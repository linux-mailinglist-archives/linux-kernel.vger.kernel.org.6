Return-Path: <linux-kernel+bounces-188196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D88CDF12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B95B20DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715F8BF3;
	Fri, 24 May 2024 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RKcgIgQM"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD16116;
	Fri, 24 May 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512763; cv=fail; b=YXTWJ7kYA0LUZXY/7heKscIJg4C/nL5pjsL8N8i5b+PidF9OVgWbMfMc3ANkVCaFZZyECkJRzx8t4ePwttunm3LSxJsM4lDfwkBukPyvm9PO6GD+EfuKIC0hQrTZfJN0tPXNVBUqolenPHfeFmusFI9B4iPueYe14mK+G6aL1jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512763; c=relaxed/simple;
	bh=f2OUotSbRZxBU/62t5KXd6Uhy1mZcCieaTg1f2r53qs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LG3cb+uD+Dh9E4CuuyPsZdIoMLw0oIeCQ81LeAn/9sAoU+NlVVtZd7KMASpj8nBB4tXvWHFtSUB2LSfpjAJmE1M08dZ4I+MkBwd/8fqLgrak2NytGI/rOae7xJFJsuc7riL1I8BeGFVY6V0Rk5Xnpcesy6+uiUSBxvtc+7ALZ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RKcgIgQM; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwycXW0dAYI+rNFSfjnC26A5ZV9vR908o7di1CbfqJJnWPfq9uzzlzbmQyUhUTXIsNeBmeJNJ6Dy3+4ieRyE6BkPbBKqQIqffJXo4y2yaL4swrY2fGO71z5MwbIi1mpMbdnnfl/xIcHk50etdnbhPqAqYcUKIWBTpZwM3bBbBKt7vn561ezABRnemrCkqdz+2PlyqoOaPBsIPdJiQ+8YlKNujbzFYZTMoWQV5GEFZT9AZF9PNsqMkLfcnWe74c1Q/k3M79rp9lq0hEmEAL2wIaUu0bKk3r1eCXmKVKAD3pK3aj90HzIx/1Mp3k8BJQzd0dfMMOGhULVuGOiP2607ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2OUotSbRZxBU/62t5KXd6Uhy1mZcCieaTg1f2r53qs=;
 b=Nlo3zwTTo9b4BMwn0EppUjSlpWXaMAOa2ahbRn81uVxO/oL+WdpdPtULcp8x3ZrIPmqUUiJ+iX0w6xcSQqJwDVwtAJ/haXMxVquIW3lAHvLAGJUG6McBXO9bTaDBmZWJsAU+ZLcjpEUcW/3zcJ1uf4CMJK0zNG2bY29LizcKBsfGNndu0tgpagds1jpeWu0d8osqpDlTewcstXRRl06Xf0I5FVijUXMkrSy8Cpf5+gJg2/SSubb2GELl+iJRHZcmMCq8bNhGhHosOFzDGIWzflDLCQ3YDer6Q5HOa7XpoqrMH9vU/Y/AgrGQHOPB0WVp+i08+wPL/4XDkWyFBr5yZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2OUotSbRZxBU/62t5KXd6Uhy1mZcCieaTg1f2r53qs=;
 b=RKcgIgQM9eOANQaXaIZh/4MgVQFgCGDXQLEAlm1SD8kzjGMX7MmVyz/x2RQOWs5BH1cjm0NkMdf8Nl8IzUOrQYj8+j2R8q1lLOFMVbMaIH97nZ67uQH3GyFQDslQnvaWLvy85SKNI58pP4RhpM+IhNq0GhplU3LkMreWBd8jNyg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 01:05:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 01:05:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"marex@denx.de" <marex@denx.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: RE: [PATCH v5 5/5] clk: imx: clk-audiomix: Corrent parent clock for
 earc_phy and audpll
Thread-Topic: [PATCH v5 5/5] clk: imx: clk-audiomix: Corrent parent clock for
 earc_phy and audpll
Thread-Index: AQHarPrLZnzBc9Ib/0SIM6sQKPG/EbGlkv3Q
Date: Fri, 24 May 2024 01:05:57 +0000
Message-ID:
 <DU0PR04MB941766059B38CCD517FDD27F88F52@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
 <1716458390-20120-6-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1716458390-20120-6-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9786:EE_
