Return-Path: <linux-kernel+bounces-449864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F399F5710
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3532B164646
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0461F8EE9;
	Tue, 17 Dec 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dalTBy76"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD412C475
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464663; cv=none; b=DQ/LZBEXDuVSnuYzCeXuZbrgXw4Ko8OqBvfgSr2eKO0dkca6zLu5wkNwh5U3u/avbqabGWNSJh+p12FGPDijP5/5WBQOH7x3QbbrIOH6qaVRmGfO1u7acraWIj2Ds1cnhSbrhKxVhBGPYLvUSWc21NEU0Jjw+LT1oicM7q6ssoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464663; c=relaxed/simple;
	bh=Az8uxBeT61U6nsnwrYrNlGS2RuUvH7emt/TmZMO07mQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W13IVHXEh/GHV484BAB9cHYt+FrkyipTfdwIEsJ2pOXp5atGUU/qi9T2l5bG+IbpB+Iu0Nvk1xZUO72cP6w8jQ7Fkow43CV4IfyzdxU8+5Lz549nfKS6Eqen5bxEkCKxVkKkqQFJ4qyiVhMRc5/6F6JHbUam+6UsEHNY5dtYt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dalTBy76; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734464661; x=1766000661;
  h=date:from:to:cc:subject:message-id;
  bh=Az8uxBeT61U6nsnwrYrNlGS2RuUvH7emt/TmZMO07mQ=;
  b=dalTBy76lz21VWZBLp2+iaRwvl/3FyZcIILdFfbi4wtLI5I7wQ5xtl0Y
   M18xc9RTiAu7Z0xkiI8sas6DgmczCXRIV+6KfNx3zhNuNR0O62oPkglC4
   uHSgx4vZyrS/NqkUUze4s3mXkmSCSghJRLxoGkclrcDLd5vFJl/btW880
   lcEgeYoiePBtKFcspA+owNJO4JyibGFaFHmjk+NBXzSrubDeGhYs5+Be9
   U8pULTId3xZSssQEroFO0eupVKYj3dNB7jEwQ/3crwtBMfwMG5yUfrsWG
   f29a4G5bIbb3a9TmRfRXdyaltxpluMfXjUun+8AXX04rxjdzEmf7HNb56
   Q==;
X-CSE-ConnectionGUID: Tz3++73pTd28gJymPtkqGQ==
X-CSE-MsgGUID: YfBTUjqbTzWvzMH36QfXcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="22496920"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="22496920"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 11:44:20 -0800
X-CSE-ConnectionGUID: nMx1HyblRsG7/v4J4udMpA==
X-CSE-MsgGUID: S91XKOlyRmqKDcqAQOL1AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="98209826"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Dec 2024 11:44:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNdUQ-000Fl8-01;
	Tue, 17 Dec 2024 19:44:18 +0000
Date: Wed, 18 Dec 2024 03:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e8b345babf2ace50f6bf380af77ee8ae415d81f2
Message-ID: <202412180355.77fEAIAu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e8b345babf2ace50f6bf380af77ee8ae415d81f2  x86/fred: Clear WFE in missing-ENDBRANCH #CPs

elapsed time: 1130m

configs tested: 19
configs skipped: 138

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20241217    clang-19
i386    buildonly-randconfig-002-20241217    gcc-12
i386    buildonly-randconfig-003-20241217    gcc-12
i386    buildonly-randconfig-004-20241217    clang-19
i386    buildonly-randconfig-005-20241217    clang-19
i386    buildonly-randconfig-006-20241217    gcc-11
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20241217    clang-19
x86_64  buildonly-randconfig-002-20241217    gcc-12
x86_64  buildonly-randconfig-003-20241217    gcc-12
x86_64  buildonly-randconfig-004-20241217    clang-19
x86_64  buildonly-randconfig-005-20241217    gcc-12
x86_64  buildonly-randconfig-006-20241217    clang-19
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

