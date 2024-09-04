Return-Path: <linux-kernel+bounces-314054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C796AE34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741931F25867
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315111187;
	Wed,  4 Sep 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6IfwdEF"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D8E567;
	Wed,  4 Sep 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415444; cv=fail; b=PqPnHAn3wSy5rrfHhJzfwuLlgavR2qJFYd0GAKqvBNZyxd7EqUXD6/g1a4p/AFm2RDx/XLe/xrXSaTDQKSTe1SseGvX2VACkil2agXWxS1CTMvzVdS9HRNw4Z4PdEv+2is7V2vYEhZ/Jy8HWjBK/bFCQ/ICModjHD/mmNzZQZag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415444; c=relaxed/simple;
	bh=66AAWPeBkgfl2ZIcQyVGDp4A9tX7e4SFkxOWg4yBKBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h2lz0VjFXT6RvkA+xt88nw1SWBaHJzjbDzFC0sQZbw+9rdvvcvGlJ/uD600WwIUzOhoW0I0/xqtpLzbDXlSP5sGu2buj9mG+w/UPOEjm4fXovhc9ruPw/swOxNjYUTrzUCgcO0YeQUChPNOgypW9/13sjxPFOhcEhhRMVu8HMbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M6IfwdEF; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3J5LnTrRAtjniOhe0zM+0v+WcOYFiuiOW8bLW4pnaVbZVGDyQ5cQqwDZ2Ct2M5g/0zY865PO1nMlQ6b+Sx9ZL4Be72c8sUy9VTLQnIBD+ZGQ3FdvnthvHusi8ZjHAup5ozJ9JBUoRcsbZICbEQJs3XFtLe1cSLKoyO2714z6/U10c0wdZreUwmAXpZODsq4Qp9WpI6kiHTy12yEyzvmwitOZUI/ajGjaO1hcqOwurL4b9XekACNusVIOS0cNsyBePzGhdorZTL1+QkPvY7mrzTLxUgo5Mk9fENm5aZrLqnIXIesBiDt56OfHC+ihfLJrhg7c6+Rml5weU7SO2HZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgFydWj/GDAfiXk/1UowxIpno4JMPiqJ2Swd0nvto9Q=;
 b=TJhJaZNphLsEZQlJBwaiE3XyK1Q0hjnSr+zulxtARki/t4vLPwa4+NdTykfdEM1GKP2ko0amrnM+oUBOJ8ZuRMODtc8agOtdca3Er3f94PI9nql1Oqgq1jkGwuFk7pLNBYczCkaVKOZ37ahEviLckJ9TudsV3QZ7iVvSvvJVIZ4ybfn+OIKemi4hRVWqmrYbCJ2c0yhQwuI5vvIxK6gvt2qb/OyP6pAlKUBj6wTQF8biCO6giVto5MZHaQE/laHheFJ6cxdX6FrCaO1ZsOdoVCLemA/b8E0HHIYL5QnWvE/xMjBKZwHrU+5ziXp5u2g8CaCcLqGZ3oe3Gj3sn/EtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgFydWj/GDAfiXk/1UowxIpno4JMPiqJ2Swd0nvto9Q=;
 b=M6IfwdEFlTt1pYUzjzqJfoPsAXfaWEt75g0FDRkcfpf8YgaUsczJj2Y4F1O+N6vU7DzmK/w+2B/xu95sYQ6sd2eyKKc5yPEKhWqJGhc2hN3b2Belcwel+2HcCyLqxpY7uWqlNRJbkChq3q4CFKanf2vu24ihX4fSmNJdYDJkoRWDFX6Pkeqs/UBw2GHMVYQ3pOpHxXaD2ZbL+ta9XI8rHMMJiVIkwdaCFRnDFo5rkbAiA094gSgXuwpqBGUkApQMzKOHrP6tliIUdXwhu7h9U+2pdiEOdLZ5I6lKwv+aemHSDWnuTy6mKGVBTimYsgYveUoYSQh/p6cRTc5Ri19kQQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 02:03:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 02:03:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>, Abel Vesa
	<abel.vesa@linaro.org>
CC: "abelvesa@kernel.org" <abelvesa@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AQHa/UMHooRn38K5ZkGUQDhNL9MK1LJG4cPA
Date: Wed, 4 Sep 2024 02:03:59 +0000
Message-ID:
 <PAXPR04MB84591356511162E61E074221889C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <Zs7gXhohOyQ/abOf@linaro.org>
 <DU0PR01MB9382A2BBCCD8C786121975B89D922@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
