Return-Path: <linux-kernel+bounces-224541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C541E9123C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE0F28CA09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539C172799;
	Fri, 21 Jun 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="UTwiPkor"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2FEBE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969812; cv=none; b=CD2vqJbW71ErisvVKU1sU/NnBpRRIQU98j8o8cMwCBsjZsSwuB9nWcqlbyFblhnIxc+U+I3KzLZtMJAz8dHK/0hcZn4c78pCxfuVpwLhwyA8Nh3Cm7bt3AeIhFZi3y5ftn7yFAVqSQGf+giGpOYWFNWDo7ebjpsEONGRfYqYYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969812; c=relaxed/simple;
	bh=6RaiAhPPVs/dHf85TLOue4Bep8K565kekBDc2KLu22s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nN9aYM0p04lPU4Kpr/i3gZg4w4bOGbPegS8nNnsyAawVDhLHgM3HL1+RdR4Li9RW1jUkPOiQYRrkwRKwndjRmQrsYyTygW8gEm4+teuytydyblw+gCYsGBt9XBGrn7U7FjmWx8B34oOveB/Jsj2VAQfL0IkkeVorc26Z+ix9Xi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=UTwiPkor; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718969810; bh=ylpBeO/XjxteMRVJX3+KDGNAzLXrVlXfpfw5efkyM5M=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=UTwiPkorTV8JS173a2AK8sottIABJgy8M5hJoTQzfIvQ/RAgX3IXvVt94j0Cikuj0
	 9Zh0Yzp106CSKjP/V6tdZq0vk9gwTdUiSk588nchwDI/ATWBsRbIxzwGBizTorOacK
	 5NsAoECi71LsfrboDqJV++HZkk6RlTPK8mWj6+htm+Y6JAs4J8BRkcDHlt7Q+1nmoY
	 7W+Vhnyc8eYfrW/USh4TwfZZhn1BWk0xEQJT/JoK4sFsNTTTQmUua1I3gJCSE9nFKP
	 CvuERnaVUbdI58Z0N56HhBnHFIgicQzn/SqfMTqezGO5WGaTV4TIPVhh3Hw5QHeUeU
	 AeT+aVVMEX4Sg==
Received: from [192.168.1.30] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 6B7AE6802F7;
	Fri, 21 Jun 2024 11:36:43 +0000 (UTC)
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
In-Reply-To: <da6f4aa8-e79d-d70a-eeb5-0068ffc1ef52@huawei.com>
Date: Fri, 21 Jun 2024 05:36:41 -0600
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
Message-Id: <BE6684D5-1CEE-46AA-84BF-C6146667D84B@mac.com>
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
 <da6f4aa8-e79d-d70a-eeb5-0068ffc1ef52@huawei.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-ORIG-GUID: DMwOz1WGYUYgodWiLGoA52OxUglNZKaC
X-Proofpoint-GUID: DMwOz1WGYUYgodWiLGoA52OxUglNZKaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406210086


