Return-Path: <linux-kernel+bounces-408411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544689C7E70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 972B6B21B77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9E18BB84;
	Wed, 13 Nov 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE4LE+yW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC02AE84
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538488; cv=none; b=VhKb/qWcnWRJwDnqbgz7l3aRFElnv8oXDw/tXacmWjMllId5FisBAgegHgBdxQTfve3BOU61evMS+Mj5aCIx/380UDCmobOeqxbU0nI1Jzty5yea/GUbpubVys5KWHruFmt+aRHj2RoPCgfYpLv8xyQXtJyDLTdbhxUhA8bm/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538488; c=relaxed/simple;
	bh=1y/gn5kjsgX1oFj7j52d+i6b3aeNT/ZUKOYSEKL9dm8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OZ+ijxo0C/d8liouL/+W9UsyK+3JYJPLrkKanBPjU7+2qyv9dgFdO42PkpBrhI5f608x0yXlmIM0Iuh6yDb0yhvf4ROfxkU15gxH70azTl8CJdMtk3uNwuRnQQg2DkIdbQIPpN81qKI8xgrk79mrl+1h3O2qn+/a74Qb0jbJ04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE4LE+yW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731538487; x=1763074487;
  h=date:from:to:cc:subject:message-id;
  bh=1y/gn5kjsgX1oFj7j52d+i6b3aeNT/ZUKOYSEKL9dm8=;
  b=cE4LE+yWjk9VimuIGW8QVzSFu0dP9uRJ2uXXEnEu2ZNo2P5Q+hLSkIlV
   MbK8jIKPg1RVuM5w7rF+c/YZTOuV7TXBnSIxzs9owz3N6ygvY87UgQtcH
   5p1q1/1AjjdmAJ5yQZPGvF32X7UPRGRv7NVjjj2KHdOLsa/LkgT0pUrnR
   BjrYukpy5VqT5H7O2XaxvoO/C09GiLOmjRU9PwyprFV7Oj3gshbiMEY+0
   wbnzezq0csqJHnztenPweHtFIOXBq2IwBnaIm7asWrg7lhKHx2rX1W8U2
   1JxAjL7B149/JHxTLuOBFfcnxG7YHrBw3nf8Ao1u/s2rmAk7rDXGoOxAp
   A==;
X-CSE-ConnectionGUID: 0gzO2fx3R5ubean5ETJ8sw==
X-CSE-MsgGUID: prTAldPcS+SG/L4XPkU0cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31430253"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31430253"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:54:47 -0800
X-CSE-ConnectionGUID: uv+hOKBOTbiZMT2Pt+gmjA==
X-CSE-MsgGUID: cFF3LUTITia1C3xklNgfTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92949970"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2024 14:54:46 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBMG3-0000oR-2A;
	Wed, 13 Nov 2024 22:54:43 +0000
Date: Thu, 14 Nov 2024 06:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 c02d480cf0ffd2c1d32d0fea4399a9fabfc0b895
Message-ID: <202411140610.dEDhnh3A-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: c02d480cf0ffd2c1d32d0fea4399a9fabfc0b895  Merge branch into tip/master: 'x86/urgent'

elapsed time: 729m

configs tested: 64
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.2.0
arc                     allnoconfig    gcc-14.2.0
arc            axs103_smp_defconfig    gcc-13.2.0
arc                  hsdk_defconfig    gcc-13.2.0
arm                    alldefconfig    gcc-13.2.0
arm                     allnoconfig    gcc-14.2.0
arm                gemini_defconfig    gcc-13.2.0
arm                 sama5_defconfig    gcc-13.2.0
arm              spear6xx_defconfig    gcc-13.2.0
arm                 sunxi_defconfig    gcc-13.2.0
arm64                   allnoconfig    gcc-14.2.0
csky                    allnoconfig    gcc-14.2.0
hexagon                 allnoconfig    gcc-14.2.0
i386                   allmodconfig    clang-19
i386                   allmodconfig    gcc-12
i386                    allnoconfig    clang-19
i386                    allnoconfig    gcc-12
i386                   allyesconfig    clang-19
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch               allnoconfig    gcc-14.2.0
m68k                    allnoconfig    gcc-14.2.0
m68k                 virt_defconfig    gcc-13.2.0
microblaze              allnoconfig    gcc-14.2.0
mips                    allnoconfig    gcc-14.2.0
mips                 ip27_defconfig    gcc-13.2.0
nios2                   allnoconfig    gcc-14.2.0
openrisc                allnoconfig    clang-20
openrisc                  defconfig    gcc-12
parisc                  allnoconfig    clang-20
parisc                    defconfig    gcc-12
powerpc                 allnoconfig    clang-20
powerpc            bamboo_defconfig    gcc-13.2.0
powerpc       linkstation_defconfig    gcc-13.2.0
powerpc         lite5200b_defconfig    gcc-13.2.0
powerpc       mpc832x_rdb_defconfig    gcc-13.2.0
powerpc     mpc834x_itxgp_defconfig    gcc-13.2.0
riscv                   allnoconfig    clang-20
riscv                     defconfig    gcc-12
s390                   allmodconfig    gcc-14.2.0
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.2.0
s390                      defconfig    gcc-12
sh                     allmodconfig    gcc-14.2.0
sh                      allnoconfig    gcc-14.2.0
sh                     allyesconfig    gcc-14.2.0
sh                        defconfig    gcc-12
sh                 se7343_defconfig    gcc-13.2.0
sh           sh7710voipgw_defconfig    gcc-13.2.0
sparc                  allmodconfig    gcc-14.2.0
sparc64                   defconfig    gcc-12
um                      allnoconfig    clang-20
um                        defconfig    gcc-12
um                   i386_defconfig    gcc-12
um                 x86_64_defconfig    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                        kexec    gcc-12
x86_64                     rhel-8.3    gcc-12
xtensa                  allnoconfig    gcc-14.2.0
xtensa      generic_kc705_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

