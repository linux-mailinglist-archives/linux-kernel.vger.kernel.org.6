Return-Path: <linux-kernel+bounces-425247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5859DBF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871F0B21E61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172E156886;
	Fri, 29 Nov 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvztqU4h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36B15575E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859841; cv=none; b=oreb319b9FbuyyGSh0BOYbQci75iz2SaisPT5dnasntD0d5nffldq47oez6uvifofgP3/WGxY+c3vzN0m83rgU6XCBIyFLa3APUj1K3YT7kz8aG8LTAPDjc2oGmUvZ8g4/u2dh2s6dl0J5dfSbD+4MYCKOCawyPhjtO2du4QcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859841; c=relaxed/simple;
	bh=BiyPOYVcnRkzkIbrQIwXy04cfsOkp2i9FaI4uUtLlKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V9UxHUX/XbBcvs/1q9hIHHJ31qzePdNQtTDRelUiQwy+ZO/MSpPXtabzH+SvTKZd494zj2VPwxXQuUmq0rSDcnkZ4EXvGIYWjnw/UI0fKyQ4mzXr91OKtj5VnrUVAEnrivTBgOJ+m/wi/DbNWkQ7dM+y5oIVY/COdxwlHKRdTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvztqU4h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732859840; x=1764395840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BiyPOYVcnRkzkIbrQIwXy04cfsOkp2i9FaI4uUtLlKQ=;
  b=GvztqU4hgQFzUEOlBSvvktC22LSwagrMXbQLdnZm+PhtwGOveKkuR2TB
   8lipRfZ16U9U5EyTXaWJ9+JW0x+SqCTS237lsHLlN0oABnEHJJ4guGwGP
   FuJd9haebCff4ti7BdMZXuL7Or2vzAQNGpm54fT1fIoP4YVoQTvxPBSqR
   lCvro6mGQh3GVvPHeQCAOStNgiFc07QUpJQi1yotW51f51Ss1bWPfk1VL
   QeYx3SumcWAVGrUZ6LQ8uqxI4qtYPE1EcR7WoDlhnF11DtTEB3AXW/2ys
   zOG2e0SZt6JnzuXn7mMmErmMEpYqbL13V/Axrwo0Azg3SjNgdtFwEzWJI
   Q==;
X-CSE-ConnectionGUID: FDb+M7bnSDeqNSORAyntmA==
X-CSE-MsgGUID: Y2+47JJkQTmqyjOPlUWo+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="37024708"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="37024708"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 21:57:13 -0800
X-CSE-ConnectionGUID: xVKf3n8ER+iOiKkwfX0JDQ==
X-CSE-MsgGUID: 4O6KkV3GRSCjAZ4gvJL7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="97373406"
Received: from lkp-server01.sh.intel.com (HELO 5e2646291792) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Nov 2024 21:57:12 -0800
Received: from kbuild by 5e2646291792 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGu05-00002X-2d;
	Fri, 29 Nov 2024 05:57:09 +0000
Date: Fri, 29 Nov 2024 13:57:05 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202411291301.fqIf68PA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08b57bcb9ebf78675c50069c54125c0a8b795
commit: 453924de6212ac159f946b75c6b59918e2e30944 afs: Overhaul invalidation handling to better support RO volumes
date:   11 months ago
config: powerpc64-randconfig-r112-20241118 (https://download.01.org/0day-ci/archive/20241129/202411291301.fqIf68PA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241129/202411291301.fqIf68PA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291301.fqIf68PA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/afs/callback.c: note: in included file (through arch/powerpc/include/asm/atomic.h, arch/powerpc/include/asm/paca.h, arch/powerpc/include/asm/current.h, ...):
>> arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/include/asm/cmpxchg.h:243:48: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   fs/afs/callback.c:146:22: sparse: sparse: context imbalance in 'afs_lookup_volume_rcu' - different lock contexts for basic block
--
   fs/afs/rotate.c: note: in included file (through arch/powerpc/include/asm/atomic.h, arch/powerpc/include/asm/paca.h, arch/powerpc/include/asm/current.h, ...):
>> arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/include/asm/cmpxchg.h:243:48: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)

vim +241 arch/powerpc/include/asm/cmpxchg.h

ae3a197e3d0bfe3 David Howells 2012-03-28  235  
ae3a197e3d0bfe3 David Howells 2012-03-28  236  static __always_inline unsigned long
26760fc19a7e663 Boqun Feng    2015-12-15  237  __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
ae3a197e3d0bfe3 David Howells 2012-03-28  238  {
ae3a197e3d0bfe3 David Howells 2012-03-28  239  	switch (size) {
d0563a1297e234e Pan Xinhui    2016-04-27  240  	case 1:
d0563a1297e234e Pan Xinhui    2016-04-27 @241  		return __xchg_u8_relaxed(ptr, x);
d0563a1297e234e Pan Xinhui    2016-04-27  242  	case 2:
d0563a1297e234e Pan Xinhui    2016-04-27  243  		return __xchg_u16_relaxed(ptr, x);
ae3a197e3d0bfe3 David Howells 2012-03-28  244  	case 4:
26760fc19a7e663 Boqun Feng    2015-12-15  245  		return __xchg_u32_relaxed(ptr, x);
ae3a197e3d0bfe3 David Howells 2012-03-28  246  #ifdef CONFIG_PPC64
ae3a197e3d0bfe3 David Howells 2012-03-28  247  	case 8:
26760fc19a7e663 Boqun Feng    2015-12-15  248  		return __xchg_u64_relaxed(ptr, x);
ae3a197e3d0bfe3 David Howells 2012-03-28  249  #endif
ae3a197e3d0bfe3 David Howells 2012-03-28  250  	}
068550631fbe0b7 Andrzej Hajda 2023-01-18  251  	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_relaxed");
ae3a197e3d0bfe3 David Howells 2012-03-28  252  	return x;
ae3a197e3d0bfe3 David Howells 2012-03-28  253  }
9eaa82935dccb74 Mark Rutland  2021-05-25  254  #define arch_xchg_local(ptr,x)						     \
ae3a197e3d0bfe3 David Howells 2012-03-28  255    ({									     \
ae3a197e3d0bfe3 David Howells 2012-03-28  256       __typeof__(*(ptr)) _x_ = (x);					     \
26760fc19a7e663 Boqun Feng    2015-12-15  257       (__typeof__(*(ptr))) __xchg_local((ptr),				     \
26760fc19a7e663 Boqun Feng    2015-12-15  258       		(unsigned long)_x_, sizeof(*(ptr))); 			     \
ae3a197e3d0bfe3 David Howells 2012-03-28  259    })
ae3a197e3d0bfe3 David Howells 2012-03-28  260  

:::::: The code at line 241 was first introduced by commit
:::::: d0563a1297e234ed37f6b51c2e9321accebd1839 powerpc: Implement {cmp}xchg for u8 and u16

:::::: TO: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

