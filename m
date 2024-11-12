Return-Path: <linux-kernel+bounces-405180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54929C4DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E9E1F2482F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826620823E;
	Tue, 12 Nov 2024 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkOibuxV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB084207A17
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387399; cv=none; b=k95gC51biC7UdyZDtEFTlioJPOxBUd6UBrv8mVmoj3OglkipJ5ZyzUbI57p0pLm5jYX3+xuAZ1vecL3v1PNsaEXN3XOKAIU2U2XdMR7EHfmrNCqF9s6YQI9MajezsuocyA9FzPVdekBLa/UqjAZqjlRWot6Uufio+F1wa/7SF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387399; c=relaxed/simple;
	bh=nIc+qScYeGua2l1SnyVL6OxC6MaxKCLInMYB9IrDTW8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O49vx5I34i+D1Dg2yzeWzR/UWMvoajw+dzcI+sY8H3cstoQImI4lekBEfxlTFS30ry1Wxo7BAMPanadT7y8mudktsd21WeTtYaKyBNTuLHLmfYr/qaaZdf9/VHxpKJtLpi3+u4dD9zWmEg/dT+HOoEDUJzb051Hf7y44BZbo/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkOibuxV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731387398; x=1762923398;
  h=date:from:to:cc:subject:message-id;
  bh=nIc+qScYeGua2l1SnyVL6OxC6MaxKCLInMYB9IrDTW8=;
  b=RkOibuxVFVKmR24uaC7wJeRFwLkK6NP7rkH7W7CKIhVW33RvvRNzRnkJ
   FZDiNFX2ep40dq1kv8WbMEh09PVQOHt6LUiq6XzV0mC9fZ1w3/UsJ0oGb
   0ouWmAsJxIsyWvAfZsgz1UXLUUN1Gvz0yC/XTXpB/P9ypYq4dcggoTWMv
   qBN0RJQ+lyJgZ80IcK9m5tsuX1kgVk4HhFdU3V1+GkV/teFSIRAkLbftT
   idvYXvtNO2zx+w+CzAkCoNJ30L0XGLwT/X0sHeujUd1aEl98s92e4Glh2
   agfXKh6DutE50/KGCR5nXSP2xvvyg0MJwlDN4dwZJFypP6frI6ky1yyH2
   w==;
X-CSE-ConnectionGUID: 4PctM7bgT0yND2gR7a0kTQ==
X-CSE-MsgGUID: Rcd4Aa5kSImLQd9Bz8pzkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="35136646"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="35136646"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 20:56:37 -0800
X-CSE-ConnectionGUID: WZLVRXIjTEK5DU5YjU9P8A==
X-CSE-MsgGUID: MlKSWfPzS7mvRWcLR4iNXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87415213"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Nov 2024 20:56:36 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAix7-0000Tj-1q;
	Tue, 12 Nov 2024 04:56:33 +0000
Date: Tue, 12 Nov 2024 12:55:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fb7300a68dfd15c2885dfba5b4e2a84637a9c3c1
Message-ID: <202411121250.V6YjoXBx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: fb7300a68dfd15c2885dfba5b4e2a84637a9c3c1  Merge branch into tip/master: 'x86/tdx'

elapsed time: 812m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.2.0
alpha           allyesconfig    clang-20
alpha           allyesconfig    gcc-14.2.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.2.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.2.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.2.0
csky             allnoconfig    gcc-14.2.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.2.0
hexagon         allyesconfig    clang-20
i386            allmodconfig    clang-19
i386            allmodconfig    gcc-12
i386             allnoconfig    clang-19
i386             allnoconfig    gcc-12
i386            allyesconfig    clang-19
i386            allyesconfig    gcc-12
i386               defconfig    clang-19
loongarch       allmodconfig    gcc-14.2.0
loongarch        allnoconfig    gcc-14.2.0
m68k            allmodconfig    gcc-14.2.0
m68k             allnoconfig    gcc-14.2.0
m68k            allyesconfig    gcc-14.2.0
microblaze      allmodconfig    gcc-14.2.0
microblaze       allnoconfig    gcc-14.2.0
microblaze      allyesconfig    gcc-14.2.0
mips             allnoconfig    gcc-14.2.0
nios2            allnoconfig    gcc-14.2.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.2.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.2.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.2.0
parisc             defconfig    gcc-12
powerpc         allmodconfig    gcc-14.2.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    clang-20
riscv           allmodconfig    clang-20
riscv            allnoconfig    clang-20
riscv           allyesconfig    clang-20
riscv              defconfig    gcc-12
s390            allmodconfig    clang-20
s390            allmodconfig    gcc-14.2.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.2.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.2.0
sh               allnoconfig    gcc-14.2.0
sh              allyesconfig    gcc-14.2.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.2.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um              allyesconfig    gcc-12
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-19
x86_64          allyesconfig    clang-19
x86_64             defconfig    clang-19
x86_64             defconfig    gcc-11
x86_64                 kexec    clang-19
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
xtensa           allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

