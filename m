Return-Path: <linux-kernel+bounces-412054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6F9D032A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A4283E72
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9313CF82;
	Sun, 17 Nov 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T5PHKzZh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849B38FAD;
	Sun, 17 Nov 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731841441; cv=fail; b=oH206UbDf0+tdTZNv22yZZBbQOwbkW9Ean7WcwOqvCWK0wrCYq3+mT+53USVCsfaRoblmKmwlTUrJtXHMtBFTURhEgwfIDvRq3+eI6XTbKW8acNCNNgBnJskjW5lwUJkNuQH0Z1IcrPJH2ZPMnW2ZOo+BhwpZ3/yGOl2djfwqzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731841441; c=relaxed/simple;
	bh=GRkgKZsSTGA1uYcINBjSOD0Nlx41F+TItVJV01xy/EY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JiilapzH+9sgAkXW41C2BEk1BRXUR10y+EAAvNBqHVaYnPpS470AzQtwtcDzACwgT+QAK83OyyeiloU97xISN4lBESzF96UG/eUGAD3JSR3lPDr2YMVKRcEe2ypwcm4iXYK3MEaWob6iTC+6L+IdJvjt9kfBnHoLtT1K/Hea3KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T5PHKzZh; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAH9GXfRqeJSJsYyPiWlIPl5s8jj6O6p/zTTJGQvG+AtwJTuhPQ051QlpYlJ7N0vF2MMGzsjJbHV2ZWPAvL89pOq0kLUPkAi9OIoeO/hRq4mbGc9ydlTvKNyFG+PBvUJZzTjblhNEts4TYmVRbDbXCJu4UvMB32drj3w8i+QyMzujE9AdnrKxXi2Zvtg8tA9mcLuuEbz2NJ4+0f2+yfKaG4mwDkjk/mdI1uqLJpyYNVJQ5RErKKr4YpHFNo72jHiAMCtiLukGYxgNWUEVzenx5atVr/9MgNBMDro+amPfLHAzMGTENM98w1ZavEgzmhpoB00Ib+cH+CAaaRfM8YK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGXOCilP4ScCpA5zA25KG4wOkWgJq2HJJtmkKwgsmiY=;
 b=UbpfgblzsFfORxtH2EvG3LJ2Bu+v92a3lNfFatNcQ8HqzciqLto16vqpcT8L0lfmt/YHy+dkZAcOIdOGOjUHPRB2cv6SdEeGseSmv7dcCeqL5/u46bgHDlQd+YaXNIluzXyiR8Z8nOXHzRwoHi1EcweNKHqvhaNbfpR9JfOsE1PqNMDICYqO49u7PgnMAiicor6ruDVuYn+aSYXgufenxeYtxh1/3bCd3DjLI+LQ96779LZYZoN/3lQIsqvSYz55tr726PRAeC/CwjmSRTmIP+u4i7sQqIul1djASRxr//H8t552aoIrQZ8Hp+9yV5tvwnVtl66a+Y73MOeaVFavug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGXOCilP4ScCpA5zA25KG4wOkWgJq2HJJtmkKwgsmiY=;
 b=T5PHKzZhS/YrmM75kOdZae4ZVzJGh/QFqGHIcsYc66bt+yWXusUAsvZtXtGVdLtdp3lqE0ZHIKuIKfrdfIhYzX+0JerXz7UKv0NJvdu8vzVMg5YbOd8s0SWxF3XHQSgeUPRMognpOhZlkyM/pslMjSSpvZpwES4kKmVoT473GT5U7LYNtBwNLJFTr72FC5/JTnc0B45lrMGd8TQZYDsp778EfEKQEUd6NHKln8nGOW/6rDCzSOx3onRIqObJX60lPoA7yNE4b5o2MNWtFN3QA82jW3sfH6uowRIrx/bLuJ2AJxWE+WnWHviV67jghYspkos/lL9cWcYcB6DEzE5CEQ==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sun, 17 Nov
 2024 11:03:53 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 11:03:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Arnd Bergmann
	<arnd@kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Thread-Topic: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Thread-Index: AQHbN7LzwMkd4Aivn0y4f3lE3b1b17K7QGuAgAAQb6A=
Date: Sun, 17 Nov 2024 11:03:53 +0000
Message-ID:
 <DB9PR04MB846112F2F09EBE8F5691AC1C88262@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241115230555.2435004-1-arnd@kernel.org>
 <Zzm_X0o-TkkGQeAN@pluto>
