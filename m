Return-Path: <linux-kernel+bounces-338178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAAD985460
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F84FB20DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3BE156F36;
	Wed, 25 Sep 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyncLYoQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B752154BF5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250263; cv=none; b=SoCGyj4tO6TAdJtND+df/xazpsqt+gXDD6o2kQ6NGU/Zfqd7dgaC1J0gAlpT4rDLEMP7eakVJgXpZk1eyqepJjtgjPMIKSseSEt5TJTnRiFxsKuABZoePbB2hN8Au+5SSjS9Z7KtG28T77V85Uh3objyHvpQBXgf3RNpMULnea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250263; c=relaxed/simple;
	bh=rRsmLsGYEiTCVvqokxTWg1QWQKAlLTi8/ZDwSs1ODnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I+9PSmDOLc93EVsEt66lfBtpKp38x6dro8QC1J1n39kYsj53sv5DJeEbEPPlYYiVomA9nA9/mwwh3TmzaQ8Q8+vXtkkyzrqy5AFmgMO2ibvTEwL5/24UE0RKGdjbnSsrC+jdp33PjKCyxEvmi6fpAEyMzXAjtQ+zgnDIA4/uIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyncLYoQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727250261; x=1758786261;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rRsmLsGYEiTCVvqokxTWg1QWQKAlLTi8/ZDwSs1ODnQ=;
  b=WyncLYoQQJ1/JCWff9WSff6ApwVFlIWBkVOt+20zDYZCi7vni1mmXwwq
   wSvMcNscJqIneFUVNvaUvq0STA7ZIDU8zb0zKy2rOcHU5ok8FGPOFVyrg
   1wKzrEfF7TthLJslK/gQZkhL9lXZ2g4GLmFTpTEdQHCKx68pyQMkrdiAM
   /KWWTH4Fn1ON8mGV93db+Q1A4IlGFthutzjIW6lfuFne68EH6sDS+4Gx1
   MKXA9R8G8sbpLFawXbHZ2enk2pZv2UPozX0Hqn7qkeYGErhuQbxwFheOK
   eeQrIB/1a5F89G0YykHYvBtSxqRrOvw0YjE/FRPPvFL44RyaG9QpPgGKI
   w==;
X-CSE-ConnectionGUID: KUwohTaZQ6y2eCAQYI0ppw==
X-CSE-MsgGUID: mqpLZnLmSY2b+YNamC+9LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26434363"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26434363"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:44:09 -0700
X-CSE-ConnectionGUID: dhPuuFmmSoiQCFQlArnkLw==
X-CSE-MsgGUID: YqhBUnhSRdiKShK10NIBhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="72146785"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Sep 2024 00:44:07 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stMgu-000JJv-1W;
	Wed, 25 Sep 2024 07:44:04 +0000
Date: Wed, 25 Sep 2024 15:43:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: cpus:
 'brcm,bmips-cbr-reg' is a required property