In-Reply-To:
 <DU0PR01MB9382A2BBCCD8C786121975B89D922@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Enabled=True;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SetDate=2024-09-02T14:18:09.837Z;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Name=TTControl
 -
 Public;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ContentBits=0;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB6859:EE_
x-ms-office365-filtering-correlation-id: 8766bd9b-3ca7-4bd5-9582-08dccc85d734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NVveu3p4SFVy5AWLi5pZ8FmoL0VI5zXqAxcIVigdypwRWpYTjHmXFoM6ADDd?=
 =?us-ascii?Q?qefVqKpd66wvFopeA2l51seT3FG3a0IXnJBLg2Sf6ilfJtOJI8H1rzZa0kFK?=
 =?us-ascii?Q?2Zl64LzmBkv/xb0a6oSRi5PSpaP5RfKsyeGhY6MksOF6R4EyYncaDkjEGata?=
 =?us-ascii?Q?WYwMoCsXCj0kxEXehGkD/gNgoNtoEBdpxcxBwlmuZKX0e5zlTOm1/hEiMmjW?=
 =?us-ascii?Q?WG02pNQ8hJ8YYSa1GzJcy9zk8FJHgNoeUVDnVFcltMWtVgMqggSJOWAKmdMr?=
 =?us-ascii?Q?89xHo2diZj4sHsLTU73nWZ0V49Yde0qmzxDMYrF3wvpS72P8CkcbSMdrg/Ou?=
 =?us-ascii?Q?i+ALHgb6OJAKoCsJh51n34jxX+FiWmHuexhAVVqeENawGmfGsoS+Q7Dm5xea?=
 =?us-ascii?Q?nDP4R9I+S2gLNNBH9oy73kQzuqsOMgx8+vaJnJ/jss4tMWkaPZlygd9iNg0j?=
 =?us-ascii?Q?/9dh3gAgU6okeL56j86UeIvSOZsnUfEH8o0TxHkGMEM8G8IzQno2I60abzVY?=
 =?us-ascii?Q?aEZc3sAMap9JWHwbG3cYTJa/BZoHgRCkP42OMKjzG8XMWwsyt3t/eDcXfRAV?=
 =?us-ascii?Q?gBlDgcjMgcxMDguRAWJqeZU4I5Zyy6OC1pNjvYOQT4f97wXB7AIs4Jgywsrd?=
 =?us-ascii?Q?qSZ9u4NasLi5mJoamHt/oLFZ5OFo8VhjG5gliSlIULLNCWvSyl4AozYX7Y8q?=
 =?us-ascii?Q?YiNGU9d24i4INQxbx8WWEQb2cDTwbNqcvFc9pmzgyNHl80WELYS8Swkxsxsi?=
 =?us-ascii?Q?SR3jtL84iDz5DGJguQEnhwrWYNhZbBmsSzuRpW9456Y1/AjeeVmnGMgso6JT?=
 =?us-ascii?Q?KL92RgImE+SKdJ8HSmym8lWtVsHuDmM6ujGOYpg4sedGLe/bebsPagGqdfg1?=
 =?us-ascii?Q?hTSmq6ClPQmubB8xlbZGpDEWY8SW1eHIeVYqHLW+/mpho6ELtW+k3/mzCr6P?=
 =?us-ascii?Q?W221a025l2/AnBlKllaT1AZytjZydZGDncZn6/kPdBzatZjhSBzwb7AxHjmF?=
 =?us-ascii?Q?yYyp+R1G7Z0neXpVRDC97FJ099lCX1nLQUUYVskD3iOdmoLqG3LObhRzRm6Y?=
 =?us-ascii?Q?UNwdHxB7pp5GovlPD+m0sxKWXlE46PsjsNs/a98DcKFfoK6G5ckXAENhkdPC?=
 =?us-ascii?Q?1wgmpdI7ZuDTjLB5DSGxL//YvTpjqWjR01wwu+z8CUNiPdEmchEY10AK6YVB?=
 =?us-ascii?Q?fnZO8syWLEdoLOL2OtL4UKjfb3dXkEQyzXeDd9q+gMeu3hyFFc8eulZzcth4?=
 =?us-ascii?Q?io4cFSpDkwgZO0PWps91jHUXhlMOVKlkLxGygkmqQLRJ0jDKeAGYtj+psgBy?=
 =?us-ascii?Q?wKAUjJ7P2T1q/qORVKyIcD9Zt5uh/4IAju2pbz6u13nIFikgzfOfpfOG6teH?=
 =?us-ascii?Q?HFVqyoVlqx0+pv4WAhsWJ+R2luKqEGHwxdjMPWVhTh23KSNLYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gC36oDiz4WkiUdO6kL9TFzNX9v8yhRwHeJoW8nCe4YvXWqA42f19XnPni9XM?=
 =?us-ascii?Q?Q7pmXBm/mj+cLPn5QEEMWxUrAZpZcL3dt63bH1fkbEQ4bq+PVvVUtzi/nYpo?=
 =?us-ascii?Q?fsznGu1XAfbDW0n4Dwu0GTrBiw2oZXM6rw5joNkme/b41ybB54BpLzXEz1Z0?=
 =?us-ascii?Q?SkiGBezyLCxUpEzzluchyO5zwt9/oRDowoSZXbh5lbIQzxuOMtCTTyrKOgZh?=
 =?us-ascii?Q?2c6hBLIJ4wgqwXhKPGTFXUjpcfFbGEwG6eQ9z2ZixFXbA51Psp/fcn0IGpMB?=
 =?us-ascii?Q?rSA/pvoUuf8+lOajAU+zjqcg8ghB4CFn7VjsLW/dvbSyUpatApZVqQ2oSLmi?=
 =?us-ascii?Q?vZ2H1mitQ6AjFQx54Q1h447rt4M3+od/mSsHw+aGBNgeE1AULFpnYgOjjFLv?=
 =?us-ascii?Q?BJPIU4k//G9ruqOqhvgmvelnpIUCMf2XtLkAC68AiJoXiUTsf1c8xMsLfhZ1?=
 =?us-ascii?Q?FaEsPxBeLI29VCaD4XZWGdXTfuEVxzY/FYaOQ9wdCFh/z3RwndJEQOFqo4Qi?=
 =?us-ascii?Q?/7W67MlBTQP0a5VJVV/dz7KGvhOrwyHxsf0r/ZQqtUsXFJ9vXO0PQ3Wyis5Y?=
 =?us-ascii?Q?EHH/QVSL0skQrYJlZKwCnbFL/3vVo9U3hOQ7XmZoFdrrq6CUY07m0dKsefW5?=
 =?us-ascii?Q?NT3hSWCU39FHjU6MncwKs7BCizL6t1efhRYXgsQJWe4GpPUPweNDK7/21lqr?=
 =?us-ascii?Q?Qap5WfUqNq9KoczvwAcf65tSEBnc6eqDVIlCobByYX+VGJAxgvZZ4i8N7PGz?=
 =?us-ascii?Q?h2uDan9knvVE56KB72GtUi6NzFXNg/WMLOrVCiwQWQN0xfUIUx6KzHkvaHFW?=
 =?us-ascii?Q?vfrFvvHqpXKZYXyVGY2F9FEoFJ1j2hCA4p1iiMCHd9FO25UUN8qjS+zltba/?=
 =?us-ascii?Q?TvHzqpU6W59FJwQ2Pd3V6A0m6NTj2NAKQVOsvX8J8yixkbXXyG50k2KT/QeJ?=
 =?us-ascii?Q?ns+L39pBjSjbw1LvKnwiNGi4MMjnBESSRtXCe5+Iwsf7WOTaACBWXdNEP/kL?=
 =?us-ascii?Q?r0azBo2eopaBaVI7VgvAhizN5518W+RRogKC+OfPzG5Ga2ZAt9xy3Ly/GVn2?=
 =?us-ascii?Q?je3NYppA23Z2XNdSQ2cvp+rBcSSwAzq/J6p2kKufZQk3arR9zcM8ZhrrhAU0?=
 =?us-ascii?Q?n5O2MTNRwI+SSTsTNNT6Dt7pZuq9rN2i8g89wpSUSF9Ovl16Lvc2ePvHHo+a?=
 =?us-ascii?Q?okEDtkR3boEQFrgJy3A+wiWlaleWj+u8Fx994Am4dTlEp+7RNR56ufNHKYeW?=
 =?us-ascii?Q?/DeOlszC+3xXGUX7KMqgtxiDObEMvMEVGU+JWcSRb4EJ3iOfyTXny7yx+Kck?=
 =?us-ascii?Q?AJDI4Dsnq5OkUVQQe+lyyJqcBQRMFg4Pe+aBGk12x2A221RlqYJF8K1YEiKW?=
 =?us-ascii?Q?tbtLurrKtITFp06gJLkyXLgzhj59drpJ5m0PzQQ+b1C17awxOuKLHvnq/n0B?=
 =?us-ascii?Q?0Lu2GP16GtXzkRz4Vu3P3Ap/z5AHZEVhihzXUVF22DRhhm3LibxfsLNu+e2Y?=
 =?us-ascii?Q?XZfPyjcxiK7r49XTNaBhdWXaaxmLKTtjKCE+4+LNJR52f1QEO4Y/d2HUs9lv?=
 =?us-ascii?Q?oV8rIBlR8cbZ7ZnqjoA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8766bd9b-3ca7-4bd5-9582-08dccc85d734
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 02:03:59.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgYlhUFZj8oJgOFjseh3m5oU4ft0pJIiTGIyOZj+K6lDwPmkrqvRk0nzitcw7qrHlX/kKkTcus3pQjYIb/Efow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859

