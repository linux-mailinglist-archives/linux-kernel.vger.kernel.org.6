Return-Path: <linux-kernel+bounces-408597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C297A9C80E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0B1F21BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA751E3DEF;
	Thu, 14 Nov 2024 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXHox3br"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF681F95E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551978; cv=none; b=CjH/N9TXUsq90X7GbO/yHJbECm6FatQe0H4mOW2DMniaDHdQ/WRknfJX5W/Cuz/8MvbJKurF8jJS2PkHfjKqe083AwU8qS4HhDa8U89Qm7wRKaeCpcHrl3gaOb9t4d8c2v9A1WuZ+lBBHc/SlznavXhypFUIeb8Hrcweb3WryvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551978; c=relaxed/simple;
	bh=HtwMRICIohc7Hsrenws2SjvHyz038JQTwRgDobdkBtQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hZ1D5s8hpEZvs+eMjAKbQEq5Axtcr5N+xL8WIAiM+RUqlw0dzSdF0YbL9CiIfDuxT+o7FF/YsQpCvbjPdTU/8uWJxVAHumKzoqEur9KrRDBgRj+ftNpXp5elDpbzs3ABl1DdycmAV1zcng8ohliOJWReOP0WhNei7wT39nKGT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXHox3br; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731551977; x=1763087977;
  h=date:from:to:cc:subject:message-id;
  bh=HtwMRICIohc7Hsrenws2SjvHyz038JQTwRgDobdkBtQ=;
  b=jXHox3brcBAodOGUycg0dYADTHh+jAQ8N+crrEI4CdH6Tlnqj9PG78vi
   moIaiZbUgCDScpp3DzC5Tn6WlKvIBjmRChAzybCR775Rsx7Q+vqiPYt7v
   PfixdsJfZqkA9YNPBjc//3mGiRtS5eKcTG589AI2P5TgqFzkhYcpr/VPG
   Ynw45N0znxOBBkE11RUqYBrltVbUdpmme0JLTceMn4wtd7Jx7+keKFaVo
   MzS8nqPaBeFLqgRYEVfeESg31R8awUAAqSzUyfK7amc/QYIG4w13gRQ9L
   JGvcH2wzjs+tDWpHYFm3QFoODNQQ99vMqan09JcxaatCup/L+bP+5no5G
   g==;
X-CSE-ConnectionGUID: ch2ST4MMScO02AU1cyRNaw==
X-CSE-MsgGUID: YoO/I2t9TGWwbc9zJXVwBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="35269634"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="35269634"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:39:35 -0800
X-CSE-ConnectionGUID: Bsbyc8GaSrSv/bQv0j658w==
X-CSE-MsgGUID: J4YArSAaShOvFqvy2dfPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="87941376"
Received: from lkp-server01.sh.intel.com (HELO b014a344d658) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Nov 2024 18:39:34 -0800
Received: from kbuild by b014a344d658 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBPlb-00003V-2i;
	Thu, 14 Nov 2024 02:39:31 +0000
Date: Thu, 14 Nov 2024 10:39:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 8d9ffb2fe65a6c4ef114e8d4f947958a12751bbe
Message-ID: <202411141012.3XsZzm5m-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 8d9ffb2fe65a6c4ef114e8d4f947958a12751bbe  x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=y

elapsed time: 737m

configs tested: 59
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allyesconfig    clang-20
arc                 allmodconfig    clang-20
arc                 allyesconfig    clang-20
arc           vdk_hs38_defconfig    gcc-14.2.0
arm                 alldefconfig    gcc-14.2.0
arm                 allmodconfig    clang-20
arm                 allyesconfig    clang-20
arm               dove_defconfig    gcc-14.2.0
arm            socfpga_defconfig    gcc-14.2.0
arm64               allmodconfig    clang-20
hexagon             allmodconfig    clang-20
hexagon             allyesconfig    clang-20
i386                allmodconfig    clang-19
i386                 allnoconfig    clang-19
i386                allyesconfig    clang-19
i386                   defconfig    clang-19
loongarch           allmodconfig    gcc-14.2.0
m68k                allmodconfig    gcc-14.2.0
m68k                allyesconfig    gcc-14.2.0
m68k           m5272c3_defconfig    gcc-14.2.0
m68k           m5307c3_defconfig    gcc-14.2.0
m68k               q40_defconfig    gcc-14.2.0
microblaze          allmodconfig    gcc-14.2.0
microblaze          allyesconfig    gcc-14.2.0
mips         bmips_stb_defconfig    gcc-14.2.0
mips        loongson1b_defconfig    gcc-14.2.0
openrisc             allnoconfig    clang-20
openrisc            allyesconfig    gcc-14.2.0
openrisc     or1klitex_defconfig    gcc-14.2.0
parisc              allmodconfig    gcc-14.2.0
parisc               allnoconfig    clang-20
parisc              allyesconfig    gcc-14.2.0
powerpc             allmodconfig    gcc-14.2.0
powerpc              allnoconfig    clang-20
powerpc             allyesconfig    gcc-14.2.0
powerpc           cell_defconfig    gcc-14.2.0
powerpc          ebony_defconfig    gcc-14.2.0
powerpc        mpc83xx_defconfig    gcc-14.2.0
powerpc       socrates_defconfig    gcc-14.2.0
riscv               allmodconfig    gcc-14.2.0
riscv                allnoconfig    clang-20
riscv               allyesconfig    gcc-14.2.0
s390                allmodconfig    gcc-14.2.0
s390                 allnoconfig    clang-20
s390                allyesconfig    gcc-14.2.0
sh                  allmodconfig    gcc-14.2.0
sh                  allyesconfig    gcc-14.2.0
sh              se7721_defconfig    gcc-14.2.0
sparc               allmodconfig    gcc-14.2.0
um                  allmodconfig    clang-20
um                   allnoconfig    clang-20
um                  allyesconfig    clang-20
x86_64               allnoconfig    clang-19
x86_64              allyesconfig    clang-19
x86_64                 defconfig    clang-19
x86_64                     kexec    clang-19
x86_64                     kexec    gcc-12
x86_64                  rhel-8.3    gcc-12
xtensa             iss_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

