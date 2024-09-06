Return-Path: <linux-kernel+bounces-319351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6DC96FB7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D83728BBB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDB13C3F2;
	Fri,  6 Sep 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kalo2BiR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC851B85C8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648593; cv=none; b=bw3U9S510+oNd4PQW0UqY1tIAO6czOkihaDgr5u/ZrhJAUOKADoKJ7AXHMcoZ7GHEXzuhiKKTu28XDZyXcw5NPtHf7HdVeHgibWjafo3R9UhSsJVS6W4NPBMWmLMzeLMjCY9S/f8n05s29E4fwMK1lPES1LPiABhw9LmDYOjNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648593; c=relaxed/simple;
	bh=+ldZjsubTT77pCXz1rvlbaJGaIGElNZK2hdUTORjo2g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pDpr5CQ2RncRP6Xe6q6U42XDAgNct6HiZyA+wKWAU6pKQTsetpn/82OreNp4sjzH92nPKNdjDAdsN7LANY/yJXNAEZND5/SksMU4B+z4EL7DjFcOMmKzPhHk5qaVmeyPd3QpIewHkcsjbHwwxnEQ6/wpTRtcbntrrfMBT6wdRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kalo2BiR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725648592; x=1757184592;
  h=date:from:to:cc:subject:message-id;
  bh=+ldZjsubTT77pCXz1rvlbaJGaIGElNZK2hdUTORjo2g=;
  b=Kalo2BiRj+rI73q+8Tc5MvL9hyGJxoEnwmi8PLY9nFv7qtZrsbZHFTf3
   0cShv8UOoG6xUN4fTiw1xS+h6TaWPvNpFCSsdf4157POgXn2U/wu69wrX
   6sDheKXGyYEB0TJnuvCP3E4s7DlVR3lbOdm1FvQuZ8laN0DTRYWSv/7/M
   YELJkLxbqzJonnv0lUpJEKNtmGloHhfSrAEtZQhhhkjUXQ26EYwJvmChD
   PKkOVss95WJTw49rmDJUbu/+3Znywwqvvw2oEEjh9zdHrBx9qxeFZy1DV
   /kw3GdVAev4nTOLD7FaTZaHS9ekx6FASx8PIWCa+KtI4OO4KTltoWIBtu
   A==;
X-CSE-ConnectionGUID: MGCT4hh3SdeH8En2Qpr5NQ==
X-CSE-MsgGUID: wuoyWCRbSKC2NWtXNTxElA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="28301627"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="28301627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 11:49:51 -0700
X-CSE-ConnectionGUID: tVgo0uSnRDySq35hSAQvEQ==
X-CSE-MsgGUID: x24tRgzITzGDKIH9GB1+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70618101"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Sep 2024 11:49:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sme1k-000Bbj-1R;
	Fri, 06 Sep 2024 18:49:48 +0000
Date: Sat, 07 Sep 2024 02:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 c8ddc99eeba5f00b65efeae920eec3990bfc34ca
Message-ID: <202409070235.zEty4IaF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git x86/sgx
branch HEAD: c8ddc99eeba5f00b65efeae920eec3990bfc34ca  x86/sgx: Log information when a node lacks an EPC section

elapsed time: 1020m

configs tested: 50
configs skipped: 205

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
arc                               allnoconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm64                             allnoconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
hexagon                           allnoconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240906   gcc-12
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240906   gcc-12
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240906   gcc-12
i386         buildonly-randconfig-006-20240906   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240906   gcc-12
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240906   gcc-12
i386                  randconfig-005-20240906   gcc-12
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240906   gcc-12
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                         allnoconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                              defconfig   gcc-12
riscv                               defconfig   gcc-12
s390                                defconfig   gcc-12
sh                                allnoconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc64                             defconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

