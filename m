Return-Path: <linux-kernel+bounces-357862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19618997716
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2391C20C42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12D191473;
	Wed,  9 Oct 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLX3mtzO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921A17C22F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507509; cv=none; b=uJx4LUt+w3bmW295H13Nd4JGn59OywkbIf1KwHSgX6YFIbaYxkjhQrw1dhc9vNpfhas9xvFBWfbGETNMpPHd01JpgfHJ3PV0uuzlmCIsxB6OBZ4djMBvkncC6jbi6ar9cTtjnDlDJ89lgZsAQl5xkOrIVcYK7Ht97nXEtNz5LNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507509; c=relaxed/simple;
	bh=wFdDor0k0PKZpuilD/lcZK9jvH29CCzgUDiFRek3xbU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=amSEW6tW5pLmdo28yMgaATQGoiLFq0JUJ435Y+P2dW/pfKGjjQy+JB0mDAiEL0M8qt2U+DBWJ1zbTcE6PnwRwC+Rarc2uv8dDTpnCIGKSeZasH0ptsbeOSkTfJPZzhhWTSB5fHQAjgonaOdZe4yOPA3qlVYYVwRNvujVPpqIpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLX3mtzO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728507507; x=1760043507;
  h=date:from:to:cc:subject:message-id;
  bh=wFdDor0k0PKZpuilD/lcZK9jvH29CCzgUDiFRek3xbU=;
  b=aLX3mtzOZ0cmjq7qlxrQ1kZ+SlE9VXSiTPrIdDxuulbAD1zFTG3SSdPi
   ViWE5Yeu7yIAfUenuR/UkiJ8J3uaurlx1lHt83f47+PN5/IL8m2FhVV4S
   lpS58NrtsSAgjFIu2u0W19KOMXsUgHZD+toCdX9vMOKft84D5SXyKwiNP
   IYcE+vW/tGEjiclM2IDbaj7bXpTfenq3/ITIHfklqXRUfH3bWxW/xPkxh
   pvvQ31GqZfcPSPDC0ohLYF3YlqOe651Kya9sZ77guZJ5SJLGNa0Nhx5KV
   RXPGe80kda13aWBYjgX1HA1GBdUoGrAfFrRWaH2TOUhvU2tj7BF7nV0fO
   g==;
X-CSE-ConnectionGUID: KWALlrEeQBaBXNgPvb48ig==
X-CSE-MsgGUID: AZnyvp0VQ4ecF7doLd5GyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27282164"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27282164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 13:58:21 -0700
X-CSE-ConnectionGUID: zVLcxHRUTyOs0blDHcSacA==
X-CSE-MsgGUID: n2FmCR5XQGC4/r+jPH8sEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="107224618"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Oct 2024 13:58:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sydlC-0009nA-0L;
	Wed, 09 Oct 2024 20:58:18 +0000
Date: Thu, 10 Oct 2024 04:57:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e4d2102018542e3ae5e297bc6e229303abff8a0f
Message-ID: <202410100432.3uGmUL5N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e4d2102018542e3ae5e297bc6e229303abff8a0f  x86/bugs: Use code segment selector for VERW operand

elapsed time: 768m

configs tested: 58
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
hexagon          allnoconfig    gcc-14.1.0
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um               allnoconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64         rhel-8.3-rust    clang-18
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

