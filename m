Return-Path: <linux-kernel+bounces-446176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0379F20AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 21:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA2D16706C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF701ABEBB;
	Sat, 14 Dec 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG/RjaUt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D76DDA9
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734208028; cv=none; b=qyXTHq4eCLuD5ran2VPzy6vSiOh4a2VxLyTaeChJKNNtHhCymaObA+ppSkDdgr1g5aXCdO5JFMXYjjSHPbCZ1nUD9M7b0K6yPshOIZDIhN21+Q9+HaD7wIwoVk74c44SSgbIek6R4QRgdx0aWHF41pHjlaDAfYDbd6SdNX8Vor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734208028; c=relaxed/simple;
	bh=tu8zO3Mo9Kc3BqMP0mDqyPQQ/sswYbJ0hFBE1xxD+3s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nDbbQGEZ1jDMkuHxTYfzs/8RRV/btWzSzRg+hBkmNRtPYSLTa4r7j7cp0vRWVaPi4tRNJmqU+0rNios2ijWr2R6FG1r+mYhUFKym30Nhx0mgj925pkJYg1DSvbfT/3fhjivooGgps8Aij5asFO4jIbVOrJ7Os5F64BKdKkh3Xlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG/RjaUt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734208025; x=1765744025;
  h=date:from:to:cc:subject:message-id;
  bh=tu8zO3Mo9Kc3BqMP0mDqyPQQ/sswYbJ0hFBE1xxD+3s=;
  b=XG/RjaUtOGlYzLdegmTbR3NMs84MvbjYMfJgaJRWLgCZrZLimNsbKMl1
   UIdPDxYG5OLgP75suOriHfPq1gD7v8VqYhEnQD4gzHni9ctS6HBMaIEvK
   c2EnUW3TUuoJRG2dmbG617xxY9Lvyl5Avd6fuu+SmTaNxpPrSZ9D79ZiI
   8zKz02hSXgLn0H+nupTorD4U+NO+JPqwd0ueINGV2SihMkKfvzBS2TGwg
   mQeBMbZTHOCZIom3wm67QI8jYIULZDdPJ7A6jYW74IjVbafQgFZFX+eLP
   cTDDekHmRU+FbF5mkgHuo5z22CEaOXPx1d2CawVbeRJxlIzvMfyDVgIOC
   A==;
X-CSE-ConnectionGUID: vBWHRBzHRQiqJv7YJ/UWDQ==
X-CSE-MsgGUID: L6Jw28qpQ4ymUMkwCuQ+5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34513195"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="34513195"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 12:27:04 -0800
X-CSE-ConnectionGUID: QPxi8BqiT2+0xHcBC7YfIg==
X-CSE-MsgGUID: M8veTq4+QEykZ70ZVZA2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127831490"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Dec 2024 12:27:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMYj6-000DCn-2o;
	Sat, 14 Dec 2024 20:27:00 +0000
Date: Sun, 15 Dec 2024 04:26:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.12.12a] BUILD SUCCESS
 910fce190107d58a8ec641742f4ac2abccd6c17a
Message-ID: <202412150418.TVoGF9Bx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.12.12a
branch HEAD: 910fce190107d58a8ec641742f4ac2abccd6c17a  EXP rcu: Check for expedited initialization completion

elapsed time: 2492m

configs tested: 65
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241214    gcc-13.2.0
arc                  randconfig-001-20241215    gcc-13.2.0
arc                  randconfig-002-20241214    gcc-13.2.0
arc                  randconfig-002-20241215    gcc-13.2.0
arm                  randconfig-001-20241214    gcc-14.2.0
arm                  randconfig-001-20241215    clang-20
arm                  randconfig-002-20241214    clang-15
arm                  randconfig-003-20241214    gcc-14.2.0
arm                  randconfig-004-20241214    gcc-14.2.0
arm64                randconfig-001-20241214    clang-15
arm64                randconfig-002-20241214    clang-20
arm64                randconfig-003-20241214    clang-15
arm64                randconfig-004-20241214    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-001-20241215    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
csky                 randconfig-002-20241215    gcc-14.2.0
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-001-20241215    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241214    gcc-12
i386       buildonly-randconfig-001-20241215    gcc-12
i386       buildonly-randconfig-002-20241214    gcc-12
i386       buildonly-randconfig-002-20241215    gcc-12
i386       buildonly-randconfig-003-20241214    clang-19
i386       buildonly-randconfig-004-20241214    clang-19
i386       buildonly-randconfig-004-20241215    gcc-12
i386       buildonly-randconfig-005-20241214    gcc-11
i386       buildonly-randconfig-006-20241214    gcc-12
loongarch            randconfig-001-20241214    gcc-14.2.0
loongarch            randconfig-002-20241214    gcc-14.2.0
nios2                randconfig-001-20241214    gcc-14.2.0
nios2                randconfig-002-20241214    gcc-14.2.0
parisc               randconfig-001-20241214    gcc-14.2.0
parisc               randconfig-002-20241214    gcc-14.2.0
powerpc              randconfig-001-20241214    clang-20
powerpc              randconfig-002-20241214    clang-15
powerpc              randconfig-003-20241214    clang-20
powerpc64            randconfig-001-20241214    gcc-14.2.0
powerpc64            randconfig-003-20241214    clang-20
riscv                randconfig-001-20241214    clang-20
riscv                randconfig-002-20241214    clang-20
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241214    gcc-14.2.0
s390                 randconfig-002-20241214    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241214    gcc-14.2.0
sh                   randconfig-002-20241214    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241214    gcc-14.2.0
sparc                randconfig-002-20241214    gcc-14.2.0
sparc64              randconfig-001-20241214    gcc-14.2.0
sparc64              randconfig-002-20241214    gcc-14.2.0
um                   randconfig-001-20241214    clang-20
um                   randconfig-002-20241214    clang-17
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241214    gcc-14.2.0
xtensa               randconfig-002-20241214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

