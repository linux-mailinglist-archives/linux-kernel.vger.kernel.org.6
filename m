Return-Path: <linux-kernel+bounces-266626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8FA940398
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA9E2831BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F7779CC;
	Tue, 30 Jul 2024 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iRWjE2EN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1BC2F2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302800; cv=none; b=Ezz1n3RgQgpbJK37vTWzytAFQqzqZoGXYCkxfXGVUQLKSFZLGgj3Nwk19jNTqGwykz7W/IjdCv5+7gb9Y63aWympzcxA5pBJ6sh1O90u1+wRiqxNUrbLBEYutcsnTkpJPyKzRVkq8n2m7rHOkSt8fMx8GSyD81uWcULPTIfa768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302800; c=relaxed/simple;
	bh=BpjfebOz05C7JZVV+p5ipcYp6b3vih29sNrNTDUdqvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9tx9PWQBJiqh2KoVOjDV4KxpcESDXnrtOgRBKJ+/WTOMPFXYjFg8sgXnG+LGuz3Ld0VEFrNkTPUk4xljGby6dqH4bGSxiP0L5wNQfS8V5hsqqx6StXcArfGxqpOhRzgoV/gySo9q9GWkZhDd4O3FQgaldNMu5Har7RSDalUuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iRWjE2EN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U1OZgs018710;
	Mon, 29 Jul 2024 20:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722302675;
	bh=BpjfebOz05C7JZVV+p5ipcYp6b3vih29sNrNTDUdqvg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=iRWjE2ENrgkR2NQlqsbvzttaeNQloBAkAEQgOBsvCaoFqUOggIjPgVytQ1xRae0RA
	 DuvDheC4uRtFWIURqXfONJ5hlnE6Do1E18BJDsSBEiL0Rgfn1gZ56ho+bqFeYzNPjA
	 ho3t9KgHuKo8n6wKmloGaxxivtR62KUBMH3WbvG0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U1OZSP083287
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 20:24:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 20:24:34 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Mon, 29 Jul 2024 20:24:34 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "zhourui@huaqin.com" <zhourui@huaqin.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Salazar, Ivan"
	<i-salazar@ti.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Chadha, Jasjot Singh" <j-chadha@ti.com>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "Yue, Jaden"
	<jaden-yue@ti.com>,
        "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>,
        "Rao, Dipa" <dipa@ti.com>, "yuhsuan@google.com" <yuhsuan@google.com>,
        "Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
        "judyhsiao@google.com" <judyhsiao@google.com>,
        "Navada Kanyana, Mukund"
	<navada@ti.com>,
        "cujomalainey@google.com" <cujomalainey@google.com>,
        "Kutty,
 Aanya" <aanya@ti.com>,
        "Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
        "savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
        "flaviopr@microsoft.com" <flaviopr@microsoft.com>,
        "Ji, Jesse"
	<jesse-ji@ti.com>,
        "darren.ye@mediatek.com" <darren.ye@mediatek.com>,
        "antheas.dk@gmail.com" <antheas.dk@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Move tas2563_dvc_table
 into a separate Header file
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Move tas2563_dvc_table
 into a separate Header file
Thread-Index: AQHa10cEjfotFf/Vgk2obNCAlPwD9bIOUcYAgAA8p8A=
Date: Tue, 30 Jul 2024 01:24:34 +0000
Message-ID: <9f92b5275c3e4b7d896e90f8a654f11e@ti.com>
References: <20240716061123.127-1-shenghao-ding@ti.com>
 <1dc0518a-f0b3-4617-9c79-ac903ca9ee33@sirena.org.uk>
In-Reply-To: <1dc0518a-f0b3-4617-9c79-ac903ca9ee33@sirena.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Broonie
Thank for your feedback. I will resend them.
One more thing, these day my colleague and I want have some adjustment on t=
he=20
tas2781 driver code to support both i2c and spi interface, and plan to abst=
ract
the common part, especially the dsp binary parsing, as a shared lib. Would =
you
be so kind and give us some advice on it? Thanks.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, July 30, 2024 12:42 AM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com;
> perex@perex.cz; pierre-louis.bossart@linux.intel.com;
> 13916275206@139.com; zhourui@huaqin.com; alsa-devel@alsa-project.org;
> Salazar, Ivan <i-salazar@ti.com>; linux-kernel@vger.kernel.org; Chadha, J=
asjot
> Singh <j-chadha@ti.com>; liam.r.girdwood@intel.com; Yue, Jaden <jaden-
> yue@ti.com>; yung-chuan.liao@linux.intel.com; Rao, Dipa <dipa@ti.com>;
> yuhsuan@google.com; Lo, Henry <henry.lo@ti.com>; tiwai@suse.de; Xu,
> Baojun <baojun.xu@ti.com>; soyer@irl.hu; Baojun.Xu@fpt.com;
> judyhsiao@google.com; Navada Kanyana, Mukund <navada@ti.com>;
> cujomalainey@google.com; Kutty, Aanya <aanya@ti.com>; Mahmud, Nayeem
> <nayeem.mahmud@ti.com>; savyasanchi.shukla@netradyne.com;
> flaviopr@microsoft.com; Ji, Jesse <jesse-ji@ti.com>; darren.ye@mediatek.c=
om;
> antheas.dk@gmail.com
> Subject: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Move tas2563_dvc_table
> into a separate Header file
>=20
> On Tue, Jul 16, 2024 at 02:11:21PM +0800, Shenghao Ding wrote:
> > Move tas2563_dvc_table into a separate Header file, as only tas2781
> > codec driver use this table, and hda side codec driver won't use it.
>=20
> This doesn't apply against current code (or your other patch to this driv=
er from
> the same day), please check and resend?

