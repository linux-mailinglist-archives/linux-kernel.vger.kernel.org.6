Return-Path: <linux-kernel+bounces-403529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA7B9C36E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB281C216C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841F146A63;
	Mon, 11 Nov 2024 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQXhiVeh"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D213E022;
	Mon, 11 Nov 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294681; cv=fail; b=qqc/uSLgfh/82lx4Z96b2wFM56cmVTdCQdbCqVFgtE8+2fXwscgeU+aN2YNW745KfbfCzNupjJvus651FywzKbXeAuNc90PcRkZUP/2EA27noj02H6AIG6B976MJgkUi9E1H+JPl+8nsyGlsMXZk1Wn7dpDOOZbWEqcWasmT7A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294681; c=relaxed/simple;
	bh=isxBNy+rU9vkmNJ0bTvwSOvRf+SPpRlAAS0TSQDIH+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jtEevrXsREmENQhmIDOPROo4zvWkoneMKWs+ujkZBqw42xBh5DFQjvEQEANyDrySz1YGV06nH6VltyiWFGBio1hGQuii8nX6Qr2VtAdevKDGPaO+DgeoeWW/cs9hS1+leBkht6XI4s04ChPCdu9/ChjOwJqF3Vm3jGhUel7W3hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQXhiVeh; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyHflN9RmkwughLHTewRHe21iNyuFgHVYYSL4YHyKE6Xt5ETnHL2g1iXuQH7LsSXtD7D4+9TK21nPxx1PRupViHFnC1qwDfFKW4Cso9Iip7N61uMP5T13Wo/Cf1v5yU3D9DD/Ke5UEERLPqSHmoVr4YNV2Pv1q/xvCGVikXy9uiFt5TEZrK+zW+itGUqWmGg2wA7VlZVShuW8bbHulqT/pTs/xYIWgTabNRrlsXFdtBk3ZuHZw5g4nz9CIZ2+V3FsLrCDKyuP6/pHN0dhqfm0jC+UPcMXDZxiDnZ9snAGAOUdqjDRe6JXoySnsTmbMlx3Vmb1NWNLafPIxGVk/ibWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP1DQ0hKU+yPVslMQAyU0BFOmwcTsGKCfAiztPBsi9M=;
 b=WE4dMT8nXlhDq32NcLT/yr7gOER7Dn0nGHRhgzjpATwuk3DJO2HA2gkt5ycZ5+eJ/GgL/4stjYm90CijtIRX+//j+uluPYzUypJ0wfEjel/YebTjB39v0l4Vh47+hmV1TSk15rbsf5MHfA/FZ9fsuwV2Ck+oLEPHCM0qieRUkPmYos7XOXwIxs8sPtUOAMT5BDzlddwsxh6E5iTpgUtaH+uSd46PzbXWJzNzylBq+iBC3NuhBo+lIi2bHFfx1E2/ERupgFvsm1KdIb2knFsPWxppdQNyWkorgl4quqHvsYqR5kShL5OH65INcr3UFa9fVQxj3yX5cHkVWtgnWS/2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP1DQ0hKU+yPVslMQAyU0BFOmwcTsGKCfAiztPBsi9M=;
 b=eQXhiVehBlnDcUdG6MaPxSGeY8qvRfaHPa41WIqQwygii6BOoUWxZROUO/fKi3CpgOLd+ThWaMDDhLvm0UPJoT+rljDZTgfqSkGldM4gmWoNh6cGuWugTFNrfprBp8FLcvTOVn6QFPp8uTarzY3y58yEzPAXcrq7Z0SaNMmMSkCXhltk+KkoLkB5KCYLmuOsGs4wf1YbZFfS3vtmejaN5wnH5YU3y0qtp7i4RqeUXqXx+VNIkgXomMwR33HMRaSPBGPaMSjWOJ3dYPYbGNHbtP4QvIUpcFSM5edLTljxesvmA6Is0pTE4SFitggVWDVSS4ApjomeTv85PHp6hHeRrg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 03:11:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 03:11:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "shengjiu.wang@gmail.com"
	<shengjiu.wang@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as
 SPDIF IPG clock
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as
 SPDIF IPG clock
Thread-Index: AQHbMcTBaHNHhOnHoUuZrdGjWt+J9LKxarnA
Date: Mon, 11 Nov 2024 03:11:15 +0000
Message-ID:
 <PAXPR04MB84596DD01E6A066A621F590188582@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
 <20241108100759.682260-4-shengjiu.wang@nxp.com>
