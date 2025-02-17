Return-Path: <linux-kernel+bounces-518431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26959A38EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C5018837B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AFD1AA79C;
	Mon, 17 Feb 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCpSqGxV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0E18787F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830416; cv=none; b=g0/nR1V5aLy8e2jlQroy6qpk4VORLF3AwV96Yd3ePr+7xTxU694t0DYvoXKnEJdxcITtglrUJbJ/lkRqCxTIqGTjLFde/i1nVuYIKqWqUKMRqay/uvzijN8bIVx888wau/suhzlq1ib9tm7HZOan1VQglWH9+pPGRSFuqtbL09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830416; c=relaxed/simple;
	bh=IZizXcCnnJyNvGPpXrfdBPQSatvt5UguHsM/2T49HLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QRTfJZUFySg5gbnZukaFcssnBw1UFUp3qh9XzpSE9winj4RrUqVHavvvcjuPwPnDLa2bxdWqjz3M/JBzgnvsCamuNxF0+uI4n7lK58hOkZvNMtMlxcpjsJn4Yd3HLbtoU2v/MLIG9lUV29oh5v+DVaxrwX3fg/j9zitRuR1g09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCpSqGxV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739830414; x=1771366414;
  h=date:from:to:cc:subject:message-id;
  bh=IZizXcCnnJyNvGPpXrfdBPQSatvt5UguHsM/2T49HLc=;
  b=XCpSqGxVNzIbDcifKqcIRAkDFoV1FUfMVsh1jFlNfRn8Ls6SAgtRaTgW
   RGgKl+M89KsFTuIjDRFpuUY5A0NMl5waMa2RuDvyZPBJm3TsoB95S+0g5
   dB44/GJlJqRRuQnFZIub5U6JSvkKN4paIf51eF9BLTjiV016QWVfA+7Xw
   nZaYUB1K+KYtW6Uj8a5ngaFCH6JNTqhJ0/nK9xX1GCgcEoXotJmVQxujr
   yRUUI3Mo8QInA5y4nhqnLLCyULLm6qF2ld9uT080mDmskTDzz0YWobcj8
   F5vxB+pUQBBZZ/1fXHyAqE1i2pvMx+p9KILHwLtSB3AcjZV/WVWkN6SaA
   Q==;
X-CSE-ConnectionGUID: psXuCAlLRA2eqUkII8nMag==
X-CSE-MsgGUID: nZ5r/JNNSlGoTl19xyxOcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51947488"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51947488"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 14:13:34 -0800
X-CSE-ConnectionGUID: vWTtMMXcRguxpIY+R2oYlQ==
X-CSE-MsgGUID: WUcC/cyBTQu45bj6FJpAlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145128511"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Feb 2025 14:13:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk9Mp-001DdV-0f;
	Mon, 17 Feb 2025 22:13:31 +0000
Date: Tue, 18 Feb 2025 06:12:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 037e81fb9d2dfe7b31fd97e5f578854e38f09887
Message-ID: <202502180643.4ytm8Blo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 037e81fb9d2dfe7b31fd97e5f578854e38f09887  x86/microcode/AMD: Add get_patch_level()

elapsed time: 723m

configs tested: 19
configs skipped: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250217    clang-19
i386    buildonly-randconfig-002-20250217    gcc-12
i386    buildonly-randconfig-003-20250217    clang-19
i386    buildonly-randconfig-004-20250217    gcc-12
i386    buildonly-randconfig-005-20250217    gcc-12
i386    buildonly-randconfig-006-20250217    clang-19
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250217    gcc-12
x86_64  buildonly-randconfig-002-20250217    clang-19
x86_64  buildonly-randconfig-003-20250217    clang-19
x86_64  buildonly-randconfig-004-20250217    gcc-12
x86_64  buildonly-randconfig-005-20250217    gcc-12
x86_64  buildonly-randconfig-006-20250217    clang-19
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

