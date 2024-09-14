Return-Path: <linux-kernel+bounces-329106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF1978D69
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DD91F24793
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B218B09;
	Sat, 14 Sep 2024 04:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5vnDLzC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F018E25
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289505; cv=none; b=tBuwsueMtfuRpJ0HJiaxSfFl0Behn4C0qk6HSghil+PlOk1EZyTf9dssRbn9AQOshGgBecl6RE9TXTF/5+fN/41NZ6Iv4TokNd2ZB7+u0vDG0TWe0LdRhss5k56zMzF3ltaLcQlV1/xeMBAEFDdQn+y/tQfJRNHsF/acgrWZx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289505; c=relaxed/simple;
	bh=bfIjfZkeRWlbuyAdkVpJDILEQcdLaSRjgJRuJiFYJro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jc/eBRLgXEC6fyIFXK9LYq13kggcszIKdylxkFBqh5uu+r/nExfxF5E3oBTe3p412K8904BgO7FraHrsAigneZ/zwkE1BDbhMoUslU8p7TtcEtQuOoyWVChf7SA72AEbyTKVPPX3TBTrlnEdMTU7HDPB8Dj+xkzbmmkTqhw3OTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5vnDLzC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726289502; x=1757825502;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bfIjfZkeRWlbuyAdkVpJDILEQcdLaSRjgJRuJiFYJro=;
  b=V5vnDLzCEIYSHsLlWOJzb7woiTwx6B89rgeu+IscK/Jlh6svGjLfSYA9
   pyKP/qNImX+YPd6Gm61s2zDrEPU7b/ZHdUaKqcByiI1jlGspn6x0Xe9Sm
   gzDRyya0can1FKDND9ugg8+3YPrKiam8Mmw/L61UdP3o8+geF1g3wP4cG
   HqiAxFtCCenZN9XgMVN2crQ6w/efV7A2/gon1NlJL57U/IrR+czerQK4o
   /zYeprpQGJoobOuqCBPAKM38k7lCbghIqdxUZL2HMWAsRuGtssz9QL2sa
   QLJOy8hpiEJnxpVfYe64JVcjy8FZCOCSLvFN9OApHAYdF0vUaQnfVH4Zd
   A==;
X-CSE-ConnectionGUID: mGyK0XdISuGPaJoCQNqLrg==
X-CSE-MsgGUID: 321RsIEzRli2BKe901wapQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25025904"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="25025904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 21:51:41 -0700
X-CSE-ConnectionGUID: BA2B1eS8Ruip4oicnfDI3Q==
X-CSE-MsgGUID: ctMZrdlZT4KQtAT61AWzbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="73062334"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Sep 2024 21:51:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spKkz-0007NO-2j;
	Sat, 14 Sep 2024 04:51:37 +0000
Date: Sat, 14 Sep 2024 12:51:34 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202409141258.oHu7Og9E-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b7718454f937f50f44f98c1222f5135eaef29132
commit: 453924de6212ac159f946b75c6b59918e2e30944 afs: Overhaul invalidation handling to better support RO volumes
date:   9 months ago
config: powerpc64-randconfig-r111-20240913 (https://download.01.org/0day-ci/archive/20240914/202409141258.oHu7Og9E-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce: (https://download.01.org/0day-ci/archive/20240914/202409141258.oHu7Og9E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141258.oHu7Og9E-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/afs/callback.c: note: in included file (through arch/powerpc/include/asm/pgtable-be-types.h, arch/powerpc/include/asm/page.h, arch/powerpc/include/asm/mmu.h, ...):
>> arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/include/asm/cmpxchg.h:243:48: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   fs/afs/callback.c:146:22: sparse: sparse: context imbalance in 'afs_lookup_volume_rcu' - different lock contexts for basic block
--
   fs/afs/rotate.c: note: in included file (through arch/powerpc/include/asm/pgtable-be-types.h, arch/powerpc/include/asm/page.h, arch/powerpc/include/asm/mmu.h, ...):
>> arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/include/asm/cmpxchg.h:243:48: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)

vim +241 arch/powerpc/include/asm/cmpxchg.h

ae3a197e3d0bfe David Howells 2012-03-28  235  
ae3a197e3d0bfe David Howells 2012-03-28  236  static __always_inline unsigned long
26760fc19a7e66 Boqun Feng    2015-12-15  237  __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
ae3a197e3d0bfe David Howells 2012-03-28  238  {
ae3a197e3d0bfe David Howells 2012-03-28  239  	switch (size) {
d0563a1297e234 Pan Xinhui    2016-04-27  240  	case 1:
d0563a1297e234 Pan Xinhui    2016-04-27 @241  		return __xchg_u8_relaxed(ptr, x);
d0563a1297e234 Pan Xinhui    2016-04-27  242  	case 2:
d0563a1297e234 Pan Xinhui    2016-04-27  243  		return __xchg_u16_relaxed(ptr, x);
ae3a197e3d0bfe David Howells 2012-03-28  244  	case 4:
26760fc19a7e66 Boqun Feng    2015-12-15  245  		return __xchg_u32_relaxed(ptr, x);
ae3a197e3d0bfe David Howells 2012-03-28  246  #ifdef CONFIG_PPC64
ae3a197e3d0bfe David Howells 2012-03-28  247  	case 8:
26760fc19a7e66 Boqun Feng    2015-12-15  248  		return __xchg_u64_relaxed(ptr, x);
ae3a197e3d0bfe David Howells 2012-03-28  249  #endif
ae3a197e3d0bfe David Howells 2012-03-28  250  	}
068550631fbe0b Andrzej Hajda 2023-01-18  251  	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_relaxed");
ae3a197e3d0bfe David Howells 2012-03-28  252  	return x;
ae3a197e3d0bfe David Howells 2012-03-28  253  }
9eaa82935dccb7 Mark Rutland  2021-05-25  254  #define arch_xchg_local(ptr,x)						     \
ae3a197e3d0bfe David Howells 2012-03-28  255    ({									     \
ae3a197e3d0bfe David Howells 2012-03-28  256       __typeof__(*(ptr)) _x_ = (x);					     \
26760fc19a7e66 Boqun Feng    2015-12-15  257       (__typeof__(*(ptr))) __xchg_local((ptr),				     \
26760fc19a7e66 Boqun Feng    2015-12-15  258       		(unsigned long)_x_, sizeof(*(ptr))); 			     \
ae3a197e3d0bfe David Howells 2012-03-28  259    })
ae3a197e3d0bfe David Howells 2012-03-28  260  

:::::: The code at line 241 was first introduced by commit
:::::: d0563a1297e234ed37f6b51c2e9321accebd1839 powerpc: Implement {cmp}xchg for u8 and u16

:::::: TO: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

