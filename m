Return-Path: <linux-kernel+bounces-388069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A249B5A17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412C3B22BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE1196C67;
	Wed, 30 Oct 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvjPLA2c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B46194AF4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256347; cv=none; b=MgBMKqfASJDxb7bLVkXD9oNw3na58blobEjHElFpfs5Kqsq/bgvrig5hECQoCEgk8CYXCUukYsrVdUz9Njgm4UQpglbZifbMVwYP1tBMCXIQ7q12o17Sic7K2AK2TV+ESZ/o3T97cgtYUJIEmB06LXzCKeG4+V4XM7H+H7yMf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256347; c=relaxed/simple;
	bh=lC0BEgzdIKoa4TPyy81izcJDiI7PR2f8LE6mnKnb3jI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tajpgDtXDATRhrqCQtfiBJkLVpbtRtias6X78V2hwCGLg1RuEuof/6FNuWaTQc44zfMrMtJ75lQrD086iWW0uf+hGoZUzgpy63nuQFlMTkdlQofCVgSInqjpmCLxxOcS3rz1czhj2YfbuNmKrUuJdSfzEmcpBfdzu01m6FDzrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvjPLA2c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730256345; x=1761792345;
  h=date:from:to:cc:subject:message-id;
  bh=lC0BEgzdIKoa4TPyy81izcJDiI7PR2f8LE6mnKnb3jI=;
  b=VvjPLA2c+jG37iZq2N/ITdAh8O7qg9HI3ulVwpN54DLzTcponXzLI8rk
   iC9gJWSMLbJGpWWi+VeiB2PzTHOKCcyz5BsXRKqTFGoPYv/tLpE307zm6
   x8MmcQEieKM2JMI3lEtqrsSPW0BULRR+eVirGTu/KS9nDgiOUCwk0i2sI
   P9SBUta/s4RVjqKg9GvMa1RTnIXONNYeaT1jfSGgF37TOf3m5dSrzn5XB
   WJkr7m4RbQsTEa/U7oNkyi+lk4iHsngLxvMoQr32iSXAy61YBnKsicv8u
   i4PqPllEEF9ZL3YUIi5YUU0pSdZrYbB9xvfBBABlx9/4oMLvK0PeGYuiJ
   Q==;
X-CSE-ConnectionGUID: UnyfUEILSeGxaQ5wWxEZPg==
X-CSE-MsgGUID: PxLxY95sTB2T/JYrHqGhKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29703192"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29703192"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:45:45 -0700
X-CSE-ConnectionGUID: +ZG65z1NTRinoVuNQNekPw==
X-CSE-MsgGUID: fcEKB0mNS1O6N95jMZjsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82102372"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Oct 2024 19:45:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5yiL-000eQs-30;
	Wed, 30 Oct 2024 02:45:41 +0000
Date: Wed, 30 Oct 2024 10:45:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8b766b117ad0ef7311f0dec6f9b8c39e86393196
Message-ID: <202410301019.e0xCUoe0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8b766b117ad0ef7311f0dec6f9b8c39e86393196  Merge branch into tip/master: 'x86/sev'

elapsed time: 911m

configs tested: 64
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.1.0
alpha       allyesconfig    gcc-13.3.0
arc         allmodconfig    clang-20
arc         allmodconfig    gcc-13.2.0
arc          allnoconfig    gcc-14.1.0
arc         allyesconfig    clang-20
arc         allyesconfig    gcc-13.2.0
arm         allmodconfig    clang-20
arm         allmodconfig    gcc-14.1.0
arm          allnoconfig    gcc-14.1.0
arm         allyesconfig    clang-20
arm         allyesconfig    gcc-14.1.0
arm64       allmodconfig    clang-20
arm64        allnoconfig    gcc-14.1.0
csky         allnoconfig    gcc-14.1.0
hexagon     allmodconfig    clang-20
hexagon      allnoconfig    gcc-14.1.0
hexagon     allyesconfig    clang-20
i386        allmodconfig    clang-19
i386        allmodconfig    gcc-12
i386         allnoconfig    clang-19
i386         allnoconfig    gcc-12
i386        allyesconfig    clang-19
i386        allyesconfig    gcc-12
i386           defconfig    clang-19
loongarch   allmodconfig    gcc-14.1.0
loongarch    allnoconfig    gcc-14.1.0
m68k        allmodconfig    gcc-14.1.0
m68k         allnoconfig    gcc-14.1.0
m68k        allyesconfig    gcc-14.1.0
microblaze  allmodconfig    gcc-14.1.0
microblaze   allnoconfig    gcc-14.1.0
microblaze  allyesconfig    gcc-14.1.0
mips         allnoconfig    gcc-14.1.0
nios2        allnoconfig    gcc-14.1.0
openrisc     allnoconfig    clang-20
openrisc    allyesconfig    gcc-14.1.0
parisc      allmodconfig    gcc-14.1.0
parisc       allnoconfig    clang-20
parisc      allyesconfig    gcc-14.1.0
powerpc     allmodconfig    gcc-14.1.0
powerpc      allnoconfig    clang-20
powerpc     allyesconfig    clang-20
riscv       allmodconfig    clang-20
riscv        allnoconfig    clang-20
riscv       allyesconfig    clang-20
s390        allmodconfig    clang-20
s390        allmodconfig    gcc-14.1.0
s390         allnoconfig    clang-20
s390        allyesconfig    gcc-14.1.0
sh          allmodconfig    gcc-14.1.0
sh           allnoconfig    gcc-14.1.0
sh          allyesconfig    gcc-14.1.0
sparc       allmodconfig    gcc-14.1.0
um          allmodconfig    clang-20
um           allnoconfig    clang-20
um          allyesconfig    gcc-12
x86_64       allnoconfig    clang-19
x86_64      allyesconfig    clang-19
x86_64         defconfig    clang-19
x86_64         defconfig    gcc-11
x86_64             kexec    clang-19
x86_64          rhel-8.3    gcc-12
xtensa       allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

