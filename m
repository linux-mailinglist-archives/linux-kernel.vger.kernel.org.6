Return-Path: <linux-kernel+bounces-415392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480829D3568
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB5C283D66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF58170A15;
	Wed, 20 Nov 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObZu/x8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C0156F20;
	Wed, 20 Nov 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091338; cv=none; b=J1gXhaQjOO/zU7Tb3tBjOxFJSzn4Unh9YygFv4f063sPNQhZR+KQ5ER6R8JO98UJhquFUlcoVWUCEM8f40w9T8XBPsh01xDL5unfZbJdYtSp4tdkvGBbFLY+pjXbcDjzk/p16aMkiRZDMI9tzQJJ8FUZ9jXnyLObCf8P18pjxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091338; c=relaxed/simple;
	bh=r5LJKMh22+WU9zlQmk8oS8zbTaFxi6bJT9D41aUjabE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obc+1jRHkJh1T04pJpcpeIkNuId9VKTFcJ3QUSDdb887HXMHp5djcqqWFyEU2oEJhiRu6DC0/tqYso90i60NIzP+8w6IKjC+5PinhEBifUh4j7pMYMfFPPj51dmffzEds1g5DLak5uIXV71CVvNkzYu78yuETHr9I1kDTjYWRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObZu/x8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35851C4CECD;
	Wed, 20 Nov 2024 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091338;
	bh=r5LJKMh22+WU9zlQmk8oS8zbTaFxi6bJT9D41aUjabE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObZu/x8cTiiCQ4uqMKDf8ML2Grv1dygO0z0nUV6xGSv4CMHxYvsSXb+2EFsBETV+G
	 FaGn6ZOeJrnlqxCzNBCUHWS8cOIGbHBM8fL6I0sMPB7eUbNft3TOnAxkY3fxFSupAw
	 J+ivIPke741EE6xaoP6O9r8F3kUjiGamyl73MLjbd3+Sskmy9hs2l89lT83t+xVPz3
	 8B86Wg3oI6XSPJl0I8/lfOjJmvY0xXU9DdK/UzvH75IzeDwBplqzw7Gz/89+5v+3p0
	 RKbD7dN8nSBukFimzgS/D0m8fVMucJQBKlu+9lbhfFak6N9t74tporu/FT5z2DYMh7
	 1ZGOGoq3ikZfQ==
Date: Wed, 20 Nov 2024 09:28:54 +0100
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
Subject: Re: [PATCH v2 08/21] dt-bindings: gpu: img: Add BXS-4-64 devicetree
 bindings
Message-ID: <jgabneyvumignjvgy3l7bmjccyxradhl4fguocrynymn5ii7uh@zpdvdsizpm3c>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
 <20241118-sets-bxs-4-64-patch-v1-v2-8-3fd45d9fb0cf@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-8-3fd45d9fb0cf@imgtec.com>

On Mon, Nov 18, 2024 at 01:02:00PM +0000, Matt Coster wrote:
> Like the existing AXE-1-16M integration, BXS-4-64 uses the single clock
> integration in the TI k3-j721s2.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v2:
> - Use normal reg syntax for 64-bit values
> - Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-8-4ed30e865892@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 9dc55a6d0d4023983a3fc480340351f3fa974ce5..b620baa56a4caa41246f7b53064d0e3309bdda8e 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -18,6 +18,11 @@ properties:
>                - ti,am62-gpu
>            - const: img,img-axe-1-16m
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - ti,j721s2-gpu
> +          - const: img,img-bxs-4-64
> +          - const: img,img-rogue
>  
>        # This legacy combination of compatible strings was introduced early on before the more
>        # specific GPU identifiers were used. Keep it around here for compatibility, but never use
> @@ -78,6 +83,18 @@ allOf:
>        properties:
>          power-domains:
>            maxItems: 1
> +  # Cores with two power domains
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:

Nope

> +              - const: img,img-bxs-4-64
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 2
> +          maxItems: 2

You need to constrain power-domain-names. Same for other variants.


>    # Vendor integrations using a single clock domain
>    - if:
>        properties:
> @@ -85,6 +102,7 @@ allOf:
>            contains:
>              anyOf:
>                - const: ti,am62-gpu
> +              - const: ti,j721s2-gpu
>      then:
>        properties:
>          clocks:
> @@ -105,3 +123,26 @@ examples:
>          power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
>          power-domain-names = "a";
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>

Drop. No difference in this example.

Best regards,
Krzysztof


