Return-Path: <linux-kernel+bounces-544788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C5A4E53B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAD517D281
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22EC27701F;
	Tue,  4 Mar 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2hjJ/RL"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CDF2780E7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103243; cv=pass; b=uXA+D5WAL8mT0h0qJTE6GMWuS3dNlT+q7QQMpX5fiQ2qaYRiEI+pbPWlrAq3v+rL1USbX5d/Zd4Npk4eqX9BkUaULkKgSmw8B9G1fgeyEzeuG5UYMFeca7DaDp51RndNze0a+rPqYY6zL5VZzUof7mL5p+seUShQymAyYQ9BCok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103243; c=relaxed/simple;
	bh=w0bJs8KOArtC3mlGh7g05Lul3RISIZPHi8LDf6r63II=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KMAHWpn0ovIdhweancGQCS+0WVzh1tozsGRgA6wQqTelGgeoFtY/fcbAgbb4pT/dvbeEUKwsMxFNCS6YwPqSGo0c3Ye6SJ7PItVOsaXz1ertqCgQrYrLMNft0z5TCEqOsdh9Roug2BUgUukJTxi3ReyUuly4T5sSJMBxv4G/5o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2hjJ/RL; arc=none smtp.client-ip=192.198.163.19; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9A81640CF4D3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:47:19 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C2hjJ/RL
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g5D0fFZzG0tR
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:46:08 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B1F0C4274F; Tue,  4 Mar 2025 18:46:04 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2hjJ/RL
X-Envelope-From: <linux-kernel+bounces-541508-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2hjJ/RL
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 9172C42AEE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:16:25 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 279DB2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:16:24 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501C93BB066
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA251F8BD6;
	Mon,  3 Mar 2025 11:07:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6A1F869F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000072; cv=none; b=quA+9fmebUf2h15Pe4A4F1w7ARIbTwEs3XzcuEeAbAQOumrmqM5m8b92S1QfTM9T/sKNNEA6TVEFf+FIIZhUCqLDCSh3ufhdJ9C3unF78cMXVZegU0XJ/Z39t6aQgTkl2CXhNcmWBTfefGMkK84fA9cQGvy1vlPURHwvqNda9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000072; c=relaxed/simple;
	bh=w0bJs8KOArtC3mlGh7g05Lul3RISIZPHi8LDf6r63II=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gouvFhgbWPnP5Wbospbyz4ggg8NMbj4B18aqecY1spxZOqw1YQSj9GWLPGzElveYxW9HQ6Nok+h7qzfJlr8qR/iKD/RnNbKKlTLLgjYTln3nI7KtsVfw52eNjOIt/VR0dBIYfMkc1RB/jaMano0sLInv0rhzUq0RTISakHiKQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2hjJ/RL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741000069; x=1772536069;
  h=date:from:to:cc:subject:message-id;
  bh=w0bJs8KOArtC3mlGh7g05Lul3RISIZPHi8LDf6r63II=;
  b=C2hjJ/RLbN5pq7gVhhY4sKsdGcInbDeljLqs/M1P7LyepfWSQaShtdrI
   dh8oWkZ4KLngPlDb6oU821BWNjOlLjEQQjcS3eJhkUeYqaPS8BhnUNPE7
   Atoj7wHw4QPheaoZsxFp5ewZ9y0UGMgAxBfa4p1VADv9CqwmNMOXUbCCX
   hYSrxBTALaX7uy0OuOOx/etNWGBDh30zbWeJzajp60CajMsIscPmTnNt/
   jAEjXMGgqd4U6/D4IG9thGAM3Q8OochuMQXoImsM+I9AoGu+GCpynHshD
   cYhXx1E1O07yFX+arUCSmtNszsD/I3PlOVwXYMeDlN1/E21y6THN+gbYp
   g==;
X-CSE-ConnectionGUID: P1gw9xvASsuT7ABsxr44Tw==
X-CSE-MsgGUID: zAk6zjE5RB6C1zPjObOIQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41045330"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41045330"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:07:48 -0800
X-CSE-ConnectionGUID: 8w+EQ7DNRPOrrEa0OC9oJQ==
X-CSE-MsgGUID: syqWUHTqQQ+iQ7F0LpNfTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118458384"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Mar 2025 03:07:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tp3eD-000IOK-0f;
	Mon, 03 Mar 2025 11:07:45 +0000
Date: Mon, 03 Mar 2025 19:07:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 16c52ca7545527a06e662ba6818900c4e91a4e0b
Message-ID: <202503031923.Wx07BEBD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g5D0fFZzG0tR
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707974.08269@Q4SOWYesZI4ohQKHRC3sIQ
X-ITU-MailScanner-SpamCheck: not spam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 16c52ca7545527a06e662ba6818900c4e91a4e0b  Merge branch into tip/master: 'x86/sev'

elapsed time: 910m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250303    gcc-13.2.0
arc                   randconfig-002-20250303    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250303    clang-15
arm                   randconfig-002-20250303    gcc-14.2.0
arm                   randconfig-003-20250303    gcc-14.2.0
arm                   randconfig-004-20250303    clang-17
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250303    clang-21
arm64                 randconfig-002-20250303    clang-19
arm64                 randconfig-003-20250303    gcc-14.2.0
arm64                 randconfig-004-20250303    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250303    gcc-14.2.0
csky                  randconfig-002-20250303    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250303    clang-21
hexagon               randconfig-002-20250303    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250303    gcc-12
i386        buildonly-randconfig-002-20250303    clang-19
i386        buildonly-randconfig-003-20250303    clang-19
i386        buildonly-randconfig-004-20250303    gcc-12
i386        buildonly-randconfig-005-20250303    gcc-12
i386        buildonly-randconfig-006-20250303    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250303    gcc-14.2.0
loongarch             randconfig-002-20250303    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250303    gcc-14.2.0
nios2                 randconfig-002-20250303    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250303    gcc-14.2.0
parisc                randconfig-002-20250303    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 canyonlands_defconfig    clang-19
powerpc                    gamecube_defconfig    clang-16
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250303    clang-15
powerpc               randconfig-002-20250303    clang-21
powerpc               randconfig-003-20250303    clang-21
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-002-20250303    gcc-14.2.0
powerpc64             randconfig-003-20250303    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250303    gcc-14.2.0
riscv                 randconfig-002-20250303    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250303    clang-18
s390                  randconfig-002-20250303    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                    randconfig-001-20250303    gcc-14.2.0
sh                    randconfig-002-20250303    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250303    gcc-14.2.0
sparc                 randconfig-002-20250303    gcc-14.2.0
sparc64               randconfig-001-20250303    gcc-14.2.0
sparc64               randconfig-002-20250303    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250303    gcc-12
um                    randconfig-002-20250303    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250303    clang-19
x86_64      buildonly-randconfig-002-20250303    gcc-12
x86_64      buildonly-randconfig-003-20250303    clang-19
x86_64      buildonly-randconfig-004-20250303    gcc-12
x86_64      buildonly-randconfig-005-20250303    gcc-12
x86_64      buildonly-randconfig-006-20250303    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250303    gcc-14.2.0
xtensa                randconfig-002-20250303    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


