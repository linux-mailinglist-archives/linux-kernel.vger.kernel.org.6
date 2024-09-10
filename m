Return-Path: <linux-kernel+bounces-323667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF9974165
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084F8282BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A351A38DF;
	Tue, 10 Sep 2024 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQo27bbP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5918EFF8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990965; cv=none; b=oFOAeD2DkjRjPdu/0aN7bvjOOacIuL6JUSx1PUL4H5j2WBYpTupG/IG6le4smWUW0QzcFZLPy5hR6WpBk7/Wf9fDPe0yysbHO3ceNr+jmRO/cEfaHHK4WGTAnfIwjkn1bGiCjJy4KQcewIMOyp6wNNxhfKKXdvjcyHrnmoCCKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990965; c=relaxed/simple;
	bh=lMSLjd2Dhzg68AICCy0qDkfng2wBeHQZv4uGMveHniA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UMA+SwjhzYPEOwq5t60YR/ndRzXLLjBngUPu4pYt7ytPhqbcGGXJF8oRYRLPxjTbtwXRGDBL7NsAldFUYHpmRe3r9Od13WZIBTvle/yp3cAC5r2t/F058HgDO8E8QdMw7tXZOJkRWl0AsKZdRv3bhi+twcI8FlttHUlOq7ZXZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQo27bbP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725990961; x=1757526961;
  h=date:from:to:cc:subject:message-id;
  bh=lMSLjd2Dhzg68AICCy0qDkfng2wBeHQZv4uGMveHniA=;
  b=hQo27bbPGVe4KHSQaB5LYq0vkgFo7LqEXSwgd4IrUHOKWaquGqdLd+zZ
   nz4MEbZ9ZWiJemOpTDrEifcYTporsRo1xAKhhzQYbamV3QpZU66otJ1j5
   dBuH7u9epY90InJelZGiX3kAUXWD/KNZNiHh33AQBOVJ3SPwlkUQc95kN
   4l2V8QPF/p8UW6VKvRbYpzn5yNebrUVAoxE4Aj7vcwnNYhP55LmOP9vhK
   /N6vPddQRismyCk1MRJfA6Tu+xxfECsqeqh7VbOpPWgf9+F0sTjCZZmso
   sybY9VSTIwlOj5jx4QOmgGHzfJyKSk7ZHM7bqWsuIKDETNpUWDwo1N/2x
   Q==;
X-CSE-ConnectionGUID: 63hwy7T4TVeAzrejIEtAbg==
X-CSE-MsgGUID: Itdhe+n2QXChJrB9aALT2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24633852"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24633852"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 10:56:00 -0700
X-CSE-ConnectionGUID: NF2wwvFySk2MUhVqMxCozw==
X-CSE-MsgGUID: waH5jC5hSYmvcAIhnkkoNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71729503"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2024 10:55:59 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so55o-0002Sk-0n;
	Tue, 10 Sep 2024 17:55:56 +0000
Date: Wed, 11 Sep 2024 01:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/rt] BUILD SUCCESS
 41639286fd0b2538de8cfe3e99db18ed0df520cd
Message-ID: <202409110145.NWibBukz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/rt
branch HEAD: 41639286fd0b2538de8cfe3e99db18ed0df520cd  riscv: Allow to enable PREEMPT_RT.

elapsed time: 1460m

configs tested: 33
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm64                 randconfig-001-20240910   gcc-14.1.0
arm64                 randconfig-002-20240910   clang-20
arm64                 randconfig-003-20240910   gcc-14.1.0
arm64                 randconfig-004-20240910   gcc-14.1.0
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240910   gcc-12
i386         buildonly-randconfig-002-20240910   gcc-12
i386         buildonly-randconfig-003-20240910   gcc-12
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   gcc-12
i386                  randconfig-002-20240910   gcc-12
i386                  randconfig-003-20240910   gcc-12
i386                  randconfig-004-20240910   gcc-12
i386                  randconfig-005-20240910   gcc-12
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   gcc-12
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   gcc-12
i386                  randconfig-015-20240910   gcc-12
i386                  randconfig-016-20240910   clang-18
riscv                             allnoconfig   gcc-14.1.0
riscv                 randconfig-001-20240910   gcc-14.1.0
riscv                 randconfig-002-20240910   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

