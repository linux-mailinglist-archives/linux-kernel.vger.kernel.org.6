Return-Path: <linux-kernel+bounces-576931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D73A71628
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729D5170229
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8501DD87D;
	Wed, 26 Mar 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkwZ24qD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7A1A3A8A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990484; cv=none; b=ZqzoWRKkNzgEx1EDwBk8gQ0oL0hq1B+DrtgFm38y8Je+eBL18tkNvfhIeWkEHbS6C5Jr91kLxXcDZvs3rrcC9Xib9041+l/+O7sWJbUHYjwa2uTR5+RolIZwE4FHmEbzxPBSUDJbpxghvSmk82Vl9lCkeIMwm/jd08Z4277boCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990484; c=relaxed/simple;
	bh=JLHh64NrRMVzh5P62S3YztbUKN+nhm0XubMsKQFvI48=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z+RG28c3KjAygdtvDmjLSOFV19WMELkEVDfeZtn1JrMcjen94elh5drShtf6f80oeM/0/6/qji6Tun7Pt2XQgGwMx2AJJH9Fd9xFaSLl0GQKnqQEx44ARSrK1ol55JuEIE5rr3PYEqBAtwV2uTPZGOoUWa3Mb3qSTkvVUha0Nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkwZ24qD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742990482; x=1774526482;
  h=date:from:to:cc:subject:message-id;
  bh=JLHh64NrRMVzh5P62S3YztbUKN+nhm0XubMsKQFvI48=;
  b=kkwZ24qDHFjedSy/clexsxYJtmS4sS3qg/PAha77de58jTFJrKvx/lf7
   I50JgqHRk6JYkkDB55LBBMsCgOuOUe8WKMDqv5e2hqJkyk2UM5dKMF7Mt
   mlOaHaOhfqLjTssieIOFOK71jvRv0JrOtIHQuHyTyBAj/rqnJ7p/vJeIc
   xVoDYn/Wi+LhWEAvxkXNwxCDEhwz6tr1NNMgDvqkc6H49EGTvcvscGP+o
   hPsCOGlxRNmrO8oRCWthvpvON4BWS6/0HDYb58Mc9q1xlWBwljzWUb4Hk
   H1EAJCECOWUqcce4UQPMOW2ygM+Iaaj5KE0rSul6a15ohGyhgbRwTTDbv
   A==;
X-CSE-ConnectionGUID: Q0mmm8LGR3GSmGisc969sw==
X-CSE-MsgGUID: 28QhwicSTtmS0PwLtXNeVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54920653"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="54920653"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 05:01:09 -0700
X-CSE-ConnectionGUID: eT3MLhvjTZavuDz728mkpg==
X-CSE-MsgGUID: nqi+zKAnRt2WemFdpH/m+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="124686016"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Mar 2025 05:01:08 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txPRS-0005i4-1i;
	Wed, 26 Mar 2025 12:01:06 +0000
Date: Wed, 26 Mar 2025 20:00:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 ed91ad084ef9fa49f6c6dfef2cb10c12ce3786a6
Message-ID: <202503262029.cpVo7uL9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: ed91ad084ef9fa49f6c6dfef2cb10c12ce3786a6  x86/fpu/xstate: Adjust xstate copying logic for user ABI

elapsed time: 1448m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250325    gcc-12
i386    buildonly-randconfig-002-20250325    clang-20
i386    buildonly-randconfig-003-20250325    gcc-12
i386    buildonly-randconfig-004-20250325    clang-20
i386    buildonly-randconfig-005-20250325    gcc-12
i386    buildonly-randconfig-006-20250325    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250325    gcc-12
x86_64  buildonly-randconfig-002-20250325    clang-20
x86_64  buildonly-randconfig-003-20250325    gcc-12
x86_64  buildonly-randconfig-004-20250325    gcc-12
x86_64  buildonly-randconfig-005-20250325    clang-20
x86_64  buildonly-randconfig-006-20250325    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

