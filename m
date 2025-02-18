Return-Path: <linux-kernel+bounces-519546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA92AA39DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439D3162885
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B292690FE;
	Tue, 18 Feb 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rk+J3B6J"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55622E401;
	Tue, 18 Feb 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886218; cv=fail; b=PEVJYDt1+ajCGbIt+M6SKNcCzIDOsQ/+f42/AdY+BHCk/jVfxQKm96eZr+Tr8L4PNREp5hvoGVuBmmRI0h4CepjOQb/VqSLlDv9xTnqbZAxriZ8wD/m+2rwB0JhNzPuy9/Hwkmxo6BebOVc7GKFJ/6zVc5ZMa+GMGZUuVE85WWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886218; c=relaxed/simple;
	bh=MxtiT3oAbUuH/U1FUnQdRQ6aOJhqrn2rvNwGx8QXDqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2vEt0RcFgFG52a5gDYwtZbflbjJ4xsa1tokAQZpfur7VdyXY2J7VyCzimHbn9+Kd/eoJ2xZVE838pOYwBjLhTYYhEgDuEEaYtYhRReWFX4OzPqkWHOy5OL5/RoiLeOGtczOk2395xnaK03glTxBUsHOZVmE9HPIOpMsqa+tdCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rk+J3B6J; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh5kGsvKG0l/mgL9TYLGxrlz4ZiiixTEFbfvl2wk3lYaXj7w5xe/HVuw3m0EVQuc7xksQ6mjB585JLdEuvBh9t1qXzEmiKaNYRQQ58FQGB/fW1bd9zt37Zs2HJ8EYsHzew9vuPM5PoO7GXAng8FuGIx7qZ1cSeP06uWlktFpHm192v5+GqcYf2qqvCHclCRJAN8b2kFqtlGoCcQuYdL625yOXWd/o+4GOYW86cC8Djf50QY2uFbXLf4Vio2xPwM7H9OMcLkjHbAtYWYYhjwNSD5A0Tg1g2bIQfuDv2p53gmaHfB3d9kIHM+MlDNUTGbocsTW/5Y3EMMHi8gHA8Orpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+vab1wHgdUEX3Nx3FBsyg1OPW9fOlzOEZOmiZXmcgQ=;
 b=y3NhKbUiS5G6cEGL0+iXv6iN1R8MCxpldVrcdhouOL8yxBA0Sbg4DBjqHtsdVoBi+Icpo/G6V5/B1VuGBNTl4FLH2SSwWvnNihXRPIYncrSylgPS9giWwDV6cqnKyY1F3nj4hMG7CZ1zQ5+Iw7v10fp8B2/gK9sHOj+x/YgEgMZ/DzceXVKF2FkqeINGmis7G2PQ/NdpBXrkrM63MQKDCoWU81FnAWWRhx4MoUByzLGZfGjiPj/F++QRjpmmt1N176k48WPTt87PDdWt6PC6rA9vbZleLlfBDjEt547sGPaAraouAnh8e8Ews9P8WZZPdBSunbWDep7mKU+axhhRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+vab1wHgdUEX3Nx3FBsyg1OPW9fOlzOEZOmiZXmcgQ=;
 b=rk+J3B6JsW7AYpV+3uxnTVG4wykhygPCuOkiHrwNBrPB/LJohJNYnp6Wq5wo6OFyxINzw8+OfFnwj42supoq+OE5MDmLdBfJt9Sz9fbs970cLBEitn8EAbOcyvDmN5l9Vd2f3WMRhxK2tCHfCSdGwMhSM4YtgavAQTXlK4r6PLl0O2G5AmuECncgBgi7DiZBOfU6Cx5/wICYVOz3okwm+FvAV71VI5130rCdd8Y6mUBd7KlBOOpWovwrZXLaRf+hYG6AH6tVhUvSZn6pqQN1tEbB1fGQWE310o8AkKeXjW+51p2fwt4d+wEbEkcD6YU5Sm2FYIvFQjH0rRZHnUd0PA==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 13:43:33 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 13:43:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Abel Vesa
	<abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut
	<marex@denx.de>, Stephen Boyd <sboyd@kernel.org>, "S.J. Wang"
	<shengjiu.wang@nxp.com>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Thread-Topic: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Thread-Index: AQHbgV18/7n6OoA2iEW87/e550ILC7NNEwlQ
Date: Tue, 18 Feb 2025 13:43:32 +0000
Message-ID:
 <DB9PR04MB8461866A0B6A068E49D53FBE88FA2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
