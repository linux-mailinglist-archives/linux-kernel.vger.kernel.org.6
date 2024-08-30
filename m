Return-Path: <linux-kernel+bounces-309173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4F966709
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5091C20E06
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5C192D97;
	Fri, 30 Aug 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC6TKqHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046A1B86D9;
	Fri, 30 Aug 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035635; cv=none; b=uQSQR4BPscySCUTuJDkBkOmXhNSY3jDB5cmygUt/zCtrmCvFewiMiqAvE19YxkDidh0l6/EIx1n2KVMwK1X0RnGiGYc4xMj9u2R5XAo36bhrPEVyqfTfLPyp/wGPlY3nKwN8IilRtiEsgAwAgbOxyeXTrUA9loeTErzXuTByuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035635; c=relaxed/simple;
	bh=CRBgrXhnNT72frU+Zs3RPy967MpV0qi0OYhxEtXZnLM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=P7pdKSuS1VqvTppdSx4GfmEs9s7ga1Gz8UVkPqeNhkTaiWTJkrsgopwa3LnTFKkM1Jwg/Lr01HJnDjmecLM9PUniOGo1Utc6JudiDG/65W3VjkHwG2h3Znm4InMy9rDj/j05VMa3tML2dRY9N3fSe1bIv4ned6NvZvkMlpcfZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC6TKqHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400BDC4CEC7;
	Fri, 30 Aug 2024 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725035634;
	bh=CRBgrXhnNT72frU+Zs3RPy967MpV0qi0OYhxEtXZnLM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pC6TKqHgu8YJ/JCfey0OshaJQhbWdioqQSMZuc0rxAjMaFyWJ4FjafulDW5NE/Im9
	 D4C4z9AOB/ZRWL62UWkxIHyInytEiPVmeAfAFKAJdIB/3tp0qF3BX+EgaC/uVtatON
	 LRRdxdT4UJAmwxG3rnLlWH+BF80IPh7BoT6QreMcQNK62ein6kJGfZbnLV6v9lYTgW
	 m4K/7ac1AEObg41Cd/DqdKGZ1VnUU4v9OszsGKp3lUP2eqRz8EfFvLeWvr9NSS39jU
	 HbPk2+igwLGqxG323by3tK3EzFEkJTy6Gcuy/YkuogwPExfe6n9CK2nBE0SNzH/54p
	 X1H3SGTr04R6w==
Date: Fri, 30 Aug 2024 11:33:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240830085441.3589713-1-lukma@denx.de>
References: <20240830085441.3589713-1-lukma@denx.de>
Message-Id: <172503554031.420524.15555712891430366918.robh@kernel.org>
Subject: Re: [PATCH v3] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices


On Fri, 30 Aug 2024 10:54:41 +0200, Lukasz Majewski wrote:
> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> some extend similar to already upstreamed XEA devices, hence are
> using common imx28-lwe.dtsi file.
> 
> New, imx28-btt3.dtsi has been added to embrace common DTS
> properties for different HW revisions for this device.
> 
> As a result - changes introduced in imx28-btt3-[012].dts are
> minimal.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> 
> Changes for v2:
> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
>   linux kernel naming convention
> - Remove 'wlf,wm8974' from compatible for codec@1a
> 
> Changes for v3:
> - Keep alphabethical order for Makefile entries
> ---
>  arch/arm/boot/dts/nxp/mxs/Makefile         |   3 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts |  12 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts |   8 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts |  12 +
>  arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi  | 320 +++++++++++++++++++++
>  5 files changed, 355 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y nxp/mxs/imx28-btt3-0.dtb nxp/mxs/imx28-btt3-1.dtb nxp/mxs/imx28-btt3-2.dtb' for 20240830085441.3589713-1-lukma@denx.de:

arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['lwn,btt3', 'fsl,imx28'] is too short
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
		['lwn,btt3', 'fsl,imx28'] is too short
		'lwn,btt3' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
		'lwn,btt3' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
		'tq,imx8dxp-tqma8xdp' was expected
		'tq,imx8qxp-tqma8xqp' was expected
	['lwn,btt3', 'fsl,imx28'] is too long
	'lwn,btt3' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
	'lwn,btt3' is not one of ['creative,x-fi3', 'fsl,imx23-evk', 'fsl,stmp378x-devb', 'olimex,imx23-olinuxino', 'sandisk,sansa_fuze_plus']
	'lwn,btt3' is not one of ['fsl,imx25-pdk', 'karo,imx25-tx25']
	'lwn,btt3' is not one of ['eukrea,mbimxsd25-baseboard']
	'lwn,btt3' is not one of ['eukrea,mbimxsd25-baseboard-cmo-qvga', 'eukrea,mbimxsd25-baseboard-dvi-svga', 'eukrea,mbimxsd25-baseboard-dvi-vga']
	'lwn,btt3' is not one of ['armadeus,imx27-apf27', 'fsl,imx27-pdk']
	'armadeus,imx27-apf27dev' was expected
	'eukrea,mbimxsd27-baseboard' was expected
	'phytec,imx27-pca100-rdk' was expected
	'phytec,imx27-pcm970' was expected
	'lwn,btt3' is not one of ['armadeus,imx28-apf28', 'bluegiga,apx4devkit', 'crystalfontz,cfa10036', 'eukrea,mbmx28lc', 'fsl,imx28-evk', 'i2se,duckbill', 'i2se,duckbill-2', 'karo,tx28', 'lwn,imx28-xea', 'msr,m28cu3', 'schulercontrol,imx28-sps1', 'technologic,imx28-ts4600']
	'aries,m28' was expected
	'aries,m28evk' was expected
	'armadeus,imx28-apf28dev' was expected
	'lwn,btt3' is not one of ['crystalfontz,cfa10037', 'crystalfontz,cfa10049', 'crystalfontz,cfa10057', 'crystalfontz,cfa10058']
	'lwn,btt3' is not one of ['crystalfontz,cfa10055', 'crystalfontz,cfa10056']
	'lwn,btt3' is not one of ['i2se,duckbill-2-485', 'i2se,duckbill-2-enocean', 'i2se,duckbill-2-spi']
	'eukrea,mbmx283lc' was expected
	'eukrea,mbmx287lc' was expected
	'lwn,btt3' is not one of ['buglabs,imx31-bug', 'logicpd,imx31-lite']
	'lwn,btt3' is not one of ['fsl,imx35-pdk']
	'eukrea,mbimxsd35-baseboard' was expected
	'lwn,btt3' is not one of ['fsl,imx50-evk', 'kobo,aura']
	'lwn,btt3' is not one of ['armadeus,imx51-apf51', 'fsl,imx51-babbage', 'technologic,imx51-ts4800', 'zii,imx51-scu3-esb', 'zii,imx51-scu2-mezz', 'zii,imx51-rdu1']
	'armadeus,imx51-apf51dev' was expected
	'digi,connectcore-ccxmx51-jsk' was expected
	'eukrea,mbimxsd51' was expected
	'lwn,btt3' is not one of ['bhf,cx9020', 'fsl,imx53-ard', 'fsl,imx53-evk', 'fsl,imx53-qsb', 'fsl,imx53-qsrb', 'fsl,imx53-smd', 'ge,imx53-cpuvo', 'inversepath,imx53-usbarmory', 'karo,tx53', 'kiebackpeter,imx53-ddc', 'kiebackpeter,imx53-hsc', 'menlo,m53menlo', 'starterkit,sk-imx53', 'voipac,imx53-dmm-668']
	'aries,imx53-m53evk' was expected
	'tq,mba53' was expected
	'lwn,btt3' is not one of ['auvidea,h100', 'bosch,imx6q-acc', 'boundary,imx6q-nitrogen6_max', 'boundary,imx6q-nitrogen6_som2', 'boundary,imx6q-nitrogen6x', 'compulab,cm-fx6', 'dmo,imx6q-edmqmx6', 'ds,imx6q-sbc', 'embest,imx6q-marsboard', 'emtrion,emcon-mx6', 'emtrion,emcon-mx6-avari', 'engicam,imx6-icore', 'engicam,imx6-icore-rqs', 'fsl,imx6q-arm2', 'fsl,imx6q-sabreauto', 'fsl,imx6q-sabrelite', 'fsl,imx6q-sabresd', 'karo,imx6q-tx6q', 'kiebackpeter,imx6q-tpc', 'kontron,imx6q-samx6i', 'kosagi,imx6q-novena', 'kvg,vicut1q', 'logicpd,imx6q-logicpd', 'lwn,display5', 'lwn,mccmon6', 'nutsboard,imx6q-pistachio', 'microsys,sbc6x', 'poslab,imx6q-savageboard', 'prt,prti6q', 'prt,prtwd2', 'rex,imx6q-rex-pro', 'skov,imx6q-skov-revc-lt2', 'skov,imx6q-skov-revc-lt6', 'skov,imx6q-skov-reve-mi1010ait-1cp1', 'solidrun,cubox-i/q', 'solidrun,hummingboard/q', 'solidrun,hummingboard2/q', 'solidrun,solidsense/q', 'tbs,imx6q-tbs2910', 'technexion,imx6q-pico-dwarf', 'technexion,imx6q-pico-hobbit', 'technexion
 ,imx6q-pico-nymph', 'technexion,imx6q-pico-pi', 'technologic,imx6q-ts4900', 'technologic,imx6q-ts7970', 'toradex,apalis_imx6q', 'udoo,imx6q-udoo', 'uniwest,imx6q-evi', 'variscite,dt6customboard', 'wand,imx6q-wandboard', 'ysoft,imx6q-yapp4-crux', 'ysoft,imx6q-yapp4-pegasus', 'zealz,imx6q-gk802', 'zii,imx6q-zii-rdu2']
	'lwn,btt3' is not one of ['advantech,imx6q-dms-ba16', 'ge,imx6q-b450v3', 'ge,imx6q-b650v3', 'ge,imx6q-b850v3']
	'armadeus,imx6q-apf6dev' was expected
	'compulab,utilite-pro' was expected
	'dfi,fs700-m60-6qd' was expected
	'dh,imx6q-dhcom-pdk2' was expected
	'lwn,btt3' is not one of ['gw,imx6q-gw51xx', 'gw,imx6q-gw52xx', 'gw,imx6q-gw53xx', 'gw,imx6q-gw5400-a', 'gw,imx6q-gw54xx', 'gw,imx6q-gw551x', 'gw,imx6q-gw552x', 'gw,imx6q-gw553x', 'gw,imx6q-gw560x', 'gw,imx6q-gw5903', 'gw,imx6q-gw5904', 'gw,imx6q-gw5907', 'gw,imx6q-gw5910', 'gw,imx6q-gw5912', 'gw,imx6q-gw5913']
	'kontron,imx6q-samx6i-ads2' was expected
	'lwn,btt3' is not one of ['phytec,imx6q-pbac06-emmc', 'phytec,imx6q-pbac06-nand']
	'phytec,imx6q-pbab01' was expected
	'lwn,btt3' is not one of ['toradex,apalis_imx6q-ixora', 'toradex,apalis_imx6q-ixora-v1.1', 'toradex,apalis_imx6q-ixora-v1.2', 'toradex,apalis_imx6q-eval', 'toradex,apalis_imx6q-eval-v1.2']
	'variscite,mx6customboard' was expected
	'tq,imx6q-mba6x-a' was expected
	'tq,imx6q-mba6x-b' was expected
	'lwn,btt3' is not one of ['boundary,imx6qp-nitrogen6_max', 'boundary,imx6qp-nitrogen6_som2', 'fsl,imx6qp-sabreauto', 'fsl,imx6qp-sabresd', 'karo,imx6qp-tx6qp', 'kvg,vicutp', 'prt,prtwd3', 'wand,imx6qp-wandboard', 'ysoft,imx6qp-yapp4-crux-plus', 'ysoft,imx6qp-yapp4-pegasus-plus', 'zii,imx6qp-zii-rdu2']
	'phytec,imx6qp-pbac06-nand' was expected
	'tq,imx6qp-mba6x-b' was expected
	'lwn,btt3' is not one of ['abb,aristainetos-imx6dl-4', 'abb,aristainetos-imx6dl-7', 'abb,aristainetos2-imx6dl-4', 'abb,aristainetos2-imx6dl-7', 'alt,alti6p', 'boundary,imx6dl-nit6xlite', 'boundary,imx6dl-nitrogen6x', 'bticino,imx6dl-mamoj', 'eckelmann,imx6dl-ci4x10', 'emtrion,emcon-mx6', 'emtrion,emcon-mx6-avari', 'engicam,imx6-icore', 'engicam,imx6-icore-rqs', 'fsl,imx6dl-sabreauto', 'fsl,imx6dl-sabrelite', 'fsl,imx6dl-sabresd', 'karo,imx6dl-tx6dl', 'kontron,imx6dl-samx6i', 'kvg,victgo', 'kvg,vicut1', 'ply,plybas', 'ply,plym2m', 'poslab,imx6dl-savageboard', 'prt,prtmvt', 'prt,prtrvt', 'prt,prtvt7', 'rex,imx6dl-rex-basic', 'riot,imx6s-riotboard', 'sielaff,imx6dl-board', 'skov,imx6dl-skov-revc-lt2', 'skov,imx6dl-skov-revc-lt6', 'solidrun,cubox-i/dl', 'solidrun,hummingboard/dl', 'solidrun,hummingboard2/dl', 'solidrun,solidsense/dl', 'technexion,imx6dl-pico-dwarf', 'technexion,imx6dl-pico-hobbit', 'technexion,imx6dl-pico-nymph', 'technexion,imx6dl-pico-pi', 'technologic,imx6dl-ts4900',
  'technologic,imx6dl-ts7970', 'toradex,colibri_imx6dl', 'udoo,imx6dl-udoo', 'vdl,lanmcu', 'wand,imx6dl-wandboard', 'ysoft,imx6dl-yapp4-draco', 'ysoft,imx6dl-yapp4-hydra', 'ysoft,imx6dl-yapp4-lynx', 'ysoft,imx6dl-yapp4-orion', 'ysoft,imx6dl-yapp4-phoenix', 'ysoft,imx6dl-yapp4-ursa']
	'armadeus,imx6dl-apf6dev' was expected
	'lwn,btt3' is not one of ['ge,imx6dl-b105v2', 'ge,imx6dl-b105pv2', 'ge,imx6dl-b125v2', 'ge,imx6dl-b125pv2', 'ge,imx6dl-b155v2']
	'dfi,fs700-m60-6dl' was expected
	'dh,imx6dl-dhcom-picoitx' was expected
	'lwn,btt3' is not one of ['gw,imx6dl-gw51xx', 'gw,imx6dl-gw52xx', 'gw,imx6dl-gw53xx', 'gw,imx6dl-gw54xx', 'gw,imx6dl-gw551x', 'gw,imx6dl-gw552x', 'gw,imx6dl-gw553x', 'gw,imx6dl-gw560x', 'gw,imx6dl-gw5903', 'gw,imx6dl-gw5904', 'gw,imx6dl-gw5907', 'gw,imx6dl-gw5910', 'gw,imx6dl-gw5912', 'gw,imx6dl-gw5913']
	'kontron,imx6dl-samx6i-ads2' was expected
	'lwn,btt3' is not one of ['phytec,imx6dl-pbac06-emmc', 'phytec,imx6dl-pbac06-nand']
	'phytec,imx6dl-pbab01' was expected
	'lwn,btt3' is not one of ['toradex,colibri_imx6dl-aster', 'toradex,colibri_imx6dl-eval-v3', 'toradex,colibri_imx6dl-iris', 'toradex,colibri_imx6dl-iris-v2']
	'dh,imx6s-dhcom-drc02' was expected
	'tq,imx6dl-mba6x-a' was expected
	'tq,imx6dl-mba6x-b' was expected
	'lwn,btt3' is not one of ['fsl,imx6sl-evk', 'kobo,aura2', 'kobo,tolino-shine2hd', 'kobo,tolino-shine3', 'kobo,tolino-vision', 'kobo,tolino-vision5', 'revotics,imx6sl-warp']
	'lwn,btt3' is not one of ['fsl,imx6sll-evk', 'kobo,clarahd', 'kobo,librah2o']
	'lwn,btt3' is not one of ['boundary,imx6sx-nitrogen6sx', 'fsl,imx6sx-sabreauto', 'fsl,imx6sx-sdb', 'fsl,imx6sx-sdb-reva', 'samtec,imx6sx-vining-2000', 'udoo,neobasic', 'udoo,neoextended', 'udoo,neofull']
	'lwn,btt3' is not one of ['engicam,imx6ul-geam', 'engicam,imx6ul-isiot', 'fsl,imx6ul-14x14-evk', 'karo,imx6ul-tx6ul', 'kontron,sl-imx6ul', 'prt,prti6g', 'technexion,imx6ul-pico-dwarf', 'technexion,imx6ul-pico-hobbit', 'technexion,imx6ul-pico-pi']
	'armadeus,imx6ul-opos6uldev' was expected
	'lwn,btt3' is not one of ['digi,ccimx6ulsbcexpress', 'digi,ccimx6ulsbcpro']
	'grinn,imx6ul-liteboard' was expected
	'lwn,btt3' is not one of ['phytec,imx6ul-pbacd10-emmc', 'phytec,imx6ul-pbacd10-nand']
	'kontron,bl-imx6ul' was expected
	'kontron,bl-imx6ul-43' was expected
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul1-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul2-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul2l-mba6ulx', 'tq,imx6ul-tqma6ul2l-mba6ulxl']
	'lwn,btt3' is not one of ['fsl,imx6ull-14x14-evk', 'joz,jozacp', 'kontron,sl-imx6ull', 'myir,imx6ull-mys-6ulx-eval', 'toradex,colibri-imx6ull', 'toradex,colibri-imx6ull-emmc', 'toradex,colibri-imx6ull-wifi', 'uni-t,uti260b']
	'armadeus,imx6ull-opos6uldev' was expected
	'lwn,btt3' is not one of ['chargebyte,imx6ull-tarragon-master', 'chargebyte,imx6ull-tarragon-micro', 'chargebyte,imx6ull-tarragon-slave', 'chargebyte,imx6ull-tarragon-slavext']
	'lwn,btt3' is not one of ['dh,imx6ull-dhcom-drc02', 'dh,imx6ull-dhcom-pdk2', 'dh,imx6ull-dhcom-picoitx']
	'marantec,imx6ull-dhcor-maveo-box' was expected
	'lwn,btt3' is not one of ['phytec,imx6ull-pbacd10-emmc', 'phytec,imx6ull-pbacd10-nand']
	'lwn,btt3' is not one of ['phytec,imx6ull-phygate-tauri-emmc', 'phytec,imx6ull-phygate-tauri-nand']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-aster', 'toradex,colibri-imx6ull-eval', 'toradex,colibri-imx6ull-iris', 'toradex,colibri-imx6ull-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-emmc-aster', 'toradex,colibri-imx6ull-emmc-eval', 'toradex,colibri-imx6ull-emmc-iris', 'toradex,colibri-imx6ull-emmc-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-wifi-eval', 'toradex,colibri-imx6ull-wifi-aster', 'toradex,colibri-imx6ull-wifi-iris', 'toradex,colibri-imx6ull-wifi-iris-v2']
	'kontron,bl-imx6ull' was expected
	'lwn,btt3' is not one of ['tq,imx6ull-tqma6ull2-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ull-tqma6ull2l-mba6ulx', 'tq,imx6ull-tqma6ull2l-mba6ulxl']
	'lwn,btt3' is not one of ['seeed,imx6ull-seeed-npi-emmc', 'seeed,imx6ull-seeed-npi-nand']
	'lwn,btt3' is not one of ['bsh,imx6ulz-bsh-smm-m2', 'fsl,imx6ulz-14x14-evk']
	'lwn,btt3' is not one of ['element14,imx7s-warp', 'toradex,colibri-imx7s']
	'lwn,btt3' is not one of ['toradex,colibri-imx7s-aster', 'toradex,colibri-imx7s-eval-v3', 'toradex,colibri-imx7s-iris', 'toradex,colibri-imx7s-iris-v2']
	'tq,imx7s-mba7' was expected
	'lwn,btt3' is not one of ['boundary,imx7d-nitrogen7', 'compulab,cl-som-imx7', 'fsl,imx7d-sdb', 'fsl,imx7d-sdb-reva', 'kam,imx7d-flex-concentrator', 'kam,imx7d-flex-concentrator-mfg', 'novtech,imx7d-meerkat96', 'remarkable,imx7d-remarkable2', 'storopack,imx7d-smegw01', 'technexion,imx7d-pico-dwarf', 'technexion,imx7d-pico-hobbit', 'technexion,imx7d-pico-nymph', 'technexion,imx7d-pico-pi', 'toradex,colibri-imx7d', 'toradex,colibri-imx7d-emmc', 'zii,imx7d-rmu2', 'zii,imx7d-rpu2']
	'tq,imx7d-mba7' was expected
	'compulab,sbc-imx7' was expected
	'lwn,btt3' is not one of ['toradex,colibri-imx7d-aster', 'toradex,colibri-imx7d-eval-v3', 'toradex,colibri-imx7d-iris', 'toradex,colibri-imx7d-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx7d-emmc-aster', 'toradex,colibri-imx7d-emmc-eval-v3', 'toradex,colibri-imx7d-emmc-iris', 'toradex,colibri-imx7d-emmc-iris-v2']
	'lwn,btt3' is not one of ['ea,imx7ulp-com', 'fsl,imx7ulp-evk']
	'lwn,btt3' is not one of ['beacon,imx8mm-beacon-kit', 'boundary,imx8mm-nitrogen8mm', 'dmo,imx8mm-data-modul-edm-sbc', 'emtrion,emcon-mx8mm-avari', 'fsl,imx8mm-ddr4-evk', 'fsl,imx8mm-evk', 'fsl,imx8mm-evkb', 'gateworks,imx8mm-gw7904', 'gateworks,imx8mm-gw7905-0x', 'gw,imx8mm-gw71xx-0x', 'gw,imx8mm-gw72xx-0x', 'gw,imx8mm-gw73xx-0x', 'gw,imx8mm-gw7901', 'gw,imx8mm-gw7902', 'gw,imx8mm-gw7903', 'innocomm,wb15-evk', 'kontron,imx8mm-sl', 'kontron,imx8mm-osm-s', 'toradex,verdin-imx8mm', 'toradex,verdin-imx8mm-nonwifi', 'toradex,verdin-imx8mm-wifi', 'variscite,var-som-mx8mm', 'prt,prt8mm']
	'lwn,btt3' is not one of ['compulab,imx8mm-iot-gateway']
	'ees,imx8mm-emtop-baseboard' was expected
	'lwn,btt3' is not one of ['engicam,icore-mx8mm-ctouch2', 'engicam,icore-mx8mm-edimm2.2']
	'kontron,imx8mm-bl' was expected
	'kontron,imx8mm-bl-osm-s' was expected
	'lwn,btt3' is not one of ['menlo,mx8menlo', 'toradex,verdin-imx8mm-nonwifi-dahlia', 'toradex,verdin-imx8mm-nonwifi-dev', 'toradex,verdin-imx8mm-nonwifi-mallow', 'toradex,verdin-imx8mm-nonwifi-yavia']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mm-wifi-dahlia', 'toradex,verdin-imx8mm-wifi-dev', 'toradex,verdin-imx8mm-wifi-mallow', 'toradex,verdin-imx8mm-wifi-yavia']
	'lwn,btt3' is not one of ['phytec,imx8mm-phyboard-polis-rdk', 'phytec,imx8mm-phygate-tauri-l']
	'variscite,var-som-mx8mm-symphony' was expected
	'lwn,btt3' is not one of ['cloos,imx8mm-phg', 'tq,imx8mm-tqma8mqml-mba8mx']
	'lwn,btt3' is not one of ['beacon,imx8mn-beacon-kit', 'bsh,imx8mn-bsh-smm-s2', 'bsh,imx8mn-bsh-smm-s2pro', 'fsl,imx8mn-ddr3l-evk', 'fsl,imx8mn-ddr4-evk', 'fsl,imx8mn-evk', 'gw,imx8mn-gw7902']
	'lwn,btt3' is not one of ['dimonoff,gateway-evk', 'rve,gateway', 'variscite,var-som-mx8mn-symphony']
	'lwn,btt3' is not one of ['tq,imx8mn-tqma8mqnl-mba8mx']
	'lwn,btt3' is not one of ['beacon,imx8mp-beacon-kit', 'dmo,imx8mp-data-modul-edm-sbc', 'emcraft,imx8mp-navqp', 'fsl,imx8mp-evk', 'gateworks,imx8mp-gw71xx-2x', 'gateworks,imx8mp-gw72xx-2x', 'gateworks,imx8mp-gw73xx-2x', 'gateworks,imx8mp-gw74xx', 'gateworks,imx8mp-gw7905-2x', 'skov,imx8mp-skov-revb-hdmi', 'skov,imx8mp-skov-revb-lt6', 'skov,imx8mp-skov-revb-mi1010ait-1cp1', 'toradex,verdin-imx8mp', 'toradex,verdin-imx8mp-nonwifi', 'toradex,verdin-imx8mp-wifi']
	'avnet,sm2s-imx8mp-14N0600E-ep1' was expected
	'lwn,btt3' is not one of ['dh,imx8mp-dhcom-pdk2', 'dh,imx8mp-dhcom-pdk3']
	'lwn,btt3' is not one of ['engicam,icore-mx8mp-edimm2.2']
	'phytec,imx8mp-phyboard-pollux-rdk' was expected
	'lwn,btt3' is not one of ['polyhex,imx8mp-debix-model-a']
	'lwn,btt3' is not one of ['polyhex,imx8mp-debix-som-a-bmb-08']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mp-nonwifi-dahlia', 'toradex,verdin-imx8mp-nonwifi-dev', 'toradex,verdin-imx8mp-nonwifi-mallow', 'toradex,verdin-imx8mp-nonwifi-yavia']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mp-wifi-dahlia', 'toradex,verdin-imx8mp-wifi-dev', 'toradex,verdin-imx8mp-wifi-mallow', 'toradex,verdin-imx8mp-wifi-yavia']
	'lwn,btt3' is not one of ['tq,imx8mp-tqma8mpql-mba8mpxl', 'tq,imx8mp-tqma8mpql-mba8mp-ras314']
	'lwn,btt3' is not one of ['boundary,imx8mq-nitrogen8m', 'boundary,imx8mq-nitrogen8m-som', 'einfochips,imx8mq-thor96', 'fsl,imx8mq-evk', 'google,imx8mq-phanbell', 'kontron,pitx-imx8m', 'purism,librem5-devkit', 'solidrun,hummingboard-pulse', 'technexion,pico-pi-imx8m']
	'mntre,reform2' was expected
	'lwn,btt3' is not one of ['purism,librem5r2', 'purism,librem5r3', 'purism,librem5r4']
	'lwn,btt3' is not one of ['tq,imx8mq-tqma8mq-mba8mx']
	'lwn,btt3' is not one of ['zii,imx8mq-ultra-rmb3', 'zii,imx8mq-ultra-zest']
	'lwn,btt3' is not one of ['fsl,imx8qm-mek', 'toradex,apalis-imx8', 'toradex,apalis-imx8-v1.1']
	'lwn,btt3' is not one of ['toradex,apalis-imx8-eval', 'toradex,apalis-imx8-eval-v1.2', 'toradex,apalis-imx8-ixora-v1.1']
	'lwn,btt3' is not one of ['toradex,apalis-imx8-v1.1-eval', 'toradex,apalis-imx8-v1.1-eval-v1.2', 'toradex,apalis-imx8-v1.1-ixora-v1.1', 'toradex,apalis-imx8-v1.1-ixora-v1.2']
	'lwn,btt3' is not one of ['einfochips,imx8qxp-ai_ml', 'fsl,imx8qxp-mek']
	'lwn,btt3' is not one of ['fsl,imx8dxl-evk']
	'lwn,btt3' is not one of ['toradex,colibri-imx8x-aster', 'toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x-iris', 'toradex,colibri-imx8x-iris-v2']
	'lwn,btt3' is not one of ['fsl,imx8ulp-evk']
	'lwn,btt3' is not one of ['fsl,imx93-9x9-qsb', 'fsl,imx93-11x11-evk', 'fsl,imx93-14x14-evk']
	'lwn,btt3' is not one of ['fsl,imx95-19x19-evk']
	'lwn,btt3' is not one of ['fsl,imxrt1050-evk']
	'lwn,btt3' is not one of ['fsl,imxrt1170-evk']
	'lwn,btt3' is not one of ['tq,imx93-tqma9352-mba93xxca', 'tq,imx93-tqma9352-mba93xxla']
	'phytec,imx93-phyboard-segin' was expected
	'variscite,var-som-mx93-symphony' was expected
	'lwn,btt3' is not one of ['fsl,vf500', 'fsl,vf510', 'fsl,vf600', 'fsl,vf610', 'fsl,vf610m4']
	'toradex,vf500-colibri_vf50-on-eval' was expected
	'lwn,btt3' is not one of ['fsl,vf610-twr', 'lwn,bk4', 'phytec,vf610-cosmic', 'toradex,vf610-colibri_vf61']
	'toradex,vf610-colibri_vf61-on-eval' was expected
	'lwn,btt3' is not one of ['zii,vf610cfu1', 'zii,vf610dev-c', 'zii,vf610dev-b', 'zii,vf610scu4-aib', 'zii,vf610dtu', 'zii,vf610spu3', 'zii,vf610spb4']
	'lwn,btt3' is not one of ['ebs-systart,oxalis', 'fsl,ls1012a-rdb', 'fsl,ls1012a-frdm', 'fsl,ls1012a-frwy', 'fsl,ls1012a-qds']
	'lwn,btt3' is not one of ['fsl,ls1021a-iot', 'fsl,ls1021a-moxa-uc-8410a', 'fsl,ls1021a-qds', 'fsl,ls1021a-tsn', 'fsl,ls1021a-twr']
	'lwn,btt3' is not one of ['tq,ls1021a-tqmls1021a-mbls102xa']
	'lwn,btt3' is not one of ['fsl,ls1028a-qds', 'fsl,ls1028a-rdb']
	'kontron,kbox-a-230-ls' was expected
	'lwn,btt3' is not one of ['kontron,sl28-var1-ads2', 'kontron,sl28-var2-ads2', 'kontron,sl28-var3-ads2', 'kontron,sl28-var4-ads2']
	'lwn,btt3' is not one of ['kontron,sl28-var1', 'kontron,sl28-var2', 'kontron,sl28-var3', 'kontron,sl28-var4']
	'kontron,sl28' was expected
	'lwn,btt3' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']
	'lwn,btt3' is not one of ['tq,ls1043a-tqmls1043a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls1046a-frwy', 'fsl,ls1046a-qds', 'fsl,ls1046a-rdb']
	'lwn,btt3' is not one of ['tq,ls1046a-tqmls1046a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls1088a-qds', 'fsl,ls1088a-rdb']
	'lwn,btt3' is not one of ['tq,ls1088a-tqmls1088a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls2080a-simu', 'fsl,ls2080a-qds', 'fsl,ls2080a-rdb']
	'lwn,btt3' is not one of ['fsl,ls2088a-qds', 'fsl,ls2088a-rdb']
	'lwn,btt3' is not one of ['fsl,lx2160a-bluebox3', 'fsl,lx2160a-bluebox3-rev-a', 'fsl,lx2160a-qds', 'fsl,lx2160a-rdb', 'fsl,lx2162a-qds']
	'lwn,btt3' is not one of ['solidrun,clearfog-cx', 'solidrun,honeycomb']
	'lwn,btt3' is not one of ['solidrun,lx2162a-clearfog']
	'lwn,btt3' is not one of ['tq,lx2160a-tqmlx2160a-mblx2160a']
	'lwn,btt3' is not one of ['nxp,s32g274a-evb', 'nxp,s32g274a-rdb2']
	'lwn,btt3' is not one of ['nxp,s32g399a-rdb3']
	'lwn,btt3' is not one of ['fsl,s32v234-evb']
	'lwn,btt3' is not one of ['traverse,ten64']
	'fsl,imx1' was expected
	'fsl,imx23' was expected
	'fsl,imx25' was expected
	'eukrea,cpuimx25' was expected
	'eukrea,mbimxsd25-baseboard' was expected
	'fsl,imx27' was expected
	'armadeus,imx27-apf27' was expected
	'eukrea,cpuimx27' was expected
	'phytec,imx27-pca100' was expected
	'phytec,imx27-pcm038' was expected
	'denx,m28' was expected
	'denx,m28evk' was expected
	'armadeus,imx28-apf28' was expected
	'crystalfontz,cfa10036' was expected
	'crystalfontz,cfa10037' was expected
	'i2se,duckbill-2' was expected
	'eukrea,mbmx28lc' was expected
	'fsl,imx31' was expected
	'fsl,imx35' was expected
	'eukrea,cpuimx35' was expected
	'fsl,imx50' was expected
	'fsl,imx51' was expected
	'armadeus,imx51-apf51' was expected
	'digi,connectcore-ccxmx51-som' was expected
	'eukrea,cpuimx51' was expected
	'fsl,imx53' was expected
	'denx,imx53-m53evk' was expected
	'tq,tqma53' was expected
	'fsl,imx6q' was expected
	'advantech,imx6q-ba16' was expected
	'armadeus,imx6q-apf6' was expected
	'compulab,cm-fx6' was expected
	'dfi,fs700e-m60' was expected
	'dh,imx6q-dhcom-som' was expected
	'gw,ventana' was expected
	'kontron,imx6q-samx6i' was expected
	'phytec,imx6q-pbac06' was expected
	'phytec,imx6q-pfla02' was expected
	'toradex,apalis_imx6q' was expected
	'variscite,var-som-imx6q' was expected
	'tq,mba6a' was expected
	'tq,mba6b' was expected
	'fsl,imx6qp' was expected
	'phytec,imx6qp-pbac06' was expected
	'fsl,imx6dl' was expected
	'armadeus,imx6dl-apf6' was expected
	'congatec,qmx6' was expected
	'dh,imx6dl-dhcom-som' was expected
	'kontron,imx6dl-samx6i' was expected
	'phytec,imx6dl-pbac06' was expected
	'phytec,imx6dl-pfla02' was expected
	'toradex,colibri_imx6dl' was expected
	'dh,imx6s-dhcom-som' was expected
	'fsl,imx6sl' was expected
	'fsl,imx6sll' was expected
	'fsl,imx6sx' was expected
	'fsl,imx6ul' was expected
	'armadeus,imx6ul-opos6ul' was expected
	'digi,ccimx6ulsom' was expected
	'grinn,imx6ul-litesom' was expected
	'phytec,imx6ul-pbacd10' was expected
	'kontron,sl-imx6ul' was expected
	'tq,imx6ul-tqma6ul1' was expected
	'tq,imx6ul-tqma6ul2' was expected
	'tq,imx6ul-tqma6ul2l' was expected
	'fsl,imx6ull' was expected
	'armadeus,imx6ull-opos6ul' was expected
	'dh,imx6ull-dhcom-som' was expected
	'dh,imx6ull-dhcor-som' was expected
	'phytec,imx6ull-pbacd10' was expected
	'phytec,imx6ull-phygate-tauri' was expected
	'toradex,colibri-imx6ull' was expected
	'toradex,colibri-imx6ull-emmc' was expected
	'toradex,colibri-imx6ull-wifi' was expected
	'kontron,sl-imx6ull' was expected
	'tq,imx6ull-tqma6ull2' was expected
	'tq,imx6ull-tqma6ull2l' was expected
	'seeed,imx6ull-seeed-npi' was expected
	'fsl,imx7s' was expected
	'toradex,colibri-imx7s' was expected
	'tq,imx7s-tqma7' was expected
	'fsl,imx7d' was expected
	'tq,imx7d-tqma7' was expected
	'compulab,cl-som-imx7' was expected
	'toradex,colibri-imx7d' was expected
	'toradex,colibri-imx7d-emmc' was expected
	'fsl,imx7ulp' was expected
	'fsl,imx8mm' was expected
	'compulab,imx8mm-ucm-som' was expected
	'ees,imx8mm-emtop-som' was expected
	'engicam,icore-mx8mm' was expected
	'kontron,imx8mm-sl' was expected
	'kontron,imx8mm-osm-s' was expected
	'toradex,verdin-imx8mm-nonwifi' was expected
	'toradex,verdin-imx8mm-wifi' was expected
	'phytec,imx8mm-phycore-som' was expected
	'variscite,var-som-mx8mm' was expected
	'tq,imx8mm-tqma8mqml' was expected
	'fsl,imx8mn' was expected
	'variscite,var-som-mx8mn' was expected
	'tq,imx8mn-tqma8mqnl' was expected
	'fsl,imx8mp' was expected
	'avnet,sm2s-imx8mp-14N0600E' was expected
	'dh,imx8mp-dhcom-som' was expected
	'engicam,icore-mx8mp' was expected
	'phytec,imx8mp-phycore-som' was expected
	'polyhex,imx8mp-debix' was expected
	'polyhex,imx8mp-debix-som-a' was expected
	'toradex,verdin-imx8mp-nonwifi' was expected
	'toradex,verdin-imx8mp-wifi' was expected
	'tq,imx8mp-tqma8mpql' was expected
	'fsl,imx8mq' was expected
	'boundary,imx8mq-nitrogen8m-som' was expected
	'purism,librem5' was expected
	'tq,imx8mq-tqma8mq' was expected
	'zii,imx8mq-ultra' was expected
	'fsl,imx8qm' was expected
	'toradex,apalis-imx8' was expected
	'toradex,apalis-imx8-v1.1' was expected
	'fsl,imx8qxp' was expected
	'fsl,imx8dxl' was expected
	'toradex,colibri-imx8x' was expected
	'fsl,imx8ulp' was expected
	'fsl,imx93' was expected
	'fsl,imx95' was expected
	'fsl,imxrt1050' was expected
	'fsl,imxrt1170' was expected
	'tq,imx93-tqma9352' was expected
	'phytec,imx93-phycore-som' was expected
	'variscite,var-som-mx93' was expected
	'toradex,vf500-colibri_vf50' was expected
	'fsl,vf610' was expected
	'toradex,vf610-colibri_vf61' was expected
	'zii,vf610dev' was expected
	'fsl,ls1012a' was expected
	'fsl,ls1021a' was expected
	'tq,ls1021a-tqmls1021a' was expected
	'fsl,ls1028a' was expected
	'kontron,sl28-var4' was expected
	'fsl,imx28' is not one of ['kontron,sl28-var1', 'kontron,sl28-var2', 'kontron,sl28-var3', 'kontron,sl28-var4']
	'fsl,ls1043a' was expected
	'tq,ls1043a-tqmls1043a' was expected
	'fsl,ls1046a' was expected
	'tq,ls1046a-tqmls1046a' was expected
	'fsl,ls1088a' was expected
	'tq,ls1088a-tqmls1088a' was expected
	'fsl,ls2080a' was expected
	'fsl,ls2088a' was expected
	'fsl,lx2160a' was expected
	'solidrun,lx2160a-cex7' was expected
	'solidrun,lx2162a-som' was expected
	'tq,lx2160a-tqmlx2160a' was expected
	'nxp,s32g2' was expected
	'nxp,s32g3' was expected
	'fsl,s32v234' was expected
	from schema $id: http://devicetree.org/schemas/arm/fsl.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['lwn,btt3', 'fsl,imx28'] is too short
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
		['lwn,btt3', 'fsl,imx28'] is too short
		'lwn,btt3' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
		'lwn,btt3' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
		'tq,imx8dxp-tqma8xdp' was expected
		'tq,imx8qxp-tqma8xqp' was expected
	['lwn,btt3', 'fsl,imx28'] is too long
	'lwn,btt3' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
	'lwn,btt3' is not one of ['creative,x-fi3', 'fsl,imx23-evk', 'fsl,stmp378x-devb', 'olimex,imx23-olinuxino', 'sandisk,sansa_fuze_plus']
	'lwn,btt3' is not one of ['fsl,imx25-pdk', 'karo,imx25-tx25']
	'lwn,btt3' is not one of ['eukrea,mbimxsd25-baseboard']
	'lwn,btt3' is not one of ['eukrea,mbimxsd25-baseboard-cmo-qvga', 'eukrea,mbimxsd25-baseboard-dvi-svga', 'eukrea,mbimxsd25-baseboard-dvi-vga']
	'lwn,btt3' is not one of ['armadeus,imx27-apf27', 'fsl,imx27-pdk']
	'armadeus,imx27-apf27dev' was expected
	'eukrea,mbimxsd27-baseboard' was expected
	'phytec,imx27-pca100-rdk' was expected
	'phytec,imx27-pcm970' was expected
	'lwn,btt3' is not one of ['armadeus,imx28-apf28', 'bluegiga,apx4devkit', 'crystalfontz,cfa10036', 'eukrea,mbmx28lc', 'fsl,imx28-evk', 'i2se,duckbill', 'i2se,duckbill-2', 'karo,tx28', 'lwn,imx28-xea', 'msr,m28cu3', 'schulercontrol,imx28-sps1', 'technologic,imx28-ts4600']
	'aries,m28' was expected
	'aries,m28evk' was expected
	'armadeus,imx28-apf28dev' was expected
	'lwn,btt3' is not one of ['crystalfontz,cfa10037', 'crystalfontz,cfa10049', 'crystalfontz,cfa10057', 'crystalfontz,cfa10058']
	'lwn,btt3' is not one of ['crystalfontz,cfa10055', 'crystalfontz,cfa10056']
	'lwn,btt3' is not one of ['i2se,duckbill-2-485', 'i2se,duckbill-2-enocean', 'i2se,duckbill-2-spi']
	'eukrea,mbmx283lc' was expected
	'eukrea,mbmx287lc' was expected
	'lwn,btt3' is not one of ['buglabs,imx31-bug', 'logicpd,imx31-lite']
	'lwn,btt3' is not one of ['fsl,imx35-pdk']
	'eukrea,mbimxsd35-baseboard' was expected
	'lwn,btt3' is not one of ['fsl,imx50-evk', 'kobo,aura']
	'lwn,btt3' is not one of ['armadeus,imx51-apf51', 'fsl,imx51-babbage', 'technologic,imx51-ts4800', 'zii,imx51-scu3-esb', 'zii,imx51-scu2-mezz', 'zii,imx51-rdu1']
	'armadeus,imx51-apf51dev' was expected
	'digi,connectcore-ccxmx51-jsk' was expected
	'eukrea,mbimxsd51' was expected
	'lwn,btt3' is not one of ['bhf,cx9020', 'fsl,imx53-ard', 'fsl,imx53-evk', 'fsl,imx53-qsb', 'fsl,imx53-qsrb', 'fsl,imx53-smd', 'ge,imx53-cpuvo', 'inversepath,imx53-usbarmory', 'karo,tx53', 'kiebackpeter,imx53-ddc', 'kiebackpeter,imx53-hsc', 'menlo,m53menlo', 'starterkit,sk-imx53', 'voipac,imx53-dmm-668']
	'aries,imx53-m53evk' was expected
	'tq,mba53' was expected
	'lwn,btt3' is not one of ['auvidea,h100', 'bosch,imx6q-acc', 'boundary,imx6q-nitrogen6_max', 'boundary,imx6q-nitrogen6_som2', 'boundary,imx6q-nitrogen6x', 'compulab,cm-fx6', 'dmo,imx6q-edmqmx6', 'ds,imx6q-sbc', 'embest,imx6q-marsboard', 'emtrion,emcon-mx6', 'emtrion,emcon-mx6-avari', 'engicam,imx6-icore', 'engicam,imx6-icore-rqs', 'fsl,imx6q-arm2', 'fsl,imx6q-sabreauto', 'fsl,imx6q-sabrelite', 'fsl,imx6q-sabresd', 'karo,imx6q-tx6q', 'kiebackpeter,imx6q-tpc', 'kontron,imx6q-samx6i', 'kosagi,imx6q-novena', 'kvg,vicut1q', 'logicpd,imx6q-logicpd', 'lwn,display5', 'lwn,mccmon6', 'nutsboard,imx6q-pistachio', 'microsys,sbc6x', 'poslab,imx6q-savageboard', 'prt,prti6q', 'prt,prtwd2', 'rex,imx6q-rex-pro', 'skov,imx6q-skov-revc-lt2', 'skov,imx6q-skov-revc-lt6', 'skov,imx6q-skov-reve-mi1010ait-1cp1', 'solidrun,cubox-i/q', 'solidrun,hummingboard/q', 'solidrun,hummingboard2/q', 'solidrun,solidsense/q', 'tbs,imx6q-tbs2910', 'technexion,imx6q-pico-dwarf', 'technexion,imx6q-pico-hobbit', 'technexion
 ,imx6q-pico-nymph', 'technexion,imx6q-pico-pi', 'technologic,imx6q-ts4900', 'technologic,imx6q-ts7970', 'toradex,apalis_imx6q', 'udoo,imx6q-udoo', 'uniwest,imx6q-evi', 'variscite,dt6customboard', 'wand,imx6q-wandboard', 'ysoft,imx6q-yapp4-crux', 'ysoft,imx6q-yapp4-pegasus', 'zealz,imx6q-gk802', 'zii,imx6q-zii-rdu2']
	'lwn,btt3' is not one of ['advantech,imx6q-dms-ba16', 'ge,imx6q-b450v3', 'ge,imx6q-b650v3', 'ge,imx6q-b850v3']
	'armadeus,imx6q-apf6dev' was expected
	'compulab,utilite-pro' was expected
	'dfi,fs700-m60-6qd' was expected
	'dh,imx6q-dhcom-pdk2' was expected
	'lwn,btt3' is not one of ['gw,imx6q-gw51xx', 'gw,imx6q-gw52xx', 'gw,imx6q-gw53xx', 'gw,imx6q-gw5400-a', 'gw,imx6q-gw54xx', 'gw,imx6q-gw551x', 'gw,imx6q-gw552x', 'gw,imx6q-gw553x', 'gw,imx6q-gw560x', 'gw,imx6q-gw5903', 'gw,imx6q-gw5904', 'gw,imx6q-gw5907', 'gw,imx6q-gw5910', 'gw,imx6q-gw5912', 'gw,imx6q-gw5913']
	'kontron,imx6q-samx6i-ads2' was expected
	'lwn,btt3' is not one of ['phytec,imx6q-pbac06-emmc', 'phytec,imx6q-pbac06-nand']
	'phytec,imx6q-pbab01' was expected
	'lwn,btt3' is not one of ['toradex,apalis_imx6q-ixora', 'toradex,apalis_imx6q-ixora-v1.1', 'toradex,apalis_imx6q-ixora-v1.2', 'toradex,apalis_imx6q-eval', 'toradex,apalis_imx6q-eval-v1.2']
	'variscite,mx6customboard' was expected
	'tq,imx6q-mba6x-a' was expected
	'tq,imx6q-mba6x-b' was expected
	'lwn,btt3' is not one of ['boundary,imx6qp-nitrogen6_max', 'boundary,imx6qp-nitrogen6_som2', 'fsl,imx6qp-sabreauto', 'fsl,imx6qp-sabresd', 'karo,imx6qp-tx6qp', 'kvg,vicutp', 'prt,prtwd3', 'wand,imx6qp-wandboard', 'ysoft,imx6qp-yapp4-crux-plus', 'ysoft,imx6qp-yapp4-pegasus-plus', 'zii,imx6qp-zii-rdu2']
	'phytec,imx6qp-pbac06-nand' was expected
	'tq,imx6qp-mba6x-b' was expected
	'lwn,btt3' is not one of ['abb,aristainetos-imx6dl-4', 'abb,aristainetos-imx6dl-7', 'abb,aristainetos2-imx6dl-4', 'abb,aristainetos2-imx6dl-7', 'alt,alti6p', 'boundary,imx6dl-nit6xlite', 'boundary,imx6dl-nitrogen6x', 'bticino,imx6dl-mamoj', 'eckelmann,imx6dl-ci4x10', 'emtrion,emcon-mx6', 'emtrion,emcon-mx6-avari', 'engicam,imx6-icore', 'engicam,imx6-icore-rqs', 'fsl,imx6dl-sabreauto', 'fsl,imx6dl-sabrelite', 'fsl,imx6dl-sabresd', 'karo,imx6dl-tx6dl', 'kontron,imx6dl-samx6i', 'kvg,victgo', 'kvg,vicut1', 'ply,plybas', 'ply,plym2m', 'poslab,imx6dl-savageboard', 'prt,prtmvt', 'prt,prtrvt', 'prt,prtvt7', 'rex,imx6dl-rex-basic', 'riot,imx6s-riotboard', 'sielaff,imx6dl-board', 'skov,imx6dl-skov-revc-lt2', 'skov,imx6dl-skov-revc-lt6', 'solidrun,cubox-i/dl', 'solidrun,hummingboard/dl', 'solidrun,hummingboard2/dl', 'solidrun,solidsense/dl', 'technexion,imx6dl-pico-dwarf', 'technexion,imx6dl-pico-hobbit', 'technexion,imx6dl-pico-nymph', 'technexion,imx6dl-pico-pi', 'technologic,imx6dl-ts4900',
  'technologic,imx6dl-ts7970', 'toradex,colibri_imx6dl', 'udoo,imx6dl-udoo', 'vdl,lanmcu', 'wand,imx6dl-wandboard', 'ysoft,imx6dl-yapp4-draco', 'ysoft,imx6dl-yapp4-hydra', 'ysoft,imx6dl-yapp4-lynx', 'ysoft,imx6dl-yapp4-orion', 'ysoft,imx6dl-yapp4-phoenix', 'ysoft,imx6dl-yapp4-ursa']
	'armadeus,imx6dl-apf6dev' was expected
	'lwn,btt3' is not one of ['ge,imx6dl-b105v2', 'ge,imx6dl-b105pv2', 'ge,imx6dl-b125v2', 'ge,imx6dl-b125pv2', 'ge,imx6dl-b155v2']
	'dfi,fs700-m60-6dl' was expected
	'dh,imx6dl-dhcom-picoitx' was expected
	'lwn,btt3' is not one of ['gw,imx6dl-gw51xx', 'gw,imx6dl-gw52xx', 'gw,imx6dl-gw53xx', 'gw,imx6dl-gw54xx', 'gw,imx6dl-gw551x', 'gw,imx6dl-gw552x', 'gw,imx6dl-gw553x', 'gw,imx6dl-gw560x', 'gw,imx6dl-gw5903', 'gw,imx6dl-gw5904', 'gw,imx6dl-gw5907', 'gw,imx6dl-gw5910', 'gw,imx6dl-gw5912', 'gw,imx6dl-gw5913']
	'kontron,imx6dl-samx6i-ads2' was expected
	'lwn,btt3' is not one of ['phytec,imx6dl-pbac06-emmc', 'phytec,imx6dl-pbac06-nand']
	'phytec,imx6dl-pbab01' was expected
	'lwn,btt3' is not one of ['toradex,colibri_imx6dl-aster', 'toradex,colibri_imx6dl-eval-v3', 'toradex,colibri_imx6dl-iris', 'toradex,colibri_imx6dl-iris-v2']
	'dh,imx6s-dhcom-drc02' was expected
	'tq,imx6dl-mba6x-a' was expected
	'tq,imx6dl-mba6x-b' was expected
	'lwn,btt3' is not one of ['fsl,imx6sl-evk', 'kobo,aura2', 'kobo,tolino-shine2hd', 'kobo,tolino-shine3', 'kobo,tolino-vision', 'kobo,tolino-vision5', 'revotics,imx6sl-warp']
	'lwn,btt3' is not one of ['fsl,imx6sll-evk', 'kobo,clarahd', 'kobo,librah2o']
	'lwn,btt3' is not one of ['boundary,imx6sx-nitrogen6sx', 'fsl,imx6sx-sabreauto', 'fsl,imx6sx-sdb', 'fsl,imx6sx-sdb-reva', 'samtec,imx6sx-vining-2000', 'udoo,neobasic', 'udoo,neoextended', 'udoo,neofull']
	'lwn,btt3' is not one of ['engicam,imx6ul-geam', 'engicam,imx6ul-isiot', 'fsl,imx6ul-14x14-evk', 'karo,imx6ul-tx6ul', 'kontron,sl-imx6ul', 'prt,prti6g', 'technexion,imx6ul-pico-dwarf', 'technexion,imx6ul-pico-hobbit', 'technexion,imx6ul-pico-pi']
	'armadeus,imx6ul-opos6uldev' was expected
	'lwn,btt3' is not one of ['digi,ccimx6ulsbcexpress', 'digi,ccimx6ulsbcpro']
	'grinn,imx6ul-liteboard' was expected
	'lwn,btt3' is not one of ['phytec,imx6ul-pbacd10-emmc', 'phytec,imx6ul-pbacd10-nand']
	'kontron,bl-imx6ul' was expected
	'kontron,bl-imx6ul-43' was expected
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul1-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul2-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul2l-mba6ulx', 'tq,imx6ul-tqma6ul2l-mba6ulxl']
	'lwn,btt3' is not one of ['fsl,imx6ull-14x14-evk', 'joz,jozacp', 'kontron,sl-imx6ull', 'myir,imx6ull-mys-6ulx-eval', 'toradex,colibri-imx6ull', 'toradex,colibri-imx6ull-emmc', 'toradex,colibri-imx6ull-wifi', 'uni-t,uti260b']
	'armadeus,imx6ull-opos6uldev' was expected
	'lwn,btt3' is not one of ['chargebyte,imx6ull-tarragon-master', 'chargebyte,imx6ull-tarragon-micro', 'chargebyte,imx6ull-tarragon-slave', 'chargebyte,imx6ull-tarragon-slavext']
	'lwn,btt3' is not one of ['dh,imx6ull-dhcom-drc02', 'dh,imx6ull-dhcom-pdk2', 'dh,imx6ull-dhcom-picoitx']
	'marantec,imx6ull-dhcor-maveo-box' was expected
	'lwn,btt3' is not one of ['phytec,imx6ull-pbacd10-emmc', 'phytec,imx6ull-pbacd10-nand']
	'lwn,btt3' is not one of ['phytec,imx6ull-phygate-tauri-emmc', 'phytec,imx6ull-phygate-tauri-nand']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-aster', 'toradex,colibri-imx6ull-eval', 'toradex,colibri-imx6ull-iris', 'toradex,colibri-imx6ull-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-emmc-aster', 'toradex,colibri-imx6ull-emmc-eval', 'toradex,colibri-imx6ull-emmc-iris', 'toradex,colibri-imx6ull-emmc-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-wifi-eval', 'toradex,colibri-imx6ull-wifi-aster', 'toradex,colibri-imx6ull-wifi-iris', 'toradex,colibri-imx6ull-wifi-iris-v2']
	'kontron,bl-imx6ull' was expected
	'lwn,btt3' is not one of ['tq,imx6ull-tqma6ull2-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ull-tqma6ull2l-mba6ulx', 'tq,imx6ull-tqma6ull2l-mba6ulxl']
	'lwn,btt3' is not one of ['seeed,imx6ull-seeed-npi-emmc', 'seeed,imx6ull-seeed-npi-nand']
	'lwn,btt3' is not one of ['bsh,imx6ulz-bsh-smm-m2', 'fsl,imx6ulz-14x14-evk']
	'lwn,btt3' is not one of ['element14,imx7s-warp', 'toradex,colibri-imx7s']
	'lwn,btt3' is not one of ['toradex,colibri-imx7s-aster', 'toradex,colibri-imx7s-eval-v3', 'toradex,colibri-imx7s-iris', 'toradex,colibri-imx7s-iris-v2']
	'tq,imx7s-mba7' was expected
	'lwn,btt3' is not one of ['boundary,imx7d-nitrogen7', 'compulab,cl-som-imx7', 'fsl,imx7d-sdb', 'fsl,imx7d-sdb-reva', 'kam,imx7d-flex-concentrator', 'kam,imx7d-flex-concentrator-mfg', 'novtech,imx7d-meerkat96', 'remarkable,imx7d-remarkable2', 'storopack,imx7d-smegw01', 'technexion,imx7d-pico-dwarf', 'technexion,imx7d-pico-hobbit', 'technexion,imx7d-pico-nymph', 'technexion,imx7d-pico-pi', 'toradex,colibri-imx7d', 'toradex,colibri-imx7d-emmc', 'zii,imx7d-rmu2', 'zii,imx7d-rpu2']
	'tq,imx7d-mba7' was expected
	'compulab,sbc-imx7' was expected
	'lwn,btt3' is not one of ['toradex,colibri-imx7d-aster', 'toradex,colibri-imx7d-eval-v3', 'toradex,colibri-imx7d-iris', 'toradex,colibri-imx7d-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx7d-emmc-aster', 'toradex,colibri-imx7d-emmc-eval-v3', 'toradex,colibri-imx7d-emmc-iris', 'toradex,colibri-imx7d-emmc-iris-v2']
	'lwn,btt3' is not one of ['ea,imx7ulp-com', 'fsl,imx7ulp-evk']
	'lwn,btt3' is not one of ['beacon,imx8mm-beacon-kit', 'boundary,imx8mm-nitrogen8mm', 'dmo,imx8mm-data-modul-edm-sbc', 'emtrion,emcon-mx8mm-avari', 'fsl,imx8mm-ddr4-evk', 'fsl,imx8mm-evk', 'fsl,imx8mm-evkb', 'gateworks,imx8mm-gw7904', 'gateworks,imx8mm-gw7905-0x', 'gw,imx8mm-gw71xx-0x', 'gw,imx8mm-gw72xx-0x', 'gw,imx8mm-gw73xx-0x', 'gw,imx8mm-gw7901', 'gw,imx8mm-gw7902', 'gw,imx8mm-gw7903', 'innocomm,wb15-evk', 'kontron,imx8mm-sl', 'kontron,imx8mm-osm-s', 'toradex,verdin-imx8mm', 'toradex,verdin-imx8mm-nonwifi', 'toradex,verdin-imx8mm-wifi', 'variscite,var-som-mx8mm', 'prt,prt8mm']
	'lwn,btt3' is not one of ['compulab,imx8mm-iot-gateway']
	'ees,imx8mm-emtop-baseboard' was expected
	'lwn,btt3' is not one of ['engicam,icore-mx8mm-ctouch2', 'engicam,icore-mx8mm-edimm2.2']
	'kontron,imx8mm-bl' was expected
	'kontron,imx8mm-bl-osm-s' was expected
	'lwn,btt3' is not one of ['menlo,mx8menlo', 'toradex,verdin-imx8mm-nonwifi-dahlia', 'toradex,verdin-imx8mm-nonwifi-dev', 'toradex,verdin-imx8mm-nonwifi-mallow', 'toradex,verdin-imx8mm-nonwifi-yavia']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mm-wifi-dahlia', 'toradex,verdin-imx8mm-wifi-dev', 'toradex,verdin-imx8mm-wifi-mallow', 'toradex,verdin-imx8mm-wifi-yavia']
	'lwn,btt3' is not one of ['phytec,imx8mm-phyboard-polis-rdk', 'phytec,imx8mm-phygate-tauri-l']
	'variscite,var-som-mx8mm-symphony' was expected
	'lwn,btt3' is not one of ['cloos,imx8mm-phg', 'tq,imx8mm-tqma8mqml-mba8mx']
	'lwn,btt3' is not one of ['beacon,imx8mn-beacon-kit', 'bsh,imx8mn-bsh-smm-s2', 'bsh,imx8mn-bsh-smm-s2pro', 'fsl,imx8mn-ddr3l-evk', 'fsl,imx8mn-ddr4-evk', 'fsl,imx8mn-evk', 'gw,imx8mn-gw7902']
	'lwn,btt3' is not one of ['dimonoff,gateway-evk', 'rve,gateway', 'variscite,var-som-mx8mn-symphony']
	'lwn,btt3' is not one of ['tq,imx8mn-tqma8mqnl-mba8mx']
	'lwn,btt3' is not one of ['beacon,imx8mp-beacon-kit', 'dmo,imx8mp-data-modul-edm-sbc', 'emcraft,imx8mp-navqp', 'fsl,imx8mp-evk', 'gateworks,imx8mp-gw71xx-2x', 'gateworks,imx8mp-gw72xx-2x', 'gateworks,imx8mp-gw73xx-2x', 'gateworks,imx8mp-gw74xx', 'gateworks,imx8mp-gw7905-2x', 'skov,imx8mp-skov-revb-hdmi', 'skov,imx8mp-skov-revb-lt6', 'skov,imx8mp-skov-revb-mi1010ait-1cp1', 'toradex,verdin-imx8mp', 'toradex,verdin-imx8mp-nonwifi', 'toradex,verdin-imx8mp-wifi']
	'avnet,sm2s-imx8mp-14N0600E-ep1' was expected
	'lwn,btt3' is not one of ['dh,imx8mp-dhcom-pdk2', 'dh,imx8mp-dhcom-pdk3']
	'lwn,btt3' is not one of ['engicam,icore-mx8mp-edimm2.2']
	'phytec,imx8mp-phyboard-pollux-rdk' was expected
	'lwn,btt3' is not one of ['polyhex,imx8mp-debix-model-a']
	'lwn,btt3' is not one of ['polyhex,imx8mp-debix-som-a-bmb-08']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mp-nonwifi-dahlia', 'toradex,verdin-imx8mp-nonwifi-dev', 'toradex,verdin-imx8mp-nonwifi-mallow', 'toradex,verdin-imx8mp-nonwifi-yavia']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mp-wifi-dahlia', 'toradex,verdin-imx8mp-wifi-dev', 'toradex,verdin-imx8mp-wifi-mallow', 'toradex,verdin-imx8mp-wifi-yavia']
	'lwn,btt3' is not one of ['tq,imx8mp-tqma8mpql-mba8mpxl', 'tq,imx8mp-tqma8mpql-mba8mp-ras314']
	'lwn,btt3' is not one of ['boundary,imx8mq-nitrogen8m', 'boundary,imx8mq-nitrogen8m-som', 'einfochips,imx8mq-thor96', 'fsl,imx8mq-evk', 'google,imx8mq-phanbell', 'kontron,pitx-imx8m', 'purism,librem5-devkit', 'solidrun,hummingboard-pulse', 'technexion,pico-pi-imx8m']
	'mntre,reform2' was expected
	'lwn,btt3' is not one of ['purism,librem5r2', 'purism,librem5r3', 'purism,librem5r4']
	'lwn,btt3' is not one of ['tq,imx8mq-tqma8mq-mba8mx']
	'lwn,btt3' is not one of ['zii,imx8mq-ultra-rmb3', 'zii,imx8mq-ultra-zest']
	'lwn,btt3' is not one of ['fsl,imx8qm-mek', 'toradex,apalis-imx8', 'toradex,apalis-imx8-v1.1']
	'lwn,btt3' is not one of ['toradex,apalis-imx8-eval', 'toradex,apalis-imx8-eval-v1.2', 'toradex,apalis-imx8-ixora-v1.1']
	'lwn,btt3' is not one of ['toradex,apalis-imx8-v1.1-eval', 'toradex,apalis-imx8-v1.1-eval-v1.2', 'toradex,apalis-imx8-v1.1-ixora-v1.1', 'toradex,apalis-imx8-v1.1-ixora-v1.2']
	'lwn,btt3' is not one of ['einfochips,imx8qxp-ai_ml', 'fsl,imx8qxp-mek']
	'lwn,btt3' is not one of ['fsl,imx8dxl-evk']
	'lwn,btt3' is not one of ['toradex,colibri-imx8x-aster', 'toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x-iris', 'toradex,colibri-imx8x-iris-v2']
	'lwn,btt3' is not one of ['fsl,imx8ulp-evk']
	'lwn,btt3' is not one of ['fsl,imx93-9x9-qsb', 'fsl,imx93-11x11-evk', 'fsl,imx93-14x14-evk']
	'lwn,btt3' is not one of ['fsl,imx95-19x19-evk']
	'lwn,btt3' is not one of ['fsl,imxrt1050-evk']
	'lwn,btt3' is not one of ['fsl,imxrt1170-evk']
	'lwn,btt3' is not one of ['tq,imx93-tqma9352-mba93xxca', 'tq,imx93-tqma9352-mba93xxla']
	'phytec,imx93-phyboard-segin' was expected
	'variscite,var-som-mx93-symphony' was expected
	'lwn,btt3' is not one of ['fsl,vf500', 'fsl,vf510', 'fsl,vf600', 'fsl,vf610', 'fsl,vf610m4']
	'toradex,vf500-colibri_vf50-on-eval' was expected
	'lwn,btt3' is not one of ['fsl,vf610-twr', 'lwn,bk4', 'phytec,vf610-cosmic', 'toradex,vf610-colibri_vf61']
	'toradex,vf610-colibri_vf61-on-eval' was expected
	'lwn,btt3' is not one of ['zii,vf610cfu1', 'zii,vf610dev-c', 'zii,vf610dev-b', 'zii,vf610scu4-aib', 'zii,vf610dtu', 'zii,vf610spu3', 'zii,vf610spb4']
	'lwn,btt3' is not one of ['ebs-systart,oxalis', 'fsl,ls1012a-rdb', 'fsl,ls1012a-frdm', 'fsl,ls1012a-frwy', 'fsl,ls1012a-qds']
	'lwn,btt3' is not one of ['fsl,ls1021a-iot', 'fsl,ls1021a-moxa-uc-8410a', 'fsl,ls1021a-qds', 'fsl,ls1021a-tsn', 'fsl,ls1021a-twr']
	'lwn,btt3' is not one of ['tq,ls1021a-tqmls1021a-mbls102xa']
	'lwn,btt3' is not one of ['fsl,ls1028a-qds', 'fsl,ls1028a-rdb']
	'kontron,kbox-a-230-ls' was expected
	'lwn,btt3' is not one of ['kontron,sl28-var1-ads2', 'kontron,sl28-var2-ads2', 'kontron,sl28-var3-ads2', 'kontron,sl28-var4-ads2']
	'lwn,btt3' is not one of ['kontron,sl28-var1', 'kontron,sl28-var2', 'kontron,sl28-var3', 'kontron,sl28-var4']
	'kontron,sl28' was expected
	'lwn,btt3' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']
	'lwn,btt3' is not one of ['tq,ls1043a-tqmls1043a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls1046a-frwy', 'fsl,ls1046a-qds', 'fsl,ls1046a-rdb']
	'lwn,btt3' is not one of ['tq,ls1046a-tqmls1046a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls1088a-qds', 'fsl,ls1088a-rdb']
	'lwn,btt3' is not one of ['tq,ls1088a-tqmls1088a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls2080a-simu', 'fsl,ls2080a-qds', 'fsl,ls2080a-rdb']
	'lwn,btt3' is not one of ['fsl,ls2088a-qds', 'fsl,ls2088a-rdb']
	'lwn,btt3' is not one of ['fsl,lx2160a-bluebox3', 'fsl,lx2160a-bluebox3-rev-a', 'fsl,lx2160a-qds', 'fsl,lx2160a-rdb', 'fsl,lx2162a-qds']
	'lwn,btt3' is not one of ['solidrun,clearfog-cx', 'solidrun,honeycomb']
	'lwn,btt3' is not one of ['solidrun,lx2162a-clearfog']
	'lwn,btt3' is not one of ['tq,lx2160a-tqmlx2160a-mblx2160a']
	'lwn,btt3' is not one of ['nxp,s32g274a-evb', 'nxp,s32g274a-rdb2']
	'lwn,btt3' is not one of ['nxp,s32g399a-rdb3']
	'lwn,btt3' is not one of ['fsl,s32v234-evb']
	'lwn,btt3' is not one of ['traverse,ten64']
	'fsl,imx1' was expected
	'fsl,imx23' was expected
	'fsl,imx25' was expected
	'eukrea,cpuimx25' was expected
	'eukrea,mbimxsd25-baseboard' was expected
	'fsl,imx27' was expected
	'armadeus,imx27-apf27' was expected
	'eukrea,cpuimx27' was expected
	'phytec,imx27-pca100' was expected
	'phytec,imx27-pcm038' was expected
	'denx,m28' was expected
	'denx,m28evk' was expected
	'armadeus,imx28-apf28' was expected
	'crystalfontz,cfa10036' was expected
	'crystalfontz,cfa10037' was expected
	'i2se,duckbill-2' was expected
	'eukrea,mbmx28lc' was expected
	'fsl,imx31' was expected
	'fsl,imx35' was expected
	'eukrea,cpuimx35' was expected
	'fsl,imx50' was expected
	'fsl,imx51' was expected
	'armadeus,imx51-apf51' was expected
	'digi,connectcore-ccxmx51-som' was expected
	'eukrea,cpuimx51' was expected
	'fsl,imx53' was expected
	'denx,imx53-m53evk' was expected
	'tq,tqma53' was expected
	'fsl,imx6q' was expected
	'advantech,imx6q-ba16' was expected
	'armadeus,imx6q-apf6' was expected
	'compulab,cm-fx6' was expected
	'dfi,fs700e-m60' was expected
	'dh,imx6q-dhcom-som' was expected
	'gw,ventana' was expected
	'kontron,imx6q-samx6i' was expected
	'phytec,imx6q-pbac06' was expected
	'phytec,imx6q-pfla02' was expected
	'toradex,apalis_imx6q' was expected
	'variscite,var-som-imx6q' was expected
	'tq,mba6a' was expected
	'tq,mba6b' was expected
	'fsl,imx6qp' was expected
	'phytec,imx6qp-pbac06' was expected
	'fsl,imx6dl' was expected
	'armadeus,imx6dl-apf6' was expected
	'congatec,qmx6' was expected
	'dh,imx6dl-dhcom-som' was expected
	'kontron,imx6dl-samx6i' was expected
	'phytec,imx6dl-pbac06' was expected
	'phytec,imx6dl-pfla02' was expected
	'toradex,colibri_imx6dl' was expected
	'dh,imx6s-dhcom-som' was expected
	'fsl,imx6sl' was expected
	'fsl,imx6sll' was expected
	'fsl,imx6sx' was expected
	'fsl,imx6ul' was expected
	'armadeus,imx6ul-opos6ul' was expected
	'digi,ccimx6ulsom' was expected
	'grinn,imx6ul-litesom' was expected
	'phytec,imx6ul-pbacd10' was expected
	'kontron,sl-imx6ul' was expected
	'tq,imx6ul-tqma6ul1' was expected
	'tq,imx6ul-tqma6ul2' was expected
	'tq,imx6ul-tqma6ul2l' was expected
	'fsl,imx6ull' was expected
	'armadeus,imx6ull-opos6ul' was expected
	'dh,imx6ull-dhcom-som' was expected
	'dh,imx6ull-dhcor-som' was expected
	'phytec,imx6ull-pbacd10' was expected
	'phytec,imx6ull-phygate-tauri' was expected
	'toradex,colibri-imx6ull' was expected
	'toradex,colibri-imx6ull-emmc' was expected
	'toradex,colibri-imx6ull-wifi' was expected
	'kontron,sl-imx6ull' was expected
	'tq,imx6ull-tqma6ull2' was expected
	'tq,imx6ull-tqma6ull2l' was expected
	'seeed,imx6ull-seeed-npi' was expected
	'fsl,imx7s' was expected
	'toradex,colibri-imx7s' was expected
	'tq,imx7s-tqma7' was expected
	'fsl,imx7d' was expected
	'tq,imx7d-tqma7' was expected
	'compulab,cl-som-imx7' was expected
	'toradex,colibri-imx7d' was expected
	'toradex,colibri-imx7d-emmc' was expected
	'fsl,imx7ulp' was expected
	'fsl,imx8mm' was expected
	'compulab,imx8mm-ucm-som' was expected
	'ees,imx8mm-emtop-som' was expected
	'engicam,icore-mx8mm' was expected
	'kontron,imx8mm-sl' was expected
	'kontron,imx8mm-osm-s' was expected
	'toradex,verdin-imx8mm-nonwifi' was expected
	'toradex,verdin-imx8mm-wifi' was expected
	'phytec,imx8mm-phycore-som' was expected
	'variscite,var-som-mx8mm' was expected
	'tq,imx8mm-tqma8mqml' was expected
	'fsl,imx8mn' was expected
	'variscite,var-som-mx8mn' was expected
	'tq,imx8mn-tqma8mqnl' was expected
	'fsl,imx8mp' was expected
	'avnet,sm2s-imx8mp-14N0600E' was expected
	'dh,imx8mp-dhcom-som' was expected
	'engicam,icore-mx8mp' was expected
	'phytec,imx8mp-phycore-som' was expected
	'polyhex,imx8mp-debix' was expected
	'polyhex,imx8mp-debix-som-a' was expected
	'toradex,verdin-imx8mp-nonwifi' was expected
	'toradex,verdin-imx8mp-wifi' was expected
	'tq,imx8mp-tqma8mpql' was expected
	'fsl,imx8mq' was expected
	'boundary,imx8mq-nitrogen8m-som' was expected
	'purism,librem5' was expected
	'tq,imx8mq-tqma8mq' was expected
	'zii,imx8mq-ultra' was expected
	'fsl,imx8qm' was expected
	'toradex,apalis-imx8' was expected
	'toradex,apalis-imx8-v1.1' was expected
	'fsl,imx8qxp' was expected
	'fsl,imx8dxl' was expected
	'toradex,colibri-imx8x' was expected
	'fsl,imx8ulp' was expected
	'fsl,imx93' was expected
	'fsl,imx95' was expected
	'fsl,imxrt1050' was expected
	'fsl,imxrt1170' was expected
	'tq,imx93-tqma9352' was expected
	'phytec,imx93-phycore-som' was expected
	'variscite,var-som-mx93' was expected
	'toradex,vf500-colibri_vf50' was expected
	'fsl,vf610' was expected
	'toradex,vf610-colibri_vf61' was expected
	'zii,vf610dev' was expected
	'fsl,ls1012a' was expected
	'fsl,ls1021a' was expected
	'tq,ls1021a-tqmls1021a' was expected
	'fsl,ls1028a' was expected
	'kontron,sl28-var4' was expected
	'fsl,imx28' is not one of ['kontron,sl28-var1', 'kontron,sl28-var2', 'kontron,sl28-var3', 'kontron,sl28-var4']
	'fsl,ls1043a' was expected
	'tq,ls1043a-tqmls1043a' was expected
	'fsl,ls1046a' was expected
	'tq,ls1046a-tqmls1046a' was expected
	'fsl,ls1088a' was expected
	'tq,ls1088a-tqmls1088a' was expected
	'fsl,ls2080a' was expected
	'fsl,ls2088a' was expected
	'fsl,lx2160a' was expected
	'solidrun,lx2160a-cex7' was expected
	'solidrun,lx2162a-som' was expected
	'tq,lx2160a-tqmlx2160a' was expected
	'nxp,s32g2' was expected
	'nxp,s32g3' was expected
	'fsl,s32v234' was expected
	from schema $id: http://devicetree.org/schemas/arm/fsl.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['lwn,btt3', 'fsl,imx28'] is too short
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
		['lwn,btt3', 'fsl,imx28'] is too short
		'lwn,btt3' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
		'lwn,btt3' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
		'tq,imx8dxp-tqma8xdp' was expected
		'tq,imx8qxp-tqma8xqp' was expected
	['lwn,btt3', 'fsl,imx28'] is too long
	'lwn,btt3' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
	'lwn,btt3' is not one of ['creative,x-fi3', 'fsl,imx23-evk', 'fsl,stmp378x-devb', 'olimex,imx23-olinuxino', 'sandisk,sansa_fuze_plus']
	'lwn,btt3' is not one of ['fsl,imx25-pdk', 'karo,imx25-tx25']
	'lwn,btt3' is not one of ['eukrea,mbimxsd25-baseboard']
	'lwn,btt3' is not one of ['eukrea,mbimxsd25-baseboard-cmo-qvga', 'eukrea,mbimxsd25-baseboard-dvi-svga', 'eukrea,mbimxsd25-baseboard-dvi-vga']
	'lwn,btt3' is not one of ['armadeus,imx27-apf27', 'fsl,imx27-pdk']
	'armadeus,imx27-apf27dev' was expected
	'eukrea,mbimxsd27-baseboard' was expected
	'phytec,imx27-pca100-rdk' was expected
	'phytec,imx27-pcm970' was expected
	'lwn,btt3' is not one of ['armadeus,imx28-apf28', 'bluegiga,apx4devkit', 'crystalfontz,cfa10036', 'eukrea,mbmx28lc', 'fsl,imx28-evk', 'i2se,duckbill', 'i2se,duckbill-2', 'karo,tx28', 'lwn,imx28-xea', 'msr,m28cu3', 'schulercontrol,imx28-sps1', 'technologic,imx28-ts4600']
	'aries,m28' was expected
	'aries,m28evk' was expected
	'armadeus,imx28-apf28dev' was expected
	'lwn,btt3' is not one of ['crystalfontz,cfa10037', 'crystalfontz,cfa10049', 'crystalfontz,cfa10057', 'crystalfontz,cfa10058']
	'lwn,btt3' is not one of ['crystalfontz,cfa10055', 'crystalfontz,cfa10056']
	'lwn,btt3' is not one of ['i2se,duckbill-2-485', 'i2se,duckbill-2-enocean', 'i2se,duckbill-2-spi']
	'eukrea,mbmx283lc' was expected
	'eukrea,mbmx287lc' was expected
	'lwn,btt3' is not one of ['buglabs,imx31-bug', 'logicpd,imx31-lite']
	'lwn,btt3' is not one of ['fsl,imx35-pdk']
	'eukrea,mbimxsd35-baseboard' was expected
	'lwn,btt3' is not one of ['fsl,imx50-evk', 'kobo,aura']
	'lwn,btt3' is not one of ['armadeus,imx51-apf51', 'fsl,imx51-babbage', 'technologic,imx51-ts4800', 'zii,imx51-scu3-esb', 'zii,imx51-scu2-mezz', 'zii,imx51-rdu1']
	'armadeus,imx51-apf51dev' was expected
	'digi,connectcore-ccxmx51-jsk' was expected
	'eukrea,mbimxsd51' was expected
	'lwn,btt3' is not one of ['bhf,cx9020', 'fsl,imx53-ard', 'fsl,imx53-evk', 'fsl,imx53-qsb', 'fsl,imx53-qsrb', 'fsl,imx53-smd', 'ge,imx53-cpuvo', 'inversepath,imx53-usbarmory', 'karo,tx53', 'kiebackpeter,imx53-ddc', 'kiebackpeter,imx53-hsc', 'menlo,m53menlo', 'starterkit,sk-imx53', 'voipac,imx53-dmm-668']
	'aries,imx53-m53evk' was expected
	'tq,mba53' was expected
	'lwn,btt3' is not one of ['auvidea,h100', 'bosch,imx6q-acc', 'boundary,imx6q-nitrogen6_max', 'boundary,imx6q-nitrogen6_som2', 'boundary,imx6q-nitrogen6x', 'compulab,cm-fx6', 'dmo,imx6q-edmqmx6', 'ds,imx6q-sbc', 'embest,imx6q-marsboard', 'emtrion,emcon-mx6', 'emtrion,emcon-mx6-avari', 'engicam,imx6-icore', 'engicam,imx6-icore-rqs', 'fsl,imx6q-arm2', 'fsl,imx6q-sabreauto', 'fsl,imx6q-sabrelite', 'fsl,imx6q-sabresd', 'karo,imx6q-tx6q', 'kiebackpeter,imx6q-tpc', 'kontron,imx6q-samx6i', 'kosagi,imx6q-novena', 'kvg,vicut1q', 'logicpd,imx6q-logicpd', 'lwn,display5', 'lwn,mccmon6', 'nutsboard,imx6q-pistachio', 'microsys,sbc6x', 'poslab,imx6q-savageboard', 'prt,prti6q', 'prt,prtwd2', 'rex,imx6q-rex-pro', 'skov,imx6q-skov-revc-lt2', 'skov,imx6q-skov-revc-lt6', 'skov,imx6q-skov-reve-mi1010ait-1cp1', 'solidrun,cubox-i/q', 'solidrun,hummingboard/q', 'solidrun,hummingboard2/q', 'solidrun,solidsense/q', 'tbs,imx6q-tbs2910', 'technexion,imx6q-pico-dwarf', 'technexion,imx6q-pico-hobbit', 'technexion
 ,imx6q-pico-nymph', 'technexion,imx6q-pico-pi', 'technologic,imx6q-ts4900', 'technologic,imx6q-ts7970', 'toradex,apalis_imx6q', 'udoo,imx6q-udoo', 'uniwest,imx6q-evi', 'variscite,dt6customboard', 'wand,imx6q-wandboard', 'ysoft,imx6q-yapp4-crux', 'ysoft,imx6q-yapp4-pegasus', 'zealz,imx6q-gk802', 'zii,imx6q-zii-rdu2']
	'lwn,btt3' is not one of ['advantech,imx6q-dms-ba16', 'ge,imx6q-b450v3', 'ge,imx6q-b650v3', 'ge,imx6q-b850v3']
	'armadeus,imx6q-apf6dev' was expected
	'compulab,utilite-pro' was expected
	'dfi,fs700-m60-6qd' was expected
	'dh,imx6q-dhcom-pdk2' was expected
	'lwn,btt3' is not one of ['gw,imx6q-gw51xx', 'gw,imx6q-gw52xx', 'gw,imx6q-gw53xx', 'gw,imx6q-gw5400-a', 'gw,imx6q-gw54xx', 'gw,imx6q-gw551x', 'gw,imx6q-gw552x', 'gw,imx6q-gw553x', 'gw,imx6q-gw560x', 'gw,imx6q-gw5903', 'gw,imx6q-gw5904', 'gw,imx6q-gw5907', 'gw,imx6q-gw5910', 'gw,imx6q-gw5912', 'gw,imx6q-gw5913']
	'kontron,imx6q-samx6i-ads2' was expected
	'lwn,btt3' is not one of ['phytec,imx6q-pbac06-emmc', 'phytec,imx6q-pbac06-nand']
	'phytec,imx6q-pbab01' was expected
	'lwn,btt3' is not one of ['toradex,apalis_imx6q-ixora', 'toradex,apalis_imx6q-ixora-v1.1', 'toradex,apalis_imx6q-ixora-v1.2', 'toradex,apalis_imx6q-eval', 'toradex,apalis_imx6q-eval-v1.2']
	'variscite,mx6customboard' was expected
	'tq,imx6q-mba6x-a' was expected
	'tq,imx6q-mba6x-b' was expected
	'lwn,btt3' is not one of ['boundary,imx6qp-nitrogen6_max', 'boundary,imx6qp-nitrogen6_som2', 'fsl,imx6qp-sabreauto', 'fsl,imx6qp-sabresd', 'karo,imx6qp-tx6qp', 'kvg,vicutp', 'prt,prtwd3', 'wand,imx6qp-wandboard', 'ysoft,imx6qp-yapp4-crux-plus', 'ysoft,imx6qp-yapp4-pegasus-plus', 'zii,imx6qp-zii-rdu2']
	'phytec,imx6qp-pbac06-nand' was expected
	'tq,imx6qp-mba6x-b' was expected
	'lwn,btt3' is not one of ['abb,aristainetos-imx6dl-4', 'abb,aristainetos-imx6dl-7', 'abb,aristainetos2-imx6dl-4', 'abb,aristainetos2-imx6dl-7', 'alt,alti6p', 'boundary,imx6dl-nit6xlite', 'boundary,imx6dl-nitrogen6x', 'bticino,imx6dl-mamoj', 'eckelmann,imx6dl-ci4x10', 'emtrion,emcon-mx6', 'emtrion,emcon-mx6-avari', 'engicam,imx6-icore', 'engicam,imx6-icore-rqs', 'fsl,imx6dl-sabreauto', 'fsl,imx6dl-sabrelite', 'fsl,imx6dl-sabresd', 'karo,imx6dl-tx6dl', 'kontron,imx6dl-samx6i', 'kvg,victgo', 'kvg,vicut1', 'ply,plybas', 'ply,plym2m', 'poslab,imx6dl-savageboard', 'prt,prtmvt', 'prt,prtrvt', 'prt,prtvt7', 'rex,imx6dl-rex-basic', 'riot,imx6s-riotboard', 'sielaff,imx6dl-board', 'skov,imx6dl-skov-revc-lt2', 'skov,imx6dl-skov-revc-lt6', 'solidrun,cubox-i/dl', 'solidrun,hummingboard/dl', 'solidrun,hummingboard2/dl', 'solidrun,solidsense/dl', 'technexion,imx6dl-pico-dwarf', 'technexion,imx6dl-pico-hobbit', 'technexion,imx6dl-pico-nymph', 'technexion,imx6dl-pico-pi', 'technologic,imx6dl-ts4900',
  'technologic,imx6dl-ts7970', 'toradex,colibri_imx6dl', 'udoo,imx6dl-udoo', 'vdl,lanmcu', 'wand,imx6dl-wandboard', 'ysoft,imx6dl-yapp4-draco', 'ysoft,imx6dl-yapp4-hydra', 'ysoft,imx6dl-yapp4-lynx', 'ysoft,imx6dl-yapp4-orion', 'ysoft,imx6dl-yapp4-phoenix', 'ysoft,imx6dl-yapp4-ursa']
	'armadeus,imx6dl-apf6dev' was expected
	'lwn,btt3' is not one of ['ge,imx6dl-b105v2', 'ge,imx6dl-b105pv2', 'ge,imx6dl-b125v2', 'ge,imx6dl-b125pv2', 'ge,imx6dl-b155v2']
	'dfi,fs700-m60-6dl' was expected
	'dh,imx6dl-dhcom-picoitx' was expected
	'lwn,btt3' is not one of ['gw,imx6dl-gw51xx', 'gw,imx6dl-gw52xx', 'gw,imx6dl-gw53xx', 'gw,imx6dl-gw54xx', 'gw,imx6dl-gw551x', 'gw,imx6dl-gw552x', 'gw,imx6dl-gw553x', 'gw,imx6dl-gw560x', 'gw,imx6dl-gw5903', 'gw,imx6dl-gw5904', 'gw,imx6dl-gw5907', 'gw,imx6dl-gw5910', 'gw,imx6dl-gw5912', 'gw,imx6dl-gw5913']
	'kontron,imx6dl-samx6i-ads2' was expected
	'lwn,btt3' is not one of ['phytec,imx6dl-pbac06-emmc', 'phytec,imx6dl-pbac06-nand']
	'phytec,imx6dl-pbab01' was expected
	'lwn,btt3' is not one of ['toradex,colibri_imx6dl-aster', 'toradex,colibri_imx6dl-eval-v3', 'toradex,colibri_imx6dl-iris', 'toradex,colibri_imx6dl-iris-v2']
	'dh,imx6s-dhcom-drc02' was expected
	'tq,imx6dl-mba6x-a' was expected
	'tq,imx6dl-mba6x-b' was expected
	'lwn,btt3' is not one of ['fsl,imx6sl-evk', 'kobo,aura2', 'kobo,tolino-shine2hd', 'kobo,tolino-shine3', 'kobo,tolino-vision', 'kobo,tolino-vision5', 'revotics,imx6sl-warp']
	'lwn,btt3' is not one of ['fsl,imx6sll-evk', 'kobo,clarahd', 'kobo,librah2o']
	'lwn,btt3' is not one of ['boundary,imx6sx-nitrogen6sx', 'fsl,imx6sx-sabreauto', 'fsl,imx6sx-sdb', 'fsl,imx6sx-sdb-reva', 'samtec,imx6sx-vining-2000', 'udoo,neobasic', 'udoo,neoextended', 'udoo,neofull']
	'lwn,btt3' is not one of ['engicam,imx6ul-geam', 'engicam,imx6ul-isiot', 'fsl,imx6ul-14x14-evk', 'karo,imx6ul-tx6ul', 'kontron,sl-imx6ul', 'prt,prti6g', 'technexion,imx6ul-pico-dwarf', 'technexion,imx6ul-pico-hobbit', 'technexion,imx6ul-pico-pi']
	'armadeus,imx6ul-opos6uldev' was expected
	'lwn,btt3' is not one of ['digi,ccimx6ulsbcexpress', 'digi,ccimx6ulsbcpro']
	'grinn,imx6ul-liteboard' was expected
	'lwn,btt3' is not one of ['phytec,imx6ul-pbacd10-emmc', 'phytec,imx6ul-pbacd10-nand']
	'kontron,bl-imx6ul' was expected
	'kontron,bl-imx6ul-43' was expected
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul1-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul2-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ul-tqma6ul2l-mba6ulx', 'tq,imx6ul-tqma6ul2l-mba6ulxl']
	'lwn,btt3' is not one of ['fsl,imx6ull-14x14-evk', 'joz,jozacp', 'kontron,sl-imx6ull', 'myir,imx6ull-mys-6ulx-eval', 'toradex,colibri-imx6ull', 'toradex,colibri-imx6ull-emmc', 'toradex,colibri-imx6ull-wifi', 'uni-t,uti260b']
	'armadeus,imx6ull-opos6uldev' was expected
	'lwn,btt3' is not one of ['chargebyte,imx6ull-tarragon-master', 'chargebyte,imx6ull-tarragon-micro', 'chargebyte,imx6ull-tarragon-slave', 'chargebyte,imx6ull-tarragon-slavext']
	'lwn,btt3' is not one of ['dh,imx6ull-dhcom-drc02', 'dh,imx6ull-dhcom-pdk2', 'dh,imx6ull-dhcom-picoitx']
	'marantec,imx6ull-dhcor-maveo-box' was expected
	'lwn,btt3' is not one of ['phytec,imx6ull-pbacd10-emmc', 'phytec,imx6ull-pbacd10-nand']
	'lwn,btt3' is not one of ['phytec,imx6ull-phygate-tauri-emmc', 'phytec,imx6ull-phygate-tauri-nand']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-aster', 'toradex,colibri-imx6ull-eval', 'toradex,colibri-imx6ull-iris', 'toradex,colibri-imx6ull-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-emmc-aster', 'toradex,colibri-imx6ull-emmc-eval', 'toradex,colibri-imx6ull-emmc-iris', 'toradex,colibri-imx6ull-emmc-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx6ull-wifi-eval', 'toradex,colibri-imx6ull-wifi-aster', 'toradex,colibri-imx6ull-wifi-iris', 'toradex,colibri-imx6ull-wifi-iris-v2']
	'kontron,bl-imx6ull' was expected
	'lwn,btt3' is not one of ['tq,imx6ull-tqma6ull2-mba6ulx']
	'lwn,btt3' is not one of ['tq,imx6ull-tqma6ull2l-mba6ulx', 'tq,imx6ull-tqma6ull2l-mba6ulxl']
	'lwn,btt3' is not one of ['seeed,imx6ull-seeed-npi-emmc', 'seeed,imx6ull-seeed-npi-nand']
	'lwn,btt3' is not one of ['bsh,imx6ulz-bsh-smm-m2', 'fsl,imx6ulz-14x14-evk']
	'lwn,btt3' is not one of ['element14,imx7s-warp', 'toradex,colibri-imx7s']
	'lwn,btt3' is not one of ['toradex,colibri-imx7s-aster', 'toradex,colibri-imx7s-eval-v3', 'toradex,colibri-imx7s-iris', 'toradex,colibri-imx7s-iris-v2']
	'tq,imx7s-mba7' was expected
	'lwn,btt3' is not one of ['boundary,imx7d-nitrogen7', 'compulab,cl-som-imx7', 'fsl,imx7d-sdb', 'fsl,imx7d-sdb-reva', 'kam,imx7d-flex-concentrator', 'kam,imx7d-flex-concentrator-mfg', 'novtech,imx7d-meerkat96', 'remarkable,imx7d-remarkable2', 'storopack,imx7d-smegw01', 'technexion,imx7d-pico-dwarf', 'technexion,imx7d-pico-hobbit', 'technexion,imx7d-pico-nymph', 'technexion,imx7d-pico-pi', 'toradex,colibri-imx7d', 'toradex,colibri-imx7d-emmc', 'zii,imx7d-rmu2', 'zii,imx7d-rpu2']
	'tq,imx7d-mba7' was expected
	'compulab,sbc-imx7' was expected
	'lwn,btt3' is not one of ['toradex,colibri-imx7d-aster', 'toradex,colibri-imx7d-eval-v3', 'toradex,colibri-imx7d-iris', 'toradex,colibri-imx7d-iris-v2']
	'lwn,btt3' is not one of ['toradex,colibri-imx7d-emmc-aster', 'toradex,colibri-imx7d-emmc-eval-v3', 'toradex,colibri-imx7d-emmc-iris', 'toradex,colibri-imx7d-emmc-iris-v2']
	'lwn,btt3' is not one of ['ea,imx7ulp-com', 'fsl,imx7ulp-evk']
	'lwn,btt3' is not one of ['beacon,imx8mm-beacon-kit', 'boundary,imx8mm-nitrogen8mm', 'dmo,imx8mm-data-modul-edm-sbc', 'emtrion,emcon-mx8mm-avari', 'fsl,imx8mm-ddr4-evk', 'fsl,imx8mm-evk', 'fsl,imx8mm-evkb', 'gateworks,imx8mm-gw7904', 'gateworks,imx8mm-gw7905-0x', 'gw,imx8mm-gw71xx-0x', 'gw,imx8mm-gw72xx-0x', 'gw,imx8mm-gw73xx-0x', 'gw,imx8mm-gw7901', 'gw,imx8mm-gw7902', 'gw,imx8mm-gw7903', 'innocomm,wb15-evk', 'kontron,imx8mm-sl', 'kontron,imx8mm-osm-s', 'toradex,verdin-imx8mm', 'toradex,verdin-imx8mm-nonwifi', 'toradex,verdin-imx8mm-wifi', 'variscite,var-som-mx8mm', 'prt,prt8mm']
	'lwn,btt3' is not one of ['compulab,imx8mm-iot-gateway']
	'ees,imx8mm-emtop-baseboard' was expected
	'lwn,btt3' is not one of ['engicam,icore-mx8mm-ctouch2', 'engicam,icore-mx8mm-edimm2.2']
	'kontron,imx8mm-bl' was expected
	'kontron,imx8mm-bl-osm-s' was expected
	'lwn,btt3' is not one of ['menlo,mx8menlo', 'toradex,verdin-imx8mm-nonwifi-dahlia', 'toradex,verdin-imx8mm-nonwifi-dev', 'toradex,verdin-imx8mm-nonwifi-mallow', 'toradex,verdin-imx8mm-nonwifi-yavia']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mm-wifi-dahlia', 'toradex,verdin-imx8mm-wifi-dev', 'toradex,verdin-imx8mm-wifi-mallow', 'toradex,verdin-imx8mm-wifi-yavia']
	'lwn,btt3' is not one of ['phytec,imx8mm-phyboard-polis-rdk', 'phytec,imx8mm-phygate-tauri-l']
	'variscite,var-som-mx8mm-symphony' was expected
	'lwn,btt3' is not one of ['cloos,imx8mm-phg', 'tq,imx8mm-tqma8mqml-mba8mx']
	'lwn,btt3' is not one of ['beacon,imx8mn-beacon-kit', 'bsh,imx8mn-bsh-smm-s2', 'bsh,imx8mn-bsh-smm-s2pro', 'fsl,imx8mn-ddr3l-evk', 'fsl,imx8mn-ddr4-evk', 'fsl,imx8mn-evk', 'gw,imx8mn-gw7902']
	'lwn,btt3' is not one of ['dimonoff,gateway-evk', 'rve,gateway', 'variscite,var-som-mx8mn-symphony']
	'lwn,btt3' is not one of ['tq,imx8mn-tqma8mqnl-mba8mx']
	'lwn,btt3' is not one of ['beacon,imx8mp-beacon-kit', 'dmo,imx8mp-data-modul-edm-sbc', 'emcraft,imx8mp-navqp', 'fsl,imx8mp-evk', 'gateworks,imx8mp-gw71xx-2x', 'gateworks,imx8mp-gw72xx-2x', 'gateworks,imx8mp-gw73xx-2x', 'gateworks,imx8mp-gw74xx', 'gateworks,imx8mp-gw7905-2x', 'skov,imx8mp-skov-revb-hdmi', 'skov,imx8mp-skov-revb-lt6', 'skov,imx8mp-skov-revb-mi1010ait-1cp1', 'toradex,verdin-imx8mp', 'toradex,verdin-imx8mp-nonwifi', 'toradex,verdin-imx8mp-wifi']
	'avnet,sm2s-imx8mp-14N0600E-ep1' was expected
	'lwn,btt3' is not one of ['dh,imx8mp-dhcom-pdk2', 'dh,imx8mp-dhcom-pdk3']
	'lwn,btt3' is not one of ['engicam,icore-mx8mp-edimm2.2']
	'phytec,imx8mp-phyboard-pollux-rdk' was expected
	'lwn,btt3' is not one of ['polyhex,imx8mp-debix-model-a']
	'lwn,btt3' is not one of ['polyhex,imx8mp-debix-som-a-bmb-08']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mp-nonwifi-dahlia', 'toradex,verdin-imx8mp-nonwifi-dev', 'toradex,verdin-imx8mp-nonwifi-mallow', 'toradex,verdin-imx8mp-nonwifi-yavia']
	'lwn,btt3' is not one of ['toradex,verdin-imx8mp-wifi-dahlia', 'toradex,verdin-imx8mp-wifi-dev', 'toradex,verdin-imx8mp-wifi-mallow', 'toradex,verdin-imx8mp-wifi-yavia']
	'lwn,btt3' is not one of ['tq,imx8mp-tqma8mpql-mba8mpxl', 'tq,imx8mp-tqma8mpql-mba8mp-ras314']
	'lwn,btt3' is not one of ['boundary,imx8mq-nitrogen8m', 'boundary,imx8mq-nitrogen8m-som', 'einfochips,imx8mq-thor96', 'fsl,imx8mq-evk', 'google,imx8mq-phanbell', 'kontron,pitx-imx8m', 'purism,librem5-devkit', 'solidrun,hummingboard-pulse', 'technexion,pico-pi-imx8m']
	'mntre,reform2' was expected
	'lwn,btt3' is not one of ['purism,librem5r2', 'purism,librem5r3', 'purism,librem5r4']
	'lwn,btt3' is not one of ['tq,imx8mq-tqma8mq-mba8mx']
	'lwn,btt3' is not one of ['zii,imx8mq-ultra-rmb3', 'zii,imx8mq-ultra-zest']
	'lwn,btt3' is not one of ['fsl,imx8qm-mek', 'toradex,apalis-imx8', 'toradex,apalis-imx8-v1.1']
	'lwn,btt3' is not one of ['toradex,apalis-imx8-eval', 'toradex,apalis-imx8-eval-v1.2', 'toradex,apalis-imx8-ixora-v1.1']
	'lwn,btt3' is not one of ['toradex,apalis-imx8-v1.1-eval', 'toradex,apalis-imx8-v1.1-eval-v1.2', 'toradex,apalis-imx8-v1.1-ixora-v1.1', 'toradex,apalis-imx8-v1.1-ixora-v1.2']
	'lwn,btt3' is not one of ['einfochips,imx8qxp-ai_ml', 'fsl,imx8qxp-mek']
	'lwn,btt3' is not one of ['fsl,imx8dxl-evk']
	'lwn,btt3' is not one of ['toradex,colibri-imx8x-aster', 'toradex,colibri-imx8x-eval-v3', 'toradex,colibri-imx8x-iris', 'toradex,colibri-imx8x-iris-v2']
	'lwn,btt3' is not one of ['fsl,imx8ulp-evk']
	'lwn,btt3' is not one of ['fsl,imx93-9x9-qsb', 'fsl,imx93-11x11-evk', 'fsl,imx93-14x14-evk']
	'lwn,btt3' is not one of ['fsl,imx95-19x19-evk']
	'lwn,btt3' is not one of ['fsl,imxrt1050-evk']
	'lwn,btt3' is not one of ['fsl,imxrt1170-evk']
	'lwn,btt3' is not one of ['tq,imx93-tqma9352-mba93xxca', 'tq,imx93-tqma9352-mba93xxla']
	'phytec,imx93-phyboard-segin' was expected
	'variscite,var-som-mx93-symphony' was expected
	'lwn,btt3' is not one of ['fsl,vf500', 'fsl,vf510', 'fsl,vf600', 'fsl,vf610', 'fsl,vf610m4']
	'toradex,vf500-colibri_vf50-on-eval' was expected
	'lwn,btt3' is not one of ['fsl,vf610-twr', 'lwn,bk4', 'phytec,vf610-cosmic', 'toradex,vf610-colibri_vf61']
	'toradex,vf610-colibri_vf61-on-eval' was expected
	'lwn,btt3' is not one of ['zii,vf610cfu1', 'zii,vf610dev-c', 'zii,vf610dev-b', 'zii,vf610scu4-aib', 'zii,vf610dtu', 'zii,vf610spu3', 'zii,vf610spb4']
	'lwn,btt3' is not one of ['ebs-systart,oxalis', 'fsl,ls1012a-rdb', 'fsl,ls1012a-frdm', 'fsl,ls1012a-frwy', 'fsl,ls1012a-qds']
	'lwn,btt3' is not one of ['fsl,ls1021a-iot', 'fsl,ls1021a-moxa-uc-8410a', 'fsl,ls1021a-qds', 'fsl,ls1021a-tsn', 'fsl,ls1021a-twr']
	'lwn,btt3' is not one of ['tq,ls1021a-tqmls1021a-mbls102xa']
	'lwn,btt3' is not one of ['fsl,ls1028a-qds', 'fsl,ls1028a-rdb']
	'kontron,kbox-a-230-ls' was expected
	'lwn,btt3' is not one of ['kontron,sl28-var1-ads2', 'kontron,sl28-var2-ads2', 'kontron,sl28-var3-ads2', 'kontron,sl28-var4-ads2']
	'lwn,btt3' is not one of ['kontron,sl28-var1', 'kontron,sl28-var2', 'kontron,sl28-var3', 'kontron,sl28-var4']
	'kontron,sl28' was expected
	'lwn,btt3' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']
	'lwn,btt3' is not one of ['tq,ls1043a-tqmls1043a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls1046a-frwy', 'fsl,ls1046a-qds', 'fsl,ls1046a-rdb']
	'lwn,btt3' is not one of ['tq,ls1046a-tqmls1046a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls1088a-qds', 'fsl,ls1088a-rdb']
	'lwn,btt3' is not one of ['tq,ls1088a-tqmls1088a-mbls10xxa']
	'lwn,btt3' is not one of ['fsl,ls2080a-simu', 'fsl,ls2080a-qds', 'fsl,ls2080a-rdb']
	'lwn,btt3' is not one of ['fsl,ls2088a-qds', 'fsl,ls2088a-rdb']
	'lwn,btt3' is not one of ['fsl,lx2160a-bluebox3', 'fsl,lx2160a-bluebox3-rev-a', 'fsl,lx2160a-qds', 'fsl,lx2160a-rdb', 'fsl,lx2162a-qds']
	'lwn,btt3' is not one of ['solidrun,clearfog-cx', 'solidrun,honeycomb']
	'lwn,btt3' is not one of ['solidrun,lx2162a-clearfog']
	'lwn,btt3' is not one of ['tq,lx2160a-tqmlx2160a-mblx2160a']
	'lwn,btt3' is not one of ['nxp,s32g274a-evb', 'nxp,s32g274a-rdb2']
	'lwn,btt3' is not one of ['nxp,s32g399a-rdb3']
	'lwn,btt3' is not one of ['fsl,s32v234-evb']
	'lwn,btt3' is not one of ['traverse,ten64']
	'fsl,imx1' was expected
	'fsl,imx23' was expected
	'fsl,imx25' was expected
	'eukrea,cpuimx25' was expected
	'eukrea,mbimxsd25-baseboard' was expected
	'fsl,imx27' was expected
	'armadeus,imx27-apf27' was expected
	'eukrea,cpuimx27' was expected
	'phytec,imx27-pca100' was expected
	'phytec,imx27-pcm038' was expected
	'denx,m28' was expected
	'denx,m28evk' was expected
	'armadeus,imx28-apf28' was expected
	'crystalfontz,cfa10036' was expected
	'crystalfontz,cfa10037' was expected
	'i2se,duckbill-2' was expected
	'eukrea,mbmx28lc' was expected
	'fsl,imx31' was expected
	'fsl,imx35' was expected
	'eukrea,cpuimx35' was expected
	'fsl,imx50' was expected
	'fsl,imx51' was expected
	'armadeus,imx51-apf51' was expected
	'digi,connectcore-ccxmx51-som' was expected
	'eukrea,cpuimx51' was expected
	'fsl,imx53' was expected
	'denx,imx53-m53evk' was expected
	'tq,tqma53' was expected
	'fsl,imx6q' was expected
	'advantech,imx6q-ba16' was expected
	'armadeus,imx6q-apf6' was expected
	'compulab,cm-fx6' was expected
	'dfi,fs700e-m60' was expected
	'dh,imx6q-dhcom-som' was expected
	'gw,ventana' was expected
	'kontron,imx6q-samx6i' was expected
	'phytec,imx6q-pbac06' was expected
	'phytec,imx6q-pfla02' was expected
	'toradex,apalis_imx6q' was expected
	'variscite,var-som-imx6q' was expected
	'tq,mba6a' was expected
	'tq,mba6b' was expected
	'fsl,imx6qp' was expected
	'phytec,imx6qp-pbac06' was expected
	'fsl,imx6dl' was expected
	'armadeus,imx6dl-apf6' was expected
	'congatec,qmx6' was expected
	'dh,imx6dl-dhcom-som' was expected
	'kontron,imx6dl-samx6i' was expected
	'phytec,imx6dl-pbac06' was expected
	'phytec,imx6dl-pfla02' was expected
	'toradex,colibri_imx6dl' was expected
	'dh,imx6s-dhcom-som' was expected
	'fsl,imx6sl' was expected
	'fsl,imx6sll' was expected
	'fsl,imx6sx' was expected
	'fsl,imx6ul' was expected
	'armadeus,imx6ul-opos6ul' was expected
	'digi,ccimx6ulsom' was expected
	'grinn,imx6ul-litesom' was expected
	'phytec,imx6ul-pbacd10' was expected
	'kontron,sl-imx6ul' was expected
	'tq,imx6ul-tqma6ul1' was expected
	'tq,imx6ul-tqma6ul2' was expected
	'tq,imx6ul-tqma6ul2l' was expected
	'fsl,imx6ull' was expected
	'armadeus,imx6ull-opos6ul' was expected
	'dh,imx6ull-dhcom-som' was expected
	'dh,imx6ull-dhcor-som' was expected
	'phytec,imx6ull-pbacd10' was expected
	'phytec,imx6ull-phygate-tauri' was expected
	'toradex,colibri-imx6ull' was expected
	'toradex,colibri-imx6ull-emmc' was expected
	'toradex,colibri-imx6ull-wifi' was expected
	'kontron,sl-imx6ull' was expected
	'tq,imx6ull-tqma6ull2' was expected
	'tq,imx6ull-tqma6ull2l' was expected
	'seeed,imx6ull-seeed-npi' was expected
	'fsl,imx7s' was expected
	'toradex,colibri-imx7s' was expected
	'tq,imx7s-tqma7' was expected
	'fsl,imx7d' was expected
	'tq,imx7d-tqma7' was expected
	'compulab,cl-som-imx7' was expected
	'toradex,colibri-imx7d' was expected
	'toradex,colibri-imx7d-emmc' was expected
	'fsl,imx7ulp' was expected
	'fsl,imx8mm' was expected
	'compulab,imx8mm-ucm-som' was expected
	'ees,imx8mm-emtop-som' was expected
	'engicam,icore-mx8mm' was expected
	'kontron,imx8mm-sl' was expected
	'kontron,imx8mm-osm-s' was expected
	'toradex,verdin-imx8mm-nonwifi' was expected
	'toradex,verdin-imx8mm-wifi' was expected
	'phytec,imx8mm-phycore-som' was expected
	'variscite,var-som-mx8mm' was expected
	'tq,imx8mm-tqma8mqml' was expected
	'fsl,imx8mn' was expected
	'variscite,var-som-mx8mn' was expected
	'tq,imx8mn-tqma8mqnl' was expected
	'fsl,imx8mp' was expected
	'avnet,sm2s-imx8mp-14N0600E' was expected
	'dh,imx8mp-dhcom-som' was expected
	'engicam,icore-mx8mp' was expected
	'phytec,imx8mp-phycore-som' was expected
	'polyhex,imx8mp-debix' was expected
	'polyhex,imx8mp-debix-som-a' was expected
	'toradex,verdin-imx8mp-nonwifi' was expected
	'toradex,verdin-imx8mp-wifi' was expected
	'tq,imx8mp-tqma8mpql' was expected
	'fsl,imx8mq' was expected
	'boundary,imx8mq-nitrogen8m-som' was expected
	'purism,librem5' was expected
	'tq,imx8mq-tqma8mq' was expected
	'zii,imx8mq-ultra' was expected
	'fsl,imx8qm' was expected
	'toradex,apalis-imx8' was expected
	'toradex,apalis-imx8-v1.1' was expected
	'fsl,imx8qxp' was expected
	'fsl,imx8dxl' was expected
	'toradex,colibri-imx8x' was expected
	'fsl,imx8ulp' was expected
	'fsl,imx93' was expected
	'fsl,imx95' was expected
	'fsl,imxrt1050' was expected
	'fsl,imxrt1170' was expected
	'tq,imx93-tqma9352' was expected
	'phytec,imx93-phycore-som' was expected
	'variscite,var-som-mx93' was expected
	'toradex,vf500-colibri_vf50' was expected
	'fsl,vf610' was expected
	'toradex,vf610-colibri_vf61' was expected
	'zii,vf610dev' was expected
	'fsl,ls1012a' was expected
	'fsl,ls1021a' was expected
	'tq,ls1021a-tqmls1021a' was expected
	'fsl,ls1028a' was expected
	'kontron,sl28-var4' was expected
	'fsl,imx28' is not one of ['kontron,sl28-var1', 'kontron,sl28-var2', 'kontron,sl28-var3', 'kontron,sl28-var4']
	'fsl,ls1043a' was expected
	'tq,ls1043a-tqmls1043a' was expected
	'fsl,ls1046a' was expected
	'tq,ls1046a-tqmls1046a' was expected
	'fsl,ls1088a' was expected
	'tq,ls1088a-tqmls1088a' was expected
	'fsl,ls2080a' was expected
	'fsl,ls2088a' was expected
	'fsl,lx2160a' was expected
	'solidrun,lx2160a-cex7' was expected
	'solidrun,lx2162a-som' was expected
	'tq,lx2160a-tqmlx2160a' was expected
	'nxp,s32g2' was expected
	'nxp,s32g3' was expected
	'fsl,s32v234' was expected
	from schema $id: http://devicetree.org/schemas/arm/fsl.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /: failed to match any schema with compatible: ['lwn,btt3', 'fsl,imx28']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /: failed to match any schema with compatible: ['lwn,btt3', 'fsl,imx28']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: apbh@80000000: $nodename:0: 'apbh@80000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: apbh@80000000: $nodename:0: 'apbh@80000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /: failed to match any schema with compatible: ['lwn,btt3', 'fsl,imx28']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: apbh@80000000: $nodename:0: 'apbh@80000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh@80000000/interrupt-controller@80000000: failed to match any schema with compatible: ['fsl,imx28-icoll', 'fsl,icoll']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: nand-controller@8000c000: #size-cells: 0 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80010000: $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'non-removable', 'vmmc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80012000: $nodename:0: 'spi@80012000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80012000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'bus-width', 'clocks', 'keep-power-in-suspend', 'mmc-pwrseq', 'no-1-8-v', 'non-removable', 'pm-ignore-notify', 'vmmc-supply', 'wlan@1' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/mxs-mmc.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80014000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: spi@80016000: Unevaluated properties are not allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi_en_pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi_en_pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: pinctrl@80018000: 'auart0-2pins@0', 'auart0@0', 'auart1-2pins@0', 'auart1@0', 'auart2-2pins@0', 'auart2-2pins@1', 'auart2-pins@0', 'auart3-2pins@0', 'auart3-2pins@1', 'auart3@0', 'auart4@0', 'auart4@1', 'can0@0', 'can1@0', 'duart-4pins@0', 'duart@0', 'duart@1', 'gpmi-nand@0', 'gpmi-status-cfg@0', 'hog@0', 'hog@1', 'i2c0@0', 'i2c0@1', 'i2c1@0', 'i2c1@1', 'keypad-bttc@0', 'lcdif-16bit@0', 'lcdif-18bit@0', 'lcdif-24bit@0', 'lcdif-bttc@0', 'lcdif-bttc@1', 'lcdif-sync@0', 'mac0@0', 'mac0@1', 'mac1@0', 'mmc0-4bit@0', 'mmc0-8bit@0', 'mmc0-cd-cfg@0', 'mmc0-sck-cfg@0', 'mmc1-4bit@0', 'mmc1-cd-cfg@0', 'mmc1-sck-cfg@0', 'mmc2-4bit@0', 'mmc2-4bit@1', 'mmc2-cd-cfg@0', 'mmc2-sck-cfg@0', 'mmc2-sck-cfg@1', 'pwm0@0', 'pwm2@0', 'pwm3@0', 'pwm3@1', 'pwm4@0', 'saif0@0', 'saif0@1', 'saif1@0', 'spi2@0', 'spi3@0', 'spi3@1', 'ssp1-sdio@0', 'usb0@0', 'usb0@1', 'usb0id1@0', 'usb0id@0', 'usb1@0', 'usb1@1', 'wifi_en_pin@0' do not match any of the regexes: 'gpio@[0-9]+
 $', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-mxs.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbh@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbh@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbh@80000000/digctl@8001c000: failed to match any schema with compatible: ['fsl,imx28-digctl', 'fsl,imx23-digctl']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: lcdif@80030000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: lcdif@80030000: 'display', 'display0', 'display1', 'dma-names', 'dmas', 'lcd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: lcdif@80030000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: lcdif@80030000: 'display', 'display0', 'display1', 'dma-names', 'dmas', 'lcd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: lcdif@80030000: 'port' is a required property
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: lcdif@80030000: 'display', 'display0', 'display1', 'dma-names', 'dmas', 'lcd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: apbx@80040000: $nodename:0: 'apbx@80040000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: apbx@80040000: $nodename:0: 'apbx@80040000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: apbx@80040000: $nodename:0: 'apbx@80040000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx@80040000/lradc@80050000: failed to match any schema with compatible: ['fsl,imx28-lradc']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: /apb@80000000/apbx@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dtb: /apb@80000000/apbx@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']
arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dtb: /apb@80000000/apbx@80040000/timrot@80068000: failed to match any schema with compatible: ['fsl,imx28-timrot', 'fsl,timrot']






