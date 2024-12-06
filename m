Return-Path: <linux-kernel+bounces-434662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA5A9E6985
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB097166B17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7871D47A2;
	Fri,  6 Dec 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VeOporWC"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583C1DD872;
	Fri,  6 Dec 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475573; cv=fail; b=PghyK0fXFBUeZXzaN1OCZDH9J7a6E5aFSgk7OaUSXgNMMcNEz2iI2/2sHxeAwjiKkHgsQvCeRy1y/syMFZqwgLhn7vOhcfxY+Lqef0C32zA6buPggJlaqlKs5mrK1qG9LFsFggBv+Ne+QrxN+/6rPNTYRehy96AKsS7pg59JJqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475573; c=relaxed/simple;
	bh=DxxcI3JNEa+TxnhztbL4N9Wvy6LHmBuLEqvKX+z6cgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=izcidfG0jVK9RMDj6RP/xd4YEfociQ4UvGmAIQqzIohzIKrC16doCOBMYAwXs2tN4lLm/54YSfqbHMaKvgC+NZ187uVgD/hLCejUmdshumGHEkY4f5brXC+n++2BFCuybCxwbDsYCrtqYKNgRfTxdVPhGAJAasVXZ1xrAI6fQqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VeOporWC; arc=fail smtp.client-ip=40.107.247.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr2JLNkF9aXHj589IHsC4wW0twb4L2lO/HgxblgkxHv0H2mr3Mdd2MHAKQRhM1wTtjD0OFcu5XvSeFxKfKBY5rEuQDQrGOhNQnRxbqlWEFqbHnAfU2S9ytu3AU3DE5Eo4SfySlZKjBFfEb7b5L+LGciVt52RRm/aPxGIzBTat+TuLiiCoEzWtNHzbt81iSURjGmZ/lSiaEbslq6CHwFtKICqBMTpbdYwZNWcaJ4/7uQVjjoyUyXD1X61VSkVQ/fjgHtO8mPA9urDTZMIa++xBweOK8cj3yRSyIN4qWyVZQw0KiABeuM3t5VTe32CZah16zWDMc2CwqINTFEgJZztpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxxcI3JNEa+TxnhztbL4N9Wvy6LHmBuLEqvKX+z6cgg=;
 b=xtDn9zKA55E5ZnlUR9mBdhNIWDW8KDUppj+5dF6tYazI0Jrs+nRyWNfXWuteB5C12bReIF1qY69vPQFd14R1hrRG+19Xkw+DS4APUarSYc86C/TvzrjCh7YVjmlA5/DdgrXoOOsCBUjq66EwnTQQK4itfuugfJJbbjPeLnrqzOsv0QJPY2EUS3PCboGQRC44Frf0bODem4IyBHBsssrAfonW8sskj8zDWqp96BU0tbxrMmxmjFMeFkdwmKjwMmA2xgHWTNnXNl1nNvRKwn2MquRNTTTW6oawsDZMaNhK06FD6UAiBmNtl+10W2icJg+T3m3xQmCknyDILJpFJgjjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxxcI3JNEa+TxnhztbL4N9Wvy6LHmBuLEqvKX+z6cgg=;
 b=VeOporWCieOY6sniKW2zwFEZikFSHFQ6dcxj7+ZsiHCkzBhPMcNQbDneD2ME12340TxfwXW/JVUhLCy0QFB6+8Jq29oJx7Ighw+kKj+o0oVoWD3bO/4zVP30TPN34SJxSLlQMLTVYHpEdn5nJAX09bcMy/rv7aHq6niuKvUxRDjZubPeEpuxExNMMHEegcl57MyrieROCOOPyiwxTE56Y3cxXPKBRi/6nV/lAL/JJju9iL3CjOmXWi0Gu6FojBZL+AzVAALeyjvgaeSu/ehO5S19wlu20VBW+zhpJOVR8HWX+65gwIeZZJ2J0RFCSIP3+0Zr6WOw822P1YldJY4IrQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 08:59:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:59:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable Open
 Drain for MDIO
