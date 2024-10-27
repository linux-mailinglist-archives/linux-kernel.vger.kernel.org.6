Return-Path: <linux-kernel+bounces-383452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21F09B1BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 03:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55306282233
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF55101F2;
	Sun, 27 Oct 2024 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcnX+9TU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14A3C39
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729996509; cv=none; b=eYzRjK4f2vc2Hw+LXcPmWS0Gnk5surWL/MeNL8dfozsjf9eH6XGmig8OYaff/95XSCBzOWH49rBSSwBn/JPVxtnX1v8PBzLEsuVLIBio61mjZgEM1V8Gzbe5OgnV0oaO40iYMj1+crVcnVu9dB0DNauz6uP1h+s+TAXvgQgpYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729996509; c=relaxed/simple;
	bh=5gAP4fD8DqhuNukQMzKkZIw0LZPIxlIx/c9UyRWCkfQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fkCzjGO2RP6vpsTR8d54dhw25J2F/vMgm44SiordkBsrcXagGAfWS35GuvSt8TqtUW9v0uMY/70fnIBngU7vi76O2WDwYo2hgKUTE+ZNFH2SNXBSj4M6pEy61nNXJFCGNJPoxGEXWxR8Wi6pMLRp7JhJZDhGHvs12uBr5S8yaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcnX+9TU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729996506; x=1761532506;
  h=date:from:to:cc:subject:message-id;
  bh=5gAP4fD8DqhuNukQMzKkZIw0LZPIxlIx/c9UyRWCkfQ=;
  b=DcnX+9TUuyuqxF1roBQmBM/oShwxvv63JOIGVOziT2jFU7vcVNjsmwIR
   6GKy10nvFy+l4hag82K2DS/ZepqMNDAnz3C/jXsHRtA9Ly95glhDOj37N
   vm4uKdr73M8Jl30HtfftiawZxhhqd4PA4cYSptJe4ptM8EwHikQC/qtgX
   YSKHv7/PlXjMaYv1uPKzwP1VC5DuKA3y2uMhg3CYlEW3CagJDLoxAiB+4
   jEuzsoN/Is1dB6VaviERqxjHYpRhxTIFNxQ2JPfDJgaA0l9YlNGB+/np6
   Xeg3/RmUgim0gffa1RMB5C6/k0oTcFvcAbRkVXVcx+b/H24FxaMz+N+C3
   A==;
X-CSE-ConnectionGUID: JMDgxEvcT0uStIClaThkHw==
X-CSE-MsgGUID: 6K+jp9jlQXakarS1ACGFNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="55037536"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="55037536"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 19:35:05 -0700
X-CSE-ConnectionGUID: JXaiEy2dRdC3rqLqAvcoeg==
X-CSE-MsgGUID: ZV1guwYOQW+w8cCOj3GPLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="104605375"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Oct 2024 19:35:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4t7O-000aHY-2y;
	Sun, 27 Oct 2024 02:35:02 +0000
Date: Sun, 27 Oct 2024 10:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 7565caab47e89e9681a2c4439100e78f520833fa
Message-ID: <202410271052.pyQGLEW2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 7565caab47e89e9681a2c4439100e78f520833fa  x86/cpu: Use str_yes_no() helper in show_cpuinfo_misc()

elapsed time: 737m

configs tested: 67
configs skipped: 145

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-14.1.0
alpha         allyesconfig    clang-20
alpha            defconfig    gcc-14.1.0
arc           allmodconfig    clang-20
arc            allnoconfig    gcc-14.1.0
arc           allyesconfig    clang-20
arc              defconfig    gcc-14.1.0
arm           allmodconfig    clang-20
arm            allnoconfig    gcc-14.1.0
arm           allyesconfig    clang-20
arm              defconfig    gcc-14.1.0
arm64         allmodconfig    clang-20
arm64          allnoconfig    gcc-14.1.0
arm64            defconfig    gcc-14.1.0
csky           allnoconfig    gcc-14.1.0
csky             defconfig    gcc-14.1.0
hexagon       allmodconfig    clang-20
hexagon        allnoconfig    gcc-14.1.0
hexagon       allyesconfig    clang-20
hexagon          defconfig    gcc-14.1.0
i386          allmodconfig    clang-19
i386          allmodconfig    gcc-12
i386           allnoconfig    clang-19
i386           allnoconfig    gcc-12
i386          allyesconfig    clang-19
i386          allyesconfig    gcc-12
i386             defconfig    clang-19
loongarch     allmodconfig    gcc-14.1.0
loongarch      allnoconfig    gcc-14.1.0
loongarch        defconfig    gcc-14.1.0
m68k          allmodconfig    gcc-14.1.0
m68k           allnoconfig    gcc-14.1.0
m68k          allyesconfig    gcc-14.1.0
m68k             defconfig    gcc-14.1.0
microblaze    allmodconfig    gcc-14.1.0
microblaze     allnoconfig    gcc-14.1.0
microblaze    allyesconfig    gcc-14.1.0
microblaze       defconfig    gcc-14.1.0
mips           allnoconfig    gcc-14.1.0
nios2          allnoconfig    gcc-14.1.0
nios2            defconfig    gcc-14.1.0
openrisc       allnoconfig    clang-20
parisc         allnoconfig    clang-20
parisc64         defconfig    gcc-14.1.0
powerpc        allnoconfig    clang-20
riscv          allnoconfig    clang-20
s390          allmodconfig    gcc-14.1.0
s390           allnoconfig    clang-20
s390          allyesconfig    gcc-14.1.0
sh            allmodconfig    gcc-14.1.0
sh             allnoconfig    gcc-14.1.0
sh            allyesconfig    gcc-14.1.0
sparc         allmodconfig    gcc-14.1.0
um            allmodconfig    clang-20
um             allnoconfig    clang-20
um            allyesconfig    clang-20
x86_64         allnoconfig    clang-19
x86_64        allyesconfig    clang-19
x86_64           defconfig    clang-19
x86_64           defconfig    gcc-11
x86_64               kexec    clang-19
x86_64            rhel-8.3    gcc-12
x86_64        rhel-8.3-bpf    clang-19
x86_64      rhel-8.3-kunit    clang-19
x86_64        rhel-8.3-ltp    clang-19
x86_64       rhel-8.3-rust    clang-19
xtensa         allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

