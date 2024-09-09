Return-Path: <linux-kernel+bounces-321466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0211971AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787C81F22306
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D95A1B3F22;
	Mon,  9 Sep 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KHyW9n4y"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137251B3B15
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888088; cv=none; b=LkcowkZ7Mvg2O8EFoOcULJQfMOVYGputZddXLwPQVxjkI50Cd335N6i4YHhO5gWf/Oc3MHvRyIBimZB8P3R1sn/z3Daf5U+478n6fOiykTUGoYD4hC/I8leDQ+SA5ovKW3yJLJKnTUQDwsq9OlaTWUcB4VQ+508dKO0Bu2XxDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888088; c=relaxed/simple;
	bh=X0qRPwDzaSfCNbNRIcg6BWpQHSjWUMLh3C4tUQ7XIqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6vPyk45k7YPln9IVjm51y436AS+40At3DQ3+2A7NsqnD56/S9y4QKvVgNIWFDErm0cPOQnWrUYzmmP24uvAe4MYy9DRT5WFu+qQ2arS9Lx49mkjbOVujyk55Lahn5Ial+QKjkmEYJq1ZQ2mdWee3NyRyiXzgNZ9HhtPAWY+uWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KHyW9n4y; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725888077; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xtDKlk++b9rEjm2wZIZSJwpvnA+n9QUFgyYlxTYR+c8=;
	b=KHyW9n4yshyLKxfbyyOAsMR3bO2xn1PgvpfUSt/ifT1Cvkx07CpfGu1Gnz4ICw6kAZ6Cg0nXmhQBjSsg45/am9Gy/mvNsnJ6Xwi4/7cPcNJc/wrVu1JzF9YNmFnEKfzzP+GEpvLcZX00dQmxMd8XuCSF4TCFrK8oaImQmdzcsZU=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEfKbpz_1725888076)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 21:21:17 +0800
Message-ID: <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
Date: Mon, 9 Sep 2024 21:21:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Colin,

On 2024/9/9 20:48, Colin Walters wrote:
> 
> 
> On Sun, Sep 8, 2024, at 11:19 PM, Gao Xiang wrote:
>> Fast symlink can be used if the on-disk symlink data is stored
>> in the same block as the on-disk inode, so we don’t need to trigger
>> another I/O for symlink data.  However, correctly fs correction could be
>> reported _incorrectly_ if inode xattrs are too large.
>>
>> In fact, these should be valid images although they cannot be handled as
>> fast symlinks.
>>
>> Many thanks to Colin for reporting this!
> 
> Yes, though feel free to also add
> Reported-by: https://honggfuzz.dev/
> or so...not totally sure how to credit it "kernel style" bit honggfuzz very much helped me find this bug (indirectly).

Ok, it sounds good to me.
I will add this later.

> 
> 
> 
>>
>> Reported-by: Colin Walters <walters@verbum.org>
>> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - sent out a wrong version (`m_pofs += vi->xattr_isize` was missed).
>>
>>   fs/erofs/inode.c | 20 ++++++--------------
>>   1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 5f6439a63af7..f2cab9e4f3bc 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -178,12 +178,14 @@ static int erofs_fill_symlink(struct inode
>> *inode, void *kaddr,
>>   			      unsigned int m_pofs)
>>   {
>>   	struct erofs_inode *vi = EROFS_I(inode);
>> -	unsigned int bsz = i_blocksize(inode);
>> +	loff_t off;
>>   	char *lnk;
>>
>> -	/* if it cannot be handled with fast symlink scheme */
>> -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
>> -	    inode->i_size >= bsz || inode->i_size < 0) {
>> +	m_pofs += vi->xattr_isize;
>> +	/* check if it cannot be handled with fast symlink scheme */
>> +	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
>> +	    check_add_overflow(m_pofs, inode->i_size, &off) ||
>> +	    off > i_blocksize(inode)) {
>>   		inode->i_op = &erofs_symlink_iops;
>>   		return 0;
>>   	}
> 
> This change LGTM.
> 
>> @@ -192,16 +194,6 @@ static int erofs_fill_symlink(struct inode *inode,
>> void *kaddr,
>>   	if (!lnk)
>>   		return -ENOMEM;
>>
>> -	m_pofs += vi->xattr_isize;
>> -	/* inline symlink data shouldn't cross block boundary */
>> -	if (m_pofs + inode->i_size > bsz) {
> 
> It can cross a boundary but it still can't be *bigger* right? IOW do we still need to check here for inode->i_size > bsz or is that handled by something else generic?

It can be bigger.

Like ext4, EROFS supports PAGE_SIZE symlink via page_get_link()
(non-fastsymlink cases), but mostly consider this as 4KiB though
regardless of on-disk block sizes.

Thanks,
Gao Xiang




