Return-Path: <linux-kernel+bounces-395778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5207D9BC2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC9282620
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F129429;
	Tue,  5 Nov 2024 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7T5d9Wm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187811CA9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771647; cv=none; b=dPnEHHz1An/ozO1B2a8fqIRS/jTRUcSb+a6hdmSYnaPAoUFlIAtx4CEJwQn++vtVEWhXhZrBppl3VWRp+d2DbgjTgg8RIJxSsF5LSFpe1uzMhxggPbGTjPzgkhupxCOYGXa3VN6pUEgAUxwycHk0xzqhm50A1GXS1S0pS5JwVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771647; c=relaxed/simple;
	bh=eVOa5xQIw5wXVux6yc3Qr0qhE7PGTsAlDSGrhyEDVSI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dkH+x/c6DD68eIwr9qFZcnKEuXC2BVow/SXf3UyYsR4i4cnmfMGg1Gsunvhv18SL66r2OpN92dFwmBzr2v0+qwtxy2V6rYfAfxE7XW73iRxp9Cn9nMYD2m+WNtBJF47x9PQCWRwUjLXVtp9chxMnENOcNFv1EHOvLpgMent3gyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7T5d9Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871CCC4CECE;
	Tue,  5 Nov 2024 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730771647;
	bh=eVOa5xQIw5wXVux6yc3Qr0qhE7PGTsAlDSGrhyEDVSI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Y7T5d9WmL2E5oZQt6fioBSN0Gu3FqRsW3rR+SpN8WpwjvMmV8VWhmQiyRoTxiU8uf
	 s4XbBQQWmmYypsX0hrPBrJyhyvZzVDfy0M+YkwKNk8pmS0pFWfxEunjHeA5u8tf9xV
	 U9zUdwmr2F98agTHWoV2338WVNH0Y9S9cqYDbfRP5lr3J+tmsLAWrhAVYYPFuFXEiv
	 vq6mwSDd0kqTX00go5eMUxH8V88c2yhq0t6+EZLFapmVgAIt68xG7jTNH1klBrCnvp
	 zi3eq3t0ouSfkVSuxK48O4k4VGMxZFmavM6Zuf6p22h4WWvIcRq3IgccZynkHWQTlA
	 HGbtFdIFhhTSg==
Message-ID: <40643403-1209-465f-bede-a990d4b564e5@kernel.org>
Date: Tue, 5 Nov 2024 09:54:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
Subject: Re: [PATCH v2] mkfs.f2fs: adjust zone alignment when using convention
 partition with zoned one
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20241029134551.252-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241029134551.252-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 21:45, Yohan Joung wrote:
> When formatting conventional partition with zoned one, we are already
> aligning the starting block address of the next device to the zone size.
> Therefore, we do not align the segment0 address to the zone alignment.
> This reduces the wasted zone_align_start_offset.
> 
> Test result
> segment0 blkaddr 389583 -> 119251
> Add one additional section to main
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>   mkfs/f2fs_format.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index a01b19e..52a1e18 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -266,6 +266,7 @@ static int f2fs_prepare_super_block(void)
>   	uint32_t log_sectorsize, log_sectors_per_block;
>   	uint32_t log_blocksize, log_blks_per_seg;
>   	uint32_t segment_size_bytes, zone_size_bytes;
> +	uint32_t alignment_bytes;
>   	uint32_t sit_segments, nat_segments;
>   	uint32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
>   	uint32_t total_valid_blks_available;
> @@ -305,10 +306,12 @@ static int f2fs_prepare_super_block(void)
>   
>   	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
>   
> +	alignment_bytes = c.zoned_mode && c.ndevs > 1 ? segment_size_bytes : zone_size_bytes;
> +
>   	zone_align_start_offset =
>   		((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
> -		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> -		zone_size_bytes * zone_size_bytes -
> +		2 * F2FS_BLKSIZE + alignment_bytes  - 1) /
> +		alignment_bytes  * alignment_bytes  -

round_up(..., alignment_bytes) * alignment_bytes - ?

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   		(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
>   
>   	if (c.feature & F2FS_FEATURE_RO)
> @@ -327,7 +330,8 @@ static int f2fs_prepare_super_block(void)
>   
>   	if (c.zoned_mode && c.ndevs > 1)
>   		zone_align_start_offset +=
> -			(c.devices[0].total_sectors * c.sector_size) % zone_size_bytes;
> +			(c.devices[0].total_sectors * c.sector_size -
> +			 zone_align_start_offset) % zone_size_bytes;
>   
>   	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
>   	sb->cp_blkaddr = sb->segment0_blkaddr;


