Return-Path: <linux-kernel+bounces-416884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F559D4C05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3391C280989
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369E1CB316;
	Thu, 21 Nov 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VW8QmNlO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3C288CC;
	Thu, 21 Nov 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188834; cv=fail; b=F8y+p6H1Gf34VpLqc3qoiltTE8uo2NFcFR+XMNYg7JsgarpUcuNQPGh68qMd+v7Tw+zTwY6kpRx5xoOXmSmacLaMZSG1SFtt+l4+1a/1cXaaRbppYKn/cKi40w1cfEhGQbEqY99BpdyHjetfx2ujYM5F9IWoU380IWaW2jYte9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188834; c=relaxed/simple;
	bh=wwO94/oZwMFyKOOxaMUItpshltUTR2fk0XcMrQfKPU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2nGMkTJxadpvlES649CJoSMd8wM0aQsOLpIdawjGngwfBUBsmbDOpJGhBx9OjuUu2C0CDVnh4RWpl5LXZUOUYXhwQ/uMO9FUmTj2l3Z0cKLBPk4htVzMMQTOS8ZeBZqUnYOgGreIWl/yUgBVtQu+emlBYqb2OGXCc3rmBvyzZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VW8QmNlO; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMchljwFb3JQwwRAe56Q8Mi3zuEBadHtat1ZOpy00+Z9t9kW8FIZs4SeondyuGVFh06bK2xcAc1vzqiZdLQWIkC1xcbfVsdh64NlJ1CQPQfP+iuD9QK4IDWKLiIERety9iUEies6PfGrGGPhGNF2xpLrLhTUC9fDNM6JzLIP61IlRTpNFm5whUEcPR0Hifop3Tidx8D2poNx6txBnYEapudYIHjp3FVFQ0nJtuTvGFdIlEFBKMMPnfxO1V2ABlczDVHjgVc6vaCfD2kS5zOjc2sEV9eHMENUF4kBT7UAkyp8S2HgfseDPhRrcB07k8wdZdOqi/Fw+31B9+cZyHy8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5us50ASRVnp7Ob1xsA0wrH/LTsuttU6lpnWkHdcywo=;
 b=oPY9WKoskljw1Iy+aMvy7ou4J8BohW6qGDhMwZW1NRjU54RP5FGP6fkq1jQXXLQ9XYw7HUE0ZwQqtvgSnMCNtGT4KNK8zn3EtrdoG2JvpXIyVK9xyScpJxaDwjp6BoUNmaZK/wBwuK9grEeGiojCzo6cmpFBJY9gTDZhnd+5axtPNBs/vejCFrFz40xXxTBGqUIrT8TrbDzXO0lk/DlZR5qrcn9jvFE7Sdwqbus/IuzUE8VinJ709szG2BfrS/bdKOUcznW/8o0U7hkKIoPESSCTJ0CXvcdYzYw1vwyENU7f3hwRBdMcmSbTs31ETq6avOagidzu3nUkhbeXyWrEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5us50ASRVnp7Ob1xsA0wrH/LTsuttU6lpnWkHdcywo=;
 b=VW8QmNlO94+MuB1MPmk+tDLcIFuXv5bgWUwnVe7sDvtv8aKYQD8OVfUd1iLE/cLQQnyuZ1JCM1PkVJmNj8WcoNqj4wnbZW10SXSqHWuEl6FU1pu5seVrY1o4aaiTdq1WWQ8Z7H04vZOchjSbrYPIr4SDsNKEtIq22OxhzS5vLcIM2+XE2LPeQhq8q2t2eyMnlYSRBtka3ItwrQRnaRoA/KaD1J6dsgg3L6pxKr7qoejTNJXq0P/fJ5ZEUQW+LogsEDnUgluTTJQmshPN6xnUUQv+ghLKXIkfXQQADWotejbcmVrnaHI/WPQKKYQKKPlwipuGnAsZXWbykngLNs6New==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10561.eurprd04.prod.outlook.com (2603:10a6:150:227::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 11:33:46 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 11:33:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, Daniel
 Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH 4/5] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
Thread-Topic: [PATCH 4/5] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
 dsp
Thread-Index: AQHbO1Rh3vtcYp5XYU+CZPQ9BZ17R7LBm6Ww
Date: Thu, 21 Nov 2024 11:33:46 +0000
Message-ID:
 <DB9PR04MB84616B3F5A76AA1C588DC0ED88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
 <20241120135859.3133984-5-daniel.baluta@nxp.com>
