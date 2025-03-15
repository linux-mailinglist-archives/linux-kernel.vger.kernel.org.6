Return-Path: <linux-kernel+bounces-562534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB38A62AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887431788F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D81F5839;
	Sat, 15 Mar 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxbGmFhf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15A4A29
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034560; cv=none; b=MPk00hNYxbwMQrBnjau+4gs+i7c3ORusjVzOHsUauC+lZUqxAwu6p8ZAai4Ea+V/01CiYOO0iQnaHlLdmUR2dChA7jK03IdMvodSgLtKl2W47X5R0mpdSxdB2VKSv0SPU9bwiivxtpLvhJMc8H8cGAc1mQR8xEnbpvYv2KOmfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034560; c=relaxed/simple;
	bh=MnZrYtvQn9YX5y8dbDBUM8+iYJjgqkGdTLPpLJGi6HQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h3ytnus28JMg61NKauKclGnvnOGg1HsVUtW5+fkVnZUNJmBlYvxKZ6asxZuNSQprsAwAU6VvfH7SYloCRwQt1Q0MXPCJWzDbwcQGc02MRZ2ecakIh1WtNy6tyBCj+oLvCiWLniLEgngbxGd6UIbeE4hExIeGE9E+2mZwtMmQvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxbGmFhf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742034558; x=1773570558;
  h=date:from:to:cc:subject:message-id;
  bh=MnZrYtvQn9YX5y8dbDBUM8+iYJjgqkGdTLPpLJGi6HQ=;
  b=JxbGmFhfr6xBomnuH9wcaiLAIoHz/cCrobV0KadsjnDCWqxyAz//sFea
   o+iGOu0z7xQkKBgh518YB334EV7rueCyiUGm8OpQm9encUMtZX2waEWQX
   KETVkuqowOtZixdCEojhh5f4yShQ6upw5QVgJtzZqgB7+9qxADseQYUdl
   T4WMFsy0/jpulxNVMaFG7Qwjm2PJdWsXRkOowvK4MBZ9aGOE6s4wE23DE
   fqqCTIx8mduF1+uQKhB9SB85aaHILw3p8ZINpBY54S8xL3sP2T/o+OWFa
   KgCle2cC8RCU8ECMWH1A9c5iOIQkFtc9cjxQcIrstKqCECFHR/bTqFZNb
   Q==;
X-CSE-ConnectionGUID: YC7SPa+jRIeUn3/JaqRFsA==
X-CSE-MsgGUID: jxwBIrJRStKejMh+nIy1zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43392146"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="43392146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 03:29:17 -0700
X-CSE-ConnectionGUID: 7AWUXysxTqKG+rgoY5SwFQ==
X-CSE-MsgGUID: lEY74Q+UQn2rPqi+QfUzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="152396034"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Mar 2025 03:29:16 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttOlW-000BFU-0S;
	Sat, 15 Mar 2025 10:29:14 +0000
Date: Sat, 15 Mar 2025 18:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/merge] BUILD SUCCESS
 6290aec57fae99004d0ebf7e2e2076fa83532e5e
Message-ID: <202503151823.7tn0ttXO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/merge
branch HEAD: 6290aec57fae99004d0ebf7e2e2076fa83532e5e  Merge branch 'x86/headers' into timers/merge, to resolve conflicts

elapsed time: 1444m

configs tested: 87
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250314    gcc-13.2.0
arc                   randconfig-002-20250314    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250314    clang-21
arm                   randconfig-002-20250314    gcc-14.2.0
arm                   randconfig-003-20250314    gcc-14.2.0
arm                   randconfig-004-20250314    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250314    gcc-14.2.0
arm64                 randconfig-002-20250314    clang-21
arm64                 randconfig-003-20250314    clang-15
arm64                 randconfig-004-20250314    clang-21
csky                  randconfig-001-20250314    gcc-14.2.0
csky                  randconfig-002-20250314    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250314    clang-21
hexagon               randconfig-002-20250314    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250314    clang-19
i386        buildonly-randconfig-002-20250314    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-006-20250314    gcc-12
i386                                defconfig    clang-19
loongarch             randconfig-001-20250314    gcc-14.2.0
loongarch             randconfig-002-20250314    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250314    gcc-14.2.0
nios2                 randconfig-002-20250314    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250314    gcc-14.2.0
parisc                randconfig-002-20250314    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250314    clang-21
powerpc               randconfig-002-20250314    gcc-14.2.0
powerpc               randconfig-003-20250314    gcc-14.2.0
powerpc64             randconfig-001-20250314    gcc-14.2.0
powerpc64             randconfig-002-20250314    clang-17
powerpc64             randconfig-003-20250314    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250314    clang-19
riscv                 randconfig-002-20250314    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250314    gcc-14.2.0
s390                  randconfig-002-20250314    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250314    gcc-14.2.0
sh                    randconfig-002-20250314    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250314    gcc-14.2.0
sparc                 randconfig-002-20250314    gcc-14.2.0
sparc64               randconfig-001-20250314    gcc-14.2.0
sparc64               randconfig-002-20250314    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250314    gcc-12
um                    randconfig-002-20250314    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250314    clang-19
x86_64      buildonly-randconfig-002-20250314    clang-19
x86_64      buildonly-randconfig-003-20250314    gcc-12
x86_64      buildonly-randconfig-004-20250314    clang-19
x86_64      buildonly-randconfig-005-20250314    gcc-12
x86_64      buildonly-randconfig-006-20250314    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250314    gcc-14.2.0
xtensa                randconfig-002-20250314    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

