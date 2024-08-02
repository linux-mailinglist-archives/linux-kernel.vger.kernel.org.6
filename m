Return-Path: <linux-kernel+bounces-273237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3194663B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18272B20F98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042A13B58C;
	Fri,  2 Aug 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZG7gkNKA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99906137932
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642316; cv=none; b=Fbc9esX4DZcXfgKxHjMIutDJWD92z+ekjkl34g8r6S7UNdIZ7bO8Cw5xgN8cqyM58cxOIoT/drVjFEDPlSOTvAxFJvosTgtR/3axMPTZlIuqOsjtsg0TjcHhsp0AIiG50eCeJqWgo9vKQXLFzPFjTldLR3xscNXu3fQ29bXSMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642316; c=relaxed/simple;
	bh=YiCrs0mu/8wgwKATt/N56B6b/WLL8Ibek3OOIeOjpDM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TNg7Ggnr0NZZMghbN8o999mOhiJM20F6fMFi7eLbroTnWFh7lYFH16zlNH4wYbGj+Ps+C6DeQ4Yaiuf/qPDFwhdgHchShcpFPDSyrbwS+0ImkiF0fGz3p6uQNo6MtY66cx+0Us8Uuposyx+eHieoKwOMUAyxyBsO++ORqHgnq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZG7gkNKA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722642313; x=1754178313;
  h=date:from:to:cc:subject:message-id;
  bh=YiCrs0mu/8wgwKATt/N56B6b/WLL8Ibek3OOIeOjpDM=;
  b=ZG7gkNKAXfjQDDGiU7G7ovI6AZEkWOJD2fs5o+vP6pPypJ/pdkjgNBNe
   jBrgsq3xeyXiTB4LjT0GlnnmCxFbyUkRNqob5ECsKarlDGjHKLhb+3kI3
   DUyTYaYJG9paJ64UsnVjwJ1O04Xrc5UlJ5z9JrG+iuTk1U2NgTwxf8und
   YtkrlYFIQX82xtOymapHKYA+Q11rTGff9WwhYYEscg09niJ8Y7ulx1e3A
   NvgT8xk85Ap0TkfuJTciIAEhN/ILjSqzK/F+xRs0U30gzLP0EHIlwbdZR
   U0u4vW6YtpFL+CtX8h1/t6uNd+anIuZ8jWppmPvJ8hI69op/U6azzo5Iy
   w==;
X-CSE-ConnectionGUID: vtvip1tmR6iQBS9NPyy7KA==
X-CSE-MsgGUID: 9lEUT+fZRE6kptsOzWHYBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="43197535"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="43197535"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 16:45:12 -0700
X-CSE-ConnectionGUID: unFtrLAbS5a/nNSYDT0VkQ==
X-CSE-MsgGUID: AMOfXGOeR7WfbqlIN+AZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="55507245"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Aug 2024 16:45:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa1xN-000xYW-1R;
	Fri, 02 Aug 2024 23:45:09 +0000
Date: Sat, 03 Aug 2024 07:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc-2] BUILD
 REGRESSION 64c57c9e06ed6d50ba26688a7d2b60a1c33ff20f
Message-ID: <202408030746.a4dbmbYD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
branch HEAD: 64c57c9e06ed6d50ba26688a7d2b60a1c33ff20f  net/fungible: Avoid -Wflex-array-member-not-at-end warning

Error/Warning ids grouped by kconfigs:

recent_errors
`-- arm-allmodconfig
    `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()

elapsed time: 1688m

configs tested: 106
configs skipped: 1

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240803   gcc-13.2.0
arc                   randconfig-002-20240803   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                   randconfig-001-20240803   gcc-14.1.0
arm                   randconfig-002-20240803   gcc-14.1.0
arm                   randconfig-003-20240803   clang-20
arm                   randconfig-004-20240803   gcc-14.1.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240803   clang-20
arm64                 randconfig-002-20240803   clang-20
arm64                 randconfig-003-20240803   clang-20
arm64                 randconfig-004-20240803   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240803   gcc-14.1.0
csky                  randconfig-002-20240803   gcc-14.1.0
hexagon                           allnoconfig   clang-20
hexagon               randconfig-001-20240803   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-002-20240802   gcc-12
i386         buildonly-randconfig-003-20240802   clang-18
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-005-20240802   gcc-13
i386         buildonly-randconfig-006-20240802   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240802   gcc-12
i386                  randconfig-002-20240802   gcc-8
i386                  randconfig-003-20240802   clang-18
i386                  randconfig-004-20240802   gcc-13
i386                  randconfig-005-20240802   gcc-13
i386                  randconfig-006-20240802   gcc-13
i386                  randconfig-011-20240802   clang-18
i386                  randconfig-012-20240802   clang-18
i386                  randconfig-013-20240802   gcc-13
i386                  randconfig-014-20240802   clang-18
i386                  randconfig-015-20240802   clang-18
i386                  randconfig-016-20240802   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240802   gcc-11
x86_64       buildonly-randconfig-002-20240802   gcc-12
x86_64       buildonly-randconfig-003-20240802   gcc-12
x86_64       buildonly-randconfig-004-20240802   gcc-12
x86_64       buildonly-randconfig-005-20240802   clang-18
x86_64       buildonly-randconfig-006-20240802   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240802   clang-18
x86_64                randconfig-002-20240802   gcc-11
x86_64                randconfig-003-20240802   gcc-12
x86_64                randconfig-004-20240802   gcc-12
x86_64                randconfig-005-20240802   clang-18
x86_64                randconfig-006-20240802   gcc-12
x86_64                randconfig-011-20240802   clang-18
x86_64                randconfig-012-20240802   gcc-12
x86_64                randconfig-013-20240802   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

