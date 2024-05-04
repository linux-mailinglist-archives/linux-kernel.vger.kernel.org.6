Return-Path: <linux-kernel+bounces-168671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55ED8BBBCF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611491F22065
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F137143;
	Sat,  4 May 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9FzYngl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCE374C4;
	Sat,  4 May 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714828401; cv=fail; b=r6IUmxjxzoINAGW/+VMoNDcoLkrZHrS+TsJcZMadl010b3TlB0bGMhoH1aDoeEJD0CaPL7oCT4VtDF99AKz2a+u0uXYA/OKZ9ChyyH82OG9Dx6t3lVMAesk7RZ/Knn2rslKFlpMPa3yoYXETx2lNa+gqtXEsVEuNiZaOCBv9HT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714828401; c=relaxed/simple;
	bh=A6gILYSn/FhWpoGyL0W1HAez7rHwq3dZjIjLkEcwNlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EqD0ScFiB4p6qMGATkoe6VLzT+GALmN+sHqlJE8+t8iHdAfZskKSLMHi2l9p+ePvCCZhewFqxrp2WxC9DUMsfXIGGo8jaAX/Pi3J9ud/k3AdLSFWCB/Bz9jhMd9BdMrj3rt9PNuekS64xlNaenN2H23/4Z1O9HNGkA6zb1/CoVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E9FzYngl; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnJwhhsiw44I0WOZn2bZkdCXtRBrZvIKQhD/dd9kNyJSlefeE8zUlFrqBaUxix3nomsz21rLZ9YHq93Z0KNfvb0hmHwA503zma+PZCrxFQqBVpELZdkkbfxF4bNMmFQysRQsai7R0e807No+k8bYAZwv7d14A8KFTg99qweJm5R8h1FML8I6LWfwbvZ3zmYSqhQ1rAfVuM6PdpVZ8xDmf6rysUVrtyxodvfF7RmDO0tBOui/sIN5i50NJffJBh+9UzNpWL7wFYugZ7+SjZmws4aTAwcZtwpDeov6lHmeDdI77Uxrh3HYK2WIQCHCgi9TtwPK7WJ9mfuF2o61FDyvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6gILYSn/FhWpoGyL0W1HAez7rHwq3dZjIjLkEcwNlM=;
 b=XMUp2uvrXJIiuoKIplyBINYCqu0gJAxOxxkfHL8KM6DiC1pEZuYvLrRYlRF3DTMJIywmFrjDkmLMSqOepKLioWy4mWtT70V3DYW4ngdFaB99vnX4fcdNr+h/7vRMEnx5nN37XnPMzpoB4eIVdsMS2hSoPDNgOV9Iw5YNvxusEpxVaM+BLwL1c1Y0xj95vf5I7xhZKHCfhvka3LPbMUum8GouCb+KqZGwBx2QGa2h3cbV32O9bteErULQuUXfzdRhhL5jCr/dMVbarCHgzYDL1Kf4Oic1Es2VUiswzho7TuZ8Z+9FkTEukAv8isUjbfi12UenOEUKV9th8IbaJD/zJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6gILYSn/FhWpoGyL0W1HAez7rHwq3dZjIjLkEcwNlM=;
 b=E9FzYnglDv3TsucK1XTqRuqnBduQQcaisFq251nNsvbY1Pg7bWnlADEFuKadB/SG3cc5Pd73fC6bF1Ehf0+A9lbGl8mwI5tZtfCE6A5zIHQZn4iEHISaWluJnHDBudNZpVqMn0MexZjf42kOpTSrTHupYFOwJy9fr45Cdt4QoQA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sat, 4 May
 2024 13:13:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 13:13:17 +0000
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
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>, Florin
 Pavelescu <florin.pavelescu@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
Subject: RE: [PATCH 07/18] clk: imx: pll14xx: potential integer overflow
 eliminated by casting to u64
Thread-Topic: [PATCH 07/18] clk: imx: pll14xx: potential integer overflow
 eliminated by casting to u64
Thread-Index: AQHanbvU3iJph3bBxUSOuV1ImO0GJbGG+UgAgAAUv1A=
Date: Sat, 4 May 2024 13:13:17 +0000
Message-ID:
 <DU0PR04MB941771866E735F5EC83DD46E881E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
 <20240504-imx-clk-v1-7-f7915489d58d@nxp.com>
 <20240504115828.GA3666@francesco-nb>
