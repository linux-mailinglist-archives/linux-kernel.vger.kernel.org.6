Return-Path: <linux-kernel+bounces-397068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7609BD65A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C676283D70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56721503D;
	Tue,  5 Nov 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnWlfC7f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9282144CD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836608; cv=none; b=ZTM8+U/MC68B3pd1xrETtEqN5mXx98b2lfeGuq/4O3eVZy+V6EV64gdiFjML+ZKsYPXzkccUCnLyCGlkCh91qKIk+kEpb6WlJQzfd/JgI9w+tPPWy/rJjGraldaWjeTYm4uhNUD5TwIHZhtWuwCmETNKFtCq5/Zo3aJ+QItbtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836608; c=relaxed/simple;
	bh=etC4DRo9aSiilSVN2+0xOGPzkuuGeA2zoqU3BmXEyT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZN16Migrw7mfgs375eEoX9wHKKnXSlAnjlmVzUssuopO7iiBty9VBt+6aVezOiOzOxBU0V2XgwvDOYzbsGULkcAEfwTF8fxADabJNWw0lZLyH8lmxTx5GrfOE/VMd2wPykZrY4DoTbXCXD6mdRJbjHW4fz2M3ez5hw0KioHa+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnWlfC7f; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730836607; x=1762372607;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=etC4DRo9aSiilSVN2+0xOGPzkuuGeA2zoqU3BmXEyT8=;
  b=cnWlfC7fjqHQZ7NJS0Za/eI/L1Rvq+FJ0BoUdQYL2fjM8RCiC9pBBg5M
   8ux1b0o2cPuNBPBl/RhUGVrTSKWmr2YBD4y3pLNzMLJNRwH0nIHDYgKJl
   ewGPZw7irwI8jTsQ6UjSOwjKBDQ4IHUPwURMz4ewii+OX9MtJEsNjpnYc
   NGhsJbALQhMvqJSVAUQyQ+MTr0QQyXc0/ww638628l6c1lf8XF42CiFfM
   cA93RtLp4yCy/3OUosekPEgN3mgSXKn5/Wkhd6uhP1XKD6vFCOBMh6Ud6
   1V7ovZWwBvjG4GUaYcLMCdpsh6gbY4IBtYzQENwRtR25A0BpzFV6oAXQI
   Q==;
X-CSE-ConnectionGUID: g9ywJGxERb6slxbZ2MGzug==
X-CSE-MsgGUID: rRLOSSRTTQqwF0VFxW0slA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53176686"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53176686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:56:46 -0800
X-CSE-ConnectionGUID: wnbg42AUSi6duTIHLhFtPg==
X-CSE-MsgGUID: PNy0o4rYTxqHEGgxDlVCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="88720939"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Nov 2024 11:56:44 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8PfO-000mPD-1j;
	Tue, 05 Nov 2024 19:56:42 +0000
Date: Wed, 6 Nov 2024 03:55:50 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: drivers/gpu/drm/ttm/tests/ttm_bo_test.c:225:13: error: incompatible
 pointer types passing 'struct rt_mutex *' to parameter of type 'struct mutex
 *'
Message-ID: <202411060302.ox59BV7M-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2e1b3cc9d7f790145a80cb705b168f05dab65df2
commit: d2d6422f8bd17c6bb205133e290625a564194496 x86: Allow to enable PREEMPT_RT.
date:   7 weeks ago
config: i386-buildonly-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241106/202411060302.ox59BV7M-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060302.ox59BV7M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060302.ox59BV7M-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/ttm/tests/ttm_bo_test.c:15:
   In file included from include/drm/ttm/ttm_tt.h:30:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2237:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/ttm/tests/ttm_bo_test.c:225:13: error: incompatible pointer types passing 'struct rt_mutex *' to parameter of type 'struct mutex *' [-Werror,-Wincompatible-pointer-types]
     225 |         mutex_lock(&bo->base.resv->lock.base);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:161:44: note: expanded from macro 'mutex_lock'
     161 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
   include/linux/mutex.h:152:45: note: passing argument to parameter 'lock' here
     152 | extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
         |                                             ^
   drivers/gpu/drm/ttm/tests/ttm_bo_test.c:231:15: error: incompatible pointer types passing 'struct rt_mutex *' to parameter of type 'struct mutex *' [-Werror,-Wincompatible-pointer-types]
     231 |         mutex_unlock(&bo->base.resv->lock.base);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:192:40: note: passing argument to parameter 'lock' here
     192 | extern void mutex_unlock(struct mutex *lock);
         |                                        ^
   1 warning and 2 errors generated.


vim +225 drivers/gpu/drm/ttm/tests/ttm_bo_test.c

995279d280d1ef Karolina Stolarek 2023-11-29  210  
995279d280d1ef Karolina Stolarek 2023-11-29  211  static void ttm_bo_reserve_interrupted(struct kunit *test)
995279d280d1ef Karolina Stolarek 2023-11-29  212  {
995279d280d1ef Karolina Stolarek 2023-11-29  213  	struct ttm_buffer_object *bo;
995279d280d1ef Karolina Stolarek 2023-11-29  214  	struct task_struct *task;
995279d280d1ef Karolina Stolarek 2023-11-29  215  	int err;
995279d280d1ef Karolina Stolarek 2023-11-29  216  
588c4c8d58c413 Karolina Stolarek 2024-06-12  217  	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
995279d280d1ef Karolina Stolarek 2023-11-29  218  
995279d280d1ef Karolina Stolarek 2023-11-29  219  	task = kthread_create(threaded_ttm_bo_reserve, bo, "ttm-bo-reserve");
995279d280d1ef Karolina Stolarek 2023-11-29  220  
995279d280d1ef Karolina Stolarek 2023-11-29  221  	if (IS_ERR(task))
995279d280d1ef Karolina Stolarek 2023-11-29  222  		KUNIT_FAIL(test, "Couldn't create ttm bo reserve task\n");
995279d280d1ef Karolina Stolarek 2023-11-29  223  
995279d280d1ef Karolina Stolarek 2023-11-29  224  	/* Take a lock so the threaded reserve has to wait */
995279d280d1ef Karolina Stolarek 2023-11-29 @225  	mutex_lock(&bo->base.resv->lock.base);
995279d280d1ef Karolina Stolarek 2023-11-29  226  
995279d280d1ef Karolina Stolarek 2023-11-29  227  	wake_up_process(task);
995279d280d1ef Karolina Stolarek 2023-11-29  228  	msleep(20);
995279d280d1ef Karolina Stolarek 2023-11-29  229  	err = kthread_stop(task);
995279d280d1ef Karolina Stolarek 2023-11-29  230  
995279d280d1ef Karolina Stolarek 2023-11-29  231  	mutex_unlock(&bo->base.resv->lock.base);
995279d280d1ef Karolina Stolarek 2023-11-29  232  
995279d280d1ef Karolina Stolarek 2023-11-29  233  	KUNIT_ASSERT_EQ(test, err, -ERESTARTSYS);
995279d280d1ef Karolina Stolarek 2023-11-29  234  }
995279d280d1ef Karolina Stolarek 2023-11-29  235  #endif /* IS_BUILTIN(CONFIG_DRM_TTM_KUNIT_TEST) */
995279d280d1ef Karolina Stolarek 2023-11-29  236  

:::::: The code at line 225 was first introduced by commit
:::::: 995279d280d1ef5cc349b6eafee4dccd720c99bf drm/ttm/tests: Add tests for ttm_bo functions

:::::: TO: Karolina Stolarek <karolina.stolarek@intel.com>
:::::: CC: Christian König <christian.koenig@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

