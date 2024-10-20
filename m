Return-Path: <linux-kernel+bounces-373207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CEE9A53C1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874A5282289
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E26187FE4;
	Sun, 20 Oct 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnlOQAWr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978284E0A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423964; cv=none; b=iQwuIp3jqE0taXe/ZNIKwxbOJ4/KezhEmdVHTldkV2pyU6xGj7dx+wi373E3IojGaCqHF+qxQLGV/shYbEctDViIxnGU5KeURBy8NXNJxGkbrRperiXA2RjoltX+5VPZbDJIs9hb6CBt0CGFS4xyLSLCg0wM1vQkqiGy4cX7l9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423964; c=relaxed/simple;
	bh=mNXlngMmpybJSrLTvJEC8SheRPkcu10zBnENnGUrQBk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vCpg9yY0iiVgZYVdsF3GXbNU8UB6/FKDnMDacoI1wP5l2j9y3OQcZ5oRt4ZMWkj/R6+XwUzqhvs0HiQe3jqV7dpYV2+aLQU0qiC6irFbOIK/dPjggnVcb+YknSngmAVAGy/cWmzV4Mh4DNGAM6E2UdUnCwx8iJb07BOoEYsMOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnlOQAWr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729423961; x=1760959961;
  h=date:from:to:cc:subject:message-id;
  bh=mNXlngMmpybJSrLTvJEC8SheRPkcu10zBnENnGUrQBk=;
  b=nnlOQAWrXTUA8SOuhbh7xBZRcGdlVl4BlmIZjOsCDN9TPFh8FHknSt6p
   ukibFy+etOh9VlBFcLefoP4SM3TF50XPn8Lh9WA+aIqpANoLt/mNvtDcm
   1je9ctwnMP97zhZsvIZMncefQfil+4uOvALlxWOPsxm1X1SjrY5ItuTWm
   Zv6MVPjifMO+8nctwjYRm1yAzl54YSEYoxZcBptnrt9o8CMht/uHg31bv
   U0k7eYAMFNlymTrcMd8s4EkfSxtJJS4bj51CnJiYAwr81DJViLs1yjs/E
   3WX8h5GCiTxnEkem1Q6e/zSfun8XRDE+tVLke1REYkFCEo5XdQi+mvFir
   g==;
X-CSE-ConnectionGUID: dHF7iKc1RECf5YTzsqavxQ==
X-CSE-MsgGUID: Z7/bgCYVSRyjFgMvqZR93g==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29125964"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="29125964"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 04:32:40 -0700
X-CSE-ConnectionGUID: 1RANNW5CRrGgV1ok6V2uuQ==
X-CSE-MsgGUID: McOicC1ZTNOmxmh0RbWpsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="102586079"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2024 04:32:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2UAn-000QEj-1x;
	Sun, 20 Oct 2024 11:32:37 +0000
Date: Sun, 20 Oct 2024 19:31:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2] BUILD REGRESSION
 f4f8ca5cd7f039bcab816194342c7b6101e891fe
Message-ID: <202410201947.CMNM4fbK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
branch HEAD: f4f8ca5cd7f039bcab816194342c7b6101e891fe  net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410201911.RjSrvRuo-lkp@intel.com

    kernel/sched/ext.c:3454:10: error: incompatible pointer types returning 'struct cgroup_hdr *' from a function with result type 'struct cgroup *' [-Werror,-Wincompatible-pointer-types]
    kernel/sched/ext.c:7152:17: error: incompatible pointer types initializing 'struct cgroup *' with an expression of type 'struct cgroup_hdr *' [-Werror,-Wincompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-buildonly-randconfig-003-20241020
|   |-- kernel-sched-ext.c:error:incompatible-pointer-types-initializing-struct-cgroup-with-an-expression-of-type-struct-cgroup_hdr-Werror-Wincompatible-pointer-types
|   `-- kernel-sched-ext.c:error:incompatible-pointer-types-returning-struct-cgroup_hdr-from-a-function-with-result-type-struct-cgroup-Werror-Wincompatible-pointer-types
|-- mips-allmodconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- mips-allyesconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- parisc-allyesconfig
|   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
|-- riscv-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_CCMP
|   `-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_GCMP_256
`-- riscv-allyesconfig
    |-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_CCMP
    `-- drivers-net-wireless-intel-iwlwifi-mvm-d3.c:error:call-to-__compiletime_assert_NNN-declared-with-error-attribute:BUILD_BUG_ON-failed:conf-keylen-WLAN_KEY_LEN_GCMP_256

elapsed time: 2439m

configs tested: 33
configs skipped: 0

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-13.2.0
arm                               allnoconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241020    clang-18
i386        buildonly-randconfig-002-20241020    clang-18
i386        buildonly-randconfig-003-20241020    clang-18
i386        buildonly-randconfig-004-20241020    clang-18
i386        buildonly-randconfig-005-20241020    clang-18
i386        buildonly-randconfig-006-20241020    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241020    gcc-12
loongarch                         allnoconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

