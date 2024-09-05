Return-Path: <linux-kernel+bounces-316560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4F896D143
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD79A1C20D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FBE1946A8;
	Thu,  5 Sep 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+euSWZ+"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA319306B;
	Thu,  5 Sep 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523542; cv=fail; b=sPmfcrpKpMSASEkhFjYFlDi68SuUyfw5DDFjgWuUyegIDTFgK1rUAj6uBPjRLsbk87EEvmDm45vc1Ody5j3+UJG9XR8jYuMs3gBSaRh3poeYV0odZgVIGWWB0A8VnbDdV5jeWLkdL6iyQBqqgcv9Jy/2dmvWPNh6wJOeC9/1Xic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523542; c=relaxed/simple;
	bh=70KO3xzgmB8VIevg5U6HBhlfj7ERv4rj+o3XFT1YzEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OnGd3qz4jcZw2ozSk8EIUlLd1SNrIP+wGlJa7bYrBL0iJvk7r3fg6Nij0RzKepk83hA1E8nDAlXJKrlVNbhR6FrnorwDnTklfxJt4LOxTD0KqPP5TYXvi4B8ZbFCEXu/ucr3+PVRrZZilBco0kI9Sd96OaOJe8LDV6zyHEFFDKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i+euSWZ+; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbFn//V8wA7kZ+RfkZfxouLpjE0GJauy8DwVL+M/+B3jiAxheh3z3AojrRnZQe6VkjNc8Y2evE5/mwmS/m56FCtL1SdHN/oVDSWeh8zUuxVLUnmT5kZOk3hw9e9Z+na6h6HQ5em3LbX5hwR2BAsLDAigBoQb3KGTFAqcCAtNIPzOxbl1ZVBmg8x3dHJJNgVDk0hCuykp23JyIk+vlJ13sVW/v3p6NhAYk/lXMfrcsij+6L40TBLETyy1ekEUlcKaEYP0RKcTA55KVOthYXJbUYn0Kxvc11HHHWmfLcJ0JO/YVv1c01wsqXBrc7Jduhe32ysWYpHHO9+O2QX8mUnpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70KO3xzgmB8VIevg5U6HBhlfj7ERv4rj+o3XFT1YzEE=;
 b=QfrXFZQi5M5Jffa/gFZseccWwH9lc4bFaDvjuuZZDbUyqDz5gMIkNl0sZfuy0X4scO9P6mkZrqugZM6lokuQayBVhQcy4JS4FFZwssgFSBRoLc5c+BZj3Q/+MNA5RtBt+az/03X41iOuuxyr1TW26s+9dhlr1xj6qGVTffNV1+cnprLWdUf1992912uXaLIcutBBkjwfIVSnjM8x1ySktJVhXx47nw7VxYlxbS0d2T0KOqufNvTrh6lo5upgUf0t1+aJvk2J+XWx0jnujLmj3mssVM3X2XQOGBaY7zRWLeTPIgXL44uQ8gHCLMqwmoeqDyoCX4bcEv870Gpmq/P8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70KO3xzgmB8VIevg5U6HBhlfj7ERv4rj+o3XFT1YzEE=;
 b=i+euSWZ+gDrheZzBOiZHFtOG4NWEU7kCkTFDL26iSI8asfOgkgMwXkLWlMos9+OygGgfKYp/nX/egBxmKnuVvvKieZjf1yoNFBYOx2D+TbomwdTVrPSCI+2s6u1Gvl732eDblctbRF/3iKSPCGIf0mNisvdqMF04lyFXjV9lNMtvm5iV7nB7OKUKe0EaFTm77WqkdmaLXeoTjDg0W3Kekesd8xRQZLELHHI0FoM1zy4uDybv9EogBQSVhhxQRvvkMGtKa0XToaldb2zYhnfHYiLWwz3ZXfFuZY7voCgJplJcGKAARous+R/wFb8k2P22ToQFC0zD3ldEWA+rZcFrWw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 08:05:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:05:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Hongxing Zhu
	<hongxing.zhu@nxp.com>
