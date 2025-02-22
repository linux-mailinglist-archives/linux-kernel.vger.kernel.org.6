Return-Path: <linux-kernel+bounces-527382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D80A40A82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A1A420DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD80207A0E;
	Sat, 22 Feb 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhURsLk0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E9EEDE
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244066; cv=none; b=olJvJfqjH0tLJMQMPHJQLSJP94kUFkcl93TT6ZIGz88L8tjEPQDB7oJ8GbVxHz8IjYOe3A33FQ9e7yjiLIXBQnxfN0/BMoq2mpcJe16Cpx8TJgctl0sJr82bbewL+4lmSZn02/wy5toIkozHVquZKz5DP/3EfLwv/0YtWmi9DOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244066; c=relaxed/simple;
	bh=e4rQWjLUD5kmSSzaeloj1Jd0ielp9q2YvOqNPS53y6I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MbkIoQl0PaLoh99iKtqRuoBw3fk8owIPKmKLks55KkicbFCvTpk8hhIdxMLYzO2ajLhq5JHKNkj74+6kXaTOB+J6DCdrCTwKAUYvnHPoI9Da4nO94O7BYoHi2SXBB4Nb4swzK36FIPDF2/DG6nHBYzvjgx5dQ0HeOUrnlICHG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhURsLk0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740244065; x=1771780065;
  h=date:from:to:cc:subject:message-id;
  bh=e4rQWjLUD5kmSSzaeloj1Jd0ielp9q2YvOqNPS53y6I=;
  b=ZhURsLk0eHPxBNal4FAhQ5m3WpC001zyRylsLO2NPiOkWXv1ZgvMyunp
   zQyFmthXlAKxwHq8o+n8H6V+QSS8Fv6bYOyHoDRdqyYfwQzYwj7pPyRcQ
   PfVaD3uYoO9G3iJcf9VyG3gL/Y3+SCsqgxzmq/T3/pCz+xiqyBYYs36cg
   RcIpfVZcnZiiLGRbnU7aDZxin6M6mkJ1szJBylz+xG5DeHfOqaM6uRh0g
   C29icxaCaPjlaucorBhdTvAYpwnS6V6AkYwgTrSTO40hKYWpG/Tjbekqz
   Mde0b+iqPkzeRxDM3hQqcn67eqe2zgaz+iciulHRbW7leRmrBD2g/ysTT
   w==;
X-CSE-ConnectionGUID: mfQbcwr6StmJNSHO+6QPZw==
X-CSE-MsgGUID: zdr5103jTOqENNTJnngxwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41254960"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41254960"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 09:07:45 -0800
X-CSE-ConnectionGUID: abFEAbRdRVaVCwWZS3cfZg==
X-CSE-MsgGUID: 0ipGZkjqSq6VRYEZCUmZDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116141519"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 22 Feb 2025 09:07:44 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlsyb-0006kV-1j;
	Sat, 22 Feb 2025 17:07:41 +0000
Date: Sun, 23 Feb 2025 01:06:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 0156338a18eba7ee229e59c8928c7056e9753c61
Message-ID: <202502230144.XBfidprn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 0156338a18eba7ee229e59c8928c7056e9753c61  x86/apic: Use str_disabled_enabled() helper in print_ipi_mode()

elapsed time: 1446m

configs tested: 12
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250222    clang-19
i386    buildonly-randconfig-002-20250222    gcc-12
i386    buildonly-randconfig-003-20250222    gcc-12
i386    buildonly-randconfig-004-20250222    clang-19
i386    buildonly-randconfig-005-20250222    gcc-12
i386    buildonly-randconfig-006-20250222    clang-19
x86_64  buildonly-randconfig-001-20250222    clang-19
x86_64  buildonly-randconfig-002-20250222    gcc-12
x86_64  buildonly-randconfig-003-20250222    gcc-12
x86_64  buildonly-randconfig-004-20250222    clang-19
x86_64  buildonly-randconfig-005-20250222    clang-19
x86_64  buildonly-randconfig-006-20250222    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

