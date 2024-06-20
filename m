Return-Path: <linux-kernel+bounces-222192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359790FE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE1AB24B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424F5579F;
	Thu, 20 Jun 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTp0faAw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334454FA9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870027; cv=none; b=FFUrXyloFph/Qn58cePeZg/Nt5H2et27Pj6sF/JvzZ1rNQXT7JdMlqJyEoCSEkFD0SpjhxXXwg7TvbXNBWtWvtMIoTy3Vh8kzyX2COStOpHnyi1AvgMMxEOQ0nGxlERROwQdF2gGTv4hfebWjaoAqr9dsQBRKLT5pXBaruAacd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870027; c=relaxed/simple;
	bh=egP8PfsmkXE0b5YHhCEEg93oJxAOxwrcE17xLU9yMQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vBG9HhWJId4kqiqQ4XyJgTqWA+uJH4LoGfJY1+WdQygfLR4o7m6pbQyfRZwBah0cLB3YiBw0sTCWtVQBIem19N8ZgpjiUjtK5s+xGm4L81IaxrSn0UhAxOZdWoJRsO1nOKGnd7EcXgvREHfB/cO9xhEyBfUWoZSny4Ec3SpDroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTp0faAw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718870025; x=1750406025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=egP8PfsmkXE0b5YHhCEEg93oJxAOxwrcE17xLU9yMQ4=;
  b=aTp0faAwgWqHokXbdY6r92lKbu3v3LGRySMonlAClEm6KCWG0hGheVgb
   dC4epnhk9XW4n2Q4A4Q6VCBYdYWFUM8NzAi1Bqskc8BLSYtdf8kS2Qrd+
   eMKohzBmH4cEmQ5sbGpSGlYYIEzHxB7f1un7Ct0CLE9ZneS6qHnTPFtZL
   y0J4xPua8VV0t79ZaMywLf/h115gLRk7CjJIULn3NbF6ErU6BdF4lW6GN
   D2Qnr1cL4GucpQAMqCpQOaecLhIgx/TCHjTPc4vjuir/RLmtQ/IPMXKHb
   idLt78W3kwvbYgb+DZzoXDaGzxzKvEcFJAAQMeij5Oa13HLRUJj+LI0Re
   A==;
X-CSE-ConnectionGUID: GN8wvpBQRtec/gEi5Yzj0A==
X-CSE-MsgGUID: oExu2IuQQG69iu87Vf/ZGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15541598"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15541598"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 00:53:45 -0700
X-CSE-ConnectionGUID: ZsUpqSfCQoyZFpdXws+4XQ==
X-CSE-MsgGUID: mAy14uA4RhWRb3/Ww1ECnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46613628"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Jun 2024 00:53:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKCc0-0007Qb-2F;
	Thu, 20 Jun 2024 07:53:40 +0000
