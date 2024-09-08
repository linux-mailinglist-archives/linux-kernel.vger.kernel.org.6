Return-Path: <linux-kernel+bounces-319979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D059704A4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5675A282BE3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED72D272;
	Sun,  8 Sep 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4AG2YeC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773B79F4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725758742; cv=none; b=rQWR1BsORvMTBw66vOKOxfQYNwawuBZj5Jx2SpdZoHF3VDSbzy2pnOKfTH84jcD/KWvi8G7FUsDXYzcMbchYcdb99zEIbLk/r3a0xoEixuHR5dVqx/joP7xZhTOPh8MXI993vCnSWJbABZFG3BIz9mbP5RHqgwoA1HOe6W3fPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725758742; c=relaxed/simple;
	bh=PipYox8BhFhnE7Vep9ixjZNt2WP5hRfoNQKDR48Jr4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p37DjJkO9gSML4pZQUrgmE8IwIq/4zAf0uNSstbU0HvU6qmNNpe5+tO+wwFeiR3zbYcbL+3WCs4QVhI6fLjscL+KGzUOy2vHE1kcIGO7TTZuiOddH/vADJozFUfduwuAeA+4t5dUzsD6WAufNgl//bZRlv4pxVxzgdiuu8n+UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4AG2YeC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725758740; x=1757294740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PipYox8BhFhnE7Vep9ixjZNt2WP5hRfoNQKDR48Jr4Y=;
  b=G4AG2YeCwuVJXtqPUUKimupZumtCMlM1nZII5iH6WFER5iW+hfzFz9W2
   ZJgoqJI5nQpXXp6T73lfE6dMIw5VyIASjIho7qp8a8x6cJOXpoquypKJI
   yKYeMS1MSCdFwdSxNVOu/qrHFvtvTvL9Q3kK10+eDGzRBMzKVlKZPAMcC
   Ps/eQzybeus/i/Ia/DfV4zPyI9p6wapAr6aD63Au9HYFxTT++YdjeV5Wz
   uFUnmJnTQPnV/l0kH2IQz74Hqd3c6PTWbnljuKloi5fH9zeEMIC7z/yG8
   9MMiUOVd41mJepdgyDSXjpOTzmzlXgHWc/7+rTrMn6S05qJ9bwJgF7P/0
   A==;
X-CSE-ConnectionGUID: jQKaIHBFQg+k91rf3bmryA==
X-CSE-MsgGUID: 7w3n9OVGTQCdnYQbXGT03g==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24642134"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24642134"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 18:25:39 -0700
X-CSE-ConnectionGUID: FCJMMP9hT3+LhEexE6ifjA==
X-CSE-MsgGUID: aNRbv5fFT7e7WoQ0R39ihA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="71122595"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Sep 2024 18:25:38 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn6gJ-000DBH-2R;
	Sun, 08 Sep 2024 01:25:35 +0000
Date: Sun, 8 Sep 2024 09:24:40 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Rowand <frowand.list@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: arch/mips/include/asm/page.h:189:24: sparse: sparse: cast truncates
 bits from constant value (a800000000000000 becomes 0)
Message-ID: <202409080945.M1Oqo4Ou-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1f2d51b711a3b7f1ae1b46701c769c1d580fa7f
commit: 7b937cc243e5b1df8780a0aa743ce800df6c68d1 of: Create of_root if no dtb provided by firmware
date:   6 months ago
config: mips-randconfig-r111-20240907 (https://download.01.org/0day-ci/archive/20240908/202409080945.M1Oqo4Ou-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240908/202409080945.M1Oqo4Ou-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080945.M1Oqo4Ou-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/of/fdt.c: note: in included file (through include/linux/mm_types_task.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
>> arch/mips/include/asm/page.h:189:24: sparse: sparse: cast truncates bits from constant value (a800000000000000 becomes 0)

vim +189 arch/mips/include/asm/page.h

c6e8b587718c48 include/asm-mips/page.h      Ralf Baechle    2005-02-10  167  
6f284a2ce7b8bc include/asm-mips/page.h      Franck Bui-Huu  2007-01-10  168  /*
6f284a2ce7b8bc include/asm-mips/page.h      Franck Bui-Huu  2007-01-10  169   * __pa()/__va() should be used only during mem init.
6f284a2ce7b8bc include/asm-mips/page.h      Franck Bui-Huu  2007-01-10  170   */
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  171  static inline unsigned long ___pa(unsigned long x)
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  172  {
a5ff1b34e16c20 arch/mips/include/asm/page.h Masahiro Yamada 2016-08-25  173  	if (IS_ENABLED(CONFIG_64BIT)) {
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  174  		/*
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  175  		 * For MIPS64 the virtual address may either be in one of
2f9060b1db4aa2 arch/mips/include/asm/page.h Bjorn Helgaas   2024-01-03  176  		 * the compatibility segments ckseg0 or ckseg1, or it may
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  177  		 * be in xkphys.
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  178  		 */
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  179  		return x < CKSEG0 ? XPHYSADDR(x) : CPHYSADDR(x);
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  180  	}
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  181  
a5ff1b34e16c20 arch/mips/include/asm/page.h Masahiro Yamada 2016-08-25  182  	if (!IS_ENABLED(CONFIG_EVA)) {
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  183  		/*
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  184  		 * We're using the standard MIPS32 legacy memory map, ie.
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  185  		 * the address x is going to be in kseg0 or kseg1. We can
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  186  		 * handle either case by masking out the desired bits using
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  187  		 * CPHYSADDR.
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  188  		 */
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02 @189  		return CPHYSADDR(x);
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  190  	}
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  191  
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  192  	/*
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  193  	 * EVA is in use so the memory map could be anything, making it not
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  194  	 * safe to just mask out bits.
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  195  	 */
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  196  	return x - PAGE_OFFSET + PHYS_OFFSET;
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  197  }
0d8d83d0447deb arch/mips/include/asm/page.h Paul Burton     2016-08-02  198  #define __pa(x)		___pa((unsigned long)(x))
6f284a2ce7b8bc include/asm-mips/page.h      Franck Bui-Huu  2007-01-10  199  #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
49c426ba445f83 arch/mips/include/asm/page.h David Daney     2013-05-07  200  #include <asm/io.h>
5707bf6bcecd85 arch/mips/include/asm/page.h Ralf Baechle    2010-08-17  201  

:::::: The code at line 189 was first introduced by commit
:::::: 0d8d83d0447deb526c3125250eb391b5d76a3472 MIPS: Use CPHYSADDR to implement mips32 __pa

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

