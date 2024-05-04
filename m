Return-Path: <linux-kernel+bounces-168678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A38BBBFA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5817AB215E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241038394;
	Sat,  4 May 2024 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iKXwkFHZ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59D2110F;
	Sat,  4 May 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714828506; cv=fail; b=Fn2rdP/1nwMVIxjiHJODNahnnZ6x6CgX/s3DOLG+WcxvPAIDZRJmnEuBD0LnqzkTngwv3Hv604XHRBbD1+rJKuLuSYG9jUPI5vBNBkgvdHZqIbiaTCDJJOX/OYn7/91GRfgbSSCr0+heYWxAsD4csXNt51/OnZXhtHN6OA6kpnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714828506; c=relaxed/simple;
	bh=HF5YXw59jAdTaiZH/y/Uz6cJl06HC7eNo0GR6leRD0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKAbGij+GorrixyKDtVjGXZN4w737ZirT3vwqxkZrwBaHCPmHkB5EMPgNxbCqS/qyDBKYrKEUoaBZ1PCy4WZvCBA2iPWmDEwXpoTPOb8XM7tOMQ8m7Y/TIzYTsLFp45Dy4xaVZI2irn+JIm72kdqLLGno61zCIkWNwqydp8suhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iKXwkFHZ; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWnKEKx1hMwzz8oUoluPkvzK0OWX66C2aTeqjhmneglLeeuPV1N3jfGNFdSaWfIjiUSUPh6hGPt7GwnXhMWXs2feYpXJBk5l/HxfMIE0SBVdJxlkrX1Dnt2D4NJc3xJY0tTcS3nDxv05kAhx7cZp2/JLP0K+c/MQX1ktDoqiy64a/esIiuaYf8b5JnX25yv408TeRYOyzlnADLfJDcLsbQ+swyH9T31nkmjKaLqO4dPB9smckszwIX0LAMa10JrXaDx4bDwBGNcgxrYwL2lJXTNNCO8QpO6PQoDIcmb37B5U0Ov0T9DAdLqn+j5kUKd4kVQI7UzfJyDb0wNwuzBd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF5YXw59jAdTaiZH/y/Uz6cJl06HC7eNo0GR6leRD0Q=;
 b=TQlPBKVteeR2rPJJlCYQXZ/TfQpOQ+6LCEEkIX06yi3WGdNQ9K1RzfrHoIx6mOFl43vwpQSPyKtN/SW+4YWzVa9uNXeXWU+VAQeXoTJH2E0anC5eKFbXkCwDPyTHB+QjrXrITR9eFQQ7WZOB5ep+cnLCYZSh1S05AzF8J9BGL4U+OK7VXc0TNB8kYo1bGlrtpac8wibEXr29agPzeqS6XsuSpAmreRVXs3JXvNqzE0ivDdKTim9X2xsi1rTPwFvZv//PvN/vQ/LAYEOl8acJTgMsazgr8vRosq2lej4lC6Le3RfoM9rSoBdDRtxABWNXarhbiJtxUulAq+iG3rNPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF5YXw59jAdTaiZH/y/Uz6cJl06HC7eNo0GR6leRD0Q=;
 b=iKXwkFHZRJ2i4W7aLvwphPo/ntdVzGGSbWHjfw+y1J0/zNDSZWlJ4OoOBNwOvhuqNwrQbBzb2iCuMwl8yutCPg434WgmAvVTm91jgpgEhYNbyaO7ezMw/5zPjTKLK0H67a6pw0sEFpUmgKvZ4K31kUNlE+N843PSWg+pwQv1WMQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sat, 4 May
 2024 13:15:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 13:15:02 +0000
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
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: RE: [PATCH 10/18] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux
 for i.MX7D
Thread-Topic: [PATCH 10/18] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux
 for i.MX7D
Thread-Index: AQHanbveZhJbbEOK1EWGUWEQAnsbdLGG+hoAgAAUHOA=
Date: Sat, 4 May 2024 13:15:02 +0000
Message-ID:
 <DU0PR04MB9417404E8E89CB82386146B6881E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
 <20240504-imx-clk-v1-10-f7915489d58d@nxp.com>
 <20240504120124.GC3666@francesco-nb>
