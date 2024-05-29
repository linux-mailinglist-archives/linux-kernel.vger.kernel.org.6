Return-Path: <linux-kernel+bounces-193763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B698D31F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6570B27FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6E7347D;
	Wed, 29 May 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaI9MNmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F01E86E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972019; cv=none; b=MLsvJ4rgEd9zvMMn2GNoWTS9UQKyBv1jE6k0a8MTFuAq0wCJXM9FCIT17h8IwjbEcQpqSrKPO1DLbs1UOh0wog53zON4TiwSI7hMTW0Jwa2Jd3jZhidZxVW9H5WVFI6bfMAvxbBNXb8SokgGTz7VLfZa4MpwSXsvaFhZSlysaJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972019; c=relaxed/simple;
	bh=BwUxRk7Asx85AyGi+Q5sBXOAO5knNtBwrnzi+v7Uquw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O36wYTIYXRhiA4/GhTSKy1nEICdTlHQiplW5ZdZq5/rwUxNtCzMOuUxFs22FggZ9t8b6Dk65N+jL6HN1JiydoNpaTrlmwpNIdC5EYaj7as4V5zj5Ux/76opONjtTIxxcP2kYH5zOgz8DmDx4wBsizyMiDHSjbB4Q1X5Y7bCG1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaI9MNmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10A8C2BD10;
	Wed, 29 May 2024 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716972018;
	bh=BwUxRk7Asx85AyGi+Q5sBXOAO5knNtBwrnzi+v7Uquw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RaI9MNmqjwhvpPxJOJPpmP5U+qgttFG6H9ldj0Wlq8QeEHOv1svjJYWpgI73cqTYd
	 F/HiXnWg+3BTVItYKitIdWDcDRyMo99xzr4FaKVZByyYt3v1Br8hJp6XiJ74rWuGoo
	 XuEnSb2fI0DgrpJ6sKEsQfQv3Bd7xISPsGEq1s1n+jlQcgwn5KNMC6jBaDUX6PSiYs
	 3XcGqG/IGtSalsnAPa2AT7WXE4WuoRmB3pBvN9DF9VgH8dFIg3e+hD9hZ3CvtU9+tY
	 Naxi3joH1HjleApxcvbO8NZtCt8g4p9rGXljK5+kUrfqDunLcq7qvv2+L2hU22G17U
	 miog6Xte7cE/A==
Message-ID: <98d2930c-3fb8-4fa2-abe8-c90dbb315eec@kernel.org>
Date: Wed, 29 May 2024 16:40:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to avoid use SSR allocate when do defragment
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1716970779-27896-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1716970779-27896-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/29 16:19, Zhiguo Niu wrote:
> SSR allocate mode will be used when doing file defragment
> if ATGC is working at the same time, that is because
> set_page_private_gcing may make CURSEG_ALL_DATA_ATGC segment
> type got in f2fs_allocate_data_block when defragment page
> is writeback, which may cause file fragmentation is worse.
> 
> A file with 2 fragmentations is changed as following after defragment:
> 
> ----------------file info-------------------
> sensorsdata :
> --------------------------------------------
> dev       [254:48]
> ino       [0x    3029 : 12329]
> mode      [0x    81b0 : 33200]
> nlink     [0x       1 : 1]
> uid       [0x    27e6 : 10214]
> gid       [0x    27e6 : 10214]
> size      [0x  242000 : 2367488]
> blksize   [0x    1000 : 4096]
> blocks    [0x    1210 : 4624]
> --------------------------------------------
> 
> file_pos   start_blk     end_blk        blks
>         0    11361121    11361207          87
>    356352    11361215    11361216           2
>    364544    11361218    11361218           1
>    368640    11361220    11361221           2
>    376832    11361224    11361225           2
>    385024    11361227    11361238          12
>    434176    11361240    11361252          13
>    487424    11361254    11361254           1
>    491520    11361271    11361279           9
>    528384     3681794     3681795           2
>    536576     3681797     3681797           1
>    540672     3681799     3681799           1
>    544768     3681803     3681803           1
>    548864     3681805     3681805           1
>    552960     3681807     3681807           1
>    557056     3681809     3681809           1
> 
> A new FI flag FI_DEFRAG_IN_PROGRESS is introduced to avoid
> this scenarios.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/f2fs.h    | 1 +
>   fs/f2fs/file.c    | 2 ++
>   fs/f2fs/segment.c | 3 ++-
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4044e67..9281c5e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -803,6 +803,7 @@ enum {
>   	FI_COW_FILE,		/* indicate COW file */
>   	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
>   	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
> +	FI_DEFRAG_IN_PROGRESS,	/* indicate file was defragmenting */
>   	FI_MAX,			/* max flag, never be used */
>   };
>   
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5c0b281..93d2767 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2717,6 +2717,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>   		goto out;
>   	}
>   
> +	set_inode_flag(inode, FI_DEFRAG_IN_PROGRESS);
>   	map.m_lblk = pg_start;
>   	map.m_len = pg_end - pg_start;
>   	total = 0;
> @@ -2772,6 +2773,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>   clear_out:
>   	clear_inode_flag(inode, FI_SKIP_WRITES);
>   out:
> +	clear_inode_flag(inode, FI_DEFRAG_IN_PROGRESS);
>   	clear_inode_flag(inode, FI_OPU_WRITE);
>   unlock_out:
>   	inode_unlock(inode);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7caf20a..dd6f8ac 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3482,7 +3482,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>   		if (page_private_gcing(fio->page)) {
>   			if (fio->sbi->am.atgc_enabled &&
>   				(fio->io_type == FS_DATA_IO) &&
> -				(fio->sbi->gc_mode != GC_URGENT_HIGH))
> +				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
> +				!is_inode_flag_set(inode, FI_DEFRAG_IN_PROGRESS))

How about checking FI_OPU_WRITE flag?

Thanks,

>   				return CURSEG_ALL_DATA_ATGC;
>   			else
>   				return CURSEG_COLD_DATA;

