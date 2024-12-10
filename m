Return-Path: <linux-kernel+bounces-438848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED79EA736
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C59188A15B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139941D14E2;
	Tue, 10 Dec 2024 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLgXsBy7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE52469D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733805585; cv=none; b=U9KiEfNG02b7X70/BI7Tr5W1rYhW5YekCIVTN1bVqsDVmgMi5uDM9/nGc75o9W2FIUxtarxznkd+Wb1YAJiMOyQaN2zGES02fRpYtuyqUf5coyXkKgglrQJqn55tM/0jP7CW8qTkgQ0vfXOtQYNBbC2NsW4CZcOyRUDPOCdkOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733805585; c=relaxed/simple;
	bh=cMM5UJn534DXMu2P2rUZVq/5tZoRIPlZHu8wkjKPBLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GyE9uordENZxNtdUzmyMN3HenIrHnx5TxX4o5ov/F9WBKqOLLL7gBZOmeK6uJKIdgPWKvwSzj/nIky5mjg53003kc6YEPKaGog9MLRJeh8dP9xgUlf/sEJKABOKnrMY9W0rmHi8X7qByCr7ZMoJNvjGyHbwhAIt13dik/Mwvegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLgXsBy7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733805583; x=1765341583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cMM5UJn534DXMu2P2rUZVq/5tZoRIPlZHu8wkjKPBLA=;
  b=CLgXsBy7u+VtOe7q5/mjOLCN2luk8/wgpizLhcyLnhypdAW3Amb3oN0Y
   irrCspI/9NRrKkTJjUSLWVx0e+rtUPDMYEpnomJgO0Vd23paL2Z2PE0Rh
   jkib8QlRArgjf5W2IM0Y3J9vhzhR/74vwM1H8iLn2JFjM0CjzCH8ERcvS
   nru2uPeCV/lhM0dTGv/LQxDlTuPwmpNpNOUO5cfOzyN1ZsNDHgQyktyaN
   dcAbJhAvqFTgywBfzKGli+ENdqtW1qqqpOGG9/m8MMQZIJtHD29ObVm8K
   MzYv0FpZqPHF+p2/GqejQV1n74dyDH//J0sdz0it4ThgPNdpwt2EhVcS/
   w==;
X-CSE-ConnectionGUID: SNy1wbKrQaaTgUe1wHmwkA==
X-CSE-MsgGUID: H03r1LnuRGqG5u53/POzKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44734334"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="44734334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 20:39:42 -0800
X-CSE-ConnectionGUID: VI9u4nxtQfuqhdlZXHUnWQ==
X-CSE-MsgGUID: 16FMgXwARwusYhg4ccIqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100322664"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Dec 2024 20:39:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKs26-00056z-0e;
	Tue, 10 Dec 2024 04:39:38 +0000
Date: Tue, 10 Dec 2024 12:38:52 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: kernel/workqueue.c:5657:9: error: function '__alloc_workqueue' might
 be a candidate for 'gnu_printf' format attribute
