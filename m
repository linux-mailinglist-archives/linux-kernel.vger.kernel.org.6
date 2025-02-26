Return-Path: <linux-kernel+bounces-535082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B27A46EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6723AE13A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9E224B1A;
	Wed, 26 Feb 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIvIz2Uj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC7191F84
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609188; cv=none; b=s8SZsDiGdnS8dIoCDfJFlB3NK+7FvNgHLB766cnT+CxpqUjuDHZcyaZ8IEEMdIsxA6neOXje3Z0NFWFceB2KVxzZxVWm07xsfgJ4Q/dPF9BJrf8f0wlPsC5dAkGTIT+xFR+UXOIiB1sVsDApJS07VmTeRYglO0PG5qAQ/tVSN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609188; c=relaxed/simple;
	bh=EcXax8tBuz8+ORjYsrYW+71DUULiVhyUJzgFX4d9nZc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jZdH30ThYM/wcXzgaSoF47WNUeXoqEhzIo11TOM1c64tFr9UI1VEqxYY8I6XET/ggDgzIM47fVUmKBUCA/fYb/8Vs/ZBc3CKWFWN/2Eh3uCT8KtrkpvB7hYj0GSKJCmnJvPvQE8eSz9qKY1Ow7Frvk61VCyfXPqvC+/Edh0MTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIvIz2Uj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740609187; x=1772145187;
  h=date:from:to:cc:subject:message-id;
  bh=EcXax8tBuz8+ORjYsrYW+71DUULiVhyUJzgFX4d9nZc=;
  b=aIvIz2UjXtOSiKvFHgZJg5Z8GJAeJYu5yjHyved/CCFm3wzK+tGDq3Yo
   1De6W6Tj7IL0PhE/lJTDWwGcCo3XL8vr8OL6DohZb9Jm3SLTMV/Mryztr
   Q+sx/Wzw+TQq3iTaBioroLc1HfS/IW0jb1XTrGXNQ1BEC7jl7uwdb6g5Z
   Ssn4clXURRIIwAuxEX7/JZuyuraw8/R9wYbU2xO9uZP5e7NomWyPTjV1S
   MUqrOXGFPxinWz1b2nDJZyoqP0vUYNwwdYlLX+gbz85saUwAr3JQB/qLc
   p1fDqmuOl6rnvMBSo+4W4lAm+Sv/AJ74LRSeNLN0GQtRnBDdN/gbqV0Hs
   Q==;
X-CSE-ConnectionGUID: /+Kneg+0SZiJ4osX4jkm+w==
X-CSE-MsgGUID: Vk0RBZ6iQQuIfp/yiOeMzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52877151"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="52877151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:33:06 -0800
X-CSE-ConnectionGUID: qm9WdDXQTdiLM22ymu9uUw==
X-CSE-MsgGUID: 8ZLy5mu0Tj6+2WS85jpE0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116705940"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 14:33:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnPxe-000CYQ-33;
	Wed, 26 Feb 2025 22:33:02 +0000
Date: Thu, 27 Feb 2025 06:32:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0f6750b15ffdf274668b12824b09bd49ea854e18
Message-ID: <202502270607.MVfRTBSu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0f6750b15ffdf274668b12824b09bd49ea854e18  x86/entry: Fix kernel-doc warning

elapsed time: 1447m

configs tested: 14
configs skipped: 142

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250226    gcc-12
i386    buildonly-randconfig-002-20250226    gcc-12
i386    buildonly-randconfig-003-20250226    gcc-12
i386    buildonly-randconfig-004-20250226    clang-19
i386    buildonly-randconfig-005-20250226    gcc-12
i386    buildonly-randconfig-006-20250226    gcc-12
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250226    clang-19
x86_64  buildonly-randconfig-002-20250226    clang-19
x86_64  buildonly-randconfig-003-20250226    gcc-12
x86_64  buildonly-randconfig-004-20250226    clang-19
x86_64  buildonly-randconfig-005-20250226    gcc-12
x86_64  buildonly-randconfig-006-20250226    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

