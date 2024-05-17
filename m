Return-Path: <linux-kernel+bounces-182577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7208C8CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B32E1C224B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA10140386;
	Fri, 17 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHjssIQl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54913DDB0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974971; cv=none; b=KCI98ru/NYMq2C0u3atX4unWmig628QDuvntO8QXgE/kv/Whpq8dofrE4BUnWHNCnPVEohAb/gOK+IWq4JUOv/daUgX5oSpUBueH/2UTu5IBUjQAkPhSlcPRwEB7s/XztfnOSz5YXnXv/I8iBn0MpMSwi9B33BetRbb+0pDgIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974971; c=relaxed/simple;
	bh=7h9TJkr54xA5UffnPFR88Es1WniKW1IR1TUcTBmd0TM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PGRZLcqPaRFENCOUrUtfMGatCtvqB2F93dYb6gMiMnV2F8TsdGFErN10JTry5N6e6F7UW40sTVOiGrK3Cy9v9XA4PR7ovJQ9xcNod+kD1UllLDdYq72m603mljkmzJ7IfDIQbuKetZ9uJhb2c4G/GkBq8I4acqnNKzObINR4FnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHjssIQl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715974969; x=1747510969;
  h=date:from:to:cc:subject:message-id;
  bh=7h9TJkr54xA5UffnPFR88Es1WniKW1IR1TUcTBmd0TM=;
  b=FHjssIQlKTb7j2Uwm09b+cqa1HW8R454cj+nuOem1a7zbNBJmDHyPIbI
   j09gifN1dm+NuEFEjFTr7HONXIa3u2XxUIBHMwEEhCFXvUHk5aKJXH9UJ
   5S6Vdam82eJ890qojAf+QY3scr5f5RtObfjZO4zO7HSrXV92j8z7VgJxO
   Ew60zLA7JG5cxzdxYjNrRHkw7PkjF4/9ia9JEJkS1Tsws+F6kwlGJQ5er
   HXkXl+dfdqcKPmlHYg6NqPJyWtre1z4M1+VDCd6WHLKoipAfXtWEI3ExE
   5xEmR3EYfgAd19nehe8Y5zviMKLHGAWuXXVR4v7RO9fNcD+8YLzzGzGej
   g==;
X-CSE-ConnectionGUID: zOWeMwuERRKBFLMju6d/LQ==
X-CSE-MsgGUID: 5ySAbUlbSsCB7Pvk2SSADQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="23577777"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="23577777"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:42:48 -0700
X-CSE-ConnectionGUID: VitgyCCnQ+27BvEXi1yJWQ==
X-CSE-MsgGUID: /epWT5x1TO6bMkTxq9nf2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36629758"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 17 May 2024 12:42:47 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s83TZ-00014k-1h;
	Fri, 17 May 2024 19:42:45 +0000
Date: Sat, 18 May 2024 03:42:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9dba9c67e52dbe0978c0e86c994891eba480adf0
Message-ID: <202405180324.IrWoHuOv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9dba9c67e52dbe0978c0e86c994891eba480adf0  x86/alternatives: Use the correct length when optimizing NOPs

elapsed time: 728m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240517   clang
i386         buildonly-randconfig-002-20240517   clang
i386         buildonly-randconfig-003-20240517   gcc  
i386         buildonly-randconfig-004-20240517   clang
i386         buildonly-randconfig-005-20240517   clang
i386         buildonly-randconfig-006-20240517   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240517   gcc  
i386                  randconfig-002-20240517   gcc  
i386                  randconfig-003-20240517   gcc  
i386                  randconfig-004-20240517   gcc  
i386                  randconfig-005-20240517   gcc  
i386                  randconfig-006-20240517   gcc  
i386                  randconfig-011-20240517   gcc  
i386                  randconfig-012-20240517   clang
i386                  randconfig-013-20240517   gcc  
i386                  randconfig-014-20240517   gcc  
i386                  randconfig-015-20240517   clang
i386                  randconfig-016-20240517   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

