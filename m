Return-Path: <linux-kernel+bounces-399429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC799BFED4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C585CB225EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F7C198A0F;
	Thu,  7 Nov 2024 07:15:05 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB5195B18
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963704; cv=none; b=FgOi8vlQkSTj4MaBQg+u3rQEW5DWlLCU8cTzmw2O/8uaFqT8W1OQ+VhD95km+eySTKE7H9sXbrrMpZx8tTdWROsoFq0zqLyIVM3nqFbX7zTXs0BTxPjdv2vBCwOp2JN0ygBIQ4OkWSTJBoskVcVXO2nV5wp2uLQxldGjW8bJkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963704; c=relaxed/simple;
	bh=jbaB46Go95hwJUhkS2fYrcPVMTX3E+7ZvpLuas6HYkg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V7iP10XG1BpxxMRZjjR42yrQnxfZ1zl2shBQ/H1hSCajApc2H9fcBmWSyc/VmVWfus2c6n6Ms6E7w+ZbZhk3K4lPE8ZyfgvW9bHZr6IMFTqzXfopSMgJUqspBwEO8+l6PNzDtJ0WcqwzHIFejK5WRpS/4Rzd419u+0sLgkepBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XkYG61wQbzQsQv;
	Thu,  7 Nov 2024 15:13:50 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 53619140392;
	Thu,  7 Nov 2024 15:14:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 15:14:57 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com> <pnd7ca9r0pt.fsf@axis.com>
 <239af2ee-c18d-414f-099f-2c82f98d9671@huawei.com> <pnd7ca6wp9r.fsf@axis.com>
 <b3b80d1c-6c99-5d47-cba0-3be14ff79c36@huawei.com> <pndses42uam.fsf@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <932b3c63-82a7-e1ec-b46c-136e9fd60e64@huawei.com>
Date: Thu, 7 Nov 2024 15:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pndses42uam.fsf@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/11/7 0:36, Waqar Hameed 写道:
> Sorry for the late response Zhihao! I've been quite busy these days...
> 
> On Fri, Oct 18, 2024 at 09:40 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
>> 在 2024/10/18 2:36, Waqar Hameed 写道:
>>> On Wed, Oct 16, 2024 at 10:11 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>> [...]
>>>
>>>> BTW, what is the configuration of your flash?(eg. erase size, page size)?
>>> $ mtdinfo /dev/mtd2
>>>     mtd2
>>>     Name:                           firmware
>>>     Type:                           nand
>>>     Eraseblock size:                131072 bytes, 128.0 KiB
>>>     Amount of eraseblocks:          1832 (240123904 bytes, 229.0 MiB)
>>>     Minimum input/output unit size: 2048 bytes
>>>     Sub-page size:                  2048 bytes
>>>     OOB size:                       64 bytes
>>>     Character device major/minor:   90:4
>>>     Bad blocks are allowed:         true
>>>     Device is writable:             true
>>> $ ubinfo /dev/ubi0_0
>>>     Volume ID:   0 (on ubi0)
>>>     Type:        dynamic
>>>     Alignment:   1
>>>     Size:        661 LEBs (83931136 bytes, 80.0 MiB)
>>>     State:       OK
>>>     Name:        test-vol
>>>     Character device major/minor: 244:1
>>> [...]
>>
>> Thanks, I will change my nandsim configurations to generate a mtd device the
>> same model.
> 
> Did you manage to reproduce the issue with this?

I tried, but I still cannot reproduce it on my local machine.
> 
>>>
>>>> Well, let's do a preliminary analysis.
>>>> The znode->cparent[znode->ciip] is a freed address in write_index(), which
>>>> means:
>>>> 1. 'znode->ciip' is valid, znode->cparent is freed by tnc_delete, however znode
>>>> cannot be freed if znode->cnext is not NULL, which means:
>>>>     a) 'znode->cparent' is not dirty, we should add an assertion like
>>>>     ubifs_assert(c, ubifs_zn_dirty(znode->cparent)) in get_znodes_to_commit().
>>>>     Note, please check that 'znode->cparent' is not NULL before the assertion.
>>>>     b) 'znode->cparent' is dirty, but it is not added into list 'c->cnext', we
>>>>     should traverse the entire TNC in get_znodes_to_commit() to make sure that all
>>>>     dirty znodes are collected into list 'c->cnext', so another assertion is
>>>>    needed.
> 
> I'm a little worried that traversing the whole TNC could change the
> timing behavior, and thus might not trigger the race. Let's do that in
> steps? Start with the other asserts (see diff below) and later just do
> this assert. Does that sound reasonable?

Fine. I add one comment below.
> 
> I could modify `dbg_check_tnc()` so that it also checks that each dirty
> `znode` is present in `c->cnext` list. We then call this at the end of
> `get_znodes_to_commit()`.
> 

Sounds good to me, please remove other non-related checks in 
dbg_check_tnc().
>>>> 2. 'znode->ciip' is invalid, and the value beyonds the memory area of
>>>> znode->cparent. All znodes are allocated with size of 'c->max_znode_sz', which
>>>> means that 'znode->ciip' exceeds the 'c->fantout', so we can add an assertion
>>>> like ubifs_assert(c, znode->ciip < c->fantout) in get_znodes_to_commit().
>>>>
>>>> That's what I can think of, are there any other possibilities?
>>> I looked a little more at `get_znodes_to_commit()` when adding the
>>> asserts you suggest, and I have a question: what happens when
>>> `find_next_dirty()` returns `NULL`? In that case
>>> ```
>>> znode->cnext = c->cnext;
>>> ```
>>> but `znode->cparent` and `znode->ciip` are not updated. Shouldn't they?
>>
>> Good thinking.
>> According to the implementation of find_next_dirty(), the order of dirty znodes
>> collection is bottom-up, which means that the last dirty znode is the root
>> znode, so it doesn't have a parent. You can verify that by adding assertion to
>> check whether the last dirty znode is the root.
> 
> [...]
> 
> To summarize, I'll start a run with the following asserts:
> 
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a55e04822d16..4eef82e02afe 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -652,11 +652,17 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>   	}
>   	cnt += 1;
>   	while (1) {

Please move the check after the assignment of 'znode->cparent', because 
'znode->parent' could be switched by tnc_insert().
> +		ubifs_assert(c, znode->ciip < c->fantout);
> +		if (znode->cparent) {
> +			ubifs_assert(c, ubifs_zn_dirty(znode->cparent));
> +		}
> +
>   		ubifs_assert(c, !ubifs_zn_cow(znode));
>   		__set_bit(COW_ZNODE, &znode->flags);
>   		znode->alt = 0;
>   		cnext = find_next_dirty(znode);
>   		if (!cnext) {
> +			ubifs_assert(c, znode == c->zroot.znode);
>   			znode->cnext = c->cnext;
>   			break;
>   		}
> 

@@ -662,6 +662,10 @@ static int get_znodes_to_commit(struct ubifs_info *c)
                 }
                 znode->cparent = znode->parent;
                 znode->ciip = znode->iip;
+               if (znode->cparent) {
+                       ubifs_assert(c, ubifs_zn_dirty(znode->cparent));
+               }
+               ubifs_assert(c, znode->ciip < c->fantout);
                 znode->cnext = cnext;
                 znode = cnext;
                 cnt += 1;

> Then later, another run with a modified `dbg_check_tnc()` to check that
> all dirty `znode`s are indeed present in the list `c->cnext`.
> .
> 


