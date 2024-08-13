Return-Path: <linux-kernel+bounces-284556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A76950263
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFD7286531
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B618A6D6;
	Tue, 13 Aug 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4F6wOuO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301E208AD;
	Tue, 13 Aug 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544737; cv=fail; b=b/GBU4N7yGFmTrIR6fAIU7XL8sqtsgzVtgGM/+ab4wmTiG9/5OoiupxNkAYkfEkQZFolpD/JBAz9fAzcUW/QG0M7mqrVZ738+k4UZ/p4PpxDRdEgNYdXsatAVVtPagLXA6FvBRQkq1yVQ3OORdVeSvfxnKTMpotUNspFyeFOwVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544737; c=relaxed/simple;
	bh=LB6yT1D1KLoriOXwlSyiJ2c40EoV/BbUNVU14o+1hRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jE/PQzyGsYhj79blRAYr1byyTbhCrQtNdEp+fikVjIWm/4SHiG1rTWGh6YaDub1LFnIAgvZcHvtC9g6rM9VIFRctHEsU2YbasHYoVBs+QwlYTKCJdRxEyfdf/PxCJisO2CleXrmZA+XkxgDxb+2F0ZrYYVAu/qLIjNdjnrAqNAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4F6wOuO; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEgTPhCEfsk87GiiWxRyqzU++CI9FtWIW0H8LL97lUlklQrqHPxiCSXJcOYuRKmtMC1kE7sgpODLBHIrYB/hF28K5nsIQuIDbtPrUzvI9el7Nq0+8XZox5D8xxJBw4751BWxCrvx2+jBBL/HqKmeiDiSA+fI0NthD7eYXIdIxITaZaRlJoi7eTQaMYAacipsZF0lBCz6rD6s3k1VxrGay/mK+OqH9M8WO3LpoAwAIxJOSRWWJWx4u+a543qH8kkXE2PSEv9qXVQTAjbfyZJ/d2hiogq+J233pANpetLZUozmVcy66dsL33733seC3lgHOdbk/hFvipSSfeXKz1Ds9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0kfbE87sv4GE1jYfYrTYDfMm9J5+1RArU70zcg248o=;
 b=W4d8R8V8Su7N3fETmkyke//gelErRUfEEB5RT7cQIwLroQYtWnMk7tLvCKTZHl2R1JFxJlQO7sdB9fTyPxHUh8JRynAXLr3PbMXrLdjEKc8/rPN2GNJulfcCcvu2IDBgEbsDN/MhFG74HCDqj1IHQlZjYgBBPBB7sC4vg6YgOKRFaimlq1Gjh3iVfcf/bQy+LzVYAXviBByyiQIPNrGydEGOklRXhZuoEOPcYTjPH9bRviREG/N6dv0EnHT4OApz31ZcaHEyQmMx1yRQgtbgWsdZtg7OdSOYWrLDzAKNB41Cnx14d4rS6kUqGa/L5xdy7HA7Kz3m7FV7tiRTPG7aAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0kfbE87sv4GE1jYfYrTYDfMm9J5+1RArU70zcg248o=;
 b=F4F6wOuOdfilHcvyU5+tN4Rndm7Pqjf8LVxWh03dWnit6FQF6YZGXg48IyP4H1iZZCnStdlMJN3xbFvm5b00yGriWU9gtvRa7Gu2772BK4HEEeCxQZoSo1/gLsiI1ubV/jBbOVVjKQ4aropaziUbJ8ZsxIGWRMMn2IZidIuqCLU2Zn6t+CSvQ/KsV4K1/725X554RumSfWBuVGtoTL/PjYbOiLqXai0fIcjRgIuHdAuPjxJEn364qJVpImnnCVh7BIEatGPhb24O2FIbZ7q+TYfPRo+9sF0mpf9ttwkkPMla8cVe+O2+TjG5XgyiKyKWBgyxgFwNicwPzBmToWtToQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 10:25:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 10:25:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"saravanak@google.com" <saravanak@google.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Topic: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Index: AQHa4YQqp/DPlb92g0GK3FOKE5oYXbIk+n+AgAAWN+A=
