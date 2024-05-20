Return-Path: <linux-kernel+bounces-184194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3CB8CA3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820FC1C2108F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BBC139566;
	Mon, 20 May 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWOl8kw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770C134DE;
	Mon, 20 May 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716240027; cv=none; b=KbIF8PmhFrPDe3424+1yFmCy26QTmGUgT9/yIO9QmK5Zwj1FxfL8bwqD9CGr9bPXMHga4ViMyM6geLbk02g3x3/HOeqT3BOIPEqRDwQkhkfL4u0/45978DEkN6AuJ0WPg+YBgmVUO6jcVHerjrS7uUfgWdP0KgFRh/L4X2tWQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716240027; c=relaxed/simple;
	bh=6q4cLeteQnmYBt4L+ImO6U2iWiRK+PBZwIQS3r+LLZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq0zLDL50X+pzlkHx0vyQ5bfp6CU0AChsnP/mZPrVAeCLmmVAekzBszSPxf1qaBllmpHTaH98NIjrqovpv56nziVaczb8jEMrb/1/P9Xu/tz3JHxUQO2RyRVdtvF919j8grX6GfxArwIs7bYGCMvbuVgsZu8kKJbkD9Cs3d+m0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWOl8kw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8139FC2BD10;
	Mon, 20 May 2024 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716240026;
	bh=6q4cLeteQnmYBt4L+ImO6U2iWiRK+PBZwIQS3r+LLZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWOl8kw56ZVeviGOGsr0lbv+k+xZE2NAALVSx796jSXun/d+7j1KNYBiJ+vUA1OEf
	 ZQGpZdpKHadB1Mg2GFYGx+uiBNU7m04hMWVL802Lt3e4JD7G1z7jCXDmxGBreOgtt7
	 qclg7Peh7mOecKxMJyocc/JQaBGChHHBtgRDgeckbKkOPo4xn326QKtKjzKVgyx3Ci
	 v5ll50neonGDnT6+EMyhLewvzL3eXZN7Px0WLszK7SlbA0B9WllUQuugAmRj6XTiw8
	 X1hyjcj3pydyv68yzY6IUTSquK+17pYqWXlDvEyLL+Obo4SIq7BXvl3WZ5v1u2wHoO
	 yWYMjK9x4PfKg==
Date: Mon, 20 May 2024 16:20:25 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/8] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Message-ID: <20240520212025.GA1531862-robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-6-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-6-aaf996e2313a@linaro.org>

On Sun, May 19, 2024 at 08:42:21PM +0200, Krzysztof Kozlowski wrote:
> Simple syscon nodes can be documented in common syscon.yaml, however
> devices with simple-mfd compatible, thus with some children, should have
> their own schema listing these children.  Such listing makes the binding
> specific, allows better validation (so the incorrect child would not
> appear in the simple-mfd node) and actually enforces repeated rule for
> simple-mfd devices:
> 
>   "simple-mfd" is only for simple devices, where the children do not
>   depend on the parent.
> 
> Currently the syscon+simple-mfd binding is quite broad and allows
> any child or property, thus above rule cannot be enforced.
> 
> Split the syscon.yaml binding into:
> 1. Common syscon properties, used potentially by many bindings.
> 2. Simple syscon devices (NO simple-mfd!).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on:
> 1. https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
> 2. Previous patches in the series.
> ---
>  .../devicetree/bindings/mfd/syscon-common.yaml     |  72 +++++++
>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 212 +++++++++------------
>  2 files changed, 162 insertions(+), 122 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
> new file mode 100644
> index 000000000000..c3ff3a7afce3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: System Controller Registers R/W Common Properties
> +
> +description: |
> +  System controller node represents a register region containing a set
> +  of miscellaneous registers. The registers are not cohesive enough to
> +  represent as any specific type of device. The typical use-case is
> +  for some other node's driver, or platform-specific code, to acquire
> +  a reference to the syscon node (e.g. by phandle, node path, or
> +  search using a specific compatible value), interrogate the node (or
> +  associated OS driver) to determine the location of the registers,
> +  and access the registers directly.
> +
> +maintainers:
> +  - Lee Jones <lee@kernel.org>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - syscon
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: syscon
> +    minItems: 2
> +    maxItems: 5  # Should be enough
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-io-width:
> +    description: |
> +      The size (in bytes) of the IO accesses that should be performed
> +      on the device.
> +    enum: [1, 2, 4, 8]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: simple-mfd
> +    then:
> +      properties:
> +        compatible:
> +          minItems: 3
> +          maxItems: 5
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    syscon: syscon@1c00000 {
> +        compatible = "allwinner,sun8i-h3-system-controller", "syscon";
> +        reg = <0x01c00000 0x1000>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index b17fa0487178..70e3961bc96f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: System Controller Registers R/W
> +title: System Controller Devices
>  
>  description: |
>    System controller node represents a register region containing a set
> @@ -19,122 +19,99 @@ description: |
>  maintainers:
>    - Lee Jones <lee@kernel.org>
>  
> -select:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - syscon
> -
> -  required:
> -    - compatible
> -

Removing this is only going to work with v2024.04. The only way it 
works for older versions is listing all the compatibles here. That's a 
bit new for us to require it.

Rob

