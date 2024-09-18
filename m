Return-Path: <linux-kernel+bounces-332194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2C97B6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAD12861ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD8D21364;
	Wed, 18 Sep 2024 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eAVevwSj"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408DAD2D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624638; cv=none; b=UoNl0wVYseEGHYHTxYtZTUNDpdaEPjF6D1CnRR5sc35JzRiELRBFnoT+GVrKjZDigGG14fLmH9V0On/rTwwJ5Wi0xKOTOo+jPMLLVfWkZC5RkyqQ2WOFJeYI+speq/Zn0qzP3uE53Cu62NyitePs+dYxP7L3KU4BlOg2sBykZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624638; c=relaxed/simple;
	bh=ZfbDh9k7Gfb0x3Lj2v48kbWRsPcK5V6WwootI6rG4EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQjI4E3ySM6Vfnn+ATsfcpAi2h8uUg0IVrbRR2jK3GcuztD5CSbAopT7lQiYK/4M3ZJhpi9T19N5Kx5QahgGy87CiunRwNyjbQ0/jgiTBzWf+/+VL24/EU8NXM2FRQptretp7I3/ffJTTMQJQuQAQZbxsM25mPR+tChhCTAYEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eAVevwSj; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726624626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RYxP3LN7HfQ1HoAFsYKPPgOdnmK7jxbAQtD2YB8bc0s=;
	b=eAVevwSjROoIuPR5QHItfAkD6+Xf92SPa6shJ4t2zaltF+mc8CUYjxDdLRrfCye/A9dQklcHQjsg9M5mevahSaBrYkZQJOLuDemOeP9EllZxXL1FjpAXMztkD9XWr1WkVx6DAZehjsV6vV6k2YhdAq1NUNwhfRzmtBTLPxC+0Qg=
Received: from 30.221.131.28(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WFC8WJI_1726624625)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 09:57:06 +0800
Message-ID: <a4ff61ae-c83d-4a6d-837a-4e3c22c99a69@linux.alibaba.com>
Date: Wed, 18 Sep 2024 09:57:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V4 1/1] ocfs2: reserve space for inline xattr before
 attaching reflink tree
To: Andrew Morton <akpm@linux-foundation.org>,
 Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc: junxiao.bi@oracle.com, rajesh.sivaramasubramaniom@oracle.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240912064720.898600-1-gautham.ananthakrishna@oracle.com>
 <20240916091647.dbcca9d29f081c7a4c5cd2ea@linux-foundation.org>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240916091647.dbcca9d29f081c7a4c5cd2ea@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/24 12:16 AM, Andrew Morton wrote:
> On Thu, 12 Sep 2024 06:47:20 +0000 Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com> wrote:
> 
>> One of our customers reported a crash and a corrupted ocfs2 filesystem.
>> +++ b/fs/ocfs2/refcounttree.c
>> @@ -25,6 +25,7 @@
>>  #include "namei.h"
>>  #include "ocfs2_trace.h"
>>  #include "file.h"
>> +#include "symlink.h"
>>  
>>  #include <linux/bio.h>
>>  #include <linux/blkdev.h>
>> @@ -4155,8 +4156,9 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
>>  	int ret;
>>  	struct inode *inode = d_inode(old_dentry);
>>  	struct buffer_head *new_bh = NULL;
>> +	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>>  
>> -	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
>> +	if (oi->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
>>  		ret = -EINVAL;
>>  		mlog_errno(ret);
>>  		goto out;
>> @@ -4182,6 +4184,26 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
>>  		goto out_unlock;
>>  	}
>>  
>> +	if ((oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) &&
>> +	    (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL)) {
>> +		/*
>> +		 * Adjust extent record count to reserve space for extended attribute.
>> +		 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
>> +		 */
>> +		struct ocfs2_inode_info *new_oi = OCFS2_I(new_inode);
>> +
>> +		if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
>> +		    !(ocfs2_inode_is_fast_symlink(new_inode))) {
>> +			struct ocfs2_dinode *new_di = new_bh->b_data;
>> +			struct ocfs2_dinode *old_di = old_bh->b_data;
> 
> fs/ocfs2/refcounttree.c: In function '__ocfs2_reflink':
> fs/ocfs2/refcounttree.c:4190:55: error: initialization of 'struct ocfs2_dinode *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
>  4190 |                         struct ocfs2_dinode *new_di = new_bh->b_data;
>       |                                                       ^~~~~~
> fs/ocfs2/refcounttree.c:4191:55: error: initialization of 'struct ocfs2_dinode *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
>  4191 |                         struct ocfs2_dinode *old_di = old_bh->b_data;
>       |                                                       ^~~~~~
> cc1: all warnings being treated as errors
> 
> I could just add the typecasts, but that doesn't give me a tested patch :(
> 

Oops, sorry for missing this when reviewing.
Hi Gautham, could you please add the missing typecasts and confirm it?

Thanks,
Joseph

