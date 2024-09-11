Return-Path: <linux-kernel+bounces-325103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBD975509
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0EB24739
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B1199949;
	Wed, 11 Sep 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZGqhAG3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF7199945
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063863; cv=none; b=OfYETFTCoDq35053ue5B6sKjH8Jfzl+129jbG81FQUVSg5HWtTbM7gBHAMKpR20+HQh/KJmPF/bfmXMlQUlGUfEUPATTdlsgGXuzdCHznp+9wVMEWUlq959B+8PNyp9+I7DyjDbV5NCyjNyioNWNBtI9hK5cU8c8th8DqS2OV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063863; c=relaxed/simple;
	bh=9tw1+iLY2kTmeUQ/0QtPt8432I09fVnoFeUzde+RJp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD9nM6peD02Y3KRku418tEzbbmmfqRhjGPIDJzTSr8+OgWY2IXpu4craI8Gxhxwh/zXAMRR/AUhLJgShNTPW32YJLNAFrL+1iAtLbPZ56NaQyoW0hhqcb3sVZ/WkqVQIwC+6W9EjZimMF2PRtNrR+PMxmyk5JOBgmsQ98x1+22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZGqhAG3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726063862; x=1757599862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9tw1+iLY2kTmeUQ/0QtPt8432I09fVnoFeUzde+RJp0=;
  b=gZGqhAG36FHBEcPcNsWkrS65M2iC2wIBzN30tBpOmFio5lkSuVUaW+5H
   ANxl4eHAlHBIirrchzI+Gafqle0ISzmjDCnCGycmaj9XMT5Fv+5uIhNro
   hPnecZhTnEBHXAZL7JY1PhVvsawbOAzk8GAqlbkULONiANaJvGD/TCIxA
   s6nD3vGzmCS0JIMLrdJyhmX0Y35aAMQHv+pL5R1IXpurDT0X8dGZz+2p3
   /MOLilK3PiIRRMCqG/0LjZ7HFOBXGAvgKtgwb5epZ9KcBIIY7uuSNj1wv
   z4kt/nsh5xvOPAYNsMSJTY1DbY6jm6ZBbEpebFmgAlaY49Sr57rl74+wj
   A==;
X-CSE-ConnectionGUID: 5R6hYompTSOS/O+aIlpbag==
X-CSE-MsgGUID: EFtSGkdvT0KhpCbRanwu2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36253984"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="36253984"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 07:10:59 -0700
X-CSE-ConnectionGUID: bsnscet1QvOPxlsrHaRnlA==
X-CSE-MsgGUID: 9NS2CHacTC2gMGQHEWahZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67001193"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Sep 2024 07:10:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soO3a-0003gc-31;
	Wed, 11 Sep 2024 14:10:54 +0000
