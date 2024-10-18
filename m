Return-Path: <linux-kernel+bounces-370792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A29A3226
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD39B1F22FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A606757F3;
	Fri, 18 Oct 2024 01:41:05 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64343558BC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215665; cv=none; b=bPlAREpgaxI7INb7cSZyR2+6Db9qlrvhqN/ZRuRfJ+KF1Ll9NUF81gvg/iw0ziAMAP4AdoGcD7Q/RjCBU5sRFrtPv8ZB3A6FjkBUM4+40J7M0x/gD5u+5/uaNqVo9H1mkg2K4zHh18NWOnukhyAC9OH5S+yXcVHtSSy89wA1ikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215665; c=relaxed/simple;
	bh=N8l/f02iagzexerYyu9z0+Jt6eIXb+EtgywlJde3mjE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=es/XEF7zg1/kmip+vWh6b/lbPfzxHMJL4iIc2U8TIPsAOvjLtU0K7/CLtjH+GXq9sVocj01FiPl4hoIWn5YROZk/G7ceh+pE5+Try80awP+rPnLjbvvD+GUlRYeenSXiz1mwtX7xmI5d5ZZyAvIJBHEf59/YBjUTwHSsunfa0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XV6pN6jkDz20qQy;
	Fri, 18 Oct 2024 09:40:12 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id D2C731A0188;
	Fri, 18 Oct 2024 09:40:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 09:40:58 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com> <pnd7ca9r0pt.fsf@axis.com>
 <239af2ee-c18d-414f-099f-2c82f98d9671@huawei.com> <pnd7ca6wp9r.fsf@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b3b80d1c-6c99-5d47-cba0-3be14ff79c36@huawei.com>
Date: Fri, 18 Oct 2024 09:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pnd7ca6wp9r.fsf@axis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/18 2:36, Waqar Hameed Ð´µÀ:
> On Wed, Oct 16, 2024 at 10:11 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
> [...]
> 
>> BTW, what is the configuration of your flash?(eg. erase size, page size)?
> 
> $ mtdinfo /dev/mtd2
>    mtd2
>    Name:                           firmware
>    Type:                           nand
>    Eraseblock size:                131072 bytes, 128.0 KiB
>    Amount of eraseblocks:          1832 (240123904 bytes, 229.0 MiB)
>    Minimum input/output unit size: 2048 bytes
>    Sub-page size:                  2048 bytes
>    OOB size:                       64 bytes
>    Character device major/minor:   90:4
>    Bad blocks are allowed:         true
>    Device is writable:             true
> 
> $ ubinfo /dev/ubi0_0
>    Volume ID:   0 (on ubi0)
>    Type:        dynamic
>    Alignment:   1
>    Size:        661 LEBs (83931136 bytes, 80.0 MiB)
>    State:       OK
>    Name:        test-vol
>    Character device major/minor: 244:1
> 
> [...]

Thanks, I will change my nandsim configurations to generate a mtd device 
the same model.
> 
>> Well, let's do a preliminary analysis.
>> The znode->cparent[znode->ciip] is a freed address in write_index(), which
>> means:
>> 1. 'znode->ciip' is valid, znode->cparent is freed by tnc_delete, however znode
>> cannot be freed if znode->cnext is not NULL, which means:
>>    a) 'znode->cparent' is not dirty, we should add an assertion like
>>    ubifs_assert(c, ubifs_zn_dirty(znode->cparent)) in get_znodes_to_commit().
>>    Note, please check that 'znode->cparent' is not NULL before the assertion.
>>    b) 'znode->cparent' is dirty, but it is not added into list 'c->cnext', we
>>    should traverse the entire TNC in get_znodes_to_commit() to make sure that all
>>    dirty znodes are collected into list 'c->cnext', so another assertion is
>>   needed.
>> 2. 'znode->ciip' is invalid, and the value beyonds the memory area of
>> znode->cparent. All znodes are allocated with size of 'c->max_znode_sz', which
>> means that 'znode->ciip' exceeds the 'c->fantout', so we can add an assertion
>> like ubifs_assert(c, znode->ciip < c->fantout) in get_znodes_to_commit().
>>
>> That's what I can think of, are there any other possibilities?
> 
> I looked a little more at `get_znodes_to_commit()` when adding the
> asserts you suggest, and I have a question: what happens when
> `find_next_dirty()` returns `NULL`? In that case
> 
> ```
> znode->cnext = c->cnext;
> ```
> 
> but `znode->cparent` and `znode->ciip` are not updated. Shouldn't they?

Good thinking.
According to the implementation of find_next_dirty(), the order of dirty 
znodes collection is bottom-up, which means that the last dirty znode is 
the root znode, so it doesn't have a parent. You can verify that by 
adding assertion to check whether the last dirty znode is the root.
> 
> By the way, I left a test running, and it actually triggered the same
> KASAN report after 800 iterations... So we now at least know that this
> patch doesn't indeed fix the problem.
> 
> I also found another minor thing regarding the update of `cnt` in
> `get_znodes_to_commit`. I'll send a separate patch for that.
> .
> 


