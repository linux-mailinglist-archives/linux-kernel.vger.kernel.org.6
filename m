Return-Path: <linux-kernel+bounces-218124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403AC90B98A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A1B28AF19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7419AA78;
	Mon, 17 Jun 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="N7ux4WrZ"
Received: from qs51p00im-qukt01072301.me.com (qs51p00im-qukt01072301.me.com [17.57.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71219AA5C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648310; cv=none; b=N5vNh0wkShXY5QL3HaCVCEhbeuV7Omg6lgVK1oJNO6JwfTfPweWtY1D155UpPHhZxQpw3CxD9vKIddH9cRYnqdJGe0YWPrdbrqJWIiBK1pqq/06SskXFbXodo2c0NGV0v70KgEnD2RGwDAuWdRbF+JeS6a+i4vYg39chfS2vXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648310; c=relaxed/simple;
	bh=4Gu1fbPocltXlsofi4VIKRS13wZx09T4hCqNeHvSNKo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jDyI6yEETRFh1EYh1tECW8uDG83QDxkrE2oOdAWAkNf6SiY7z7Yjb/rsoxfvOdP7BBgUsTrffclWKj4W0pRhreQF+u8USFTZZ6yM7DMoAYQaw9TeXwwckl6lPsPP3q3apoNVzq68n6n4/cxDn7MRjuKHKs85+gWuTczsqrIxHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=N7ux4WrZ; arc=none smtp.client-ip=17.57.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718648307; bh=zl4ADSYUfA5+v6Sbvl/cQPRda8ieZo/JDRv9TvRws+s=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=N7ux4WrZMBpUHSnOXOCqHmxOGr3jGGkN4+sVBWIamX1nj4N+tWqQHd8YECWxnpZXZ
	 a+ZluKA5mEUDV9V8aoeYzpjWWY/xKNtWTL0HwAauwBPWABfact+3S4VQN/iIaqyjI9
	 wYYquDvPghNAgI9ifaRaL/sqsjWy+4yOvUyU1JgtUgwcCzObtygho+YnpMlP7VtppD
	 5+AsaSKZf0d+yzVYZPq+1o0GFBNvCmUbk2rDrO8UGvxR3Q3rgzzEZl/ReMLkKAfSZk
	 uSc1tOl8WkJrfKZy0rD0ZHh1LFQhAMMDx4GuYr/JtCN7yCXw7q5kpskq/I8wQMDEuw
	 5f+KINf/HhSSQ==
Received: from [172.20.144.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id 0675E2540152;
	Mon, 17 Jun 2024 18:18:21 +0000 (UTC)
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
In-Reply-To: <303502000.252057.1718647746641.JavaMail.zimbra@nod.at>
Date: Mon, 17 Jun 2024 12:18:18 -0600
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>,
 chengzhihao1 <chengzhihao1@huawei.com>,
 dpervushin <dpervushin@embeddedalley.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 yangerkun <yangerkun@huawei.com>,
 yi zhang <yi.zhang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
 <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com>
 <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at>
 <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com>
 <1802911356.251780.1718643160760.JavaMail.zimbra@nod.at>
 <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com>
 <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com>
 <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
 <303502000.252057.1718647746641.JavaMail.zimbra@nod.at>
To: Richard Weinberger <richard@nod.at>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-GUID: qvV_8sI9K2MF_V5cNH9ppsjRRpV4aTwc
X-Proofpoint-ORIG-GUID: qvV_8sI9K2MF_V5cNH9ppsjRRpV4aTwc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406170142



> On Jun 17, 2024, at 12:09 PM, Richard Weinberger <richard@nod.at> =
wrote:
>=20
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Gagan Sidhu" <broly@mac.com>
>> =
https://github.com/torvalds/linux/blob/master/drivers/mtd/ubi/gluebi.c#L29=
7
>>=20
>> it seems the GLUEBI is setting the mtd to MTD_UBIVOLUME
>>=20
>> https://github.com/torvalds/linux/blob/master/drivers/mtd/ubi/block.c
>>=20
>> where this doesn=E2=80=99t even have the text =E2=80=9Cmtd=E2=80=9D =
anywhere.
>>=20
>> but the boot partition is always the ubiblock device.
>>=20
>> so is gluebi taking the same volume and adding the MTD_UBIVOLUME =
label or
>> something?
>=20
> Yes, GLUEBI emulates a MTD on top of an UBI volume.
> It sets the MTD device type to MTD_UBIVOLUME.
>=20
>>>=20
>>> [    5.462504] auto-attach mtd7
>>> [    5.462525] ubi0: default fastmap pool size: 15
>>> [    5.477309] ubi0: default fastmap WL pool size: 7
>>> [    5.486683] ubi0: attaching mtd7
>>> [    5.811240] UBI: EOF marker found, PEBs from 273 will be erased
>>> [    5.811299] ubi0: scanning is finished
>>> [    5.874546] gluebi (pid 1): gluebi_resized: got update =
notification for
>>> unknown UBI device 0 volume 1
>>> [    5.892927] ubi0: volume 1 ("rootfs_data") re-sized from 9 to 28 =
LEBs
>>> [    5.906683] ubi0: attached mtd7 (name "ubi", size 40 MiB)
>>> [    5.917446] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: =
126976 bytes
>>> [    5.931132] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page =
size 2048
>>> [    5.944654] ubi0: VID header offset: 2048 (aligned 2048), data =
offset: 4096
>>> [    5.958513] ubi0: good PEBs: 320, bad PEBs: 0, corrupted PEBs: 0
>>> [    5.970472] ubi0: user volume: 2, internal volumes: 1, max. =
volumes count:
>>> 128
>>> [    5.984859] ubi0: max/mean erase counter: 1/0, WL threshold: =
4096, image
>>> sequence number: 1613475955
>>> [    6.003045] ubi0: available PEBs: 0, total reserved PEBs: 320, =
PEBs reserved
>>> for bad PEB handling: 15
>>> [    6.021426] rootfs: parsing partitions cmdlinepart
>>> [    6.021444] ubi0: background thread "ubi_bgt0d" started, PID 97
>>> [    6.043694] rootfs: got parser (null)
>>> [    6.051426] mtd: device 12 (rootfs) set to be root filesystem
>=20
> AFAICT, this log line is not part of the mainline kernel.

this is mainline. it=E2=80=99s just not 6.x. it=E2=80=99s 4.14.
>=20
>>> [    6.062891] rootfs_data: parsing partitions cmdlinepart
>>> [    6.073669] rootfs_data: got parser (null)
>>> [    6.211240] block ubiblock0_0: created from ubi0:0(rootfs)
>>> [    6.259545] rtc-pcf8563 0-0051: hctosys: unable to read the =
hardware clock
>>> [    6.282125] VFS: Cannot open root device "(null)" or =
unknown-block(31,12):
>>> error -6
>>> [    6.297406] Please append a correct "root=3D" boot option; here =
are the
>>> available partitions:
>>> [    6.314054] 1f00             512 mtdblock0
>>> [    6.314060]  (driver?)
>>> [    6.327077] 1f01             256 mtdblock1
>>> [    6.327081]  (driver?)
>>> [    6.340101] 1f02             256 mtdblock2
>>> [    6.340105]  (driver?)
>>> [    6.353124] 1f03             256 mtdblock3
>>> [    6.353129]  (driver?)
>>> [    6.366153] 1f04           45056 mtdblock4
>>> [    6.366158]  (driver?)
>>> [    6.379175] 1f05           40572 mtdblock5
>>> [    6.379179]  (driver?)
>>> [    6.392217] 1f06            4096 mtdblock6
>>> [    6.392222]  (driver?)
>>> [    6.405240] 1f07           40960 mtdblock7
>>> [    6.405244]  (driver?)
>>> [    6.418272] 1f08           32768 mtdblock8
>>> [    6.418277]  (driver?)
>>> [    6.431296] 1f09           40960 mtdblock9
>>> [    6.431300]  (driver?)
>>> [    6.444324] 1f0a            6144 mtdblock10
>>> [    6.444328]  (driver?)
>>> [    6.457518] 1f0b            4608 mtdblock11
>>> [    6.457523]  (driver?)
>>> [    6.470720] fe00           33604 ubiblock0_0
>>> [    6.470724]  (driver?)
>>> [    6.484090] Kernel panic - not syncing: VFS: Unable to mount root =
fs on
>>> unknown-block(31,12)
>=20
> (31, 12) would be mtdblock12.
> How does your kernel know that mtdblock12 shall be the rootfs?

this is an openwrt approach: =
https://openwrt.org/docs/techref/filesystems (under =E2=80=9Ctechnical =
details=E2=80=9D, third paragraph)

essentially there=E2=80=99s a feature they add to the kernel (via patch) =
where you can enable a feature that sets the root device based on the =
name of the partition.

in this case as long as the volume within your ubi file contains the =
name =E2=80=9Crootfs=E2=80=9D, openwrt will follow it as it gets =
unpacked and set that as the rootdevice for you.

=E2=80=94

>=20
> I have a hard time understanding your current setup.

i think we are saying the same thing when you say (31,12) is mtdblock12, =
which is shown as ubiblock0_0, because once i remove the change under =
discussion here, the boot is fine.=20

is it possible that gluebi is adding properties to the device created by =
CONFIG_MTD_UBI_BLOCK or something like that?

i wouldn=E2=80=99t worry about how the kernel knows which partition to =
set as root. openwrt has been doing this for over ten years.=20

the real question is, if we know what partition to set as root =
(ubiblock0_0 or mtdblock12), why does this change prevent it from =
finishing the boot?

the only explanation seems to be that gluebi is adding features to the =
ubiblock0_0 device (MTD_UBIVOLUME)?



>=20
> Thanks,
> //richard


