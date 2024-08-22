Return-Path: <linux-kernel+bounces-296646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20095AD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A41C218E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13C1304B0;
	Thu, 22 Aug 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYSak7Iu"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C71D12E6;
	Thu, 22 Aug 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306719; cv=fail; b=oiCwYTcaTogtbi6GOw/5jdNMmNh9oGySmGTz0ktWLdA1xyO39yC1W3mkUlMp8X7+WsbJO1iaeLmA5HZzydiuAJhl/wqFI2sssiFcB1AkEPIujg229gfTG4CYrk/M/C3fhnPjBAP0wpSZK1vPrN5gUYJ0RECErlkxOmxe2UwuJzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306719; c=relaxed/simple;
	bh=9hhsr3Z2+5AEOlsIZIXma9PAX5sSuNlh9ZqXXu+lwDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZZha1OS4BdaEeYAI5YxBHjbYJjgTsGLLF0VQ/m+Q4zWHe6NegY8qneDJl5TOr7wj7Xl/Ah+mVTDnTHZD0st1E5iUgYV08Xi0fs25ZJ0z6wPtItEuPNS42moJPhKMDtRSiJJHTo3y2dDJfpCez8aTcaspw1DWivxdexjXS30EDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYSak7Iu; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfSsgCeikVe/oYG7q6liNv3RvJPNllCx9m2cMS04h+5TBebb5M+Zc8/5y+jOD+l1vMaNAOQHIeHF6FfCVINs3CAqi3nd8uE6i1LLCo2tPVcNc0WB8OnYCEQN6M4OCokPzSNCofLeofka6n20rCyhZIbPpqgtYLraRJLeYdGs9/vPjMrfi/bR5tvqSOJtjxCRSOHeFEjkmNBU7YGI6pYOCC4OmRmZ29IJ0k1Ds4se0jrJewz3cnFY1l7jks+tOMB/a+gbTz5iPnlBxSGGhLgQoQJgtoctVELqpha537q5vXnskDiWco6Su4fdRKyGAEyFmYyq3Vqj3C2oLOCnJXBlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfU0qYDtX1+KoiD6W3O016h25wLMul71RVQD6aLXcFo=;
 b=OaUkPlQiEnkbK3cisNqW616AAIPgrHX/r8ZYdLy9RvkhrJ7Y08YPGClyhGyjPYHyZ4QR4hkaQZmxfLmfDxasUC6aR7jVh9FfaL05U2xSLmRwtQ3/SAsfbxvxyO5QDANLi9ZbdPb88xyGOekHJ0AhFGWBUEN2lkRj28DsFtYPQj/ishMqVZBAd8/tLvcXxSw7UKfNshPbGljYzXRwJsXBobX+QtEx6KAAAKElu858buBUnJa5PMg/Un5W/DAhd7MytEUHqHozDajmSpMZbMwEPopn2/4qYZdQrpOUhGnospOBNBe/+/QaWQYzI0CFYZsVuux1INoc+bSz2nWFGROnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfU0qYDtX1+KoiD6W3O016h25wLMul71RVQD6aLXcFo=;
 b=hYSak7IuR1VIaaYWqxMlQVnIKQoIwX4SjFihm/Bhac6jV/GmMbsuHk0x4aix5cDpip2SOo69hjhBgNAlwq433kk1MUusU7XIk4cY3478nzJ31m7R6eba+WuzxygrRXlI6Rt/MqnTcRYlSMyzDdM16THo3i/YUYv3kqBEvWmUUStSsBnUxHgf2+ivNNSvylWxpnkjTDOa0ZFAuG2P1NplhNJnER+V6BF13cMpufAjZoXowrBR9lNF57zUfJEuMfWAHwHL8oIJdvPywUtcjQZxpqamnjBVUP+344tYCTqCJKWLP3OAWtW6FKzMwTa48a4cflRE320P+8Zs0ceUv7b5AA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10591.eurprd04.prod.outlook.com (2603:10a6:800:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:05:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:05:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "d-gole@ti.com" <d-gole@ti.com>
Subject: RE: [PATCH V3] clk: scmi: add is_prepared hook
Thread-Topic: [PATCH V3] clk: scmi: add is_prepared hook
Thread-Index: AQHa6A+OsVR2XlT/3kKcL3t9SECDi7Iy4mAw
Date: Thu, 22 Aug 2024 06:05:14 +0000
Message-ID:
 <PAXPR04MB8459C0CD8A4A74F20DDCB0E0888F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240806145601.1184337-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240806145601.1184337-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10591:EE_
x-ms-office365-filtering-correlation-id: f4e81784-f233-44fa-dee9-08dcc2706395
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4jUDFxaJ6d78E5PtQdX6dP5zld9+TsU9xOQrVM1J7tmZg+Ft1b02fNr8Z2e5?=
 =?us-ascii?Q?Ri4nap1LDfuT51cJLEYnHnAsEP1eoS3bOss71vGRWesUUFOB/8LreexQrRKo?=
 =?us-ascii?Q?GXCQTnWht20rNv8gEkX6i7TmjlKn32Z/QPEcUpuFTvkRiP2vxghdCImc4btk?=
 =?us-ascii?Q?Ei1YOlSfMXMv6eH7sH7bdMABQAeS+197GaPhL6XDY7NgSJV0j/aYQDmwlAb1?=
 =?us-ascii?Q?IAOnVCllXl9v8dPeXfZb7nT3NDV8ZsA1X3LyppT/Lk3sGCUcndSDpKi4w8PR?=
 =?us-ascii?Q?IixMKAuiYwoxZ//NON7wTo6nYY8NLo4ySoUo2Cy59qsm+JmoYTGe2TMBl/Iz?=
 =?us-ascii?Q?6oAY5APXq5lJCskE0VEfldJFOAhVbmJFTcMsPZ/FdTp6ne2Y8lZuvUPejcEb?=
 =?us-ascii?Q?OCRJwSzHCoKDTMeYkPe85rRgzKKvzPeO1mUVaG1MsERM/82wY/mCKd9FHVbe?=
 =?us-ascii?Q?eNT7wAIDAP4o8oj/Ku2/lcVa9Dwz7N9gfsc1fi2R0RCXXP1nn90LUGPU+kgS?=
 =?us-ascii?Q?vtADpZwVQrf6H0cNxe+qIyYH0IspyouG5Xo8bjU2d8xLVXW45+e9lbvcwFOs?=
 =?us-ascii?Q?uILys7yrh8Psf2AX/vJv9OlkVQ89WT6mWeOSWBdHPUeDxcVzSy9hKL2lWxi2?=
 =?us-ascii?Q?/fn6mN3g5Vy/7gSR5gjfVavgGDBDqo3+2B2F5RddF1LN+Woe9sFP5BHi5wDn?=
 =?us-ascii?Q?M071KXci2nOLKIVtenaXOSICXEVYCoAl9+3WdshEAhoXG9xBcK/iseUAt19a?=
 =?us-ascii?Q?f95Nqf5o3Ep98MFNGhvFa8thLJCyJT6aAahrQ83QoB5kxGtZCbAT13jeg7YO?=
 =?us-ascii?Q?3whJEr/cVI45JV3H07nUWwu9ZfIys/tGiZhEzwjVGwYRMvU4M+cXUiih9fQw?=
 =?us-ascii?Q?xxGoihoPzBXl+J30+iTHQY1ogkL301b/iTUTC6Ng+rnUU+JofEx0lM8/EM53?=
 =?us-ascii?Q?OXWReIqc8YcIzHYqpr0IBONrwZ+9PT/xjegpxLeG3N1u7oYW+JVS1cbidcMD?=
 =?us-ascii?Q?QWJHVhR7cwDSU76f2/HfZgiqaUZ5lcC1Y3vp+h6w5N8aDflNEq0mDn54nJkC?=
 =?us-ascii?Q?x7Kv0l9ttSC+F7HqIVoX3v61tTAtc0glsma8ny6t8DOSR7P+kViC9n4vo44l?=
 =?us-ascii?Q?zSbRNY04LhdH+gWyNK72YpLMvCFT5gGJpnLpxwwz5tx9fKjU0D8ZSw5UxLEc?=
 =?us-ascii?Q?gg9ICVlMTx7D0qDwBKvwzb4i5X+gOK3rvlLmEcqx81nlBo3BAmtewxdgDvBl?=
 =?us-ascii?Q?oUfmm+Us0v9tRrTPBwZIvjFMGtGJNk54XJy+d6zBRZRpyQABtzyEcTIWhHMV?=
 =?us-ascii?Q?jpV9HQmo128uCmvmZoL4Gpe7ZwXxKmwzoPPpR/CzUqFKJkhWVaFBGx5pftp2?=
 =?us-ascii?Q?t1Qbpdk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DWtYUOFuDNqi9L4/Na5Kp5+arARlJhlpCc4toDqk7jYloqTEr6ih5J8RKvRg?=
 =?us-ascii?Q?yC5rdE4wU7NirBVUTqBCOdyK6MYDmAMGe/8IuAIBOaln/wNgmdx6CZCkE2Zx?=
 =?us-ascii?Q?8JHpV3j8m31Lmvgcg5r2K4cfdLGWuS7WZmD1nzcvXsJRamiFRFv84P1XnGB/?=
 =?us-ascii?Q?p2NHEShsmTy5czdVaOcxAd3aN81t8hUF3hkbD4HlVgoWFb9YctV3TPAPtXWe?=
 =?us-ascii?Q?jWN5MWe2cL8S1ng0v4ID9/iyz4Ah8EP+YriFHHIm9Sus2ssIGeN2dfJ3yFYp?=
 =?us-ascii?Q?dI+3/Kh3lBF4mrGQXqmzNuouEQptzrHzS5gkLcROjwT1ZkOmfO088bHRVUqu?=
 =?us-ascii?Q?hGOiHmvmzdlK1fKuqom9WXGkCBrJ5+3RR42SdGRJkiAcfmQ5VLBV8BxyyyrB?=
 =?us-ascii?Q?gx7GETyiOxbvqZZ3pz6RYOx7m3t2bLa6CQdT/tIp0pKivK/5+WtiCW3ZxBaf?=
 =?us-ascii?Q?K1Em8BmOZG1iPYLDJPG1LGg1NtVYj8uRWWzA2PptL/8rg0drCSNPnEv3P5xe?=
 =?us-ascii?Q?fB51bPb1aLsNeTpWQisCchhVyLIsv91dkfoUPvnTO3H8dFZMiC7611EPNNgc?=
 =?us-ascii?Q?MBPfdFr0J5am7OJIQfp7PV60W4NNO2fm2Fy3VAaH7I/uOf+Ishwbo2Uus2bk?=
 =?us-ascii?Q?MoDyEzgYmUpCeE6apB8MC4078otTBebo+wagH3vYejhWPc9j0l8eHfgMvmND?=
 =?us-ascii?Q?uwzpBCxvBjkNWfaeKNoN0pI6i2dr4GUaOkjQlX95lZuglgtV3YzouxZzhbN+?=
 =?us-ascii?Q?dY1RZON/Wjlu8Gsx8w/5C8R77WhUmh1cQtLUjep3DGk7h/LCmKOf7NFSmhRP?=
 =?us-ascii?Q?dpoTB8YNdxiNttmBxxRt3UsIx+vT/Ixx+4dYeXzdNyYwesTswynz02OyKbyT?=
 =?us-ascii?Q?1oACOeO+KUX8/y5q/bY6F2bdKQiuGxDOSPmvscntCOTwBLZXE7jcu9I2capG?=
 =?us-ascii?Q?Nwhicn68BHxgDhUKCvaPgCZHolX0XL6B9pnTITHmmO+CRwAG8CPiSKmewz+d?=
 =?us-ascii?Q?5bo7H8SvONT9j3mQFvU7vQarYUfPwDKiyUSyxVNXJtFgNEQmoNsYd7hrY+Xi?=
 =?us-ascii?Q?io/wx1Rb5RiP72Z0aNOnrUusGwcHK+L3cdU3T6L582bmEN9eHWNSUTmdY4+a?=
 =?us-ascii?Q?+pHr79Zwe3ruTTOF2JXODJnC4ZH6kDfl44P6vlnv6fYz6nZh2orXR0EaYR33?=
 =?us-ascii?Q?Me6jfyn4IM7qOtaAPiYgTS3TQdmwlgQiRRPzdO/XiwuLdemu/Vi/fDRFS9LB?=
 =?us-ascii?Q?4khygPKotMUjnDuT4o/jSwOimz+JYWMKb6/X8m+O1qRljCs8B8dFNZ6DKPj5?=
 =?us-ascii?Q?0CxHpsHYVds1wIiFByLOROaUfViXUdXxQemVe1g7+WpbXW5EEeWhfveI3d+X?=
 =?us-ascii?Q?xC/QQj2Dj1Ha7YgZcjfLFmPYzVpQg2FDN3axDsRXpk4qihVpB1j81cUTOVKc?=
 =?us-ascii?Q?HcGx31H+V8ko1O43QpuniMLDTtwnRy6V2f4wSMc3FLhlr8Gs/u+Yt+Y/pVOR?=
 =?us-ascii?Q?VSOsMhyW3cxc8dgCXE6tgkK281LZqLarHw0l3j24vcyicX972UdmUbckKBAX?=
 =?us-ascii?Q?kbX7ZC0a7QcWds0C5iI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e81784-f233-44fa-dee9-08dcc2706395
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 06:05:14.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojgqb1X1NkJv9kPZ8wC9nvAcTUuC2Ti/zBHCi9IrIHWVnXW02DHsDsEMmOKja25ldZUTYGfH//Dx7vHudjTXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10591

Hi Stephen, Sudeep

> Subject: [PATCH V3] clk: scmi: add is_prepared hook

Not sure this patch belongs to clk tree or scmi tree. But please give a loo=
k
when you have time.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Some clocks maybe default enabled by hardware. For clocks that don't
> have users, that will be left in hardware default state, because prepare
> count and enable count is zero,if there is no is_prepared hook to get
> the hardware state. So add is_prepared hook to detect the hardware
> state. Then when disabling the unused clocks, they can be simply
> turned OFF to save power during kernel boot.
>=20
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V3:
>  Update the commit log. See discussion:
>=20
> https://lore.kernel.org/all/20240802061234.njlviydzmjbsyteb@lcpd91
> 1/
> V2:
>  Provider helper __scmi_clk_is_enabled for atomic and non-atomic
> usage  Move is_prepared hook out of
> SCMI_CLK_STATE_CTRL_SUPPORTED
> https://lore.kernel.org/all/20240802061234.njlviydzmjbsyteb@lcpd91
> 1/
>=20
>  drivers/clk/clk-scmi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> d86a02563f6c..15510c2ff21c 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -156,13 +156,13 @@ static void scmi_clk_atomic_disable(struct
> clk_hw *hw)
>  	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);  }
>=20
> -static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
> +static int __scmi_clk_is_enabled(struct clk_hw *hw, bool atomic)
>  {
>  	int ret;
>  	bool enabled =3D false;
>  	struct scmi_clk *clk =3D to_scmi_clk(hw);
>=20
> -	ret =3D scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled,
> ATOMIC);
> +	ret =3D scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled,
> +atomic);
>  	if (ret)
>  		dev_warn(clk->dev,
>  			 "Failed to get state for clock ID %d\n", clk-
> >id); @@ -170,6 +170,16 @@ static int
> scmi_clk_atomic_is_enabled(struct clk_hw *hw)
>  	return !!enabled;
>  }
>=20
> +static int scmi_clk_atomic_is_enabled(struct clk_hw *hw) {
> +	return __scmi_clk_is_enabled(hw, ATOMIC); }
> +
> +static int scmi_clk_is_enabled(struct clk_hw *hw) {
> +	return __scmi_clk_is_enabled(hw, NOT_ATOMIC); }
> +
>  static int scmi_clk_get_duty_cycle(struct clk_hw *hw, struct clk_duty
> *duty)  {
>  	int ret;
> @@ -285,6 +295,8 @@ scmi_clk_ops_alloc(struct device *dev,
> unsigned long feats_key)
>=20
>  	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
>  		ops->is_enabled =3D scmi_clk_atomic_is_enabled;
> +	else
> +		ops->is_prepared =3D scmi_clk_is_enabled;
>=20
>  	/* Rate ops */
>  	ops->recalc_rate =3D scmi_clk_recalc_rate;
> --
> 2.37.1