Message-ID: <202409251520.pE12GzHd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
commit: 3de96d810ffd712b7ad2bd764c1390fac2436551 dt-bindings: mips: brcm: D=
ocument brcm,bmips-cbr-reg property
date:   3 months ago
config: mips-randconfig-052-20240925 (https://download.01.org/0day-ci/archi=
ve/20240925/202409251520.pE12GzHd-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
dtschema version: 2024.10.dev4+g577c1ab
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240925/202409251520.pE12GzHd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251520.pE12GzHd-lkp@i=
ntel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/brcm/bcm6368.dtsi:68.30-78.5: Warning (simple_bus_reg=
): /ubus/syscon@100000008: simple-bus unit address format error, expected "=
10000008"
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: compatible:0: 'brcm,bcm9636=
8mvwg' is not one of ['brcm,bcm3368', 'brcm,bcm3384', 'brcm,bcm33843', 'brc=
m,bcm3384-viper', 'brcm,bcm33843-viper', 'brcm,bcm6328', 'brcm,bcm6358', 'b=
rcm,bcm6362', 'brcm,bcm6368', 'brcm,bcm63168', 'brcm,bcm63268', 'brcm,bcm71=
25', 'brcm,bcm7346', 'brcm,bcm7358', 'brcm,bcm7360', 'brcm,bcm7362', 'brcm,=
bcm7420', 'brcm,bcm7425']
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: compatible: ['brcm,bcm96368=
mvwg', 'brcm,bcm6368'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
>> arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: cpus: 'brcm,bmips-cbr-reg' =
is a required property
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: failed to match any schema =
with compatible: ['brcm,bcm96368mvwg', 'brcm,bcm6368']
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: ubus: $nodename:0: 'ubus' does=
 not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /ubus/clock-controller@1000000=
4: failed to match any schema with compatible: ['brcm,bcm6368-clocks']
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: syscon@100000008: compatible: =
'anyOf' conditional failed, one must be fixed:
   	['syscon'] is too short
   	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allw=
inner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller',=
 'allwinner,sun50i-a64-system-controller', 'altr,sdr-ctl', 'amd,pensando-el=
ba-syscon', 'apm,xgene-csw', 'apm,xgene-efuse', 'apm,xgene-mcb', 'apm,xgene=
-rb', 'apm,xgene-scu', 'brcm,cru-clkset', 'brcm,sr-cdru', 'brcm,sr-mhb', 'f=
reecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93=
-wakeupmix-syscfg', 'fsl,ls1088a-reset', 'hisilicon,dsa-subctrl', 'hisilico=
n,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl',=
 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls=
1c-syscon', 'marvell,armada-3700-cpu-misc', 'marvell,armada-3700-nb-pm', 'm=
arvell,armada-3700-avs', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt=
2712-pctl-a-syscfg', 'mediatek,mt6397-pctl-pmic-syscfg', 'mediatek,mt8135-p=
ctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8173-pctl-a-sys=
cfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,=
sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,=
wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-=
qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', =
'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', 'rockc=
hip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62=
-usb-phy-ctrl', 'ti,am62p-cpsw-mac-efuse', 'ti,am654-dss-oldi-io-ctrl', 'ti=
,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /ubus/interrupt-controller@100=
00020: failed to match any schema with compatible: ['brcm,bcm6345-l1-intc']
--
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: compatible:0: '=
sfr,nb4-ser' is not one of ['brcm,bcm3368', 'brcm,bcm3384', 'brcm,bcm33843'=
, 'brcm,bcm3384-viper', 'brcm,bcm33843-viper', 'brcm,bcm6328', 'brcm,bcm635=
8', 'brcm,bcm6362', 'brcm,bcm6368', 'brcm,bcm63168', 'brcm,bcm63268', 'brcm=
,bcm7125', 'brcm,bcm7346', 'brcm,bcm7358', 'brcm,bcm7360', 'brcm,bcm7362', =
'brcm,bcm7420', 'brcm,bcm7425']
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: compatible: ['s=
fr,nb4-ser', 'brcm,bcm6358'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
>> arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: cpus: 'brcm,bmi=
ps-cbr-reg' is a required property
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: failed to match=
 any schema with compatible: ['sfr,nb4-ser', 'brcm,bcm6358']
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: ubus: $nodename:0:=
 'ubus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|ap=
b)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /ubus/clock-contro=
ller@fffe0004: failed to match any schema with compatible: ['brcm,bcm6358-c=
locks']
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: syscon@fffe0008: c=
ompatible: 'anyOf' conditional failed, one must be fixed:
   	['syscon'] is too short
   	'syscon' is not one of ['allwinner,sun8i-a83t-system-controller', 'allw=
inner,sun8i-h3-system-controller', 'allwinner,sun8i-v3s-system-controller',=
 'allwinner,sun50i-a64-system-controller', 'altr,sdr-ctl', 'amd,pensando-el=
ba-syscon', 'apm,xgene-csw', 'apm,xgene-efuse', 'apm,xgene-mcb', 'apm,xgene=
-rb', 'apm,xgene-scu', 'brcm,cru-clkset', 'brcm,sr-cdru', 'brcm,sr-mhb', 'f=
reecom,fsg-cs2-system-controller', 'fsl,imx93-aonmix-ns-syscfg', 'fsl,imx93=
-wakeupmix-syscfg', 'fsl,ls1088a-reset', 'hisilicon,dsa-subctrl', 'hisilico=
n,hi6220-sramctrl', 'hisilicon,pcie-sas-subctrl', 'hisilicon,peri-subctrl',=
 'hpe,gxp-sysreg', 'intel,lgm-syscon', 'loongson,ls1b-syscon', 'loongson,ls=
1c-syscon', 'marvell,armada-3700-cpu-misc', 'marvell,armada-3700-nb-pm', 'm=
arvell,armada-3700-avs', 'marvell,armada-3700-usb2-host-misc', 'mediatek,mt=
2712-pctl-a-syscfg', 'mediatek,mt6397-pctl-pmic-syscfg', 'mediatek,mt8135-p=
ctl-a-syscfg', 'mediatek,mt8135-pctl-b-syscfg', 'mediatek,mt8173-pctl-a-sys=
cfg', 'mediatek,mt8365-syscfg', 'microchip,lan966x-cpu-syscon', 'microchip,=
sparx5-cpu-syscon', 'mstar,msc313-pmsleep', 'nuvoton,ma35d1-sys', 'nuvoton,=
wpcm450-shm', 'rockchip,px30-qos', 'rockchip,rk3036-qos', 'rockchip,rk3066-=
qos', 'rockchip,rk3128-qos', 'rockchip,rk3228-qos', 'rockchip,rk3288-qos', =
'rockchip,rk3368-qos', 'rockchip,rk3399-qos', 'rockchip,rk3568-qos', 'rockc=
hip,rk3588-qos', 'rockchip,rv1126-qos', 'starfive,jh7100-sysmain', 'ti,am62=
-usb-phy-ctrl', 'ti,am62p-cpsw-mac-efuse', 'ti,am654-dss-oldi-io-ctrl', 'ti=
,am654-serdes-ctrl', 'ti,j784s4-pcie-ctrl']
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /ubus/interrupt-co=
ntroller@fffe000c: failed to match any schema with compatible: ['brcm,bcm63=
45-l1-intc']

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

