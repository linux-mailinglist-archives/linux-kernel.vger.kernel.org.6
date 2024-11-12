Return-Path: <linux-kernel+bounces-405541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336B9C52AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63281F2162A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD420D502;
	Tue, 12 Nov 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="khvReEna"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF51F26E3;
	Tue, 12 Nov 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405968; cv=fail; b=P7hIO4fQr2oFnhSaiAQlHZJbIjrOq/ekxgGDHQfjwZEJfhgAq9JWEe6hFjg4oyprOQUodnWGzz5+/XK5NKrW4wYZxRLny79gDJSWV17R++IBnKktKu+gh+0bfyLs4hPz4Z0BuICy/a6Mr+twQxOBs2zcsGTo6akZ2/GAnnbZUDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405968; c=relaxed/simple;
	bh=AqiDe9Q4UqzcMEGUGwQ8UpkAfU4BChAsrDT6YXzN3pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBWP6UtO5kt1M8BSMJ0Y5ncmYAh469h/H0MbDQQAJvJYK8VCC3UmxiQTpqM2ByR13pXcJTrVCCovcs2hLH3I4JpMG3wrHeej0VxBbkQD06QfE2anr9+g/oXJmUcSq2D7xznLB0PREDwaWSSrtD7OeMsWaMLJkRb6oXzxxljGsy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=khvReEna; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDF7k0Thxz3ae+Y4m5E33vr5d2tJHkiDLqPxuLsPdyaBlEa4eEs4ADS6wDjPW+hcWTR5Jl9F+uxKeZJ9t9kGSaOzK35O6U5dEn9Wme6JGtWHfzPjVea+M9/QSCXp4J0qFZ48oySjbwi9UgzjlKYLQ0Sr0yYcfJTww7YdP+jgqOyZFamCYGoRneGcR6KFsdUdWBtg0FjeUlEi1ea2+E2tCgO/1keQsDDQYGE6Txhm35HL+UO1H2Kxs53Sp6zluzPFc+zgGSov7a2N4MLeN1PfVgpOfanR7gLW21o3n48/fZ3Un5RgjkGJ7sVm6EMQeXgjchggTH8Dm2QAYF9IIrTz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BarySs8rmnTz0Lcyjjyr1odVS71UDLLW4AffmsOMvfk=;
 b=orG3Snpep7DyXH/S0MezrPsxhlLSl+2lHsJzYecubAfNONDe2jYrbf38W0SrnfcYjhXavX2Z/vr94iBYnxV9J465/Br6YaKSKWrfNugukvNDpxy/VtGjqpw5W7NRO2UvULF2w6LBFoXP7jtqdw/YbQQphq9GxmZP0+PprN+z2yMTMmFV6RUro3Hg4iS1Vsbckx5QCyWgNUY5QVnSeLKnmcRu2Jq8KxoxDHK7+e0AjuUklSFDzjaemK+H1ZRHrJ0BJ/KLMVnG/O5O4VzqcFyd+RVPOgpsibS/mnEdP/Ykxh7XXcP3hQP4sYEcmu4ViCbqnFIjaR4o2+iqTVu520GICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BarySs8rmnTz0Lcyjjyr1odVS71UDLLW4AffmsOMvfk=;
 b=khvReEnazznVlsawlJvx2VY3p0Z5RLSVmXNeR7Z2QdEcNViZRn+j7wEQfTmKqMaXc+UlsFs/6S2W2V+sf6KVXzH382Tp1mQ5bzT9nwz5ziTmsYU96Y0MINx1Q4jwBbChq+cT0vhfezEWDlnZ2YsgzZ7RkrZ98ThoJ2E90qQ2GzuMzeJplNJFWjq1eSlaSqBg3v8EOUg7eeWMjtusYnUFK6J6MdKvl3aA2nrs/WEbJhrD3y+w7GtPi2aDZ+DgL/PKysLDNxGunNC97mW0+KhoiysdhgFjwOD+P4D8aOxkGDm/qZ5SRIFcjwqKAnycwIS15Y5KzRaiGfVBxxSMvPbWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 10:06:03 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 10:06:03 +0000
