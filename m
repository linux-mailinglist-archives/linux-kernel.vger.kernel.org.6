Return-Path: <linux-kernel+bounces-367108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A62C99FEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1E51C21888
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDE14AD17;
	Wed, 16 Oct 2024 02:11:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341913B298
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044713; cv=none; b=lEzKtF7cQ4LvGKvKe/ShqVeRkkiYqq8ljugltgVp2VQJFB9p6ONszr6yK75e35cx2dBEUEp32lFNfuDCrV7b4WEIXmQZf1UjRxbyz1Q0wxO7rSXc25fj4n+/dhc7mKjVjEeVFD/oixiDsHYQBcpAF/HKV4PAhnwidannBFCXfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044713; c=relaxed/simple;
	bh=ZqNsJ/6KJFcbs8KwpjmGoRFD4cUwzJd634Aw1YDIXHE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DbmY0OMJC26RU0/QK2iTPwq4chff0EeH1Zca1esK5y2t85pwjW1JltiiG02FKqczI+gdZ8/ftg4nJw2QUHF9Xo6sVa/QkX3J85ph+r+Ck+H8R3PKmWGPL+LznSxe404rJDjhRJ3lMfojm2oX7OTVzm3kHTdcQe8TLBgMS7z6myA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XSvZw2qnGz20qB6;
	Wed, 16 Oct 2024 10:11:04 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 2656B1402C7;
	Wed, 16 Oct 2024 10:11:48 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 10:11:47 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com> <pnd7ca9r0pt.fsf@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <239af2ee-c18d-414f-099f-2c82f98d9671@huawei.com>
Date: Wed, 16 Oct 2024 10:11:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pnd7ca9r0pt.fsf@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/10/16 2:52, Waqar Hameed 写道:
Hi Waqar,
[...]
> 
> For completeness, here are the _exact_ steps that I have used to
> reproduce this on my system with v6.12-rc2 (commit 75b607fab38d "Merge
> tag 'sched_ext-for-6.12-rc2-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext"):
> 
> ```
> ubiattach -m 2
> 
> keyctl add logon dummy_key: dummy_load @us
> 
> ubimkvol /dev/ubi0 -s 80MiB -n 0 -N test-vol
> ubiupdatevol /dev/ubi0_0 -t
> 
> mount -t ubifs /dev/ubi0_0 /mnt/flash -o auth_hash_name=sha256,auth_key=dummy_key:
> 
> count=0
> while true; do
>      date
>      count=$(($count + 1))
>      echo count=$count
> 
>      rm -f /mnt/flash/test-file.bin
>      dd if=/dev/urandom of=/mnt/flash/test-file.bin bs=1M count=60 conv=fsync
> 
>      echo ""
> done
> ```
> 

Thanks for the complete program, I will try it again.
BTW, what is the configuration of your flash?(eg. erase size, page size)?

> Note that you need to have `CONFIG_UBIFS_FS_AUTHENTICATION=y` (and
> `CONFIG_KASAN=y` obviously) in your `.config` in order to trigger the
> offending `memcpy()` in `ubifs_copy_hash()`. Also, it takes a while. For
> example, last time it took me 88 iterations of the above loop before it
> triggered. So you might need to let it spin for a while.

Yes, above two configs are enabled, and I have added printing messages 
to confirm the authentication path is active.
> 
>>
>> Can you dig more deeper by adding more debug message, so that we can figure out
>> what is really happening.
> 
> Certainly! I could try to enable the debug prints from UBIFS, however
> they are *a lot*. Moreover, printing that much changes the timing
> behavior and might make it harder to trigger the use-after-free. Do you
> have any tips on where we should try to focus the debug prints (a
> dynamic debug filter).
> 

Well, let's do a preliminary analysis.
The znode->cparent[znode->ciip] is a freed address in write_index(), 
which means:
1. 'znode->ciip' is valid, znode->cparent is freed by tnc_delete, 
however znode cannot be freed if znode->cnext is not NULL, which means:
   a) 'znode->cparent' is not dirty, we should add an assertion like 
ubifs_assert(c, ubifs_zn_dirty(znode->cparent)) in 
get_znodes_to_commit(). Note, please check that 'znode->cparent' is not 
NULL before the assertion.
   b) 'znode->cparent' is dirty, but it is not added into list 
'c->cnext', we should traverse the entire TNC in get_znodes_to_commit() 
to make sure that all dirty znodes are collected into list 'c->cnext', 
so another assertion is needed.
2. 'znode->ciip' is invalid, and the value beyonds the memory area of 
znode->cparent. All znodes are allocated with size of 'c->max_znode_sz', 
which means that 'znode->ciip' exceeds the 'c->fantout', so we can add 
an assertion like ubifs_assert(c, znode->ciip < c->fantout) in 
get_znodes_to_commit().

That's what I can think of, are there any other possibilities?

