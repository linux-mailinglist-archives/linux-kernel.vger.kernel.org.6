Return-Path: <linux-kernel+bounces-236243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A891DF4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BE91F22A08
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8014B960;
	Mon,  1 Jul 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOIG8O9E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73641E488
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837049; cv=none; b=YB8jg/8FW/jwEI9Q6lmksvt1hnsEpnhNDAuKJobbmgplIPue0mao7WORj02kWDB/8qjQWw4xIXqASG6CbuzrMzmCuhMVU3Ew0Vi70MgHyshP30HUJy5VOFdXWgaEObUukjfNTDRhBFcmEikLrPFMI7lHHJ0SasQCKtvJIh0n8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837049; c=relaxed/simple;
	bh=uf4LPflSQFqov0T2c3ATtdR3QL0RXgFpEx87xVbdtx0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HUAEuFC5uwI8i2U7SPRBfgOIshV/GLeJOB565AJLa6nuQl+I0ZrTRfU9Jn0EhutvlFW0eqmjdqZHwCRlIbib1JGPgCM9gyqBgqAwNbXqOSDAVcp5hwxeQPZ4MfUEzFAh77VLRQOU0clElrsosv7Nv7Ka8GZSaxmmYrFDfEI+A4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOIG8O9E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719837047; x=1751373047;
  h=date:from:to:cc:subject:message-id;
  bh=uf4LPflSQFqov0T2c3ATtdR3QL0RXgFpEx87xVbdtx0=;
  b=MOIG8O9EOY4hFIGCeVEW9skpV5E+XB0Iw02DXWwFSJXaqc57gPHU6L58
   sQndBLCOJnH2CNIRtbW4rUha8wvawxWUlph9Uh/OUDmWI26R8pu5w2Uip
   fIEnldIOfG6uNfKOyQNMeJlh7gzl65Da6H7KW0m6g/ct0oDGLgfqvUEFA
   vLGCfckAxUEpKdOaBirMqmh5BoqIjXOq/DuG3LYeA4/2aJItC6hq6Fqdj
   OrMofWvfbHZFRZcR8bCXbaCcCWsT+lQZB3z870ECSSXQfiO/pPQ49UK/e
   i642s2sDjnOsmDI2HMWR3699Z6p8FqbY3MexvbmPsNVfEmb7bzaW+vs3l
   A==;
X-CSE-ConnectionGUID: hUytaypNSgOr9jOAODQhcQ==
X-CSE-MsgGUID: k9OUAJy2QT+zcUu5xRc2NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16831829"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="16831829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 05:30:46 -0700
X-CSE-ConnectionGUID: cs4tOshMQN+klTNIvVoiKA==
X-CSE-MsgGUID: IcsDpkzJR1y7yUCQqQHOUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50107322"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jul 2024 05:30:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOGB9-000Mp9-10;
	Mon, 01 Jul 2024 12:30:43 +0000
Date: Mon, 01 Jul 2024 20:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240611-CbC] BUILD SUCCESS
 a99909e5c524ca24c2143f1e89020b40e1ff33cd
Message-ID: <202407012054.la94HnMs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240611-CbC
branch HEAD: a99909e5c524ca24c2143f1e89020b40e1ff33cd  wifi: radiotap: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 9736m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                             mxs_defconfig   clang-19
arm                         s5pv210_defconfig   gcc-13.2.0
arm                           sama7_defconfig   clang-19
arm                           spitz_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                          malta_defconfig   gcc-13.2.0
openrisc                         alldefconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                     taishan_defconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allyesconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                  audio_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

