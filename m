Return-Path: <linux-kernel+bounces-547148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D85A50373
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165687A3E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0A2500C5;
	Wed,  5 Mar 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0Jpe6J+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC41465AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188436; cv=none; b=a78RU1EBkHDKWtF8kw8EbZRJ5tiGzJJw/gSXB13JqC+JM+qWkb5wIrxTtjOcD4xB4sJAosPLC+4VzCbF3Pb5QhnNQ2JJ2GQcoIHEU7l80bFUxoiHm42Z81zksTvzGTR8gdUttq9dG2vk0saEj6RHDwl2YH6Q6bqIpJoJOsBFGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188436; c=relaxed/simple;
	bh=X2KFKn8H9GBwSj3xFIyJUmnKNNBENXEcEiFQgF0eP0w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RM4oSoUvOWiHwLPBE/3SIlA0jqou09CutMUO7/HiJ09Fx7zvFVDU0jpjTxS9aSAVf8T6PGlVFrvBbeUa55pws2ySD+m9riEUwwMm8RByI7KF8Wxc+PSer6uqo4sf5aBAg0w+fUDgqg7wVOe/J3VDS9S3A69AGosuvO/OiNlZfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0Jpe6J+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741188434; x=1772724434;
  h=date:from:to:cc:subject:message-id;
  bh=X2KFKn8H9GBwSj3xFIyJUmnKNNBENXEcEiFQgF0eP0w=;
  b=W0Jpe6J+efhjqLPSNG94ZYL43fSkMtpFAc+9sShz2npS8/deQTnRzeA9
   kf54fC/wTN3eBxQAw5Ru0Qs7Xr+8n6lpbGTbQXiuWVmjWCcyfoQSVBP+D
   6WGMR6aKpJvYLObKGzjWknkG5OKE3b0IA86FBvt8CKCCwMsgPByi0Zen7
   uJ3aWwS3DP4fnhKuPPHqMc1idW9MNQQTY4PJadls+qehfsY3zS06rTy6u
   McfYzBI5F8Pmt7gADYjC+vky2g3ysR+OM6AZpLRxli33+VkC6TsDCioEb
   OTg8GwZZa/4FLTgU6uof8FJQNr7sfwWte0q2opN2MGC8Fc5+fwrGUqPwM
   Q==;
X-CSE-ConnectionGUID: 6TFVww3xTXaYUq9psmZGGQ==
X-CSE-MsgGUID: NB/82C09SvSA3wm0zmZ3mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42296167"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42296167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:27:13 -0800
X-CSE-ConnectionGUID: V7pq7CZaS2ORxqj1ijeyqw==
X-CSE-MsgGUID: 0qc90rfUTx64MOJ4nWrC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="119412518"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 05 Mar 2025 07:27:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpqeK-000L9H-2c;
	Wed, 05 Mar 2025 15:27:08 +0000
Date: Wed, 05 Mar 2025 23:26:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 71cbbb7149e3de8c39dfe8a97eaa7f1cbcbff52f
Message-ID: <202503052348.hgfybaMM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 71cbbb7149e3de8c39dfe8a97eaa7f1cbcbff52f  irqchip/davinci-cp-intc: Remove public header

elapsed time: 1451m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250305    gcc-13.2.0
arc                  randconfig-002-20250305    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250305    gcc-14.2.0
arm                  randconfig-002-20250305    clang-19
arm                  randconfig-003-20250305    gcc-14.2.0
arm                  randconfig-004-20250305    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250305    clang-15
arm64                randconfig-002-20250305    gcc-14.2.0
arm64                randconfig-003-20250305    clang-21
arm64                randconfig-004-20250305    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250305    gcc-14.2.0
csky                 randconfig-002-20250305    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250305    clang-21
hexagon              randconfig-002-20250305    clang-18
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250305    clang-19
i386       buildonly-randconfig-002-20250305    clang-19
i386       buildonly-randconfig-003-20250305    clang-19
i386       buildonly-randconfig-004-20250305    clang-19
i386       buildonly-randconfig-005-20250305    clang-19
i386       buildonly-randconfig-006-20250305    gcc-12
i386                               defconfig    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250305    gcc-14.2.0
loongarch            randconfig-002-20250305    gcc-14.2.0
nios2                randconfig-001-20250305    gcc-14.2.0
nios2                randconfig-002-20250305    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250305    gcc-14.2.0
parisc               randconfig-002-20250305    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250305    clang-17
powerpc              randconfig-002-20250305    gcc-14.2.0
powerpc              randconfig-003-20250305    gcc-14.2.0
powerpc64            randconfig-001-20250305    clang-19
powerpc64            randconfig-002-20250305    clang-17
powerpc64            randconfig-003-20250305    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250305    clang-19
riscv                randconfig-002-20250305    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250305    gcc-14.2.0
s390                 randconfig-002-20250305    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250305    gcc-14.2.0
sh                   randconfig-002-20250305    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250305    gcc-14.2.0
sparc                randconfig-002-20250305    gcc-14.2.0
sparc64              randconfig-001-20250305    gcc-14.2.0
sparc64              randconfig-002-20250305    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250305    clang-19
um                   randconfig-002-20250305    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250305    clang-19
x86_64     buildonly-randconfig-002-20250305    gcc-12
x86_64     buildonly-randconfig-003-20250305    clang-19
x86_64     buildonly-randconfig-004-20250305    gcc-12
x86_64     buildonly-randconfig-005-20250305    clang-19
x86_64     buildonly-randconfig-006-20250305    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250305    gcc-14.2.0
xtensa               randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

