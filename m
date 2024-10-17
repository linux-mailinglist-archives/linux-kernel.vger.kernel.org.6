Return-Path: <linux-kernel+bounces-369301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B79A1B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E4D1C21868
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811F1C1AD6;
	Thu, 17 Oct 2024 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqKQbwPH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A9175D32
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149426; cv=none; b=Y0wLc3gWf2PdlATBCnN3L1e964SSTNp973xynJ/rml3AzT2Vwfznt7zP8fbhXkIXNF03tBJWT4+9QoSnVbpqNa7lV+/d0oj/tnAhzSD5vue3RokAK0p7QUYNf9n4joOkHwMbOxe+zLdBjggX4tcazno/sIO6DEuzGHUELD7ehvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149426; c=relaxed/simple;
	bh=6Qcx/xRCQVR3R6oj+RqNjM+yPQSV/y21hAdtRgpHR5o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bPyE/RCT2sqU83lhyeS/hLdPJ5yU3nbHLBuGDMx5AGo9AvKmx1xRYIb1UxQuf2JlDzWPNKkKusMNbEUncExgK1m+ojFeaaPERA06KmQTAnKp5Sm6pMlUxbxjdxB5xSDZ4n7N1kYx/bJNgQ99CNQlh0rGv2sgurSNR1CoeauVRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqKQbwPH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729149425; x=1760685425;
  h=date:from:to:cc:subject:message-id;
  bh=6Qcx/xRCQVR3R6oj+RqNjM+yPQSV/y21hAdtRgpHR5o=;
  b=hqKQbwPHlmVm8qTc+t/iS6+9YWUqMwsjn7t7fkCoqQvrdleA9+UmTvmX
   tVvEj0QTpNFnXN9MUA4/Y/lKemM8Sd1YVAPfjnsmpcvo3CANr8Lh9v5Kl
   K5o3xSOhkpqxzAyW5H2MestkzL5r7fENElKHur5OTTEgb0anZM3vxQTb6
   eRarElBVY1fCoKb0Y+iOU24+HkEflyaw3rF0fo9xCTZPmABIG7bWHYTGh
   hHopL1k9J9r2OraMdZIXXrbQrI8iEdqpEdYkS26nZUls1mGnJMjacefgh
   uAnkRN1jTZ3ebszZ1cODVAHKnb+dLci485K9Z4Ok09FI119b0bCUNDQh3
   A==;
X-CSE-ConnectionGUID: p4ouCMetTeq/hXR2u/ysIw==
X-CSE-MsgGUID: oh0tV8KlTHujUEt9mUcL0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28063279"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28063279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:17:05 -0700
X-CSE-ConnectionGUID: UMjj/0CrSdyrSAygrga5Fg==
X-CSE-MsgGUID: LM9J025dTEGrhvhrJMR6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78623007"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Oct 2024 00:17:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Kkn-000LsB-17;
	Thu, 17 Oct 2024 07:17:01 +0000
Date: Thu, 17 Oct 2024 15:16:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015] BUILD REGRESSION
 d64af418459145b7d8eb94cd300fb4b7d2659a3c
Message-ID: <202410171516.VOCVOq6N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015
branch HEAD: d64af418459145b7d8eb94cd300fb4b7d2659a3c  uapi: net: Avoid -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410171340.SzEKww7B-lkp@intel.com

    ./usr/include/linux/wireless.h:747:33: error: field 'addr' has incomplete type
    ./usr/include/linux/wireless.h:772:33: error: field 'bssid' has incomplete type
    ./usr/include/linux/wireless.h:860:33: error: field 'src_addr' has incomplete type

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-buildonly-randconfig-002-20241017
    |-- usr-include-linux-wireless.h:error:field-addr-has-incomplete-type
    |-- usr-include-linux-wireless.h:error:field-bssid-has-incomplete-type
    `-- usr-include-linux-wireless.h:error:field-src_addr-has-incomplete-type

elapsed time: 1803m

configs tested: 103
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241017    clang-18
i386        buildonly-randconfig-002-20241017    clang-18
i386        buildonly-randconfig-003-20241017    clang-18
i386        buildonly-randconfig-004-20241017    clang-18
i386        buildonly-randconfig-005-20241017    clang-18
i386        buildonly-randconfig-006-20241017    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241017    clang-18
i386                  randconfig-002-20241017    clang-18
i386                  randconfig-003-20241017    clang-18
i386                  randconfig-004-20241017    clang-18
i386                  randconfig-005-20241017    clang-18
i386                  randconfig-006-20241017    clang-18
i386                  randconfig-011-20241017    clang-18
i386                  randconfig-012-20241017    clang-18
i386                  randconfig-013-20241017    clang-18
i386                  randconfig-014-20241017    clang-18
i386                  randconfig-015-20241017    clang-18
i386                  randconfig-016-20241017    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
powerpc                           allnoconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241017    gcc-12
x86_64      buildonly-randconfig-002-20241017    gcc-12
x86_64      buildonly-randconfig-003-20241017    gcc-12
x86_64      buildonly-randconfig-004-20241017    gcc-12
x86_64      buildonly-randconfig-005-20241017    gcc-12
x86_64      buildonly-randconfig-006-20241017    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241017    gcc-12
x86_64                randconfig-002-20241017    gcc-12
x86_64                randconfig-003-20241017    gcc-12
x86_64                randconfig-004-20241017    gcc-12
x86_64                randconfig-005-20241017    gcc-12
x86_64                randconfig-006-20241017    gcc-12
x86_64                randconfig-011-20241017    gcc-12
x86_64                randconfig-012-20241017    gcc-12
x86_64                randconfig-013-20241017    gcc-12
x86_64                randconfig-014-20241017    gcc-12
x86_64                randconfig-015-20241017    gcc-12
x86_64                randconfig-016-20241017    gcc-12
x86_64                randconfig-071-20241017    gcc-12
x86_64                randconfig-072-20241017    gcc-12
x86_64                randconfig-073-20241017    gcc-12
x86_64                randconfig-074-20241017    gcc-12
x86_64                randconfig-075-20241017    gcc-12
x86_64                randconfig-076-20241017    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

