Return-Path: <linux-kernel+bounces-185703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094B8CB914
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A80B21DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A72A1AA;
	Wed, 22 May 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4y69eYl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB74C7B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346068; cv=none; b=rVM+3kyMh4DQys6e/pBMOJiaaAnUFXV78z76Gs7d53P8SRhd3hUrtZJbggvQ12YifpEJxCifXa5uaVCskExaSwkJ50TWwtYuBYsX+kr/fRHbZNrHycdiJD7p6QUrJTjvRjU2LHsT265cDJSXWLPQHMV54Vs4YAW4uPNKE4QByqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346068; c=relaxed/simple;
	bh=vhEKlZY+ZZVrdklK0X1j7CdcEeoH0jWqQGuJYxTk3Bk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MpZxXeHJPW66CsP0ey3qxvLNWchu+0psrUKPNX335T6+yCnu9JCTfa3ICeNi/oZOLqmJ6axZD2XJLY1X/IJdCnE7UvwQ6/VrBMx7Lp3APFNWJyI+PDvjQ+bROzRmJuPP3bLSjdw4tC2E5aQRcFdGoWR58ldIaCSnYM+b8I6OBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4y69eYl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716346067; x=1747882067;
  h=date:from:to:cc:subject:message-id;
  bh=vhEKlZY+ZZVrdklK0X1j7CdcEeoH0jWqQGuJYxTk3Bk=;
  b=C4y69eYl7iahPT0tDGC2jQ0RoZMlCm+EJpTJtAZhjoDEHfWqPQmAaGlE
   4XMgR4Z0NG0hu3cqNpx+fJ+9gNgVYBufd41I97BuFhtOkbV4H8clELh9A
   oB5a3o+3uOrB/+vTvCAqyguk6fpdnR3zwVtdFy3z1KWFMZ0OffNaCkgtg
   92/LSrA08Ghfv8cls2wMlhicvUnjKSc//kvIabZNLG06Tq4VjYqU1A4x7
   NfkQY45Jr/hrp13RIH0YTXIyUt+1K087pvsiX3fPPKImkvHOgC6yGlOj7
   N5wwxIhWvYPajroEzVGIB04o3Z6OpOxWrQ5Qun3MiizuofG8I+qmXvo1w
   A==;
X-CSE-ConnectionGUID: W1JQTJzdRGiFwMOI5m4EpQ==
X-CSE-MsgGUID: 6oEb0DyATlWmCF54ZmHvJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12514988"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12514988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 19:47:46 -0700
X-CSE-ConnectionGUID: RNzcBumjR8mfk2SBkPveBw==
X-CSE-MsgGUID: IeiHSlpSQaq7Yf9t3yU2Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="32996880"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2024 19:47:45 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9c10-0000yP-2V;
	Wed, 22 May 2024 02:47:42 +0000
Date: Wed, 22 May 2024 10:47:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5242c6fd8c29e620393d7f12763bdf1efb1ab164
Message-ID: <202405221017.9tpjyznb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5242c6fd8c29e620393d7f12763bdf1efb1ab164  Merge branch into tip/master: 'x86/percpu'

elapsed time: 729m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-016-20240522   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

