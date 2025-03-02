Return-Path: <linux-kernel+bounces-540824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215EA4B588
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 00:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF16816C1D9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBC61EE00A;
	Sun,  2 Mar 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjoT6AcO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952E1925A2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740959330; cv=none; b=TijwuqFfAfOYKXbi9IzC622JnjnWZ94rG1uwvnC3jkP86LkvQunA/ugjtePMJT/NzURJPhb1n+F0Syfnq2nyV4b4OBmZYEecEVwoonpiRsjbOlsdWtyxHUchGmEmwQzVBs0C9/nDX4qCz/P8y9YauH4i+2W3EwIwNG1cwTFG0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740959330; c=relaxed/simple;
	bh=3FkocbcX2Ju5O6PPmkKHuxxs0BTs8xhC1jngGk6qxmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BB/gKTvgXoIO/gL4w9HHDmOstA2i1Z874fK3c2u3FZbP+VyAh2SAt92ri8qzBR2V05RbSD9RQgFQZhoHYmkNRJEdzzZ2a+25ZhPESHuMnAzYYqJcvsGPXI5xbaJdlwwHL5VEXsDS2HkU+9chp831BTiZrs9PZr80FeMBsnydndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjoT6AcO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740959329; x=1772495329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3FkocbcX2Ju5O6PPmkKHuxxs0BTs8xhC1jngGk6qxmA=;
  b=JjoT6AcOOE05u1h6aBX+TeGXbqFjGB9j7s5n1H7kVhiqhiHJ+9c6dkHy
   Hs6HzdvrKyQxtMNiEYzx2K1rkmTMDKm1Op0H7VrET8UUn41eQugyY4bwW
   Up7+ZDX4zjrRLKSm6UwoheRqHbSaih9n1uxfHexc1JtrFRswz7wnvWOmA
   QMYXqyOrtG7+4+WoowgJSWpBr+fXyYuuBTVeqLwU0eqs/R7C5dZWFAFwg
   sEtDdcgrIidlujmtNUEyWv5RmrJVz58YJArKaOCQIJ1uSlNSQTs4KhoxB
   eNFqsPTxBBN4B/OXNW0eWtkHFx16Leo/BXCUP90z+OxcAuPWU4EVxIGkG
   Q==;
X-CSE-ConnectionGUID: M3sEpf98QkWOKKVcPxOFkw==
X-CSE-MsgGUID: mXOKhvzuQzWAwWVSzOVIFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41711357"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="41711357"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 15:48:48 -0800
X-CSE-ConnectionGUID: uxw0jbt1SYaxFKdF9WIjpQ==
X-CSE-MsgGUID: 9YcKVBX2Tw2FF3ppow4s8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="118542824"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Mar 2025 15:48:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tot35-000HjL-2t;
	Sun, 02 Mar 2025 23:48:43 +0000
Date: Mon, 3 Mar 2025 07:47:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>
Subject: mm/kmsan/hooks.c:269:14: sparse: sparse: cast removes address space
 '__user' of expression
