Return-Path: <linux-kernel+bounces-251757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7901B93096C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AAB2816B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C359433C7;
	Sun, 14 Jul 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiVLUTGY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109319BC6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720947671; cv=none; b=t4kGAtoi0s8AutoMWiKXqFVtiPB3Ou49sIjafgckCRipK8XVkyxpG5s2MNpFBmWfOWHFqSr3DC2b83zCsz8j/C5MbUkjRQvg7QRiEsYJFqiaM4qpEC+CXhzKf6rqr1LgOWbQGfhxjePDry/aR7sKpW5iLZyTP/tkYdNw1LM2Pu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720947671; c=relaxed/simple;
	bh=92Y3V7fwM4zBxyAa9oU0gZDJTo7MajOnuhjTb47y0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qOm2AornzhgEO/aljHQyrWNPQej7Ik/axGr8FoR5ckiccdNkGrk+SrRfFDFgKgJLmdX06Hw6VWocdalPQ2LdBkeTOKIPw6kInpXuXVYBHmLPK29yj7lpPtGYfAR6ly4NyfMHwPKEb6GWAz0LLYyHs9A7NY8ZAzZpD6UGWBEARfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiVLUTGY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720947670; x=1752483670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=92Y3V7fwM4zBxyAa9oU0gZDJTo7MajOnuhjTb47y0uk=;
  b=kiVLUTGY3+kPqQlzRQHmV72IdkV+nFqXTM1B749s+X3EF/FTEYi2kyrW
   CNoGC6v97iUEmLoCh49DLggZ4X51/Jj1mkMBs0vEfrUrOjbq3UlE+Sayp
   8yA3ZX+uE/NuqFSbcKuq76+ocRa+toAHaQmBNZZt7IxIx9E3T7JHRDiaC
   z2UWm8mA2mA59p/Nso9hZWKUxFrqrkdxqE6H0oiOeDrxH+mELzUsVIwH6
   NyxbZUf7Ngn/8u7RbLY8YGX/PuYZ0VVk8gSeuGtrlLrH1kFpaBPc5piFr
   JKMZT8/OaG4cPAAFu5oY/IZ+wTNODx6LzqxW4XsLS53oiBslP2BwKOeLq
   A==;
X-CSE-ConnectionGUID: SxhS3MWdRbmdpm7X+lSa8g==
X-CSE-MsgGUID: BJLd8zDpQ8aqAtgZbOWeSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18185942"
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="18185942"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 02:01:10 -0700
X-CSE-ConnectionGUID: 1dvZQbTITp2oSKyBsNhW3Q==
X-CSE-MsgGUID: Yz2fVHMrSte02N6Fj+fmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="53700863"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Jul 2024 02:01:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSv6P-000dHR-2Z;
	Sun, 14 Jul 2024 09:01:05 +0000
Date: Sun, 14 Jul 2024 17:00:08 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/int-map.c:87: error: Cannot parse struct or union!
Message-ID: <202407141607.M3E2XQ0Z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d145e3f830ba2c2745b42bfba5c2f8fcb8d078a
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   5 months ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240714/202407141607.M3E2XQ0Z-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240714/202407141607.M3E2XQ0Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407141607.M3E2XQ0Z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/md/dm-vdo/int-map.c:87: error: Cannot parse struct or union!
   drivers/md/dm-vdo/int-map.c:105: warning: Function parameter or struct member 'bucket_count' not described in 'int_map'
   drivers/md/dm-vdo/int-map.c:330: warning: Function parameter or struct member '__always_unused' not described in 'search_hop_list'
   drivers/md/dm-vdo/int-map.c:330: warning: Excess function parameter 'map' description in 'search_hop_list'
   drivers/md/dm-vdo/int-map.c:461: warning: Function parameter or struct member '__always_unused' not described in 'move_empty_bucket'
   drivers/md/dm-vdo/int-map.c:461: warning: Excess function parameter 'map' description in 'move_empty_bucket'


vim +87 drivers/md/dm-vdo/int-map.c

cc46b9554b3f6d Matthew Sakai 2023-11-16  66  
cc46b9554b3f6d Matthew Sakai 2023-11-16  67  /**
cc46b9554b3f6d Matthew Sakai 2023-11-16  68   * struct bucket - hash bucket
cc46b9554b3f6d Matthew Sakai 2023-11-16  69   *
cc46b9554b3f6d Matthew Sakai 2023-11-16  70   * Buckets are packed together to reduce memory usage and improve cache efficiency. It would be
cc46b9554b3f6d Matthew Sakai 2023-11-16  71   * tempting to encode the hop offsets separately and maintain alignment of key/value pairs, but
cc46b9554b3f6d Matthew Sakai 2023-11-16  72   * it's crucial to keep the hop fields near the buckets that they use them so they'll tend to share
cc46b9554b3f6d Matthew Sakai 2023-11-16  73   * cache lines.
cc46b9554b3f6d Matthew Sakai 2023-11-16  74   */
cc46b9554b3f6d Matthew Sakai 2023-11-16  75  struct __packed bucket {
cc46b9554b3f6d Matthew Sakai 2023-11-16  76  	/**
cc46b9554b3f6d Matthew Sakai 2023-11-16  77  	 * @first_hop: The biased offset of the first entry in the hop list of the neighborhood
cc46b9554b3f6d Matthew Sakai 2023-11-16  78  	 *             that hashes to this bucket.
cc46b9554b3f6d Matthew Sakai 2023-11-16  79  	 */
cc46b9554b3f6d Matthew Sakai 2023-11-16  80  	u8 first_hop;
cc46b9554b3f6d Matthew Sakai 2023-11-16  81  	/** @next_hop: The biased offset of the next bucket in the hop list. */
cc46b9554b3f6d Matthew Sakai 2023-11-16  82  	u8 next_hop;
cc46b9554b3f6d Matthew Sakai 2023-11-16  83  	/** @key: The key stored in this bucket. */
cc46b9554b3f6d Matthew Sakai 2023-11-16  84  	u64 key;
cc46b9554b3f6d Matthew Sakai 2023-11-16  85  	/** @value: The value stored in this bucket (NULL if empty). */
cc46b9554b3f6d Matthew Sakai 2023-11-16  86  	void *value;
cc46b9554b3f6d Matthew Sakai 2023-11-16 @87  };
cc46b9554b3f6d Matthew Sakai 2023-11-16  88  

:::::: The code at line 87 was first introduced by commit
:::::: cc46b9554b3f6d2f09b1111386b2706e5b4f56c8 dm vdo: add basic hash map data structures

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

