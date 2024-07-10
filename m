Return-Path: <linux-kernel+bounces-248233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0FC92DA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD853B212F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE69196438;
	Wed, 10 Jul 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWrlH362"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7BDF71
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644905; cv=none; b=Z2ud4oSQGYs9VuE3FrV834O+1KcwMP4jy6NMTM8DvqsZH9wd+YPZ1ImoIb0/gYyX1+2eXMrWSKJ/iaRuV2vEOIBDJlJqTRfVNCmh1UjkCw+bIyXtS6XtZpIJOA5GQuVZrV7iHM0vjXPuVHjY4OvztNdfwkyweZMwXZkCemc6L9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644905; c=relaxed/simple;
	bh=6arACvGFc8becnTtOP09F/G3Zv7g/qQ2pvuFk/ujyMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wd1XC3c+597uRxqA7dGr1Z9Q5xQcZOflxGD5DSWHRO0Zxh5T813JQrJ6vhuk4Vqfv7HTcCbjok3qwAWHTTJHtzYXwu4mF6NeSUiiqkOuL0NNlq87rXHE0mdafPCn5yEtfNaFIVUfpPGx90CLxw5KIDLzDhB+tTE59VSPEtsG+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWrlH362; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720644903; x=1752180903;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6arACvGFc8becnTtOP09F/G3Zv7g/qQ2pvuFk/ujyMg=;
  b=AWrlH3626mGk6uJNxCbb2GJ9nQtVGGzF1uN4SfzGYPdcudQ1GE7y1D6l
   4b89LNzFqOXMHpYtD/s3ZQ8NLV3UwwTz3scFrxm2XGsrhbI24gJqEAfH7
   8wzVWhG33Dm+WUEoKw+KupSiNnBDDjVxeJdqZXeQlzCaZPg9SyooKuxM5
   D6IQTm/O/FjtRBxCh/3ZI9zJe44RPvl2cZvotvB7A65z+dg7nf7Ukj3Iw
   Hcnsq8Y8wL0vgHw1xu+9dTgFNZ3ze1ZlQEEJZB+EM93a7zTuSODNPriJV
   Q/mX2knydMZopu1eGxthUTdm2BV+I62qgVO7GgJs3buo8oxCPY7erzZog
   g==;
X-CSE-ConnectionGUID: AKGHj0WlSRiNYhgE1Zw0Kg==
X-CSE-MsgGUID: 0INhDzcNSdOwdV91LVvh2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35430814"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35430814"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:54:49 -0700
X-CSE-ConnectionGUID: TId9VMH4QimuE6qEdxTE8g==
X-CSE-MsgGUID: f4xoru5bTyOOn59l13UBOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48345363"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2024 13:54:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sReKp-000YHO-32;
	Wed, 10 Jul 2024 20:54:43 +0000
Date: Thu, 11 Jul 2024 04:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: i2c-mux-1:
 idle-state: [8] is not of type 'integer'
Message-ID: <202407110407.bISkgEfS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d6e1712b78251cf4470b0543bb4a8b491949aa32
commit: d3dd7bed42102704133b3569a4392f9aab6844ff arm64: dts: microchip: sparx5_pcb134: align I2C mux node name with bindings
date:   3 months ago
config: arm64-randconfig-051-20240711 (https://download.01.org/0day-ci/archive/20240711/202407110407.bISkgEfS-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407110407.bISkgEfS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407110407.bISkgEfS-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: spi@600104000: spi@e:reg:0:0: 14 is greater than the maximum of 3
   	from schema $id: http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: spi@600104000: Unevaluated properties are not allowed ('reg-shift' was unexpected)
   	from schema $id: http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: spi@0: 'spi-max-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/spi/spi-mux.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: spi@e: 'spi-max-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/spi/spi-mux.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: switch@600000000: reg-names:1: 'devices' was expected
   	from schema $id: http://devicetree.org/schemas/net/microchip,sparx5-switch.yaml#
>> arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: i2c-mux-1: idle-state: [8] is not of type 'integer'
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-gpio.yaml#
>> arch/arm64/boot/dts/microchip/sparx5_pcb134.dtb: i2c-mux-1: Unevaluated properties are not allowed ('idle-state' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-gpio.yaml#
--
   arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: mux-controller: #mux-control-cells: 1 was expected
   	from schema $id: http://devicetree.org/schemas/mux/reg-mux.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: spi@600104000: num-cs: 16 is greater than the maximum of 4
   	from schema $id: http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: spi@600104000: Unevaluated properties are not allowed ('reg-shift' was unexpected)
   	from schema $id: http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: spi@0: 'spi-max-frequency' is a required property
   	from schema $id: http://devicetree.org/schemas/spi/spi-mux.yaml#
   arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: switch@600000000: reg-names:1: 'devices' was expected
   	from schema $id: http://devicetree.org/schemas/net/microchip,sparx5-switch.yaml#
>> arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: i2c-mux-1: idle-state: [8] is not of type 'integer'
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-gpio.yaml#
>> arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dtb: i2c-mux-1: Unevaluated properties are not allowed ('idle-state' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-gpio.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

