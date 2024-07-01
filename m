Return-Path: <linux-kernel+bounces-236401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39991E1C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5517DB2681E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E83D72;
	Mon,  1 Jul 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r+sBtxYi"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B014374E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842511; cv=none; b=njlf7BahheyxdswfzPaJmkTNQqVZImiuKz1tRI6JE2lf7J7tVaRjEVpDQ45ANI6lY6qfMdODOQIiA+fr8CjDabxMEPEzd3ehvI/kxIf5tOFO86QFrrMBhU0xbZC72oO2m6ZxA03Z/RRg5OeMEiy1Db4wJu5Hc6aU03MZ1fDceGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842511; c=relaxed/simple;
	bh=3reg4i/O4YiAE5aKRVANGYOBm/8AOHKu8/Lh8yOWM1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gQMbiNbTJzpm+lR4mjWhQQTosLicue/v+nHih+PsAgYZJtYeZsmovXOTjp/3DomJO34IGysg2pmdth3rh9RTiZ8XdIBMbZWD0d964kb1SYunVugOJEeQ7Yj+qODHgVBUZD1qEnhiqraLX20NLCGX1en/MXT10XW0JofpPwbIH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r+sBtxYi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461E0EUt074153;
	Mon, 1 Jul 2024 09:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719842414;
	bh=jjxKQjXPGDBo7KD1g9SLb7Db/+v0i0QFj/MuvZQRvGE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=r+sBtxYiyUPBmKIZZ+6Li8yXVLl8t//deqhOz+TkK1RE0sVS9TD9AEtgfU1DTkwy5
	 g4hJ5tWBXY3HHX2Mq59rXbviXtUpxwne2CBnsjsi3deohEZ5Luq27mtf7wWxWbw0PC
	 Yrc8Drq7UJboRayPxaXqR0D/54nuCIt8GT/e1doU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461E0ETD003409
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 09:00:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 09:00:13 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Mon, 1 Jul 2024 09:00:13 -0500
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
        "darren.ye@mediatek.com" <darren.ye@mediatek.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the
 prefix name of DSP firmwares and calibrated data files
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the
 prefix name of DSP firmwares and calibrated data files
Thread-Index: AQHaygy3zqcBdt6oi0KleesuzWGEKLHiIqwA///EuhA=
Date: Mon, 1 Jul 2024 14:00:13 +0000
Message-ID: <664b818a177f4403bd60c3d4cd0bf4d1@ti.com>
References: <20240629101112.628-1-shenghao-ding@ti.com>
 <8245d8e7-3ff0-4f05-9f99-666e9693603f@sirena.org.uk>
In-Reply-To: <8245d8e7-3ff0-4f05-9f99-666e9693603f@sirena.org.uk>
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

Hi Brown
Thanks for your comment.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, July 1, 2024 8:23 PM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com;
> perex@perex.cz; pierre-louis.bossart@linux.intel.com;
> 13916275206@139.com; zhourui@huaqin.com; alsa-devel@alsa-project.org;
> Salazar, Ivan <i-salazar@ti.com>; linux-kernel@vger.kernel.org; Chadha,
> Jasjot Singh <j-chadha@ti.com>; liam.r.girdwood@intel.com; Yue, Jaden
> <jaden-yue@ti.com>; yung-chuan.liao@linux.intel.com; Rao, Dipa
> <dipa@ti.com>; yuhsuan@google.com; Lo, Henry <henry.lo@ti.com>;
> tiwai@suse.de; Xu, Baojun <baojun.xu@ti.com>; soyer@irl.hu;
> Baojun.Xu@fpt.com; judyhsiao@google.com; Navada Kanyana, Mukund
> <navada@ti.com>; cujomalainey@google.com; Kutty, Aanya
> <aanya@ti.com>; Mahmud, Nayeem <nayeem.mahmud@ti.com>;
> savyasanchi.shukla@netradyne.com; flaviopr@microsoft.com; Ji, Jesse
> <jesse-ji@ti.com>; darren.ye@mediatek.com
> Subject: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the
> prefix name of DSP firmwares and calibrated data files
>=20
> On Sat, Jun 29, 2024 at 06:11:10PM +0800, Shenghao Ding wrote:
>=20
> >  	tas_priv->fw_state =3D TASDEVICE_RCA_FW_OK;
> > -	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
> > -		tas_priv->dev_name);
> > +	if (tas_priv->name_prefix)
> > +		scnprintf(tas_priv->rca_binaryname, 64, "%s-%s_coef.bin",
> > +			tas_priv->name_prefix, tas_priv->dev_name);
> > +	else
> > +		scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
> > +			tas_priv->dev_name);
>=20
> I'll apply this but I do wonder if it's worth falling back to trying to l=
oad the
> unprefixed name if we fail to load the prefixed one.
If fail to load dsp firmware, the driver won't load unprefixed name firmwar=
e,=20
but switch tas2563/tas2781 to bypass-dsp mode automatically.
In this mode, smartamp become simple amp.
These day, I met a case from one of my customers, they put 2 pieces of tas2=
563,=20
and 2 pieces of tas2781 in the same i2c bus. In order to identify tas2563 a=
nd=20
tas2781, I think name_prefix is a good solution for this case.
Looking forward to your comment. Thanks.

