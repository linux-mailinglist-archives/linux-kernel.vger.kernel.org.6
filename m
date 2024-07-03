Return-Path: <linux-kernel+bounces-238858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A7925238
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254E7282ABC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17125130AC8;
	Wed,  3 Jul 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AQo9Ti6A"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98CBA2D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980475; cv=none; b=CAYyv25H4ea+xQG2yWDnqB0Pd/NunjAP4psmqYnhrjtuEFHY+2F5kKVLI/H8YDpUG3jQ0YbUUZSiiBZ9Oc49yL22qB/nKvNQLawRhVVH5z4Z8K7T5quQvS5IDb5OMxOUyoAdIDw0JAE6pnEJ1EqoiizkzCA7TFrGrj74wJhnecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980475; c=relaxed/simple;
	bh=afFBUcRiUw/uSnUuZOl4J32FjnbvltPxLHc8UdKHsoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eg9Mekhbi9AG8sHu0ftXACKLdQvODvF4W/EUglz/vIlryB6/nbCLS8vmtaVDnypaeqw+ZcuSnaqj2XdMN6zlZbQf4+Jwbk/Zg6PB0JQ27VMP6YDU0X70+9KaxEpTXEnJNlT3P0kvmnMZRYhxCSt4gl+FOfSu35BgRt3xxQj/sZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AQo9Ti6A; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634JoKv086081;
	Tue, 2 Jul 2024 23:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719980390;
	bh=htFylJICkiDuwB5yYHq2LC3E7cQvuIoGFvuuR013PkU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=AQo9Ti6AXUmkJWvbZMYVNuj2fotDM1alb3Js9vGLtNaImA5uoHJaw9mHazZ+3vGP3
	 tP58YT7W5ES6hBWQSCK6LweEHYr9+uaMUTesoPo9qX1MhrzR05J+7gWSCjNd+gpiH2
	 sNGP4lWzVS948zUBOWNrIVzPXbz8tuTi01RtZ/Ok=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634JoUY121890
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:19:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:19:49 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 2 Jul 2024 23:19:49 -0500
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
Thread-Index: AQHaygy3zqcBdt6oi0KleesuzWGEKLHiIqwA///EuhCAAIolgIAB+XEg
Date: Wed, 3 Jul 2024 04:19:49 +0000
Message-ID: <c53c1f597e6c43e3874f4bbe1b467d24@ti.com>
References: <20240629101112.628-1-shenghao-ding@ti.com>
 <8245d8e7-3ff0-4f05-9f99-666e9693603f@sirena.org.uk>
 <664b818a177f4403bd60c3d4cd0bf4d1@ti.com>
 <7a44a36c-6f95-4c5b-a86d-044f9ad13ac1@sirena.org.uk>
In-Reply-To: <7a44a36c-6f95-4c5b-a86d-044f9ad13ac1@sirena.org.uk>
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
Thanks for your comment. Feedback is inline.
> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, July 2, 2024 1:06 AM
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
> Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add name_prefix as
> the prefix name of DSP firmwares and calibrated data files
>=20
> On Mon, Jul 01, 2024 at 02:00:13PM +0000, Ding, Shenghao wrote:
>=20
> > > I'll apply this but I do wonder if it's worth falling back to trying
> > > to load the unprefixed name if we fail to load the prefixed one.
>=20
> > If fail to load dsp firmware, the driver won't load unprefixed name
> > firmware, but switch tas2563/tas2781 to bypass-dsp mode automatically.
> > In this mode, smartamp become simple amp.
> > These day, I met a case from one of my customers, they put 2 pieces of
> > tas2563, and 2 pieces of tas2781 in the same i2c bus. In order to
> > identify tas2563 and tas2781, I think name_prefix is a good solution fo=
r this
> case.
> > Looking forward to your comment. Thanks.
>=20
> Yes, the name_prefix is a good idea and probably people want things
> specifically tuned for the DSP - I was thinking about error handling or
> upgrade cases where wrong calibration might work better.  Bypass mode
> means the device will still function at least.
In bypass mode, tas2563/tas2781 can still work without speaker protection o=
r audio acoustic function.
In case of only dsp firnmware loading without calibrated data, tas2563/tas2=
781 still can work with
default calibrated data and default audio acoustic parameter.


