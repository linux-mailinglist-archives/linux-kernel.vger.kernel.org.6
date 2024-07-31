Return-Path: <linux-kernel+bounces-268432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44670942496
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93149B23B49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9001798C;
	Wed, 31 Jul 2024 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CI8LIrtX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2A17580
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394094; cv=none; b=Ro8fhYMY+wAqdGDJfs/opR3tpMhBUEVtQFAPCnRwVu8lUFpLHo7a4GHgJXnOucVy+Zd2idc2XAR7PvVCHDwcccmhu8OcciUC7QFfcJAtXQxoaCQwJEyr//iQi1txdIk2p6CwQxtyqbrY3garcs4sv4oDGdX6SL9kN4kcSim671c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394094; c=relaxed/simple;
	bh=WvAPuGPFU4pmQScx6YiigpqW7rymLfPlE9WNe9+ryRE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mwenbM5fOKUCHkGCA2Ggm3m+VTIF6RFH/aw0ZqhdZHv/MeHmuSheRB7g2ULjV1oE09rFSDyDgfBjpdd9dh86mJUlyFmtaPehCtBlIsII71OZmHSWYLezcJA6AP4Q9Y8aNpE2EMx3JrS6kXr+hSHAz3MFzs+EbTXMbRLZKHFR4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CI8LIrtX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722394092; x=1753930092;
  h=date:from:to:cc:subject:message-id;
  bh=WvAPuGPFU4pmQScx6YiigpqW7rymLfPlE9WNe9+ryRE=;
  b=CI8LIrtXX3zARoTJgk4coxaEDNjaiJHt5iK2d0hiyt4Qw6wNRgh1gfRY
   nAEOps5dOl5WXi8QFsGeVfY7p8an3oU7AMZERM2iUUJMR3xZG6W/vzokW
   7tNHLJM8YEPT21o99oxtF9WM/JIpF5UG7F6g+2FtD8zZPfbtthSB9NV5c
   f02Kll2CfjKFguhoZvmPmCox2Ew29+dAvkXrj5Sb3sP3kyvptK49cW0X4
   KMgWDBdXYAWPz7FfN6DkV2rwBsli03/vkDkY/Q9Ini5JIU6ezqp5tvvEn
   5evpWWRUjK/2lnMwCSORNH8RQFCcmrb68fkTEPkjxzXYjljG3cHEUrWfG
   w==;
X-CSE-ConnectionGUID: VbOAx+vHR9iKPG2tBlizWg==
X-CSE-MsgGUID: BjZ1nIz9TLGAPsjOTSjFDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24011104"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="24011104"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 19:48:12 -0700
X-CSE-ConnectionGUID: pKiuQVg9S9C804mmtPo9EQ==
X-CSE-MsgGUID: S8OzRHVOSF6ACmLPPJG7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54534681"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jul 2024 19:48:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYzNo-000tf6-1J;
	Wed, 31 Jul 2024 02:48:08 +0000
Date: Wed, 31 Jul 2024 10:47:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bf5641eccf71bcd13a849930e190563c3a19815d
Message-ID: <202407311008.U4PFsRJf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: bf5641eccf71bcd13a849930e190563c3a19815d  x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range

elapsed time: 737m

configs tested: 17
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240731   clang-18
i386         buildonly-randconfig-003-20240731   clang-18
i386         buildonly-randconfig-004-20240731   gcc-13
i386                                defconfig   clang-18
openrisc                          allnoconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
s390                              allnoconfig   gcc-14.1.0
um                                allnoconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

