Return-Path: <linux-kernel+bounces-218622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D813990C2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7201F2411F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392655888;
	Tue, 18 Jun 2024 04:04:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F752595
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683455; cv=none; b=ojpwU7l3lcLjymBCjkBS3+HZmp2IMPNhn1v5TRA7jrr802tsuDJDNFDBhHN0CIZxuKI8AMzdGXV2XAjQXssuQtLFGRZ9PEjcLqRkCCf4traPozIkbK6pd5iDGjTzzZ7hZSNcf/mFjg7VJA1ZroLgZsSJYgTVyCgn+qIuC/m+n7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683455; c=relaxed/simple;
	bh=94IvZ0knlZzd09LLiZCSkHk2vbZlQzsGrqSTZXOLB1w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PMdVGQIgubG4bCsux9aSBebo1mC88xyD+8CcGg0g2a4UBn3lDIhydsV4roolVQt3GSp7imJKCKnwQdAkNCoucFxUeXRqdpABXChNvtkBGQLk9SfHH8G3RJRRaWqAy87Q4x+vs3GKx6rj0FFoHF3in7O0jiorD4MyBT3CE3uBPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W3Cgy0XbqzxSKC;
	Tue, 18 Jun 2024 11:59:58 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C23EF140159;
	Tue, 18 Jun 2024 12:04:08 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 12:04:07 +0800
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To: Gagan Sidhu <broly@mac.com>, Daniel Golle <daniel@makrotopia.org>
CC: Richard Weinberger <richard@nod.at>, ZhaoLong Wang
	<wangzhaolong1@huawei.com>, dpervushin <dpervushin@embeddedalley.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mtd
	<linux-mtd@lists.infradead.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, yangerkun <yangerkun@huawei.com>, yi
 zhang <yi.zhang@huawei.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
 <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com>
 <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com>
 <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
 <303502000.252057.1718647746641.JavaMail.zimbra@nod.at>
 <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com>
 <296007365.252185.1718649153090.JavaMail.zimbra@nod.at>
 <3841F21D-CA54-456C-9D9C-F06EEA332A30@mac.com>
 <136290141.252319.1718650375432.JavaMail.zimbra@nod.at>
 <ZnCcsPA-flVcxiAT@makrotopia.org>
 <C20708FB-0626-475E-A996-DE42ACF57A8B@mac.com>
 <C7514984-8CEB-4D1F-A896-BD6E653D311B@mac.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <251ae039-9f46-081b-a7ee-fe47de268865@huawei.com>
Date: Tue, 18 Jun 2024 12:03:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <C7514984-8CEB-4D1F-A896-BD6E653D311B@mac.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/6/18 6:13, Gagan Sidhu 写道:
Hi,
> spoke to a user, gave him a build without MTD_GLUEBI, restoring changes made by (HAHAHA you are! huawei), it booted fine.
> 

May I have the layers' information about mtd/ubi, you can get it by 
'mtdinfo -a' and 'ubinfo -a' after booting the device.
I guess your device boots from ubiblock0_0. There are two ways loading 
booting device:
1. mtd(nand)
    ubi(holds volume ubi0_0)
    mtd12 (gluebi)
    mtdblock12  (This way is cut by this patch, so mtdblock12 is not 
generated, just like Daniel&Richard analyzed)
2. mtd(nand)
    ubi(holds volume ubi0_0)
    ubiblock0_0

> so we need to think about either deprecating GLUEBI or setting an option in the Kconfig that ensures they are mutually exclusive.
> 
> gluebi is definitely highjacking the block device created by UBI_BLOCK and adding the MTD_UBIVOLUME flag to it.

The gluebi(mtd) and ubiblock could exist on the same UBI volume at the 
same time, but they cannot be opened at the same time. Here is an 
example I tested on the local machine:

                                              ↗ ubiblock0_0
mtd0(nandsim) -> ubi0 (holds volume ubi0_0)
                                              ↘ gluebi(mtd1)

[root@localhost ~]# ubinfo -a
UBI version:                    1
Count of UBI devices:           1
UBI control device major/minor: 10:61
Present UBI devices:            ubi0

ubi0
Volumes count:                           1
Logical eraseblock size:                 126976 bytes, 124.0 KiB
Total amount of logical eraseblocks:     8192 (1040187392 bytes, 992.0 MiB)
Amount of available logical eraseblocks: 0 (0 bytes)
Maximum count of volumes                 128
Count of bad physical eraseblocks:       0
Count of reserved physical eraseblocks:  160
Current maximum erase counter value:     2
Minimum input/output unit size:          2048 bytes
Character device major/minor:            246:0
Present volumes:                         0

Volume ID:   0 (on ubi0)
Type:        dynamic
Alignment:   1
Size:        8026 LEBs (1019109376 bytes, 971.8 MiB)
State:       OK
Name:        vol_a
Character device major/minor: 246:1
[root@localhost ~]# mtdinfo -a
Count of MTD devices:           2
Present MTD devices:            mtd0, mtd1
Sysfs interface supported:      yes

mtd0
Name:                           NAND simulator partition 0
Type:                           nand
Eraseblock size:                131072 bytes, 128.0 KiB
Amount of eraseblocks:          8192 (1073741824 bytes, 1024.0 MiB)
Minimum input/output unit size: 2048 bytes
Sub-page size:                  512 bytes
OOB size:                       64 bytes
Character device major/minor:   90:0
Bad blocks are allowed:         true
Device is writable:             true

mtd1
Name:                           vol_a
Type:                           ubi
Eraseblock size:                126976 bytes, 124.0 KiB
Amount of eraseblocks:          8026 (1019109376 bytes, 971.8 MiB)
Minimum input/output unit size: 2048 bytes
Sub-page size:                  2048 bytes
Character device major/minor:   90:2
Bad blocks are allowed:         false
Device is writable:             true

[root@localhost ~]# lsblk | grep ubi
ubiblock0_0 251:0    0 971.9M  0 disk

> 
> there is no other explanation.
> 
> looks like this was an absolutely amazing exchange that even furthered our understanding of wtf is going on.
> 
> thanks for being a great moderator for MTD rich
> 
> Thanks,
> Gagan


