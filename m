Return-Path: <linux-kernel+bounces-553122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D01A58425
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9E23AB575
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0A1CC8B0;
	Sun,  9 Mar 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6yBAGBN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64284192580
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524782; cv=none; b=jCX/YPuNCcyMOBPLo1eyPbmFwXLRRze3T02P/uTKRDZoWMIFOmk80d5q3JfjgUKGtgbACvr3aXxeMCLoPeJAJQabsH+3zy4rwBdk8gYzFcZfyDLz+CLN9/s8Tj607d2G6hcQciDlbojq/pQJC7x4WdL5/akAg96Yj1Bk9Qlqla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524782; c=relaxed/simple;
	bh=rFcg4i8UNUAEkwLzVb0iN9+Z2k+kmMA5Ez9PqfYOedk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ez2Ert3WZzZEbnfJ6Jgz9jt1iFOr/coPli1LVCgcHvPGPPsK/oIQ/9MIGnJFT+Fw8GRpSwrCMDMJCwC/KjNWNbyofcpHja32A5K2ZG77k4amNfipJfuBw7iIZoIWieReVpnRvvs3VcvxQX2NPC8GawwKZiZKAaHFx019nwljX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6yBAGBN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741524781; x=1773060781;
  h=date:from:to:cc:subject:message-id;
  bh=rFcg4i8UNUAEkwLzVb0iN9+Z2k+kmMA5Ez9PqfYOedk=;
  b=g6yBAGBNl5zCzhIGWadILUr4AzZJy4hyZPy8XGfAtYSjZTOPYseBR0+6
   Dt8ilRzKD/WcQmACpvqLt6mdYUbgNlBgDt3pFANEAbwF5oeS3xEzqokBk
   ul0SOUZj83+bUTaV6cg8z45Sr7veZcClFONpG5EpKnSscXAi4vpSJigfy
   mTB/flXyUUUuS1YJopgyMTJ80E3GK6vJ5KegGG1jUtqLywfsJFvjZT9yr
   oMYGF1LTL7Q9+quFIyqUxAmhUZFceKSx84Z0XV6cC/K3vSoy4047PNdJx
   LPCPz9y7YYznFwbvb5ogwmlKWWMrgbNyOi6MeH/biT5WOdf5PT3+G0zfQ
   Q==;
X-CSE-ConnectionGUID: oRf3HTaURnSe+0k+csd5Mw==
X-CSE-MsgGUID: jCTpGfoQRJKDGQdc4R8nZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46305433"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="46305433"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 05:53:00 -0700
X-CSE-ConnectionGUID: pNyBP95wRxyLCBfmux/Gkw==
X-CSE-MsgGUID: PVJTamVXQWaB5HUr1V0cfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="119921550"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 09 Mar 2025 05:52:59 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trG9I-00036q-2b;
	Sun, 09 Mar 2025 12:52:56 +0000
Date: Sun, 09 Mar 2025 20:52:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 558fc8e1869ca6e1eb99a1e2b52f6c35424d4adf
Message-ID: <202503092049.yttdQGqR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 558fc8e1869ca6e1eb99a1e2b52f6c35424d4adf  x86/boot: Do not test if AC and ID eflags are changeable on x86_64

elapsed time: 958m

configs tested: 19
configs skipped: 123

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250309    clang-19
i386    buildonly-randconfig-002-20250309    clang-19
i386    buildonly-randconfig-003-20250309    gcc-11
i386    buildonly-randconfig-004-20250309    gcc-12
i386    buildonly-randconfig-005-20250309    clang-19
i386    buildonly-randconfig-006-20250309    clang-19
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250309    gcc-12
x86_64  buildonly-randconfig-002-20250309    gcc-11
x86_64  buildonly-randconfig-003-20250309    gcc-12
x86_64  buildonly-randconfig-004-20250309    gcc-12
x86_64  buildonly-randconfig-005-20250309    clang-19
x86_64  buildonly-randconfig-006-20250309    clang-19
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

