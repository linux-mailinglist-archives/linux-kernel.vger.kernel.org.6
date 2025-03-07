Return-Path: <linux-kernel+bounces-551009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43195A566DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DB3188946C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8242217677;
	Fri,  7 Mar 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do7rjWG5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C98149C50
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347363; cv=none; b=JZ3IB30P7aQR87gkEt37Wev+PisH1mUxYvrv6oaXD/H+/Zpaa2pGgREfSIeLikLnRdLXjkTzCqWZAmn0TDzvY7iDYHXuq7GweyejkqM9wYOXe/XaJaAUbeUZU653MMAce1GkzOeVOhIDXILSpl+903qr5JVMhyxdfvuMp+PziPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347363; c=relaxed/simple;
	bh=s0CTBTAc57riCsNIVPzPYq0916bfiL/a6CFxehNzsOk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PxUarfMRDjLUJEbuP9jEjrBriVrAmDLjlF/QDBFCS4FEvNdHSSFxqy+xgx/gt85F62inDTYtlAr2Xr5UAS9IVeUZBdRKt8+POkq/5xvYhGdQ/e92jjDGKEvfPS3Wlix52d4tVKy6Np/PKuPMP106VyHdNYx1gIxBC7WjnFgXics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do7rjWG5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741347362; x=1772883362;
  h=date:from:to:cc:subject:message-id;
  bh=s0CTBTAc57riCsNIVPzPYq0916bfiL/a6CFxehNzsOk=;
  b=do7rjWG5TKu2tn7QHZAMbdsbQbg1bCPMNXlJnQLCtoTLhnsk/miU6tgw
   O5f6mHbMnkrsmaxWv6pNsRHCpTthz+F6ac+bH9r37SY6nY/YMIsdg4MaF
   qx1WAEAg4CULF+rsWD1kMJeLj4bneePY2dkyq7mMvhThAcL7CUUu7xHO8
   V0hzHGKUMf5lQiOidy6oBP2YaVCOrL7FnCBCWdyxK49nXNAGgEoOvzAZg
   t9S3AG/3+5AmaobC+hG93SjTurKxqQh6IbpUO06MKk79nCencHx4iiA3N
   b10LgoG0HLR6PIbgUclC1vNkCadzPXarMkPIT86PrTuhURUwCaNiJsT4y
   g==;
X-CSE-ConnectionGUID: z0zpzYOSSnCdbiJ94zs0vg==
X-CSE-MsgGUID: hJVgrOT2QBicIPKxtqhzOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42523409"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42523409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:36:01 -0800
X-CSE-ConnectionGUID: CsF76SWmQPu23q2bm8HgrQ==
X-CSE-MsgGUID: /xxplntSRueVLESna1JivA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119227378"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2025 03:36:00 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqVzi-0000O9-02;
	Fri, 07 Mar 2025 11:35:58 +0000
Date: Fri, 07 Mar 2025 19:34:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 0896acd80782ec49c6d36e576fcd53786f0a2bfb
Message-ID: <202503071948.ZeeHdg51-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 0896acd80782ec49c6d36e576fcd53786f0a2bfb  x86/mm: Always set the ASID valid bit for the INVLPGB instruction

elapsed time: 2278m

configs tested: 65
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                 randconfig-001-20250306    gcc-14.2.0
csky                 randconfig-002-20250306    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250306    clang-21
hexagon              randconfig-002-20250306    clang-19
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
loongarch            randconfig-001-20250306    gcc-14.2.0
loongarch            randconfig-002-20250306    gcc-14.2.0
nios2                randconfig-001-20250306    gcc-14.2.0
nios2                randconfig-002-20250306    gcc-14.2.0
parisc               randconfig-001-20250306    gcc-14.2.0
parisc               randconfig-002-20250306    gcc-14.2.0
powerpc              randconfig-001-20250306    clang-21
powerpc              randconfig-002-20250306    clang-18
powerpc              randconfig-003-20250306    gcc-14.2.0
powerpc64            randconfig-001-20250306    clang-18
powerpc64            randconfig-002-20250306    clang-21
powerpc64            randconfig-003-20250306    clang-18
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

