Return-Path: <linux-kernel+bounces-555498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0FDA5B895
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717783AE281
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF291EDA18;
	Tue, 11 Mar 2025 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dADlVhwF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9F29A1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741671621; cv=none; b=kwsAsjNOU1p1E+zvkDm9bQeRgTaSxCdig9VYV8mYw+cqOWOz/52cw96+d8QyZpCS3XKof3KoS6W37rBw9i3EwinWA7XdXjfLaYK5Rc6YTkoXmioRYJvZmAGEZM/81HHefI/0DNv7jCg8DcLS1m7nv3qRsUdOFUkZ13Ub4SZva4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741671621; c=relaxed/simple;
	bh=oYweTKx7ALuJMlsAQRAxSOuMULV72Za28r/jTArWsTg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pDsbv0P1Mjltxv/i3LRq+vdbi1oIWAohWHOMrX9pHf26q8BPwJ50wHdMfM7H9cjNtilBG4IhMnGC5u+1r3V+3aTNF54EfQ3KrokDi+AHAvGYaF9FjwB8k32zBtlhgRLfn+kiYe015vqoL66ubjMZKoBuEjOYkuBClnUaJAhoU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dADlVhwF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741671619; x=1773207619;
  h=date:from:to:cc:subject:message-id;
  bh=oYweTKx7ALuJMlsAQRAxSOuMULV72Za28r/jTArWsTg=;
  b=dADlVhwFW+dDdF24j1hcY6BVNOWLqaHUGuAbVyXqKNvW07U7tKsZOkPD
   GVUrxnBnjW6YKZkddUxk5Sdlfj3msN/bQkeWBXELDTfDAyJXCgY1yMQvb
   8PF26OxDVDI81n6pUnVPV+NsMurjmaLnRuWn7X5R5+hl+kWSxpDRB9Je/
   Z7wfckLG02GP2r6z0Ggb+N/WmkeUpC6kviIsqNJIZiJrLtxNVoSDF+aBw
   5bt/X0+kvM8zDe+zxLnkg1ISipdtKV0nvOsrY5gUX2I//gyxnRhYk+2Vd
   Rk2FciOsBmZrOnefwJ82Vr2zfcdx++CPOgl8B9X3Q27B2UOsq/E5iGooP
   g==;
X-CSE-ConnectionGUID: gabBY9NNSeG1B489uCIRyg==
X-CSE-MsgGUID: wZuAyaxiTO23CkFzO8Exow==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60241321"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="60241321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 22:40:17 -0700
X-CSE-ConnectionGUID: mygwctF2REqT8BRrNG1n2g==
X-CSE-MsgGUID: KvvI4gcVQhe/7mQyYol9cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120170929"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 10 Mar 2025 22:40:17 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trsLe-0006OI-11;
	Tue, 11 Mar 2025 05:40:14 +0000
Date: Tue, 11 Mar 2025 13:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e3e89178a9f4a80092578af3ff3c8478f9187d59
Message-ID: <202503111329.CXHJQLOi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e3e89178a9f4a80092578af3ff3c8478f9187d59  x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes

elapsed time: 862m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250311    gcc-12
i386    buildonly-randconfig-002-20250311    clang-19
i386    buildonly-randconfig-003-20250311    clang-19
i386    buildonly-randconfig-004-20250311    clang-19
i386    buildonly-randconfig-005-20250311    clang-19
i386    buildonly-randconfig-006-20250311    gcc-11
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250311    gcc-12
x86_64  buildonly-randconfig-002-20250311    gcc-12
x86_64  buildonly-randconfig-003-20250311    clang-19
x86_64  buildonly-randconfig-004-20250311    clang-19
x86_64  buildonly-randconfig-005-20250311    gcc-12
x86_64  buildonly-randconfig-006-20250311    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

