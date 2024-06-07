Return-Path: <linux-kernel+bounces-206170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97093900511
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F6428DBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B01850B7;
	Fri,  7 Jun 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJHFk5Yl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F419415D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767187; cv=none; b=qZiJU9Sd0xqrErgV4uxHuFHKxHaIDHvmWhlIpMZDt72gzHcMosXA2hA8S5zOlvcMleuFRYRi8fqXdH5aSnMPAJIZoVdtB86QbjVIaPVfPeW2Vh3PQdjspkKEHnLgD9j8Qrrq0YLmBk0gQ6WeSNd6EomrZG1D33jEb7pOS71m994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767187; c=relaxed/simple;
	bh=jRjpn/aCZiZBz0Aqn7IkINUMJj2UiFOycXcGc9CYR1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atQ4lYr05ipRpcoNunNrRgMEWTSUu86fJHp/kch/2zCGVjvii8tx1U/aqhucfHRddRPHCCHZu6iGZ1Wp9GbZuAvtkr38x2KkTSHfiDrx51SDPz9VGBFEMRKZYPBXnWbCpYsar8W1Ie593F13AHnYXf+GvJHcH+jYjFFKU5KnBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KJHFk5Yl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PcY+IMjQpk0PL4/bmmieIepic/SgBBF32UMJe2Qyub0=; b=KJHFk5Yl2xkpDxC6WonNt/UB7P
	+qlM+bli9bb3xGiCC8qffan2T7bDtw9DgUbGWU5Hz84acTNc0GCBbmQSCmtjEVvWcNDSY24fzSOre
	hgD/aFQJ6iAMGFT7JuGAXaS/zz3yiE4AsNdbtJ25bR9foaWNbeMlXtRTCXb/qfFwJIvdLP7gIFI+n
	R2xAyncyOpK/515eFn97bWb+vYQGafbVNACL5Rvr+6NCV1hVuwIg/DqUGzWmLmFweaGm5XQx73rR0
	u+rnLsty4M7KIsTs4TrdL/4kq6+3MSBS+JNEor2XuHS7BLFOTqthUJPowoVUBokchD6HlJu49musL
	0Z76zymw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFZiJ-00000006HUe-3L41;
	Fri, 07 Jun 2024 13:33:03 +0000
Date: Fri, 7 Jun 2024 14:33:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: get rid of buffer_head use
Message-ID: <ZmMMDy9eeCU2igqj@casper.infradead.org>
References: <20240607101829.389015-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607101829.389015-1-chao@kernel.org>

On Fri, Jun 07, 2024 at 06:18:29PM +0800, Chao Yu wrote:
> @@ -1990,6 +1989,12 @@ static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
>  	return (struct f2fs_super_block *)(sbi->raw_super);
>  }
>  
> +static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio)
> +{
> +	return (struct f2fs_super_block *)(page_address(folio_page(folio, 0)) +
> +							F2FS_SUPER_OFFSET);
> +}

This assumes that the superblock is in the first page of the folio.
That's not necessarily guaranteed; let's say you have a 64KiB folio
that covers the start of the bdev.

I don't quite know how to write this because f2fs defines its block size
in terms of PAGE_SIZE, which just seems like nonsense to me.  If you
format a filesystem on a 16KiB PAGE_SIZE machine and then try to mount
it on a machine with a 4KiB PAGE_SIZE, it's going to go horribly wrong.

You'd need to pass in something that indicates whether you're trying to
access the first or second superblock; there's no way to tell from the
folio which one it is.

> +static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
> +								bool update)
>  {
> -	lock_buffer(bh);
> -	if (super)
> -		memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
> -	set_buffer_dirty(bh);
> -	unlock_buffer(bh);
> -
> +	struct bio *bio;
>  	/* it's rare case, we can do fua all the time */
> -	return __sync_dirty_buffer(bh, REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
> +	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA;
> +	int ret;
> +
> +	folio_lock(folio);
> +	folio_wait_writeback(folio);
> +	if (update)
> +		memcpy(F2FS_SUPER_BLOCK(folio), F2FS_RAW_SUPER(sbi),
> +					sizeof(struct f2fs_super_block));
> +	folio_mark_dirty(folio);
> +	folio_clear_dirty_for_io(folio);
> +	folio_start_writeback(folio);
> +	folio_unlock(folio);
> +
> +	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
> +
> +	/* it doesn't need to set crypto context for superblock update */
> +	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(folio_index(folio));
> +
> +	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
> +		f2fs_bug_on(sbi, 1);

Better make that folio_size(folio) to support bs>PS.


