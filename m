Return-Path: <linux-kernel+bounces-180738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C768C7275
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2562DB23092
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAED137778;
	Thu, 16 May 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vco1HtXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4813443C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846799; cv=none; b=nETfXPLSkrjNH0Anfw1pqGa1y/HfZDVVJTqckaLpCGv7FvLWTqKdf5Q0q7jfKWfzGjZuJMCDQFfisMyzmyI08arKXI1rFjyX3YdPfDUJCZW9gt73Ympcvjj5GbgtJjqnfDUoFAwMMtIgRVWuWin2HhF684ZzS4Vpd2+9kDA3Kps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846799; c=relaxed/simple;
	bh=Cpes2UwySJ5Ss9+H0DDEAlFZX5mKWDHgKLb1yKMu3OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQg0e+NmB1XdSJtaOh8QPHQH0BUJXzxjf2OXwYtJmBwTQ2iScIWsVKsm4cbEnA66Zc7t696xfVrhDc6ahpYRgDCKcDDzeJsJQhunWNUK1bmxS278HinV3LvjWrmQkhR5kUF7VZgpJaC1t7eNpxNpqbj1vvjF7uabjlnCSEsw0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vco1HtXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C0BC32781;
	Thu, 16 May 2024 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715846798;
	bh=Cpes2UwySJ5Ss9+H0DDEAlFZX5mKWDHgKLb1yKMu3OI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vco1HtXF/lVJfAJo4GYPqv/q5dp57R2B9PypCmBdhq/n/3Hjebue4fGhBUEUb1m8o
	 EInyD9fNStefU14k2Q3xO5GKF44UFEphHfSSAXqGp7SzkdtDybBhupHbbg9J+XHmz4
	 AAGA0oHGuyV5ET5zZ59HFjz/gfmxAbWFhQHhuzZCaV4TjeLxjjtU+b05Eyg0QgkIrM
	 iQOBy30ImeILZIL/HRvUdxZIKyC3a0+9d2fszXSdRUJwvQC1zuP00MxJcDxI6PBXa+
	 hrkgdVbbJQ2E8uJJhAJb+HjZb8cfBeLqRpi42fN49u+OQPqjg029NZelaC2Hoq2SQJ
	 Kgmq4h6LRsRzg==
Message-ID: <c9c8b609-68b8-4f44-98eb-8d04e1a270fb@kernel.org>
Date: Thu, 16 May 2024 16:06:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs:modify the entering condition for
 f2fs_migrate_blocks()
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: bo.wu@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240515082433.24411-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240515082433.24411-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/15 16:24, Liao Yuanhong wrote:
> Currently, when we allocating a swap file on zone UFS, this file will
> created on conventional UFS. If the swap file size is not aligned with the
> zone size, the last extent will enter f2fs_migrate_blocks(), resulting in
> significant additional I/O overhead and prolonged lock occupancy. In most
> cases, this is unnecessary, because on Conventional UFS, as long as the
> start block of the swap file is aligned with zone, it is sequentially
> aligned.To circumvent this issue, we have altered the conditions for
> entering f2fs_migrate_blocks(). Now, if the start block of the last extent
> is aligned with the start of zone, we avoids entering
> f2fs_migrate_blocks().

Hi,

Is it possible that we can pin swapfile, and fallocate on it aligned to
zone size, then mkswap and swapon?

Thanks,

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/data.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 50ceb25b3..4d58fb6c2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3925,10 +3925,12 @@ static int check_swap_activate(struct swap_info_struct *sis,
>          block_t pblock;
>          block_t lowest_pblock = -1;
>          block_t highest_pblock = 0;
> +       block_t blk_start;
>          int nr_extents = 0;
>          unsigned int nr_pblocks;
>          unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
>          unsigned int not_aligned = 0;
> +       unsigned int cur_sec;
>          int ret = 0;
> 
>          /*
> @@ -3965,23 +3967,39 @@ static int check_swap_activate(struct swap_info_struct *sis,
>                  pblock = map.m_pblk;
>                  nr_pblocks = map.m_len;
> 
> -               if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
> +               blk_start = pblock - SM_I(sbi)->main_blkaddr;
> +
> +               if (blk_start % blks_per_sec ||
>                                  nr_pblocks % blks_per_sec ||
>                                  !f2fs_valid_pinned_area(sbi, pblock)) {
>                          bool last_extent = false;
> 
>                          not_aligned++;
> 
> +                       cur_sec = (blk_start + nr_pblocks) / BLKS_PER_SEC(sbi);
>                          nr_pblocks = roundup(nr_pblocks, blks_per_sec);
> -                       if (cur_lblock + nr_pblocks > sis->max)
> +                       if (cur_lblock + nr_pblocks > sis->max) {
>                                  nr_pblocks -= blks_per_sec;
> 
> +                               /* the start address is aligned to section */
> +                               if (!(blk_start % blks_per_sec))
> +                                       last_extent = true;
> +                       }
> +
>                          /* this extent is last one */
>                          if (!nr_pblocks) {
>                                  nr_pblocks = last_lblock - cur_lblock;
>                                  last_extent = true;
>                          }
> 
> +                       /*
> +                        * the last extent which located on conventional UFS doesn't
> +                        * need migrate
> +                        */
> +                       if (last_extent && f2fs_sb_has_blkzoned(sbi) &&
> +                               cur_sec < GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi)))
> +                               goto next;
> +
>                          ret = f2fs_migrate_blocks(inode, cur_lblock,
>                                                          nr_pblocks);
>                          if (ret) {
> @@ -3994,6 +4012,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
>                                  goto retry;
>                  }
> 
> +next:
>                  if (cur_lblock + nr_pblocks >= sis->max)
>                          nr_pblocks = sis->max - cur_lblock;
> 
> --
> 2.25.1
> 

