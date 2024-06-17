Return-Path: <linux-kernel+bounces-217950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E146D90B6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7584C28558F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402E161924;
	Mon, 17 Jun 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBZ2NdOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100311D9526;
	Mon, 17 Jun 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642700; cv=none; b=dMbPFWXJnet51RdA1rjhRRjw4lSp7I2RYhRhy81D71O4/5UuSCkVi9g/JK6VNPWsA4FqPjbqwFhu4Y/FInJHb2LqCm3iwpK5GFE2aLn6Oq81SqNTO0AGrAA2GioiXbsap0KPwjd2utCnFM6qQfFrl/LFKzrX/y/+qXRauuv6P48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642700; c=relaxed/simple;
	bh=emQds4Az4vlgUQ3QKW8TwIc7kwvGHiLk2C7AyCRuXrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixSTJbmDpDpVpvIoNgL4wAJ4h0bw8858ZqJkjtWueG2D6VXu0zDLz5xQ2s7tRq0UlA0UpgSW50LFlzkr8OMTaXGAf5NP3gtDv+HxmrZGsJ2t0zggJR2ieR4XmJVtH33OZ0Djy5zDygbpmAMmEF2p9pEcze8Hk/CSvcsEMHX+V2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBZ2NdOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264FC2BD10;
	Mon, 17 Jun 2024 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642699;
	bh=emQds4Az4vlgUQ3QKW8TwIc7kwvGHiLk2C7AyCRuXrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBZ2NdOpRwA8YessJ9R84Yok8kyvrymuj0txndaxbKtdcWxAUtwlnoidZ4t5fxR/I
	 ecoD/OaQnYd4iaibs2JCkXzxGzyniGRCiPO5ZXBIEBJ7BdERMtLcZiLJEnjKK3MrY9
	 jWl9bOO/mznn5RssWxGxQOq/Im+uT2ir8nrYbXF2oJqPxk4/4XHIEqgxWFLCBqV6BS
	 3UkhMgywcTzZRuq+nMetDeErvj6PlOKNHfgIWTdxyNHyRXQpGQCNwRfwDtwnDihrh8
	 QpH2U+k52JizlV+lkUdSv0HraLj08CxI841rV8FdER48qyBPqYBi4dY3QCp/vuTW7O
	 heWsGf4xZQNLA==
Date: Mon, 17 Jun 2024 17:44:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v2 6/7] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Message-ID: <20240617-zoology-silica-2c8c78363b32@spud>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-6-571b5850174a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CXG+45ywyuUtHPCF"
Content-Disposition: inline
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-6-571b5850174a@linaro.org>


--CXG+45ywyuUtHPCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 03:19:26PM +0200, Krzysztof Kozlowski wrote:
> Simple syscon nodes can be documented in common syscon.yaml, however
> devices with simple-mfd compatible, thus with some children, should have
> their own schema listing these children.  Such listing makes the binding
> specific, allows better validation (so the incorrect child would not
> appear in the simple-mfd node) and actually enforces repeated rule for
> simple-mfd devices:
>=20
>   "simple-mfd" is only for simple devices, where the children do not
>   depend on the parent.
>=20
> Currently the syscon+simple-mfd binding is quite broad and allows
> any child or property, thus above rule cannot be enforced.
>=20
> Split the syscon.yaml binding into:
> 1. Common syscon properties, used potentially by many bindings.
> 2. Simple syscon devices (NO simple-mfd!).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Depends on:
> 1. Patch in MFD: https://lore.kernel.org/all/171828959006.2643902.8308227=
314531523435.b4-ty@kernel.org/
> 2. Previous patches in the series.
> ---
>  .../devicetree/bindings/mfd/syscon-common.yaml     |  72 +++++
>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 294 +++++++++++++--=
------
>  2 files changed, 251 insertions(+), 115 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/D=
ocumentation/devicetree/bindings/mfd/syscon-common.yaml
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

This | can go, right?

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

And this can be const, given it's unlikely to grow?

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

Same with this one.

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
> +        compatible =3D "allwinner,sun8i-h3-system-controller", "syscon";
> +        reg =3D <0x01c00000 0x1000>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index d6fa58c9e4de..d4e9533cf3fe 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: System Controller Registers R/W
> +title: System Controller Devices
> =20
>  description: |
>    System controller node represents a register region containing a set
> @@ -19,123 +19,196 @@ description: |
>  maintainers:
>    - Lee Jones <lee@kernel.org>
> =20
> +# Need a select with all compatibles listed for compatibility with older
> +# dtschema (<2024.02), so this will not be selected for other schemas ha=
ving
> +# syscon fallback.
>  select:
>    properties:
>      compatible:
>        contains:
>          enum:
> -          - syscon

