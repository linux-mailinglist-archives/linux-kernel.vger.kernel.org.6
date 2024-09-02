Return-Path: <linux-kernel+bounces-311050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CEC968454
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEB71F217D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1F145A0B;
	Mon,  2 Sep 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNrhX1s9"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0413C820;
	Mon,  2 Sep 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272016; cv=fail; b=oSrGAiKuuAgb94yvTqqV0rPHfxKn5jzQQaXrZF54lXBlQNFKpjnnXlvsEpnYiPd3gPPekKPmW2300B7aeUMJapQfIILKH/vcekDV5FsLxKkmHJRl8kt7V85lUbnoCSxlIkoRbnsSyrWShKpUQr+yWAwRrKRX4ahYu0evUhW2www=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272016; c=relaxed/simple;
	bh=FJIp3/jkLWu5wlQ5s5LKqmv5wk+bm4psAX1pLqtCuO8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fHdtJTOM51/PtPrfdz/ADAbcc5tYtz5SiE6j0lvrIwT71LIeURaOggQiwmXELeC5W8zzQkbqQXM3+OiDP0pxpElqjdcB6k4d/x4T5ZONdzINf7QwLeWVm/4URgBASk+M+WnTXYhCekQin7SyGhixvGVkUeOvg2KTvjUIuZSutvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PNrhX1s9; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW7XnHQjsXtWvSUVhJseG2NL1iv0V3JJhNYoeoU8EPG6MJO9+zxFxFrf8GGaoKl7RaEf1PXAciLGmMVAMEZY0qNC86IJetLsmKBGKGniKEgDqqP4/hOul2eSGSQx1f8Kx0/OTDlidZwgfckXlpIANLc5B9LD3PxFUQRdfGNsDn+NN5J7F5AIZjkxxFJnlb4xn/wDzmpYemZG+CE0aVy9X8qliwyfqGKrueVFJhTh9gpvX80kNu9HkkfADmbXfdL8p45ODqB37O/TTrEaLe/VdxTQ6L3/ixVxSOAT/otcjvU3EOyOOfceBhmGg5l741hzFsXdRceL691bHllT9lZ/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9YDOZ9678ruWDMmfOhVfKO9XqTxkUl7vWa4WEAbUP0=;
 b=idrc8LGAZ1Z4NWTKn/AU76OlQ6pdO79NDc9EhPyZ+FmZhOjhHjMkMfX42JKwr6wdsVITYH3y/raH4jSamPUYhsIIuB14pAjPdOAIOIZ5F5nC8kIZJWPSr/CfNFIqQA2D+HsfPpqcMUIyCsA+n6tVNKawl2WNcQD2v5hCviqTr1s4GisDEGKQFBltk1sl/T+fGdEo46P/nefFnbhELns0bBXHFyekiApJGAfQRlcTHP5g2IG8N9/W2wjN0sKHnxaGVrZkC7mrTSLg+iyGAvuOpcWeQKdOH76Elo5XIYGP0mfF43drzstcrd208N9W2ZXxYMX1TOQOgCjhFbosqCiWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9YDOZ9678ruWDMmfOhVfKO9XqTxkUl7vWa4WEAbUP0=;
 b=PNrhX1s9U3WCBQek/lwuPkiERYJMAxztuPlu+ZUqGvx/dQbf82fgicpd+sG90HWf9ByHxdSKxpn7oNIpvMk3JL/BCZYDt9IKjHWNrGFtrCofTVqTahVYHcFKTYVPpW/c+25uKH7EM2DZVoA/M0wZXuaPzYgJzdOpEpuawmHr/UKHRC6JOvZDhRf2QxiIQXdqYyaC47ej5dLI0q4ImD7nOCG0EsgSE7+hpTvFG2lQAbUtEZHk4Z3hIg5nIvpOGPV7MFJ8L3tkLnSKSeB4huZm4HA9pcKg2jfZnFvmF3xtF1tHmh1185jgmH0uwEBy9eF4Ow9djXq1HTAlkU5RtrHLHQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:13:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:13:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level
 compatible
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level
 compatible
Thread-Index: AQHa/Q0VmoKrC7xzgUmRx3O0sW6DM7JERwOA
Date: Mon, 2 Sep 2024 10:13:32 +0000
Message-ID:
 <PAXPR04MB8459FB36872E71E1605DDC2088922@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8171:EE_
