Return-Path: <linux-kernel+bounces-536945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC748A48615
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE857A64D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1BD1D5AD8;
	Thu, 27 Feb 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWriXBF4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750331D5AD3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675827; cv=none; b=ukXBX6RcJbeqnyYqcjrhV7WbnRrERBopjjpRZ9IIGGQiVKxVAmxC7e8ONuNVUYhVLLWRHODRb8h31TC5YE7nuKNdRPkJVj5+IuFb9O8+n1Q4S4Kcluq0tE34/m2nnlirJNoh5g45IHdkQCd9879rtr3qw2O3tTki1+GIH7P0m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675827; c=relaxed/simple;
	bh=HyDFN6xw3L7gjV6hkEPJk7jFVE7JOo+iGRLmVcSzufI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fTbKJgddEFH5eiQ2KiVDXdTNy4w6nrYjWDaWz1MgpIi0ORbaGkEqrrc4E4gvnx7AtWxQnSAghuCRTP3a7WkD4O6k5/RID5zqj5hKsU9xfHnd6CQ62jCEz0OcNBI61+E1/suXtCg1qfzRKZhl3bCmhJhGWpyCqNWMa7PlVgV89sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWriXBF4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740675825; x=1772211825;
  h=date:from:to:cc:subject:message-id;
  bh=HyDFN6xw3L7gjV6hkEPJk7jFVE7JOo+iGRLmVcSzufI=;
  b=MWriXBF45NpcO7+00GUIv3/uQqtJ1jx9LO6eTc9q9O16T0FL6+GU8kSo
   ZHQ/iPuQ4OMKIFVz5CNFT5TfD2azH+tzJ1lSZJzhGWDPJgKVQFx2nQ6KA
   TN2k2U+8rccTmHcMBwX1HNUuZGYPdOJ3eRjUYVDe3zoGt9ws6G/5R54Ml
   aoS+G9drDBvUq5zlDBU2NaYpcuycWA5FDF0oKM2UwKR/VSTLGBMkfPd7S
   Xa+QBJs3A9oTKidknKBu8f9kVnPdPKHWOdgNdkwJkux5legt40O5V49yK
   1hIvjElLhqeQqM7bS//ee5LOWjRi/UeYF5tE6zrrfq7sXPAJIu0ipByLx
   w==;
X-CSE-ConnectionGUID: G1grKYFIQs6JevvrwZL64Q==
X-CSE-MsgGUID: FBbwYDQ3SdKBvvkE8yPTCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="29182981"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="29182981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:03:44 -0800
X-CSE-ConnectionGUID: 1OjeLMbdRK2AFbU/Z0Khmw==
X-CSE-MsgGUID: vHuAQYa+R9eQu3m1rz2k4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117609378"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 09:03:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnhIT-000DkO-0u;
	Thu, 27 Feb 2025 17:03:41 +0000
Date: Fri, 28 Feb 2025 01:03:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 7a6b158e00c862ccfa7fe447682bd0bf5c229c73
Message-ID: <202502280117.N7xXHN03-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 7a6b158e00c862ccfa7fe447682bd0bf5c229c73  posix-clock: Remove duplicate compat ioctl() handler

elapsed time: 1453m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250227    gcc-13.2.0
arc                  randconfig-002-20250227    gcc-13.2.0
arm                  randconfig-001-20250227    gcc-14.2.0
arm                  randconfig-002-20250227    clang-17
arm                  randconfig-003-20250227    gcc-14.2.0
arm                  randconfig-004-20250227    clang-21
arm64                randconfig-001-20250227    gcc-14.2.0
arm64                randconfig-002-20250227    clang-19
arm64                randconfig-003-20250227    gcc-14.2.0
arm64                randconfig-004-20250227    gcc-14.2.0
csky                 randconfig-001-20250227    gcc-14.2.0
csky                 randconfig-002-20250227    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250227    clang-14
hexagon              randconfig-002-20250227    clang-16
i386       buildonly-randconfig-001-20250227    gcc-12
i386       buildonly-randconfig-002-20250227    gcc-11
i386       buildonly-randconfig-003-20250227    clang-19
i386       buildonly-randconfig-004-20250227    gcc-12
i386       buildonly-randconfig-005-20250227    gcc-11
i386       buildonly-randconfig-006-20250227    clang-19
loongarch            randconfig-001-20250227    gcc-14.2.0
loongarch            randconfig-002-20250227    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250227    gcc-14.2.0
nios2                randconfig-002-20250227    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250227    gcc-14.2.0
parisc               randconfig-002-20250227    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250227    clang-19
powerpc              randconfig-002-20250227    gcc-14.2.0
powerpc              randconfig-003-20250227    clang-19
powerpc64            randconfig-001-20250227    clang-17
powerpc64            randconfig-002-20250227    clang-21
powerpc64            randconfig-003-20250227    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250227    gcc-14.2.0
riscv                randconfig-002-20250227    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250227    clang-18
s390                 randconfig-002-20250227    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250227    gcc-14.2.0
sh                   randconfig-002-20250227    gcc-14.2.0
sparc                randconfig-001-20250227    gcc-14.2.0
sparc                randconfig-002-20250227    gcc-14.2.0
sparc64              randconfig-001-20250227    gcc-14.2.0
sparc64              randconfig-002-20250227    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250227    clang-17
um                   randconfig-002-20250227    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250227    clang-19
x86_64     buildonly-randconfig-002-20250227    clang-19
x86_64     buildonly-randconfig-003-20250227    gcc-12
x86_64     buildonly-randconfig-004-20250227    gcc-12
x86_64     buildonly-randconfig-005-20250227    clang-19
x86_64     buildonly-randconfig-006-20250227    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250227    gcc-14.2.0
xtensa               randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

