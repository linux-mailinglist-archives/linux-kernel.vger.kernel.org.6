Return-Path: <linux-kernel+bounces-349927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617D98FD72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD32028342D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596631311A7;
	Fri,  4 Oct 2024 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQs1W6vB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290912D758;
	Fri,  4 Oct 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024207; cv=none; b=AIZnz5I8qMuELIty5ywAtpAIRv85vyHbd2rucsnY5WBEW67QYTgHPI//YPaOx5GU/W3XIP+cUt+FlzEMZUXVh91AY9gAS+3mu1tSmyGw52HlL3AMPidEwguO22DWUZYb/6ePabgprF4g/5JMHf0KDOoCct/zYQ37WE4jaK/e7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024207; c=relaxed/simple;
	bh=yj1cVDpC+pHE9UFWN5sSN/8jUO5Z0hUC1u0IFF/l9iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGnb+sjwvx6L/13vHoLE/1Kmd1Dv3fb0HeC5P0fBQPBMi0QY+RbpnlLZQ7L3hAoLfgP4xwgcOQHqj7em3UPQd8B+uJ7Uv/uXNH2UkC3E0MTujHBOiAz4Ob/oFKve3731PGZOWE1GpOgpogh9Xj1s4jA6t6Xz5owhY8hz/llemKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQs1W6vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E952C4CEC6;
	Fri,  4 Oct 2024 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728024207;
	bh=yj1cVDpC+pHE9UFWN5sSN/8jUO5Z0hUC1u0IFF/l9iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQs1W6vBxMk9U8zxcs8SLDjiBadl4jg/gfAsSVBGZRA6caLKOLw+SBzKvff0do4/s
	 Vdp4P8cxN8hqpcoUC80u2FPhxEEjUhV5t7vpX71KIRuUTCsyqgWCIqhcrWX8Cbi/Gr
	 VUDTuSgIFp0Q1W2zHwfWKY+Z5bHT1huv3QD1Z8LrgbEbgMC6MESZH/08O826RltDpi
	 RiXqsNxe+lz8yuHhkReAJ74HZGUxyfPzuIyhAg8cUJJYkK7fnByalsVNBybDHjlXSN
	 lx0yIUtvksVexr2tXYJTZnIcDGBVQiKHwLociqFyBmsmylBsM0s3nSqP279mCWKXrF
	 3RxdMOLv+u/Sg==
Date: Fri, 4 Oct 2024 08:43:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq:
 workaround wrong interrupt-map number
Message-ID: <gre52gkd325yfnjwoqyfot4yrb3rim4pi2ye3hjcp4bd7yimba@tq2drzuwlc6f>
References: <20241003214315.638668-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003214315.638668-1-Frank.Li@nxp.com>

On Thu, Oct 03, 2024 at 05:43:15PM -0400, Frank Li wrote:
> The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> function to parser interrupt-map. So it doesn't consider '#address-size'
> in parent interrupt controller, such as GIC.
> 
> When dt-binding verify interrupt-map, item data matrix is spitted at
> incorrect position. So cause below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
> interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
> is too short
> 
> Reduce minItems and maxItems to workaround this warning for
> 'fsl,ls1088a-extirq', 'fsl,ls2080a-extirq' and fsl,lx2160a-extirq.
> Other keep the same restriction.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - remove duplicate function in commit message
> - only reduce miniItems for after 1088a chips
> - maxItems change to 9. Otherwise report too long.
> ---
>  .../interrupt-controller/fsl,ls-extirq.yaml   | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> index 199b34fdbefc4..1bfced6ed620c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> @@ -82,14 +82,37 @@ allOf:
>              enum:
>                - fsl,ls1043a-extirq
>                - fsl,ls1046a-extirq
> +    then:
> +      properties:
> +        interrupt-map:
> +          minItems: 12
> +          maxItems: 12
> +        interrupt-map-mask:
> +          items:
> +            - const: 0xf
> +            - const: 0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
>                - fsl,ls1088a-extirq
>                - fsl,ls2080a-extirq
>                - fsl,lx2160a-extirq
> +# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> +# function function to parser interrupt-map. So it doesn't consider

Same issue as last time, double function.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


> +# '#address-size' in parent interrupt controller, such as GIC.
> +#
> +# When dt-binding verify interrupt-map, item data matrix is spitted at
> +# incorrect position. Reduce minItems and maxItems to workaround this
> +# problem.
> +
>      then:
>        properties:
>          interrupt-map:
> -          minItems: 12
> -          maxItems: 12
> +          minItems: 8
> +          maxItems: 9

Are you sure it works? I see 12 items in fsl-ls1088a.dtsi.

What's more, I do not see your errors/warnings at all.

Best regards,
Krzysztof


