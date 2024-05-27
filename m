Return-Path: <linux-kernel+bounces-190405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBBF8CFDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223241F2498C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6320013AA51;
	Mon, 27 May 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz/sxKoe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8D13AA4C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804684; cv=none; b=F0/N0d8ig4mzB24dOcpTgktaaJAuQ115lPgEly9OYNtzuOwjSCMHS1Hz5HBSj4cVOZvBs/FWKD+bApHVYjuNsEbMLE89fPXJJyPQ+mPECDpWngLu8cY1aOx7qv5NpsxWrLV1VlM+WiOWGixRI+ei1nGx8ujCcMFhrV3Q0q7Uapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804684; c=relaxed/simple;
	bh=iF1e4OR68r7uRH5SuttU2xbWS5C5hLwh9sBP8FO+9lM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n3pim411Pei9Hl/rReKmL07v2UmSjdDOsNzQ3/Sm5BonA8ajkoXMsNfY22Tt1SrerVvlXuJc1/7BLhb9bfVFdPNvVzkIjllMoAd0T1sS1cQDTio0fwpnCrh0NjGaZOeagoINcBf+nXptQZb/irPvnCpkv0dRW+i7m5DZTzag50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz/sxKoe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716804683; x=1748340683;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iF1e4OR68r7uRH5SuttU2xbWS5C5hLwh9sBP8FO+9lM=;
  b=Jz/sxKoeH4pXPc4WNyb7psMFXPuyGKxuw+n2vPPS7YjXWJu+IB8EJxE1
   n03XO+n7ZdPcfg0nVEOp5ths7ELBbEY/9pLa67Mfwc57MKuY21kBu+pGq
   RwhkMyFQ6gFKOaXkW+X3kJoWic4UI9gzPTOc94COSLRKLhK0WN5REGApb
   p3obQF8bt3EgJfCB4DPlxoGoE3MZf/umHvRP06GtUmLmtDPmRVma6liCk
   wzTidEADmpf3WxiDUd4jYQW4Z1m52+g9RtejEhyjpme/g0aD08ku/3Hjx
   kwV2Px39I+29nIqibrvVNfdaPU588UsSZyhwG6fxsnHMlEl++nU4NHNm9
   g==;
X-CSE-ConnectionGUID: xfUgWG1SQGmagW/havErbg==
X-CSE-MsgGUID: NtT1rdsXTDubbsp1siC9vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23680786"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="23680786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:11:13 -0700
X-CSE-ConnectionGUID: EX1qWCtdSXG5ocjR6v65wg==
X-CSE-MsgGUID: OmnGnyXPTiG7dDZNxHRB0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="65939837"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 03:11:11 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBXJs-0009yf-2Y;
	Mon, 27 May 2024 10:11:08 +0000
Date: Mon, 27 May 2024 18:11:07 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/tty/mxser.c:291:2: warning: 'counted_by' should not be
 applied to an array with element of unknown size because 'struct mxser_port'
 is a struct type with a flexible array member. This will be an error in a
 future compiler version
Message-ID: <202405271811.Mp20bWge-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
commit: f34907ecca71177a438bc1f1012e945326f707c3 mxser: Annotate struct mxser_board with __counted_by
date:   8 months ago
config: s390-randconfig-002-20240527 (https://download.01.org/0day-ci/archive/20240527/202405271811.Mp20bWge-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405271811.Mp20bWge-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405271811.Mp20bWge-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/mxser.c:18:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2168:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/tty/mxser.c:24:
   In file included from include/linux/tty.h:12:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/tty/mxser.c:24:
   In file included from include/linux/tty.h:12:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/tty/mxser.c:24:
   In file included from include/linux/tty.h:12:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/tty/mxser.c:291:2: warning: 'counted_by' should not be applied to an array with element of unknown size because 'struct mxser_port' is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
     291 |         struct mxser_port ports[] __counted_by(nports);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   14 warnings generated.


vim +291 drivers/tty/mxser.c

   281	
   282	struct mxser_board {
   283		unsigned int idx;
   284		unsigned short nports;
   285		int irq;
   286		unsigned long vector;
   287	
   288		enum mxser_must_hwid must_hwid;
   289		speed_t max_baud;
   290	
 > 291		struct mxser_port ports[] __counted_by(nports);
   292	};
   293	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

