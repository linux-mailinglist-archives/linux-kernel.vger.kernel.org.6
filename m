Return-Path: <linux-kernel+bounces-234841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52B91CB5B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 08:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B16228455D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7EC29422;
	Sat, 29 Jun 2024 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOLhJk5C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0B8485
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719641480; cv=none; b=NiA9+0DgzFLdyHMlq3vY2BmPIXRn3S1cv0I3S3ulK/URg9OFz0oUNJkCADPsmkY0XcMPVOWsMKAgXWWcQXPWAsGEtNu2CIfxp32TP81AybR6D8oKutHn29bWUYfYSMxz7kuTEfNRIAA7hy43ISOhitxHSthKw+1LxktqkQ7FZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719641480; c=relaxed/simple;
	bh=2dcMdRN9Mk+zz0ThsugCdusmqssCiqVZSE1WOFkdvUc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TIp2XTh5F2CsmG8VmLF4av24KqYmOIeLRlwgjsghCRkCi33EE0h+8WYU6zalroegJFrtsfeSRv15Zr+Oe/HddzgAVebUFcb/TY9CB1vYmH9yqwm7M2msHU6B4pHBHUfYEAe1si2enorDGTlOa+jKZsR1PikHDNdVknpvP75oTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOLhJk5C; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719641479; x=1751177479;
  h=date:from:to:cc:subject:message-id;
  bh=2dcMdRN9Mk+zz0ThsugCdusmqssCiqVZSE1WOFkdvUc=;
  b=lOLhJk5CBelf1jy0KjQsRueKbCbSBGVfouEPRfE8+1+FjcvhMfUOLld4
   deSWleVibJMwTGrK6ZSxpRXdxKPdSJ3XuYnNXkVw88WchmTOPlql+Umul
   oXUBGrGFYbmeyLPS+ZlcA9qkOz/u/SL96Ru6ZD1tJNIhQXFr4yIJSjozB
   TAFQBYXHqC72PmOdtfh5q1S097r1Z4CLRQUCFi0PD86lu25bdlIxhzALD
   xDl5nSoHcffiUWySTuQOBI7CXgRcZr/n1eTkdSJUfufKA/4A16cuGD6rn
   lRgSzSIzhEoc5wmDxwgsJRE/Co+KAi4v/mXpXi2RZ42Ocsd0ihOuqmGOt
   w==;
X-CSE-ConnectionGUID: ez8mWG95Tj+cxEhoK9f7hA==
X-CSE-MsgGUID: DWOpSd30TWWzWAThGOXl+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16666709"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16666709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 23:11:18 -0700
X-CSE-ConnectionGUID: NyvIQ0BPQLO5i8OXHu7cSQ==
X-CSE-MsgGUID: Pwt4ADbsS0KmDnpptDM+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="75672990"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jun 2024 23:11:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNRIo-000J23-0X;
	Sat, 29 Jun 2024 06:11:14 +0000
Date: Sat, 29 Jun 2024 14:10:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 a7e7185ccd2acc4360e2cde688027cd1ecf10d93
Message-ID: <202406291415.aN1ypx7O-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: a7e7185ccd2acc4360e2cde688027cd1ecf10d93  x86/sev: Move the instrumentation exclusion bits too

elapsed time: 9759m

configs tested: 44
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240623   gcc-13.2.0
arc                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-001-20240623   gcc-13.2.0
arm                   randconfig-002-20240623   gcc-13.2.0
arm                   randconfig-003-20240623   gcc-13.2.0
arm                   randconfig-004-20240623   gcc-13.2.0
csky                  randconfig-001-20240623   gcc-13.2.0
csky                  randconfig-002-20240623   gcc-13.2.0
i386         buildonly-randconfig-001-20240622   gcc-13
i386         buildonly-randconfig-004-20240622   gcc-13
i386         buildonly-randconfig-005-20240622   gcc-13
i386                  randconfig-001-20240622   gcc-10
i386                  randconfig-003-20240622   gcc-13
i386                  randconfig-004-20240622   gcc-13
i386                  randconfig-006-20240622   gcc-13
i386                  randconfig-011-20240622   gcc-9
i386                  randconfig-012-20240622   gcc-7
loongarch             randconfig-001-20240623   gcc-13.2.0
loongarch             randconfig-002-20240623   gcc-13.2.0
nios2                 randconfig-001-20240623   gcc-13.2.0
nios2                 randconfig-002-20240623   gcc-13.2.0
parisc                randconfig-001-20240623   gcc-13.2.0
parisc                randconfig-002-20240623   gcc-13.2.0
powerpc               randconfig-001-20240623   gcc-13.2.0
powerpc64             randconfig-001-20240623   gcc-13.2.0
powerpc64             randconfig-003-20240623   gcc-13.2.0
s390                  randconfig-001-20240623   gcc-13.2.0
s390                  randconfig-002-20240623   gcc-13.2.0
sh                    randconfig-001-20240623   gcc-13.2.0
sh                    randconfig-002-20240623   gcc-13.2.0
sparc64               randconfig-001-20240623   gcc-13.2.0
sparc64               randconfig-002-20240623   gcc-13.2.0
um                    randconfig-001-20240623   gcc-7
x86_64                randconfig-001-20240623   gcc-13
x86_64                randconfig-002-20240623   gcc-13
x86_64                randconfig-004-20240623   gcc-13
x86_64                randconfig-005-20240623   gcc-8
x86_64                randconfig-012-20240623   gcc-13
x86_64                randconfig-015-20240623   gcc-13
x86_64                randconfig-071-20240623   gcc-13
x86_64                randconfig-072-20240623   gcc-13
x86_64                randconfig-075-20240623   gcc-13
xtensa                randconfig-001-20240623   gcc-13.2.0
xtensa                randconfig-002-20240623   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

