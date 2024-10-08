Return-Path: <linux-kernel+bounces-354830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916D994319
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6489E28C5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275C176FA7;
	Tue,  8 Oct 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l24ZsXuD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D514EC59;
	Tue,  8 Oct 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377492; cv=fail; b=S5koLs8x2m8GBEss/QxoUQVCmZhEPFExXfsB81NZ+B1SPq7nLYyd2j58duFWzL/BIzhqOTbwYw25xyOo646wViQWZQSwv1mwR8mjPBDENPAXwLudHEpRmi/DFatdW5MDMuJJikGXcaGTK7b1XJOGV8C/scideP3sMR7eYm8hA8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377492; c=relaxed/simple;
	bh=zGii0WUgdmoLZCwKp74eLykt/ptWItlaB7ifJQ/m3fI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A+y+zQv0FRLIObo1LxM8PUUcT4p2iyocSaVjLQ0SxInNWi7Oof0qGiyTPd2SpWXx4qu+JoYq2yx4DE6e9l3bJOIqPG1qy+LfiZqCHGsQEGiMf9JbudslCBoxEoORce5sBRHIquu7fdpmeoQaY6uPxHzFhjh/RpOe1ycU8UO0Lmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l24ZsXuD; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlzecKZ9a3WyNlt/eMAvjYPm12SxEGWvsHZAmPqkjwiPpN2QV3I0yhQdGivG3nAhYtCaZHYooNLu5wHMKnXD8o6gGW8RagEZ6OAkfyeQFf3h2+6ZbAVNGlRehPyoN41GMV2UmPtzWkc4IlT/eQ/kK7BGapXmRP4T9p4sVGa6YPCOKf0u/yoitcIgXdWcP/LsIJxO/oG4XM2HlNxsFVN9XtO2qeIXv1NQNEEeK3+mdp59IYttR5/rIK131OduZc77/Deu+7TKGBV2nc5n7nz+LtLcq+rcFUTDTm3z0alKJXnh2rzl9mYJ0a8HFEkPR23565mm4nJKDYrI01TTBTa9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/PibI1HR2O5IGNxjOP+bVHqnohBXBIp+ueZCqz2yUg=;
 b=bG7DN6VaUQIYMizKP5nvl4Js9AkpVpghGx1uVVx0krdjMFkZq5t56+prEDcxMQJ/hdyjInZXYVZkSDiFOZYH8LHsdigGI3tso37qSym0hF6OMnBMBwgqVSMLweKUMlb3kXJbhOF2xvhUpSxhnCGQ2ilronI+XE0ge7cYJDbSz9BRgY8tkGcmpb0RfnblP+1SkyPw0tcefLbanB0Jgjz5Gi1he+K3z8BY/ynXz8g0U1BTvb0Ic+BeAGMtQYPDr6KHhKside+zWsaqPWyNaMkFo5AWCb05YI0nmKOrmszn6y5LFl29F/NKjBuC/1JXaBDnqtSCkwqiIVxZDI39fLfBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/PibI1HR2O5IGNxjOP+bVHqnohBXBIp+ueZCqz2yUg=;
 b=l24ZsXuD3zW8pUIfumCPHclCL0k3Z6emutH7SOKwzbuhPNWyj+1jTEtgWweEpzDu4SreveY/Iairt9NkFtq0QXg5Cfs59c7kqjaMntSpOMxIWOQD3DJTqEEyBHu/7giqxL/SN4AKc/uSvyJUF0RfaElJ2c50gua6So+PW3gtkcr5pSTUX4qV5xnR2+1iK7O0ZmEalxIQh5DwQtAOONm+3WXjoayIbIGCLX544AYFKVMlOHvPiw+RZIKDKd8Essc1W4k74eMe5Thzn8TS41zf9yGJevq3SRBstXfR+WU74Bi5W/SnY3Sr+z8xDkmrs1EUKHFlkEbbJx5W6sO/JRkkyg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10656.eurprd04.prod.outlook.com (2603:10a6:150:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:51:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:51:26 +0000
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
Thread-Index: AQHbGLx4kfLbSUcjVEme+BTq/dAog7J8i89QgAABBUA=
Date: Tue, 8 Oct 2024 08:51:26 +0000
Message-ID:
 <PAXPR04MB845980EE67F1B99C9AC9D0DF887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241007132555.GA53279@francesco-nb>
 <PAXPR04MB84596824B2DFDF20E005F173887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB84596824B2DFDF20E005F173887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10656:EE_
x-ms-office365-filtering-correlation-id: d702e755-051d-41f9-dc20-08dce7766527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UjbL9DhB3UomAhM10hClW1Cy49iTKwB95B4zTw4Tpn+7nQcxn5ZLqlu7cAaz?=
 =?us-ascii?Q?VFlBaIW7MpCuegLa/VOFnSCAElgAF+OcMmEFNYnb2ajDKXFWnsvWZqnUrHEl?=
 =?us-ascii?Q?ApAF/ntPNhH6YSErItGaPPaiC6k2FAlsEHWC5iG8rsVp7OwTd4Hd36+5VfJS?=
 =?us-ascii?Q?PabBW/7QFLHAo8ibnevpWR4tPWdFx3Hk/591xgcmUSpC+8tkNjQgjApaDDzc?=
 =?us-ascii?Q?QSFjbIIIn8MDLcD0CLivyxWLDss8y5ldcNgcbcmUPZm+H8WDF9/R199wszdy?=
 =?us-ascii?Q?5fPTnjH83yzDNsqCqT1jip2Wk5IwwIWhd5PUfGTmjxftarWAyAKjqNNVsMIL?=
 =?us-ascii?Q?p0X77bp0VrxUOLwDMc5FnVnsYf0Nu7wuaLWlWOYdcsO5n/oKuulpVBwBZpKP?=
 =?us-ascii?Q?s3jXEX3j5+UU57zs+pAQ/hpwTsBi2nPL56Eg8WRKgv0dHgGllIDLGfl3BdR4?=
 =?us-ascii?Q?5wsAvATG4F0D2sU+y6VEB1rtiYr9jAS5spA8MpPdvRDgwwGeO8/sZ9mpBA7F?=
 =?us-ascii?Q?lANPSR2Dfs8Gn4awswTj/Gk4/Iifo2MkoFV6cMoFz4vy9/7f11fpAVOODMbF?=
 =?us-ascii?Q?NiI1aX3XbgIWLNv/fKCTiKNRT7xhZtDuoaE7zB0NDXWUIq/HolIIautE5ObJ?=
 =?us-ascii?Q?aNpHobFJ7V6qFWOxX9k5VTWBaemxhVAWpxLFtT3/1Z0D+qjszJMpgyIu5NDT?=
 =?us-ascii?Q?99ZYGdDDsCCxDPLsYA1kkjNwpkNYWYuTnYhRDa9LbD7apYcvAuhYLq/4xcFu?=
 =?us-ascii?Q?/a/SwXIhb+6Zgf8BzVErmMaHVkiLf4LvB2lB0LJr1rXph654Hl1kVpTzqJfU?=
 =?us-ascii?Q?O+7dT/BA3lyRQYHaSF6E72XlHtb2knzW56zIgRksvGkNhrBKeyjrEHWPORwT?=
 =?us-ascii?Q?v0ousvLiLvaNhPOcK5M0kU0Y3W/FeZwlDxZDEajFxQsUWmn2ncrjT9Tt7pGA?=
 =?us-ascii?Q?7BsH2/8UB+caw7jEYgi/ntrAf1ZjO9Ql9TH440ZYKy3nUhtWdkIrgPIMc7j2?=
 =?us-ascii?Q?Ax9GTXpMsz6c73z3NgKHLdH5MZDILUYYGt7R1aeGolvnhIx5n+2lu5dZYLoU?=
 =?us-ascii?Q?DCUoCRNhO2hb29+QnJcmX4nV1GoilsJfvJ0bacSriRbiXG5uPHLhZ77+tBgo?=
 =?us-ascii?Q?ahAp9+AghBO4NdH4CLPD2iI5WL446fXsjoPiZwgLmvteIkEaGazqstcavt6q?=
 =?us-ascii?Q?e1XCKGJi2x7ZdDtWRg6H8lNby2mOsQluf9B+KzvUYp31UMKhBeR/8FlmUqI6?=
 =?us-ascii?Q?KwOC2j0dfCdNe1lAS8zy9brAWKgx9dJfF89UpE1ZJmGzgkoftHMuu4LNLKW8?=
 =?us-ascii?Q?DQHkjNmm9iekLi0oJFojykrNmNv+yB4aLoYud6EOGaozkvq2c5/xuGFJFphM?=
 =?us-ascii?Q?mGviLVE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9t5fZo5wzZ4MbtG7IdGHSZJlsGhZhSklduKZ7XEsN+KLuSKn/0besm5UBxRs?=
 =?us-ascii?Q?/qu4JLOJAQq3H3g+gik/Sb1mTHII6cxo3yOFKcmX0EfymW08FC9/i7sBy4Xi?=
 =?us-ascii?Q?C3NArNelB8KQBpHLKYPUek794T2XzJC2rqJWYxdYP9wMPllLBltdWETz2NCN?=
 =?us-ascii?Q?P0z+4ftSa4byVBUy8DM+uS0Gxd3Y5rSfEPi/8b6z81GiolMslHYzyVrBH2jD?=
 =?us-ascii?Q?zQppryGFfhpz8H1F+hDxUCoN9hEoBEr8KXUdVjQ+KX+/o2T/JbDdI1S5DfxN?=
 =?us-ascii?Q?GAfXaSLIASEhJWBVQKdw9JP+Ytx9HkjIoY9Os8sy6W3gjtMvEZLzO2lKQn4m?=
 =?us-ascii?Q?oIFrFMFFQCk0FWS5uGltuIDoz5tTvFQxEgDgjFhrTO9gvC4tS6e9MTNmSssk?=
 =?us-ascii?Q?rKwLlNwSRoAzSZ6r+4Nbjcs+4+dBwNDyVfq08hKbrM5E9o1dmtKZV/TTNosl?=
 =?us-ascii?Q?BKgdkYyN7waC1K6SLJCDmno/xlwOqriSVOl34/ynQB7+UvPsOKgZEbz0Rvwb?=
 =?us-ascii?Q?xscFw70bjBbkq+HBNgI0AhWAo1DHyNLiDi3qo3L7K+a5MfaIJj+cR1ITCnrk?=
 =?us-ascii?Q?0dWxY8+9KAhSoLkZv+gupkFdDE9jcVTt830h6SljRQk6O+uMxJkYLFqhDN6s?=
 =?us-ascii?Q?P+5VMq/b4xuoHgvSJKoPKM5aPjqtDUuySnvD+fDutSsNNKkwFxa6Qlks9CQK?=
 =?us-ascii?Q?aUWyccYlVVLro+og2P1gszSPmvJmjNcKuqqsHcYKgXKbZh9CDeKoiuwvhHD6?=
 =?us-ascii?Q?cxFZs1byCAZ3xq0yOr3K+g0BBopZrGORXdFOstQ7X/Ce7/SLXPh+ZJahjuEh?=
 =?us-ascii?Q?K1RQrHN5pfgZwy7lSz3fsgYGW0WnpS8s3o0N9Xvn2KeLk/xCrQ1jsN0m+tPK?=
 =?us-ascii?Q?itfH9QL1N6WHmEUMXplw0LYhb+4lVwV5uA5T2y6BYKC7azJVgwqkWJNsqh+4?=
 =?us-ascii?Q?QwGrzz7t65DyX2ar4/0aANz0i8rUVfWQfctSMvHhHdFE5YCs+hKkrFBd9TfC?=
 =?us-ascii?Q?8K1qJzbI3h52P9av0xqfjeCXlWExG6IIt29v/i/nIMjfUqfRiTTu7LsNLkNf?=
 =?us-ascii?Q?w0kKjjlpjOPIy7YBYFoiNs+YPqWrMg5P/7Ir/NJX4F98k82+uCSfGO8d6cyA?=
 =?us-ascii?Q?+HVX2mBNm6H+m834XXMjQ9UJU64LfARBWo5TjiQfKCr/9j+dwCSSVGuSJSPj?=
 =?us-ascii?Q?dPVd91O8fMprPQ+irQt8f6gW4gRFTQKgIm3NO3oh6DDpVc7YZH5tfVj5uY4v?=
 =?us-ascii?Q?3KfX54UphdXnK49GraDG5GlILbALV7Bubrs/kiaioE5davMMKaFAd2gj+DlA?=
 =?us-ascii?Q?E+VzXUWjOwUv8Td24l+jxcl1pJp2rvzPwD4kqtAjhNf1xzAYu32vKE2azFdO?=
 =?us-ascii?Q?JSaR+ahv5GjuMN8nzV1rz0rATm1GYUGvf9+7cy1F0aEJsT4MwZqjgwf4YywL?=
 =?us-ascii?Q?TBcJQaXO4qzhIOMVtMbth1XmHFlh9u5npcxPtBAzQQ6oW7KabfEE2mwP1g3W?=
 =?us-ascii?Q?YetZs1az6TPytMboqPCZ8IDquFeymY/vWOzFlB4MjbEyglTmWkXVCVD4mgN1?=
 =?us-ascii?Q?oheeXMHasGW+BGULpIs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d702e755-051d-41f9-dc20-08dce7766527
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 08:51:26.8471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xveGnc5CWVCT7Zee5Wb0jfCmIeg/R/9840B+JEizEDzBwLnJPSy71jHx3kqmCtRo2oorSL4tJfElDXonE+3FWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10656

> Subject: RE: clk_imx8mp_audiomix_runtime_resume Kernel panic
> regression on v6.12
>=20
> > Subject: clk_imx8mp_audiomix_runtime_resume Kernel panic
> regression on
> > v6.12
> >
> >
> > Is it now back?
>=20
> With tag: next-20240930, I need see this issue on i.MX8MP-EVK board.

Sorry, typo. I not see issue on my board.

Regards,
Peng.

>=20
> Regards,
> Peng.
>=20
> >
> > [    4.012850] SError Interrupt on CPU2, code 0x00000000bf000002 -
> -
> > SError
> > [    4.012862] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
> tainted
> > 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> > [    4.012869] Hardware name: Toradex Verdin iMX8M Plus WB on
> > Dahlia Board (DT)
> > [    4.012872] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -
> SSBS
> > BTYPE=3D--)
> > [    4.012877] pc :
> clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> > [    4.012891] lr : pm_generic_runtime_resume+0x2c/0x44
> > [    4.012897] sp : ffff8000821cb740
> > [    4.012899] x29: ffff8000821cb740 x28: ffff8000793c48d8 x27:
> > ffff8000793c48c0
> > [    4.012908] x26: ffff0000c0ec90f4 x25: 0000000000000000 x24:
> > 0000000000000000
> > [    4.012916] x23: 0000000000000000 x22: ffff0000c1bef180 x21:
> > 0000000000000000
> > [    4.012923] x20: ffff0000c0a73000 x19: ffff0000c0ecbc10 x18:
> > ffffffffffffffff
> > [    4.012930] x17: 3030303064623033 x16: 2f7375622e303030 x15:
> > 756e285472656c6c
> > [    4.012937] x14: ffff800081267458 x13: 6d692c6c73664361 x12:
> > 0000000000000000
> > [    4.012944] x11: 00353333333d4d55 x10: ffff8000818020ae x9 :
> > 0000000000000008
> > [    4.012951] x8 : 0000000000000008 x7 : 0000000000000000 x6 :
> > ffff0000c5bf2080
> > [    4.012958] x5 : ffff800081f10000 x4 : ffff800080c182e8 x3 :
> > ffff0000c0ee7088
> > [    4.012965] x2 : 0000000000000000 x1 : 0000000000000004 x0 :
> > ffff800081f10300
> > [    4.012973] Kernel panic - not syncing: Asynchronous SError
> Interrupt
> > [    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
> tainted
> > 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
> > [    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on
> > Dahlia Board (DT)
> > [    4.012985] Call trace:
> > [    4.012988]  dump_backtrace+0xd0/0x120
> > [    4.012998]  show_stack+0x18/0x24
> > [    4.013005]  dump_stack_lvl+0x60/0x80
> > [    4.013013]  dump_stack+0x18/0x24
> > [    4.013019]  panic+0x168/0x350
> > [    4.013025]  add_taint+0x0/0xbc
> > [    4.013029]  arm64_serror_panic+0x64/0x70
> > [    4.013034]  do_serror+0x3c/0x70
> > [    4.013039]  el1h_64_error_handler+0x30/0x54
> > [    4.013046]  el1h_64_error+0x64/0x68
> > [    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
> > [    4.013059]  __genpd_runtime_resume+0x30/0x80
> > [    4.013066]  genpd_runtime_resume+0x114/0x29c
> > [    4.013073]  __rpm_callback+0x48/0x1e0
> > [    4.013079]  rpm_callback+0x68/0x80
> > [    4.013084]  rpm_resume+0x3bc/0x6a0
> > [    4.013089]  __pm_runtime_resume+0x50/0x9c
> > [    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
> > [    4.013101]  __driver_probe_device+0x4c/0x14c
> > [    4.013108]  driver_probe_device+0x3c/0x120
> > [    4.013114]  __driver_attach+0xc4/0x200
> > [    4.013119]  bus_for_each_dev+0x7c/0xe0
> > [    4.013125]  driver_attach+0x24/0x30
> > [    4.013130]  bus_add_driver+0x110/0x240
> > [    4.013135]  driver_register+0x68/0x124
> > [    4.013142]  __platform_driver_register+0x24/0x30
> > [    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
> > [    4.013163]  do_one_initcall+0x60/0x1e0
> > [    4.013168]  do_init_module+0x5c/0x21c
> > [    4.013175]  load_module+0x1a98/0x205c
> > [    4.013181]  init_module_from_file+0x88/0xd4
> > [    4.013187]  __arm64_sys_finit_module+0x258/0x350
> > [    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
> > [    4.013202]  do_el0_svc+0xa8/0xe0
> > [    4.013208]  el0_svc+0x3c/0x140
> > [    4.013215]  el0t_64_sync_handler+0x120/0x12c
> > [    4.013222]  el0t_64_sync+0x190/0x194
> > [    4.013228] SMP: stopping secondary CPUs
> > [    4.013237] Kernel Offset: disabled
> > [    4.013239] CPU features: 0x00,00000000,00200000,4200420b
> > [    4.013243] Memory Limit: none
> > [    4.316721] ---[ end Kernel panic - not syncing: Asynchronous SError
> > Interrupt ]---
> >
> >
> > Francesco


