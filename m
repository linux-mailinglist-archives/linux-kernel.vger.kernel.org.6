Return-Path: <linux-kernel+bounces-522240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F07A3C7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE033B3270
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55D1FCFD2;
	Wed, 19 Feb 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA4vvv6n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50B286284
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990137; cv=none; b=TVZYyoSPxCmrQ+qOF6vYc7cRgHzoR/86M3bHJZncVWl/BwQkfFkv62sODEcQtNnP9J0GV6yRjqKhGteQNfZiydjqTdBfB0dgS+vINLi8iH7ZxDb4HL7adiVYsz4QlrLT3c/RXLHgz/hcJLw1WBNP4KyQcvFI55QUrRChnROkWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990137; c=relaxed/simple;
	bh=7prenXagOrLaHxQTYkCyFErnEhCLzGfw+nnqrOCEqVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hCR3N1JL374hABwxZ07cJvIen+As78AlkNUrMT7TGXJfjYhpydcne5j2/6wLy8wnykDvzOocLUxhrK3gjS7iktknnLJJmqhMWnA8NAHamUxmwjXpalpdmiU5CfD15irvv45R0VhiU28CDSQQH34FZ/rgSHKSO4d9Di/9MtTTvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA4vvv6n; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739990136; x=1771526136;
  h=date:from:to:cc:subject:message-id;
  bh=7prenXagOrLaHxQTYkCyFErnEhCLzGfw+nnqrOCEqVw=;
  b=gA4vvv6n9v8bYPm7GYuuDsZlxzU+/xHdE/qZENWhTI5uSkhxF4yqERpB
   5tI2surBD5EMkeieI+HcMLazem5H1AGnd1Rrv16BQZXOdsl4f9TdOXqxT
   I3BNYewecfY0o/z9XIYIFCDP1rD/uGHbUqPmUzWULYqUYXHGKKx52fJkD
   JzHFT1jmnbjoXAlp/dgbn0PAO/UEbbggkABAY5U77JHvO1O3SoD+UIUqk
   30gJqBXiA0qflzzKuHNtBct1LTT4/Wg5EJ3gsWLYlZXOrZySHOjbynYFP
   4TGKOFoQgT1mZIqkdK4Yjk6WgG98zp8NP7ztlnhEe0Waf+JS87dZ7LnpR
   A==;
X-CSE-ConnectionGUID: 0kY5DbfqRKKk+h1LPJdo6A==
X-CSE-MsgGUID: J26VEjIqT1WOs/R0ljYX4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63220148"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="63220148"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:35:35 -0800
X-CSE-ConnectionGUID: i4DlK0O/TGmV5zLYsy+N7Q==
X-CSE-MsgGUID: CpwIsLGNSbisaZzPxyHgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115326225"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:21:17 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkoh7-0003In-2H;
	Wed, 19 Feb 2025 18:21:13 +0000
Date: Thu, 20 Feb 2025 02:20:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 c893ee3f95f16fcb98da934d61483d0b7d8ed568
Message-ID: <202502200233.FaoTxUh8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: c893ee3f95f16fcb98da934d61483d0b7d8ed568  x86/amd_node: Add a smn_read_register() helper

elapsed time: 1454m

configs tested: 74
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250219    gcc-13.2.0
arc                  randconfig-002-20250219    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250219    gcc-14.2.0
arm                  randconfig-002-20250219    clang-17
arm                  randconfig-003-20250219    clang-15
arm                  randconfig-004-20250219    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250219    clang-21
arm64                randconfig-002-20250219    gcc-14.2.0
arm64                randconfig-003-20250219    gcc-14.2.0
arm64                randconfig-004-20250219    gcc-14.2.0
csky                 randconfig-001-20250219    gcc-14.2.0
csky                 randconfig-002-20250219    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250219    clang-14
hexagon              randconfig-002-20250219    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250219    clang-19
i386       buildonly-randconfig-002-20250219    clang-19
i386       buildonly-randconfig-003-20250219    gcc-12
i386       buildonly-randconfig-004-20250219    clang-19
i386       buildonly-randconfig-005-20250219    clang-19
i386       buildonly-randconfig-006-20250219    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250219    gcc-14.2.0
loongarch            randconfig-002-20250219    gcc-14.2.0
nios2                randconfig-001-20250219    gcc-14.2.0
nios2                randconfig-002-20250219    gcc-14.2.0
parisc               randconfig-001-20250219    gcc-14.2.0
parisc               randconfig-002-20250219    gcc-14.2.0
powerpc              randconfig-001-20250219    clang-15
powerpc              randconfig-002-20250219    clang-17
powerpc              randconfig-003-20250219    gcc-14.2.0
powerpc64            randconfig-001-20250219    gcc-14.2.0
powerpc64            randconfig-002-20250219    gcc-14.2.0
powerpc64            randconfig-003-20250219    gcc-14.2.0
riscv                randconfig-001-20250219    clang-21
riscv                randconfig-002-20250219    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250219    clang-18
s390                 randconfig-002-20250219    clang-21
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250219    gcc-14.2.0
sh                   randconfig-002-20250219    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250219    gcc-14.2.0
sparc                randconfig-002-20250219    gcc-14.2.0
sparc64              randconfig-001-20250219    gcc-14.2.0
sparc64              randconfig-002-20250219    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250219    clang-21
um                   randconfig-002-20250219    clang-21
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250219    gcc-12
x86_64     buildonly-randconfig-002-20250219    clang-19
x86_64     buildonly-randconfig-003-20250219    gcc-12
x86_64     buildonly-randconfig-004-20250219    clang-19
x86_64     buildonly-randconfig-005-20250219    gcc-12
x86_64     buildonly-randconfig-006-20250219    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250219    gcc-14.2.0
xtensa               randconfig-002-20250219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

