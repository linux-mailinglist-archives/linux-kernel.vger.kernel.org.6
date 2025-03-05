Return-Path: <linux-kernel+bounces-545839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEECEA4F24C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD89E3A85C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB3F4ED;
	Wed,  5 Mar 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpjiRK6a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430211078F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133935; cv=none; b=g3UrV5X0uXwdnogRNYocMkbgEcePGOKEbc5c/K/+IMdzhp0qt2WXlbPx2Ls4lzu4uuq1bZDt0gY1K3dWU0C+98VBk5q7DYK7mxdY63HZx1Y8wFOtMDpG6xDbMpKVg5KEUd+Y3UmMmKUbQQevFpKZTm0GwpBRvz9IvOdsCl0IMBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133935; c=relaxed/simple;
	bh=phhBcgYZ6Wa5Ew8fl7nA64kfa6V3GPXYg9e0b02aaP0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kQB3hpECpczX9Smi+vDik1Zeoer33wGX0bFOTvq4nFvYcxuqZPuBDjIkseIkgmqYmq7/gesvryISzwYk4ygBucG1q2/6KgE1RDpPCsF9DShypC4AFEXxXpBr5gpaHIMnObyLeJIm0d6o/YLQLrYfq0OEhaaJkxbR7Rn0jR+Wadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpjiRK6a; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741133934; x=1772669934;
  h=date:from:to:cc:subject:message-id;
  bh=phhBcgYZ6Wa5Ew8fl7nA64kfa6V3GPXYg9e0b02aaP0=;
  b=IpjiRK6aqYNroB0YEmRLy6E43mAHNdrQ8kGy7v03GLgJLunDE2lXvZFq
   C/KS1uhZtuiwUNQ5qwf76KfWesCC23m/Wyut0RKVSqKZGM+Pd/LDLfIp+
   q3R2VStE1yQNkla2ya2oiX5DcIOdR4R8077e70m1+Bm47ajHqdhH1zICN
   tjZE7qcl+0aG/0icPMdo1u156/DYQ4HjpE2NFIKR1qmy/gaGJlp1W82sS
   IsFNDaMQrq/y/b5lmiYl/g8FGYzXMk60LkzZyDOi1kSA42CwtTAPW9+QF
   Q9tvubnwSkKYS6g4q0CQAw5XUR1668KGbxmjpiPtJVGFJF2Ir530vd3JS
   g==;
X-CSE-ConnectionGUID: Y3+PV6SAQDSX5vN+PwU8Pw==
X-CSE-MsgGUID: FJj9HZjeQO+jLXLXi1l+uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="44886062"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="44886062"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 16:18:53 -0800
X-CSE-ConnectionGUID: kKt2Inq9Q+2E9RmBwVJ5uA==
X-CSE-MsgGUID: fRO2sXotQfiX1Ak/vh2xcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118431936"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 04 Mar 2025 16:18:52 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpcTK-000KP8-01;
	Wed, 05 Mar 2025 00:18:50 +0000
Date: Wed, 05 Mar 2025 08:18:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 f6bdaab79ee4228a143ee1b4cb80416d6ffc0c63
Message-ID: <202503050819.8Odm6yzN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: f6bdaab79ee4228a143ee1b4cb80416d6ffc0c63  x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63

elapsed time: 840m

configs tested: 19
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250304    clang-19
i386    buildonly-randconfig-002-20250304    clang-19
i386    buildonly-randconfig-003-20250304    gcc-12
i386    buildonly-randconfig-004-20250304    gcc-11
i386    buildonly-randconfig-005-20250304    gcc-11
i386    buildonly-randconfig-006-20250304    gcc-12
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250304    clang-19
x86_64  buildonly-randconfig-002-20250304    gcc-12
x86_64  buildonly-randconfig-003-20250304    gcc-12
x86_64  buildonly-randconfig-004-20250304    gcc-12
x86_64  buildonly-randconfig-005-20250304    gcc-12
x86_64  buildonly-randconfig-006-20250304    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

