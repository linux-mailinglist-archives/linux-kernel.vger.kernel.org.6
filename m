Return-Path: <linux-kernel+bounces-240743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD09271FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2EC1C223AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AF1A4F16;
	Thu,  4 Jul 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtl92JMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF4107A0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082796; cv=none; b=fp9bHBfnkM7z+FYguaV8MxfqUHDGTmZ9rbl3wzH/0VTb9bjMhjps+VlgBOaIpBOCYcOC98RmjOau8VjwmDgfvGv39cjblVdZEYZozAooGkveyUtmSqPLdsdOCwTKPt+53DDRLEPg5rFBIAHFLlwno6ob6KSxgIa1HAgWpxErWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082796; c=relaxed/simple;
	bh=ZxRLkDRdvAg3y5cVKYOdLAYOAli7hUoWN2F6wd8SGsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1mrV1f7WODngFOXTyDgZ/TCD3BLlvqoME2hXas5wJG4dccr22WCs6OO4nAw3nzlUpqqOEGP/MnNtTuei+S1sENyEPlf+q95IVmcnJ09OD2Z5C1rtueUrFo/Q7S6sSntFV4evtC0deQolxM4lqUn6OWXK/PfhNu/qEo0EJ7hlec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtl92JMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CD1C3277B;
	Thu,  4 Jul 2024 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720082796;
	bh=ZxRLkDRdvAg3y5cVKYOdLAYOAli7hUoWN2F6wd8SGsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mtl92JMjymjC+BRRawFCLgS4lRWNWJo5JiHwak1oxHrXC8sez3cJXddYh2zVie9MA
	 MLLYpjDkdtjBvmMNcX/f0Fp1bWLr0rf/oNoeobhdbeGkQpuK7lhX78WClQ1tU/Tz+C
	 zp83gLhCHzGp6jTYxHGLqcf+29DFDJkxFF0usLBgzaoSYQNF14j3PuP2rpFuKmTIot
	 GMVn+Yo/i3fKsW/8uPT0Q2a2aE7fizDaXli0Ej0Eihf1A2+iVmLVztRp3ioM9BMSrQ
	 JvkCxCYz4AeuE2bOhXHEjwhLf6cimvQKe7I1gGBE/RIdfIF5RWi7y0IXie7rjJ2XUS
	 C68G/NTlOuQFg==
Message-ID: <cbc18f90-9c5a-49b0-9c6f-d1fbab0f2df1@kernel.org>
Date: Thu, 4 Jul 2024 16:46:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs:Add write priority option based on zone UFS
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: bo.wu@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240702062952.28859-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240702062952.28859-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/2 14:29, Liao Yuanhong wrote:
> Currently, we are using a mix of traditional UFS and zone UFS to support
> some functionalities that cannot be achieved on zone UFS alone. However,
> there are some issues with this approach. There exists a significant
> performance difference between traditional UFS and zone UFS. Under normal
> usage, we prioritize writes to zone UFS. However, in critical conditions
> (such as when the entire UFS is almost full), we cannot determine whether
> data will be written to traditional UFS or zone UFS. This can lead to
> significant performance fluctuations, which is not conducive to
> development and testing. To address this, we have added an option
> zlu_io_enable under sys with the following three modes:
> 1) zlu_io_enable == 0:Normal mode, prioritize writing to zone UFS;
> 2) zlu_io_enable == 1:Zone UFS only mode, only allow writing to zone UFS;
> 3) zlu_io_enable == 2:Traditional UFS priority mode, prioritize writing to
> traditional UFS.

Use blkzone_alloc_policy instead of zlu_io_enable? Not sure.

Should update manual of f2fs sysfs entry.

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/f2fs.h    |  5 +++++
>   fs/f2fs/segment.c | 23 ++++++++++++++++++++++-
>   fs/f2fs/sysfs.c   | 13 +++++++++++++
>   3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f7ee6c5e371e..7ba782bd15b2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1781,6 +1781,11 @@ struct f2fs_sb_info {
>   	u64 committed_atomic_block;
>   	u64 revoked_atomic_block;
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	/* For adjust the priority writing position of data in zone UFS */
> +	unsigned int zlu_io_enable;		/* data write mode */
> +#endif

#ifdef CONFIG_BLK_DEV_ZONED
	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
	/* For adjust the priority writing position of data in zone UFS */
	unsigned int zlu_io_enable;		/* data write mode */
#endif

> +
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	struct kmem_cache *page_array_slab;	/* page array entry */
>   	unsigned int page_array_slab_size;	/* default page array slab size */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4db1add43e36..327457c28700 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2686,17 +2686,38 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>   			goto got_it;
>   	}
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
>   	/*
>   	 * If we format f2fs on zoned storage, let's try to get pinned sections
>   	 * from beginning of the storage, which should be a conventional one.
>   	 */
>   	if (f2fs_sb_has_blkzoned(sbi)) {
> -		segno = pinning ? 0 : max(first_zoned_segno(sbi), *newseg);
> +		if (sbi->zlu_io_enable == 2)		/* Prioritize writing to traditional UFS */

Please use a macro instead of magic number.

> +			segno = 0;
> +		else
> +			segno = pinning ? 0 : max(first_zoned_segno(sbi), *newseg);
>   		hint = GET_SEC_FROM_SEG(sbi, segno);
>   	}
> +#endif
>   
>   find_other_zone:
>   	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
> +		if (sbi->zlu_io_enable == 1) {		/* Write only to zone UFS */

Ditto.

And we'd better initialize it w/ default policy in somewhere.

> +			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
> +			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> +		} else
> +			secno = find_first_zero_bit(free_i->free_secmap,
> +								MAIN_SECS(sbi));
> +		if (secno >= MAIN_SECS(sbi)) {
> +			ret = -ENOSPC;
> +			goto out_unlock;
> +		}
> +	}
> +#endif
> +
>   	if (secno >= MAIN_SECS(sbi)) {
>   		secno = find_first_zero_bit(free_i->free_secmap,
>   							MAIN_SECS(sbi));
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index fee7ee45ceaa..bc9e5e8bb749 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -627,6 +627,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   	}
>   #endif
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (!strcmp(a->attr.name, "zlu_io_enable")) {

Should check validation of new value?

> +		sbi->zlu_io_enable = t;
> +		return count;
> +	}
> +#endif
> +
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	if (!strcmp(a->attr.name, "compr_written_block") ||
>   		!strcmp(a->attr.name, "compr_saved_block")) {
> @@ -1006,6 +1013,9 @@ F2FS_SBI_GENERAL_RW_ATTR(dir_level);
>   F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
>   F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
>   #endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +F2FS_SBI_GENERAL_RW_ATTR(zlu_io_enable);

#ifdef CONFIG_BLK_DEV_ZONED
F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
F2FS_SBI_GENERAL_RW_ATTR(zlu_io_enable);
#endif

Thanks,

> +#endif
>   F2FS_SBI_GENERAL_RW_ATTR(readdir_ra);
>   F2FS_SBI_GENERAL_RW_ATTR(max_io_bytes);
>   F2FS_SBI_GENERAL_RW_ATTR(data_io_flag);
> @@ -1153,6 +1163,9 @@ static struct attribute *f2fs_attrs[] = {
>   #ifdef CONFIG_F2FS_IOSTAT
>   	ATTR_LIST(iostat_enable),
>   	ATTR_LIST(iostat_period_ms),
> +#endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	ATTR_LIST(zlu_io_enable),
>   #endif
>   	ATTR_LIST(readdir_ra),
>   	ATTR_LIST(max_io_bytes),

