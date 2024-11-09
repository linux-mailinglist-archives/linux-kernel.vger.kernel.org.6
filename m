Return-Path: <linux-kernel+bounces-402541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577209C28E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35EEB21F59
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29703D2FB;
	Sat,  9 Nov 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCfxFIXX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3217C9B;
	Sat,  9 Nov 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112592; cv=none; b=mF/CSid5MOUJcSa5oYn4DK3k9BzYlaTiaZm5vOzNbvKRtY4SSffuMmW1PxO4foNCmlfy1o4LpPzvFnH9AqhVJvRE6osL67a3uW74EfCGMGBDSASfHJz4b+NYC5+/COf2cPAN4g+DacVdAVyBDiDahou+owcb9M+JnXSerKWjA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112592; c=relaxed/simple;
	bh=/v4nOKMZqjRDKHeSccKn/6TRtfkIXuzKK2o/IGgxuG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7AYVv99vBifQNwPRa9yqxcCj5lxHX8NjIlbEDI7N/D8h46G9Rr5aFzwQvhy8MxTKk11jB9HD7cnruDuDvdMIGQq6Qj5XGt4b5REcecFJrmzRGUsYEf6EvjMRdu/AdRAMg6IoBPyEEBaIVlGlC9/TZ0tyV9d6/CCp2741wcwzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCfxFIXX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731112590; x=1762648590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/v4nOKMZqjRDKHeSccKn/6TRtfkIXuzKK2o/IGgxuG0=;
  b=mCfxFIXX65FV1yF/ManTwvqbIAVGvXqvYT2EfXH0iSeAKCAQPdKcP0UF
   5007lV9Zp67fqLm2VsGopLGx/ThZd9ldV3EdTW6wdPDhSYZFvOAqUL+8N
   B/bbLghr6JNpEcXX5bkkeJMcbPW4klvylQLVyPJMEL/3agmz6ntjjvbI4
   48lK+RCPKDJRRVtdnmPEeCpWct/Ofjyv5IChW7JFcv1nS3EzvFAY1Clzx
   sn2o52klWmlNb2D+Gdv20wG8+p469F9L891QOSO3c34UWdvDhZLrg6Vnb
   UkcNHHdDVw9JcdU7wKFNG+Qdelq0FeY3oyZvMfL+g6Bm0fnFU541s0CR6
   A==;
X-CSE-ConnectionGUID: hnNvSN2ES9i4vWdL2BY9MA==
X-CSE-MsgGUID: ykHbf34KSt6ZkQnuIfPoBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34697184"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34697184"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:36:29 -0800
X-CSE-ConnectionGUID: GzuMQ6EmShiR9JfRGqiapQ==
X-CSE-MsgGUID: O5rcz93TTtGnX69xmuZJlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="85866781"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Nov 2024 16:36:24 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9ZSg-000rvI-0L;
	Sat, 09 Nov 2024 00:36:22 +0000
Date: Sat, 9 Nov 2024 08:36:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <202411090817.15n7hhOv-lkp@intel.com>
References: <20241108054006.2550856-2-fj5100bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108054006.2550856-2-fj5100bi@fujitsu.com>

Hi Yoshihiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/smp/core]
[also build test WARNING on linus/master v6.12-rc6]
[cannot apply to arm64/for-next/core arm-perf/for-next/perf next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yoshihiro-Furudera/perf-Fujitsu-Add-the-Uncore-MAC-PMU-driver/20241108-134245
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/20241108054006.2550856-2-fj5100bi%40fujitsu.com
patch subject: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241109/202411090817.15n7hhOv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090817.15n7hhOv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090817.15n7hhOv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/fujitsu_mac_pmu.c:12:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/perf/fujitsu_mac_pmu.c:15:
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
   In file included from drivers/perf/fujitsu_mac_pmu.c:15:
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
   In file included from drivers/perf/fujitsu_mac_pmu.c:15:
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
>> drivers/perf/fujitsu_mac_pmu.c:604:36: warning: unused variable 'fujitsu_mac_pmu_acpi_match' [-Wunused-const-variable]
     604 | static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   17 warnings generated.


vim +/fujitsu_mac_pmu_acpi_match +604 drivers/perf/fujitsu_mac_pmu.c

   603	
 > 604	static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
   605		{ "FUJI200C", },
   606		{ }
   607	};
   608	MODULE_DEVICE_TABLE(acpi, fujitsu_mac_pmu_acpi_match);
   609	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

