Return-Path: <linux-kernel+bounces-168681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B78BBC08
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67A41F22225
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4339FED;
	Sat,  4 May 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUwzs6j6"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE293C47C;
	Sat,  4 May 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714828537; cv=fail; b=g6Jbzd3ZV4K9/2rg8i4Pyfw3IVXgiCdQObYs2inxjRXMz2TcAQGXfYgwsXmhYiFfgZcVO1mbZZz1KK6HdGDGF9sN8toHIpr9JslPTAnU7qsA4dY5eCQ2f9bSMQ9f8d3ldFg08QtPu5ZdjaLo5EmZ18q8f3BBWu+RdjQkmNk5fBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714828537; c=relaxed/simple;
	bh=BwYtrCtFycRIWzm4/qr0kFTVE6wJZB0DDjGt8f7FaZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqSn7KVctk8RcUyQfLoXMF/WmChqieUkM0JAXGGOlC1gmKHEOPPWCjFxhdN0FrpTn5DpKKrrC1RyTtpjavZ+0HNrL/wxHXw+qg1d9EJD9eXnOCYRIv4/XdyZSK2rIMv4Dq5tSivH4zjNUFmZ/9fkw/gKS/g7nCchHDWk9kY8rXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUwzs6j6; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKXFgvXo9Ex4WZeysp6nMI+H7Zv+OdaaMnssWsRJ+Zz9G+dAKjcuN1pNgxM6sanDKkpKJCO2daT7OybJFPpKrh8evWp+uTHNMQJwsqInLc6awEx8Bphi8bwm+3/SopcMv4fuPzkfJTd+lOaTWN/NlzUfjIaycbjdfv87WKgvVseRp5URW4l/ylAmgZxBHa5WhYXYKliQs3ZoMjMsOiP5IOj0/DqrVG5LWXZyKDfGpYu0FHAXvNKHB7FlynuZl8HDrmyfgvYajxRZ8YqlYHIksvrH54sdWjtMUIQrfANdBKILeq4e6ZVKRyReLnWdjFg/iECe0oJR80lfhhD8TRpFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwYtrCtFycRIWzm4/qr0kFTVE6wJZB0DDjGt8f7FaZc=;
 b=B80MdalDgzSLkcNi7i/0JENFwqfZ6C6ZfjMKNviz/GHBJKYBTv1txvXdsfxUPUlKliCC58UCZ/Orl/IPHhtyzsrsoajIB+GjS0Q7Vh77B86svubJqConSoTS7nA1WRkyUctDwes/b90dzZ0ZjBxPXNTDjSfoPUYzuwYcfFhs9+0S6gfar5qLOnOtvWkEBXpZulyKxtZqMTRiC8D8PONCPbIHTSgsBX02IY9LsTWtHhHFUy5ArqTxvdm/UZFZCF6a4v4DX8eSrBvcMM8GObQWKI0VXBrHms/ZVudcAbX3ZuZ6S/IbpKYESD0A+O1FO7xysc6hzO/dXe5rUO/rqu48Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwYtrCtFycRIWzm4/qr0kFTVE6wJZB0DDjGt8f7FaZc=;
 b=MUwzs6j6O4vV+da1fubioR0R9T96VVnsiGjHVRNuXcXlUyy1Qg9tHMl5y+VkViPqRvedDpOAY8BHvgdDDfVWoAu5aUZltwK27qcUzxb7heG9iEyviaWnNCN0/0oNoxhK2sott/tD4EXyQGmSbtWMu1MJoXE0yXF3IErJLtw65Po=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sat, 4 May
 2024 13:15:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 13:15:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>, "S.J. Wang"
	<shengjiu.wang@nxp.com>
Subject: RE: [PATCH 08/18] clk: imx: imx8mp-audiomix: remove sdma root clock
Thread-Topic: [PATCH 08/18] clk: imx: imx8mp-audiomix: remove sdma root clock
Thread-Index: AQHanbvXn3rY9AYNv06Zy9t6z2sWLbGG+auAgAAVEOA=
Date: Sat, 4 May 2024 13:15:32 +0000
Message-ID:
 <DU0PR04MB94173BFF42020C4687E5EDB7881E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
 <20240504-imx-clk-v1-8-f7915489d58d@nxp.com>
 <20240504115951.GB3666@francesco-nb>
