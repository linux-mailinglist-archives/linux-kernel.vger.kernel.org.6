Return-Path: <linux-kernel+bounces-413660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570459D1D05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0392B1F21AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9440BE0;
	Tue, 19 Nov 2024 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs/H4vG/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BD2D047
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978719; cv=none; b=BO1sSH81tY78xuNrt+nXWJgX4Re7XqaqTs1tncd+Pp4T8NRMZb1CrM0ahvlSNl4YAAyLzhkcUJ2Sv1IXltZcQhWClowThxJO4vsWzasAdRCo1/Qi5ErK/5B+HNt1viKT6piRL6xHjxTFZqfgBgAv/OoAmyYkzh/PReMH67FDp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978719; c=relaxed/simple;
	bh=5GqFx1fD8zSbopaJaZOgppfLuxZcO4ZGnmyqWC0RSpY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivMBIPjBARSBK2JM8HRIJz4WmFqyspSy7pPaTfpZyotiMbQ3NiZR4eRlWPXX8PYMY4guKCL/00Hyef4NOVFUu8U2M24opYQTtZZnXb/Y8gQ3W3VwrJ4d8PRJoBXzUtLKuJnObhWpc68VaF05LH/9NHYHmFx2hbTyk1tTt/XZ3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs/H4vG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883E0C4CECC;
	Tue, 19 Nov 2024 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978719;
	bh=5GqFx1fD8zSbopaJaZOgppfLuxZcO4ZGnmyqWC0RSpY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Bs/H4vG/RwefsIScLr4GSF/IMbJpm0uqiiDgkOUALs+4Viulqd8AqsOPIOixYlbJx
	 8a8yoYOQy2ozHP+anAZuRauaXMiiYb9wBxz7/1+3tmy5cB+3xhWE0rO3+cdEVuiVhe
	 vn4QgDshX1M1JKuK173YAzWcISWVhkTKNERoGZC5j2Mbi6ekiGJMllS1QCm6qlc0LF
	 VaT0T7rcrhnyg9TRxpSHbTnx2wNyCOhtF7CLnWhjDjHYpd692W/fovvdH46xEc6kNa
	 HnEAy7MDFqaoW6xR1fnEi8bKenyBFbZwmjB27LtT87uxYxX9K8v8cNZHPNvgZfjwlz
	 0RKCubA4VsX4w==
Message-ID: <6b58469c-2a93-4839-9fb9-4e6ec901c308@kernel.org>
Date: Tue, 19 Nov 2024 09:11:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES,
 BTYES_TO_BLK} to avoid overflow
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241108012557.572782-1-chao@kernel.org>
 <ZzuCfgTp9m1eqIGa@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZzuCfgTp9m1eqIGa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/19 2:07, Jaegeuk Kim wrote:
> I applied this with the below change to avoid build failure.

Thank you!

Thanks,
> 
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3336,7 +3336,7 @@ loff_t max_file_blocks(struct inode *inode)
>           * fit within U32_MAX + 1 data units.
>           */
> 
> -       result = min(result, F2FS_BYTES_TO_BLK(((loff_t)U32_MAX + 1) * 4096));
> +       result = umin(result, F2FS_BYTES_TO_BLK(((loff_t)U32_MAX + 1) * 4096));
> 
>          return result;
>   }
> 
> On 11/08, Chao Yu wrote:
>> It missed to cast variable to unsigned long long type before
>> bit shift, which will cause overflow, fix it.
>>
>> Fixes: f7ef9b83b583 ("f2fs: introduce macros to convert bytes and blocks in f2fs")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   include/linux/f2fs_fs.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index b0b821edfd97..3b2ad444c002 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -24,10 +24,10 @@
>>   #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
>>   #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */
>>   
>> -#define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
>> -#define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
>> +#define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS)
>> +#define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) << F2FS_BLKSIZE_BITS)
>>   #define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
>> -#define F2FS_BLK_ALIGN(x)			(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>> +#define F2FS_BLK_ALIGN(x)		(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>>   
>>   /* 0, 1(node nid), 2(meta nid) are reserved node id */
>>   #define F2FS_RESERVED_NODE_NUM		3
>> -- 
>> 2.40.1


