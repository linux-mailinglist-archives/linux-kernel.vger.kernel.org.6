Return-Path: <linux-kernel+bounces-516499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C33A37293
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B6C18904C2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA45158DD9;
	Sun, 16 Feb 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCkmv//k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF13151991
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695005; cv=none; b=jisd79s7UffD4QL43XD3CokfRVdSbJtGVACvunpjDogPzPsPFDfNKVNeWWDXE8OfFHaSzscz8I/Ze8VaOBr52iH8+dE5Phsvx6cap6xrph96JV8lyXunKrrBfZnNILOdfMQO2v22ponzzRR8k3h2JHbNCIwPpi8hvphc42iRIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695005; c=relaxed/simple;
	bh=B7H8nX851YpwT9OHvCmngzSlPCFhFwcwGq8/g4kXvcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i7LVy/76TUM6sw/fuLsL30aytzgMf9jlYay37R/ipjxLag4HpSRM1rquJ19SbR1Yl3QkoSttbJPR1sR3fxKcBp5afRxaU/PSEeJYwx/OCYWee5MoxedXiYicEHeN/AATqdaXwcCTMwkksZrSfC6RzU/z98YUP1aBpNDgppA74JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCkmv//k; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739695003; x=1771231003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B7H8nX851YpwT9OHvCmngzSlPCFhFwcwGq8/g4kXvcY=;
  b=BCkmv//k0R2w85p0wwFGhRb0LoCaeD0XOHgcybC+Ihyy0EVTHKeZZIJ8
   RFrSdI9OmV5qzdDO8rYmmQm1zWSTDl4PqCUoPLI4Juc0S2QBRUh1C1x7N
   jxT5LX/C0oM5Ui5Y6SGZlhRHtXDSCMpOYxl0xx2Avog51I7fJjk+R848P
   NhhJBPCzCVUc3LzcGOVNGUCCQprFnKotrRi3PS6mS4nQ1sKqznAO4jpuT
   2vd/ls5d8fMQN2ki9pHKBPuN0VEDjnOh9aPkjlqwQBM7jZqFATSWY5j+f
   EkGj/C9MFVtOgpgxb3ttkFlzuzJK464WuiVFuetmU6RJ2fasiPAKGQyWK
   Q==;
X-CSE-ConnectionGUID: 6PwBqd2HT+2OMgU4cNmCqQ==
X-CSE-MsgGUID: qUrW5MeCT6yoxZjz+LXAhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57927433"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57927433"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 00:36:43 -0800
X-CSE-ConnectionGUID: tFALWGZLTE+qZ1hKt7Mf1g==
X-CSE-MsgGUID: D+Lf3bFZSjOxCJEx5Y1okA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114741292"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Feb 2025 00:36:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tja8k-001BiZ-2k;
	Sun, 16 Feb 2025 08:36:38 +0000
Date: Sun, 16 Feb 2025 16:36:28 +0800
From: kernel test robot <lkp@intel.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: drivers/md/dm-integrity.c:2470 dm_integrity_map_inline() warn:
 unsigned '_x' is never less than zero.
Message-ID: <202502161654.6egvP8G4-lkp@intel.com>
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
commit: fb0987682c629c1d2c476f35f6fde405a5e304a4 dm-integrity: introduce the Inline mode
date:   7 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502161654.6egvP8G4-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502161654.6egvP8G4-lkp@intel.com/

New smatch warnings:
drivers/md/dm-integrity.c:2470 dm_integrity_map_inline() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:2514 dm_integrity_inline_recheck() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:2485 dm_integrity_free_payload() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
drivers/md/dm-integrity.c:515 sb_mac() error: memcmp() 'actual_mac' too small (64 vs 448)
drivers/md/dm-integrity.c:2530 dm_integrity_inline_recheck() warn: unsigned '_x' is never less than zero.
include/linux/scatterlist.h:189 sg_set_buf() warn: unsigned '_x' is never less than zero.
drivers/md/dm-integrity.c:4718 dm_integrity_ctr() warn: add some parenthesis here?
drivers/md/dm-integrity.c:4941 dm_integrity_ctr() warn: Function too hairy.  No more merges.

