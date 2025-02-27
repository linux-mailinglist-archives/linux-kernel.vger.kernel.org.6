Return-Path: <linux-kernel+bounces-536273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9FA47D93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A6E17470F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA41991CD;
	Thu, 27 Feb 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSt2ucA4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4414B5AE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658911; cv=none; b=icZMWzXMDhnQuBNHquvMBvOSrwBPlEOIpJg/46CWdOoKwP9g/KYQaGnXGwJZyccd0tAXezx0HtPj02qiWHIpFqtj3MPXSyMQxmm1ps2bBw7i0RZE1JG3+tXsmodhGP38WVJXaao4FrIuWE3JoY0gZlvCE72QW3RBIPTQuV7ohn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658911; c=relaxed/simple;
	bh=cEtPQlJ5uNxY2bl5se/tu3OHK+iWAqPYGo4kKDBGNB4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e98R2xLPrE+1llZFDv1EoCFshSICfeJgvwDdwLZLQTw+ctQZNZimI6LRYejtp8SWlnRamXTgEtPWAMWyl50sV757Yke2EDf4PNf0IER/eeoo96/HGdWMR1iRL6GHwpSypiZgIGu1Ozb6cu79Q5L604unJNNcerAouQSC/WDWqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSt2ucA4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740658911; x=1772194911;
  h=date:from:to:cc:subject:message-id;
  bh=cEtPQlJ5uNxY2bl5se/tu3OHK+iWAqPYGo4kKDBGNB4=;
  b=kSt2ucA4Q1fK0I1Z0HxBOwfd9KPyOTCoi+4n6QH+4r2IrJottY4OEbjp
   3JlC6ajNecUdTPArg3ur+J190nehD1O5DhxjbXMFJqQtquRJ6jTa5X8qt
   06k9b2DFwncH0pdwdssrPVEfu5DPTDbJXTwnxAyFDaz8aWz/X036S8SZy
   7DeOQBo+xPMRfLfhT190dt3odDSNQ5HRbdlc+fRMq1l0lfX09KtHv3Ag8
   h4q8PSYQbuCmZNAPzSRYd4t2ejxJEtJSbvC9BPC4WDJ68VlNPxEveO24r
   bBoUjLNoiwO5sXcXaXiducQLUXH/HpfV370ewAbahwO2UUldhhse767ut
   g==;
X-CSE-ConnectionGUID: xrWL5Ck/TaSqvrAg8ZJSNw==
X-CSE-MsgGUID: jMskCOZ4RnORcNI+MZZTAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="64012030"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="64012030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:21:50 -0800
X-CSE-ConnectionGUID: LD5ypQBcQ12P1DavM5+UJA==
X-CSE-MsgGUID: f6j5yVPRT6OuuA3eHPaGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117041577"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2025 04:21:49 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tncte-000DKv-13;
	Thu, 27 Feb 2025 12:21:46 +0000
Date: Thu, 27 Feb 2025 20:21:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 399b2799985237cf5c3656b7cfc87cdaa489efd1
Message-ID: <202502272021.eo2Om1Xa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 399b2799985237cf5c3656b7cfc87cdaa489efd1  irqchip/renesas-rzv2h: Add RZ/G3E support

elapsed time: 1462m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250226    gcc-13.2.0
arc                  randconfig-002-20250226    gcc-13.2.0
arm                  randconfig-001-20250226    gcc-14.2.0
arm                  randconfig-002-20250226    clang-21
arm                  randconfig-003-20250226    gcc-14.2.0
arm                  randconfig-004-20250226    gcc-14.2.0
arm64                randconfig-001-20250226    gcc-14.2.0
arm64                randconfig-002-20250226    gcc-14.2.0
arm64                randconfig-003-20250226    clang-21
arm64                randconfig-004-20250226    gcc-14.2.0
csky                 randconfig-001-20250226    gcc-14.2.0
csky                 randconfig-002-20250226    gcc-14.2.0
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250226    clang-21
hexagon              randconfig-002-20250226    clang-21
i386       buildonly-randconfig-001-20250226    gcc-12
i386       buildonly-randconfig-002-20250226    gcc-12
i386       buildonly-randconfig-003-20250226    gcc-12
i386       buildonly-randconfig-004-20250226    clang-19
i386       buildonly-randconfig-005-20250226    gcc-12
i386       buildonly-randconfig-006-20250226    gcc-12
loongarch            randconfig-001-20250226    gcc-14.2.0
loongarch            randconfig-002-20250226    gcc-14.2.0
nios2                randconfig-001-20250226    gcc-14.2.0
nios2                randconfig-002-20250226    gcc-14.2.0
parisc               randconfig-001-20250226    gcc-14.2.0
parisc               randconfig-002-20250226    gcc-14.2.0
powerpc              randconfig-001-20250226    gcc-14.2.0
powerpc              randconfig-002-20250226    clang-18
powerpc              randconfig-003-20250226    clang-21
powerpc64            randconfig-001-20250226    clang-18
powerpc64            randconfig-002-20250226    gcc-14.2.0
powerpc64            randconfig-003-20250226    gcc-14.2.0
riscv                randconfig-001-20250226    clang-18
riscv                randconfig-002-20250226    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250226    gcc-14.2.0
s390                 randconfig-002-20250226    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250226    gcc-14.2.0
sh                   randconfig-002-20250226    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250226    gcc-14.2.0
sparc                randconfig-002-20250226    gcc-14.2.0
sparc64              randconfig-001-20250226    gcc-14.2.0
sparc64              randconfig-002-20250226    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250226    clang-18
um                   randconfig-002-20250226    gcc-12
x86_64     buildonly-randconfig-001-20250226    clang-19
x86_64     buildonly-randconfig-002-20250226    clang-19
x86_64     buildonly-randconfig-003-20250226    gcc-12
x86_64     buildonly-randconfig-004-20250226    clang-19
x86_64     buildonly-randconfig-005-20250226    gcc-12
x86_64     buildonly-randconfig-006-20250226    gcc-12
xtensa               randconfig-001-20250226    gcc-14.2.0
xtensa               randconfig-002-20250226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

