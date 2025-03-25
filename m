Return-Path: <linux-kernel+bounces-574698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA83A6E8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4113D3AF077
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476019F130;
	Tue, 25 Mar 2025 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp31jYZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E41FDD;
	Tue, 25 Mar 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872985; cv=none; b=ZxxFK1HgY/B6vxHfPbWnm6wVNHTZ9s0Nh/pmOf9hMYGQ51t1OyuI/7KaV/gjm2ovf8/P3IeaA68nLkdgpRIRCWAKAK5bWgU28qhDR0qxUBvEb4t+N9N/B9+brolz1RqjJI6w0zlFCPdumBT4qeYBlpEy78fKQ7kE+egllPyautQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872985; c=relaxed/simple;
	bh=WwL66kYR3F+uZq5uOtCGWp7idJWWj5WsdtRUs00zJag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF+kDExOhI99I1fLxXuqITtJI1J9D6r/q6BYv9CPqBFxrJ/5y5AJywRPOH422mfejG4WfXuZSo513iAR3mnKbjeuGv3nT282dV3ZW3A2IIibdS0yYi60kx5mRu3uxFjenwifxdhM1j6vtiOeW1bo+nLDsQqNyKEeJAZL37lH5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp31jYZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EB0C4CEE8;
	Tue, 25 Mar 2025 03:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872984;
	bh=WwL66kYR3F+uZq5uOtCGWp7idJWWj5WsdtRUs00zJag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mp31jYZVn5eyKEAP1PFsxKTyo9qX0SB0WIaembvnyhdKhV6dlbHKQUq7CdKOuKAF5
	 OA1uEQWeXxEPpdqjEZwn4uOsa0N6FXwZCH/mx13Fm73rqKwL3l99oEKbodKBePIHOR
	 RHjXi5WjD0rx27um5V9XSlWwqhgr2dZU6bH1fVyieY1MLfUEUSHIl6BRkRYdClRwsy
	 gqilazXbehsm0kEYP1PXJljuQ54G9RO0zMahFRfSrhO/+dTMJPAzu7GmTd9kkNsIeG
	 yoQETUSdk5lYoNG79VWeo94aBzxiRae7IIQpt0sF3tQSnXfdfKl6hjtIUnb4LQap4Z
	 jsXbzf9KM29Xg==
Date: Mon, 24 Mar 2025 22:23:03 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: bus: add documentation for the IMX
 AIPSTZ bridge
Message-ID: <20250325032303.GA1624882-robh@kernel.org>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
 <20250324162556.30972-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324162556.30972-2-laurentiumihalcea111@gmail.com>

On Mon, Mar 24, 2025 at 12:25:52PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add documentation for IMX AIPSTZ bridge.
> 
> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> new file mode 100644
> index 000000000000..c0427dfcdaca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,imx8mp-aipstz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Secure AHB to IP Slave bus (AIPSTZ) bridge
> +
> +description:
> +  The secure AIPS bridge (AIPSTZ) acts as a bridge for AHB masters
> +  issuing transactions to IP Slave peripherals. Additionally, this module
> +  offers access control configurations meant to restrict which peripherals
> +  a master can access.

Wrap at 80 chars.

> +
> +maintainers:
> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8mp-aipstz
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: bus
> +      - const: ac
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  "#access-controller-cells":
> +    const: 0

With 0 cells, how do you identify which device it is?

> +
> +  ranges: true
> +
> +# borrowed from simple-bus.yaml, no additional requirements for children
> +patternProperties:
> +  "@(0|[1-9a-f][0-9a-f]*)$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      reg:
> +        items:
> +          minItems: 2
> +          maxItems: 4
> +        minItems: 1
> +        maxItems: 1024
> +      ranges:
> +        oneOf:
> +          - items:
> +              minItems: 3
> +              maxItems: 7
> +            minItems: 1
> +            maxItems: 1024
> +          - $ref: /schemas/types.yaml#/definitions/flag
> +    anyOf:
> +      - required:
> +          - reg
> +      - required:
> +          - ranges
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - power-domains
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#access-controller-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus@30c00000 {
> +        compatible = "fsl,imx8mp-aipstz";
> +        reg = <0x30c00000 0x400000>, <0x30df0000 0x10000>;

It doesn't look like you have any registers in the 1st entry, but they 
are child devices? Then you should use ranges and drop it here:

ranges = <0x0 0x30c00000 0x400000>;


> +        reg-names = "bus", "ac";
> +        power-domains = <&pgc_audio>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        #access-controller-cells = <0>;
> +        ranges;
> +
> +        dma-controller@30e00000 {
> +            compatible = "fsl,imx8mp-sdma", "fsl,imx8mq-sdma";
> +            reg = <0x30e00000 0x10000>;
> +            #dma-cells = <3>;
> +            clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT>,
> +                     <&clk IMX8MP_CLK_AUDIO_ROOT>;
> +            clock-names = "ipg", "ahb";
> +            interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +            fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";

No 'access-controllers' here?

> +        };
> +    };
> -- 
> 2.34.1
> 

