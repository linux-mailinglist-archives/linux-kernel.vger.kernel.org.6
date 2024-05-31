Return-Path: <linux-kernel+bounces-196815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F98D6212
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACC81F28F41
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917E1586D0;
	Fri, 31 May 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnpDO3Nq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D11EB2F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159531; cv=none; b=Ywlx4ZN57lGI5A9HQj/1Hx7rzIFSBJOCTVwbFbKml7Lv1DhBwpiYGbLANcc3r8F18G+ovh9qx9G+4nbyYttWPT62O62pbAV7n/3JMA+KuKehUanTLJJnp17zJB/p6aywZAFDMnBE1kJsAoJcAbWbV2rpx65Oy+abL29JT7a5M1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159531; c=relaxed/simple;
	bh=NZ/NfDrdDsPlqW54XHDYNMsEgEVJK03dPFzIqz10z7U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jy7At067+2ulNH626hT6BmIZkwGxlaD4rjXSprjZq6pwN3WnnTPz+upHTWw6Bl1yhFFIOqw74GqhQBDUu/IvHjD4kUE0oXZfyKtCHuyPGJzShPgNn0IQPA6yX3Xz4M+LQR6PhkuejjExiJ6/QnJYs97jMZG45309qA4rsXUTSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnpDO3Nq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717159530; x=1748695530;
  h=date:from:to:cc:subject:message-id;
  bh=NZ/NfDrdDsPlqW54XHDYNMsEgEVJK03dPFzIqz10z7U=;
  b=YnpDO3Nq1fETpz76M0gXoGyjvTy90VNjp0w16Yt14rKnBQp3Q6LVvObv
   z4TRQfqJClDtXvSono7WukDk9Q0/WM1KAHjjCt+WkxfQikQ73I7IspQN6
   m9DtVdokFqVj3rWkY12kLvSC9S3I4m3r6Po+PVgmEABmUzl67Ywce+m6z
   um6nJYdiposyfHdx2r7jhwOa66vM+5E6r9WhJ+WKoeJfnDcsjFiYKgZqa
   28E4NqxQ0hCD9aBApyXHUF+ZfTbt9rDDIczCiVa4Ws0brYkRttVokEHfv
   H0mhOrQsN6dSvxiDgGTOOsuXmlS1myR8hnAV/kk/4K90gIKEmur0RW8xh
   Q==;
X-CSE-ConnectionGUID: JiO6sl4XQFKH4ICd07iDDA==
X-CSE-MsgGUID: FrGT8NXiQYOFBTkivU65Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13517917"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13517917"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 05:45:27 -0700
X-CSE-ConnectionGUID: INYaHnvhQ1eAK/7BR8XOHQ==
X-CSE-MsgGUID: DrBZjvZfRJ22F99Bwydy5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36740331"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 31 May 2024 05:45:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD1dL-000H5R-0j;
	Fri, 31 May 2024 12:45:23 +0000
Date: Fri, 31 May 2024 20:45:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 2a38e4ca302280fdcce370ba2bee79bac16c4587
Message-ID: <202405312016.Jem4qdgJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 2a38e4ca302280fdcce370ba2bee79bac16c4587  x86/cpu: Provide default cache line size if not enumerated

elapsed time: 1259m

configs tested: 76
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240531   clang
i386         buildonly-randconfig-004-20240531   clang
i386         buildonly-randconfig-006-20240531   clang
i386                                defconfig   clang
i386                  randconfig-002-20240531   clang
i386                  randconfig-003-20240531   clang
i386                  randconfig-005-20240531   clang
i386                  randconfig-006-20240531   clang
i386                  randconfig-011-20240531   clang
i386                  randconfig-014-20240531   clang
i386                  randconfig-016-20240531   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240531   clang
x86_64       buildonly-randconfig-002-20240531   gcc  
x86_64       buildonly-randconfig-003-20240531   clang
x86_64       buildonly-randconfig-004-20240531   clang
x86_64       buildonly-randconfig-005-20240531   gcc  
x86_64       buildonly-randconfig-006-20240531   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240531   gcc  
x86_64                randconfig-002-20240531   clang
x86_64                randconfig-003-20240531   gcc  
x86_64                randconfig-004-20240531   gcc  
x86_64                randconfig-005-20240531   gcc  
x86_64                randconfig-006-20240531   gcc  
x86_64                randconfig-011-20240531   clang
x86_64                randconfig-012-20240531   gcc  
x86_64                randconfig-013-20240531   gcc  
x86_64                randconfig-014-20240531   clang
x86_64                randconfig-015-20240531   gcc  
x86_64                randconfig-016-20240531   gcc  
x86_64                randconfig-071-20240531   clang
x86_64                randconfig-072-20240531   gcc  
x86_64                randconfig-073-20240531   gcc  
x86_64                randconfig-074-20240531   gcc  
x86_64                randconfig-075-20240531   clang
x86_64                randconfig-076-20240531   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

