Return-Path: <linux-kernel+bounces-227823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F879156DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA38284CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F880143C42;
	Mon, 24 Jun 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="ZaWP/RKA"
Received: from ci74p00im-qukt09081501.me.com (ci74p00im-qukt09081501.me.com [17.57.156.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5CD1BC20
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255620; cv=none; b=uPTclCgl2v4e+v5OqAcHMusC23sCff0HzYPqobAX2tUIkYBDYjHjtx8RufgnY9SmyHCODaMZhin/GrJ81hbqe+e7OH7FwQoMsm6Vf58OYDcUc/41WK34jwxx4fMFRK5+YcaS3PKs7ZdJfBalTxdG1UpVY98eY0jaRwoOmHI24Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255620; c=relaxed/simple;
	bh=pATsgfuynY3i5Yamo8zIYDydQ+ZELomD+Bybiq7ZWAY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RDR8XjNGOPDieIzRWB5WgGEoE4yxeHiEOyu8RXz/QPLag/FM3wvuy/kKVyaEF2OM65FmPGr2CbpWrrAQQK6kJcn9c+4BjkNEUGhjz8hQ6qEC1+hTll87GakxkojtUI8CDelLCksQ+7VU53Tj5Q157OgIZe3MIlYdhUGcCrRSsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=ZaWP/RKA; arc=none smtp.client-ip=17.57.156.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1719255618; bh=pATsgfuynY3i5Yamo8zIYDydQ+ZELomD+Bybiq7ZWAY=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=ZaWP/RKAyX9rFS11X882aV/v6u4O5FPNYtfs89tRYktREY9I91A6IQJQ1DYW5zPFW
	 AbyafjCl/QOhY5W4/FE3Sz1GROWdbJod9pMN551QL/OMPe9lZP0pJlfcA+GClT9qEp
	 4Z0Xcfw5Lt/cniKGL94JPjop23dNxctsK/6rTVDy0UbE+opXI5jVCqeK5erZJTi9O/
	 qgOU8Q7FpCQzSwrZM4/VlfjDL32yz9zVoYIKWA7FQRIBq4MBPU6ROIPTjeJG8eGQDm
	 YqQr7lZJqxxI6+lY7yeCLewZDDKTBJ0Xz17i6nnstpp8nmM0PHAetjens8wJxR9mec
	 rBhsLAAqJNXzA==
Received: from [172.20.144.3] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081501.me.com (Postfix) with ESMTPSA id 42D6B25C051B;
	Mon, 24 Jun 2024 19:00:13 +0000 (UTC)
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
In-Reply-To: <Znc8_hcjH3_0plN4@makrotopia.org>
Date: Mon, 24 Jun 2024 13:00:08 -0600
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
 Richard Weinberger <richard@nod.at>,
 ZhaoLong Wang <wangzhaolong1@huawei.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 yangerkun <yangerkun@huawei.com>,
 yi zhang <yi.zhang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5234146D-E9D8-4D05-95F0-D3308F9CAFFD@mac.com>
References: <251ae039-9f46-081b-a7ee-fe47de268865@huawei.com>
 <EFEC7C06-A3B2-46D6-99F4-ADA7F7199188@mac.com>
 <45d2ef27-95cc-16c4-8b0a-4413421d785b@huawei.com>
 <772249DB-434C-4AB9-AE6B-1CB684E1E11A@mac.com>
 <e562e94b-274d-4a82-3dad-d3e1109a2607@huawei.com>
 <7558AC97-FFFC-4593-B946-9F8FBD8D62FA@mac.com>
 <da6f4aa8-e79d-d70a-eeb5-0068ffc1ef52@huawei.com>
 <BE6684D5-1CEE-46AA-84BF-C6146667D84B@mac.com>
 <69656f63-d2ad-8215-eba6-12603fb38f62@huawei.com>
 <4FBEAA67-7829-481C-8EB0-06621B73F935@mac.com>
 <Znc8_hcjH3_0plN4@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-ORIG-GUID: gTRDLq10rEvO02APYPW2llV3MOb1jbZ4
X-Proofpoint-GUID: gTRDLq10rEvO02APYPW2llV3MOb1jbZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406240151

actually the issue was resolved. we are discussing unexpected behaviour =
when both MTD_UBI_GLUEBI and MTD_UBI_BLOCK are enabled.

disabling MTD_UBI_GLUEBI fixed my issue, and everything mounted as =
expected afterwards.

the question was why ubiblock0_0 was not being mounted when =
MTD_UBI_GLUEBI was enabled, and the evidence suggested it was somehow =
being assigned the label MTD_UBIVOLUME

but if no one cares that=E2=80=99s fine lol

Thanks,
Gagan

> On Jun 22, 2024, at 3:07 PM, Daniel Golle <daniel@makrotopia.org> =
wrote:
>=20
> On Fri, Jun 21, 2024 at 08:43:47PM -0600, Gagan Sidhu wrote:
>> [...]
>> GLUEBI should be operating on the /dev/mtdblockX device and not =
ubiblock0_0 and thus the boot procedure created by openwrt should be =
unaffected.
>>=20
>> at least that=E2=80=99s how i would understand the situation if each =
are creating their own devices.
>>=20
>> we need to figure out a solution or maybe master rich should end our =
ongoing discussion because technically =E2=80=9Cit=E2=80=99s not =
mainline=E2=80=9D and we=E2=80=99re probably boring the recipients.
>=20
> I've suggested a simple solution here:
>=20
> https://lkml.org/lkml/2024/6/17/1602
>=20
> You could try that and let us know if it resolves the issue for you.


