Return-Path: <linux-kernel+bounces-338057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1349852DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466C12843C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B5155359;
	Wed, 25 Sep 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONQG6JVm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445C14C582
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245328; cv=none; b=CEJnrc+CkLyJPmNCbxqYYXgEky+TjzhACOwVd/K+1vg/Uvo0SbpvMHfZ5rSU4vPzRUJjZQIa+o9ryf/15J0iii5UYJYZiECpCkXtRRKmCniSKpT3vJ78YjQzHFOSFsTPvUvPysZRPOtE7GC04K+epTbKdLfwSnY3wNKw3s7kixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245328; c=relaxed/simple;
	bh=tFJLMH16MvhRj3zeHSvbMzen/rGWE00hjFvjCOjwr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FhloSaxkEPFvDEfx3FCGoAOfeMal+jbMq/YJPxnjyTqv2G7523pnQQOZF4dvi06/fep30oTFVmt1kw3Ini958OHXh/edzfAm/gcE64fxEHzEej428NQ+MyYNH30y624V6plns75znMWJYqpJAkaWjixuOCd3Mj/FiyU4RgafWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONQG6JVm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727245325; x=1758781325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tFJLMH16MvhRj3zeHSvbMzen/rGWE00hjFvjCOjwr1I=;
  b=ONQG6JVmF8feSQ4Hon5yaLKIPY1jpid4yDZll1v0hsrCyepO4d2m8qri
   pzRgC9KvnY09yWS0Ox9FuV1/FLxpYoZzEJZutjbGFOkTD/ZMm1DXTpQKy
   Wst0uHQFbGfjO7w4BZBkMHnEC3Lm+LdhKi1vNVzjVURsNAKmZtC0Im3Le
   hWxz9hQq1nroArG70mLBaM5TI9MeHGvHvwjzhbn9cqBvudWo32UnexIMr
   nrQ859X9zBiuA+5mgNgVOLRxs3QLXHnMO2YSA9IXBiRLPaK6uI2DasEBe
   ZSQDR+fU8tlRG4Wx/TC5Q1BD0yV9bDGIPxYCKyJKMHLBEBdPgwl62o1b7
   A==;
X-CSE-ConnectionGUID: W6fKEfjOQmivrSYAsR9CNg==
X-CSE-MsgGUID: 7DU0jfyjQ2ibfYgULzQLOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26144041"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26144041"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 23:22:05 -0700
X-CSE-ConnectionGUID: uk+QLmS2TCqlBgCTmEMQ9g==
X-CSE-MsgGUID: 6zf6NmwJS3WjehMpyQfTmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="72118857"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2024 23:22:03 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stLPU-000JDL-1M;
	Wed, 25 Sep 2024 06:22:00 +0000
Date: Wed, 25 Sep 2024 14:21:49 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: syscon@100000008:
 compatible: ['syscon'] is too short
