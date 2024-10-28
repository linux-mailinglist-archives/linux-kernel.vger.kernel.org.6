Return-Path: <linux-kernel+bounces-384201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80C9B2848
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23371C21336
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2918FC91;
	Mon, 28 Oct 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWjopX/E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897518FC74
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098718; cv=none; b=L/U5/qtIO7t/DJvhywlsF7LhT0I6/yTaxPuufvGqf8Qln7Wq+SmI+hpG0Wy2SaRafEfQbXpoJE14Zgp72m3yrkbNUgGKz6DU+Gim2UZa39K5vRMQIz9AD9nbndExZA+GXpNGdA2izqCsQUNspubW64LDMxy7KYZTKVbnmVdeIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098718; c=relaxed/simple;
	bh=iBtFal+VbXMv3skYB4e56SQ3UqidkU1gErX+/J1ZiLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gbttyr//TnwAepFi1qIAv3ICOfMzGxGl+3w6NT0k43Uf7FXWN5Rkr5iJJoMXSmnOjHuVOGhyz42w+AuepdJAEICdxcD4VWLe5ZqHMjIx9cdyCYgFjhYfEcYRdtEohzc8Qq25raZP1IwE2onwWcfoL22bRJobERG8UOtFcJojiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWjopX/E; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730098715; x=1761634715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iBtFal+VbXMv3skYB4e56SQ3UqidkU1gErX+/J1ZiLQ=;
  b=fWjopX/EE+7D9Tu6Im6xM2LNeZk1D0IyEbcBI+Pur6URAgnpcYcuR/fq
   Fb7tXA5IQva7ps22Cqn35bxbez2P4Q6Re2MPZ6NDDPXhPSeLH+6Z6Uvo5
   kGBDBS+iVBZYrJJb2tOgHfnqy1YzPHa2JUK2PCfsZfUbuKBc1X9Hqu4HU
   25PDMRzn3lP8p/kG1eWmwR4p8JxildpsKMAWsO9fUe9qFbghM9lDmuZjw
   w8Xay/BY3EPWNpLbus5kJqa4P08GTJBC+P4Zm9xMFUu/yQtxvksDavuyl
   C+fWJbbz5E+yD08iseMzRFhWDchZsjX/I+6URnFwcdVcdFMJdBVDgTBkR
   Q==;
X-CSE-ConnectionGUID: jMEZuR+6QCik/fGaJ0Z6bg==
X-CSE-MsgGUID: CkXZNHBAQXe8zZD4Bf/jrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="55092655"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="55092655"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 23:58:34 -0700
X-CSE-ConnectionGUID: bIHabTgwSOeWF4JSKoZpDw==
X-CSE-MsgGUID: YjY/wKSIRsi8aN+mS9XCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="118988087"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Oct 2024 23:58:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5Jhu-000bzg-1r;
	Mon, 28 Oct 2024 06:58:30 +0000
