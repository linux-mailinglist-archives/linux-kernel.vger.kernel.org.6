Return-Path: <linux-kernel+bounces-256207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57EA934AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040E61C21662
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE7980C0A;
	Thu, 18 Jul 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pBEEDI/i"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AA3BB30
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294003; cv=fail; b=Ge7b9RQ3Fc1FciLqiemCOP+Ua5OaGRwteiArMHcvx7ZA1p4Faq1B6yQ9DpvRcWcNIc7/7/H2W+/ArE/QyrxaRmRs6Pyob68Jl0+o1nA2vWWcCJq0TG8k/72D4fHDj47xriGRBVxmUCAEje+c/2TbWRkVU1i5J/ntw5bs1vE84cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294003; c=relaxed/simple;
	bh=gH1n5W+cze2IaQ26H79ZKLjLIkjlsNbwSxEupkUOY4g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TsBlnyf0ASj+aGQyRDLWW4ZG2sraqsB2nDYdX60a+DIObyiud1otPblIFDvt+2GV+au3dCR3Fko/Ind0Bl0O3ucXRCQy18PapJyxSkWFfXIylLsmOHSMR4pLa03Qx2dMc0v/XKEqlrwPQNdLWx0XsVu6+IGLw84EouElV7kUHd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pBEEDI/i; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYO2OvOzVtSxc/iAyD0ubdDr4N6J/UF8YvuxNst/mVo+Sgw5jXxt79n0zv4GZi6IdUr5NqgXeNaQjqS60NaFkDNZARHmfuqnbXL4udJPieC7goRLX4nfaG5cL3SQmKC6oGRqWu2fq1O7D3M9Pk9fMFzgLhIvlTPCb//k+p5VFYqHa/sdb2LBRr85NaklLGXPNPmtt4FMj2ygSo9apR5m31pQ2pYk6T0OeZihnLogLoUur3rs4ddiOAwFkl7NPw+BrZscJbjz7w6fqLo31x+5E2TQBSCBjmV2B9w/uyoamoNcqNc0mCTPuqVUV7Q7rfbwAlIWrtr4eJiSU593qXfD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVxkjXZu70mi6S09FPpIPAXl7P4S6f4ecJB4HIGZT6w=;
 b=SUjVDFxa1W5Af+y2KucBWT9GmnBxCuFXYJ+by3fWeQLvKEGrLOjUcPwNtn9D0GYWY3GPCaZlInUizJXnNeg4b9Z7MOwfXklI+SM60sp0ZCtdSRiG/F2x2InjmOTy/LCNORCn+5vtfHF2HyxBsEA2dubfhdfx7eWu8NQxXHI3R7uNsQmMbpqkFNDwrGKxrkom+R7q0UbMBC3585sHNgHNKaC8NaCIImFl4A71qLv5ZFhSWkD0riDAlmhYc6ZuyabKo7lRsfNPsTqRZAx7Q6bHzoquUDx166+Vwf4YOdoiSgPXeiEnQ4DPoOfcCuvala6DF3vg9R0loomKn+k4w8/fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVxkjXZu70mi6S09FPpIPAXl7P4S6f4ecJB4HIGZT6w=;
 b=pBEEDI/inUzpLWHHXBUwbHaT9aoCq6PqsZLkXfp0cfVh3XO+AaOHOjYgS9Cd2xCMkjM0FIa6YpeBE71lE4xvBvViqTV9Vxv//Ugj8zujxmm6iirz5o2AmJlbb/6OssnAv3X7KDyBZ4XpbNNnuC8vIBWR2YSHSXadHhLj2Db4MPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA1PR04MB10263.eurprd04.prod.outlook.com (2603:10a6:102:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 09:13:18 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 09:13:17 +0000
