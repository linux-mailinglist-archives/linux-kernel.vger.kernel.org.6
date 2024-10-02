Return-Path: <linux-kernel+bounces-348375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7998E6CE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668FF28317C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6B19E99B;
	Wed,  2 Oct 2024 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuMLcGGl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1716419;
	Wed,  2 Oct 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911683; cv=none; b=uyYtDr5uDKWbOj7FuCUK6dFNKCQbLecDjroqur9aA6HEIEokQxsoQW2vP6uohH80AEqDOifZeQdUejhK3IGIRHYk5E2CD4fX/umUpg7lAfmdzZ7+LZjoxm4v0p2PueeHPx02bxNJPVFKYOTwdxedLtZoH9RKewdLUDyL1jEj52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911683; c=relaxed/simple;
	bh=MDFYbH0l8/JCnv5G74aFoLHuvJehI0qeBVHtHdp/RPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clbTU9QDCXXHYqBCh4MInGZewehwNUIAkMhjEAtWGYS4RsCa9uG52mYNraJhf5/cjsGJ9X0SLAUiHIxcxLEZTJJ2xwuC30FM12Dl4QgTCGD+LQ+hu0dsYWTgsAk15vJlsvmqhTP3jCN6MLhdwMkSbELXtc5tvYdexSwXGLhOalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuMLcGGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777BEC4CEC2;
	Wed,  2 Oct 2024 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727911682;
	bh=MDFYbH0l8/JCnv5G74aFoLHuvJehI0qeBVHtHdp/RPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuMLcGGlluvdM+NJ6u03ob2mi6xCrpH2bRbb8Gft53xQlnGVsNEdk7dxarRzPTvaL
	 pbgZXAsaVnQImpjYs0hznEuzVGADOFHm0vp+2oD13hhRm5STrYmf4u6V6MUcJXM2Pt
	 BBoZ6x4m37cXHbizX6+ZFBf88Olfy1BOlCny8lQyoDiQHTykZBqvFZSQrdNyH0bWcP
	 waKKne/VLvp+r8wQl/WVnX4lobOUnfN+ICfxlOk65sU1YOAyoc7PHvWQYHtywYU7nT
	 TygWiGMFEIifWBtwuqc8V0EfZ/3aLaFSWQ4ut/Evj69a2ho06RFvyhm+Gcr1+R35w/
	 hn6sMDZw+iYFA==
Date: Wed, 2 Oct 2024 18:28:01 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 04/11] dt-bindings: soc: microchip: document the two
 simple-mfd syscons on PolarFire SoC
Message-ID: <20241002232801.GA1520357-robh@kernel.org>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-unvaried-clever-374b4d763849@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-unvaried-clever-374b4d763849@spud>

On Wed, Oct 02, 2024 at 11:48:02AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> There are two syscons on PolarFire SoC that provide various functionality of
> use to the OS.
> 
> The first of these is the "control-scb" region, that contains the "tvs"
> temperature and voltage sensors and the control/status registers for the
> system controller's mailbox. The mailbox has a dedicated node, so
> there's no need for a child node describing it, looking the syscon up by
> compatible is sufficient.
> 
> The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
> interrupt controller and more. At this point, only the reset controller
> child is described as that's all that is described by the existing
> bindings. The clock controller already has a dedicated node, and will
> retain it as there are other clock regions, so like the mailbox,
> a compatible-based lookup of the syscon is sufficient to keep the clock
> driver working as before so no child is needed. There's also an
> interrupt multiplexing service provided by this syscon, for which there
> is work in progress at [1].
> 
> Link: https://lore.kernel.org/linux-gpio/20240723-uncouple-enforcer-7c48e4a4fefe@wendy/ [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../microchip/microchip,mpfs-control-scb.yaml | 44 +++++++++++++++
>  .../microchip,mpfs-mss-top-sysreg.yaml        | 54 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
> new file mode 100644
> index 0000000000000..4f9168320243c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-control-scb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PolarFire SoC System Controller Bus (SCB) Control Register region
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description:
> +  An assortment of system controller related registers, including voltage and
> +  temperature sensors and the status/control registers for the system
> +  controller's mailbox.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,mpfs-control-scb
> +      - const: syscon
> +      - const: simple-mfd

Where's the child nodes?

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;

Don't need the soc node.

> +
> +      syscon@37020000 {
> +        compatible = "microchip,mpfs-control-scb", "syscon", "simple-mfd";
> +        reg = <0x37020000 0x100>;
> +      };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
> new file mode 100644
> index 0000000000000..98ccec3caad51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg Register region
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description:
> +  An wide assortment of registers that control elements of the MSS on PolarFire
> +  SoC, including pinmuxing, resets and clocks among others.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,mpfs-mss-top-sysreg
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    description: |

Don't need '|'.

> +      The AHB/AXI peripherals on the PolarFire SoC have reset support, so
> +      from CLK_ENVM to CLK_CFM. The reset consumer should specify the
> +      desired peripheral via the clock ID in its "resets" phandle cell.
> +      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list
> +      of PolarFire clock/reset IDs.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      syscon@20002000 {
> +        compatible = "microchip,mpfs-mss-top-sysreg", "syscon", "simple-mfd";
> +        reg = <0x20002000 0x1000>;
> +        #reset-cells = <1>;
> +      };
> +    };
> +
> -- 
> 2.45.2
> 

