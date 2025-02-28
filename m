Return-Path: <linux-kernel+bounces-539404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DAA4A3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2257ABE65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A0202974;
	Fri, 28 Feb 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T61vPYD9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820B1F4CA6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773574; cv=none; b=H2dtpxwqhY60NolpkqCVfKU8LV0M/3YkasaMtaqhG70a5ikoKWQdJ+hkb3CxS9Mp+IaKFy9pWmxLI39sSLNT7K4h1zH9oxJzJ6uMYmdIgPdjS5N7vmv7fVna+sAWFLSJuzuNQIc3Ge6FD+DXl7CORm+XUGVqw3R7tWJE5ofMaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773574; c=relaxed/simple;
	bh=lZwaPu5t1OzEeS+3OIXeyJ2YU8XfpuFj1Rr/KvxV8sk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NmnnSnIIWvIvqor3TqIA/eM3kGHfGGeNsLjBaCVOARsCJ7Exn8jVt0Z55R+SUyCNUez7YGGhdrD+7yqYaTFpWjy3fvL/mjytdM3IJM3J0lRWWNNjJRgq4PPWY2n1V3xVmwNtEDEi/a/ibm1AT93KdrE9W5XREs0jW1bdBzJhP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T61vPYD9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740773573; x=1772309573;
  h=date:from:to:cc:subject:message-id;
  bh=lZwaPu5t1OzEeS+3OIXeyJ2YU8XfpuFj1Rr/KvxV8sk=;
  b=T61vPYD9bYSwhBNWDa3OIQ9HUu00L9xz53AIljsZ5fUZc97A9LGmiuy2
   yVX8RG5lJH95yen9aye5gfxUP1Kdt3yK3y3eIx3KQd4so6iq7sOjx9hEQ
   RiqTjVIZsPnR8eNQ8pzRIR2cl3nA+z6pDJUTET+Fn8HoVjX8pJ/7hY2KN
   n+bsZibRkNsUJHj9CNX9NOifihb1eGnb0xQmE1nQGBDEf2YGspCE99+xe
   3hJ/kz8GvlNfMAVRf0i7WEILgM6vWEOLZ9neQa2nzl+XDksxhYdsf59cY
   4waD9440oWlpHMC1mJ4P1OsVQ7yJrKWKasJo5dialsax55sZ1i1KLpiIr
   A==;
X-CSE-ConnectionGUID: ANvmtcI6QuyMnXqJa6vA4g==
X-CSE-MsgGUID: 9v26aGnqSGugAxctQ0nZyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52348257"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52348257"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:12:52 -0800
X-CSE-ConnectionGUID: wbqzRRujQO6EZTB6vR770A==
X-CSE-MsgGUID: gVL5a2h/RUq9OyChcZSBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122389046"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2025 12:12:52 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to6j2-000FT6-2o;
	Fri, 28 Feb 2025 20:12:48 +0000
Date: Sat, 01 Mar 2025 04:12:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 69a2fdf446049ae31be4a14a0cf16f2f18f09b6c
Message-ID: <202503010427.J1wkSaqQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 69a2fdf446049ae31be4a14a0cf16f2f18f09b6c  x86/fpu/xstate: Simplify print_xstate_features()

elapsed time: 1454m

configs tested: 61
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

