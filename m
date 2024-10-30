Return-Path: <linux-kernel+bounces-388167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C89B5B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEF928395B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B01D0E19;
	Wed, 30 Oct 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMYV8BqI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730E2C95
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267699; cv=none; b=HxFib3grpaFtPwgCrjMVEWjdsLnHcJKkxfYq5k1OcU1eh1Q7KqsRzEbthcszq25J6NV+ugJGeLk4JZAf4II/wBd5QDIQCj9y+fzEh/YWhsZUTJJyF2CbRjy65N1pFLTQf0KlIAFviBcz7htblz8L0H+Pq17m62eCQgDV6HTDdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267699; c=relaxed/simple;
	bh=6q9V6oqtxM8JFtBy0BdqCGAK55IJJtLaOB0i6A/1BBQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YVKbOUr3l6QPVZNAgI5yGG76Ff3TBntxu26ymjYxXkaFS+kmQtcmIXB9cmDkSr0wfF5pEWTGgPnaVgczVmYl+KumPnuk7dLQcJMA8KBdOFHQMZtdwjcsYuStYVsa9Vp7nWZNY1foUa31qvNzmgTFKAm/RPe0xANUHJ80jtSRRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMYV8BqI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730267698; x=1761803698;
  h=date:from:to:cc:subject:message-id;
  bh=6q9V6oqtxM8JFtBy0BdqCGAK55IJJtLaOB0i6A/1BBQ=;
  b=TMYV8BqIYh1W5S+g3lyJDJv1ysZYNFGLZRc2I4lAot4HbRTq/mQPKTnP
   Q0wbSQ1StInps43j/k7NRgHYIoe1CwP9UlJxJNuk5aa/nLsDKinOEM8O1
   lBEAYjRZbTL8eKdKu7A+i98VJaobWRHPr43TzGGqMDAK6ifPa4/0gsOgy
   5JpN4gN3l4Tkybm0AzES/s9dV+rJGQkFvwBzvzecMa1M2B/4cO/iPnXNz
   KhmA4u1uCxe3NvOhorvUN/kZAqDkdZnmdb4l0ePaX9K0z/8sXWrtMSScn
   BNOI06qjq6e5VDWUjYxFdkjHknoL9/pBBajaoMpRdFriPvDlQXOe97Ypl
   Q==;
X-CSE-ConnectionGUID: iKjLxZzaQa+Ne77q1FGzrg==
X-CSE-MsgGUID: 3TAPqk9lSI+JUnjXLMaEoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30062581"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="30062581"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:54:57 -0700
X-CSE-ConnectionGUID: UiMft75eQxmQn8f51IxI4g==
X-CSE-MsgGUID: 2YOrqBsTQ1qO1Xhuabd7nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="81837149"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 Oct 2024 22:54:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t61fR-000eZC-1y;
	Wed, 30 Oct 2024 05:54:53 +0000
Date: Wed, 30 Oct 2024 13:54:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 fce9642c765a18abd1db0339a7d832c29b68456a
Message-ID: <202410301340.1PSpXLI5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: fce9642c765a18abd1db0339a7d832c29b68456a  x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB

elapsed time: 738m

configs tested: 44
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.1.0
alpha       allyesconfig    clang-20
arc         allmodconfig    clang-20
arc          allnoconfig    gcc-14.1.0
arc         allyesconfig    clang-20
arm         allmodconfig    clang-20
arm          allnoconfig    gcc-14.1.0
arm         allyesconfig    clang-20
arm64       allmodconfig    clang-20
arm64        allnoconfig    gcc-14.1.0
csky         allnoconfig    gcc-14.1.0
hexagon     allmodconfig    clang-20
hexagon      allnoconfig    gcc-14.1.0
hexagon     allyesconfig    clang-20
i386        allmodconfig    clang-19
i386         allnoconfig    clang-19
i386        allyesconfig    clang-19
i386           defconfig    clang-19
loongarch   allmodconfig    gcc-14.1.0
loongarch    allnoconfig    gcc-14.1.0
m68k        allmodconfig    gcc-14.1.0
m68k         allnoconfig    gcc-14.1.0
m68k        allyesconfig    gcc-14.1.0
microblaze  allmodconfig    gcc-14.1.0
microblaze   allnoconfig    gcc-14.1.0
microblaze  allyesconfig    gcc-14.1.0
mips         allnoconfig    gcc-14.1.0
nios2        allnoconfig    gcc-14.1.0
openrisc     allnoconfig    clang-20
parisc       allnoconfig    clang-20
powerpc      allnoconfig    clang-20
riscv        allnoconfig    clang-20
s390         allnoconfig    clang-20
sh           allnoconfig    gcc-14.1.0
um          allmodconfig    clang-20
um           allnoconfig    clang-20
um          allyesconfig    clang-20
x86_64       allnoconfig    clang-19
x86_64      allyesconfig    clang-19
x86_64         defconfig    clang-19
x86_64             kexec    clang-19
x86_64             kexec    gcc-12
x86_64          rhel-8.3    gcc-12
xtensa       allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

