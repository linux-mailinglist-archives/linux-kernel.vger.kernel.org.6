Return-Path: <linux-kernel+bounces-287752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C1952C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65848282A27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87281C0DCF;
	Thu, 15 Aug 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQv+111W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0B54FAD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714270; cv=none; b=EGT28G1x85Uch+OcGIL0BiSHrMEkca5xSlzdtiGlmTY6GmCcuwImCQ85PVngw6ChOjMLzqm19rS8syAc8wm8p9w99TIE96pERQjfZITrHZTwpQ/r8k22ciTSJA7qj057cbCxOmZteJ3nKnTYkjl/NxYXh4GgScN8yMoYZwoXLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714270; c=relaxed/simple;
	bh=qY9RPTLliTtiPvRGA79q7/wQdg+V6XeN035mY21UQBE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JAe29oNuUhjBM8IVIWdQ5xhnCEOnMMKMg3T/lQY4xwcgbVrZQwfgGHEDWEefrMyJcfbOu0PGXGVKHoQ9CWLGQyCtR5Cjx/LCFZYNfRc9pCLiNy6rsGliOQsYqwPudKRrgXaz7Tw64qr3whmtjH1dAcY8ulllVO08HkEy7cQqICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQv+111W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723714268; x=1755250268;
  h=date:from:to:cc:subject:message-id;
  bh=qY9RPTLliTtiPvRGA79q7/wQdg+V6XeN035mY21UQBE=;
  b=SQv+111WvdAymtSMfOKPWQfXTeZmgIelPsYA1sGgGDFmKRURq8schzK4
   jrau3J9Dej5KAIlPei8sfHo3NiCKXiBxUoYYiZ28Q3R8zNG03N7kaYrKX
   JyKBHb9BpFVTYz3wtqUZCfzUGFgGfQNdL0+hiZy6mN13CE2O6onUY8fqa
   EkYp+Ga/2k2HUZPxvVCMTbem+l5+HygakNJeeWzu9WJiNMN3yIDbhQ2fI
   bJPuK5pkYKM9fM9JyqQG8CQ5nmJdnsIFlLpqUfoY0PAdKJwO5ZY1lDmug
   /WPF17n3/G4sO0Z3FJaOZVjuL0atwgECAE93Mgpo4yaV2kxt9WOH8Aebb
   w==;
X-CSE-ConnectionGUID: 29FnGF96TF2JOk7uMnWqwg==
X-CSE-MsgGUID: jxNuf2BuTOSGWq1M7Zy8WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="13025935"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="13025935"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:31:07 -0700
X-CSE-ConnectionGUID: 8iNQyaFUSDqo/N+5chCHyQ==
X-CSE-MsgGUID: 1/Cipg4WRt6rdrI5SUJT4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="60060435"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Aug 2024 02:31:06 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seWoy-0003Mg-0J;
	Thu, 15 Aug 2024 09:31:04 +0000
Date: Thu, 15 Aug 2024 17:30:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 2848ff28d180bd63a95da8e5dcbcdd76c1beeb7b
Message-ID: <202408151719.oKE4B0sI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 2848ff28d180bd63a95da8e5dcbcdd76c1beeb7b  x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

elapsed time: 912m

configs tested: 38
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240815   gcc-12
i386         buildonly-randconfig-002-20240815   clang-18
i386         buildonly-randconfig-003-20240815   clang-18
i386         buildonly-randconfig-004-20240815   clang-18
i386         buildonly-randconfig-005-20240815   clang-18
i386         buildonly-randconfig-006-20240815   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240815   gcc-12
i386                  randconfig-002-20240815   clang-18
i386                  randconfig-003-20240815   clang-18
i386                  randconfig-004-20240815   gcc-12
i386                  randconfig-005-20240815   gcc-12
i386                  randconfig-006-20240815   gcc-12
i386                  randconfig-011-20240815   clang-18
i386                  randconfig-012-20240815   clang-18
i386                  randconfig-013-20240815   gcc-12
i386                  randconfig-014-20240815   clang-18
i386                  randconfig-015-20240815   clang-18
i386                  randconfig-016-20240815   gcc-12
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

