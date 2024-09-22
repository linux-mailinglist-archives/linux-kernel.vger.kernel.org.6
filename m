Return-Path: <linux-kernel+bounces-335032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12897E012
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 05:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A978A1C20A3A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AC193086;
	Sun, 22 Sep 2024 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n75QP05E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220875381E
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726976597; cv=none; b=LHpsXEO0MsCZOOsqmo9TTfyD28UhjcJgwO2FP4Zd3LHNwYW3I2w00hWgx8piqXZnd6Xjq8LP/IV5vS/fZJtCBmRzh1jELrHKd7yqfhuhYpUh906hAiLg6W53mfleA/B0J8hMIwQZtyHp37rZkLAwo6zsQo6EpYvprkf75rOUIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726976597; c=relaxed/simple;
	bh=1UmnlTDxf4ovmcAGVTqNL6EPysgxiMva1fVE9fHeAHw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dssE9vmx8sqPINIJshA7rj67ebx7+vMDMHsVtuo6HoKD7DBVHU2XEFLYIZ3Hgvd6hvMUcaWfH/tvaRS6z8dyt7UERv0wftLROE7KBRStBdmJnyadMd9/yz+gL9euDZM1g9WEyGIRt7Fkhj7jgbgf+V8tI1eqg1EagnApiJ8VpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n75QP05E; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726976595; x=1758512595;
  h=date:from:to:cc:subject:message-id;
  bh=1UmnlTDxf4ovmcAGVTqNL6EPysgxiMva1fVE9fHeAHw=;
  b=n75QP05EMCauDMGDh7Sdt7vKhn6ruNODGGIffnAG9zRAWqhxeHqULRnj
   1quZ2lDVFWw8LCrUcLSUu1YxF9pFpvE90aoqaiTyiRkv/QoJfIb7yAzWU
   VizYC0W1e7nIb8tlB4E5VX0pRWvz2s17BHY5XdaPljiRVV9xcjaq6HS15
   qXx0ZlXJsuKKctaOGEniVLk38n6mpD/ooo/x9EcwwPchbeTJrL8hMxVJY
   60VP33pfT4x+IhNy02pSV5FfW/n6o1INnOOXoZs0JayyRaaVIr3Z3KrQs
   Wb/6iIDKZjgfU8nGzDK1JK2u10DEYT3X3RS8QHJwK4ZgnC04gzUnadNj+
   A==;
X-CSE-ConnectionGUID: m1bbFD8ISsOyoZZLfk9k/Q==
X-CSE-MsgGUID: NIaI+flaTU+oUwwwX3P7CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="25892388"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="25892388"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 20:43:15 -0700
X-CSE-ConnectionGUID: /6/Qg568Qya2Y1JYZSOiaA==
X-CSE-MsgGUID: Qxk55YfLQPOZ0hsafOJzGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70707113"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2024 20:43:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssDV9-000G0K-1g;
	Sun, 22 Sep 2024 03:43:11 +0000
Date: Sun, 22 Sep 2024 11:42:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240919] BUILD SUCCESS
 c4fe76eb6cabd44e576f30024974d06c9bd5d6ca
Message-ID: <202409221113.Upancyot-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240919
branch HEAD: c4fe76eb6cabd44e576f30024974d06c9bd5d6ca  treewide_some: fix multiple -Wfamnae warnings that must be audited separately

elapsed time: 2608m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20240922    gcc-13.2.0
arc                   randconfig-002-20240922    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                     davinci_all_defconfig    clang-20
arm                           h3600_defconfig    gcc-14.1.0
arm                   milbeaut_m10v_defconfig    clang-16
arm                        mvebu_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20240922    gcc-14.1.0
arm                   randconfig-002-20240922    clang-20
arm                   randconfig-003-20240922    clang-16
arm                   randconfig-004-20240922    gcc-14.1.0
arm                           sama7_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240922    gcc-14.1.0
arm64                 randconfig-002-20240922    clang-20
arm64                 randconfig-003-20240922    gcc-14.1.0
arm64                 randconfig-004-20240922    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240922    gcc-14.1.0
csky                  randconfig-002-20240922    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240922    clang-20
hexagon               randconfig-002-20240922    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240922    clang-18
i386        buildonly-randconfig-002-20240922    clang-18
i386        buildonly-randconfig-003-20240922    clang-18
i386        buildonly-randconfig-004-20240922    clang-18
i386        buildonly-randconfig-005-20240922    clang-18
i386        buildonly-randconfig-006-20240922    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240922    clang-18
i386                  randconfig-002-20240922    gcc-12
i386                  randconfig-004-20240922    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240922    gcc-14.1.0
loongarch             randconfig-002-20240922    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                 decstation_r4k_defconfig    gcc-13.2.0
mips                           mtx1_defconfig    clang-16
mips                      pic32mzda_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240922    gcc-14.1.0
nios2                 randconfig-002-20240922    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240922    gcc-14.1.0
parisc                randconfig-002-20240922    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-002-20240922    gcc-14.1.0
powerpc64             randconfig-001-20240922    clang-20
powerpc64             randconfig-002-20240922    gcc-14.1.0
powerpc64             randconfig-003-20240922    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20240922    gcc-14.1.0
riscv                 randconfig-002-20240922    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20240922    clang-20
s390                  randconfig-002-20240922    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240922    gcc-14.1.0
sh                    randconfig-002-20240922    gcc-14.1.0
um                               allmodconfig    clang-20
um                               allyesconfig    gcc-12
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