In-Reply-To: <20241120135859.3133984-5-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GVXPR04MB10561:EE_
x-ms-office365-filtering-correlation-id: b26c749a-2cde-4bb7-4370-08dd0a205cac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?55YuY59sVE07GKl9P6X6S/iZ4YlhEYaFzBMlCs1tjkDWX0aHNXhTQfo0cN6j?=
 =?us-ascii?Q?0NFgHKJNStW5c+2HeCICdoReJF3EaahiHFb3Xd3NkaaLjITdDnDP7Qp9pKdz?=
 =?us-ascii?Q?CxN0ywnLoNAmw5nuQyemQqtqWYCvOe14qDlX4fFXJ2a4JOMC6lGX5miqOioj?=
 =?us-ascii?Q?UW8747kcDDqptUfOPEZi8NlRnYfuO8AiiDv93QA7T8x7LPPRHoX7fYyt12ZE?=
 =?us-ascii?Q?UuIJ9C7k4ibZ7lkF0SSn4thkPPn4ZDdW/lbmsKLfLrnSDh4JfwnXBdNQv2fY?=
 =?us-ascii?Q?rp6iZmlT6f8Og83ZIZWDDt5/WPCne5falHrwvZtKb2M5SSkBl3FQA25R32ee?=
 =?us-ascii?Q?hfKFvfYfTmnDP43AetaPZgiP1J77BcjoBx095Zte49fk9VkfDpSIt2REpakW?=
 =?us-ascii?Q?CjQi2oHJZIcvy6089DYtC86QEfKTEp8tzyzX9t8dTR4HAHe6xGkujt++rVV7?=
 =?us-ascii?Q?V2EkdT8zRUI9YGoF9zwcZ2r5s9JeKH1tm+c9NIaBozFAzBJR0/23Noo1unT8?=
 =?us-ascii?Q?5fEKtzK8dHMrbLgTwdhT+863QfT2cvQprS7HMMixdtRq/m/8QC1OogSz+xHV?=
 =?us-ascii?Q?CbS79ghFy0tjJyipEZH5M8y3JGntvQCnVXGZJaVuNgBYdtUYRzbW8vrb3hVA?=
 =?us-ascii?Q?kXu4l8t8QdSaQeNL4UyHT2UzJ6Pfy7Ipsv3eWAqc36loIZK9h5hV9fJpR42Z?=
 =?us-ascii?Q?ELdmEnJDyKcMcFvmf87QjxskeakdNF1Ek8mjUR00rvZB3L2kjeIQCxaLI2Wk?=
 =?us-ascii?Q?DdFaSGSzNc8X70PCWN/Kd/zEynTRVDMlhZVYsN0YtkvGNWm2J1ncgw8WXjbw?=
 =?us-ascii?Q?SC0mkpd27K2nkip88JbbdiJ27IgPflJq9dmuO/vPMzgdKgnbU7DEhFcS4RWM?=
 =?us-ascii?Q?izm+HHZfon+foluPtjQ6QtPJhzhLyjiN3WBaEbfCur9P9pK0IR3t4W2SgQby?=
 =?us-ascii?Q?vLFXsPN6oBTFn2LeGe43Ef/7w6OlshzMsCygSSAbZButpLanSWkogyZWcxCi?=
 =?us-ascii?Q?0Fzaf84Or5jy+9srtnFcSsTZp60SuGOK+mBv7FDE8m2wdwqYDKRvZMaJKQ5q?=
 =?us-ascii?Q?bHXX0LSyM9fNafyXIOFGhGxHP2rSteoYq5q2I7sVo130JoWMflCgVTWwgxVA?=
 =?us-ascii?Q?ncmd3QPe4isWwf4b6XLLrmTiJpZgtJquA/3sLsR5hDpSUMDdldoFNCaFg9Hr?=
 =?us-ascii?Q?0nA03mEGS+k+w6ULqzMHC53pxOEdzWbUveSpFHxBNsyx7ONs+WAAjhwkCwTI?=
 =?us-ascii?Q?oVBtFLD6RPaJrvkeyCoqii2QtanX2tzcGJZvhY8VrgipiuCWiI8hUXm7hSGB?=
 =?us-ascii?Q?J45B7wLfIavbrmA1/5KlugWo9ZJhuwlv3owD3jR9jIV37BMJqwo3jv8ienl8?=
 =?us-ascii?Q?BesW4T0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ECmWRbjEqjvPticu8EflTYUX8eXXEf3uWqhJU0FNr5A6oPX5CxSBtddbu0be?=
 =?us-ascii?Q?gMbixKbboCOL+0PpS2JVwLmPo6hJErwx8IBk4adDVZ8b+NhkJicjOnLuJ8xn?=
 =?us-ascii?Q?+NyCw3wzetvYizXR6MA7l7MjP7I/mNucokyj21HHDBGOz/q0Xr6ZeolyH0aC?=
 =?us-ascii?Q?hHgrKewQQfWLaXkvMskFj2tAE+5UCCavvhB67TibmX5No2eDtdIOlPA6L7Pe?=
 =?us-ascii?Q?BqqMDi7XsCzx5punfXcF3/hZn9IZqHa5IKzfflvWkaiaUieNdtBHK3Vs46qu?=
 =?us-ascii?Q?2vl5k8sjUNAPDtzppKijMQhR0sj29op0UA9gqs4fvfUUfyk5liU3VlyBQNWI?=
 =?us-ascii?Q?M/HQRBydn4TySorpk+mvk0QBYn2hoibm4i4MWr8pROOw+/7nors74C1MowKK?=
 =?us-ascii?Q?jJMgBmNPGeGxcyZmUdvkxwr7FGUUnbhxFEZZb2aAQFkTiIqjU3cMgStmMDle?=
 =?us-ascii?Q?vg5L1x1LaTH3OgiBbSYg7z6/uk++ciVYyFodd0G+D8iI9bhplsau2mFUVuAb?=
 =?us-ascii?Q?pP9rHbz2rpQYG6KuhWGLXoHNzIfgYqfV0lrrJg5aIhwmzSEbMRDLsWtWuXk4?=
 =?us-ascii?Q?rGWoGqlvMbLEgM0mV3nHwH3X38cp/LTHsY2xXOTQhvsNQIeVC9IlJ+UCHngu?=
 =?us-ascii?Q?sWVCuchA4A+SlKidazP33W2iuwna18IhGH4zd3iy/LL1PUVHXzPIJ78M75L0?=
 =?us-ascii?Q?R2BR4sIfLcgBEaq/OimYHAtQMzJFss7X1nOrRBzWzJMUCs2ASJ6kxxZRrC0Y?=
 =?us-ascii?Q?cltqGhWf5PkwkEffFdkmqjIg2GdoiegJhlRIxhUs3x6M1yl23zn5dvk8uzu0?=
 =?us-ascii?Q?CFc/WSsAaFC9dCJkVp3S096kKMHKNajT92CZ4nQQebz4Rr+2DG/T2u/E2x55?=
 =?us-ascii?Q?le5mczqjKDHkZj846SkVo5VgW83IZBSNLSzH6cWc/mnsZlFCWhZKQ2GeIFhT?=
 =?us-ascii?Q?I4jN5rzNnS6KQCa0ldJbVzdDdvB7s+sRKzQaFUWsBQBsgePWa0D6jFDdrGQT?=
 =?us-ascii?Q?N8a1nrbAO+83E4Zx/qW2aXpE5pI0ARMV/rV98A8GzPl8jJhDea5Ys2Eadfzs?=
 =?us-ascii?Q?Wzp4YjDbFVTVhXM5CLWNq5YXO6nE1fzp8ggb5BYWre8mVqNKErNBgx6CC+U8?=
 =?us-ascii?Q?nmn7mfDp1UdS4vXX2raMuAmDD6HpQq74ykjyUA2FIQPWg5LwMEpvvtjNkAD1?=
 =?us-ascii?Q?GM6sTj65RK9Q7YKnTFAphoTRFjv8SARqmhk5THSHikODY7/4Llu9xrXCyg5I?=
 =?us-ascii?Q?Vz40E/pLzNNnBjMGsQmTWNVlqk70lPef/BbDFmfffr0CT8LX2Hc0PR948OpD?=
 =?us-ascii?Q?BG5a6RqQfB8FqFm1Rnrl9QGcW1ayO1v3W5QLvgXbZe+iiy1q+LIDE/cFxAkf?=
 =?us-ascii?Q?sruxb7qpjMbDo4RfJi9SoF5wZgWxmfYNRqiGZ/ycSArdUDORn4u3s5jntUms?=
 =?us-ascii?Q?6ltU/ghnH7aR+/bdPRi8ArUp42n+KRS3X3McEwIpRqOToXd9lXBZuflVHow/?=
 =?us-ascii?Q?MT7yWH1zeoKCTgRto0TzHpJPu2tGG7QnBWlO73N4aODe8Of3H9mrVRQIgbwz?=
 =?us-ascii?Q?8eTyZnmRqR546hldAFU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26c749a-2cde-4bb7-4370-08dd0a205cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 11:33:46.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoUePbWBwvHuRPXQR/wgzZnux8e3khNdhg/xUvYj4B6YLRPGpJIUvVufVSi+0eiGfARaGOtIgONMcG/JwZELYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10561

