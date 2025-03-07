Return-Path: <linux-kernel+bounces-551007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA4A566D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17CD177B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E1218599;
	Fri,  7 Mar 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/77bJgd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293A20B1E7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347302; cv=none; b=Mtgf1ASGB0mt4uWdC5j1wngrPtdlbtaDcGSF9JRHlcBDJstnV0xedg0DmmSo0je6Di171GPxNMG2npPugvuTO34gEGDtcCMjfcJa0/yOVPmgv+bb1IuERuvMkoJ4xQpmpawBSjbMRHxR6fWZWvYUMZ8ifEzWTLxtkXy+n02J+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347302; c=relaxed/simple;
	bh=2yz22/a4mY5YReJltrnDtDlFs5BsVlUn6+HtL2mQ0Sw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Nvml1jSgIHcUV7bOtIMciV/KX/+R8ja/4QNBXBkV0VB7QrX5a1B9zyJT2rLRfm2u+ppeVWw4JW2UYRK2JereNjfGqaKyeI+imoFW6/eLNif04SI8YJtKwrsPBXZTMnfLtdd18+tRlDfFW78z6qU7GgQnrqH1Pu9qdaiatwrgqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/77bJgd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741347301; x=1772883301;
  h=date:from:to:cc:subject:message-id;
  bh=2yz22/a4mY5YReJltrnDtDlFs5BsVlUn6+HtL2mQ0Sw=;
  b=G/77bJgdMmQWpL2tQQ1HvII6Halcsj4uEI+k/wABKstKdebA4RxpDTsm
   c6dP969kx8z3KlkiVL0dFGX07DX6DEc+s3tjDFjrlpa2YvVJkEPdxlHFE
   IhqG7xeA+mmG4voDD7BxzZsBZ0rsC0z+5xkr+Z9D+91JlamQR+/YagKXC
   16qi3fzbJ4cpHYe75iqLT7mFR/4DNgKKhlK/+Z5+J4ZHdPL4SBTrXSWLE
   bxgT/0ivn7j6wUuCVAg9UB19hCup+dY0X2dnFnbZgDPS/ET2x88FLYH9M
   FNi+ypwG42RUfdw0x9zzoq81qreTO1qvpGo2JCQ29IO7JSelv5rA710VD
   w==;
X-CSE-ConnectionGUID: xvDbEMwZQwC5crlOqE20yQ==
X-CSE-MsgGUID: BH6ah3EFSeeOG7GPpQ0IyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64833355"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="64833355"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:35:01 -0800
X-CSE-ConnectionGUID: HphhefN7QBq5bdxKWoeoIw==
X-CSE-MsgGUID: FPo1XZemR9SkmIjWiYGrFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120223811"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 07 Mar 2025 03:35:00 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqVyj-0000O3-2v;
	Fri, 07 Mar 2025 11:34:57 +0000
Date: Fri, 07 Mar 2025 19:34:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 ef69de53c46a4b526442f6bc5970fc14f7a0bb32
Message-ID: <202503071901.oVGBjPaN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: ef69de53c46a4b526442f6bc5970fc14f7a0bb32  x86/platform/olpc: Remove unused variable 'len' in olpc_dt_compatible_match()

elapsed time: 1463m

configs tested: 15
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-12
i386    buildonly-randconfig-001-20250306    clang-19
i386    buildonly-randconfig-002-20250306    clang-19
i386    buildonly-randconfig-003-20250306    clang-19
i386    buildonly-randconfig-004-20250306    gcc-12
i386    buildonly-randconfig-005-20250306    gcc-12
i386    buildonly-randconfig-006-20250306    clang-19
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250306    gcc-11
x86_64  buildonly-randconfig-002-20250306    clang-19
x86_64  buildonly-randconfig-003-20250306    clang-19
x86_64  buildonly-randconfig-004-20250306    clang-19
x86_64  buildonly-randconfig-005-20250306    clang-19
x86_64  buildonly-randconfig-006-20250306    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

