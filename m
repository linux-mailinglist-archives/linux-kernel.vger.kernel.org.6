Return-Path: <linux-kernel+bounces-311314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29383968772
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B697B24A30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864419E989;
	Mon,  2 Sep 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aFb9gE77"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1E19E982;
	Mon,  2 Sep 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280020; cv=fail; b=jyw8+SJ32epxirRJFzlDRTrHuRmHqkyU77fA4CAgLP1EEoopgU3aX3tnNmCHyab2V95o7FUmjjJ6UUfh9rSWfxl1IgQkm2RHgpCEPWojpzgIJUMErFveIN6s/HAAMj7mVjC0hFRv6bp/MGryD1XkK9/94fsnWX2qykWpYitKCs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280020; c=relaxed/simple;
	bh=NtNr+hipPoRTf9GkfZC/siTXhlKTvjboXic8tmWqTqs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIBiWY2SXrpGcsgMV/q7sxCFgGRAbJdJW5ZFMacqR2pNXGv3rnY86B+Al7cOhMVEmtfu2Rlu4r+7YEX05OlJkIz84RdLSpdIeKvoxijtiHHNik9L/cnOjJjOimGd6zYL8hKtb+7dUCxBbyVKdwTOz2U5slDwXbQIHVwgO0x/xQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aFb9gE77; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Paf7vj6YgI/nnVIEBjxvFssHYaLpMoNlvAPxLn/rNrAWEpXBBOMbnJxhqqhvk5EgbWrrcp6+7f8oTpKrnhoCMKtSM6iXvH1FfpE/q2S7rRpkU4gmEmEfB/iOVA7EZ1SgExXxRgMnud1Is13cHQPf1q7Vk19KMMUe0kPTjc8aDy7P4k71pCvnf3ziAv3HpYm/AU3UiEUkSp3WjensAgep8XmCrNDi1wIg3FZIHAtGfpvz3U9AS+f0k5IJXfdyi++o9cpRsI5yu0OZWjz1cg4hrGsw4PfeaAzuxEOEYiMnwEqD7k7t9KZ1UREMOXSiE8cjizx4wpIbydqMg5j36jWHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtNr+hipPoRTf9GkfZC/siTXhlKTvjboXic8tmWqTqs=;
 b=yKfRok/O3jLfCGuZIXvHAkz6OtGy9lH/PMdoCBCdWQKnuHuY+SwdG6VAPgXNE+PTjF71cw/PoDJUzOfxRZZO55eTOX8tMU7MrIB9Ikp82NX3zaoQr+jNJeJZgqT5AX/72OgFPVw9pcWvJfTxJ/98m/3K8yc1gFCNyYSbftFeB9MkttTrI9uHocxGLRmnLRvMHH74zQ6xPAz1NYrvAKa4l77bR0LbXiGI/MW3jxg24S0/amJQlcgOfLpD9OFSktbVMhfCEKSiWNbUZQ6uREmBVmamv/pISeiMDdoTLDP0VZtXnpj6dYdM63t7+gIoXOFQgtFpXuC2p3xPcXxVJcWO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtNr+hipPoRTf9GkfZC/siTXhlKTvjboXic8tmWqTqs=;
 b=aFb9gE77NIaiCkKiLnt+djDqlssWWoHhw3vENaRAemIikoSDrdpYnfhJI6h1RaC5PfgMzDMduq8+nyOsMiArFPd8iR6MeEEhTs4o2XUdgDArBhF7lf2hWCO2EcIZFC7q2qKnANjiPD0IAn8yUmvv3hyFsubhsOUAiq12MsFvvI5W56Pfbe8u0lX3XgeLlqYIhlHVTjWZp0Czv5sLhTcFM3pnlpSPLPGwg+8WWPS93AIxPyBZeGRpNjc6pCtaUPyrF0nYXXrCJKHatGFSCAYYk08bcEVKvB27jg9Us+pjuGCjwkOQ9W3oEdyM5pstDs9jl5Rkfuwct5tQiTI6RdGemA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 12:26:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 12:26:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM
 SoM compatible alone
Thread-Topic: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM
 SoM compatible alone
Thread-Index: AQHa/Q0X9mOzJc/GHUKwPUHeDPzdobJEbH/w
Date: Mon, 2 Sep 2024 12:26:54 +0000
Message-ID:
 <PAXPR04MB845910B01B38836AA7D9B74688922@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
 <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10444:EE_
