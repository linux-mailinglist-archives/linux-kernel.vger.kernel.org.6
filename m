Return-Path: <linux-kernel+bounces-530210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8EA43090
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E735168BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89820AF77;
	Mon, 24 Feb 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bv668jdT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0E207DFF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438840; cv=none; b=MO05hKQUVywR7hS0YASb2QthVh5x0ovEvNe0+p0+4C4r3ei1K154yEBWLOYBB9+gOFNuhIxPjb7BtHMwwOMLlqFliNDjqIKm3L96if3KKuzq86gt6K58xc5KZk+0HGOyYd8qVFfqtV1hsN7DnQmtP6UhBshLWRS0uANNIx3GIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438840; c=relaxed/simple;
	bh=NU8ghwEnANBw9tGSg50UrMsAD/8B3rrywGZnzLOm4gY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rITJe2QlffYc4dvrGUPppSWOMDbPjYS1drIsQP8ueNM0swHFXp84VXJf5EA8PkVY5eyhK13uI9vmpfL18HKQP6vTHTXsdPgfNcV2f+Ig0UoOZ+HFBQYxb0hSk41hllJIhzSobx+ZtJ0McH3M3FI9Wf+mYK/LpbgJAtR6bVH6QMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bv668jdT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740438838; x=1771974838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NU8ghwEnANBw9tGSg50UrMsAD/8B3rrywGZnzLOm4gY=;
  b=Bv668jdTZPv2HXVTvFxAU6rfJo0COucOhUfZSUNUIomn2P3AqBlFDxiJ
   EFN1YokTUPa5pL17YE5EwwsWLYTClN8eyFfkkrFr8+Abd+HBhRqwUqjRL
   ubaGlB0xO6T9+V2NLugOWD+c7FUP9Quih/Qfz2iwaxw7fRRPSqDJa2EfG
   OZCjWPu9p3lPOR7+cADRBoK6bYKSTbekCLXrrJ2q948y7yYBM5dnCo3fw
   FtS3AJNp+mSym014lz0vkRYsxr5jH9kF4JJqAKpbVe6IAD56/SUx8T5SJ
   NlztT2DZGI3VJvaCkroBf2QBvas9/b3YEYgU86vMS7DD8b93Y/FZA+g9N
   w==;
X-CSE-ConnectionGUID: BhLOAaArS3qQG1dH5CHpKA==
X-CSE-MsgGUID: 3oVl04pASJaVXUSmp+/oAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58634885"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58634885"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:13:58 -0800
X-CSE-ConnectionGUID: hU/VVwovSNO088hCm9pe/A==
X-CSE-MsgGUID: uIxEa51QSmSQkhF+6sChTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121298492"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Feb 2025 15:13:55 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmhe5-0009R5-2D;
	Mon, 24 Feb 2025 23:13:53 +0000
Date: Tue, 25 Feb 2025 07:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <kasong@tencent.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/list_lru.c:552:3-8: WARNING: NULL check before some freeing
 functions is not needed.
