Return-Path: <linux-kernel+bounces-395835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5659BC3B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72656B215FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB918132A;
	Tue,  5 Nov 2024 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE/R62T5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C336AEC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776550; cv=none; b=dS7EcP9N+6G73U2PuDVRSj3CMbKvLimstDje53TCvVjfI/zv0cTxCUSBxtE+TUyaP6ZV4lto/CL/72cpjUG4awfzatoDoCgCJLS12EA1Kg0GCsKKd5Ao1msQP8wPNR5aCAaSn3tKEawyoPmezIwTfxrwjZQ8A/Nkx4DjM9DoFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776550; c=relaxed/simple;
	bh=DYXSN1MfpgZ26ekPgjplaJVj/lw8x307aYQ/0XgHtU4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=puj26NjJIuRckMatk5/8MoUEwBuOxNOrz87pg5S9jEwCNO9OI2jrkVpM3/FLAQB3UHrqm2CZRKT3HR8mVBcNKp++IqOJlkLLRFIeREHHXuMXD8x1qTuzYATA985au23TLgDhbtkfo1EE45Y3rJgcO3Bb0Lh4c9kctYNhH8eCVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE/R62T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A1C4CECE;
	Tue,  5 Nov 2024 03:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730776550;
	bh=DYXSN1MfpgZ26ekPgjplaJVj/lw8x307aYQ/0XgHtU4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UE/R62T5BX+eGYvqU2C3kKQxv23yQeGzxoXHNj0A5co4FYMlLgbBAKJpLhhoimG0k
	 848q6aHGWddZrz6PeXNmQxOK8ljcSi/kpNFuZQrzoZpFv/Icp7/+SmyUpDlIusAnA0
	 NXkQXxvtGalBM8PiVpxmf+OOusB3fghfvEmeWd5ULKwP45k15+xIGJwlvzk57EwNyQ
	 eq1S8L6mQn594GSEXddbhDWH+LUA7oMEqTPKVcZ3bOijwB62HNJZYRyVmD/AN7DTzt
	 rLh1lq5prVqYZ/spSYxLcdJImlt0TGDMPQJ1xaIKNGWmMC1lAwKVzli8R11qlCEpCe
	 L7EhCtYRVsoew==
Message-ID: <888aaf87-1363-4c1f-bd95-d119c72d7b30@kernel.org>
Date: Tue, 5 Nov 2024 11:15:45 +0800
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

Hi Zhiguo,

Any testcase to reproduce this bug? w/o this patch, it looks output
from fiemap looks fine?

f2fs_io fiemap 0 19034 file
Fiemap: offset = 0 len = 19034
	logical addr.    physical addr.   length           flags
0	0000000000000000 0000000004401000 0000000000005000 00001001

Thanks,

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
>   
>   	start_blk = bytes_to_blks(inode, start);
>   	last_blk = bytes_to_blks(inode, start + len - 1);


