Return-Path: <linux-kernel+bounces-215838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CDE9097B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10B028454C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AD376E1;
	Sat, 15 Jun 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TK+esgJ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D42110E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448507; cv=none; b=JrhXWarf2viZVrKYUx2xKjNpQPY/Bh3Jg9yXEHY5T44TTs8qc1u14ROvF4e4xEexwFfaNOgd1fzPTVIs29uIKG+WeRPwyVezvrREuBb2SzXOe0CfgDWq1ND79EgF6fAyrD9vOUKTe1FBDjbDU0VIz+Pxb+qRfnlK/q6e8E2TGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448507; c=relaxed/simple;
	bh=drd6bg/9BTTXzHHKoRFBlXZWf+bz91UOVD5CEUftSAY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r7Lk37uIZO4yODNFCXbNkHwervbKSB/1Z1DMyAX0AlEhMsFz1KMzYQiUbfHO3qo0j/ZtE7kLp82Vv+lmVcsEnXUv+BpAyLoV9ANK09aM8uIGwwozsy2C8Ir3gaYKCmsaGPBWd1QFqArYJjtFYyMu1O3bVR9h+fllL30O4IeZq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TK+esgJ2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718448505; x=1749984505;
  h=date:from:to:cc:subject:message-id;
  bh=drd6bg/9BTTXzHHKoRFBlXZWf+bz91UOVD5CEUftSAY=;
  b=TK+esgJ2Mor007jh67tLKCG0rcR+BH5Fv0Y4d8AcT2TpfOro6G7eZKgj
   jagBTBHpLHzFJ+Dr07XGzI87LcMzFOEp2oA9Lj07TLElCyhqFj9CTgxJQ
   nxbxya2IRn0hQo3OCjCo6DSGMCSHpqk9RzrnMVlHWzILISakH/THg40+y
   TKLc+v6W917T9OvubGYU5uUzBu33OnKE7EhWXp9wCnYON0eW3/KuDINc5
   hXAnCqDuGA7M+Nuv8C8tsBmURASw64fr+LvxgKktBNbIKM41cTk1xxzq3
   qOfFyFrKfO1moqBjEr3bUnou4gzMVB6HPfBepS5gNFYS40YHdamvyXUJF
   A==;
X-CSE-ConnectionGUID: 9vTRrSnuS4G6iVIXLdsj0g==
X-CSE-MsgGUID: i8tct4qySRSxzEGCl4ftYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="37862851"
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="37862851"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 03:48:24 -0700
X-CSE-ConnectionGUID: Azt9hhBuTE+wyoLZhPWmEQ==
X-CSE-MsgGUID: D8sWGJP1SXWT91m+eRvfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="45699768"
Received: from lkp-server01.sh.intel.com (HELO 0bcb674f05cd) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Jun 2024 03:48:24 -0700
Received: from kbuild by 0bcb674f05cd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIQxJ-00005g-1w;
	Sat, 15 Jun 2024 10:48:21 +0000
Date: Sat, 15 Jun 2024 18:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 501bd734f933f4eb5c080b87936e9d43f471d723
Message-ID: <202406151809.ImE7G7tq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 501bd734f933f4eb5c080b87936e9d43f471d723  x86/CPU/AMD: Always inline amd_clear_divider()

elapsed time: 2732m

configs tested: 25
configs skipped: 169

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386         buildonly-randconfig-001-20240614   clang-18
i386         buildonly-randconfig-002-20240614   clang-18
i386         buildonly-randconfig-003-20240614   gcc-12
i386         buildonly-randconfig-004-20240614   gcc-8
i386         buildonly-randconfig-005-20240614   gcc-13
i386         buildonly-randconfig-006-20240614   gcc-10
i386                                defconfig   clang-18
i386                  randconfig-001-20240614   gcc-13
i386                  randconfig-002-20240614   gcc-8
i386                  randconfig-003-20240614   gcc-13
i386                  randconfig-004-20240614   clang-18
i386                  randconfig-005-20240614   gcc-13
i386                  randconfig-006-20240614   gcc-10
i386                  randconfig-011-20240614   gcc-13
i386                  randconfig-012-20240614   clang-18
i386                  randconfig-013-20240614   gcc-13
i386                  randconfig-014-20240614   gcc-13
i386                  randconfig-015-20240614   clang-18
i386                  randconfig-016-20240614   clang-18
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

