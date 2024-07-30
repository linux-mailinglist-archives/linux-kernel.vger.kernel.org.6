Return-Path: <linux-kernel+bounces-267674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5494142B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3391F25399
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E51A08CA;
	Tue, 30 Jul 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kYwbmgRw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB04335D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348980; cv=none; b=L26M2g9GBJjI6fmQwfzNUPvMbHScnpLMhB2C5pcC9S1yv57FLM0O7MylPs0GaUE0Utow62KcdTM4klZDN08bCeXbzB7RatxzeGEoXOWj5bl8UOg/D8pJ90NUZFKlFce4OutsNg3mr1r14dlNIwudgd6JxE6KmdZqkI+UmjwdvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348980; c=relaxed/simple;
	bh=fzsxcMO6k+mrsgGKiQiUun0Ododx3jXSBjCYHRjK8sY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9cyjXScGkeT7yDNCA6buhogeymHC7IK1h0TdIY84szNkQ82svV6pgH8RSfBqvZf1jct7uCbr3TkYW0eUPesvLIM5D5eaVDC2grbLEa85LdRFm51BP9eywzPvgecKQ3qJl8a1TqL3tnRr+w+LDMzvbLypLPpqnrtbAXtU4Bz9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kYwbmgRw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46UEEJlP060203;
	Tue, 30 Jul 2024 09:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722348859;
	bh=o4TOsK/Mp1AnHRHmNr5JPZMpiXc8I/97ClXsJCflGPg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=kYwbmgRwgQJTz+zoEBv5FBk99ZTdc/wOXxoig2Y6EiRoyBe9JsK//6EDwmvZDqigq
	 4Gf5Ek/lWWEMim/7oltXNf8Egw3vQU/L7KlAWkO8tLVl4I/o6/3lUKyU2CYvK7DIQ/
	 sOYYBk9orMeJlDCgVXTszvQpZGtfxdByFI9+DVRE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46UEEJ07120754
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 09:14:19 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 09:14:18 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 30 Jul 2024 09:14:19 -0500
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
Thread-Index: AQHa10cEjfotFf/Vgk2obNCAlPwD9bIOUcYAgAA8p8CAAQ6AAP//yVtQ
Date: Tue, 30 Jul 2024 14:14:18 +0000
Message-ID: <962c985c3d894e3e8f0594022b6ae383@ti.com>
References: <20240716061123.127-1-shenghao-ding@ti.com>
 <1dc0518a-f0b3-4617-9c79-ac903ca9ee33@sirena.org.uk>
 <9f92b5275c3e4b7d896e90f8a654f11e@ti.com>
 <e8ce11fd-ff6a-4ca0-ac33-5abf20cf242d@sirena.org.uk>
In-Reply-To: <e8ce11fd-ff6a-4ca0-ac33-5abf20cf242d@sirena.org.uk>
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

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, July 30, 2024 8:27 PM
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
> Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Move
> tas2563_dvc_table into a separate Header file
>=20
> On Tue, Jul 30, 2024 at 01:24:34AM +0000, Ding, Shenghao wrote:
>=20
> > One more thing, these day my colleague and I want have some adjustment
> > on the
> > tas2781 driver code to support both i2c and spi interface, and plan to
> > abstract the common part, especially the dsp binary parsing, as a
> > shared lib. Would you be so kind and give us some advice on it? Thanks.
>=20
> That seems like a sensible and reasonable design - factoring out common c=
ode
> is a good idea, there's a number of existing drivers doing things ike tha=
t.
> Possibly the biggest example is the Cirrus/Wolfson Arizona drivers and th=
e
> wm_adsp DSPs they use.  Do you have specific questions around this?

Thanks for your advice. So far, I have no specific questions. First, I will=
 study=20
Cirrus/Wolfson Arizona drivers and then find a suitable solution for tas256=
3/tas2781.

