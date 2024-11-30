Return-Path: <linux-kernel+bounces-426425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9855F9DF2DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D42281416
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896F2146A63;
	Sat, 30 Nov 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T82/rBBu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C294139579
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732996000; cv=none; b=h2/MLN30V8c0t+dHySWgxBkAaeXMwUYtvEsTrX8IrIbGrIIbKcWIJN8RP+J0WuT4JiLG6r4CAsbgmUGJS8aop7n/RkaZF2c+1HCnd73JZplzn54Gj1aUNXqxVpADmGYoAEtrrRgvEnjOXQg9gXkc/lov1/O+gEHkgrtkVtpmP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732996000; c=relaxed/simple;
	bh=IRB3Dw911TwljM0cVNjsK6O106zwEM7+cIbWQL0xkCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dvFeHH07OOy0LqjEYYCADCjwqYKUnsn8hWBx0/8pES94oaravSOTV6V+YcerUeV0LdrvmQAwzYWAEls1V3aR6cZY4Bn1iBZzQ2cXB2OU2mr8YZMKD2BARHR8bqIBQMR1Sb53ZgvFGfB3IS10dUpPfDoheD/sQW83pWIC1iK5i5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T82/rBBu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732996000; x=1764532000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IRB3Dw911TwljM0cVNjsK6O106zwEM7+cIbWQL0xkCs=;
  b=T82/rBBun5sf9/FrFYuvmFcpLL8zSJnjjWJOW1qNOjcz00rWDbGf0sOK
   tFkm5/AayNQJJd7BrvClZ/4oyjg/ARSYTnVCJ8F8KwgI+Z9ZVBgo4ZkNk
   alHCj7BQ4YFv0HyannLSbEo5x8Px1rIF5YOTXLXRWM2nnXLe2iw196b/c
   yEk8TPEJY07QE+u0gPFMPz5tMpvkICeLyE75Zmv8f15xuFrHgdbwxogoN
   MoHg7/BhSLbwuPKI1cc8idNd/2aTEcvRA+/ClhwVSmOJaxzQptfcbNZ7v
   fq48kZL/CB0I0ljRuDRddc1cbzKqfQ/OwhZdQGNqU8PBtsL7EdvrAq2QZ
   g==;
X-CSE-ConnectionGUID: tojNPacPQGiBT2kYdvVNsQ==
X-CSE-MsgGUID: LhL5pvAgQTaYhUgWZpW87g==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="36857077"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="36857077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 11:46:39 -0800
X-CSE-ConnectionGUID: tVJC+f9fRPCwTkpwZtEb+g==
X-CSE-MsgGUID: BJyh6Ev4Qd++AeS7sWq5uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="92358805"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 Nov 2024 11:46:37 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHTQJ-0000wN-0M;
	Sat, 30 Nov 2024 19:46:35 +0000
Date: Sun, 1 Dec 2024 03:46:20 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: fs/netfs/objects.c:148:5-24: WARNING: atomic_dec_and_test variation
 before object free at line 150.
Message-ID: <202412010523.B4dXJKXN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d8b78066f4c9c8ec898bd4246fc4db31d476dd88
commit: f89ea63f1c65d3e93b255f14f9d9e05df87955fa netfs, 9p: Fix race between umount and async request completion
date:   6 months ago
config: openrisc-randconfig-r061-20241130 (https://download.01.org/0day-ci/archive/20241201/202412010523.B4dXJKXN-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412010523.B4dXJKXN-lkp@intel.com/

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

