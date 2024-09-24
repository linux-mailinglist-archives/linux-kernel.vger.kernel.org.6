Return-Path: <linux-kernel+bounces-336566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC7983C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B61C21CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8C40BF2;
	Tue, 24 Sep 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3H/Iqch"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF845005
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156407; cv=none; b=PpR/gpx7h3sYzFjo1csHT1KlRUEapGO0dQ8TQuxxpzgJtjTKD+NtiWUAZNc+EK0kOK6911EqwESHUpPj1KqlKOhIMsJ9nAiP0JfQ5ojyet91Nz92dmeuvW5aVx7gJ124YUmKO379diny0Vj50NugzQTR7/oA9dtsD5KUPpfwZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156407; c=relaxed/simple;
	bh=a/Tbi+R9Tf2RIYas84kAF2nAlMF4Day5msdi0tI0imQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ax8E58IKivfnK5gKlzwrr+swLPcD1+QyrbgKSd0XaxOxn2rTrGLUl00bfIbKFCnFrtrlnypUbfulsVb5sWxX79LjcKvUEK7uGlE8qQCgFN1MzNW9J26Sua/4GKJf7Ar/YcEet3IwuUNI/deTH0VhhpatzRXreGMFMUb8XtuFces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3H/Iqch; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727156406; x=1758692406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a/Tbi+R9Tf2RIYas84kAF2nAlMF4Day5msdi0tI0imQ=;
  b=I3H/Iqchc5mHoIFfTIRdmNB6Zqy/KqXIK41G7SSK3Ofju2iWdZe0ZHkX
   8LnW6Fp8q1GVLLgDr9ppfdO2pL5tLilDJ2Y9tnsVTy6wzyQuwjSqqtv9F
   VFSdGYoWBrY9Tq200swyF4LKe0z4e3w+BWVec3+LEMe6J0t/jQ34FKnxz
   hFMYmymNWVOrP3ZqJ/bbBLCPwc+GtMnR03nHnXE+/Lsssan5oh6hCAid4
   csgP8cFEbIwglwasgrfwLb8I4XrbTmZDobP1B+jNZrOJuy/MSH2JEvhIL
   +6DHk4ErNJeKOd2O5ct0auLKdrgUtuRfJTIZTY53OdpgYEmiGeGRWqmJZ
   A==;
X-CSE-ConnectionGUID: ABLpr58OSRaqiraErf2X/g==
X-CSE-MsgGUID: ECXQQR8+Sdq/Nv808yTyBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36702115"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="36702115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 22:40:05 -0700
X-CSE-ConnectionGUID: AUb8naOzSBmlKGzcrrHb1A==
X-CSE-MsgGUID: SoHkh85aQb2aWi2ExSX0fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="75697209"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Sep 2024 22:40:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssyHH-000Hyv-2O;
	Tue, 24 Sep 2024 05:39:59 +0000
Date: Tue, 24 Sep 2024 13:39:53 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/loongarch/include/asm/cmpxchg.h:70:42: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202409241307.hzwOrV5I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   abf2050f51fdca0fd146388f83cddd95a57a008d
commit: 453924de6212ac159f946b75c6b59918e2e30944 afs: Overhaul invalidation handling to better support RO volumes
date:   9 months ago
config: loongarch-randconfig-r121-20240922 (https://download.01.org/0day-ci/archive/20240924/202409241307.hzwOrV5I-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240924/202409241307.hzwOrV5I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409241307.hzwOrV5I-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/afs/callback.c: note: in included file (through arch/loongarch/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/loongarch/include/asm/cmpxchg.h:70:42: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/loongarch/include/asm/cmpxchg.h:73:24: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   fs/afs/callback.c:146:22: sparse: sparse: context imbalance in 'afs_lookup_volume_rcu' - different lock contexts for basic block
--
   fs/afs/rotate.c: note: in included file (through arch/loongarch/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/loongarch/include/asm/cmpxchg.h:70:42: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/loongarch/include/asm/cmpxchg.h:73:24: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)

vim +70 arch/loongarch/include/asm/cmpxchg.h

720dc7ab252bbd Huacai Chen   2022-08-25  63  
ddf502717da029 Huacai Chen   2022-10-12  64  static __always_inline unsigned long
068550631fbe0b Andrzej Hajda 2023-01-18  65  __arch_xchg(volatile void *ptr, unsigned long x, int size)
5b0b14e550a006 Huacai Chen   2022-05-31  66  {
5b0b14e550a006 Huacai Chen   2022-05-31  67  	switch (size) {
720dc7ab252bbd Huacai Chen   2022-08-25  68  	case 1:
720dc7ab252bbd Huacai Chen   2022-08-25  69  	case 2:
720dc7ab252bbd Huacai Chen   2022-08-25 @70  		return __xchg_small(ptr, x, size);
720dc7ab252bbd Huacai Chen   2022-08-25  71  
5b0b14e550a006 Huacai Chen   2022-05-31  72  	case 4:
5b0b14e550a006 Huacai Chen   2022-05-31  73  		return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
5b0b14e550a006 Huacai Chen   2022-05-31  74  
5b0b14e550a006 Huacai Chen   2022-05-31  75  	case 8:
5b0b14e550a006 Huacai Chen   2022-05-31  76  		return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
5b0b14e550a006 Huacai Chen   2022-05-31  77  
5b0b14e550a006 Huacai Chen   2022-05-31  78  	default:
5b0b14e550a006 Huacai Chen   2022-05-31  79  		BUILD_BUG();
5b0b14e550a006 Huacai Chen   2022-05-31  80  	}
5b0b14e550a006 Huacai Chen   2022-05-31  81  
5b0b14e550a006 Huacai Chen   2022-05-31  82  	return 0;
5b0b14e550a006 Huacai Chen   2022-05-31  83  }
5b0b14e550a006 Huacai Chen   2022-05-31  84  

:::::: The code at line 70 was first introduced by commit
:::::: 720dc7ab252bbdf404cab7b909e26b31e602bf7e LoongArch: Add subword xchg/cmpxchg emulation

:::::: TO: Huacai Chen <chenhuacai@loongson.cn>
:::::: CC: Huacai Chen <chenhuacai@loongson.cn>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