Subject: RE: [PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Thread-Topic: [PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Thread-Index: AQHa/z6oDYyKk3uRw0mOTNpX5NPk2LJI1cdA
Date: Thu, 5 Sep 2024 08:05:36 +0000
Message-ID:
 <PAXPR04MB8459A02F50EC633EB4694F1F889D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
 <1725503468-22105-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1725503468-22105-4-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB7001:EE_
x-ms-office365-filtering-correlation-id: 5c4f2704-aa94-490f-a38d-08dccd818660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R2Lo/a4b4iDfhy9Xvndrb3yyBnfUyD+Wuq350gqlikZGG2IKUc/G4yZ84iwb?=
 =?us-ascii?Q?PO+4V85568z++zogueKkWs57Utk5naY9RKUTgDmMxNJmWe7MlmOdb4kjVSlB?=
 =?us-ascii?Q?TC8kCUezdlWFntvtvU9W9gvwAk851iLIGQ+hD3fBQDbHBuCILQNszur+qZ7n?=
 =?us-ascii?Q?AnFjlkOwcZG0a2GLx8AU3wSDruIRQVmUxLb5bJYc+LKeyPPSzppDae8aFVCK?=
 =?us-ascii?Q?1jlxeGRdW7yFEnhlZRL2Kc2PWYom28jBldyAeXaVA6cgL0mJ7S157a2slwNh?=
 =?us-ascii?Q?ke6dtPKCLSImPiBJIrzQgpxLgeDS0Ujlegj4Q4gP+WN63qt9XmBVpnKfU0np?=
 =?us-ascii?Q?DFy+HeVNUxa4gLkbxEv7QohQNZdouq+31YqHVGPJ8BnNC1Pi5PnkQkrr99iH?=
 =?us-ascii?Q?ffyop2yNAFaXpGLHqftrP47m13FNUEjga9W5caCGmEbz3fZmyJKD2t8/Skdx?=
 =?us-ascii?Q?WiUvU70HT6kHTkk8W0uVUOVjO2oBUwCvx/GyXsg94FmSY1WnuvobZI/DMS/m?=
 =?us-ascii?Q?A/PQMWtixNqM8wyBrnghk8WRDbke/AR+yZ50WGuzCRhh4Gw3YfxSyRH42/N1?=
 =?us-ascii?Q?XUfv+0aqyTEytn62rubPNl+Fci4hTnLOAMRQ/zIdp3DvyZcYQCHXB7aiZEpK?=
 =?us-ascii?Q?VoJMwVIZIQGcUMfapIIkuPUvmCuhcuyw9CMbBIeFtWhCSSKkr8X0N5gS9tTE?=
 =?us-ascii?Q?tZE5PGG2sugBE5pZ/zsP/p1MkFZKsVSUgAnZN8PGR7upKinm/t8HwgNe1KfB?=
 =?us-ascii?Q?sd6LzlBw/23KS9P71D6ix5GzsBKEU94ppp1aKY6M+7ksVmHygcm9xqZbU1Lj?=
 =?us-ascii?Q?8QBUY+9uGtmniRaJzQlhfUwOCV4ebm6hXgBj1qJBwKjrpY0lC1u6x18mfcyh?=
 =?us-ascii?Q?UhcnyKqs5xhvNg1ThUnlU2GtPN55Xj7Y1gUdhd8DVDO/Uimk2qYGHHxOQC1T?=
 =?us-ascii?Q?tXB7r+MfFHjeD275DDXyRAlHsZIxvVGdkm5QP4EVDZ9T3fO1cJfFcgevSaz1?=
 =?us-ascii?Q?+fqaVZOYKn3pQddPKV2pHIFaHI+00qYI5tY6YlUtrjjwyJiEnu61m0ppbEit?=
 =?us-ascii?Q?I90TGzRdVQMU8r4CkmUqBkMU4mbbN0ukdAdB+gaOixhVeb2hw2+VSgTB8NI6?=
 =?us-ascii?Q?s6yzyLFG81SYg5vLgDf7bUwwHZmuwzbQygZ1m89JqQjej7TUycu5/nSqjFrd?=
 =?us-ascii?Q?zAs/VF3PbdlnknO0M06X4qkeS/xryBfVNhATK7PmPunPululzeb1wgeIkinQ?=
 =?us-ascii?Q?PeHaFIqolD0RUthdYUPtjHWKs5t5lkxPoKX8G56zYfUKIGDWlyZOk+hipC1f?=
 =?us-ascii?Q?zKl/N/qgZ+0jvMbYZa4AbcRkgSLEE9Ds1MucqqvAQnc6+U6aDDh5A0XO49zP?=
 =?us-ascii?Q?0HIKLREEpkXoeiBavtsuUQ7Vcsg69BlYg8bEB2jKEWaDm+NlATMnh7wHnpte?=
 =?us-ascii?Q?vfN4kosUxqE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hTevrxp0MmlM6cRajdAIjRvYfO0CGfrOFb7OwCMo8/ipxx8bHNBSDd00A+Jz?=
 =?us-ascii?Q?Ks6WpvYPGXL8mgDAFYymK9nULZ+yaCpX6qzPwkLfxNlLG1ubqmqP2uY6t43X?=
 =?us-ascii?Q?FI6Mw5cRUA0Rb/WnEYYVpoAsKseCcj8AihBUKJD/EMuW42UBE3UboINexhVA?=
 =?us-ascii?Q?r8Chu/z3g3cGlV3TCACvjepo3eaHkXg8h+SBLa+vq+8lWOe6iEaUCupo7eFn?=
 =?us-ascii?Q?+0l5OgYuioHENik2qSo5PTiUgBAwJLDf+VRn60lV5qNiF9CpVNi/WmaT3ZBR?=
 =?us-ascii?Q?XdoAL4TywTCu8/EAl4C32WKyuloLWOXKQNgYprziQ7WioLux2IUK2NJyhb8g?=
 =?us-ascii?Q?SlAJO2IU0ArvDjhqNb7KhJha7X5oGJDQpmYKXwc9XrqsVZgpuS1gATVdO6wj?=
 =?us-ascii?Q?hnRh6pS8poPHVKxGFKL7qpfYYGXAO4OlSa2+5uJzbMXBhD/UPCetgqFkLeaj?=
 =?us-ascii?Q?3RHuXg7y1O/RzghtJ7OcEhEXpD3KdABBGOg8Wy748mqKKjZPGD3zSyOBfDYR?=
 =?us-ascii?Q?qDLxBuw8BPxdLMJm/FwMWPVNAFs1GEpg8ZZ56y485ZSZETSth/FLFNrr1of+?=
 =?us-ascii?Q?Ot+7dfzP3M3hbXiQp2VMrGp8XFRne4pNDmAig7qTAvuDu/KfkX3YkA5GUT80?=
 =?us-ascii?Q?e1Tik3UQ75pvjRvDoqpg5EEhKLYefD5zIpHaRAv6PR1xPlUcCF+hjCEotLqA?=
 =?us-ascii?Q?MS73wx+bGXyu6bC+8WuIK8zmFkNlUrMIUwecVA+hTYJIjuhLisqNWONgFkS8?=
 =?us-ascii?Q?/ocaMnDwT/35VVCa3AHCWTFH54dBKR+i8KwjPKTSb2DyQYtMUXQ5MHBmCJT1?=
 =?us-ascii?Q?/ZsDxD9zTqZqEuAu/Nghv5gqFOvx38uq1VwyPTC95PHyBcM9OJcXlBYCu4UI?=
 =?us-ascii?Q?ITLCuQHXqCnEdjt5Nmokyp6VsWDaM6Jg6HGqugDPjdqq50UuI4ETTWD5RgAW?=
 =?us-ascii?Q?8mdhyyqEsVtUUuePknJYgrkotxfHn7g7xhy/gBKldLFi5GIwInqk90dZMOlf?=
 =?us-ascii?Q?pV+7xqVzP2eA2XhnVSJuUpGdESn2v+d6tTxSl7lNB6BISHevjmzNMxBfjUF3?=
 =?us-ascii?Q?PPWTYEYR6q/IJIOyCF1wpq7+B4dqJt6VS9wgnlivLED3+XhfzDMK8didfPJB?=
 =?us-ascii?Q?OE/nVcdIJgDSuXrqBajs4DB7nvmuqhhvpo4Pu0hk2OftG72oJ+dRF5/PNmqa?=
 =?us-ascii?Q?aMiK7L5bEzAwVlwBVLXy4jaKfkD0dUmyfI3hct69FPRsLRhzPvm9mjpqNOLo?=
 =?us-ascii?Q?EdQlKLjcn4NmNhpwo4cObecoh+gv9+AwONR61vJk9fP2vNosAXLuMjtF36Md?=
 =?us-ascii?Q?aLkxFAymiGvTZ1QTqyoLrgvPyOKCR6/hfy0W1q4HCCAkPCq46y7c4ZVW2HrC?=
 =?us-ascii?Q?Khs96bIbgJeKrovLYLE6164X7F9JYieV/PRbQMfTqvGTLHZDqymb3yq9t+12?=
 =?us-ascii?Q?1H5kdkQTuUvORIjJyJRELYO2GB2diJUlWTUqnnBsxxLd2D2fcLa9j+OvizBa?=
 =?us-ascii?Q?ZtQ0yN4Vk220ts2zhHiWcJ2N6pFthRMkor8fK6EW9vRfBzdBh2JlemaqS9UB?=
 =?us-ascii?Q?cgZ5A653MViarqx1QRo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f2704-aa94-490f-a38d-08dccd818660
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 08:05:36.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjmRfPqSiAF16noI7lPwmxmDkmO2puq39ROs4vGJ8d89XFQxd9vOxtDJQO8RuvFJwNNGN10ILOkv9AUaUexI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

> Subject: [PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO
> block
>=20
> CREF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
> enable/disable.
>=20
> Add compatible string "fsl,imx95-hsio-blk-ctl" to support PCIe REF clock

Typo: nxp,imx95-hsio-blk-ctl.

Except this, LGTM: Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