Wow, this is noisy. Is it not possible to achieve something similar by
making the select check for not: compatible: contains: simple-mfd? Or
did I misunderstand the intention here?

Thanks,
Conor.

> -
> +          - al,alpine-sysfabric-servic
> +          - allwinner,sun8i-a83t-system-controller
> +          - allwinner,sun8i-h3-system-controller
> +          - allwinner,sun8i-v3s-system-controller
> +          - allwinner,sun50i-a64-system-controller
> +          - altr,l3regs
> +          - altr,sdr-ctl
> +          - amd,pensando-elba-syscon
> +          - amlogic,meson-mx-assist
> +          - amlogic,meson-mx-bootrom
> +          - amlogic,meson8-analog-top
> +          - amlogic,meson8b-analog-top
> +          - amlogic,meson8-pmu
> +          - amlogic,meson8b-pmu
> +          - apm,xgene-csw
> +          - apm,xgene-efuse
> +          - apm,xgene-mcb
> +          - apm,xgene-rb
> +          - apm,xgene-scu
> +          - atmel,sama5d2-sfrbu
> +          - atmel,sama5d3-nfc-io
> +          - atmel,sama5d3-sfrbu
> +          - atmel,sama5d4-sfrbu
> +          - axis,artpec6-syscon
> +          - brcm,cru-clkset
> +          - brcm,sr-cdru
> +          - brcm,sr-mhb
> +          - cirrus,ep7209-syscon1
> +          - cirrus,ep7209-syscon2
> +          - cirrus,ep7209-syscon3
> +          - cnxt,cx92755-uc
> +          - freecom,fsg-cs2-system-controller
> +          - fsl,imx93-aonmix-ns-syscfg
> +          - fsl,imx93-wakeupmix-syscfg
> +          - fsl,ls1088a-reset
> +          - fsl,vf610-anatop
> +          - fsl,vf610-mscm-cpucfg
> +          - hisilicon,dsa-subctrl
> +          - hisilicon,hi6220-sramctrl
> +          - hisilicon,hip04-ppe
> +          - hisilicon,pcie-sas-subctrl
> +          - hisilicon,peri-subctrl
> +          - hpe,gxp-sysreg
> +          - loongson,ls1b-syscon
> +          - loongson,ls1c-syscon
> +          - lsi,axxia-syscon
> +          - marvell,armada-3700-cpu-misc
> +          - marvell,armada-3700-nb-pm
> +          - marvell,armada-3700-avs
> +          - marvell,armada-3700-usb2-host-misc
> +          - marvell,dove-global-config
> +          - mediatek,mt2701-pctl-a-syscfg
> +          - mediatek,mt2712-pctl-a-syscfg
> +          - mediatek,mt6397-pctl-pmic-syscfg
> +          - mediatek,mt8135-pctl-a-syscfg
> +          - mediatek,mt8135-pctl-b-syscfg
> +          - mediatek,mt8173-pctl-a-syscfg
> +          - mediatek,mt8365-syscfg
> +          - microchip,lan966x-cpu-syscon
> +          - microchip,sam9x60-sfr
> +          - microchip,sama7g5-ddr3phy
> +          - mscc,ocelot-cpu-syscon
> +          - mstar,msc313-pmsleep
> +          - nuvoton,ma35d1-sys
> +          - nuvoton,wpcm450-shm
> +          - rockchip,px30-qos
> +          - rockchip,rk3036-qos
> +          - rockchip,rk3066-qos
> +          - rockchip,rk3128-qos
> +          - rockchip,rk3228-qos
> +          - rockchip,rk3288-qos
> +          - rockchip,rk3368-qos
> +          - rockchip,rk3399-qos
> +          - rockchip,rk3568-qos
> +          - rockchip,rk3588-qos
> +          - rockchip,rv1126-qos
> +          - st,spear1340-misc
> +          - stericsson,nomadik-pmu
> +          - starfive,jh7100-sysmain
> +          - ti,am62-usb-phy-ctrl
> +          - ti,am625-dss-oldi-io-ctrl
> +          - ti,am62p-cpsw-mac-efuse
> +          - ti,am654-dss-oldi-io-ctrl
> +          - ti,j784s4-pcie-ctrl
> +          - ti,keystone-pllctrl
>    required:
>      - compatible
> =20
>  properties:
>    compatible:
> -    anyOf:
> -      - items:
> -          - enum:
> -              - al,alpine-sysfabric-service
> -              - allwinner,sun8i-a83t-system-controller
> -              - allwinner,sun8i-h3-system-controller
> -              - allwinner,sun8i-v3s-system-controller
> -              - allwinner,sun50i-a64-system-controller
> -              - altr,l3regs
> -              - altr,sdr-ctl
> -              - amd,pensando-elba-syscon
> -              - amlogic,meson-mx-assist
> -              - amlogic,meson-mx-bootrom
> -              - amlogic,meson8-analog-top
> -              - amlogic,meson8b-analog-top
> -              - amlogic,meson8-pmu
> -              - amlogic,meson8b-pmu
> -              - apm,xgene-csw
> -              - apm,xgene-efuse
> -              - apm,xgene-mcb
> -              - apm,xgene-rb
> -              - apm,xgene-scu
> -              - atmel,sama5d2-sfrbu
> -              - atmel,sama5d3-nfc-io
> -              - atmel,sama5d3-sfrbu
> -              - atmel,sama5d4-sfrbu
> -              - axis,artpec6-syscon
> -              - brcm,cru-clkset
> -              - brcm,sr-cdru
> -              - brcm,sr-mhb
> -              - cirrus,ep7209-syscon1
> -              - cirrus,ep7209-syscon2
> -              - cirrus,ep7209-syscon3
> -              - cnxt,cx92755-uc
> -              - freecom,fsg-cs2-system-controller
> -              - fsl,imx93-aonmix-ns-syscfg
> -              - fsl,imx93-wakeupmix-syscfg
> -              - fsl,ls1088a-reset
> -              - fsl,vf610-anatop
> -              - fsl,vf610-mscm-cpucfg
> -              - hisilicon,dsa-subctrl
> -              - hisilicon,hi6220-sramctrl
> -              - hisilicon,hip04-ppe
> -              - hisilicon,pcie-sas-subctrl
> -              - hisilicon,peri-subctrl
> -              - hpe,gxp-sysreg
> -              - loongson,ls1b-syscon
> -              - loongson,ls1c-syscon
> -              - lsi,axxia-syscon
> -              - marvell,armada-3700-cpu-misc
> -              - marvell,armada-3700-nb-pm
> -              - marvell,armada-3700-avs
> -              - marvell,armada-3700-usb2-host-misc
> -              - marvell,dove-global-config
> -              - mediatek,mt2701-pctl-a-syscfg
> -              - mediatek,mt2712-pctl-a-syscfg
> -              - mediatek,mt6397-pctl-pmic-syscfg
> -              - mediatek,mt8135-pctl-a-syscfg
> -              - mediatek,mt8135-pctl-b-syscfg
> -              - mediatek,mt8173-pctl-a-syscfg
> -              - mediatek,mt8365-syscfg
> -              - microchip,lan966x-cpu-syscon
> -              - microchip,sam9x60-sfr
> -              - microchip,sama7g5-ddr3phy
> -              - mscc,ocelot-cpu-syscon
> -              - mstar,msc313-pmsleep
> -              - nuvoton,ma35d1-sys
> -              - nuvoton,wpcm450-shm
> -              - rockchip,px30-qos
> -              - rockchip,rk3036-qos
> -              - rockchip,rk3066-qos
> -              - rockchip,rk3128-qos
> -              - rockchip,rk3228-qos
> -              - rockchip,rk3288-qos
> -              - rockchip,rk3368-qos
> -              - rockchip,rk3399-qos
> -              - rockchip,rk3568-qos
> -              - rockchip,rk3588-qos
> -              - rockchip,rv1126-qos
> -              - st,spear1340-misc
> -              - stericsson,nomadik-pmu
> -              - starfive,jh7100-sysmain
> -              - ti,am62-usb-phy-ctrl
> -              - ti,am625-dss-oldi-io-ctrl
> -              - ti,am62p-cpsw-mac-efuse
> -              - ti,am654-dss-oldi-io-ctrl
> -              - ti,j784s4-pcie-ctrl
> -              - ti,keystone-pllctrl
> -
> -          - const: syscon
> -
> -      - contains:
> -          const: syscon
> -        minItems: 2
> -        maxItems: 5  # Should be enough
> +    items:
> +      - enum:
> +          - al,alpine-sysfabric-service
> +          - allwinner,sun8i-a83t-system-controller
> +          - allwinner,sun8i-h3-system-controller
> +          - allwinner,sun8i-v3s-system-controller
> +          - allwinner,sun50i-a64-system-controller
> +          - altr,l3regs
> +          - altr,sdr-ctl
> +          - amd,pensando-elba-syscon
> +          - amlogic,meson-mx-assist
> +          - amlogic,meson-mx-bootrom
> +          - amlogic,meson8-analog-top
> +          - amlogic,meson8b-analog-top
> +          - amlogic,meson8-pmu
> +          - amlogic,meson8b-pmu
> +          - apm,xgene-csw
> +          - apm,xgene-efuse
> +          - apm,xgene-mcb
> +          - apm,xgene-rb
> +          - apm,xgene-scu
> +          - atmel,sama5d2-sfrbu
> +          - atmel,sama5d3-nfc-io
> +          - atmel,sama5d3-sfrbu
> +          - atmel,sama5d4-sfrbu
> +          - axis,artpec6-syscon
> +          - brcm,cru-clkset
> +          - brcm,sr-cdru
> +          - brcm,sr-mhb
> +          - cirrus,ep7209-syscon1
> +          - cirrus,ep7209-syscon2
> +          - cirrus,ep7209-syscon3
> +          - cnxt,cx92755-uc
> +          - freecom,fsg-cs2-system-controller
> +          - fsl,imx93-aonmix-ns-syscfg
> +          - fsl,imx93-wakeupmix-syscfg
> +          - fsl,ls1088a-reset
> +          - fsl,vf610-anatop
> +          - fsl,vf610-mscm-cpucfg
> +          - hisilicon,dsa-subctrl
> +          - hisilicon,hi6220-sramctrl
> +          - hisilicon,hip04-ppe
> +          - hisilicon,pcie-sas-subctrl
> +          - hisilicon,peri-subctrl
> +          - hpe,gxp-sysreg
> +          - loongson,ls1b-syscon
> +          - loongson,ls1c-syscon
> +          - lsi,axxia-syscon
> +          - marvell,armada-3700-cpu-misc
> +          - marvell,armada-3700-nb-pm
> +          - marvell,armada-3700-avs
> +          - marvell,armada-3700-usb2-host-misc
> +          - marvell,dove-global-config
> +          - mediatek,mt2701-pctl-a-syscfg
> +          - mediatek,mt2712-pctl-a-syscfg
> +          - mediatek,mt6397-pctl-pmic-syscfg
> +          - mediatek,mt8135-pctl-a-syscfg
> +          - mediatek,mt8135-pctl-b-syscfg
> +          - mediatek,mt8173-pctl-a-syscfg
> +          - mediatek,mt8365-syscfg
> +          - microchip,lan966x-cpu-syscon
> +          - microchip,sam9x60-sfr
> +          - microchip,sama7g5-ddr3phy
> +          - mscc,ocelot-cpu-syscon
> +          - mstar,msc313-pmsleep
> +          - nuvoton,ma35d1-sys
> +          - nuvoton,wpcm450-shm
> +          - rockchip,px30-qos
> +          - rockchip,rk3036-qos
> +          - rockchip,rk3066-qos
> +          - rockchip,rk3128-qos
> +          - rockchip,rk3228-qos
> +          - rockchip,rk3288-qos
> +          - rockchip,rk3368-qos
> +          - rockchip,rk3399-qos
> +          - rockchip,rk3568-qos
> +          - rockchip,rk3588-qos
> +          - rockchip,rv1126-qos
> +          - st,spear1340-misc
> +          - stericsson,nomadik-pmu
> +          - starfive,jh7100-sysmain
> +          - ti,am62-usb-phy-ctrl
> +          - ti,am625-dss-oldi-io-ctrl
> +          - ti,am62p-cpsw-mac-efuse
> +          - ti,am654-dss-oldi-io-ctrl
> +          - ti,j784s4-pcie-ctrl
> +          - ti,keystone-pllctrl
> +      - const: syscon
> =20
>    reg:
>      maxItems: 1
> =20
> -  reg-io-width:
> -    description: |
> -      The size (in bytes) of the IO accesses that should be performed
> -      on the device.
> -    enum: [1, 2, 4, 8]
> -
>    resets:
>      maxItems: 1
> =20
> @@ -144,18 +217,9 @@ required:
>    - reg
> =20
>  allOf:
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            const: simple-mfd
> -    then:
> -      properties:
> -        compatible:
> -          minItems: 3
> -          maxItems: 5
> +  - $ref: syscon-common.yaml#
> =20
> -additionalProperties: true
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
>=20
> --=20
> 2.43.0
>=20

--CXG+45ywyuUtHPCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBoBAAKCRB4tDGHoIJi
0seNAP9PcJIAfsc/vsXxRXfOLox7rjOS6pkmfprZROch6c7uWQEA35aMGLQF3ywb
TmXxwm/cSATJ2sqoryaGHZDfKAJmxgs=
=dmFR
-----END PGP SIGNATURE-----

--CXG+45ywyuUtHPCF--

