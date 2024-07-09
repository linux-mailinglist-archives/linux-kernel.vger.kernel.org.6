Return-Path: <linux-kernel+bounces-246667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D06292C4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D486281C19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BF17B027;
	Tue,  9 Jul 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx2/u00N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B31B86DD;
	Tue,  9 Jul 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558145; cv=none; b=sTW0oZL2t5D+iOcadyeYE0+h7260bgNBL8teLbMRzCcRPM/Iuza+LPADxiPLzT0e2vLsUUiDn+qWVsjViJ6bZb61DZRfyBhly1EYGbiMko/o15HXUMZXexratmkLNfhBlK5rENvPowarqQQKNubVIFmK/W2w+NR/DDgX9fDcd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558145; c=relaxed/simple;
	bh=xB/rqONSiKTXX/COCfXXzm9QDGUNKnQ7AIJwDG5XVS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKv1k+LdLBxa3tQR/FVy5N71a7Zeq7G2SnN0/2KnI905sC2O3+L62fLmhS1XYTsJZ62taX3HNlD//o3+wIawXba25c0BoM3AdkyD0JpWntfeaQCTrkxfv+mAqTdI2Z0eEtqWbpzEHKbymyAegmUF1EJ8hKI9t/AwS8Qm0itIMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx2/u00N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F5DC4AF0C;
	Tue,  9 Jul 2024 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720558145;
	bh=xB/rqONSiKTXX/COCfXXzm9QDGUNKnQ7AIJwDG5XVS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mx2/u00NmV324nTrIISzR9sSOk0mG5byuO592kDG/+85ZduAvRKEaF12VdZOBi08A
	 YlOwls7IOIN4K6ICFdxqB0NP/A5Ery3mrlulO9Os/QiBoN2UY1XaMujhK45sXP0Qp2
	 V8LIfSDK1s3Cwwc6W3hax4Q6r5dlIFF2USrOYTwi9a4j9Y9US35J9Qp22U/jL6Euj1
	 BaOng6yMOrwfcfZQay3n3bfSnrTKPeNwfW6SifLsBDp8fCo7IbKxFhhuDUWeJ2mUiu
	 DvOW+ZORf2xEvhSaCtPYWN51r7FPEsavPB0cptR/94MxnQ5XWUgkipzao19JHkk1kQ
	 Mzj/OwbO9EkGA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so53289461fa.0;
        Tue, 09 Jul 2024 13:49:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWemgK4+EvDb/4cKsK01UHz5+88qPdwFHxpFbRux0quPAb1ohaFJ4kfCewzgl5RQ5kfkVOLnppP4Djg/0HoiDvO3v7OW/QQcUyjvJ3RfZOyct2nu6c6dZfOzq0b6IiuEN5qdOw/0zmlbg==
X-Gm-Message-State: AOJu0YxLeN+gPGg5YW/1+erBeTutukRHTfORp58a2GhYjzhQojseqqWZ
	xMKwfo6SeiiUJlvNE+5E7+YGRp7v5wbSk+mffkP0nt1uTxOZD+Hrprrqb0amg4RXNZhgFStZwjg
	oHFkgw2dGlSZAxSYfOhre38A6yA==
X-Google-Smtp-Source: AGHT+IEajOEWJj58FQkrrV8zeZNHl0JCYk13BPOFaqtQhTSXDsWpEjQX8c50JAOS6vz2PcMZTxq0KKGMf23dC+uMZ7A=
X-Received: by 2002:a05:6512:6d3:b0:52e:a008:8f41 with SMTP id
 2adb3069b0e04-52eb99916damr2826092e87.25.1720558143312; Tue, 09 Jul 2024
 13:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709084401.21108-1-krzysztof.kozlowski@linaro.org> <20240709170248.GA3803124-robh@kernel.org>
In-Reply-To: <20240709170248.GA3803124-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Jul 2024 14:48:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-wLzHmYN9Lntth3TKgpjfj3jxoGD5T49gSkDSMR=S_Q@mail.gmail.com>
Message-ID: <CAL_JsqL-wLzHmYN9Lntth3TKgpjfj3jxoGD5T49gSkDSMR=S_Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: non-dt-devices: document ltr,ltrf216a used
 via ACPI PRP0001
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, 
	Jonathan Cameron <jic23@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 11:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Jul 09, 2024 at 10:44:01AM +0200, Krzysztof Kozlowski wrote:
