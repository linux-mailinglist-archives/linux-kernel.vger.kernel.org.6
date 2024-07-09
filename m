Return-Path: <linux-kernel+bounces-245195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C492AF78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E20F1F21EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394C12F38B;
	Tue,  9 Jul 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEQ2u3gi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA11139F;
	Tue,  9 Jul 2024 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503523; cv=none; b=VHVGYTWbJspixmPqRbT0qM51REtbu+Yt50hvxUM9lU0bqSswv7dsOqIkBYnMwT70xkr5ia/bQUTWRUAsNX11IaCjIepBWGhaiKbYX7Mnaj3gV/RCGMBCyiwSQOTEl1HEqkOSRqsA0r5AhebpvkeEUf6XUVCCSOmxdfqmAIuqfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503523; c=relaxed/simple;
	bh=eihBDEE0BRkjP+/D5kaM6ajtYeCO3gVY+4vlYJ6/QFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKLBqgyqNdqWoIach3ywyLdnFR2x+deh1cWUP0IsUgBMgt6Z7phh+9LXA7T8qsKAqQBvlab4csyJDIkUFvnW+0WNkROtzo4Ha131l+0wi+Bu0JzAha+lBPfXME3+cwDDSQSzYZ7fZ4ArsGH8SV0fbAEpU0M/I2tV9x6r1rGWBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEQ2u3gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F04C32782;
	Tue,  9 Jul 2024 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720503522;
	bh=eihBDEE0BRkjP+/D5kaM6ajtYeCO3gVY+4vlYJ6/QFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEQ2u3gisaj41cLqk3W0wZY2PX/643a/WIiVJHphnx2WjAOee347FdvnPaeO+zvrz
	 FNIFwqRUhUtDkrJ6Mtku0mupL2xDUA8zle1zjS0K6T+dKu2+VDRT7yZPZr4WYa2OLw
	 fV+5H2G2o/v5mBnUsOtEVIWdQU/VvtarAf6D7Q/RK7qbGFsdfQnQQjSSS0+kQ6dkI7
	 FEW93cHfwIw4Cj4UhQz/7Le9n7v3CLFbxzK6E+OiuFtdAcyGLkzq6dZeZ+XPvlMkZy
	 zKovpzvqRrcG93+J3ucEvkCsBqI7Yx4PVuM1Gt6VXcKNUUCB7EDyzcgo8aCExRgZ9h
	 tIqN/8/h9cK+Q==
Message-ID: <112e58d8-8a70-4aed-bf42-df4cdf47c0d2@kernel.org>
Date: Tue, 9 Jul 2024 14:38:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] block: Validate logical block size in
 blk_validate_limits()
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240708091651.177447-1-john.g.garry@oracle.com>
 <20240708091651.177447-3-john.g.garry@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240708091651.177447-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 18:16, John Garry wrote:
> Some drivers validate that their own logical block size. It is no harm to
> always do this, so validate in blk_validate_limits().
> 
> This allows us to remove the validation in most of those drivers.
> 
> Add a comment to blk_validate_block_size() to inform users that self-
> validation of LBS is usually unnecessary.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-settings.c   | 4 ++++
>  include/linux/blkdev.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 9fa4eed4df06..cd8a8eabc9a5 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -235,6 +235,10 @@ static int blk_validate_limits(struct queue_limits *lim)
>  	 */
>  	if (!lim->logical_block_size)
>  		lim->logical_block_size = SECTOR_SIZE;
> +	else if (blk_validate_block_size(lim->logical_block_size)) {
> +		pr_warn("Invalid logical block size (%d)\n", lim->logical_block_size);

logical_block_size is an unsigned int so this needs to use %u.

With this nit fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> +		return -EINVAL;
> +	}
>  	if (lim->physical_block_size < lim->logical_block_size)
>  		lim->physical_block_size = lim->logical_block_size;
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 02e04df27282..dce4a6bf7307 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -268,6 +268,7 @@ static inline dev_t disk_devt(struct gendisk *disk)
>  	return MKDEV(disk->major, disk->first_minor);
>  }
>  
> +/* blk_validate_limits() validates bsize, so drivers don't usually need to */
>  static inline int blk_validate_block_size(unsigned long bsize)
>  {
>  	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))

-- 
Damien Le Moal
Western Digital Research