Hi Diogo,

> Subject: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
>=20
> When of_clk_parent_fill is ran without all the parent clocks having
> been probed then the probe function will return -EINVAL, making it so
> that the probe isn't attempted again. As fw_devlink is on by default
> this does not usually happen, but if fw_devlink is disabled then it is
> very possible that the parent clock will be probed after the lpcg first
> attempt.

Did you meet issue with fw_devlink disabled?

>=20
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>
> ---
> v2: change from dev_warn to dev_err_probe
> v3: refresh patch
> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-
> imx8qxp-lpcg.c
> index d0ccaa040225..cae8f6060fe8 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct
> platform_device *pdev,
>=20
>         ret =3D of_clk_parent_fill(np, parent_names, count);
>         if (ret !=3D count) {
> -               dev_err(&pdev->dev, "failed to get clock parent names\n")=
;
> -               return count;
> +               return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
> +                                    "failed to get all clock parent
> + names\n");
>         }

The change is not enough, you also need to handle
        ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);                     =
                          =20
        if (!ret)                                                          =
                        =20
                return 0;
->
        ret =3D imx_lpcg_parse_clks_from_dt(pdev, np);                     =
                          =20
        if (!ret)                                                          =
                        =20
                return 0;
        if (ret =3D=3D -EPROBE_DEFER)
                return ret;

