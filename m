Return-Path: <linux-kernel+bounces-436734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFE9E8A12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEF41885478
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F837F477;
	Mon,  9 Dec 2024 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dowID7qf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA03E47B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716868; cv=none; b=nNglZlH91E/OEESCxTKq6xVQgc0Nh1Zhiy4H6xUMZBRp8gwJduuvsveoQwtrR0gZsBSYZLkgwfN5OtnhkRZdT4eJJ5mzZ9Y1g5mAU1Xpmkj7t++ThprygZLorQ6fs18dyjM/vHIw7LMjEdnuTp7LSu1y6sVBiJJLU/fH2C7dT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716868; c=relaxed/simple;
	bh=V+YdMaJPLJrDjJ6KaNcDxTWkDIAP8zxo9clj2Ks/oa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VvRRArw19Rwa5fh0iaUqWwumBJjQvOm8iLpzvhOSukyDuKaR9YJIQG7CwP20hzHEWJGIrLRKABjiXVNiLMy4Tx42PePMErlayH81iVF5Vpl2LV+VIxJTWHuw+LnxseTlqzQByjWbpzqPh7sh3OMzgatOSva17nhYt+F4t9HSg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dowID7qf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733716866; x=1765252866;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V+YdMaJPLJrDjJ6KaNcDxTWkDIAP8zxo9clj2Ks/oa8=;
  b=dowID7qfsWzk//EzXnCGZcoRLn1sGdhXMhUWXvTIb4cVtCxaukphJN6H
   KzRVlXxmYj1bKBsBw3QSKfOwok5SIFCnUnC3eYE2nwlixE02lgUE15mdu
   KwN8OBj9m1KCafpd791UdTMaUfDE0k6T5IpTRzMUKf+SAtaJ4e90PwprE
   otfTnnL/bTWMGLaCTThXT9WdwBaP2aUgJDUifhZG3+2pcEMfuguokHbny
   WVC1GjkGLWHQ7Ph0KEPjcRwTwXXx6Z3yH47Vhh+e7NSwql+JZ1V1QcVhi
   qiBiSkil/LtgGKhVGajjWI/78u7gNwBYnhlbibh/CovBer0LCfd/t7JYp
   A==;
X-CSE-ConnectionGUID: JeaT88/ERBOP8wv+oz4qzg==
X-CSE-MsgGUID: imlTw+rySp2hF0/IImAPrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="21589796"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="21589796"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:01:05 -0800
X-CSE-ConnectionGUID: wOAf+bbJQwuScR53R0G2lQ==
X-CSE-MsgGUID: CxV1/FXDQYCdj3J27wa/WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125839459"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Dec 2024 20:01:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUxB-0003mA-23;
	Mon, 09 Dec 2024 04:01:01 +0000
Date: Mon, 9 Dec 2024 12:00:15 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>
Subject: drivers/md/bcache/super.c:108:14: sparse: sparse: restricted __le64
 degrades to integer
