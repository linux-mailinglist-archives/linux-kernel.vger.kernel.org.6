Return-Path: <linux-kernel+bounces-191083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9E8D0651
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2302C1F238C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D18D529;
	Mon, 27 May 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXEariW8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3711640B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824277; cv=none; b=Le0XDqxfYb/28g5mw+xU9SP0oaYeL9PjkqKYdjm+dS7kwugMFWajHflBcK2O+EWIcdaryaLfmaMKogvC2TtPFiiWj3/PtIi1d9dU/UVkducB6suNQuP4RtTEf+fBb6Kj8dvfACmShY28EcssSeYPd0a1DdEEpNn5O7X3Q4pd7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824277; c=relaxed/simple;
	bh=1FHv8VqjTK+OQiuHJUmQHzqF2Yzw88THTiswU3Z+Hu4=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=biBbE/6ko7o9HBKUVy4DdByLhHXdNP4IpdNWDPgqEEPVI2JVKWQUKirQP294CuKeb+lJF/AEkadBro2dOH23uk1vITadhnEXkn0dQeZCA+5/pmAJ9v+ymmIzPypO21nubjxFyeYH9SqCqBnjPG5foeoAe3zO9NaTljbWzpmzzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXEariW8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716824275; x=1748360275;
  h=date:from:cc:subject:message-id:mime-version;
  bh=1FHv8VqjTK+OQiuHJUmQHzqF2Yzw88THTiswU3Z+Hu4=;
  b=TXEariW821Nl+Xjwddnwqka/zLcneG7X0rxIX93uz2VtgXZ68ymdg5Ly
   xHC3A1Yz3QvYfKDiNe+hw0K5iBTivoTdBAz9JDKEfoJtBb2oTxrUAGXDM
   cV01mvKzNSdBuU+dtPd8A/9VmX7fsbBWJsui53jv/tAMsEUlDoUvck9Cf
   cRCByHbpps4OGnb4oSrUJGiwTv8TpMeBC9v9bcDRZliclXAtDKVcq9HdZ
   E/Tgk1ZS2okNlXxk0XuoWq1/afdH8k9VtbHUtLkdzpq/N6AEyhLMJMdSl
   U08s3U+5fFPKkZbpFdaVqaOZMU8WSAYMisu6JFh1rwocc0n1dbmSMG0k4
   A==;
X-CSE-ConnectionGUID: jdNERxuESV6ym2pddcEWFg==
X-CSE-MsgGUID: IgrqxyisTy2jLnlF4WfEhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16103320"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16103320"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 08:37:55 -0700
X-CSE-ConnectionGUID: rnhvKdY+RAGcX+08y8ASGg==
X-CSE-MsgGUID: AhzGe1mfRVyhOixuFB+PTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39199054"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 08:37:53 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBcQ3-000An9-1w;
	Mon, 27 May 2024 15:37:51 +0000
Date: Mon, 27 May 2024 23:37:17 +0800
From: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: drivers/md/dm-vdo/int-map.c:85: error: Cannot parse struct or union!
Message-ID: <202405272334.ExNaB8F6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
commit: 0d21364c6e8dc1f62c34bbc49d49935c8b01844c Merge drm/drm-next into drm-misc-next
date:   8 weeks ago
config: sparc64-allyesconfig (https://download.01.org/0day-ci/archive/20240527/202405272334.ExNaB8F6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405272334.ExNaB8F6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405272334.ExNaB8F6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/md/dm-vdo/int-map.c:85: error: Cannot parse struct or union!
   drivers/md/dm-vdo/int-map.c:103: warning: Function parameter or struct member 'bucket_count' not described in 'int_map'
   drivers/md/dm-vdo/int-map.c:328: warning: Function parameter or struct member '__always_unused' not described in 'search_hop_list'
   drivers/md/dm-vdo/int-map.c:328: warning: Excess function parameter 'map' description in 'search_hop_list'
   drivers/md/dm-vdo/int-map.c:459: warning: Function parameter or struct member '__always_unused' not described in 'move_empty_bucket'
   drivers/md/dm-vdo/int-map.c:459: warning: Excess function parameter 'map' description in 'move_empty_bucket'


vim +85 drivers/md/dm-vdo/int-map.c

cc46b9554b3f6d Matthew Sakai 2023-11-16  64  
cc46b9554b3f6d Matthew Sakai 2023-11-16  65  /**
cc46b9554b3f6d Matthew Sakai 2023-11-16  66   * struct bucket - hash bucket
cc46b9554b3f6d Matthew Sakai 2023-11-16  67   *
cc46b9554b3f6d Matthew Sakai 2023-11-16  68   * Buckets are packed together to reduce memory usage and improve cache efficiency. It would be
cc46b9554b3f6d Matthew Sakai 2023-11-16  69   * tempting to encode the hop offsets separately and maintain alignment of key/value pairs, but
cc46b9554b3f6d Matthew Sakai 2023-11-16  70   * it's crucial to keep the hop fields near the buckets that they use them so they'll tend to share
cc46b9554b3f6d Matthew Sakai 2023-11-16  71   * cache lines.
cc46b9554b3f6d Matthew Sakai 2023-11-16  72   */
cc46b9554b3f6d Matthew Sakai 2023-11-16  73  struct __packed bucket {
cc46b9554b3f6d Matthew Sakai 2023-11-16  74  	/**
cc46b9554b3f6d Matthew Sakai 2023-11-16  75  	 * @first_hop: The biased offset of the first entry in the hop list of the neighborhood
cc46b9554b3f6d Matthew Sakai 2023-11-16  76  	 *             that hashes to this bucket.
cc46b9554b3f6d Matthew Sakai 2023-11-16  77  	 */
cc46b9554b3f6d Matthew Sakai 2023-11-16  78  	u8 first_hop;
cc46b9554b3f6d Matthew Sakai 2023-11-16  79  	/** @next_hop: The biased offset of the next bucket in the hop list. */
cc46b9554b3f6d Matthew Sakai 2023-11-16  80  	u8 next_hop;
cc46b9554b3f6d Matthew Sakai 2023-11-16  81  	/** @key: The key stored in this bucket. */
cc46b9554b3f6d Matthew Sakai 2023-11-16  82  	u64 key;
cc46b9554b3f6d Matthew Sakai 2023-11-16  83  	/** @value: The value stored in this bucket (NULL if empty). */
cc46b9554b3f6d Matthew Sakai 2023-11-16  84  	void *value;
cc46b9554b3f6d Matthew Sakai 2023-11-16 @85  };
cc46b9554b3f6d Matthew Sakai 2023-11-16  86  

:::::: The code at line 85 was first introduced by commit
:::::: cc46b9554b3f6d2f09b1111386b2706e5b4f56c8 dm vdo: add basic hash map data structures

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

