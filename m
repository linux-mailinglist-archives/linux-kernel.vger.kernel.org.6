Return-Path: <linux-kernel+bounces-556160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C7A5C19E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8454F3AA43A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC5253F13;
	Tue, 11 Mar 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqGc63mn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D841D514E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697267; cv=none; b=MUryDGN2Pf2HC7zpUolbWmr07jyY5RQshw44ryJsbWFT0rsJQnqwUaWZzGwtIedChZqMUdGAE+bo2ABxSusmd2YjDgdSYXTpxcbnk8aMnYKbnOk2jlRB1zrk49lzGuzng/eA407cxEeNFqhOmzqtvIoge8qnX+CvksvRqJDjY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697267; c=relaxed/simple;
	bh=6kcD7D+tKa3jd+9NZ4BfVmrA80KiU0Mvj3U1zhs1YN0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PnTO1m0n/veTh5hf/ee2TEQnYLp8IN9EVq2TtdiaA2wJG8GiKhfcsPlyhv4l7/ECWvDgbMxa4nTilicNhdT4jyvWGmxtrMEMqQPJ9rP+2LNZw6nG3hPxenkJK59c0/nGu527wAAsdbueSXFwiYCIoa5f3YX7UtDrQqBYxXOzJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqGc63mn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741697265; x=1773233265;
  h=date:from:to:cc:subject:message-id;
  bh=6kcD7D+tKa3jd+9NZ4BfVmrA80KiU0Mvj3U1zhs1YN0=;
  b=hqGc63mnYFqTFHtj8ZtsmhHc+7I4U0mth1nGnsSsvb3Pqjvs6vxhTWkS
   j+gLXsBVpObY3Q21PcV5/fbBN6ANis1SCL3r3qnPcmXSTn1O7mWgjscla
   MaMFBoLoHTkDbT+sPooor17HB+DFrhb8odBThnk5ZpfIpj9OUbJgjdW3k
   4+mu4BbAHUNpLMRhxiSywAXyta2g7JjZ4aHATM4atwDUyZ4UeygufCdg1
   ScOswEipYLdQhtxsMC6UuKMHvmBz6/Lu4dH8LfyUghYOnOe/Pr+zk5CSG
   3hFJTJezX2AfTpuJ6E4UDdh0yj8qyDGfrkLNHBo2Gr8bvkbSalV8rqYWj
   g==;
X-CSE-ConnectionGUID: 1vBcGCTrQ5u1vNvbPj2THQ==
X-CSE-MsgGUID: 7dFJbZr5Sdug9qKTcyb24g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42916655"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42916655"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:47:44 -0700
X-CSE-ConnectionGUID: EqHzGnUYRyGkQ0or5Tj3uQ==
X-CSE-MsgGUID: m3JSWOldTvWt0F3MDqrLXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="151260863"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 11 Mar 2025 05:47:44 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trz1H-0006f6-1n;
	Tue, 11 Mar 2025 12:47:40 +0000
Date: Tue, 11 Mar 2025 20:47:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 4f10ec03fe1ed12479134be33ddf006382744651
Message-ID: <202503112016.XuNcNG7F-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 4f10ec03fe1ed12479134be33ddf006382744651  x86/mm/ident_map: Fix theoretical virtual address overflow to zero

elapsed time: 990m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250311    gcc-12
i386    buildonly-randconfig-002-20250311    clang-19
i386    buildonly-randconfig-003-20250311    clang-19
i386    buildonly-randconfig-004-20250311    clang-19
i386    buildonly-randconfig-005-20250311    clang-19
i386    buildonly-randconfig-006-20250311    gcc-11
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250311    gcc-12
x86_64  buildonly-randconfig-002-20250311    gcc-12
x86_64  buildonly-randconfig-003-20250311    clang-19
x86_64  buildonly-randconfig-004-20250311    clang-19
x86_64  buildonly-randconfig-005-20250311    gcc-12
x86_64  buildonly-randconfig-006-20250311    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

