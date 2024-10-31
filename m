Return-Path: <linux-kernel+bounces-390080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D526D9B753D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811B61F21981
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08C149C54;
	Thu, 31 Oct 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMiC4EVa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835814884D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359160; cv=none; b=nV471Prde2v4QM+6DRibLznAQiZbRzY6Ok0IzGDxSEfVw/5VLT5L4DJyplcieQ5EibdE7Y9ofk5hqAqpCdJkEs9uAtjs2BlTQBqajM+XBJy2n+NdGL/bJB+V/KyfUJP/usN6uVAt8wLKUsg4k1sCVMgY1t7AsHoLzvJeCu8CT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359160; c=relaxed/simple;
	bh=G1joOcZYVzyi+CpWThJYYljoZ34bPNrUyzqzZp2mieM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jH/csTyYtkcviF6fXlGz99nTk4HtI+cyO26AnQZqQLnVPcHQUUnAz3EdUXzmYvw6JhRyCGQdimdv401Y6SnGbtPkPvm8P7a1jUQQTdBXLp+V1Yb5Tgs5VxQaUhA+fIcOdJATTA/A4g+ftgMsFAmQYQuEWk3JQjV2WVoDCT6ws0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMiC4EVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D03C4CEC3;
	Thu, 31 Oct 2024 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730359160;
	bh=G1joOcZYVzyi+CpWThJYYljoZ34bPNrUyzqzZp2mieM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fMiC4EVapi5C1MT5gjVRtLMnN+GYG5+8V4cLi2fM6euLZJKtYxeUIMf+tfVkOjJWT
	 03+c1Ys1x42N1Xpmpydoe3KKZDiJeT0DJ2pHe6uZ0enYH0DXtaW7zw3hKckQu0ahwv
	 l1N7gUzyUbZTTQXP0yhg7YUagZvFybjBFAKFWsoctk0+Smdf++ORcZpcTiS/nmY4UZ
	 /DLLR50GTnrEuwg3JKQ2KBgMiTJXgPMGqfXCABJhGnr0P1vTLu6fra00FgUQuhewzB
	 ejFgwia1s6NPgk00bxjCYgam//rmg68NdnY25m95Fva3rOyhY1lLrpb107odGHWOS+
	 yOxT2UJEy4MWQ==
Message-ID: <290e29df-3f63-4de9-a18f-c5c4190d85f1@kernel.org>
Date: Thu, 31 Oct 2024 15:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, sunyibuaa@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH v2 1/5] f2fs: blocks need to belong to the same segment
 when using update_sit_entry()
To: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
 <20241030103136.2874140-2-yi.sun@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241030103136.2874140-2-yi.sun@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/30 18:31, Yi Sun wrote:
> When using update_sit_entry() to release consecutive blocks,
> ensure that the consecutive blocks belong to the same segment.
> Because after update_sit_entry_for_realese(), @segno is still
> in use in update_sit_entry().

I think this patch should be merged into
"f2fs: introduce update_sit_entry_for_release()".

Thanks,

> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>   fs/f2fs/segment.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bb2fd98331cd..a5bd101c63a1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2424,6 +2424,10 @@ static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr,
>   		SIT_I(sbi)->max_mtime = ctime;
>   }
>   
> +/*
> + * NOTE: when updating multiple blocks at the same time, please ensure
> + * that the consecutive input blocks belong to the same segment.
> + */
>   static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_entry *se,
>   				block_t blkaddr, unsigned int offset, int del)
>   {
> @@ -2434,6 +2438,8 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
>   	int i;
>   	int del_count = -del;
>   
> +	f2fs_bug_on(sbi, GET_SEGNO(sbi, blkaddr) != GET_SEGNO(sbi, blkaddr + del_count - 1));
> +
>   	for (i = 0; i < del_count; i++) {
>   		exist = f2fs_test_and_clear_bit(offset + i, se->cur_valid_map);
>   #ifdef CONFIG_F2FS_CHECK_FS
> @@ -2476,6 +2482,11 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
>   	return del;
>   }
>   
> +/*
> + * If releasing blocks, this function supports updating multiple consecutive blocks
> + * at one time, but please note that these consecutive blocks need to belong to the
> + * same segment.
> + */
>   static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>   {
>   	struct seg_entry *se;


