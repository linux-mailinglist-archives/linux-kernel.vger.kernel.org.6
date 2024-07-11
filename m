Return-Path: <linux-kernel+bounces-248809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836A92E242
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3492850C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEBF15747C;
	Thu, 11 Jul 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njysQA38"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1F1509B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686558; cv=none; b=fvXkC0fwwUNybZJX8M/Izdx73Myx4VI1i2euWO/I4oMTDhV1dj7q83ltNcZnv5bR4IA7Mr7dl/UNS0ZbAFC6sxcXDdQQa7rva3I7C+a6i0IGxaIMN+5N7Wlc8aPGkxruBPMLhKIWb5zrAQKwNE4hj24Gt5NNwMxwHGas9VvOKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686558; c=relaxed/simple;
	bh=ReCPBUA5yimuKNSzK/fvryEVC3yvqSCKIo9u/aGvPZc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iJhIJMi/Rn/MSnqfN0oXHcS00sKPAacOvEUuJUzpRM4tMXKb+2ne13WUbZZIjaFKVQ/s8N5BMpLL98Tkd4q8pPau5AW8ZP8QM05bcdOAA5n6z/EZW+7UEaW6YGr/nvuMxpQy0BUVkH+y1dzu1KcL11vJKhAcMfXsVoD+QBkcqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njysQA38; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720686557; x=1752222557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ReCPBUA5yimuKNSzK/fvryEVC3yvqSCKIo9u/aGvPZc=;
  b=njysQA38NZQpWiGiaSZPRYkNVvcB94HpBFOvoCLjFZjys5q+t1s7SpRc
   xzH45oWrZL5cl+pVXpVEjyEwJOAsXpyvOj+0roUZwRumXVfqi2Ww/Gj74
   JDKjQOpSaJ5RjDkMLh/HdGL3vQEJ/SnpX0ikB33IZzuJXrOM+xnIIaw4a
   MhJGvmiu2EcMMpdKpiaShAwonN7bKaVUj2AiEyFGa9lsAFa59fUgSx7DB
   191YzzWfHpbnDXQRGpNiEtZANYFYdyi0TwS90O5pworwATIEftz1swWFf
   EVnmr7vQ4DPFC78w4T9Oj6Fgnm6TKxVMGLYXpwCcunwZMQ00b9yBnNobq
   A==;
X-CSE-ConnectionGUID: IIF3IgKtQJyipGZ+lCrMVQ==
X-CSE-MsgGUID: c1nRNGjCQJiP/1UTIAPfNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43470895"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="43470895"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:29:16 -0700
X-CSE-ConnectionGUID: ximq65pwQ0eIQcuLyGceiQ==
X-CSE-MsgGUID: 5K+GjalbRaqXkiLJOw/ZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="52868735"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jul 2024 01:29:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRpAu-000Z1B-22;
	Thu, 11 Jul 2024 08:29:12 +0000
Date: Thu, 11 Jul 2024 16:28:46 +0800
From: kernel test robot <lkp@intel.com>
To: Kelly Hung <ppighouse@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: i2c-mux@70:
 idle-state: [1] is not of type 'integer'
Message-ID: <202407111649.iCSi2S48-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: d8bdd1e8acd54631a59c56f637b18816c5381f61 ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
date:   2 months ago
config: arm-randconfig-051-20240711 (https://download.01.org/0day-ci/archive/20240711/202407111649.iCSi2S48-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111649.iCSi2S48-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111649.iCSi2S48-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: kcs@114: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: sdc@1e740000: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: sdc@1e740000: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
   	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
>> arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: i2c-mux@70: idle-state: [1] is not of type 'integer'
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: i2c-mux@70: Unevaluated properties are not allowed ('idle-state' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

