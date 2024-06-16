Return-Path: <linux-kernel+bounces-216457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FA909F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A586B212F3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A150285;
	Sun, 16 Jun 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2YuFlF4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA603611A;
	Sun, 16 Jun 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718568281; cv=none; b=DsfQkOEBVJ7aoMnZ2Ogh2fYbDJFYcC6nd0hXnypeqgvKSOkGQFS7TTaz4MOY9NkJLIrZh+Ejqdh+Ye1QDJCAGtafP+JSiKQgqvXHw5RHBAhto73jD0s6gD0qgwMzCH6nBjxOr4vMv12ljN14Zwz/M02HXvMb05O618+J9GDVMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718568281; c=relaxed/simple;
	bh=QWRC2D1H2zURtP0smss7txlGTYwCW8TFD++F2R+yQuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKfZNkLB9I7LNJ8y4rTL4OeiwS7eHXz1jEQFm2S7UhPCOOzy9po9zC6/12YqYp9SHXMbOSx/FZJLQNc7NnblFEj5r1svRVCePlNj7S/zZNGrMS2qDPFEzWIPhm9y6IzCisrSnEdmjzqn9XQ7WEsgjvrdKGFUioOB47PTMRdfZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2YuFlF4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718568278; x=1750104278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QWRC2D1H2zURtP0smss7txlGTYwCW8TFD++F2R+yQuw=;
  b=m2YuFlF4V/ZD40M7UBygQvgL2fgf8K4BSzGMAIVtPtvemR6ZGWBznt/p
   F5lzktlR8B4Bhn2FdmQY02HbVJxNGK4cN/OC/NEHny+jR67ABKDnVuBqr
   OGiralCr9FVFiBboZozMlKymUv5IyiReXzZspeB6TSROJAkwt06CyWvtp
   dJsMsGUihbfDVuhFFZs+aCXl7sS2UHaGFGoO3N996H7TVQEriMpsBzH6w
   afhj4KJehyBzf23LDbTMrhT3Qu8Dk0St+mAGd9s9JeTklKjk22KsSmOEc
   WQzwb3CO2MHHWEIpcdPSzQ1B+T9+uWjS7wPSsGWcBcR6P9mhXDVx0feI+
   A==;
X-CSE-ConnectionGUID: LKGdcqCaSpWMf143CCVwOg==
X-CSE-MsgGUID: 3UZbZ9W1SGi695ZsWv/WyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26511258"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="26511258"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 13:04:38 -0700
X-CSE-ConnectionGUID: FSbR0r2qRVu6njUTKVBMEw==
X-CSE-MsgGUID: 4aaZq+W0Sdy2/n9jqsyfUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="40943438"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jun 2024 13:04:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIw77-0003EI-0K;
	Sun, 16 Jun 2024 20:04:33 +0000
Date: Mon, 17 Jun 2024 04:04:17 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/7] ARM: dts: aspeed: Harma: add VR device
Message-ID: <202406170350.zQo7bJdX-lkp@intel.com>
References: <20240613152425.1582059-3-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613152425.1582059-3-peteryin.openbmc@gmail.com>

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Yin/ARM-dts-aspeed-Harma-revise-hsc-chip/20240613-232915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240613152425.1582059-3-peteryin.openbmc%40gmail.com
patch subject: [PATCH v1 2/7] ARM: dts: aspeed: Harma: add VR device
config: arm-randconfig-051-20240614 (https://download.01.org/0day-ci/archive/20240617/202406170350.zQo7bJdX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406170350.zQo7bJdX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406170350.zQo7bJdX-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:409.21-412.6: Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@700/i2c-mux@70/i2c@0/power-monitor@63: I2C bus unit address format error, expected "61"
   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:655.36-659.7: Warning (unique_unit_address_if_enabled): /ahb/apb/lpc@1e789000/reset-controller@98: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/uart-routing@98)
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /: spi-gpio: {'status': ['okay'], 'compatible': ['spi-gpio'], '#address-cells': [[1]], '#size-cells': [[0]], 'gpio-sck': [[58, 203, 0]], 'gpio-mosi': [[58, 204, 0]], 'gpio-miso': [[58, 205, 0]], 'num-chipselects': [[1]], 'cs-gpios': [[58, 200, 1]], 'tpmdev@0': {'compatible': ['infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': [[33000000]], 'reg': [[0]]}} is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: timer: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: bus@1e600000: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
   	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e660000: $nodename:0: 'ftgmac@1e660000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
--
   	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: serial@1e78d000: pinctrl-0: True is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: serial@1e78f000: pinctrl-0: True is not of type 'array'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@80/pwm@5e: failed to match any schema with compatible: ['max31790']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@180/pwm@5e: failed to match any schema with compatible: ['max31790']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@280/power-monitor@69: failed to match any schema with compatible: ['pmbus']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@700/i2c-mux@70/i2c@0/power-monitor@61: failed to match any schema with compatible: ['isil,isl69260']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@700/i2c-mux@70/i2c@0/power-monitor@62: failed to match any schema with compatible: ['isil,isl69260']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@700/i2c-mux@70/i2c@0/power-monitor@63: failed to match any schema with compatible: ['isil,isl69260']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/ipmb@10: failed to match any schema with compatible: ['ipmb-dev']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: spi-gpio: $nodename:0: 'spi-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#

vim +/61 +409 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

   387	
   388	&i2c13 {
   389		status = "okay";
   390	
   391		i2c-mux@70 {
   392			compatible = "nxp,pca9545";
   393			reg = <0x70>;
   394			#address-cells = <1>;
   395			#size-cells = <0>;
   396	
   397			imux28: i2c@0 {
   398				#address-cells = <1>;
   399				#size-cells = <0>;
   400				reg = <0>;
   401				power-monitor@61 {
   402					compatible = "isil,isl69260";
   403					reg = <0x61>;
   404				};
   405				power-monitor@62 {
   406					compatible = "isil,isl69260";
   407					reg = <0x62>;
   408				};
 > 409				power-monitor@63 {
   410					compatible = "isil,isl69260";
   411					reg = <0x61>;
   412				};
   413				power-monitor@64 {
   414					compatible = "infineon,xdpe152c4";
   415					reg = <0x64>;
   416				};
   417				power-monitor@66 {
   418					compatible = "infineon,xdpe152c4";
   419					reg = <0x66>;
   420				};
   421				power-monitor@68 {
   422					compatible = "infineon,xdpe152c4";
   423					reg = <0x68>;
   424				};
   425			};
   426			imux29: i2c@1 {
   427				#address-cells = <1>;
   428				#size-cells = <0>;
   429				reg = <1>;
   430				//MB FRU
   431				eeprom@54 {
   432					compatible = "atmel,24c64";
   433					reg = <0x54>;
   434				};
   435			};
   436			imux30: i2c@2 {
   437				#address-cells = <1>;
   438				#size-cells = <0>;
   439				reg = <2>;
   440			};
   441			imux31: i2c@3 {
   442				#address-cells = <1>;
   443				#size-cells = <0>;
   444				reg = <3>;
   445			};
   446		};
   447	};
   448	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

