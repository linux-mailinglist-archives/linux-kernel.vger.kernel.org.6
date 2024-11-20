Return-Path: <linux-kernel+bounces-415385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3FB9D3552
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2411F21CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C116DC3C;
	Wed, 20 Nov 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyJET/A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164341B7F4;
	Wed, 20 Nov 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091152; cv=none; b=D2yIVpCfvh4xPQ5NvqIEdRKtHo1/OkI5s9N+5zj8zfRZF/yNDfNrTm3lpw3u6azZEJJJPKZUDdV5wtziG42QAbYwo46FzW0GY0icGqBYREIwsp9/BmpUYI/w3AfyAunAln0arVF9eO+Qw71nlaD7XiYvtR1z/Daem/vBkErvqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091152; c=relaxed/simple;
	bh=4g2jYdwDFVMXNP1wEEU61wC8oYt/WiBu8Ec1k44MiQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDzeWa1iGh+2acDRwmwJupBZZAV1feVal3cnhgpAEaoFfaoTLhvIBrifhnAE3hq8IXdXZrFbryVR+UleR3cZ4jr2vCMxYGYqOEIDPUP6nxWpesaLLF8qZX5EYUn/nyUQoV0Wblgi6p/ypg3UwOTjd4QMFc3GZsk0HMdZHeeAvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyJET/A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC96C4CECD;
	Wed, 20 Nov 2024 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091151;
	bh=4g2jYdwDFVMXNP1wEEU61wC8oYt/WiBu8Ec1k44MiQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyJET/A3qqX0Ig94Sej1L4KJxIx6MBcWHlXRQzQ/QC00uTg7Kz4e2SDgschEiztX0
	 qsUmBlXJgyP1HWfE5y3sBYXn7BLtUZmFgjTwp478T8s7UmWHccCQdcfWhfKZ0qynWY
	 is/JtZQYF6sjGdLFNYMgISflbcs25A5q0FM20rGE40Re7yvRaXAsBCZsmVfagB/Rgf
	 MbRW5knUVzpY48jn9zCps6xlShXCK39P3iO/lt/0gz7N+qyleFmaQMzbwUku+d30uv
	 C/lJ15TzHlVWDyRk6ZXsN8+yecETDan/501CADHfXMPF4B67ifFQp2p4nxJXeCcC8q
	 5JWC9UMtALyVA==
Date: Wed, 20 Nov 2024 09:25:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v2 02/21] dt-bindings: gpu: img: Further constrain clocks
Message-ID: <rdo2aye6lzlxtwxashbftwytyfa54gea2jmv3ww3hxuokdj3rk@pza4lgqlfa6l>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
 <20241118-sets-bxs-4-64-patch-v1-v2-2-3fd45d9fb0cf@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-2-3fd45d9fb0cf@imgtec.com>

On Mon, Nov 18, 2024 at 01:01:54PM +0000, Matt Coster wrote:
> All Imagination GPUs use three clocks: core, mem and sys. All reasonably
> modern Imagination GPUs also support a single-clock mode where the SoC
> only hooks up core and the other two are derived internally. On GPUs which
> support this mode, it is the default and most commonly used integration.
> 
> Codify this "1 or 3" constraint in our bindings and hang the specifics off
> the vendor compatible string to mirror the integration-time choice.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v2:
> - Simplified clocks constraints (P2)
> - Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml   | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index ef7070daf213277d0190fe319e202fdc597337d4..3b5a5b966585ac29ad104c7aef19881eca73ce80 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -29,16 +29,16 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  clocks:
> -    minItems: 1
> -    maxItems: 3
> +  clocks: true

NAK. Widest constraints always stay here.

>  
>    clock-names:
> -    items:
> -      - const: core
> -      - const: mem
> -      - const: sys
> -    minItems: 1
> +    oneOf:
> +      - items:
> +          - const: core
> +      - items:
> +          - const: core
> +          - const: mem
> +          - const: sys

Why? Sorry, this is just wrong. This deviec has specific, one clock.

Anyway, this needs to use old syntax. You change here nothing.

NAK

>  
>    interrupts:
>      maxItems: 1
> @@ -56,11 +56,13 @@ required:
>  additionalProperties: false
>  
>  allOf:
> +  # Vendor integrations using a single clock domain
>    - if:
>        properties:
>          compatible:
>            contains:
> -            const: ti,am62-gpu
> +            anyOf:

Nope. That's not needed, not explained.

Best regards,
Krzysztof


