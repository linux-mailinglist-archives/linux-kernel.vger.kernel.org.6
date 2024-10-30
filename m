Return-Path: <linux-kernel+bounces-388048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E0C9B59D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040AF1F241F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DAC19259B;
	Wed, 30 Oct 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j15u1Eur"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608904437
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254666; cv=none; b=hEOS1AtwFN2mDbb4T8+eDy43Ztio/Ym/ZbPT4hyjDcfNVeZgkqLaAw9eXvVQ4fDUYAN69+VzeCU6ReyOCC+GSWyTg3GuNyv7e+8BRc83LQNb2jTeIU6LPtyacqbmEcxf5JmYHJRNQge1xGDfF/3+JPpmISGKQP55ABAvkYZm3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254666; c=relaxed/simple;
	bh=XvLLwZjGP5gfa+jo+Fuijfvc4lmo/bWgu7Linm7BCfY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f8AvUdS1bw01elNHK6MTcPFv9PBE4ucvUyRMD0uW6ebuSZ4oNUJoHa05slW6EBrU3WRL3RUV7q2eHfnkaUtjbUU2Th+qmRq31cbJ6I4/2RWerNQPVcEGRb0Ibwb/G3gnyXk2tQ4He1cstBY8MvxM0SnaizCaymeKJSSIQbUuQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j15u1Eur; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730254664; x=1761790664;
  h=date:from:to:cc:subject:message-id;
  bh=XvLLwZjGP5gfa+jo+Fuijfvc4lmo/bWgu7Linm7BCfY=;
  b=j15u1EurAItiqV/3Lye3uwbKPDQ0HXX32jysnAaFNS19ZupxYrdqMx0E
   qQlyKFaVNvvbrsD0J3jS9kxNfIhn9JafNW1YVj3vHv4cxyqq8d2bY8qUx
   fk0QD1CDc1tT8tyvgBtlOKQ7tBMr2/p97qzB3yOdklLBimivF8dBgLHNS
   0OqJ3eLTkbBRP22Uyzlb49McwFDLYywuMTkSRF7pzhVUlb1s7N0rOQMnm
   Pfh4JdJ9Nq6C4b8tWZHR0kpLhQMY/2TZ5niqahmEZOLrIec6uFRNvQ/aV
   6nv4AXzTlD7y3xi61INlFeWq6PJfTSr5buZJ/xNc4RK/DwJjkVGWv8jIn
   w==;
X-CSE-ConnectionGUID: BGaZQGwhSfyOOvtz/BHGiA==
X-CSE-MsgGUID: 7b6XRd+sRFmaMlyVOFnX4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="41337664"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="41337664"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:17:44 -0700
X-CSE-ConnectionGUID: NN/Q425RTdOy9Apk0dIoRw==
X-CSE-MsgGUID: haPR1NFER32iyK2lAm7CYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="86771014"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Oct 2024 19:17:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5yHE-000ePM-2Q;
	Wed, 30 Oct 2024 02:17:40 +0000
Date: Wed, 30 Oct 2024 10:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 5db91545ef8150c45a526675ef99e8998b648a41
Message-ID: <202410301023.PrhYhvi2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 5db91545ef8150c45a526675ef99e8998b648a41  sched: Pass correct scheduling policy to __setscheduler_class

elapsed time: 737m

configs tested: 76
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
alpha              defconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arc                defconfig    gcc-14.1.0
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm                defconfig    gcc-14.1.0
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
arm64              defconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
csky               defconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
hexagon            defconfig    gcc-14.1.0
i386            allmodconfig    clang-19
i386             allnoconfig    clang-19
i386            allyesconfig    clang-19
i386               defconfig    clang-19
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
loongarch          defconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
m68k               defconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
microblaze         defconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
nios2              defconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
parisc64           defconfig    gcc-14.1.0
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-19
x86_64          allyesconfig    clang-19
x86_64             defconfig    clang-19
x86_64                 kexec    clang-19
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

