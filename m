Return-Path: <linux-kernel+bounces-343262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09CD9898BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A321F2184D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115D4C85;
	Mon, 30 Sep 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBNDdlBe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38F10E4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727658039; cv=none; b=mzH/q/s/SDzV0OiDqwrMwt5N2U4WtlOiMy7viSTi40sT63Sp2+QWiVgaSLJxmRy9ACmh/R9ILP/1hB6RJPJAah3vzRAi1v49+pGUeoCoyBowl6Ba6OEZslQSBfmAs2RsTjf6faQYy36RnPnJmSYJxz2TY5FdForKrlQTzh5gSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727658039; c=relaxed/simple;
	bh=y4Xr5e5pES7Llfc8h1Ih3ugWCreLhotvnuYOiirpS4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CsQWT1oOrdZ+iGJy09bYZCDZX/d2tE5vYMoFB6eMUiA3vX4/rKvIPdKFvcbRDyi9MLNdx7dSGlEsw0goofGbEdARuf4nP84eT/IzKAc+iERUOkCGt1CoDx0FM7MHwuIrv+QMDVir/bbJSb7KSEQ/Bz/Rr752YA4UYUMTBSbo/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBNDdlBe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727658038; x=1759194038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y4Xr5e5pES7Llfc8h1Ih3ugWCreLhotvnuYOiirpS4g=;
  b=fBNDdlBe3jPTeX5spmfDWsXEfzmRU3kS+6xnLSrakiVpEZA1swJxtJIi
   yI4cI62QBQnAicu3Xv4hLv6/6uHIgMR+J+2K9HzzSBTprJ5Q0QqZgFVjN
   L/E4Q/wUS1saJQ+ERYsXWWdK5JMSLUzvhT2RflNimMcd6VQ1lTasM9qZs
   uf1BZM4xKlUSB6xBwYv3f3E2r2bRV/5nWm6qvJFNCUm1XzrxcQrSAwKVH
   XtmV4K4GMMPosiUGwCobi55d3CqgJnvKTiIgwYwG2W9v9Rl5pU1x2K5db
   HZS4+W5BGKnuZnWPX25EtR1kUz1Qp4KgZ8uwA1vY2yV4qYTUbAsoZS18P
   Q==;
X-CSE-ConnectionGUID: SbyjaJ4AR/m7NU38pP22tg==
X-CSE-MsgGUID: 2QOVSSIBSR+onpXF9KJ3sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44191541"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="44191541"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 18:00:37 -0700
X-CSE-ConnectionGUID: 6ffkm2LSSTW+IuuaMCbWWQ==
X-CSE-MsgGUID: +ijqhO3FTciTFh1cfUz6uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73408514"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Sep 2024 18:00:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv4m9-000OrD-1s;
	Mon, 30 Sep 2024 01:00:33 +0000
Date: Mon, 30 Sep 2024 09:00:15 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/parisc/include/asm/page.h:7:25: error: 'CONFIG_PAGE_SHIFT'
 undeclared; did you mean 'CONFIG_HAVE_PCI'?
Message-ID: <202409300823.1WT06W20-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9852d85ec9d492ebef56dc5f229416c925758edc
commit: d3e5bab923d35f73c74f6dbbb761988d4f58f878 arch: simplify architecture specific page size configuration
date:   7 months ago
config: parisc-randconfig-002-20231201 (https://download.01.org/0day-ci/archive/20240930/202409300823.1WT06W20-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240930/202409300823.1WT06W20-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409300823.1WT06W20-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/parisc/include/uapi/asm/byteorder.h:5,
                    from arch/parisc/include/asm/bitops.h:11,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from arch/parisc/include/asm/bitops.h:201:
   include/asm-generic/bitops/__fls.h: In function '__fls':
   include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   In file included from arch/parisc/include/asm/processor.h:19,
                    from include/linux/sched.h:13,
                    from arch/parisc/kernel/asm-offsets.c:18:
   arch/parisc/include/asm/pdc.h:75:24: warning: 'struct pdc_memory_table' declared inside parameter list will not be visible outside of this definition or declaration
      75 |                 struct pdc_memory_table *tbl, unsigned long entries);
         |                        ^~~~~~~~~~~~~~~~
   arch/parisc/include/asm/pdc.h:74:30: warning: 'struct pdc_memory_table_raddr' declared inside parameter list will not be visible outside of this definition or declaration
      74 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *r_addr,
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/parisc/include/uapi/asm/byteorder.h:5,
                    from arch/parisc/include/asm/bitops.h:11,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/sched.h:14:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   In file included from arch/parisc/include/asm/bitops.h:201:
   include/asm-generic/bitops/__fls.h: In function '__fls':
   include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   In file included from include/linux/cpumask.h:12,
                    from include/linux/sched.h:16:
   include/linux/cpumask.h: In function 'cpumask_setall':
   include/linux/bitmap.h:215:44: warning: right shift count >= width of type [-Wshift-count-overflow]
     215 | #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
         |                                            ^~
   include/linux/cpumask.h:542:41: note: in expansion of macro 'BITMAP_LAST_WORD_MASK'
     542 |                 cpumask_bits(dstp)[0] = BITMAP_LAST_WORD_MASK(nr_cpumask_bits);
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/shm.h:6,
                    from include/linux/sched.h:23:
   include/asm-generic/getorder.h: In function 'get_order':
>> arch/parisc/include/asm/page.h:7:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
       7 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/parisc/include/asm/page.h:7:25: note: each undeclared identifier is reported only once for each function it appears in
       7 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   In file included from include/linux/sched.h:38:
   include/linux/mm_types_task.h: At top level:
   include/linux/mm_types_task.h:16:10: fatal error: asm/tlbbatch.h: No such file or directory
      16 | #include <asm/tlbbatch.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.build:116: arch/parisc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1199: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +7 arch/parisc/include/asm/page.h

     6	
   > 7	#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
     8	#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
     9	#define PAGE_MASK	(~(PAGE_SIZE-1))
    10	
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

