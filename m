Return-Path: <linux-kernel+bounces-223805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4912391184D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1F1283F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FED82891;
	Fri, 21 Jun 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="C5EMADND"
Received: from qs51p00im-qukt01072102.me.com (qs51p00im-qukt01072102.me.com [17.57.155.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D727E765
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935778; cv=none; b=BsG50tsiYprUd57Wyc2QghAW7eEtNxOSKKaJc1i2M7uVzgEHn6LfiSEicXQUlo1xX+y1RRIMHnjbakkWSB1YFsI7y4vj2KW7ngj4+LEBh5q+PYehLWT5i+n9Xvu3/w7DIYVK4yPArWYVjd7NjZVUW/BoROMNc885zpAn6ZiVfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935778; c=relaxed/simple;
	bh=fOrX71rNtMTDz2IaDwtoVfKNzzHNj1Q4W7txMJJxRn4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=apWQTKebwbdUna3u20J5YiYF38ArA9wu7I+FuDbmUUSfXF5lAKJbGjWMAlctXgrSle/vGWWs2Vr7RVgCIIHQo1JCQiuhZxVapTq6hiKbWUBBB+vXpFFebxZqNdridLDvmKXB9OPpjR/+5m4bAWn/U14Hh29eq6vZH8RV/wOVBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=C5EMADND; arc=none smtp.client-ip=17.57.155.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718935776; bh=eE0he76KyAk+hlTf5ijqIAg7twYKoEda5k6Mj0FMxyA=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=C5EMADNDGI3Z+2eRuamT8eMEUEFUjzhfWfHbyTukxg8srYHndVXSoUqU0n33kFJrp
	 YRsA4NPqdl9DV1jtQCFamevXzgveFP+ugjEMFE5jnuUM+S5azZx9l77jRF0tF/46Il
	 g8/JWfjVga+6SpxgcVUJZ/wSFKIyAA+lqw0coFoDX5Wlb1X8JOOPgZvUhrJiDhSas4
	 KrkQYVhjOHjigKwHun2vx6EgV+MRZV8m5gNvG8xq6UZsANUYYTDrWjc9O3gKLVJCCs
	 13qI4hxZ2XPUOTDo5Jgn3/0h5McUp1OGBwti7ldnpQQw/vnFsgd2toizJ2ylSUpCVa
	 u337WPrijXhcQ==
Received: from [172.20.144.1] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072102.me.com (Postfix) with ESMTPSA id 50EC33402C3;
	Fri, 21 Jun 2024 02:09:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
From: Gagan Sidhu <broly@mac.com>
In-Reply-To: <45d2ef27-95cc-16c4-8b0a-4413421d785b@huawei.com>
Date: Thu, 20 Jun 2024 20:09:10 -0600
Cc: Daniel Golle <daniel@makrotopia.org>,
 Richard Weinberger <richard@nod.at>,
 ZhaoLong Wang <wangzhaolong1@huawei.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 yangerkun <yangerkun@huawei.com>,
 yi zhang <yi.zhang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <772249DB-434C-4AB9-AE6B-1CB684E1E11A@mac.com>
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
To: Zhihao Cheng <chengzhihao1@huawei.com>
X-Mailer: Apple Mail (2.3445.104.21)


Thanks,
Gagan

> On Jun 20, 2024, at 7:59 PM, Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:
>=20
> =E5=9C=A8 2024/6/21 6:06, Gagan Sidhu =E5=86=99=E9=81=93:
>> hi zhihao,
>> so i assume my crude paraphrase is correct? that i may have =
unintentionally pointed the finger at you, but the real issue is GLUEBI =
existing with BLOCK on the same volume?
>=20
> Uhhh, I don't think I mean this. We will make it clear after getting =
the layers' information about your device.
> Everything goes well from you guys talking, this patch did reject the =
mtdblock loading from a gluebi device, which may lead booting failed if =
your rootfs depends on a mtdblock(which is generated from the gluebi =
device).
> =46rom your description 'spoke to a user, gave him a build without =
MTD_GLUEBI, restoring changes made by (HAHAHA you are! huawei), it =
booted fine'. One thing I'm curious about, if the device boots from the =
mtdblock(which is generated from gluebi device), the gluebi device won't =
be generated because you have turned off the CONFIG_MTD_UBI_GLUEBI, then =
the device boots successfully, which means that your rootfs is most =
likely loaded from ubiblock0_0. My questions are:
> Q1. According to previous talking, the booting configuration is
> =
https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, =
why the device could boot from ubiblock0_0?(it looks like that the =
device uses config from =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.pat=
ch;h=3D266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=3DHEAD [pointed by =
Richard]). I'm unfamilar with openwrt(Maybe you and Daniel know much), =
is that possible the device could automatically choose boot device in =
the openwrt framework?
yes, that patch will, effectively, allow an =E2=80=9Cautoselect=E2=80=9D =
of the ubi partition because it looks for the string =E2=80=9Crootfs=E2=80=
=9D in the ubi-formatted file.
once it finds the =E2=80=9Crootfs=E2=80=9D partition, it will rename it =
to =E2=80=9Cubi=E2=80=9D and that will be set as the boot/root partition

> Q2. Take a step back, if the gluebi device and ubiblock are generated =
from the same UBI volume, there will be error message like 'cannot open =
device %d, volume %d, error -16' if we open gluebi device and ubiblock =
at the same time, but I cannot find the error message from the log.
it=E2=80=99s in  the very first email about this topic. i posted a full =
bootlog. look there, it will show you that=E2=80=99s what happened,  but =
i think it said error -6 not -16
[    6.282125] VFS: Cannot open root device "(null)" or =
unknown-block(31,12): error -6


> Q3. If the Q1's answer is 'yes', which means that your device could =
automatically choose to boot rootfs from ubiblock0_0 when it cannot =
dectect a mtdblock(which is generated from the gluebi device), why it =
can fail booting before reverting this patch? I mean, the mtdblock won't =
be generated before reverting this patch, the device should =
automatically choose to boot rootfs from ubiblock0_0, but it does not, =
and the error message in=20
because it seems to have to do with gluebi and ubi_block doing something =
to the same partition.

config_mtd_ubi_block is not dependent on config_mtd_ubi_gluebi. i was =
confused about this too. i thought since both are about block devices, =
there is a dependency, but there isn=E2=80=99t.

effectively config_mtd_ubi_block can work without config_mtd_ubi_gluebi, =
but it=E2=80=99s only for read-only filesystems (like squashfs, which is =
what i=E2=80=99m using)

> Q2 is not shown in your log.

first email. it=E2=80=99s there.
>=20
> So, we will answer above questions if we have the layers' information =
about your device('mtdinfo -a' and 'ubinfo -a' after booting the =
device). There are two situations:
> 1. the layers' information after reverting this patch
> 2. the layers' information after disable CONFIG_MTD_UBI_GLUEBI
>=20
i personally think there=E2=80=99s some kind of interplay between =
CONFIG_MTD_UBI_GLUEBI and CONFIG_MTD_UBI_BLOCK. it seemed to me that =
gluebi re-labeled the UBI_BLOCK partition, or added the MTD_UBIVOLUME =
flag when it did not need to.

i think your question is more applicable outside of the read-only file =
systems situation. in my specific case, CONFIG_MTD_UBI_BLOCK suffices =
because of the niche filesystem i am using (squashfs, read only). i =
think if it was something else (like jffs2, or i am writing to this =
partition), then your question becomes more relevant.

i suspect you=E2=80=99ll do some thorough evaluation and provide us some =
much-appreciated insight, because i cannot how CONFIG_MTD_UBI_BLOCK =
enabled and CONFIG_MTD_UBI_GLUEBI disabled worked.

>> i was just joking about you being a spy by the way. it was post-fix =
euphoria ;)
>=20
> It's nothing, I knew your are not serious.
>> master rich, shepherd weinberger, what say ye?
>> your wisdom and insight would be greatly appreciated as closure and =
maybe even a patch to reflect the beauty of collaborating over current =
;)
>> Thanks,
>> Gagan
>>> On Jun 17, 2024, at 10:03 PM, Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:
>>>=20
>>> =E5=9C=A8 2024/6/18 6:13, Gagan Sidhu =E5=86=99=E9=81=93:
>>> Hi,
>>>> spoke to a user, gave him a build without MTD_GLUEBI, restoring =
changes made by (HAHAHA you are! huawei), it booted fine.
>>>=20
>>> May I have the layers' information about mtd/ubi, you can get it by =
'mtdinfo -a' and 'ubinfo -a' after booting the device.
>>> I guess your device boots from ubiblock0_0. There are two ways =
loading booting device:
>>> 1. mtd(nand)
>>>   ubi(holds volume ubi0_0)
>>>   mtd12 (gluebi)
>>>   mtdblock12  (This way is cut by this patch, so mtdblock12 is not =
generated, just like Daniel&Richard analyzed)
>>> 2. mtd(nand)
>>>   ubi(holds volume ubi0_0)
>>>   ubiblock0_0
>>>=20
>>>> so we need to think about either deprecating GLUEBI or setting an =
option in the Kconfig that ensures they are mutually exclusive.
>>>> gluebi is definitely highjacking the block device created by =
UBI_BLOCK and adding the MTD_UBIVOLUME flag to it.
>>>=20
>>> The gluebi(mtd) and ubiblock could exist on the same UBI volume at =
the same time, but they cannot be opened at the same time. Here is an =
example I tested on the local machine:
>>>=20
>>>                                             =E2=86=97 ubiblock0_0
>>> mtd0(nandsim) -> ubi0 (holds volume ubi0_0)
>>>                                             =E2=86=98 gluebi(mtd1)
>>>=20
>>> [root@localhost ~]# ubinfo -a
>>> UBI version:                    1
>>> Count of UBI devices:           1
>>> UBI control device major/minor: 10:61
>>> Present UBI devices:            ubi0
>>>=20
>>> ubi0
>>> Volumes count:                           1
>>> Logical eraseblock size:                 126976 bytes, 124.0 KiB
>>> Total amount of logical eraseblocks:     8192 (1040187392 bytes, =
992.0 MiB)
>>> Amount of available logical eraseblocks: 0 (0 bytes)
>>> Maximum count of volumes                 128
>>> Count of bad physical eraseblocks:       0
>>> Count of reserved physical eraseblocks:  160
>>> Current maximum erase counter value:     2
>>> Minimum input/output unit size:          2048 bytes
>>> Character device major/minor:            246:0
>>> Present volumes:                         0
>>>=20
>>> Volume ID:   0 (on ubi0)
>>> Type:        dynamic
>>> Alignment:   1
>>> Size:        8026 LEBs (1019109376 bytes, 971.8 MiB)
>>> State:       OK
>>> Name:        vol_a
>>> Character device major/minor: 246:1
>>> [root@localhost ~]# mtdinfo -a
>>> Count of MTD devices:           2
>>> Present MTD devices:            mtd0, mtd1
>>> Sysfs interface supported:      yes
>>>=20
>>> mtd0
>>> Name:                           NAND simulator partition 0
>>> Type:                           nand
>>> Eraseblock size:                131072 bytes, 128.0 KiB
>>> Amount of eraseblocks:          8192 (1073741824 bytes, 1024.0 MiB)
>>> Minimum input/output unit size: 2048 bytes
>>> Sub-page size:                  512 bytes
>>> OOB size:                       64 bytes
>>> Character device major/minor:   90:0
>>> Bad blocks are allowed:         true
>>> Device is writable:             true
>>>=20
>>> mtd1
>>> Name:                           vol_a
>>> Type:                           ubi
>>> Eraseblock size:                126976 bytes, 124.0 KiB
>>> Amount of eraseblocks:          8026 (1019109376 bytes, 971.8 MiB)
>>> Minimum input/output unit size: 2048 bytes
>>> Sub-page size:                  2048 bytes
>>> Character device major/minor:   90:2
>>> Bad blocks are allowed:         false
>>> Device is writable:             true
>>>=20
>>> [root@localhost ~]# lsblk | grep ubi
>>> ubiblock0_0 251:0    0 971.9M  0 disk
>>>=20
>>>> there is no other explanation.
>>>> looks like this was an absolutely amazing exchange that even =
furthered our understanding of wtf is going on.
>>>> thanks for being a great moderator for MTD rich
>>>> Thanks,
>>>> Gagan
>>>=20
>> .
>=20


