Return-Path: <linux-kernel+bounces-371655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3089A3DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A34D1F2315B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2812208AD;
	Fri, 18 Oct 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hi3GfoBx"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E618028;
	Fri, 18 Oct 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253618; cv=none; b=RPp/ZWnR7+myas4O/+mG5aAu7t0CrjMp4LwjoF5vZIxX5/0aKOJwZTT+uAJmR+8wPmOW57iC/17NpnJQK6Ff8tN+zzedtVr8nnSCLv/K3qDyJjwc+Em6htvbINMU4QK3LnE61BDXqz7p1GUUt0lD0QrLyypNmLHbnN+zdYsLPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253618; c=relaxed/simple;
	bh=i37SaRzslbKXdvTWMx2bvwNLqVIaXZu7rKAifGB+qnQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aMRnzHZt6oyZ/4oVcRenaLIClVy2z0lvEGi4H9pXZ87+f+fnuRRwTbj9NPhrpXJvH/QunNOiS0czKXVyO+eZkJCcBxmSX61qPLdvlnNclcLIP5BESTMVWMEbqNJAlh5Da0Fnitk/5vTWwQi5JEgF3lnHPvKIXSEZ9jX87cCR9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hi3GfoBx; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=1aAs7Nlz9KxKA2Bf4GMSwxHrj241sfnt/4rLIpJMark=;
	b=hi3GfoBx7kF86SUCNIdb/HBRd6UivOGLbw83IDAw3/2dLyY8mJOoj3SKts45MN
	sdMtQyVnk4RmqF1zb9UF0eyT795fKg2IMMw0O5jyy585YiFWuVoSugOnJilp5NIJ
	QSuvrRLwQnWvxxiw22K/BWLYRmajMVKz1biFihTgbcdv0=
Received: from [192.168.22.184] (unknown [223.70.253.255])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHT6hITRJnqFYVBw--.63805S2;
	Fri, 18 Oct 2024 19:58:02 +0800 (CST)
Message-ID: <641939fc-e001-4e4d-8297-58ebe5fc4194@163.com>
Date: Fri, 18 Oct 2024 19:57:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
From: liubaolin <liubaolin12138@163.com>
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, zhangshida@kylinos.cn,
 longzhi@sangfor.com.cn, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
 <5dc22111.4718.19279c3f3b7.Coremail.liubaolin12138@163.com>
 <20241016103301.rl6qngi2fb6yxjin@quack3>
 <908502d6-cb0c-44ae-8c03-9a22c8c7fbf2@163.com>
 <8c14e5b0-5229-4611-b8e6-434c6eb34ee9@163.com>
 <20241018091444.tmzhbj73gvegfmb5@quack3>
 <f5193380-57f8-40c4-b4d6-b8e8cc3d0977@163.com>
In-Reply-To: <f5193380-57f8-40c4-b4d6-b8e8cc3d0977@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHT6hITRJnqFYVBw--.63805S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AryUXw1rGw4fJr1kCr1UGFg_yoWxuw4rpr
	y3Ka17Kr4UtryDArn2qF4UXrWUK34UXr9rXr15Gr1xZ390yrn3tF48tr10ka4DCrWDGw10
	vr1UJr9rGr1jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3-BiUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiLh18ymcSPg36ewAAsC

> please feel free to add:
> Reported-and-tested-by: Baolin Liu <liubaolin@kylinos.cn>
> Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
> 
> Thank you.



