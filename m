Return-Path: <linux-kernel+bounces-264483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D9D93E3FA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D94B2126C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C84C144;
	Sun, 28 Jul 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQqv/Um5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878828C09
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722152766; cv=none; b=rJgYk3JBt98lsZdPp+6Nd2t6goTI+K6qziMQoeemw9wmPN9tWQCZiYNT/pseT0WBHkNmvynbyiF+xUMp66YnO/e1/W9YdjlFdg6+3Rj2JaC9A/ZSU/bEobrvYnelOgICcew5+kV3H5NQsjMr/Wnu5ifxdFK4sz9L7iO15h/7VyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722152766; c=relaxed/simple;
	bh=iBvRhHhsfX5P/iKTnOx29nZSFG5/+5JfbERy4ly5nEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gz8k/auw7be1FJCIaglH5Z0jSL7EItXFkUMEIyUTuKuDYlTCOdaPmh+ve8O+sJZ5ivNc9cJRMl0/EsINJO3Jb5lUMRGImkx1QYdAldAEqS68ItC8XImBepDfBYZSH74/mpb3FteKOipwzT52wYuSXIs5MxVrRIURJ+5uFOFh7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQqv/Um5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722152763; x=1753688763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iBvRhHhsfX5P/iKTnOx29nZSFG5/+5JfbERy4ly5nEk=;
  b=IQqv/Um54ushb+ZIMyyDm0zYZZ/+vqNvUwQD/AN89MN6GH4cHU5UitlJ
   W2M/cX7AV7VE0bkNFkNcg/+vlL2/eeYhed5xs1ksoZL11aTQYLw530i2K
   3t8X0/xj9j3Y3ZGZDrIXF3JczVFQf+0ipZ8lOhcUPeoK2ZhWi4W8/Sv+3
   FPTnLCcrIpnvLLKGantGuC2a37YDNbsmtpKwqJ2qAtGwmaZjwIKkOUJzQ
   9480Pq7tOcgCmR5ms2hpQaUBthCPREMuV6KQ9OjoTu4g4lFhYW43zxq4v
   KEEeYopbAv/15sjt5QSesW67DgSOQC8RAZyK/5HUNaRvxhT2UuQVj/Qp0
   A==;
X-CSE-ConnectionGUID: /lfpsJPKQfaQjk5Axx485g==
X-CSE-MsgGUID: +Dk0Dk1rRTSPzmYjAEoqPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="31291437"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="31291437"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 00:46:02 -0700
X-CSE-ConnectionGUID: 87D2YE3BTY+IyFn98x3vVQ==
X-CSE-MsgGUID: yMJ/o/KOSmWd3pkKOt329w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53574640"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2024 00:45:58 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXybJ-000qcq-2B;
	Sun, 28 Jul 2024 07:45:53 +0000
Date: Sun, 28 Jul 2024 15:45:53 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/iomem.c:18:32: sparse: sparse: cast truncates bits from
 constant value (38400000050e becomes 50e)
Message-ID: <202407281541.d1dk2Bne-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5437f30d3458ad36e83ab96088d490ebfee844d8
commit: 0453c9a78015cb2219cda7239d881f4e3137bff8 sh: mm: convert to GENERIC_IOREMAP
date:   12 months ago
config: sh-randconfig-r133-20240727 (https://download.01.org/0day-ci/archive/20240728/202407281541.d1dk2Bne-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240728/202407281541.d1dk2Bne-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407281541.d1dk2Bne-lkp@intel.com/

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
   arch/sh/boards/board-sh7785lcr.c:298:13: sparse: sparse: symbol 'init_sh7785lcr_IRQ' was not declared. Should it be static?
   arch/sh/boards/board-sh7785lcr.c:322:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *p @@     got void [noderef] __iomem * @@
   arch/sh/boards/board-sh7785lcr.c:322:11: sparse:     expected unsigned char *p
   arch/sh/boards/board-sh7785lcr.c:322:11: sparse:     got void [noderef] __iomem *
>> arch/sh/boards/board-sh7785lcr.c:328:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char *p @@
   arch/sh/boards/board-sh7785lcr.c:328:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/sh/boards/board-sh7785lcr.c:328:17: sparse:     got unsigned char *p
   arch/sh/boards/board-sh7785lcr.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/spi/spi-sh-sci.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/scatterlist.h, include/linux/spi/spi.h):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/spi/spi-nxp-fspi.c:513:25: sparse: sparse: cast from restricted __be32
   drivers/spi/spi-nxp-fspi.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/scsi/aacraid/rx.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/scsi/aacraid/nark.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/scsi/aacraid/rkt.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/scsi/aacraid/sa.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
--
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/src.c:146:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/aacraid/src.c:507:54: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/aacraid/src.c:545:57: sparse: sparse: bad assignment (+=) to restricted __le32
   drivers/scsi/aacraid/src.c:552:57: sparse: sparse: bad assignment (+=) to restricted __le32
   drivers/scsi/aacraid/src.c:560:49: sparse: sparse: bad assignment (+=) to restricted __le32
   drivers/scsi/aacraid/src.c:563:55: sparse: sparse: bad assignment (+=) to restricted __le32
   drivers/scsi/aacraid/src.c:804:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aacraid/src.c:804:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char * @@
   drivers/scsi/aacraid/src.c:804:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/scsi/aacraid/src.c:804:15: sparse:     got char *
   drivers/scsi/aacraid/src.c:804:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aacraid/src.c:806:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aacraid/src.c:806:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char * @@
   drivers/scsi/aacraid/src.c:806:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/scsi/aacraid/src.c:806:9: sparse:     got char *
   drivers/scsi/aacraid/src.c:806:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aacraid/src.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)

vim +18 kernel/iomem.c

5981690ddb8f72 Dan Williams 2018-03-29  14  
5981690ddb8f72 Dan Williams 2018-03-29  15  #ifndef arch_memremap_wb
5981690ddb8f72 Dan Williams 2018-03-29  16  static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
5981690ddb8f72 Dan Williams 2018-03-29  17  {
5981690ddb8f72 Dan Williams 2018-03-29 @18  	return (__force void *)ioremap_cache(offset, size);
5981690ddb8f72 Dan Williams 2018-03-29  19  }
5981690ddb8f72 Dan Williams 2018-03-29  20  #endif
5981690ddb8f72 Dan Williams 2018-03-29  21  

:::::: The code at line 18 was first introduced by commit
:::::: 5981690ddb8f72f9546a2d017a914cf56095fc1f memremap: split devm_memremap_pages() and memremap() infrastructure

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

