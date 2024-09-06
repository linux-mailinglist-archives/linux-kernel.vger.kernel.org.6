Return-Path: <linux-kernel+bounces-318066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 266F796E7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9102B22D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003938DD1;
	Fri,  6 Sep 2024 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0uSUxFv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80434CC4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591370; cv=none; b=ppGoR19Zdt30bBkC9y+vNPNULW/v8yPmb0UnmBlqDBCPMfuEB9K/lkHRHR6vKSaq8wCkTEdQt0M9+D0dZHbf3SFJkA2JeISmdyJ/QsL5WgrEEGx80uKj5U4+S2kOXHhcOOR9VtBeTyxR75+JftmDBOJDL7nDQmajLPBdB+cd4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591370; c=relaxed/simple;
	bh=qgnvsxHpCz4EVBPco1NOjE/FCNHMlw/IPYRztBb49aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RT6CDp01/4zodRcBaVWp593jPKq2pjOuGILYWArnTXGi4m6NpRicefKfmJyP4h4/UsTGLdG2ry2N+P20GyadhU8Se6aDGMg0GfSXVIS6T4TcJBd7yXFOlAjWzEN1oaOgZf0MdJl7jlxn0Kd5ljhOKle9fV56d11eXuCWuUuYeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0uSUxFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E264EC4CEC3;
	Fri,  6 Sep 2024 02:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725591370;
	bh=qgnvsxHpCz4EVBPco1NOjE/FCNHMlw/IPYRztBb49aY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z0uSUxFvjxemebFIt78o6fDrJCp8BCtbUae6TTI7RWpZH8sOpIgm+1pqE6OZ4+4Kr
	 oBBs3P/Cj1Dl42a8vE2TTl+ihni6Z+nB8B29dbTskrIC8FxPxLzaW21x15Dl5jtZTD
	 ai5xzcfiRSIvPRy24gwZLhz7iHDeqqk5ck4e7kgdSR2PFoVBKYcc+ZiYK1I3vyMrhF
	 RUVHjh8px5ceccf38golfl39VGFzgpxPHUFJuZR63LKZS56hjMuvRTSW5mLgSzg9e7
	 vman8HjnhMCzRitB8Yd60JowQyuK39RC8Iwff2XmFfMNOkjNpwj8S4vx/D91Fetiln
	 A6Z65OjtQ9IrA==
Message-ID: <501416af-b08c-448b-881d-0915575e22f5@kernel.org>
Date: Fri, 6 Sep 2024 10:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/7] f2fs: read summary blocks with the correct
 amount for migration_granularity
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
 <20240829215242.3641502-2-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240829215242.3641502-2-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now we do readahead for a full section by not considering
> migration_granularity and it triggers unnecessary read. So, make it read
> with the correct amount.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/gc.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 46e3bc26b78a..b5d3fd40b17a 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1708,24 +1708,33 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   	struct blk_plug plug;
>   	unsigned int segno = start_segno;
>   	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
> +	unsigned int sec_end_segno;
>   	int seg_freed = 0, migrated = 0;
>   	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>   						SUM_TYPE_DATA : SUM_TYPE_NODE;
>   	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
>   	int submitted = 0;
>   
> -	if (__is_large_section(sbi))
> -		end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
> +	if (__is_large_section(sbi)) {
> +		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
>   
> -	/*
> -	 * zone-capacity can be less than zone-size in zoned devices,
> -	 * resulting in less than expected usable segments in the zone,
> -	 * calculate the end segno in the zone which can be garbage collected
> -	 */
> -	if (f2fs_sb_has_blkzoned(sbi))
> -		end_segno -= SEGS_PER_SEC(sbi) -
> +		/*
> +		 * zone-capacity can be less than zone-size in zoned devices,
> +		 * resulting in less than expected usable segments in the zone,
> +		 * calculate the end segno in the zone which can be garbage
> +		 * collected
> +		 */
> +		if (f2fs_sb_has_blkzoned(sbi))
> +			sec_end_segno -= SEGS_PER_SEC(sbi) -
>   					f2fs_usable_segs_in_sec(sbi, segno);
>   
> +		if (gc_type == BG_GC)
> +			end_segno = start_segno + sbi->migration_granularity;
> +
> +		if (end_segno > sec_end_segno)
> +			end_segno = sec_end_segno;
> +	}
> +
>   	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
>   
>   	/* readahead multi ssa blocks those have contiguous address */
> @@ -1762,9 +1771,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   
>   		if (get_valid_blocks(sbi, segno, false) == 0)
>   			goto freed;
> -		if (gc_type == BG_GC && __is_large_section(sbi) &&
> -				migrated >= sbi->migration_granularity)

It seems we change the logic from migrating "migration_granularity" segments which
has valid blocks to scanning "migration_granularity" segments and try migrating
valid blocks in those segments.

IIUC, when background GC recycle sparse zone, it will take gc thread more round,
it seems low efficient. How do you think of keeping previous implementation?

Thanks,

> -			goto skip;
>   		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
>   			goto skip;
>   
> @@ -1803,7 +1809,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   
>   		if (__is_large_section(sbi))
>   			sbi->next_victim_seg[gc_type] =
> -				(segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
> +				(segno + 1 < sec_end_segno) ?
> +					segno + 1 : NULL_SEGNO;
>   skip:
>   		f2fs_put_page(sum_page, 0);
>   	}


