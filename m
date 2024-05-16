Return-Path: <linux-kernel+bounces-180546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FAA8C7002
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19811F21D08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E111A1366;
	Thu, 16 May 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sYZroa7X"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890610F1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822740; cv=none; b=aO2tGN+TS2EPlZfRMyZIblfeSpPpoRd+zAMvDkI3kLLtjxlYuKiQumc1Fvqq+IRSy0lV6biTMQJOnVP7eA06tHpwZtgcWeuWrUmmc+ymwNWGmtlvshKEbqpu1JF+8RpYDZs25IOwbOcjV67VYiK240A0kUzyAyFp+ZX1m/lVEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822740; c=relaxed/simple;
	bh=hzGJgKulpQX2J2VYQHpmUzBVbITwBgGfAjtKWVSlGtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGFkMuqHYO2ti6wLngShmE6XswHr4X+9ISnxTG2aHjj9KRYjOnqQCsOlW7F2zcV4hhKM07ri4/rrmn1so+PJbbSy1IWq5s1RmScafUIckjc95EwWcIX+PlNOa23YGzO5gpgJpn6eYWIPjnGqx2UdsHGqcTY0ieUXat1J6AL3t0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sYZroa7X; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715822728; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r1isWmBJiUBnwSRE2U9rv0XS6h/F0ZDmTQNKcWxVn5Q=;
	b=sYZroa7XpUiq6yshDlolEvEle0qYc+iNHeyzHyXt8MPbSlBVY73Ujw6MHLwYhjhqflHooT7fHTqk3zb5+Xyc5lPGKnRaTnwizuYZDZg54J7QhqL+Kchvf/VrPcdVlzN8IGAvwkdOoRR+NRFNbW1XhsFUYEiuSAFSdDtwYvMEpVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W6ZBgVk_1715822726;
Received: from 30.221.128.154(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W6ZBgVk_1715822726)
          by smtp.aliyun-inc.com;
          Thu, 16 May 2024 09:25:28 +0800
Message-ID: <cb1d3df4-db34-447d-b265-e4fad5a1fe7f@linux.alibaba.com>
Date: Thu, 16 May 2024 09:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: add bounds checking to
 ocfs2_xattr_find_entry()
To: Ferry Meng <mengferry@linux.alibaba.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <20240515132934.69511-1-mengferry@linux.alibaba.com>
 <20240515132934.69511-2-mengferry@linux.alibaba.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240515132934.69511-2-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 9:29 PM, Ferry Meng wrote:
> Just add redundant (perhaps paranoia) checks to make sure it doesn't
> stray beyond valid meory region of ocfs2 xattr entry array during a
> single match.
> 
> Maybe this patch can prevent some crash caused by crafted poison images.
> 

I'd rather restructure the commit message as below:

Add a paranoia check to make sure it doesn't stray beyond valid memory
region containing ocfs2 xattr entries when scanning for a match.
It will prevent out-of-bound access in case of crafted images.

> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
> ---
>  fs/ocfs2/xattr.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 3b81213ed7b8..37be4a286faf 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -1062,8 +1062,8 @@ ssize_t ocfs2_listxattr(struct dentry *dentry,
>  	return i_ret + b_ret;
>  }
>  
> -static int ocfs2_xattr_find_entry(int name_index,
> -				  const char *name,
> +static int ocfs2_xattr_find_entry(struct inode *inode, void *end,

'end' can be obtained from ocfs2_xattr_search directly.

Thanks,
Joseph

> +				  int name_index, const char *name,
>  				  struct ocfs2_xattr_search *xs)
>  {
>  	struct ocfs2_xattr_entry *entry;
> @@ -1076,6 +1076,10 @@ static int ocfs2_xattr_find_entry(int name_index,
>  	name_len = strlen(name);
>  	entry = xs->here;
>  	for (i = 0; i < le16_to_cpu(xs->header->xh_count); i++) {
> +		if ((void *)entry >= end) {
> +			ocfs2_error(inode->i_sb, "corrupted xattr entries");
> +			return -EFSCORRUPTED;
> +		}
>  		cmp = name_index - ocfs2_xattr_get_type(entry);
>  		if (!cmp)
>  			cmp = name_len - entry->xe_name_len;
> @@ -1166,7 +1170,7 @@ static int ocfs2_xattr_ibody_get(struct inode *inode,
>  	xs->base = (void *)xs->header;
>  	xs->here = xs->header->xh_entries;
>  
> -	ret = ocfs2_xattr_find_entry(name_index, name, xs);
> +	ret = ocfs2_xattr_find_entry(inode, xs->end, name_index, name, xs);
>  	if (ret)
>  		return ret;
>  	size = le64_to_cpu(xs->here->xe_value_size);
> @@ -2698,7 +2702,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
>  
>  	/* Find the named attribute. */
>  	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL) {
> -		ret = ocfs2_xattr_find_entry(name_index, name, xs);
> +		ret = ocfs2_xattr_find_entry(inode, xs->end, name_index, name, xs);
>  		if (ret && ret != -ENODATA)
>  			return ret;
>  		xs->not_found = ret;
> @@ -2833,7 +2837,7 @@ static int ocfs2_xattr_block_find(struct inode *inode,
>  		xs->end = (void *)(blk_bh->b_data) + blk_bh->b_size;
>  		xs->here = xs->header->xh_entries;
>  
> -		ret = ocfs2_xattr_find_entry(name_index, name, xs);
> +		ret = ocfs2_xattr_find_entry(inode, xs->end, name_index, name, xs);
>  	} else
>  		ret = ocfs2_xattr_index_block_find(inode, blk_bh,
>  						   name_index,

