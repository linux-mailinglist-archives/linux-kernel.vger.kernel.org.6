Return-Path: <linux-kernel+bounces-341372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8D987F24
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634C71C225E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541D17C9E7;
	Fri, 27 Sep 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XED3G62b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A96BFC0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420945; cv=none; b=LUwuNAgtzwstRjJzlVhKP91YQfNyUGurow8MsLvCqtNGznwi1jjy2tlqM66cjyF5xICJ8QsJmOAOGc35wxVvcIoPzkzfyIwbcHx40xG+wa5u8tqpa5Gef8O2o+dskCfj04uG0yMHpln+GnOoIt8Ver/DcmU8Id9mbC6kh09dOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420945; c=relaxed/simple;
	bh=neZ8mjhpDb1zKg9oMc0du6XDU0YSF/yog+PccxNQx10=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T6K3F9sCEoLz5TbYpWGPzNpNPSJ7N1C/eA9xZ+y/o5vXFKrQmPgRG6JaQfdBN+cgYgyV2NpZfKmGceUtejtgf9/CPNpp2kXhf9ebOUpq+dBcLxCLRrc9hsycMbP0V4GILHWDJC4KQb0c5vPNsF7OzT3EYNTN+EFtW/W61LB8qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XED3G62b; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727420944; x=1758956944;
  h=date:from:to:cc:subject:message-id;
  bh=neZ8mjhpDb1zKg9oMc0du6XDU0YSF/yog+PccxNQx10=;
  b=XED3G62boFd6eiHAASsq2iAQItc1t+SJ/tyrOkzD4+dInLaDkx9XyTN/
   K5NZ3mTJbHsIn/CWe25osqNbUXr8l+UH7Ojduv+uP3XbN+R0/8QIuphd3
   1bhmBFT6jqBbceTMvbXV+wcpWEAW/FYajzgrMRDSdgv/4wwzwSAcIHm0f
   vuD5ZJyBRaG6WePdWhuwAtgLwddzfwFvnWYuH7VESdNUVwT7F64W/JTJ/
   FAwVHqazNE5ZwPBQEq0F50U1LeZPxnx115VSZQMWSeUIS0y/h8xBKtW5M
   HihF0qCgqU6mWv/1JU2nh3S/i/l5roQ569BBflddT2hPNw0daXjBRPF5C
   w==;
X-CSE-ConnectionGUID: 2xAMp45NRa+8JfusqmH5wg==
X-CSE-MsgGUID: sewPeEgQQveHl9dQQDNJjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26358822"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26358822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 00:09:03 -0700
X-CSE-ConnectionGUID: OHdmhwdxRrS0k5S9sRJLgw==
X-CSE-MsgGUID: ek7S3XJwQZufo2Ql5itK8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="95787954"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Sep 2024 00:09:02 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su564-000LdZ-1B;
	Fri, 27 Sep 2024 07:09:00 +0000
Date: Fri, 27 Sep 2024 15:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d1fb034b75a8a96fcb4bf01a7c0e1421eef833a3
Message-ID: <202409271505.f1dOit4j-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d1fb034b75a8a96fcb4bf01a7c0e1421eef833a3  x86/cpu: Add two Intel CPU model numbers

elapsed time: 754m

configs tested: 36
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20240927    clang-18
i386    buildonly-randconfig-002-20240927    clang-18
i386    buildonly-randconfig-002-20240927    gcc-12
i386    buildonly-randconfig-003-20240927    clang-18
i386    buildonly-randconfig-004-20240927    clang-18
i386    buildonly-randconfig-005-20240927    clang-18
i386    buildonly-randconfig-006-20240927    clang-18
i386    buildonly-randconfig-006-20240927    gcc-12
i386                            defconfig    clang-18
i386              randconfig-001-20240927    clang-18
i386              randconfig-002-20240927    clang-18
i386              randconfig-003-20240927    clang-18
i386              randconfig-004-20240927    clang-18
i386              randconfig-004-20240927    gcc-12
i386              randconfig-005-20240927    clang-18
i386              randconfig-006-20240927    clang-18
i386              randconfig-011-20240927    clang-18
i386              randconfig-011-20240927    gcc-12
i386              randconfig-012-20240927    clang-18
i386              randconfig-013-20240927    clang-18
i386              randconfig-013-20240927    gcc-12
i386              randconfig-014-20240927    clang-18
i386              randconfig-014-20240927    gcc-12
i386              randconfig-015-20240927    clang-18
i386              randconfig-015-20240927    gcc-11
i386              randconfig-016-20240927    clang-18
x86_64                        allnoconfig    clang-18
x86_64                       allyesconfig    clang-18
x86_64                          defconfig    gcc-11
x86_64                              kexec    clang-18
x86_64                              kexec    gcc-12
x86_64                           rhel-8.3    gcc-12
x86_64                      rhel-8.3-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