From: carlos.song@nxp.com
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v2] i3c: master: svc: adjust SDR according to i3c spec
Date: Thu, 18 Jul 2024 17:13:28 +0800
Message-Id: <20240718091329.3788619-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA1PR04MB10263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a98c670-b49b-47a4-6633-08dca709dc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/BQeIK4bYkX7dXpHXthwBrCgTXenC5zPGLzRcgIx3Zx4RYQrhyV8iwEX2keB?=
 =?us-ascii?Q?62of6VE5Cmdb4IIM+tg+Ns4N3+W5zhJ/4PL/rxbiZRoPSkFSfUwtsBPMT5kd?=
 =?us-ascii?Q?nDJ4wEBm58JlIps8lzimJEozxDEFH/ayBf4YMCuQ8nW+Ao5L8I2Wn950bJSr?=
 =?us-ascii?Q?4iQqEWiWbIPOcNa6o5FYJwnwDDeaJs3nMymA4+DRORJmrfu95krEdGQ3UrnZ?=
 =?us-ascii?Q?cSo3ESVyzfzB6tiUXLAjLaV5DgNASGQnSoxce9tCd4wn0QG+GEVb3N7jHN5o?=
 =?us-ascii?Q?fHJb8ioxpYL1CcfQL8eQPti8uIUDY3tXI6Qq0fnln1bfPLfmD37kYqw3SBwx?=
 =?us-ascii?Q?ivp9NKU1TNZCIVBDOwRzbT0orVZ6O6Kvt+1syR/G9HpieCjytwLCkYobEo9X?=
 =?us-ascii?Q?4uTks89DNTiC9ebdZ8kH1fWus+0rfetgIEVJNp8ARYoTMGGejg0mbjGnuLt2?=
 =?us-ascii?Q?7C+gadtnX19Ywhiz28zLu6xrargU8nukMfg9RLGvSHpDsXI0O7DVfKj7XLUr?=
 =?us-ascii?Q?4hiPFW+nAgB8xOnZiJ94NCK+UMGGnfcgrb49QlIpLCG94dAbyukQrmgfIq4U?=
 =?us-ascii?Q?jvBl71OJf2jeBI3jeAdcqLTIJVI9ju4zucB9O1ESx7ZVntSQmHdHUxXbraCt?=
 =?us-ascii?Q?erLUXZEqTxmGXqnZpXJQ3uuPTBY+c2UmTpgR7vSY6DYBIeLopsdkAuLdc60X?=
 =?us-ascii?Q?t4st+06DvFwhklDzhRklVQD/TjdQXTxvIkfqngc6gvQUGLHHqSxknnuHnwYt?=
 =?us-ascii?Q?EJGHzKrP/oCYe9yicYBrxgVoRaBAsn27A0XCI6r6+/Lpu43MTtKAYHUaNwVT?=
 =?us-ascii?Q?AEcktSSQJhH0DyuEXvg3BhnTbbRGZLiRzxOLc8nBj/n82FMKvcW87MBgpdMF?=
 =?us-ascii?Q?9mVbfksSsdkzyVpPQ5oMCBRWvzw6Ne226fp9Ml5eVHexUKUyvzHt9bKk35FZ?=
 =?us-ascii?Q?NHkSl0tBkR08PT0xzu0dvAQGF/Kmxm6dg7WRiqmXzd0TAl42FrctkTuSEyz9?=
 =?us-ascii?Q?Z8basSUSbmuZY48d1LHXjwm883Qur2vlHxFH4wEckq2tAz+B1TO0rFGgKqwm?=
 =?us-ascii?Q?r8dvN2fAvM0rXKv2WLTrjnqmQp3AxmzGp9xS75BCJdk8lrTRdZsA/2+M0bGl?=
 =?us-ascii?Q?btipKPwQMXrke5g8CPyk0S6Tc5oppKzS8Ix7M3ZqTadT53Y9D3oKc/vJw4tA?=
 =?us-ascii?Q?GPP+WK/l62AtJ84iSBZ36tLTr7qQ+A77dUKa8talkdSQDxZAwrReCARouGv1?=
 =?us-ascii?Q?2/aSrISaWeFSOlwgdm1rrFa7Lbna+Ghu195u4m0fWBAj2x4N7u4wn79qt+2l?=
 =?us-ascii?Q?g86NasAwALqjmTCnPG1GNF+ws4REhyW8IFEAgp6m9vJq7OYKWnn85/uaK+Na?=
 =?us-ascii?Q?AcHWUpMA05n56GRNMjNPUb7bxn5j4eCEPz5F3LJHYVupqt+spw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RKh497Xwve4tPjIfmvZ26H0Wave+nqB6i3M9NNqmnjUppGz3WoI28bSjggTU?=
 =?us-ascii?Q?PO7ALhvfOa+gSHOh8hMb7xV94nPpMnS0u4M1nanlNpL2ZGEJcHU8WeBLFq25?=
 =?us-ascii?Q?9Ip97zEOS+pug4LyX6CuFtsVRClLyKf33DUJcJtciRpKJpZKLmg5/CH/VvrN?=
 =?us-ascii?Q?AQTeE7n5GF0CKAB/2txekYqdTapMxuLOy20piAKOFgEtmkgjcP293MaMwjlU?=
 =?us-ascii?Q?Nyr5Vn9WJAcnyCccQJTyBbsdr25m/s5nVMASN//Pvv+0Js+Pjchdw8RbeCew?=
 =?us-ascii?Q?3nxEIyuZFIu61O/B9IE5Eo3L1nXzqgvgco2ukl073J+tyGW7kNh7RH3+Dna9?=
 =?us-ascii?Q?d3LS6haskqUFR4h7rQcB1fR60O2MFBBXJBdcNNcW9ihAckcJzXE9dqb1lAZA?=
 =?us-ascii?Q?SV1IJSick4GLd1zlABi+kMztFyELFScQbrdDOIgXbeIiVyu2I7lN0haF/uzK?=
 =?us-ascii?Q?Bwi+sl1MpWBNh7Kk+uuQ+ytrc1V4M9JEU8GTOedUHyqCfbDbwuUjRjWBosRG?=
 =?us-ascii?Q?aJ7u/9lDaXx6+/akCG6/J39MF8iSFM6k+9WgUTRQ8x+HZzv63IDLWTgjtpO7?=
 =?us-ascii?Q?VaJ46hwhg+XD0x14wIqXW8i0Lih1uY0nPxx/w1wlurwV4R2kgyjSDuttVaOw?=
 =?us-ascii?Q?V0ZXKBTvQqNb25MOLJpM6KwCkY0FzmrnYrQfD6fwBQ9Fil22WKX4r3ILW06T?=
 =?us-ascii?Q?YUXVCQhE96zW3LJyaIkS5Pu3aAp/0CSj2TUHjB5ejSsfV0E1EP4hUJ3eZ0oW?=
 =?us-ascii?Q?NXK+9Uy6yW0ILa0fc3IBDlk8zbS9paB8sLYNqWl7g0cWGpTA57WKdXjkqca/?=
 =?us-ascii?Q?UINSOzhugf/6iBGLJYmgLLdpRJGdZ/gbPqFwLsMgg3Mc1/LyRmmkkyWTPt9L?=
 =?us-ascii?Q?gbgLyhMfC+xWAPCgjlADayey+QxZSxPUl/beJ+ec1tDzsZ76qZZrsbn2q0pW?=
 =?us-ascii?Q?YjM/CNAYc9eXGRzoVOsldGqOfDJdGlCGZZadfsWvCNZIycJT70O2ZuHFF22C?=
 =?us-ascii?Q?6iyygNNseyi5sOp6/quWrR6AtT9OqqKxJhFDdtizL/tQyvoevj5F6/Xlb/aS?=
 =?us-ascii?Q?lK7DV5h/jZuF/Qq3clcJ2OU6N+tBX7tmYz8/u6TKnl2KLVTrigQXGYyyotqQ?=
 =?us-ascii?Q?2GTCjtGQzPqT+NNKvib3mBCw1mZ0r5QO1A3lk/WtSudWPoMndn9NiZ+KA2XG?=
 =?us-ascii?Q?ZO30QgF4v5aD/wUvU6FMcTGk5/NfaD1FsaICdMqE1Lppbz9weMnZk62BHuAd?=
 =?us-ascii?Q?JYeKFVsPkDrCFQMr4s54c9xjlFDZLc27O3v2zAIURm4RbcsUWFNZu/AtqsuM?=
 =?us-ascii?Q?2pf7NMtQRhpd+2MxoXJaBSFtdikS1+aObiBHEzczU3r3CzI5hAULxV+vbLqo?=
 =?us-ascii?Q?enV9M/hfTmi7mZ89bOedOTB6+vYFgcc6ATah4lVHB2Jfp44bLphJo3GjEjjh?=
 =?us-ascii?Q?OGYJyPO+1nccSOtegGGjEuBFLl68DpvHboLzwb8ibJeGB5uikfXuQk+Vv1Fh?=
 =?us-ascii?Q?XVOhfYLMfMmzV9cB2ujxhiSIFczJ9V3D3wRq49ZIG4nJPvRq2m5WA+vb8g0d?=
 =?us-ascii?Q?NUYgEqfFMDGsMvdrfYeJO9x8gYp193Hspb53mYpZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a98c670-b49b-47a4-6633-08dca709dc6f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 09:13:17.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xryOYqWHgCZc+Vft/rMKHerPEYn/VuWUtuAJZU1QgHhNUfUGReRTAxwdxatgnJ85z4wYxz9vA5nPI/wRmiLzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10263

