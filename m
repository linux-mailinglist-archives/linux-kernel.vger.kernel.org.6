Return-Path: <linux-kernel+bounces-561975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8DA61993
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F7A3AECF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED762036ED;
	Fri, 14 Mar 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghmNZKKz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7CE14A0A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977423; cv=none; b=pMr3YiYnKWfE4+WDtu3UI+rbhkOCdCD++Zua4YzHDyZ8DWqYcoyaAl2TBZktovco2DjHeWSTmygW4qWiHZcShMj+F5ST4Vv6lpdx1lcNodIAlOb7J6TF+zWNRmf7+HWNxf8zKHtcKRqfqdSeuyLoVtVOJtkc+hHyL2awfkmDU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977423; c=relaxed/simple;
	bh=HMfQX1JYo3M0tmkUhU3iwDWKNPn8Zx0SQwGHkosIac0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=m2JT/GCDZpX9/4QAqAaxN9zlWn5ORp3PlnICAebuvWsbb7KR8tJCoFA+KtySLD5LSaBl+ViyLlDxM5cWbHPqTNoERX5Ovl3HsF+tMxXZqcDOOVc48YEQdBQdJC384oHzIGHSjUXGARLvdF/K0juE6iTy+u0Kt94OFWgIUSnrO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghmNZKKz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741977421; x=1773513421;
  h=date:from:to:cc:subject:message-id;
  bh=HMfQX1JYo3M0tmkUhU3iwDWKNPn8Zx0SQwGHkosIac0=;
  b=ghmNZKKzqP/MhzpDkJ6Ce8DjK/hhfhwpeRYICeWDmThIcL1YhDEBw9+n
   zx9H1VlNe2QFp1lIi4Eb9Gz7AR8D/A3c6U7W6OW5EFUxT1w0SsCFSuvxT
   OxUoK3o5urcOqUBCALEqPePsdTYqFAlCBz+mme8uIa3fMeqw2G79Wcoks
   jLnPoZ5sXfA1nGK2niWbcs4pcpzeQveQsnuYQ03a0GYipC9mfx6n2z8py
   vYA2aD0FiZtiB8GW7E6T4UBYJ5fQ1m4wPHgSlV2jttGs6jQSvjn2ENpyR
   imv1rzIwneYCCxZBwDkOfly16jR0FdMLI9VA+p/GmKDkmHz7iuByQBpwd
   A==;
X-CSE-ConnectionGUID: GjbBpoXUQziGc2SSahK/1Q==
X-CSE-MsgGUID: MpJI4mqsSKK8B5AGTk0wJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42871863"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42871863"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:36:58 -0700
X-CSE-ConnectionGUID: +uVmtWJITS6wYES8D7klHw==
X-CSE-MsgGUID: ky2UufjcS1S09WsI2jsRqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121083177"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 14 Mar 2025 11:36:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt9tv-000Ajx-1A;
	Fri, 14 Mar 2025 18:36:55 +0000
Date: Sat, 15 Mar 2025 02:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 9628d19e91f1ef9e7b1321e74a88bfa646d2a8d3
Message-ID: <202503150225.37YQB5Nh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 9628d19e91f1ef9e7b1321e74a88bfa646d2a8d3  x86/locking/atomic: Improve performance by using asm_inline() for atomic locking instructions

elapsed time: 1454m

configs tested: 15
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-12
i386    buildonly-randconfig-001-20250314    clang-19
i386    buildonly-randconfig-002-20250314    clang-19
i386    buildonly-randconfig-003-20250314    gcc-12
i386    buildonly-randconfig-004-20250314    gcc-12
i386    buildonly-randconfig-005-20250314    gcc-12
i386    buildonly-randconfig-006-20250314    gcc-12
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250314    clang-19
x86_64  buildonly-randconfig-002-20250314    clang-19
x86_64  buildonly-randconfig-003-20250314    gcc-12
x86_64  buildonly-randconfig-004-20250314    clang-19
x86_64  buildonly-randconfig-005-20250314    gcc-12
x86_64  buildonly-randconfig-006-20250314    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

