Return-Path: <linux-kernel+bounces-298287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF195C536
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654B8282B35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5155C3E;
	Fri, 23 Aug 2024 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VruIH0DG"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50E6A022
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393599; cv=none; b=nU6Gbh+SERTHFx6gVM6SHcQ+p7Qlh/h6hwwLH4bW//XDBTMtChCUiQ+8PSRNRGPHbH/A9yQJxiPpDXoVVDtTHwWG2Oi5/z8o5fGVBgGA0Q9Znwu3J9kJm1Wvu24KReyjfQxVSNWmDS7EP1l0y0penILkt31x7pPRfo2LNKPKw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393599; c=relaxed/simple;
	bh=VUMwXIMSyIeTBZlzaPoBJKVKFDfRDDHp4ZTbcK6E7D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IH6EPQ20mTn4QQDf7veehKVHkswyT+3jMEwj/6oIWR3fUrePcy638Q2oI88g7kPOyLMaend+s7v1A4GjmLJeUgPif8wmurInJgRWNt/9CXU/Vz5zQ0PA1IqrLX9lRgZ6+OQRk4XFR809/vBtaBECggto76ozN9axGpM0dCUu1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VruIH0DG; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724393587; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l9vVfdqNR2maj7WJKOY1sDy7gPIzSYM4Hjrqvr3z5nc=;
	b=VruIH0DGPo5q2NSd50cocj/uodlyZXw44pgxGoolIfBH5WOXslUa1OVKlf2/QlRBUHL46vgZuSt4wK5BhbZgo/rFwxv5n+NPt6khjaxp0zwfSKU1ZUNRxUIIDIUJJX6vR03+sjnotcjS+fLXvXju/btwZGCoGK+rPb8HRU9hoc0=
Received: from 30.221.129.19(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDSR2PV_1724393586)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 14:13:07 +0800
Message-ID: <ae1eb591-ba89-4290-8c17-4cc7816ce666@linux.alibaba.com>
Date: Fri, 23 Aug 2024 14:13:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix null-ptr-deref when journal load failed.
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: ocfs2-devel@lists.linux.dev, jlbec@evilplan.org, mark@fasheh.com,
 syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240819131120.746077-1-sunjunchao2870@gmail.com>
 <26da607a-530d-4dc1-9040-bf56b406b98f@linux.alibaba.com>
 <CAHB1NaiJJmf838FwSGM8UZX6ebQn8L2hhFxNAcdmRDfBo1VUyg@mail.gmail.com>
 <eb9f35a7-e3ab-47cf-a043-c03f11c21c97@linux.alibaba.com>
 <e7acce1eb19af9798f0c64bdba5fe75688f37c2c.camel@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <e7acce1eb19af9798f0c64bdba5fe75688f37c2c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/23/24 10:22 AM, Julian Sun wrote:
