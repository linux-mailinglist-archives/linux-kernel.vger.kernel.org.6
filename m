Return-Path: <linux-kernel+bounces-446020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6DF9F1E91
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3011884D65
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7110191F9E;
	Sat, 14 Dec 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+utZwpf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACC42A99
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179825; cv=none; b=NMXUw1TRwIbLJe9nLFsb4OiVm1YA/JPL2+ObWAG+0uwKXuw9U3DdE2DOB99Ssy4dAGVtdayam7oJrLgiS3Ptb33Odkx+SYX88b3gHqxZmH+fMdjFLIcLbA48CJ1xSNARSiqWS+ZFyU9JEzX8Y1GojAwUkzjIrXcG9y/COdxKZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179825; c=relaxed/simple;
	bh=PK8vWe6/Z3roLiIfp5rmzYIrcidljC13dSg16QT36oA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dGtw325eOtvd5gqPo9+hvJ4yid7vB2HSi0JAn1deb3PY6BWrx2617onvLe7qWix7ZDl0qzHJPgVPcEWNh/vQuhb6KSqkt0LzViurp79KucAm+ME4nwyhupCuXRqxUsAokOmh5aMQYvpuAQmspBziTQLlMXSGekN7gx3YwjGZ8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+utZwpf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734179823; x=1765715823;
  h=date:from:to:cc:subject:message-id;
  bh=PK8vWe6/Z3roLiIfp5rmzYIrcidljC13dSg16QT36oA=;
  b=m+utZwpfvEAuzK7oC+XZKXKWbywNM1sweekUZX3Iuam1xwB9BH8lF27F
   atuqE8gQsevNlrW7tVrVqEKZqk/r6eMK48olxguAGOuY44zA3z8RdZZr/
   R7KB9ULUsX5Xsiz6BwNKPGgU5SJCKsHkdAs7sCf+qAO51/v+Celo8d8Y6
   a6XvhAGZ9zyxu/FLj0eywGZ1q/Ovo9niW5gHg4rOwuE9bquHDuh7qSKc6
   J/TAQwh2VVHkAD3ZVaVWykOGcdtDYUrhd0pKX5wZJtOXtHFpB7ukRW+49
   Jbj9MDZf4kPFHIw6Ia/EoYtZdHOk56gyHyEiFxsiqC/xkwXULMov+HjcQ
   Q==;
X-CSE-ConnectionGUID: w/D5zk8qQrqPshwUxfGKJA==
X-CSE-MsgGUID: qOpPO7XgTQ6o8Zy5IIkHlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34537878"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="34537878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 04:37:02 -0800
X-CSE-ConnectionGUID: jw/Itvb4QKCdWvvhh7pfTA==
X-CSE-MsgGUID: JQOhEW8tQI2eK6QkpAW1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="101802673"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Dec 2024 04:37:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMROF-000Cvf-17;
	Sat, 14 Dec 2024 12:36:59 +0000
Date: Sat, 14 Dec 2024 20:36:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 ef4316d2ddea79c84e1ed0ef2047541dbbbee494
Message-ID: <202412142021.aHNa48YA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: ef4316d2ddea79c84e1ed0ef2047541dbbbee494  Merge branch into tip/master: 'sched/urgent'

elapsed time: 1453m

configs tested: 56
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241213    gcc-13.2.0
arc                  randconfig-002-20241213    gcc-13.2.0
arm                  randconfig-001-20241213    clang-16
arm                  randconfig-002-20241213    clang-18
arm                  randconfig-003-20241213    gcc-14.2.0
arm                  randconfig-004-20241213    clang-18
arm64                randconfig-001-20241213    gcc-14.2.0
arm64                randconfig-002-20241213    gcc-14.2.0
arm64                randconfig-003-20241213    clang-18
arm64                randconfig-004-20241213    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
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
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

