Return-Path: <linux-kernel+bounces-182014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECC8C851E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2222844DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7B3AC25;
	Fri, 17 May 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JjuDLVNQ"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEC3D0A3
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943214; cv=none; b=ipCpTnsJFeU6oR13DZozAiCs/mIhgq9wXbYH4eXX8pw7E4E6mXxQ4mFViRZkiuKkiMo7od9fGcPJgcRA+f6Uq3jOJNzu2ELzltlSc9wB2Zo8/jh0TOTRvvq5YBslK2MoVwDvN+e+2/ByT+YPV4uKLRmE4HTPIOHfXy9N47efr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943214; c=relaxed/simple;
	bh=E5gD5h7waLiCQD46TNJCji9FfD8rOtnJN1PISy5aSHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcgJR4vw5i4uiTo3arDK/CC9pPlyhz3f3rICYdAG3I+L/uf5Noa2R8yoVWil2XJ7TYDzqczbNxk1rz/tjNVks2SCFnN4QYbgYBSyfxWfo02Dc2Xe4mUFnPJ4T5dSL/hyI+NQNR5z1DDhiSZHtfVyfCA1fnZ88gbEYqEr4hfrZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JjuDLVNQ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715943209; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6ewg+pfLX/2tt7Dbv8mKSMb7haYUAuqFESpeYFM6blE=;
	b=JjuDLVNQ9DlffuRPchq95lSXKxWNfHvU6CMVKmstdish5MoH3UEc5Bh9BIGovjd+XvVMrRHWvhfQF4tXHK7krakV0K1U30gLzWJqc+b8rHgc1dS0beqwkWkuDAR2HWbecwk4ViE6idx96xlX/5wkAgkdMdcIDbrwXNUXlhDiWTw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6eLjVb_1715943207;
Received: from 30.221.128.140(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W6eLjVb_1715943207)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 18:53:28 +0800
Message-ID: <784b6bcc-067a-4a27-93e9-60e96da2befb@linux.alibaba.com>
Date: Fri, 17 May 2024 18:53:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ocfs2: strict bound check before memcmp in
 ocfs2_xattr_find_entry()
To: Ferry Meng <mengferry@linux.alibaba.com>, lei lu <llfamsec@gmail.com>,
 akpm <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, ocfs2-devel@lists.linux.dev
References: <20240517094147.87133-1-mengferry@linux.alibaba.com>
 <20240517094147.87133-3-mengferry@linux.alibaba.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240517094147.87133-3-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/17/24 5:41 PM, Ferry Meng wrote:
> xattr in ocfs2 maybe 'non-indexed', which saved with additional space
> requested. It's better to check if the memory is out of bound before
> memcmp, although this possibility mainly comes from crafted poisonous
> images.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reported-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/xattr.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 8aea94c90739..35c0cc2a51af 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -1068,7 +1068,7 @@ static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
>  {
>  	struct ocfs2_xattr_entry *entry;
>  	size_t name_len;
> -	int i, cmp = 1;
> +	int i, name_offset, cmp = 1;
>  
>  	if (name == NULL)
>  		return -EINVAL;
> @@ -1083,10 +1083,15 @@ static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
>  		cmp = name_index - ocfs2_xattr_get_type(entry);
>  		if (!cmp)
>  			cmp = name_len - entry->xe_name_len;
> -		if (!cmp)
> -			cmp = memcmp(name, (xs->base +
> -				     le16_to_cpu(entry->xe_name_offset)),
> -				     name_len);
> +		if (!cmp) {
> +			name_offset = le16_to_cpu(entry->xe_name_offset);
> +			if ((xs->base + name_offset + name_len) > xs->end) {
> +				ocfs2_error(inode->i_sb,
> +					    "corrupted xattr entries");
> +				return -EFSCORRUPTED;
> +			}
> +			cmp = memcmp(name, (xs->base + name_offset), name_len);
> +		}
>  		if (cmp == 0)
>  			break;
>  		entry += 1;

