Return-Path: <linux-kernel+bounces-391616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA59B8958
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F073AB2189E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589931369B4;
	Fri,  1 Nov 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o62mErCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34847482
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428570; cv=none; b=CuozTTCMC6Y38WUmYGCZ0lbPiQl30uuxPaC4Yso9DXnw2oFvWTvWKwZRxffuU+NM/i8Wzb9DeH0Zq5uPjtZfmxQFT387y/r8CjkK678tnjPu73kbmYI13ms37U8L3A6gaWFugQUVgADUcfsiGGMUd1hjlLtOlvnH3NnH+wtrZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428570; c=relaxed/simple;
	bh=0huvr86IZjuH0dxBEMWUcQq3vXzn9tBf7P+2WdfP0Fg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mRcYtwmqesK+7vkklWjho188/7/hQOUOy3zag4iarGidIN5kAZpUQJp3C7FA9n/bfxsMMv2QFIQhZlOtdJdB26pOM0jbrFzXv2dcMsp55NoH42VVuorc9k0MLexrEKw5PHwd5xDZolFPgAjJVizYoRW0UExukfyUPLgho6z1dhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o62mErCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D7CC4CEC3;
	Fri,  1 Nov 2024 02:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428570;
	bh=0huvr86IZjuH0dxBEMWUcQq3vXzn9tBf7P+2WdfP0Fg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=o62mErCHPvdOWVzRcHE2AHdgIYSmL5c0Y+u9oJeAJpriwsA3hlhXXJ7o486fqrXX4
	 VlUYPYvb4Pniy8+wH6X+7FCOiT0IvpTuyrl1s+8Gm2Q3B6fAaU53+xjFOtGhwFY8I+
	 y9pProlQjWYESmObVyjTm1D/wf60CXwEtUPwmrVuPfieTa+NpBMgpVOac87DPMZA8m
	 Wiiviih3MILCOuPywC/zV+5SejXTyqLOrVo2PDfNf5kLG8x+ju81PPhP+9FICxTR1b
	 eU1c2ifVTqBrLAucISlJrHYO3xJTDxBwi/5k+gCxAGj7qvIgV4enEDKB7J/polCxyF
	 soyfXnLD5o0rA==
Message-ID: <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
Date: Fri, 1 Nov 2024 10:36:05 +0800
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
Subject: Re: [PATCH 2/2] f2fs: fix to adjust appropriate length for fiemap
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
 <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/31 13:59, Zhiguo Niu wrote:
> If user give a file size as "length" parameter for fiemap
> operations, but this size is non-block size aligned,
> it will show 2 segments fiemap results even this whole file
> is contiguous on disk, such as the following results, please
> note that this f2fs_io has been modified for testing.
> 
>   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> Fiemap: offset = 0 len = 19304
>          logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> 
> after this patch:
>   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> Fiemap: offset = 0 len = 19304
> 	logical addr.    physical addr.   length           flags
> 0	0000000000000000 00000000315f3000 0000000000005000 00001000

Why is FIEMAP_EXTENT_LAST missing in #0 extent? As we can see it
in #1 extent before your change.

1       0000000000004000 0000000020bae000 0000000000001000 00001001

Thanks,

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> f2fs_io has been modified for testing, the length for fiemap is
> real file size, not block number
> ---
>   fs/f2fs/data.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 90fa8ab..8c9bb42 100644
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
>   
>   	start_blk = bytes_to_blks(inode, start);
>   	last_blk = bytes_to_blks(inode, start + len - 1);


