Return-Path: <linux-kernel+bounces-316165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AC96CC09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CDA1F2497A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A6BE5D;
	Thu,  5 Sep 2024 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGhoOA6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F2B661
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498408; cv=none; b=idWEQODZO1whvl2RJIrh4KuD+Kp29rbaqg5iW/2yOMr5duKsDZtHnLoytkezFLiny4QPuyFfE16gTy196jTTvA5xsIU+RaLwMhtq/LXAQ7Sa66JBVAx3m16eXNx/NJ5yG7T3yBSQOj/B7gDZif84aiXUMbCh/KOBH2N6k4FRc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498408; c=relaxed/simple;
	bh=OjSgoO9oN8sGczK0arFHjxbqWTdLcYmFj3s0vOgXXaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxHR7F+MX6MJRZdEaHBLpKGorwdGnPFrnNCbmu0ccmN6zYSd0BzexvbdJuppjfa/ZYeZFbszpuYTdC5/z0Q+inl6ntDlWxjXGQ5c98ldB6xMY+zBkBvvkon81+tBIM6u7djhlyojdQD0S0FkKqGI1HTaBU9AKof34n/J0b03ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGhoOA6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47937C4CEC2;
	Thu,  5 Sep 2024 01:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725498407;
	bh=OjSgoO9oN8sGczK0arFHjxbqWTdLcYmFj3s0vOgXXaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGhoOA6FU94z6rtuMOMLqvI800jzraJk7Z0jLpY2/DitoF+XJmNL4I2Re5cm976Jn
	 9QZOTc06E1G/wuV+lMEKtKliCa+XtcZYr4TFJFjFYVJc/HucnggP1pNLOPPg8rKLD3
	 xhYxX3CbpL9bcq3bGcQvlfu3r5PsXg5zjEhe72YGhYcoG/BNTzPZCm6yihFXyMF908
	 Mi3M523RU3HgyU4ZmcyTCINnUum7+m4Rc41ux7gVDPqo8XTyJ+GGcTwseti2VLkwE0
	 PCkXG9I2TE/AAiojoTwPNdaNtmpe7eL/Zhj4HuaFDRzIhYgNgSxBppPu3Flyo8meOv
	 loHI5hFu8mSig==
Message-ID: <b2b6db47-07c6-4fd5-b2cb-30ddefcdd98e@kernel.org>
Date: Thu, 5 Sep 2024 09:06:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent atomic file from being dirtied
 before commit
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
References: <20240826202352.2150294-1-daeho43@gmail.com>
 <45a8a9f3-27b8-433e-a0ac-e457f4cdf1eb@kernel.org>
 <CACOAw_xMipooJy3GrZTc2CSpMoSs9FsErdxjqMWXVQ6iDiEZ0Q@mail.gmail.com>
 <d4f218ad-7a01-4b5b-a438-c0e4e14bbc96@kernel.org>
 <CACOAw_zvNyD3cmMpJsidEMyrtnZYU4kR4BmE_cygroPyYoiGvA@mail.gmail.com>
 <5c7b34d8-6efa-4716-ab89-a0b7b7583cb2@kernel.org>
 <CACOAw_w3Tn6HL9hZXFgpjpgu9ySvE_0FbTWMMBuZKgRFBYXXLA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_w3Tn6HL9hZXFgpjpgu9ySvE_0FbTWMMBuZKgRFBYXXLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/4 22:56, Daeho Jeong wrote:
