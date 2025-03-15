Return-Path: <linux-kernel+bounces-562536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E9A62AED
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD002178A05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF22629F;
	Sat, 15 Mar 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2A+r5ec"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A21F5420
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034620; cv=none; b=c/1thSsI9max6ScncGnLhWTKcd8l8y5stVRSn7ACaykBo8efZmnGrQiQGQPTnUtf1o9E3I2sAB6hBBK/iVMQf5OBeVmHPBDSoEgRqWy4wqfArkYocX5EZw98T07ufg+iy6uZOpwD8AZbOin9wE1aS/VfySCQPl+AutoufN+2q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034620; c=relaxed/simple;
	bh=AS5DGfZQc+/rQQqIwJXY4GCb3aw85Ld05fWMIbC/8ao=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cL3PUttUT8hzJjx5povbTvvIom/Jf2ZuyfwkmoDu1Sqo+I7snrJnB1RQwn4fUbbqhVfWGi/I4sCF5dDdFOf5oq40Fe44scR9aDfaSZGOaVV4Bf/giUSkBGVDIO3tDLR8hxsBP9mP+x8JcBSLnUTqcg6npRoMpeliIDFeMzckFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2A+r5ec; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742034619; x=1773570619;
  h=date:from:to:cc:subject:message-id;
  bh=AS5DGfZQc+/rQQqIwJXY4GCb3aw85Ld05fWMIbC/8ao=;
  b=c2A+r5ecN4fwboXRx6Cnb3DPefoZ1n8YZkdHgVpzumtXXT5N91r0THdi
   gmhaHdG89ddVV9d44SGP9eaI85xikTDUGoYXdOMGIepzlWpjH3be47MAq
   v82VAFVIYT2CN+SAyvitUNjk/XKH4lmWQ9blv7fgrI47ETm0n2QO4Nj16
   I+VhocXtrzjCBHTi/wejqylb1jIDH6i/iQQJqOoFnNjT5VXOzTfXAmqpn
   Y5DiwKTdeNrVUfTgSx2J/b19EAxxOhmy28ySNmEuyOLEfGfm8+8B9TS56
   21i4MEup2CEFw/rgb+KG45U92WKX+rw9fnOIwKnaW0bKk8Xas43//fyXl
   g==;
X-CSE-ConnectionGUID: Z8eH3cQESBap3raYxmCgAQ==
X-CSE-MsgGUID: AYj0MAs3TuOq+Xde5R3Z4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43392197"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="43392197"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 03:30:17 -0700
X-CSE-ConnectionGUID: vIFR9xpnTdmQJ1QJp9X99Q==
X-CSE-MsgGUID: kasP1rUtQO+jVnFbdZjWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="126555037"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 15 Mar 2025 03:30:17 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttOmU-000BFm-1D;
	Sat, 15 Mar 2025 10:30:14 +0000
Date: Sat, 15 Mar 2025 18:29:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 b25eb5f5e419b81f124d5ba2abaaacf1948fb97e
Message-ID: <202503151828.xOMbCknv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: b25eb5f5e419b81f124d5ba2abaaacf1948fb97e  x86/kexec: Add relocate_kernel() debugging support: Load a GDT

elapsed time: 1445m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
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

