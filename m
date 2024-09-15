Return-Path: <linux-kernel+bounces-329764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979049795CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08171C2033E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801E40879;
	Sun, 15 Sep 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOFBF1lZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE984374F1
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726390060; cv=none; b=GLGnnajX56ptytHTnJcb5SnlAeu8Ppg/HvvF5XfabhFV6ajSTZr9N88MpJ21Y24EEWli4lvnvwHMyF8Q+0iwU8hmpdP45UQ7wPiTe3kHxr9J67JjAEdO9/VT45UvEqKVKJcyd7ClqPz4kwFFl9ad3yeaxrg1oytTw/KUx+XCjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726390060; c=relaxed/simple;
	bh=D6GWGcMX7Zv9vf8VKlGKpdPxnM4BRSeoxRrsGiS7res=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pU5Z1HmO65rlowtivCGeNqqgB5xjLrKA+8ZixlaLF15s8Yj3flRr8y74H52kgw5lWMVmJekKHnmHx3PSrdc5xLuF1oh3qN8pyHc7YxS3xi+MnKNz8aqsoGqlGFz6Yz6wByxrCh0MHTRkJsFgJd1Hagyr6NVYnohU0IsyYB4+eBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOFBF1lZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726390059; x=1757926059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D6GWGcMX7Zv9vf8VKlGKpdPxnM4BRSeoxRrsGiS7res=;
  b=QOFBF1lZ5Mvym73TWaJ4pYa2jy5LRhzjco3kyA3I7Cb2pFHFl28X21RD
   yq0YF/56YnOiI2vRBPoQPsg8EWzvZ5tqwfFr1B/lL38wpx9OpF9g5In5k
   w2+GiIzKkYQpqtzPrdQDe0iQuZgZYwhfI/sx0sYEI4fDhzX7aPBVtMH42
   /dhgEkfur3gZOfYox/sbwj+k5TyiaT5pVfmA4JClYsZstxjji+0xCieCD
   3jRk5CmsGrmFES/1JBBxxhluZ0q76fLUdlv1OzTq1SpVN+VGuM3ktGrpn
   PXg+QW6mJ5rkrw46o+ZxOQfangLZXd7fO23ITVbNIuHvMrxXFZao99R6p
   Q==;
X-CSE-ConnectionGUID: vDCxZ4uvT96dgmnAUUsWsA==
X-CSE-MsgGUID: W89rrgVBTXaqogm3tDg3+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="47757914"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="47757914"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 01:47:38 -0700
X-CSE-ConnectionGUID: fTGYWZOoRxKNiWTXtwxd5A==
X-CSE-MsgGUID: sc0dm/VPSauHpq0YjwMZRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="72967430"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 Sep 2024 01:47:37 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spkut-0008XS-10;
	Sun, 15 Sep 2024 08:47:35 +0000
Date: Sun, 15 Sep 2024 16:47:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/io-wq.c:401:6-25: WARNING: atomic_dec_and_test variation
 before object free at line 408.
Message-ID: <202409151605.9zKulYo3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: ed29b0b4fd835b058ddd151c49d021e28d631ee6 io_uring: move to separate directory
date:   2 years, 2 months ago
config: i386-randconfig-052-20240915 (https://download.01.org/0day-ci/archive/20240915/202409151605.9zKulYo3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409151605.9zKulYo3-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> io_uring/io-wq.c:401:6-25: WARNING: atomic_dec_and_test variation before object free at line 408.

vim +401 io_uring/io-wq.c

685fe7feedb967 fs/io-wq.c Jens Axboe 2021-03-08  392  
958234d5ec9321 fs/io-wq.c Jens Axboe 2021-02-17  393  static void io_wqe_dec_running(struct io_worker *worker)
c5def4ab849494 fs/io-wq.c Jens Axboe 2019-11-07  394  {
958234d5ec9321 fs/io-wq.c Jens Axboe 2021-02-17  395  	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
958234d5ec9321 fs/io-wq.c Jens Axboe 2021-02-17  396  	struct io_wqe *wqe = worker->wqe;
c5def4ab849494 fs/io-wq.c Jens Axboe 2019-11-07  397  
685fe7feedb967 fs/io-wq.c Jens Axboe 2021-03-08  398  	if (!(worker->flags & IO_WORKER_F_UP))
685fe7feedb967 fs/io-wq.c Jens Axboe 2021-03-08  399  		return;
685fe7feedb967 fs/io-wq.c Jens Axboe 2021-03-08  400  
42abc95f05bff5 fs/io-wq.c Hao Xu     2022-02-06 @401  	if (!atomic_dec_and_test(&acct->nr_running))
42abc95f05bff5 fs/io-wq.c Hao Xu     2022-02-06  402  		return;
e13fb1fe1483f6 fs/io-wq.c Hao Xu     2022-02-06  403  	if (!io_acct_run_queue(acct))
42abc95f05bff5 fs/io-wq.c Hao Xu     2022-02-06  404  		return;
42abc95f05bff5 fs/io-wq.c Hao Xu     2022-02-06  405  
685fe7feedb967 fs/io-wq.c Jens Axboe 2021-03-08  406  	atomic_inc(&acct->nr_running);
685fe7feedb967 fs/io-wq.c Jens Axboe 2021-03-08  407  	atomic_inc(&wqe->wq->worker_refs);
3146cba99aa284 fs/io-wq.c Jens Axboe 2021-09-01 @408  	io_queue_worker_create(worker, acct, create_worker_cb);
c5def4ab849494 fs/io-wq.c Jens Axboe 2019-11-07  409  }
c5def4ab849494 fs/io-wq.c Jens Axboe 2019-11-07  410  

:::::: The code at line 401 was first introduced by commit
:::::: 42abc95f05bff5180ac40c7ba5726b73c1d5e2f4 io-wq: decouple work_list protection from the big wqe->lock

:::::: TO: Hao Xu <haoxu@linux.alibaba.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

