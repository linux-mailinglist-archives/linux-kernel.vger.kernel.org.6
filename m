Return-Path: <linux-kernel+bounces-270569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524E944187
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92921C220D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD313D282;
	Thu,  1 Aug 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uzzy9Pdz"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013050.outbound.protection.outlook.com [52.101.67.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7401EB35;
	Thu,  1 Aug 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481616; cv=fail; b=ECIT0xORCJKzBCLLEF73nLkVo5rEHxTv05uEo1+5X6AuyVnrt9fAf4SrYwyFxBugaINkDbbmVVN3UnhRn0rg2KTEaSgTueLPRAiEzLSBV2Lv7fJvDm4y7Vieq0uGC4bhoNfKJ5TNEDaqSG8sJI7I37xIKxr/UTtRBN8Dag80ewI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481616; c=relaxed/simple;
	bh=4h1fgoS5QtSxfQwOjeRDipCEzOoHPDYEDmtEL14PFSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKAWnDfaYixT0+lIKJPAYI5iikWMfVWOciKEoNLcFki4ZR+Nh6Q2opAP6dybeXU2Bo3YF42gMoF6j9gCTSXRT1XNxe1tQNRY34/O0PyNvjqdBByaZ5GHoDLKrCxZ7PuoC9NiEGIANIcqm3Ut+uB2Z9oSd7usGtCFx+SxRZWLcG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uzzy9Pdz; arc=fail smtp.client-ip=52.101.67.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEgjNrV0lds4cTtMW3Wt2HYdgCRe+QjnTP0zxgNihKzPmPUp9xAqijX/7DXJdrOcgw9pkDUr0JZz1MgIZzGnKA7zAUFlunVEfBNBwtNZVDZxzq1mECxzNq10m5TCIDaKD3voyvA/X+rJ8A4UGKq0ZOJ0irCYqaNIGGQf2gWEbMBNGH95q5g/EcDHQpTozMlVD323PvkoPJGRbPzTGcHVj/ET1e0R0jyq/eEUXEwbR18AvQEjmyBJKl7uaZvHL/s1Y6gTE7LtQKZbf8uXa3zjRUuUS3hKGy1DmSHi4beJ3c80cCzcdx0dntot2jFiawQCxoNxmCLOILFOMayEdZ990w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h1fgoS5QtSxfQwOjeRDipCEzOoHPDYEDmtEL14PFSA=;
 b=XG3flNkv9FJP3rnskXUf3PmCrU+qlOL7UT2kMKLr13dajbUB7VwpnEKCgOHLPzs5U6OfXdGvBvhta/j09AZOgfCJu6ZUD45Pk9aUMshy0ZCL1jVv3RBYzW8oj2+EKGTUg4JKhnvTuqqBpKX6uvW1e98hI8lC5j10OCbfa1aQEMrUNw7FlaQhWsKnM6eFNMdV3TZK2mOqG/piRcuzIC5XviKckUM6i4RGutcHrdZFt4eYEPahjlP1mRjRfAw3qUcNCAVpnaU75MwB59+QAXZ8dRgJgN/cuxzBCEuKK7tuRS37jWm5W0PNAkPnueDSZZ5rV7HbGxK/xUFtJWNIrYEGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h1fgoS5QtSxfQwOjeRDipCEzOoHPDYEDmtEL14PFSA=;
 b=Uzzy9Pdzel5CZZyA6qajKVpE72VxQhJExUjZWBL5dB1cqcmEmClupcJTMjmvAuhPa5BwLOZ7dw4DK/uDgNpAsm75Xo3SY2nNZQaGGRn+42LGqdUQUtVRanhYX6p5p506G3xvBXNkDvtucAcLobwMizuObPFFVdblMvfiECWgETtIYfCAuwzjPr5pdr+SHSi9plHuyfDW3iB5c/XTugVmdJ4Y/SLmmb20WuuxsPBgECN2xc8LCo2jbAQK+GKlBtNkSgj8J7wPWkuGfz+VNwe3V6+IVYamFvEVMT9HdI3Yko4mIcL4m9KciOf1bMCWk1isvmXQKqZtl+5iVrzV/Xuizg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:06:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 03:06:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux@ew.tq-group.com" <linux@ew.tq-group.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/14] arm64: dts: freescale: imx93-tqma9352-mba91xxla:
 Add ethernet aliases
Thread-Topic: [PATCH 08/14] arm64: dts: freescale: imx93-tqma9352-mba91xxla:
 Add ethernet aliases
