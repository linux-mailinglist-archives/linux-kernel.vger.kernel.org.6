Return-Path: <linux-kernel+bounces-320582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D16970C32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BF41F2249C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB341AC897;
	Mon,  9 Sep 2024 03:20:54 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709791400A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725852053; cv=none; b=WoLXTe3aaL2OT8MMJjjLicOHyODkTFhRyU0JN9nktMW1i773LlwKzHnqsANOnKneN3w3OBTLn933z6MHLl3aOAEsYcbQHhUUcZqThlQSFuszMiUrdZFqPNQRYf+4faSy4tFd7lebnLvblYFI+UoIaj6G97Cbu3dkrS0EhvTcq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725852053; c=relaxed/simple;
	bh=vaDqM2punjCmT7Jh0Bq7yjiB+5/tGwkGIkNgMGJSPj4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LnBkFC/AQuqRb8ZscIPof66tVlADvl2sBF8tjdE+rgx1SQGXr2VraJ/HSL7xI/D5zesOzw2REFBXNcTXiMzy6KbiL9Vx1UUG6kkRLd8ogrM4tKlf9vHkthzCLN8kat9YE0q+jV274pZqiUS34B2N/o/4v3XtAvnTt9nWPpQVvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2Bsw6Brsz1j8JW;
	Mon,  9 Sep 2024 11:20:20 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E3CC1A0188;
	Mon,  9 Sep 2024 11:20:47 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 11:20:46 +0800
Subject: Re: [PATCH] ubi: wl: Close down wear-leveling before nand is
 suspended
To: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>, Richard
 Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>
References: <20240907-ubi-wl-race-v1-1-6f7f5e0aea7b@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <10beabdf-17e2-8232-0ce9-1b3d1136f6bb@huawei.com>
Date: Mon, 9 Sep 2024 11:20:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240907-ubi-wl-race-v1-1-6f7f5e0aea7b@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/9/8 3:28, Mårten Lindahl 写道:
> If a reboot/shutdown signal with double force (-ff) is triggered when
> the erase worker or wear-leveling worker function runs we may end up in
> a race condition since the MTD device gets a reboot notification and
> suspends the nand flash before the erase or wear-leveling is done. This
> will reject all accesses to the flash with -EBUSY.
> 
> Sequence for the erase worker function:
> 
>     systemctl reboot -ff           ubi_thread
> 
>                                  do_work
>   __do_sys_reboot
>     blocking_notifier_call_chain
>       mtd_reboot_notifier
>         nand_shutdown
>           nand_suspend
>                                    __erase_worker
>                                      ubi_sync_erase
>                                        mtd_erase
>                                          nand_erase_nand
> 
>                                            # Blocked by suspended chip
>                                            nand_get_device
>                                              => EBUSY
> 
> Similar sequence for the wear-leveling function:
> 
>     systemctl reboot -ff           ubi_thread
> 
>                                  do_work
>   __do_sys_reboot
>     blocking_notifier_call_chain
>       mtd_reboot_notifier
>         nand_shutdown
>           nand_suspend
>                                    wear_leveling_worker
>                                      ubi_eba_copy_leb
>                                        ubi_io_write
>                                          mtd_write
>                                            nand_write_oob
> 
>                                              # Blocked by suspended chip
>                                              nand_get_device
>                                                => EBUSY
> 
>   systemd-shutdown[1]: Rebooting.
>   ubi0 error: ubi_io_write: error -16 while writing 2048 bytes to PEB
>   CPU: 1 PID: 82 Comm: ubi_bgt0d Kdump: loaded Tainted: G           O
>   (unwind_backtrace) from [<80107b9f>] (show_stack+0xb/0xc)
>   (show_stack) from [<8033641f>] (dump_stack_lvl+0x2b/0x34)
>   (dump_stack_lvl) from [<803b7f3f>] (ubi_io_write+0x3ab/0x4a8)
>   (ubi_io_write) from [<803b817d>] (ubi_io_write_vid_hdr+0x71/0xb4)
>   (ubi_io_write_vid_hdr) from [<803b6971>] (ubi_eba_copy_leb+0x195/0x2f0)
>   (ubi_eba_copy_leb) from [<803b939b>] (wear_leveling_worker+0x2ff/0x738)
>   (wear_leveling_worker) from [<803b86ef>] (do_work+0x5b/0xb0)
>   (do_work) from [<803b9ee1>] (ubi_thread+0xb1/0x11c)
>   (ubi_thread) from [<8012c113>] (kthread+0x11b/0x134)
>   (kthread) from [<80100139>] (ret_from_fork+0x11/0x38)
>   Exception stack(0x80c43fb0 to 0x80c43ff8)
>   ...
>   ubi0 error: ubi_dump_flash: err -16 while reading 2048 bytes from PEB
>   ubi0 error: wear_leveling_worker: error -16 while moving PEB 246 to PEB
>   ubi0 warning: ubi_ro_mode.part.0: switch to read-only mode
>   ...
>   ubi0 error: do_work: work failed with error code -16
>   ubi0 error: ubi_thread: ubi_bgt0d: work failed with error code -16

Yes, I noticed these types of messages too before kernel v5.18. Since 
commit 013e6292aaf5e4b0("mtd: rawnand: Simplify the locking"), the 
behavior of nand_get_device() is changed. A process who is invoking 
nand_get_device() during rebooting won't be stucked, it will get an 
EBUSY error code, that's why we see the above messages from UBI module.
After commit 8cba323437a49a4("mtd: rawnand: protect access to rawnand 
devices while in suspend"), the behavior of nand_get_device() is changed 
back. A process who is invoking nand_get_device() during rebooting will 
be stucked again, so there should be no error messages in UBI layer.
So, is your kernel version lower than v5.18?


