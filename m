Return-Path: <linux-kernel+bounces-249750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F592EF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228F01F21F37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62715F40D;
	Thu, 11 Jul 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIZ09Hrj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3F15E5CD;
	Thu, 11 Jul 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724627; cv=none; b=m+t//vjlnXPCQlwCYmswesTZC5lKfXMnJIDoEenhd5UOIxvFjJ256bbteGpSvnk5hGgnaAfLz0LHAcaDNyd+ODz7hOs6R6HJSQ3YC+A8u0GaBlkZr9DRVEGP85SPKb63c57QKoNur/xTPyNVITJMTikR5Lc87wWlR7H02zf5rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724627; c=relaxed/simple;
	bh=KjDHsBomUHrlcuMySZ8NJg7L3Q0FPnsN62pBzRy47t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIQ1i1l72R5NUCa5AS5JN8kTigbdlvfYutXLIAdVyC6JzIjk/nz/lgNIDomB13yColNlVFW9bv7aXd3LAET5UEgxkTzGT680k66QmZaVqUgYyJdQZ8quz5n/8lNFbXU7dqCQ14W5SMMmZVAFPCYvKb6sqiNPJNsPdAkIYEebAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIZ09Hrj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720724625; x=1752260625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjDHsBomUHrlcuMySZ8NJg7L3Q0FPnsN62pBzRy47t0=;
  b=mIZ09Hrjb1u9iUwYNZlLNYzs7f2Olat/9jaKCCdgdNO2lXxwqsL+TCoN
   rBEgxvQWiSvCT9S0Un/Rqxo1Y01BzbxU7y+NlMBR7B3RUfQ4ygZI4CIzj
   QPYI6ajpU/Yweaa62TNzrK/+G9Kc3ujjh6f6gkhJlAIoZDaVT+kYdJQjf
   90FaW9PL2iSnnzUP2AOE+YnnpBq6Rh6r/W8kpqknkERsJHiWzyb3vUVOf
   s/yFnElDA5vB2DbDhHi1Y/JkbQDfYyMcb2Cf63KCpyA7zjqKMeyi8QDNG
   zmMzwTAI7bRj1NQ9zm9yxl1x2njrWt+giXuIGKK+vrR5jE3Xbpj3FjLzc
   Q==;
X-CSE-ConnectionGUID: agBPXJaVSo+fqvIALCMzEw==
X-CSE-MsgGUID: KEOFaHguS56XPfW8mtwlsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17753626"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="17753626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 12:03:45 -0700
X-CSE-ConnectionGUID: 8bj9pQiWR/6B/B20EEpk+A==
X-CSE-MsgGUID: ulTMRKI8TFan/Xihp4bMsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="79358047"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Jul 2024 12:03:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRz4s-000ZiI-29;
	Thu, 11 Jul 2024 19:03:38 +0000
Date: Fri, 12 Jul 2024 03:03:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
Message-ID: <202407120208.ub5kh5K1-lkp@intel.com>
References: <20240710162526.2341399-8-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710162526.2341399-8-jbrunet@baylibre.com>

Hi Jerome,

kernel test robot noticed the following build errors:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on clk/clk-next linus/master v6.10-rc7 next-20240711]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/reset-amlogic-convert-driver-to-regmap/20240711-055833
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20240710162526.2341399-8-jbrunet%40baylibre.com
patch subject: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240712/202407120208.ub5kh5K1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407120208.ub5kh5K1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407120208.ub5kh5K1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/reset/reset-meson.c:8:
   In file included from include/linux/auxiliary_bus.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/reset/reset-meson.c:11:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/reset/reset-meson.c:11:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/reset/reset-meson.c:11:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/reset/reset-meson.c:272:1: error: redefinition of '__inittest'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^
   include/linux/auxiliary_bus.h:245:2: note: expanded from macro 'module_auxiliary_driver'
     245 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
   drivers/reset/reset-meson.c:232:1: note: previous definition is here
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^
   include/linux/platform_device.h:303:2: note: expanded from macro 'module_platform_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
>> drivers/reset/reset-meson.c:272:1: error: redefinition of 'init_module'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^
   include/linux/auxiliary_bus.h:245:2: note: expanded from macro 'module_auxiliary_driver'
     245 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^
   drivers/reset/reset-meson.c:232:1: note: previous definition is here
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^
   include/linux/platform_device.h:303:2: note: expanded from macro 'module_platform_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^
>> drivers/reset/reset-meson.c:272:1: error: redefinition of '__exittest'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^
   include/linux/auxiliary_bus.h:245:2: note: expanded from macro 'module_auxiliary_driver'
     245 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:139:42: note: expanded from macro '\
   module_exit'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^
   drivers/reset/reset-meson.c:232:1: note: previous definition is here
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^
   include/linux/platform_device.h:303:2: note: expanded from macro 'module_platform_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:139:42: note: expanded from macro '\
   module_exit'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^
>> drivers/reset/reset-meson.c:272:1: error: redefinition of 'cleanup_module'
     272 | module_auxiliary_driver(meson_reset_aux_driver);
         | ^
   include/linux/auxiliary_bus.h:245:2: note: expanded from macro 'module_auxiliary_driver'
     245 |         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:141:7: note: expanded from macro '\
   module_exit'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^
   drivers/reset/reset-meson.c:232:1: note: previous definition is here
     232 | module_platform_driver(meson_reset_pltf_driver);
         | ^
   include/linux/platform_device.h:303:2: note: expanded from macro 'module_platform_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
   include/linux/module.h:141:7: note: expanded from macro '\
   module_exit'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^
   drivers/reset/reset-meson.c:292:5: error: redefinition of 'devm_meson_rst_aux_register'
     292 | int devm_meson_rst_aux_register(struct device *dev,
         |     ^
   include/soc/amlogic/meson-auxiliary-reset.h:15:19: note: previous definition is here
      15 | static inline int devm_meson_rst_aux_register(struct device *dev,
         |                   ^
   17 warnings and 5 errors generated.


vim +/__inittest +272 drivers/reset/reset-meson.c

   267	
   268	static struct auxiliary_driver meson_reset_aux_driver = {
   269		.probe		= meson_reset_aux_probe,
   270		.id_table	= meson_reset_aux_ids,
   271	};
 > 272	module_auxiliary_driver(meson_reset_aux_driver);
   273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

