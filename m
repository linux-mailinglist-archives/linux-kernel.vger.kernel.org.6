Return-Path: <linux-kernel+bounces-218039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C530D90B86E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497231F2381E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218B18EFF2;
	Mon, 17 Jun 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="kuyH1Beq"
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868210A2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646519; cv=none; b=bj2p2Da3kKyKaUleE4JEeEmXAmWg8RKiYBBayc0EijI6XrQZChIWN9gH5KS74eOJ4JIc0kjEVdfi0o8Oum2mkfluKuhS6Dqx4TFhAPxZ08WukG7cE1h3ONGjsPk7FJsV0S377ijC0UDDseDmBiRjYajQl4DyvKMGMws/tRu9a98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646519; c=relaxed/simple;
	bh=v1ku5aWxtvFs+90tP5jCbOKol50bXnablfVWOQFbI60=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=luAhvcbbxql2WgMf2i+q2nWVupjEfeuD/kJ5K89Ayr4APFo3J3INYvrLDTpj5V4QwWMkbSA2eJEFNVitnjFKiavty2Dl3YOClKv/FdobWeq6cpw+3lfDDj8kGEGU2upe+1KPdOeYt87yDUBdeKxLjrfPnB/Kd8uPY2Lx7/cWIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=kuyH1Beq; arc=none smtp.client-ip=17.57.155.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718646517; bh=AvSNnwpi4zFhnr0K3pbiFoV/i17xqC8RIz0JddAMy8E=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=kuyH1Beq6ktFI5GwtiM+gvUO2us9Lbvd9nB9/nAB+MgGzIF1kJJosy2uThRO/1CwM
	 be815IB4wd5h994tHu8U8hLXU4fU7bsCuz9JSHzn0fP5NmO2HE6P7Jew7P1JBkxYnl
	 P9EXprAnT4+jI5PXDQFi0qW5Y1Y3PrvO2NgbfNum1x/15jMlm9GXa6breGyUCG12cp
	 Q3GA1Q/MWSz1WyMfrxv/HKbUME7rYGYYsb7ibgz5vJMw/AL4K9rQEk/RBDwK6CSUH5
	 2Sc/37nfpA9DUunrzB23wsTcHuOiZTyVxqbF+k+lnpMlb510gGRi/ClPJHyYyA7ywc
	 ZdfBbNbqV/IpA==