Date: Thu, 20 Jun 2024 15:53:03 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: kernel/kcov.c:635:32: error: 'KCOV_MODE_REMOTE' undeclared
Message-ID: <202406201538.SMBucNWT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
commit: 01c8f9806bde438ca1c8cbbc439f0a14a6694f6c kcov: don't lose track of remote references during softirqs
date:   5 days ago
config: x86_64-randconfig-014-20240202 (https://download.01.org/0day-ci/archive/20240620/202406201538.SMBucNWT-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201538.SMBucNWT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201538.SMBucNWT-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                     ^~
   include/asm-generic/rwonce.h:55:27: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                           ^
   kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
     363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
         |         ^~~~~~~~~~
   kernel/kcov.c:363:21: error: 'struct task_struct' has no member named 'kcov_mode'
     363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
         |                     ^~
   include/asm-generic/rwonce.h:55:34: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                  ^
   kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
     363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
         |         ^~~~~~~~~~
   kernel/kcov.c:363:34: error: 'KCOV_MODE_DISABLED' undeclared (first use in this function); did you mean 'KCOV_DISABLE'?
     363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
         |                                  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:55:40: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
     363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
         |         ^~~~~~~~~~
   kernel/kcov.c:365:10: error: 'struct task_struct' has no member named 'kcov'
     365 |         t->kcov = NULL;
         |          ^~
   kernel/kcov.c:366:10: error: 'struct task_struct' has no member named 'kcov_size'
     366 |         t->kcov_size = 0;
         |          ^~
   kernel/kcov.c:367:10: error: 'struct task_struct' has no member named 'kcov_area'
     367 |         t->kcov_area = NULL;
         |          ^~
   kernel/kcov.c: In function 'kcov_task_reset':
   kernel/kcov.c:373:10: error: 'struct task_struct' has no member named 'kcov_sequence'
     373 |         t->kcov_sequence = 0;
         |          ^~
   kernel/kcov.c:374:10: error: 'struct task_struct' has no member named 'kcov_handle'
     374 |         t->kcov_handle = 0;
         |          ^~
   kernel/kcov.c: At top level:
   kernel/kcov.c:377:6: error: redefinition of 'kcov_task_init'
     377 | void kcov_task_init(struct task_struct *t)
         |      ^~~~~~~~~~~~~~
   In file included from kernel/kcov.c:24:
   include/linux/kcov.h:96:20: note: previous definition of 'kcov_task_init' with type 'void(struct task_struct *)'
      96 | static inline void kcov_task_init(struct task_struct *t) {}
         |                    ^~~~~~~~~~~~~~
   kernel/kcov.c: In function 'kcov_task_init':
   kernel/kcov.c:380:10: error: 'struct task_struct' has no member named 'kcov_handle'
     380 |         t->kcov_handle = current->kcov_handle;
         |          ^~
   kernel/kcov.c:380:33: error: 'struct task_struct' has no member named 'kcov_handle'
     380 |         t->kcov_handle = current->kcov_handle;
         |                                 ^~
   kernel/kcov.c: In function 'kcov_reset':
   kernel/kcov.c:386:22: error: 'KCOV_MODE_INIT' undeclared (first use in this function)
     386 |         kcov->mode = KCOV_MODE_INIT;
         |                      ^~~~~~~~~~~~~~
   kernel/kcov.c: At top level:
   kernel/kcov.c:434:6: error: redefinition of 'kcov_task_exit'
     434 | void kcov_task_exit(struct task_struct *t)
         |      ^~~~~~~~~~~~~~
   include/linux/kcov.h:97:20: note: previous definition of 'kcov_task_exit' with type 'void(struct task_struct *)'
      97 | static inline void kcov_task_exit(struct task_struct *t) {}
         |                    ^~~~~~~~~~~~~~
   kernel/kcov.c: In function 'kcov_task_exit':
   kernel/kcov.c:439:17: error: 'struct task_struct' has no member named 'kcov'
     439 |         kcov = t->kcov;
         |                 ^~
   kernel/kcov.c: In function 'kcov_open':
   kernel/kcov.c:515:22: error: 'KCOV_MODE_DISABLED' undeclared (first use in this function); did you mean 'KCOV_DISABLE'?
     515 |         kcov->mode = KCOV_MODE_DISABLED;
         |                      ^~~~~~~~~~~~~~~~~~
         |                      KCOV_DISABLE
   kernel/kcov.c: In function 'kcov_get_mode':
   kernel/kcov.c:532:24: error: 'KCOV_MODE_TRACE_PC' undeclared (first use in this function); did you mean 'KCOV_TRACE_PC'?
     532 |                 return KCOV_MODE_TRACE_PC;
         |                        ^~~~~~~~~~~~~~~~~~
         |                        KCOV_TRACE_PC
   kernel/kcov.c: In function 'kcov_ioctl_locked':
   kernel/kcov.c:593:35: error: 'KCOV_MODE_INIT' undeclared (first use in this function)
     593 |                 if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
         |                                   ^~~~~~~~~~~~~~
   kernel/kcov.c:596:41: error: 'struct task_struct' has no member named 'kcov'
     596 |                 if (kcov->t != NULL || t->kcov != NULL)
         |                                         ^~
   kernel/kcov.c:612:43: error: 'struct task_struct' has no member named 'kcov'
     612 |                 if (unused != 0 || current->kcov != kcov)
         |                                           ^~
   kernel/kcov.c:624:41: error: 'struct task_struct' has no member named 'kcov'
     624 |                 if (kcov->t != NULL || t->kcov != NULL)
         |                                         ^~
   kernel/kcov.c:634:18: error: 'struct task_struct' has no member named 'kcov'
     634 |                 t->kcov = kcov;
         |                  ^~
   kernel/kcov.c:635:18: error: 'struct task_struct' has no member named 'kcov_mode'
     635 |                 t->kcov_mode = KCOV_MODE_REMOTE;
         |                  ^~
>> kernel/kcov.c:635:32: error: 'KCOV_MODE_REMOTE' undeclared (first use in this function)
     635 |                 t->kcov_mode = KCOV_MODE_REMOTE;
         |                                ^~~~~~~~~~~~~~~~
   kernel/kcov.c:672:26: error: 'struct task_struct' has no member named 'kcov_handle'
     672 |                         t->kcov_handle = remote_arg->common_handle;
         |                          ^~
   kernel/kcov.c: In function 'kcov_ioctl':
   kernel/kcov.c:710:35: error: 'KCOV_MODE_DISABLED' undeclared (first use in this function); did you mean 'KCOV_DISABLE'?
     710 |                 if (kcov->mode != KCOV_MODE_DISABLED) {
         |                                   ^~~~~~~~~~~~~~~~~~
         |                                   KCOV_DISABLE
   kernel/kcov.c:717:30: error: 'KCOV_MODE_INIT' undeclared (first use in this function)
     717 |                 kcov->mode = KCOV_MODE_INIT;
         |                              ^~~~~~~~~~~~~~
   kernel/kcov.c: In function 'kcov_mode_enabled':
   kernel/kcov.c:803:25: error: 'KCOV_IN_CTXSW' undeclared (first use in this function)
     803 |         return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
         |                         ^~~~~~~~~~~~~
   kernel/kcov.c:803:43: error: 'KCOV_MODE_DISABLED' undeclared (first use in this function); did you mean 'KCOV_DISABLE'?
     803 |         return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
         |                                           ^~~~~~~~~~~~~~~~~~
         |                                           KCOV_DISABLE
   kernel/kcov.c: In function 'kcov_remote_softirq_start':
   kernel/kcov.c:811:27: error: 'struct task_struct' has no member named 'kcov_mode'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                           ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kcov.c:811:16: note: in expansion of macro 'READ_ONCE'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                ^~~~~~~~~
   kernel/kcov.c:811:27: error: 'struct task_struct' has no member named 'kcov_mode'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                           ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kcov.c:811:16: note: in expansion of macro 'READ_ONCE'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                ^~~~~~~~~
   kernel/kcov.c:811:27: error: 'struct task_struct' has no member named 'kcov_mode'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                           ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kcov.c:811:16: note: in expansion of macro 'READ_ONCE'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                ^~~~~~~~~
   kernel/kcov.c:811:27: error: 'struct task_struct' has no member named 'kcov_mode'
     811 |         mode = READ_ONCE(t->kcov_mode);
         |                           ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~


vim +/KCOV_MODE_REMOTE +635 kernel/kcov.c

   574	
   575	static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
   576				     unsigned long arg)
   577	{
   578		struct task_struct *t;
   579		unsigned long flags, unused;
   580		int mode, i;
   581		struct kcov_remote_arg *remote_arg;
   582		struct kcov_remote *remote;
   583	
   584		switch (cmd) {
   585		case KCOV_ENABLE:
   586			/*
   587			 * Enable coverage for the current task.
   588			 * At this point user must have been enabled trace mode,
   589			 * and mmapped the file. Coverage collection is disabled only
   590			 * at task exit or voluntary by KCOV_DISABLE. After that it can
   591			 * be enabled for another task.
   592			 */
   593			if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
   594				return -EINVAL;
   595			t = current;
   596			if (kcov->t != NULL || t->kcov != NULL)
   597				return -EBUSY;
   598			mode = kcov_get_mode(arg);
   599			if (mode < 0)
   600				return mode;
   601			kcov_fault_in_area(kcov);
   602			kcov->mode = mode;
   603			kcov_start(t, kcov, kcov->size, kcov->area, kcov->mode,
   604					kcov->sequence);
   605			kcov->t = t;
   606			/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
   607			kcov_get(kcov);
   608			return 0;
   609		case KCOV_DISABLE:
   610			/* Disable coverage for the current task. */
   611			unused = arg;
   612			if (unused != 0 || current->kcov != kcov)
   613				return -EINVAL;
   614			t = current;
   615			if (WARN_ON(kcov->t != t))
   616				return -EINVAL;
   617			kcov_disable(t, kcov);
   618			kcov_put(kcov);
   619			return 0;
   620		case KCOV_REMOTE_ENABLE:
   621			if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
   622				return -EINVAL;
   623			t = current;
   624			if (kcov->t != NULL || t->kcov != NULL)
   625				return -EBUSY;
   626			remote_arg = (struct kcov_remote_arg *)arg;
   627			mode = kcov_get_mode(remote_arg->trace_mode);
   628			if (mode < 0)
   629				return mode;
   630			if ((unsigned long)remote_arg->area_size >
   631			    LONG_MAX / sizeof(unsigned long))
   632				return -EINVAL;
   633			kcov->mode = mode;
   634			t->kcov = kcov;
 > 635		        t->kcov_mode = KCOV_MODE_REMOTE;
   636			kcov->t = t;
   637			kcov->remote = true;
   638			kcov->remote_size = remote_arg->area_size;
   639			spin_lock_irqsave(&kcov_remote_lock, flags);
   640			for (i = 0; i < remote_arg->num_handles; i++) {
   641				if (!kcov_check_handle(remote_arg->handles[i],
   642							false, true, false)) {
   643					spin_unlock_irqrestore(&kcov_remote_lock,
   644								flags);
   645					kcov_disable(t, kcov);
   646					return -EINVAL;
   647				}
   648				remote = kcov_remote_add(kcov, remote_arg->handles[i]);
   649				if (IS_ERR(remote)) {
   650					spin_unlock_irqrestore(&kcov_remote_lock,
   651								flags);
   652					kcov_disable(t, kcov);
   653					return PTR_ERR(remote);
   654				}
   655			}
   656			if (remote_arg->common_handle) {
   657				if (!kcov_check_handle(remote_arg->common_handle,
   658							true, false, false)) {
   659					spin_unlock_irqrestore(&kcov_remote_lock,
   660								flags);
   661					kcov_disable(t, kcov);
   662					return -EINVAL;
   663				}
   664				remote = kcov_remote_add(kcov,
   665						remote_arg->common_handle);
   666				if (IS_ERR(remote)) {
   667					spin_unlock_irqrestore(&kcov_remote_lock,
   668								flags);
   669					kcov_disable(t, kcov);
   670					return PTR_ERR(remote);
   671				}
   672				t->kcov_handle = remote_arg->common_handle;
   673			}
   674			spin_unlock_irqrestore(&kcov_remote_lock, flags);
   675			/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
   676			kcov_get(kcov);
   677			return 0;
   678		default:
   679			return -ENOTTY;
   680		}
   681	}
   682	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

