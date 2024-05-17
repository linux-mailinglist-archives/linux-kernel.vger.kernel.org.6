Return-Path: <linux-kernel+bounces-182013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915048C851D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39775284BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145633AC36;
	Fri, 17 May 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kOVVxkPh"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621603A1C5
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943168; cv=none; b=pltXRIHCGYqO75ScXtYev3ZBxwsYvhaQnYQZ5T2ndyE5l3GshocVFC1eTLyENcpbZv1UIyONuP3SKYJRRkA7jjB9GVGh3g8rXAUs+Y3ncv+Br7ELpaP97fFlfA9SrCQUmY99IthSw1KnRvc4OAO3lwwr/w4VECunObA7in+7sWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943168; c=relaxed/simple;
	bh=JDqGBD0D5kpmPykpBr4kW+JyQRNpCrU3OX4bPh5dBfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVyJhrvddFcHmca5ZLuM4qfG4TqpzrbT+y0MQ1uQ6HofTODu4shDM78iUtnvCHrlfojHFD+tADSiHCR4aZPhvaRy03TYIXsXTeV+S2tfbUJNFcrKpJt747rbbLQ/WvyhPe6Za2+LsSDR/YzCFeqYQrVgXC9Dauxuy/GEaAkF0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kOVVxkPh; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715943157; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XHU484ru7u5dgmBpXpNyU6IxS0QHgLQgPSB3Je2RxDQ=;
	b=kOVVxkPhqQeAvGu0OWGG14B9bHGqABgdrWPx4C4LTsR+Sl/xbCyFAAR5B4tf7IHe8aXUBMDln2SHN9K0ulBP5ysdILF+lJ3MTb6NvyT/7Aq0kCUhbgiQHRWc0675h9sP9n07p8J35jHiJvXC8elUb1P+d2fg9XXWtpsdaUD6Yaw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6eXBwH_1715943155;
Received: from 30.221.128.140(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W6eXBwH_1715943155)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 18:52:36 +0800
Message-ID: <1b906ebc-a850-4974-8ceb-e33d88768bf1@linux.alibaba.com>
Date: Fri, 17 May 2024 18:52:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ocfs2: add bounds checking to
 ocfs2_xattr_find_entry()
To: Ferry Meng <mengferry@linux.alibaba.com>, lei lu <llfamsec@gmail.com>,
 akpm <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, ocfs2-devel@lists.linux.dev
References: <20240517094147.87133-1-mengferry@linux.alibaba.com>
 <20240517094147.87133-2-mengferry@linux.alibaba.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240517094147.87133-2-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/17/24 5:41 PM, Ferry Meng wrote:
> Add a paranoia check to make sure it doesn't stray beyond valid memory
> region containing ocfs2 xattr entries when scanning for a match.
> It will prevent out-of-bound access in case of crafted images.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reported-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/xattr.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 3b81213ed7b8..8aea94c90739 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -1062,7 +1062,7 @@ ssize_t ocfs2_listxattr(struct dentry *dentry,
>  	return i_ret + b_ret;
>  }
>  
> -static int ocfs2_xattr_find_entry(int name_index,
> +static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
>  				  const char *name,
>  				  struct ocfs2_xattr_search *xs)
>  {
> @@ -1076,6 +1076,10 @@ static int ocfs2_xattr_find_entry(int name_index,
>  	name_len = strlen(name);
>  	entry = xs->here;
>  	for (i = 0; i < le16_to_cpu(xs->header->xh_count); i++) {
> +		if ((void *)entry >= xs->end) {
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
> +	ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
>  	if (ret)
>  		return ret;
>  	size = le64_to_cpu(xs->here->xe_value_size);
> @@ -2698,7 +2702,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
>  
>  	/* Find the named attribute. */
>  	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL) {
> -		ret = ocfs2_xattr_find_entry(name_index, name, xs);
> +		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
>  		if (ret && ret != -ENODATA)
>  			return ret;
>  		xs->not_found = ret;
> @@ -2833,7 +2837,7 @@ static int ocfs2_xattr_block_find(struct inode *inode,
>  		xs->end = (void *)(blk_bh->b_data) + blk_bh->b_size;
>  		xs->here = xs->header->xh_entries;
>  
> -		ret = ocfs2_xattr_find_entry(name_index, name, xs);
> +		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
>  	} else
>  		ret = ocfs2_xattr_index_block_find(inode, blk_bh,
>  						   name_index,

