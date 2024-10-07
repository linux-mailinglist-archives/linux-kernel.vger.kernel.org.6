Return-Path: <linux-kernel+bounces-353901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2929899341C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AB8281C13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1AE1DC06F;
	Mon,  7 Oct 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NifajxMl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471231DC079
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319936; cv=none; b=gBO0bGqBiIkgDqs5rNMCD0uoijkLfxL9etAkJJpAM9047z2lW8FDMsAZi6y/97I6DPy0whRfh9V9/zmhSrKTliBnTaQgb+NKjiYsyoUSRwxGr1ShR/6VRU6/OX/dVOpkFy0rlFgnHpQHhBEwABDXOF59W0tkuT6oYJeGV+CfHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319936; c=relaxed/simple;
	bh=McFR8CfgpnxksNQs6KtKlTa460EvJpbtOvh/Sm4lYCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDQNiubaOdI1RQxeTTsMFti2I/GBBHWyvmQVzKfgVZnvxhcdGlFYFh2LpBTaiQWTnlK+E9wO6giXgjDFETUMlFJ9J/zymmDr7ku0qFS8co5B7VUQq9VcDa6pS6j5LjUz8JNca3DzQvDGzrrl6eSZuynnUzFlxNskHuCeFXvqktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NifajxMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96671C4CEC6;
	Mon,  7 Oct 2024 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728319935;
	bh=McFR8CfgpnxksNQs6KtKlTa460EvJpbtOvh/Sm4lYCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NifajxMl/qi1VfPGNZIfvKjpMmnl/IP6NF0mW1lU1NZ6arMQBQa0/v5j8DrHXzqlN
	 1Sj1SQT5wxP1GchJLtpPjHJSjA0Ku4s5UQYfS+ATfbYSxXNKUB81ug2/VG1fo0b4ji
	 eS/Ltc2/h42GFAInxqkLWG0Rjcuy6hdHE6Z0LjuiI7YoXZzLYFWIWEsvJcXVuXCFun
	 ZN4TcZESCB4LV5HTfHKWFnoQaZZnpycy9bkn5WugOlN0FU0kcyu+OHmkvLJgwQH9yr
	 Lkz/fOcK6NxmZ2e5bi0lcOZj8BdLSn9SzDOyocEdD+SoIAqOvorErYzdVcISuhhqNK
	 Dyow4yn2yFu9A==
Date: Mon, 7 Oct 2024 16:52:14 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] f2fs: use per-log target_bitmap to improve lookup
 performace of ssr allocation
Message-ID: <ZwQRvmVoDr_O6vLH@google.com>
References: <20240411082354.1691820-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411082354.1691820-1-chao@kernel.org>

Hi Chao,

This introduces another bitmap increasing memory footprint. Do we know how
much performance benefit with this?

On 04/11, Chao Yu wrote:
> After commit 899fee36fac0 ("f2fs: fix to avoid data corruption by
> forbidding SSR overwrite"), valid block bitmap of current openned
> segment is fixed, let's introduce a per-log bitmap instead of temp
> bitmap to avoid unnecessary calculation overhead whenever allocating
> free slot w/ SSR allocator.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - rebase to last dev-test branch.
>  fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
>  fs/f2fs/segment.h |  1 +
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6474b7338e81..af716925db19 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2840,31 +2840,39 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>  	return 0;
>  }
>  
> -static int __next_free_blkoff(struct f2fs_sb_info *sbi,
> -					int segno, block_t start)
> +static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
> +					unsigned long *target_map,
> +					int segno)
>  {
>  	struct seg_entry *se = get_seg_entry(sbi, segno);
>  	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> -	unsigned long *target_map = SIT_I(sbi)->tmp_map;
>  	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>  	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
>  	int i;
>  
>  	for (i = 0; i < entries; i++)
>  		target_map[i] = ckpt_map[i] | cur_map[i];
> +}
> +
> +static int __next_free_blkoff(struct f2fs_sb_info *sbi, unsigned long *bitmap,
> +					int segno, block_t start)
> +{
> +	__get_segment_bitmap(sbi, bitmap, segno);
>  
> -	return __find_rev_next_zero_bit(target_map, BLKS_PER_SEG(sbi), start);
> +	return __find_rev_next_zero_bit(bitmap, BLKS_PER_SEG(sbi), start);
>  }
>  
>  static int f2fs_find_next_ssr_block(struct f2fs_sb_info *sbi,
> -		struct curseg_info *seg)
> +					struct curseg_info *seg)
>  {
> -	return __next_free_blkoff(sbi, seg->segno, seg->next_blkoff + 1);
> +	return __find_rev_next_zero_bit(seg->target_map,
> +				BLKS_PER_SEG(sbi), seg->next_blkoff + 1);
>  }
>  
>  bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
>  {
> -	return __next_free_blkoff(sbi, segno, 0) < BLKS_PER_SEG(sbi);
> +	return __next_free_blkoff(sbi, SIT_I(sbi)->tmp_map, segno, 0) <
> +							BLKS_PER_SEG(sbi);
>  }
>  
>  /*
> @@ -2890,7 +2898,8 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
>  
>  	reset_curseg(sbi, type, 1);
>  	curseg->alloc_type = SSR;
> -	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->segno, 0);
> +	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->target_map,
> +							curseg->segno, 0);
>  
>  	sum_page = f2fs_get_sum_page(sbi, new_segno);
>  	if (IS_ERR(sum_page)) {
> @@ -4635,6 +4644,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
>  				sizeof(struct f2fs_journal), GFP_KERNEL);
>  		if (!array[i].journal)
>  			return -ENOMEM;
> +		array[i].target_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
> +								GFP_KERNEL);
> +		if (!array[i].target_map)
> +			return -ENOMEM;
>  		if (i < NR_PERSISTENT_LOG)
>  			array[i].seg_type = CURSEG_HOT_DATA + i;
>  		else if (i == CURSEG_COLD_DATA_PINNED)
> @@ -5453,6 +5466,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
>  	for (i = 0; i < NR_CURSEG_TYPE; i++) {
>  		kfree(array[i].sum_blk);
>  		kfree(array[i].journal);
> +		kfree(array[i].target_map);
>  	}
>  	kfree(array);
>  }
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index e1c0f418aa11..10f3e44f036f 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -292,6 +292,7 @@ struct curseg_info {
>  	struct f2fs_summary_block *sum_blk;	/* cached summary block */
>  	struct rw_semaphore journal_rwsem;	/* protect journal area */
>  	struct f2fs_journal *journal;		/* cached journal info */
> +	unsigned long *target_map;		/* bitmap for SSR allocator */
>  	unsigned char alloc_type;		/* current allocation type */
>  	unsigned short seg_type;		/* segment type like CURSEG_XXX_TYPE */
>  	unsigned int segno;			/* current segment number */
> -- 
> 2.40.1