Date: Tue, 13 Aug 2024 10:25:31 +0000
Message-ID:
 <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
In-Reply-To: <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8472:EE_
x-ms-office365-filtering-correlation-id: 2c671a08-5580-47cf-25e6-08dcbb8242bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x2oWhVRWOmK01LuJrblPIGetPDbH0p4kF5Y7UdW6BV8RTlkdrsKkzeoIf/Ut?=
 =?us-ascii?Q?zvlZmajhGdpXdw2Bj25uIKGSXnFewiYwTMOvzTmSLQ1ZTujZ5oQBdp65aVvX?=
 =?us-ascii?Q?ntxPgWynNfkfYayqjz4FkhetLlZwMSveAxt7T5ntTwNwS/YrmcRdTn429Oxx?=
 =?us-ascii?Q?Huwj2Xz0qD2Zp90c6qDkNB8Ov/hvYP6ysy0qEWRmxzylhdrRIJH8M9S9PM9d?=
 =?us-ascii?Q?tukID9JqokK84yrj1k5Qw0+gj/CeqwhY5RYncK80Ez1q2etRP7ikF++rHSAn?=
 =?us-ascii?Q?pOcH/NYG5VuRL9Boh/Ugi4uaY1zGulFreFMhMd6otJ00kEXQehKWSKFDLz5Z?=
 =?us-ascii?Q?wfQ/XCx+Dw0eQidXl4zdhhsgbNFk106AIO5yEcXQ4mroPei9lCtFA0c0H2ty?=
 =?us-ascii?Q?lFuZiQ8i4s104xUQZSWPusDDCuKVy9zb0EHdnujVuthZEUEh2lr1qOcwXsiR?=
 =?us-ascii?Q?xMFqtojmThOKhjaTuf3O6olXH7JISNN2lnh6POehdytN+ko1GS/oNZg1rCrC?=
 =?us-ascii?Q?suVVYubcrYV1gLFdjtStj1MvemOF6uNoKpXNrNRu8lScaCamtYXFbwCLLOeg?=
 =?us-ascii?Q?aQt8PX9dTw+cTK4xzV/bDcUcldWXb16HYTb96a/gWXfvk/88ox6VksrmEfv8?=
 =?us-ascii?Q?WqXchHNGl1n5lx+CQd1drqx8En7ZWAv0a4pLSkKtw+QrU3s/7MSc3ynabKX+?=
 =?us-ascii?Q?y6v9PbZLYPB8IxnpTCjBpeoaWtiM8+IWcBlIw/URV96I+hHuRV/KzTxGu4Hx?=
 =?us-ascii?Q?ibmHeI4J060Dx7TCIPmAUxGHjpDJkH+OpFQBPMMJhpTy7St0O39zmBAgl3ij?=
 =?us-ascii?Q?4dUT5h3KWwBOPUt05DqX+boW/c6nAgW07WrrPAzQjQTheM8Nr/c+oTCJEhhm?=
 =?us-ascii?Q?X3Q2GOeMfQExLn44nj1y8iIHnPRl5dalmHqKt4Q89DuoIHnwYAUdIqQluUbq?=
 =?us-ascii?Q?mhI98R7/1lP1TWIEwlPcoa/aRTw0+d7wDTEIKH9l8tILvlSa8EnUjdOWtaSM?=
 =?us-ascii?Q?etgLLz1tQolsWilpyOLBxZvBQ1GPc6cW/8s16O3s97ytwMfWnCVO7FMPknKc?=
 =?us-ascii?Q?E7uug7gOy61dKBACirPMSk1ChdqhTnPmUrd3l77rJAGOXooiY//YBQVBlIHF?=
 =?us-ascii?Q?Gd/6lMwk8n7d9ERqgRh6QbLObk9MlMrxURfCGwjjJvxvn3YXZtwwtgcj8D6Z?=
 =?us-ascii?Q?cHvbAuNxAb1k+RMGuChBIBZrXweV+az+qsbEq3cvRlDIzYfSEaWNVhrfWZZ+?=
 =?us-ascii?Q?mghgskPjPOUm9KJqIshZzVUex4LCq++U3zJRuXtD14DR7Jvn6/gjPvtBk4nh?=
 =?us-ascii?Q?G5Hh/vet9RUdKcvsBCsBOmceKOvf6jfHxPwAhmEoJ5D8wztReXnT3vIzmlJg?=
 =?us-ascii?Q?BlV6DwpOSCFCcsYXKDdbxdhw4RB31Uh5L8Z+WjszKYoJyuHwgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qmJQzdibQ6135ArrJEnivB9ZuQ1+CPfJSCjZpbKQxdCe48ywnCuvxgc1CKK9?=
 =?us-ascii?Q?0sQkslJ7YCeRDMHd+wj95gFByjx6YTbFirFO/qVwoXV732DAwueH6WidaEpm?=
 =?us-ascii?Q?JKeGXo6xrDpsv0ySse65eVPqf14D/0VDyYJYBoyJsle5wbV23GdscCdKkjUF?=
 =?us-ascii?Q?V12dHHeZAD/+n9TmAb73xyBcjPBWarIjtmEEEr3WbAym6Qo+9GffPaR4E+hr?=
 =?us-ascii?Q?o/Tt07KCGZgP/8YKIuc47XqwWtOWeOrCnvlH/I1662K6BhJb4okBAlcvcJCk?=
 =?us-ascii?Q?4x0Gedm8ABHFtyn+eSL/liQynkQOXHV2HE4ea5zbdYm8ZXdMAibkGPoHU9lk?=
 =?us-ascii?Q?ZEF4WXSOiFH0BKLs2l5zQViSN/xmuW+dOC8lLUsLqM3cStHlS83tH8LVzXUI?=
 =?us-ascii?Q?SEp3FGRxHwm0MfoB6fnUo5wHdBr/NfZK7pJgYnt/9HBXcUWT5rLbfkBFacFw?=
 =?us-ascii?Q?sZNFcSvmHlxArIvxACdj7/rzYQIxo2JKrqxjHSSTs5PYkPUBm4TLJpU5HMyd?=
 =?us-ascii?Q?rLLk6Llt+T0zJYmbB4J3FVS/FXsLwIsUZzNDVflHF8uIDBqL4/1yDlMhfkF7?=
 =?us-ascii?Q?b8cujr8CKL7j93PeeO4ptigJLwSEa/xW6ONX/B2SEe9mdSZMlpXkfUYaJYvi?=
 =?us-ascii?Q?hHnM/VbIb4FnMg7Q8oW7Bu2m1Xt/RA0j87DiFY3i3jp89itdHtApwOwlvEFe?=
 =?us-ascii?Q?LTjxYZlufBScGlbC58K2HJQtemkRHke8g8SgjGawL58gp8laumIipzvYxyfF?=
 =?us-ascii?Q?RnLxrv6A9Tcts2QjH9w+VxIMykNo3Iiq8hvOLePJ917Mx+lITiozO7fIQOO9?=
 =?us-ascii?Q?3EYfg4dZbXxbrilNvSX5fHI9xSQfV/33T0HDqYqGjFOrsRTAMAh1mu/eoxRr?=
 =?us-ascii?Q?v/syv1lsWlEGj7tPMEfQjB2vZzUQFvnzVa8qXAphnzdRaYiihKQINRLbiwr3?=
 =?us-ascii?Q?/1GeaZ9KEh129cr2ue4Aa7xo47m26p11YytsAplVVoCOlDXcbK1JVeJ0FOIE?=
 =?us-ascii?Q?IjmfhjVmZEtsFcTfqr7nY3xoYV3Q43D9zQWvaPUAPuzbO/jCQ3dnCi6jwGoU?=
 =?us-ascii?Q?zQKk8Ax6UgOlTFQyz/RRxV/jmLlLi3R36qy+jpOU0HALliCC7g4LazTxuwEu?=
 =?us-ascii?Q?PvMpwtBn8O4ZCg+g1Ws8YTRQRWeWKxtSVGbLFbnD3jw81dQDSRtZ/aPZM7Xo?=
 =?us-ascii?Q?AWoWp1v3N8oMYbegnG6gNiAB3NdXu05hLyqSIKjnRlIqQkggnumgW0J9LmPz?=
 =?us-ascii?Q?Iyc4wlo7U7iCZarEeZFeXi29jpwnU1wXzHmjjU9s7aaHcyYyv7IFDS8ZjU6R?=
 =?us-ascii?Q?WRVREFiiJCt0rn6ppxYCBgE5f9JhhphK6294zcGuwOU+Sd3+cgQxnZXhQ6IJ?=
 =?us-ascii?Q?fCLVVlSsjtd1oUsUPiymhOv3GonntRult5hth1zkim4/hA1biHqulUkwFvbS?=
 =?us-ascii?Q?rX+mVYxfIuEarKEHBudjbyHdk587tXQlQUM+AkRfzdz/B0O8GXDo+owOwHkX?=
 =?us-ascii?Q?AN9SvVEhu/PW0JPgz8T79flsIQFzUE11h6RtZs919n/oQ+LEC7cova7k2mIh?=
 =?us-ascii?Q?ZdHZ9+bVucHA/60PU+M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c671a08-5580-47cf-25e6-08dcbb8242bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 10:25:31.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoJmmuC4QMTm07smLHgZmFIiP39OI/lOjWEU7MSFjT4lqL8PtLiw9pyYUz3VAVPiixl9Qf6FO4fF8V8c6c/Trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472

> Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> for scmi cpufreq
>=20
> On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> > SCMI_PROTCOL_PERF protocol, but with different name, so two scmi
> > devices will be created. But the fwnode->dev could only point to one
> device.
> >
> > If scmi cpufreq device created earlier, the fwnode->dev will point to
> > the scmi cpufreq device. Then the fw_devlink will link performance
> > domain user device(consumer) to the scmi cpufreq device(supplier).
> > But actually the performance domain user device, such as GPU,
> should
> > use the scmi perf device as supplier. Also if 'cpufreq.off=3D1' in
> > bootargs, the GPU driver will defer probe always, because of the scmi
> > cpufreq
>=20
> The commit message itself seems very specific to some platform to me.
> What about platforms that don't atall have a GPU? Why would they
> care about this?

It is a generic issue if a platform has performance domain to serve
scmi cpufreq and device performance level.

>=20
> > device not ready.
> >
> > Because for cpufreq, no need use fw_devlink. So bypass setting
> fwnode
> > for scmi cpufreq device.
> >
> > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the
> > scmi_device")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Use A!=3DB to replace !(A =3D=3D B)
> >  Add fixes tag
> >  This might be a workaround, but since this is a fix, it is simple for
> > backporting.
>=20
> More than a workaround, it feels like a HACK to me.
>=20
> >
> > V1:
> >
> >
> >
> >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/bus.c
> > b/drivers/firmware/arm_scmi/bus.c index
> 96b2e5f9a8ef..be91a82e0cda
> > 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -395,7 +395,8 @@ __scmi_device_create(struct device_node
> *np, struct device *parent,
> >  	scmi_dev->id =3D id;
> >  	scmi_dev->protocol_id =3D protocol;
> >  	scmi_dev->dev.parent =3D parent;
> > -	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> > +	if ((protocol !=3D SCMI_PROTOCOL_PERF) || strcmp(name,
> "cpufreq"))
> > +		device_set_node(&scmi_dev->dev,
> of_fwnode_handle(np));
>=20
> I kind of disagree with the idea here to be specific about the
> PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus driver right?
> Why bring in specific code into a bus driver? We will never fix the
> actual root cause of the issue this way.

The root cause is fwnode devlink only supports one fwnode, one device.
1:1 match. But current arm scmi driver use one fwnode for two devices.

If your platform has scmi cpufreq and scmi device performance domain,
you might see that some devices are consumer of scmi cpufreq, but actually
they should be consumer of scmi device performance domain.

I not have a good idea that this is fw devlink design that only allows
1 fwnode has 1 device or not. If yes, that arm scmi should be fixed.
If not, fw devlink should be updated.

The current patch is the simplest method for stable tree fixes as I
could work out.

Thanks,
Peng.
.

>=20
> --
> Best regards,
> Dhruva Gole <d-gole@ti.com>

