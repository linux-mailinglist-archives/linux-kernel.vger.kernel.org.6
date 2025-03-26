Return-Path: <linux-kernel+bounces-576617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B163A711EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777FE177227
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678181A3148;
	Wed, 26 Mar 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQGv8rfD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF591A83E5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976063; cv=none; b=uFYDbVTNL4vsdfSujsCuywPwYVmL9wrC06MTlDm1K4Y0GOfL16rKH6Rh7Id34YoPW/QZSmQAJZJXvSaUZ6eXlLAqHTueqwbpcWCiXGMpwQpogz59upW1Ty260FJSuvqlHVomGh8v56LrxJ1KPPiuROTEmlOwJ/zUAn7jC9Rebhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976063; c=relaxed/simple;
	bh=wOp0+B17YhIX+n8/6NTfeBJbPFlcrvqdnA/gfiljdRM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=le8EFg9r0XKvcjKN48X54yL48ovHaWdFKk62fD8NaWZ1ZkniDMtegxJ0ws2qCOdReUoH7Yz4uNPFyVDrRcYPWfMgWiYrhix+wQyaRLMQk1KhuDTGtdCnta3tgU0lvqd0bFa/hu3J+pu5LOiUHVT08cj5sQIYiB8GYHSa3cWSn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQGv8rfD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742976062; x=1774512062;
  h=date:from:to:cc:subject:message-id;
  bh=wOp0+B17YhIX+n8/6NTfeBJbPFlcrvqdnA/gfiljdRM=;
  b=MQGv8rfDGmUK9DgrwKDOoxJYc5KusF14TYFaPhRH4F1VrGPdhSOZmzct
   A86HTbERjGY/pkExQ4PoI0T7HBgBWwEmMbncEcyq9ukZ888r0I3Vadkos
   bmnO5fgSJC96XvJWinsyrDNNV8KFNJZeeX7wTy8/9a0E+BNkw5y1GKH48
   QloOk4GzqQgcVCC2sgaoKrqNC4NAQFOM1Z3LhRjETu/FLwQFXI/bOsGmg
   FY5YAr5wRduZJfSvos5iSZSL6DuhG+XN6K47+vVBzmSO6/s8mZMT9K9fR
   23/LUDoCFVEsInmYml/hceUak+mZDzEoMwaEx6ZsUwlRXlX5QDIwMfQoJ
   g==;
X-CSE-ConnectionGUID: 92fgKmHCQ5SLjmlDYgd+Bg==
X-CSE-MsgGUID: ddXacG6vQ3a8Ro7Xsqd6qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="31852128"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="31852128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:01:02 -0700
X-CSE-ConnectionGUID: GSLxCutaSfiJ0ysfDc2Org==
X-CSE-MsgGUID: tBm9tMrhQImWt557rY0jcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="147866268"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2025 01:01:01 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txLh5-0005ZP-07;
	Wed, 26 Mar 2025 08:00:59 +0000
Date: Wed, 26 Mar 2025 16:00:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/kconfig] BUILD SUCCESS
 ad9b861824ac55d81431815fffaaff5e981badc1
Message-ID: <202503261624.2HlsitUk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kconfig
branch HEAD: ad9b861824ac55d81431815fffaaff5e981badc1  x86/kbuild/64: Restrict clang versions that can use '-march=native'

elapsed time: 1447m

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

