Return-Path: <linux-kernel+bounces-561972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA83A6198E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D99419C2F21
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861FA204876;
	Fri, 14 Mar 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6duJVvo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B328155747
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977301; cv=none; b=KoxEf/PU0Q1364sjPMkHzf/UoK4KumMoGdV4duVCJBdtdkDJ6EwJN/5ec+8KDcvp5AxvwXAtFtjmIIPTRkfJxoScJbpN4AK4kkIhHOkY/yYkIAjF9+FtLk95VFTzpXJ3eB3aAUVcoOqRkOAh/Sfn2jK5fFg9R73gy4uwLIvAsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977301; c=relaxed/simple;
	bh=B47SLe4p5NQC36SS6dzpije70IscPGAIhQydwClkN10=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qX0fH1hKVC3Tv171+eEsYUWELtogwZL/0XAs9566w6ISQfC0Zu8hkaUq8gLHlf6UdUkSqxD5bcvQi2EIsNQWQBAziEugMh9i/xRCuZt48yFrEFsvP7AO5SlakuM4v/pvVtJpUsjKDbhSYAmQcevsPxvJNlq0CVAvQ09aFPbJvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6duJVvo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741977299; x=1773513299;
  h=date:from:to:cc:subject:message-id;
  bh=B47SLe4p5NQC36SS6dzpije70IscPGAIhQydwClkN10=;
  b=i6duJVvoSTDLQyy2/CsX88ltuakmvN3hqivyZq8YeIu+3uYjn8c20nNr
   T1HeTgAuui9ql5F8D0dYiqCdKA7VU0epZy3L+73k9O7suCv4wpo+w3LaS
   Kvs0ryzymOMnr4TvqcQprU2EIr2Y/KA/7ocQ9WSvF+bAQ/zVJqNfL+v/r
   nqTCr8J/ue788ugnj5MPgrUlgH2h7/gOdP+SuusU6OBaUUTf+OoirHCPF
   uMdnlnB4sEYEpBEfX8IMCiE83KM0FzgSvcIoclaIOoT2wbZUkhNpCZAUG
   9USzOsspqRtmC2Hl5c4BmX6SihWPCCyBCy7v2osfIEeansKHgAPPVl9ua
   g==;
X-CSE-ConnectionGUID: htJnL0z8StiFxZBLxHzJgg==
X-CSE-MsgGUID: aXthyyhgSu2FkcEOXEzzNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42310469"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42310469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:34:58 -0700
X-CSE-ConnectionGUID: iIOB921mTfu6WeS9JZdQMA==
X-CSE-MsgGUID: KR1Ln5JKRR2W+abhQYbJXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121869404"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 14 Mar 2025 11:34:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt9rz-000Ajk-09;
	Fri, 14 Mar 2025 18:34:55 +0000
Date: Sat, 15 Mar 2025 02:34:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a2ab25529bbcea51b5e01dded79f45aeb94f644a
Message-ID: <202503150259.ZloBHtL8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: a2ab25529bbcea51b5e01dded79f45aeb94f644a  x86/vmware: Parse MP tables for SEV-SNP enabled guests under VMware hypervisors

elapsed time: 1452m

configs tested: 18
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250314    clang-19
i386    buildonly-randconfig-002-20250314    clang-19
i386    buildonly-randconfig-003-20250314    gcc-12
i386    buildonly-randconfig-004-20250314    gcc-12
i386    buildonly-randconfig-005-20250314    gcc-12
i386    buildonly-randconfig-006-20250314    gcc-12
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250314    clang-19
x86_64  buildonly-randconfig-002-20250314    clang-19
x86_64  buildonly-randconfig-003-20250314    gcc-12
x86_64  buildonly-randconfig-004-20250314    clang-19
x86_64  buildonly-randconfig-005-20250314    gcc-12
x86_64  buildonly-randconfig-006-20250314    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

