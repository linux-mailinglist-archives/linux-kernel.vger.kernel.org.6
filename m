Return-Path: <linux-kernel+bounces-234461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2691C6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CC42851D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E9770F0;
	Fri, 28 Jun 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGCO/NMT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E936F2E9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604674; cv=none; b=hyRL9fm0fq34Mggsu0pN9Kn73+BuCsegcwLPGDpIKkLjFHLnAhmxA2VQX9kXVbpenwwkYapMAEp4GIMvC4IJZZSEy0FLmWpfZ7tgsW6jZc2lmXBeXvt0tGaFWJQsxy+8x+INVA0Rio23lH6naMTnCdO/SWxBanLMVn5SK4XLrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604674; c=relaxed/simple;
	bh=XR8YSJSJVVzCdKrkEB7Bs8rDWeV681ZCIOD6iU9yLNs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kfMX8pSb/YxCr3KWTGhUHE6hduL3WDciVTL2gKyNQYQPzRjJ6LWsVKzlae8tZh8CzEg0MHyo6n5A4KtrdfFZdQJs+DrQCtv3k7PU+GFKLN7utgsNd0ZPspGaOl/heRb7aAmwOD9TT3vfPk4fWmUo1dXyQHMQ0fUSofYgsGXbchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGCO/NMT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719604672; x=1751140672;
  h=date:from:to:cc:subject:message-id;
  bh=XR8YSJSJVVzCdKrkEB7Bs8rDWeV681ZCIOD6iU9yLNs=;
  b=XGCO/NMTMClLWBdDAYESH8UUGdIjV4LN4SdnjXfuZAJ0c4xd4a2pqC2C
   LKYJnCn/rhgfDTihPVtRlwljCrdl6M1+rrryltjMXSYmJmQM8szKw5/Pg
   dBJvUbmjt+HAXcwbgL8ucCVcckputbqJ90DZX78QUofaCDTVXARtPpHza
   cexMx15U1BfrBfykRfKCd9S1033v3xkwmih6rgjCeYa5zkIyTuu6TFDxQ
   pOHo9gvCKthibSRxSBloXN5TY+rY8n+quhQiQtBd1AfqMyOUYZq2c2mfH
   AU57YgkHs2q1t89e/kD1w4eU6sqC9jP3NVBsyD55NxZL1niKNnnHJvklZ
   Q==;
X-CSE-ConnectionGUID: YiB5NYeTQoOkjeIlfqNE6g==
X-CSE-MsgGUID: 3n9ljIsgQcyfmIa/t7YrAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="19703090"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="19703090"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 12:57:51 -0700
X-CSE-ConnectionGUID: 7hgBWiQ/Q/unhqvD0ZtR4g==
X-CSE-MsgGUID: A9E+e1kXRMK2cKQxJJ1oBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45258596"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Jun 2024 12:57:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNHjA-000IEz-0X;
	Fri, 28 Jun 2024 19:57:48 +0000
Date: Sat, 29 Jun 2024 03:57:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 c2a31060c741ff2bc857fbe1197d92f970825000
Message-ID: <202406290335.of95aoM5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: c2a31060c741ff2bc857fbe1197d92f970825000  lockdep: Fix deadlock issue between lockdep and rcu

elapsed time: 4309m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240628   gcc-13.2.0
arc                   randconfig-002-20240628   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                   randconfig-001-20240628   gcc-13.2.0
arm                   randconfig-002-20240628   gcc-13.2.0
arm                   randconfig-003-20240628   gcc-13.2.0
arm                   randconfig-004-20240628   clang-19
arm                   randconfig-004-20240628   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240628   gcc-13.2.0
arm64                 randconfig-002-20240628   gcc-13.2.0
arm64                 randconfig-003-20240628   clang-19
arm64                 randconfig-003-20240628   gcc-13.2.0
arm64                 randconfig-004-20240628   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240628   gcc-13.2.0
csky                  randconfig-002-20240628   gcc-13.2.0
hexagon               randconfig-001-20240628   clang-19
hexagon               randconfig-002-20240628   clang-19
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240628   gcc-13.2.0
loongarch             randconfig-002-20240628   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240628   gcc-13.2.0
nios2                 randconfig-002-20240628   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240628   gcc-13.2.0
parisc                randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-001-20240628   gcc-13.2.0
powerpc               randconfig-002-20240628   gcc-13.2.0
powerpc               randconfig-003-20240628   gcc-13.2.0
powerpc64             randconfig-001-20240628   gcc-13.2.0
powerpc64             randconfig-002-20240628   gcc-13.2.0
powerpc64             randconfig-003-20240628   clang-19
powerpc64             randconfig-003-20240628   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240628   gcc-13.2.0
riscv                 randconfig-002-20240628   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240628   clang-19
s390                  randconfig-001-20240628   gcc-13.2.0
s390                  randconfig-002-20240628   clang-19
s390                  randconfig-002-20240628   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240628   gcc-13.2.0
sh                    randconfig-002-20240628   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240628   gcc-13.2.0
sparc64               randconfig-002-20240628   gcc-13.2.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240628   gcc-13
um                    randconfig-001-20240628   gcc-13.2.0
um                    randconfig-002-20240628   clang-19
um                    randconfig-002-20240628   gcc-13.2.0
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240628   gcc-13
x86_64       buildonly-randconfig-002-20240628   gcc-13
x86_64       buildonly-randconfig-003-20240628   gcc-13
x86_64       buildonly-randconfig-004-20240628   gcc-13
x86_64       buildonly-randconfig-005-20240628   gcc-13
x86_64       buildonly-randconfig-006-20240628   gcc-13
x86_64                randconfig-001-20240628   gcc-13
x86_64                randconfig-002-20240628   gcc-13
x86_64                randconfig-003-20240628   gcc-13
x86_64                randconfig-004-20240628   gcc-13
x86_64                randconfig-005-20240628   gcc-13
x86_64                randconfig-006-20240628   gcc-13
x86_64                randconfig-011-20240628   gcc-13
x86_64                randconfig-012-20240628   gcc-13
x86_64                randconfig-013-20240628   gcc-13
x86_64                randconfig-014-20240628   gcc-13
x86_64                randconfig-015-20240628   gcc-13
x86_64                randconfig-016-20240628   gcc-13
x86_64                randconfig-071-20240628   gcc-13
x86_64                randconfig-072-20240628   gcc-13
x86_64                randconfig-073-20240628   gcc-13
x86_64                randconfig-074-20240628   gcc-13
x86_64                randconfig-075-20240628   gcc-13
x86_64                randconfig-076-20240628   gcc-13
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240628   gcc-13.2.0
xtensa                randconfig-002-20240628   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

