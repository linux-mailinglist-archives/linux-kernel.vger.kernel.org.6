Return-Path: <linux-kernel+bounces-565510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B3A669CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69473A7522
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD717D355;
	Tue, 18 Mar 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4pHdhZR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37746B8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276972; cv=none; b=bT22/JJinlrYxH9+uYh5zTFgL1KCTOloQF+HTgZ5ZRqINvsQvpXiSV+IsXOwBA23+/uoWSF+1V8MNM3XR8PFBuHYZww2dsZ5aq00EOhpmJEXmooQsqQIU0rvUrfe1xRCTfvnxPwT2x+wsUEB+TdsoncHGdo8lvTG9qwq1Mmdsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276972; c=relaxed/simple;
	bh=cPyLsAymAQCqZAyUD8hKdcXbKrQyYUAdZc6QzZPlsTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N1PsbuaPGkvnjzlKZRgY3VCHQgA8zK0Q/9d+SuHs/5gYricqM3uNzLI+mF1NO6p8WTtbWst8CBZha2qHMyxCg05QQy8KLcxu70g8iDG9XYcqd9ZYP8NtppGVtzeDiZysAIqhQQPiB6dCcRrreFoao823Ij+MW0hq7EufWitvv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4pHdhZR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742276970; x=1773812970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cPyLsAymAQCqZAyUD8hKdcXbKrQyYUAdZc6QzZPlsTI=;
  b=N4pHdhZR/5jal+cWpDYyL3j2P+rPdd6pMNU6Swrm3p1dmp0Cy/TGyKoF
   ELwBB5fnv2kSNuufOLNxq64ycNYroO61JrxUbytdSCJsVH5aY9PB7YBmu
   JXeFGgAUqRiguv41RCIV/RTDy8vT70czgVHlnRZ/v1M772fKmpE7GxEtk
   3s5d3ndK/S328LHHVqYmAKaROhxqG+JgwH7kXxvQ+YPYFHjoaAfI1IuUR
   pnSmAvl2txmLcEXUoVjdTZo/QCEMbOhd+YUycpNavq3RzvgnNZg9npLKN
   ei2KbgWZ8daTAe8vHqCSPTEWuTeodUW/xWGnLqbhuSITS7srumP0Jxhea
   A==;
X-CSE-ConnectionGUID: NOJ7/qN7TB2HC6ArAUmNhA==
X-CSE-MsgGUID: ODLR6iw4SBmekM9H0Dd+qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="60790232"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="60790232"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 22:49:30 -0700
X-CSE-ConnectionGUID: ghMZ/yHAQVGgCX0yybpEEw==
X-CSE-MsgGUID: 0NV8rLOwQ3y0dkmI10VoGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127001758"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2025 22:49:27 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuPp3-000DRD-1p;
	Tue, 18 Mar 2025 05:49:25 +0000
Date: Tue, 18 Mar 2025 13:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: include/linux/rcupdate.h:538:9: error: dereferencing pointer to
 incomplete type 'struct nfsd_file'
Message-ID: <202503181317.eiDzfsM0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc444ada131001812c5d10b380837238c9cf7c8c
commit: 86e00412254a717ffd5d38dc5ec0ee1cce6281b3 nfs: cache all open LOCALIO nfsd_file(s) in client
date:   9 weeks ago
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250318/202503181317.eiDzfsM0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181317.eiDzfsM0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181317.eiDzfsM0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from fs/nfs/localio.c:11:
   fs/nfs/localio.c: In function 'nfs_local_open_fh':
>> include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type 'struct nfsd_file'
     typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
            ^
   include/linux/rcupdate.h:686:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:758:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs/nfs/localio.c:279:7: note: in expansion of macro 'rcu_dereference'
     nf = rcu_dereference(*pnf);
          ^~~~~~~~~~~~~~~
--
   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from localio.c:11:
   localio.c: In function 'nfs_local_open_fh':
>> include/linux/rcupdate.h:538:9: error: dereferencing pointer to incomplete type 'struct nfsd_file'
     typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
            ^
   include/linux/rcupdate.h:686:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:758:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   localio.c:279:7: note: in expansion of macro 'rcu_dereference'
     nf = rcu_dereference(*pnf);
          ^~~~~~~~~~~~~~~


vim +538 include/linux/rcupdate.h

76c8eaafe4f061 Paul E. McKenney        2021-04-21  528  
24ba53017e188e Chun-Hung Tseng         2021-09-15  529  #define __rcu_access_pointer(p, local, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  530  ({ \
24ba53017e188e Chun-Hung Tseng         2021-09-15  531  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  532) 	rcu_check_sparse(p, space); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  533  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  534  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  535  #define __rcu_dereference_check(p, local, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  536  ({ \
ac59853c06993a Pranith Kumar           2014-11-13  537  	/* Dependency order vs. p above. */ \
24ba53017e188e Chun-Hung Tseng         2021-09-15 @538  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  539  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  540) 	rcu_check_sparse(p, space); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  541  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  542  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  543  #define __rcu_dereference_protected(p, local, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  544  ({ \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  545  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  546) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  547  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  548  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  549  #define __rcu_dereference_raw(p, local) \
995f1405610bd8 Paul E. McKenney        2016-07-01  550  ({ \
995f1405610bd8 Paul E. McKenney        2016-07-01  551  	/* Dependency order vs. p above. */ \
24ba53017e188e Chun-Hung Tseng         2021-09-15  552  	typeof(p) local = READ_ONCE(p); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  553  	((typeof(*p) __force __kernel *)(local)); \
995f1405610bd8 Paul E. McKenney        2016-07-01  554  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  555  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  556  

:::::: The code at line 538 was first introduced by commit
:::::: 24ba53017e188e031f9cb8b290286fad52d2af00 rcu: Replace ________p1 and _________p1 with __UNIQUE_ID(rcu)

:::::: TO: Chun-Hung Tseng <henrybear327@gmail.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

