Return-Path: <linux-kernel+bounces-572761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750CA6CE56
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58DB169A99
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73177201261;
	Sun, 23 Mar 2025 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSWOzKej"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78B15ADA6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742719156; cv=none; b=OVF5lXrH3nAadkueZ51KN7etqEwC3SLSldjr1ZWhzneGyTnufTSc49cebcY94jY6vEik/hYkWmVj4WXn1ZgXL7yPlncy/6t9TskjJsYpVt0eTgARCzewKxnT3fJSDvNtVzun15ARJ/eP9/scaYQEpWdSeCopo7Eq6X7vlxveDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742719156; c=relaxed/simple;
	bh=pjyCmpxEr5jT0zIxY7JcF9hVQh7SAFHzVL7PbIN655o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=enCZSsxbk4D+aJ+G/PY+qVBe+UzpYbfsIfu5Js6xAf2Y0JPiGzBJ6W24THN2hFgMerb/X1xQEXX6ztYEb5Fj3Az6vqFCdfjG1I1g9CLrM88pidAbrx1mtnX2hev+JKgRs9nKOVqea3wUxlrPzS0wQT2DLtSaWZpjvsE6dx1KWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSWOzKej; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742719155; x=1774255155;
  h=date:from:to:cc:subject:message-id;
  bh=pjyCmpxEr5jT0zIxY7JcF9hVQh7SAFHzVL7PbIN655o=;
  b=KSWOzKej9J+jyMqmXZbgbpo9MAKy9swHmQKZDRy53R6scjlTSU75H1xC
   mZbbTiSq3kMWPUp0O0BM9PFvTJwItTf9hI1haOmDF+i05Ahh1yx5LYrJZ
   JNUM0YBwAJ3Rcv95qIZnExZDIFSxBVFohx4kBQNgdmaDziIGwdfDjIGNq
   WHkzwgEqXSiiY1u0KY4lQlxb65opnck06SZjLiD3HQqw9aq/OqyvDhUIF
   5hmUpPKFc1P+jyShH4c4bjVxWic9IlRtaknLTBex6PI+FTy96mb1KzbHR
   2R+zOOSA5hOvWbI7MJEdgKtbH6a9TgL9YNvqBRtcAbSoEzSHzLBbhTKAz
   w==;
X-CSE-ConnectionGUID: Pwlh4vnhT9mxSIJa+pTJKw==
X-CSE-MsgGUID: yeI/4VvcRXyq6lRqINGOSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="43171688"
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="43171688"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 01:39:15 -0700
X-CSE-ConnectionGUID: IKam/7RMQrOr4I/WqkSbIA==
X-CSE-MsgGUID: vf5RN25sSO6f1hDAnEDNDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="127921669"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 23 Mar 2025 01:39:13 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twGrP-0002fX-2T;
	Sun, 23 Mar 2025 08:39:11 +0000
Date: Sun, 23 Mar 2025 16:38:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 50a53b60e141d7e31368a87e222e4dd5597bd4ae
Message-ID: <202503231650.ZPj02Ox0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 50a53b60e141d7e31368a87e222e4dd5597bd4ae  perf/amd/ibs: Prevent leaking sensitive data to userspace

elapsed time: 1444m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250322    clang-20
i386    buildonly-randconfig-002-20250322    gcc-12
i386    buildonly-randconfig-003-20250322    gcc-12
i386    buildonly-randconfig-004-20250322    clang-20
i386    buildonly-randconfig-005-20250322    clang-20
i386    buildonly-randconfig-006-20250322    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250322    clang-20
x86_64  buildonly-randconfig-002-20250322    clang-20
x86_64  buildonly-randconfig-003-20250322    clang-20
x86_64  buildonly-randconfig-004-20250322    gcc-12
x86_64  buildonly-randconfig-005-20250322    clang-20
x86_64  buildonly-randconfig-006-20250322    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

