Return-Path: <linux-kernel+bounces-264590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C793E5B7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B551C20BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B603F548E1;
	Sun, 28 Jul 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpTF1mwA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58596548E0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722177851; cv=none; b=YsRaX7Eol3EHjs21us84e2kIlMIoPDqmtMicOejOeLfgWzIxuVSWgnEB7cRAtnEAi7fj4NIl4IPbLlY8j/APvpwL3UzQK09OOalarkZKraw+/jG4b5zils0P5ccO/ToT71QKuj3w2NsKqp9cMzcN2HJPXdf+f3lpA0hfooCbzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722177851; c=relaxed/simple;
	bh=w/v3YnBofyZNHsEcMe25l0OAYAAVhvA2Y6GCENl+Qws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qgnDIgsTciXKrUCt1zX0pMRz+rMwklrvfpy2K+maH9/PsUY4yXQ1x5m+LLOStma6pS+QynPUmw1yaD/fhKvkm45MA5OdWm6XkOA3wFjyqJhAzHav3Wwb5V9m7rOKb5LoW1fjDFuxEU2XzB9PAkrON4oyNHhoVCq+juGXLwhbH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpTF1mwA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722177849; x=1753713849;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w/v3YnBofyZNHsEcMe25l0OAYAAVhvA2Y6GCENl+Qws=;
  b=HpTF1mwADosWPnskp1aZMtR8zijnHbY6isV4BG3OqYkiGDg29YTr34FN
   VI5YxGgamt3awQ7y3gX/hDa1nI8LB1r6xkZOHEH+YFZnHHfq+ot2W8gBl
   dwus+uPkNI7ngiVxzi4PNgWr3tqRQGmQs60p2QgQYnQV5EVtqM5BYcJ5P
   gFzp3p3eGavcjSwJWL9tWox0SPq6ZjU2dA1J633Xc4HNcsLVKCwDO2FpV
   p7c+10w7+pzJ2dAnDKE7dROaSkOFYUUpE/DI1xEQ/13uXGWCh3Lu+khH+
   IOKgBMvdn3a1W6znF6H8OI5XR7aiCeOWaz013fajhwWYi+vqUBBWDaWK3
   g==;
X-CSE-ConnectionGUID: NsYn6u1jTH6iu7+MNqFYyA==
X-CSE-MsgGUID: ZkeMneR1Q7WEFK7nHpfuxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30528393"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="30528393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 07:44:08 -0700
X-CSE-ConnectionGUID: QjK0JcPfRCW6pA5ymGpX2A==
X-CSE-MsgGUID: SDwZWuAIRsmwdkixYTRVdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="58310102"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jul 2024 07:44:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY580-000qsw-35;
	Sun, 28 Jul 2024 14:44:04 +0000
Date: Sun, 28 Jul 2024 22:43:19 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/iomem.c:18:32: sparse: sparse: cast truncates bits from
 constant value (38400000050e becomes 50e)
Message-ID: <202407282201.lk1cNoMd-lkp@intel.com>
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
config: sh-randconfig-r133-20240727 (https://download.01.org/0day-ci/archive/20240728/202407282201.lk1cNoMd-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240728/202407282201.lk1cNoMd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407282201.lk1cNoMd-lkp@intel.com/

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
   drivers/scsi/esas2r/esas2r_init.c:908:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] length @@     got restricted __le32 [usertype] @@
   drivers/scsi/esas2r/esas2r_init.c:908:41: sparse:     expected unsigned int [usertype] length
   drivers/scsi/esas2r/esas2r_init.c:908:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/esas2r/esas2r_init.c:1164:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgl_page_size @@     got restricted __le32 [usertype] @@
   drivers/scsi/esas2r/esas2r_init.c:1164:35: sparse:     expected unsigned int [usertype] sgl_page_size
   drivers/scsi/esas2r/esas2r_init.c:1164:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/esas2r/esas2r_init.c:1166:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] epoch_time @@     got restricted __le32 [usertype] @@
   drivers/scsi/esas2r/esas2r_init.c:1166:32: sparse:     expected unsigned int [usertype] epoch_time
   drivers/scsi/esas2r/esas2r_init.c:1166:32: sparse:     got restricted __le32 [usertype]
   drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1178:41: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1181:38: sparse: sparse: cast to restricted __le16
   drivers/scsi/esas2r/esas2r_init.c:1196:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/esas2r/esas2r_init.c:1207:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ctl_len @@     got restricted __le32 [usertype] @@
   drivers/scsi/esas2r/esas2r_init.c:1207:56: sparse:     expected unsigned int [usertype] ctl_len
   drivers/scsi/esas2r/esas2r_init.c:1207:56: sparse:     got restricted __le32 [usertype]
   drivers/scsi/esas2r/esas2r_init.c:1209:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] address @@     got restricted __le64 [usertype] @@
   drivers/scsi/esas2r/esas2r_init.c:1209:56: sparse:     expected unsigned long long [usertype] address
   drivers/scsi/esas2r/esas2r_init.c:1209:56: sparse:     got restricted __le64 [usertype]
   drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1223:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c:1225:41: sparse: sparse: cast to restricted __le32
   drivers/scsi/esas2r/esas2r_init.c: note: in included file (through arch/sh/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
>> include/asm-generic/io.h:1089:41: sparse: sparse: cast truncates bits from constant value (384000000506 becomes 506)
   drivers/scsi/esas2r/esas2r_init.c:286:15: sparse: sparse: memset with byte count of 557736
   drivers/scsi/esas2r/esas2r_init.c: note: in included file:
   drivers/scsi/esas2r/esas2r.h:1260:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ppsense_buf @@     got restricted __le64 [usertype] @@
   drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     expected unsigned long long [usertype] ppsense_buf
   drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     got restricted __le64 [usertype]
   drivers/scsi/esas2r/esas2r.h:1260:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] ppsense_buf @@     got restricted __le64 [usertype] @@
   drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     expected unsigned long long [usertype] ppsense_buf
   drivers/scsi/esas2r/esas2r.h:1260:17: sparse:     got restricted __le64 [usertype]

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