In-Reply-To: <20240504115828.GA3666@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8174:EE_
x-ms-office365-filtering-correlation-id: 31e05e8f-6870-458c-5da1-08dc6c3bf64e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RPROSMBcIJcorT+IYt3a1CcPJtcTLVhtJTuOk6BlOX1aMczgl7A1+bz65KCC?=
 =?us-ascii?Q?whRceFk0QfYhVwt+mQRAQE8hTs4MxBYt8Jx3JJCfKXa/tKoP4NbC7dkrvmZV?=
 =?us-ascii?Q?ZteFLomgFoT5OkjoQBaZR9xf/AAw2kl8GTCPuXWJTDhMLVMtTH1OaLgsXOsn?=
 =?us-ascii?Q?Hzkl5WT7BebxvG+q3e/pcRxTtQ0HeksxpW/Mb382X9DAQ5IYF8OZD//GKS1L?=
 =?us-ascii?Q?4DhU7kS16Gk47z72XLNn873UNpCdza7eMuDNEnCIv8hWT3M5c2rvU9dUkSFV?=
 =?us-ascii?Q?HVtDxbmrManbgGS0bSY+wOkvBU2nP6p2pOdvflzp8OmYe6Iq8ML+sf2ULmvb?=
 =?us-ascii?Q?1KXzOQHcQ8rOoHPqBP99eAGF6iQAJHdDlq1kXXOEQgMvHqRXSX6fH/go5USc?=
 =?us-ascii?Q?HaMLMZqAsXzal1e5svuhYgwmAnnWW0zJOZEZSxr1Vw5LkqMowe+D5DYxMa+P?=
 =?us-ascii?Q?g1DOF6dzBwsuuJSAJBFoZn0aWE61CxYWgc6iNp1azMJaoPeEac+OIXSvo39T?=
 =?us-ascii?Q?xU2y3v4YruLXRlAmMbZlMQ68P3DtuvHzkYrdPql52O26m4jepGGrZeDgAe/F?=
 =?us-ascii?Q?3iFJNjK8Sb3l15806Bdy1V0OvrCTPyYrC/C9PsPQsluP5ovva1LeV25cHsSw?=
 =?us-ascii?Q?PyZLOVaTTQe2SLrJIL6Rpgz3N33piCRh31bbSyL+Nnlu9Q1/NlN61A38bNLK?=
 =?us-ascii?Q?9mUXqmBDykge0GJynPwrugdE8C7x3sG+E8QoTjFZmIuLr+D9dzI8eflPVHXo?=
 =?us-ascii?Q?Hr72hLx4hI/nASdX8Ujob4P9x8f3bd+mUsLIw0rgv7Rwe1pGlxcQhmLbcrC7?=
 =?us-ascii?Q?gzBm+OWvWzGPR7se6y2DKTFyfPPiXK/93zsBobos0PcjvEVHk3XsvDxE5gG9?=
 =?us-ascii?Q?dRcCRuL5pzjSGIOy/DlJzDsN7kKzcNBTVC1yFcsBVc0jMgm8FITSlMM+/j14?=
 =?us-ascii?Q?y1OfbOfKAbytWl1IGuU/gwf6W/DIKFTh36tR9SCBU1nd5os3hToT/J5Zz7jH?=
 =?us-ascii?Q?+eUbbvSnWHV595kSJ9sMMflGw2MqPN2gnkeuCQiTA49SAPnCEqgtsJ0XskGE?=
 =?us-ascii?Q?12PNWnqRJvYa5VWYyItWrl1NG2b1vsN5QsTvPXKbYkDHW6cfeT3zuq72ldar?=
 =?us-ascii?Q?uBXU0cLonsmK2FtS2lf+cIaekHGhm7efm9+Yraxo+bJHZN9UwDh4NdWvwlKD?=
 =?us-ascii?Q?2aoa4YiXI9kHizxTAiqdXKmZHxaWPgUbRn/KQ08QkZVK72+gwaZOaq70xtiJ?=
 =?us-ascii?Q?ZmBlbApTu6FFbv2r+76WiSaugkOMrclskXxqX62oCcl5bXWbL5vqptzz0Pra?=
 =?us-ascii?Q?Xgq2C+ulYIPMfsoYCwQJcJVT8CsepqCEAk9YKVx7YItCMA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gI1d2cWOjU3BzXl8sSdSEtMu4aWOD9CvvndrKx2Wb++DhhDVI8U4tbkBMmYw?=
 =?us-ascii?Q?mExhx7AKSnRg5VpMhwL/+C+2p2Y9C1IPGFGRfD0tGW3ugprD/XwSnrPluSF5?=
 =?us-ascii?Q?rsCDKu8I6xZbFoCRdpS03w0A5T8p1+OdeCSam5F5d/tsU/z+RZfPOYdgnIuT?=
 =?us-ascii?Q?kYReGzHGzqG815PXY1QUg3dnzxkNp6BYfP69qHeJWJmt0bG0xovq8rE23ce6?=
 =?us-ascii?Q?iL3nGkVExXd0G2HK4mfpHsMsb1iB6sga/RQqhWeZCbV0wqEXZpwxI7fdoPja?=
 =?us-ascii?Q?j+I7mAKQBy0vy7Up+2fTHXzwssFSLxrzms5JZpJLMLrn5+tRhhqx3gpgfLfg?=
 =?us-ascii?Q?sggckgkbrJJzFAgxVtb/rdEFj6Du54iUXKdcxAAA0mNqDxEmzNT2D/5fXVr+?=
 =?us-ascii?Q?D0mxRjeRqtfjy3mvPyWo+SFbnkjkPV3SDv7rjkN3Di8yW5YH5Vfx0IhQKNbS?=
 =?us-ascii?Q?IFaIQNuwC9/USuhxBHu7ZPniuNOpUs4AlDsollZJZvnRHeN+bsnE+fMqiEft?=
 =?us-ascii?Q?AervDAm4Dz0zA0LYAdvzGaqiGPZejM3hVsR7bNZB559HxgJJD2GuSPpQHT+r?=
 =?us-ascii?Q?hp99yZt0GAsmSK70rAOp3L+pXYFje5SxWXiMDXWupMlXb6l6n1qd12wS9NfV?=
 =?us-ascii?Q?KYg1bYeTBruHcvoAfFeWI1Vj9ftQNmeYmzRVV4WJxnVuIyRjzWD6QyTlB3ZV?=
 =?us-ascii?Q?gNdWiwOMYq66PyUsgCQ1gJ+qEjktovZ2xjiQIDbKmNAcuddwfoBuhbxQBUWO?=
 =?us-ascii?Q?FuEVrhlo0YWkuCcoPnb09mKtJf0vIhvjWGMIV/G3aIO+ePO2yY5nFj5hA/4h?=
 =?us-ascii?Q?btzDBfHON3kIjM00wgQZcU34Sod7C33Z9u5Rv2VLfi1oXaCfCERCeUR1yMEz?=
 =?us-ascii?Q?qbcUG+i1Yivy5nitu9ylB8XISbodNc7clzZD54jMANSGezI5stik/ETppYRf?=
 =?us-ascii?Q?BzxQ6iygJ5arOlPAR2NNNxr303cdLYFHY9gVqs11XpEHKusUbkYtwCWb2Y1j?=
 =?us-ascii?Q?Juq2aLoqBwA8PfuwlQLacIJaVi76UvUMs1uFeuy2pCQ61jqdJbAeszV+M9IS?=
 =?us-ascii?Q?k/zkYCnwQzd+9NTf3pc3Lr0ATJcTqq1Mrz6kqWRSvCmg7lgf1dPsM0eGSXq1?=
 =?us-ascii?Q?jHHMUMBi4FulI7NKEqKoTdaQ9jISoVBoRdVaHL5yZmJGVJK7GFgMX6ROgoq8?=
 =?us-ascii?Q?zJCjN4QN/V+Sa8ggHVVNlUeAxEMvKMaj+E1p/QFD1VhO7A9vnf0aLu8567+U?=
 =?us-ascii?Q?6+CecB+6ZiHMAqxTeUkO3yOpL4NdMj1AYrS2oAyZTepPcQbKlEv+FIcqFEIi?=
 =?us-ascii?Q?YDG+Me35kPAfnm1QghJse+4HSME5s3dKlUSYWL9mtY9QBjYg2zHtSDZY/lwL?=
 =?us-ascii?Q?lR7MqRzjHkvpZ2Q+xRkgBW9lT7ncE9HVZuDNe5jBby+V3R409rnCVv60yONP?=
 =?us-ascii?Q?X5cu/Oabui6y7kOh9LT3rEcfPmhg49xpA/6fQYDbKHJjC+gdkCFHwiSWmHYW?=
 =?us-ascii?Q?beN/bCysHvTwTEqMICFZ85V0uShmEUBKyZRykD4aoU3IrO0WmYjGlg6kx+m2?=
 =?us-ascii?Q?nN90N+bLusNfZwCBbFM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e05e8f-6870-458c-5da1-08dc6c3bf64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2024 13:13:17.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjNP/Iok4kIX33GGQUpJx2JUDkUXqW/sJQjCezipgZ5g318Cyq4aW6fxjtB9WILhtt5DjtFk7akjCgOmGx+5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

> Subject: Re: [PATCH 07/18] clk: imx: pll14xx: potential integer overflow
> eliminated by casting to u64
>=20
> Hello Peng,
>=20
> On Sat, May 04, 2024 at 08:49:00AM +0800, Peng Fan (OSS) wrote:
> > From: Florin Pavelescu <florin.pavelescu@nxp.com>
> >
> > Cast to u64, so that multiplications and additions will be done in
> > 64-bit arithmetic (and the results will also be 64-bit) and the
> > possibility of integer overflow is eliminated.
> >
> > Fix Unintentional integer overflow reported by Coverity
>=20
> Fixes tag if this is a fix?
>=20
> It would be interesting in general if this can be trigger in real life an=
d with
> which side effects or if we are just silencing the tool

This is just to silencing the tool, maybe this patch is no needed.

Thanks,
Peng.


