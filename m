Return-Path: <linux-kernel+bounces-351451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B3991163
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398FD1F22632
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700331D8DEE;
	Fri,  4 Oct 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOAB7W7X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AF1ADFF4
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077085; cv=none; b=g2g02+8wonsH2j0/MwDyKxje5tkqZ0jewzCfAOO4y6iSrcYlfeesSEawuj2rhfnqBtAP+Q+4nmPPPD/P1IP0dt8yHVnXsi+syM6yOkqgIGJxdNfu8ZVulHE4/1uP4CZ+T6M3SlEc3ZQVfzHoa9i0yrfoTnVgh2noTxoyv9jn0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077085; c=relaxed/simple;
	bh=vUDDGt88ZuQBZhMgXUdendIBpTh2y41buKcgAer334s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RAEnFFnzP/qgMQQkQyStgvY+odzRaSPpNE6ZdH0lFqDEsxbvcWdNmtKV/oR9R+QQjsE6kxKCIQbzbsO9041KJ+krXpTxVq3zE79AFX3MaJZgeeCDiQVSj/w4PRd8JdFkBL1r/f3khwatepy1ZR8dPW3o4QH4bdd0uClXjLhCgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOAB7W7X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728077084; x=1759613084;
  h=date:from:to:cc:subject:message-id;
  bh=vUDDGt88ZuQBZhMgXUdendIBpTh2y41buKcgAer334s=;
  b=EOAB7W7XtTpcXVm+Ahh8OVypUtFm4bHMAvLycUCttEqpQkfJpctHO6Ll
   SEGNOMN3oUiRxpIOgAZjT7Jqmr67kghelMne/GBBlGTSlNvVpIEFrHAbD
   2Qw8km2cuojAMS16wjU+vAO2GkNFH78evPiIZg0FrR8AtmnwJNCv6r2hX
   j8c0i4ORbcfuRwnN+55Wv/3Sxo0cMUEsZuu1+STi5Ro0Hd6Z5SHdHJEQp
   soHjVH0W5IOhpk594zyCJkxhbVWCIp4bNwZh+HU99DJK8VLQxnktHrS69
   afoeXJTfRCiEyH+g9AJfiPorJESx+2WuASXtpVleNmuTAyaAG9X7SG8R9
   A==;
X-CSE-ConnectionGUID: Y8/3TyeWRKKwol1f6ZNTtg==
X-CSE-MsgGUID: nkQYuOmxQR6dWpBglf+pWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26817381"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="26817381"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:24:43 -0700
X-CSE-ConnectionGUID: Aqp2bC5oT6+m9mYJTXnOlA==
X-CSE-MsgGUID: 9aHt1wtRSUm4Tik9qAAPUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74948696"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Oct 2024 14:24:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swpmy-0002EW-08;
	Fri, 04 Oct 2024 21:24:40 +0000
Date: Sat, 05 Oct 2024 05:24:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241003] BUILD SUCCESS WITH
 WARNING ec64acf2dce7577a42c01241e78b24afebc26e96
Message-ID: <202410050557.DVwhYdSo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241003
branch HEAD: ec64acf2dce7577a42c01241e78b24afebc26e96  treewide_some: fix multiple -Wfamnae warnings that must be audited separately

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410050156.QDVz2Sit-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202410050215.8zVNACRw-lkp@intel.com

    kernel/bpf/core.c:2505:22: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
    kernel/bpf/core.c:2505:29: warning: comparison of distinct pointer types lacks a cast

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- alpha-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-randconfig-001-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-randconfig-002-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-randconfig-001-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-randconfig-002-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-001-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-buildonly-randconfig-002-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-buildonly-randconfig-003-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-buildonly-randconfig-005-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-001-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- m68k-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- m68k-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- riscv-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- riscv-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- s390-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-kexec
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-randconfig-161-20241005
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-rhel-8.3
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-rhel-8.3-kselftests
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
`-- x86_64-rhel-8.3-rust
    `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)

elapsed time: 1473m

configs tested: 44
configs skipped: 0

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20241005    gcc-13.2.0
arc                   randconfig-002-20241005    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20241005    gcc-14.1.0
arm                   randconfig-002-20241005    clang-20
arm                   randconfig-003-20241005    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241005    clang-18
i386        buildonly-randconfig-002-20241005    clang-18
i386        buildonly-randconfig-003-20241005    clang-18
i386        buildonly-randconfig-004-20241005    clang-18
i386        buildonly-randconfig-005-20241005    gcc-12
i386        buildonly-randconfig-006-20241005    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241005    gcc-11
loongarch                         allnoconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
um                                allnoconfig    clang-17
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

