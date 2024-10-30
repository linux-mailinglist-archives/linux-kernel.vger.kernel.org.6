Return-Path: <linux-kernel+bounces-388070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CE9B5A18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63A11C2282F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B421990BA;
	Wed, 30 Oct 2024 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqDVmkAo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15A1946DA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256350; cv=none; b=JbVZbePylnvq7aSV8Ts30n4qbIRa2W9k6O0JVBfEzNp7JvdtvwGHbE+owjg89H+VIncJtu1zBzJwp7vGzlQZiDTP90jCTrFQinSAFbwGu9ld8fUhXCdu4cRh9mrd+mvLp7R69R86sfpYXE6MLdHVNNzQx8V4JS4qzlKA7LwHKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256350; c=relaxed/simple;
	bh=3cFRgxpKgXTZksTpHvBjO0Kn0raiACrJGMIE6pnPib0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IPc7INvaUjdRSksctE94gAPR9DSdH4R4BP8yACGd0uJHZwggyz2sVfDJ2PrE5kO9EqIrWm4PVYivC8jobf6W+fZocqyADwtUixBD7x+RTQdFkZWNO3KIPciaceajDX0dr4MK7EHPDf6QAbkj1tKZ+alCL0Kd4XCeZ3697ApqlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqDVmkAo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730256348; x=1761792348;
  h=date:from:to:cc:subject:message-id;
  bh=3cFRgxpKgXTZksTpHvBjO0Kn0raiACrJGMIE6pnPib0=;
  b=IqDVmkAoWp5R+tRIJNQ/CPcDi4RUlXrNpgHcbx8QIrGZ5jAJcrA612nB
   dbHCalK6lMs6xEMnAry7jSQl71YVxTHtKeCftPien+xHpYZzMMDLnbDRH
   aHEpWaz0XCOF2JZDrgmlMeVHV6ky/7MtYGfyrsCA91u0JJmzwbCcyfauV
   TxhO6W+nIgeXv7HnKxRoiMH4S0ZLPtVsj1dbkVZMUu5EanilKoh1DanPL
   U9VUUtcGCg2ZCDbYZBTLS+2UrUNJ2rronBZzu9OYxWJ+A+EG05GSHkCUb
   8aT+/8csXc5PLriwkz/lbaXAp6xU5A1zutPTHiTlNs73UEPJ+/mLzN8zU
   Q==;
X-CSE-ConnectionGUID: h4o48G5jSum9gnuOPgGoQQ==
X-CSE-MsgGUID: /dKj68bmQji6FnYIbn5C1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29703190"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29703190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:45:45 -0700
X-CSE-ConnectionGUID: kcfCK39bQBSK0xPQHVVdLQ==
X-CSE-MsgGUID: E2i6l7V/SVKv3Kd9G3LY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82102374"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Oct 2024 19:45:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5yiL-000eQv-34;
	Wed, 30 Oct 2024 02:45:41 +0000
Date: Wed, 30 Oct 2024 10:44:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 1550dde8a537b35dbf066c7f9cfe5f9b360bce0d
Message-ID: <202410301033.PIMMZrn6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 1550dde8a537b35dbf066c7f9cfe5f9b360bce0d  posix-timers: Add proper state tracking

Warning ids grouped by kconfigs:

recent_errors
|-- x86_64-allnoconfig
|   `-- Warning:drivers-regulator-core.c-references-a-file-that-doesn-t-exist:Documentation-timers-timers-howto.rst
`-- x86_64-randconfig-121-20241029
    `-- kernel-signal.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-spinlock-usertype-l-got-struct-spinlock-noderef-__rcu

elapsed time: 909m

configs tested: 80
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
powerpc         allyesconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    clang-20
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    clang-20
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