In-Reply-To: <Zzm_X0o-TkkGQeAN@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GV1PR04MB10560:EE_
x-ms-office365-filtering-correlation-id: 518453a2-1c73-48a1-ee63-08dd06f78617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V2l3QVOA/fqngXQpKEwciKfkrYI6MQjRfzkPUsqehkkVmeCGxQPtKH9frP7m?=
 =?us-ascii?Q?vNDRsr8KsYwm+iKHHjYFSWsxsKrVJsLrZ9qwGx2uatz/TgNd6MwJ52jooRm/?=
 =?us-ascii?Q?lKSeu3tDYugDEi8TPOP5Dzon2fYtX/TjESSky//zJaM5V9L0PeEGG9DrN9pX?=
 =?us-ascii?Q?A1cPuuh9gcxKY6fuMax096NcWEcNoVPmMZ3L9qUVl/4yQ3Xxjsk0rpQHAJLD?=
 =?us-ascii?Q?SnFghmsJ9T3VFVzMfkHFvOiaDDrYF5XLYEz2485agJkq7mtYqi4PN0Aw0Ukt?=
 =?us-ascii?Q?Gt19rWM4jLS12Wg012xQfZZf8a0ojHn/Tr9zjXtYa7U+MxLE6eU3/vTXceIp?=
 =?us-ascii?Q?OdXMKb+m+3TbJBSAF9eQzc99AKS8Et1n0t6r38PQXyC/rzRjXLBAtgKgPprl?=
 =?us-ascii?Q?3WXl6dRt89SsWJxfSt3MwgwFCa0AfyLlu42n1sWmb3z/NuBfZzZJvzwET5Tr?=
 =?us-ascii?Q?jPxQXTBdrCvrf3L2t5B3MlZhbPJTrvEbosMYjCpdzzFpUerT3g6rBf/z9kRG?=
 =?us-ascii?Q?TAbmRVTepnCaHM61oLV1m1ZCgBa/1UZHy365YBEiCek++kge8ql6EU3KDOl2?=
 =?us-ascii?Q?L25BspjsTs5axgdez6VbKGEAhdX1p6Lu4x0tSpBTc478zopPvHV/PQ+a1n5W?=
 =?us-ascii?Q?pfbiPrEkQsUNrt15CNIWU0MKomVtRrJdR8CAhpVrv0ODy4sX/nAWBHO1TUdk?=
 =?us-ascii?Q?EaXl+ctKQB7OYkwkhDCTWe2m5qLQysV+ROAPXEgbUIxis1Xy6u9/0og/2vh7?=
 =?us-ascii?Q?pXfksRmnVeHZURn1qerbswB4GTT4yrUByQK7pCFaHyeFJmKwLowmNfwFgCHo?=
 =?us-ascii?Q?xM2WCUo8X+96ig0EJzH5y8HV6cDLXuftonL5G5oMUYaf2LET2JmJnhakGobJ?=
 =?us-ascii?Q?aGQ+XM1CUDt3Uz+d6UE/5fJy/Rf/11nmXgaPRdZqbF1mDQPPkQSVqRhOBLAk?=
 =?us-ascii?Q?KJTFcKQOEUsdAiXbT++k0IiNNpQ7It0/p1YsXWkd9un3bHt7HRv5n+buq/8z?=
 =?us-ascii?Q?vRFw6exXWFUGaPSJuDiv5M3ud5lOFEYYFEggYEulfzZGG3+mjLaEIe1TV7q/?=
 =?us-ascii?Q?1yqE+dsEvur+VMHFkxY8ZitSl4X7uvV/p0HvqrsqtttmJnEz1AVyUvZdnlzz?=
 =?us-ascii?Q?sGO8Duppps8Pg5IN0T0H8YEbVt2TS6IbAKFjJbzwkH2bOqs89GKbZf/rWWVX?=
 =?us-ascii?Q?knHk9sTYVGULV51wVslMgLWvtkFwdH9kvOty13YBPGlpQh1G5+eAJW2y8mk1?=
 =?us-ascii?Q?UvwQMWxH15XKDDxB1vr+Fyf+Vy0LYUtNzet5xu//p7KPbpDl/aTGEDqmpgjR?=
 =?us-ascii?Q?wOt6oZIeexjb4nkD2vCx4fYn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9o7tU+5VO8x29DFOd1TiaBiAcT7gGR0KGB3DoXdLIozyR22cCHA+YlzKAZmA?=
 =?us-ascii?Q?R4uwkgXzJTlN4MYQ5XLwC1jVF6+Z1TzDxhf/DAZShJHNPxseYzJ90/hNcOjc?=
 =?us-ascii?Q?6GuTBqUqfSm77PLqVOev4RGHJLwtQnqtobi5E2Vmc8LLlmzxwKp6lZEVnrYl?=
 =?us-ascii?Q?LDGMiUxrnQMTH6WhUsMiE0NenlbICjX/aJVUNb4G24PrEU3wqYWJyvkbQB1l?=
 =?us-ascii?Q?85PP93gsZsmwpAu0mriSGmuDFCm3iKOIx3wJg5MHDQqe7V+uja98uiF4qhdA?=
 =?us-ascii?Q?H91J4xwdUEto5Hhtf5AuCTohre8UQ7INt7o3IAoXCYl5k2jBhIOYxNl2H2Gd?=
 =?us-ascii?Q?JzHF0RFotw1YxEd3rLD+9Yyqo+8OowfYi6WQzFaoQM6uUZ/8HcuSE9pGFiqV?=
 =?us-ascii?Q?43x9HXtdAY8tpYz+VMw1FsLjHlllBOCJvMIGLaft0sPGLOrC/hO8qOZLMqSo?=
 =?us-ascii?Q?tujaHYk2ys+wYWj/nBHaheVqkDFaLXHpi5jmEFohvV2pEi4Uk0za+Kx5arYq?=
 =?us-ascii?Q?GaBCPaYG5Se89Q33HEpqKVkMvvHZcQJt4xWZXRre7r6KPNwfVok19u88dXCz?=
 =?us-ascii?Q?sDMUQdKKysApc49VChXcImAML2qqQLeSH1coMEGyb0xRxvlxP/mvtqS3NwAU?=
 =?us-ascii?Q?rhJZY1DdHgSJULBfG66483yaiy9HNDrlhXkPBFsRJ3YN6joaM8aw+OX2er84?=
 =?us-ascii?Q?UITA5RvcdmdXwotpYUMAyBB2EW6d2vn6hhpW9qIKxYqY/PwWxEnGeDYxj668?=
 =?us-ascii?Q?n892dnfnfRwDXmxE+NKLVOra94jcI2tR8DMnVh4ponzlnKjtyKSxy0quDIX3?=
 =?us-ascii?Q?wq2ztZ9Yy4A21yo6n1KFCtvgRhXlcvqooK5IAgVg7BC8A/qcA2Xq2vxHfNYl?=
 =?us-ascii?Q?/AtEcldiXVe33W85xW00tghJOmsi6QRPe57PA4cQSGU9bQpa9w6CkYWW8Rda?=
 =?us-ascii?Q?gdwH4MlDPfGcjx3oziwkRc7I2MI+h+d22NSH+fJ8zsMi4klKUBFPNxS83xOJ?=
 =?us-ascii?Q?URVBcMUTMPy1x9ZFYBtq6EzudKbDrjqdOt3A3iNqzfsMDsEms4P8xdicaaGE?=
 =?us-ascii?Q?lC5kccAWz66JSCjGMmGGclNEWQlgCjTFAOy87KZ57MHui9i4UffaFsj7NdWZ?=
 =?us-ascii?Q?VfCLPbAOu/a43cOY/jPfIYtyGRdKrcvAj8dLxDgjVujzWsOHvdtyDaSWDTA+?=
 =?us-ascii?Q?se+HXGRvfU4PG3s0baYw3HS3WUAMncnHsHKra6/2C3qaQmoNWi4xvponQA7Q?=
 =?us-ascii?Q?mNARh17frVzgKF4qHQ07FebnXEk9ZaEKgRjU/UONMb74tjXdARz9i+LLxwjg?=
 =?us-ascii?Q?pGgoJ8L9TBil04EAYVtP7pXWZefgas3Uf6u9K1W1P+jS7qUFAdODSK/30+gg?=
 =?us-ascii?Q?zFtrODgdeYT2OwOZQC2kK0U2c0DPobljgmMHLY9ev7rXPycbopvf08Ui5cU2?=
 =?us-ascii?Q?VaK17bEbHz72D9IhFWY0/X0xIS7HuAZmpEtx79CZs/pOhIYRYA5hIOz7Z/dG?=
 =?us-ascii?Q?x2DOWNybFIte+XIPeFd0/CuWuXq640mMyy+p57L8baUMIuMvqAJNs13klXrd?=
 =?us-ascii?Q?PyqF9Zfe2z76wpdfo68=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 518453a2-1c73-48a1-ee63-08dd06f78617
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2024 11:03:53.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Exyw6JOKT8LUkkytwpJj8BWgky0ExqOSrfGpAKYwJLUaDoMs2l9vRtSwIL5DqYofv4KeArmIQyvs1WXPqISM+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

