Return-Path: <linux-kernel+bounces-517259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E699A37E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59A716B11E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3649212D68;
	Mon, 17 Feb 2025 09:24:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC85212B29
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784291; cv=none; b=ZGzCbmSOzIanN+29g6MQh45vdivpyKUhHt0vuvkTb+crjfMRic+dkYqVYvFnDQlOFWgg6hlC7o1TpUCPwOKyAVFfgk7YorfQCeRITIrht/fpodNAej2whXuC4LUx6u1ZSebS+8Oq96FNkGUiXGtjVUqTbtzW+7jcl4/Mq68A3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784291; c=relaxed/simple;
	bh=GCBDsD8hfPY99hvJlya7hExxmO6UCU2izMf6ZNn0YfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRSITq8Wbvgob8IGsc3nBoeQNH5lkK3NyRxMA+jnEd/ZUC/+nquGFSbQ8kSJ4yEuBdlreZfaGKlvuQS2kAvwUrTSFtNSD+LflMTrH39cazsGFG+8j0xqpT5180U6/KEUpBVLnK8lM6TfMRixYS6cgDv0Q1cgMdgYbRPm8IWfKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C19A68BEB; Mon, 17 Feb 2025 10:24:46 +0100 (CET)
Date: Mon, 17 Feb 2025 10:24:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-riscv@lists.infradead.org
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x'
 is never less than zero.
Message-ID: <20250217092445.GA29568@lst.de>
References: <202502171326.j4Xd3I0j-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502171326.j4Xd3I0j-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote:
> New smatch warnings:
> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is never less than zero.

Looks like this is an issue in the riscv virt_to_page implementation
which also shows up in various other places.  Any chance this could get
fixed in the riscv code?

> 
> Old smatch warnings:
> fs/xfs/xfs_linux.h:283 kmem_to_page() warn: unsigned '_x' is never less than zero.
> fs/xfs/xfs_buf.c:761 xfs_buf_get_map() error: we previously assumed 'bp' could be null (see line 743)
> arch/riscv/include/asm/atomic.h:218 arch_atomic_fetch_add_unless() warn: inconsistent indenting
> 
> vim +/_x +1534 fs/xfs/xfs_buf.c
> 
>   1518	
>   1519	static void
>   1520	xfs_buf_submit_bio(
>   1521		struct xfs_buf		*bp)
>   1522	{
>   1523		unsigned int		size = BBTOB(bp->b_length);
>   1524		unsigned int		map = 0, p;
>   1525		struct blk_plug		plug;
>   1526		struct bio		*bio;
>   1527	
>   1528		bio = bio_alloc(bp->b_target->bt_bdev, bp->b_page_count,
>   1529				xfs_buf_bio_op(bp), GFP_NOIO);
>   1530		bio->bi_private = bp;
>   1531		bio->bi_end_io = xfs_buf_bio_end_io;
>   1532	
>   1533		if (bp->b_flags & _XBF_KMEM) {
> > 1534			__bio_add_page(bio, virt_to_page(bp->b_addr), size,
>   1535					bp->b_offset);
>   1536		} else {
>   1537			for (p = 0; p < bp->b_page_count; p++)
>   1538				__bio_add_page(bio, bp->b_pages[p], PAGE_SIZE, 0);
>   1539			bio->bi_iter.bi_size = size; /* limit to the actual size used */
>   1540	
>   1541			if (xfs_buf_is_vmapped(bp))
>   1542				flush_kernel_vmap_range(bp->b_addr,
>   1543						xfs_buf_vmap_len(bp));
>   1544		}
>   1545	
>   1546		/*
>   1547		 * If there is more than one map segment, split out a new bio for each
>   1548		 * map except of the last one.  The last map is handled by the
>   1549		 * remainder of the original bio outside the loop.
>   1550		 */
>   1551		blk_start_plug(&plug);
>   1552		for (map = 0; map < bp->b_map_count - 1; map++) {
>   1553			struct bio	*split;
>   1554	
>   1555			split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
>   1556					&fs_bio_set);
>   1557			split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
>   1558			bio_chain(split, bio);
>   1559			submit_bio(split);
>   1560		}
>   1561		bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
>   1562		submit_bio(bio);
>   1563		blk_finish_plug(&plug);
>   1564	}
>   1565	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
---end quoted text---

