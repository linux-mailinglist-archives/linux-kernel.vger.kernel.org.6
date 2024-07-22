Return-Path: <linux-kernel+bounces-259466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8E9396A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8EC1F21FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A14438B;
	Mon, 22 Jul 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFICJtNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EBD512;
	Mon, 22 Jul 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721687904; cv=none; b=FXNUFxSQxTlqoLUMxNV4bG0nJ92AoKjEWSWNOWpCoGmPhgZ+YFI7dM/P8Mx+iixzm62UaPKAwA8ot4mk2a5hwa2Zv6IEawUH/IaqU/zP3FE/1vfyYJC6nKSSzO5HwQ35lOLuj8qF/Ou9jhn7Ou+XNuHQ+iojOiqKPiedd5PfxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721687904; c=relaxed/simple;
	bh=M/zsupZtOVoOtw7sD2RiHJfeIhVHyAa2UsCMK9eHAX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Th7ONvhRQ+Zrnqz/63DWzQ4p7rPi3KyAdgdIT75FG729EyCJJCX2lbksIV1U9AiqbAE+qjJM1Tjl4QPJ4aNLn4uPJyqz0NETMr8zUqPiwzE0jHifxKTHUyAFwm982tObbc4ovJ+u1MqS5zdmVx+3qw793rQ3Mntf3LkhVbsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFICJtNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA16C116B1;
	Mon, 22 Jul 2024 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721687903;
	bh=M/zsupZtOVoOtw7sD2RiHJfeIhVHyAa2UsCMK9eHAX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFICJtNi1fLEb0f+8fdbIXpBUEKT1ABXvzBrCXDomr7V3Ed31KCf0VGDPJVBxeJ2s
	 PnKhXh8WD7ZQ9W8Rlz7UCWM6covqugGrB/2xqkBdFF2BmONHYb1mIvCj2bxnqHZUMM
	 2NQA+fc9nS9RK2hbSDkVulOQD0NxNfic2Ybr9V1CmIcceRisMmcbJNuQoMEIGe+E2T
	 b3f59Tl6hxFj/s0r+wcqbpsI2r4ZyWn8+g/iff1BYtzVIJuxkT/Cf+mBezAdi0s9SO
	 nnO1LvVqdAYKx9h7HYKmZy+mUg5FQSf7fOIQch7kIdWtuFLYsH5BynSAXZkRVTmniL
	 9+5JMECBNeKTg==
Date: Mon, 22 Jul 2024 16:38:14 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
	francesco@dolcini.it, frank.li@nxp.com
Subject: Re: [PATCH v2 01/16] dt-bindings: display: imx: Add some i.MX8qxp
 Display Controller processing units
Message-ID: <20240722223814.GA183822-robh@kernel.org>
References: <20240712093243.2108456-1-victor.liu@nxp.com>
 <20240712093243.2108456-2-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712093243.2108456-2-victor.liu@nxp.com>

On Fri, Jul 12, 2024 at 05:32:28PM +0800, Liu Ying wrote:
> Freescale i.MX8qxp Display Controller is implemented as construction set of
> building blocks with unified concept and standardized interfaces.
> 
> Document some processing units to support two display outputs.
> 
> ConstFrame, ExtDst, FetchLayer, FetchWarp and LayerBlend processing units
> are in pixel engine.  FrameGen and TCon processing units are in display
> engine.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2:
> * Drop fsl,dc-*-id DT properties. (Krzysztof)
> * Add port property to fsl,imx8qxp-dc-tcon.yaml. (Krzysztof)
> * Fix register range sizes in examples.
> 
>  .../imx/fsl,imx8qxp-dc-constframe.yaml        |  44 ++++++
>  .../display/imx/fsl,imx8qxp-dc-extdst.yaml    |  72 ++++++++++
>  .../imx/fsl,imx8qxp-dc-fetchlayer.yaml        |  30 +++++
>  .../imx/fsl,imx8qxp-dc-fetchunit-common.yaml  | 125 ++++++++++++++++++
>  .../display/imx/fsl,imx8qxp-dc-fetchwarp.yaml |  30 +++++
>  .../display/imx/fsl,imx8qxp-dc-framegen.yaml  |  64 +++++++++
>  .../imx/fsl,imx8qxp-dc-layerblend.yaml        |  39 ++++++
>  .../display/imx/fsl,imx8qxp-dc-tcon.yaml      |  45 +++++++
>  8 files changed, 449 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchlayer.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchunit-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchwarp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-framegen.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-layerblend.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-tcon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
> new file mode 100644
> index 000000000000..94f678563608
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-constframe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Display Controller Constant Frame
> +
> +description: |
> +  The Constant Frame unit is used instead of a Fetch unit where generation of
> +  constant color frames only is sufficient. This is the case for the background
> +  planes of content and safety streams in a Display Controller.
> +
> +  The color can be setup to any RGBA value.
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qxp-dc-constframe
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: pec
> +      - const: cfg
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    constframe@56180960 {
> +        compatible = "fsl,imx8qxp-dc-constframe";
> +        reg = <0x56180960 0xc>, <0x56184400 0x20>;
> +        reg-names = "pec", "cfg";
> +    };
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
> new file mode 100644
> index 000000000000..dfc2d4f94f8e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-extdst.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Display Controller External Destination Interface
> +
> +description: |
> +  The External Destination unit is the interface between the internal pixel
> +  processing pipeline of the Pixel Engine, which is 30-bit RGB plus 8-bit Alpha,
> +  and a Display Engine.
> +
> +  It comprises the following built-in Gamma apply function.
> +
> +  +------X-----------------------+
> +  |      |          ExtDst Unit  |
> +  |      V                       |
> +  |  +-------+                   |
> +  |  | Gamma |                   |
> +  |  +-------+                   |
> +  |      |                       |
> +  |      V                       +
> +  +------X-----------------------+
> +
> +  The output format is 24-bit RGB plus 1-bit Alpha. Conversion from 10 to 8
> +  bits is done by LSBit truncation.  Alpha output bit is 1 for input 255, 0
> +  otherwise.
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qxp-dc-extdst
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: pec
> +      - const: cfg
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: shdload
> +      - const: framecomplete
> +      - const: seqcomplete
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    extdst@56180980 {
> +        compatible = "fsl,imx8qxp-dc-extdst";
> +        reg = <0x56180980 0x1c>, <0x56184800 0x28>;
> +        reg-names = "pec", "cfg";
> +        interrupt-parent = <&dc0_intc>;
> +        interrupts = <3>, <4>, <5>;
> +        interrupt-names = "shdload", "framecomplete", "seqcomplete";
> +    };
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchlayer.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchlayer.yaml
> new file mode 100644
> index 000000000000..804a3ea7419f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchlayer.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-fetchlayer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Display Controller Fetchlayer
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +allOf:
> +  - $ref: fsl,imx8qxp-dc-fetchunit-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qxp-dc-fetchlayer

As the fetch units only differ by compatible, combine them and the 
common schema into 1 schema doc.

Rob

