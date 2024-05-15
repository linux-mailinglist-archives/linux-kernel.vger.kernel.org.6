Return-Path: <linux-kernel+bounces-179323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095CC8C5ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683A01F220A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1681C17;
	Wed, 15 May 2024 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riTySqg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208E816
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736873; cv=none; b=HuLvZMjrcenMQgMZdsiNlm274MpVRtq6taxwdsfKk7aUBTyi7EgfBRFcpAR40sqF3oNsSlo+LMV7qUbBgW/CyYv6sB7xIuLwjhY5IYcrPoGDPwjj0D0gibwgB5oxGiNz/Qijs6Nn6DW3e1qXTz/VJ5xPssGjR8FqZJwlGnu8VKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736873; c=relaxed/simple;
	bh=VjlVMK0VLtnbMICT7jQ/JYzOP302qxtpqkzwsgNzVbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYvvADw2UNFVKR3IszF24G84NwHY3C9Ej+Ui8eX/j7MUb60NwEDDtFGGfjAPBfms4fZ0hdBnN9wJ9QiUgWZC01WFS9SS8E5QZ0njMag7tilXY1DlEKvmrzAccSwjrrXpF2IuzzsS+pTWx0P3IdQLVTc16HrJKrtxGM+hmkGWFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riTySqg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D10C2BD10;
	Wed, 15 May 2024 01:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715736872;
	bh=VjlVMK0VLtnbMICT7jQ/JYzOP302qxtpqkzwsgNzVbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=riTySqg4KKK4IWdLpx47Os0OV5sgHxzdH35QT5AuSPRyyKSwbSBid5ww2nvcYOJNH
	 /yUEWKhyIOo8uyX9zfc1b2t/C9NGWynIybRjynXGjvytUXPxuO2GL3qvrlVOHbwMr7
	 Dbt/EUUWqp9JNEgtgPyoK88rJaMyMCfhtCmbliNaWjZc+0FRccayBOfybs3MLCoaDb
	 DBoDwosHUR7HAQV5PiTIM9qQTFQzD2t3A8hrSSssB0EeGtkPuOd+BdlIhzfJ9SOafO
	 yAtL2j5/8gPX8P2PYYY2CKKYbz+Y1gO5t+cRZrQexjzmHW35OCUvQa6Yz55S3bswYT
	 msme8QQUfZm0A==
Message-ID: <43f128b0-5151-4ae6-9bc0-438c7a9871e9@kernel.org>
Date: Wed, 15 May 2024 09:34:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] f2fs: fix to do sanity check on i_nid for inline_data
 inode
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-3-chao@kernel.org> <ZjzxWp4-wmpCzBeB@google.com>
 <b58d0a62-9491-4b77-a3be-70331f849bb8@kernel.org>
 <Zj2WWpHmHaWKbDgG@google.com>
 <948ecc86-63f5-48bb-b71c-61d57cbf446c@kernel.org>
 <Zj6-Fl5OQrHyg0g_@google.com>
 <02a4e80f-a146-4862-8399-3db42979b8fb@kernel.org>
 <ZkOMSQK6hitduUYK@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZkOMSQK6hitduUYK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/5/15 0:07, Jaegeuk Kim wrote:
