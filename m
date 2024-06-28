Return-Path: <linux-kernel+bounces-233208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D822E91B455
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B6284223
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F67568A;
	Fri, 28 Jun 2024 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZMRa0jw1"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6B3FF1;
	Fri, 28 Jun 2024 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536324; cv=fail; b=gQTjUHkDAcASPlNsBPKj0nlHpLaDdkfpLDF3ZoRd3VziCViFFsVFFD1tHhQ+ymNLxZzqrHB8Om2qdixeQlsWyh2cd3jQuf5ZVggXNP5z0K7CYruKopCd7/RM8aSrv5Hb9CjGVolZcoMHEnbzucAdZdCNJUeUcgbGzJexftj5Qow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536324; c=relaxed/simple;
	bh=EqeUgBOr/tQ/oQTFF/95P+oglXcjaA+jIdr8xRsqIEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EaLfL4SXCQJ9kCsqW+lyIKbWSPvA4/VoOXgo+EpP18DjpViwkdyKmcRn1p/fmIlBOt0d8NJldrIimlJLFgHbeGp3xkEJl3b2fjz5FlQqbZRX6voyfT+2rPDbrhWH868wq3XeMZyEsEfuItN+8fTP2/yIJkEFXoWNn9aharvKrzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZMRa0jw1; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hka2QGeysCNR9uSV55s857WVGJu+vhplGp6xWHKGbJmqgdpPKBfDQnDOH7FmozBh9e+ryu4tlB5tr9+nwkwYD2mXGN7sw3fzVsjVtHZ1t9IHE7uSTPRauXeG/nWFr+31woh1IsHz2x/3z2EdugZwYzolZj0yUkJdR7sLVQORM/PwyLJOnUjTSo6iHSJsh8jabAV1EDICf8mxcaTz50dtOeVDRv0pjuxSfu6tvhRww2ZTAIvqVFekVQwM0HASaqdq5wRhEACuq7dljt3ARqG54HOEvxm3QgNoZa8jsX1Iu4dg2AbtepcvgLVwvf0NbgrzZQ+l2w6r8h4xXhkZ7teN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3CnLASEeBgxxWbixizOagi0L0nFJXLrSbRxyGFjJYw=;
 b=SuB8UEqz8tNrGzy6uVvDMDl3K8scNFSD+bbBcx30T1OIwPp3/QxTeWVlsngXqvs09260KJmLwI32FBQffVU6JX2FT3f00bgHAIsQSkhBs7vRHfMp36nug3T/SwrUvI6gRxqPB3jbQAxaAOZ9tg4BGp0e5cEp87s59UOh3oTdhZ/oy9gGc/fTio8QE/VoN4rtoRnry5EuRDkNNBSelHeSxzcXcB+HpDwCx0hZv4WBr+EmTfQTwKTENupPiMoKHcRtt0p+SZ5lH4QgEPselSNiLBmxIYlf+26gKmVj6uc/oSqcswN94812KLBnVSnqvTRYYfwBve9LmSNAxKYko1Mm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3CnLASEeBgxxWbixizOagi0L0nFJXLrSbRxyGFjJYw=;
 b=ZMRa0jw18gK9H+5B8kclhBKc2Js/ouRM5aShNsrJ2FLHLC0OVXNEN0Bj+/+hWR6G9yY2YgUngD4KAvKXQWbLlfzEyGFnq6BIL7Yt2x2jRiLedjO2hW/WSZ6CWebr+D2TjIl+eS2L2RTXnP0Y3foFSUjd0MxVwQ6ivjBCPyzkF6M=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 00:58:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:58:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 5/7] arm64: dts: imx95-19x19-evk: add flexspi and child
 node
Thread-Topic: [PATCH 5/7] arm64: dts: imx95-19x19-evk: add flexspi and child
 node
Thread-Index: AQHayN2G5sIbh8BuOUme+3uH2bRwrLHcWqTw
Date: Fri, 28 Jun 2024 00:58:38 +0000
Message-ID:
 <AM6PR04MB59413C6B1A976B158808CD9788D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-5-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-5-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAWPR04MB9933:EE_