Message-ID: <202503030742.0cGEybrx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ilya,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eb172143d5508b4da468ed59ee857c6e5e01da6
commit: 3a8f6f3b469b4075919a3613e182f9a70df92d46 kmsan: enable on s390
date:   8 months ago
config: s390-randconfig-r122-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030742.0cGEybrx-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce: (https://download.01.org/0day-ci/archive/20250303/202503030742.0cGEybrx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030742.0cGEybrx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/kmsan/hooks.c:269:14: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:271:75: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const *user_addr @@     got void [noderef] __user *to @@
   mm/kmsan/hooks.c:271:75: sparse:     expected void const *user_addr
   mm/kmsan/hooks.c:271:75: sparse:     got void [noderef] __user *to
   mm/kmsan/hooks.c:280:50: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:306:59: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:319:79: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:325:79: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:421:78: sparse: sparse: Using plain integer as NULL pointer

vim +/__user +269 mm/kmsan/hooks.c

b073d7f8aee4eb Alexander Potapenko 2022-09-15  247  
75cf0290271bf6 Alexander Potapenko 2022-09-15  248  void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
75cf0290271bf6 Alexander Potapenko 2022-09-15  249  			size_t left)
75cf0290271bf6 Alexander Potapenko 2022-09-15  250  {
75cf0290271bf6 Alexander Potapenko 2022-09-15  251  	unsigned long ua_flags;
75cf0290271bf6 Alexander Potapenko 2022-09-15  252  
75cf0290271bf6 Alexander Potapenko 2022-09-15  253  	if (!kmsan_enabled || kmsan_in_runtime())
75cf0290271bf6 Alexander Potapenko 2022-09-15  254  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  255  	/*
75cf0290271bf6 Alexander Potapenko 2022-09-15  256  	 * At this point we've copied the memory already. It's hard to check it
75cf0290271bf6 Alexander Potapenko 2022-09-15  257  	 * before copying, as the size of actually copied buffer is unknown.
75cf0290271bf6 Alexander Potapenko 2022-09-15  258  	 */
75cf0290271bf6 Alexander Potapenko 2022-09-15  259  
75cf0290271bf6 Alexander Potapenko 2022-09-15  260  	/* copy_to_user() may copy zero bytes. No need to check. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  261  	if (!to_copy)
75cf0290271bf6 Alexander Potapenko 2022-09-15  262  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  263  	/* Or maybe copy_to_user() failed to copy anything. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  264  	if (to_copy <= left)
75cf0290271bf6 Alexander Potapenko 2022-09-15  265  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  266  
75cf0290271bf6 Alexander Potapenko 2022-09-15  267  	ua_flags = user_access_save();
f926e9326f3a79 Ilya Leoshkevich    2024-06-21  268  	if (!IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) ||
f926e9326f3a79 Ilya Leoshkevich    2024-06-21 @269  	    (u64)to < TASK_SIZE) {
75cf0290271bf6 Alexander Potapenko 2022-09-15  270  		/* This is a user memory access, check it. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  271  		kmsan_internal_check_memory((void *)from, to_copy - left, to,
75cf0290271bf6 Alexander Potapenko 2022-09-15  272  					    REASON_COPY_TO_USER);
75cf0290271bf6 Alexander Potapenko 2022-09-15  273  	} else {
75cf0290271bf6 Alexander Potapenko 2022-09-15  274  		/* Otherwise this is a kernel memory access. This happens when a
75cf0290271bf6 Alexander Potapenko 2022-09-15  275  		 * compat syscall passes an argument allocated on the kernel
75cf0290271bf6 Alexander Potapenko 2022-09-15  276  		 * stack to a real syscall.
75cf0290271bf6 Alexander Potapenko 2022-09-15  277  		 * Don't check anything, just copy the shadow of the copied
75cf0290271bf6 Alexander Potapenko 2022-09-15  278  		 * bytes.
75cf0290271bf6 Alexander Potapenko 2022-09-15  279  		 */
75cf0290271bf6 Alexander Potapenko 2022-09-15  280  		kmsan_internal_memmove_metadata((void *)to, (void *)from,
75cf0290271bf6 Alexander Potapenko 2022-09-15  281  						to_copy - left);
75cf0290271bf6 Alexander Potapenko 2022-09-15  282  	}
75cf0290271bf6 Alexander Potapenko 2022-09-15  283  	user_access_restore(ua_flags);
75cf0290271bf6 Alexander Potapenko 2022-09-15  284  }
75cf0290271bf6 Alexander Potapenko 2022-09-15  285  EXPORT_SYMBOL(kmsan_copy_to_user);
75cf0290271bf6 Alexander Potapenko 2022-09-15  286  

:::::: The code at line 269 was first introduced by commit
:::::: f926e9326f3a79f7e01ac790e2361f44d8ca8320 kmsan: fix kmsan_copy_to_user() on arches with overlapping address spaces

:::::: TO: Ilya Leoshkevich <iii@linux.ibm.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

