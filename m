Return-Path: <linux-kernel+bounces-432560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D99E4CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B1C1881A83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F4191F91;
	Thu,  5 Dec 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hZoXOXtF"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CBC15B980
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371204; cv=none; b=sk42IsZJF6oMw/8WkeNnFc1GVHQrWOYRZ2CVi/sOOnCMfWWr+oupXLXbouqqnSuAy62WJVDxNPaYJaihVKtreMjoqUFTODv1pos1967RE6sHd/3zdDdTIBpcElRGtSnt1mdbOQ/3F4sDuF1ViTn/d/S+tM4u+gget/984MCl9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371204; c=relaxed/simple;
	bh=Fs9+RSzK6wjek/HCJ7ZcgpDKTN9pel0w2yPEXbo5R+s=;
	h=Date:Message-ID:Mime-Version:Subject:From:To:CC:In-Reply-To:
	 Content-Type:References; b=bVJymqb+kgqPKcv45m66HTFIvOigsbykMyBe+Os2RRzqSdcW1RaBuiWsTxMbAt21u495VEU9vWnaiWorY6WlUKkrkv5ZMCrkzBW9l0nvCTLbxbSbxYk8B/RNnUZnPz9Q1fe203YeeduW4uYmtVjuM8Quut//j7kimsbqr6PhHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hZoXOXtF; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241205035953epoutp010d7f90572c9fb31ffbb29b9a23000fdd~OK_qogRGt1529615296epoutp01f
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241205035953epoutp010d7f90572c9fb31ffbb29b9a23000fdd~OK_qogRGt1529615296epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733371193;
	bh=Fs9+RSzK6wjek/HCJ7ZcgpDKTN9pel0w2yPEXbo5R+s=;
	h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
	b=hZoXOXtFfG1j+ZwUKh9fxaiq22Q34ezixv1aT8gm7RxuuVPI5IZC026SX+kc9uD4m
	 n4kRjZHjmElydL0o9MboYsf9nlTeICFX3pKXEbSPLJxhXTzZQk4swb+VkOWVQdwm7m
	 t8sIGmNeYuRp3oA1n+Z8ddi9Jj7tTCepZkVx3YtY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241205035952epcas1p226ff77392909603a983c4824774f9a50~OK_pux95S1603716037epcas1p2G;
	Thu,  5 Dec 2024 03:59:52 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.144]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y3gdM2sKPz4x9Q2; Thu,  5 Dec
	2024 03:59:51 +0000 (GMT)
X-AuditID: b6c32a4c-ac3ff70000007bf7-8b-67512537816c
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.8E.31735.73521576; Thu,  5 Dec 2024 12:59:51 +0900 (KST)
Date: Thu, 05 Dec 2024 12:58:14 +0900
Message-ID: <556725552.2924666.1733371094684@v8mail-kr1-0.v8mail-kr1.knoxportal-kr-prod-green.svc.cluster.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH] extcon: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <la6csftzuntp3w2etea5s2u63yjxvxcgicg7tbehnild4d736g@uqod6luq4bth>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20241205035814epcms1p417c54b0cf0076b5e5d8846ea684b44cb
Content-Type: multipart/mixed;
	boundary="----=_Part_2924665_665943932.1733371094684"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmvq65amC6wcYzIhbXvzxntTh/fgO7
	xeVdc9gs5n/9xObA4vH+Riu7x6ZVnWwefVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r
	5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
	kV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ3R2bWVreCwQMWt+9eYGhhf83cx
	cnBICJhIXHmV18XIxSEksIdR4l1PE1sXIycHi4CqxI0XdxlBbF6BAomupknMIPW8AoISf3cI
	g4SFBTIlOpteMoHYQgJKEg039zFDxPUlOh5sA2tlE9CV2LrhLguILSKQLzHhyk2wemaBLInZ
	V46B2RICvBIz2p+yQNjSEtuXbwXr5RTwk1h8YT07RFxU4ubqt3D2+2PzGSFsEYnWe2eZIWxB
	iQc/d0PFJSX67uxlgngxW+LePmmIcInEhDO7WCFsc4lXEy9BtbpITOtazAhxWpjEizUPoGpk
	JaaeWgd1Mp/Eu689rDAn75j3BOp8NYlDu5dAnSYjcXr6QqiZHhIru66zQYLnPKPEr5U2Exjl
	ZyECcRaSbRC2tsSyha+ZQUqYBTQl1u/ShwirSUzp/8IGYZtLrFozkxnCVpSY0v2QfQEj+ypG
	qdSC4tz01GTDAkPdvNRyeBJIzs/dxAhOo1o+Oxi/r/+rd4iRiYPxEKMKUP+jDasvMEqx5OXn
	pSqJ8AZpB6QL8aYkVlalFuXHF5XmpBYfYjQFpoSJzFKiyfnABJ9XEm9oYmlgYmZkbGJhaGao
	JM575kpZqpBAemJJanZqakFqEUwfEwenVAOTT/D2C7mS3xiXKO29Ms999+Obx1pb3Pf8ilv1
	p3XqvtCM6ffyHxfuvlrnw3B/xbufPYuXH2JZ/X/a8d+XpXgiz+5u0UjSuKGdnxcg7/p01YW3
	1cxJGYySEwL7Pi/ukvhSnvPsinPRHAazTQXHj6iL6mkffdc4f/PcwlXZdYdf2XJMSRPRiLUr
	vTv/lb/ocqfoDdXcX3KzXd+ecZK1XPHs6RfpjuTUpG0qt95N2hzYphwX7SmvqnHN65xy0xR9
	3nPvfz4zviISZ+Ih3rA8K+tY3IGJAc8+SJgq6nd0nuQTT7vXVD3v0f3dpxvaPv6fxrvq8f2E
	G22+5/48UJRbW3x7Ts3r36FLrFapWN06JcYQr8RSnJFoqMVcVJwIAJX/0F04BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241204103802epcas1p3bb95970c978894677e1087ac20dc8450
