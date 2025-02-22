Return-Path: <linux-kernel+bounces-527091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A4A40731
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2F700C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F933207A26;
	Sat, 22 Feb 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXvWdSYF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18144207A1D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218280; cv=none; b=LiXNYEIMH2ubkVRn8tp+uC0PMusiF7mFObwWgrDz2BKL32H0ljuEkw5kKg8mcJcFA2iTTzWiIamcnoggb3iUWvxEwr+pLJyCTIR7nY96KqgGvz038WcKKYmXfbGRdmjXhMRp7fp4GVvb2u0ncu/+2R6abJ3+wAFVc2OfDGSjrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218280; c=relaxed/simple;
	bh=NGVtBbKg9JLsQmxh7+zW3Knm/bad1Q2ESjaHJQpXMB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lvf4SeO3HGeomGOYt3ByZH2Pv/MUykJsvzKUyhsmtGi6SWQ8QSix5hRHs5fSJAwGsfvFmfsEbDtMAH8x/Xc7+YhD+Qf6iByR1chE4v+75kv9rakG15RsmylQax77IzJfPxbHVkhpFAkfgD7beohPBJzF/Ol0oukm15PnCy1wi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXvWdSYF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740218278; x=1771754278;
  h=date:from:to:cc:subject:message-id;
  bh=NGVtBbKg9JLsQmxh7+zW3Knm/bad1Q2ESjaHJQpXMB8=;
  b=MXvWdSYFqO7tqQNrI0RKMlsgTD0c2tL+fkAL/njN9QchPGp0Gt7qdf/x
   AEttMgHpUKC8AShCx+bLz4CHvaADS21ahPZflUMEmQ97rNpOunvZ9GFVG
   YeWkcQfaQ68O6Fb8HvgJYxijPhzlLzAbEl1y66m6y4IxqZhvZOq5Yv4u/
   c7ATukOBEiMGY7kM6pM85usgJflNrPnDOknydmueNZ1xNeg8ePj2VDnDM
   LzlnwoVn3pCCzlbcONMVxzOAWgLe/K6Lrdi3GGFXpsURzCtTJOGRCzdfw
   cw3n00foRV7mYeMpCG91HoiQ+KUEwhPYbHq71XohqcNTGH64ryJrwKhrq
   w==;
X-CSE-ConnectionGUID: xkLuprjyQY2y9ZCG9TNecg==
X-CSE-MsgGUID: eyu2D1lmSzCrwXKsGT7EPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52462197"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52462197"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 01:57:57 -0800
X-CSE-ConnectionGUID: 8PGckbJsQCKFL4Bfz+HQMA==
X-CSE-MsgGUID: wpg/UG9zSKW0XPD7w0ulgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="115553762"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 22 Feb 2025 01:57:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlmGf-0006St-11;
	Sat, 22 Feb 2025 09:57:53 +0000
Date: Sat, 22 Feb 2025 17:57:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 b956c9de91757c9478e24fc9f6a57fd46f0a49f0
Message-ID: <202502221714.4p3Ekqzd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: b956c9de91757c9478e24fc9f6a57fd46f0a49f0  arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of MBI

elapsed time: 1453m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                 randconfig-001-20250221    gcc-14.2.0
csky                 randconfig-002-20250221    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250221    clang-21
hexagon              randconfig-002-20250221    clang-21
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch            randconfig-001-20250221    gcc-14.2.0
loongarch            randconfig-002-20250221    gcc-14.2.0
nios2                randconfig-001-20250221    gcc-14.2.0
nios2                randconfig-002-20250221    gcc-14.2.0
parisc               randconfig-001-20250221    gcc-14.2.0
parisc               randconfig-002-20250221    gcc-14.2.0
powerpc              randconfig-001-20250221    clang-21
powerpc              randconfig-002-20250221    clang-21
powerpc              randconfig-003-20250221    clang-17
powerpc64            randconfig-001-20250221    clang-21
powerpc64            randconfig-002-20250221    clang-21
powerpc64            randconfig-003-20250221    clang-19
riscv                randconfig-001-20250221    clang-21
riscv                randconfig-002-20250221    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250221    gcc-14.2.0
s390                 randconfig-002-20250221    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250221    gcc-14.2.0
sh                   randconfig-002-20250221    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250221    gcc-14.2.0
sparc                randconfig-002-20250221    gcc-14.2.0
sparc64              randconfig-001-20250221    gcc-14.2.0
sparc64              randconfig-002-20250221    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250221    gcc-12
um                   randconfig-002-20250221    gcc-12
x86_64     buildonly-randconfig-001-20250221    gcc-12
x86_64     buildonly-randconfig-002-20250221    clang-19
x86_64     buildonly-randconfig-003-20250221    clang-19
x86_64     buildonly-randconfig-004-20250221    clang-19
x86_64     buildonly-randconfig-005-20250221    clang-19
x86_64     buildonly-randconfig-006-20250221    clang-19
xtensa               randconfig-001-20250221    gcc-14.2.0
xtensa               randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