Date: Wed, 11 Sep 2024 22:10:28 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 7/7] vhost: Add new UAPI to support change to task mode
Message-ID: <202409112119.BJdqPVTC-lkp@intel.com>
References: <20240909013531.1243525-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909013531.1243525-8-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.11-rc7 next-20240911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-module_param-for-enable-kthread/20240909-093852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240909013531.1243525-8-lulu%40redhat.com
patch subject: [PATCH v1 7/7] vhost: Add new UAPI to support change to task mode
config: arc-randconfig-001-20240911 (https://download.01.org/0day-ci/archive/20240911/202409112119.BJdqPVTC-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409112119.BJdqPVTC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409112119.BJdqPVTC-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vhost/vhost.c: In function 'vhost_worker_queue':
   drivers/vhost/vhost.c:273:13: error: 'use_kthread' undeclared (first use in this function)
     273 |         if (use_kthread) {
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c:273:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/vhost/vhost.c: In function 'vhost_workers_free':
   drivers/vhost/vhost.c:805:13: error: 'use_kthread' undeclared (first use in this function)
     805 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_worker_create':
   drivers/vhost/vhost.c:986:13: error: 'use_kthread' undeclared (first use in this function)
     986 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_free_worker':
   drivers/vhost/vhost.c:1030:13: error: 'use_kthread' undeclared (first use in this function)
    1030 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_dev_ioctl':
>> drivers/vhost/vhost.c:2358:37: error: 'kthread' undeclared (first use in this function); did you mean 'kthreadd'?
    2358 |                 if (copy_from_user(&kthread, argp, sizeof(enforce_task))) {
         |                                     ^~~~~~~
         |                                     kthreadd
   drivers/vhost/vhost.c:2362:17: error: 'use_kthread' undeclared (first use in this function)
    2362 |                 use_kthread = enforce_task;
         |                 ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_worker_create':
   drivers/vhost/vhost.c:990:1: warning: control reaches end of non-void function [-Wreturn-type]
     990 | }
         | ^


vim +2358 drivers/vhost/vhost.c

  2337	
  2338	/* Caller must have device mutex */
  2339	long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
  2340	{
  2341		struct eventfd_ctx *ctx;
  2342		u64 p;
  2343		long r = 0;
  2344		int i, fd;
  2345		bool enforce_task;
  2346	
  2347		/* If you are not the owner, you can become one */
  2348		if (ioctl == VHOST_SET_OWNER) {
  2349			r = vhost_dev_set_owner(d);
  2350			goto done;
  2351		}
  2352		if (ioctl == VHOST_SET_ENFORCE_TASK) {
  2353			/* Is there an owner already? */
  2354			if (vhost_dev_has_owner(d)) {
  2355				r = -EBUSY;
  2356				goto done;
  2357			}
> 2358			if (copy_from_user(&kthread, argp, sizeof(enforce_task))) {
  2359				r = -EFAULT;
  2360				goto done;
  2361			}
  2362			use_kthread = enforce_task;
  2363			goto done;
  2364		}
  2365	
  2366		/* You must be the owner to do anything else */
  2367		r = vhost_dev_check_owner(d);
  2368		if (r)
  2369			goto done;
  2370	
  2371		switch (ioctl) {
  2372		case VHOST_SET_MEM_TABLE:
  2373			r = vhost_set_memory(d, argp);
  2374			break;
  2375		case VHOST_SET_LOG_BASE:
  2376			if (copy_from_user(&p, argp, sizeof p)) {
  2377				r = -EFAULT;
  2378				break;
  2379			}
  2380			if ((u64)(unsigned long)p != p) {
  2381				r = -EFAULT;
  2382				break;
  2383			}
  2384			for (i = 0; i < d->nvqs; ++i) {
  2385				struct vhost_virtqueue *vq;
  2386				void __user *base = (void __user *)(unsigned long)p;
  2387				vq = d->vqs[i];
  2388				mutex_lock(&vq->mutex);
  2389				/* If ring is inactive, will check when it's enabled. */
  2390				if (vq->private_data && !vq_log_access_ok(vq, base))
  2391					r = -EFAULT;
  2392				else
  2393					vq->log_base = base;
  2394				mutex_unlock(&vq->mutex);
  2395			}
  2396			break;
  2397		case VHOST_SET_LOG_FD:
  2398			r = get_user(fd, (int __user *)argp);
  2399			if (r < 0)
  2400				break;
  2401			ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
  2402			if (IS_ERR(ctx)) {
  2403				r = PTR_ERR(ctx);
  2404				break;
  2405			}
  2406			swap(ctx, d->log_ctx);
  2407			for (i = 0; i < d->nvqs; ++i) {
  2408				mutex_lock(&d->vqs[i]->mutex);
  2409				d->vqs[i]->log_ctx = d->log_ctx;
  2410				mutex_unlock(&d->vqs[i]->mutex);
  2411			}
  2412			if (ctx)
  2413				eventfd_ctx_put(ctx);
  2414			break;
  2415		default:
  2416			r = -ENOIOCTLCMD;
  2417			break;
  2418		}
  2419	done:
  2420		return r;
  2421	}
  2422	EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
  2423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