In-Reply-To: <20240504115951.GB3666@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8633:EE_
x-ms-office365-filtering-correlation-id: 3bbaa8ac-f94e-405b-b030-08dc6c3c474b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zGE0MUdIbZF/ewQcgm3On9G1qVBXJ+eyRDo0QmdhR/g8wosfYNbNsGJfMJGS?=
 =?us-ascii?Q?wcwSwJIOypV0+PElNKxQPpaRNBBMtpP49euZ0wR5CfWf5SA9eU8s0WQIWrqU?=
 =?us-ascii?Q?5KDZZMEvUmVP1RhmJ+PZnCY/heaSgVKzLxq2CEovv5lg/SggePWxmjGlYyUs?=
 =?us-ascii?Q?/0LcOaDhJ4nyO6+Kz70Y1LW0TnAc4dXjK1ZzToKZCfgNqwoUjHmq1t04/MaZ?=
 =?us-ascii?Q?oIKsJs5RItsXoXd5RFKuEq/ejCFQl3MBJyoise9ZB4s0xO4R6eZcII3gAQ8D?=
 =?us-ascii?Q?kJBWFPLvyMnb9Vv7tEdPnIVqmDyjTfqtQZdgO6PtPcbg09OdXEOs7kMFHqO0?=
 =?us-ascii?Q?f0HslXgYJbX6xMS2PcfTOBSJQiUW1FmyJv77t5ROci6xZDJc4lyOXQVosMzw?=
 =?us-ascii?Q?ibClSopC9hJ2V5kZmwVd70LpbyfpcVBE9zUcusClDeaGlrPZ4ol2XU0WpWBZ?=
 =?us-ascii?Q?3iPLs23HeYcJHaQe+vY3PwvESfs01bgqWGX3WA55hRNuYH+60hnNt1uTPM60?=
 =?us-ascii?Q?E7ztHS5sxhDnpVt4l10pYXOBDAcLf1T2AfIhc1/TXJOg3WeyYn8np1OVKLuz?=
 =?us-ascii?Q?HFW6Ko5aAko26z58S2wNzvLbse1Pk91oni61UwlmtxAJ1kdPvOUTpBQKaLyD?=
 =?us-ascii?Q?Faydg7z8oYw0HSPn+ntmLkkc/NwvamIOkVwY4lbeeBR/N/R6EeImU/ZGSePG?=
 =?us-ascii?Q?YgQn1fVo4xYtpyywxECYkMq7iIiEm0hvWWXuHakG4NNMyuq1lHfaTL/WE446?=
 =?us-ascii?Q?azHsViDpZGXEPXQdiaOtIWvdiRuwq4T3kujyWKoGW4J0CX/sGu80ukB53umo?=
 =?us-ascii?Q?p7h8DPxYxrsBRG8HK7vP7Ii3jD59Dc2Ii3Euzb+iX17DWQ9nTZu6AP0ZyMvB?=
 =?us-ascii?Q?33ISkJLo2IZDkx0nguXaa3RB1hR41WKJS/cr3zZUCChUJVV3iH4H+oMtzgF/?=
 =?us-ascii?Q?BxnHc7grA/s7vWBLwCnfUJkYDIFnCnJEkvSDZxV6CvC6uLNor9J0KCyJKEaA?=
 =?us-ascii?Q?qYSNzFwKEu8+SuYDMrSaKTOGR3eBwL59zedLsJuO8SSZ+tMl+gS0tfFk7+td?=
 =?us-ascii?Q?MjfTPsfqCbW9aZkKmkLsTG+HC8XSj2CakmQVqWXQ7qqNGduRkaYARiGvt1+s?=
 =?us-ascii?Q?hs9Woqbay4sj39xPH5ZEEKO8jV0Ffu4q3KnpHfK/qbAuEFd43iD4b84BlSGx?=
 =?us-ascii?Q?SAzy9/bHWP0RoLjj6VGXXCpShIBReDcSCq1yvfKvU+TmduNiugJ5GXaVqOLb?=
 =?us-ascii?Q?OxmhMo9qmQeptg0PySzIgiZ55e6J3t6DCvtmyo508MTKcEOztla0oIVLyfdZ?=
 =?us-ascii?Q?FmY6sMUThN9ai0btgHSC1n4h4o2fYVnHvDxEuXcoFsH6UA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cuVhvEOtW5M3DrUfTdvEkeUCy9DtgB4+jgIZ4OpQlwaWVgbCiwxJb8fi/wqk?=
 =?us-ascii?Q?+tpuSn5W2K3nawrqPn4wue4bAksIpVcsBS9EJs/IJQBkzfBd5QmZ1GcOC4L3?=
 =?us-ascii?Q?GG+42GixX5Fk8Vl3nQpnWQjUgtPa/HFxoh6+1V9YbqK+pC21tQXBnsRTAONh?=
 =?us-ascii?Q?V36Kill/H7RzuhTMC0mDZjAOn9LK/sVKu1M+AKOdcZeFUOYhEMviJill1Zal?=
 =?us-ascii?Q?Dhj42/MEjfoDFNFEINNzs9kCV7RkqTP0lrkpBoHpn52P5qpM3jKvUW6JZm48?=
 =?us-ascii?Q?pYWOx6TNtIL3HSgduJgygwbZnplw+eHL2o4LAVwh1Bdyo8HDf+bz+wpRDpg4?=
 =?us-ascii?Q?5jMK3r7pUf5WBQC5L+NHQQHPLSGLBeSTLOaeuxxGSpmLp5jaI9JDC7AKgkDb?=
 =?us-ascii?Q?Mu9S1HmPx4MnfJt/oesUVE8pfq8uYQU915PWa9eYVEVoav9AnnxREVn89CBu?=
 =?us-ascii?Q?EFKL2gvTtA0TSfjH/G1w/Q0ItPCsP3JlHzoI6bO24glQXXxCbCLgoUHqvX0A?=
 =?us-ascii?Q?A0z7YASalFhbjsrdstrFXKLUkkM6VP0gOFTc+vysR3/55owFAHsxg0YS8NNL?=
 =?us-ascii?Q?BUlT85biLyE6Z3fMnhfVBCwOGPMv/wmRtZT52YEMrJVAbUnU//shKOsS/qxo?=
 =?us-ascii?Q?8yL3qZyxW53MF0TWLMNCYJ3txfrbZdLmIzBPErysnT2NA6kkQcCtOBSe4vnb?=
 =?us-ascii?Q?jZbzK0jtgIkbZEzyMWnHsZIqm8BB0lOuJEi2+Jv/Bd4tmL1dJLNt2ABoURtm?=
 =?us-ascii?Q?c5FZ/ApwRFI3nYt8Rf5ks4zNSXgAccXCT0xkDr114/etaUK5+ci1hf+qRw5y?=
 =?us-ascii?Q?CQXdnuYvsSqWAZ1N1FLAFGZoXHF+1gFWOr49nI0YMpRy6gu6rw1sxQB8w0mW?=
 =?us-ascii?Q?nm3dQGuTq9UeRl8JOxg6nrrKLz12mgOS7c3K13TVaDLA0fWItw96u6tABnWU?=
 =?us-ascii?Q?+VwwJ9TCzgx2IlD5Xa6QleEYSW4POfHhsaF34FrXk8x/ak2tw5yGdgfA4Emo?=
 =?us-ascii?Q?DrmHnac21uZVMaf+0F0JrBDPF94FLPayf2SufontvNm23LhotBdyQyM57sqJ?=
 =?us-ascii?Q?z4aYjdqdPfZ/RfXdZ427zbpqEuxp8kEe7Esnz2AkW54t2fozRx6a1FY0m79j?=
 =?us-ascii?Q?3gl9jEeplCg3xpjjx0IhvIeCRm4nhgnBguU4lmdxB4mznDT1Di5WgDp390rH?=
 =?us-ascii?Q?UdaDZcz6hzv0EBHWOmehRfNbTUsFExsOJV53ARhNCZa/50dNzifMQ1ERGJdl?=
 =?us-ascii?Q?8OXqpVtGHpYhuHruvE4tCAv5jiSZviB/6u+B78uARHflkAOBFSkE8yrrCorV?=
 =?us-ascii?Q?MdMWDwe8yol0uWqAWTCV3s7f0anfsEteb78Jto5q5gbJJFUcMPrRRHVE3tJv?=
 =?us-ascii?Q?jipqRH8lW0F3VvwJR2XzTWDlBO3uZJv0S40guRW+aMzvMKPqRjzzN/8d6h6I?=
 =?us-ascii?Q?4fyoss0jiN6chwAprFRfk4Hg2EEZN6iv+A6W+gFttxjEUObdFJMYaNHo+Z/t?=
 =?us-ascii?Q?/KIQWXEyH//897a+nhph7grg84qOyl8gALD3PUM4CSbrhYnOOiq/U28hChMk?=
 =?us-ascii?Q?iGK7vzCv2uJfKVpvDLs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbaa8ac-f94e-405b-b030-08dc6c3c474b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2024 13:15:32.9129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1IMrzbSqvc54NCsZEbGkQfVahLkUdpvc9Qok/KFT4Tq78MTeAXwzAE4FH6iod7Y+hQD3YrODg2eLka0dm8nYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633

> Subject: Re: [PATCH 08/18] clk: imx: imx8mp-audiomix: remove sdma root
> clock
>=20
> Hello Peng,
>=20
> On Sat, May 04, 2024 at 08:49:01AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is an issue:
> > SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-26) to
> 1
>=20
> Fixes tag, given that this is fixing an issue?

Sure. will add the tag in v2.

Thanks,
Peng.
>=20
> Francesco


