Return-Path: <linux-kernel+bounces-375601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9A9A9810
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742DC282DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663F824AF;
	Tue, 22 Oct 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCbSUd+k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7281C27
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572856; cv=none; b=GuP0STDPSVPt3d06IhJqVGFu1IG0G2zEX5tT4+akC8ynRKE+Sn3hASCoAJB0E5mdUiw+Jz5wK5anJ2PXcg17lBB/4W/jtF2sEk/J4j16X3s7vaSQh8AZcNFNHym8HyGCClV30vZHnxrbKia4gScSj/RzIh7uqrMam2tmm/z4MQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572856; c=relaxed/simple;
	bh=Y8Q/z42eucWJFaIDprTlLK+fB9PmmazEqqJznCIqDRk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oF5sdtaWY0qPJg7TyBqghiBkiz7AsBOhWsO0F2ZhWySZ0EH+B6g5sOgji3I6f38WfLOp4jVMPImBXj8XPn5HygDZdY1w7aDachjXVd04yyXrDSkbd2sUJZyLQ2G7ijXuVzGGCNd5EPS0t+2FkEzJ7Z9n5gj3rwhEdVWJ93I2wHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCbSUd+k; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729572854; x=1761108854;
  h=date:from:to:cc:subject:message-id;
  bh=Y8Q/z42eucWJFaIDprTlLK+fB9PmmazEqqJznCIqDRk=;
  b=MCbSUd+k71kyv+LJtcz+Yv2rwPAqdH+Q+rO+CnAoBFFSCsBenwNp4Kay
   /Ml7yQN4UUG5779K+7ve+bAYqbASMRJ5xA/TKNuqDn4tLf9TYxAzN2M16
   fA/Nd1LLkwnK9C3nGZxvVPJoJq9FUhmVdhcG+awQIBXjTmUVzQfvgBaeG
   XJDewr/nWPp1jKphntrC454LUwim0hKlMGoraE8RZJXhdQmWtqCNwPc0b
   Buf2CWK4pHjJLARcshmnH1c0ixvrlsSwSE/VACNCn7Esqpl5yfaMz9Ji3
   eBuqMAQCZlsQ8LPeqR5wQJG51dJ1PWAUWp6RDwiHnKHqqz+Aj9hN/wjBX
   g==;
X-CSE-ConnectionGUID: egmG33AfRMaeg9awiNl4RQ==
X-CSE-MsgGUID: TaLvlym5QMe0uXSFT2uTGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28518690"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="28518690"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 21:54:14 -0700
X-CSE-ConnectionGUID: E1pIUNI9QtyvA8z0TseJhg==
X-CSE-MsgGUID: CKjR7H97QDaZJNJXvAThxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79373170"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Oct 2024 21:54:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t36uJ-000T4o-0m;
	Tue, 22 Oct 2024 04:54:11 +0000
Date: Tue, 22 Oct 2024 12:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 cdccaab0631812e911553ff56683e9005cd3a51e
Message-ID: <202410221257.uAsU5mKm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: cdccaab0631812e911553ff56683e9005cd3a51e  x86/platform: Switch back to struct platform_driver::remove()

elapsed time: 740m

configs tested: 29
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.1.0
arc          allnoconfig    gcc-14.1.0
arm          allnoconfig    gcc-14.1.0
arm64        allnoconfig    gcc-14.1.0
csky         allnoconfig    gcc-14.1.0
hexagon      allnoconfig    gcc-14.1.0
i386        allmodconfig    clang-18
i386         allnoconfig    clang-18
i386        allyesconfig    clang-18
i386           defconfig    clang-18
loongarch    allnoconfig    gcc-14.1.0
m68k         allnoconfig    gcc-14.1.0
microblaze   allnoconfig    gcc-14.1.0
mips         allnoconfig    gcc-14.1.0
nios2        allnoconfig    gcc-14.1.0
openrisc     allnoconfig    clang-20
parisc       allnoconfig    clang-20
powerpc      allnoconfig    clang-20
riscv        allnoconfig    clang-20
s390         allnoconfig    clang-20
sh           allnoconfig    gcc-14.1.0
um           allnoconfig    clang-20
x86_64       allnoconfig    clang-18
x86_64      allyesconfig    clang-18
x86_64         defconfig    clang-18
x86_64             kexec    clang-18
x86_64             kexec    gcc-12
x86_64          rhel-8.3    gcc-12
xtensa       allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

