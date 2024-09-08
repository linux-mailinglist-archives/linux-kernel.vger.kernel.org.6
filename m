Return-Path: <linux-kernel+bounces-320291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA87970868
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3582B2158D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28017279C;
	Sun,  8 Sep 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDI6fGkV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09EA36B0D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725809125; cv=none; b=jvmpk0JtVEPXlHMvbX11uRt1kjEsW+0a/qe7HvJOC+M5pg7nDPw0b5hYEt698BdQDSXuRERR3XyEj/u66Yuiy59QT9AcwbfW33cF4Gde5rctmnd6FEMATJ1cSLPvH2YBY2GirsYmIXiv6NiZhvQKV5WDi/a+8ltUuq5RrCkRCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725809125; c=relaxed/simple;
	bh=By5zUPgfL+dN0S3WzMVycd1W/qmxScpWCUYn81UoJaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HibQ3LbPVq+HdNSZ9LR/KsiFXQl7L0dxBVpAhj7QHhMXZfCXj+V+BWTDgi/VVKiJBvbyrkLAHlzKYifLd+wZuAcYKGHv0YhNbM6C45cNKYlU4gMBXerpSJ/p8EPHlrdSYwe6mdGjw7NWm1YCoTlKFOh4llkjXDTEEAcP89kBXVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDI6fGkV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725809123; x=1757345123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=By5zUPgfL+dN0S3WzMVycd1W/qmxScpWCUYn81UoJaA=;
  b=aDI6fGkV0RzqyTcK+rE+0rdcCyLmgl2sHJM3bMzS9xODjzbXQ1UddXwZ
   CFEqt5zy+b/x86xEaAivGOak3Jsdf8887ZpxO8bAfAHHuQ4rL/KiAQpOg
   PrufHw9I5FhbYrGqTiaD+2nhHt4qbTAIN6S1VmzxWykZOLKRvkxgY+40G
   bx+cNqbcp58H7U6++ff8+4hl31CBjtIO3uokO8beDJ+5UFW8vF110ZX7j
   +jBkuDZ8soeKz5fPOElkh46mHtdO4/F2bxZYsYpuSIbjzBHJuIL0QQqFs
   zqUgpubCqQrGrBVX3+GiP4ozwXpZJWq2ylsBaHSuXGxxnZxMdz8Fynnx6
   Q==;
X-CSE-ConnectionGUID: uRgySVh1QtaT9vZZe+W/3w==
X-CSE-MsgGUID: x/mOD+RnRmSrbsTJ8r8PtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="27425469"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="27425469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 08:25:22 -0700
X-CSE-ConnectionGUID: xkZQwZlKTna5gIidrpR0Rg==
X-CSE-MsgGUID: stG7cw0pSnq58gqzTlPOPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="71385024"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2024 08:25:21 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snJmw-000DeV-1K;
	Sun, 08 Sep 2024 15:25:18 +0000
Date: Sun, 8 Sep 2024 23:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: fs/netfs/objects.c:148:5-24: WARNING: atomic_dec_and_test variation
 before object free at line 150.
Message-ID: <202409082345.wiwtJarb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1f2d51b711a3b7f1ae1b46701c769c1d580fa7f
commit: f89ea63f1c65d3e93b255f14f9d9e05df87955fa netfs, 9p: Fix race between umount and async request completion
date:   3 months ago
config: x86_64-randconfig-102-20240908 (https://download.01.org/0day-ci/archive/20240908/202409082345.wiwtJarb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409082345.wiwtJarb-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/netfs/objects.c:148:5-24: WARNING: atomic_dec_and_test variation before object free at line 150.

vim +148 fs/netfs/objects.c

   123	
   124	static void netfs_free_request(struct work_struct *work)
   125	{
   126		struct netfs_io_request *rreq =
   127			container_of(work, struct netfs_io_request, work);
   128		struct netfs_inode *ictx = netfs_inode(rreq->inode);
   129		unsigned int i;
   130	
   131		trace_netfs_rreq(rreq, netfs_rreq_trace_free);
   132		netfs_proc_del_rreq(rreq);
   133		netfs_clear_subrequests(rreq, false);
   134		if (rreq->netfs_ops->free_request)
   135			rreq->netfs_ops->free_request(rreq);
   136		if (rreq->cache_resources.ops)
   137			rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
   138		if (rreq->direct_bv) {
   139			for (i = 0; i < rreq->direct_bv_count; i++) {
   140				if (rreq->direct_bv[i].bv_page) {
   141					if (rreq->direct_bv_unpin)
   142						unpin_user_page(rreq->direct_bv[i].bv_page);
   143				}
   144			}
   145			kvfree(rreq->direct_bv);
   146		}
   147	
 > 148		if (atomic_dec_and_test(&ictx->io_count))
   149			wake_up_var(&ictx->io_count);
 > 150		call_rcu(&rreq->rcu, netfs_free_request_rcu);
   151	}
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

