Return-Path: <linux-kernel+bounces-403449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A920D9C35DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26C61C2148A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BD17C69;
	Mon, 11 Nov 2024 01:23:55 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE52EACD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288235; cv=none; b=Lu41Kh3JaJyIiXzrEZcmuL9zXwdeI1tO4HladH2obEOjycO4Sb93vZehwc6RAlS3EauBtE2BzHwrUf2LC3D04AfYQWWjMCdDEQoS40zh1Jgcfhq7qur6ytTLnS64k29WP2BITwzOoYcChE3/M5FlnyyL6A1b4GcYsebVFsXmcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288235; c=relaxed/simple;
	bh=GzDSymeFLcSp5DGb9vI/Zqlut6YtFcb3duNnbPFWwzo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LfHPwlo7y4CakXeclGTy3lB57E7ewx60fIazDj0BDxWZtvI5CdcCeVSGx9gi+JrJRPXYhMKH8taSGpUMirEXj/aG/7qd0GEFK1zmyJQbc0syVEst+3JVyExXD/n24al+8idu+6MwRa/qMDBaJMEdfyNYaaMK+2PgOFdADB14quc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XmsGM0gv8z1hwRD;
	Mon, 11 Nov 2024 09:22:03 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A36F1A0188;
	Mon, 11 Nov 2024 09:23:50 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 09:23:49 +0800
Subject: Re: [PATCH v2] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com>
 <3c46013e-809e-cdcf-8648-2ffe2ab6c32b@huawei.com> <pndbjymzrnh.fsf@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f43655b7-0283-0008-1475-67174533d21a@huawei.com>
Date: Mon, 11 Nov 2024 09:23:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pndbjymzrnh.fsf@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/11/11 5:48, Waqar Hameed 写道:
> On Sat, Nov 09, 2024 at 10:34 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
>> 在 2024/10/9 22:46, Waqar Hameed 写道:
>> 3 nits below.
>>
>> 1. Make the title as 'ubifs: authentication: Fix use-after-free in
>> ubifs_tnc_end_commit'
>>
>> 2. At the begining of the commit msg, describe the problem:
>> After TNC tree inserting(which may trigger a znode split and change the
>> znode->parent) and deleting(which may trigger znode freeing), the
>> znode->cparent(which still points to a freed znode) may not be updated at the
>> begining of commit, which could trigger an UAF problem while accessing
>> znode->cparent in write_index().
> 
> Alright, will rephrase the commit message a bit.
> 
>>
>>> Running
>>>     rm -f /etc/test-file.bin
>>>     dd if=/dev/urandom of=/etc/test-file.bin bs=1M count=60 conv=fsync
>>> in a loop, with `CONFIG_UBIFS_FS_AUTHENTICATION`, KASAN reports:
>>>     BUG: KASAN: use-after-free in ubifs_tnc_end_commit+0xa5c/0x1950
>>>     Write of size 32 at addr ffffff800a3af86c by task ubifs_bgt0_20/153
>>>     Call trace:
>>
>> [...]
>>> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
>>> index a55e04822d16..a464eb557585 100644
>>> --- a/fs/ubifs/tnc_commit.c
>>> +++ b/fs/ubifs/tnc_commit.c
>>> @@ -657,6 +657,7 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>>>    		znode->alt = 0;
>>>    		cnext = find_next_dirty(znode);
>>>    		if (!cnext) {
>>
>> 3. I'd like to add the the assertion 'ubifs_assert(c, !znode->parent);'
> 
> Wouldn't the assert always be true? Since the root node wouldn't have a
> parent. Or are we afraid of some other edge cases (bugs?) that might
> have been missed and want to be defensive here? Either way, I'll add the
> assert.

A defensive code here is to prevent some unknown bugs, in which the last 
returned znode has a parent, although it looks impossible for current 
realization.
> 
>>> +			znode->cparent = NULL;
>>>    			znode->cnext = c->cnext;
>>>    			break;
>>>    		}
>>>
> .
> 


