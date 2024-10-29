Return-Path: <linux-kernel+bounces-386234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5EA9B40C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EDC28071B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1C1F12F0;
	Tue, 29 Oct 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwfUXJn/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34621EF959
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171382; cv=none; b=WpTWKb5JZXMAvrOyGSGlk8ueoeXaehdNu2eVDrDpckPa2MUUxZB0b1bSE3IznLNOlQ6UKty9UKY/wOfwqj8Mle/I/7EcSPHAGGpiZsijm1FIqhYU2ujpbeD/AXNr727sWWyT0qjB8f4DxEAqGX/yTSif8iw+Uf8vYncjOdmRSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171382; c=relaxed/simple;
	bh=3b5nW4pKky8yOvZUxCXln0sKFoR4Dn4zscraUTMyzmc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JK6FJKS6fNZDdzO2AC0p/GckFwv/o6yRMiSV/u28dxA+Znlz9Fz2bHr2RGIAEve/T4KACkd5sab5Mw3brTVpcBbSifClIAGsgzZC3AgEC4MREvyV11t/flgJLCHTUL1rZ1HyXftpCE3B2fTqxNWDR06y/qdfqFtQqTUB/lKq97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwfUXJn/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730171381; x=1761707381;
  h=date:from:to:cc:subject:message-id;
  bh=3b5nW4pKky8yOvZUxCXln0sKFoR4Dn4zscraUTMyzmc=;
  b=gwfUXJn/ItlMNuCPUi05s0e4iIQ8XwbOy4GpA6IZpUcMMjEE2n88vRSN
   6t5fIhh6J0TzlJ5vREtW2MoWaef8Vi85Qa69IWOx6jnKhPYTqTg/+mkOL
   KNqTHhsuHLxdcbYAtyCALF9Em35pldsv/r0PcGyqbFDqtOlsDqxiToW0G
   xXfeYUZ8xlkWvsE3huF6F4oc+z14YtwFUmNyhydW6ikqHdOD8fjace04P
   y7G58hVjEfvDiMYW7WoBrs1gkhJdBkDYrcIk/HxJ0cfmcxzEATtEzPnUF
   q5kqedsvTVN5k1oWONq8bD6nslURdDbYTmYx6dp1aqYpFqgbqGml1nsqI
   w==;
X-CSE-ConnectionGUID: W4bOI3ttTNutH0DqXJlLZg==
X-CSE-MsgGUID: fNpsEUWMSiaBk2IIx4Q1vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33487685"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33487685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 20:09:40 -0700
X-CSE-ConnectionGUID: 2W1DTaUIQxSZXkB4Z/6i4Q==
X-CSE-MsgGUID: 32rDDVGVQWuxm1W7kF7Q3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86422609"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Oct 2024 20:09:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5cbx-000dBh-0n;
	Tue, 29 Oct 2024 03:09:37 +0000
Date: Tue, 29 Oct 2024 11:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 754269ccf03d68da15b9e5cdd26a6464b81cec67
Message-ID: <202410291157.sUqPzo6c-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 754269ccf03d68da15b9e5cdd26a6464b81cec67  x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff

elapsed time: 727m

configs tested: 52
configs skipped: 129

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
i386            allmodconfig    gcc-12
i386             allnoconfig    gcc-12
i386            allyesconfig    gcc-12
i386               defconfig    clang-19
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc             defconfig    gcc-12
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-19
x86_64          allyesconfig    clang-19
x86_64             defconfig    gcc-11
x86_64                 kexec    clang-19
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