> Subject: Re: [PATCH] firmware: arm_scmi: fix i.MX build dependency
>=20
> On Sat, Nov 16, 2024 at 12:05:18AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
>=20
> Hi Arnd,
>=20
> > The newly added SCMI vendor driver references functions in the
> > protocol driver but needs a Kconfig dependency to ensure it can link,
> > essentially the Kconfig dependency needs to be reversed to match
> the
> > link time dependency:
> >
> > arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function
> `fsl_mqs_sm_write':
> > fsl_mqs.c:(.text+0x1aa): undefined reference to
> `scmi_imx_misc_ctrl_set'
> > arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function
> `fsl_mqs_sm_read':
> > fsl_mqs.c:(.text+0x1ee): undefined reference to
> `scmi_imx_misc_ctrl_get'
> >
>=20
> The SCMI drivers, like the newly added IMX_SCMI_MISC_DRV,
> generally make ue of the related vendor protocol like
> IMX_SCMI_MISC_EXT, BUT the SCMI stack is designed in a way that NO
> symbols are needed to be exported by the protocol layer (to avoid a
> huge and growing number of symbols exports)...so usually the current
> DRV-->PROTO dependency is fine.
>=20
> In this case, AFAIU, it is the SCMI driver that in turn exports a few
> helpers that are used by another driver fsl_mqs, which in turn could be
> compiled and work with or without the SCMI stack, so with this patch
> we are artificially reversing the DRV<--PROTO dependency to solve this
> scenario in all the compillation scenarios...
>=20
> ....BUT given that the IMX_SCMI_MISC_DRV is the one that should
> export the missing symbols could NOT this solved in a cleaner way,
> without adding the fake reverse dependency, by instead modifying the
> header of the driver with something like the classic:
>=20
> --->8-----
> diff --git a/include/linux/firmware/imx/sm.h
> b/include/linux/firmware/imx/sm.h index
> 9b85a3f028d1..3a7a3ec367c5 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -17,7 +17,19 @@
>  #define SCMI_IMX_CTRL_SAI4_MCLK                4       /* WAKE SAI4
> MCLK */
>  #define SCMI_IMX_CTRL_SAI5_MCLK                5       /* WAKE SAI5
> MCLK */
>=20
> +#ifdef IMX_SCMI_MISC_DRV
>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);  int
> scmi_imx_misc_ctrl_set(u32 id, u32 val);
> +#else
> +static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val) {
> +       return 0;
> +}
> +
> +static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val) {
> +       return 0;
> +}
> +#endif
>=20

This change is good to me. With just a difference that in downstream
we use -EOPNOTSUPP

https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/include/linux/firmware/i=
mx/sm.h#L19

Thanks,
Peng.

>  #endif
> ----->8-----------
>=20
> ....to just support compilation in all the scenarios.
>=20
> > This however only works after changing the dependency in the
> > SND_SOC_FSL_MQS driver as well, which uses 'select
> IMX_SCMI_MISC_DRV'
> > to turn on a driver it depends on. This is generally a bad idea, so
> > the best solution is to change that into a dependency.
> >
> > To allow the ASoC driver to keep building with the SCMI support, this
> > needs to be an optional dependency that enforces the link-time
> > dependency if IMX_SCMI_MISC_DRV is a loadable module but not
> depend on
> > it if that is disabled.
> >
>=20
> ...and maybe with the above additions you could avoid also these other
> dep changes...
>=20
> ...not sure if I am missing something and I have definitely not tested
> any of my babbling above...
>=20
> Thanks,
> Cristian

