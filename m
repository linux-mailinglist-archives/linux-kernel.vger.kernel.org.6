Return-Path: <linux-kernel+bounces-200390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187E68FAF4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C8F281EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13791448D7;
	Tue,  4 Jun 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eTl6Oqml"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152A12B17B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494979; cv=none; b=RfjBiV6L5lKPMAqkALC+PY4JYkaSQaOIgTUnTvWwma5CCgJ/mPxE7rraG7SsvJakAHjRoYFoffg0+yn13IuVCdM4qWdM+h/eTp0J5eBrhz3LVH7DsdAM2J/RgL1lnDMgQgpsakaBtP4C9Wy1dNV6XMFv6/uhEvC8mYjUoxcHqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494979; c=relaxed/simple;
	bh=r6RvP2n9en7SM9ZCewNVBQx41RT6DI0t88AmBPjP4lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYJiatoc3vmg+1NVS1DDvT8jAi5aVGzua6eyr6kTFDNSj8tM8p/yeiEmBET7MWfNsoySx2rDon+DZbXOKEKwuwPCugOzhFuH4V7k4eDMhx3tkla9R2m5xB9Yi2STAGw1QrErTlHijedkdh/1IayLTTp8nWKQH7WcpU0mwRvvUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eTl6Oqml; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549t7Dh118037;
	Tue, 4 Jun 2024 04:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494907;
	bh=YP4oBrC+7QEADT2fGVE3UTVws0H5q4ZZzSJpBXFPj6o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=eTl6OqmlqgQKQBjiQ7Yt85XAqeOeCL3JpZB+jCb0ovOjP7zCXE1KIaH3Sxp2inOwv
	 7Ij40/O2KdgEn6ZutuLO3iauoFU4GZig3WFahZ/eJ8U8yMccodXDBhpX5ViLt6gWCp
	 RiWezmKB2R8sRETOd1EgHTOeUXHfKNCqctA0kONg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549t7oj025321
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:55:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:55:06 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 4 Jun 2024 04:55:06 -0500
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
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>, "Xu, Baojun"
	<baojun.xu@ti.com>,
        "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com"
	<Baojun.Xu@fpt.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        "Yue, Jaden"
	<jaden-yue@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
        "Navada Kanyana, Mukund"
	<navada@ti.com>, "Hari, Raj" <s-hari@ti.com>,
        "zhourui@huaqin.com"
	<zhourui@huaqin.com>
Subject: RE: [EXTERNAL] Re: [PATCH v6] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Thread-Topic: [EXTERNAL] Re: [PATCH v6] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Thread-Index: AQHaqS31kPp1+e8rVkmNZkec74ALOLGg2NiAgBOuXWCAAdixgIABGDzw
Date: Tue, 4 Jun 2024 09:55:06 +0000
Message-ID: <5cdc0aeca5df44a5a29e000f78b67b56@ti.com>
References: <20240518141546.1742-1-shenghao-ding@ti.com>
 <171623322336.94469.13172149100331733795.b4-ty@kernel.org>
 <138b621eeccc47329ec5fc808790667f@ti.com>
 <90d891b7-1978-4a6c-86c6-bb693ce764d0@sirena.org.uk>
In-Reply-To: <90d891b7-1978-4a6c-86c6-bb693ce764d0@sirena.org.uk>
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

Thanks for your comments.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, June 3, 2024 8:12 PM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com;
> perex@perex.cz; pierre-louis.bossart@linux.intel.com;
> 13916275206@139.com; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; liam.r.girdwood@intel.com; tiwai@suse.de; Xu,
> Baojun <baojun.xu@ti.com>; soyer@irl.hu; Baojun.Xu@fpt.com;
> yuhsuan@google.com; Yue, Jaden <jaden-yue@ti.com>; Lo, Henry
> <henry.lo@ti.com>; Navada Kanyana, Mukund <navada@ti.com>; Hari, Raj
> <s-hari@ti.com>; zhourui@huaqin.com
> Subject: Re: [EXTERNAL] Re: [PATCH v6] ASoC: tas2781: Fix wrong loading
> calibrated data sequence
>=20
> On Sun, Jun 02, 2024 at 01:11:39PM +0000, Ding, Shenghao wrote:
>=20
> > One of my customers requested tas2781 driver in kernel 6.10 to be merge=
d
> into kernel 6.1.
> > I wondered how I  can handle this. May I resubmit the whole code into
> latest 6.1 branch?
> > Looking forward to your reply. Thanks.
>=20
> You'd need to do something yourself - the stable kernels themselves don't
> add new features, and I think v6.1 is not updated any more anyway.
> The usual thing would be to do a backport and then publish it somehow,
> some vendors have git trees they use (some use github), some share patche=
s
> via e-mail but there's a bunch of options there.
>=20
> If this is for some OS vendor (or for use with a specific OS) you may be =
able
> to work directly with them to add the driver, some OSs are open to that b=
ut
> some aren't.