Received: from [172.20.144.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id EF7FA44034C;
	Mon, 17 Jun 2024 17:48:30 +0000 (UTC)
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
In-Reply-To: <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com>
Date: Mon, 17 Jun 2024 11:48:25 -0600
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
Message-Id: <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
 <561660214.251562.1718638970757.JavaMail.zimbra@nod.at>
 <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com>
 <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at>
 <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com>
 <1802911356.251780.1718643160760.JavaMail.zimbra@nod.at>
 <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com>
 <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com>
To: Richard Weinberger <richard@nod.at>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-ORIG-GUID: aPLMcYmQ49AZ0iSzUUSYDpWfxosfbxfr
X-Proofpoint-GUID: aPLMcYmQ49AZ0iSzUUSYDpWfxosfbxfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406170111

h=
ttps://github.com/torvalds/linux/blob/master/drivers/mtd/ubi/gluebi.c#L297=


it seems the GLUEBI is setting the mtd to MTD_UBIVOLUME

https://github.com/torvalds/linux/blob/master/drivers/mtd/ubi/block.c

where this doesn=E2=80=99t even have the text =E2=80=9Cmtd=E2=80=9D =
anywhere.

but the boot partition is always the ubiblock device.

so is gluebi taking the same volume and adding the MTD_UBIVOLUME label =
or something?

that seems a little unusual.

Thanks,
Gagan

> On Jun 17, 2024, at 11:33 AM, Gagan Sidhu <broly@mac.com> wrote:
>=20
> just to highlight this, let=E2=80=99s look at the failed boot with the =
changes discussed in this patch
>=20
> [    5.462504] auto-attach mtd7
> [    5.462525] ubi0: default fastmap pool size: 15
> [    5.477309] ubi0: default fastmap WL pool size: 7
> [    5.486683] ubi0: attaching mtd7
> [    5.811240] UBI: EOF marker found, PEBs from 273 will be erased
> [    5.811299] ubi0: scanning is finished
> [    5.874546] gluebi (pid 1): gluebi_resized: got update notification =
for unknown UBI device 0 volume 1
> [    5.892927] ubi0: volume 1 ("rootfs_data") re-sized from 9 to 28 =
LEBs
> [    5.906683] ubi0: attached mtd7 (name "ubi", size 40 MiB)
> [    5.917446] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: =
126976 bytes
> [    5.931132] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page =
size 2048
> [    5.944654] ubi0: VID header offset: 2048 (aligned 2048), data =
offset: 4096
> [    5.958513] ubi0: good PEBs: 320, bad PEBs: 0, corrupted PEBs: 0
> [    5.970472] ubi0: user volume: 2, internal volumes: 1, max. volumes =
count: 128
> [    5.984859] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, =
image sequence number: 1613475955
> [    6.003045] ubi0: available PEBs: 0, total reserved PEBs: 320, PEBs =
reserved for bad PEB handling: 15
> [    6.021426] rootfs: parsing partitions cmdlinepart
> [    6.021444] ubi0: background thread "ubi_bgt0d" started, PID 97
> [    6.043694] rootfs: got parser (null)
> [    6.051426] mtd: device 12 (rootfs) set to be root filesystem
> [    6.062891] rootfs_data: parsing partitions cmdlinepart
> [    6.073669] rootfs_data: got parser (null)
> [    6.211240] block ubiblock0_0: created from ubi0:0(rootfs)
> [    6.259545] rtc-pcf8563 0-0051: hctosys: unable to read the =
hardware clock
> [    6.282125] VFS: Cannot open root device "(null)" or =
unknown-block(31,12): error -6
> [    6.297406] Please append a correct "root=3D" boot option; here are =
the available partitions:
> [    6.314054] 1f00             512 mtdblock0
> [    6.314060]  (driver?)
> [    6.327077] 1f01             256 mtdblock1
> [    6.327081]  (driver?)
> [    6.340101] 1f02             256 mtdblock2
> [    6.340105]  (driver?)
> [    6.353124] 1f03             256 mtdblock3
> [    6.353129]  (driver?)
> [    6.366153] 1f04           45056 mtdblock4
> [    6.366158]  (driver?)
> [    6.379175] 1f05           40572 mtdblock5
> [    6.379179]  (driver?)
> [    6.392217] 1f06            4096 mtdblock6
> [    6.392222]  (driver?)
> [    6.405240] 1f07           40960 mtdblock7
> [    6.405244]  (driver?)
> [    6.418272] 1f08           32768 mtdblock8
> [    6.418277]  (driver?)
> [    6.431296] 1f09           40960 mtdblock9
> [    6.431300]  (driver?)
> [    6.444324] 1f0a            6144 mtdblock10
> [    6.444328]  (driver?)
> [    6.457518] 1f0b            4608 mtdblock11
> [    6.457523]  (driver?)
> [    6.470720] fe00           33604 ubiblock0_0
> [    6.470724]  (driver?)
> [    6.484090] Kernel panic - not syncing: VFS: Unable to mount root =
fs on unknown-block(31,12)
> [    6.500892] Rebooting in 1 seconds..
>=20
>=20
>=20
> here, i assume ubiblock0_0 is the device created from =
CONFIG_MTD_UBI_BLOCK, correct?
>=20
> then, i don=E2=80=99t think it=E2=80=99s GLUEBI that is the reason my =
boot works. i think gluebi is useless now that you mention it, and =
isn=E2=80=99t the reason everything works.
>=20
> as you can see, UBI_BLOCK is the reasno ubiblock0_0 is created.
>=20
> this patch prevents this device from being registered/announced. so =
when ubi tries to set it (correctly) as the root partition (#12), it =
fails.
>=20
> so doesn=E2=80=99t this change affect more than just GLUEBI? it seems =
to affect UBI_BLOCK as well.
>=20
> Thanks,
> Gagan
>=20
>> On Jun 17, 2024, at 11:23 AM, Gagan Sidhu <broly@mac.com> wrote:
>>=20
>>=20
>>> On Jun 17, 2024, at 10:52 AM, Richard Weinberger <richard@nod.at> =
wrote:
>>>=20
>>> ----- Urspr=C3=BCngliche Mail -----
>>>> Von: "Gagan Sidhu" <broly@mac.com>
>>>> i don=E2=80=99t think my articulation is correct if you interpreted =
it as that.
>>>>=20
>>>> as i understand it, gluebi simply makes it handy when you have a =
filesystem
>>>> packed within a ubi file, and it will take that file and mount itas =
a block
>>>> device.
>>>=20
>>> There is no such thing as an UBI file. UBI hosts volumes.
>>> You can install into these volumes whatever you want.
>>> Also a file system such as UBIFS, but this seems not to be the case =
here.
>> that=E2=80=99s correct. the UBI sits underneath so it=E2=80=99s not =
ubifs.=20
>>=20
>>>=20
>>>> so i would say it=E2=80=99s not MTD->UBI->GLUEBI->MTD->MTDBLOCK
>>>>=20
>>>> it=E2=80=99d say it=E2=80=99s more MTD->GLUEBI->MTDBLOCK
>>>=20
>>> No. GLUBI emulates a MTD on top of an UBI volume.
>>> So every read/write operation of the filesystem will first to =
through:
>>>=20
>>> 1. block layer
>>> 2. MTDBLOCK (and mtd)
>>> 3. GLUBI
>>> 4. UBI
>>> 5. MTD (this time the real one)
>>>=20
>>> Is this really a setup OpenWRT is using?
>>> I'm not saying it's impossible, but far from ideal.
>>> We have UBIBlock for reasons.
>>>=20
>> i don=E2=80=99t understand what you mean. i didn=E2=80=99t think this =
was unusual haha.
>>=20
>> all ubiblock does is give me the right to use a read-only filesystem. =
it doesn=E2=80=99t map the UBI to a block device.
>>=20
>> are you saying there is an easy automated solution that allows me to =
remove gluebi, and maintain functionality? it doesn=E2=80=99t seem so =
easy.
>>=20
>> for example, here is an openwrt setup: =
https://forum.openwrt.org/t/ubifs-mount-twice-at-booting/126198
>>=20
>> so instead of using gluebi, they use an UBIFS. or they use an =
overlay. but up until that point, it=E2=80=99s similar.
>>=20
>> i didn=E2=80=99t think gluebi was the reason this check was =
problematic.
>> 	- are you saying MTD_UBIVOLUME is only a property of GLUEBI?
>>=20
>> these lines seemed more general than that.
>>=20
>> my position is this:
>>=20
>> 1. ubi seems to take care of everything as long as i name the =
partition accordingly (here, i pack the ubi file with two volumes, one =
for the kernel, the other with the rootfs).
>> 2. the change being discussed broke that.=20
>> 3. i don=E2=80=99t see how gluebi is the root of the problem though, =
because i have MTD_UBI_BLOCK enabled as well, so shouldn=E2=80=99t in =
spite of the change? it does not.
>>=20
>>=20
>>> Anyway, since the kernel has to be user space friendly and
>>> users seems to use such "odd" stackings I consider reverting this =
patch.
>>> ZhaoLong Wang, what do you think?
>>>=20
>>> Thanks,
>>> //richard
>>=20
>=20


