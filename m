Return-Path: <linux-kernel+bounces-245552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE392B446
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FAC1F24534
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5AD155398;
	Tue,  9 Jul 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sddAE2Ur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E313C687
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518289; cv=none; b=NNUtNkNT6ztVASYjhK9wvU6/trUDTQIk2RmtbTvEDE5QibFlod1U3pNhN1LLL4U38nxkOFb3D9/mnjVgt0vjYeOz/fiFHPR4HPeBQxOQo2cRVKvs2Cd/sfzznNsgDV4oRDEv6u6pqoqsVHfkxaOKxPrOHf0VBAtxurFbvnLD2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518289; c=relaxed/simple;
	bh=ZXkUotYWlRiEIQWRFI/h2BgFuQ26QWnYA5OxBz0fLbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuEegHnXZoUWMHRoTJBc7bw5hPUQO6XUF947tp2s5lZ2lYF32xw6w1Lb3N4rSK5g357vf+slQX960VlMMFD0SkiCAXQGZ0yZ+DbcTutzSFSxm6h2FKJcX8SvDSY4kLzJzMPoIwwY/HEp3z0TMclN/h8G/O4UbgPe3oOEYHhIVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sddAE2Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4251C3277B;
	Tue,  9 Jul 2024 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720518289;
	bh=ZXkUotYWlRiEIQWRFI/h2BgFuQ26QWnYA5OxBz0fLbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sddAE2UretRWrf69ZjCYSzwlwSkuTw/AnwWqwLBqEZ1BBLzvy3Vnu3Y0XOzhYR4IU
	 0fNTvJXjNVygLUdeS12ORdjpvDIFi8YpfSyLPGeA477hy5+Cj+uWPO10IEZd21Kbtl
	 ZFiyXXyHt5/PP5yaIgCVI7IwLO15xf1lo8ihHVTgH3XkSGQUdl/XYu4KlOigPFCxef
	 HOhH2sdMARZ/fRVw5zPb7eaTKH3CPDbyRp5Y4YdIEEBSDxEiLuqS60MM+y27au8e4g
	 5ITYKINHLR0wzSy+NcNSlQTOA93iNEKKTmV4T10/dcJAUNlFiJ0sA/Mgi9U70tlgOm
	 mBI8uk7fSnbgw==