x-ms-office365-filtering-correlation-id: 7d3ae447-9bc1-46d4-1a9f-08dc970d7206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bsnUzdDz6M3dd2Y0soIrSAdlY6s4bEuLRGRZOlh5TsBQkLd9QrrLkMvQuGy+?=
 =?us-ascii?Q?oLTOddd3nJhcP+iOBlrbICWNhFcXYyJORfE+lNTLyrRrF4UA4vuBT7D2Pk2E?=
 =?us-ascii?Q?83Hpj+wRrTyKz6mHfuKZ91+aXpLv6inbKt4ZXqtkkH9qrF+/8zxqRSy1G5Q4?=
 =?us-ascii?Q?gmAp/A/NkFhH1OjuloXp/ogypM5SeJh0VNgKNPgfQYvLFe26MLQyPuJb01ZK?=
 =?us-ascii?Q?R6jmXoDADM/4u54OqGV3IMsELIyb9xVimlLskera99cleYQQ/+JMBI5uNjAN?=
 =?us-ascii?Q?loCtc4K81whG695VYF1PrsRSxyCsx2gD+GBaCRGR3lSzgjAPOUceNspgAplu?=
 =?us-ascii?Q?oaNH8CvMeaV04p4wjHurHY22tEhoLJy7mnmIH1coVik+Y1X62SZUUxn/Nqs2?=
 =?us-ascii?Q?bcZPz82sD1ZxC3AOHbofiI3OQOaXhqc59yh+ZwvTYELirXotlB+Soq0XDAgF?=
 =?us-ascii?Q?oRR7vjG37Dzi6jR98c5ZEhi3Q3umxoUblanIyYZ9Bz7Ft70xz/V0PvS1MxT4?=
 =?us-ascii?Q?ubY/QBH7sxVQ4l+7TyvDCL+HyugQX90NPi6fVB0z2H/2N2fGwhv5vTT4+xgN?=
 =?us-ascii?Q?h58NNJqU+KS87cqW+DEnYRT/lsgEyR65cyefKPABQLGkiLmTras96XgLe6Nn?=
 =?us-ascii?Q?iaCiHlInFhX/1f5sfBLrBAy6TRPjiMkWlOshcdMD8wW8ZoYwWwRDTEL7OnGH?=
 =?us-ascii?Q?EXjISdtsavzzzj+45OS0TQOGOq8dWLa0m9SH2bIVWYFK+4WWnA3xntByru0U?=
 =?us-ascii?Q?WqZ30FF1Obis4LSKoKErvCCl+sfguJ3WjXD1GLXmg6upVyEDVSw05KmmghJC?=
 =?us-ascii?Q?/pqWHfj0s82CZ963wA+HY8ds2wv60IkpVGEoZnGL3jGAQTgCdvZ1uVTXGQZO?=
 =?us-ascii?Q?se43IR6/2u2uoxnFYnRn2jkQHG0PIFZc4VmJ3yccW5XW2Wbpw1HhIR4M+r5j?=
 =?us-ascii?Q?qPcyhjLb+Au+m+KbNQxBzGRHuo3mGEU14jOAJp3IHp1mtFMLmKqS0NmJx52x?=
 =?us-ascii?Q?9BRwXaA+zZ1bdg7AgRcDx7OdoQNrRKY+3moUZVmKALbIZi1Jf9ItVa9ypV+0?=
 =?us-ascii?Q?fzpX43V0cTc4v5WxH4Asq8mJVqhyzdQA5lsvmQM77vGwe5cwvhM8b1QrK1Eh?=
 =?us-ascii?Q?Tl1D71qOCexBwX0FoBFzUcoaX5YLH1Kiw1cyEBm7REOCII6t3/IfMZp2x4Zy?=
 =?us-ascii?Q?lOSXkCLNhMBgZInsiq3b4/2jME3tXUTFLL4N6EwDmE4rk0qY27C/AjwXxqbX?=
 =?us-ascii?Q?7G6zvPOF8W/NcgyO7k0KqafoKkYUB/S2V+f+gB2y426JJ2LPWDnVqJnxkRw6?=
 =?us-ascii?Q?iyWWmC13G+acbquoe95kyPFHQOWqab9J1hUwRplnqminXIObk0tcz89b1f9K?=
 =?us-ascii?Q?Ut4yok60QWPxD0lPUYChzDHDsXo003+01HmrpPJUlUg5nGXxmipfIrLaQSlC?=
 =?us-ascii?Q?wC8l4TwCWVc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NNLB//qHTmek7YgWs8wLQudkqikA9TQljrk65TwCl7N6jo9v3+gKi75A4ubN?=
 =?us-ascii?Q?h6SQ3f7U3QY/ZRLJxhepHg+B4RNI16Zp3llCGggWBtStWqGHZnLiM+79qBjD?=
 =?us-ascii?Q?IxDDzdatohlwSew+UIC5LNShNiEny1IB6H2ZEp/Bo2FaHgVv++3CtEWg1m1J?=
 =?us-ascii?Q?hsNyFg+clwIsuPYiI1z+q3N0VkfxMa4cfv58Qgmh88PuWmeVCCs3ZtLup3up?=
 =?us-ascii?Q?AFb44NFhkttag6uwNDlQ261XoTQKjLoFSD0q0BUAkUG0vEPj2d3BUjVPU0of?=
 =?us-ascii?Q?ACw441OIoSS5/52jqkXpjaGV1AwRyoVL4RKOqSvxN8UYE1crLQ8u6subVpt8?=
 =?us-ascii?Q?zW3GALLQSUQC+Am3NP7Ht0rJoudP63BbppzD+9HKxTHMmCujHO6HXjutNcFD?=
 =?us-ascii?Q?DnZjx8dCsAbLNSvolLplam0VfPTD5H1q7N0mesah5OJK+R4uBoQC0PLuiRsU?=
 =?us-ascii?Q?s/oXWUp9o8ATiIjO5UdsPGxwxJQsCwU/c7o+zHlhJ4AM+dqagyflUkdFaDlZ?=
 =?us-ascii?Q?qZKyX+3GhgPC/HiP+ZjwGskJbVFVd4f9T0eix1L98EAU2f0UQo46cjmgVwF9?=
 =?us-ascii?Q?zQ7AJ2ffE24ytCz4q+evXMlWa15TBB/0D2uCdztht0Mmu8V0tJBsyZH7jDMs?=
 =?us-ascii?Q?z2wXCSfBbXAnrp7OexDl+D6h4ZbDlaQ/47c9B6uvMjJDwK3tF67+glU70b2b?=
 =?us-ascii?Q?SDYFQZrFCDVqqxzr2W9/R4CxjQckFWWPv5WVeR0xNQ6TCikMTpfUy4P+Myv7?=
 =?us-ascii?Q?GjDQ1IJG2mLr2sSBB+8amJYtgh9rSSqKD924kw93jQ2u7E+kFztAPwlr+jw8?=
 =?us-ascii?Q?E2aDs/2n8jkv6nasYBmFb8LdaVcml7KLxWs/m+1PldcnxARmh/KA17PP1BXa?=
 =?us-ascii?Q?ZsGOLZVksCrtwHe3rBQ56uQeBS15VVhvFfOzPGeyi5DUW020/uV598iapntA?=
 =?us-ascii?Q?PjZrTawxx5jEQNRD7f9aIplbYsLdaqtrIPPycL8Y3kPitshyB9dJPJ8o+RXn?=
 =?us-ascii?Q?Vb+W26a37dbJqSWrvK01wI79tmeqifeRZIxk1VIQyiRSOpFd5fDyVEzZsbhs?=
 =?us-ascii?Q?CiEjwVxIMFdPBuMIeSNTHxoYEXT+2YxqvXmWs+icSSe/IBLe5Ug4fHdXbzwM?=
 =?us-ascii?Q?DjgMrsH5bl8cqLPeUGzt2v4E27iqWEpiOrVh05k68g6vZrUqCUQ1Ft8I2jqb?=
 =?us-ascii?Q?CTOWgwHi6X7qG2p7d9RVNtoz8G0dQKX1CC80aqJerpablwsGDuinF4MyieqO?=
 =?us-ascii?Q?rQwuL1Ka+iekJ/Hjk9NeX0mRjVVAX609buH//LjvRXrDAY54yhmQ6bQ5vBuh?=
 =?us-ascii?Q?A1z8Jc074nrRVyPSuAnE0sZINDB0Gi5aHRbzj+SdDahXyMNDepNA9LS3Rwkb?=
 =?us-ascii?Q?cfxsG8S31BSewhfJsLHLTr4Ozyvo2Op7GQZu5uNrSQiybU2G0mlNToFipq+d?=
 =?us-ascii?Q?9SS+/AW2rZQvMEY82gKY6jToeltIzeQyxjYOi3P9hlKA1rbDnCvlvQh5gXc8?=
 =?us-ascii?Q?7x2qINdnjBMVnDNvvDd+q97g0q98u62oB6Rp6iB74D+uXQusyAf/sFF9Pxx5?=
 =?us-ascii?Q?iVp9svUvTSvHCSvSiMo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3ae447-9bc1-46d4-1a9f-08dc970d7206
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:58:38.3047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekCHxTM0hIC8k2Gj+yPltKS5xO9WB2i1DNljUmu6su/rHbx5euaIh+keLD6csiZAvLY38W91EnMk9xxLMjRm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