Message-ID: <202502250720.9ueIb7Xh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kairui,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d082ecbc71e9e0bf49883ee4afd435a77a5101b6
commit: fb56fdf8b9a2f7397f8a83dce50189f3f0cf71af mm/list_lru: split the lock to per-cgroup scope
date:   4 months ago
config: mips-randconfig-r052-20250224 (https://download.01.org/0day-ci/archive/20250225/202502250720.9ueIb7Xh-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502250720.9ueIb7Xh-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> mm/list_lru.c:552:3-8: WARNING: NULL check before some freeing functions is not needed.

vim +552 mm/list_lru.c

88f2ef73fd6649 Muchun Song      2022-03-22  508  
88f2ef73fd6649 Muchun Song      2022-03-22  509  int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
88f2ef73fd6649 Muchun Song      2022-03-22  510  			 gfp_t gfp)
88f2ef73fd6649 Muchun Song      2022-03-22  511  {
88f2ef73fd6649 Muchun Song      2022-03-22  512  	unsigned long flags;
d70110704d2d52 Muchun Song      2022-03-22  513  	struct list_lru_memcg *mlru;
28e98022b31efd Kairui Song      2024-11-05  514  	struct mem_cgroup *pos, *parent;
bbca91cca9a902 Muchun Song      2022-03-22  515  	XA_STATE(xas, &lru->xa, 0);
88f2ef73fd6649 Muchun Song      2022-03-22  516  
88f2ef73fd6649 Muchun Song      2022-03-22  517  	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
88f2ef73fd6649 Muchun Song      2022-03-22  518  		return 0;
88f2ef73fd6649 Muchun Song      2022-03-22  519  
88f2ef73fd6649 Muchun Song      2022-03-22  520  	gfp &= GFP_RECLAIM_MASK;
88f2ef73fd6649 Muchun Song      2022-03-22  521  	/*
88f2ef73fd6649 Muchun Song      2022-03-22  522  	 * Because the list_lru can be reparented to the parent cgroup's
88f2ef73fd6649 Muchun Song      2022-03-22  523  	 * list_lru, we should make sure that this cgroup and all its
d70110704d2d52 Muchun Song      2022-03-22  524  	 * ancestors have allocated list_lru_memcg.
88f2ef73fd6649 Muchun Song      2022-03-22  525  	 */
28e98022b31efd Kairui Song      2024-11-05  526  	do {
28e98022b31efd Kairui Song      2024-11-05  527  		/*
28e98022b31efd Kairui Song      2024-11-05  528  		 * Keep finding the farest parent that wasn't populated
28e98022b31efd Kairui Song      2024-11-05  529  		 * until found memcg itself.
28e98022b31efd Kairui Song      2024-11-05  530  		 */
28e98022b31efd Kairui Song      2024-11-05  531  		pos = memcg;
28e98022b31efd Kairui Song      2024-11-05  532  		parent = parent_mem_cgroup(pos);
28e98022b31efd Kairui Song      2024-11-05  533  		while (!memcg_list_lru_allocated(parent, lru)) {
28e98022b31efd Kairui Song      2024-11-05  534  			pos = parent;
28e98022b31efd Kairui Song      2024-11-05  535  			parent = parent_mem_cgroup(pos);
88f2ef73fd6649 Muchun Song      2022-03-22  536  		}
88f2ef73fd6649 Muchun Song      2022-03-22  537  
fb56fdf8b9a2f7 Kairui Song      2024-11-05  538  		mlru = memcg_init_list_lru_one(lru, gfp);
28e98022b31efd Kairui Song      2024-11-05  539  		if (!mlru)
28e98022b31efd Kairui Song      2024-11-05  540  			return -ENOMEM;
28e98022b31efd Kairui Song      2024-11-05  541  		xas_set(&xas, pos->kmemcg_id);
28e98022b31efd Kairui Song      2024-11-05  542  		do {
bbca91cca9a902 Muchun Song      2022-03-22  543  			xas_lock_irqsave(&xas, flags);
28e98022b31efd Kairui Song      2024-11-05  544  			if (!xas_load(&xas) && !css_is_dying(&pos->css)) {
bbca91cca9a902 Muchun Song      2022-03-22  545  				xas_store(&xas, mlru);
28e98022b31efd Kairui Song      2024-11-05  546  				if (!xas_error(&xas))
28e98022b31efd Kairui Song      2024-11-05  547  					mlru = NULL;
bbca91cca9a902 Muchun Song      2022-03-22  548  			}
bbca91cca9a902 Muchun Song      2022-03-22  549  			xas_unlock_irqrestore(&xas, flags);
28e98022b31efd Kairui Song      2024-11-05  550  		} while (xas_nomem(&xas, gfp));
28e98022b31efd Kairui Song      2024-11-05  551  		if (mlru)
28e98022b31efd Kairui Song      2024-11-05 @552  			kfree(mlru);
28e98022b31efd Kairui Song      2024-11-05  553  	} while (pos != memcg && !css_is_dying(&pos->css));
88f2ef73fd6649 Muchun Song      2022-03-22  554  
bbca91cca9a902 Muchun Song      2022-03-22  555  	return xas_error(&xas);
88f2ef73fd6649 Muchun Song      2022-03-22  556  }
60d3fd32a7a9da Vladimir Davydov 2015-02-12  557  #else
bbca91cca9a902 Muchun Song      2022-03-22  558  static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
60d3fd32a7a9da Vladimir Davydov 2015-02-12  559  {
60d3fd32a7a9da Vladimir Davydov 2015-02-12  560  }
60d3fd32a7a9da Vladimir Davydov 2015-02-12  561  

:::::: The code at line 552 was first introduced by commit
:::::: 28e98022b31efdb8f1ba310d938cd9b97ededfe4 mm/list_lru: simplify reparenting and initial allocation

:::::: TO: Kairui Song <kasong@tencent.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