Message-ID: <11d0ca19-3538-49c1-bab9-1ba0f2b8c9a6@kernel.org>
Date: Tue, 9 Jul 2024 17:44:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] f2fs:Add write priority option based on zone UFS
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: bo.wu@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240702062952.28859-1-liaoyuanhong@vivo.com>
 <20240709021614.17044-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240709021614.17044-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/9 10:16, Liao Yuanhong wrote:
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
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
> v3:
> 	-Delete excess comments,
> 	-Use enum instead of define,
> 	-Modify some judgment criteria to make them more reasonable.
> ---
> v2:
> 	-Change name to blkzone_alloc_policy,
> 	-Update manual of f2fs sysfs entry,
> 	-Use macro instead of magic number,
> 	-Initialize it w/ default policy in f2fs_scan_devices,
> 	-Add validation check,
> 	-Merged the ifdef PROFIG-BLK-DEV_ZONED area.
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++++++++
>   fs/f2fs/f2fs.h                          |  8 ++++++++
>   fs/f2fs/segment.c                       | 25 ++++++++++++++++++++++++-
>   fs/f2fs/super.c                         |  1 +
>   fs/f2fs/sysfs.c                         | 11 +++++++++++
>   5 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index cad6c3dc1f9c..3500920ab7ce 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -763,3 +763,17 @@ Date:		November 2023
>   Contact:	"Chao Yu" <chao@kernel.org>
>   Description:	It controls to enable/disable IO aware feature for background discard.
>   		By default, the value is 1 which indicates IO aware is on.
> +
> +What:		/sys/fs/f2fs/<disk>/blkzone_alloc_policy
> +Date:		July 2024
> +Contact:	"Yuanhong Liao" <liaoyuanhong@vivo.com>
> +Description:	The zone UFS we are currently using consists of two parts:
> +		conventional zones and sequential zones. It can be used to control which part
> +		to prioritize for writes, with a default value of 0.
> +
> +		========================  =========================================
> +		value					  description
> +		blkzone_alloc_policy = 0  Prioritize writing to sequential zones
> +		blkzone_alloc_policy = 1  Only allow writing to sequential zones
> +		blkzone_alloc_policy = 2  Prioritize writing to conventional zones
> +		========================  =========================================
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f7ee6c5e371e..adefd19810ff 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -134,6 +134,12 @@ typedef u32 nid_t;
>   
>   #define COMPRESS_EXT_NUM		16
>   
> +enum blkzone_allocation_policy {
> +	BLKZONE_ALLOC_PRIOR_SEQ;	/* Prioritize writing to sequential zones */
> +	BLKZONE_ALLOC_ONLY_SEQ;		/* Only allow writing to sequential zones */
> +	BLKZONE_ALLOC_PRIOR_CONV;	/* Prioritize writing to conventional zones */
> +};
> +
>   /*
>    * An implementation of an rwsem that is explicitly unfair to readers. This
>    * prevents priority inversion when a low-priority reader acquires the read lock
> @@ -1555,6 +1561,8 @@ struct f2fs_sb_info {
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
>   	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
> +	/* For adjust the priority writing position of data in zone UFS */
> +	unsigned int blkzone_alloc_policy;
>   #endif
>   
>   	/* for node-related operations */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4db1add43e36..b38b92e08c6c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2686,17 +2686,40 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
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
> +		/* Prioritize writing to conventional zones */
> +		if (sbi->blkzone_alloc_policy == PRIOR_CONVENTIONAL || pinning)

should adjust new enum definition?

> +			segno = 0;
> +		else
> +			segno = max(first_zoned_segno(sbi), *newseg);
>   		hint = GET_SEC_FROM_SEG(sbi, segno);
>   	}
> +#endif
>   
>   find_other_zone:
>   	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
> +		/* Write only to sequential zones */
> +		if (sbi->blkzone_alloc_policy == ONLY_SEQUENTIAL) {

ditto

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
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4a1bc8f40f9a..d5b0b7b141ce 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4229,6 +4229,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   	sbi->aligned_blksize = true;
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	sbi->max_open_zones = UINT_MAX;
> +	sbi->blkzone_alloc_policy = PRIOR_SEQUENTIAL;

ditto

>   #endif
>   
>   	for (i = 0; i < max_devices; i++) {
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index fee7ee45ceaa..359a12f84060 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -627,6 +627,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   	}
>   #endif
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (!strcmp(a->attr.name, "blkzone_alloc_policy")) {
> +		if (t < PRIOR_SEQUENTIAL || t > PRIOR_CONVENTIONAL)

ditto

> +			return -EINVAL;
> +		sbi->blkzone_alloc_policy = t;
> +		return count;
> +	}
> +#endif
> +
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	if (!strcmp(a->attr.name, "compr_written_block") ||
>   		!strcmp(a->attr.name, "compr_saved_block")) {
> @@ -1033,6 +1042,7 @@ F2FS_SBI_GENERAL_RW_ATTR(warm_data_age_threshold);
>   F2FS_SBI_GENERAL_RW_ATTR(last_age_weight);
>   #ifdef CONFIG_BLK_DEV_ZONED
>   F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
> +F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>   #endif
>   
>   /* STAT_INFO ATTR */
> @@ -1187,6 +1197,7 @@ static struct attribute *f2fs_attrs[] = {
>   #endif
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	ATTR_LIST(unusable_blocks_per_sec),
> +	ATTR_LIST(blkzone_alloc_policy),
>   #endif
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	ATTR_LIST(compr_written_block),