In-Reply-To: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DBBPR04MB7819:EE_
x-ms-office365-filtering-correlation-id: a6096495-19b7-4747-fcee-08dd50223c61
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?heqAvwbAAVDqC6rmirTb6opJIG4C5dcjCv/RLMqbPqw49Wh2bFj7WM2J7pQm?=
 =?us-ascii?Q?jGtCp4jl8qeHdKBA24X5XV7VdRu3guQ6J6ZBbyORNFCjP3ycF1tjhCrWOMbW?=
 =?us-ascii?Q?Rl+SbCRL44+dA90rKdVEyHL2uK5m5smc7m7i2d2jzS6WjUdwly0yp0Q3vCl9?=
 =?us-ascii?Q?fsnUOrYN1SPFK6KZ+M9kbpcYIJMlBlOW7R8vlUtZ2TMgGHcgveFQbaFVF+Ud?=
 =?us-ascii?Q?ofsgg/ke0KdnSr2DsYZkLKn5RCoObsCurJLmrHf6uiGC0dxxEPH9rkjXB8wh?=
 =?us-ascii?Q?twYF6bNzNW7hwk+KXmTBLnqR6O4w91mdFfwjJSQKnAGunbr6Oc54RPzgH8Np?=
 =?us-ascii?Q?0hd7LVijXtedIFLG44oyL1jbvHT/7nhdT9OEX9xX3CCsNK7XakxEyCedXTfD?=
 =?us-ascii?Q?NDH7OryVnaw5r02kE2vmoiWAZgo4AqMzOVRRnZ+4bvzdWG1o9xkkqt8yyubg?=
 =?us-ascii?Q?4m4vGog9hvybJtVf8d9ksJhrgtO4ntzf/QWxB8mXvjr36bCtXYXDC0+mQyR3?=
 =?us-ascii?Q?hTBwVrj0KV+AhxmfdwfVpoFNHVBGZKTDsbSAHDeivb4ZdKckmx1VTlyZ0q0l?=
 =?us-ascii?Q?gX8ooI0epoSk/paVZ6F97fVLWclGvxhmdjguLW3JDfJUr8CbmX3bjx/UzEmC?=
 =?us-ascii?Q?qXPXe5EJ3+MAb6HXjVH8Hh1ApeRZOOhpqD77KKT2p1/vDnkbwYxIhcZmWZev?=
 =?us-ascii?Q?yxBdvd8B3v6+pnS21i4Sx3puK4gMuabODqCyjauPxQiqBfwGIFSwPnw9qwEL?=
 =?us-ascii?Q?/kDWduBasx2ByiwMNm23U7RipZJ1C/JUnGY/xLKihtl405teMuIpnDI4FbGp?=
 =?us-ascii?Q?8x6RFT/zLymqCw5AwKXUhxzRAh9TYXP6sf06WOa6qZHBqlXGFDp8vZBwBWCe?=
 =?us-ascii?Q?c5RLtxiWApjf0xVvH9jc8EuD/AL2yCGPCrj6Vyl08WB74bLvDLgQetgl2rA8?=
 =?us-ascii?Q?fJnfEXrZjxJefJ1NsHYqeOaT9y1K9KWwMzb4OACebwZkr1eHKBaIoQt0DLNo?=
 =?us-ascii?Q?bcR8ZpsGtD/TcrvJbNa6WZQZqeNf47g0eRPNuv2x11Ye6c10UE4zOA2IDd45?=
 =?us-ascii?Q?gRfp40OFV3b9n30NMMs7gQtiex82rsw3bNdLKzeEJC3NdIGnB6GMpYYKCTc0?=
 =?us-ascii?Q?gGGV4inDGm1YQrisXO15/RUuVkS+5jYYSggYQz06/wXOUWTTp9XcoAIaBPDb?=
 =?us-ascii?Q?zvQp8+V3Azu/1uwVHRn5WGSZvneuM+Lxa3Cl5Vf9llTE4yuRheM+eyK76eFF?=
 =?us-ascii?Q?nU4xq/zwOkAsP4TmkfuJrNaeMghY3FDpkiQdgtrraTY/vhjL7+sqsX7ZkdDg?=
 =?us-ascii?Q?c9XEZtasgg4Omh6J9/wBAVT2sOBnFSdE/o5Iz6A5YwPsYNCsKk9G0PT7U/oW?=
 =?us-ascii?Q?LzdFFCyV+a8FaJKrVJ2GS1EaH7zjtSeCQZLLF4sDEdCKcGb0bK/TAYRzQ136?=
 =?us-ascii?Q?bY11Nnj+UGw9lIgdF+cWC9BFbOhIlxYx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L+/Gk+01VlH6s2a0hVgItY45BESKmxIKwWA41uaYWYNsrP2NmydJIRZz2lpG?=
 =?us-ascii?Q?sfq6yizAdkoE6drOUVjDKt133H8Zva3KEXJcP8DpN5TVwJmptMd04jz2E4ch?=
 =?us-ascii?Q?4K1A4QO6atSWUqpD2lg8XhePmLzL+QoG9rAgD0zuqpb+qF2BbbDDNYOhonkl?=
 =?us-ascii?Q?VFTqopXaLuaq8yOFPsBLdyrmTBypc20Y6iRLsNR3VUoaPgT/pTCtKsUFGNFI?=
 =?us-ascii?Q?U0cyylSlv0KZ4blKZpYKfSosRaGCoJiY/0opTUUYxYy9gO9QZ+Sqn1SAux+V?=
 =?us-ascii?Q?eMfolsuVq6NKGOer+aEjibkY6z8bocwjCfxKUNppYtOrDbmxtg4JrSXep5pC?=
 =?us-ascii?Q?JneasBEexH3SIpGTz2eCRAliFGbANCTKHdC7f+Eq+MpSGnBcsfniV7EWN8JK?=
 =?us-ascii?Q?zrHUHXKYPLqxZ01QEM83dn+1ew7MS114b230JtWA6dCM3EqWTrEE/2G0pbmB?=
 =?us-ascii?Q?0EEKseB8C0B8/qlfaHTbogFhHWX5y9iC8W81RnIp/MHFZdRGX1deG3j0UpAK?=
 =?us-ascii?Q?r0Tj+6cP1uLu4Zmux2Kk7QuVaxLGPnnFxOWzWE11D/w3sd5ZYKejJ9hWBDNz?=
 =?us-ascii?Q?QZXwxiuwG5oCFP5iE/pJI/+H2nJt2JeNwokv3NFRjD7p6f6h+jDjJKeVFb8e?=
 =?us-ascii?Q?H20gWJHT/aqTwe/xIwTYjXQ3tr1ymXb74tKORM/KDuwyteYQc6cHIPmpS6QY?=
 =?us-ascii?Q?yCf+KGqpdZv2eVNyfTVSdEIJRDTzk0ZePpH3L89lWWR19/C/wta94lMCS/Dp?=
 =?us-ascii?Q?sdxWMnx6MyxZe0fUjx3vLMueOJZvl6NGovv0lOmt4zVcFk+qX0aQXLP8Clmm?=
 =?us-ascii?Q?W95ulIZGUIBkOBD5ictySkBs1mQpkS8d1kLZBAbKYbLLZJUUc2xRbzDV/ucw?=
 =?us-ascii?Q?Bmz6yB/HvQ28fYI2czbA5chNmhKTsyf2oeQ5jRaSACwb4bPWESuRyNUOPun7?=
 =?us-ascii?Q?Q90cqHQMnR8toG1R2XANl4CUikNYX1yaFRYxPBi9Bxxcb05/6EC08EfPDGIR?=
 =?us-ascii?Q?BV2xo2OoSiEgj07TZp2upyXH0tEMDJdkPJVZIOMAbMmRbzzPpZfB4FKf80f1?=
 =?us-ascii?Q?JqtZ/d1KMIYMK7VkiLdAfXZWTHAVB4rz5WHxo3EFn4pH+cQ6TXCm3fIVNMz0?=
 =?us-ascii?Q?NQ/fxmkVsGbJHxOregqMuDahkSKCayJbysUjzp5HASfDb3AFw9l0K9hzZNxi?=
 =?us-ascii?Q?rIHyExrhJJpI+sHivxMuwy1QbVyvirkWlas0yOLdCvgqwFFFGejnoJQOKU3p?=
 =?us-ascii?Q?iHsfQ3rH8ZzK8iRQ+hM894R25EAKLFxo6BESYgamcERz3+io12t4eRCjYMXl?=
 =?us-ascii?Q?sSpn+Yyxz8wo9Arch0gjS8wzjF/gl3xDQ3mj/JaB3tspx/WFHEiCARz/g7hp?=
 =?us-ascii?Q?u7rsM/1ExmZAexvA72g0yfKJIXv7V45XSKCRMLjDappWvCOayLvRWzkANmKL?=
 =?us-ascii?Q?dfNTTZBu5xgpoRRa+VAuK+Cl875St99pdt3UMBt5wm7UbpkUPcqtaBvVbkQ2?=
 =?us-ascii?Q?4XXtrYLFhFy0XVfKDkD1c4PvFiB4xXKnBIgq64a0kabe2AU+/TfivdFE9xs9?=
 =?us-ascii?Q?7rV/5jBqR5apmuO3rEM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6096495-19b7-4747-fcee-08dd50223c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 13:43:32.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gv82o9FsVVa3WRfr1+PLHmg1QjTf05KgfX67DkuFoZqA84IkX3PNq6hLIbxq9ak48876JYV3eebffv617nzqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819

Hi Laurentiu,

> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX
> DSP/OCRAM_A
>=20
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by
> setting it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT.
> Additionally, set the frequency of AUDIO_AXI_CLK_ROOT to 800MHz
> instead of the current 400MHz.

The patchset looks good to me, just one nit,=20
Should fixes tag be added for the patchset?

Regards,
Peng.

>=20
> Laurentiu Mihalcea (4):
>   dt-bindings: clock: imx8mp: add axi clock
>   clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
>   arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
>   arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
>=20
>  .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++---
> -
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi              |  7 ++++---
>  drivers/clk/imx/clk-imx8mp-audiomix.c                  |  6 +++---
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> --
> 2.34.1


