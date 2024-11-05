Return-Path: <linux-kernel+bounces-396010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E629BC6AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BDDB23446
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490731FE0F4;
	Tue,  5 Nov 2024 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9b1sj5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40911FDF9D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790264; cv=none; b=QSBS6+FctQwswgzmGLOIKDO+6PWEwReF6DIaj/lFzh/cw7pt3EMoJpC4cz7EMbbd+zw1wt6J4bUp0ZrR4Ka/236QwCBp7mXhMWrBcCbXeAzF7ruhVGI1Dow8gGD8jmVgbIpVgMHb57x2OfzB0HJ1bAPg+fUHlyIWzyd5DuejPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790264; c=relaxed/simple;
	bh=bbE301m90ULv29UrCtK4FKya/NA2/RTIhNtW40SMa7M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uj6ZYLFdpGvorO9RFfCAWEIr+wkEGWaMTKx3E1GHzer7nMDd+JrdFbiAe/eUvcAwYqdOSdtggdg6I0EMSearBT1793Eu8J/lAaSnKTeyod1uMW/lUwBs2fAIiQfAvnyy/WYyKVKzWe3CAJ0X/G2lz3ufcq+CjwNqYE56uCo9tQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9b1sj5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFABC4CECF;
	Tue,  5 Nov 2024 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730790264;
	bh=bbE301m90ULv29UrCtK4FKya/NA2/RTIhNtW40SMa7M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=K9b1sj5h6ECF4jsJwNY+ic/mV0j84+esX6RTfeJuUGyVKSTHqzwpxK17fhxTS43Td
	 1tmtdvByWPwGhatX3OWvtW2S16Qqx3yqrg8g6FrQ7Hj58vWd5v0IWebGhWG+0L6U30
	 OQWcLp662hDzkhwjuW8YzHH4rXbkBGBM2guXXMP7r0ruAdiWQ/AeULM3PCbbZ02Z7P
	 puK9DSPFIfSCRP1CkfomtiM5DbxGGnJmelhd6qqBlTIJ0Pz2swhYODZL7S/0tNbydm
	 q+8QBHcOMjhZWQJD6HX9w8ssJD7XgJG/ErbU/jGbDxBpPJVuUWD+3vEydhZ6HPlz1t
	 Pfy0rbaRo3fMg==
Message-ID: <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org>
Date: Tue, 5 Nov 2024 15:04:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/4 9:56, Zhiguo Niu wrote:
> If user give a file size as "length" parameter for fiemap
> operations, but if this size is non-block size aligned,
> it will show 2 segments fiemap results even this whole file
> is contiguous on disk, such as the following results:
> 
>   ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> Fiemap: offset = 0 len = 19034
>          logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> 
> after this patch:
> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> Fiemap: offset = 0 len = 19034
>      logical addr.    physical addr.   length           flags
> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> V2: correct commit msg according to Chao's questions
> f2fs_io has been modified for testing, the length for fiemap is
> real file size, not block number
> ---
>   fs/f2fs/data.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 306b86b0..9fc229d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   			goto out;
>   	}
>   
> -	if (bytes_to_blks(inode, len) == 0)
> -		len = blks_to_bytes(inode, 1);
> +	if (len & (blks_to_bytes(inode, 1) - 1))
> +		len = round_up(len, blks_to_bytes(inode, 1));

How do you think of getting rid of above alignment for len?

>   
>   	start_blk = bytes_to_blks(inode, start);
>   	last_blk = bytes_to_blks(inode, start + len - 1);

And round up end position w/:

last_blk = bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSIZE));

Thanks,


