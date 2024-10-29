Return-Path: <linux-kernel+bounces-386295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B69B419E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588B21F2370E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB737200B96;
	Tue, 29 Oct 2024 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y98DRVRO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240121F4FA8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176966; cv=none; b=Y5m7G/nuIrBbYjyCBpVghWhRWQznZXFnLfjSlZfr8G1Kq4FXtDnYK7NW8FnBswAn/jDhFrxrQZfXWG24hrEgwi0X69HtA8blaUnDoNI8MhJAKrjZgcN85zD/Tkmd1lRiyZzCwkTIQ9+IA+VpkFhE9lM31Z3rRUPRofV69Z07oI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176966; c=relaxed/simple;
	bh=KQCOZau7OhpQ2F+0qsuPTSSx8QMm6ThsnF5cs3MBbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bTsyv4/9YP8T8UIAXASUXaLmnveOSc5x5y4z8yqGaX/6x9u0iZoNUNjoSxlkEsXaUBxk2B0xpXDkdaDarqyv32Lxb3Z1VLf8HQFkDaanFsAGBRoDw+WOx6sOCcmBHQ6avg+OL7oIVDj+5gX6VAk2iD6y1AFZFWvV35KCy/9T/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y98DRVRO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730176964; x=1761712964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KQCOZau7OhpQ2F+0qsuPTSSx8QMm6ThsnF5cs3MBbi0=;
  b=Y98DRVROx5mORXMmGZXri+TxmWn8VjbLpd3wYEiZvCqxqlIjfthZI60I
   mFQGD/KLqfC2yAlshaj+nI9w+fK8OYC030u6rXCHDPQtVV5ISmhAFsD+o
   bEuEtltMLPlmmeGYOPmS5DjeOquVCgj6Vw38WQwiHEY4Ng8mOAYqFEBmB
   8OC6ZbUyn8nl1ivuxWG0yeQacP7ZZRWx16HeSPr6nDjF7XwnMjHogz8JR
   9uaqf7pZ1uvm4vRptxBpajRlAM0L8Ebx+gC3Lgby/Tj8pT+Q41IJ1fWB6
   YEMEatIHLmUnluNWtowzpamU82uhdN9p+povlac39u78t1cSQVWzPsdwo
   Q==;
X-CSE-ConnectionGUID: Ekob5yDLTC6wVC2/c88myw==
X-CSE-MsgGUID: xb92+YHRRQGlf33P27aw5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52353812"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52353812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 21:42:43 -0700
X-CSE-ConnectionGUID: kWxdsO7xRlmf/e1KEoa5/g==
X-CSE-MsgGUID: FQsoShHFRWGBxyzSZ7+McQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81764511"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Oct 2024 21:42:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5e3z-000dG4-1O;
	Tue, 29 Oct 2024 04:42:39 +0000
Date: Tue, 29 Oct 2024 12:42:37 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/include/asm/cmpxchg.h:241:47: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202410291254.6OenFxNK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e42b1a9a2557aa94fee47f078633677198386a52
commit: 453924de6212ac159f946b75c6b59918e2e30944 afs: Overhaul invalidation handling to better support RO volumes
date:   10 months ago
config: powerpc64-randconfig-r111-20241029 (https://download.01.org/0day-ci/archive/20241029/202410291254.6OenFxNK-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241029/202410291254.6OenFxNK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291254.6OenFxNK-lkp@intel.com/

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

