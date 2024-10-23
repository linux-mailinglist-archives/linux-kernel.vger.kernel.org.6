Return-Path: <linux-kernel+bounces-377345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E8D9ABD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AC91F23070
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39113BC18;
	Wed, 23 Oct 2024 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6goqNoE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB939ACC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729659810; cv=none; b=ggH7VTllfHkI9fAZbOyGCavq03nJIqi6nPPBd69w/Mk1fwEwc3kJ6ayaunkjigxfw1Uy2B+l9qd3vfP6WK9Vuj8CfVPP6tpkqtLNluL3fl8ktF5xCtcJ/ms23BZs9Q1Z0dvLLDVdASbo/HTJ6upcLtZ57CcKRdDrjNRFYGdBccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729659810; c=relaxed/simple;
	bh=vHP/V7Zso/PyRpoNmgHnXDd/1O+3+cEyBKOoHeeGSdI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BWpiLXSY+XkPvThzhB09RXxYiS1+nl7c+wHD4qvnL1191lZRah6LgLqIV8PalZK3+/v39U6CPg3gA9qFoEWqaFIwXIYgJ1XT2b1afYszz2zxsQGWUW+SSFK6+g+cmO4Aadw1QOXOlgeEFGtWlfyc/zZh46hz22Ox0AWT86G19h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6goqNoE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729659809; x=1761195809;
  h=date:from:to:cc:subject:message-id;
  bh=vHP/V7Zso/PyRpoNmgHnXDd/1O+3+cEyBKOoHeeGSdI=;
  b=j6goqNoE+Z5Nctb4ZzGqVevZOLKP1mG2clERKW7COsgOaug1TOUF23JI
   SJ71PVNVDIG8mristtPGUTpsT3qhiZHpzm4kpxIQL3FCeMZEeuVaICtga
   ZnVXG9vXaSg7+8Tq81fYGPhWHaF+HFsWQ4UXDNrroIbwksWkrurLAsxz+
   UYsHY0OR4PLUYX4Hr1jaEwWrZjlQrM83BgHtHK/S2Coon7sjV7WotJqaB
   hdN0M+FVLk2P7i5XPTv+jSiAWsSOQjbLOYjXZAtuh+/p9M6ko/8LXrZ7x
   8hx1FwbDLhQtnjEXTdkYI5oCNPV0nvXGaDdcj8/z5v/Ew99Qub5q5LdQY
   Q==;
X-CSE-ConnectionGUID: rySkwxy6S8mvCazNxAzGFQ==
X-CSE-MsgGUID: D30dDz/WSZGW0KeAWKhvHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="39846270"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="39846270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:03:26 -0700
X-CSE-ConnectionGUID: fhSQ49RvRUOtjCsz+M/WtQ==
X-CSE-MsgGUID: N0GwRNJvQQqCN52XebEJAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84669461"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Oct 2024 22:03:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3TWl-000USU-1U;
	Wed, 23 Oct 2024 05:03:23 +0000
Date: Wed, 23 Oct 2024 13:02:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 1d81d85d1a19e50d5237dc67d6b825c34ae13de8
Message-ID: <202410231320.99vbP0zm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 1d81d85d1a19e50d5237dc67d6b825c34ae13de8  x86/microcode/AMD: Split load_microcode_amd()

elapsed time: 731m

configs tested: 49
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                 alldefconfig    clang-20
arm         footbridge_defconfig    clang-20
arm         jornada720_defconfig    clang-20
arm          multi_v4t_defconfig    clang-20
arm            mv78xx0_defconfig    clang-20
arm              sunxi_defconfig    clang-20
i386                allmodconfig    clang-18
i386                 allnoconfig    clang-18
i386                allyesconfig    clang-18
i386                   defconfig    clang-18
loongarch           allmodconfig    gcc-14.1.0
m68k                allmodconfig    gcc-14.1.0
m68k                allyesconfig    gcc-14.1.0
microblaze          allmodconfig    gcc-14.1.0
microblaze          allyesconfig    gcc-14.1.0
mips              ip30_defconfig    clang-20
mips              jazz_defconfig    clang-20
nios2            3c120_defconfig    clang-20
openrisc             allnoconfig    clang-20
openrisc               defconfig    gcc-12
parisc               allnoconfig    clang-20
parisc                 defconfig    gcc-12
powerpc              allnoconfig    clang-20
powerpc       gamecube_defconfig    clang-20
powerpc         ppc44x_defconfig    clang-20
powerpc        redwood_defconfig    clang-20
riscv                allnoconfig    clang-20
riscv                  defconfig    gcc-12
s390                allmodconfig    gcc-14.1.0
s390                 allnoconfig    clang-20
s390                allyesconfig    gcc-14.1.0
s390                   defconfig    gcc-12
sh                  allmodconfig    gcc-14.1.0
sh                  allyesconfig    gcc-14.1.0
sh                     defconfig    gcc-12
sh              se7722_defconfig    clang-20
sh              se7724_defconfig    clang-20
sh           sh7785lcr_defconfig    clang-20
sparc               allmodconfig    gcc-14.1.0
sparc64                defconfig    gcc-12
um                   allnoconfig    clang-20
um                     defconfig    gcc-12
um                i386_defconfig    gcc-12
um              x86_64_defconfig    gcc-12
x86_64               allnoconfig    clang-18
x86_64              allyesconfig    clang-18
x86_64                 defconfig    clang-18
x86_64                     kexec    clang-18
x86_64                  rhel-8.3    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