Regards,
Peng.

>=20
>         ret =3D of_property_read_string_array(np, "clock-output-names",
> --
> 2.34.1
> ________________________________________
> From: Abel Vesa <abel.vesa@linaro.org>
> Sent: Wednesday, August 28, 2024 10:31 AM
> To: Diogo Manuel Pais Silva
> Cc: Peng Fan; abelvesa@kernel.org; linux-clk@vger.kernel.org;
> shawnguo@kernel.org; kernel@pengutronix.de;
> s.hauer@pengutronix.de; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; festevam@gmail.com;
> imx@lists.linux.dev; EMC: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] clk: imx8qxp: Defer instead of failing probe
>=20
> On 24-07-02 08:10:44, Diogo Manuel Pais Silva wrote:
> > When of_clk_parent_fill is ran without all the parent clocks having
> been probed then the probe function will return -EINVAL, making it so
> that the probe isn't attempted again. As fw_devlink is on by default
> this does not usually happen, but if fw_devlink is disabled then it is
> very possible that the parent clock will be probed after the lpcg first
> attempt.
> >
> > Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>
>=20
> This patch doesn't apply cleanly.
>=20
> Please respin.
>=20
> Thanks!
>=20
> > ---
> > v2: change from dev_warn to dev_err_probe
> > ---
> >  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > index d0ccaa040225..7bd9b745edbe 100644
> > --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > @@ -225,8 +225,8 @@ static int
> imx_lpcg_parse_clks_from_dt(struct
> > platform_device *pdev,
> >
> >       ret =3D of_clk_parent_fill(np, parent_names, count);
> >       if (ret !=3D count) {
> > -             dev_err(&pdev->dev, "failed to get clock parent names\n")=
;
> > -             return count;
> > +             return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
> > +                             "failed to get all clock parent
> > + names\n");
> >       }
> >
> >       ret =3D of_property_read_string_array(np, "clock-output-names",
> > --
> > 2.34.1
> CONFIDENTIALITY: The contents of this e-mail are confidential and
> intended only for the above addressee(s). If you are not the intended
> recipient, or the person responsible for delivering it to the intended
> recipient, copying or delivering it to anyone else or using it in any
> unauthorized manner is prohibited and may be unlawful. If you receive
> this e-mail by mistake, please notify the sender and the systems
> administrator at straymail@tttech.com immediately.

