Return-Path: <linux-kernel+bounces-527283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19268A4092E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620B019C0AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE71624CC;
	Sat, 22 Feb 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHcIlmNL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70C27453
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235308; cv=none; b=DFlyABFdepyNdSISs0xGJOvcef+bokeYShZcfJi3qWGmNPLC3KsqNEOm/gezWDMn9Ppd0BSPQt71yq+iYNNl27FTh0MNRmX+0Jkcnx15FIMhs5tzCtdG7AHveRr0ZYsjtFJjY5WwRqoaRjrdB9YhgTziW7D8RgjoOLy9gL1UIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235308; c=relaxed/simple;
	bh=As/eZJ6s9+cJd8f9+sfyUoCTHTcKLX0Xz7bfhxzSwjc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dDfKpueOrPw9r6cSfD4MRKlYry/2pQUZJxtzt0Y3dsG0DdlTLW4ZK1uWgZLvhi1qv5l7TnE+Fq4parFIb3x52bIMYsGOtgUSqboOpP8CdMIf9n755WlypocuzIC9+/we9F5zesZ8LxdY53EokNFui+XIQ/cR2V602O/Npa8lpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHcIlmNL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740235307; x=1771771307;
  h=date:from:to:cc:subject:message-id;
  bh=As/eZJ6s9+cJd8f9+sfyUoCTHTcKLX0Xz7bfhxzSwjc=;
  b=IHcIlmNLwT4iBuJqxI5U+SHqWc+yxgJUoCTK8K1JffNCQYKjWS5yMrBz
   jOBgl9sqd6EaTVBTL8144UbS5n5h/+69fmQrkbCFUqMJ5FTXlfPk7Ajoy
   faK6A2V1eB8SzpS3qAlokOVTYA1SWhF2JDnrTA/nbd5bba6Ylj0e9ZDeo
   +q6vuUO3DFnTZ7aX6toNuVk6ODtvvW+gUv8KV8AZA9eWxQrxAkhO2eoTO
   KesVhy3w8qoL2b8zgN2mevrkZjpQkUtdQflZwCjR39V4gNnIyAd+2SgtT
   pXH1D79ep4s8Q64wiUmKoztWWCrjgjzFn7+x8m6H0ILdWpGrMXoGY8VJg
   A==;
X-CSE-ConnectionGUID: Ag5xttSzTDKZMTODAPqVDQ==
X-CSE-MsgGUID: 2TQHGQdRQyS9Njte4KzWIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="40889274"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="40889274"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 06:41:46 -0800
X-CSE-ConnectionGUID: Xfmf5wBPQL2hsaeOxD3zkg==
X-CSE-MsgGUID: h/0AcusEQ/WUcwiOTHf8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116121255"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 22 Feb 2025 06:41:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlqhI-0006ed-1x;
	Sat, 22 Feb 2025 14:41:41 +0000
Date: Sat, 22 Feb 2025 22:41:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 1937e18cc3cf27e2b3ef70e8c161437051ab7608
Message-ID: <202502222233.wzgXnGhN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 1937e18cc3cf27e2b3ef70e8c161437051ab7608  x86/fpu: Fix guest FPU state buffer allocation size

elapsed time: 1446m

configs tested: 15
configs skipped: 167

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-12
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

