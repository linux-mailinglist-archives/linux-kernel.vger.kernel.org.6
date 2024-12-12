Return-Path: <linux-kernel+bounces-443860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D109EFCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9BB16C228
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA61A7273;
	Thu, 12 Dec 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0E8UYUj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1341925AB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033612; cv=none; b=ThJXfKkswZChwYagHxxk2Wb/LouT9u3p0ySaZTfxCav+x96E6OwqNAVACT6p1bw3yYXzdGKx46wfNdx6drvs4idCzp72bLOUjC3n1V7tb1D+dLIXieJamQlLEIm7MIwoBhQ/lj/8ZU4LjnTG2UNcngtrp91q/RWPzlIhKeJPR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033612; c=relaxed/simple;
	bh=1UtQxahLe3+8appwicruepO1DUPTGRJZf2yMSqIfQzc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L8Iw37ZBEQqGJNIcLyCr2n8qJF3DyiiwXvaKSpvevLjMAn54dcM0SeO0FWUJTljVGAd+1VNRgef1GIfptX6j8Gpxq7OMgmFrrPlhYFCZqR0mqSZG7S0YzsqMyDl3ck4Bj5oRSypPWM8g1MvXoPjgtxzwsA9y0mtsgYPOIfQnG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0E8UYUj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734033612; x=1765569612;
  h=date:from:to:cc:subject:message-id;
  bh=1UtQxahLe3+8appwicruepO1DUPTGRJZf2yMSqIfQzc=;
  b=K0E8UYUjRim7XR0T1EbRUHLzbE22c+RkdKtbHhm1IP9HN0HkGb1UYOam
   H6GZMReSa9Qw2B5jue+7TrXWFHHcwqRCNwnUNeCBXZYWc7LnG6kdzmpq3
   shJ4vTlJ2uZAlglrEu83ZL0xtN5d3iis9Lf7/P46z/0oYZO4zzi2U89+q
   s9+55XpEdgFWSNv0guJACCXZU9oRPOd2IUvgLv8jY9VXQejunQLpD9cII
   ZUjH8PA0CFKEJD82R+L/mRuUEpOEOiYgCARSeEz++z5T1NpLCTV/UN0rD
   w9V591y7BCk58BZaH8BCyi+gg7/l6WjjcaZ0fZGL0c+GhHg+7A3Q4kJRA
   g==;
X-CSE-ConnectionGUID: hSgdrxmiT9ecA4PAzXUCbw==
X-CSE-MsgGUID: f5SGrjWjSuCRaedX9kl1Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34519854"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="34519854"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 12:00:11 -0800
X-CSE-ConnectionGUID: yPY6SfQ0Rk6D7dAomarrJg==
X-CSE-MsgGUID: op1rRvwBR0S2hNq7OQmHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96763196"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Dec 2024 12:00:09 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLpLz-000BHZ-0Y;
	Thu, 12 Dec 2024 20:00:07 +0000
Date: Fri, 13 Dec 2024 03:59:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 b4706d814921cc2df7bb59ad8f9ee84855a4f0c4
Message-ID: <202412130335.rQoL4473-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: b4706d814921cc2df7bb59ad8f9ee84855a4f0c4  genirq/kexec: Prevent redundant IRQ masking by checking state before shutdown

elapsed time: 1452m

configs tested: 51
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241212    gcc-13.2.0
arc                  randconfig-002-20241212    gcc-13.2.0
arm                  randconfig-001-20241212    gcc-14.2.0
arm                  randconfig-002-20241212    clang-20
arm                  randconfig-003-20241212    clang-19
arm                  randconfig-004-20241212    clang-20
arm64                randconfig-001-20241212    clang-20
arm64                randconfig-002-20241212    clang-15
arm64                randconfig-003-20241212    clang-20
arm64                randconfig-004-20241212    gcc-14.2.0
csky                 randconfig-001-20241212    gcc-14.2.0
csky                 randconfig-002-20241212    gcc-14.2.0
hexagon              randconfig-001-20241212    clang-14
hexagon              randconfig-002-20241212    clang-16
i386       buildonly-randconfig-001-20241212    clang-19
i386       buildonly-randconfig-002-20241212    clang-19
i386       buildonly-randconfig-003-20241212    clang-19
i386       buildonly-randconfig-004-20241212    clang-19
i386       buildonly-randconfig-005-20241212    clang-19
i386       buildonly-randconfig-006-20241212    gcc-12
loongarch            randconfig-001-20241212    gcc-14.2.0
loongarch            randconfig-002-20241212    gcc-14.2.0
nios2                randconfig-001-20241212    gcc-14.2.0
nios2                randconfig-002-20241212    gcc-14.2.0
parisc               randconfig-001-20241212    gcc-14.2.0
parisc               randconfig-002-20241212    gcc-14.2.0
powerpc              randconfig-001-20241212    gcc-14.2.0
powerpc              randconfig-002-20241212    clang-20
powerpc              randconfig-003-20241212    clang-15
powerpc64            randconfig-001-20241212    clang-20
powerpc64            randconfig-002-20241212    gcc-14.2.0
powerpc64            randconfig-003-20241212    gcc-14.2.0
riscv                randconfig-001-20241212    clang-17
riscv                randconfig-002-20241212    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241212    clang-18
s390                 randconfig-002-20241212    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241212    gcc-14.2.0
sh                   randconfig-002-20241212    gcc-14.2.0
sparc                randconfig-001-20241212    gcc-14.2.0
sparc                randconfig-002-20241212    gcc-14.2.0
sparc64              randconfig-001-20241212    gcc-14.2.0
sparc64              randconfig-002-20241212    gcc-14.2.0
um                   randconfig-001-20241212    gcc-12
um                   randconfig-002-20241212    clang-20
x86_64     buildonly-randconfig-002-20241212    gcc-12
x86_64     buildonly-randconfig-004-20241212    clang-19
xtensa               randconfig-001-20241212    gcc-14.2.0
xtensa               randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

