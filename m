Return-Path: <linux-kernel+bounces-218167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133190BA06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170C7281FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914D198E83;
	Mon, 17 Jun 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="OvrARZp6"
Received: from qs51p00im-qukt01071701.me.com (qs51p00im-qukt01071701.me.com [17.57.155.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FBE198A20
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649983; cv=none; b=pG8fsj/fD/4hXMs8GVzNl5tW1zmFlDwlMmNJpVYTN3Z7iVCEu6mrXj9wSUqRYDxbvL50UY13RVovxNtz+oOaXoGJ8Y1dPEgEWkScLnPbSFvNs84U5gq8KWyjVUuWNzPFVgNS7KLmoj/MBAvqunqZNm0Z7nr5oqw1uf4ANkCWjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649983; c=relaxed/simple;
	bh=0qt6JY0l5BIRoWxzuekw4IctY3CGatEXriuJO5DDUUI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OmlfCGXSIcAByzcUdLur/9WBszHYn1EJodCPM8zz15Wl3gx9d5Hx6xQ52jAzOAODwUY2qH0Gd7cHgOuOrJx9cYS+RTjMmjTYf28w2fxAlHVNK0Zba7e6b+O1SF8X2GBICECBOYHY/niynecQpqO8OJ2Tv1BtDyQfKcqbyS3/u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=OvrARZp6; arc=none smtp.client-ip=17.57.155.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718649980; bh=0qt6JY0l5BIRoWxzuekw4IctY3CGatEXriuJO5DDUUI=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=OvrARZp6VpH+vuM3Sy8aunE3u7lHISuIHWbeYLJAUVPVtRDDshwU3ZdHV/fBoaGPk
	 NCWglSBhHkqwFSw1hnzZNUG6dJ/acN+ho6QirZJK7VzDbsvkZaaXXWnQHOLI+FKhAF
	 HkpirHfwl9MVLhLNPS62R37pDfmXDfmEyG4hnHGimtX52Rp9oKFbSjJfltwni/WRWz
	 ubb9FcMlXRMtwyOnVKm9hTGoD29smTLpsuuYDQQI/sMLqQllcE06TTf2l0s2WOchq9
	 PoAEp58++liWWmvcyTACZtP/Ze7OayPfXSmmxyyoiZneAhBbdxglpp+vbcFwqqEeco
	 erR+PhrY6KTMg==
Received: from [172.20.144.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071701.me.com (Postfix) with ESMTPSA id 624564D00207;
	Mon, 17 Jun 2024 18:46:14 +0000 (UTC)
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
In-Reply-To: <296007365.252185.1718649153090.JavaMail.zimbra@nod.at>
Date: Mon, 17 Jun 2024 12:46:10 -0600
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
Message-Id: <3841F21D-CA54-456C-9D9C-F06EEA332A30@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
 <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com>
 <1802911356.251780.1718643160760.JavaMail.zimbra@nod.at>
 <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com>
 <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com>
 <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
 <303502000.252057.1718647746641.JavaMail.zimbra@nod.at>
 <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com>
 <296007365.252185.1718649153090.JavaMail.zimbra@nod.at>
To: Richard Weinberger <richard@nod.at>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-GUID: rXbTZeafNsUTrSQnBXVxBnN2JoMEIHeH
X-Proofpoint-ORIG-GUID: rXbTZeafNsUTrSQnBXVxBnN2JoMEIHeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406130160



> On Jun 17, 2024, at 12:32 PM, Richard Weinberger <richard@nod.at> =
wrote:
>=20
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Gagan Sidhu" <broly@mac.com>
>>> AFAICT, this log line is not part of the mainline kernel.
>>=20
>> this is mainline. it=E2=80=99s just not 6.x. it=E2=80=99s 4.14.
>=20
> I've double checked and disagree.
> This line comes from:
> =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-4.14/480-mtd-set-rootfs-to-be-root-dev.patch;h=3D6cddaf01=
b75cb58cfb377f568f2c375af87e2f1b;hb=3Dc3bd1321de1e0d814f5cfc4f494f6b2fb1f5=
133b

no i know that, that=E2=80=99s the patch i showed you. i meant the rest =
of it is mainline. the patch obviously is not.
>=20
> In recent OpenWRT kernels I see:
> =
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux=
/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.pat=
ch;h=3D266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=3DHEAD
>=20
> Looks like in recent versions the patch in question does *not* cause a =
regression.

that patch is also applied in my version as well, so i don=E2=80=99t see =
how this avoids the regression.

https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774

mine says "[6.051426] mtd: device 12 (rootfs) set to be root filesystem"

which is simply the call from drivers/mtd/mtdcore.c

so the rootfs device is set correctly. it=E2=80=99s just not booting =
from it.

the regression comes from having GLUEBI+BLOCK enabled, it seems, are =
they fighting for/operating on the same partition?

>=20
>>> (31, 12) would be mtdblock12.
>>> How does your kernel know that mtdblock12 shall be the rootfs?
>>=20
>> this is an openwrt approach: =
https://openwrt.org/docs/techref/filesystems (under
>> =E2=80=9Ctechnical details=E2=80=9D, third paragraph)
>>=20
>> essentially there=E2=80=99s a feature they add to the kernel (via =
patch) where you can
>> enable a feature that sets the root device based on the name of the =
partition.
>=20
> So, this is all not mainline. :-/

i did say openwrt at the start, and i think that=E2=80=99s pretty close =
to mainline as it gets.

sometimes these patches aren=E2=80=99t appropriate to push upstream. =
this one is not the one causing the issue.

it seems to me that there is a problem with GLUEBI+BLOCK playing =
together.=20

as far as i can see, the setting of the device is being doing by =
mtdcore.c

it=E2=80=99s just not working with gluebi and block are enabled, and i =
need to know whether disabling gluebi will allow it to work.

in other words, is it possible for gluebi to use the partition created =
by ubi_block, and add the MTD_UBIVOLUME flag?

>=20
>> in this case as long as the volume within your ubi file contains the =
name
>> =E2=80=9Crootfs=E2=80=9D, openwrt will follow it as it gets unpacked =
and set that as the
>> rootdevice for you.
>=20
> Thanks,
> //richard


