Return-Path: <linux-kernel+bounces-407005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED64C9C6758
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14085B2534D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07F13AD1C;
	Wed, 13 Nov 2024 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9/p6VOr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5041C64
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465190; cv=none; b=eJi7+2QF1VTGKhuRSNpOMmkbvBNPbV06DT88UuxUIjFZKJzCmH7McyEnlBXHb4hEmf/8tAh86UOFxnSMAx9Jy6M51216NvWkX/S1vHW5iUXu+SFN9XOWNVML1s5djkVXPK+JgecwZDXjC7h3k5WMY347aA4WhIGmpLIk8jgaYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465190; c=relaxed/simple;
	bh=4B4Ta9fU5vnW3DKSbM/YXoUMmMFrcSK4stQudt4YHGc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b3pfsgonMG+O60PNgMUOzPtIm113Bin8aXb8mVfrGjqpy77/ReZZTgM6Klm0ZFyKuAelS/NHel0mIuMcxrdlorSDKiCj2m8BB/zrc40IwZg6QqG7Qo2eK8IBl4CmBmzpZODoDRWtDJro0ZD309cIyVZblAJugTOGtIyc6mF4O+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9/p6VOr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731465188; x=1763001188;
  h=date:from:to:cc:subject:message-id;
  bh=4B4Ta9fU5vnW3DKSbM/YXoUMmMFrcSK4stQudt4YHGc=;
  b=O9/p6VOrmtrxv1yH6p9KGr2Rd1ffu/A+jc05AMG+4TlezviEj9k2OL0A
   jlOnnCPmORTX0b5hKYnSLldpnMo6D5NS1COxwRa9RTxzk+0O/peABC4wk
   QG3YXVlBB1Ued+5YrqbLqSP65dE1XUFiPeRmgJE4kIe0FRnq09MwF3WRd
   ouj3li4SNyNhgU/H94EVj2CQZ5L5ZvwfuVsFJh6EHf04fEkQtKhAYHjwF
   tZbh/Y8dMa0N2ATzbxZb8h1SydrsawoaxgmOgqnAouiVZWGUosGuLlIun
   rGEgDJiVOEuf9EMc/P85RG63v9BqFq4GuXo2JZ5l+2dRuZoL4ZBzNr9Nu
   Q==;
X-CSE-ConnectionGUID: g6S0Gb5dQ5uVvNoNKsOgag==
X-CSE-MsgGUID: CuQfPh7/Qque+K+Jhlb5pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31440096"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="31440096"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 18:33:07 -0800
X-CSE-ConnectionGUID: cFo0roMoRdaqciN/cZ058w==
X-CSE-MsgGUID: E6h9PwJsS/6OFChm3/14dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="111030787"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2024 18:33:06 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB3Bo-0001wn-2C;
	Wed, 13 Nov 2024 02:33:04 +0000
Date: Wed, 13 Nov 2024 10:32:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 a0e35b3c3ac10ef1e4f35fb0cae3bf39950239b7
Message-ID: <202411131002.wOBS4cwp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: a0e35b3c3ac10ef1e4f35fb0cae3bf39950239b7  srcu: Unconditionally record srcu_read_lock_lite() in ->srcu_reader_flavor

elapsed time: 1234m

configs tested: 55
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.2.0
alpha       allyesconfig    clang-20
arc         allmodconfig    clang-20
arc          allnoconfig    gcc-14.2.0
arc         allyesconfig    clang-20
arm         allmodconfig    clang-20
arm          allnoconfig    gcc-14.2.0
arm         allyesconfig    clang-20
arm64       allmodconfig    clang-20
arm64        allnoconfig    gcc-14.2.0
csky         allnoconfig    gcc-14.2.0
hexagon     allmodconfig    clang-20
hexagon      allnoconfig    gcc-14.2.0
hexagon     allyesconfig    clang-20
i386        allmodconfig    clang-19
i386         allnoconfig    clang-19
i386        allyesconfig    clang-19
i386           defconfig    clang-19
loongarch   allmodconfig    gcc-14.2.0
loongarch    allnoconfig    gcc-14.2.0
m68k        allmodconfig    gcc-14.2.0
m68k         allnoconfig    gcc-14.2.0
m68k        allyesconfig    gcc-14.2.0
microblaze  allmodconfig    gcc-14.2.0
microblaze   allnoconfig    gcc-14.2.0
microblaze  allyesconfig    gcc-14.2.0
mips         allnoconfig    gcc-14.2.0
nios2        allnoconfig    gcc-14.2.0
openrisc     allnoconfig    clang-20
openrisc    allyesconfig    gcc-14.2.0
parisc      allmodconfig    gcc-14.2.0
parisc       allnoconfig    clang-20
parisc      allyesconfig    gcc-14.2.0
powerpc     allmodconfig    gcc-14.2.0
powerpc      allnoconfig    clang-20
powerpc     allyesconfig    gcc-14.2.0
riscv       allmodconfig    gcc-14.2.0
riscv        allnoconfig    clang-20
riscv       allyesconfig    gcc-14.2.0
s390        allmodconfig    gcc-14.2.0
s390         allnoconfig    clang-20
s390        allyesconfig    gcc-14.2.0
sh          allmodconfig    gcc-14.2.0
sh           allnoconfig    gcc-14.2.0
sh          allyesconfig    gcc-14.2.0
sparc       allmodconfig    gcc-14.2.0
um          allmodconfig    clang-20
um           allnoconfig    clang-20
um          allyesconfig    clang-20
x86_64       allnoconfig    clang-19
x86_64      allyesconfig    clang-19
x86_64         defconfig    clang-19
x86_64             kexec    clang-19
x86_64          rhel-8.3    gcc-12
xtensa       allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

