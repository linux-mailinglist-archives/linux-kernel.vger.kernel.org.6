Return-Path: <linux-kernel+bounces-318258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED496EAC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6FD4B25BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B814BF8F;
	Fri,  6 Sep 2024 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3M1OqZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442213D891
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604499; cv=none; b=tLVyU+ctSYixydCFjJE7GW2gitfYfXKii4AVRhU6X5HKabFquNlTEyP0dTR5KbyMw7tx1WcU3QY9FUW7a3RFt15mKkG4caxny/OLqiTapkDPZmMSxiMP7iB7quK7/DX1fOhCxv6eSgaoFOiJHwJKlKlN5ZpqG2BjOOqkkcjEqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604499; c=relaxed/simple;
	bh=cFZIh7ashMIXVKWV6hq6sOPOO05bRbQ/dRA4j6sUTR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJQom+S8kEGQGDlLlUWnEu0g3TPXr/3d1L9Y4kJlIRfaX/K+3EqjR5oW0tYHbjpl4g8v+hNlz97NZYCltjFU3fsP+tdfsem15t0h0bMoq7wQc2X1fD+Ldrg4gc7iByoxZVmOvQ/sFALtfAKFFi99qCN/mMSvpBXU32MXebBpEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3M1OqZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF12C4CEC4;
	Fri,  6 Sep 2024 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725604498;
	bh=cFZIh7ashMIXVKWV6hq6sOPOO05bRbQ/dRA4j6sUTR0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k3M1OqZwf2gL9dWrp5W66q9ZbyphSzygXI5f87QGVTKesaEpHCxLLD3nIxmgzJ61s
	 Kdq+JgvZYe+fKFudleOM1e44h3tT+fqThBINlVsm2L0OISEBQpeh3c1N3papEYbVmr
	 xV3ivQRmNAMuHOW1c+ph5Vwj4ZcyCd+UAnOnIF1HDYLrH5YuTnCnnrYrTGZtZERSPM
	 3k8TRj+6Z4aknsJJk0lKWWixW4SKFwZC9R9BWICF2/7tcDTTQvLq6WFrwODBWRPcFf
	 KFhmGysN9NUHF6jImYuAavB8bXVO7mQ41JlT+bwrJ16FyAfuwJbnb4Hq8CdhLoShSf
	 lyHGB0Ax6jE+A==
Message-ID: <807c19f9-f4d6-477d-8728-ab90734a4ebe@kernel.org>
Date: Fri, 6 Sep 2024 14:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 5/7] f2fs: do FG_GC when GC boosting is
 required for zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
 <20240829215242.3641502-5-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240829215242.3641502-5-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Under low free section count, we need to use FG_GC instead of BG_GC to
> recover free sections.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/f2fs.h |  1 +
>   fs/f2fs/gc.c   | 24 +++++++++++++++++-------
>   2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5e4db3ba534a..ee1fafc65e95 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1294,6 +1294,7 @@ struct f2fs_gc_control {
>   	bool should_migrate_blocks;	/* should migrate blocks */
>   	bool err_gc_skipped;		/* return EAGAIN if GC skipped */

bool one_time;			/* require one time GC in one migration unit */

In order to avoid unnecessary padding for alignment.

Thanks,

>   	unsigned int nr_free_secs;	/* # of free sections to do GC */
> +	bool one_time;			/* require one time GC in one migration unit */
>   };
>   
>   /*
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d6d71aab94f3..37b47a8d95f1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -81,6 +81,8 @@ static int gc_thread_func(void *data)
>   			continue;
>   		}
>   
> +		gc_control.one_time = false;
> +
>   		/*
>   		 * [GC triggering condition]
>   		 * 0. GC is not conducted currently.
> @@ -126,15 +128,19 @@ static int gc_thread_func(void *data)
>   				wait_ms = gc_th->max_sleep_time;
>   		}
>   
> -		if (need_to_boost_gc(sbi))
> +		if (need_to_boost_gc(sbi)) {
>   			decrease_sleep_time(gc_th, &wait_ms);
> -		else
> +			if (f2fs_sb_has_blkzoned(sbi))
> +				gc_control.one_time = true;
> +		} else {
>   			increase_sleep_time(gc_th, &wait_ms);
> +		}
>   do_gc:
>   		stat_inc_gc_call_count(sbi, foreground ?
>   					FOREGROUND : BACKGROUND);
>   
> -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
> +		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
> +				gc_control.one_time;
>   
>   		/* foreground GC was been triggered via f2fs_balance_fs() */
>   		if (foreground)
> @@ -1701,7 +1707,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
>   static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   				unsigned int start_segno,
>   				struct gc_inode_list *gc_list, int gc_type,
> -				bool force_migrate)
> +				bool force_migrate, bool one_time)
>   {
>   	struct page *sum_page;
>   	struct f2fs_summary_block *sum;
> @@ -1728,7 +1734,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   			sec_end_segno -= SEGS_PER_SEC(sbi) -
>   					f2fs_usable_segs_in_sec(sbi, segno);
>   
> -		if (gc_type == BG_GC) {
> +		if (gc_type == BG_GC || one_time) {
>   			unsigned int migration_granularity =
>   				sbi->migration_granularity;
>   
> @@ -1908,7 +1914,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   	}
>   
>   	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
> -				gc_control->should_migrate_blocks);
> +				gc_control->should_migrate_blocks,
> +				gc_control->one_time);
>   	if (seg_freed < 0)
>   		goto stop;
>   
> @@ -1919,6 +1926,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   		total_sec_freed++;
>   	}
>   
> +	if (gc_control->one_time)
> +		goto stop;
> +
>   	if (gc_type == FG_GC) {
>   		sbi->cur_victim_sec = NULL_SEGNO;
>   
> @@ -2044,7 +2054,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>   		};
>   
>   		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
> -						dry_run_sections == 0);
> +						dry_run_sections == 0, false);
>   		put_gc_inode(&gc_list);
>   
>   		if (!dry_run && get_valid_blocks(sbi, segno, true))


