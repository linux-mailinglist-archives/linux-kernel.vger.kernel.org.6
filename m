Return-Path: <linux-kernel+bounces-302707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C896022E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FA1284CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4E1494CF;
	Tue, 27 Aug 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IEu5/SmU"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AF7E76D;
	Tue, 27 Aug 2024 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741264; cv=fail; b=Ovl+aewyws6NCurG30k33haw9MBQAoblcS2f0gcg65ed+K6dj7wpXhneozdkUx6sAXEhLHjLzjHhST3FVQCb+LJtc837Kqo1BpVbFD9q72yFnhhIlHFV9uPgsRFpE9tMK7EOHVBFIJCN70jno+cJGVzuR1o50SYtCRnAKw1JCrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741264; c=relaxed/simple;
	bh=GyW04xtg7ERKa09wpF7mYgtWEuUoab/wwb2p+EuJjZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LpQhy1h4rW8eOhrasI8wZdGDBc2E2USXdyp8QuxDiHPJiph8+SZ0aQjxuF0UMNWQta3X3lcv3nrDN0w3zMYvUVrcYwfMduDMmle/rww389CHNDS5K1wIqVvBemK2yLMUcP6PGl3nUQwCqqYreLzBdQeKxifNiWE7ryL3eutErSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IEu5/SmU; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOvrilHICgraSxuDkEeCiA6pDZl4KSYXq4xFB+Dgnc/xv5JHb+axodpoiUO76HGsPc/SRyc8DM10XuPu9Gevaj+IRgh3P320bVeViYQqK6n2z5twuoI9uvRbAtIa9r5zcLwWEqD0SKEIgp1MmFvKLs0fZDF0Vh0LmO9etExGgAM/K7S/75YmaWmYXm09dIcKM32t5NBVaMIgiD5GuaaK1qpmJ4knQfxT/fQDXhsgTad46JuA4sBo8T6JFEAHIUiWThIzBMzeD0ip9xKATM/a4V8qOtd+GXSHKMWxbT0ffN/bFufqSmf+8k3Z4Ref+0tPrnzwQ1tQZGbgoPCY9wsE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/P+hGMrX8/qkJJ33Z5vBjI3lB5RXH+OLbdApCOs5Nw=;
 b=cqTULesuygPAcD3376plkAUiWWs+b4/mkvM2elllU23hA0IZl+U9EFA0kA4dbDGQ5Hml1ffGBpko2ZpAphO8pK7IJ7Fs9TU7qJljggmnO6afzOTviSZlsnhpTF/wlDjbHtiv6banBYNfE1MNH9JJMP9x3gVWDWy7GrnYKfBkWWy7tzTuPExZiwd2/lqvqGwjtFVwBH1h5DtZkFoUat+GS3sWUvFBZWilkSeyIlR1O7JTFw5nClqoRqPzYVm0DYmc3w8k8hIsM0kT+4eHg3YY3AccgQl/IxkEMCCRa3NRw0GRQiYjozIWpYD0WuTfzqV5TZaBHmkdzmYvYTOxOXoiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/P+hGMrX8/qkJJ33Z5vBjI3lB5RXH+OLbdApCOs5Nw=;
 b=IEu5/SmUKlXUi8oc52FhcLMuS5ZxoSSYHEuxM+LWgcIWry9rVxzq5cXmmCsaMHl3pGA1yCvy+ipm3DrELqDK6XcOoz7smt38NJK6slMtZIqe7wzFsyfEjHJ0xTL6f0s4VDc+YlF4T631YvE9OH0bMzFHbbQo/eU64RI+M1+nR2yMewDKsfIGV9YShOrEDQRkte4x4aE5DgG1QbxF8Fmq7m82K7LrpOx/iE50SHcbqmnz9Unm78MO5/7leh0tJRpsEtU2U4mAcMP4q+ixJZnIzcUMghx9+Ag7DX7XN5TjYttpX+mnJY83fB4BcwwV7knOYCtKot/sKzph9K4xTK5f7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:47:38 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:47:37 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com
