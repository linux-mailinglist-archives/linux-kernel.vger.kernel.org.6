Return-Path: <linux-kernel+bounces-220486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F117D90E256
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B581F22629
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E333CC2;
	Wed, 19 Jun 2024 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cklgkSUF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E261DDF5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718771625; cv=none; b=chYyerHm9KUCBIi1dnXaud2bqw9tcHd3uRpHjb+yc71LymN9lwp8HVpIZVXhWwMgIbV6L2vH2okYmUFQGhTJ4HOWKi4CBvY2eB+7UGBrgS733hoNDkRyTa0jLo8D1M9d7LQ5UCHT5WQhjTez1aVfk3eSZl/U1CCyhxgdGAk2WMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718771625; c=relaxed/simple;
	bh=VGZJiAFJAqXfJBqJMs76AsYIPeLVd4IvB4ptQsOCzIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ntL7/zIomFC6Kw8Rkt3V1nMO9Ys6BvIa3IRu3Hd120cIku5rc+4RG0jSJJ9Bl5bAZ6XKFTRkHHg2XF5if4z3fKFjwLnT3RqDiy1VvHsvTx23WbQgCVyLSa6r6rJ0ktFmExuUWsAJNAYlJJ3tIs5xiE1la19w/dgKT2ZWI7bMes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cklgkSUF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718771623; x=1750307623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VGZJiAFJAqXfJBqJMs76AsYIPeLVd4IvB4ptQsOCzIU=;
  b=cklgkSUFj7oqJrCBIlse6VSbBzefvi9bX49Tt5OLjpz4Pl+PlOx8RvLM
   Zhr9SYjqUmgYiJBV8jZeLgz/zCVUl6g7mhsElzloCEO0jupNYTVYkwXoc
   r+BEiFPz8sC1X/GtbYLYhrZRV3I00/AAgw29x2pIoIzwuW+UWFK38BQQZ
   MpBuTIeam40EKNUQCZX+H1JbbasIKsbygN4i5ukCiuj3nDH01KDrOfdoq
   SsNu1nAW8mYK+2NvHZFGeXsR7d3Tt4tthB203C0Qo7dsrOV7JJ544bizr
   MIeB0j/2rPCKME8qSNvJl17B/LnGUrfZqQTUwLN7DlQfYeoO9+jWZP9Wp
   Q==;
X-CSE-ConnectionGUID: ZAEN5BXwQkSKwVL/JLrQug==
X-CSE-MsgGUID: Qo28L+wDRm28TH3tvHrRCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26369440"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="26369440"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 21:33:42 -0700
X-CSE-ConnectionGUID: rsJV3hRgT2Wxwkvl9w2n0Q==
X-CSE-MsgGUID: PPOXf1fLStKHOe4eByYB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="65020273"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Jun 2024 21:33:41 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJn0t-0006Hu-0F;
	Wed, 19 Jun 2024 04:33:39 +0000
Date: Wed, 19 Jun 2024 12:33:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/backpointers.c:396:21: warning: 'bucket.offset' is used
 uninitialized
Message-ID: <202406191248.wSUI6f8j-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92e5605a199efbaee59fb19e15d6cc2103a04ec2
commit: 633cf069445d95384d88e9ff40f395c001f8b2b7 bcachefs: Kill bch2_dev_bkey_exists() in backpointer code
date:   6 weeks ago
config: um-randconfig-r081-20240305 (https://download.01.org/0day-ci/archive/20240619/202406191248.wSUI6f8j-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191248.wSUI6f8j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191248.wSUI6f8j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/bcachefs/backpointers.c: In function 'bch2_check_btree_backpointer':
>> fs/bcachefs/backpointers.c:396:21: warning: 'bucket.offset' is used uninitialized [-Wuninitialized]
     396 |         struct bpos bucket;
         |                     ^~~~~~


vim +396 fs/bcachefs/backpointers.c

   386	
   387	static int bch2_check_btree_backpointer(struct btree_trans *trans, struct btree_iter *bp_iter,
   388						struct bkey_s_c k)
   389	{
   390		struct bch_fs *c = trans->c;
   391		struct btree_iter alloc_iter = { NULL };
   392		struct bkey_s_c alloc_k;
   393		struct printbuf buf = PRINTBUF;
   394		int ret = 0;
   395	
 > 396		struct bpos bucket;
   397		if (!bp_pos_to_bucket_nodev_noerror(c, k.k->p, &bucket)) {
   398			if (fsck_err(c, backpointer_to_missing_device,
   399				     "backpointer for missing device:\n%s",
   400				     (bch2_bkey_val_to_text(&buf, c, k), buf.buf)))
   401				ret = bch2_btree_delete_at(trans, bp_iter, 0);
   402			goto out;
   403		}
   404	
   405		alloc_k = bch2_bkey_get_iter(trans, &alloc_iter, BTREE_ID_alloc, bucket, 0);
   406		ret = bkey_err(alloc_k);
   407		if (ret)
   408			goto out;
   409	
   410		if (fsck_err_on(alloc_k.k->type != KEY_TYPE_alloc_v4, c,
   411				backpointer_to_missing_alloc,
   412				"backpointer for nonexistent alloc key: %llu:%llu:0\n%s",
   413				alloc_iter.pos.inode, alloc_iter.pos.offset,
   414				(bch2_bkey_val_to_text(&buf, c, k), buf.buf))) {
   415			ret = bch2_btree_delete_at(trans, bp_iter, 0);
   416			goto out;
   417		}
   418	out:
   419	fsck_err:
   420		bch2_trans_iter_exit(trans, &alloc_iter);
   421		printbuf_exit(&buf);
   422		return ret;
   423	}
   424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

