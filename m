Return-Path: <linux-kernel+bounces-516778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D2A37745
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3021890526
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8C1A08A6;
	Sun, 16 Feb 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFOgPZpc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239E199947
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735511; cv=none; b=ZSfUwqbG8yU20LsbBPssBKMAD6zCXsept9t/Wl41zw6dPFq1GbeKz+l5uixDEDvilDpP4EmRDYFlJjYkc9TnSQUhcfzkQUfJN71zt/6mBCEyZl+5KEVEM2cEjcp9IqxtJBBVnYOuMkNTwmbeQvWo07oYisKJT5NTrjOSLto95E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735511; c=relaxed/simple;
	bh=lnh/4FfD2L8HNVTk8lqOHG+hPUKVJCwEF1geb3Lp/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EpTvpdYznWP0JlBoO3wfVvHrNGP0R/AAzdd2kEjpZbQEvG8qzsIEnrbmhzlu98KqhtoQhfhttCS0X6K7NqKwzB78DfOUc5v8T0MoOJBIDkFXoECNaJi8M8EdP7PbDbXGM1/SfHnBqZAFNAxdpRouHLOxEBkHzJZQpC1GBfM70xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFOgPZpc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739735508; x=1771271508;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lnh/4FfD2L8HNVTk8lqOHG+hPUKVJCwEF1geb3Lp/NY=;
  b=lFOgPZpcDW60zZLPH6z64AUrvKqhgIH7Fjy7Z7J83DSYn2OoMf7u8Utb
   uS6ykuYCNX8zniDk0Rl7b4Lfqi9zYR93R7nY4xJyQDI9SUx0YMHyWW4cj
   2a9waHXyR8fdws/hWcdILHZTkSAEISavN/mdTqxL6Ws0E42ASXOch3BZ9
   e7SIHloFayby+4iRunUXKdCQx2k110QZywdfp75dCaF4lBTCYABLVPhBF
   T8R9DLTVXOwZ2rw8tOOwhYY1V69kXK51CVc5g5eXXjMA2cG1S5hjHxljQ
   j202IiAjRXXrDfA/bsGQLRWTIpx3HZVne8IWjkZ2i31lEvdxY6xPkCv1M
   w==;
X-CSE-ConnectionGUID: q70fuSI6RSSznPU8st1N/A==
X-CSE-MsgGUID: 1Eza3oLJS8Ge/wME7oAOZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="28017488"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="28017488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 11:51:47 -0800
X-CSE-ConnectionGUID: n58BRKQvSdeuucf+Nw7fHw==
X-CSE-MsgGUID: OE3fTuH7RfGo5NTNGkPI1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113798228"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Feb 2025 11:51:46 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjkg3-001CBT-1U;
	Sun, 16 Feb 2025 19:51:43 +0000
Date: Mon, 17 Feb 2025 03:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/md/dm-integrity.c:3212 integrity_recalc_inline() warn:
 unsigned '_x' is never less than zero.
Message-ID: <202502170319.1LAHKJlm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad1b832bf1cf2df9304f8eb72943111625c7e5a7
commit: 90da77987dd59c8f6ec6d508d23d5a77c7af64f1 dm-integrity: support recalculation in the 'I' mode
date:   5 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250217/202502170319.1LAHKJlm-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502170319.1LAHKJlm-lkp@intel.com/

New smatch warnings:
drivers/md/dm-integrity.c:3212 integrity_recalc_inline() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
drivers/md/dm-integrity.c:518 sb_mac() error: memcmp() 'actual_mac' too small (64 vs 448)
drivers/md/dm-integrity.c:2515 dm_integrity_map_inline() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:2559 dm_integrity_inline_recheck() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:2575 dm_integrity_inline_recheck() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:2530 dm_integrity_free_payload() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:3229 integrity_recalc_inline() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:3237 integrity_recalc_inline() warn: unsigned '_x' is never less than zero.
include/linux/scatterlist.h:189 sg_set_buf() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:5149 dm_integrity_ctr() warn: Function too hairy.  No more merges.

