Return-Path: <linux-kernel+bounces-435888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1789E7E45
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B0718874DD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF03D994;
	Sat,  7 Dec 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uk9VnxYn"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623122C6E3
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733548398; cv=none; b=Z+vQTf8XGEU8iogaKJxIUo4a/NleQlxTLUqRZd2yHlyjTiA6GGvrEg1lCXt5fJY0JlX70wb/6vkediNEDZC66B1bqp8D11t1DRgKS/R9T0e1ZyuvNr4KxHHvuJFqIacrTu2XDc6amVdNXBX+yB0s32f2qFsP3qQdxEXQS/WPgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733548398; c=relaxed/simple;
	bh=pSGawhxNpkahZpa3CMrsrawjBiV++nvJ40tdvZ922Io=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=actYvepSg424iM5S/soJ2QzXiZW5xoGA+b5pZpTLmieWshJHDfZCWz7niUL1s2g2x01MZA2rE8FlWPwmBYBA/hkydetajk4rWSPjPUN+sIe7sHaslGjk1pCAztNd3sC6/zjeTvecHwUe0WqpiSooRrJLElhLPA0MqvZ2LIF+11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uk9VnxYn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241207051311epoutp03a9a66e4e53d9b0ce8577b7ec6ee766e9~OzRPNaFrU2050320503epoutp03c
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:13:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241207051311epoutp03a9a66e4e53d9b0ce8577b7ec6ee766e9~OzRPNaFrU2050320503epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733548391;
	bh=pSGawhxNpkahZpa3CMrsrawjBiV++nvJ40tdvZ922Io=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=uk9VnxYnPN0lL2xkxh4M3k7hKxvBf2jZlI6LuTH6KhQt/LccFRyzJVF0Q/0x5S8b/
	 yc+iAleMvZC14xtTQueyCnxudwZ0U27RgU0VqogWZ8IOHZsNI6nDgb2yHl/YgG2WZq
	 qh7idb3aYhrvdqQ8m1ciGeFq+UasIAi333EB7Pbk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241207051310epcas1p26d547f08bdb0277a60a3be277f1e6ccf~OzROMPljK2276122761epcas1p2B;
	Sat,  7 Dec 2024 05:13:10 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.235]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y4x913LRhz4x9Ps; Sat,  7 Dec
	2024 05:13:09 +0000 (GMT)
X-AuditID: b6c32a33-5b18370000005ad5-d7-6753d9651d89
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.93.23253.569D3576; Sat,  7 Dec 2024 14:13:09 +0900 (KST)
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
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <3dgr7brrcsux4bhywmdu7v4ibmieb3wotb7t5qlent64su7z4x@qapri6zyjfbe>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241207051308epcms1p7e8315738f47c9bbeb252807b08edfc38@epcms1p7>
Date: Sat, 07 Dec 2024 14:13:08 +0900
X-CMS-MailID: 20241207051308epcms1p7e8315738f47c9bbeb252807b08edfc38
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmgW7qzeB0g22HJSyuf3nOanH+/AZ2
	i8u75rBZzP/6ic2BxeP9jVZ2j02rOtk8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91W
	yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
	I7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj15R/bAU7RCrmLN/J2MB4W7iL
	kZNDQsBE4sqR2exdjFwcQgI7GCXWfprL1MXIwcErICjxdwdYjbBApkRn00smEFtIQEmi4eY+
	Zoi4vkTHg22MIDabgK7E1g13WUBaRQTcJaZPNQcZySwwiVFiwa8+RohdvBIz2p+yQNjSEtuX
	bwWLcwr4SXzcsRGqRlTi5uq37DD2+2PzoeIiEq33zjJD2IISD37uhopLSvTd2csEskxCYBuj
	xI4jc9ggnP2MElMetkFN0pc4M/ckG8RjvhLXN0qDmCwCqhJfVhhBVLhI/NzfClbNLKAtsWzh
	a2aQEmYBTYn1u/QhwnwS7772sMK8smPeEyYIW03i0O4lUItkJE5PXwh1pofEyq7rbJCg/cUk
	MfX7H7YJjPKzEKE7C8m2WQjbFjAyr2IUSy0ozk1PTTYsMIRHaHJ+7iZGcIrTMt7BeHn+P71D
	jEwcjIcYJTiYlUR4K8MC04V4UxIrq1KL8uOLSnNSiw8xmgK9OZFZSjQ5H5hk80riDU0sDUzM
	jIxNLAzNDJXEec9cKUsVEkhPLEnNTk0tSC2C6WPi4JRqYPIUOPCr77e5enT4zYfyTU5VzN/n
	Giu19JesmO+9dt3itLO/FjpW709L8457Iso+P9zg+cVe/san61QFFTjnRpcFBmZmdCZe+t/h
	0cawc9f063bfOSJXKXD1MnnVvDtgdM+8xPpYNWuTe9qEm9se8VwM2cTacfam32XLUgn19aG7
	pFZlbjqzt/jsowlPtuocECvL+esc+ji6UPJs2jVHBq8C2caTxgUf5efYd5uVH5TffiWqaI3D
	3BNn5BhfiXl3Zk17591/rO3zPJ/0N0KZa3v2XZ7/pKuW65wwh3l/+u19qzyPn5/R4mrf9u3u
	1TizM/vnxzpPSHZ8aOltc+hQifAcTUOVZYbq5o8vpe18oMRSnJFoqMVcVJwIAL3/mSr6AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241204103802epcas1p3bb95970c978894677e1087ac20dc8450
