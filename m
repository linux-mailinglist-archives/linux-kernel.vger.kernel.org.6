Return-Path: <linux-kernel+bounces-436785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C09E8AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676D4188212C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830F14A4FB;
	Mon,  9 Dec 2024 05:03:08 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298B4C91
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720588; cv=none; b=nb8RX98dtQyk4KXvtE4ELe9/phkiVRSukUkC09T/D7rUkeSdMF/DCzuVQCGxr7uilO4fXm8EyY61oIsC5usQ6Ll4vU3iDbS1tMHhshC00kUqohIIV0FHi46Oe6NkGnVJXPwD8JnDvBDaF7RXjv1bb9DXv+UAodenDjveNnkN1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720588; c=relaxed/simple;
	bh=v1QZ6/a4HOQZfnqLaSgZ2Y5a/OZhbcLZbP/q88JSpPk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GxSmwUyX1j8KRk96zkUSspks7izZaV68nj9nXNJdriApHHX0RuICs7B7MW77Eioa8ZbwXThgRhEhIC5GL0YL0flSB66L5CeNkasXqCUBNNvdDV1Se3pBafRpZo5AsDxWw4FdKmmpsFO6JJajPv85Idt2xYcjM7yYWuBNX7Pd9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y68nh0hb1z1kvfh;
	Mon,  9 Dec 2024 13:00:40 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id CF55C1A016C;
	Mon,  9 Dec 2024 13:03:02 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 13:03:02 +0800
Subject: Re: [PATCH] MTD: fix slab-use-after-free due to dangling pointer in
 notifier chain
To: Dennis Lam <dennis.lamerice@gmail.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
References: <20241208175211.9406-2-dennis.lamerice@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <638528e2-e265-e421-13b8-259851c50f43@huawei.com>
Date: Mon, 9 Dec 2024 13:03:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241208175211.9406-2-dennis.lamerice@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/9 1:52, Dennis Lam Ð´µÀ:
> When attaching MTDs, a reboot notifier is added to the blocking
> notification chain. However, when detaching a MTD and freeing its
> related objects, the notifier is never unregistered from the
> notification chain and is freed during the detaching process. This
> results in the slab-use-after-free.
> 
> To fix this, I added an unregister notifier function in the ubi_wl_close
> function to ensure that the notifier is removed from the chain after the
> device has been detached.
> 
> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> Reported-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67409091.050a0220.363a1b.013d.GAE@google.com/T/
> ---
>   drivers/mtd/ubi/wl.c | 1 +
>   1 file changed, 1 insertion(+)

Hi Dennis, thanks for reporting it! It is an actual bug and I can 
reproduce it easily:
[  232.811608] 
==================================================================
[  232.812392] BUG: KASAN: slab-use-after-free in 
notifier_call_chain+0x2b0/0x300
[  232.813195] Read of size 8 at addr ffff888109fd92e0 by task 
systemd-shutdow/1
[  232.813979]
[  232.814162] CPU: 1 UID: 0 PID: 1 Comm: systemd-shutdow Not tainted 
6.13.0-rc2-00019-g580644ec5adf-dirty #54
[  232.815224] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.16.3-2.fc40 04/01/2014
[  232.816184] Call Trace:
[  232.816466]  <TASK>
[  232.816713]  dump_stack_lvl+0x9f/0xf0
[  232.817122]  print_report+0x21e/0x76f
[  232.819952]  __asan_report_load8_noabort+0x24/0x40
[  232.820487]  notifier_call_chain+0x2b0/0x300
[  232.820982]  blocking_notifier_call_chain+0x6a/0xc0
[  232.821531]  kernel_restart_prepare+0x25/0xa0
[  232.822022]  kernel_restart+0x1a/0x60
[  232.822435]  __do_sys_reboot+0x21b/0x3c0
[  232.825632]  __x64_sys_reboot+0x9e/0x110
[  232.826616]  x64_sys_call+0x1315/0x4150
[  232.827047]  do_syscall_64+0xa7/0x210
[  232.827462]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

And I think this patch could fix the single problem. Before that, I find 
the commit 5580cdae05aefa96deebd7f5ade9d70c92adabd7("ubi: wl: Close down 
wear-leveling before nand is suspended") is applied by a mistake. Hi, 
Richard, the patch has been discussed in 
https://lore.kernel.org/all/9bf76f5d-12a4-46ff-90d4-4a7f0f47c381@axis.com/, 
and the patch is not needed now, otherwise, there will be other UAF 
problems(in fm worker). If you agree, I will send a patch to revert it.
> 
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 4f6f339d8fb8..31a1e5515d98 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -1995,6 +1995,7 @@ static void protection_queue_destroy(struct ubi_device *ubi)
>   void ubi_wl_close(struct ubi_device *ubi)
>   {
>   	dbg_wl("close the WL sub-system");
> +	unregister_reboot_notifier(&ubi->wl_reboot_notifier);
>   	ubi_fastmap_close(ubi);
>   	shutdown_work(ubi);
>   	protection_queue_destroy(ubi);
> 