Message-ID: <202409251418.vYwoiQ8l-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
commit: f97b0435c8572b16305d68cfc14ddc901878a9e7 dt-bindings: mfd: syscon: Split and enforce documenting MFD children
date:   3 months ago
config: mips-randconfig-052-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251418.vYwoiQ8l-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
dtschema version: 2024.10.dev4+g577c1ab
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251418.vYwoiQ8l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251418.vYwoiQ8l-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/brcm/bcm6368.dtsi:68.30-78.5: Warning (simple_bus_reg): /ubus/syscon@100000008: simple-bus unit address format error, expected "10000008"
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: compatible:0: 'brcm,bcm96368mvwg' is not one of ['brcm,bcm3368', 'brcm,bcm3384', 'brcm,bcm33843', 'brcm,bcm3384-viper', 'brcm,bcm33843-viper', 'brcm,bcm6328', 'brcm,bcm6358', 'brcm,bcm6362', 'brcm,bcm6368', 'brcm,bcm63168', 'brcm,bcm63268', 'brcm,bcm7125', 'brcm,bcm7346', 'brcm,bcm7358', 'brcm,bcm7360', 'brcm,bcm7362', 'brcm,bcm7420', 'brcm,bcm7425']
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: compatible: ['brcm,bcm96368mvwg', 'brcm,bcm6368'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /: failed to match any schema with compatible: ['brcm,bcm96368mvwg', 'brcm,bcm6368']
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: ubus: $nodename:0: 'ubus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /ubus/clock-controller@10000004: failed to match any schema with compatible: ['brcm,bcm6368-clocks']
>> arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: syscon@100000008: compatible: ['syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /ubus/interrupt-controller@10000020: failed to match any schema with compatible: ['brcm,bcm6345-l1-intc']
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: watchdog@1000005c: Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/brcm,bcm7038-wdt.yaml#
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: /ubus/led-controller@100000d0: failed to match any schema with compatible: ['brcm,bcm6358-leds']
   arch/mips/boot/dts/brcm/bcm96368mvwg.dtb: nand@10000200: compatible: 'oneOf' conditional failed, one must be fixed:
   	['brcm,nand-bcm6368', 'brcm,brcmnand-v2.1', 'brcm,brcmnand'] is too long
   	['brcm,nand-bcm6368', 'brcm,brcmnand-v2.1', 'brcm,brcmnand'] is too short
   	'brcm,nand-bcm6368' is not one of ['brcm,brcmnand-v2.1', 'brcm,brcmnand-v2.2', 'brcm,brcmnand-v4.0', 'brcm,brcmnand-v5.0', 'brcm,brcmnand-v6.0', 'brcm,brcmnand-v6.1', 'brcm,brcmnand-v6.2', 'brcm,brcmnand-v7.0', 'brcm,brcmnand-v7.1', 'brcm,brcmnand-v7.2', 'brcm,brcmnand-v7.3']
   	'brcm,nand-bcm63138' was expected
--
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: /: compatible: ['brcm,bcm9ejtagprb', 'brcm,bcm6328'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: /: failed to match any schema with compatible: ['brcm,bcm9ejtagprb', 'brcm,bcm6328']
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: ubus: $nodename:0: 'ubus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: /ubus/clock-controller@10000004: failed to match any schema with compatible: ['brcm,bcm6328-clocks']
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: /ubus/interrupt-controller@10000020: failed to match any schema with compatible: ['brcm,bcm6345-l1-intc']
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: watchdog@1000005c: Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/brcm,bcm7038-wdt.yaml#
>> arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: syscon@10000068: compatible: ['syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
   arch/mips/boot/dts/brcm/bcm9ejtagprb.dtb: nand@10000200: compatible: 'oneOf' conditional failed, one must be fixed:
   	['brcm,nand-bcm6368', 'brcm,brcmnand-v2.2', 'brcm,brcmnand'] is too long
   	['brcm,nand-bcm6368', 'brcm,brcmnand-v2.2', 'brcm,brcmnand'] is too short
   	'brcm,nand-bcm6368' is not one of ['brcm,brcmnand-v2.1', 'brcm,brcmnand-v2.2', 'brcm,brcmnand-v4.0', 'brcm,brcmnand-v5.0', 'brcm,brcmnand-v6.0', 'brcm,brcmnand-v6.1', 'brcm,brcmnand-v6.2', 'brcm,brcmnand-v7.0', 'brcm,brcmnand-v7.1', 'brcm,brcmnand-v7.2', 'brcm,brcmnand-v7.3']
   	'brcm,nand-bcm63138' was expected
   	'brcm,nand-iproc' was expected
   	'brcm,nand-bcm63168' was expected
   	'brcm,brcmnand' was expected
   	'brcm,brcmnand-v2.2' is not one of ['brcm,brcmnand-v7.0', 'brcm,brcmnand-v7.1']
--
   arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: /: compatible: ['netgear,cvg834g', 'brcm,bcm3368'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: /: failed to match any schema with compatible: ['netgear,cvg834g', 'brcm,bcm3368']
   arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: ubus: $nodename:0: 'ubus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: ubus: syscon-reboot@fff8c008: 'anyOf' conditional failed, one must be fixed:
   	'reg' is a required property
   	'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: /ubus/clock-controller@fff8c004: failed to match any schema with compatible: ['brcm,bcm3368-clocks']
>> arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: syscon@fff8c008: compatible: ['syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
   arch/mips/boot/dts/brcm/bcm3368-netgear-cvg834g.dtb: /ubus/interrupt-controller@fff8c00c: failed to match any schema with compatible: ['brcm,bcm6345-l1-intc']
--
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: compatible:0: 'sfr,nb4-ser' is not one of ['brcm,bcm3368', 'brcm,bcm3384', 'brcm,bcm33843', 'brcm,bcm3384-viper', 'brcm,bcm33843-viper', 'brcm,bcm6328', 'brcm,bcm6358', 'brcm,bcm6362', 'brcm,bcm6368', 'brcm,bcm63168', 'brcm,bcm63268', 'brcm,bcm7125', 'brcm,bcm7346', 'brcm,bcm7358', 'brcm,bcm7360', 'brcm,bcm7362', 'brcm,bcm7420', 'brcm,bcm7425']
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: compatible: ['sfr,nb4-ser', 'brcm,bcm6358'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /: failed to match any schema with compatible: ['sfr,nb4-ser', 'brcm,bcm6358']
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: ubus: $nodename:0: 'ubus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /ubus/clock-controller@fffe0004: failed to match any schema with compatible: ['brcm,bcm6358-clocks']
>> arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: syscon@fffe0008: compatible: ['syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /ubus/interrupt-controller@fffe000c: failed to match any schema with compatible: ['brcm,bcm6345-l1-intc']
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: watchdog@fffe005c: Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/brcm,bcm7038-wdt.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: /ubus/led-controller@fffe00d0: failed to match any schema with compatible: ['brcm,bcm6358-leds']
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: usb-phy@fffe1500: 'reset-names' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#
   arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dtb: nor@1e000000: $nodename:0: 'nor@1e000000' does not match '^(flash|.*sram|nand)(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
--
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: /: compatible:0: 'sfr,nb6-ser' is not one of ['brcm,bcm3368', 'brcm,bcm3384', 'brcm,bcm33843', 'brcm,bcm3384-viper', 'brcm,bcm33843-viper', 'brcm,bcm6328', 'brcm,bcm6358', 'brcm,bcm6362', 'brcm,bcm6368', 'brcm,bcm63168', 'brcm,bcm63268', 'brcm,bcm7125', 'brcm,bcm7346', 'brcm,bcm7358', 'brcm,bcm7360', 'brcm,bcm7362', 'brcm,bcm7420', 'brcm,bcm7425']
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: /: compatible: ['sfr,nb6-ser', 'brcm,bcm6362'] is too long
   	from schema $id: http://devicetree.org/schemas/mips/brcm/soc.yaml#
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: /: failed to match any schema with compatible: ['sfr,nb6-ser', 'brcm,bcm6362']
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: ubus: $nodename:0: 'ubus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: /ubus/clock-controller@10000004: failed to match any schema with compatible: ['brcm,bcm6362-clocks']
>> arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: syscon@10000008: compatible: ['syscon'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: /ubus/interrupt-controller@10000020: failed to match any schema with compatible: ['brcm,bcm6345-l1-intc']
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: watchdog@1000005c: Unevaluated properties are not allowed ('clock-names' was unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/brcm,bcm7038-wdt.yaml#
   arch/mips/boot/dts/brcm/bcm6362-neufbox6-sercomm.dtb: nand@10000200: compatible: 'oneOf' conditional failed, one must be fixed:
   	['brcm,nand-bcm6368', 'brcm,brcmnand-v2.2', 'brcm,brcmnand'] is too long
   	['brcm,nand-bcm6368', 'brcm,brcmnand-v2.2', 'brcm,brcmnand'] is too short
   	'brcm,nand-bcm6368' is not one of ['brcm,brcmnand-v2.1', 'brcm,brcmnand-v2.2', 'brcm,brcmnand-v4.0', 'brcm,brcmnand-v5.0', 'brcm,brcmnand-v6.0', 'brcm,brcmnand-v6.1', 'brcm,brcmnand-v6.2', 'brcm,brcmnand-v7.0', 'brcm,brcmnand-v7.1', 'brcm,brcmnand-v7.2', 'brcm,brcmnand-v7.3']
   	'brcm,nand-bcm63138' was expected
   	'brcm,nand-iproc' was expected

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

