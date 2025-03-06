Return-Path: <linux-kernel+bounces-548609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D3A546EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BC21883C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFF20ADC7;
	Thu,  6 Mar 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/rh6Hvd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3B2080D7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254782; cv=none; b=rfOsV39Ezn7MOuYhfHVz9OerM6ru+4OB36sgtFvIKDgpLki5pW7QdHsSVWKQJ6kuQkBUd/cZ+iW0LkXcI6tB/z6s77i5cof9zIqRoqJJhmIvMp4NHQN0+J2NMPnx8HP+0jT78gb/evC2gv7wkj7rot0McjxW4B9aK6QUpUn5lcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254782; c=relaxed/simple;
	bh=5wL21Rn4f9saBWRTpHN1pecVymAerCULJTWmV1TLHWk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UbCoSocFnNmj5P8iGu8lvTXGD8a1Q2fpKGxDt5HaiafTdPRfg3iaQ13kE7pJe8w4908G6kDeaZIXLbgEmOtw7Wt5GJquHXmqQqx67Sg5Ev/tlQTdnA93XLv4Nh2NX1OIsqCBHkqgQq0KAnM4YMT/l7/c2PU6lW/x4Liiwf5eoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/rh6Hvd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741254781; x=1772790781;
  h=date:from:to:cc:subject:message-id;
  bh=5wL21Rn4f9saBWRTpHN1pecVymAerCULJTWmV1TLHWk=;
  b=O/rh6HvdvB6Lx+K0pt9aQSIFItYdagcuPTEmTzeewKnq8h4YgiaOabNA
   6tNRitiQ/2RmOloorg5x5fRvI1xamJg/tSnGOz3pBJ6FKf0/DDrh9ohcr
   ehbuUUYpfibUsNfiq+pZQLqRCq44D2PsAWtvcvd/m9sS5Z9ER+BCB04uu
   VZr2EkQjfM7+oD7pa8OlAMz7hMNm0z1zd19mbifVbPG2pigmewB1gqQrP
   hTU57qMg+ecZ79ONlG9mfwR2ZXApcRUh/5sMbZz5aSPhwiD527hGAswPW
   MoYuZSEESa0nKUYxNu40sbSK/aNzDNZ+666gEa1L+3HNe/HGIj69v0t9U
   g==;
X-CSE-ConnectionGUID: +tROgpwTSz+cRsV64cqceg==
X-CSE-MsgGUID: AgmNswQeQ9GgIi0VCtItnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46026427"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46026427"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:53:01 -0800
X-CSE-ConnectionGUID: 95CJC/jASISuHfEznb3swA==
X-CSE-MsgGUID: oTcqe24hQaOu/lC8wYW4aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123990717"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Mar 2025 01:53:00 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq7uT-000MsA-11;
	Thu, 06 Mar 2025 09:52:57 +0000
Date: Thu, 06 Mar 2025 17:52:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0d3e0dfd68fb9e6b0ec865be9f3377cc3ff55733
Message-ID: <202503061729.dX9vfVav-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0d3e0dfd68fb9e6b0ec865be9f3377cc3ff55733  x86/sgx: Fix size overflows in sgx_encl_create()

elapsed time: 1463m

configs tested: 18
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250305    clang-19
i386    buildonly-randconfig-002-20250305    clang-19
i386    buildonly-randconfig-003-20250305    clang-19
i386    buildonly-randconfig-004-20250305    clang-19
i386    buildonly-randconfig-005-20250305    clang-19
i386    buildonly-randconfig-006-20250305    gcc-12
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250305    clang-19
x86_64  buildonly-randconfig-002-20250305    gcc-12
x86_64  buildonly-randconfig-003-20250305    clang-19
x86_64  buildonly-randconfig-004-20250305    gcc-12
x86_64  buildonly-randconfig-005-20250305    clang-19
x86_64  buildonly-randconfig-006-20250305    clang-19
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