> On Fri, 2024-08-23 at 09:59 +0800, Joseph Qi wrote:
>>
>>
>> On 8/20/24 11:19 PM, Julian Sun wrote:
>>> Joseph Qi <joseph.qi@linux.alibaba.com> 于2024年8月20日周二 21:03写道：
>>>>
>>>>
>>>>
>>>> On 8/19/24 9:11 PM, Julian Sun wrote:
>>>>> During the mounting process, if the jbd2_journal_load()
>>>>> call fails, it will internally invoke journal_reset()
>>>>> ->journal_fail_superblock(), which sets journal->j_sb_buffer
>>>>
>>>>
>>>>> This description is not right.
>>>>> journal_reset() fails because of too short journal, then lead
>>>>> to
>>>>> jbd2_journal_load() fails with NULL j_sb_buffer.
>>> yeah. That's exactly what I described.
>>>>
>>>>> to NULL. Subsequently, ocfs2_journal_shutdown() calls
>>>>> jbd2_journal_flush()->jbd2_cleanup_journal_tail()->
>>>>> __jbd2_update_log_tail()->jbd2_journal_update_sb_log_tail()
>>>>> ->lock_buffer(journal->j_sb_buffer), resulting in a
>>>>> null-pointer dereference error.
>>>>>
>>>>> To resolve this issue, a new state OCFS2_JOURNAL_INITED
>>>>> has been introduced to replace the previous functionality
>>>>> of OCFS2_JOURNAL_LOADED, the original OCFS2_JOURNAL_LOADED
>>>>> is only set when ocfs2_journal_load() is successful.
>>>>
>>>>
>>>>> Or set OCFS2_JOURNAL_LOADED only after JBD2_LOADED?
>>> I don't think this is correct. We first call ocfs2_journal_init(),
>>> which allocates some resources, before calling jbd2_journal_load().
>>> If
>>> ocfs2_journal_init() succeeds but jbd2_journal_load() fails, this
>>> solution may lead to a resource leak.
>>> If there is anything important I'm missing, please let me know,
>>> thanks.
>>>
>>
>> Okay, seems except iput(inode) and kfree(journal), we may have to do
>> the
>> following cleanup:
>> 1) ocfs2_inode_unlock(journal->j_inode);
>> 2) brelse(journal->j_bh);
>> 3) OCFS2_I(inode)->ip_open_count--
>> 4) jbd2_journal_destroy()
>> ...
>>
>> So it seems that introducing a new state will be more clear.
>>
>>>>> The jbd2_journal_flush() function is allowed to be called
>>>>> only when this flag is set. The logic here is that if the
>>>>> journal has even not been successfully loaded, there is
>>>>> no need to flush the journal.
>>>>>
>>>>> Link:
>>>>> https://syzkaller.appspot.com/bug?extid=05b9b39d8bdfe1a0861f
>>>>> Reported-by:
>>>>> syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
>>>>> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
>>>>> ---
>>>>>  fs/ocfs2/journal.c | 9 ++++++---
>>>>>  fs/ocfs2/journal.h | 1 +
>>>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
>>>>> index 530fba34f6d3..6f837296048f 100644
>>>>> --- a/fs/ocfs2/journal.c
>>>>> +++ b/fs/ocfs2/journal.c
>>>>> @@ -968,7 +968,7 @@ int ocfs2_journal_init(struct ocfs2_super
>>>>> *osb, int *dirty)
>>>>>
>>>>>       ocfs2_set_journal_params(osb);
>>>>>
>>>>> -     journal->j_state = OCFS2_JOURNAL_LOADED;
>>>>> +     journal->j_state = OCFS2_JOURNAL_INITED;
>>>>>
>>>>>       status = 0;
>>>>>  done:
>>>>> @@ -1039,6 +1039,7 @@ void ocfs2_journal_shutdown(struct
>>>>> ocfs2_super *osb)
>>>>>       int status = 0;
>>>>>       struct inode *inode = NULL;
>>>>>       int num_running_trans = 0;
>>>>> +     enum ocfs2_journal_state state;
>>>>>
>>>>>       BUG_ON(!osb);
>>>>>
>>>>> @@ -1047,8 +1048,9 @@ void ocfs2_journal_shutdown(struct
>>>>> ocfs2_super *osb)
>>>>>               goto done;
>>>>>
>>>>>       inode = journal->j_inode;
>>>>> +     state = journal->j_state;
>>>>>
>>>>> -     if (journal->j_state != OCFS2_JOURNAL_LOADED)
>>>>> +     if (state != OCFS2_JOURNAL_INITED)
>>
>> This is not right.
>> What if journal has already been loaded?
> Hi, Joseph
> 
> Thanks for your review and comments.
> 
> I'm not sure if I fully understand what you mean. 
> Because the functionality of OCFS2_JOURNAL_INITED is completely
> equivalent to the original OCFS2_JOURNAL_LOADED, so do you mean that
> there might be an issue with the original OCFS2_JOURNAL_LOADED? If so,
> I will dig it into and try to fix.
> But in any case, that should be a separate patch.
> 
> If there is any misunderstanding, please let me know, thanks.

Now you separate original OCFS2_JOURNAL_LOADED into OCFS2_JOURNAL_INITED
and OCFS2_JOURNAL_LOADED. And ocfs2_journal_shutdown() will be called
after OCFS2_JOURNAL_LOADED is set, e.g. normal umount, or error happens
after ocfs2_check_volume(). You changes break the this logic.

BTW, cc linux-kernel as well.

Thanks,
Joseph