x-ms-office365-filtering-correlation-id: 012fdb06-af42-425a-3187-08dccb4a87fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZCHTK7acrQEK0m2W0laVLIqE4lS8ZcmUbSQg7ax44qMNKlYlzl+wr4kLoYMW?=
 =?us-ascii?Q?JtHQCiW9/h/LSvDBYRntcwx5d4m6je0+IZWMqUC/oKGMrgSxgFzg+4h7git8?=
 =?us-ascii?Q?AERJ9g/w39q7Rp61UN2PVN43rMuf32M+l/BvqKzlO8B6byF1RaSPaexAn2L8?=
 =?us-ascii?Q?kwrIqY2wmGLyXekxjfP/JsFy+JC058hkSCAGe97pcaehUwcBGsJ4CR6YnPdm?=
 =?us-ascii?Q?i81GfVzEaqnCWsOE2MXV/WM0fLFepA1k35aQuO7jIPnJFvxEq+MsNTpjoZBL?=
 =?us-ascii?Q?dPgEcYs2h/63H1N0Z70TNVdd7s2+jyfIX8sBSwXC+ps2uUngp0pCBA7LgJ00?=
 =?us-ascii?Q?SxOyUupyAI2Ht0bc+fUKvdz5YUqgPIaCLPHlF1+WUTqurEf/XYESPwX8NiOy?=
 =?us-ascii?Q?X+j/7wPECJcd3y4C/6Q1K7s0vMz9dAz5Lnco65NeZiD2nOblDQIISLGVgtXo?=
 =?us-ascii?Q?nxZ5PJ7Vyu61DfTC6ZuGg7UcDWHDNyq8fzueszsvMHZvuFLtVIN3siTdZC4d?=
 =?us-ascii?Q?ZL6HMVACZ4Ha/2jkJFj0voyZDvg7FL5kGgCg3qH8+kPo6eYrFVWhid5Uo/yy?=
 =?us-ascii?Q?MwJAmeCQNEilglhbBEe1s1MEJi8xKqYKClvaSNaTEy5dnTBZGYREkA7zER/p?=
 =?us-ascii?Q?1lYKOVdZZRM44wE2dv5z0zuy7R02Rm/mdUj3rxhna8WZ01mOjdrOFvGDYo8T?=
 =?us-ascii?Q?TOlrh0NWrLPNZzQXRyTTod38C8oPDCDRd0Y+6FtPsEUMBkWyVctKvgT0j6Vc?=
 =?us-ascii?Q?wP+UIbEG4hFHrZV/uR9U4wh6V30W1BroU7glkj66P6qYwgW89ONW0ZclSYFI?=
 =?us-ascii?Q?6uqADS1RJOH7mDXdbNL8fFskCvZVaqqhJH6aP3HrOnRE/4kUCVVNvaLfeo5x?=
 =?us-ascii?Q?dp9C6hEMattxL6wyU+VDV0R9VNBXXit90tbseMWmjTci5XpD/09MsEpqjdjz?=
 =?us-ascii?Q?ESyweoSi3yqjd5sPATor2U7SJOGlOBg+TLSn8KWc7Q/mv5ZNQATJdUsUEdFs?=
 =?us-ascii?Q?SsFs5ce5vJnA+rMRMvlqou49FRhy9wsCihaA2gVObgegnVw53b7N65RZ6PNL?=
 =?us-ascii?Q?MUF81nk+MTkdYDP7Ypn2EIjQw5uM3/yQZCnYZavpxYhHGw0a0Yt33UTGJaFh?=
 =?us-ascii?Q?z+P9e0OanTxibAJvEMviglAIpNTnkF6gnq9q4Axr1SnufR0ydEwSHwwlDBXU?=
 =?us-ascii?Q?9fYvqmtomDzi6mdirV0pIXH8ypgWHDGQVRyDX275GsPH4snI7YLFKNJLDVKN?=
 =?us-ascii?Q?yXB7xICne4p7mfb1D5l2u2AZ5hq+jJzqk4dOk3w5paD/7QhNNCcdJRhtYtVk?=
 =?us-ascii?Q?jEcr5uFawUC8uR/prvBiQ0j+eJ/VF94/F6LDod64h5qXSBLEOAt4klritG2y?=
 =?us-ascii?Q?cnYBdghQZfXYXtixPcgM3ZN6Vw4QhFyR+dEsKivnbyY0hVs2WIWHrp6TIiDr?=
 =?us-ascii?Q?NRd9obbKhKk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mMM91leQSNWRGVaZjKrMsVrjFX3f33DNsnnFSVPoG3oJcDipyLgJzzUubTBn?=
 =?us-ascii?Q?/PTtvplodW7DBjhUPu/LMMwsqAGULPKSCRBR1hBKCVS3s68DbGXy0/sqURwl?=
 =?us-ascii?Q?Zr6/72/DHhw10yFz+ba3gYV3boykMA5B8P9v71gr340J8aE6BUPFcoMRRBJC?=
 =?us-ascii?Q?vZzccGddlUn2fdQ/hTNfgYjKR8sKPdIqbpbQfWxE1sKl/CbASyrbZN9F9Nap?=
 =?us-ascii?Q?KYNs6ZiVK5MrkSh4ADH0iy5AqIVeg0MpuoXL5fFAVInro3PQ0bIE/P+nGINw?=
 =?us-ascii?Q?8sli6U/6XKzkqniOQTR+fONeCEywjJP9hRty3ufYE4u0IfglffNBTiuIPGuh?=
 =?us-ascii?Q?LZgBwFuCHkXteVT6jMP0dlmY9YdoLKr6Utw7Z5+ZVfhOLu+hiTRbDxgotiji?=
 =?us-ascii?Q?cW6Fy+n1EhPkFFK3uuBXyJEthd/wHdRFrklq2j41U234pwgsi0kgcZf4d6yx?=
 =?us-ascii?Q?Vgvc1clh78jPtJ569LVau1CV8YUw1KEcqRi/wk28w2FvSIEHieXBZhW5JFXR?=
 =?us-ascii?Q?ghoF/QLs0CPxBbdruV6O5AQ6K/A46hakUfha3HXB2LMG3qAQQZI1lWSmF/Jt?=
 =?us-ascii?Q?uVcX1Ih878uuoV1+a3DVLo2erlBlzbVOJQ9qWUaXucdEe2oKcuNEINBmnLCI?=
 =?us-ascii?Q?HDAqA34D0JD8Yk9rcQe8MLxMtq+wNcYN252z+ZuqzctILYHg8kH/4cgHbWD4?=
 =?us-ascii?Q?RJqKG0X7bouErEnm6Lv4WVGvvqpSuR0WfR4XO1oMKQq/pYg2Yi/YIFt9AW/k?=
 =?us-ascii?Q?bf4DW0+twKxNnizYWx90BivLvwUmfm/X+qakq2EJoOScMSfZK4A7XTD4RKME?=
 =?us-ascii?Q?dXZaJknx0mog2XGMMKZ5sxQkySt7v4+hy7szHkpdex51TvW8vxiFsutDqX3A?=
 =?us-ascii?Q?8zRWGlFLL2tPzzCjdU4dwkRIOTGeo3k7JGhQVxF8jjUT7GQPAkEicftuqDcE?=
 =?us-ascii?Q?LWKgY3eZgjHby3pbdqDloTpsNGuWMUyOreOre8tR+WnCrOfM6hp6EqcfvZmn?=
 =?us-ascii?Q?49RgcbEZMoaOPQhPs3r3eIZOqtBwGnzWW8Ys2ZW0BcwwK0/CWgCjN5hm4fX+?=
 =?us-ascii?Q?SpTEtlfSN2UNDw9SQkoZySxLQWHJ3V2r+Qdo6znceCn5+gnAsV85FNWBS3A+?=
 =?us-ascii?Q?gz53yx4sxVXBh32oFlGLSTlTNGPT+RP3L9tVTZ+nhzQJMjTGbs/Cd48Kton4?=
 =?us-ascii?Q?8LA353gkkyYDDQkvzxJg3+yM6MzySPqOTko8S92gU2h+P/rBQr0jpVwAYPFg?=
 =?us-ascii?Q?gYQ4bgLA8TWBSdwha1nG50uyQYYRkJ9E1ENSPzSHqoncicM2SyHstMsexEH2?=
 =?us-ascii?Q?1Tf+30ZbaUPYdnY60nbx0iUgp26uIiz1IiIggGoi7fhesKEQKH7i2rLDw+Mc?=
 =?us-ascii?Q?f/DlYN2DNyBZanoGpgrosIF4NmbOYin/NcA88gsm+iNAPISNCHOr9+ru/Huq?=
 =?us-ascii?Q?2euyqi8MGqAIT11AfuK/jk2ioNG5dIj0bykKtce1Wvu0rpNukiYve+/aX0kz?=
 =?us-ascii?Q?x5ZhU1vZQMJoSVQYZUOGU++qQnoa/kPMwfJkunSs34/FA4AG4ximpEy4hOry?=
 =?us-ascii?Q?IuHoBvE+K2BXCAZWAWk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 012fdb06-af42-425a-3187-08dccb4a87fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 12:26:54.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfjLqXuzQwq9B/DkRB62J5FFXez661Tu2ArgDpz5guA7ISHLJr0/V7TD0jDQqlwABLsmxqjg5MN1Cl1wiUNqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444

> Subject: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-
> MX8MM SoM compatible alone
>=20
> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used
> alone without motherboard, so drop the usage of its compatible alone.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I got a mistake in my previous comment, so

Reviewed-by: Peng Fan <peng.fan@nxp.com>

