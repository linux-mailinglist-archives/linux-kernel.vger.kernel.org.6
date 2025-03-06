Return-Path: <linux-kernel+bounces-549813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E40A55784
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDEB1899C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B080270EC9;
	Thu,  6 Mar 2025 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fum7OIca"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E02702C7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293371; cv=none; b=PvOeXA13JZ/5C4DcYdDCvep9NSe+Llpmcxk1c7ioB8pYGNQwGEkr3gEcp/LqsIKSRBCfxFUCYj/aF4Cbp2bwV2VW18FADJ3Zi9iEQrPzVlfzs7YjTlgS5qUWmjLlgTPznmCPV2bYphN6JHRrCKGXRZrwJT5QXkbhh++uRnT7WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293371; c=relaxed/simple;
	bh=vAg8ZGzUWbx1ecs/23DGgF3jWaZ6KzDwT8vmxrpLap4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i3Kes1khNO/qCJ/tMqewx7HdN3WKwqHIitAKYOW8v68vxVGFMpQbMr76zKXmdUIXJgsSUP07fEi5AGDDB6jauYgxerd0sMKV/+DgQGBW9XnDaXPpC7oLWqhvsl2/USOkSqOZqyi6rammXK2w3GKqSEq3L1JCXGcda0NAvTwh8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fum7OIca; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741293369; x=1772829369;
  h=date:from:to:cc:subject:message-id;
  bh=vAg8ZGzUWbx1ecs/23DGgF3jWaZ6KzDwT8vmxrpLap4=;
  b=Fum7OIcaKYvxxCilnLqYx/YaXciLYVfTmaVnqof6GdtEHWR/DAaxwULx
   Da+x7ny+pDaepqjtFeVddgnakhnCOo2QtzhRzWWSAxpubB14fKl9y/guf
   6jJ/LU+MBbT6eYshagNCSZwjZ3qNKDm1T7w0ijqZIh12hqi+MeNhhhBJj
   K8QAXrngDmJLCuuwlyhv6RqJWgPtXCh1VlxzGE7rX2wa4CUkBjkxuDuaD
   GG/pDSd1t9jAREhhm3yVYkO31m7kj7lx4OOvDk5Z6xaZKqSxK/cQ0z7jZ
   dVHjjDtNh33IJPLj44mNaSQUN7cUGqvvCYEk1Mw7osXUnc7PPwo5DSkY/
   w==;
X-CSE-ConnectionGUID: V/6Ku0kVQoqyVQm910S1TA==
X-CSE-MsgGUID: jKMARI6cRtmdKVyPhRVyCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42462571"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42462571"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:36:09 -0800
X-CSE-ConnectionGUID: V7ETCB+kQ9iwqSFrsR0F1A==
X-CSE-MsgGUID: Edq6FtpwSVSgjuRoJk2M5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156352658"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Mar 2025 12:36:08 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqHwr-000NaA-1d;
	Thu, 06 Mar 2025 20:36:05 +0000
Date: Fri, 07 Mar 2025 04:35:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.03.04a] BUILD SUCCESS
 21b5d0da513fd5e8621c4650ed03e481373ff73c
Message-ID: <202503070433.cr24eL8S-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.03.04a
branch HEAD: 21b5d0da513fd5e8621c4650ed03e481373ff73c  sched: Disable DL server if sysctl_sched_rt_runtime is -1

elapsed time: 1665m

configs tested: 73
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                 randconfig-001-20250306    gcc-14.2.0
csky                 randconfig-002-20250306    gcc-14.2.0
hexagon              randconfig-001-20250306    clang-21
hexagon              randconfig-002-20250306    clang-19
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
i386       buildonly-randconfig-006-20250307    clang-19
loongarch            randconfig-001-20250306    gcc-14.2.0
loongarch            randconfig-002-20250306    gcc-14.2.0
nios2                randconfig-001-20250306    gcc-14.2.0
nios2                randconfig-002-20250306    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250306    gcc-14.2.0
parisc               randconfig-002-20250306    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250306    clang-21
powerpc              randconfig-002-20250306    clang-18
powerpc              randconfig-003-20250306    gcc-14.2.0
powerpc64            randconfig-001-20250306    clang-18
powerpc64            randconfig-002-20250306    clang-21
powerpc64            randconfig-003-20250306    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

