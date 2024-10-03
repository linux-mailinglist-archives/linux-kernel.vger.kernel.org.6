Return-Path: <linux-kernel+bounces-348850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2A98EC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51143284DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56101487D5;
	Thu,  3 Oct 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXGMB5SO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6F823C3;
	Thu,  3 Oct 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949363; cv=none; b=Egx+IcXfGz7nkwz0tbHUFilu0tpeZiKw8sqivvlGxebZqshiwJooHVEZi9ZOtbpp4D0uZULFADt53nNLBgkWT8jIOWgipqVXzapkac0otEsnrtj3aJOajd0HQqYgzrHhUKvokMsYgod/6nZhfDbF9b6ASSHCK0q51H2GTA0XORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949363; c=relaxed/simple;
	bh=y+pE/N0M2BW56qGISsqqQTdfiVqXwv7iTvZ2UeWDVX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQtgFMGjwIQ4aU9oimNpzgQy6hK/Mgln2bjMRmqYwE0BzPYwggsrZqFY3yeEt76P8py5k9CvGUO68llTIWtJMQBmufkXTEoUgOIUiWPilN33H5TPMBQFE1GL14P67VxjjSFMdcdiKRoTn1yn1z6dwXh97jmpgWC7ax1ZD6VXvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXGMB5SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2441DC4CEC7;
	Thu,  3 Oct 2024 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727949362;
	bh=y+pE/N0M2BW56qGISsqqQTdfiVqXwv7iTvZ2UeWDVX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXGMB5SOGc9CPY32l6KiCxzk1A/7NdBo9y8yqMU33/NxreAU+C78ufBXGGlhhtHc7
	 Odj/AdqlInUyajFL0wC8vhjtPif3Z8Atz7JdKmZ/+B4YhlcvWgb6xIIuYFjiVgoUTK
	 AMW8x7m58LwsYCNDwR2wm4wFPdyAb2zujZjlvLfLQ/BBWmsXBwEhCkK/+UdUk+DfwH
	 XVX3HdbP+aJ5GnRHjFthpKNqWP/9pgStk67QvlRBfY7/BwNSROuMbKPdG68WjmxXx3
	 VGZGodSreRCi3XOHoqRPFlPJ3/lsjl9WNNLa/vg8LJPVksix05cyXlHQJpRha6cofi
	 JAfKIsE9h88mg==
Date: Thu, 3 Oct 2024 11:55:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq:
 workaround wrong interrupt-map number
Message-ID: <z5uvbyxvnyvftkfuhrljbrszqagjhb7srwfyyr3yhmt6yaduqh@jmxkzppy23mz>
References: <20241002212613.599687-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002212613.599687-1-Frank.Li@nxp.com>

On Wed, Oct 02, 2024 at 05:26:13PM -0400, Frank Li wrote:
> The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> function function to parser interrupt-map. So it doesn't consider

Double 'function'.

> '#address-size' in parent interrupt controller, such as GIC.
> 
> When dt-binding verify interrupt-map, item data matrix is spitted at
> incorrect position. So cause below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
> interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
> is too short
> 
> Reduce minItems to workaround this warning.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/interrupt-controller/fsl,ls-extirq.yaml     | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> index 199b34fdbefc4..b52abfd3e19d4 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> @@ -85,10 +85,17 @@ allOf:
>                - fsl,ls1088a-extirq
>                - fsl,ls2080a-extirq
>                - fsl,lx2160a-extirq
> +# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> +# function function to parser interrupt-map. So it doesn't consider
> +# '#address-size' in parent interrupt controller, such as GIC.
> +#
> +# When  dt-binding verify interrupt-map, item data matrix is spitted at
> +# incorrect position. Reduce minItems to workaround this problem.
> +
>      then:
>        properties:
>          interrupt-map:
> -          minItems: 12
> +          minItems: 8

This should be restricted to compatibles in that driver, not to all. I
assume that driver won't be corrected here because it would break the
ABI, thus probably maxItems should be 8 as well.

Best regards,
Krzysztof