Date: Mon, 28 Oct 2024 14:58:16 +0800
From: kernel test robot <lkp@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: fs/bcachefs/btree_cache.c:502:13-14: Unneeded semicolon
Message-ID: <202410281421.V62F8rHI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guenter,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81983758430957d9a5cb3333fe324fd70cf63e7e
commit: 2007d28ec0095c6db0a24fd8bb8fe280c65446cd bcachefs: rename version -> bversion for big endian builds
date:   4 weeks ago
config: m68k-randconfig-r051-20241027 (https://download.01.org/0day-ci/archive/20241028/202410281421.V62F8rHI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410281421.V62F8rHI-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/btree_cache.c:502:13-14: Unneeded semicolon

vim +502 fs/bcachefs/btree_cache.c

1c6fdbd8f2465d Kent Overstreet 2017-03-16  441  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  442  static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
1c6fdbd8f2465d Kent Overstreet 2017-03-16  443  					   struct shrink_control *sc)
1c6fdbd8f2465d Kent Overstreet 2017-03-16  444  {
7a51608d012546 Kent Overstreet 2024-09-04  445  	struct btree_cache_list *list = shrink->private_data;
7a51608d012546 Kent Overstreet 2024-09-04  446  	struct btree_cache *bc = container_of(list, struct btree_cache, live[list->idx]);
7a51608d012546 Kent Overstreet 2024-09-04  447  	struct bch_fs *c = container_of(bc, struct bch_fs, btree_cache);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  448  	struct btree *b, *t;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  449  	unsigned long nr = sc->nr_to_scan;
7c7e071d90ac27 Kent Overstreet 2022-04-03  450  	unsigned long can_free = 0;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  451  	unsigned long freed = 0;
c36ff038fd3af6 Kent Overstreet 2022-09-25  452  	unsigned long touched = 0;
97c0e19502549c Kent Overstreet 2020-10-15  453  	unsigned i, flags;
c7ce813fe49a58 Kent Overstreet 2021-12-27  454  	unsigned long ret = SHRINK_STOP;
7a51608d012546 Kent Overstreet 2024-09-04  455  	bool trigger_writes = atomic_long_read(&bc->nr_dirty) + nr >= list->nr * 3 / 4;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  456  
29364f34530d30 Kent Overstreet 2020-11-02  457  	if (bch2_btree_shrinker_disabled)
1c6fdbd8f2465d Kent Overstreet 2017-03-16  458  		return SHRINK_STOP;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  459  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  460  	mutex_lock(&bc->lock);
97c0e19502549c Kent Overstreet 2020-10-15  461  	flags = memalloc_nofs_save();
97c0e19502549c Kent Overstreet 2020-10-15  462  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  463  	/*
1c6fdbd8f2465d Kent Overstreet 2017-03-16  464  	 * It's _really_ critical that we don't free too many btree nodes - we
1c6fdbd8f2465d Kent Overstreet 2017-03-16  465  	 * have to always leave ourselves a reserve. The reserve is how we
1c6fdbd8f2465d Kent Overstreet 2017-03-16  466  	 * guarantee that allocating memory for a new btree node can always
1c6fdbd8f2465d Kent Overstreet 2017-03-16  467  	 * succeed, so that inserting keys into the btree can always succeed and
1c6fdbd8f2465d Kent Overstreet 2017-03-16  468  	 * IO can always make forward progress:
1c6fdbd8f2465d Kent Overstreet 2017-03-16  469  	 */
7a51608d012546 Kent Overstreet 2024-09-04  470  	can_free = btree_cache_can_free(list);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  471  	nr = min_t(unsigned long, nr, can_free);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  472  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  473  	i = 0;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  474  	list_for_each_entry_safe(b, t, &bc->freeable, list) {
c043a3303c11cd Kent Overstreet 2021-12-27  475  		/*
c043a3303c11cd Kent Overstreet 2021-12-27  476  		 * Leave a few nodes on the freeable list, so that a btree split
c043a3303c11cd Kent Overstreet 2021-12-27  477  		 * won't have to hit the system allocator:
c043a3303c11cd Kent Overstreet 2021-12-27  478  		 */
c043a3303c11cd Kent Overstreet 2021-12-27  479  		if (++i <= 3)
c043a3303c11cd Kent Overstreet 2021-12-27  480  			continue;
c043a3303c11cd Kent Overstreet 2021-12-27  481  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  482  		touched++;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  483  
54b2db3d58eadb Kent Overstreet 2021-11-11  484  		if (touched >= nr)
c36ff038fd3af6 Kent Overstreet 2022-09-25  485  			goto out;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  486  
bceacfa97ec8b6 Daniel Hill     2022-09-30  487  		if (!btree_node_reclaim(c, b, true)) {
1c6fdbd8f2465d Kent Overstreet 2017-03-16  488  			btree_node_data_free(c, b);
c43a6ef9a0747e Kent Overstreet 2020-06-06  489  			six_unlock_write(&b->c.lock);
c43a6ef9a0747e Kent Overstreet 2020-06-06  490  			six_unlock_intent(&b->c.lock);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  491  			freed++;
691f2cba229189 Kent Overstreet 2024-09-05  492  			bc->nr_freed++;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  493  		}
1c6fdbd8f2465d Kent Overstreet 2017-03-16  494  	}
1c6fdbd8f2465d Kent Overstreet 2017-03-16  495  restart:
7a51608d012546 Kent Overstreet 2024-09-04  496  	list_for_each_entry_safe(b, t, &list->list, list) {
c36ff038fd3af6 Kent Overstreet 2022-09-25  497  		touched++;
c36ff038fd3af6 Kent Overstreet 2022-09-25  498  
05a49d22750ec4 Kent Overstreet 2022-03-03  499  		if (btree_node_accessed(b)) {
05a49d22750ec4 Kent Overstreet 2022-03-03  500  			clear_btree_node_accessed(b);
3340dee2350954 Kent Overstreet 2024-09-01  501  			bc->not_freed[BCH_BTREE_CACHE_NOT_FREED_access_bit]++;
ad5dbe3ce533ec Kent Overstreet 2024-09-04 @502  			--touched;;
bceacfa97ec8b6 Daniel Hill     2022-09-30  503  		} else if (!btree_node_reclaim(c, b, true)) {
91ddd7151000c0 Kent Overstreet 2024-09-05  504  			bch2_btree_node_hash_remove(bc, b);
91ddd7151000c0 Kent Overstreet 2024-09-05  505  
1c6fdbd8f2465d Kent Overstreet 2017-03-16  506  			freed++;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  507  			btree_node_data_free(c, b);
691f2cba229189 Kent Overstreet 2024-09-05  508  			bc->nr_freed++;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  509  
c43a6ef9a0747e Kent Overstreet 2020-06-06  510  			six_unlock_write(&b->c.lock);
c43a6ef9a0747e Kent Overstreet 2020-06-06  511  			six_unlock_intent(&b->c.lock);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  512  
c36ff038fd3af6 Kent Overstreet 2022-09-25  513  			if (freed == nr)
c36ff038fd3af6 Kent Overstreet 2022-09-25  514  				goto out_rotate;
c36ff038fd3af6 Kent Overstreet 2022-09-25  515  		} else if (trigger_writes &&
c36ff038fd3af6 Kent Overstreet 2022-09-25  516  			   btree_node_dirty(b) &&
c36ff038fd3af6 Kent Overstreet 2022-09-25  517  			   !btree_node_will_make_reachable(b) &&
c36ff038fd3af6 Kent Overstreet 2022-09-25  518  			   !btree_node_write_blocked(b) &&
c36ff038fd3af6 Kent Overstreet 2022-09-25  519  			   six_trylock_read(&b->c.lock)) {
7a51608d012546 Kent Overstreet 2024-09-04  520  			list_move(&list->list, &b->list);
c36ff038fd3af6 Kent Overstreet 2022-09-25  521  			mutex_unlock(&bc->lock);
46fee692eebb85 Kent Overstreet 2022-10-28  522  			__bch2_btree_node_write(c, b, BTREE_WRITE_cache_reclaim);
c36ff038fd3af6 Kent Overstreet 2022-09-25  523  			six_unlock_read(&b->c.lock);
c36ff038fd3af6 Kent Overstreet 2022-09-25  524  			if (touched >= nr)
c36ff038fd3af6 Kent Overstreet 2022-09-25  525  				goto out_nounlock;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  526  			mutex_lock(&bc->lock);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  527  			goto restart;
05a49d22750ec4 Kent Overstreet 2022-03-03  528  		}
05a49d22750ec4 Kent Overstreet 2022-03-03  529  
c36ff038fd3af6 Kent Overstreet 2022-09-25  530  		if (touched >= nr)
05a49d22750ec4 Kent Overstreet 2022-03-03  531  			break;
05a49d22750ec4 Kent Overstreet 2022-03-03  532  	}
c36ff038fd3af6 Kent Overstreet 2022-09-25  533  out_rotate:
7a51608d012546 Kent Overstreet 2024-09-04  534  	if (&t->list != &list->list)
7a51608d012546 Kent Overstreet 2024-09-04  535  		list_move_tail(&list->list, &t->list);
1c6fdbd8f2465d Kent Overstreet 2017-03-16  536  out:
c36ff038fd3af6 Kent Overstreet 2022-09-25  537  	mutex_unlock(&bc->lock);
c36ff038fd3af6 Kent Overstreet 2022-09-25  538  out_nounlock:
7c7e071d90ac27 Kent Overstreet 2022-04-03  539  	ret = freed;
e648448ca562af Kent Overstreet 2020-11-11  540  	memalloc_nofs_restore(flags);
674cfc26240b78 Kent Overstreet 2022-08-27  541  	trace_and_count(c, btree_cache_scan, sc->nr_to_scan, can_free, ret);
c7ce813fe49a58 Kent Overstreet 2021-12-27  542  	return ret;
1c6fdbd8f2465d Kent Overstreet 2017-03-16  543  }
1c6fdbd8f2465d Kent Overstreet 2017-03-16  544  

:::::: The code at line 502 was first introduced by commit
:::::: ad5dbe3ce533ec13abacad78076050672e3d39eb bcachefs: Don't count "skipped access bit" as touched in btree cache scan

:::::: TO: Kent Overstreet <kent.overstreet@linux.dev>
:::::: CC: Kent Overstreet <kent.overstreet@linux.dev>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