From: Carlos Song <carlos.song@nxp.com>

According to I3C Specification(Version 1.1) 5.1.2.4 "Use of Clock
Speed to Prevent Legacy I2C Devices From Seeing I3C traffic", when
slow i2c devices(FM/FM+ rate i2c frequency without 50ns filter)
works on i3c bus, i3c SDR should work at FM/FM+ rate.

Adjust timing for difference mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
Change for V2:
- Correct I3C clk configuration and simplify the code:
  Pure I3C mode and MIXED-FAST I3C mode just use the same i3c clk configuration:
  1. i3c push-pull timing is 40ns high and 40ns low at 12.5Mhz
  2. i3c open-darin timing is 40ns high and 200ns low at ~4Mhz
  3. i2cbaud should be different between Pure I3C mode and MIXED-FAST
     I3C mode.
---
 drivers/i3c/master/svc-i3c-master.c | 31 ++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e80c002991f7..78116530f431 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -127,6 +127,8 @@
 
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
+#define SVC_I3C_PPBAUD_MAX 15
+#define SVC_I3C_QUICK_I2C_CLK 4170000
 
 #define SVC_I3C_EVENT_IBI	BIT(0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(1)
@@ -535,6 +537,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_bus *bus = i3c_master_get_bus(m);
 	struct i3c_device_info info = {};
 	unsigned long fclk_rate, fclk_period_ns;