Message-ID: <202412071044.tthTVBw4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: a702a692cd7559053ea573f4e2c84828f0e62824 bcache: use a separate data structure for the on-disk super block
date:   4 years, 10 months ago
config: x86_64-randconfig-r133-20240105 (https://download.01.org/0day-ci/archive/20241207/202412071044.tthTVBw4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071044.tthTVBw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071044.tthTVBw4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/md/bcache/super.c:108:24: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int nr_keys @@     got restricted __le16 [usertype] keys @@
   drivers/md/bcache/super.c:108:24: sparse:     expected unsigned int nr_keys
   drivers/md/bcache/super.c:108:24: sparse:     got restricted __le16 [usertype] keys
>> drivers/md/bcache/super.c:108:14: sparse: sparse: restricted __le64 degrades to integer
   drivers/md/bcache/super.c:237:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int nr_keys @@     got restricted __le16 [usertype] keys @@
   drivers/md/bcache/super.c:237:21: sparse:     expected unsigned int nr_keys
   drivers/md/bcache/super.c:237:21: sparse:     got restricted __le16 [usertype] keys
>> drivers/md/bcache/super.c:237:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] csum @@     got unsigned long long @@
   drivers/md/bcache/super.c:237:19: sparse:     expected restricted __le64 [usertype] csum
   drivers/md/bcache/super.c:237:19: sparse:     got unsigned long long
   drivers/md/bcache/super.c: note: in included file (through drivers/md/bcache/bcache.h):
   include/uapi/linux/bcache.h:345:38: sparse: sparse: array of flexible structures
   drivers/md/bcache/super.c:574:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] prio @@     got restricted __le16 [usertype] @@
   drivers/md/bcache/super.c:574:33: sparse:     expected unsigned short [usertype] prio
   drivers/md/bcache/super.c:574:33: sparse:     got restricted __le16 [usertype]
   drivers/md/bcache/super.c:642:27: sparse: sparse: cast to restricted __le16
   drivers/md/bcache/super.c:744:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] invalidated @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:744:32: sparse:     expected unsigned int [usertype] invalidated
   drivers/md/bcache/super.c:744:32: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c:1104:26: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] rtime @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:1104:26: sparse:     expected unsigned int [usertype] rtime
   drivers/md/bcache/super.c:1104:26: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c:1148:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] invalidated @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:1148:32: sparse:     expected unsigned int [usertype] invalidated
   drivers/md/bcache/super.c:1148:32: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c:1502:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] last_reg @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:1502:36: sparse:     expected unsigned int [usertype] last_reg
   drivers/md/bcache/super.c:1502:36: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c: note: in included file (through drivers/md/bcache/bcache.h):
   drivers/md/bcache/bset.h:231:36: sparse: sparse: array of flexible structures

vim +108 drivers/md/bcache/super.c