Thread-Index: AQHa3cmRdtZxP0u3bUWd9Gx7MkJrb7IRxA2g
Date: Thu, 1 Aug 2024 03:06:51 +0000
Message-ID:
 <PAXPR04MB8459660E3AA9CA0CFC2241F888B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-9-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-9-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: e0554c27-0ef8-4c46-5d7c-08dcb1d6fd93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8jz+lfw7OJpD+2XPXy4g2ML3RfzuHfGMQtKKJyP0YKKImzDqT3HFmmfRTiVR?=
 =?us-ascii?Q?iJXSXjBvxxwtjHTul4I0+GvPydofgbYZVPQVR8v1KtDJTSEvoXBIRj9BKo15?=
 =?us-ascii?Q?hcgzSf57pw/BkBB5d35UhDwiK9IZgsruf93W2+J4CFFByc+/7qauBmTooWxZ?=
 =?us-ascii?Q?Giapoo4n8t3PS5hO17ye8RHmYgGhp3O7+nyoLM5keV5UsMALha7RksEJ0LUG?=
 =?us-ascii?Q?OO8UGUhv2VUx++I8PeTPlUmtTW9NFj4clRJD2Zv7M1/n8nWLLLigv3aHi+z0?=
 =?us-ascii?Q?eYO81XxnjD390oLQ21f3f9UNP5cwDzc+9qVp+OyTPKIZe8fIotXXMN7uHZcu?=
 =?us-ascii?Q?OfldaXlNTaA5kl1lsXPz58VHh8Q8CkbVW+ptPBJaAtDxFI27GxNHpl1P6YF0?=
 =?us-ascii?Q?q+SMIgqNSNTlCgF+GKW+CNn9icF/1IyVOT5XlKfduxYYOst+ep7UgSROwJcT?=
 =?us-ascii?Q?lMpfErQTYjh9i5n05Q6coMRPqYyZnTfdy20jsdv/d/a/BftF4FINP+DNMAA7?=
 =?us-ascii?Q?cp4mMaQNalGOTGpMPhWSWYiAZYfi5mUnPIFRlQdB8NJ7k4Btwt1tg+0pj5hg?=
 =?us-ascii?Q?NQVIbhdfJ05PEN5STn4MC8arRdSw6JUn+p7qoBYjEv9IB+4+IrEMVnhbE63G?=
 =?us-ascii?Q?7vGp6exUUIeDusnUvJDOLmSd53RB3n3NReawR2mwRNXERaIeuL/xSEHUaEwD?=
 =?us-ascii?Q?jadOkUirQG0maV75pDayY6+yEG0v6xVcOvtQOeKA7JZigau6Xxv0TjdwsTmi?=
 =?us-ascii?Q?RX8vK9rn2RqLLcDpXeWSHzkmJOQ4HQl1S6ZcY/d0TVOriR3RKgs+FMRZJEfB?=
 =?us-ascii?Q?QHIHnGT5+KAPnUXHRr0ObiWNhYozWH97I6oydp3bUZCVh41NhjihC4J7qa1b?=
 =?us-ascii?Q?h9TED9uT6Ruu7rPbRL/xLjcL5swaz2tdZPvKp+A53Xj2O8kLg1g+j3lWRbca?=
 =?us-ascii?Q?K+rY6mpqpZGIjjPDtRQbm2oAvmtd12clhXmXy1fpSGcyM+86AJ/daBWHGlLt?=
 =?us-ascii?Q?tKzMi10rlq8i8AgFaVXuJLATkNj1hCLRo9sexqlenksYVDu/LTUAp1QpZW8u?=
 =?us-ascii?Q?4zdpUZweOZqUm+zRFlAaGjA6hGkgNDuVkYE/Z6FTNkTzKb+1C4/uXKDW29mF?=
 =?us-ascii?Q?cNSYW030PXGoUEr2E6CEmPR8Nub1M/E1I4wdpdM7GYVcfyXx6daA2mmXbcl9?=
 =?us-ascii?Q?1GLqjc0XyipKst5Z9GK/CyNXG43UkBRg+yUuBH4h1wLAV9plmG55+6J5vMAx?=
 =?us-ascii?Q?8a5L1Vuoboc+xB+JilKAMi5qVlTx2sIsfOCCDgAXXnPZjXjWbfxlqTwG+Jt1?=
 =?us-ascii?Q?sDNHemz1AxB8eTAgwgctDxV3BNrN+g/TCBeULzkE5yDkCFdqlF+g804VFYsq?=
 =?us-ascii?Q?GQg0Rxmso1LAMrqErSwvuyhcrgDayVomckliX/K322iC9iQoXA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U10jYKE+37D/aUzCv/5YF8D9uWuXVsOR+mT1J1q0HCT7CvliCgcCU3L0dBFp?=
 =?us-ascii?Q?jaPmVuuNLyuV2pJrje1yJF6u6qGLEtEedGAp9fsUa+nEff/dZSC+S4Am/63G?=
 =?us-ascii?Q?ExqK3sBXOw/eAOVsyMf6ZpZG2fV/ac+JzC60FL9n5x/gNl0kFnY9LDjf7qZl?=
 =?us-ascii?Q?8Yq96nA9Z0+IGyWseYmDtQCNA/YZaN4dLgsP0md6SCUASONlsgXLQD+P19my?=
 =?us-ascii?Q?p64swast+0iIjguVlWBOhrCQln0IGcNsXnw3t32nJhQZ3xi9KH/9IXvaaovz?=
 =?us-ascii?Q?I66ESX4SXtkGqvkQBpm4NVi+KtUhuGy20H1YPEhin/y33c4GZyyk4xr+KzT4?=
 =?us-ascii?Q?dYzsKM8HdIt85TIxaKTblB3OJwGAAlfjXVrHBV67hSlkinuM/iZcyr0C9D6Y?=
 =?us-ascii?Q?tv0dNo0uE24u6ll1KGn9MfvChmCaoYhcA9xsO2gdriVJnJCvushtfMxRNNX0?=
 =?us-ascii?Q?WM53zniT4tXpdVqAAeAtWCpTvneCPwU31OqS/WBHXGPm+uTFyVq4fpKm7AJX?=
 =?us-ascii?Q?CGECjfbGZ0CwLXVCSvWPCHTn9xE564gssEaQBwsAc5dtOUGV6mgrHaq5eVnR?=
 =?us-ascii?Q?jZApjaS0J1BPk4wXe1iPWhKlGwNnqZNF6DwwC2ODor5Dy+u/oRFq5nraTUR0?=
 =?us-ascii?Q?66nhuwKaDAa4fLZ/Cby3Hz+8+bcWXfVZHbm9l+XRmpnDkFKM169G4LUaka6x?=
 =?us-ascii?Q?bSfyTU0WNkpuZLrU6W5+HmsnsYMWS2fcmrzQ4kMa1Vlg+nnLrMGaqYjn//9E?=
 =?us-ascii?Q?3296R5lmDjAMChTF8sQjBEmIEBma5XEqJGMLhAjredYO8fKSa/CQmVJKtA6y?=
 =?us-ascii?Q?wzPFPdUSb3ZLXNLN0HCsoIBjgEoHJRLYmfRjPNNOgYByEezM+7/d8v6lNqlA?=
 =?us-ascii?Q?qmgWejbG/kdVJ6d4OYKOh/ovfSnz9jlOT5cglDa8y09xSx+IrMbenRPjr5UJ?=
 =?us-ascii?Q?J+ypKtYR8PNzWVAKFMMGu73V3ojHs4kUEDZkGp2gwmDCrPBJxo21yUe/afMO?=
 =?us-ascii?Q?vjABK5Xck00rSveluYiBtjeL1qTfhVVJVhW4luHfn4NUCCduBETb88UhkQ1v?=
 =?us-ascii?Q?5F9p+ufTa6wOptJpGK0SpHyauVH2YhNQp0JAocwXceNqdz8+s6wvI8UBKS5X?=
 =?us-ascii?Q?2ASTNXRuKgFwf+XBTSkjqh9PuKRgSEeddpbMBcodnEj9vsGBzBZbiKYWxDFL?=
 =?us-ascii?Q?fDJeyG78/xkP5zZ7YgwI6zsI28G2/XDmr5FiKOcPUyF+3bm4/lzTUGHxPljP?=
 =?us-ascii?Q?jyjsI55WYjuPJ30I1MnWptIYq/rvShUDONpFzSEJqxmngzmPAZ0xuJ8Xl00W?=
 =?us-ascii?Q?8W2iyCAwL3rwYrhzwi8ozdSfHm+t6fPmpb452mXUA++ZEEWTphPjhv3u76EU?=
 =?us-ascii?Q?fla3O66r+T5cSsiPsGYbwYOyhBX3bqPtPGqtmItWza6BdIGkaLkL2YAUrClA?=
 =?us-ascii?Q?a3DwwH/sWk3BE03HEC/a8GJA0rm1Kpe5sOQbpnEwKpLzXIY4xeGFr+IMxWN9?=
 =?us-ascii?Q?YhLhAqhLlpEnQ/VUO+UaNA+1wwXIj/BFXLglcG1sGZaYOsdAX1JUHCtgjshA?=
 =?us-ascii?Q?IEYHBiJSIQUuWColoEU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0554c27-0ef8-4c46-5d7c-08dcb1d6fd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:06:51.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jB1znNVaQBmTHdVgJ+zb7diTzdtHEwa/Ku+T3ZHWgK+Q9tF/ckAyitxIatkWF4xaexgNILu1idhfMhR0awA4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

> Subject: [PATCH 08/14] arm64: dts: freescale: imx93-tqma9352-
> mba91xxla: Add ethernet aliases
>=20
> They are used by systemd to rename network interfaces to predictable
> interface names, e.g. end0 & end1.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

