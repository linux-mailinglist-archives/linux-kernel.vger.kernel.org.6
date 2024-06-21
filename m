Return-Path: <linux-kernel+bounces-223827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57839118E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D0A1C21926
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F784E0B;
	Fri, 21 Jun 2024 03:03:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437323207
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939013; cv=none; b=SZW45YAQR+9KdU6H/BCHmAiFHjwfbC0dtlNElROdnBJMfyr2SIfBtWnbsLKZ+Zn5uf+47r0xA1pA2hzRNXXYeBOtli+X9ae1L+vVnXv2jq5iD7GRjB9gd6czRP+XrZOTVeQzaXwW1JsRQtE0ytT9GvpQS80Hpc/A0fkmu4yOMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939013; c=relaxed/simple;
	bh=557A8fUBf3pRpj4bhjFgagyqsgqiFDCqC7dJY1304DY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WEFD4S7eeFhEUX7VSjZkCHxletcI3Uf+pKiCteqBsAFwjn+ZF7mvtdN9ijtZ3I+Y8Pzb+4+paRyYJBDNitb5IPUjQgl13VnhoYVA3y7oc++UQfdQh2zBMK6/VyRZlowhQA5sKmXB8ZKHt2xwjVn93igeXvCuJPMyewUWNCBSArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W529d3R2FzVm4c;
	Fri, 21 Jun 2024 10:58:29 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 70EE118006E;
	Fri, 21 Jun 2024 11:03:26 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 11:03:25 +0800
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To: Gagan Sidhu <broly@mac.com>
CC: Daniel Golle <daniel@makrotopia.org>, Richard Weinberger <richard@nod.at>,
	ZhaoLong Wang <wangzhaolong1@huawei.com>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, yangerkun <yangerkun@huawei.com>, yi zhang
	<yi.zhang@huawei.com>
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
 <251ae039-9f46-081b-a7ee-fe47de268865@huawei.com>
 <EFEC7C06-A3B2-46D6-99F4-ADA7F7199188@mac.com>
 <45d2ef27-95cc-16c4-8b0a-4413421d785b@huawei.com>
 <772249DB-434C-4AB9-AE6B-1CB684E1E11A@mac.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e562e94b-274d-4a82-3dad-d3e1109a2607@huawei.com>
Date: Fri, 21 Jun 2024 11:03:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <772249DB-434C-4AB9-AE6B-1CB684E1E11A@mac.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/6/21 10:09, Gagan Sidhu 写道:
> 
> Thanks,
> Gagan
> 
>> On Jun 20, 2024, at 7:59 PM, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> 在 2024/6/21 6:06, Gagan Sidhu 写道:
>>> hi zhihao,
>>> so i assume my crude paraphrase is correct? that i may have unintentionally pointed the finger at you, but the real issue is GLUEBI existing with BLOCK on the same volume?
>>
>> Uhhh, I don't think I mean this. We will make it clear after getting the layers' information about your device.
>> Everything goes well from you guys talking, this patch did reject the mtdblock loading from a gluebi device, which may lead booting failed if your rootfs depends on a mtdblock(which is generated from the gluebi device).
>>  From your description 'spoke to a user, gave him a build without MTD_GLUEBI, restoring changes made by (HAHAHA you are! huawei), it booted fine'. One thing I'm curious about, if the device boots from the mtdblock(which is generated from gluebi device), the gluebi device won't be generated because you have turned off the CONFIG_MTD_UBI_GLUEBI, then the device boots successfully, which means that your rootfs is most likely loaded from ubiblock0_0. My questions are:
>> Q1. According to previous talking, the booting configuration is
>> https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, why the device could boot from ubiblock0_0?(it looks like that the device uses config from https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.patch;h=266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=HEAD [pointed by Richard]). I'm unfamilar with openwrt(Maybe you and Daniel know much), is that possible the device could automatically choose boot device in the openwrt framework?
> yes, that patch will, effectively, allow an “autoselect” of the ubi partition because it looks for the string “rootfs” in the ubi-formatted file.
> once it finds the “rootfs” partition, it will rename it to “ubi” and that will be set as the boot/root partition

