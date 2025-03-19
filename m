Return-Path: <linux-kernel+bounces-567113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B84A68164
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A04B16DFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8214F70;
	Wed, 19 Mar 2025 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGfFu/Yt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C35A926
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343658; cv=none; b=Wvpv43MLJkXk9S/uqrXRVoZO4sHxXd4EbZiNucNHAtFmi/7evFCFc+/SZGn3JD6ap0oeTbWRZ2drZmKZixZd/IBhgfKRW2o0pJyFZcECgTFCK04Pv9SHWPMeUGALCrr9yq1XcSoNulH6FYk9j16bpr6ebYPssKj872yuWdNJqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343658; c=relaxed/simple;
	bh=GQqcVrf5QyqYx2+WDGznbW9W9FZB47r9v9ZhK+tx9u0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jd920JRGaSz6CZ8/eD2fxi+cT1nTAE6kxEaAzeWcKM8vDyqBZ0J2N6wIL+Heyn9fLYlOVRNd+DiHyxbInkFm25crpy2/Gk0REXn9GO8TsAH4tBTdE2lKMwjsFXgl0YEq5d6LOPQB9Rjd+dLHKDS0Ld6kqLyqwpTuJqXRgOphrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGfFu/Yt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742343657; x=1773879657;
  h=date:from:to:cc:subject:message-id;
  bh=GQqcVrf5QyqYx2+WDGznbW9W9FZB47r9v9ZhK+tx9u0=;
  b=JGfFu/YtNQ6iyhdciHGtrrnn6+KfCvvvizAtbZ1tx9bNyi4mWMlnzBGo
   zG/ik3/OMscEZmBXCB2IZKaOormClP753NCc/oZxZok73Cv+vr4QPTqW0
   ZT5Nxb9672P7AxIi7keYf7FsqTrtkr/AQrQwIyUdHeddRgQQqL9DkG77i
   5CQzttrmLpgzuus9LC70VGJyeb2TcjvrIdcmF5q98e+A5ENT6ZKfAxzHl
   gAhr6+b1ejynU28Giu+K/Po4TLJ1qwMGgJrr8/XaZ8wDH/bXsTtyhak8Z
   qN2ZZ8PWHhg6sMhWxcgwPVqix3YB2WYga7L9IU+ksY0PtUB7dHlgIMwU7
   g==;
X-CSE-ConnectionGUID: ub0ADB2OTIWp9SNSUOHZ+w==
X-CSE-MsgGUID: nx0Va/dGSMKZTAroaVYLng==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43698808"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43698808"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 17:20:56 -0700
X-CSE-ConnectionGUID: uHxiXTzzTYqGODC3CJukKQ==
X-CSE-MsgGUID: OdHZfBDrQDW68g8YIru5Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122892213"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 Mar 2025 17:20:55 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuhAy-000EFm-2x;
	Wed, 19 Mar 2025 00:20:52 +0000
Date: Wed, 19 Mar 2025 08:20:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 65a99264f5e5a2bcc8c905f7b2d633e8991672ac
Message-ID: <202503190836.urAOLXR8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 65a99264f5e5a2bcc8c905f7b2d633e8991672ac  perf/x86: Check data address for IBS software filter

elapsed time: 1455m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250318    clang-20
i386    buildonly-randconfig-002-20250318    clang-20
i386    buildonly-randconfig-003-20250318    clang-20
i386    buildonly-randconfig-004-20250318    clang-20
i386    buildonly-randconfig-005-20250318    clang-20
i386    buildonly-randconfig-006-20250318    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250318    clang-20
x86_64  buildonly-randconfig-002-20250318    clang-20
x86_64  buildonly-randconfig-003-20250318    clang-20
x86_64  buildonly-randconfig-004-20250318    clang-20
x86_64  buildonly-randconfig-005-20250318    gcc-12
x86_64  buildonly-randconfig-006-20250318    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