vim +/_x +2470 drivers/md/dm-integrity.c

  2397	
  2398	static int dm_integrity_map_inline(struct dm_integrity_io *dio)
  2399	{
  2400		struct dm_integrity_c *ic = dio->ic;
  2401		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
  2402		struct bio_integrity_payload *bip;
  2403		unsigned payload_len, digest_size, extra_size, ret;
  2404	
  2405		dio->integrity_payload = NULL;
  2406		dio->integrity_payload_from_mempool = false;
  2407	
  2408		if (unlikely(bio_integrity(bio))) {
  2409			bio->bi_status = BLK_STS_NOTSUPP;
  2410			bio_endio(bio);
  2411			return DM_MAPIO_SUBMITTED;
  2412		}
  2413	
  2414		bio_set_dev(bio, ic->dev->bdev);
  2415		if (unlikely((bio->bi_opf & REQ_PREFLUSH) != 0))
  2416			return DM_MAPIO_REMAPPED;
  2417	
  2418	retry:
  2419		payload_len = ic->tuple_size * (bio_sectors(bio) >> ic->sb->log2_sectors_per_block);
  2420		digest_size = crypto_shash_digestsize(ic->internal_hash);
  2421		extra_size = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
  2422		payload_len += extra_size;
  2423		dio->integrity_payload = kmalloc(payload_len, GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
  2424		if (unlikely(!dio->integrity_payload)) {
  2425			const unsigned x_size = PAGE_SIZE << 1;
  2426			if (payload_len > x_size) {
  2427				unsigned sectors = ((x_size - extra_size) / ic->tuple_size) << ic->sb->log2_sectors_per_block;
  2428				if (WARN_ON(!sectors || sectors >= bio_sectors(bio))) {
  2429					bio->bi_status = BLK_STS_NOTSUPP;
  2430					bio_endio(bio);
  2431					return DM_MAPIO_SUBMITTED;
  2432				}
  2433				dm_accept_partial_bio(bio, sectors);
  2434				goto retry;
  2435			}
  2436			dio->integrity_payload = page_to_virt((struct page *)mempool_alloc(&ic->recheck_pool, GFP_NOIO));
  2437			dio->integrity_payload_from_mempool = true;
  2438		}
  2439	
  2440		bio->bi_iter.bi_sector = dm_target_offset(ic->ti, bio->bi_iter.bi_sector);
  2441		dio->bio_details.bi_iter = bio->bi_iter;
  2442	
  2443		if (unlikely(!dm_integrity_check_limits(ic, bio->bi_iter.bi_sector, bio))) {
  2444			return DM_MAPIO_KILL;
  2445		}
  2446	
  2447		bio->bi_iter.bi_sector += ic->start + SB_SECTORS;
  2448	
  2449		bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
  2450		if (unlikely(IS_ERR(bip))) {
  2451			bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
  2452			bio_endio(bio);
  2453			return DM_MAPIO_SUBMITTED;
  2454		}
  2455	
  2456		if (dio->op == REQ_OP_WRITE) {
  2457			unsigned pos = 0;
  2458			while (dio->bio_details.bi_iter.bi_size) {
  2459				struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
  2460				const char *mem = bvec_kmap_local(&bv);
  2461				if (ic->tag_size < ic->tuple_size)
  2462					memset(dio->integrity_payload + pos + ic->tag_size, 0, ic->tuple_size - ic->tuple_size);
  2463				integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem, dio->integrity_payload + pos);
  2464				kunmap_local(mem);
  2465				pos += ic->tuple_size;
  2466				bio_advance_iter_single(bio, &dio->bio_details.bi_iter, ic->sectors_per_block << SECTOR_SHIFT);
  2467			}
  2468		}
  2469	
> 2470		ret = bio_integrity_add_page(bio, virt_to_page(dio->integrity_payload),
  2471						payload_len, offset_in_page(dio->integrity_payload));
  2472		if (unlikely(ret != payload_len)) {
  2473			bio->bi_status = BLK_STS_RESOURCE;
  2474			bio_endio(bio);
  2475			return DM_MAPIO_SUBMITTED;
  2476		}
  2477	
  2478		return DM_MAPIO_REMAPPED;
  2479	}
  2480	
  2481	static inline void dm_integrity_free_payload(struct dm_integrity_io *dio)
  2482	{
  2483		struct dm_integrity_c *ic = dio->ic;
  2484		if (unlikely(dio->integrity_payload_from_mempool))
> 2485			mempool_free(virt_to_page(dio->integrity_payload), &ic->recheck_pool);
  2486		else
  2487			kfree(dio->integrity_payload);
  2488		dio->integrity_payload = NULL;
  2489		dio->integrity_payload_from_mempool = false;
  2490	}
  2491	
  2492	static void dm_integrity_inline_recheck(struct work_struct *w)
  2493	{
  2494		struct dm_integrity_io *dio = container_of(w, struct dm_integrity_io, work);
  2495		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
  2496		struct dm_integrity_c *ic = dio->ic;
  2497		struct bio *outgoing_bio;
  2498		void *outgoing_data;
  2499	
  2500		dio->integrity_payload = page_to_virt((struct page *)mempool_alloc(&ic->recheck_pool, GFP_NOIO));
  2501		dio->integrity_payload_from_mempool = true;
  2502	
  2503		outgoing_data = dio->integrity_payload + PAGE_SIZE;
  2504	
  2505		while (dio->bio_details.bi_iter.bi_size) {
  2506			char digest[HASH_MAX_DIGESTSIZE];
  2507			int r;
  2508			struct bio_integrity_payload *bip;
  2509			struct bio_vec bv;
  2510			char *mem;
  2511	
  2512			outgoing_bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_READ, GFP_NOIO, &ic->recheck_bios);
  2513	
> 2514			r = bio_add_page(outgoing_bio, virt_to_page(outgoing_data), ic->sectors_per_block << SECTOR_SHIFT, 0);
  2515			if (unlikely(r != (ic->sectors_per_block << SECTOR_SHIFT))) {
  2516				bio_put(outgoing_bio);
  2517				bio->bi_status = BLK_STS_RESOURCE;
  2518				bio_endio(bio);
  2519				return;
  2520			}
  2521	
  2522			bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
  2523			if (unlikely(IS_ERR(bip))) {
  2524				bio_put(outgoing_bio);
  2525				bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
  2526				bio_endio(bio);
  2527				return;
  2528			}
  2529	
  2530			r = bio_integrity_add_page(outgoing_bio, virt_to_page(dio->integrity_payload), ic->tuple_size, 0);
  2531			if (unlikely(r != ic->tuple_size)) {
  2532				bio_put(outgoing_bio);
  2533				bio->bi_status = BLK_STS_RESOURCE;
  2534				bio_endio(bio);
  2535				return;
  2536			}
  2537	
  2538			outgoing_bio->bi_iter.bi_sector = dio->bio_details.bi_iter.bi_sector + ic->start + SB_SECTORS;
  2539	
  2540			r = submit_bio_wait(outgoing_bio);
  2541			if (unlikely(r != 0)) {
  2542				bio_put(outgoing_bio);
  2543				bio->bi_status = errno_to_blk_status(r);
  2544				bio_endio(bio);
  2545				return;
  2546			}
  2547			bio_put(outgoing_bio);
  2548	
  2549			integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, outgoing_data, digest);
  2550			if (unlikely(memcmp(digest, dio->integrity_payload, min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
  2551				DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
  2552					ic->dev->bdev, dio->bio_details.bi_iter.bi_sector);
  2553				atomic64_inc(&ic->number_of_mismatches);
  2554				dm_audit_log_bio(DM_MSG_PREFIX, "integrity-checksum",
  2555					bio, dio->bio_details.bi_iter.bi_sector, 0);
  2556	
  2557				bio->bi_status = BLK_STS_PROTECTION;
  2558				bio_endio(bio);
  2559				return;
  2560			}
  2561	
  2562			bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
  2563			mem = bvec_kmap_local(&bv);
  2564			memcpy(mem, outgoing_data, ic->sectors_per_block << SECTOR_SHIFT);
  2565			kunmap_local(mem);
  2566	
  2567			bio_advance_iter_single(bio, &dio->bio_details.bi_iter, ic->sectors_per_block << SECTOR_SHIFT);
  2568		}
  2569	
  2570		bio_endio(bio);
  2571	}
  2572	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

