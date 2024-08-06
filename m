Return-Path: <linux-kernel+bounces-276461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B9949418
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A871F2295A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5871EA0BD;
	Tue,  6 Aug 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IrdDexku"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D61D6DDB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956609; cv=fail; b=aLW/DuKicSstqrHwzf9djiceFXLx9/E63PsZWTUS6sTIpXa/RQ+ZUKej7FTQLq3PqBavCBUPkiM+QGxYuCqL/3ZfgKJdybmpO2QrgoskdJDQ4ARsX8a3TJ9sObzCoMwfOIzDsCSerjyyyxRtvfGBjaJh4lB4rf/lJDvvaA4lphs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956609; c=relaxed/simple;
	bh=78zNBtFJAu9fvBFQoZZu6zUI42/3CCG6DhVHv3j0trQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Am776NZgD0AFAc5/EyhwRMpJhsAD5zSwpwaoOFf17ogOi+zzp9kwMGsox/8x/43/bm5ZXmRvs9XAMiKiFn1fyVHW+MtgP8eYs4cMVa+cdMzL1t+98LuH4KdzSWzwkk+COBTSrrWpUhzQfR5znMoHC4llJri8sbxGSHincHjm/Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IrdDexku; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbHznyhGh5enjpWZj+SO/0y1VnT3fHzdT73VsarN9EPGJAB8VL+wgnaaROeBfX7J9QFn1wIMdFxXXrIwAeDfY56ZsMQYUvgalOeRSfNbtzuVJreTRtNKEOJ5NbqMe0xDnim5RA6YfUxbKj4l0vDPrw3HrFjrpwOhkMn1FWWWlt49IwryDozdOeATZ7w2FDCZpnO7q2vTVTVQ7I+SIS3GWihj4AufZ2SgDh+xi13JkqeCTS1nVC1DBmXMT5r5v9M+7ipGF7wI96KyTcXYhE0zG65lRg34hxisb3YC2dz37IMtijwICvg4ZFqnhpXfalpgZCQQWMJE64OO8n9Ih7zZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRR1WibPqgrUD1d/iGI6z2eWTpvdUJqL8dI6N1HwkEI=;
 b=BCXBPr8jqmuO0zDoEoN1N7LseUbFd0YAPY8qE7Q5zNN54iNcw+gSFQHqlPqZVM88EyxXF5u78+Yy6YXW9vQr+TebXwY0bhXtC1auc8A6OxGyZ/u0rN8KyyKoKcyJIL4oYvUsFDrsXbjuTEKsXJ4olE/GEY1177q6+omG+TpYWDl4fieuluS4q1Qtm4jXyygf2vSRMbFqCXEs1Nx7vOtKvXnwF8UxRw5CNuJOlSVSHUreXBLawUcZSiO2LqvH17OClkBcKOMRXEuYDIwccO3nbnlJUA3Qmd6gCJisnKcmoLH51EtiwE7nQzr3u6LErOFy+ARM0YtQW5wobP+/ICXUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRR1WibPqgrUD1d/iGI6z2eWTpvdUJqL8dI6N1HwkEI=;
 b=IrdDexkujcw2VlHSp4RlksduOwQco5DDulJQbTcUxFvS9oSkiau6DNbWMZG4MeyIVTn4w2qU+ewEcDR8eqyovdzUZ6hlepw4jiTSEbyd75rMesAH57Q+Z1IfnEXPyw40+7+mZ5UKjDJtWEMRw75FdVn6IVsTAi6KLDByQkPphUVxQ8bfhnilaJU52lIz1ERTMT9uYihu7VFWV/JsEcqaQn5c8B8jMY7nA7I6EA9pMi7c+TKRPZAkqunRFRMZ87y2NDC1cB13kq8qHP4nNN6EKHy5u9wd2x1Yn/sgzQI6WCpY0UJPV31ATvOtvr/buTQkRbArMLg6X5NFN2LE7bA9iw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10273.eurprd04.prod.outlook.com (2603:10a6:150:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 15:03:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Tue, 6 Aug 2024
 15:03:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Thread-Topic: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Thread-Index: AQHa1rJig9jveBmI/0OpTC5JEanfT7IadeyQ
Date: Tue, 6 Aug 2024 15:03:22 +0000
Message-ID:
 <PAXPR04MB8459D8581DD1827D28546C4A88BF2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10273:EE_
x-ms-office365-filtering-correlation-id: 6e7d9d8c-6459-4e54-f77d-08dcb628ea61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w6qcRJn54gZ87OgfYVBQHmF2xVaOlPYj2JLFDL5PsDKCjKdHEENBuNUeC6Wr?=
 =?us-ascii?Q?Xuw1HZW6VbCQgcro0NfcRsLfsIuTU9SH5kyu4HKvqWmyAWZ69K8U2Ty4/eiL?=
 =?us-ascii?Q?eh5YsNXkRAnbD6Pown8Trfic458U6wHLXGTMtgsEAfogHW+esTaGdd9Nnu1y?=
 =?us-ascii?Q?NkpPgI0VFkbyEFIMmv+7W4VjmmTUA0CCQaW8aku4hXfRRkOVFtXbNaXHofmJ?=
 =?us-ascii?Q?V8EgXNqOJB8eUbN71/k7IQGEtJ5v3NhRnME1Ar1N3Dsf7jKL/7k3mlPvVp4g?=
 =?us-ascii?Q?+LH2YohCt3RULaCSkiZ/cAPcjc/BXz+Rhk3vTp6LPkbq2ztaeDPCyaZF3EBG?=
 =?us-ascii?Q?ZBKV5bp6A/oYL03VOhuPwBsRDJKDQvxCBga0S2hAngIzDL8YNLZPvjD1iBUf?=
 =?us-ascii?Q?BeP69nLR/UV0pFoWmzI5iEIvv09X9eAsncapbLXuHL7tOfHxa0O0/4Yc3ynG?=
 =?us-ascii?Q?IjwEowmtdb92XG/JJW2yWlSaMKCHgcpbpIbZblUheoJwNN1Rn3BQYP/L6CgX?=
 =?us-ascii?Q?hPUw6Gj1PFStLGvfZpqJtURIJv7Nmu6tEQvmTGeYvy6h6kPBu4AguZwXfeId?=
 =?us-ascii?Q?4G77+S8/x7ynLwlX41YgZeBKSa1kB9FbfpJybElzetlCcrajdeIcSXyYelJq?=
 =?us-ascii?Q?rPV4EEIyiyo5a4a/QrYf2mNPsxeXMN0FCJNnQKw5Ht3Btti5vOoBy9mmzZnh?=
 =?us-ascii?Q?kV+jVES4LqwWYl05o4cfEoJxv/ILmwj0u0j/j1g8GNEg9bMm7pLwwzH1BwSI?=
 =?us-ascii?Q?/1eiWlj8FcWy4JQR4NZzkgLW4hOU6AzqdpVmF4lZInvFPayR/8sCEJ7qZUca?=
 =?us-ascii?Q?AwsjDdZM9es5slcOFn2og/Ap68cicI8XKz5Dpj6bU93eVKyKE+q5NUrjYzxO?=
 =?us-ascii?Q?zfKazyVfuPyYIZxYYvIfayQurA5VMRAjAYM8J2WTO4SD4HfrtAkYLFqZDSu9?=
 =?us-ascii?Q?EV3/MCIksGv3Y6TYr1XDnEeJMZPWXFCcbREV3P7RPt7rgEHYJ0TXNWmT5/Oy?=
 =?us-ascii?Q?EKJNM14an3R6bF4hjRv5XeKghtvblp3yXa1vzAHgECrshpWms1PkKdiZSHDR?=
 =?us-ascii?Q?75MSkE4WTrYH46n51vxgTQbtjeyvntZ+nrreTk5m0KoTc+g0LU5lMjtQIeGW?=
 =?us-ascii?Q?0WyiXpclEK0ZZau97Z/32SWuuKOSbMa3EqfAVsh+LyiiaLzklX0Q3o/Q+NKA?=
 =?us-ascii?Q?nEPYSGaohPqevMP/tMaWZ70ZTLWJxzWvUMcEfCQPZYEjvYx1hdkiiGKn0Agi?=
 =?us-ascii?Q?U8Vw8JZfbtJ5ufsy7ZuTOhGeZtJJaRSSYCN8kcV8pl6fuf+1CKhUjJ0Yqx5I?=
 =?us-ascii?Q?3epg6U8iBF8y3voMPL0C00O/xpAwAVEmxcXrIVmB3Q+lLP9H8OWehEG+U0Vf?=
 =?us-ascii?Q?P9MfGseKcdU3/GayW2TN+8wF2wDsg56suuDtkLZnKOnad6MIJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jtYaPA5JT+YTpeG4Pcu0KzFVfNBaW1QMR1/zQjSTo4r6AyPfNJJM5UoukAG0?=
 =?us-ascii?Q?0UbmUANKe0JgIMTWWJq2U7R8Lkmvv6t4jH4wTFZCCV3oqAR3NWzaxB3WKBgU?=
 =?us-ascii?Q?p6Cpv0cLHeloYrNcqodYlf+NYpFO1BNbTZpb15ll9/EgGm82vM29wVyiJFSr?=
 =?us-ascii?Q?lSFmC48CwVnNA+VrDmThabDdpbjU9adnxc1txTs4WBr0zSOoj0kw4ctZF2Ly?=
 =?us-ascii?Q?R3Wzy7B7ObQ0s5d8BoI2jsZlzc22ym9Scku0d6Hr4XIYReXOrq8tT94P6/ZD?=
 =?us-ascii?Q?uyFyIWT9JeBPGLlNQESb7YHyelzyQDgN0/O1mHX6qBO4nu+ZDhboTbvIn3Ck?=
 =?us-ascii?Q?/x7IMaMVk9dKVcgcMoRC7Js+TqvpiNI+6Tn/Bno33PGJhEP6wvSFN8ELRg1d?=
 =?us-ascii?Q?0khqTr6fv+o9/Hnw2D2yyfmK73r63Uh5t3QQdTgFKToEroUeiITurfmpuZEw?=
 =?us-ascii?Q?5QcYCkJ8oQ4V/W1/ucOtLNWLtHQNTE39c0W7gZKkgVZBur5fQFb+SNAOOnQ5?=
 =?us-ascii?Q?+0pV7FPjJEeF8EOeAdc/x8ohBws8UQD0h2VfKTNe+DCeV8mvXPoEyaJa0OZ/?=
 =?us-ascii?Q?qMtPKpSqpfW8d3Tm7KzQvInt1T2Lz2u+q2WpnmOIEflSYPLyWohJtHJbIkUY?=
 =?us-ascii?Q?KAADB5XFCt1ja9Km2fSWi0XnELlmuaafPNU2F7HGiaFsDEt2LzDTfMj2khKd?=
 =?us-ascii?Q?wTp0nO3BaDUNmMODKgksKGC7Xc08DRIj+8oKjNQ+SUHHL3bKHQBM+31K9zuC?=
 =?us-ascii?Q?Af/gmcqsfayjRvrv0iuz0rqLsG3xhtuiIgut63tPJLkT9bmS+WXSoKiVa0+p?=
 =?us-ascii?Q?6xvJyzhwsi6VGp0/Kz7YlNdDVgZsFycfUddoWj9U2HBx+nM50Ut9JdAaL0OZ?=
 =?us-ascii?Q?AWhcv82ZYZa4AZ1qEPd/EgQt/u8XlaJrGcsUsmbogpmnDZC8glf93dArYaZJ?=
 =?us-ascii?Q?lnpFoQMivfoeXzk/yJhM9sM/DY5sL2Va55bl/tAugKvusF65vHpLsntGAoNe?=
 =?us-ascii?Q?eB8miCZOjmf1w15cb4pmkMIErS2mDPjGx4Z9Kp/oFGu9/zT3ncljA6TvEp04?=
 =?us-ascii?Q?We4WAHQ1tslgmdviUjm+v6+CGNae3nMEBn7BBTLBGeq0tbBXiEI7x8VEheWo?=
 =?us-ascii?Q?bTHN6GP+o9AyL8AnOXAJiE94Lc12thb5l+dl4pCLh9GR5xq6B3+zS6fe5/6s?=
 =?us-ascii?Q?5nFK1I3jSzIDudxJ4qrEFS4R8H0vMmTAla9BPdjcOsW7gH7R6URUJUa33Mdf?=
 =?us-ascii?Q?Do0+LQ01KdPF6jJ6ctatSpUKl3E3joIZNbcYWnDsQ4Zz3qh9yECof7gkfd8z?=
 =?us-ascii?Q?8de4j0zDKREJiekKgleQ/+tZyewBwarGV67etgBsZO+pyQHgGlsvKg7jDlD5?=
 =?us-ascii?Q?C9DtgMK12Wc481vfyix+FytHyeiKDeysI8gPCCZt7CDyKOGrLTL/iF4vSeRt?=
 =?us-ascii?Q?gMLb5KyUYtMHrBboHfvj+HS62PSsNFmeBcMPgukkRQwVEBLgOZwQ8bxPgA02?=
 =?us-ascii?Q?TGPRee0sgxvfIAQKPxSLhBQJWxsNdJo7I2b7UCqNfx4T9SL6sxTrxx+R/vD3?=
 =?us-ascii?Q?pdSo3SqF9D64saEA3Jc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7d9d8c-6459-4e54-f77d-08dcb628ea61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 15:03:22.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HQEdLpKV/r332zYP01LzOLcL5735gsyidB5UVfopmlHYrLpprgC0j6+Cuq+3Y/3qof+IwUWpoiXvLUI6PFTfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10273

Hi Shawn,

> Subject: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver

Is this patch good to you?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Enable i.MX SCMI Pinctrl driver which is for i.MX95 IOMUXC settings
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig
> b/arch/arm64/configs/defconfig index 7d32fca64996..764d9b6ade3f
> 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -581,6 +581,7 @@ CONFIG_PINCTRL_SINGLE=3Dy
> CONFIG_PINCTRL_OWL=3Dy  CONFIG_PINCTRL_S700=3Dy
> CONFIG_PINCTRL_S900=3Dy
> +CONFIG_PINCTRL_IMX_SCMI=3Dy
>  CONFIG_PINCTRL_IMX8MM=3Dy
>  CONFIG_PINCTRL_IMX8MN=3Dy
>  CONFIG_PINCTRL_IMX8MP=3Dy
> --
> 2.37.1


