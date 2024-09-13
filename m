Return-Path: <linux-kernel+bounces-328890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9AC978A83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2101F244D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40087155389;
	Fri, 13 Sep 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLIYFdVW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F71494BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262611; cv=none; b=mnXr5BYCF6Zg+L+lgQs2s3nLUFCPCiSbHBnK3RJPAM/i+YEJgwdXkkoj99U67ACYRb5llLUM2iyhK4r0HpSRjMQ/U30rJvZz6sbXI+3d2Ja8W4UC6vQDnylOVFal2CcLgCkQiBRXVwsQ5wNu9YduylHOxkMmDSydYIMw+3461Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262611; c=relaxed/simple;
	bh=BYt45oZPDkVHlYHqzGVb0rk4AE97llNfA0B9F86dKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RuYO/WLUSpUdg8/lOpKEeAbDloB21Cz/Pem76sKDNKmPKrjoNruQG3fBdxidr7u8nIAM0Z07J2xWRZ22enTOOH9QDpSDxFDWhSrd7DpAgtuJUGSAETaDK5eXaugwpaODGW9LbXZNgJ6IKSJcCkCirDmqUEMHOeKh2yzWuEu27PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLIYFdVW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726262609; x=1757798609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BYt45oZPDkVHlYHqzGVb0rk4AE97llNfA0B9F86dKnc=;
  b=hLIYFdVW4Eu5hIqej97ircbFjg6F6/1wdGVbW2wrsFF+PVe8jG//A7ep
   mLXgzO8ikCXydIaNm28Ai/x01r3kaoDZQw+Dbz5G930PCrrgCiDCml4b9
   BaiGSNUD0nlZa5EBk+yfMmF1mdpkiCOo7EhZdyorb/rPqt78vPg2GV4HD
   aUOyf1BfLn5YPBaSW6mZI4n41CL3vUUjjS44AAO8XDMkbOYV3uxClgNVh
   /1tr1jseviPL8jny4huyhDLmrPaCS1by9yjwxcWUpnWvsXj54fXUh7tjK
   U6sBxxyp/sTReo86uq9k3wfvl6xkATwjyes4A8xNrjd3YSAWjIWlaRL26
   g==;
X-CSE-ConnectionGUID: irApJrcYTSWPccsKdl6UcQ==
X-CSE-MsgGUID: 9Wom96QORTC4CWeFxccn9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25062596"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25062596"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 14:23:28 -0700
X-CSE-ConnectionGUID: aVfLqxGWSMe80OH2Am86Mw==
X-CSE-MsgGUID: RYkeqJGmTrmWNEuNThOXaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68520815"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Sep 2024 14:23:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spDlE-000722-0r;
	Fri, 13 Sep 2024 21:23:24 +0000
Date: Sat, 14 Sep 2024 05:22:24 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/iomem.c:18:32: sparse: sparse: cast truncates bits from
 constant value (38400000050e becomes 50e)
Message-ID: <202409140544.bY7KrkTy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e936e7d4a83b5ff6b7a685722f0ba348383af68c
commit: 0453c9a78015cb2219cda7239d881f4e3137bff8 sh: mm: convert to GENERIC_IOREMAP
date:   1 year, 1 month ago
config: sh-randconfig-r113-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140544.bY7KrkTy-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240914/202409140544.bY7KrkTy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140544.bY7KrkTy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/iomem.c:113:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   kernel/iomem.c:113:22: sparse:     expected void *[assigned] addr
   kernel/iomem.c:113:22: sparse:     got void [noderef] __iomem *
   kernel/iomem.c:116:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   kernel/iomem.c:116:22: sparse:     expected void *[assigned] addr
   kernel/iomem.c:116:22: sparse:     got void [noderef] __iomem *
>> kernel/iomem.c:18:32: sparse: sparse: cast truncates bits from constant value (38400000050e becomes 50e)
   kernel/iomem.c: note: in included file (through include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
   include/linux/mmzone.h:1997:40: sparse: sparse: self-comparison always evaluates to false
--
   drivers/usb/musb/tusb6010.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)

vim +18 kernel/iomem.c