> > There is a device in the wild with non-updatable firmware coming with
> > ACPI tables with rejected "ltr,ltrf216a" compatible.  Linux kernel stil=
l
> > supports this device via ACPI PRP0001, however the compatible was never
> > accepted to bindings.  Lack of bindings causes checkpatch.pl warning
> > about undocumented compatible.
>
> Why do we care? For checkpatch.pl I really don't. That hack check I
> wrote makes any string in binding docs a documented compatible. I have a
> better check using the schema written, but that would make checkpatch
> dependent on dtschema tools. So maybe just time to drop this check from
> checkpatch as we have other ways to check and track this.
>
> However, I do care about 'make dt_compatible_check'. Besides these ACPI
> cases, there's a bunch of cases that we'll never have schemas for. Like
> everything from Sparc... Old PowerMac stuff... So I would like to
> 'document' them just to exclude from dt_compatible_check. So perhaps
> this should be generalized.

Here's my list of what's really not documented. It's just a grep of
the bindings of each compatible found by 'make dt_compatible_check'.
Probably anything with SUNW, ibm, amcc, or mpc5 is never going to be
documented.

There are some false positives such as cases documented like "fsl,<chip>-gu=
ts".

1682m-rng
abb,socrates-nand
adi,ad2s1200
adi,ad2s1205
adi,ad7816
adi,ad7817
adi,ad7818
adi,ad9833
adi,ad9834
adi,ad9837
adi,ad9838
adi,adis16203
adi,adm1024
adi,adm1027
adi,adt7316
adi,adt7317
adi,adt7318
adi,adt7463
adi,adt7468
adi,adt7516
adi,adt7517
adi,adt7519
adi,adxl34x
adm1030
allwinner,sun4i-a10-codec-clk
allwinner,sun4i-a10-pll2-clk
allwinner,sun4i-emac
allwinner,sun50i-h6-dwc3
allwinner,sun5i-a13-pll2-clk
allwinner,sun6i-a31-ahb1-mux-clk
allwinner,sun6i-a31-display-clk
allwinner,sun7i-a20-pll4-clk
allwinner,sun8i-a33-ahb1-gates-clk
alphascale,asm9260-icoll
altr,socfpga-a10-gate-clk
altr,socfpga-a10-perip-clk
altr,socfpga-a10-pll-clock
altr,socfpga-perip-clk
amcc,ppc440epx-rng
amcc,ppc460ex-rng
amcc,ppc4xx-crypto
amcc,sata-460ex
amlogic,meson-gxl-mmc
amlogic,meson-gxm-mmc
ams,as3722-pinctrl
ams,as3722-regulator
apm,xgene2-sgenet
apm,xgene2-xgenet
apm,xgene-ahci-v2
apm,xgene-gpio-v2
apm,xgene-reboot
apm,xgene-shadowcat
arcx,anybus-controller
arm,amba-bus
arm,armv7m-nvic
arm,core-module-versatile
arm,coresight-replicator
arm,external-bus-interface
arm,integrator-cp-timer
arm,integrator-timer
aspeed,ast2400-scu-ic
aspeed,ast2600-gfx
aspeed,g4-pinctrl
aspeed,g5-pinctrl
atmel,at91rm9200-clk-main
atmel,at91rm9200-clk-main-osc
atmel,at91rm9200-clk-master
atmel,at91rm9200-clk-peripheral
atmel,at91rm9200-clk-pll
atmel,at91rm9200-clk-programmable
atmel,at91rm9200-clk-system
atmel,at91rm9200-clk-usb
atmel,at91rm9200-usart-serial
atmel,at91sam9260-clk-slow
atmel,at91sam9261-pmc
atmel,at91sam9263-pmc
atmel,at91sam9g20-clk-pllb
atmel,at91sam9g45-clk-pll
atmel,at91sam9g45-clk-programmable
atmel,at91sam9n12-clk-usb
atmel,at91sam9rl-dma
atmel,at91sam9rl-ssc
atmel,at91sam9x5-clk-main
atmel,at91sam9x5-clk-main-rc-osc
atmel,at91sam9x5-clk-master
atmel,at91sam9x5-clk-peripheral
atmel,at91sam9x5-clk-plldiv
atmel,at91sam9x5-clk-programmable
atmel,at91sam9x5-clk-smd
atmel,at91sam9x5-clk-usb
atmel,at91sam9x5-clk-utmi
atmel,atmel_mxt_tp
atmel,atmel_mxt_ts
atmel,mXT224
atmel,qt602240_ts
atmel,sama5d2-clk-audio-pll-frac
atmel,sama5d2-clk-audio-pll-pad
atmel,sama5d2-clk-audio-pll-pmc
atmel,sama5d2-clk-generated
atmel,sama5d2-clk-i2s-mux
atmel,sama5d2-sfr
atmel,sama5d3-adc
atmel,sama5d3-clk-pll
atmel,sama5d3-tcb
atmel,sama5d4-clk-h32mx
atmel,sama5d4-sfr
atmel,samx7-rstc
audio-graph-card2-custom-sample
bcm,kona-sdhci
bcm,kona-smc
bcm,kona-timer
bmac+
bosch,bmp181
bq4802
brcm,40nm-ephy
brcm,bcm58535-srab
brcm,bcm7125-sun-top-ctrl
brcm,bcm7211-dpfe-cpu
brcm,bcm7278-dpfe-cpu
brcm,bcm7346-sun-top-ctrl
brcm,bcm7358-sun-top-ctrl
brcm,bcm7360-sun-top-ctrl
brcm,bcm7362-sun-top-ctrl
brcm,bcm7420-sun-top-ctrl
brcm,bcm7425-sun-top-ctrl
brcm,bcm7429-sun-top-ctrl
brcm,bcm7435-sun-top-ctrl
brcm,brcmstb-sun-top-ctrl
brcm,ehci-brcm-v2
brcm,vc4-v3d
broadcom,bcm5241
buffalo,ls421d
buffalo,ls421de
cavium,mdio-mux
cavium,mdio-mux-sn74cbtlv3253
cdns,pc302-gem
cdns,xtfpga-clock
chrp,mesh0
compat2
compat3
dallas,max6654
dlg,da9053-ba
dlg,da9053-bc
ds1287
electra-cf
epapr,hv-byte-channel
epson,rx8803
fcu
fsl,1s1021a-msi
fsl,1s1043a-msi
fsl,avic
fsl,b4860-l3-cache-controller
fsl,bsc9131-guts
fsl,bsc9132-guts
fsl,elbc-fcm-nand
fsl,ep8248e-bcsr
fsl,ep8248e-mdio-bitbang
fsl,icoll
fsl,imx1-dma
fsl,imx1-iomuxc
fsl,imx21-dma
fsl,imx21-nand
fsl,imx25-iomuxc
fsl,imx25-nand
fsl,imx51-ipu
fsl,imx51-nand
fsl,imx53-nand
fsl,imx53-tve
fsl,imx6q-ipu
fsl,imx6q-mlb150
fsl,imx8qm-ahci
fsl,ls1021a-esdhc
fsl,ls1028a-ahci
fsl,ls1043a-ahci
fsl,ls1046a-ahci
fsl,ls1088a-ahci
fsl,ls2080a-ahci
fsl,ls2088a-ahci
fsl,lx2160a-ahci
fsl,mc34708
fsl,mpc5121-fec
fsl,mpc5121-fec-mdio
fsl,mpc5121-gpio
fsl,mpc5121-localbus
fsl,mpc5121-mbx
fsl,mpc5121-nfc
fsl,mpc5121-pci
fsl,mpc5121-rtc
fsl,mpc5121-sdhc
fsl,mpc5121-sram
fsl,mpc5125-fec
fsl,mpc5125-psc-spi
fsl,mpc5125-psc-uart
fsl,mpc5200b-mdio
fsl,mpc5200b-psc-ac97
fsl,mpc5200b-psc-i2s
fsl,mpc5200b-psc-uart
fsl,mpc5200-mdio
fsl,mpc5200-sram
fsl,mpc8272-cpm-usb
fsl,mpc8379-esdhc
fsl,mpc8536-guts
fsl,mpc8544-guts
fsl,mpc8548-pcie
fsl,mpc8568-guts
fsl,mpc8569-guts
fsl,mpc8572-guts
fsl,mpc8610-pci
fsl,mpc8641-pcie
fsl,p1010-esdhc
fsl,p1010-guts
fsl,p1010-pcie
fsl,p1020-guts
fsl,p1021-guts
fsl,p1022-guts
fsl,p1022-pcie
fsl,p1023-guts
fsl,p1023-pcie
fsl,p2020-guts
fsl,p4080-l3-cache-controller
fsl,p4080-pcie
fsl,pq1-fec-enet
fsl,pq2pro-localbus
fsl,pq3-gpio
fsl,pq3-localbus
fsl,pq-sata-v2
fsl,qoriq-pcie
fsl,qoriq-pcie-v2.1
fsl,qoriq-pcie-v2.2
fsl,qoriq-pcie-v2.3
fsl,qoriq-pcie-v2.4
fsl,qoriq-pcie-v3.0
fsl,sec4.0
fsl,sec4.0-job-ring
fsl,t4240-l3-cache-controller
fsl,timrot
fsl,tzic
fsl,vf610-pit
fsl,vmpic-msi
fsl,vmpic-msi-v4.3
fujitsu,coral
fujitsu,lime
fujitsu,MB86276
fujitsu,MB86277
fujitsu,MB86293
fujitsu,MB86294
fujitsu,mint
gef,fpga-wdt
gef,sbc310-gpio
gef,sbc610-gpio
ge,imp3a-gpio
gen_nand
giantplus,gpg482739qs5
google,arche-platform
gpio-mockup
gpio-simulator
grmn,lidar-lite-v3
hawk-bridge
heathrow-media-bay
himax,hx8369
hisilicon,hi3670-dwc3
hisilicon,hi3798mv100-usb2-phy
hisilicon,hip04-clock
hisilicon,hip04-intc
hisilicon,histb-rng
hisilicon,usbhub
honeywell,hih6130
i2cpcf,8584
ibm,axon-msic
ibm,coherent-platform-facility
ibm,ebc
ibm,fsi2pib
ibm,i2cr-scom
ibm,iic
IBM,lhca
IBM,lhea
IBM,lhea-ethernet
ibm,opal-console-hvsi
ibm,opal-console-raw
ibm,opal-flash
ibm,opal-ipmi
ibm,opal-prd
ibm,opb
ibm,plb3
ibm,plb4
ibm,plb6
ibm,pmemory
ibm,pmemory-v2
ibm,power-rng
ibm,ppc4xx-spi
ibm,sdram-4xx-ddr2
ibm,secureboot
ibm,secureboot-v1
ibm,secureboot-v2
ibm,secvar-backend
ibm,tah
idt,82p33811
idt,8v19n850
idt,8v19n851
ingenic,jz4725b-bch
ingenic,jz4740-ecc
ingenic,jz4780-bch
ingenic,x2000h
inside-secure,safexcel-eip197c-mxl
intel,i8259
intel,lgm-asc
invensense,icp10100
invensense,itg3200
invn,mpu3050
isa-m5819p
isa-m5823p
isl,isl12022
isl,isl29028
isl,isl9305
isl,isl9305h
keylargo-media-bay
lantiq,ase-pinctrl
lantiq,dcdc-xrx200
lantiq,gptu-xway
lantiq,icu
lantiq,nand-xway
lantiq,nor
lantiq,pci-xway
lantiq,sflash-falcon
lantiq,vmmc-xway
lantiq,xrx100-pinctrl
lantiq,xrx200a1x-gphy-fw
lantiq,xrx200a2x-gphy-fw
lantiq,xrx200-pinctrl
lantiq,xrx300-pinctrl
linux,spi-loopback-test
liteon,ltr303
lltc,ltc7132
lm87cimt
ltr,ltrf216a
m5819
mailbox-test
marvell,88E1111
marvell,88e1116
marvell,88e1118
marvell,88e1145
marvell,88e1149r
marvell,88e1310
marvell,88E1510
marvell,88E1514
marvell,ap806-system-controller
marvell,armada-3700-rwtm-firmware
marvell,armada-380-ahci
marvell,armada-38x-uart
marvell,cp110-system-controller0
marvell,mv88f6710-pinctrl
marvell,mv88f6720-pinctrl
marvell,mv88f6810-pinctrl
marvell,mv88f6820-pinctrl
marvell,mv88f6828-pinctrl
marvell,mv88f6920-pinctrl
marvell,mv88f6925-pinctrl
marvell,mv88f6928-pinctrl
marvell,pxa1928-gpio
marvell,pxa250-core-clocks
marvell,pxa25x-pinctrl
marvell,pxa270-clocks
marvell,pxa27x-pinctrl
marvell,pxa300-clocks
marvell,pxa-intc
marvell,pxa-timer
max6690
maxim,max20710
maxim,max30208
maxim,max3100
maxim,max31785b
maxim,max6639
maxim,max7318
mediatek,mt6660
mediatek,mt6765-cqdma
mediatek,mt6765-pinctrl
mediatek,mt6779-audio
mediatek,mt6873-dvfsrc
mediatek,mt7620-pci
mediatek,mt7623-moore-pinctrl
mediatek,mt8167-disp-aal
mediatek,mt8167-disp-ccorr
mediatek,mt8167-disp-dither
mediatek,mt8167-disp-gamma
mediatek,mt8167-disp-ovl
mediatek,mt8167-disp-rdma
mediatek,mt8176
mediatek,mt817x
mediatek,mt8183-audiosys
mediatek,mt8183-dvfsrc
mediatek,mt8188-vpp-mutex
mediatek,mt8192-dvfsrc
microchip,lan9354-mdio
microchip,pic32mzda-infra
microchip,sama7g5-ohci
microchip,sama7g5-sdhci
microcrystal,rv2123
moxa,moxart-ic
moxa,moxart-mdio
moxa,moxart-rtl8201cp
mpc5200b-fec-phy
mpc5200-serial
mpc5200-sram
mps,mp2629_adc
mps,mp2629_charger
mps,mp5023
mrvl,pwri2c
mti,ranchu
national,lm64
national,lm85b
national,lm85c
national,lm95235
national,lm95245
national,lm96163
nintendo,latte-exi
nvidia,tegra114-apbdma
nvidia,tegra114-kbc
nvidia,tegra114-mc
nvidia,tegra124-mipi
nvidia,tegra132-emc
nvidia,tegra132-mc
nvidia,tegra132-mipi
nvidia,tegra132-pmc
nvidia,tegra148-apbdma
nvidia,tegra194-hte-test
nvidia,tegra210-ictlr
nvidia,tegra210-mc
nvidia,tegra239-ccplex-cluster
nvidia,tegra30-apbdma
nvidia,tegra30-kbc
nxp,isp1707
nxp,rtc-pcf2123
nxp,uda1380
ohare-media-bay
ohare-swim3
ohci-bigendian
ohci-le
ohci-littledian
omapdss,composite-video-connector
omapdss,dvi-connector
omapdss,hdmi-connector
omapdss,lgphilips,lb035q02
omapdss,nec,nl8048hl11
omapdss,panel-dpi
omapdss,panel-dsi-cm
omapdss,sharp,ls037v7dw01
omapdss,sony,acx565akm
omapdss,svideo-connector
omapdss,ti,opa362
omapdss,ti,tfp410
omapdss,ti,tpd12s015
omapdss,toppoly,td028ttec1
omapdss,tpo,td028ttec1
omapdss,tpo,td043mtea1
onnn,nct214
onnn,nct218
onnn,nct72
onnn,pca9655
opencores,ocfb
pasemi,localbus
pasemi,localbus-nand
pasemi,pwrficient-rng
pasemi,sdc
pciex108e,80f0
phytec,pcm030-audio-fabric
picochip,pc3x2-rtc
picochip,pc3x2-timer
pmem-region-v2
ppc4xx-rng
qca,qca9530-pll
qca,qca9560-pll
qcom,adreno-3xx
qcom,gcc-mdm9615
qcom,kgsl-3d0
qcom,mdss_mdp
qcom,sc7180-ipa-virt
qcom,sc7180-qmp-usb3-phy
qcom,sc8180x-dpu
qcom,sc8180x-ipa-virt
qcom,sc8180x-mdss
qcom,sc8180x-qmp-usb3-phy
qcom,sdm845-qmp-usb3-phy
qcom,sdx55-ipa-virt
qcom,sm8150-camnoc-virt
qcom,sm8150-ipa-virt
qcom,sm8150-qmp-usb3-phy
qcom,sm8250-ipa-virt
qcom,sm8250-qmp-usb3-phy
qcom,sm8350-qmp-gen3x2-pcie-phy
qcom,sm8350-qmp-usb3-phy
qcom,sm8450-qmp-usb3-phy
qcom,usb-snps-femto-v2-phy
qt1070
ralink,mt7620a-memc
ralink,rt2880-memc
ralink,rt2880-pinmux
ralink,rt2880-reset
ralink,rt288x-pci
ralink,rt3050-memc
ralink,rt3883-memc
raspberrypi,sensehat-joystick
realtek,rt1305
realtek,rt1306
regulator-virtual-consumer
renesas,cmt-48
renesas,cmt-48-gen2
renesas,mlp
rockchip,rk3366-tsadc
rohm,bh1780gli
sab82532
sgx,vz89te
sgy,gpio-halt
silabs,si544a
silabs,si544c
smsc,emc6d100
smsc,emc6d101
smsc,emc6d102
smsc,emc6d103
smsc,emc6d103s
smsc,lan91c94
smu-sat
snps,archs-timer-gfrc
snps,archs-timer-rtc
socionext,mn884433
socionext,mn884434-0
socionext,mn884434-1
sprd,sc9860-dwc3
sprd,sc9860-suspend-timer
st,6556002
stericsson,ab8500-ponkey
st-ericsson,u8540
st-ericsson,u9540
st,iis2mdc
st,nomadik-src-clock
st,pm6764tr
st,rv4162
st,spear-plgpio
st,st21nfca_i2c
st,st21nfcb_i2c
st,sta529
st,stih407-compositor
st,stih407-flash-pinctrl
st,stih407-front-pinctrl
st,stih407-hda
st,stih407-hdmi
st,stih407-rear-pinctrl
st,stih407-tvout
st,stih416-mpe-thermal
st,sti-pwm
st,stmpe1801
st,stmpe610
st,stw4810
st,stw4811
st,stw481x-vmmc
sun4v
SUNW,bbc-beep
SUNW,bbc-i2c
SUNW,CS4231
SUNW,ebus-pic16f747-env
SUNW,kt-cwq
SUNW,kt-mau
SUNW,n2-cwq
SUNW,n2-mau
SUNW,niusl
SUNW,smbus-beep
SUNW,sun4v-console
SUNW,sun4v-pci
SUNW,vf-cwq
SUNW,vf-mau
swim3
synaptics,synaptics_i2c
tcs,tcs4526
test-device
ti,741g74
ti,am33xx-ecap
ti,am33xx-ehrpwm
ti,bq24157s
ti,cd9200
ti,cd9220
ti,cd9222
ti,cd9224
ti,cd9240
ti,cd9244
ti,cd9246
ti,cd9248
ti,dm6441-mmc
ti,dm814-pllss
ti,dm814-scm
ti,drv2604l
ti,emif-4d5
ti,musb-dm816
ti,omap2420-sdma
ti,omap2430-sdma
ti,omap3430-sdma
ti,omap3630-sdma
ti,omap3-sham
ti,omap5-usb2
ti,omap-infra
ti,tlv320aic23
ti,tps53647
ti,tps53667
ti,tps53681
ti,tps546d24
ti,tps65217-bl
ti,tps65218-gpio
ti,tps80036-pmic
ti,twl4030-power-omap3-evm
ti,twl4030-power-omap3-ldp
ti,twl4030-power-omap3-sdp
ti,ucd9000
ti,ucd90120
ti,ucd90124
ti,ucd90160
ti,ucd9090
ti,ucd90910
toppoly,td028ttec1
toshiba,apb-dummy-codec
ucc_uart
unittest-gpio
unittest-pci
via,vt8500-ehci
virtio,uml
wm,prizm-ehci
wm,wm8750-pinctrl
wrs,epld-localbus
xlnx,axi4-os62420_3pin-1.00.a
xlnx,axi4-os62420_6pin-1.00.a
xlnx,axi-fifo-mm-s-4.1
xlnx,opb-intc-1.00.c
xlnx,plb-dvi-cntlr-ref-1.00.c
xlnx,plb-tft-cntlr-ref-1.00.a
xlnx,xillybus-1.00.a
xlnx,xps-intc-1.00.a
xlnx,xps-ll-temac-1.01.b
xlnx,xps-ll-temac-2.00.a
xlnx,xps-ll-temac-2.02.a
xlnx,xps-ll-temac-2.03.a
xlnx,xps-ps2-1.00.a
xlnx,xps-tft-1.00.a
xlnx,xps-tft-2.00.a
xlnx,xps-tft-2.01.a
xlnx,xps-usb-host-1.00.a
zte,zx296718-reset