From: Liu Ying <victor.liu@nxp.com>
To: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	marex@denx.de
Subject: [PATCH v6 2/7] Revert "clk: imx: clk-imx8mp: Allow media_disp pixel clock reconfigure parent rate"
Date: Tue, 12 Nov 2024 18:05:42 +0800
Message-Id: <20241112100547.2908497-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112100547.2908497-1-victor.liu@nxp.com>
References: <20241112100547.2908497-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a70d83-b547-4374-406c-08dd03019db8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?iq32CdUNWRx3IeSDAGFdJjPT6eehjigcuZMH2gf3Oe1rqkne7CYC1ub4kz2H?=
 =?us-ascii?Q?1wYrpxCKA/ttb1sFigCxbV6noCInOU8R5nXJMzQ/LPimIeybYNoX/OKVQNQN?=
 =?us-ascii?Q?oxwzutY+0FGqruweXMK6q62q54fiBDeIPCUS7Ncli7B2IYI3PX5jALHfHlml?=
 =?us-ascii?Q?Y1Z1rU8B1+5Va62nmjgWUAFWqirf1jIwyjr2HsIpazN0eFCGdKiyPDr3uofW?=
 =?us-ascii?Q?6k0DkYUbQ5H90TN8PSs8WcMxpFj+kyePb+02Bfe7KQKQOsuUQ8nYxOfp27Gh?=
 =?us-ascii?Q?m5U07PegYmaRGLNd5mD/sCy0rOJg2QMEWwSB6S5CwxJtAjGB9QbzOFKPEl6n?=
 =?us-ascii?Q?3Wx2J+mvV+sqzWScAAj8pv22gYb7MqxYiEuAL+5OB/Y3aiaSzwnmwL6DHZte?=
 =?us-ascii?Q?xrjc4x2j53CC3qFQCch2dJEQDpmxnCcsVmc3jEuOD6RlJGs26bYfaqSaC2TS?=
 =?us-ascii?Q?NgPCddxIGl/BAWmZg6j7OTdpuhjmgA5LMxeVms0pF/HQy0bzTRnijXP9JZ5u?=
 =?us-ascii?Q?EV7h8F8+jKM6CEKDyma/kCYrcFE47/20tz83hEmV32jRXu/565lfab8p5B/S?=
 =?us-ascii?Q?fa1SW9OyJh8A5+Qvr3K2I89Gco8RTKduPmR16NXwgga6lYvTiNvDPQuRTES1?=
 =?us-ascii?Q?qHFhgBc9IxyW1H/z0DdYjLhJtipFIWlRma3Qct8xH5IQbK1y4quO8xIRovtl?=
 =?us-ascii?Q?/f9POF6BFYbLBY5ecxwJMiOJG2+qc6EFf/gPmo1v2EVwskN/zWKV047Rmz5E?=
 =?us-ascii?Q?x5Lzh2ChkuAO+nIRZ8w/C2YcZpSnhRoHS+B+I7LQSTbYJhI33z6zkAuT1hW4?=
 =?us-ascii?Q?kZXkDyGg6hcHc08/1uyx+q+EcC2OuYxUgYeD2NrIxXA4cW/CFZhrvUTuTI8x?=
 =?us-ascii?Q?PIPV9EiexXXS9tHWhHaMFS+IF7/Rikpqx7BkbNAmx+VRo42H4j3UCz69C9eP?=
 =?us-ascii?Q?GVVr8uQw5W5DSAWxM+ua4F9JHHt7yDKLB1rLeGrDU/Kx+OHz9OyhFdu+Xxz9?=
 =?us-ascii?Q?hAqY07t2ac7cgtVLjjMhMbh/1J+Yk5bjXVXy6Tqar/AQzEON4mNlPAb8oSSS?=
 =?us-ascii?Q?RUw+jpghENqsv4dOioCBkUjnjn2s2i5qTX+16ux01fczerPziyT2Jbs/fgYu?=
 =?us-ascii?Q?T2z+IkeY9eD+WQp/qFB3TJjIE1cf21wA4op7HddA/5LrvTvpiNB4m7UqMIVc?=
 =?us-ascii?Q?O9M1nW0ast3JkIdULthzDybhqNxPLXcdrBh6+Ng3dotelubuTAP9aVUeN7wS?=
 =?us-ascii?Q?47LCeGDjlIh/xf8B9inuzfUNjhJ7aXLCwV6ZASJnWEgOObk/9hH14LbjS9+7?=
 =?us-ascii?Q?6Klh47q9fETPfKOeHJMae2FruvIQMVrk2z8xyRHRRwwuk2Y4kqAwfGXZ+D2p?=
 =?us-ascii?Q?5yZBjZI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?sM0+HA+EwUm2mI+uwPMneawY78ctU9zTwuiHsCELOwsC4QaOzbiUrjYtW/zf?=
 =?us-ascii?Q?qrWVopzvJ0w5n/+uzvjLuKh95w6VNw1bLPLeNSwPPoa069MNo+wK9VDYH6j9?=
 =?us-ascii?Q?h5xs14moYa3HURA2Vou1E+TCHCfUiPsfmb2reTV0yf36gLZ0WQbA59REy8dJ?=
 =?us-ascii?Q?8Y/ejDaEiog5QnJzUbEmCbuwf4kDMYzkpYqTftKB62JCLwOfLr/fVxQlvWob?=
 =?us-ascii?Q?cPgIdc5ElF5uf9rxT94Oryv4rkn4K7WUBz5WZjdn9iSIR+EAErGOsrErH8LK?=
 =?us-ascii?Q?lwwPQM+a0ebP7DdmtF3xtL2+OvsNzdmf4BJk1ZB/zmGPPVtfwK8zMdAFet9R?=
 =?us-ascii?Q?464NFwiumv8Ws5frcMzYW5SMnrqeqYWvYbUUPUfWNq8yh8kENEmztQFKg8eQ?=
 =?us-ascii?Q?hvqwbLSApFB4RCjmXnev7cU/6sMb0Xnwpc4O2do8wq6ObpsCOiMYkJRMJz5H?=
 =?us-ascii?Q?9n9Q9DqEa08kElh+hZ8Zik7ejJif5WsRsCer+62ymjWc/eaWqYvw9DX9cXgU?=
 =?us-ascii?Q?0nqgS5V5mAq66+Qx5W8g5TT0DQdB3+6oRgMQwbreOPijA4i5W7gElGZyhtC9?=
 =?us-ascii?Q?hAzhKd1MM4uGH+jmk+g7aNeptmNx38zPlg71N+LtEtdW92UMDa5X7Xtn6wzI?=
 =?us-ascii?Q?ecqSUzn9tQtqFaUaUudtvb43M7aaPaAu443KnkPHWfKvByNq+4jkINIO7/vV?=
 =?us-ascii?Q?pC3cYSYhsmI0VWnHspf3T5Mo17xEX4BMi6NW9t1//MDbu77aO8M9woXqQC2T?=
 =?us-ascii?Q?W0qcxc7J6Pjj4sTaEzyg2XB/7oj2P9/Xp6tynnVO5FGJyVrfsXOj/gip+AIr?=
 =?us-ascii?Q?BVXaLep4NcDwprqTSJ/yAXvZ6XpGx0GY4epqdoC7WeYNCWbIecmmP+Wvw2v+?=
 =?us-ascii?Q?jBqwdzHwzpFidLY6E6jDUPI8W2ccM2pMoBmlfxeQSVx9/6fmITMD7OJVUJU6?=
 =?us-ascii?Q?A8Pyk0Slm2I6qheAG2mD1D18mpi2C3R8qthns1sE/XoyNqT6T3PFPiATunQW?=
 =?us-ascii?Q?WUJdqd9ImFAx6sk2J/bEnT/it8S0CsniFSNkI/nNaR5WW59Kelc9FcrqF/pa?=
 =?us-ascii?Q?xTKcuUBQGc4CAk+ut0eg6FRAOBJpvmkLG4Uc6FtAD1WPGrX0B/eqLJB6fCHn?=
 =?us-ascii?Q?RWgwU5SAifomrZpCky4gpa0aewDIqYsIMhWAmCbeLr8jPE3NOk1C12ohicof?=
 =?us-ascii?Q?ZBfZZAQy69TNez9jcd9kDjIZwhNtbnYaz0SIZRamlen9OqAe8aaX81yv3Gi8?=
 =?us-ascii?Q?8puoZoweCzP5o4jjrMRiAWbBbVbtMY6vTXP+eGOaCO1+u8F1oBrTsr792eAW?=
 =?us-ascii?Q?PwkmXU4Z2FJXBZ64MLl3pAM7NuhlyoKfXzYeJLEhHpBO+R1qrb2O9BhqIeA5?=
 =?us-ascii?Q?Gh0R1tQ7rjY8LLCgnkeU4tYwb+/jCUVfWEMDpleKaTVK8GQKXERurwQKNfwv?=
 =?us-ascii?Q?ZtQz1jwQr+aSX6pmMauVbDzjLov1NK6vSfZe3l+Sbc8wH8ysUBxDj2WEfLdc?=
 =?us-ascii?Q?6Zq7YfDkhx8Yni2c6HRiewWHYBnxMSHS9RnIhmUlnkdxyIdx8K80FSEXxfHe?=
 =?us-ascii?Q?lvCajgmgPd8b3ds09OEs1z3vCzEZideZzXMlfhJF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a70d83-b547-4374-406c-08dd03019db8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 10:06:03.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjCXUk6XL1fHmE7aH3zDivWd9UXMzELfTpJ1kGgVNRflFVcFD4dHgSWyFsCQ8m2dBcJRLEJxqU1EvSZxzY+10g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

