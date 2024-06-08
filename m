Return-Path: <linux-kernel+bounces-207210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8369013B7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 23:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED7A1F2194F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FE2E620;
	Sat,  8 Jun 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5m4Bhna"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470421A04
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717883250; cv=none; b=suVnyoPwpe0ktpcpq9USudcBRPQQzDu5LKm7qnmk0N46hNxfK9SSQSMd/77GzmGGzAClgR3BjxM6En8jx2M78k6k5Fff5OUwhqX1isX1WcXdEsJiGlMWmnnfoR+wrO2D1gJJxdL3X+FMsumwwMf0jWeQC7hMzyCvp2UdfwX31zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717883250; c=relaxed/simple;
	bh=lNvY8dxp7aLIxhj4eSVixx0JkTm+4c97dJCdGNGGJrI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pNyx4rqzraBjr20lbwXaPi++71zPGxQQsqMYfEPpc5l5o7zruM2heTFfqbjzdcunDaUXIMHUjkc2xBe65TJP+apTXyejfVaWA1r+MrGMEzivxobLAIZhYHPScUqJtm0VTMDgj+9lUv6hzbfyiEzGQ/o41OdlBbYVX5kNLxDv+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5m4Bhna; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717883249; x=1749419249;
  h=date:from:to:cc:subject:message-id;
  bh=lNvY8dxp7aLIxhj4eSVixx0JkTm+4c97dJCdGNGGJrI=;
  b=U5m4Bhnan376kmMSoiOB/PnelXlJBhkanikWUDWlMIiqW+jqfKdcrnrv
   yX4/C5juvznJb00MQDHI2+Y8oDVwh1UBRgCLSWgWbIENdl39TePGY5sGP
   C++QasLo4yDJCaPYXh34ve1SbxiKcY32ipMzUywRLbduh9OnRrG+VJIPH
   EoqJBB5h+OyaFC+1IaXgtrjqgGCxNETnlvKYS5bIkM24QA2bfONMpXQiv
   5xQHm0iDDTv76iy8koeyexfPVT7wN+W+iYtetzjJtijW1Pvzt5csQjebK
   EX59l/ix130MSCSRXyaCDqIbBpf9EXq+UyfnXV2nRWOJxx6tvcEIEoQtL
   g==;
X-CSE-ConnectionGUID: dWyoMSShRqC5wA4jmPWnGg==
X-CSE-MsgGUID: fWnGgxZ0T1a8wdg1i7GLTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="11979081"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="11979081"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 14:47:27 -0700
X-CSE-ConnectionGUID: MUyCQt5FS/64GfHX+JZ8Vw==
X-CSE-MsgGUID: Gcz7VuzST7CSa/Yc/YoYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="43094802"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jun 2024 14:47:27 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG3uF-0000Wc-2l;
	Sat, 08 Jun 2024 21:47:23 +0000
Date: Sun, 09 Jun 2024 05:46:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 f6d116e080604251880b4957843f9b1f6fdfa30f
Message-ID: <202406090541.dnZ7c9aF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: f6d116e080604251880b4957843f9b1f6fdfa30f  tools/x86/kcpuid: Add missing dir via Makefile

elapsed time: 1449m

configs tested: 20
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