> Subject: [PATCH 5/7] arm64: dts: imx95-19x19-evk: add flexspi and
> child node
>=20
> Add flexspi and child flash node.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx95-19x19-evk.dts    | 33
> +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 660e623f4f964..ed8921d6217b8 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -163,6 +163,22 @@ sound-wm8962 {
>  	};
>  };
>=20
> +&flexspi1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexspi1>;
> +	status =3D "okay";
> +
> +	flash@0 {
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		spi-max-frequency =3D <200000000>;
> +		spi-tx-bus-width =3D <8>;
> +		spi-rx-bus-width =3D <8>;
> +	};
> +};
> +
>  &lpi2c4 {
>  	clock-frequency =3D <400000>;
>  	pinctrl-names =3D "default";
> @@ -336,6 +352,23 @@ &wdog3 {
>  };
>=20
>  &scmi_iomuxc {
> +	pinctrl_flexspi1: flexspi1grp {
> +		fsl,pins =3D <
> +
> 	IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B
> 	0x3fe
> +			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11
> 			0x3fe

This gpio should be in a standalone node and put under
flash@0 as 'reset-gpios'.

Regards,
Peng.

> +			IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK
> 			0x3fe
> +			IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS
> 			0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6
> 	0x3fe
> +
> 	IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7
> 	0x3fe
> +		>;
> +	};
> +
>  	pinctrl_hp: hpgrp {
>  		fsl,pins =3D <
>  			IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11
> 		0x31e
> --
> 2.34.1
>=20


