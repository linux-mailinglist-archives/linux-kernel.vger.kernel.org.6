Return-Path: <linux-kernel+bounces-263054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29293D069
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BEE1C2110C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C9176AD8;
	Fri, 26 Jul 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lsCeh7av"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD5176AA6;
	Fri, 26 Jul 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986139; cv=fail; b=VDsqOJinb7FJWenusuVcC6jPtcyiRtloz+rZH2FqG1OS3mvetSvew67jtGXqFq1hNFr63P7/BwH/r3BJNkmrgiCZ3/d0g3UOlG7SfNX4ZAWM60t/rv8a+fLTL1zKu53QcoMrY6fT8C1ZD+DiAhpvnzjF/Of3mzAqYmSIdn2E4fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986139; c=relaxed/simple;
	bh=h7XRgAbQ4YQy13OaZaK8QrbM2AdPZsDrVTy2paoYEDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAM8m7hwUPbVr7vGsWYGMvaqvI5YKgGgrpNG63lPH5YZw+z61M/AWgXPWsOehSZVhfdJ6LRwrAwdJ/eM2YX757dR4mJcUGp4f4qjE3PZtFA3cBqcMOvvQqnsMPELIwlfKeucyvTqGd24gsTRiyRPHVJilyleXtD8ZM2jvdWK0Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lsCeh7av; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeje1YL/1lRAVkzrlbnit7GTVIyNlhLZozNnvwO4DK7ZQ2m+C1qYPLo7VDGNeY9kCsMyruu7JnQhFUbvRB8HXkiZLEXOusmjD2I2ygx/l4QedW494HTikiqiET2su4R5CppKjwymm7/fe4zUDcbJCTTjJrNb+t6xiby1PP/jDKcd1sIxOTtLD7/ejLPPioNfyy7j5Lz+IUuPgjaZCkzlIpZI7MxhiKpeLAMiwIBtHVZGOoguUjyDQY0cWfk2EgY00cbbWQsEEN619eTIcKcv1C7lcPonlEt+vt/TQjHumJYX5cDHgopHetS+ZCdQNxeG9ROECmox9uSJ8WRw3ussRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eEIEGvtRX2KHwcJD93BNqKL+DlXzu0KP3wbHQfcF1w=;
 b=wIzjpsKLMd8fdRY387CE0BhNDT/os9JqAC6tium1P/WKuQN8S6MRe24C539g47De4E9O80o4/u5ib+px5AQRZewJtswAx9S/53FsWLEJoBiHXpaazBwG2rbIvwctf7zc+ZSe8lfKXBantajFPhYhiEXK3QSaYfF9ewHwihwPNV6Xq7p2K3ZH5EehiMb+kna49YQs85nBqweNlj9aKZlyL2IVwdom9pIHTn+VKUaa5mBGrprK5TFNfiQNuwaOIMqW+P8SxLwjy/a2ZKRbpulyBiQE8yrjHkobut+JbuVuKtCzQQV04v+COhAmpppHH1XHahqiqHuc30fKesUyULD1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eEIEGvtRX2KHwcJD93BNqKL+DlXzu0KP3wbHQfcF1w=;
 b=lsCeh7avFMZWBVaGyqy8pINAzI5LNN0n0AB52mj5jigXLI5h7WPPcDGJTVTrHM+4BiU2UbF9Nf23aOhyiJ1OhFvQxWVnoVvm4qr8TfDlSOb162io0DHfVCyCJmB5+8xtyW3lFlTsLRdryequa8xsH5LV2MUDyt0AXISy3/YFh4osnNvu/u4F03ddKFpHjEIG7SXClIFzyokFK4cBGbWghZb+WoMCv8nYx5IYtLcWJh8Ku6KpnUeT66CnWb4HaAMAsCf5F/id11LTBqGCuJF2Rfh6bWCYK9dzk9WZL2ajdlSxMt09aM/JRMnswS44KXdG1+7znXlZQSWRAXjW0Mi4ug==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10230.eurprd04.prod.outlook.com (2603:10a6:800:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 09:28:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 09:28:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"kamlesh@ti.com" <kamlesh@ti.com>
Subject: RE: [PATCH] clk: scmi: add is_prepared hook
Thread-Topic: [PATCH] clk: scmi: add is_prepared hook
Thread-Index: AQHa3nDdvyZ63JzdWUmPgzcBzaVdhrIItZOAgAAJSyA=
Date: Fri, 26 Jul 2024 09:28:52 +0000
Message-ID:
 <PAXPR04MB8459C5A372FADDD970BCA33088B42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
 <20240726085305.sb57f3i2ezvtwrwz@dhruva>
In-Reply-To: <20240726085305.sb57f3i2ezvtwrwz@dhruva>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10230:EE_
x-ms-office365-filtering-correlation-id: 4c0e8c2c-4829-48f3-c6e7-08dcad555d6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Nm+KOvC9OCv3gcHvvst7jpnHEDhzBoALWnV1+e6RI3iDdaallNCyiv2hzH4C?=
 =?us-ascii?Q?SiQ+da2EhADbzM7tmLQFX6sJkgWZRhqm8UvQ5kqRvshBjjQCY7mMSxXJcZkX?=
 =?us-ascii?Q?ZuesadHj0i0P9gV5q8kcjsRHWnYvpn2Xvr04TMR7fmsSnydTGFKB9ikRv8gt?=
 =?us-ascii?Q?uYwzJbivMuNiT2Q5cW3lSzANieWKJyylj4lyAOs+gk1W137e/mLCChM51DR1?=
 =?us-ascii?Q?m/PSkY6th6FEGh3AOvGwMpJmdC3gck/LtywFfvwTkAVcXHSdDUA5vUqnWhqf?=
 =?us-ascii?Q?CcJ9rLpLNJOgNwF6ppu80igtLYRTdt+aEByBNxNuHZDIBPDVmZIYjP/JEb/F?=
 =?us-ascii?Q?eV6jYPHwAfh8qwmZ5sShuxzD2B2uPDvf72gGSeH5Unqr8Zi2JGmtI0qxJTlb?=
 =?us-ascii?Q?GRScpBMYNECM16mg5i2tJ4Wja3Ge42CYtFbjr95ajNGkBdsPGL9hlJWPZRG5?=
 =?us-ascii?Q?71U/59pC+ck8E9Twz+qhoQeZO/lSltevY/1yDbTb4koO3CrdVSHRJvAtccNh?=
 =?us-ascii?Q?Aq3HI9lSHOjhhJKN6wDWlqzNY+0ayLklLxMRq/owJJG/vZ6YxErWCyQtOcHu?=
 =?us-ascii?Q?YVlmBx8rgOWO2ps3DYaQ5BWQv2rYVqCyljn4J60Onwz76EsQdE/LNDdX1zSZ?=
 =?us-ascii?Q?RqjWsISlBiV7RsbBhW432GvH9c50kDoKLkN/y+jchlstxNR13L4O3Za+AaT/?=
 =?us-ascii?Q?cC9T4mnLmxhJWD2TmShKcnJzehcyJopjoTWIasYD3G5pRRDEoYW8Ra1/9nSW?=
 =?us-ascii?Q?pjBpSAVf135181HsG2I+DdhqlQANdqDl8jMul03Rq2pvNKVYfD0SkmTdPFWl?=
 =?us-ascii?Q?NoknjzzG/f12eSWKq07oDkBkrOeY9gi+aCrmdkgY+Uvj3eLVqciRz+vAVhRp?=
 =?us-ascii?Q?V3Bkv2Vija6MMyHlEI4RzZbmjnZ3YNLbaMF46ZkeEB65xTyjjFp5QtySd0NT?=
 =?us-ascii?Q?bNFucPAAmnCA4KIMmSiUCgZSEJnMR3ZJGOr5CwmnsvE4AzltcW9NxdkxDAAI?=
 =?us-ascii?Q?/jHKsf79k3If5veV0bYeC1EOCDNTOesDGNrWLEK7yF9TPLoflEljFVg2w0Qz?=
 =?us-ascii?Q?C4yzZ3MPNsumS/VbCiq+Lic7e/GsfMYgRVo5xtDEUBqEkklOjwlITOPxOxQG?=
 =?us-ascii?Q?nGJZFALnhfwebG9gcaHh5WF7zcGWg8FdZYQpy7caCxRgB7fhaETdFpE11mBO?=
 =?us-ascii?Q?BnjiRYeIxeJfca2XCbg4EFmGZe7ZmrT8jwnB7GksiDSDX98pKF4giDr8hqZI?=
 =?us-ascii?Q?fgL0aXf21r/pV87dHKE9kImN0WzahR/pHS5tBhY4sbrJoz6h3NwGYSigwuua?=
 =?us-ascii?Q?4IgMeltwLiCNzwrtuaaSm+bkJJJc+hDmLDL/mitN3UukrL9LPQ1lyRytrSEh?=
 =?us-ascii?Q?X7zeV812K4C5xbkVjei69qJ6Mzr1NgvzCGXA9o2SvvjAD0IjHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0muu7Ad0VqXiLkExKbBkyeeLOsJk9pgygN5axIYOHrVCq2dd0787SVP42KSb?=
 =?us-ascii?Q?Jj4CgkiWr0i13cVp8wbs9fKM0zQ1mPobdopjnnk7/sdEhuGBFFjDCgUrkQUz?=
 =?us-ascii?Q?zArrO35EC+OWbNN/jMGWD/8GVyppC8UrFdh+iELnXHhn3QICBm6GbMXuOLBD?=
 =?us-ascii?Q?CWKLQrbgUsGL4V7fE29Dhh3qPFl+R0eTkMrd63PTy7wp0qoMhSgntSNg9i4k?=
 =?us-ascii?Q?8MgbbadajVmEIE4GAWtvjkPupifORU7hhyFSvte+/301DO9WJ4Znk5Bcm/uC?=
 =?us-ascii?Q?NTfwp34fxt9tJZG3eUPXiZ3LJFjngAsoUqHdN3AvC/LqMLeqCapgDYf+znMo?=
 =?us-ascii?Q?ldOXzPEMeqkFzHT/NGaWaT8j0tOFWIIERLnJzKrvNCsDlvQ3B4zaQqa4lZim?=
 =?us-ascii?Q?mJhwjzNPcJSdF9KJ/e//COd+RZkH3PvRYe8JS/deJv6d5i46sqtrvbsJZod1?=
 =?us-ascii?Q?E9CT6QcNeusnc2j8qkC2t8cKUqHysA2TBvWwS8YE43Y4g2vn9sflU9zzGEIg?=
 =?us-ascii?Q?Mp82YSxhYOOfLyx+phT0ZfSN2Q9RZqISnKm9ey15aRHNqT4oOqTAk3gAxSMf?=
 =?us-ascii?Q?G/5L+GBlyk3+etfF+/NP143SJxl1uQ1BzwhpcWpwlUUTnh+wo5PaK4cDJkWh?=
 =?us-ascii?Q?Jbq4qHpm5Krn4wUnjY+6q6HStDcijNplW/RcS9S0DO7PqMm9uU6/5rQNNuzY?=
 =?us-ascii?Q?G6Qt62aQogoKfQUbpWDvAz3xfdgn4CsgKVa6wNWNSVZEcdzuK7Q6R/3IwleE?=
 =?us-ascii?Q?qKjumBVo/LG3pjS9fPqVkHHRyeJHQg2VRhoPEdimPA7ezcs8+/9Gw1mmxAGc?=
 =?us-ascii?Q?FYCRlSY93jaKTpgV2bF8ytyEvX02TVZxmtc2o+XFVOnUwAvCunmXTKkTu1cy?=
 =?us-ascii?Q?hKEbG4P7vc28VklzBvwizPo/w+O1RlHUNqpe7lrtKipHJW+h6Lo3jD05000s?=
 =?us-ascii?Q?tK7v//derF5lHIPa6meJyibWYfKMpHoygdK1EyUbaFnoPTAeHJhj1X4JS7vO?=
 =?us-ascii?Q?oxMLFHif7DFI0QU5k8o10/phZdw9x4zVwbl+jMiMQQJh+2kubZ4tl218l4yK?=
 =?us-ascii?Q?oraHiwqXcI4MTNQwlidTZOJosVstAcdb7jF7c+6xjbYBBAI19rQuMmCUt+5A?=
 =?us-ascii?Q?Hg2h2TbFNiv9vJhitTBMDPHvTjgQAhBDE0k7Sj85EihBf8fqS+qSP7mY5ImS?=
 =?us-ascii?Q?bRkqfUSgVsdtckAaZkoPcN/emDwRC+7VgSyAGy/hxTth5ySlHwDsneBrQUAm?=
 =?us-ascii?Q?nrEKzXCaIEBsMZUFPdQItXsmv4Rbtlnv2ceeghEI1hQq7HmlMscdZN/hB5ri?=
 =?us-ascii?Q?RBzA8Ejh1+gdoAG6yC0wwAnVijbS826URy8gCsE0L+JsmMNI+m54qCc6A0K+?=
 =?us-ascii?Q?U11xgqTmoAQw/ubMdcxahdYTMcgd3VhbX1+vYpZfEgfjJRV5ftBL6JNIELHx?=
 =?us-ascii?Q?lOIMYN0inF4oNsGeSXqDrFruJ2pBTEXDAD7Y1PsEF5GWjopLJr7O1DHdPxXi?=
 =?us-ascii?Q?TUEM7Nb6v4zGz2u2VKMPqXiZ/TwZCAyFhIfzRws0N2iqnc0IJqxNiPZAzR4+?=
 =?us-ascii?Q?RMvklaVbYj21mNZm0+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0e8c2c-4829-48f3-c6e7-08dcad555d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 09:28:53.0473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPM9CRk8x6lI1zoDQfcH1s9qVGlZHedxI/hwPnZ2e9wXilqxz44rc4xhRmz+PvFtOq8FHrKC05TM/38Fkz2hSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10230

> Subject: Re: [PATCH] clk: scmi: add is_prepared hook
>=20
> On Jul 25, 2024 at 17:07:41 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Some clks maybe default enabled by hardware, so add is_prepared
> hook
>=20
> Why is_prepared when there is an is_enabled hook?

This patch is for non-atomic clk ops. The is_enabled hook is
In atomic clk ops.

> See in the atomic case we already have something similar:
>=20
> ops->is_enabled =3D scmi_clk_atomic_is_enabled;
>=20
> > to get the status of the clk. Then when disabling unused clks, those
> > unused clks but default hardware on clks could be in off state to save
> > power.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/clk-scmi.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> > d86a02563f6c..d2d370337ba5 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -142,6 +142,20 @@ static void scmi_clk_disable(struct clk_hw
> *hw)
> >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);  }
> >
> > +static int scmi_clk_is_enabled(struct clk_hw *hw) {
> > +	int ret;
> > +	bool enabled =3D false;
> > +	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +
> > +	ret =3D scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled,
> NOT_ATOMIC);
> > +	if (ret)
> > +		dev_warn(clk->dev,
> > +			 "Failed to get state for clock ID %d\n", clk-
> >id);
> > +
> > +	return !!enabled;
> > +}
> > +
> >  static int scmi_clk_atomic_enable(struct clk_hw *hw)  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw); @@ -280,6 +294,7
> @@
> > scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
> >  		} else {
> >  			ops->prepare =3D scmi_clk_enable;
> >  			ops->unprepare =3D scmi_clk_disable;
> > +			ops->is_prepared =3D scmi_clk_is_enabled;
>=20
> IMO from the decription and what the function is doing is_enabled
> makes
> more sense here to me, unless there's a better explanation.
>=20
> Ref: linux/clk-provider.h
> is_prepared: Queries the hardware to determine if the clock is prepared
> vs
> is_enabled: Queries the hardware to determine if the clock is enabled

SCMI firmware has no knowledge of prepare/unprepared.

As wrote in the beginning, this patch is for non atomic clk ops.

Regards,
Peng.

>=20
> --
> Best regards,
> Dhruva Gole <d-gole@ti.com>