+	unsigned long i2c_period_ns, i2c_scl_rate, i3c_scl_rate;
 	unsigned int high_period_ns, od_low_period_ns;
 	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
@@ -555,12 +558,15 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	}
 
 	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
+	i2c_period_ns = DIV_ROUND_UP(1000000000, bus->scl_rate.i2c);
+	i2c_scl_rate = bus->scl_rate.i2c;
+	i3c_scl_rate = bus->scl_rate.i3c;
 
 	/*
 	 * Using I3C Push-Pull mode, target is 12.5MHz/80ns period.
 	 * Simplest configuration is using a 50% duty-cycle of 40ns.
 	 */
-	ppbaud = DIV_ROUND_UP(40, fclk_period_ns) - 1;
+	ppbaud = DIV_ROUND_UP(fclk_rate / 2, i3c_scl_rate) - 1;
 	pplow = 0;
 
 	/*
@@ -570,7 +576,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	 */
 	odhpp = 1;
 	high_period_ns = (ppbaud + 1) * fclk_period_ns;
-	odbaud = DIV_ROUND_UP(240 - high_period_ns, high_period_ns) - 1;
+	odbaud = DIV_ROUND_UP(fclk_rate, SVC_I3C_QUICK_I2C_CLK * (1 + ppbaud)) - 2;
 	od_low_period_ns = (odbaud + 1) * high_period_ns;
 
 	switch (bus->mode) {
@@ -579,20 +585,27 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		odstop = 0;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
-	case I3C_BUS_MODE_MIXED_LIMITED:
 		/*
 		 * Using I2C Fm+ mode, target is 1MHz/1000ns, the difference
 		 * between the high and low period does not really matter.
 		 */
-		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
+		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
 		odstop = 1;
 		break;
+	case I3C_BUS_MODE_MIXED_LIMITED:
 	case I3C_BUS_MODE_MIXED_SLOW:
-		/*
-		 * Using I2C Fm mode, target is 0.4MHz/2500ns, with the same
-		 * constraints as the FM+ mode.
-		 */
-		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
+		/* I3C PP + I3C OP + I2C OP both use i2c clk rate */
+		if (ppbaud > SVC_I3C_PPBAUD_MAX) {
+			ppbaud = SVC_I3C_PPBAUD_MAX;
+			pplow =  DIV_ROUND_UP(fclk_rate, i3c_scl_rate) - (2 + 2 * ppbaud);
+		}
+
+		high_period_ns = (ppbaud + 1) * fclk_period_ns;
+		odhpp = 0;
+		odbaud = DIV_ROUND_UP(fclk_rate, i2c_scl_rate * (2 + 2 * ppbaud)) - 1;
+
+		od_low_period_ns = (odbaud + 1) * high_period_ns;
+		i2cbaud = DIV_ROUND_UP(i2c_period_ns, od_low_period_ns) - 2;
 		odstop = 1;
 		break;
 	default:
-- 
2.34.1