vim +/_x +3212 drivers/md/dm-integrity.c

  3148	
  3149	static void integrity_recalc_inline(struct work_struct *w)
  3150	{
  3151		struct dm_integrity_c *ic = container_of(w, struct dm_integrity_c, recalc_work);
  3152		size_t recalc_tags_size;
  3153		u8 *recalc_buffer = NULL;
  3154		u8 *recalc_tags = NULL;
  3155		struct dm_integrity_range range;
  3156		struct bio *bio;
  3157		struct bio_integrity_payload *bip;
  3158		__u8 *t;
  3159		unsigned int i;
  3160		int r;
  3161		unsigned ret;
  3162		unsigned int super_counter = 0;
  3163		unsigned recalc_sectors = RECALC_SECTORS;
  3164	
  3165	retry:
  3166		recalc_buffer = kmalloc(recalc_sectors << SECTOR_SHIFT, GFP_NOIO | __GFP_NOWARN);
  3167		if (!recalc_buffer) {
  3168	oom:
  3169			recalc_sectors >>= 1;
  3170			if (recalc_sectors >= 1U << ic->sb->log2_sectors_per_block)
  3171				goto retry;
  3172			DMCRIT("out of memory for recalculate buffer - recalculation disabled");
  3173			goto free_ret;
  3174		}
  3175	
  3176		recalc_tags_size = (recalc_sectors >> ic->sb->log2_sectors_per_block) * ic->tuple_size;
  3177		if (crypto_shash_digestsize(ic->internal_hash) > ic->tuple_size)
  3178			recalc_tags_size += crypto_shash_digestsize(ic->internal_hash) - ic->tuple_size;
  3179		recalc_tags = kmalloc(recalc_tags_size, GFP_NOIO | __GFP_NOWARN);
  3180		if (!recalc_tags) {
  3181			kfree(recalc_buffer);
  3182			recalc_buffer = NULL;
  3183			goto oom;
  3184		}
  3185	
  3186		spin_lock_irq(&ic->endio_wait.lock);
  3187	
  3188	next_chunk:
  3189		if (unlikely(dm_post_suspending(ic->ti)))
  3190			goto unlock_ret;
  3191	
  3192		range.logical_sector = le64_to_cpu(ic->sb->recalc_sector);
  3193		if (unlikely(range.logical_sector >= ic->provided_data_sectors))
  3194			goto unlock_ret;
  3195		range.n_sectors = min((sector_t)recalc_sectors, ic->provided_data_sectors - range.logical_sector);
  3196	
  3197		add_new_range_and_wait(ic, &range);
  3198		spin_unlock_irq(&ic->endio_wait.lock);
  3199	
  3200		if (unlikely(++super_counter == RECALC_WRITE_SUPER)) {
  3201			recalc_write_super(ic);
  3202			super_counter = 0;
  3203		}
  3204	
  3205		if (unlikely(dm_integrity_failed(ic)))
  3206			goto err;
  3207	
  3208		DEBUG_print("recalculating: %llx - %llx\n", range.logical_sector, range.n_sectors);
  3209	
  3210		bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_READ, GFP_NOIO, &ic->recalc_bios);
  3211		bio->bi_iter.bi_sector = ic->start + SB_SECTORS + range.logical_sector;
> 3212		__bio_add_page(bio, virt_to_page(recalc_buffer), range.n_sectors << SECTOR_SHIFT, offset_in_page(recalc_buffer));
  3213		r = submit_bio_wait(bio);
  3214		bio_put(bio);
  3215		if (unlikely(r)) {
  3216			dm_integrity_io_error(ic, "reading data", r);
  3217			goto err;
  3218		}
  3219	
  3220		t = recalc_tags;
  3221		for (i = 0; i < range.n_sectors; i += ic->sectors_per_block) {
  3222			memset(t, 0, ic->tuple_size);
  3223			integrity_sector_checksum(ic, range.logical_sector + i, recalc_buffer + (i << SECTOR_SHIFT), t);
  3224			t += ic->tuple_size;
  3225		}
  3226	
  3227		bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_WRITE, GFP_NOIO, &ic->recalc_bios);
  3228		bio->bi_iter.bi_sector = ic->start + SB_SECTORS + range.logical_sector;
  3229		__bio_add_page(bio, virt_to_page(recalc_buffer), range.n_sectors << SECTOR_SHIFT, offset_in_page(recalc_buffer));
  3230	
  3231		bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
  3232		if (unlikely(IS_ERR(bip))) {
  3233			bio_put(bio);
  3234			DMCRIT("out of memory for bio integrity payload - recalculation disabled");
  3235			goto err;
  3236		}
  3237		ret = bio_integrity_add_page(bio, virt_to_page(recalc_tags), t - recalc_tags, offset_in_page(recalc_tags));
  3238		if (unlikely(ret != t - recalc_tags)) {
  3239			bio_put(bio);
  3240			dm_integrity_io_error(ic, "attaching integrity tags", -ENOMEM);
  3241			goto err;
  3242		}
  3243	
  3244		r = submit_bio_wait(bio);
  3245		bio_put(bio);
  3246		if (unlikely(r)) {
  3247			dm_integrity_io_error(ic, "writing data", r);
  3248			goto err;
  3249		}
  3250	
  3251		cond_resched();
  3252		spin_lock_irq(&ic->endio_wait.lock);
  3253		remove_range_unlocked(ic, &range);
  3254	#ifdef CONFIG_64BIT
  3255		/* Paired with smp_load_acquire in dm_integrity_map_inline. */
  3256		smp_store_release(&ic->sb->recalc_sector, cpu_to_le64(range.logical_sector + range.n_sectors));
  3257	#else
  3258		ic->sb->recalc_sector = cpu_to_le64(range.logical_sector + range.n_sectors);
  3259	#endif
  3260		goto next_chunk;
  3261	
  3262	err:
  3263		remove_range(ic, &range);
  3264		goto free_ret;
  3265	
  3266	unlock_ret:
  3267		spin_unlock_irq(&ic->endio_wait.lock);
  3268	
  3269		recalc_write_super(ic);
  3270	
  3271	free_ret:
  3272		kfree(recalc_buffer);
  3273		kfree(recalc_tags);
  3274	}
  3275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

