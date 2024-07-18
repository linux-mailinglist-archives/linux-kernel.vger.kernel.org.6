Return-Path: <linux-kernel+bounces-256155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568829349FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884CE1C21A74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CC7D07E;
	Thu, 18 Jul 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZuE5BMW3"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959576C76
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291730; cv=none; b=IYy5iE2SL4U+1InPqvirO/yVMl8OWFMOrZTzij1a/MOQQINnFIHFytNEzWl4hZ4so0Fz3RiLazID3GPoSeoXCvrM1wRoBcQO4v9fESeDl8MhqwY5xcR/8lTt3m+28KnDfKijwFsNY5xNMih3upeqdqozqf+PAxEZfxAsrWV/Pl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291730; c=relaxed/simple;
	bh=ZcjGaThk43r2VNt3TZKk82NYHBE8OHlbTdfT0XNuLSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qr3vGbbaostHEqmHNNjdDgCY5BrTmzpPzSsLE403gfMVtPHJivy4M73dOY2/JueXQb3NbaVGGajr/3K0uuh3emUmEpQNp085sdDQLosJSM8U08lDxs6+iU30pYWIC3JRMayFzY/vlvMX+uXbcXrQk0bmW049+LSEiInOqcxpag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZuE5BMW3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721291720; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kVIiWbjT2MUtWNFGmAxUAO5KdbPF+pPGe2sz+VSsX+8=;
	b=ZuE5BMW3GmO1vKfGgG9BQbfxgxCWSc8OZMoRmivLXd0Ee91Bm2wJKoxM+5/tuhwWOgtJsC3HkIJiBo09dAKJzYX+3adfu7u++ZVM3/CLfIqvinN4103oH1z7mHxXdqzOeHHo/9MPH/iQXrk6jzagmBFqlMuBNPX5y5Uy3zvWKIU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WAnmEir_1721291719;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAnmEir_1721291719)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 16:35:19 +0800
Message-ID: <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
Date: Thu, 18 Jul 2024 16:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: support STATX_DIOALIGN
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240718063756.2982763-1-lihongbo22@huawei.com>
 <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/18 16:32, Gao Xiang wrote:
> From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>

Also I will fix the email address issue
(Hongbo Li <lihongbo22@huawei.com>) when applying too.

> 
> Add support for STATX_DIOALIGN to erofs, so that direct I/O
> alignment restrictions are exposed to userspace in a generic
> way.
> 
> [Before]
> ```
> ./statx_test /mnt/erofs/testfile
> statx(/mnt/erofs/testfile) = 0
> dio mem align:0
> dio offset align:0
> ```
> 
> [After]
> ```
> ./statx_test /mnt/erofs/testfile
> statx(/mnt/erofs/testfile) = 0
> dio mem align:512
> dio offset align:512
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Hongbo,
> 
> I tidy up the patch a bit according to the current codebase,
> I will apply this later for this cycle.
> 
> Also r-v-bs are always welcome...
> 
> Thanks,
> Gao Xiang
> 
>   fs/erofs/inode.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..43c09aae2afc 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -334,14 +334,29 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   		  unsigned int query_flags)
>   {
>   	struct inode *const inode = d_inode(path->dentry);
> +	bool compressed =
> +		erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
>   
> -	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
> +	if (compressed)
>   		stat->attributes |= STATX_ATTR_COMPRESSED;
> -
>   	stat->attributes |= STATX_ATTR_IMMUTABLE;
>   	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>   				  STATX_ATTR_IMMUTABLE);
>   
> +	/*
> +	 * Return the DIO alignment restrictions if requested.
> +	 *
> +	 * In EROFS, STATX_DIOALIGN is not supported in ondemand mode and
> +	 * compressed files, so in these cases we report no DIO support.
> +	 */
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> +		stat->result_mask |= STATX_DIOALIGN;
> +		if (!erofs_is_fscache_mode(inode->i_sb) && !compressed) {
> +			stat->dio_mem_align =
> +				bdev_logical_block_size(inode->i_sb->s_bdev);
> +			stat->dio_offset_align = stat->dio_mem_align;
> +		}
> +	}
>   	generic_fillattr(idmap, request_mask, inode, stat);
>   	return 0;
>   }

