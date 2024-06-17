Return-Path: <linux-kernel+bounces-218340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7512290BCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000131F26552
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757251946D0;
	Mon, 17 Jun 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="oX0kEfeE"
Received: from qs51p00im-qukt01071501.me.com (qs51p00im-qukt01071501.me.com [17.57.155.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D915ECDB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659339; cv=none; b=JrR/kZxItmtGlXwdp6OXHnGFB7f0Kj73/mKsnls7HgtUSccsuI4jE4jus9qq9Ldl/JXpySFLLsi0tiN6a1dXmP3eoS4TQqY0IMIS7X++FK87vNeO2e7uaAmyvrCs90v0vCqq7y/oVdABDc5ScZZGu89e86VtnxnD0YznNnjNciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659339; c=relaxed/simple;
	bh=E+Bm5sOSPHSEF8+pYbaQbA8J/GmlqEfBy2/ywcC+BHE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ys1zK6bHEivpBNRjV8+GkU9sYH4bovz2hve++A4QukGTnF9FAVKy4TUm58XaWu4natJ+SWIIRjISYEM9tjzprfoW8Uv0Lb4EBcx1rja4f+mD6OtDJqKxe9FjdpLTb91iNUuTlTcyyZzasbNH1tL3as9m4jJ9v10uehHT0aIZYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=oX0kEfeE; arc=none smtp.client-ip=17.57.155.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718659336; bh=zphKwo0cedwY0LBU5x8vzx2ltgDECMtIpwscY5FyRsU=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=oX0kEfeEAS4YWcVdHr2b7kNIoOp0XGVB6QTfNgyCVH0sF1ij9bZL14Tm6p+tursoH
	 TtgHDmlgjsgzM5CmljGCBlM/29AkNUCkxg3XWEBN/fytUrzMtkMiybWapDphD0csGM
	 Tw44xegU8w7OxXrNsz1Trarb2VnZ7ZLQ0jCF3rsZoxZ4jalqLFnJXv/bN83ikfU2xx
	 7VR21fZmFDb7hNFFA6rEzxGs1GOvR4Kuko1B+Z4bbHyknMs6V7AHO1celKoBCv6gG0
	 8rF6gJZML0SkJMIHHqwQitJsW7mdsUJ9Bozel489tFH8z6tX6ZJ/SgfOoZeXsjztt7
	 QAwZy92NV01ZQ==
Received: from [172.20.144.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071501.me.com (Postfix) with ESMTPSA id 2C6B01C401C8;
	Mon, 17 Jun 2024 21:22:07 +0000 (UTC)
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
In-Reply-To: <ZnCcsPA-flVcxiAT@makrotopia.org>
Date: Mon, 17 Jun 2024 15:22:03 -0600
Cc: Richard Weinberger <richard@nod.at>,
 ZhaoLong Wang <wangzhaolong1@huawei.com>,
 chengzhihao1 <chengzhihao1@huawei.com>,
 dpervushin <dpervushin@embeddedalley.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 yangerkun <yangerkun@huawei.com>,
 yi zhang <yi.zhang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C20708FB-0626-475E-A996-DE42ACF57A8B@mac.com>
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
To: Daniel Golle <daniel@makrotopia.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-ORIG-GUID: 42_gNPI27HtsYQpfWBA8YSGM4DBwc0wO
X-Proofpoint-GUID: 42_gNPI27HtsYQpfWBA8YSGM4DBwc0wO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 clxscore=1011
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406130160

hi daniel,

most of your understanding is correct, but i am using a device tree. i =
will answer in-line

Thanks,
Gagan

> On Jun 17, 2024, at 2:29 PM, Daniel Golle <daniel@makrotopia.org> =
wrote:
>=20
> Hi Richard,
>=20
> On Mon, Jun 17, 2024 at 08:52:55PM +0200, Richard Weinberger wrote:
>> [CC'ing Daniel]
>>=20
>> ----- Urspr=C3=BCngliche Mail -----
>>> Von: "Gagan Sidhu" <broly@mac.com>
>>> An: "richard" <richard@nod.at>
>>> CC: "ZhaoLong Wang" <wangzhaolong1@huawei.com>, "chengzhihao1" =
<chengzhihao1@huawei.com>, "dpervushin"
>>> <dpervushin@embeddedalley.com>, "linux-kernel" =
<linux-kernel@vger.kernel.org>, "linux-mtd"
>>> <linux-mtd@lists.infradead.org>, "Miquel Raynal" =
<miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
>>> "yangerkun" <yangerkun@huawei.com>, "yi zhang" <yi.zhang@huawei.com>
>>> Gesendet: Montag, 17. Juni 2024 20:46:10
>>> Betreff: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference =
caused by ftl notifier
>>=20
>>>> On Jun 17, 2024, at 12:32 PM, Richard Weinberger <richard@nod.at> =
wrote:
>>>>=20
>>>> ----- Urspr=C3=BCngliche Mail -----
>>>>> Von: "Gagan Sidhu" <broly@mac.com>
>>>>>> AFAICT, this log line is not part of the mainline kernel.
>>>>>=20
>>>>> this is mainline. it=E2=80=99s just not 6.x. it=E2=80=99s 4.14.
>>>>=20
>>>> I've double checked and disagree.
>>>> This line comes from:
>>>> =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-4.14/480-mtd-set-rootfs-to-be-root-dev.patch;h=3D6cddaf01=
b75cb58cfb377f568f2c375af87e2f1b;hb=3Dc3bd1321de1e0d814f5cfc4f494f6b2fb1f5=
133b
>>>=20
>>> no i know that, that=E2=80=99s the patch i showed you. i meant the =
rest of it is
>>> mainline. the patch obviously is not.
>>>>=20
>>>> In recent OpenWRT kernels I see:
>>>> =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.pat=
ch;h=3D266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=3DHEAD
>>>>=20
>>>> Looks like in recent versions the patch in question does *not* =
cause a
>>>> regression.
>>>=20
>>> that patch is also applied in my version as well, so i don=E2=80=99t =
see how this avoids
>>> the regression.
>>>=20
>>> =
https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774
>>>=20
>>> mine says "[6.051426] mtd: device 12 (rootfs) set to be root =
filesystem"
>>>=20
>>> which is simply the call from drivers/mtd/mtdcore.c
>>>=20
>>> so the rootfs device is set correctly. it=E2=80=99s just not booting =
from it.
>>>=20
>>> the regression comes from having GLUEBI+BLOCK enabled, it seems, are =
they
>>> fighting for/operating on the same partition?
>>=20
>> I don't know. Let's ask Daniel.
>=20
> I've tried to follow up with this thread and to understand what this =
is all
> about.
>=20
> Let me add a few things:
>=20
> * In OpenWrt we are trying to get rid of the downstream patches
>   mentioned here. They were introduced at a time when we did not have
>   Device Tree and hence no option to use kernel cmdline to attach UBI,
>   or use root=3D parameter. Nowadays they are legacy and we should not
>   use the various auto-rootfs hacks in favor of doing the same thing
>   using /chosen/bootargs in DT and the like.
>=20
> * Shortly after the introduction of ubiblock we happily got rid of =
gluebi.
>   In OpenWrt gluebi has not been enabled for a very long time, and
>   hence I can tell little about potential problems it may cause, or at
>   least I can't do more than anyone else can which is reading the code
>   and the logs supplied by the user.
>=20
> All that being said there are of course cases where one may simply
> require to use a very old kernel (4.14 here) in order to be able to =
run
> proprietary out-of-tree drivers (rt2860 wifi here). And, of course, if
> you can compile a kernel with gluebi and ubiblock both enabled, then
> that should work as well and not result in either of them going south.
>=20
> So reading the logs I do understand what has happened:
> Note that the error for unknown-block(31,12) is ENXIO ("No such device
> or address"), and that makes sense as that mtdblock12 device indeed
> doesn't exist:
>=20
>> [    6.457518] 1f0b            4608 mtdblock11
>> [    6.457523]  (driver?)
>> [    6.470720] fe00           33604 ubiblock0_0
>> [    6.470724]  (driver?)
>=20
> And yes, that's due to the added tests for mtd->type !=3D =
MTD_UBIVOLUME
> which prevent mtdblock from being created for gluebi devices.
>=20
> I understand that the board depends on OpenWrt's patches, as back in =
the
> days of Linux 4.14 MT7621 was still using platform C code for each =
board
> and there was no way to set, append or replace bootargs from DT, =
simply
> because there isn't DT.

i am using the DT that is very similar to this one:
=
https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/dts/mt7=
621_dlink_dir_nand_128m.dtsi

as in, the mtd layout you=E2=80=99re seeing in the boot logs is fixed =
partitions:
```
[    3.188484] 9 fixed-partitions partitions found on MTD device =
MT7621-NAND
[    3.202005] Creating 9 MTD partitions on "MT7621-NAND":
[    3.212430] 0x000000000000-0x000000080000 : "Bootloader"
[    3.224024] 0x0000000c0000-0x000000100000 : "Config"
[    3.234684] 0x000000100000-0x000000140000 : "Factory"
[    3.245518] 0x000000140000-0x000000180000 : "Config2"
[    3.256379] 0x000000180000-0x000002d80000 : "sysv"
[    3.895176] 1 squashfs-split partitions found on MTD device sysv
[    3.907164] 0x0000005c1000-0x000002d60000 : "ddwrt"
[    3.920925] 2 uimage-fw partitions found on MTD device sysv
[    3.932031] Creating 2 MTD partitions on "sysv":
[    3.941232] 0x000000000000-0x000000400000 : "kernel"
[    3.951995] 0x000000400000-0x000002c00000 : "ubi"
[    3.962325] 0x000002d80000-0x000004d80000 : "private"
[    3.973322] 0x000004d80000-0x000007580000 : "firmware2"
[    3.984759] 0x000007580000-0x000007b80000 : "mydlink"
[    3.995699] 0x000007b80000-0x000008000000 : =E2=80=9Creserved=E2=80=9D
[    4.006687] [mtk_nand] probe successfully!
[    4.015584] Signature matched and data read!
[    4.024090] load_fact_bbt success 1023

```
here is the rest of the log that richard & i are honing in upon:

```
[    5.462504] auto-attach mtd7
[    5.462525] ubi0: default fastmap pool size: 15
[    5.477309] ubi0: default fastmap WL pool size: 7
[    5.486683] ubi0: attaching mtd7
[    5.811240] UBI: EOF marker found, PEBs from 273 will be erased
[    5.811299] ubi0: scanning is finished
[    5.874546] gluebi (pid 1): gluebi_resized: got update notification =
for unknown UBI device 0 volume 1
[    5.892927] ubi0: volume 1 ("rootfs_data") re-sized from 9 to 28 LEBs
[    5.906683] ubi0: attached mtd7 (name "ubi", size 40 MiB)
[    5.917446] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 =
bytes
[    5.931132] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size =
2048
[    5.944654] ubi0: VID header offset: 2048 (aligned 2048), data =
offset: 4096
[    5.958513] ubi0: good PEBs: 320, bad PEBs: 0, corrupted PEBs: 0
[    5.970472] ubi0: user volume: 2, internal volumes: 1, max. volumes =
count: 128
[    5.984859] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, =
image sequence number: 1613475955
[    6.003045] ubi0: available PEBs: 0, total reserved PEBs: 320, PEBs =
reserved for bad PEB handling: 15
[    6.021426] rootfs: parsing partitions cmdlinepart
[    6.021444] ubi0: background thread "ubi_bgt0d" started, PID 97
[    6.043694] rootfs: got parser (null)
[    6.051426] mtd: device 12 (rootfs) set to be root filesystem
[    6.062891] rootfs_data: parsing partitions cmdlinepart
[    6.073669] rootfs_data: got parser (null)
[    6.211240] block ubiblock0_0: created from ubi0:0(rootfs)
[    6.259545] rtc-pcf8563 0-0051: hctosys: unable to read the hardware =
clock
[    6.282125] VFS: Cannot open root device "(null)" or =
unknown-block(31,12): error -6
[    6.297406] Please append a correct "root=3D" boot option; here are =
the available partitions:
[    6.314054] 1f00             512 mtdblock0
[    6.314060]  (driver?)
[    6.327077] 1f01             256 mtdblock1
[    6.327081]  (driver?)
[    6.340101] 1f02             256 mtdblock2
[    6.340105]  (driver?)
[    6.353124] 1f03             256 mtdblock3
[    6.353129]  (driver?)
[    6.366153] 1f04           45056 mtdblock4
[    6.366158]  (driver?)
[    6.379175] 1f05           40572 mtdblock5
[    6.379179]  (driver?)
[    6.392217] 1f06            4096 mtdblock6
[    6.392222]  (driver?)
[    6.405240] 1f07           40960 mtdblock7
[    6.405244]  (driver?)
[    6.418272] 1f08           32768 mtdblock8
[    6.418277]  (driver?)
[    6.431296] 1f09           40960 mtdblock9
[    6.431300]  (driver?)
[    6.444324] 1f0a            6144 mtdblock10
[    6.444328]  (driver?)
[    6.457518] 1f0b            4608 mtdblock11
[    6.457523]  (driver?)
[    6.470720] fe00           33604 ubiblock0_0
[    6.470724]  (driver?)
[    6.484090] Kernel panic - not syncing: VFS: Unable to mount root fs =
on unknown-block(31,12)

```

>=20
> As at the time also ubiblock wasn't used and also most likely won't =
work
> with that semi-proprietary firmware based Linux 4.14 which expects =
JFFS2
> to be used, my suggestion is to disabled CONFIG_FTL (if it isn't =
already
> disabled anyway) and apply this patch (which should be further
> discussed) in order to fix commit ("mtd: Fix gluebi NULL pointer
> dereference caused by ftl notifier=E2=80=9D):

i=E2=80=99m not using JFFS2, either.

my question is about the interaction between GLUEBI and UBI_BLOCK.

it seems to me that the device is created by UBI_BLOCK, so that=E2=80=99s =
fine.

the question is: is there interaction between GLUEBI and UBI_BLOCK?

i don=E2=80=99t understand how, if the device is created by UBI_BLOCK, =
that it could get the MTD_UBIVOLUME tag unless GLUEBI scanned the MTD =
volumes and found the block device created by UBI Block, and decided =
that it should have this tag.

there is something wrong here. as richard said: if the ubiblock0_0 =
device is created by ubi_block as is shown above:

[    6.211240] block ubiblock0_0: created from ubi0:0(rootfs)

then how the heck is this device not getting mounted after boot? the =
only explanation is that GLUEBI is interfering and doesn=E2=80=99t =
realise the UBI_BLOCK device should not be tagged.

i would test this myself but i don=E2=80=99t have this router on me and =
i don=E2=80=99t want to make a user flash their router a few times for =
me to figure this out. they=E2=80=99ve been through enough with this =
whole ordeal (lol).

>=20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 3caa0717d46c..3ef57dd56288 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -461,7 +461,7 @@ static void blktrans_notify_add(struct mtd_info =
*mtd)
> {
> 	struct mtd_blktrans_ops *tr;
>=20
> -	if (mtd->type =3D=3D MTD_ABSENT || mtd->type =3D=3D =
MTD_UBIVOLUME)
> +	if (mtd->type =3D=3D MTD_ABSENT || (IS_ENABLED(CONFIG_FTL) && =
mtd->type =3D=3D MTD_UBIVOLUME))
> 		return;
>=20
> 	list_for_each_entry(tr, &blktrans_majors, list)
> @@ -501,7 +501,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops =
*tr)
> 	mutex_lock(&mtd_table_mutex);
> 	list_add(&tr->list, &blktrans_majors);
> 	mtd_for_each_device(mtd)
> -		if (mtd->type !=3D MTD_ABSENT && mtd->type !=3D =
MTD_UBIVOLUME)
> +		if (mtd->type !=3D MTD_ABSENT && (!IS_ENABLED(CONFIG_FTL =
|| mtd->type !=3D MTD_UBIVOLUME)))
> 			tr->add_mtd(tr, mtd);
> 	mutex_unlock(&mtd_table_mutex);
> 	return 0;
>=20
>=20
> Let me know if that helps and lets discuss if it could be considered =
for
> being applied in upstream Linux.

we could do that, but i think we need to find out whether GLUEBI is =
taking our UBI_BLOCK device and doing something it shouldn=E2=80=99t be =
doing.

>=20
>>=20
>>>=20
>>>>=20
>>>>>> (31, 12) would be mtdblock12.
>>>>>> How does your kernel know that mtdblock12 shall be the rootfs?
>>>>>=20
>>>>> this is an openwrt approach: =
https://openwrt.org/docs/techref/filesystems (under
>>>>> =E2=80=9Ctechnical details=E2=80=9D, third paragraph)
>>>>>=20
>>>>> essentially there=E2=80=99s a feature they add to the kernel (via =
patch) where you can
>>>>> enable a feature that sets the root device based on the name of =
the partition.
>>>>=20
>>>> So, this is all not mainline. :-/
>>>=20
>>> i did say openwrt at the start, and i think that=E2=80=99s pretty =
close to mainline as
>>> it gets.
>>>=20
>>> sometimes these patches aren=E2=80=99t appropriate to push upstream. =
this one is not the
>>> one causing the issue.
>>>=20
>>> it seems to me that there is a problem with GLUEBI+BLOCK playing =
together.
>>>=20
>>> as far as i can see, the setting of the device is being doing by =
mtdcore.c
>>>=20
>>> it=E2=80=99s just not working with gluebi and block are enabled, and =
i need to know
>>> whether disabling gluebi will allow it to work.
>>>=20
>>> in other words, is it possible for gluebi to use the partition =
created by
>>> ubi_block, and add the MTD_UBIVOLUME flag?
>>=20
>> No. UBIBlock works on top of UBI volumes and creates a block device.
>>=20
>> We'll sort this out. :)
>>=20
>> Thanks,
>> //richard
>>=20
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/


