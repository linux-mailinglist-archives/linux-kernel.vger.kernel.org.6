Return-Path: <linux-kernel+bounces-217905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AF190B5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2DB1F22EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4112E71;
	Mon, 17 Jun 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="moyJRz09"
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC0F9F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640324; cv=none; b=Ih6vP+gz65M7KSJCGMCtayvb9KT2UKP4WL041XDbVH+Ey05DfjB86ritkSQIpOghOP1lMeRTNy45GvDp6WIMuLhO22F40QN/gb1gisqXNVv5Dq2fjHyo3NX8Sqns+TD0VWwVm1sRo0NNIA8W6DYo3UIDkmrzjBPhIUj4bz/Q1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640324; c=relaxed/simple;
	bh=0uZ5ctPfb0GgkMhOGKobFwZbKqRtprPiZXTB6IzB9QA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FflD8YXS0oFLOyEZRHv4CgYWpgydwW8rn645x6CkErk3hgE0z1LoBd+vpNENgw04fhJp673GMl3KgL98SbdsPTqnUrFDDN6JFVqFmat1qy4AmfssPkSkd1BnR36lL+SJ/AT8El+2S9xwbaeKRkZeesE06k/hEWxZ7yCbtnb6LwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=moyJRz09; arc=none smtp.client-ip=17.57.155.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1718640322; bh=ams6j7WKomm1oRicNJ1/r9gMg38ZDFI+xkZNs8TEMhU=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=moyJRz09gh/fQP+v90FcVIfHpJirByHENxA081YTvOOLYbA11oxvR0WTUosty8AOT
	 NvU7uvj65AiHZG0QI1x6Q7YlxUl5NeoFJI7r8cXCNJf99gcQ8Pfem29LKpGN7kZrr7
	 twz1m3E1DlmKQz42PugunNL4enjg7KW49vZqrO2ECya2icCsQyQbe0sNayMmELANxS
	 HaANSg5minaQACXNUq/4pNXJph/e+9FeN670Nq2teEHKIIDfi8VuVw+5TKSFP3w9WO
	 OEuBHLSaszOJfU43oQe+7ttdQP/agxQdo/fyIPC6iXGEhZ9MLmgIFBd/cvsJyB18m1
	 5UCdxX031zW6g==
Received: from [172.20.144.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id B8B9E1980328;
	Mon, 17 Jun 2024 16:05:17 +0000 (UTC)
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
In-Reply-To: <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at>
Date: Mon, 17 Jun 2024 10:05:13 -0600
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
Message-Id: <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
 <561660214.251562.1718638970757.JavaMail.zimbra@nod.at>
 <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com>
 <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at>
To: Richard Weinberger <richard@nod.at>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-ORIG-GUID: buHqJC9Wi3ZoO48bM3PVXyOG_kezwdJU
X-Proofpoint-GUID: buHqJC9Wi3ZoO48bM3PVXyOG_kezwdJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406170125

i don=E2=80=99t think my articulation is correct if you interpreted it =
as that.

as i understand it, gluebi simply makes it handy when you have a =
filesystem packed within a ubi file, and it will take that file and =
mount itas a block device.

so i would say it=E2=80=99s not MTD->UBI->GLUEBI->MTD->MTDBLOCK

it=E2=80=99d say it=E2=80=99s more MTD->GLUEBI->MTDBLOCK

that is, the squashfs (actual filesystem) is simply wrapped in a ubi =
file for gluebi, which will then make it a block device.

i=E2=80=99m not using an actual UBIFS anywhere, aside from sitting =
underneath the squashfs to handle the mapping from the squash to the =
nand (to handle bad blocks).

e.g. i have a rootfs in a squashfs file
	-i wrap that squashfs file into a squashfs.ubi
	-i use gluebi to detect this squashfs.ubi file as a block device =
and mount it

that=E2=80=99s about it.


Thanks,
Gagan

> On Jun 17, 2024, at 10:00 AM, Richard Weinberger <richard@nod.at> =
wrote:
>=20
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Gagan Sidhu" <broly@mac.com>
>> yes, i have a squashfs inside a ubi volume, and i create ubi block =
device from
>> it.
>>=20
>> i do use config_mtd_ubi_block because the filesystem is squashfs.
>>=20
>> so i think it=E2=80=99s affirmative to both questions. gluebi for the =
block device from
>> the ubi.fs file, then config_mtd_ubi_block to mount this read-only =
filesystem
>> as a block device.
>>=20
>> the end result of both options is a read-only block device that can =
handle bad
>> blocks on nand devices.
>>=20
>> if i was using an M25P80, i wouldn=E2=80=99t even be using ubi.
>>=20
>> so CONFIG_MTD_UBI_{GLUEBI,BLOCK} are handy for cases where you need =
an mtd block
>> device with a read-only file system where the UBI takes care of the
>> idiosyncrasies that make NAND (imo, ofc) inferior to SPI
>=20
> Isn't MTD -> UBI -> GLUBI -> MTD -> MTDBLOCK performance wise a =
nightmare?
> We have UBIBlock for this use case.
>=20
> Thanks,
> //richard


