Return-Path: <linux-kernel+bounces-376137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A99AA0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B2E1F26644
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1819AD8D;
	Tue, 22 Oct 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwzqTu/H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8619924A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594675; cv=none; b=dTjaZ526ibWw89ANXyQilJLrDXNAUBix0Q3rWin1+4NxVefkU5zqxBVso21rrLt92stwXNFA1MpqITwqxoit7DhQaC6aBu23ThDlpPJ7bBuP3PDzmicwrWZ7TadSE7K/BYw6fu6dgr5NoFmoZNTJBFAcdK1vhJ1Ib4gw4plgupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594675; c=relaxed/simple;
	bh=PQZ98CQOypu+SKUj3LQxyW07z57KSbsIR40rpzU2bxU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Abmbd/rETPGAFt5SGwLAr0VP7D60t9dfE7nvsSkeXtFOOg1LACQ6iNbI4gaEDAOrIH1RWQmUCo5OO8bI0LsFo0v5+mRlO1QCIGLyP/dPSR+OiGGwIao68JbtL4wwZlquZ3QGZUGMOpvkLXrTX2X83tglHVDiYZkNshsYVevaQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwzqTu/H; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729594674; x=1761130674;
  h=date:from:to:cc:subject:message-id;
  bh=PQZ98CQOypu+SKUj3LQxyW07z57KSbsIR40rpzU2bxU=;
  b=mwzqTu/HvuazRXS+0tifzo4hdxq0ly9mBm/ooEollrUSValu2MOmhiPL
   JK1u4I2licZxNh7tBQDi0428+qT9TQpjxffOB9ogj499dy5IVULm2pcCF
   Qi2yE0VYASFzHEOe73Y/HlhSVOytQbmosc0AKqjnC1Q6La9PvJzkMs8va
   6AjlFI44ANJizez2WFdCk89ZDP9PzuLWeGs8RcoPRA8a4M8n0c0WbdrQo
   tzE5Y9kC8nsNAB0R4zZx2CHK7W3tq4YCi59e/xpSvbxNGKW7QuO5Y6MGU
   vuZ96TyLkD5yLzQoAcP9lUQiA5CqcIfEaPs7OvKd8y2xvxR37katRqcd5
   Q==;
X-CSE-ConnectionGUID: HesG/g2KS/KRJ1POv14qlQ==
X-CSE-MsgGUID: 2Ro6O6wYQvm/DLdrA6/4SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="54526182"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="54526182"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 03:57:41 -0700
X-CSE-ConnectionGUID: ZReiKj9VSiiU7QLxN9vMmQ==
X-CSE-MsgGUID: BXIeoy5tQNyJo4LTzGiuFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84431059"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 22 Oct 2024 03:57:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3CZu-000TSc-0N;
	Tue, 22 Oct 2024 10:57:30 +0000
Date: Tue, 22 Oct 2024 18:56:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 3267cb6d3a174ff83d6287dcd5b0047bbd912452
Message-ID: <202410221842.DYMPny7H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 3267cb6d3a174ff83d6287dcd5b0047bbd912452  x86/lam: Disable ADDRESS_MASKING in most cases

elapsed time: 750m

configs tested: 46
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-14.1.0
alpha         allyesconfig    clang-20
arc            allnoconfig    gcc-14.1.0
arm            allnoconfig    gcc-14.1.0
arm64          allnoconfig    gcc-14.1.0
csky           allnoconfig    gcc-14.1.0
hexagon       allmodconfig    clang-20
hexagon        allnoconfig    gcc-14.1.0
hexagon       allyesconfig    clang-20
i386          allmodconfig    clang-18
i386           allnoconfig    clang-18
i386          allyesconfig    clang-18
i386             defconfig    clang-18
loongarch      allnoconfig    gcc-14.1.0
m68k           allnoconfig    gcc-14.1.0
microblaze     allnoconfig    gcc-14.1.0
mips           allnoconfig    gcc-14.1.0
nios2          allnoconfig    gcc-14.1.0
openrisc       allnoconfig    clang-20
openrisc         defconfig    gcc-12
parisc         allnoconfig    clang-20
parisc           defconfig    gcc-12
powerpc        allnoconfig    clang-20
riscv          allnoconfig    clang-20
riscv            defconfig    gcc-12
s390          allmodconfig    gcc-14.1.0
s390           allnoconfig    clang-20
s390          allyesconfig    gcc-14.1.0
s390             defconfig    gcc-12
sh            allmodconfig    gcc-14.1.0
sh             allnoconfig    gcc-14.1.0
sh            allyesconfig    gcc-14.1.0
sh               defconfig    gcc-12
sparc         allmodconfig    gcc-14.1.0
sparc64          defconfig    gcc-12
um            allmodconfig    clang-20
um             allnoconfig    clang-20
um            allyesconfig    clang-20
um               defconfig    gcc-12
um          i386_defconfig    gcc-12
x86_64         allnoconfig    clang-18
x86_64        allyesconfig    clang-18
x86_64           defconfig    clang-18
x86_64               kexec    clang-18
x86_64            rhel-8.3    gcc-12
xtensa         allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