Subject: [PATCH 0/2] arm64: dts: imx93-11x11-evk: Add PWM backlight for "LVDS" connector
Date: Tue, 27 Aug 2024 14:47:15 +0800
Message-Id: <20240827064717.2383292-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dd9403-1532-450c-2483-08dcc6642380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XvF8P4QVpsI2icyD5kPt/NHhbK+4UXWGDkk950KJvp5Mv73ryDyz3yDRguus?=
 =?us-ascii?Q?NHhiNBT+LWBIt/p4oIZP5ONJe8ySLG2AWDO75oi47Q5w29Z0SwuWagdFbHOW?=
 =?us-ascii?Q?dbPk+azBwiTBXmxUtjzG9ez2SEBXYrLAMB8eFyCrlN0NA53elARFYQkNpJTk?=
 =?us-ascii?Q?30or+wY7aRrhG9qrSSojomE15fMkujvdDopZGXAa5y4tL2eNBVuHMSVzSpnN?=
 =?us-ascii?Q?RjAsnx14cWEB7JHHLZI486VeL873rtfpMnMLxiZjekiagbyb9fMdawyuY9Ff?=
 =?us-ascii?Q?kMm1oGf/NmUztoR4dPLto8H8iTQFLKzR9+A/7uVzhZ1NCpJCMfdT0WeOxjw+?=
 =?us-ascii?Q?u+v9kdzp+tlNvNWPbzyntxWqLMInpTB6LJXTW5UjOK+9pTUPVn/YO3/FcXag?=
 =?us-ascii?Q?lVLltsc6VHvPw6fy4XCI66zgJpHuptsQsyG6L9mSKTVFS4rc+2BffJAkgHft?=
 =?us-ascii?Q?Uug3uAZUfrdUwYVKJ/iIYJQqxsS8g6YLa9MFUViguhjh3Qsn3zpr1l9A1APj?=
 =?us-ascii?Q?LPGnoJJeWcAbqR/Mr0QrNp3gCMfpU1uuKNTWfdXX3qajm/RhZjmHKNpKIZbl?=
 =?us-ascii?Q?m0pbf+YXwhpKpUNbuyOQ6F68oIobEBjeO2PzSEPy4nrSCVTPUyqht6WyhPz8?=
 =?us-ascii?Q?d9dxoeriqkggCfJlozkYcWxg23xOU1JMvhvWPoa/wvzhde9VIqkjR1gEaLyG?=
 =?us-ascii?Q?oNloiSqYxLVPGUZVn4sr+BGdaJe+6UYtXSp1ZfDaPkJGvIQMNhIwzOunbXq0?=
 =?us-ascii?Q?G2iy7Q3mV2lzEf5gqZcRsTFzep94CSl2Ve5skcq28tUU3hx/04cWPHuO9a+V?=
 =?us-ascii?Q?u7YG3SSl1xCJfDv0063kEMYBC4G6wTDOlKGKQILyKCtjNzzvFONnldAG4FQE?=
 =?us-ascii?Q?dpWdw9q9jxKhk1uuEpwMtuRlhP+lW0qAyzZEoGhHz37ggeJRzNrKwHmM/XbF?=
 =?us-ascii?Q?uwam9BAd4npBmGWdIVDWaDUwy91ek1SDODYhesFPpNJljomKqFlUGPIqWW2R?=
 =?us-ascii?Q?f1t577kep+BxUovHkU0w/SweV59Xvg+9s1XEGJGSj+JqDyRIHSGTvEqYdDD9?=
 =?us-ascii?Q?dl0LjCqP/3EE5DNkGby9CWLupydfpZuFABwnve1xVd/wcb0yuDoTtV6UAzPz?=
 =?us-ascii?Q?bmvt0PK6FPiweq5Ja2u483MFm2eJxiIZjDvFTvhL7q/PZ75PZPk7eILtvO0W?=
 =?us-ascii?Q?5S/HdEiDHORuGpmK+khdt9lErCrbNOu7cqG4gOfGRojxPXEmIzkGHk6oT8bn?=
 =?us-ascii?Q?mY/y9J/pAp1vi+0KnplyzRbygRo820J9bXgKyIvHIRVe7DvyikIjop9PK+ne?=
 =?us-ascii?Q?wIPKrvhH+9iNGQo9nq7PE2ftSkQx6gyUIb58QGvb+7IXzJdaCcYP6qAzeSBM?=
 =?us-ascii?Q?YSxLFD5p2Vr7cNUV29fmmOaO8dPOYxXCiXGBRSscremCSdtcDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1xB7S2NoIXmz+QCSC/36dsA5cgHF691HgZdKPGLiObqG0UoGX0/nDlyuN3HG?=
 =?us-ascii?Q?+nEo/c6c5Jzny0V9oB4HhPtxUtVvUE51y1eyRr1Q/PKppurN3D1+O+XkciOa?=
 =?us-ascii?Q?6gDP4TQ6sU+/HV8LceEm0ZPFWO9PuXUwnqdp9iBA3fooUkS+25NSICKUxvKG?=
 =?us-ascii?Q?HvZI071646jQADgX5Hy8Q/NoswdyoEahZZ1r9hLWyZ3m+8hOef045aj2xm4z?=
 =?us-ascii?Q?2Wo9dne0u5f8L0vCso78Yq2QBqAaPGg8tEtlJw7Ema7Ct4dwkr034AEULn/o?=
 =?us-ascii?Q?Nh/XSVHYq42A7Bkbgbgu/uFRPgLD8GtyXxef1q5f4JjxDTc3YJmyiUMxAJqI?=
 =?us-ascii?Q?/yHKDfWKc1dsxs/R4g9y4GJhWCL5+RVwL1+ozpKsgJqqnWdrRqprQSwwD4NH?=
 =?us-ascii?Q?4pn0dtKctXda1/nfsPYsnfURfCmfZ/aSoxuH2LK4mltGMt1zyKA0UNymNxXY?=
 =?us-ascii?Q?9FDacEf0MLHYztjJoo4VVkZi/SnP0O4Tqk01wgt39oUYRcmbYk8czfkr6oki?=
 =?us-ascii?Q?Yrvfi0806XuRaaMLHAl75ag1vaLVl8XxOQzBuAWjti2RfG5q9ejalqhfTKvj?=
 =?us-ascii?Q?b9MlVRRvzuaZJeh3fHWi8PWiB+tDPTXpSOR9B5tY218Qel4U95ytzWMOs7ps?=
 =?us-ascii?Q?GFfrcTMiWmoZDqC7tN/+k1HeUvudPb2ZNWfAo5My+9RsIwHVnaYZ5CnOxQoo?=
 =?us-ascii?Q?lt48xWuHKdc+T2cmunmLV7/LDHyrCaelLnhTGJkumMvMOQjxCOj5mQDYFQKx?=
 =?us-ascii?Q?/NqhkZco50FLxvISzLBjyrkkwXv9WgGuh8GoovcTgN10HoRQXEFUGCQrSeOh?=
 =?us-ascii?Q?muiM3kh20sj9qI96eZSLbRq5/+9X6leoPR/dav+WCMqZ4a1DskUEGLvz6Hue?=
 =?us-ascii?Q?T81CJIKnlkMK/NUQhTsnidwqwOGLuUN3vPfGgwUoX0Tsggy7+j/MrS7+fWgp?=
 =?us-ascii?Q?o8GAdn0AG4X+WKl8YTxbguCtqNh2z5pIbL5G1oyJu+UoitITuVd9MWhtdaCq?=
 =?us-ascii?Q?4SdSFqLU8rR0+Is0dnh2t3nm8iwS5xdSJhUI9OFczOPmOUW9tmWVDeC3F9rh?=
 =?us-ascii?Q?yLAFxAgGW3b+wrPuvhqPwsbC9glAxTCxkjtBRGQcMfp9f52zOG7NdFWn+dx7?=
 =?us-ascii?Q?ImcJrjc0FjH6VcXvxqyKa08Aw+0MAyxINMOkubcprELZPmALQReODeVksVpU?=
 =?us-ascii?Q?q9/uY0vBe/zxvmPRbYJxBWADOxJluRn7JhRqYLpX5igJhtYKY7gWSxUVTSej?=
 =?us-ascii?Q?1Trz4pKmUgfe8b/ApEtEmqMYzvU9A1Iv1Dr5HvB0Xhuom3Ha9mfQNI9bs0qJ?=
 =?us-ascii?Q?IuGhWubc4HF1e+1ZgDWUOHzlnXxBtL6RBvCqLggtWNwA+rXs3CaWjlqr6tmV?=
 =?us-ascii?Q?9G+XClMAdtFubL/mpiayZ1f5gurIs9pEB1u9YDoyzerLAsNX5rinhbDC94eh?=
 =?us-ascii?Q?bXhExQ7fU0e7OWID23paZR2MtPJvnpiwUgEPPPQeDOHSbk200UBayRrNnVL3?=
 =?us-ascii?Q?Ylr5eo64Ebav298Us0ri4mw0ck8a/Zty03tfUaSP0D0CRHW2kvkx0u/L5PRY?=
 =?us-ascii?Q?Nd/k3XuyNVUMHlRGKY7Mnjz4/FA47rLkI75oL/o5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd9403-1532-450c-2483-08dcc6642380
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:47:37.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmUzVFpNLHYtk9yDh+3onTTzuZt7k5ahoJguSz6U53JrD/26iTJPyNL3ZcYdOL8wnO7BS4532MJxL74aemzNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559

Hi,

This patch set adds PWM backlight support for "LVDS" connector on i.MX93
11x11 EVK.

This patch set is based on next-20240826 and targets for v6.12.

Patch 1 adds device tree support for the PWM backlight.
Patch 2 updates defconfig for ARM64 to build ADP5585 MFD/GPIO/PWM drivers
as modules.

Liu Ying (2):
  arm64: dts: imx93-11x11-evk: Add PWM backlight for "LVDS" connector
  arm64: defconfig: Enable ADP5585 GPIO and PWM drivers

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 30 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  3 ++
 2 files changed, 33 insertions(+)


base-commit: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
-- 
2.34.1