Oh, maybe I know what has happened. According to the configuration of 
https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, 
openwrt decides to boot rootfs from mtdblock(which is generated from the 
gluebi device), because the mtd char device (which is genertated from 
gluebi device) is found by openwrt. However, this patch stops generating 
mtdblock from gluebi device, so the mounting failed by missed mtdblock. 
After disabling the CONFIG_MTD_UBI_GLUEBI, the gluebi device is not 
generated, so openwrt decides to boot rootfs from ubiblock0_0, then your 
device booted successfully.
The key is the rootfs device judgement in openwrt, openwrt chooses the 
rootfs device according to the existence of mtd char device, openwrt not 
check whether the corresponding mtdblock exists before mouting it. 
Should openwrt check the existence of mtdblock beforing using it? Or 
maybe openwrt could turn to use ubiblock if the mtdblock device is not 
found?
> 
>> Q2. Take a step back, if the gluebi device and ubiblock are generated from the same UBI volume, there will be error message like 'cannot open device %d, volume %d, error -16' if we open gluebi device and ubiblock at the same time, but I cannot find the error message from the log.
> it’s in  the very first email about this topic. i posted a full bootlog. look there, it will show you that’s what happened,  but i think it said error -6 not -16
> [    6.282125] VFS: Cannot open root device "(null)" or unknown-block(31,12): error -6
> 
> 
>> Q3. If the Q1's answer is 'yes', which means that your device could automatically choose to boot rootfs from ubiblock0_0 when it cannot dectect a mtdblock(which is generated from the gluebi device), why it can fail booting before reverting this patch? I mean, the mtdblock won't be generated before reverting this patch, the device should automatically choose to boot rootfs from ubiblock0_0, but it does not, and the error message in
> because it seems to have to do with gluebi and ubi_block doing something to the same partition.
> 
> config_mtd_ubi_block is not dependent on config_mtd_ubi_gluebi. i was confused about this too. i thought since both are about block devices, there is a dependency, but there isn’t.
> 
> effectively config_mtd_ubi_block can work without config_mtd_ubi_gluebi, but it’s only for read-only filesystems (like squashfs, which is what i’m using)
> 
>> Q2 is not shown in your log.
> 
> first email. it’s there.
>>
>> So, we will answer above questions if we have the layers' information about your device('mtdinfo -a' and 'ubinfo -a' after booting the device). There are two situations:
>> 1. the layers' information after reverting this patch
>> 2. the layers' information after disable CONFIG_MTD_UBI_GLUEBI
>>
> i personally think there’s some kind of interplay between CONFIG_MTD_UBI_GLUEBI and CONFIG_MTD_UBI_BLOCK. it seemed to me that gluebi re-labeled the UBI_BLOCK partition, or added the MTD_UBIVOLUME flag when it did not need to.
> 
> i think your question is more applicable outside of the read-only file systems situation. in my specific case, CONFIG_MTD_UBI_BLOCK suffices because of the niche filesystem i am using (squashfs, read only). i think if it was something else (like jffs2, or i am writing to this partition), then your question becomes more relevant.
> 
> i suspect you’ll do some thorough evaluation and provide us some much-appreciated insight, because i cannot how CONFIG_MTD_UBI_BLOCK enabled and CONFIG_MTD_UBI_GLUEBI disabled worked.
> 
>>> i was just joking about you being a spy by the way. it was post-fix euphoria ;)
>>
>> It's nothing, I knew your are not serious.
>>> master rich, shepherd weinberger, what say ye?
>>> your wisdom and insight would be greatly appreciated as closure and maybe even a patch to reflect the beauty of collaborating over current ;)
>>> Thanks,
>>> Gagan
>>>> On Jun 17, 2024, at 10:03 PM, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>>>
>>>> 在 2024/6/18 6:13, Gagan Sidhu 写道:
>>>> Hi,
>>>>> spoke to a user, gave him a build without MTD_GLUEBI, restoring changes made by (HAHAHA you are! huawei), it booted fine.
>>>>
>>>> May I have the layers' information about mtd/ubi, you can get it by 'mtdinfo -a' and 'ubinfo -a' after booting the device.
>>>> I guess your device boots from ubiblock0_0. There are two ways loading booting device:
>>>> 1. mtd(nand)
>>>>    ubi(holds volume ubi0_0)
>>>>    mtd12 (gluebi)
>>>>    mtdblock12  (This way is cut by this patch, so mtdblock12 is not generated, just like Daniel&Richard analyzed)
>>>> 2. mtd(nand)
>>>>    ubi(holds volume ubi0_0)
>>>>    ubiblock0_0
>>>>
>>>>> so we need to think about either deprecating GLUEBI or setting an option in the Kconfig that ensures they are mutually exclusive.
>>>>> gluebi is definitely highjacking the block device created by UBI_BLOCK and adding the MTD_UBIVOLUME flag to it.
>>>>
>>>> The gluebi(mtd) and ubiblock could exist on the same UBI volume at the same time, but they cannot be opened at the same time. Here is an example I tested on the local machine:
>>>>
>>>>                                              ↗ ubiblock0_0
>>>> mtd0(nandsim) -> ubi0 (holds volume ubi0_0)
>>>>                                              ↘ gluebi(mtd1)
>>>>
>>>> [root@localhost ~]# ubinfo -a
>>>> UBI version:                    1
>>>> Count of UBI devices:           1
>>>> UBI control device major/minor: 10:61
>>>> Present UBI devices:            ubi0
>>>>
>>>> ubi0
>>>> Volumes count:                           1
>>>> Logical eraseblock size:                 126976 bytes, 124.0 KiB
>>>> Total amount of logical eraseblocks:     8192 (1040187392 bytes, 992.0 MiB)
>>>> Amount of available logical eraseblocks: 0 (0 bytes)
>>>> Maximum count of volumes                 128
>>>> Count of bad physical eraseblocks:       0
>>>> Count of reserved physical eraseblocks:  160
>>>> Current maximum erase counter value:     2
>>>> Minimum input/output unit size:          2048 bytes
>>>> Character device major/minor:            246:0
>>>> Present volumes:                         0
>>>>
>>>> Volume ID:   0 (on ubi0)
>>>> Type:        dynamic
>>>> Alignment:   1
>>>> Size:        8026 LEBs (1019109376 bytes, 971.8 MiB)
>>>> State:       OK
>>>> Name:        vol_a
>>>> Character device major/minor: 246:1
>>>> [root@localhost ~]# mtdinfo -a
>>>> Count of MTD devices:           2
>>>> Present MTD devices:            mtd0, mtd1
>>>> Sysfs interface supported:      yes
>>>>
>>>> mtd0
>>>> Name:                           NAND simulator partition 0
>>>> Type:                           nand
>>>> Eraseblock size:                131072 bytes, 128.0 KiB
>>>> Amount of eraseblocks:          8192 (1073741824 bytes, 1024.0 MiB)
>>>> Minimum input/output unit size: 2048 bytes
>>>> Sub-page size:                  512 bytes
>>>> OOB size:                       64 bytes
>>>> Character device major/minor:   90:0
>>>> Bad blocks are allowed:         true
>>>> Device is writable:             true
>>>>
>>>> mtd1
>>>> Name:                           vol_a
>>>> Type:                           ubi
>>>> Eraseblock size:                126976 bytes, 124.0 KiB
>>>> Amount of eraseblocks:          8026 (1019109376 bytes, 971.8 MiB)
>>>> Minimum input/output unit size: 2048 bytes
>>>> Sub-page size:                  2048 bytes
>>>> Character device major/minor:   90:2
>>>> Bad blocks are allowed:         false
>>>> Device is writable:             true
>>>>
>>>> [root@localhost ~]# lsblk | grep ubi
>>>> ubiblock0_0 251:0    0 971.9M  0 disk
>>>>
>>>>> there is no other explanation.
>>>>> looks like this was an absolutely amazing exchange that even furthered our understanding of wtf is going on.
>>>>> thanks for being a great moderator for MTD rich
>>>>> Thanks,
>>>>> Gagan
>>>>
>>> .
>>
> 
> .
> 


