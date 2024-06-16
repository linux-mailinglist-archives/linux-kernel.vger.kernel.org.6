Return-Path: <linux-kernel+bounces-216173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE288909C46
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E40C1F21432
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D55181310;
	Sun, 16 Jun 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlWo//fz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00D17E91F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523604; cv=none; b=AamvWz9D4SOQvuknN0o2bRiqxwTdgvZIHbOa4srJBRCasKzdPC+P0QK/clotp7IYfRC7Maw9j5Ur13UPhECfCtEKr5k1rKP2CcxNcQQao9SfxxOFHGvK2MgmdNg4Hqxb9i4i59rTEotgyTOPsCMEnDO6ApY6jOdE7n4wRXDl58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523604; c=relaxed/simple;
	bh=D5EhZQltojW1k4f42xECiyyRksv10v2W4+ViC3waBxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iHlZNt+r7iEmeXiVc5SKlStjQshg4JPKiVP86zQ5APGE+FBaDC12Djh3NS5As1IdOV0bM/C2jYemHW8oIIFUhXRgRfOz9AcwDbcnbtI5UrfEusF7o5omfcnxlGOzaClJS8i5WPUEHCHXgOIWNC4gw1nwa16VanqFuseMQQhVETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WlWo//fz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718523602; x=1750059602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D5EhZQltojW1k4f42xECiyyRksv10v2W4+ViC3waBxg=;
  b=WlWo//fzH/O/KjIIKaCaOq6pEwaMLc06VPMLFh34xgndVGBXJlVuIHic
   4ZSbilzlAiwHM/WGRPqjqtpvbRR+SazyioP9aVqvRaftRMMM7bI1nbe0D
   oinACWUrRaC7IRzOXgao0xAs5M3nG57cmjFYWjq7dONdkAcSJmyCQh32D
   tfwXaGBqJ8cirancAksussbWESJqhy6f5WzDV821PxnZWwh7Oskpfp39f
   +WwQUAMS+C7M8gMvfnKMOs5Q20rb7wMxyU0tz+msKraTlupdni4/SIdVK
   l4VmXUhpnLgmZGL2a+2ixGyIJ12wiYiZInBS2+Tu8HLtofMvJciaz8xX3
   g==;
X-CSE-ConnectionGUID: YFNEtWcMQS2IyyAwHs5KtA==
X-CSE-MsgGUID: lGE5DsHjQPm4yLFJSwVh7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="26053454"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="26053454"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 00:40:00 -0700
X-CSE-ConnectionGUID: nWSIyOm5T2KAeExjKybE/w==
X-CSE-MsgGUID: As6hhlrURJqXKBrttUM6hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40760962"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2024 00:39:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIkUW-0002NG-2L;
	Sun, 16 Jun 2024 07:39:56 +0000
Date: Sun, 16 Jun 2024 15:39:08 +0800
From: kernel test robot <lkp@intel.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: error: <unknown>:0:0: in function
 _RNvMNtCs5QSdWC790r4_4core3f32f7next_up float (float): SSE register return
 with SSE disabled
Message-ID: <202406161537.8SBTYvQm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3e18a540541325a8c8848171f71e0d45ad30b2c
commit: 56f64b370612d8967df2c2e0cead805444d4e71a rust: upgrade to Rust 1.78.0
date:   6 weeks ago
config: um-randconfig-r061-20240616 (https://download.01.org/0day-ci/archive/20240616/202406161537.8SBTYvQm-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406161537.8SBTYvQm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406161537.8SBTYvQm-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for function 'foo' [-Wmissing-prototypes]
   void foo(void)
   ^
   arch/x86/um/user-offsets.c:17:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void foo(void)
   ^
   static
   1 warning generated.
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for function 'foo' [-Wmissing-prototypes]
   void foo(void)
   ^
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void foo(void)
   ^
   static
   1 warning generated.
   clang diag: include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>> error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up float (float): SSE register return with SSE disabled

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