> 外部邮件/External Mail
> 
> 
> On 05/11, Chao Yu wrote:
>> On 2024/5/11 8:38, Jaegeuk Kim wrote:
>>> On 05/10, Chao Yu wrote:
>>>> On 2024/5/10 11:36, Jaegeuk Kim wrote:
>>>>> On 05/10, Chao Yu wrote:
>>>>>> On 2024/5/9 23:52, Jaegeuk Kim wrote:
>>>>>>> On 05/06, Chao Yu wrote:
>>>>>>>> syzbot reports a f2fs bug as below:
>>>>>>>>
>>>>>>>> ------------[ cut here ]------------
>>>>>>>> kernel BUG at fs/f2fs/inline.c:258!
>>>>>>>> CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
>>>>>>>> RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
>>>>>>>> Call Trace:
>>>>>>>>      f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
>>>>>>>>      f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
>>>>>>>>      __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
>>>>>>>>      f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
>>>>>>>>      do_writepages+0x35b/0x870 mm/page-writeback.c:2612
>>>>>>>>      __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
>>>>>>>>      writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
>>>>>>>>      wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
>>>>>>>>      wb_do_writeback fs/fs-writeback.c:2264 [inline]
>>>>>>>>      wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
>>>>>>>>      process_one_work kernel/workqueue.c:3254 [inline]
>>>>>>>>      process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
>>>>>>>>      worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>>>>>>>>      kthread+0x2f2/0x390 kernel/kthread.c:388
>>>>>>>>      ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>>>>>>>>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>>>>>>>
>>>>>>>> The root cause is: inline_data inode can be fuzzed, so that there may
>>>>>>>> be valid blkaddr in its direct node, once f2fs triggers background GC
>>>>>>>> to migrate the block, it will hit f2fs_bug_on() during dirty page
>>>>>>>> writeback.
>>>>>>>>
>>>>>>>> Let's add sanity check on i_nid field for inline_data inode, meanwhile,
>>>>>>>> forbid to migrate inline_data inode's data block to fix this issue.
>>>>>>>>
>>>>>>>> Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
>>>>>>>> Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000d103ce06174d7ec3@google.com
>>>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>>>> ---
>>>>>>>>      fs/f2fs/f2fs.h   |  2 +-
>>>>>>>>      fs/f2fs/gc.c     |  6 ++++++
>>>>>>>>      fs/f2fs/inline.c | 17 ++++++++++++++++-
>>>>>>>>      fs/f2fs/inode.c  |  2 +-
>>>>>>>>      4 files changed, 24 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>>> index fced2b7652f4..c876813b5532 100644
>>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>>> @@ -4146,7 +4146,7 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
>>>>>>>>       * inline.c
>>>>>>>>       */
>>>>>>>>      bool f2fs_may_inline_data(struct inode *inode);
>>>>>>>> -bool f2fs_sanity_check_inline_data(struct inode *inode);
>>>>>>>> +bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage);
>>>>>>>>      bool f2fs_may_inline_dentry(struct inode *inode);
>>>>>>>>      void f2fs_do_read_inline_data(struct page *page, struct page *ipage);
>>>>>>>>      void f2fs_truncate_inline_inode(struct inode *inode,
>>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>>> index e86c7f01539a..041957750478 100644
>>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>>> @@ -1563,6 +1563,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>>>>>                                    continue;
>>>>>>>>                            }
>>>>>>>> +                 if (f2fs_has_inline_data(inode)) {
>>>>>>>> +                         iput(inode);
>>>>>>>> +                         set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>>>> +                         continue;
>>>>>>>
>>>>>>> Any race condtion to get this as false alarm?
>>>>>>
>>>>>> Since there is no reproducer for the bug, I doubt it was caused by metadata
>>>>>> fuzzing, something like this:
>>>>>>
>>>>>> - inline inode has one valid blkaddr in i_addr or in dnode reference by i_nid;
>>>>>> - SIT/SSA entry of the block is valid;
>>>>>> - background GC migrates the block;
>>>>>> - kworker writeback it, and trigger the bug_on().
>>>>>
>>>>> Wasn't detected by sanity_check_inode?
>>>>
>>>> I fuzzed non-inline inode w/ below metadata fields:
>>>> - i_blocks = 1
>>>> - i_size = 2048
>>>> - i_inline |= 0x02
>>>>
>>>> sanity_check_inode() doesn't complain.
>>>
>>> I mean, the below sanity_check_inode() can cover the fuzzed case? I'm wondering
>>
>> I didn't figure out a generic way in sanity_check_inode() to catch all fuzzed cases.
> 
> 
> The patch described:
>   "The root cause is: inline_data inode can be fuzzed, so that there may
>   be valid blkaddr in its direct node, once f2fs triggers background GC
>   to migrate the block, it will hit f2fs_bug_on() during dirty page
>   writeback."
> 
> Do you suspect the node block address was suddenly assigned after f2fs_iget()?

No, I suspect that the image was fuzzed by tools offline, not in runtime after
mount().

> Otherwise, it looks checking them in sanity_check_inode would be enough.
> 
>>
>> e.g.
>> case #1
>> - blkaddr, its dnode, SSA and SIT are consistent
>> - dnode.footer.ino points to inline inode
>> - inline inode doesn't link to the donde
>>
>> Something like fuzzed special file, please check details in below commit:
>>
>> 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
>>
>> case #2
>> - blkaddr, its dnode, SSA and SIT are consistent
>> - blkaddr locates in inline inode's i_addr

The image status is something like above as I described.

Thanks,

>>
>> Thanks,
>>
>>> whether we really need to check it in the gc path.
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thoughts?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>> +                 }
>>>>>>>> +
>>>>>>>>                            err = f2fs_gc_pinned_control(inode, gc_type, segno);
>>>>>>>>                            if (err == -EAGAIN) {
>>>>>>>>                                    iput(inode);
>>>>>>>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>>>>>>>> index ac00423f117b..067600fed3d4 100644
>>>>>>>> --- a/fs/f2fs/inline.c
>>>>>>>> +++ b/fs/f2fs/inline.c
>>>>>>>> @@ -33,11 +33,26 @@ bool f2fs_may_inline_data(struct inode *inode)
>>>>>>>>            return !f2fs_post_read_required(inode);
>>>>>>>>      }
>>>>>>>> -bool f2fs_sanity_check_inline_data(struct inode *inode)
>>>>>>>> +static bool has_node_blocks(struct inode *inode, struct page *ipage)
>>>>>>>> +{
>>>>>>>> + struct f2fs_inode *ri = F2FS_INODE(ipage);
>>>>>>>> + int i;
>>>>>>>> +
>>>>>>>> + for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
>>>>>>>> +         if (ri->i_nid[i])
>>>>>>>> +                 return true;
>>>>>>>> + }
>>>>>>>> + return false;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage)
>>>>>>>>      {
>>>>>>>>            if (!f2fs_has_inline_data(inode))
>>>>>>>>                    return false;
>>>>>>>> + if (has_node_blocks(inode, ipage))
>>>>>>>> +         return false;
>>>>>>>> +
>>>>>>>>            if (!support_inline_data(inode))
>>>>>>>>                    return true;
>>>>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>>>>> index c26effdce9aa..1423cd27a477 100644
>>>>>>>> --- a/fs/f2fs/inode.c
>>>>>>>> +++ b/fs/f2fs/inode.c
>>>>>>>> @@ -343,7 +343,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>>>>>>>                    }
>>>>>>>>            }
>>>>>>>> - if (f2fs_sanity_check_inline_data(inode)) {
>>>>>>>> + if (f2fs_sanity_check_inline_data(inode, node_page)) {
>>>>>>>>                    f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
>>>>>>>>                              __func__, inode->i_ino, inode->i_mode);
>>>>>>>>                    return false;
>>>>>>>> --
>>>>>>>> 2.40.1

