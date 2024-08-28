Return-Path: <linux-kernel+bounces-304667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A715096236A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACA31C21513
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2D1586CF;
	Wed, 28 Aug 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mt4KumDy"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095E15A849;
	Wed, 28 Aug 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837473; cv=fail; b=onX3iqd6SBbcArrEOrbvWVTESf82zZMwWJaun9yr1OFuZb2hCMAgtXyREoyhcauWWsSW4NM3zNW6kWnRNPDicJmdP3N5/1ykULsNseVi1j93sjNQpPpa4qspeMbjfaMVb0JF0LhQ3sviHiQYN6FtsDQaEuaSvuJGtT7vNyfvkrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837473; c=relaxed/simple;
	bh=LKP1aGM0T097fytiXDQdCg6BMopp4uAHOJDaJYQM9YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pqB3kajKK9Qbgnnvv39VBnmVxZhIdj/ZK12/iWjT4PH379LTxL6OqGhucstytZgOi8zmze7c5ZZWd5fxnX8cmhLCVuFmUdpZ3mDjN8RTJvrWyjx323F9TKWowaDIMs5n76JQtVH/RN0SnxWSBD42Z3OZOxCnTS3Hz6m55zZMuqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mt4KumDy; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUKkJBlNUyhkHa1A+nWrOgGh1aiwY2gBkfCHHEK/T8FlO92kIwGSQn4TKSr0XOb7rPhPZns19E5ZbiKSg8fu7ObVqswKDUxvaH8PSaMCBFpOSbMstTHsxDcoktY8sDUe5hdSJGUySCTsOKXDvi7tWWCgKxBGoZNgaE9ktVQuAJBRKwnFVk7eyU9cv5GROh1Q+jrh7EDMD3xXs/bdl0tyC7fJPCcvO8oZ9/O7xRvwXCVtV5/kCeAxE7A3BqAImdb95WvA9c5WfDr28FXGQPpl530ekeKQgtZRDyVFXcNZ8UvfJ8kDGWQEk1So7ybinarmPpseidyH9FImvxkcrqfgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhvjokLUObfyNcL7sh6Rh87ZdiXIalAsDFpm0Ye9FlM=;
 b=uprdeZ8zRzhGR1/Qdr6erTD5hFeUmWrMjDbIYQOEJWQDBpJeTnMC1Y58HTSP/jOb+GpZhHxc+p4gJGTs2a1UGIWK34gWgGF6gh7kWAEXkGEO3npfa7pxacU+F0SbYv9YKmZRzCJhlzYOsLiRsW9MAzuogX+P5BPNaptog96xUWQMH6+RUPepR5ex+hJ5QYrIsVtYwudgGTGGS81U0xSx7J1gmoRJmTWG5HBY6qaC+ltLhkPkbe14BpdkIG1sftcdSk5d3r9JlTSaVxzqKD8+qFrVuIs61BMR70L4DguW9HUcaJCnz4YITBBM+mvYsoa3N/YHcUU1gtwXcK2PIijLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhvjokLUObfyNcL7sh6Rh87ZdiXIalAsDFpm0Ye9FlM=;
 b=mt4KumDyXEuGtI05b1g8MAuG6xmSX+Pkt6KolttNVyZZX0epJnkZZv5zNNL4pDab/MfWFpRBGtRZ88rEOpnWcgAl2uLKgIs8TdCzsFl8yG5YmowK0nDSFxLOK8fS1R1woNKUSXP9k8xCVnOBLP2fobPzlUJJ2Sm4rlRDcwrXmGgEfOq1Qsbtuc95ZGthu6Sdb0ujGHqFb3htHQqBPP/gDxzM+6N6SjZKcLmDIJy51YW61kRWIGOmHazWW67WyEKqullcp02fdUxoA8o6Iho9zcUVDQXI+3Z1xOLZXgJNZoDLkAQdHz/5rx8XuXMKEh0+M8+n2ZDkar2nYdj0vMsMQQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7159.eurprd04.prod.outlook.com (2603:10a6:20b:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 09:31:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 09:31:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 RESEND 1/4] dt-bindings: clock: add i.MX95 NETCMIX
 block control
Thread-Topic: [PATCH v2 RESEND 1/4] dt-bindings: clock: add i.MX95 NETCMIX
 block control
Thread-Index: AQHa4VhpphfHEoU9R0W8vXu5XtP46bI8iqoAgAALMzA=
Date: Wed, 28 Aug 2024 09:31:08 +0000
Message-ID:
 <PAXPR04MB8510AE921AD67C110F135BB988952@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
 <20240729012756.3686758-2-wei.fang@nxp.com> <Zs7jvCHO+ifC3VaT@linaro.org>
