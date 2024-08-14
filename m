Return-Path: <linux-kernel+bounces-285770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D395125C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0501F23B97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666951BF53;
	Wed, 14 Aug 2024 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtqkoP4f"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1233FE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602576; cv=fail; b=Q0p8HJq9UPaLhkn85PqzuquZv8aGryFhM0TW48MMtvjDxuxRNo969r1hMfRNhdz7NNDyNNJrJkrqahFHbJo2Ty7wAjVMigUXqVVNlcdd1Dl30csThhwR81Lxad3nn4mUlTccimcvrvpRa5raEE2o3c8v7FOVS8kwU9yjpVAeEqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602576; c=relaxed/simple;
	bh=1SraUpZXVRO9yW5lJKih+tRz3CivfC1BdsDNyGPze88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVmJkk8ge9BabrfcfTn1oUuOP277ry9QZwQGBtnCQkarZuU410ZxfpoRiQwQmxlRpxyF1vbpieQWiVrkcRmqsrUPfEuOM/aXkChos0lzNPsVJ2XGcQmX9/+9OIop3ixdmQFDD+ZyD3+kg7SDbPIkv1B9xoXAr4gLt1hRvs7BONY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gtqkoP4f; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNOKNFQQoj4ra39xXOmrpj/3bfhl2HU7r+klHtZ3GIAlFkgRoY8Z5utMbA0euLdRA+Cetvrrzcn3KOied/bFMs6PJgmIn7Tc2b/X/ZcarSQ58IEfrXFfv0BpWF0XIt9dGItmKSzzELcJcdsAM5vuuySQo+qkGySUuQRSnRVdyBNfXHhW+tLjZDyg6EzioIBb2pT4sapDkOXSrF7u4kIak55kyk69ecpNaP1XNDJrMxkqKRaYBTiUCaKzvDQ+zmg2Z1/cUdO+JxW8rCMfJ5r+lwbo5r/ZKn/CtJdECQurz4WpRF7I/uQaW5qWVi7xOt4EerJewgeT4cxn+6Hn/jeQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SraUpZXVRO9yW5lJKih+tRz3CivfC1BdsDNyGPze88=;
 b=cH6KOHEzh2SSK5OiPZVrHmtACRhOOx0nKoS+FJJoz3zOGg5HxmLW/apU7LTbl0x3Y05P3KwIXJFyrco5I3Qem/y8CmKTQSdcEIzgyjVnTtWb3PHC/GxaP5BD68KPHmlUxDLK99qqdaVXeeLvbEqahFTT8nboGm4gmeC8mEl4pIfkDcamciz8SRETWZwyA1h8ffzKoi78Evng9gyJp2q7QA5KBRo7mxAXJ3kxuRCXOwS/VtLA1/xrhfRwNaYVLVcFrMC88KVTspjHjr9sNjvaTzs/xpwYP6VJH4svsTsR7ecVDclcr06KMtue8GF71DVI7cJjW+WUZgW/szEj1FmjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SraUpZXVRO9yW5lJKih+tRz3CivfC1BdsDNyGPze88=;
 b=gtqkoP4fi4u+ACwJ+8PoLgUkfx6FdnDBnAi5iXKBcu1S14RCqChd99N5qSXjICkFoP4xMlMB3N5SJbTNQzy3JhSQluin2w0rco5v5RyVPc+BzoA5olU9shFSTKJXe0l/nMG92VoNc3pOu1vlpH3mdqmBpanUVcwN2+a9oT+xXLUmPN2b7Ab09q2sY91d8GY8R6C6IbSm5/qkay1Hv+LzWSkV3ijRvUZvZTjcXmrcvD1IvgPb3Rn66ery7Xwwu8xuyusS2Co5FlPOd9HOKVazvhuHldtfl4ALAsfdLI75GFqp23cnJF4DqWmZjufglRNX2OjRpyYJX0MWpsCkeA4ICQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7319.eurprd04.prod.outlook.com (2603:10a6:10:1ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 02:29:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 02:29:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Thread-Topic: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Thread-Index: AQHa1rJig9jveBmI/0OpTC5JEanfT7IjJXsAgAMQWwA=
Date: Wed, 14 Aug 2024 02:29:31 +0000
Message-ID:
 <PAXPR04MB8459714653491478CF0A6DE888872@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
 <ZrmESMKrhIv/+32l@dragon>
In-Reply-To: <ZrmESMKrhIv/+32l@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBAPR04MB7319:EE_
x-ms-office365-filtering-correlation-id: 1f753e80-3990-44d6-5a55-08dcbc08eddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sTeWsNRonXgZwjLHF2bVf5Gvts0zc+cF4rEckhXHS6jWuXLarIQOEprKUIo+?=
 =?us-ascii?Q?OhsPTaQUzRXCQ1QIcoAbWqgPUNLl9AtY7JhLvu9um7T1lgWFAjoEmjI4eN2V?=
 =?us-ascii?Q?fv+BxN0a8zeBBTEE5aYqJs6G01EQYq8Zw65Mn9iea5jAG3EIP1XPxWRmnjIl?=
 =?us-ascii?Q?kMZWGXpq0x82T1r5+f40ZwqqrUSs8sIVrfSIrXXgJ13APcD++XQqvXno9eaZ?=
 =?us-ascii?Q?9UXn1TN1g3NnOelggIkvP6DD3yUmL22coHM0bq5ZP9ltOkWr0QZ7gAZE1qJb?=
 =?us-ascii?Q?mEYMPlVCT6lkQEFa0lYmjR2fTfpoRCt0sNnp3rlCfIIx/b2TIiblJ04ZzuMr?=
 =?us-ascii?Q?ERWBUYGJzc7jPNWf9TE1iywWYDNHXEMPfrv0GlStjTRGdGfJX1VeVHzGFvDF?=
 =?us-ascii?Q?MPCZ7QTbsr+A5bUGG4n4XuxHqGkxLoMKTxJYry5kuleoU/B/DWSiZXvGXY5b?=
 =?us-ascii?Q?m1F+8jl/ZtmOcVMK0KjYIwJp+7SDvQiFByQ4sF8Ss60JMItsZBF7U5GVcjEL?=
 =?us-ascii?Q?D96jHgnbTpuavf3db44rg2xfRddfuDCdJ4DT6IOBrxHRUEWStVjhk9U51I9x?=
 =?us-ascii?Q?Cmk30LYu/bkssOlAZt4gQ9XJQ1Fxsh/dPE4eUHjL03hwQkNzzOeaoVmgyazf?=
 =?us-ascii?Q?sw9YhALO0Vu9HY3J1PXVCffntkE+3K6dw5T2NOXRwh6YEOEzZD17BAR7g7We?=
 =?us-ascii?Q?MNmw8W9542HFPT4dtDShRaZR793M6oewl6APFyv+mnJdkgiemAGOR26W5VMc?=
 =?us-ascii?Q?mELQwA6RaZe6xJzULZQEK/QLJZ036Vi46Vte/rjvVKvCzFE0db5Flw3mKJ/X?=
 =?us-ascii?Q?/e0fcAO/CI700gL82FsGD2HFQ8rzWf9IUD7CKPpeEKr1frTa0fq8E6G//Qph?=
 =?us-ascii?Q?8JSxSTHfVkkli0CZJ7VQPOCORgqeqmqjtV1Jjwek1ME0MmP68x65OpK9EFkq?=
 =?us-ascii?Q?Vwm8+eJNdFk5eIfu8SoYYL7kQczp7swTLX8f/UOSxNRVOaSRu+mAQXVHAppJ?=
 =?us-ascii?Q?1o0GbOq89SBjREur456ZB+Y2BnAp0cpZ5vmvJZoS586baLC8GfZJz+4zr20b?=
 =?us-ascii?Q?oCvts9lYnN5lPjj6H46/OoSdrER4f/sDDzgeIztpRMqGryaDUzNqh8XSxb5f?=
 =?us-ascii?Q?IhwqHrmrd9i+NDsZBXlLJnIg+B/uWrAhjsferQuKcNvkMCuN280Ba54jWfk7?=
 =?us-ascii?Q?Zm8tFw60vX8EFSuoxuyIixKsV4ZyykXI0pTjz1UJ8yjWx33xFn3ISjSV13SN?=
 =?us-ascii?Q?2j6pXNaiTtz8Yp1AlwnTGvQD8odH51pQVW8RvaGlctP1XETIildZM1HP7ie4?=
 =?us-ascii?Q?gd9gW2cvp6u2rnfPdwbIwVlOt6rzB/HELirC1ihysz0n0cJvmce8pBxUg3Wf?=
 =?us-ascii?Q?m4Z6dd0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ok7JjFUn1+Q5wuJT4WtPFEqEjMzR0vDsJ+86jcgl4PhS0UJN+ViKZuKbWKN3?=
 =?us-ascii?Q?h9g+947HRN3LLqZzqki11oPlpIfhdwW35tOjBTzthvovd10AakWWU1oZJE90?=
 =?us-ascii?Q?KJ4SXgtHHs48+nyaCf/O2XR9R6vRytIFpKMVogonRBKNpQSW9cWwgSlaBxbJ?=
 =?us-ascii?Q?Ld7Ez8QSZYxL1oySTtsfzGOzf1RtEJ8bYfBKXGaVGKhwtZv3WIAniNoUfp2k?=
 =?us-ascii?Q?zfkCo8wNkMBUgcIa9kBKRsBZ5Mvco83kiVTHOj4TFNHZuKTknYK0tJkR58aQ?=
 =?us-ascii?Q?2i7p7gh4XG+9jbIkceAkIM3JoJAz3jQJxz5Zm0LjaApGs8Mgk4nyliHdD28V?=
 =?us-ascii?Q?ZGzMpvLKoKRe2wz5yputgFrlXFx37XuY0IKhBEbw/KW1qv8GfKWk7Wy4ptNI?=
 =?us-ascii?Q?Nku+mrRMEzfOKI9NaEqZogoMbqaihGXEtKi/N6sTz5/bQQ1Youu3sbIHXTKs?=
 =?us-ascii?Q?p20HfMz9EVGpu9gyBabx/5RP8AkVNUhRiHib/me/qWQfmij1R3rXqeezXA5S?=
 =?us-ascii?Q?tntvbeKqa+dQ+ofSGuyzWcwpQ59z8QtcyhxL7VZV1dCcZO/JU/Df/bJMDyzi?=
 =?us-ascii?Q?UlQWtAZmdFSBFMP+a0zxbzc0peHrMhZLh+4W+JyCE3q+QCBEae/9LoVzN9z8?=
 =?us-ascii?Q?+Y5hlR3T2l7kvTZcMU0tLeDcwmRQJCb9sXJVr7QW0dShNZPXI7RscB6S2hTE?=
 =?us-ascii?Q?c16AIBDLyDk21dtFYWFIuvSPp4ZCLCWVMKPw1pIzQ1n4cN1c1ChI89TJ9qks?=
 =?us-ascii?Q?u1a4n/zrSPIX+etZJ8o25IE4AR0qnOL3jBs7n7VXCLBQSLdHg57BIOz8LpdP?=
 =?us-ascii?Q?NeS2XceyqYdCKBaMj0b8k2i6GdLx8UtdtxduO8ZeaHib+Vy19D10EAUyPth6?=
 =?us-ascii?Q?l4nbsjQi+nDUALzFFVWgBQgRw7vEMp/mBJ+Y2udMsODYrIOldcuSlxdWP6HW?=
 =?us-ascii?Q?xI4PETFO8pE2qDUiBfRUlOJAtrd03KkY1ztWABIJCz4YwfK9Gl0QEfVYZSd4?=
 =?us-ascii?Q?u2LY73+BmBE9SfI2bRAOzNCav9QBcQIX7KlYUApZMcgHmdTBnDcgTc2l9JLQ?=
 =?us-ascii?Q?a4VGhhjXBh1hy29LnzZzTqXWdgh02hLN8VH19zCNG/0S/iYCHstDFqfIR8vI?=
 =?us-ascii?Q?sY0Cvx9pS4rEd85/0l4Q1EVQUNvQfIHvnkXwYyIvtVMhm/8bOFPTw1HRNqup?=
 =?us-ascii?Q?JRC0gH5vCHPg//kvYdRSP/OXHbLKZdA2qWxNRsAkwwjAkNHOHmPJ5ItFNwFU?=
 =?us-ascii?Q?jYXJa8WPhWId5dmqTSMfQeCIfYjM6Hs9gvfpEdp86hX0vA5niMkVo7IiA2/8?=
 =?us-ascii?Q?asn7pNvvdjOieUfeFz7Yt5y350BvJhci0Gv/PZXQ78DoUGQKINe9J6XeQePU?=
 =?us-ascii?Q?QhVEHJxW4JZ9cdjYKi8U9tu6qRpoqpiLvKQpV3sKUHXL/RaG1T4O6TedHsb8?=
 =?us-ascii?Q?W2Sm+1aL3K3oEjeuxYGMv7oPfJpRtSLCa/9OGYoXWzwf3hI4ov1ChoF8A/bT?=
 =?us-ascii?Q?krtdZ/WxP2TFVHjzABi/Jgym8UvKwPYF/+/uilp4wz+xjNK47tB3OoGXW7EY?=
 =?us-ascii?Q?/csTk3ru/b9PEW7CbKY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f753e80-3990-44d6-5a55-08dcbc08eddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 02:29:31.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhPVicoBkhCByrP4uyd1mhbneWdOmMmWjw15c+Kjl88zpQTcmkENPPmUZeSfHtlDXA+dR67oGAAwvu5WrXnr7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7319

Hi Shawn,

> Subject: Re: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL
> driver
>=20
> On Mon, Jul 15, 2024 at 08:36:35PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Enable i.MX SCMI Pinctrl driver which is for i.MX95 IOMUXC settings
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Applied, thanks!

Thanks for picking this patch, but after more check, this patch
needs to be dropped for now before we find a better solution
on how to resolve the arm scmi fw devlink issue.

Thanks,
Peng.


