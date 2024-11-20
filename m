Return-Path: <linux-kernel+bounces-415387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03719D3558
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713EBB23CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08F16DC36;
	Wed, 20 Nov 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXUEDCpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80921B7F4;
	Wed, 20 Nov 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091231; cv=none; b=cQzUJnCVRAsAO+6EUZn8VukRc+BRwEpxdUByFbT1irgeucNDWV2OcjbJZslPr5LQGPLAQ2ivyLPaQ6Lo0/7Nvt3huNHoIoS2np/SHOO5SBU78Idx3JJXNiqFsdiy48vg/59JC5juHBZNvULkEeeK0bWaG0F+gXpvKqtrAPTSJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091231; c=relaxed/simple;
	bh=tEs7YJheOg0akvlILu5xk9FyaMQ6VUNo0eHv9oq3w4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT1cn+uvIm2LH57g7BAjF7j7XYQeydxlMTKvLlChOdiYHP1jLwZn1vb38gRvfl9CpHgSBr05UeyBmRTGkF+yi3ei/9jutB2LQb93G1iaiUZ4LIBbzEyhSYADt22ycU5X6jLzI1p5WTKrVRsdp68RqZl1u5pseE/a4bYRPUe/TF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXUEDCpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A8CC4CECD;
	Wed, 20 Nov 2024 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091231;
	bh=tEs7YJheOg0akvlILu5xk9FyaMQ6VUNo0eHv9oq3w4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXUEDCpmmpMU+pYHL5B2xnvX8L+ZLDO78IR5GrI80GSCqnU0A7IAIyd8GLm58asmY
	 b9kjn2BxnvYtCv4oKmU4ySEQFHrDSZ04K633yrqh7O6y40D0Av8GlM8OwFGrKAw+ZP
	 cSivLMggDdz2C6DvQLriGKk3dAdUQYnEY8d2XvYAhugJHB3KyDYCHH5QF0DScC2ZF6
	 8Ar5KEJ4ZD8VhFq1RoSN/VnBUY+/bVvv2nOmPT1vRCP4Og0sjj+Zt1WxC1xnsjsc6X
	 bp33MQusXdO7wlDnNSN4J3B88wdCrgTcJQjBQAgPghOlGlvU4fHqSDizT9kcLMvWjB
	 DdAoYIcyVpuOQ==
Date: Wed, 20 Nov 2024 09:27:08 +0100
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
Subject: Re: [PATCH v2 03/21] dt-bindings: gpu: img: Power domain details
Message-ID: <756y5ahz6oko32uqymdc4umdzl747gi6gpei6cjdotix5mkofp@q6cxo2ldt5dh>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
 <20241118-sets-bxs-4-64-patch-v1-v2-3-3fd45d9fb0cf@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-3-3fd45d9fb0cf@imgtec.com>

On Mon, Nov 18, 2024 at 01:01:55PM +0000, Matt Coster wrote:
> The single existing GPU (AXE-1-16M) only requires a single power domain.
> Subsequent patches will add support for BXS-4-64 MC1, which has two power
> domains. Add infrastructure now to allow for this.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v2:
> - Simplified power-domains constraints P3
> - Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-3-4ed30e865892@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 3b5a5b966585ac29ad104c7aef19881eca73ce80..c629f54c86c441b4cc9e57925f1d65129cbe285b 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -43,8 +43,15 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  power-domains:
> -    maxItems: 1
> +  power-domains: true

NAK for the same reasons.

> +
> +  power-domain-names:
> +    oneOf:
> +      - items:
> +          - const: a
> +      - items:
> +          - const: a
> +          - const: b

No, list items and use minItems.

But what's more: there is no user of it. Sorry, that's a no go. You
probably organized patches incorrectly, but this on its own is just
incorrect.


>  
>  required:
>    - compatible
> @@ -52,10 +59,23 @@ required:
>    - clocks
>    - clock-names
>    - interrupts
> +  - power-domains
> +  - power-domain-names

That's an ABI break. Explain in commit msg why and its impact on users.

>  
>  additionalProperties: false
>  
>  allOf:
> +  # Cores with a single power domain
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:

No, drop.

Best regards,
Krzysztof


