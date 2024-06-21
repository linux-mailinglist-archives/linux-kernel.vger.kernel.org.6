Return-Path: <linux-kernel+bounces-223875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694E9119D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A041F22E66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579212D1EA;
	Fri, 21 Jun 2024 04:55:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27AEA4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945741; cv=none; b=saSGAdGq909ttBmd4Qz0wr3PNwq+00Aq9VWvE5VI2el8kVqFU4MjbqpvKimHt7fs2V0b6CKQ+GsczHxkOQuzjsqhPlBYJUIUd7tYoI43/sEJCOBU+zForNUYJ0QeZwJXwuEQd+ltyF4ja6qVCS5GmF5iUuwgV0HBLXTeCeorTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945741; c=relaxed/simple;
	bh=USr+jluwtxcYgL0+ww1HGRX8JzlHNQX1UAIWWsngaK0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mKnbLJbRpnfufTIuhxZsfwhKkfwyaEjtJdXZyBEfA9cOYeKm7YcVnKG5Ehh4ECufz0SjqM/NBZRuXJdxzjkb9+NWLajsegrfYfxPpW5z8GFhQj11assZc5ZXbTV6NWU0G+KVsNMLNKEmuGXTqYxFvKAkV3ghNn75o4ZKF4NB0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W54gg5ZQfz1N7wp;
	Fri, 21 Jun 2024 12:51:11 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id ED958180060;
	Fri, 21 Jun 2024 12:55:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 12:55:27 +0800
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
 <e562e94b-274d-4a82-3dad-d3e1109a2607@huawei.com>
 <7558AC97-FFFC-4593-B946-9F8FBD8D62FA@mac.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <da6f4aa8-e79d-d70a-eeb5-0068ffc1ef52@huawei.com>
Date: Fri, 21 Jun 2024 12:55:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7558AC97-FFFC-4593-B946-9F8FBD8D62FA@mac.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/6/21 12:27, Gagan Sidhu 写道:
> 
> 
>> On Jun 20, 2024, at 9:03 PM, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> 在 2024/6/21 10:09, Gagan Sidhu 写道:
>>> Thanks,
>>> Gagan
>>>> On Jun 20, 2024, at 7:59 PM, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>>>
>>>> 在 2024/6/21 6:06, Gagan Sidhu 写道:
>>>>> hi zhihao,
>>>>> so i assume my crude paraphrase is correct? that i may have unintentionally pointed the finger at you, but the real issue is GLUEBI existing with BLOCK on the same volume?
>>>>
>>>> Uhhh, I don't think I mean this. We will make it clear after getting the layers' information about your device.
>>>> Everything goes well from you guys talking, this patch did reject the mtdblock loading from a gluebi device, which may lead booting failed if your rootfs depends on a mtdblock(which is generated from the gluebi device).
>>>>  From your description 'spoke to a user, gave him a build without MTD_GLUEBI, restoring changes made by (HAHAHA you are! huawei), it booted fine'. One thing I'm curious about, if the device boots from the mtdblock(which is generated from gluebi device), the gluebi device won't be generated because you have turned off the CONFIG_MTD_UBI_GLUEBI, then the device boots successfully, which means that your rootfs is most likely loaded from ubiblock0_0. My questions are:
>>>> Q1. According to previous talking, the booting configuration is
>>>> https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, why the device could boot from ubiblock0_0?(it looks like that the device uses config from https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.patch;h=266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=HEAD [pointed by Richard]). I'm unfamilar with openwrt(Maybe you and Daniel know much), is that possible the device could automatically choose boot device in the openwrt framework?
>>> yes, that patch will, effectively, allow an “autoselect” of the ubi partition because it looks for the string “rootfs” in the ubi-formatted file.
>>> once it finds the “rootfs” partition, it will rename it to “ubi” and that will be set as the boot/root partition
>>
>> Oh, maybe I know what has happened. According to the configuration of https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, openwrt decides to boot rootfs from mtdblock(which is generated from the gluebi device), because the mtd char device (which is genertated from gluebi device) is found by openwrt. However, this patch stops generating mtdblock from gluebi device, so the mounting failed by missed mtdblock. After disabling the CONFIG_MTD_UBI_GLUEBI, the gluebi device is not generated, so openwrt decides to boot rootfs from ubiblock0_0, then your device booted successfully.
>> The key is the rootfs device judgement in openwrt, openwrt chooses the rootfs device according to the existence of mtd char device, openwrt not check whether the corresponding mtdblock exists before mouting it. Should openwrt check the existence of mtdblock beforing using it? Or maybe openwrt could turn to use ubiblock if the mtdblock device is not found?
> 
> as i understand it, the openwrt patch requires the mtdblock device to exist before finding it. it does not rely on gluebi to generate anything.

Yes, openwrt knows nothing under the mtd layer(Whatever the mtd is 
generated by a gluebi device or the mtd is a real physical nand flash). 
I mean, the layers' inforamtion on your device could be(The squashfs 
image is stored in UBI volume ubi0_0.):

                                       ↗ ubiblock0_0
mtdX(nand) -> UBI(holds volume ubi0_0)
                                       ↘ mtd12(gluebi) -> mtdblock12

The openwrt only sees ubiblock0_0, mtd12 and mtdblock12(The ubi0_0 and 
gluebi are not awared by openwrt). The openwrt detects that mtd12 has 
label 'linux,rootfs' in device tree, so it tries mouting mtdblock12 
without checking the existence of mtdblock12.
Could that be possible?

> 
> the mtd char device is not generated from gluebi. openwrt does not use gluebi at all. i was just being paranoid and had too many options enabled.
> 	-however, my paranoia has illuminated an issue with regards to GLUEBI and UBI_BLOCK’s coexistence.
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-5.15/400-mtd-mtdsplit-support.patch;h=46ef15d127dfb686e4458fd5838c3eaec8aa2cd7;hb=HEAD
> 
> openwrt relies on device tree, in this case with attribute “fixed-partition” and additional parameter
> openwrt’s split_rootfs_dev merely requires a partition with the label rootfs to be used, and it will automatically create the rootfs (if the splitting criteria) are satisfied.
> 
> split_rootfs_dev requires, as a prerequisite, that there is a partition on the flash that can be “split”. after that, it will rely on ubi to create rootfs for boot.
> 	-i’m a little lazy right now on explaining the details, but trust me it doesn’t need gluebi to create the block device.
> 
> 



