Return-Path: <linux-kernel+bounces-268763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23684942902
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546431C21E26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281B1A7F69;
	Wed, 31 Jul 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYdJdRiu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3C16C84A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413886; cv=none; b=KbiRmpYyxN8h2aF4PJzvKWBx+TB/ynID+k/vtKg3B09R2sb7/odOo57Jy00CpofELwiF3aqqbmnk/9g/UrLQmplZmJvGO/msYGbLBbkyrSsdZZoEgbUwcQnOnIXnZOqfvxfQTVlgqR27B8mTgna9UJMDWj82Vs0SsuHhy9gjOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413886; c=relaxed/simple;
	bh=fZJzL9fO5FzTr6ClXfZRQcuAR19IGhcGGEsag84FQwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4dTUf7u4Wrm3sNJBRjk0GmvsxQAnuX6OTvBr7HpNLxP5YhbcRNqlYd0nJwzvscRwv2+u8c1ZaAY7TdyWTnv5P7tEu078jQxYVhAr7dnqoZtzd7nq6L+YhQjQXHn+MdNc1mvJ6dUqOV2/x82iCHBgVKM9LaiLy4Om/WtRGNrGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYdJdRiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82951C116B1;
	Wed, 31 Jul 2024 08:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722413886;
	bh=fZJzL9fO5FzTr6ClXfZRQcuAR19IGhcGGEsag84FQwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OYdJdRiu+c2+xwO/QTYLHkuBbR+XEayRGXnShfczbz5tDgJmlQJZ+wkJTxINkzqK2
	 ja8b+yeLzDwis8aIgM2gStkLIjIP97Ed78pvp0lyObjadgzok4xCNn4qUSfggohNNa
	 GNkZOt0EPP3CDbqYcYT8HlSomGvV/2VNToFMu/C5YIGohWom94O0h1dPD1naZQgVtR
	 7OI/ekvds4puMqFklXM5z9+0TUQCQpitrEURoNAgSu4Q/Y4KdWgGJcS8fmYMqh93R9
	 wvhIp7sl1RDGNdyENZeUlhvfP0jVRH+OQl17FdBP5PE1bg2TCnttDZur7m9U4b0Ju5
	 jmgQU9Yzmp/ww==
Message-ID: <1b1c5fcf-0c71-4c5d-a429-3decc3bb8cb3@kernel.org>
Date: Wed, 31 Jul 2024 16:18:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240726012204.1306174-1-chao@kernel.org>
 <ZqfCwDcg7nvJPenf@google.com>
 <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>
 <ZqkUJAMJzW_4ANhY@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqkUJAMJzW_4ANhY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/31 0:26, Jaegeuk Kim wrote:
> On 07/30, Chao Yu wrote:
>> On 2024/7/30 0:26, Jaegeuk Kim wrote:
>>> On 07/26, Chao Yu wrote:
>>>> We should always truncate pagecache while truncating on-disk data.
>>>>
>>>> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>> v2:
>>>> - fix to use cow_inode instead of inode
>>>>    fs/f2fs/file.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 6c62f76474d1..54886ddcb8ab 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>>>>    		F2FS_I(fi->cow_inode)->atomic_inode = inode;
>>>>    	} else {
>>>>    		/* Reuse the already created COW inode */
>>>> +		truncate_setsize(fi->cow_inode, 0);
>>>
>>> What if the below truncation failed?
>>
>> What about just dropping page cache and do not set isize to 0?
> 
> Can we also check if there's any dirty page before truncating it?

Sure, so how about this?

		/* Reuse the already created COW inode */
		if (get_dirty_pages(fi->cow_inode)) {
			ret = filemap_write_and_wait(fi->cow_inode->i_mapping);
			if (ret) {
				f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
				goto out;
			}
		}

		truncate_inode_pages(fi->cow_inode->i_mapping, 0);

		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
		if (ret) {
			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
			goto out;
		}

		i_size_write(fi->cow_inode, 0);

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>    		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>>>>    		if (ret) {
>>>>    			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>>>> -- 
>>>> 2.40.1


