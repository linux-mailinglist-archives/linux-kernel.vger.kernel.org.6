Return-Path: <linux-kernel+bounces-446023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93B9F1E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1961889E92
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1271922D4;
	Sat, 14 Dec 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meJaMDpQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAD3CF58
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734180065; cv=none; b=F18K2Dn2jSVScqTu9jYj1jeYs2nbYY6v0QRMMuqzU1qAU1jVj3waFDB5k4MflL2RljBVVvO3QZDAwySQJ+LZ+aL8F5S5Zo1NvJrkD18FDSYLFKePmf4JsP+7GX/WyRpWUms3FeF7YwFDQGQgKdyKMDN18AWAeS+Uqg8SZEiaG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734180065; c=relaxed/simple;
	bh=aaYH2V4SA1Qldfx41VW2s1VHi+ScY/MRsEu05DhKJss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O/pdyoaydh+r2K1OWSnzPQXEYQwL1KkTQkVqCU89otSesydtnd4xqnWEz2wGnQB6w+Kkrz+JMynzbxDWz35oZSie9OcynFJ1HsqtBMV/2LonQYWfC151Y4pMLh9Dd9Q6Yf7/N9/h0KZh40pu0Z5RZtsbtWBGFf21h2jsdQAhzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meJaMDpQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734180064; x=1765716064;
  h=date:from:to:cc:subject:message-id;
  bh=aaYH2V4SA1Qldfx41VW2s1VHi+ScY/MRsEu05DhKJss=;
  b=meJaMDpQDM4Q9sqiTc/+MFPDp6MXjhlDemOybFhtadcCVO7L6oir8NEO
   Ld4ZeS9my3fnuPdvYbmBhOYH/w7OaI6uPWAZvBWMuuZKKgeaDekNyvL0x
   weMngQ4Bg0RdsvPKLVCB8tbe7c2Xp807wPmzTfmp4p/meCxWEfrzyRyMd
   hXfZNA2P3NAD6p5NzANta+oa80vk9r91WJdH//1MDWmY0jI0DmYCqTvHR
   A/7vZqcn1nWsr6wCAiOLHFh4DdNnOekbkJ/vu+Zfn4u+ziPA/L6sxLGYc
   IPdGVrqfNgPYSDheVLlfVtbQ7LxKlbd+7sefz2NDoaohhFPwkSWcec6CH
   Q==;
X-CSE-ConnectionGUID: +TjSSDi8TQ++fotvWqwEAA==
X-CSE-MsgGUID: H+vr4U/yRQKVC5gRh8TBNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="38309420"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="38309420"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 04:41:03 -0800
X-CSE-ConnectionGUID: 9FZBj1T1Q92Jp5GncxM8MQ==
X-CSE-MsgGUID: FT040BYBQSmCPXXefvtL+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="96649466"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2024 04:41:02 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMRS7-000Cvn-2u;
	Sat, 14 Dec 2024 12:40:59 +0000
Date: Sat, 14 Dec 2024 20:40:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7e39d667b06c0849ab9cec1c96e2dc253a57310b
Message-ID: <202412142001.Hc4u917h-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7e39d667b06c0849ab9cec1c96e2dc253a57310b  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1457m

configs tested: 56
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241213    gcc-13.2.0
arc                  randconfig-002-20241213    gcc-13.2.0
arm                  randconfig-001-20241213    clang-16
arm                  randconfig-002-20241213    clang-18
arm                  randconfig-003-20241213    gcc-14.2.0
arm                  randconfig-004-20241213    clang-18
arm64                randconfig-001-20241213    gcc-14.2.0
arm64                randconfig-002-20241213    gcc-14.2.0
arm64                randconfig-003-20241213    clang-18
arm64                randconfig-004-20241213    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch            randconfig-001-20241214    gcc-14.2.0
loongarch            randconfig-002-20241214    gcc-14.2.0
nios2                randconfig-001-20241214    gcc-14.2.0
nios2                randconfig-002-20241214    gcc-14.2.0
parisc               randconfig-001-20241214    gcc-14.2.0
parisc               randconfig-002-20241214    gcc-14.2.0
powerpc              randconfig-001-20241214    clang-20
powerpc              randconfig-002-20241214    clang-15
powerpc              randconfig-003-20241214    clang-20
powerpc64            randconfig-001-20241214    gcc-14.2.0
powerpc64            randconfig-003-20241214    clang-20
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