x-ms-office365-filtering-correlation-id: 53f19700-9a32-48e7-2d67-08dccb37e5f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IyeS6bDv74xYyHUtdhNIxwmf4s4foXyEtlapajNmbN3zBG+6p+B/h9K3NnTQ?=
 =?us-ascii?Q?IZ0h6jveHDze1EIgL6WPTtnhQBPvRG4N3u3r/c0a1Tz7C0xjPpnSTSfTpXKb?=
 =?us-ascii?Q?XFYjqdH+qF5/9n84GTzxeRztqzEiCs+/Fd5ljqcbs4oM71OEw3BoaSzpoiGE?=
 =?us-ascii?Q?0BAviU7XPENJF1fmfONvueVwcCQAQw0nQw1bCfZBY3Vg/3cowJr0JMdytcqx?=
 =?us-ascii?Q?3zowI1aTDkWLXyvcDPxlyyoPCa6V/Dqh75ljL6SbRAgWJEcRLQTXTUaJ4g+F?=
 =?us-ascii?Q?uNwW3mic57L2SfhMR0dw9pI25L/kc/1tbEmLh6ieY/G/Rf6tWRbkhk5NRwkX?=
 =?us-ascii?Q?buNiejpQeI8jb/6Ma8NGrT9eu7FuYrQmlTFtfi0oizDGuI3nzpqKevGQJKu8?=
 =?us-ascii?Q?6XGd7uJJQ9oMTh42O4ubgZLBJfnYlL/XqJHrev8lWF+CSDH2LkDAkOian588?=
 =?us-ascii?Q?/X/ALzn1j6b6ZItxtRztTE+5Z9AmWEotOqVUQ8WqE5Pry0ufg8UfcI16IQAq?=
 =?us-ascii?Q?dFy6xea9oMyI/kQLgdmAu76OKSiUPOkzyyjPsA10hhvYfqLEuk4pvxpyz0Yg?=
 =?us-ascii?Q?TdeLfgmdB6LCoTB20tKCoS4cWXmfqSZtIz+2HagrclRB4rIly0+t6Mu6Qepz?=
 =?us-ascii?Q?7rpAxJY4lBFZaqh72/xHMBLGVvZJvHMdDClPKxlh/URFNL2BlfYwq7sr5sKy?=
 =?us-ascii?Q?Gt8QalZ8VRjwrJZHsbfLgVW4I112z7hwq2uEWGGI8JRNJbVQP6trVaQXXCzQ?=
 =?us-ascii?Q?A19KXINtlOZr4BI9kcmMCw8jNcCI7GxKmFXFwsGmSo0nhBaNYJAbm6JWKTuo?=
 =?us-ascii?Q?mptLgi9RGJWPKIJgv6v3w7MRlbn181WZauTjU3DXRRH6pDYtGgufWHqmhu/j?=
 =?us-ascii?Q?mg3gqxvpt0uoCLsxmtbtA8AFqWb7AtcQ+a14r50qyhRVTRT2h1ZoMOJE1vG4?=
 =?us-ascii?Q?xKj/7Pc2ehgk4J+eBhh7cuvieSQXIHU6fSpQ8+fookFl0eD3uBGdj65JR+9Z?=
 =?us-ascii?Q?aYHDSXj7jMh4IGqB43BsZsoNyEFyI7lWiIcUPaYZpGfP2s4I03gI2nZUOxPy?=
 =?us-ascii?Q?aaMzBnrc/2bHGAmOPxJBmGgSSsIKupknqUqO6Ip8nfHR3KBzpNnDyufyszCJ?=
 =?us-ascii?Q?LTWWM5hKk/UtXyNkejPZoAhUWpF3m0QMf1SqGwG1+Ow1B+AgRCxV69W7KWGp?=
 =?us-ascii?Q?M9ocYmA5FqV2rR4z5K5tatg16er8XuTduRoxWNHn91VwSnIcV6ArQawWhKLR?=
 =?us-ascii?Q?5+bO4wwXt91txDOWKw8m1HYuzgGNfo0dCTG159BwqrjSG+9wrUHTvkCxSxLu?=
 =?us-ascii?Q?xuQkXRPcy4QeGgz3AK0n8uEt9HPLaoO2RKHiuY9ig+hWC1nVy97LUf8y+Pfm?=
 =?us-ascii?Q?lnvN/ustC8IFGYTddiZAMFM1zTioGe2dB9LlXjEqD/+YXC1s5lcMyA3L5KcH?=
 =?us-ascii?Q?WM3ImMSKnQY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l4GvXINHXny+AuK9RtjIxds/YA27N34yrksdL+azPsijXRnaQwdtLv9xJ84m?=
 =?us-ascii?Q?108R7r6/JXLX4JZCKs3U9ZrDBTJIaa1p41WwLYeaIBcYIVbwSsUz+0jT9WOD?=
 =?us-ascii?Q?Exk97GNue+9VaXv3WYwUsSSCO4EG9fmj7nx6vax7huPrbYWQHarA5HSJ4qU5?=
 =?us-ascii?Q?PA6lc53Nwbj1kyTeCXnXq8u9YdIEWm8xhw5wX3jNDLQP+K75QlV5G2fEQdzT?=
 =?us-ascii?Q?5itWmI6GPBRdewVNr2odaZ3i3pn3pdxqm9d3zIRCUUqEwc1nxnlitaDfNYTT?=
 =?us-ascii?Q?qD4HtCZU50pOx9qeWrfeRHwn52FpmVTijCYdwokrI5L7Tr9NxzdXbll+GC3D?=
 =?us-ascii?Q?wUUQLEpWrXw32fJ0k36xTm/u+D6bZ+WdoKGXsw+zcEFe4Xkc0eP3EsKsqXJd?=
 =?us-ascii?Q?iMNPW7eDP9K6aW/JoNEKmZMhq9hXElGpa8UHh2i+qOjAwKy+neMD5gQygvz4?=
 =?us-ascii?Q?QvCbYFnwIB0zOgKcaedhtuk08tSystkiiFw9liCK0ttjT+kVpc2nvZyB/evV?=
 =?us-ascii?Q?rU91Gapzq3aROezIWzVYW7322Psd3eAoNt72LH8JCP4/Fl+1b1ejU3ZY4nWM?=
 =?us-ascii?Q?/CmoAUj87KuKikqgVv6znlpIzGjzz3x7MuFw5PM/J/yUOs5PFu066jFVf8FJ?=
 =?us-ascii?Q?4J+qXnG7pDy1PUQgCHSr5PZT0dxCyuSLvWPIiZXVMSDog6a3xKlcDD6+gjbK?=
 =?us-ascii?Q?MBfNDHZ0IT0ESz6FRmW1C/gEy/OTonNQa448GhgxRQRv5Vu07UMjZ/Qsl9dj?=
 =?us-ascii?Q?039GLHof4x+cXyw/Fjh4cQoFKsXvlJMkszxasXvr4e6U6/byuj/ycpSeMkh5?=
 =?us-ascii?Q?1+VqcsayZhe8ipHomjXS9Y245uqKobjMNGGwOQqmDHClMK5OsdKg7pYcUCaj?=
 =?us-ascii?Q?y4jpsY13/Jz7h1ZuTwBD8stPwPMJmDYxVrKb49WdAoVIEmjBUJ07zZUNjPKR?=
 =?us-ascii?Q?AnPwTmdKd1QpWtPDptdJQL9FVdcvULa3rE+OnErL3g+809YuPS41W5lez9Cd?=
 =?us-ascii?Q?od2e1hb0X5C+3QnAqgbFFcyiqq2iv0dVz3bTlXzvop1Gh5NQuHUF/65wXEgX?=
 =?us-ascii?Q?+DJ7+d7YypfIe1E6DeIuzmDmNf7PqNXPYfE4SgjLH6xJNGpYJYd4UbfnMADO?=
 =?us-ascii?Q?JhOmJkZ8Jp+anNjiTs6PlBMY1ChOrgzt6xF9F5agCJCH1YnhekCO6JertUJ+?=
 =?us-ascii?Q?n88mlS0m7StIPRG3iY2H20Bp5spjdcue9H1xo/xzXJv1lv1xfA3YJDGrh53y?=
 =?us-ascii?Q?ZDDvxAqABfMlWS8Fv+reuurGfVJjO+7NDoKX35acFRkFpyY8YTrm95dUyJEK?=
 =?us-ascii?Q?NHwW9+HHnVzk02rxv3FCdb8dAqWY3phfrJH5rlODbYNY9sLG4L7IZ/mgNJQD?=
 =?us-ascii?Q?/krKlwZ4iv1GPjXczQpJNSZr0/7IeH0EH12OzuXSFdiuFJjxob07Tmc9xHnJ?=
 =?us-ascii?Q?EdyqlfSPJvQEuO8+TtQ7TSJhRPoDWpvLYm9tCylG9Ao4VYptX7VJLoPjl+3b?=
 =?us-ascii?Q?KWM0jG/5DMEd3CwoNiRuYqlevBqVMq2IJhEDXgEjR3Y/1vin/EnuIcoYYXa0?=
 =?us-ascii?Q?b/6QD6xnKrch+zuKtVI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f19700-9a32-48e7-2d67-08dccb37e5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:13:32.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avTfM+L4s8q7Ac35q66Whk/2/yvqnJyCnLqvC7hRQfy9Oma7gEhIQbjzvizj1nGdyntqGeCA/UDGY18qBIB4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

> Subject: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-
> level compatible
>=20
> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used
> alone without motherboard, so drop the top-level compatible field to
> avoid any false impression that such usage is possible.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> index d7830df5b6f9..cdfacbc35db5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> @@ -8,7 +8,6 @@
>=20
>  / {
>  	model =3D "Variscite VAR-SOM-MX8MM module";
> -	compatible =3D "variscite,var-som-mx8mm", "fsl,imx8mm";
>=20
>  	chosen {
>  		stdout-path =3D &uart4;
> --
> 2.43.0
>=20

Should the " variscite,var-som-mx8mm " also removed from
imx8mm-var-som-symphony.dts?

Regards,
Peng.

