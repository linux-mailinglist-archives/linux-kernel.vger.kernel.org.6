Return-Path: <linux-kernel+bounces-571899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E0A6C40F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D530189E7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CA1230264;
	Fri, 21 Mar 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WM6IHte3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4222DFA6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588226; cv=none; b=hjVbafy3w6bNjCFRaoJVyPXLZ+0AbJgBg/2r7hr6/6ypaSBzjzWdwE68swjQxsZ9QjG+O9NTBdjo7XC4k3zOqdhui3kI8DEAy3L8OwRXcZv10uOwL7rRsntmwMv2WR+jRZFtaLbcmdMjiKYcDq6c4LUiLgFIxRj1YOmZyRMgJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588226; c=relaxed/simple;
	bh=NVZp4BWeyBtdW4RNgqRxFhP2Hz8JWnqhqxWf188RgKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=djzeXv3YOEX7qCMqgyLehnX7ysk/E2zvcKSnhp/kbtVnt/LQkq8cwxETsQI0QKXA7LDDCJkYZY95n33gR9vO0K0YhtImXG9lhgM9ptNCUOuQCZ5pUbuFkKWxybjIzLyOPNAnK+R0nePDtU03LT9+sGakUL7zmwNUg8NYJiYmNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WM6IHte3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742588224; x=1774124224;
  h=date:from:to:cc:subject:message-id;
  bh=NVZp4BWeyBtdW4RNgqRxFhP2Hz8JWnqhqxWf188RgKc=;
  b=WM6IHte37kU422zB8sjrHzmdrGHVwv/p42aRlnY5R16fiR6zSggIjjqf
   7axJzQIX4lizsYxATiuXDanV+j7guAjG3lFOy/fTmVQWC4mmXeKMgWj3y
   gJVB9XWOA2VyZjCJTu1PcLW0SwjsEQ7BJh82T3h/+bMqYMIEZNDFAZJWd
   HK3P593BHOoN4u/5EJqIoiELnYHyoKlcCIQ3SS6g8hiJ9ynY9zX9B+w8u
   8lYD48fCGPMuIakSJo++dmscQU6u/5SvQhol36D2xFDjB8sHVgCDxe6Zu
   pz5DlQm17kabEZ82c+re/pZAd4CLBJoPbD2Jw1JffDToE132ODBd7PX/p
   Q==;
X-CSE-ConnectionGUID: XOGA+8wNRciQw8eVBzDSOg==
X-CSE-MsgGUID: a6zHbGnjTxubN301LlOR4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43746975"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43746975"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:17:03 -0700
X-CSE-ConnectionGUID: FVpJiq7qTk+PseUWyOO+/Q==
X-CSE-MsgGUID: 4LLubxEjSTSkdcjhOuk0pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123510805"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 Mar 2025 13:17:02 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvinb-0001f1-2u;
	Fri, 21 Mar 2025 20:16:59 +0000
Date: Sat, 22 Mar 2025 04:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 7e512f5ad24458e2c930b5be5d96ddf9e176e05d
Message-ID: <202503220409.DK8VzkdF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 7e512f5ad24458e2c930b5be5d96ddf9e176e05d  perf/x86/rapl: Fix error handling in init_rapl_pmus()

elapsed time: 1446m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250321    clang-20
i386    buildonly-randconfig-002-20250321    clang-20
i386    buildonly-randconfig-003-20250321    clang-20
i386    buildonly-randconfig-004-20250321    clang-20
i386    buildonly-randconfig-005-20250321    clang-20
i386    buildonly-randconfig-006-20250321    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250321    clang-20
x86_64  buildonly-randconfig-002-20250321    clang-20
x86_64  buildonly-randconfig-003-20250321    gcc-12
x86_64  buildonly-randconfig-004-20250321    clang-20
x86_64  buildonly-randconfig-005-20250321    clang-20
x86_64  buildonly-randconfig-006-20250321    clang-20
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

