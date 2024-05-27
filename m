Return-Path: <linux-kernel+bounces-191380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7468D0E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D8F1F21EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6A16086C;
	Mon, 27 May 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HttzYzSD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398A10A0C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716840179; cv=none; b=LKz4MkX4ipELWoXdoq+QI9dbZvnI+gh8+bYaYg1u8eztvF4+vGaBxj/+Plm3lYDNwYdX16RqPWlbg7DyY9mc7uCwECsZb1tb+CL92jpBYurIHCRRM2tZBPbZcl6/h0WDsU9KO6QXz1ybRk2urXrpiNyWD1PC+WZQV/KPlsfvgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716840179; c=relaxed/simple;
	bh=cal7mG0qUZDbQaDkg8S5M7WXgm8vuqmTCMSvfQjBd84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CIbO9v95+qI3xJ0QultGXonORvAYGJcAimgiljm0vZ+w6OfHnbg1kttXlfugS1kaLtL9tWfkPfj9Wb2CGI3j6a4oanGMoCzE02kix99ZOsNGh0xC9rrMnZBH/WfboTTMJp673eJ0X4Vuty6QAJCN0gYEOMMHLHnlYUO1cOA7aIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HttzYzSD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716840177; x=1748376177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cal7mG0qUZDbQaDkg8S5M7WXgm8vuqmTCMSvfQjBd84=;
  b=HttzYzSD2+JV+JpxljWFkW0rMJySdd0Un7/bY+Uq2JOGK1CE9Ue7nOr4
   dBK5EDBT85xqsS4HUnfEvZ99ar8WCSom+5OtH5cCv5RBsnQp1com0iY5B
   7iaMBU0U0pvrmJ5RiiLzWKaHOjv24B4b6D/OoxAX/Juq+Hx1GCrUzXuif
   NEMykNxnKIy8UzPa2vJJRcVRzI5z2iHOBL6fbT2d8Q+8o6mmD5udeXhMu
   ErV05LgefSSYymbHVIn9R670BJrqxA5H+udAgDwoasJHFncQF2ENFSxd3
   S6qCg13PHvh7jl7mFqf307SDnabLmEZcnuRCWlSacOT84S5YYJ+7+yz47
   g==;
X-CSE-ConnectionGUID: 5hk7/ydWToeqDRl0wUUPtw==
X-CSE-MsgGUID: JKMQQKvDQmWKkA5zULz8Vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38551854"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="38551854"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 13:02:56 -0700
X-CSE-ConnectionGUID: OvQQXpLfRQuX6VE8i4kLfQ==
X-CSE-MsgGUID: 7hyXouXUT0eYX5P46h8/3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34737795"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 27 May 2024 13:02:55 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBgYV-000B2t-36;
	Mon, 27 May 2024 20:02:52 +0000
Date: Tue, 28 May 2024 04:02:40 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/int-map.c:87: error: Cannot parse struct or union!
Message-ID: <202405280322.DuFLX7rb-lkp@intel.com>
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
head:   2bfcfd584ff5ccc8bb7acde19b42570414bf880b
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   3 months ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240528/202405280322.DuFLX7rb-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405280322.DuFLX7rb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405280322.DuFLX7rb-lkp@intel.com/

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