x-ms-office365-filtering-correlation-id: 6f03d177-7a0b-4f90-8e49-08dc7b8dab45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WXHwVrHaYCKAxrrc1bhUbWkXco+zclVuF7JtnZR+mC5v4mTDjzurNEmSPBMV?=
 =?us-ascii?Q?KwEM1a7vqrXDHA+hubac1rOszhCaYHfjiSII6h/MpxpqXNXYoE4G54sccn8V?=
 =?us-ascii?Q?5ymPNsS1sDRVMfZjwP2Vy4UoDJy38P35vHsoeJXSIPmXSew+Sxk/bABwAEok?=
 =?us-ascii?Q?iK+0XHjsPxn341HW9HrAH9HD0dhDzZfT0BZ9KEVEpHp4rLe6lPjrxX/Wd22/?=
 =?us-ascii?Q?TjsFbOHr15Ob6qAu6WRFiB3BXil7E2lr6vOs5zG7SJ3BlvUyrnt0vBaPYCJ7?=
 =?us-ascii?Q?7KgKkoZ4+aMDZ0rwKZgh2OIcCTO+C/lNixDQ9gWlOuPGslxsyMKK9u7vfpiQ?=
 =?us-ascii?Q?R1svj+iYWZPDffNKJxy6pj/TRoSkRhC9T/e4pyei5k95WMZt9l2btbQSno/W?=
 =?us-ascii?Q?A64xxYgCz8pVINI8kzjHiDTKwIVNirXallf4Xb52j7mhH/tax6FnK+ilY/AY?=
 =?us-ascii?Q?M6R/Olp+Bd+a5aUNf0DFVVYj9FdDas3zUady0hiSujG0M3R5IJV1SZyKkb27?=
 =?us-ascii?Q?UiucsLGnX4xWz4nosnslppB4lG9gfZJGUpmz3XByK3oMOZFDWqtaW3JF6y7J?=
 =?us-ascii?Q?La9HK6WwvfxfHzfWMqey++Hn3N+EcsmSrpLl8E1yvpvI+84SqcRD53I/oZeX?=
 =?us-ascii?Q?q8TSMoadNYylx6wVqCcD7ql0HqJjV3kPxjKUar4ileHWdxAFhxv7HIKUfrOS?=
 =?us-ascii?Q?UNnAOhlHrhfRixrdahPfgT7OmM3QDbkdtU5D8N7G1rB+foZTrg/rkXl9UMKs?=
 =?us-ascii?Q?G8AJTTb90Yfe5TmCeVgZtS5Rluh86b0PmNsT6MWbb+FiVV1Jr5w22y/hoYGS?=
 =?us-ascii?Q?uK3y/z809ocve6IoL09mBy+XeDEl60LQcfHVTub+9xFqRBRMjC8BOzb1Fprs?=
 =?us-ascii?Q?MdvKCSTyp1sehJz6TJ05CJA3UEwX8FSKkoDQXVoPrqlvX4g0zbAG63SSyOg+?=
 =?us-ascii?Q?C9mDqC0EJuu8U0lk1XiyQbA1T8/pCCQkDEi+NsGFzbOOpIe0OCtTOvA1aL82?=
 =?us-ascii?Q?GtFDUPPXCYU3Edr8dO9yHnE4D1lm9yF+TmKYknDF0BD3wCbrC0mtAxMY82f6?=
 =?us-ascii?Q?hEFYlB03wt+roY+aTCFPtaQiTXjPhAwfLUTNp55TK1pu8G++1NEcHMSaUo6u?=
 =?us-ascii?Q?gt7fKSJ7YWrl9QKxVHLoQXq0/q36naHLGJ2U5LGjL7AYdJlr7mTi9c6tn/+N?=
 =?us-ascii?Q?/14JfAFVFcJeIhOahkV6UWqgUrdP0yslkQ1fZqOzW7d51vMGeCeQNtG+C7/Y?=
 =?us-ascii?Q?j8ni2gvHzofPMUQ0pXJhIXIYvr7m/3mr4TtjbqX2cd1wrTfvSmqDW7ZFKx5J?=
 =?us-ascii?Q?7D7cGQcW5QI4WEbf4NkYYExjD/pDom0anYGrbaXFR1j3SJlx/J4L935ZeF0q?=
 =?us-ascii?Q?X/vS6S4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r8ckciHohR2LAAdL4u3DJUZ2sgu6et2kIArAsc89QMDTLLvP4f0sAYz2w2Fs?=
 =?us-ascii?Q?FlTOv0IRzK7xc1ArJp1yqSMg50vUCacGHtovklU7LRl8BQ+ivFfvUFPb0Apu?=
 =?us-ascii?Q?pnTacIwTFeDdLyMFWjq1U2r9EaWHeeXe/PVHEB0Sxm3mmC2RSwkXAggJUs65?=
 =?us-ascii?Q?hWGGGdJgDwq9E4UxuQJHgpJAU8CFXxZ/cRNHrvF/gE0OIf2NCfUgpFQVEKPf?=
 =?us-ascii?Q?plpXsaBsIbErC3Jrkgm6bR3ysVDedHvAMXlNycClDk6RQej66QTdwmth4+nl?=
 =?us-ascii?Q?WqpEHG/grK3+OCIfj+2VERWiZK1YRdbKBS2XT3l1sc9r6vT66PEJ3fosH3kV?=
 =?us-ascii?Q?QvxEZAI6GDR0h8l3+BmEbtYt1ALe04JrFWdCMF6ioO/SX9eZBTXsjNFfy0kW?=
 =?us-ascii?Q?cg2TPHAzwbencAs4/afVyjU6ROR4NN19NeXJE8RSNjyNvqSV9twGQ64A2OZr?=
 =?us-ascii?Q?UuTYlAv6MjmOB1Jge+eCixMsLxd4JCVGVrBJSbwCTDbiIP1DtDWoHSPGuqtn?=
 =?us-ascii?Q?o+MmQvpL07Vyn05uVgyRAgVDAa5QyB8ldEWRgavQ9rqxN9/5VkFZwo0qTkwN?=
 =?us-ascii?Q?ABoO8tE/REAJEhJ6v7SmpApfHkxTblGsyjpsEx7zDcAhNWqJdaEwGMxUC+Ti?=
 =?us-ascii?Q?2GIOwWFd+su7IrR0GGZ5CB1Zh6y7BaxzcbwrtW8wwOzu5qkL/lbGe2IgDnZy?=
 =?us-ascii?Q?910LaIzaHQ3vZbzWGgdz6uwMaV1fvTF09Ekp6as8v1TJfMZFAN07FLyjX1P+?=
 =?us-ascii?Q?7ZaKOWTGnRnu3UdACEl8IUDAuN5PDxjBCbDYqkKYg+IHallaHsP90y1Xsbw/?=
 =?us-ascii?Q?2UO70zLD8CXNAjFU4N87D1Pr5HU+TAgS2Jt9PZwt7wNCRXPxgRzPjPUy6XEL?=
 =?us-ascii?Q?98+p8277Y9T1Kk7i3ue16iMzqQveWO1xbAAzD2dVBbYnCr8CloYsLW/BG5Xp?=
 =?us-ascii?Q?cWIFvWV6gEZXQ7qBYruZAIoWyBJAvuNwgqje0/Qpz45uvrmXld4mM86KrLDJ?=
 =?us-ascii?Q?RLtrh+qS+BUgu5S3qMyTfwwf6/xykBcNbtt3ShR+e7qYMp26+zkLYngQEYqt?=
 =?us-ascii?Q?OyW5G5b72tMs0lGXFjnMUkI2HG0/VuV5fSHvQv719ACcR0Xkj5CKEeFbHrZ4?=
 =?us-ascii?Q?punYjkOiXLo0u3+ynRxmuQYoz1yS5YMlUWZbIkWJ8S0Ws6seovUXr1cPlvjg?=
 =?us-ascii?Q?VDaC3CieeXfp1QLRT4toK5LCa4QfagX29TE1XC0urKqQJTB61aI2ZNe5W9ZD?=
 =?us-ascii?Q?qdBj/p3WC2yhiixCuNJi8DFwc6qTXPqUL1YQOz8C9pa3o/AFDJldU9ZpNv/O?=
 =?us-ascii?Q?It4/obpBEz5Vp9i3l9+dxb3ISy/o0lGjC0PYReoH1bj91Runbc5Qt8ZIa93m?=
 =?us-ascii?Q?fwllYzmngpsyVhIMUI0O7FaCjfbIEnqhV2IChLqTlZyYKm8z9ReM6pPkAJVe?=
 =?us-ascii?Q?vCKeq6454jK1YYUZKdclYdSs85B1BAN9kNauk+3dEVXW8wa3F+8B8RU5xclJ?=
 =?us-ascii?Q?k90+2kveTp+64KcM3rXqU1ZxxKyTl6dAinBQdu9T6YqbZASD5vm9gW1OSwqx?=
 =?us-ascii?Q?nspJk44pdTuPRpiyI0o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f03d177-7a0b-4f90-8e49-08dc7b8dab45
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 01:05:57.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gF61N6Gkp+rSNdpsKGyS85FpKcng0iXWNxS5c6zEQhcXiWa2WLa0ZeDI9DBBn17mJYzKsvjJRs1YC/C1sk8iZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786

> Subject: [PATCH v5 5/5] clk: imx: clk-audiomix: Corrent parent clock for
> earc_phy and audpll
>=20
> According to Reference Manual of i.MX8MP The parent clock of "earc_phy" i=
s
> "sai_pll_out_div2", The parent clock of "audpll" is "osc_24m".
>=20
> Add CLK_GATE_PARENT() macro for usage of specifying parent clock.
>=20
> Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

