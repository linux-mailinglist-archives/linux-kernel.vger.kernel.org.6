Return-Path: <linux-kernel+bounces-314070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F896AE8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D54B23DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30099383BF;
	Wed,  4 Sep 2024 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJRQJJjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550134CD8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725416808; cv=none; b=cuZeRV30Hzg0/SrEXL848eM2gU8AfLKsipvIbUkYb2Wb81LFoHg8AABW9Mc20MhXFj91pmcQSqtAZ3v8r9HZ7vz5fckbiOWcPQ0Lps/yRpE7p9DHLE8bHaJ1xPxULB4m0VHQZSPW9jpG0Q2wT8OXiHXUjRyPpirD9q6Klrays2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725416808; c=relaxed/simple;
	bh=8qboybJq+c/5kLOuu22HLxuVqbE+xW8K4CixXEsPXxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osOqr4Lq49zdQleRQPmlwE91Yh9C+mkszfD2r4HTRiNohoTAc7yo0WPLS6kKIhzvfRZ0jaUBD+Vbo8GRwHUUk1PXzhSQdOuGUo28HeUUImxWOoVSH2X5HemaxkT1IyjkiY8TX3isyp23nFIdXemIba9Nbn30u7baaejWB1eU1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJRQJJjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2637DC4CEC4;
	Wed,  4 Sep 2024 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725416808;
	bh=8qboybJq+c/5kLOuu22HLxuVqbE+xW8K4CixXEsPXxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XJRQJJjIBJCe8QsjT1obuFtajcAjZjMjQW2af/kpDt+X5h3vCkS5AVVxW4oy56MFy
	 +HaghyvyhYNIuH06Fwi5JS6v4I9mH5j/z3PP8LYoXVB+ZhvWV+q4mPzbrrxcU/nTbK
	 kD1cAwQSUXCGqbbChEd8T5YVx1+JKry5rBGt+ErC8V947TJcInJ8z9VZnT2GBqaUdk
	 Dr7p64riR+/XuLnuk7EJZC3vlMU62u96tQ5kroHNOdsAD7EzQVTTTpbmfHB8hsNt5s
	 vPI2vJoeRW6iXlfynPJl6CI+/I13LMtkdxTtUXf6INFKnrX7rxFqW9LZdqfz0Ljg8v
	 Kt0RK28vCMMzg==
Message-ID: <d4f218ad-7a01-4b5b-a438-c0e4e14bbc96@kernel.org>
Date: Wed, 4 Sep 2024 10:26:44 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_xMipooJy3GrZTc2CSpMoSs9FsErdxjqMWXVQ6iDiEZ0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/4 1:07, Daeho Jeong wrote:
> On Mon, Sep 2, 2024 at 3:08 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/8/27 4:23, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> Keep atomic file clean while updating and make it dirtied during commit
>>> in order to avoid unnecessary and excessive inode updates in the previous
>>> fix.
>>>
>>> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag")
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>    fs/f2fs/f2fs.h    |  3 +--
>>>    fs/f2fs/inode.c   | 10 ++++++----
>>>    fs/f2fs/segment.c | 10 ++++++++--
>>>    3 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 465b2fd50c70..5a7f6fa8b585 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -801,7 +801,7 @@ enum {
>>>        FI_COMPRESS_RELEASED,   /* compressed blocks were released */
>>>        FI_ALIGNED_WRITE,       /* enable aligned write */
>>>        FI_COW_FILE,            /* indicate COW file */
>>> -     FI_ATOMIC_COMMITTED,    /* indicate atomic commit completed except disk sync */
>>> +     FI_ATOMIC_DIRTIED,      /* indicate atomic file is dirtied */
>>>        FI_ATOMIC_REPLACE,      /* indicate atomic replace */
>>>        FI_OPENED_FILE,         /* indicate file has been opened */
>>>        FI_MAX,                 /* max flag, never be used */
>>> @@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>>>        case FI_INLINE_DOTS:
>>>        case FI_PIN_FILE:
>>>        case FI_COMPRESS_RELEASED:
>>> -     case FI_ATOMIC_COMMITTED:
>>>                f2fs_mark_inode_dirty_sync(inode, true);
>>>        }
>>>    }
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index 1eb250c6b392..5dd3e55d2be2 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>>>        if (f2fs_inode_dirtied(inode, sync))
>>
>> It will return directly here if inode was dirtied, so it may missed to set
>> FI_ATOMIC_DIRTIED flag?
> 
> Is it possible for it to be already dirty, since we already made it
> clean with f2fs_write_inode() when we started the atomic write?

Some ioctl interfaces may race w/ atomic write? e.g. set_pin_file won't
check atomic_file status, and may dirty inode after we started atomic
write, so we'd better detect such race condition and break ioctl to
avoid ruin atomic write? and maybe we can add f2fs_bug_on() in
f2fs_mark_inode_dirty_sync() to detect any other missing cases?

Thanks,

> 
>>
>> Thanks,
>>
>>>                return;
>>>
>>> +     if (f2fs_is_atomic_file(inode)) {
>>> +             set_inode_flag(inode, FI_ATOMIC_DIRTIED);
>>> +             return;
>>> +     }
>>> +
>>>        mark_inode_dirty_sync(inode);
>>>    }
>>>
>>> @@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
>>>        ri->i_gid = cpu_to_le32(i_gid_read(inode));
>>>        ri->i_links = cpu_to_le32(inode->i_nlink);
>>>        ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
>>> -
>>> -     if (!f2fs_is_atomic_file(inode) ||
>>> -                     is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
>>> -             ri->i_size = cpu_to_le64(i_size_read(inode));
>>> +     ri->i_size = cpu_to_le64(i_size_read(inode));
>>>
>>>        if (et) {
>>>                read_lock(&et->lock);
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 78c3198a6308..2b5391b229a8 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>>>                truncate_inode_pages_final(inode->i_mapping);
>>>
>>>        release_atomic_write_cnt(inode);
>>> -     clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
>>>        clear_inode_flag(inode, FI_ATOMIC_REPLACE);
>>>        clear_inode_flag(inode, FI_ATOMIC_FILE);
>>> +     if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
>>> +             clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
>>> +             f2fs_mark_inode_dirty_sync(inode, true);
>>> +     }
>>>        stat_dec_atomic_inode(inode);
>>>
>>>        F2FS_I(inode)->atomic_write_task = NULL;
>>> @@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>>>                sbi->revoked_atomic_block += fi->atomic_write_cnt;
>>>        } else {
>>>                sbi->committed_atomic_block += fi->atomic_write_cnt;
>>> -             set_inode_flag(inode, FI_ATOMIC_COMMITTED);
>>> +             if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
>>> +                     clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
>>> +                     f2fs_mark_inode_dirty_sync(inode, true);
>>> +             }
>>>        }
>>>
>>>        __complete_revoke_list(inode, &revoke_list, ret ? true : false);
>>