In-Reply-To: <20240504120124.GC3666@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8633:EE_
x-ms-office365-filtering-correlation-id: d754d5a5-dd01-4ef0-fe99-08dc6c3c350c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RzXR9SJZGAZ/ZIq3KYl7l5rUlVqx3m2ndW4QAO45pv9acciVzsnJJ9EirGdQ?=
 =?us-ascii?Q?vwef8JO+jvR8sgpuYQIAFed75YQHsn/XuqQ4pNxRgIQ2F3k/wZoE3ssoviWw?=
 =?us-ascii?Q?lwsj1ARgamMglMKyrG2vqiB1sPQtvEO2wezAHtiKnTpB8wqLG1483xT7mQ+H?=
 =?us-ascii?Q?oOWvxTsYU5rsFQClrdBnw/YrvGvkfXO1Wzk3sk+0Rwy4J9y50fBsHlSxBI7R?=
 =?us-ascii?Q?Z2vLoymhVQ9OuCHPM9YZ753RAweWUmjUToTUw/bFKvQu5wmha8DzU+6TTaJg?=
 =?us-ascii?Q?0LTDOtpC5yJ2JsPWirZqMl3k6dl4iOBQsqxg0rLBIu9FzlL0CPone+N9ZbNp?=
 =?us-ascii?Q?do6lo/fGXSwhTF7K3ZmdpV1GyDyUUikfh1lE/01yp2S5aGqQ+WIZK1Mg6/HR?=
 =?us-ascii?Q?zrcV2Dqo3nDTiTXbm70DJJw2yVh/zsLWO7leMkes3UK4xvK7qjt6yYchWWM0?=
 =?us-ascii?Q?jELCvxQG1TiTWNz4Hk0C11aFgP54WZp/XVPDWkdoqnTP0hgjUNnEt8ZmTLPo?=
 =?us-ascii?Q?/zyf/KlrP5UwkSSpLhjYc063JZygmf3D+FNdlhtyJY81zHSPYxH8zPit40Ag?=
 =?us-ascii?Q?Wb3FNM3T2HnHfr+oClT75ge0YICDmj29vieGSxDC8D0v3Ceijy2VdpF9lNru?=
 =?us-ascii?Q?aAKZ50y6ESw95Mw26MwRlq31XYovsNKHWIfg6My+qX0GV9KI2WK2D3kEjlI8?=
 =?us-ascii?Q?QacT4kugwOBhUvosxgNQQ7caGQf8zY/h0vbHKm/drFYTueUx46fMCWlYHLDt?=
 =?us-ascii?Q?4VysOsIJ2MjlkysrevqTI/cm0kyJPh7NUeDB3UH62tb0KPEpAIn9P52DT3pp?=
 =?us-ascii?Q?N86UltPWnjKnlw2w27FKPHhfdcYDTRwHs02XiFYZOvL2D/vw4/qg1jYzceDP?=
 =?us-ascii?Q?hU4LacImkNEOjwxyyIArS012pL0JT6PKD2kLw2SwFtNl4ZuJ8YrGeLhmt7nL?=
 =?us-ascii?Q?tquVPXsuugSA4V8kD+XGDK+epN7EAcIKZS9IYzsgxn0C3wzO5BsbMcEed+y2?=
 =?us-ascii?Q?+/r1a9hAeYf56yNybypyGTmr5PMA1ZI0QN8QR5okv+laq4THc8t+7nWoP7pM?=
 =?us-ascii?Q?JW81kDj/lw4Tls2t3iHDXpoRB/aMyUbzFza5e6Bt9QueK5kW8ehJqWgz4FaT?=
 =?us-ascii?Q?GlUpdPfryyqx0S9n9jCGXmoNoo+vlg4r2GjjnFFriSnFh90ObELEEO/Zi5q4?=
 =?us-ascii?Q?GlZaagn4N9EndfX5rj+eT+Lgp5J73nkv80a/v5/NAuphU46Xu0cLCv8mx/U6?=
 =?us-ascii?Q?2v7o3kCqTIk2CP6++VFgaSX4KHigQpc1bnAffj1Zf3MtlXcSQbbQTG7IfC0v?=
 =?us-ascii?Q?q8GIxgTtDrQLemWiyhZseiHinKnNKQoDYJ+zWnmGxZ2KOg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s0yKX9uaiS3l1UMuQdSD33yd2waEYDzVKr+dhklLdGA7X4XnoS2KSm2BJ/8/?=
 =?us-ascii?Q?nro1x/wZSk+j2gnRqwI+Pqfy3s6t51Fp31c1IqZc8BvnUSBaliJBEahcc4Ek?=
 =?us-ascii?Q?Jw+EWKK9uNYDvh0Sr/g+Tn+HHqVwLl/Jrt/0LbkOh0a4ohx7SqZ4QtrZlomT?=
 =?us-ascii?Q?P+xMoyRl/CU1Mw+RqyH3r29G6BBPL4b63pjikLCFFhvyHH6yyuwagOqHD5kc?=
 =?us-ascii?Q?GGJ6tzhKHdPBomNdv4Rio46nrWZG3Ij3l6lVsuecV/Byb4FCD8XSdIpbtfuQ?=
 =?us-ascii?Q?G1hEKDBgcEvE3353ko3sPnXI2j9kav13GfHHHq9V3ru1qG8fAlfsSZRvBv68?=
 =?us-ascii?Q?x/6UnRUfEZHAQZstrExFfJCoWHzb5tCPF6Wnu+tYNI3/ChOouVc+nzvk96yC?=
 =?us-ascii?Q?Sv3o33hgUJoYPUgpi3lFBqw5WWxOT5yUvlUaH542+1zOO3EIGPLNz49/Dqpz?=
 =?us-ascii?Q?nE6djp065yT4PA9y3TQpY45Cle4ABE9cvPRzm0Bh6INeD50pucEMY2aj5MYL?=
 =?us-ascii?Q?we/jt/I6VwlD3kRQUv3zNVTMfu6g7+y/sSPJ0gERX0csRrtJk28nd3WvJsyS?=
 =?us-ascii?Q?eE8ugXdDqgvBCqNACc6OiR3AwBwIjRDPtTHMXbGQGy40S7mRibnUy7Ly1Kp6?=
 =?us-ascii?Q?5H84J+PganDZnHDYOOJpdWmrYrDsPgPLS0KkFcxLYwQTxm7pikdyufUPSGK/?=
 =?us-ascii?Q?PSzFK6nRG7onAkwoDsNoydXySdlOcDX8ky37troWyXjNtfi4ATavZhylUI4i?=
 =?us-ascii?Q?39mgtltUMoR0a0Ueu2LIZG6nO3c4pgOY2aAUFCt2n+ngXwa38FkJfvbl4X1N?=
 =?us-ascii?Q?1wUHdr/9x3IPpXIBpx6F0Y2/diHI1OFH5KyliEg55XQsDfloNMDk0aoSq5O1?=
 =?us-ascii?Q?2IiXKWbMY4kmGBNzLVUlTNqwMdurlJXuNO7zdJYoJQq21CeXxeiuxVkLTGO0?=
 =?us-ascii?Q?Lrfy8Ei8PT3lVBX+pzl1YpJdzBnX6ZuEchQpvxeAwnOJAnq8agATBoCfhsCx?=
 =?us-ascii?Q?SpmEZi3pkkANLQtVAyZKkZVI9wt2N6Qw5Y0SGQDiOCwbdRvt875G0Dcr+uWO?=
 =?us-ascii?Q?0JJiWzemfFwAbpTwwT9wbDmT78N8vGXKIcSU+dllCa5LBR9G5DiOYmK3ZgZD?=
 =?us-ascii?Q?QsLQRKQhKIGHf6Ax2DGH9o4CskWnc9nYeQz8EevvBUuLMQ1i8arbo8MSRDJ0?=
 =?us-ascii?Q?h+O8EIMsqxG/WIk5wo/Y6TrdrAQVJRrvnWxGfQ5+aig7Zy+PojLPRQ1H4A8u?=
 =?us-ascii?Q?AwK1AmCqFDR6tDE1nJtq0SPm3UWlqD16g5+rYy62CPn9mqIAdD+0yelQT5tg?=
 =?us-ascii?Q?efh3lJjSiZhHBr6RhSh7nIu1BEqqY0tGgTwC41JYXjxrfQJIfEXkExwQEvmh?=
 =?us-ascii?Q?1tsIwLTZlKykb/pvijmlWT3Mf2RWr7cL4HcyntKVYfdNXZ4oBzOjbxe6Jzzn?=
 =?us-ascii?Q?RYsk6qU+dFX8Xz+BgngjL+KmURZ1+KPdg/BlKHukpeVP96QO0uu6s4RYtlHy?=
 =?us-ascii?Q?T7wWoVGH3Ute+8SeMpzd2dwt+tjnKJTbYTCJ9Fj//fHwRGFmNXOTcdC3kmMl?=
 =?us-ascii?Q?HMghEhh5KDvqY/p/cDs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d754d5a5-dd01-4ef0-fe99-08dc6c3c350c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2024 13:15:02.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlQyCecqBy9CWMZ+gEvx5kwOSrPDLJ0mY1TQwO6KVyrCdA4kgJ8SZSEeuSODM4G8RAB/VWWMisqURYJL1vhQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633

> Subject: Re: [PATCH 10/18] clk: imx: Remove CLK_SET_PARENT_GATE for
> DRAM mux for i.MX7D
>=20
> Hello Peng,
>=20
> On Sat, May 04, 2024 at 08:49:03AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > For i.MX7D DRAM related mux clock, the clock source change should ONLY
> > be done done in low level asm code without accessing DRAM, and then
> > calling clk API to sync the HW clock status with clk tree, it should
> > never touch real clock source switch via clk API, so
> > CLK_SET_PARENT_GATE flag should NOT be added, otherwise, DRAM's clock
> > parent will be disabled when DRAM is active, and system will hang.
>=20
> From the description this is solving a system hang, but no fixes tag nor =
cc
> stable.

Not add fixes tab, because current upstream kernel not support DRAM freq
update for 7D, so the issue will not happen in upstream kernel. But in case
in future DRAM freq change needs change..
>=20
> Francesco


