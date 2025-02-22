Return-Path: <linux-kernel+bounces-527381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD33CA40A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CB717644E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7B200100;
	Sat, 22 Feb 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrZEDcg0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825DEEDE
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243826; cv=none; b=h8uQ83Ka6hDwkusqIVm3DynCdcoHcrFnCdw7wWhhuYKCaAn3BvcUYDb/Y6BOlXFBbCfBY5mVa0iiwRrScF9N+sKtZCBX79+iZcZI34JL3fHbQ+gypBmk0YAYLvirpnn6ubdWBAKUC8A1/BJl78QP6bD9j64PEAsoYaE6M2CXaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243826; c=relaxed/simple;
	bh=zfCHYYaE2Fz/0ILigTgxe/mFTTlV6HLBul6Hhx6fWEM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uykj6m5tQrPTwAvYPra1idbNz4lpWnMpnOPyWNRlRNEQHCj0SXH3AIo+moqDv3L3fK2Ji7zf4xb0gJIgU49oNPcbSegFa3Alr1X9Vp07wAZwPPv6zP4nzE9OQSysHZkYwpzwwHDaDBIeTZm/jKZjCn+KjSwRSVjZZqRTLv7Lxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrZEDcg0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740243824; x=1771779824;
  h=date:from:to:cc:subject:message-id;
  bh=zfCHYYaE2Fz/0ILigTgxe/mFTTlV6HLBul6Hhx6fWEM=;
  b=HrZEDcg0ZlRj7s2He7QZm5l/2DbZmsjKZfzXE0/I+jU76QRFTqhItLRP
   CgW0yypFog7NQs4SksSqv7pGzzryznjmYXeCgYcPvcx4NHXHELnXyXlid
   7oyBvqlLbvoCICLyvVjHQ0u4Jm31+Ita98taipoDhRLu03p87/N7vnFzi
   nZxRMk0AGZXEC45c37P2+sQlH1KT2KXW8+SXk615lzdoNjcw0QGDvSOBD
   Fdk8QUsgFepMwaGTrDlsBsW1v+6T7XUBmS4qrSzlX9k5eoX2D5ZNcmn3O
   W34y5p3X2bezohIhUkThHBY9xe6v8b6IzlWHUYBJHRWkhZEIO0HBzRkHK
   g==;
X-CSE-ConnectionGUID: XyVUD63ySImBda9Fkyensw==
X-CSE-MsgGUID: a9ZujjARQ9aIVdNkQcCS2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44825308"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="44825308"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 09:03:44 -0800
X-CSE-ConnectionGUID: OETjQ/dTQYmvsYHYpNRLeg==
X-CSE-MsgGUID: 0kQn9kQzR5GK2fK1KKX84A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="116281264"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 Feb 2025 09:03:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlsuj-0006jv-0I;
	Sat, 22 Feb 2025 17:03:41 +0000
Date: Sun, 23 Feb 2025 01:02:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 000894d8fc0d787b52a46339f297e20c024a6ca5
Message-ID: <202502230150.IMGPhR43-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 000894d8fc0d787b52a46339f297e20c024a6ca5  x86/platform/olpc-xo1-sci: Don't include <linux/pm_wakeup.h> directly

elapsed time: 1442m

configs tested: 14
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
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250222    clang-19
x86_64  buildonly-randconfig-002-20250222    gcc-12
x86_64  buildonly-randconfig-003-20250222    gcc-12
x86_64  buildonly-randconfig-004-20250222    clang-19
x86_64  buildonly-randconfig-005-20250222    clang-19
x86_64  buildonly-randconfig-006-20250222    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