In-Reply-To: <20241108100759.682260-4-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7348:EE_
x-ms-office365-filtering-correlation-id: e2e6557d-a0f3-45df-33f8-08dd01fe8104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OljNcism5+/iAByV7NjLY1qU4t33HLtYKN+lEgSOhAtIJBpZ5LH+Qeritvn1?=
 =?us-ascii?Q?tfem8ntzc2bdFby+X/mE/75qZ59uELYYrF6aFZtiFDcDeMickWzM1nscT8xv?=
 =?us-ascii?Q?T/mbcCsw2OkCOtzvjeB5cPtrbBfWcPyZyLR8EPiLYEn0IWPTuAi9yQWE8L9H?=
 =?us-ascii?Q?ULQstgWaHclZybbAVpqlNQrGMCuQBp9IYiy492gILAsWnJAi/A7ASeVb8PP7?=
 =?us-ascii?Q?ME5i9q7AoYO6+OE0ED2/o2WFQBc+Kwge2K9VjfmKDKgq3rbk81vDV7Xx7N35?=
 =?us-ascii?Q?PLZYVCttG9eWK1N+OOvqfFmtsUzacflHosx3yQ//l+krPi3BlNEIqGeU9vnf?=
 =?us-ascii?Q?aTc0NgSf8YzxB4IHX8Tmiyyy/K2d71txFl5neOtSgGvhSJ6Zr8+oPY1B0y0W?=
 =?us-ascii?Q?ur+W1SBUsXWh5flnGtkzHdlip5itL7OvNLer8IhYIBmBJZuRPJ/uZr1DybUU?=
 =?us-ascii?Q?MbhNJ7W9R4qe0Ta1pTsgTG7iNtCC/rXEX+jRAK8MPsZILai2r9Kiv+tlv7Dg?=
 =?us-ascii?Q?WDDgJHqHW3M4h9Krl8jxcFVA2KVHoTO/wKLSOFiWnpZvMojt8scfIh8AvqSs?=
 =?us-ascii?Q?ye50sFD+7ygYT2KE4MgkApixlUJU03pqftkD9+FPBCOtj8geBuD9zZWLYGjg?=
 =?us-ascii?Q?+b6n6AfogBsMoIMJTQ+gF2bchU+A7PHGeTu8u+GFF/g2tnZtxWnm50tVfT4g?=
 =?us-ascii?Q?df/BovFAlvLK7obUugsFA42o++mDSZEyPAuO5RemebrbVIF1/eJpH0K3MYbR?=
 =?us-ascii?Q?A6G0rsOr2kTmsx6DAeFkqXoUtj7qdipC7nhBgY8BzE6qokc88aU+FmortZbi?=
 =?us-ascii?Q?IZLKE/sqtTtOh4RssFR6+8yyS/ZQ5ZOSgCwWzYP/oV1wkzETHLngjtCRFYt2?=
 =?us-ascii?Q?IENiRwZpyimGvfzRZRcxv2kYR4te6MtI2trpPFNOAe0xoizozCW4nFp8FnU7?=
 =?us-ascii?Q?JhJYh3ocAE8D+r2I2gQwrX08X5++yIGEIFbX8LAOFblvuR9gjZwqpsQ2byrx?=
 =?us-ascii?Q?XcKXzuMWjLV22iS/yc0CTbbFhsuf59epYMD/iBs61IJwPu0pp+7+Tl/gsEgF?=
 =?us-ascii?Q?oVHNGcHBQndyU0n6GlborZOTmmp4RRZsTFUsRBGdBoBCx8sGJZmnnsRsXGI/?=
 =?us-ascii?Q?dvnbKVtmnzaY8gtYnBkn4Gb4Ee0Ajkx8QPEk/8wutfz/D8i/PE+VljdvvxcE?=
 =?us-ascii?Q?+poJM9hYI6zc6cUcJ3sGA5Ga+2yGWmLP47VxgdwtSqI14/4SvdnLdRiID7jD?=
 =?us-ascii?Q?68bCp1CPf4zUlq1QC5prIx8gIChuexYsG2mVH/gOLY1GwE8JY0CuA9fT5H1/?=
 =?us-ascii?Q?RZ3focLBe3EJvo1lHmD6mqFBAeiQaksww0K7nQTK6HQ0wfSxzEiXducuWfX9?=
 =?us-ascii?Q?plkArRryyryoPtJzPSJ/S0AnfdOz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gTBNdv1H4fLZ5XvauRpWZj/vdwebzBXNbMHZYYAge1R59A2xjzb897Hv4UoD?=
 =?us-ascii?Q?eOiA+NTaSNEVAbAQiYZ3ofxgIcy7UZgsqZh1viK8gcJue3qJqSj2Bx2OpRei?=
 =?us-ascii?Q?zsqlVdo5dQ+gc/rhiGYr9fwlj6mV3PfUGjeFH+vXaAmj1Lbyn7XnV+upqSIS?=
 =?us-ascii?Q?c/K9WGqZfR2FaB8yAnB7eLeReKtd/RAyiXIgBXfKInngUIp11EHTnTb8IYEN?=
 =?us-ascii?Q?Uehgpj/IsGdXToGbpCWpURyueR70YGTPquu7S8gOCDzvSpuagqSmlvWoDBZV?=
 =?us-ascii?Q?InRiiNRhYYjWi2OgFiJr9d8Be7cRJWZxg1fpXDIvMUBaNuOA+rsHKgXk0H6E?=
 =?us-ascii?Q?wfNFQzBBOBR70LVA7Ar3pdr1B6gjFhYLB8XQhsU5+T/iK9f6082prK6mx4p1?=
 =?us-ascii?Q?7N5su6XkPPMQjT2r8U9JF9Zn8ulo9FAJ17UAxRdO5VE1QP9GV4vPEkzIMccU?=
 =?us-ascii?Q?PW0wCPzTWVxzWSc17Nh4NSm3EPUqWINr8pMaIx9ViOa/clFTqbpYjsRZqOVu?=
 =?us-ascii?Q?gm187D3OsmR3B17AsAaChNL1oeQ8py8UOGKBpwHdKCpXcZdsDaVv8pMlabX6?=
 =?us-ascii?Q?piZEjgXqZXP3o9W8JeU23Iy40FFUtaqQ9hr0uOk10AkPDIdSK+fhr3+J66vA?=
 =?us-ascii?Q?OIGZzquCByrhlnPUUiRhNpdUC5t0pq2svDQ0vHeiEMsOBgbm6KtYKlrqxKLl?=
 =?us-ascii?Q?PdSa6Y1vRVXcj4lv3Ib9UvIeLRgk7J9Pr32OQM3SIiLiE5vnWnuititbur9v?=
 =?us-ascii?Q?VUKOZyZOLB4NAz6HFaJLdOo90mJBQQxTuqd/N4Jx/otESg1giPBxZQQsv1xf?=
 =?us-ascii?Q?qfKvU612pG1Ru50Dw5upQ/FgumRXzHykCRUfmiTAmHpCuiyygQdDte2U9p+e?=
 =?us-ascii?Q?PFsAvOPhcouVL3NhuS7hJO2dMRkbUYNpy6r752SrQQ6lTzg7A8E62NfySGdx?=
 =?us-ascii?Q?uwB8OcMdbqKgvSO3wWC/Oe3CPjbjwjNYEqIfVr62yPIo8BavWOSvm1+7bzx2?=
 =?us-ascii?Q?Ck1B/mPQczs0kYd6QbuuH/vGBJaYMmUE8sg6ug7OToFR3rcABKhq6slfkcmk?=
 =?us-ascii?Q?rgVr5qxqjHIHsaozgf405sn7VdcNLJ+fh7igiuOZ3R1neuH0sgAzhjFK4RnV?=
 =?us-ascii?Q?VFnATTE0dccvRAuldRQyBbq9Bx3wFffxKCWpWYDIzHxUxHXLx2R3MT7nq0ny?=
 =?us-ascii?Q?pAJhFNrkLTYf9fAzdXD9vPUYjIShKAKus32hV4gCZSXj7QaPLySx5I5fV+dm?=
 =?us-ascii?Q?sIbAlurNYSdz0BPrcM1xmla6FgFJvIMbuMJqA4snvhMmF09soO44jOaMqFBj?=
 =?us-ascii?Q?KVr6ZntmcGRy+FJ0CpC2toqvg93ci8pCA4Ie9e+tIUh61ArvThwlw4EJzsQV?=
 =?us-ascii?Q?x/277Spk/lOPIjH8iShjCnDfIikw0TnM3WEi6wQN6U040Vewje5KzBirxsJm?=
 =?us-ascii?Q?4F72qaOL4A+2tQSM46AL1Fmmpn0O9q4+4P8zzNJAhA/WjhB0a1b13Jb8XcXL?=
 =?us-ascii?Q?4dpk9ynBWZAPbBV03++DVzjjgrGxr0YW+LVRMsQQqGVbC5AsdMF27gtkMqa4?=
 =?us-ascii?Q?itVHcmJHKamX6VNy6qo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e6557d-a0f3-45df-33f8-08dd01fe8104
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 03:11:15.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H7/WPojoPtxuTb/cvBiCe0Qk90TiHveB2yhgs/YSYQH15Gv/htoNB/a3L2sJ+t6mS3gmkC3rD/NdCM8ZEPOEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348

> Subject: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG
> as SPDIF IPG clock
>=20

This patch has a fix tag, but the other two not have. So the other two
will not be backported and cause issue.

So use fixes for all or drop fixes for all.

Regards,
Peng.

> IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which missed the
> clock gate part.
>=20
> IMX93_CLK_SPDIF_IPG is the correct clock.
>=20
> Fixes: 1c4a4f7362fd ("arm64: dts: imx93: Add audio device nodes")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 688488de8cd2..56766fdb0b1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
>  				reg-names =3D "ram", "regs", "rxfifo",
> "txfifo";
>  				interrupts =3D <GIC_SPI 203
> IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 204
> IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk
> IMX93_CLK_BUS_WAKEUP>,
> +				clocks =3D <&clk
> IMX93_CLK_SPDIF_IPG>,
>  					 <&clk
> IMX93_CLK_SPDIF_GATE>,
>  					 <&clk IMX93_CLK_DUMMY>,
>  					 <&clk
> IMX93_CLK_AUD_XCVR_GATE>;
> --
> 2.34.1


