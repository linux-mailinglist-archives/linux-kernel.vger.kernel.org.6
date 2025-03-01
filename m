Return-Path: <linux-kernel+bounces-540076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB10BA4AD57
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368FF16EAC7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8C1E3DE5;
	Sat,  1 Mar 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFroAZXu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F58494
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853697; cv=none; b=pXycjKpWt2MHUh6YnMtGgkvZZlgY7RUvztsQk0I+ISPSs8RlbilhYRDoRO8hVXI8MV3sfl8KX7wTPWCSG25cXoRb2Xpa5XL9LHhvlEM32mko2U2rT8NQhaVkzdYq9PSVblPBzFf8LJCfYjbt0YjqQVDtvqeIvnz2Ks6BxOnaWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853697; c=relaxed/simple;
	bh=dJf+HMWGk7CdzmhSxBAOuYKx6KFCFvhsX21yszjN19k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NhJjaTuuO1fHtTTsrcJ7mujaJAg1McQocZH4M0JvI7cf5XwzPDrgwSqJ2uc7jt3PC2jlSiB1X2F6Z4UzHDlis/jNeZ9CNo/ugxU+52ccMGsJIABywP/1DMzMv3V7wJMsBDMbA/YDzQtGABmVbife1VtvZ5F2dEqKYQ3e1aKA5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFroAZXu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740853695; x=1772389695;
  h=date:from:to:cc:subject:message-id;
  bh=dJf+HMWGk7CdzmhSxBAOuYKx6KFCFvhsX21yszjN19k=;
  b=gFroAZXu1Z8XUz/KoIeWUFaDGhmBTsSriqhLLO8aQnhUgw/m79reol0N
   axWcDd15SUguTQ9EpAk08WlW6jwjzCnCrZwzJT1UpNHFRcO6iKxSPMFVR
   Ubojzl0PzhkbTn+Dktisvnta5+nwXX55XoCxlHJHbME+amjOioWhiDnnU
   IjF4WXRCy0VDzdB1sP2YPNrAHWLe6z/ZYFRs7VQWzbdB+jnWr2vo4h4HI
   DZMlfb2ncLHFKK+0Az2/JsqfWqocdTpWDlsdz1H6qMQbMPmvIZCCPRzAg
   cidgJzisS7ECOdfJL7D6U0TxuBUxaz8L7gtt4iYMtT2dhC22pPSI4Xmku
   Q==;
X-CSE-ConnectionGUID: kw8Ay2rqSSmgji6JtrmAsA==
X-CSE-MsgGUID: +QajHtOOQea22Rfpqz7Uxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="42014952"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="42014952"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:28:14 -0800
X-CSE-ConnectionGUID: CHwU4Fr6R+6NOcfuEeWBpA==
X-CSE-MsgGUID: XSSnOCigRgeSGtJCWPEebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117807785"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2025 10:28:13 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRZK-000GYo-31;
	Sat, 01 Mar 2025 18:28:11 +0000
Date: Sun, 02 Mar 2025 02:26:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 fd5935f9c20431eeadd6993fd4d2672e3e17a6b8
Message-ID: <202503020210.HJ4ExkdY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: fd5935f9c20431eeadd6993fd4d2672e3e17a6b8  x86/mm: Check return value from memblock_phys_alloc_range()

elapsed time: 1454m

configs tested: 63
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250301    gcc-13.2.0
arc                  randconfig-002-20250301    gcc-13.2.0
arm                  randconfig-001-20250301    gcc-14.2.0
arm                  randconfig-002-20250301    gcc-14.2.0
arm                  randconfig-003-20250301    clang-21
arm                  randconfig-004-20250301    clang-21
arm64                randconfig-001-20250301    gcc-14.2.0
arm64                randconfig-002-20250301    clang-21
arm64                randconfig-003-20250301    clang-15
arm64                randconfig-004-20250301    clang-17
csky                 randconfig-001-20250301    gcc-14.2.0
csky                 randconfig-002-20250301    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250301    clang-21
hexagon              randconfig-002-20250301    clang-21
i386       buildonly-randconfig-001-20250301    clang-19
i386       buildonly-randconfig-002-20250301    clang-19
i386       buildonly-randconfig-003-20250301    clang-19
i386       buildonly-randconfig-004-20250301    clang-19
i386       buildonly-randconfig-005-20250301    gcc-12
i386       buildonly-randconfig-006-20250301    clang-19
loongarch            randconfig-001-20250301    gcc-14.2.0
loongarch            randconfig-002-20250301    gcc-14.2.0
nios2                randconfig-001-20250301    gcc-14.2.0
nios2                randconfig-002-20250301    gcc-14.2.0
parisc               randconfig-001-20250301    gcc-14.2.0
parisc               randconfig-002-20250301    gcc-14.2.0
powerpc              randconfig-001-20250301    clang-17
powerpc              randconfig-002-20250301    clang-19
powerpc              randconfig-003-20250301    clang-21
powerpc64            randconfig-001-20250301    gcc-14.2.0
powerpc64            randconfig-002-20250301    clang-21
powerpc64            randconfig-003-20250301    gcc-14.2.0
riscv                randconfig-001-20250301    gcc-14.2.0
riscv                randconfig-002-20250301    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250301    clang-15
s390                 randconfig-002-20250301    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250301    gcc-14.2.0
sh                   randconfig-002-20250301    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250301    gcc-14.2.0
sparc                randconfig-002-20250301    gcc-14.2.0
sparc64              randconfig-001-20250301    gcc-14.2.0
sparc64              randconfig-002-20250301    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250301    gcc-12
um                   randconfig-002-20250301    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250301    clang-19
x86_64     buildonly-randconfig-002-20250301    clang-19
x86_64     buildonly-randconfig-003-20250301    gcc-11
x86_64     buildonly-randconfig-004-20250301    gcc-12
x86_64     buildonly-randconfig-005-20250301    gcc-12
x86_64     buildonly-randconfig-006-20250301    clang-19
xtensa               randconfig-001-20250301    gcc-14.2.0
xtensa               randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

