Return-Path: <linux-kernel+bounces-517025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02FFA37B13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93767A2A68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBEE18C33B;
	Mon, 17 Feb 2025 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dw51M1Jt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96313433A8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771631; cv=none; b=Uzl063AuxCWwuwhe85vEi0oklFOIuftgP2f/BC7KpVFQYdzl8UEFutLCdR1Z7yiqQ6TieZ/E7z0zTjlKtrM3g02P8uAIyI9wYKoh/iM/rK8tFdS+knmzGgd44ZRKGa+mAw9wDXlIdbMm8Iby+K9Nu9yAJTcQMnTgUi5Tyqh/XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771631; c=relaxed/simple;
	bh=wZ+K4PWEj9jhYIVyuQBlA9/Si8EkTZ1I9vdP9JNp4As=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SxjXuqJkmDCcFrMg+7vWpI6oDjsTIut/WoIk9+DtBO2EvHhpgf2ejt8GTvv2MqLQPSsQpNuON12IKNeOTRGiycmiYpduVRwGzP8lM+pDP6MvkfwjcE8QG5QS2TUwJRHafHtt6Uei68/1qmxYQXhb5fN5/gGhFZMS7Lqd6XcMhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dw51M1Jt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739771630; x=1771307630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wZ+K4PWEj9jhYIVyuQBlA9/Si8EkTZ1I9vdP9JNp4As=;
  b=dw51M1JtkH/LtEO4pbY6D3ff42zp3WnF3p4puhuy/t95XL5tRWs8jl8R
   FxE7AZzcATo0NYyD+hfD2QLmcR6Wayl18F83UqmQ1byBPcTmoIckwF0Wa
   uyUoxpKI7gRFw93UE6QebMHOE3LzF1pxJVmb3LVwtuo/xfOpM4ARf/ZZp
   /iHAl6ynZRc4y1lnplMFS4yVYCnVqm3dw6PxoS6bOc65LVOZjTgNJixTY
   qq+gfG5DiYmNxiEhOTE3ivIpnZ8lps1WA0NbrRxCi1VxFIbreVN6jRgd6
   BjL2iZYHstF4GE20jXgL1oHeUyo1T9iCeEkvwgdnXwN9ek1PuBoahuEiZ
   g==;
X-CSE-ConnectionGUID: wvTCb4iJQyqktZnpbTYuew==
X-CSE-MsgGUID: VZJwToF+S5a0lAngBjrhLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="62912661"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="62912661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 21:53:49 -0800
X-CSE-ConnectionGUID: 1EWIo1gsSjuzmPCxmV+VWA==
X-CSE-MsgGUID: 5+uQE1YtTZa+RQGYADmjIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144941033"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Feb 2025 21:53:47 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tju4f-001CeT-1i;
	Mon, 17 Feb 2025 05:53:45 +0000
Date: Mon, 17 Feb 2025 13:53:08 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is
 never less than zero.
Message-ID: <202502171326.j4Xd3I0j-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0ad2507d5d93f39619fc42372c347d6006b64319
commit: fac69ec8cd743f509129deb5feae9e3f9ebc2cc8 xfs: simplify buffer I/O submission
date:   5 weeks ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250217/202502171326.j4Xd3I0j-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502171326.j4Xd3I0j-lkp@intel.com/

New smatch warnings:
fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
fs/xfs/xfs_linux.h:283 kmem_to_page() warn: unsigned '_x' is never less than zero.
fs/xfs/xfs_buf.c:761 xfs_buf_get_map() error: we previously assumed 'bp' could be null (see line 743)
arch/riscv/include/asm/atomic.h:218 arch_atomic_fetch_add_unless() warn: inconsistent indenting

vim +/_x +1534 fs/xfs/xfs_buf.c

  1518	
  1519	static void
  1520	xfs_buf_submit_bio(
  1521		struct xfs_buf		*bp)
  1522	{
  1523		unsigned int		size = BBTOB(bp->b_length);
  1524		unsigned int		map = 0, p;
  1525		struct blk_plug		plug;
  1526		struct bio		*bio;
  1527	
  1528		bio = bio_alloc(bp->b_target->bt_bdev, bp->b_page_count,
  1529				xfs_buf_bio_op(bp), GFP_NOIO);
  1530		bio->bi_private = bp;
  1531		bio->bi_end_io = xfs_buf_bio_end_io;
  1532	
  1533		if (bp->b_flags & _XBF_KMEM) {
> 1534			__bio_add_page(bio, virt_to_page(bp->b_addr), size,
  1535					bp->b_offset);
  1536		} else {
  1537			for (p = 0; p < bp->b_page_count; p++)
  1538				__bio_add_page(bio, bp->b_pages[p], PAGE_SIZE, 0);
  1539			bio->bi_iter.bi_size = size; /* limit to the actual size used */
  1540	
  1541			if (xfs_buf_is_vmapped(bp))
  1542				flush_kernel_vmap_range(bp->b_addr,
  1543						xfs_buf_vmap_len(bp));
  1544		}
  1545	
  1546		/*
  1547		 * If there is more than one map segment, split out a new bio for each
  1548		 * map except of the last one.  The last map is handled by the
  1549		 * remainder of the original bio outside the loop.
  1550		 */
  1551		blk_start_plug(&plug);
  1552		for (map = 0; map < bp->b_map_count - 1; map++) {
  1553			struct bio	*split;
  1554	
  1555			split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
  1556					&fs_bio_set);
  1557			split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
  1558			bio_chain(split, bio);
  1559			submit_bio(split);
  1560		}
  1561		bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
  1562		submit_bio(bio);
  1563		blk_finish_plug(&plug);
  1564	}
  1565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

