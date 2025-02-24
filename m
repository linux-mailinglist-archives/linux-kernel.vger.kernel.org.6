Return-Path: <linux-kernel+bounces-528148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54FA4142F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3525171705
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7891A76AC;
	Mon, 24 Feb 2025 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDY9oqFC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9C1A705C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368609; cv=none; b=ABw3VfRV+p55UYeA4Y1aaLOlR7INiKg75VqW9rNM4ZHqSlC5w7x7p0TRpACyHyc/PpgUOQ8GML67prw3XQPyhMC/2BM6msMZSBmjgfaocyaC26R30kj1lBGLMPvcabWMcoj01aeJW+oDnHQbn3/WF8ZmaaHNud8XJfNADBmvNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368609; c=relaxed/simple;
	bh=8o9r4B0XpOobeIieD2x5HaFRY17SbtMnCUSAOwwT1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oFo6yH/6a5rHy9UtIzJForkhMVwEtqmJH+pSzWX6ExaH7y6Fu1KceITEFKnG4VN1ztjCK1CLoIAKPtPmScpPyIgoy3+nQAyR/24qMLwtjzt6ohYa01u+qMTP7OMdTI20ZDzoD8Bc191ubxwzgUbUKeJok5Mfmn4iCyDpkjBczic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDY9oqFC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740368606; x=1771904606;
  h=date:from:to:cc:subject:message-id;
  bh=8o9r4B0XpOobeIieD2x5HaFRY17SbtMnCUSAOwwT1Tk=;
  b=iDY9oqFCWIAIJ/ZzMF0MFkDFFL1mkrMrQtB3xl5ux/n5VWCvgnqLVsee
   lNzzAlexEAJfVjoj7zJhquiIJq1DwHFH0SU8g3XhgEsswIjWL/NJR4FXs
   R9o0zx4TBewYnbo14gcdSo0/qrp+ymQovJbDaMgaJqNC9TLbgMG96PmHA
   oiSByY5uZi+fGZh0XHFSP4aqyDp1oDejxmE0SCZ8WIlUjvlK7pGI+8l4p
   bUc5ituphKFr7q2439xyRkAzMkTpdLMkFSCfbhP+tGi3BDZJqENogOHh6
   dxUmilRb8E+BjcjfirdKHEFRpebHX5ocOyJFeEhYvBYuRV9R2yaEV75yW
   w==;
X-CSE-ConnectionGUID: 4ER7HeP4TWuNrg8SPCyQwQ==
X-CSE-MsgGUID: SG74YsS4Qa2A8htyMj2oLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="43941553"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="43941553"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:43:25 -0800
X-CSE-ConnectionGUID: pPXeqpcyT96+kG0Z1nIu5Q==
X-CSE-MsgGUID: r7Xn/nstQ0aVf2BC5GhBvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116130817"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 19:43:25 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmPN5-0007pP-1U;
	Mon, 24 Feb 2025 03:43:09 +0000
Date: Mon, 24 Feb 2025 11:42:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 51184c3c96a19b5143710ef91426e311f4364bac
Message-ID: <202502241120.GUQv6unk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 51184c3c96a19b5143710ef91426e311f4364bac  x86/usercopy: Fix kernel-doc func param name in clean_cache_range()'s description

elapsed time: 728m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250223    clang-19
i386    buildonly-randconfig-002-20250223    gcc-11
i386    buildonly-randconfig-003-20250223    gcc-12
i386    buildonly-randconfig-004-20250223    clang-19
i386    buildonly-randconfig-005-20250223    gcc-12
i386    buildonly-randconfig-006-20250223    gcc-11
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250223    clang-19
x86_64  buildonly-randconfig-002-20250223    gcc-12
x86_64  buildonly-randconfig-003-20250223    gcc-12
x86_64  buildonly-randconfig-004-20250223    gcc-12
x86_64  buildonly-randconfig-005-20250223    gcc-12
x86_64  buildonly-randconfig-006-20250223    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