References: <3dgr7brrcsux4bhywmdu7v4ibmieb3wotb7t5qlent64su7z4x@qapri6zyjfbe>
	<la6csftzuntp3w2etea5s2u63yjxvxcgicg7tbehnild4d736g@uqod6luq4bth>
	<20240918123150.1540161-6-u.kleine-koenig@baylibre.com>
	<556725552.2924666.1733371094684@v8mail-kr1-0.v8mail-kr1.knoxportal-kr-prod-green.svc.cluster.local>
	<CGME20241204103802epcas1p3bb95970c978894677e1087ac20dc8450@epcms1p7>

>Hello MyungJoo,
>
>On Thu, Dec 05, 2024 at 12:58:14PM +0900, MyungJoo Ham wrote:
>> >On Wed, Sep 18, 2024 at 02:31:48PM +0200, Uwe Kleine-K=C3=B6nig=20wrote=
:=0D=0A>>=20>>=20These=20drivers=20don't=20use=20the=20driver_data=20member=
=20of=20struct=20i2c_device_id,=0D=0A>>=20>>=20so=20don't=20explicitly=20in=
itialize=20this=20member.=0D=0A>>=20>>=20=0D=0A>>=20>>=20This=20prepares=20=
putting=20driver_data=20in=20an=20anonymous=20union=20which=20requires=0D=
=0A>>=20>>=20either=20no=20initialization=20or=20named=20designators.=20But=
=20it's=20also=20a=20nice=0D=0A>>=20>>=20cleanup=20on=20its=20own.=0D=0A>>=
=20>>=20=0D=0A>>=20>>=20Signed-off-by:=20Uwe=20Kleine-K=C3=B6nig=20<u.klein=
e-koenig=40baylibre.com>=0D=0A>>=20>=0D=0A>>=20>That=20patch=20got=20some=
=20positive=20feedback=20by=20Krzysztof=20but=20wasn't=20applied.=0D=0A>>=
=20>Is=20this=20still=20on=20someone's=20radar=20for=20application?=0D=0A>>=
=20=0D=0A>>=20Can=20you=20provide=20a=20link=20to=20a=20commit=20that=20req=
uires=20this=20change?=0D=0A>>=20=0D=0A>>=20For=20now,=20I=20don't=20see=20=
any=20benefit=20from=20this=20change.=0D=0A>=0D=0A>So=20the=20explicit=20in=
itialisation=20of=20.driver_data=20that=20then=20isn't=20used=0D=0A>doesn't=
=20look=20strange=20enough=20to=20you=20to=20drop=20it?=0D=0A>=0D=0A>Would=
=20you=20prefer=20=0D=0A>=0D=0A>---=20a/drivers/extcon/extcon-fsa9480.c=0D=
=0A>+++=20b/drivers/extcon/extcon-fsa9480.c=0D=0A>=40=40=20-350,7=20+350,7=
=20=40=40=20static=20const=20struct=20dev_pm_ops=20fsa9480_pm_ops=20=3D=20=
=7B=0D=0A>=20=7D;=0D=0A>=0D=0A>=20static=20const=20struct=20i2c_device_id=
=20fsa9480_id=5B=5D=20=3D=20=7B=0D=0A>-=09=7B=20=22fsa9480=22,=200=20=7D,=
=0D=0A>+=09=7B=20.name=20=3D=20=22fsa9480=22,=20.driver_data=20=3D=200,=20=
=7D,=0D=0A>=20=09=7B=7D=0D=0A>=20=7D;=0D=0A>=20MODULE_DEVICE_TABLE(i2c,=20f=
sa9480_id);=0D=0A>=0D=0A>then?=0D=0A>=0D=0A>Anyhow:=20The=20most=20recent=
=20presentation=20of=20the=20quest=20is=20at=0D=0A>https://lore.kernel.org/=
linux-iio/20241204150036.1695824-2-u.kleine-koenig=40baylibre.com.=0D=0A=0D=
=0AHi,=0D=0A=0D=0AThat=20link=20explains=20it.=0D=0A=0D=0AIt'd=20have=20bee=
n=20easier=20to=20see=20if=20that=20link=20or=20the=20pending=20changes=20o=
n=20i2c_device_id=0D=0Awere=20mentioned.=0D=0A=0D=0AChanwoo:=20please=20tak=
e=20a=20look.=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A=0D=0A=0D=0A(For=20the=
=20original=20=22extcon:=20Drop=20explicit=20initialization=20of=20struct=
=20i2c_device_id::driver_data=20to=200=22)=0D=0AAcked-by:=20MyungJoo=20Ham=
=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A=0D=0A=0D=0A