> On Tue, Sep 3, 2024 at 8:35 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/9/4 10:52, Daeho Jeong wrote:
>>> On Tue, Sep 3, 2024 at 7:26 PM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2024/9/4 1:07, Daeho Jeong wrote:
>>>>> On Mon, Sep 2, 2024 at 3:08 AM Chao Yu <chao@kernel.org> wrote:
>>>>>>
>>>>>> On 2024/8/27 4:23, Daeho Jeong wrote:
>>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>>
>>>>>>> Keep atomic file clean while updating and make it dirtied during commit
>>>>>>> in order to avoid unnecessary and excessive inode updates in the previous
>>>>>>> fix.
>>>>>>>
>>>>>>> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag")
>>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>>>> ---
>>>>>>>      fs/f2fs/f2fs.h    |  3 +--
>>>>>>>      fs/f2fs/inode.c   | 10 ++++++----
>>>>>>>      fs/f2fs/segment.c | 10 ++++++++--
>>>>>>>      3 files changed, 15 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>> index 465b2fd50c70..5a7f6fa8b585 100644
>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>> @@ -801,7 +801,7 @@ enum {
>>>>>>>          FI_COMPRESS_RELEASED,   /* compressed blocks were released */
>>>>>>>          FI_ALIGNED_WRITE,       /* enable aligned write */
>>>>>>>          FI_COW_FILE,            /* indicate COW file */
>>>>>>> -     FI_ATOMIC_COMMITTED,    /* indicate atomic commit completed except disk sync */
>>>>>>> +     FI_ATOMIC_DIRTIED,      /* indicate atomic file is dirtied */
>>>>>>>          FI_ATOMIC_REPLACE,      /* indicate atomic replace */
>>>>>>>          FI_OPENED_FILE,         /* indicate file has been opened */
>>>>>>>          FI_MAX,                 /* max flag, never be used */
>>>>>>> @@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>>>>>>>          case FI_INLINE_DOTS:
>>>>>>>          case FI_PIN_FILE:
>>>>>>>          case FI_COMPRESS_RELEASED:
>>>>>>> -     case FI_ATOMIC_COMMITTED:
>>>>>>>                  f2fs_mark_inode_dirty_sync(inode, true);
>>>>>>>          }
>>>>>>>      }
>>>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>>>> index 1eb250c6b392..5dd3e55d2be2 100644
>>>>>>> --- a/fs/f2fs/inode.c
>>>>>>> +++ b/fs/f2fs/inode.c
>>>>>>> @@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>>>>>>>          if (f2fs_inode_dirtied(inode, sync))
>>>>>>
>>>>>> It will return directly here if inode was dirtied, so it may missed to set
>>>>>> FI_ATOMIC_DIRTIED flag?
>>>>>
>>>>> Is it possible for it to be already dirty, since we already made it
>>>>> clean with f2fs_write_inode() when we started the atomic write?
>>>>
>>>> Some ioctl interfaces may race w/ atomic write? e.g. set_pin_file won't
>>>> check atomic_file status, and may dirty inode after we started atomic
>>>> write, so we'd better detect such race condition and break ioctl to
>>>> avoid ruin atomic write? and maybe we can add f2fs_bug_on() in
>>>> f2fs_mark_inode_dirty_sync() to detect any other missing cases?
>>>>
>>>
>>> How about exchanging the positions of f2fs_write_inode() and
>>> set_inode_flag() in f2fs_ioc_start_atomic_write()?
>>>
>>> ...
>>>           f2fs_write_inode(inode, NULL);
>>>
>>>           stat_inc_atomic_inode(inode);
>>>
>>>           set_inode_flag(inode, FI_ATOMIC_FILE);
>>> ...
>>
>> Oh, I'm not sure I've got your point, after exchanging we still may suffer
>> below race condition, right?
>>
>> - f2fs_ioc_start_atomic_write
>>    - set_inode_flag(inode, FI_ATOMIC_FILE)
>>    - f2fs_write_inode(inode, NULL)
>>                                          - f2fs_ioc_set_pin_file
>>                                           - set_inode_flag(inode, FI_PIN_FILE)
>>                                            - __mark_inode_dirty_flag()
>                                                   => This attempt will
> be blocked by the below condition.
> 
> +       if (f2fs_is_atomic_file(inode)) {
> +               set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +               return;
> +       }

Oh, yes, FI_ATOMIC_DIRTIED will be tagged once inode becomes dirty.

Thanks,

> 
> Plz, refer to the above comment.
> 
>> - f2fs_ioc_commit_atomic_write
>>
>> So that I proposed a fix for this:
>> https://lore.kernel.org/linux-f2fs-devel/20240904032047.1264706-1-chao@kernel.org
>>
>> Thanks,
>>
>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>                  return;
>>>>>>>
>>>>>>> +     if (f2fs_is_atomic_file(inode)) {
>>>>>>> +             set_inode_flag(inode, FI_ATOMIC_DIRTIED);
>>>>>>> +             return;
>>>>>>> +     }
>>>>>>> +
>>>>>>>          mark_inode_dirty_sync(inode);
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
>>>>>>>          ri->i_gid = cpu_to_le32(i_gid_read(inode));
>>>>>>>          ri->i_links = cpu_to_le32(inode->i_nlink);
>>>>>>>          ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
>>>>>>> -
>>>>>>> -     if (!f2fs_is_atomic_file(inode) ||
>>>>>>> -                     is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
>>>>>>> -             ri->i_size = cpu_to_le64(i_size_read(inode));
>>>>>>> +     ri->i_size = cpu_to_le64(i_size_read(inode));
>>>>>>>
>>>>>>>          if (et) {
>>>>>>>                  read_lock(&et->lock);
>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>> index 78c3198a6308..2b5391b229a8 100644
>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>> @@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>>>>>>>                  truncate_inode_pages_final(inode->i_mapping);
>>>>>>>
>>>>>>>          release_atomic_write_cnt(inode);
>>>>>>> -     clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
>>>>>>>          clear_inode_flag(inode, FI_ATOMIC_REPLACE);
>>>>>>>          clear_inode_flag(inode, FI_ATOMIC_FILE);
>>>>>>> +     if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
>>>>>>> +             clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
>>>>>>> +             f2fs_mark_inode_dirty_sync(inode, true);
>>>>>>> +     }
>>>>>>>          stat_dec_atomic_inode(inode);
>>>>>>>
>>>>>>>          F2FS_I(inode)->atomic_write_task = NULL;
>>>>>>> @@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>>>>>>>                  sbi->revoked_atomic_block += fi->atomic_write_cnt;
>>>>>>>          } else {
>>>>>>>                  sbi->committed_atomic_block += fi->atomic_write_cnt;
>>>>>>> -             set_inode_flag(inode, FI_ATOMIC_COMMITTED);
>>>>>>> +             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
>>>>>>> +                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
>>>>>>> +                     f2fs_mark_inode_dirty_sync(inode, true);
>>>>>>> +             }
>>>>>>>          }
>>>>>>>
>>>>>>>          __complete_revoke_list(inode, &revoke_list, ret ? true : false);
>>>>>>
>>>>
>>