Message-ID: <202412101255.Y9hKSRFL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7cb1b466315004af98f6ba6c2546bb713ca3c237
commit: 9b59a85a84dc37ca4f2c54df5e06aff4c1eae5d3 workqueue: Don't call va_start / va_end twice
date:   4 months ago
config: x86_64-rhel-9.4-nofixup (https://download.01.org/0day-ci/archive/20241210/202412101255.Y9hKSRFL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241210/202412101255.Y9hKSRFL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412101255.Y9hKSRFL-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/workqueue.c: In function '__alloc_workqueue':
>> kernel/workqueue.c:5657:9: error: function '__alloc_workqueue' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
    5657 |         name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
         |         ^~~~~~~~
   cc1: all warnings being treated as errors


vim +5657 kernel/workqueue.c

a045a272d88757 Tejun Heo           2024-01-29  5621  
b188c57af2b5c1 Matthew Brost       2024-08-09  5622  static struct workqueue_struct *__alloc_workqueue(const char *fmt,
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5623  						  unsigned int flags,
9b59a85a84dc37 Matthew Brost       2024-08-20  5624  						  int max_active, va_list args)
f147f29eb7c495 Tejun Heo           2013-04-01  5625  {
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5626  	struct workqueue_struct *wq;
91ccc6e7233bb1 Tejun Heo           2024-01-29  5627  	size_t wq_size;
91ccc6e7233bb1 Tejun Heo           2024-01-29  5628  	int name_len;
f147f29eb7c495 Tejun Heo           2013-04-01  5629  
4cb1ef64609f9b Tejun Heo           2024-02-04  5630  	if (flags & WQ_BH) {
4cb1ef64609f9b Tejun Heo           2024-02-04  5631  		if (WARN_ON_ONCE(flags & ~__WQ_BH_ALLOWS))
4cb1ef64609f9b Tejun Heo           2024-02-04  5632  			return NULL;
4cb1ef64609f9b Tejun Heo           2024-02-04  5633  		if (WARN_ON_ONCE(max_active))
4cb1ef64609f9b Tejun Heo           2024-02-04  5634  			return NULL;
4cb1ef64609f9b Tejun Heo           2024-02-04  5635  	}
4cb1ef64609f9b Tejun Heo           2024-02-04  5636  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5637  	/* see the comment above the definition of WQ_POWER_EFFICIENT */
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5638  	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5639  		flags |= WQ_UNBOUND;
f147f29eb7c495 Tejun Heo           2013-04-01  5640  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5641  	/* allocate wq and format name */
91ccc6e7233bb1 Tejun Heo           2024-01-29  5642  	if (flags & WQ_UNBOUND)
91ccc6e7233bb1 Tejun Heo           2024-01-29  5643  		wq_size = struct_size(wq, node_nr_active, nr_node_ids + 1);
91ccc6e7233bb1 Tejun Heo           2024-01-29  5644  	else
91ccc6e7233bb1 Tejun Heo           2024-01-29  5645  		wq_size = sizeof(*wq);
91ccc6e7233bb1 Tejun Heo           2024-01-29  5646  
91ccc6e7233bb1 Tejun Heo           2024-01-29  5647  	wq = kzalloc(wq_size, GFP_KERNEL);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5648  	if (!wq)
f147f29eb7c495 Tejun Heo           2013-04-01  5649  		return NULL;
6029a91829ad2b Tejun Heo           2013-04-01  5650  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5651  	if (flags & WQ_UNBOUND) {
be69d00d976957 Thomas Gleixner     2019-06-26  5652  		wq->unbound_attrs = alloc_workqueue_attrs();
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5653  		if (!wq->unbound_attrs)
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5654  			goto err_free_wq;
d2c1d40487bb18 Tejun Heo           2013-03-12  5655  	}
d2c1d40487bb18 Tejun Heo           2013-03-12  5656  
91ccc6e7233bb1 Tejun Heo           2024-01-29 @5657  	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
4c16bd327c74d6 Tejun Heo           2013-04-01  5658  
91ccc6e7233bb1 Tejun Heo           2024-01-29  5659  	if (name_len >= WQ_NAME_LEN)
91ccc6e7233bb1 Tejun Heo           2024-01-29  5660  		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
91ccc6e7233bb1 Tejun Heo           2024-01-29  5661  			     wq->name);
31c89007285d36 Audra Mitchell      2024-01-15  5662  
4cb1ef64609f9b Tejun Heo           2024-02-04  5663  	if (flags & WQ_BH) {
4cb1ef64609f9b Tejun Heo           2024-02-04  5664  		/*
4cb1ef64609f9b Tejun Heo           2024-02-04  5665  		 * BH workqueues always share a single execution context per CPU
4cb1ef64609f9b Tejun Heo           2024-02-04  5666  		 * and don't impose any max_active limit.
4cb1ef64609f9b Tejun Heo           2024-02-04  5667  		 */
4cb1ef64609f9b Tejun Heo           2024-02-04  5668  		max_active = INT_MAX;
4cb1ef64609f9b Tejun Heo           2024-02-04  5669  	} else {
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5670  		max_active = max_active ?: WQ_DFL_ACTIVE;
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5671  		max_active = wq_clamp_max_active(max_active, flags, wq->name);
4cb1ef64609f9b Tejun Heo           2024-02-04  5672  	}
4c16bd327c74d6 Tejun Heo           2013-04-01  5673  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5674  	/* init wq */
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5675  	wq->flags = flags;
a045a272d88757 Tejun Heo           2024-01-29  5676  	wq->max_active = max_active;
5797b1c18919cd Tejun Heo           2024-01-29  5677  	wq->min_active = min(max_active, WQ_DFL_MIN_ACTIVE);
5797b1c18919cd Tejun Heo           2024-01-29  5678  	wq->saved_max_active = wq->max_active;
5797b1c18919cd Tejun Heo           2024-01-29  5679  	wq->saved_min_active = wq->min_active;
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5680  	mutex_init(&wq->mutex);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5681  	atomic_set(&wq->nr_pwqs_to_flush, 0);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5682  	INIT_LIST_HEAD(&wq->pwqs);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5683  	INIT_LIST_HEAD(&wq->flusher_queue);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5684  	INIT_LIST_HEAD(&wq->flusher_overflow);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5685  	INIT_LIST_HEAD(&wq->maydays);
4c16bd327c74d6 Tejun Heo           2013-04-01  5686  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5687  	INIT_LIST_HEAD(&wq->list);
4c16bd327c74d6 Tejun Heo           2013-04-01  5688  
91ccc6e7233bb1 Tejun Heo           2024-01-29  5689  	if (flags & WQ_UNBOUND) {
91ccc6e7233bb1 Tejun Heo           2024-01-29  5690  		if (alloc_node_nr_active(wq->node_nr_active) < 0)
b188c57af2b5c1 Matthew Brost       2024-08-09  5691  			goto err_free_wq;
91ccc6e7233bb1 Tejun Heo           2024-01-29  5692  	}
91ccc6e7233bb1 Tejun Heo           2024-01-29  5693  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5694  	/*
1726a17135905e Lai Jiangshan       2024-07-04  5695  	 * wq_pool_mutex protects the workqueues list, allocations of PWQs,
aa8684755a2835 Lai Jiangshan       2024-07-16  5696  	 * and the global freeze state.
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5697  	 */
1726a17135905e Lai Jiangshan       2024-07-04  5698  	apply_wqattrs_lock();
1726a17135905e Lai Jiangshan       2024-07-04  5699  
1726a17135905e Lai Jiangshan       2024-07-04  5700  	if (alloc_and_link_pwqs(wq) < 0)
1726a17135905e Lai Jiangshan       2024-07-04  5701  		goto err_unlock_free_node_nr_active;
1befcf3073fa08 Tejun Heo           2013-04-01  5702  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5703  	mutex_lock(&wq->mutex);
a045a272d88757 Tejun Heo           2024-01-29  5704  	wq_adjust_max_active(wq);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5705  	mutex_unlock(&wq->mutex);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5706  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5707  	list_add_tail_rcu(&wq->list, &workqueues);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5708  
c5178e6ca6c806 Lai Jiangshan       2024-07-04  5709  	if (wq_online && init_rescuer(wq) < 0)
449b31ad293740 Lai Jiangshan       2024-07-04  5710  		goto err_unlock_destroy;
449b31ad293740 Lai Jiangshan       2024-07-04  5711  
449b31ad293740 Lai Jiangshan       2024-07-04  5712  	apply_wqattrs_unlock();
c5178e6ca6c806 Lai Jiangshan       2024-07-04  5713  
c3138f3881920d Lai Jiangshan       2024-07-04  5714  	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
c3138f3881920d Lai Jiangshan       2024-07-04  5715  		goto err_destroy;
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5716  
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5717  	return wq;
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5718  
1726a17135905e Lai Jiangshan       2024-07-04  5719  err_unlock_free_node_nr_active:
1726a17135905e Lai Jiangshan       2024-07-04  5720  	apply_wqattrs_unlock();
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5721  	/*
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5722  	 * Failed alloc_and_link_pwqs() may leave pending pwq->release_work,
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5723  	 * flushing the pwq_release_worker ensures that the pwq_release_workfn()
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5724  	 * completes before calling kfree(wq).
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5725  	 */
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5726  	if (wq->flags & WQ_UNBOUND) {
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5727  		kthread_flush_worker(pwq_release_worker);
91ccc6e7233bb1 Tejun Heo           2024-01-29  5728  		free_node_nr_active(wq->node_nr_active);
4e9a37389ec2d0 Lai Jiangshan       2024-07-04  5729  	}
82efcab3b9f3ef Bart Van Assche     2019-03-11  5730  err_free_wq:
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5731  	free_workqueue_attrs(wq->unbound_attrs);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5732  	kfree(wq);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5733  	return NULL;
449b31ad293740 Lai Jiangshan       2024-07-04  5734  err_unlock_destroy:
449b31ad293740 Lai Jiangshan       2024-07-04  5735  	apply_wqattrs_unlock();
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5736  err_destroy:
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5737  	destroy_workqueue(wq);
6ba94429c8e7b8 Frederic Weisbecker 2015-04-02  5738  	return NULL;
1befcf3073fa08 Tejun Heo           2013-04-01  5739  }
b188c57af2b5c1 Matthew Brost       2024-08-09  5740  

:::::: The code at line 5657 was first introduced by commit
:::::: 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5 workqueue: Introduce struct wq_node_nr_active

:::::: TO: Tejun Heo <tj@kernel.org>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

