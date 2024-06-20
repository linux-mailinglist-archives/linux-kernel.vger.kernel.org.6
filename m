Return-Path: <linux-kernel+bounces-223601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF191156C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36B61C22A37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE9F13210D;
	Thu, 20 Jun 2024 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="aU9ZmrSV"
Received: from qs51p00im-qukt01072102.me.com (qs51p00im-qukt01072102.me.com [17.57.155.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25285952
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921185; cv=none; b=YwxKytoJC9FMtz/99TF9Xup5uJm6GuvGOjvLqs7bhCkaYb8JWfgo7Xy+mRWudn5W6vbYyVTXAEYOSQleXKkfVRpK33TW2aDl2Um4iRgX6qy/lHxAp73sHHxfld/HI2xs1YeYNcpb0bkmdOjxKwdncBgJmKNBWZsfRR/SOkR++yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921185; c=relaxed/simple;
	bh=I9OMwWn+DGbGRcP3Iz4EuPPHEvna2l74bjOtJCoaedk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jwRpf7XYep4l4+BiArM7YMiaQ8sw/IoIRSalf1pw3hz/e8/KdgfzSOFDg3KS+3XVXWsHJy9KvKBDO+VvblEa4YpvwBBnwRaIl+mFPx7QGuPc0v1Ee/sVvu2kArpglDUuMjC/SvE6w7X7bRDxtmC+jDLvy9CDvO4KykVX5UrBNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=aU9ZmrSV; arc=none smtp.client-ip=17.57.155.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718921182; bh=RlqKdkifPzJNyVFZdKuDYBTnjv4N3Vl4EqLMDScJvWs=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=aU9ZmrSV7pifIU9rsgI2B4SpepfRE+AwQhm+DQIBMz2WOABFNb8bz2dgmabxl5QDt
	 /R6P5G7UCY7rDzO6xzsvzvdBApXF69JckhHm8owlCIjhkbH2Az82YKt+ILizPTo4Zz
	 Apdk9Q5xxo15/qXBryLXmunsk2sunbMk1Pfn6DCCHMToW0H/uDv1ov/G8vAvZBxqxn
	 Lw1maU5ANLiFviuyTjzghJrNGt6hpPmHNS0Y1qchNp4QTyyb9BZZ1u6RAyGDJPNJMM
	 19B57f2yPYkroiJ07HK6Ot9v5yN5UKZj0bp64DjaUcVtbkEIOdeSLBDYVlVj9VnV4D
	 FlBuJBhcNp42Q==
Received: from [172.20.144.1] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072102.me.com (Postfix) with ESMTPSA id 61596340252;
	Thu, 20 Jun 2024 22:06:15 +0000 (UTC)
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
In-Reply-To: <251ae039-9f46-081b-a7ee-fe47de268865@huawei.com>
Date: Thu, 20 Jun 2024 16:06:11 -0600
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
Message-Id: <EFEC7C06-A3B2-46D6-99F4-ADA7F7199188@mac.com>
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
To: Zhihao Cheng <chengzhihao1@huawei.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-GUID: aBMcI18K3s8DbCMnieoX6MXPFPbwhYhe
X-Proofpoint-ORIG-GUID: aBMcI18K3s8DbCMnieoX6MXPFPbwhYhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406200163

hi zhihao,

so i assume my crude paraphrase is correct? that i may have =
unintentionally pointed the finger at you, but the real issue is GLUEBI =
existing with BLOCK on the same volume?

i was just joking about you being a spy by the way. it was post-fix =
euphoria ;)

master rich, shepherd weinberger, what say ye?

your wisdom and insight would be greatly appreciated as closure and =
maybe even a patch to reflect the beauty of collaborating over current =
;)

Thanks,
Gagan

> On Jun 17, 2024, at 10:03 PM, Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:
>=20
> =E5=9C=A8 2024/6/18 6:13, Gagan Sidhu =E5=86=99=E9=81=93:
> Hi,
>> spoke to a user, gave him a build without MTD_GLUEBI, restoring =
changes made by (HAHAHA you are! huawei), it booted fine.
>=20
> May I have the layers' information about mtd/ubi, you can get it by =
'mtdinfo -a' and 'ubinfo -a' after booting the device.
> I guess your device boots from ubiblock0_0. There are two ways loading =
booting device:
> 1. mtd(nand)
>   ubi(holds volume ubi0_0)
>   mtd12 (gluebi)
>   mtdblock12  (This way is cut by this patch, so mtdblock12 is not =
generated, just like Daniel&Richard analyzed)
> 2. mtd(nand)
>   ubi(holds volume ubi0_0)
>   ubiblock0_0
>=20
>> so we need to think about either deprecating GLUEBI or setting an =
option in the Kconfig that ensures they are mutually exclusive.
>> gluebi is definitely highjacking the block device created by =
UBI_BLOCK and adding the MTD_UBIVOLUME flag to it.
>=20
> The gluebi(mtd) and ubiblock could exist on the same UBI volume at the =
same time, but they cannot be opened at the same time. Here is an =
example I tested on the local machine:
>=20
>                                             =E2=86=97 ubiblock0_0
> mtd0(nandsim) -> ubi0 (holds volume ubi0_0)
>                                             =E2=86=98 gluebi(mtd1)
>=20
> [root@localhost ~]# ubinfo -a
> UBI version:                    1
> Count of UBI devices:           1
> UBI control device major/minor: 10:61
> Present UBI devices:            ubi0
>=20
> ubi0
> Volumes count:                           1
> Logical eraseblock size:                 126976 bytes, 124.0 KiB
> Total amount of logical eraseblocks:     8192 (1040187392 bytes, 992.0 =
MiB)
> Amount of available logical eraseblocks: 0 (0 bytes)
> Maximum count of volumes                 128
> Count of bad physical eraseblocks:       0
> Count of reserved physical eraseblocks:  160
> Current maximum erase counter value:     2
> Minimum input/output unit size:          2048 bytes
> Character device major/minor:            246:0
> Present volumes:                         0
>=20
> Volume ID:   0 (on ubi0)
> Type:        dynamic
> Alignment:   1
> Size:        8026 LEBs (1019109376 bytes, 971.8 MiB)
> State:       OK
> Name:        vol_a
> Character device major/minor: 246:1
> [root@localhost ~]# mtdinfo -a
> Count of MTD devices:           2
> Present MTD devices:            mtd0, mtd1
> Sysfs interface supported:      yes
>=20
> mtd0
> Name:                           NAND simulator partition 0
> Type:                           nand
> Eraseblock size:                131072 bytes, 128.0 KiB
> Amount of eraseblocks:          8192 (1073741824 bytes, 1024.0 MiB)
> Minimum input/output unit size: 2048 bytes
> Sub-page size:                  512 bytes
> OOB size:                       64 bytes
> Character device major/minor:   90:0
> Bad blocks are allowed:         true
> Device is writable:             true
>=20
> mtd1
> Name:                           vol_a
> Type:                           ubi
> Eraseblock size:                126976 bytes, 124.0 KiB
> Amount of eraseblocks:          8026 (1019109376 bytes, 971.8 MiB)
> Minimum input/output unit size: 2048 bytes
> Sub-page size:                  2048 bytes
> Character device major/minor:   90:2
> Bad blocks are allowed:         false
> Device is writable:             true
>=20
> [root@localhost ~]# lsblk | grep ubi
> ubiblock0_0 251:0    0 971.9M  0 disk
>=20
>> there is no other explanation.
>> looks like this was an absolutely amazing exchange that even =
furthered our understanding of wtf is going on.
>> thanks for being a great moderator for MTD rich
>> Thanks,
>> Gagan
>=20