References: <la6csftzuntp3w2etea5s2u63yjxvxcgicg7tbehnild4d736g@uqod6luq4bth>
	<20240918123150.1540161-6-u.kleine-koenig@baylibre.com>
	<CGME20241204103802epcas1p3bb95970c978894677e1087ac20dc8450@epcms1p4>

------=_Part_2924665_665943932.1733371094684
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

>Hello,
>
>On Wed, Sep 18, 2024 at 02:31:48PM +0200, Uwe Kleine-K=C3=B6nig=20wrote:=
=0D=0A>>=20These=20drivers=20don't=20use=20the=20driver_data=20member=20of=
=20struct=20i2c_device_id,=0D=0A>>=20so=20don't=20explicitly=20initialize=
=20this=20member.=0D=0A>>=20=0D=0A>>=20This=20prepares=20putting=20driver_d=
ata=20in=20an=20anonymous=20union=20which=20requires=0D=0A>>=20either=20no=
=20initialization=20or=20named=20designators.=20But=20it's=20also=20a=20nic=
e=0D=0A>>=20cleanup=20on=20its=20own.=0D=0A>>=20=0D=0A>>=20Signed-off-by:=
=20Uwe=20Kleine-K=C3=B6nig=20<u.kleine-koenig=40baylibre.com>=0D=0A>=0D=0A>=
That=20patch=20got=20some=20positive=20feedback=20by=20Krzysztof=20but=20wa=
sn't=20applied.=0D=0A>Is=20this=20still=20on=20someone's=20radar=20for=20ap=
plication?=0D=0A>=0D=0A>Best=20regards=0D=0A>Uwe=0D=0A=0D=0ACan=20you=20pro=
vide=20a=20link=20to=20a=20commit=20that=20requires=20this=20change?=0D=0A=
=0D=0AFor=20now,=20I=20don't=20see=20any=20benefit=20from=20this=20change.=
=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A=0D=0A
------=_Part_2924665_665943932.1733371094684
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBQUJDZ0FkRmlFRVA0R3NhVHA2
SGxtSnJmN1RqNEQ3V0gwUy9rNEZBbWRRTVFBQUNna1FqNEQ3V0gwUw0KL2s1TW53ZjZBNEhwdlZ6
cGhsdGUzdm8yNTQrNHM4anlhbUpvNGp2VWNsYWJrSzhQdDhsSjcyK2NKZ2pHRGU0bQ0KQU14UzlE
MXBVU2REV1ZZckhwZ3VsZys2V1RIUnFoYmk2NDJVS2p1enU1Y3JNSitqNlJ6czlGS0pIQnZIVXpF
Mg0KbFpkaENsWjVvOXJscDNlck5jZUY1M3Jid2ptbVQrSVhHclczZE1zQ3VrejgvNFl4dXplUllt
c3hFcjZNRVdmTg0KRUxaczdnWUl2cWJYU1Z0a1YreFdxWUt1elJKY0lOaFF3T1crUmFOZ3BzZFY3
dW9VL0ptNzJsRk5XODdKS1FuTA0KbzlQUEF4UlhIMy9rWVBTaDIxTUorR25QVkQ1TjJzZVhjSkRx
UHgwUEt6T0NTTWQ1aXlYZkdGSTE5R3Q2SDRlRQ0KYmRZVDNCTGFHVFY2NjJPTmxBZlhORExrN3BL
M3JBPT0NCj0vWEtMDQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

------=_Part_2924665_665943932.1733371094684--

