Return-Path: <linux-kernel+bounces-342779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A629892F0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7AB1F21688
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4122092;
	Sun, 29 Sep 2024 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd1kdb0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C6AD51
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727582073; cv=none; b=Wka2wPtxJ5eagiz/U/b9mtMKBBPLWk0xnPOWOQAK+Qzdq8B26EYD8py48EvBQnNK0MjV5LfxeFlAUVKFzSSg96kfKvrijhr/qlWLiIs3StEpOhiLMavz2ahoo+PwzROZdzcNpQYIRP4uBZTT3C+PVfmK4DpBT3vfJmOZnjrLwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727582073; c=relaxed/simple;
	bh=jQnK/zdWBtGm7aEm9PQXE3LpQ7q2Wkf1+dqFPprS3rg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/rOail5xrZ//0dtiTjpnnskJ5xGIyna4Kcsfo/1f0NgZVcpCmZev2/oB3+YgHyjMr4T0hDomGiQaX0ASbPEr/OmN0ymig13dj4mxgNBgXQCRjRBzXzfk7NtTE6ysgggcwcT3UPLK/uN07X7O4KHUB3j2LxSHuKwh/kgouBpZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd1kdb0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3155EC4CEC6;
	Sun, 29 Sep 2024 03:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727582071;
	bh=jQnK/zdWBtGm7aEm9PQXE3LpQ7q2Wkf1+dqFPprS3rg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bd1kdb0/4I/cwnVfN61Z2dTw1qOrkXYgERk9PthE3i/QyAjfC3lE7ph7uHqJl2fOn
	 04x5sjU1JVS0AYGO+Rhc2EZk4bbzwOzV8/rhLcaBYt2EhGYkstObGTnGRO6LIODpKt
	 vpLDkLMgNEqzhVxb9EUKYsq3+A8XqJDG1aL0b2dvkHKkyk4TqfZygtyg+kyPe8+rCO
	 jhbqTdKjA6949Zn55HvEaRWeZWrlw5A8Z4YfNVGq2mCGgWVSb73HIhThqCWiS6gFbU
	 nOUh03cE3jQYW3oOfEILvUUuNwNfF4hi5iQq9ZE4STJHRpO9c7kk1GUR5x9UIEUxTL
	 0X/VUrKOdl+6Q==
Message-ID: <8b368a3a-a25d-42c0-a5b5-f3da4f28c8cc@kernel.org>
Date: Sun, 29 Sep 2024 11:54:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: compress: fix inconsistent update of i_blocks in
 release_compress_blocks and reserve_compress_blocks
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20240929024343.3763975-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240929024343.3763975-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/29 10:43, Qi Han wrote:
> After release a file and subsequently reserve it, the FSCK flag is set
> when the file is deleted, as shown in the following backtrace:
> 
> F2FS-fs (dm-48): Inconsistent i_blocks, ino:401231, iblocks:1448, sectors:1472
> fs_rec_info_write_type+0x58/0x274
> f2fs_rec_info_write+0x1c/0x2c
> set_sbi_flag+0x74/0x98
> dec_valid_block_count+0x150/0x190
> f2fs_truncate_data_blocks_range+0x2d4/0x3cc
> f2fs_do_truncate_blocks+0x2fc/0x5f0
> f2fs_truncate_blocks+0x68/0x100
> f2fs_truncate+0x80/0x128
> f2fs_evict_inode+0x1a4/0x794
> evict+0xd4/0x280
> iput+0x238/0x284
> do_unlinkat+0x1ac/0x298
> __arm64_sys_unlinkat+0x48/0x68
> invoke_syscall+0x58/0x11c
> 
> For clusters of the following type, i_blocks are decremented by 1 and
> i_compr_blocks are incremented by 7 in release_compress_blocks, while
> updates to i_blocks and i_compr_blocks are skipped in reserve_compress_blocks.
> 
> raw node:
> D D D D D D D D
> after compress:
> C D D D D D D D
> after reserve:
> C D D D D D D D
> 
> Let's update i_blocks and i_compr_blocks properly in reserve_compress_blocks.

Hi, Qi,

Thank you for catching this.

> 
> Fixes: eb8fbaa53374 ("f2fs: compress: fix to check unreleased compressed cluster")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/file.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9ae54c4c72fe..7500b4067996 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3791,12 +3791,6 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
>   
>   		to_reserved = cluster_size - compr_blocks - reserved;
>   
> -		/* for the case all blocks in cluster were reserved */
> -		if (to_reserved == 1) {

I think this case is trying to catch abnormal condition and try to
handle it correctly, e.g. compressed cluster was not released due
to it fails in release_compress_blocks(), so status of compress
cluster may be: C D N N N N N N.

So the right check condition should be?

if (reserved && to_reserved == 1)

Thoughts?

And I think we'd better add a testcase in fstests to cover all these
cases, let me figure out a patch soon.

Thanks,

> -			dn->ofs_in_node += cluster_size;
> -			goto next;
> -		}
> -
>   		ret = inc_valid_block_count(sbi, dn->inode,
>   						&to_reserved, false);
>   		if (unlikely(ret))