5981690ddb8f72 Dan Williams 2018-03-29   14  
5981690ddb8f72 Dan Williams 2018-03-29   15  #ifndef arch_memremap_wb
5981690ddb8f72 Dan Williams 2018-03-29   16  static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
5981690ddb8f72 Dan Williams 2018-03-29   17  {
5981690ddb8f72 Dan Williams 2018-03-29  @18  	return (__force void *)ioremap_cache(offset, size);
5981690ddb8f72 Dan Williams 2018-03-29   19  }
5981690ddb8f72 Dan Williams 2018-03-29   20  #endif
5981690ddb8f72 Dan Williams 2018-03-29   21  
5981690ddb8f72 Dan Williams 2018-03-29   22  #ifndef arch_memremap_can_ram_remap
5981690ddb8f72 Dan Williams 2018-03-29   23  static bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
5981690ddb8f72 Dan Williams 2018-03-29   24  					unsigned long flags)
5981690ddb8f72 Dan Williams 2018-03-29   25  {
5981690ddb8f72 Dan Williams 2018-03-29   26  	return true;
5981690ddb8f72 Dan Williams 2018-03-29   27  }
5981690ddb8f72 Dan Williams 2018-03-29   28  #endif
5981690ddb8f72 Dan Williams 2018-03-29   29  
5981690ddb8f72 Dan Williams 2018-03-29   30  static void *try_ram_remap(resource_size_t offset, size_t size,
5981690ddb8f72 Dan Williams 2018-03-29   31  			   unsigned long flags)
5981690ddb8f72 Dan Williams 2018-03-29   32  {
5981690ddb8f72 Dan Williams 2018-03-29   33  	unsigned long pfn = PHYS_PFN(offset);
5981690ddb8f72 Dan Williams 2018-03-29   34  
5981690ddb8f72 Dan Williams 2018-03-29   35  	/* In the simple case just return the existing linear address */
5981690ddb8f72 Dan Williams 2018-03-29   36  	if (pfn_valid(pfn) && !PageHighMem(pfn_to_page(pfn)) &&
5981690ddb8f72 Dan Williams 2018-03-29   37  	    arch_memremap_can_ram_remap(offset, size, flags))
5981690ddb8f72 Dan Williams 2018-03-29   38  		return __va(offset);
5981690ddb8f72 Dan Williams 2018-03-29   39  
5981690ddb8f72 Dan Williams 2018-03-29   40  	return NULL; /* fallback to arch_memremap_wb */
5981690ddb8f72 Dan Williams 2018-03-29   41  }
5981690ddb8f72 Dan Williams 2018-03-29   42  
5981690ddb8f72 Dan Williams 2018-03-29   43  /**
5981690ddb8f72 Dan Williams 2018-03-29   44   * memremap() - remap an iomem_resource as cacheable memory
5981690ddb8f72 Dan Williams 2018-03-29   45   * @offset: iomem resource start address
5981690ddb8f72 Dan Williams 2018-03-29   46   * @size: size of remap
5981690ddb8f72 Dan Williams 2018-03-29   47   * @flags: any of MEMREMAP_WB, MEMREMAP_WT, MEMREMAP_WC,
5981690ddb8f72 Dan Williams 2018-03-29   48   *		  MEMREMAP_ENC, MEMREMAP_DEC
5981690ddb8f72 Dan Williams 2018-03-29   49   *
5981690ddb8f72 Dan Williams 2018-03-29   50   * memremap() is "ioremap" for cases where it is known that the resource
5981690ddb8f72 Dan Williams 2018-03-29   51   * being mapped does not have i/o side effects and the __iomem
5981690ddb8f72 Dan Williams 2018-03-29   52   * annotation is not applicable. In the case of multiple flags, the different
5981690ddb8f72 Dan Williams 2018-03-29   53   * mapping types will be attempted in the order listed below until one of
5981690ddb8f72 Dan Williams 2018-03-29   54   * them succeeds.
5981690ddb8f72 Dan Williams 2018-03-29   55   *
5981690ddb8f72 Dan Williams 2018-03-29   56   * MEMREMAP_WB - matches the default mapping for System RAM on
5981690ddb8f72 Dan Williams 2018-03-29   57   * the architecture.  This is usually a read-allocate write-back cache.
f6c6010a077341 Wei Yang     2019-03-05   58   * Moreover, if MEMREMAP_WB is specified and the requested remap region is RAM
5981690ddb8f72 Dan Williams 2018-03-29   59   * memremap() will bypass establishing a new mapping and instead return
5981690ddb8f72 Dan Williams 2018-03-29   60   * a pointer into the direct map.
5981690ddb8f72 Dan Williams 2018-03-29   61   *
5981690ddb8f72 Dan Williams 2018-03-29   62   * MEMREMAP_WT - establish a mapping whereby writes either bypass the
5981690ddb8f72 Dan Williams 2018-03-29   63   * cache or are written through to memory and never exist in a
5981690ddb8f72 Dan Williams 2018-03-29   64   * cache-dirty state with respect to program visibility.  Attempts to
5981690ddb8f72 Dan Williams 2018-03-29   65   * map System RAM with this mapping type will fail.
5981690ddb8f72 Dan Williams 2018-03-29   66   *
5981690ddb8f72 Dan Williams 2018-03-29   67   * MEMREMAP_WC - establish a writecombine mapping, whereby writes may
5981690ddb8f72 Dan Williams 2018-03-29   68   * be coalesced together (e.g. in the CPU's write buffers), but is otherwise
5981690ddb8f72 Dan Williams 2018-03-29   69   * uncached. Attempts to map System RAM with this mapping type will fail.
5981690ddb8f72 Dan Williams 2018-03-29   70   */
5981690ddb8f72 Dan Williams 2018-03-29   71  void *memremap(resource_size_t offset, size_t size, unsigned long flags)
5981690ddb8f72 Dan Williams 2018-03-29   72  {
5981690ddb8f72 Dan Williams 2018-03-29   73  	int is_ram = region_intersects(offset, size,
5981690ddb8f72 Dan Williams 2018-03-29   74  				       IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
5981690ddb8f72 Dan Williams 2018-03-29   75  	void *addr = NULL;
5981690ddb8f72 Dan Williams 2018-03-29   76  
5981690ddb8f72 Dan Williams 2018-03-29   77  	if (!flags)
5981690ddb8f72 Dan Williams 2018-03-29   78  		return NULL;
5981690ddb8f72 Dan Williams 2018-03-29   79  
5981690ddb8f72 Dan Williams 2018-03-29   80  	if (is_ram == REGION_MIXED) {
5981690ddb8f72 Dan Williams 2018-03-29   81  		WARN_ONCE(1, "memremap attempted on mixed range %pa size: %#lx\n",
5981690ddb8f72 Dan Williams 2018-03-29   82  				&offset, (unsigned long) size);
5981690ddb8f72 Dan Williams 2018-03-29   83  		return NULL;
5981690ddb8f72 Dan Williams 2018-03-29   84  	}
5981690ddb8f72 Dan Williams 2018-03-29   85  
5981690ddb8f72 Dan Williams 2018-03-29   86  	/* Try all mapping types requested until one returns non-NULL */
5981690ddb8f72 Dan Williams 2018-03-29   87  	if (flags & MEMREMAP_WB) {
5981690ddb8f72 Dan Williams 2018-03-29   88  		/*
f6c6010a077341 Wei Yang     2019-03-05   89  		 * MEMREMAP_WB is special in that it can be satisfied
5981690ddb8f72 Dan Williams 2018-03-29   90  		 * from the direct map.  Some archs depend on the
5981690ddb8f72 Dan Williams 2018-03-29   91  		 * capability of memremap() to autodetect cases where
5981690ddb8f72 Dan Williams 2018-03-29   92  		 * the requested range is potentially in System RAM.
5981690ddb8f72 Dan Williams 2018-03-29   93  		 */
5981690ddb8f72 Dan Williams 2018-03-29   94  		if (is_ram == REGION_INTERSECTS)
5981690ddb8f72 Dan Williams 2018-03-29   95  			addr = try_ram_remap(offset, size, flags);
5981690ddb8f72 Dan Williams 2018-03-29   96  		if (!addr)
5981690ddb8f72 Dan Williams 2018-03-29   97  			addr = arch_memremap_wb(offset, size);
5981690ddb8f72 Dan Williams 2018-03-29   98  	}
5981690ddb8f72 Dan Williams 2018-03-29   99  
5981690ddb8f72 Dan Williams 2018-03-29  100  	/*
5981690ddb8f72 Dan Williams 2018-03-29  101  	 * If we don't have a mapping yet and other request flags are
5981690ddb8f72 Dan Williams 2018-03-29  102  	 * present then we will be attempting to establish a new virtual
5981690ddb8f72 Dan Williams 2018-03-29  103  	 * address mapping.  Enforce that this mapping is not aliasing
5981690ddb8f72 Dan Williams 2018-03-29  104  	 * System RAM.
5981690ddb8f72 Dan Williams 2018-03-29  105  	 */
5981690ddb8f72 Dan Williams 2018-03-29  106  	if (!addr && is_ram == REGION_INTERSECTS && flags != MEMREMAP_WB) {
5981690ddb8f72 Dan Williams 2018-03-29  107  		WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
5981690ddb8f72 Dan Williams 2018-03-29  108  				&offset, (unsigned long) size);
5981690ddb8f72 Dan Williams 2018-03-29  109  		return NULL;
5981690ddb8f72 Dan Williams 2018-03-29  110  	}
5981690ddb8f72 Dan Williams 2018-03-29  111  
5981690ddb8f72 Dan Williams 2018-03-29  112  	if (!addr && (flags & MEMREMAP_WT))
5981690ddb8f72 Dan Williams 2018-03-29 @113  		addr = ioremap_wt(offset, size);
5981690ddb8f72 Dan Williams 2018-03-29  114  
5981690ddb8f72 Dan Williams 2018-03-29  115  	if (!addr && (flags & MEMREMAP_WC))
5981690ddb8f72 Dan Williams 2018-03-29  116  		addr = ioremap_wc(offset, size);
5981690ddb8f72 Dan Williams 2018-03-29  117  
5981690ddb8f72 Dan Williams 2018-03-29  118  	return addr;
5981690ddb8f72 Dan Williams 2018-03-29  119  }
5981690ddb8f72 Dan Williams 2018-03-29  120  EXPORT_SYMBOL(memremap);
5981690ddb8f72 Dan Williams 2018-03-29  121  

:::::: The code at line 18 was first introduced by commit
:::::: 5981690ddb8f72f9546a2d017a914cf56095fc1f memremap: split devm_memremap_pages() and memremap() infrastructure

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