> Subject: [PATCH 4/5] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
> dsp
>=20
> Audio block control contains a set of registers some of them used for
> DSP configuration.
>=20
> Drivers (rproc, SOF) are using fsl,dsp-ctrl property to access those
> registers in order to control the operations of the DSP (e.g for start,
> reset, etc).
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 41ff40ab5da2..fa4ff75af12d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1616,7 +1616,7 @@ sdma2: dma-controller@30e10000 {
>  			};
>=20
>  			audio_blk_ctrl: clock-controller@30e20000 {
> -				compatible =3D "fsl,imx8mp-audio-blk-
> ctrl";
> +				compatible =3D "fsl,imx8mp-audio-blk-
> ctrl", "syscon";

This requires binding update as I recall.

Regards,
Peng.

>  				reg =3D <0x30e20000 0x10000>;
>  				#clock-cells =3D <1>;
>  				#reset-cells =3D <1>;
> @@ -2433,6 +2433,7 @@ dsp: dsp@3b6e8000 {
>  			mboxes =3D <&mu2 0 0>, <&mu2 1 0>, <&mu2
> 3 0>;
>  			firmware-name =3D "imx/dsp/hifi4.bin";
>  			memory-region =3D <&dsp_reserved>;
> +			fsl,dsp-ctrl =3D <&audio_blk_ctrl>;
>  			status =3D "disabled";
>  		};
>  	};
> --
> 2.43.0
>=20