Thread-Topic: [PATCH v2 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable Open
 Drain for MDIO
Thread-Index: AQHbRydxYlA9gitvA0qLoVs4V1AIs7LY6+Ew
Date: Fri, 6 Dec 2024 08:59:29 +0000
Message-ID:
 <PAXPR04MB8459234E55143042090E5CEF88312@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241205150730.3132807-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20241205150730.3132807-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10727:EE_
x-ms-office365-filtering-correlation-id: 41d8f04b-4e1b-4d4e-4123-08dd15d44aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TwyKkXRXsEBEwyZeOBTsUvk4NCNybt3PXMusY539hB7or60AQAaEH56W60KF?=
 =?us-ascii?Q?xjmQCiG3fMYTpxMCfCCD1WllTz93kWWTK097XyTUCACuAGKSxoRg+cRJYURR?=
 =?us-ascii?Q?hHMYdGafuRSvbQ2XyGkkekhN1FvxNoKu7cD42J7IJ7pUHAtaQ21rFca4kQR/?=
 =?us-ascii?Q?NZstlYjMlaE7RvjlKQjenTH1CrBibKSmN0bLaKs/jChPhvtQL0dA//38IgsU?=
 =?us-ascii?Q?qWbbMjrC+rIvpi1FRe0PDDJKk6b13OrscW2WH81LZYvR2TX+hCGiozCWT6Uq?=
 =?us-ascii?Q?w6R5QvSGflzReEcZcwZ7DBMggMT8mg1NrxctmMTNM1pO2Q1eZAlJDSh6+zrC?=
 =?us-ascii?Q?O2BI2yhIISkFhyQy4zQ9Btyb6d7si1DG2ytMBuM65dGU5cxbcWpjL1OKc1JD?=
 =?us-ascii?Q?0qIV6YczKEoccpytljiePp6LK8lJdahdY9oitzMMdi7YEzxv9GpGsjY4zrRo?=
 =?us-ascii?Q?lXja3WkRI55ECd4xy+9JFZrgt/bjn7DNsoJPrn7ANDSq6sRgvJcEv0HTd0FC?=
 =?us-ascii?Q?UuwKURnfFU1iAV/K+Y1ewpFa4Y4//F53X6zFUZsgvK8DROhTbaSV2VSPlgDH?=
 =?us-ascii?Q?ndu4AJ53FwpBOPrv8cFFw4tSF7yDZ8SuRr64IOCmARnDJ2hGVsBWdWpKpeWM?=
 =?us-ascii?Q?yCmT26+RjmB4kwkKnoE3v74zGCyrny0dFm2Koyo1kMiCrSLTrRl9BZTwhJP+?=
 =?us-ascii?Q?CPisAh7qtGFFqRVszkWVbc49B1lIW051XHO+/l5hM9cOFoaoWMiMZtIuQWFx?=
 =?us-ascii?Q?uNw7PNQMv/24JZ6sT9Ktqkd79g6gFrtKIen84kJir0NjP0J3d1XhOC8FQiW6?=
 =?us-ascii?Q?2H9veQTW/EfnCt3AKQDOf/NgLd5gOt57q4rj5S4ptGwRL2JG8r0iMw2RERB2?=
 =?us-ascii?Q?dupjY6TBK687md3jDrwbWb3hC6FzwqPPRfbG4gO9qsXb3K3G3BzJgiCHbNhL?=
 =?us-ascii?Q?hGiIzosPeRdPHwIDwygyXIMKfkIPugnPimvLSQrOYfdRwCH41Ak1AVl7YSqJ?=
 =?us-ascii?Q?YOYJj2MJW0QNnAtf8om9/5mbEtNe6m0IA+va6E+KoDJ9Gr0qdRlmUJRKg7vv?=
 =?us-ascii?Q?ltkofdR1TyuVaoQlfYirdi3y4k88HDAQs/x0/SogjvQ7H9tTSpP9jfa16HC5?=
 =?us-ascii?Q?vAcsiQMQUhmF2gc6Ik2rSQ4zLujoMjq5kz/toA+IzGTTgze9JIyOzuAQUJtM?=
 =?us-ascii?Q?6B7WJvuqnsGZMXr94DJokw8i3hsxJ1aSs6Mo6p5OBseNoFgugubWVZtNqFuw?=
 =?us-ascii?Q?Kx1/wPjNTVJRHoP/0AVsagQ+2iyHpUgrNJ+TEV2ti1csOKtRChRYhbMLZa/T?=
 =?us-ascii?Q?Wrqz5HintAR9ueRd2ZCC0ScWTKeOw6ap0aKHF6sX0RSwgpllxblnAAQREQNP?=
 =?us-ascii?Q?3/zz+Eo/ekNLr5yTHfTpGjDNMcP8+kiGlaxjH+U8CvfkBYEsgg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t7FOVod8E1ZTj0jJvRIwtcCR8xKgzzQnOmYZ5+YLp23btjJZTZhxeZ9seP38?=
 =?us-ascii?Q?XPSgAIojI674fbScKI/ReUz2aJN0LHHu3C+yOeMaIPr2C3hVY0fz1R0E1/GU?=
 =?us-ascii?Q?drjdU5KajDX0uiufqXhJLMZiOCFxIegIlUjQP26PN8eJ97F82FmMBwLUsrq8?=
 =?us-ascii?Q?xBDsokqVZ05Siav6fLSgtnfNBpY4owDPcLxZDMQccqXhrrtRnfTCEJZeeDOl?=
 =?us-ascii?Q?l8Er2BNiEnKz/u/bxeKHsLURm5CWYpNhpnTEo3Xo0uiylktkR2o4UnK0vZll?=
 =?us-ascii?Q?uehJMDgj+U2mCHh53IbMEbdxwPzmY5biMS3GVZCublMPRHH3+Q+zqGnRG4ll?=
 =?us-ascii?Q?Z5QThE76OvmftW+aXWfi2210VpbNIHB+h9vwHXfLYlqoFlY3Dmm42xsyup6O?=
 =?us-ascii?Q?oFJaOIyJnY6y9M3ip4Tum92plZBXYrkeFaKBnsCt5LXt0OX5viNoThgSXeay?=
 =?us-ascii?Q?WLoyEm093guS5ztOdDPbnREG5gJZNPFWVydDCrMIevjmRL0c/TtJ+J5YcSbM?=
 =?us-ascii?Q?MK6xBC6eiZoHcJrm9Tsa9dLqh3+8o3oVbCLuJt4v7M3eZA6RqucSvRjvm260?=
 =?us-ascii?Q?rBshJbaAc4sZQmd/xKymENX7lkQ2f2bOHi3WW97k/szHiGcb2ASBVmbnM78F?=
 =?us-ascii?Q?USZ84Tlm1wLc6tym4eXJpyIUv5qDo+txecLRbpL5bGcMUjSKpQWsyW3rqklN?=
 =?us-ascii?Q?fQVSrX65IoD+EBQssonQ7tSS+onjhrRMLGf4v7lOqKeoFwNkedyPIECT00JF?=
 =?us-ascii?Q?n5+oMJAXaWhyQVzCT7qXci9288L74S+NY+Ev7bOX5DrwxPJ2FYpKoRgmaDLf?=
 =?us-ascii?Q?6Uc0W27to04Qbofx/kO2hwgCN08pDTQwNDYS3zI1jMOmUA4E6BQxUFuI9jUH?=
 =?us-ascii?Q?t+A4qcxL52xIbr4gb+dhsRudSca/Fa9THXN2HN7mAng25Z9TS59LNjoKw1Yc?=
 =?us-ascii?Q?E9dOfO2CoYlFJOcHG+Gdon6b4LO6wBf+yOKPonGXmIECPSAodD89xq62akER?=
 =?us-ascii?Q?WKOKWtM9B69Fg26jJyAW6SM2aJpwa7WgU87sqguWjvAfhYmaYkCsmZlzBYS2?=
 =?us-ascii?Q?bGAieViIpCswwUt71CdCOMRrpeHz+ROB7w1/vquoFv306wpOO081xN+50VVj?=
 =?us-ascii?Q?4xxSzQiosjqu5dj7em2OQW1GSeVkgjl4hsQm/7R0mbyjXySH8nvSgn1cHDCR?=
 =?us-ascii?Q?hvJCNDAzUiyIfByC4q6IkgU8M/vUXzM0Yo9Uv7+aR5PsZTMkDqJxZYS9cORX?=
 =?us-ascii?Q?3N2b9z53GXHYaHRupaFUPnIEiDJF1aW9t8ZBuHPtFMroNpAiTIpUouzY+dx7?=
 =?us-ascii?Q?g5VckkDy6dexINKmr8A5Puqdjxd8fs3HDMUkOaAYE4gL11VnFacA6V+gWqw3?=
 =?us-ascii?Q?Z8n67Ii60ht8BOfYWPZJdxk/lZnOMc3yG+SaZbB4/qyt7HE1N/Kaw1HYQewE?=
 =?us-ascii?Q?tv8rN/+ZC9y7OXtZDGS4qiFBk0z+4YuM/VLNwjJSKPMW/tebW0QH+YMZ/ex3?=
 =?us-ascii?Q?faMcaBDWIyvaUV7NbKm2OQIHJxjlSRZf7wYibeZzDFULWA+7KlyctNJDd/kE?=
 =?us-ascii?Q?tpDE9To7+O3ThsBxEPw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d8f04b-4e1b-4d4e-4123-08dd15d44aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 08:59:29.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w949rCTBUdjkuzdCtttDq/etgabr0bgbYsZY30boVce19dMc/kjHMQpjwOgVzjS78mGL/u6zpr5GI/lUcOESrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

> Subject: [PATCH v2 1/2] arm64: dt: imx93-tqma9352-mba93xxca:
> enable Open Drain for MDIO

s/dt/dts

>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> The board has a pull-up resistor for MDIO pin per PHY design guide.
> When MDIO is idle, it needs to be high and open drain is better to be
> used here for power saving.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Besides the typo:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