In-Reply-To: <Zs7jvCHO+ifC3VaT@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB7159:EE_
x-ms-office365-filtering-correlation-id: 024b8827-2c28-4d1c-bff3-08dcc744258a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aU1WEjcpBKxB1qhN1G+Do5rkuzzqvqusSpe2H5jwAQ0ydeZm4zupi9WBB5j3?=
 =?us-ascii?Q?An12/1WIDl8J+5c/qdW/65C1x/jB4yCWzDzgonOSqohqr1sB/GR2GqBLN5om?=
 =?us-ascii?Q?emTiu7vdW/CQf1DKJQJt+7NwsftoKa/98rkljVgwc1rEqgCwKhqpU6SoN57M?=
 =?us-ascii?Q?3eri0ZM/Nll42uypw77kfnvq/i28LleNniOprJABk/8bpbyld0wp98uHaCGm?=
 =?us-ascii?Q?yZtPHFbEAFy/f6eiCNlsaE3+f9+eTENYVYp4uGEIuZjb6y2yPhZ6/G4imBoM?=
 =?us-ascii?Q?UWnqkMukYsY7X5eCixolfS7rUDzJDLO8YbaOejl3EDrpFRLl66fgTgVYISp+?=
 =?us-ascii?Q?eEtpI5MNnrWVdGs2+MdOvUrC9uZblX/GrplZzmd39/A2xLU2h3AYZDDlieKm?=
 =?us-ascii?Q?5ubvKmonCi+SIhBgPqbQk8XWduwMEc6m4xua7iQE0dqicy9HkYZBwRVmwDAq?=
 =?us-ascii?Q?ajbJkg2yPE06y98sisfrao5e1lfDqD+mSrK2KCviSXN2kT11tXZIicDDq3mu?=
 =?us-ascii?Q?jYZ1VKdVrPke0gBLm681AWqhyiAvklRlbQyNz0CtHmsTytWq9JtFjhwe2P8Y?=
 =?us-ascii?Q?q+/KSIKJG12xMPdfz/mUNxP/SKQL7zqu14lwHzWtZDuRrcpxXHJe9qDd5T7N?=
 =?us-ascii?Q?s0wi53wn4e3dcLtWHUfE6qUpi3BNctHuKw6239dDdE8ECiWUhI9RJMJ34oUQ?=
 =?us-ascii?Q?ItPhmToIZVF8zpQkUuPcAkfS7JsIfySpL6FvidTOmbh5tN54k97BCTd9z8Hu?=
 =?us-ascii?Q?v9iFwK+0BlLnmQe0ltwgJCJdrWmd48tL3y0MY5ZdM7ewvdGEADjBPbstqvWd?=
 =?us-ascii?Q?PabxzpMPScFpxWYsUKNLC54YH01UzDJvE9e6oiHiBB4JRj/Lk8cETGN2qiFK?=
 =?us-ascii?Q?kump6nYEqsakUsb24/TbFJYqNYIePnGjHlJXZMHrkBn0Dak48mTE2Rr7VsMg?=
 =?us-ascii?Q?g6S6ErZq4hXtCVjzEW80WdN6tH1EuMQF+rj1JQkBDpdLDv3WFu2ohaN4HhOx?=
 =?us-ascii?Q?ZyTGHA5b2sLnbaKb1NSE0e+2dk3omM22u0Tth47URs/WBEBhww+94m6ZyR8g?=
 =?us-ascii?Q?mf++3+zOpPhZdpPc6l5YyRAjUAcooWjKkb+vvyFtrDkekl5se3OG+LZIKW8P?=
 =?us-ascii?Q?ZxGaPc/i8SpPD9nhDDQxom5XB/SerPYt4ACowdsMOD8GhJcCXamhn1WIx7BG?=
 =?us-ascii?Q?ATp1VFcuI0aDSTQQLhWERwWGk5iRAX9VNKoRuNwSdhT53He8chDL4RSX9MOz?=
 =?us-ascii?Q?Mp+KElwU5/NMGj0uHSAoQzc+SX8p4He0aGg+4yfvEHFlVY1N80NXeaEl5cTd?=
 =?us-ascii?Q?cjd+9s/jKNbIbg0itIJVkvKTrXzrfgY9KbzqFl2Wxle4qsPtFIzRtnw9k2/F?=
 =?us-ascii?Q?0xYrlH3UzqrMdK7XuLfEF7gZ+pvFpobSg7AVWzKl+oUgJ6a8qw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nogfrDpCLp7hDS5+gk97etBJ8uIfssOARjgmEeQO2HgUb1TZRxCXsogf0HCb?=
 =?us-ascii?Q?72FwHu5z6mbulq1FAcEdVcL+WkHtW2baLFtZyosPcBWBBXgtZHMOalhfHfF8?=
 =?us-ascii?Q?B562o/T2AM/XYATjSoHWty14yZ9N9CecNiFL6QonJI2Vd0eUpyUS5EKEI/xq?=
 =?us-ascii?Q?CrXI2jWYl77etfg2c8eT4V52DpMbgpSxhrY6jr7+UssKXV7s2yl9a7HosvjG?=
 =?us-ascii?Q?DBxufRnrqKn1nQo/+HBPXSZ8yAY2ATSsBNQiThITrHozm3VfXylg2sHecdux?=
 =?us-ascii?Q?J25qwZcBCxO0URtlxW596/DU0r2MgNyPbq2hyjRe5Luu2iZxGSK4AxsM5zQW?=
 =?us-ascii?Q?H/9XT4AK8QJFJr6+UPjn8gZ75PkYcesBqumybFSFftQbCvLIN02IvEKbceEh?=
 =?us-ascii?Q?Jt+YDzJrTAta+Mc17NqfbR/SIGK7iwBbPb2oBFRFB3xkoisCzGLYsd2coVUs?=
 =?us-ascii?Q?9BDvhiMrHPXJgxVHVxhCRflMc5Cjs4Zl0JzRH5G4+VCXeEKz07p9QwfzSDnR?=
 =?us-ascii?Q?InDHbTT0D0b1anph0uCGAgEPH2yi+v9Hovh6c6ErngfFvZkpaSG5xjkgQLad?=
 =?us-ascii?Q?3QYzzSHH8B1012AooO2CzCtvuuhgSzBJYYJZ0M3VHcRSObkceRvdfVfTqg8D?=
 =?us-ascii?Q?64QJcb+oTS2bKAPUiqH+gY6wwWNkQl4mF6O1CuUlACIUZU53p0e6y8ut4oWO?=
 =?us-ascii?Q?pwLDi/fqi5n4CyxC43BWCgF/w0tYtjaygF3kyr6MeN4O8QTz+WW+HSJ6YxTL?=
 =?us-ascii?Q?IOlRvaQq/eYTyOTStw6n+YW1w2DjVOXB39jadTL88dIGJT423CPZEpJVBl77?=
 =?us-ascii?Q?oiqzWTW+QABPPC0l7euy+Y3uvc6MlU5uwhBDeP0RjVOsNSm7zOWZaBSGxspi?=
 =?us-ascii?Q?TMeXunTNStM1W85LzH/OBqfSEyLL/RW06xR9yUwrgD20V+t3KyBQAj19njUc?=
 =?us-ascii?Q?2Ryw/hXG+SJZ9o2OgYPg/VURW9O7plxJN1yXkcnuivEhbyNVfdQXNYkOJ2Vz?=
 =?us-ascii?Q?2kc03AZQSZQ9GQBf4RucyyG3s2n7Y38XsIZVz7yCZg5/8b6G1e8fDmIuqpU0?=
 =?us-ascii?Q?pZYXHqX/NsElc2OZ18w2JoXTLIT/RoQfYizz4PznlvIHBubZuMiSQ5RoYQyC?=
 =?us-ascii?Q?zHStRKJQAMyPWaaZvYIA+pT1lDZmXRk0PeplWuE5HhzcgB/2S0I9YCaPR4nM?=
 =?us-ascii?Q?g1lhWJ0cw6zwIJH3YyPJ0NMFArj4PlBYV6kftRm+GozLc18f0s1zrQEDeypY?=
 =?us-ascii?Q?ju/aduZU0fYQeW6/6+LJ503sGifh1C81zqpw1VQk8xjboQ0BVcYcf6lbkErJ?=
 =?us-ascii?Q?8yoDHijdO4NbgZelB60K1eRX95YmDqdb4s8x9b6XpPiPS0GhPvRdbJ+jCZmX?=
 =?us-ascii?Q?Ib9XFIuftcbhMwimZ/GGtMhgorPvGORBl67ukEYmZZobkOyXFDlhXppl3xys?=
 =?us-ascii?Q?6iqEE4KuQ5EE3fRA5J+gwd2suGLgD970Xv3JWVIqCmtkABNX6u48VklNvRf4?=
 =?us-ascii?Q?u7XuWU56uw/Nn8Y+8D+Ye1lgUvipqNsogn0r71RcdSu9OAJ3nykIi+P24Goq?=
 =?us-ascii?Q?bFEudUSgVvG/LBolaGU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024b8827-2c28-4d1c-bff3-08dcc744258a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 09:31:08.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl88mgOiTEFIyzW+tmipXX0yMumYHdMphTT4Uyva52FBDNfgr5A+sk4hJY5qsRzhbOhD9rOJKSStVmV1Rh4TTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7159

> On 24-07-29 09:27:53, Wei Fang wrote:
> > Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.=
yaml
> b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > index 2dffc02dcd8b..b0072bae12d9 100644
> > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > @@ -17,6 +17,7 @@ properties:
> >            - nxp,imx95-display-csr
> >            - nxp,imx95-camera-csr
> >            - nxp,imx95-vpu-csr
> > +          - nxp,imx95-netcmix-blk-ctrl
>=20
> Move this above vpu-csr, please.
>=20
> Also, for some reason, this patchset doesn't apply cleanly.
>=20
> Please respin.
>=20

Okay, let me update my local tree. I use the linux-next tree as the code
Base, is this tree okay?

