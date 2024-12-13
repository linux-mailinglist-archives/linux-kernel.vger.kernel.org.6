Return-Path: <linux-kernel+bounces-444321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6BC9F04B7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53C6188B30F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700418B475;
	Fri, 13 Dec 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiJyUg5X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4028161320
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070850; cv=none; b=rOHHfHrgfkhoyeoHu8XwbxG3DNR/4E2wduSaDJLq3TUL9YZvEAcBJsxC7VSYsNQvLSA07BuU3U1h3TO4ZxOoKzDA+GlnDJaHohghLPCReDMIme+alsSnBuDOgDXefEZfSfyHL40ZRF2jxHE8se0qHJQUo4+Io+GzaUAkBs3pVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070850; c=relaxed/simple;
	bh=P01W4OErA5v3HC84nQjsAib+BK44YXIRCKMn/xl+Vqs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hwjOkG2ThZynC8QFBVPSGkxz0x1iu7jKkkLpH3+xTnNMNsIgo2Reodd+lUX5Cf9VY+/5N9yp9xCPJqQz4RD6OZbcnmYc6HoQwwNCURFDcfGDjzHOGjJUDyD3wIyagCgdu2U5ZpUAW9M0sDpUnCKa8khrK5oKZg6lZNCxQzHX6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiJyUg5X; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734070849; x=1765606849;
  h=date:from:to:cc:subject:message-id;
  bh=P01W4OErA5v3HC84nQjsAib+BK44YXIRCKMn/xl+Vqs=;
  b=HiJyUg5Xdg5TkYdHQ8RFiNMfp+cPwMAJ4PJ8XSRvzosSViQaBq/CYPpz
   AKbhvDPYPkC8KYnk/ngE8b9uamxTKzK3sMRDIERCB+h4qitk+rsCVwqVD
   b0/2xFKFbzd6RfqcekaWilaJiVoXYbVnDfk5QVNh+Ki2HwCRovAKj0ctw
   vmAN2/fTZNhrzmIxYDEPQze79D8ngThev00310qEjodE+DhhiIJQBODnv
   ic/VNQ0YPeWMXvDzt/PsgFf6eljq0XTyrFGZl7S/bHUCzL3XARMxbUw2X
   272c7xTGAPq+UoG+c5ztin0znnoY335txUytqLkvE6WRIhe7ZTKg70zwg
   g==;
X-CSE-ConnectionGUID: PsHW5OYGRvqciCnhA6jAgg==
X-CSE-MsgGUID: 4sU/MF7xRVexNhjgEvwzGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="52040409"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="52040409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:20:48 -0800
X-CSE-ConnectionGUID: g0IaJv+TRgimeO/R+t2fTQ==
X-CSE-MsgGUID: YZyYwi7mQgy/JOwwYyMoAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96304982"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Dec 2024 22:20:47 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLz2a-000Bkn-2p;
	Fri, 13 Dec 2024 06:20:44 +0000
Date: Fri, 13 Dec 2024 14:20:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.12.07a] BUILD SUCCESS
 04c3a25cc1534b1aefc292d7e414fa03ba637b8a
Message-ID: <202412131402.jXwZ1W43-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.12.07a
branch HEAD: 04c3a25cc1534b1aefc292d7e414fa03ba637b8a  stop_machine: Fix rcu_momentary_eqs() call in multi_cpu_stop()

elapsed time: 1917m

configs tested: 57
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241212    gcc-13.2.0
arc                  randconfig-002-20241212    gcc-13.2.0
arm                  randconfig-001-20241212    gcc-14.2.0
arm                  randconfig-002-20241212    clang-20
arm                  randconfig-003-20241212    clang-19
arm                  randconfig-004-20241212    clang-20
arm64                randconfig-001-20241212    clang-20
arm64                randconfig-002-20241212    clang-15
arm64                randconfig-003-20241212    clang-20
arm64                randconfig-004-20241212    gcc-14.2.0
csky                 randconfig-001-20241213    gcc-14.2.0
csky                 randconfig-002-20241213    gcc-14.2.0
hexagon              randconfig-001-20241213    clang-20
hexagon              randconfig-002-20241213    clang-20
i386       buildonly-randconfig-001-20241212    clang-19
i386       buildonly-randconfig-002-20241212    clang-19
i386       buildonly-randconfig-003-20241212    clang-19
i386       buildonly-randconfig-004-20241212    clang-19
i386       buildonly-randconfig-005-20241212    clang-19
i386       buildonly-randconfig-006-20241212    gcc-12
loongarch            randconfig-001-20241213    gcc-14.2.0
loongarch            randconfig-002-20241213    gcc-14.2.0
nios2                randconfig-001-20241213    gcc-14.2.0
nios2                randconfig-002-20241213    gcc-14.2.0
parisc               randconfig-001-20241213    gcc-14.2.0
parisc               randconfig-002-20241213    gcc-14.2.0
powerpc              randconfig-001-20241213    gcc-14.2.0
powerpc              randconfig-002-20241213    clang-20
powerpc              randconfig-003-20241213    gcc-14.2.0
powerpc64            randconfig-001-20241213    gcc-14.2.0
powerpc64            randconfig-002-20241213    gcc-14.2.0
powerpc64            randconfig-003-20241213    gcc-14.2.0
riscv                randconfig-001-20241212    clang-17
riscv                randconfig-002-20241212    clang-20
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241212    clang-18
s390                 randconfig-002-20241212    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241212    gcc-14.2.0
sh                   randconfig-002-20241212    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241212    gcc-14.2.0
sparc                randconfig-002-20241212    gcc-14.2.0
sparc64              randconfig-001-20241212    gcc-14.2.0
sparc64              randconfig-002-20241212    gcc-14.2.0
um                   randconfig-001-20241212    gcc-12
um                   randconfig-002-20241212    clang-20
x86_64     buildonly-randconfig-001-20241213    gcc-12
x86_64     buildonly-randconfig-002-20241213    gcc-12
x86_64     buildonly-randconfig-003-20241213    gcc-12
x86_64     buildonly-randconfig-004-20241213    gcc-12
x86_64     buildonly-randconfig-005-20241213    gcc-12
x86_64     buildonly-randconfig-006-20241213    clang-19
xtensa               randconfig-001-20241212    gcc-14.2.0
xtensa               randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