在 2024/10/18 19:34, liubaolin 写道:
>> Sorry, I saw the patch you submitted.
>> I would like to request a modification to the commit message.
>> I use the email 'Baolin Liu liubaolin12138@163.com' for community 
>> communication.
>> However, my work email is 'Baolin Liu liubaolin@kylinos.cn'.
>>
>> So I would like to ask you to modify the commit message as follows:
>> From:
>> Reported-by: Baolin Liu liubaolin12138@163.com
>> Reported-by: Zhi Long longzhi@sangfor.com.cn
>> To:
>> Reported-and-tested-by: Baolin Liu liubaolin@kylinos.cn
>> Reported-and-tested-by: Zhi Long longzhi@sangfor.com.cn
>>
>> Could you please make the modification? Thank you.
> 
> 
> 
> 在 2024/10/18 17:14, Jan Kara 写道:
>> On Fri 18-10-24 09:48:17, liubaolin wrote:
>>>> Hello, I am very sorry.
>>>> I did not previously understand the approach of your patch to solve 
>>>> the issue.
>>>> Yesterday, I intentionally injected faults during the quick 
>>>> reproduction
>>>> test, and indeed, after applying your patch, the crash issue was
>>>> resolved and did not occur again.
>>>> I finally understood your approach to solving the problem. Please 
>>>> disregard my previous email.
>>>> Thank you for helping me solve this crash issue in a better way.
>>>> I still need to improve my skills in file systems, and I truly 
>>>> appreciate your guidance.
>>
>> Great! Thanks for testing. I'll send the patch for inclusion then.
>>
>>                                 Honza
>>
>>> 在 2024/10/16 21:38, liubaolin 写道:
>>>>> Hello,
>>>>> I reviewed the patch attached in your email. The issue you mentioned
>>>>> about clearing buffer_new(bh) in write_end_fn() is indeed a bug.
>>>>> However, this patch does not resolve the crash issue we encountered.
>>>>>
>>>>> Let me explain my analysis in detail below.
>>>>> The crash occurs in the function jbd2_journal_dirty_metadata().
>>>>>
>>>>> ext4_block_write_begin() -> ext4_journalled_zero_new_buffers() ->
>>>>> write_end_fn()
>>>>>   -> ext4_dirty_journalled_data() -> ext4_handle_dirty_metadata() ->
>>>>> __ext4_handle_dirty_metadata()
>>>>>   -> jbd2_journal_dirty_metadata()
>>>>>
>>>>> In the function jbd2_journal_dirty_metadata(), there is the
>>>>> following condition:
>>>>> —---------------------------------------------------------------------------------------------------
>>>>>          if (data_race(jh->b_transaction != transaction &&
>>>>>              jh->b_next_transaction != transaction)) {
>>>>>                  spin_lock(&jh->b_state_lock);
>>>>>                  J_ASSERT_JH(jh, jh->b_transaction == transaction ||
>>>>>                                  jh->b_next_transaction == 
>>>>> transaction);
>>>>>                  spin_unlock(&jh->b_state_lock);
>>>>>          }
>>>>> ----------------------------------------------------------------------------------------------------
>>>>> By analyzing the vmcore, I found that both jh->b_transaction and jh-
>>>>>> b_next_transaction are NULL.
>>>>> Through code analysis, I discovered that the
>>>>> __jbd2_journal_file_buffer() function adds the corresponding
>>>>> transaction of bh to jh->b_transaction.
>>>>> Normally, this is accessed through do_journal_get_write_access(),
>>>>> which can call __jbd2_journal_file_buffer().
>>>>> The detailed function call process is as follows:
>>>>> do_journal_get_write_access() -> ext4_journal_get_write_access() ->
>>>>> __ext4_journal_get_write_access()
>>>>>   -> jbd2_journal_get_write_access() -> do_get_write_access() ->
>>>>> __jbd2_journal_file_buffer()
>>>>>
>>>>>
>>>>> Therefore, resolving the crash issue requires obtaining write access
>>>>> before calling the jbd2_journal_dirty_metadata() function.
>>>>> The comment at the definition of the jbd2_journal_dirty_metadata()
>>>>> function also states:     'The buffer must have previously had
>>>>> jbd2_journal_get_write_access().'
>>>>>
>>>>> In the ext4_block_write_begin() function, if get_block() encounters
>>>>> an error, then neither bh->b_this_page nor the subsequent bh calls
>>>>> do_journal_get_write_access().
>>>>> If bh->b_this_page and the subsequent bh are in the new state, it
>>>>> will lead to a crash when reaching the jbd2_journal_dirty_metadata()
>>>>> function.
>>>>>
>>>>> So, there are two ways to resolve this crash issue:
>>>>> 1、Call do_journal_get_write_access() on bh that is not handled due
>>>>> to get_block() error.
>>>>>      The patch modification is in the attachment 0001-ext4-fix-a-
>>>>> assertion-failure-due-to-ungranted-bh-dir.patch.
>>>>>
>>>>> 2、Call clear_buffer_new() on bh that is not handled due to
>>>>> get_block() error.
>>>>>      The patch modification is in the attachment 0001-ext4-fix-a-
>>>>> assertion-failure-due-to-bh-not-clear-new.patch.
>>>>>
>>>>> Additionally, I have found a method to quickly reproduce this crash
>>>>> issue.
>>>>> For details, please refer to the email I previously sent you:
>>>>> “https://lore.kernel.org/all/bd41c24b-7325-4584-
>>>>> a965-392a32e32c74@163.com/”.
>>>>> I have verified that this quick reproduction method works for both
>>>>> solutions to resolve the issue.
>>>>>
>>>>> Please continue to consider which method is better to resolve this
>>>>> issue. If you think that using clear_buffer_new() is a better
>>>>> solution, I can resend the patch via git send-mail.
>>>>
>>>>
>>>>
>>>> 在 2024/10/16 18:33, Jan Kara 写道:
>>>>> Hello,
>>>>>
>>>>> On Fri 11-10-24 12:08:58, Baolin Liu wrote:
>>>>>> Greetings，
>>>>>>
>>>>>> This problem is reproduced by our customer using their own testing 
>>>>>> tool
>>>>>> “run_bug”. When I consulted with a client, the testing tool “run_bug”
>>>>>> used a variety of background programs to benchmark (including memory
>>>>>> pressure, cpu pressure, file cycle manipulation, fsstress Stress 
>>>>>> testing
>>>>>> tool, postmark program，and so on).
>>>>>>
>>>>>> The recurrence probability is relatively low.
>>>>>
>>>>> OK, thanks for asking!
>>>>>
>>>>>> In response to your query, in ext4_block_write_begin, the new 
>>>>>> state will
>>>>>> be clear before get block, and the bh that failed get_block will 
>>>>>> not be
>>>>>> set to new. However, when the page size is greater than the
>>>>>> block size, a
>>>>>> page will contain multiple bh.
>>>>>
>>>>> True. I wanted to argue that the buffer_new bit should be either
>>>>> cleared in
>>>>> ext4_block_write_begin() (in case of error) or in
>>>>> ext4_journalled_write_end() (in case of success) but actually
>>>>> ext4_journalled_write_end() misses the clearing. So I think the better
>>>>> solution is like the attached patch. I'll submit it once testing 
>>>>> finishes
>>>>> but it would be great if you could test that it fixes your problems as
>>>>> well. Thanks!
>>>>>
>>>>>                                  Honza
>>>
> 