This reverts commit ff06ea04e4cf3ba2f025024776e83bfbdfa05155.

media_disp1_pix clock is the pixel clock of the first i.MX8MP LCDIFv3
display controller, while media_disp2_pix clock is the pixel clock of
the second i.MX8MP LCDIFv3 display controller.  The two display
controllers connect with Samsung MIPI DSI controller and LVDS Display
Bridge(LDB) respectively.  Since the two display controllers are driven
by separate DRM driver instances and the two pixel clocks may be derived
from the same video_pll1_out clock(sys_pll3_out clock could be already
used to derive audio_axi clock), there is no way to negotiate a dynamically
changeable video_pll1_out clock rate to satisfy both of the two display
controllers.  In this case, the only solution to drive them with the
single video_pll1_out clock is to assign a sensible/unchangeable clock
rate for video_pll1_out clock.  Thus, there is no need to set the
CLK_SET_RATE_PARENT flag for media_disp{1,2}_pix clocks, drop it then.

Fixes: ff06ea04e4cf ("clk: imx: clk-imx8mp: Allow media_disp pixel clock reconfigure parent rate")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6:
* New patch.

 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 drivers/clk/imx/clk.h        | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 516dbd170c8a..e561ff7b135f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -547,7 +547,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
 	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
 	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
-	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300, CLK_SET_RATE_PARENT);
+	hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300);
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
@@ -609,7 +609,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, ccm_base + 0xbc80);
 	hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, ccm_base + 0xbd00);
 	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, ccm_base + 0xbd80);
-	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp1_pix", imx8mp_media_disp_pix_sels, ccm_base + 0xbe00, CLK_SET_RATE_PARENT);
+	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite("media_disp1_pix", imx8mp_media_disp_pix_sels, ccm_base + 0xbe00);
 	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
 	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
 	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index aa5202f284f3..adb7ad649a0d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -442,10 +442,6 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			IMX_COMPOSITE_BUS, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
 
-#define imx8m_clk_hw_composite_bus_flags(name, parent_names, reg, flags) \
-	_imx8m_clk_hw_composite(name, parent_names, reg, \
-			IMX_COMPOSITE_BUS, IMX_COMPOSITE_CLK_FLAGS_DEFAULT | flags)
-
 #define imx8m_clk_hw_composite_bus_critical(name, parent_names, reg)	\
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			IMX_COMPOSITE_BUS, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
-- 
2.34.1


