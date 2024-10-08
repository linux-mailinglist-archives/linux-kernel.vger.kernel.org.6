Return-Path: <linux-kernel+bounces-354820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604339942FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C814428551A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576A185B5D;
	Tue,  8 Oct 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VBgNsMLd"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128523A6;
	Tue,  8 Oct 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377278; cv=fail; b=elc4lIWyhUSs2CvbPvsSbavyFzixdc6LZNiKBctfwKh0GJsS/47AJ/TUGo71JcIDE0ADr048RLt8kQn2jsdu7sV2KoVHuI/E+a2ohTXPCDgT8FaCW/iO6UnyS73+qfDoO5MdIv7q/fLVivPPhdYTWVBFy0665nY6kr+u6Ic1XPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377278; c=relaxed/simple;
	bh=5wt8FuYywrAX5P0UU3qbmGtr9pEUKZzLkmyxivGk+vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8RBV8EWBqn6k7QdMFBQm1u2m1jrk+BpUM2DE7FWIxHVxeKQy3jH9nbQDaTFc4lcwAJDAP8I75K+Q0dnycevdnxOff+vg/NPF/0wAZExFVSMuQcn/OrdoydxIbfkip3MyI09+QuevvdYoeKS3r+clQ5vaQPWj3grTE4AwJh84xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VBgNsMLd; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB416wPvn92qMGk7hLKRIroJvzYlfGvd+XXAMQajM6TzEwBaYqGEQmxJ0aNW3AMnNYMo2fF6+9rhwOZHmcToEA2YxCL1rERL3MgwJ2w7CXhdzJD7aI0WZuRqKZTgmPeRbGfdo5W5c0VwKUR/fpqMJfHtqJ/haZsQjygLvO9mubsJRHg1BEMliw2lwUNMhh9Mf+pd1EMtYk+5boMEYRnWKzBxuQhhZp9PFImsRvVQ/1XZz7bH5B2cWA1K/HoJ7K2eAZ3Q1NwLdHjuYHh6IjlbNIBABV6EfZmZj9fIPPQlehnmOygDyyyktVKTaNfFKU+X4GwdNzjQhofpVNxdYhvJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE6gEr1XEr01mhLoXQ4fzPP+enq7FVEE+GWWLxqOZk0=;
 b=cXoJm612GSkdIPbJFlJ76dWG/ybn1b5o+JeLhIwK0rtJTzItK7VSJzXl5JSOtc3U+ISib3Hvr1Zi+Z7Vz8Pg5c2C/FMe7PeektTOGiQIE0+yDl39SWNP1CnGhCs1PlRNbMQmAgvMEokwAYmArufPzeYiKAIdFciqGLXvW0HKqEobhMpiGDKKur2Z/X9mqmw6eAFvrDyIZZfGuNvten7T/G8LoH2tlKBajs0BFuI9EwBwFidzOnHtnMO4FoLXAWsN9zREcwdrHkEofukuBzrEAlo1uMweRb96zbmQgJuGXCjfGTmbA3TiR2yCm0CagCP3TDX7LYTwq0+v8L1juscM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE6gEr1XEr01mhLoXQ4fzPP+enq7FVEE+GWWLxqOZk0=;
 b=VBgNsMLdXbyjGkU4+fW/UxiIylqu4Vz+CmsjqykA9u1a8HL7hvLFuPHTkG5eW3lgkTPnpoEasqXHwp0Dq53atcoDGw40fJd9yb/UXjdLGfV4Iki837DOkULzb/gwAbAWwnDs+eTkuw38ivl/FycPJVCihxXbWqy4FNPzDuJoKLnD/f92RxOlazOJOCUk7M+Rf/IrtK7wOW6NZnshKXkKKqKRbb4YhIKt0/MX2hh83X09+7LBMDL0/jm4tiEXxO45fDhaM6pwRitXpwdIhQQ47DJP1kYuGL6Wz5yQipdaYRdyolMLT5lRZtUBXMDNx4IwaPQ8C+CwkIpt5+w+/b7r4Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9857.eurprd04.prod.outlook.com (2603:10a6:800:1d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:47:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:47:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "shengjiu.wang@gmail.com"
	<shengjiu.wang@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, Adam Ford
	<aford173@gmail.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, Mark
 Brown <broonie@kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on
 v6.12
Thread-Topic: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on
 v6.12
Thread-Index: AQHbGLx4kfLbSUcjVEme+BTq/dAog7J8i89Q
Date: Tue, 8 Oct 2024 08:47:52 +0000
Message-ID:
 <PAXPR04MB84596824B2DFDF20E005F173887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241007132555.GA53279@francesco-nb>
In-Reply-To: <20241007132555.GA53279@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB9857:EE_
x-ms-office365-filtering-correlation-id: 8c804d57-72af-455d-b639-08dce775e595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IXuL8a9/ERke3l+M9uZ2bOxjHE1bcsLAvv9WrkMKW6N6LqKL9YXnYSvb5EBV?=
 =?us-ascii?Q?IiHr+Eg3pFUj7wicSN+83PmR7+OsVO4LCwQeKsojHer1NRhsVAIxpLaPRmC5?=
 =?us-ascii?Q?r6fyr6aXBy/HvRDln2oNDVIDW/61dqFMBD6o8nnuA6IiHuom8zffhx5Xx5o8?=
 =?us-ascii?Q?9XYoMB7Mj0n6vSJZYKfZa51zOIRWPbCkYepBDs078sYm6Zo0QwQ2+5UzwhH9?=
 =?us-ascii?Q?FHu6V9pgc8ZEo4QzLw/GP6cO2pY+s45Dv1dcp4XMkm1wqkhcx6HSg5ksZmx6?=
 =?us-ascii?Q?dvCOea4IPk4ndphzIUDTpIDiEem2XtmbuDgZvme918uvXWd66YrszFG56Z6q?=
 =?us-ascii?Q?6t83a0GEtaAxTnrobIBZ9JtkC8CR8tOSloRrX6eTuUJQlMe+0N6N21JPb/rY?=
 =?us-ascii?Q?iK8U0dm2D7NJn0D9S4A0E0I01xZ3+OVFg1IefliGZDJgn65MKzchwVEUxNw+?=
 =?us-ascii?Q?udAuyX5XoP99gmgAH+AXqt7Vf31sbwEcTvDXsZxlagcqopCAF2DwIEIgLxa3?=
 =?us-ascii?Q?9DN47ZCLXRaRnmc9zCy1bd2fF8A3Ah8ajEQjZyos1+g47KL03N+CHKuZ+XRG?=
 =?us-ascii?Q?NVlZQixkkF2ho95UQ5NCGvYLfSzWG+lKPB3Ne4mX9qigjtAHiV++qKu0mrqd?=
 =?us-ascii?Q?Cyhh5Fx9sJ0aVyWzEHG6xo1ITMxakiyb9zg/CJF2lc8IzE6IUCRMFmjS82eM?=
 =?us-ascii?Q?KgrCJIFeU8UP1dj6U5waI3ez7K/Cy4FTAKAlihXB6jqICaExdhCwR9t6UDwK?=
 =?us-ascii?Q?xwkciVqaAMpPxXZAg4d6HlNRVyGeOuDL7tCEzbr/awMU9kU9PjQUZHeWG3Xc?=
 =?us-ascii?Q?60a72tAb4q6xxFE86Gyh7ZiS0NbJqhPcAxXO0bMNfJE9mqWoSRu9/V2JJzum?=
 =?us-ascii?Q?qjJXhqhHxoEfTRWeaIpWSR4MUExVTWeYcnu865Mmb2w4prJeDeU8JPB3aeiO?=
 =?us-ascii?Q?D2yJXNpWzrSQ6ZViPiGQw0yRM/SbzU7riJK31+30042s/xqWMRhSOPAg75+C?=
 =?us-ascii?Q?sOX1BIcmQYUOxolOk4KvUptzSTRrLExIIZt0CA2k0pqX8GTdoV0MA4Nidbm/?=
 =?us-ascii?Q?TpEslA04DE3O2c/gGYARk50sLAmdf1X3Kb0M3STXTXWOqhQgFNbOzMdnkEl4?=
 =?us-ascii?Q?1LtFfZr5aCLVG+BcU5rbvFTI5zhmv1OYV7DcIMxqLQvL0OzHWEOjUVf30ASS?=
 =?us-ascii?Q?eJgaWsluomoMUeSi2mhhtsV7R3VuN776CfV3KEH1/RAdFbDZd+M41Qn8QMWn?=
 =?us-ascii?Q?K5CE9b5Qw6eXS+PJJzx2AxSuDLB2XUt9yEd6LQinU6UzL83aMhwJfe8TPtbZ?=
 =?us-ascii?Q?su8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pnLGvILZJZTb1+d2mahKFxqPcIfhSCwXf1sKzWLZDQdqofewnDLzZxZltS+M?=
 =?us-ascii?Q?s5/GtqUZ47kks4P+dlnvhDV8oKVT7yMti6Is2j9abvlmQ418obI2RoBf3Tec?=
 =?us-ascii?Q?0XosXgkr+SqRsVlBWHuWlkBO/nrTa647GKXAUUnl9k3HRfrynyIkLX9WgsEq?=
 =?us-ascii?Q?ZVw4HDSxKs4ZqdoW1aRuRiZJ9t1e2etrmlTpxPs/J7Gr0iWl0OCFREadUeuZ?=
 =?us-ascii?Q?YH+rBaKvW/2zFSQZQqhvBl8hGAe7eS870vuKj+U8Q1PWhMYgTyL9kTpKF9Kw?=
 =?us-ascii?Q?xH7Yaa2mEEaL4qJUYLqZdhKXwrhT76O6TPfItfxaoPC8ZD4kgcEDKBZ0DnOY?=
 =?us-ascii?Q?2sjCYJatt0DAgLjRXuRyg6pjrZtVID7KBNS4cg8/0Hf/cA5Lu6VJRtnPtVyp?=
 =?us-ascii?Q?6ftMrPm02hAgdYnTf1vaUSHlQ0WyCi5koVtLpWMTWowik6D06ZEU5xHQ/ny2?=
 =?us-ascii?Q?Ye96dF+Y7asUXMQMFfqaINRCex4SlMHAepUxt8ja7AOKtRLrOO3LyzzCH8dW?=
 =?us-ascii?Q?GcQoj586gdIWzAuzTf2skvrvIb0lG3hnc+TcxnxVen6HYp9bjpS9VC4rUpUQ?=
 =?us-ascii?Q?+Za8L9Pt3S6+FkiujgZk2YzQm+dYGrZ203AwIlXO497iVMRzAiF6QHXLtHgP?=
 =?us-ascii?Q?8pQLUj6Xp2OPmHprii8Cr13ujoPtCiA3MPG5W5nRp8Y+SVZA7D8xU7srGpD0?=
 =?us-ascii?Q?U1Sqo5irPH2wOqlgsLqmWVJbEUpIF8APtuw11vV0LFFlAceEOWfVqrNxUFJh?=
 =?us-ascii?Q?iTAddoPF8dP1At/T96fBx2HZpn5YcJAySclxBYsMtBf0xD0LZlBWnH8d99IO?=
 =?us-ascii?Q?TGSwiZVN1k/saGUktJqyrOsfI7jlAbvlSya1QW47eT27661x/7lx48h7La7w?=
 =?us-ascii?Q?3sQUA2qO/WfkrKvIDD/ed4+NBLhzSVl8qhHroMnLboD8MEacNlpwCmea8ovS?=
 =?us-ascii?Q?3m4abeOP6Uhk18BlbmAdIWGoe4LMZP49uakDjQk/fptWw/JSmdg4YqVcJb7h?=
 =?us-ascii?Q?VRGnC7eDWK7xdNHcNdcvXbzfvmoKZIK2Z6r/lSBlVCKyQZb7bRyIh35qCjX1?=
 =?us-ascii?Q?ZacXU+UEjIsbgs6lO2XSj2jMKoNeMKqDrEivsa+TFBpwtbqb+Tqgvxx2OSIP?=
 =?us-ascii?Q?B7gEOszELQoMVNpKpa/0pG1/ENx+1IITXgDUXJpMVSxbtXn62EX3mJdk02iJ?=
 =?us-ascii?Q?L2P6srpo0HD11gI1MALmwW64tF4CYCdYTw5oDiOQP2yGEpaMyAltvy/09/ZX?=
 =?us-ascii?Q?EkoANHTgQmsv1UpSWp/WLvjjI9pu20NrFI9K/hRm6wETwXRVGPEIQdlwBAjw?=
 =?us-ascii?Q?yeXtQsDmlDjaB9qpqd33vwCVqO3lwNxrc+CHPexEMzVHDtD9eJMg+kMOsRTZ?=
 =?us-ascii?Q?g/IxwrfKRtXskpKynT9kO18PxASc+wurkpXgxRQR4mDRqs79AD/TqXiAlClU?=
 =?us-ascii?Q?6CwLzT78Wn5LlcTAX1Lj01ECY1+Uua58UTljW/6i1i+zKc3bbTSAv7O2lfhi?=
 =?us-ascii?Q?2l49YcujtdByXO/2aJhe3RyP4HCOhjGO1KHSgHrP4GZB0GmZNUzhHaUm4cOj?=
 =?us-ascii?Q?3kHkj63izqyxTGWzP+8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c804d57-72af-455d-b639-08dce775e595
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 08:47:52.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1VV5aX2D6mUReAtsmy326pydg+XOivUBtHEiw72/jCIHKHPOUcoGpwwbFVqGPkFnQPsC3OqOEPq49Bk/mj/RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9857

> Subject: clk_imx8mp_audiomix_runtime_resume Kernel panic
> regression on v6.12
>=20
> Hello,
> it seems that an old regression is back on v6.12, reproduced on -rc2
> (not sure about rc1).
>=20
> The original report is from
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Fall%2F20240424164725.GA18760%40francesco-
> nb%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C5d607b7da6304
> cc475bd08dce6d39678%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638639043687597943%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C0%7C%7C%7C&sdata=3DOEpuMElhS1Qu8ozk%2Foru6LUf3m6Z
> 9vKCIph0ySjhwFg%3D&reserved=3D0
> and it was fixed with
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Fall%2F1715396125-3724-1-git-send-email-
> shengjiu.wang%40nxp.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.c
> om%7C5d607b7da6304cc475bd08dce6d39678%7C686ea1d3bc2b4c6
> fa92cd99c5c301635%7C0%7C0%7C638639043687614985%7CUnkno
> wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DUk3dHAJ60Q
> yvDHohjqZJSqaPZCCU4tAM7eD1cY%2Fh9gg%3D&reserved=3D0.
>=20
> Is it now back?

With tag: next-20240930, I need see this issue on i.MX8MP-EVK board.

Regards,
Peng.

>=20
> [    4.012850] SError Interrupt on CPU2, code 0x00000000bf000002 --
> SError
> [    4.012862] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not tainted
> 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> [    4.012869] Hardware name: Toradex Verdin iMX8M Plus WB on
> Dahlia Board (DT)
> [    4.012872] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    4.012877] pc : clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> [    4.012891] lr : pm_generic_runtime_resume+0x2c/0x44
> [    4.012897] sp : ffff8000821cb740
> [    4.012899] x29: ffff8000821cb740 x28: ffff8000793c48d8 x27:
> ffff8000793c48c0
> [    4.012908] x26: ffff0000c0ec90f4 x25: 0000000000000000 x24:
> 0000000000000000
> [    4.012916] x23: 0000000000000000 x22: ffff0000c1bef180 x21:
> 0000000000000000
> [    4.012923] x20: ffff0000c0a73000 x19: ffff0000c0ecbc10 x18:
> ffffffffffffffff
> [    4.012930] x17: 3030303064623033 x16: 2f7375622e303030 x15:
> 756e285472656c6c
> [    4.012937] x14: ffff800081267458 x13: 6d692c6c73664361 x12:
> 0000000000000000
> [    4.012944] x11: 00353333333d4d55 x10: ffff8000818020ae x9 :
> 0000000000000008
> [    4.012951] x8 : 0000000000000008 x7 : 0000000000000000 x6 :
> ffff0000c5bf2080
> [    4.012958] x5 : ffff800081f10000 x4 : ffff800080c182e8 x3 :
> ffff0000c0ee7088
> [    4.012965] x2 : 0000000000000000 x1 : 0000000000000004 x0 :
> ffff800081f10300
> [    4.012973] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not tainted
> 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> [    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on
> Dahlia Board (DT)
> [    4.012985] Call trace:
> [    4.012988]  dump_backtrace+0xd0/0x120
> [    4.012998]  show_stack+0x18/0x24
> [    4.013005]  dump_stack_lvl+0x60/0x80
> [    4.013013]  dump_stack+0x18/0x24
> [    4.013019]  panic+0x168/0x350
> [    4.013025]  add_taint+0x0/0xbc
> [    4.013029]  arm64_serror_panic+0x64/0x70
> [    4.013034]  do_serror+0x3c/0x70
> [    4.013039]  el1h_64_error_handler+0x30/0x54
> [    4.013046]  el1h_64_error+0x64/0x68
> [    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> [    4.013059]  __genpd_runtime_resume+0x30/0x80
> [    4.013066]  genpd_runtime_resume+0x114/0x29c
> [    4.013073]  __rpm_callback+0x48/0x1e0
> [    4.013079]  rpm_callback+0x68/0x80
> [    4.013084]  rpm_resume+0x3bc/0x6a0
> [    4.013089]  __pm_runtime_resume+0x50/0x9c
> [    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
> [    4.013101]  __driver_probe_device+0x4c/0x14c
> [    4.013108]  driver_probe_device+0x3c/0x120
> [    4.013114]  __driver_attach+0xc4/0x200
> [    4.013119]  bus_for_each_dev+0x7c/0xe0
> [    4.013125]  driver_attach+0x24/0x30
> [    4.013130]  bus_add_driver+0x110/0x240
> [    4.013135]  driver_register+0x68/0x124
> [    4.013142]  __platform_driver_register+0x24/0x30
> [    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
> [    4.013163]  do_one_initcall+0x60/0x1e0
> [    4.013168]  do_init_module+0x5c/0x21c
> [    4.013175]  load_module+0x1a98/0x205c
> [    4.013181]  init_module_from_file+0x88/0xd4
> [    4.013187]  __arm64_sys_finit_module+0x258/0x350
> [    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
> [    4.013202]  do_el0_svc+0xa8/0xe0
> [    4.013208]  el0_svc+0x3c/0x140
> [    4.013215]  el0t_64_sync_handler+0x120/0x12c
> [    4.013222]  el0t_64_sync+0x190/0x194
> [    4.013228] SMP: stopping secondary CPUs
> [    4.013237] Kernel Offset: disabled
> [    4.013239] CPU features: 0x00,00000000,00200000,4200420b
> [    4.013243] Memory Limit: none
> [    4.316721] ---[ end Kernel panic - not syncing: Asynchronous SError
> Interrupt ]---
>=20
>=20
> Francesco