cafe563591446cf Kent Overstreet   2013-03-23   61  
cafe563591446cf Kent Overstreet   2013-03-23   62  static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
cafe563591446cf Kent Overstreet   2013-03-23   63  			      struct page **res)
cafe563591446cf Kent Overstreet   2013-03-23   64  {
cafe563591446cf Kent Overstreet   2013-03-23   65  	const char *err;
a702a692cd75590 Christoph Hellwig 2020-01-24   66  	struct cache_sb_disk *s;
cafe563591446cf Kent Overstreet   2013-03-23   67  	struct buffer_head *bh = __bread(bdev, 1, SB_SIZE);
6f10f7d1b02b1bb Coly Li           2018-08-11   68  	unsigned int i;
cafe563591446cf Kent Overstreet   2013-03-23   69  
cafe563591446cf Kent Overstreet   2013-03-23   70  	if (!bh)
cafe563591446cf Kent Overstreet   2013-03-23   71  		return "IO error";
cafe563591446cf Kent Overstreet   2013-03-23   72  
a702a692cd75590 Christoph Hellwig 2020-01-24   73  	s = (struct cache_sb_disk *)bh->b_data;
cafe563591446cf Kent Overstreet   2013-03-23   74  
cafe563591446cf Kent Overstreet   2013-03-23   75  	sb->offset		= le64_to_cpu(s->offset);
cafe563591446cf Kent Overstreet   2013-03-23   76  	sb->version		= le64_to_cpu(s->version);
cafe563591446cf Kent Overstreet   2013-03-23   77  
cafe563591446cf Kent Overstreet   2013-03-23   78  	memcpy(sb->magic,	s->magic, 16);
cafe563591446cf Kent Overstreet   2013-03-23   79  	memcpy(sb->uuid,	s->uuid, 16);
cafe563591446cf Kent Overstreet   2013-03-23   80  	memcpy(sb->set_uuid,	s->set_uuid, 16);
cafe563591446cf Kent Overstreet   2013-03-23   81  	memcpy(sb->label,	s->label, SB_LABEL_SIZE);
cafe563591446cf Kent Overstreet   2013-03-23   82  
cafe563591446cf Kent Overstreet   2013-03-23   83  	sb->flags		= le64_to_cpu(s->flags);
cafe563591446cf Kent Overstreet   2013-03-23   84  	sb->seq			= le64_to_cpu(s->seq);
cafe563591446cf Kent Overstreet   2013-03-23   85  	sb->last_mount		= le32_to_cpu(s->last_mount);
cafe563591446cf Kent Overstreet   2013-03-23   86  	sb->first_bucket	= le16_to_cpu(s->first_bucket);
cafe563591446cf Kent Overstreet   2013-03-23   87  	sb->keys		= le16_to_cpu(s->keys);
cafe563591446cf Kent Overstreet   2013-03-23   88  
cafe563591446cf Kent Overstreet   2013-03-23   89  	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
cafe563591446cf Kent Overstreet   2013-03-23   90  		sb->d[i] = le64_to_cpu(s->d[i]);
cafe563591446cf Kent Overstreet   2013-03-23   91  
cafe563591446cf Kent Overstreet   2013-03-23   92  	pr_debug("read sb version %llu, flags %llu, seq %llu, journal size %u",
cafe563591446cf Kent Overstreet   2013-03-23   93  		 sb->version, sb->flags, sb->seq, sb->keys);
cafe563591446cf Kent Overstreet   2013-03-23   94  
aaf8dbeab586572 Coly Li           2019-11-13   95  	err = "Not a bcache superblock (bad offset)";
cafe563591446cf Kent Overstreet   2013-03-23   96  	if (sb->offset != SB_SECTOR)
cafe563591446cf Kent Overstreet   2013-03-23   97  		goto err;
cafe563591446cf Kent Overstreet   2013-03-23   98  
aaf8dbeab586572 Coly Li           2019-11-13   99  	err = "Not a bcache superblock (bad magic)";
cafe563591446cf Kent Overstreet   2013-03-23  100  	if (memcmp(sb->magic, bcache_magic, 16))
cafe563591446cf Kent Overstreet   2013-03-23  101  		goto err;
cafe563591446cf Kent Overstreet   2013-03-23  102  
cafe563591446cf Kent Overstreet   2013-03-23  103  	err = "Too many journal buckets";
cafe563591446cf Kent Overstreet   2013-03-23  104  	if (sb->keys > SB_JOURNAL_BUCKETS)
cafe563591446cf Kent Overstreet   2013-03-23  105  		goto err;
cafe563591446cf Kent Overstreet   2013-03-23  106  
cafe563591446cf Kent Overstreet   2013-03-23  107  	err = "Bad checksum";
cafe563591446cf Kent Overstreet   2013-03-23 @108  	if (s->csum != csum_set(s))
cafe563591446cf Kent Overstreet   2013-03-23  109  		goto err;
cafe563591446cf Kent Overstreet   2013-03-23  110  
cafe563591446cf Kent Overstreet   2013-03-23  111  	err = "Bad UUID";
169ef1cf6171d35 Kent Overstreet   2013-03-28  112  	if (bch_is_zero(sb->uuid, 16))
cafe563591446cf Kent Overstreet   2013-03-23  113  		goto err;
cafe563591446cf Kent Overstreet   2013-03-23  114  
8abb2a5dbadab91 Kent Overstreet   2013-04-23  115  	sb->block_size	= le16_to_cpu(s->block_size);
8abb2a5dbadab91 Kent Overstreet   2013-04-23  116  
8abb2a5dbadab91 Kent Overstreet   2013-04-23  117  	err = "Superblock block size smaller than device block size";
8abb2a5dbadab91 Kent Overstreet   2013-04-23  118  	if (sb->block_size << 9 < bdev_logical_block_size(bdev))
8abb2a5dbadab91 Kent Overstreet   2013-04-23  119  		goto err;
8abb2a5dbadab91 Kent Overstreet   2013-04-23  120  
2903381fce71004 Kent Overstreet   2013-04-11  121  	switch (sb->version) {
2903381fce71004 Kent Overstreet   2013-04-11  122  	case BCACHE_SB_VERSION_BDEV:
2903381fce71004 Kent Overstreet   2013-04-11  123  		sb->data_offset	= BDEV_DATA_START_DEFAULT;
2903381fce71004 Kent Overstreet   2013-04-11  124  		break;
2903381fce71004 Kent Overstreet   2013-04-11  125  	case BCACHE_SB_VERSION_BDEV_WITH_OFFSET:
2903381fce71004 Kent Overstreet   2013-04-11  126  		sb->data_offset	= le64_to_cpu(s->data_offset);
cafe563591446cf Kent Overstreet   2013-03-23  127  
2903381fce71004 Kent Overstreet   2013-04-11  128  		err = "Bad data offset";
2903381fce71004 Kent Overstreet   2013-04-11  129  		if (sb->data_offset < BDEV_DATA_START_DEFAULT)
cafe563591446cf Kent Overstreet   2013-03-23  130  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  131  
2903381fce71004 Kent Overstreet   2013-04-11  132  		break;
2903381fce71004 Kent Overstreet   2013-04-11  133  	case BCACHE_SB_VERSION_CDEV:
2903381fce71004 Kent Overstreet   2013-04-11  134  	case BCACHE_SB_VERSION_CDEV_WITH_UUID:
2903381fce71004 Kent Overstreet   2013-04-11  135  		sb->nbuckets	= le64_to_cpu(s->nbuckets);
2903381fce71004 Kent Overstreet   2013-04-11  136  		sb->bucket_size	= le16_to_cpu(s->bucket_size);
2903381fce71004 Kent Overstreet   2013-04-11  137  
2903381fce71004 Kent Overstreet   2013-04-11  138  		sb->nr_in_set	= le16_to_cpu(s->nr_in_set);
2903381fce71004 Kent Overstreet   2013-04-11  139  		sb->nr_this_dev	= le16_to_cpu(s->nr_this_dev);
2903381fce71004 Kent Overstreet   2013-04-11  140  
cafe563591446cf Kent Overstreet   2013-03-23  141  		err = "Too many buckets";
cafe563591446cf Kent Overstreet   2013-03-23  142  		if (sb->nbuckets > LONG_MAX)
cafe563591446cf Kent Overstreet   2013-03-23  143  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  144  
cafe563591446cf Kent Overstreet   2013-03-23  145  		err = "Not enough buckets";
cafe563591446cf Kent Overstreet   2013-03-23  146  		if (sb->nbuckets < 1 << 7)
cafe563591446cf Kent Overstreet   2013-03-23  147  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  148  
2903381fce71004 Kent Overstreet   2013-04-11  149  		err = "Bad block/bucket size";
2903381fce71004 Kent Overstreet   2013-04-11  150  		if (!is_power_of_2(sb->block_size) ||
2903381fce71004 Kent Overstreet   2013-04-11  151  		    sb->block_size > PAGE_SECTORS ||
2903381fce71004 Kent Overstreet   2013-04-11  152  		    !is_power_of_2(sb->bucket_size) ||
2903381fce71004 Kent Overstreet   2013-04-11  153  		    sb->bucket_size < PAGE_SECTORS)
2903381fce71004 Kent Overstreet   2013-04-11  154  			goto err;
2903381fce71004 Kent Overstreet   2013-04-11  155  
cafe563591446cf Kent Overstreet   2013-03-23  156  		err = "Invalid superblock: device too small";
b0d30981c05f32d Coly Li           2018-08-11  157  		if (get_capacity(bdev->bd_disk) <
b0d30981c05f32d Coly Li           2018-08-11  158  		    sb->bucket_size * sb->nbuckets)
cafe563591446cf Kent Overstreet   2013-03-23  159  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  160  
cafe563591446cf Kent Overstreet   2013-03-23  161  		err = "Bad UUID";
169ef1cf6171d35 Kent Overstreet   2013-03-28  162  		if (bch_is_zero(sb->set_uuid, 16))
cafe563591446cf Kent Overstreet   2013-03-23  163  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  164  
cafe563591446cf Kent Overstreet   2013-03-23  165  		err = "Bad cache device number in set";
cafe563591446cf Kent Overstreet   2013-03-23  166  		if (!sb->nr_in_set ||
cafe563591446cf Kent Overstreet   2013-03-23  167  		    sb->nr_in_set <= sb->nr_this_dev ||
cafe563591446cf Kent Overstreet   2013-03-23  168  		    sb->nr_in_set > MAX_CACHES_PER_SET)
cafe563591446cf Kent Overstreet   2013-03-23  169  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  170  
cafe563591446cf Kent Overstreet   2013-03-23  171  		err = "Journal buckets not sequential";
cafe563591446cf Kent Overstreet   2013-03-23  172  		for (i = 0; i < sb->keys; i++)
cafe563591446cf Kent Overstreet   2013-03-23  173  			if (sb->d[i] != sb->first_bucket + i)
cafe563591446cf Kent Overstreet   2013-03-23  174  				goto err;
cafe563591446cf Kent Overstreet   2013-03-23  175  
cafe563591446cf Kent Overstreet   2013-03-23  176  		err = "Too many journal buckets";
cafe563591446cf Kent Overstreet   2013-03-23  177  		if (sb->first_bucket + sb->keys > sb->nbuckets)
cafe563591446cf Kent Overstreet   2013-03-23  178  			goto err;
cafe563591446cf Kent Overstreet   2013-03-23  179  
cafe563591446cf Kent Overstreet   2013-03-23  180  		err = "Invalid superblock: first bucket comes before end of super";
cafe563591446cf Kent Overstreet   2013-03-23  181  		if (sb->first_bucket * sb->bucket_size < 16)
cafe563591446cf Kent Overstreet   2013-03-23  182  			goto err;
2903381fce71004 Kent Overstreet   2013-04-11  183  
2903381fce71004 Kent Overstreet   2013-04-11  184  		break;
2903381fce71004 Kent Overstreet   2013-04-11  185  	default:
2903381fce71004 Kent Overstreet   2013-04-11  186  		err = "Unsupported superblock version";
2903381fce71004 Kent Overstreet   2013-04-11  187  		goto err;
2903381fce71004 Kent Overstreet   2013-04-11  188  	}
2903381fce71004 Kent Overstreet   2013-04-11  189  
75cbb3f1d840429 Arnd Bergmann     2018-07-26  190  	sb->last_mount = (u32)ktime_get_real_seconds();
cafe563591446cf Kent Overstreet   2013-03-23  191  	err = NULL;
cafe563591446cf Kent Overstreet   2013-03-23  192  
cafe563591446cf Kent Overstreet   2013-03-23  193  	get_page(bh->b_page);
cafe563591446cf Kent Overstreet   2013-03-23  194  	*res = bh->b_page;
cafe563591446cf Kent Overstreet   2013-03-23  195  err:
cafe563591446cf Kent Overstreet   2013-03-23  196  	put_bh(bh);
cafe563591446cf Kent Overstreet   2013-03-23  197  	return err;
cafe563591446cf Kent Overstreet   2013-03-23  198  }
cafe563591446cf Kent Overstreet   2013-03-23  199  
4246a0b63bd8f56 Christoph Hellwig 2015-07-20  200  static void write_bdev_super_endio(struct bio *bio)
cafe563591446cf Kent Overstreet   2013-03-23  201  {
cafe563591446cf Kent Overstreet   2013-03-23  202  	struct cached_dev *dc = bio->bi_private;
08ec1e6282f2716 Coly Li           2019-06-28  203  
08ec1e6282f2716 Coly Li           2019-06-28  204  	if (bio->bi_status)
08ec1e6282f2716 Coly Li           2019-06-28  205  		bch_count_backing_io_errors(dc, bio);
cafe563591446cf Kent Overstreet   2013-03-23  206  
cb7a583e6a6ace6 Kent Overstreet   2013-12-16  207  	closure_put(&dc->sb_write);
cafe563591446cf Kent Overstreet   2013-03-23  208  }
cafe563591446cf Kent Overstreet   2013-03-23  209  
cafe563591446cf Kent Overstreet   2013-03-23  210  static void __write_super(struct cache_sb *sb, struct bio *bio)
cafe563591446cf Kent Overstreet   2013-03-23  211  {
a702a692cd75590 Christoph Hellwig 2020-01-24  212  	struct cache_sb_disk *out = page_address(bio_first_page_all(bio));
6f10f7d1b02b1bb Coly Li           2018-08-11  213  	unsigned int i;
cafe563591446cf Kent Overstreet   2013-03-23  214  
4f024f3797c43cb Kent Overstreet   2013-10-11  215  	bio->bi_iter.bi_sector	= SB_SECTOR;
4f024f3797c43cb Kent Overstreet   2013-10-11  216  	bio->bi_iter.bi_size	= SB_SIZE;
ad0d9e76a412470 Mike Christie     2016-06-05  217  	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC|REQ_META);
169ef1cf6171d35 Kent Overstreet   2013-03-28  218  	bch_bio_map(bio, NULL);
cafe563591446cf Kent Overstreet   2013-03-23  219  
cafe563591446cf Kent Overstreet   2013-03-23  220  	out->offset		= cpu_to_le64(sb->offset);
cafe563591446cf Kent Overstreet   2013-03-23  221  	out->version		= cpu_to_le64(sb->version);
cafe563591446cf Kent Overstreet   2013-03-23  222  
cafe563591446cf Kent Overstreet   2013-03-23  223  	memcpy(out->uuid,	sb->uuid, 16);
cafe563591446cf Kent Overstreet   2013-03-23  224  	memcpy(out->set_uuid,	sb->set_uuid, 16);
cafe563591446cf Kent Overstreet   2013-03-23  225  	memcpy(out->label,	sb->label, SB_LABEL_SIZE);
cafe563591446cf Kent Overstreet   2013-03-23  226  
cafe563591446cf Kent Overstreet   2013-03-23  227  	out->flags		= cpu_to_le64(sb->flags);
cafe563591446cf Kent Overstreet   2013-03-23  228  	out->seq		= cpu_to_le64(sb->seq);
cafe563591446cf Kent Overstreet   2013-03-23  229  
cafe563591446cf Kent Overstreet   2013-03-23  230  	out->last_mount		= cpu_to_le32(sb->last_mount);
cafe563591446cf Kent Overstreet   2013-03-23  231  	out->first_bucket	= cpu_to_le16(sb->first_bucket);
cafe563591446cf Kent Overstreet   2013-03-23  232  	out->keys		= cpu_to_le16(sb->keys);
cafe563591446cf Kent Overstreet   2013-03-23  233  
cafe563591446cf Kent Overstreet   2013-03-23  234  	for (i = 0; i < sb->keys; i++)
cafe563591446cf Kent Overstreet   2013-03-23  235  		out->d[i] = cpu_to_le64(sb->d[i]);
cafe563591446cf Kent Overstreet   2013-03-23  236  
cafe563591446cf Kent Overstreet   2013-03-23 @237  	out->csum = csum_set(out);
cafe563591446cf Kent Overstreet   2013-03-23  238  
cafe563591446cf Kent Overstreet   2013-03-23  239  	pr_debug("ver %llu, flags %llu, seq %llu",
cafe563591446cf Kent Overstreet   2013-03-23  240  		 sb->version, sb->flags, sb->seq);
cafe563591446cf Kent Overstreet   2013-03-23  241  
4e49ea4a3d27636 Mike Christie     2016-06-05  242  	submit_bio(bio);
cafe563591446cf Kent Overstreet   2013-03-23  243  }
cafe563591446cf Kent Overstreet   2013-03-23  244  

:::::: The code at line 108 was first introduced by commit
:::::: cafe563591446cf80bfbc2fe3bc72a2e36cf1060 bcache: A block layer cache

:::::: TO: Kent Overstreet <koverstreet@google.com>
:::::: CC: Kent Overstreet <koverstreet@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