> On Jun 20, 2024, at 10:55 PM, Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:
>=20
> =E5=9C=A8 2024/6/21 12:27, Gagan Sidhu =E5=86=99=E9=81=93:
>>> On Jun 20, 2024, at 9:03 PM, Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:
>>>=20
>>> =E5=9C=A8 2024/6/21 10:09, Gagan Sidhu =E5=86=99=E9=81=93:
>>>> Thanks,
>>>> Gagan
>>>>> On Jun 20, 2024, at 7:59 PM, Zhihao Cheng =
<chengzhihao1@huawei.com> wrote:
>>>>>=20
>>>>> =E5=9C=A8 2024/6/21 6:06, Gagan Sidhu =E5=86=99=E9=81=93:
>>>>>> hi zhihao,
>>>>>> so i assume my crude paraphrase is correct? that i may have =
unintentionally pointed the finger at you, but the real issue is GLUEBI =
existing with BLOCK on the same volume?
>>>>>=20
>>>>> Uhhh, I don't think I mean this. We will make it clear after =
getting the layers' information about your device.
>>>>> Everything goes well from you guys talking, this patch did reject =
the mtdblock loading from a gluebi device, which may lead booting failed =
if your rootfs depends on a mtdblock(which is generated from the gluebi =
device).
>>>>> =46rom your description 'spoke to a user, gave him a build without =
MTD_GLUEBI, restoring changes made by (HAHAHA you are! huawei), it =
booted fine'. One thing I'm curious about, if the device boots from the =
mtdblock(which is generated from gluebi device), the gluebi device won't =
be generated because you have turned off the CONFIG_MTD_UBI_GLUEBI, then =
the device boots successfully, which means that your rootfs is most =
likely loaded from ubiblock0_0. My questions are:
>>>>> Q1. According to previous talking, the booting configuration is
>>>>> =
https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, =
why the device could boot from ubiblock0_0?(it looks like that the =
device uses config from =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.pat=
ch;h=3D266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=3DHEAD [pointed by =
Richard]). I'm unfamilar with openwrt(Maybe you and Daniel know much), =
is that possible the device could automatically choose boot device in =
the openwrt framework?
>>>> yes, that patch will, effectively, allow an =E2=80=9Cautoselect=E2=80=
=9D of the ubi partition because it looks for the string =E2=80=9Crootfs=E2=
=80=9D in the ubi-formatted file.
>>>> once it finds the =E2=80=9Crootfs=E2=80=9D partition, it will =
rename it to =E2=80=9Cubi=E2=80=9D and that will be set as the boot/root =
partition
>>>=20
>>> Oh, maybe I know what has happened. According to the configuration =
of =
https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774, =
openwrt decides to boot rootfs from mtdblock(which is generated from the =
gluebi device), because the mtd char device (which is genertated from =
gluebi device) is found by openwrt. However, this patch stops generating =
mtdblock from gluebi device, so the mounting failed by missed mtdblock. =
After disabling the CONFIG_MTD_UBI_GLUEBI, the gluebi device is not =
generated, so openwrt decides to boot rootfs from ubiblock0_0, then your =
device booted successfully.
>>> The key is the rootfs device judgement in openwrt, openwrt chooses =
the rootfs device according to the existence of mtd char device, openwrt =
not check whether the corresponding mtdblock exists before mouting it. =
Should openwrt check the existence of mtdblock beforing using it? Or =
maybe openwrt could turn to use ubiblock if the mtdblock device is not =
found?
>> as i understand it, the openwrt patch requires the mtdblock device to =
exist before finding it. it does not rely on gluebi to generate =
anything.
>=20
> Yes, openwrt knows nothing under the mtd layer(Whatever the mtd is =
generated by a gluebi device or the mtd is a real physical nand flash). =
I mean, the layers' inforamtion on your device could be(The squashfs =
image is stored in UBI volume ubi0_0.):
>=20
>                                      =E2=86=97 ubiblock0_0
> mtdX(nand) -> UBI(holds volume ubi0_0)
>                                      =E2=86=98 mtd12(gluebi) -> =
mtdblock12
>=20
> The openwrt only sees ubiblock0_0, mtd12 and mtdblock12(The ubi0_0 and =
gluebi are not awared by openwrt). The openwrt detects that mtd12 has =
label 'linux,rootfs' in device tree, so it tries mouting mtdblock12 =
without checking the existence of mtdblock12.
> Could that be possible?

just to share the relevant part of the log again:
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
[    3.995699] 0x000007b80000-0x000008000000 : "reserved"
[    4.006687] [mtk_nand] probe successfully!
```
and

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
openwrt does see ubi0_0 because it has to, in order to create =
ubiblock0_0.

regarding openwrt not checking the existence of mtdblock12: i think what =
richard said earlier was that ubiblock0_0 _is_ mtdblock12. as i =
understand it, the ubiblock0_0 is merely a convenient label for =
/dev/mtdblock12

that=E2=80=99s why i was complaining and posted the error log, because =
VFS seemed to be mounting the right partition but was failing.

i could be wrong on this, though.

>=20
>> the mtd char device is not generated from gluebi. openwrt does not =
use gluebi at all. i was just being paranoid and had too many options =
enabled.
>> 	-however, my paranoia has illuminated an issue with regards to =
GLUEBI and UBI_BLOCK=E2=80=99s coexistence.
>> =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-5.15/400-mtd-mtdsplit-support.patch;h=3D46ef15d127dfb686e=
4458fd5838c3eaec8aa2cd7;hb=3DHEAD
>> openwrt relies on device tree, in this case with attribute =
=E2=80=9Cfixed-partition=E2=80=9D and additional parameter
>> openwrt=E2=80=99s split_rootfs_dev merely requires a partition with =
the label rootfs to be used, and it will automatically create the rootfs =
(if the splitting criteria) are satisfied.
>> split_rootfs_dev requires, as a prerequisite, that there is a =
partition on the flash that can be =E2=80=9Csplit=E2=80=9D. after that, =
it will rely on ubi to create rootfs for boot.
>> 	-i=E2=80=99m a little lazy right now on explaining the details, =
but trust me it doesn=E2=80=99t need gluebi to create the block device.


