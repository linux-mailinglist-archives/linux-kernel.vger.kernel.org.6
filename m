Return-Path: <linux-kernel+bounces-262571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A793C8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0317A1F225B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BD6F099;
	Thu, 25 Jul 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YUiGqi9k"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A94CB2B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936062; cv=fail; b=o+mvNm1sUzp5nF4EydZGJ0qmecWnmmZJ72UEHmzaknGl4dSru1fl52+N2JO29f0hGFccYKr29X7MYpEdjQZ8YCrfSlNV4lt4yNlM3eOkFBvuZb16tnShUAjiHn5rgAx0w/z1LKarZzxNtn04kPtmslSYHv/9SnqC03SzoHge03c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936062; c=relaxed/simple;
	bh=vCIVr7fezQlpwd4TyTeMjKAymJMEJv7BWyY9pWxRzBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBx/pJ68UNSl9ECNTMYdmU7VziydpaN5wJRHPBvBu26RTxN1NCeQPawnLLku8/BvimXAolEUQv2BbtPQymPktjkNF5OIlWLb4dSZ/FI4UhDGngJXPS1ivMSF7OwySWe2ai8CDUm+Pnl47VHZMq8YAeXooqWVyqNInUKhWLYaus0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YUiGqi9k; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X++lXOunx0+JwbNTWv4z2lHMxxC0EiIRi3RD16AP5Mm3BNeOTZEIPgQJnZyJOKtWkwCS82JdfU1feZ5foZNoJ8HMEyoFi3PubLPJyPAnVIR+Hivyu4kUZuAuN3MHIErT9keWTvk2lhfP8BkW1Y7lE/WH9h+T13Zxg8HDpkNXqIz39GwkblCaw930FwilLQeugGmpR83y0omaor3qffmq0IsHN3Cq8lPuUPyityoCvHe2SniVJSlrHVE4BHiBFAK4r1hWWwFM2Hlkfq99JrywAgR2It96X6w3A2ktFdJfN7x3tHht2+EclMX8DqjrsriracF837nwq7Jjp7TOvqgTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QekM0muMH05kCvJf8WblyLADqXuVT928CCeuFdA9sLQ=;
 b=InBOwHTS2yL08D+tGBvsgvVhsJ9SbeUEj5WbednLh9ueUgUtQYv9ITHbDWH09bFlOm/GTOceY/UEE4ebH6ll8vf4X365CuyrGTgzej76Nr6vnHu3sOKlCWgdg7Np8pwEHU49K3HnbEnpbmwvRUFBelZXU6lkWxzt+WjohYPMqY9AVMgEdimxRsjZIzCT2FO2pMsRSap4M75b2c2zNJhQp8vTRESDqKWsa9P1BPjOqeTOIEG5jN6yOhNPNUlMY0aJq8wzts4u74PkiQh3h0IYkxbrL75iPZP5agThY3boW4NmicIgOa5TMTvwleVDFgkBpHIFLAxxVk+B+Roii8Or+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QekM0muMH05kCvJf8WblyLADqXuVT928CCeuFdA9sLQ=;
 b=YUiGqi9kZ3OTlaKxsRNxstbyeord1vBTwdzwCF4dCAXyWtxMJrwFhRr/0uEaKak1Q/3KrgA8ikJMfKk/VqWjknTxoaN1hJum/wPJKxhIJ7hMZEvedjGthz/ZcsAlL4lzhkFe0HkWHltEohI0HXriJk9xfQaxezsiOn54Kq+c4S4xuKxWcMsah3ECGhxezKASHn/pxBzkkXIRvAL0PCCTsDcxQ3QEVB0Aepk9RPFtFHlKeefHanlqh0Or5xMOpfbdEa+4N4mgZwjZkWENgMaFkLvq5Ek5pg3zZUfZZD7qVLTp973Icvo8PlJEZaaWKci4PNttcttKdLxuwmRPF+x00g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 19:34:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 19:34:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/2] clocksource: imx-tpm: fix next event not taking effect sometime
Date: Thu, 25 Jul 2024 15:33:55 -0400
Message-Id: <20240725193355.1436005-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725193355.1436005-1-Frank.Li@nxp.com>
References: <20240725193355.1436005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 84afb012-8043-4962-4822-08dcace0c647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEca3I948bmu0rln+7GYQKdMzly8aZZt1KFYLsf6cvn50iS07rstr2SsAiGQ?=
 =?us-ascii?Q?RajzM8ytZVb4BPhINdMQzTwMfFvTKWc3y6NFebyeC3hFjIkAdnUXzCvKHAae?=
 =?us-ascii?Q?wstoRFT6SAgV0JysyENPcytdNiAz9z0OQ7y6YddaTkpJfXcLJ8Q8qMCO+tKT?=
 =?us-ascii?Q?HvNpB1vjGmox8tL5noip/224ovGTazPn1bjv6GpoMl5JEwd1tlk8rvqZCqlH?=
 =?us-ascii?Q?lSlXc8J9qlTjsI3NwxqnI7UQtroi9XkcCkqWCKxpZlrZzmKFavUenftG4ecr?=
 =?us-ascii?Q?0Y/QExNAlIjL1e3ughOb3s+Zz+Pmw0WJqXMvQAU1vxAGSbXfV05TNaWveTNP?=
 =?us-ascii?Q?xxV2mjCGPD3HwRpCmOCMUc+k1IEb1RxLwgjXiJu6NEYKddprwi+IzkwAu+Gw?=
 =?us-ascii?Q?sS4jnuycc5+zm8qVmEa1mGRN3U8w1TSGF7Lus4lN0f0Pj+jCYCMgfxp142Uz?=
 =?us-ascii?Q?bowSBdTUdepywtxpWP7KmBUI0PNCYAlR5dVyjCTi7NkizZ5TNtX4NJjmoY1h?=
 =?us-ascii?Q?IQVfk/jBQ0l9/ry69IJHDN19HRNw/5uJYEIQ/zgn5ScC9bceawVfMZeyWxV3?=
 =?us-ascii?Q?z5noOEN84NprBbf6WuUFjCm3GG9Fn47zGATWeIsvk4HGbkY13nY3FRqjYcZd?=
 =?us-ascii?Q?a1a32n0Wg5OF9oST+yHz+mDAidNdTIG4W25mvoCxsISFJ8kPKG+D0uvY5C/r?=
 =?us-ascii?Q?fwZbWT5KWjU5smWWKMgt5XmbTHxyaQgc2Fm5FceypREqmBHE5CJTGELrI8TF?=
 =?us-ascii?Q?PhyQEh/dBPMuTBvG2hGSBmxH9kUGgY5Qd1auvDT3ItWtMyUGZThR/5eHpMlx?=
 =?us-ascii?Q?zg1FJxIvFo2RfFmoKOUhIg7qjZCkdeqorYzHiwHshIYjR4cW1BPUTWaxxD0m?=
 =?us-ascii?Q?I36KWcws0VY0A2xswZezmEUE+AFZGQXQ4hf/T72iJ6k2EQQlUPtjp4/ZYhqG?=
 =?us-ascii?Q?zFpsZPPoRzXv81TDpUSBp8FUUEsGqpbKGEjj66WRoM6Is3jJ5CWHk8hMA5TO?=
 =?us-ascii?Q?37n6VxeB2B0tqWwljejrV+Buqr6HegfZBg5c+JUdTlMMIHtcYy1LJdbuKoxn?=
 =?us-ascii?Q?fwtNUQxrgwx7m6oV7+b0HO4Gn1hMCIUi3HATUP3XYGwccR4FzyvA6Vf2rFt5?=
 =?us-ascii?Q?llEwrSeqC05GyybPhJ4uXcLDTs+Uu8TeqYSgrtw9nzUKMv/fI0v45k3BpnsB?=
 =?us-ascii?Q?67jEpocuBcAkv7pHsOnL5FSWJ4mMVLJcnAP3gaf7HvoiWAquBjUQNraULehv?=
 =?us-ascii?Q?+CrgOCSGY7lZwHJIcYbeqIXRHQ+bnAEyq++282ZbV8+1eggNqOdskTlPZR9k?=
 =?us-ascii?Q?OEJQXCItOe8oOlyuHKcnKCdj6hio3ukX4a0HlePxyZ5yEr6fdVNAt5K4rA7z?=
 =?us-ascii?Q?sA27d0V3WRCJDkS/CKZlsQqh0OdiC2uFXAQIFxIFAYu8JSvv5u8+SSgT2lJc?=
 =?us-ascii?Q?6qlG9eTNaGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GubiVGbbOSZu+31szOseyVpSAYeEWuIO7BGIt6n3CpedbUcNGqigE38cPJ38?=
 =?us-ascii?Q?MSWkbCugnULHloUdHqFUkc9eoTb83zBvRCYAqJvrlNupK3+G+04/fz3MyHZG?=
 =?us-ascii?Q?ge0p7cnQ7d0YlajhwCy+gFY8w6qZh4McInQTggK/ekH92aimheCXgO3Q4XAT?=
 =?us-ascii?Q?n5dh7NuErR3Lwzj/s+/k4ePQWHDbg200wrNXag4FEu4d8YSqpiq8T+m7IYDa?=
 =?us-ascii?Q?HaDoqD8en7vl11ldDpx7vI6fNR8RI3cgX0/KAnZrcC2tnYty5xU79S0pQiH4?=
 =?us-ascii?Q?60EGzRZyRLSF4jDMbuZ52ad9B7bSA3V7ZpG/6zhXESyGdhWg1hslVfnQCc8E?=
 =?us-ascii?Q?jq3O4J2P/wLhXYGt6Tl1wijquOWgac3heFcSVz66+/4XtUMbhi1wLbPso+51?=
 =?us-ascii?Q?vJmXBCaAtrBYRbvMlkItujr/cKmqwBON1DRVcMOAHH9RuyRRY1C8f+3C4c4Z?=
 =?us-ascii?Q?VnXNAOBwdHlIeea4v2DJ0D29dlHbacjhG8PGUKZNFW28v18t+n9zwkPg5Gzw?=
 =?us-ascii?Q?492poV45aSyI6n643viePo5iTm34uzkC6bEfj0AYOwYPjPY7alGqYAegwVvC?=
 =?us-ascii?Q?+h0PaH2oNTPne/MKQas9DLa79f8xzRU4Ex5EvNeVUaZgA4Mo/AVOQlyBABWp?=
 =?us-ascii?Q?yGDrccxNa8wn//nizA/pXewJkrt4LAyCNZIyk4WujOAfvLDk38AEXfg53DbB?=
 =?us-ascii?Q?9c56+yDqSZYtY1bsozNmidWLAiRBJClRW4k74TJYIGlmtduNcwgj1PxdIe1k?=
 =?us-ascii?Q?SdRBpFfh6bhLPHTr52Ea6vCPWLPVQ+Hk3QKkbkRi75C0OBPXnh55yVwO/hnn?=
 =?us-ascii?Q?yef4/o6GccovjR298PywFVIbvavJdp0qE8Cqj4dw9ikbod81ZTS0EeSxVjY1?=
 =?us-ascii?Q?sf1j1jRjL1Bz/TLozLMPyDLmkgr4GLKY9FCSLetpg7AMtXmUC+E6/ncqqniH?=
 =?us-ascii?Q?D/Gk55iBrviQmSMJq+3lGcpZExAmY1KI7aEU1gY2s3a4PeWFms+/dgyMeS55?=
 =?us-ascii?Q?lFK99LXn8jxfwIonHztsIPx/qOcEaRG8eYC1toi7GftA3jCI4NfB6sxSLd72?=
 =?us-ascii?Q?2fvcdcdV/icX86SLTyR3HmW7lGXPi5igxPV6N6QNv0rd6aKMEjOzpjkcnxhT?=
 =?us-ascii?Q?4RrTHSrqSmlLnHWPCD3fk/lhOBeor/sit0xAoRo28iQ0NILSYiV2i1a7wIPF?=
 =?us-ascii?Q?VLIvT/KO1L/Xmhqa5QKV55XxkVWTI5N1GiSRF5ZKxArnZ+30WcfR9VxbLWaf?=
 =?us-ascii?Q?wgfbCZSgUJfmBQMqpadnl+gpCEz18VHzJupNrIZnFy4nsgz9z3u+77lWw2SG?=
 =?us-ascii?Q?vFFt9JlKJtY8621QCSYl78lSenqrsfsAZ9saKCWzMYGnBpMcxu8JXLy0Ef+R?=
 =?us-ascii?Q?YSbQAokgeoiizbQxC0yYveKg5IS+vcsQnT4qGyBeBmxWZmwSUtVbXPpehdsm?=
 =?us-ascii?Q?iMCX1dHLW3RnR4V4YWuX4BzwpyKxyb30Hr506vJTTmmkG2U/Fy2+j427YsLT?=
 =?us-ascii?Q?hkQUgtbrjw0fK3QIhtkgTG3fY7vlZpx7aKpkXXMsHetABwnkYXK2eGF3MJCb?=
 =?us-ascii?Q?iTQ79BkAA4gOVIceTj4U8MJzcgyG4pa/QvN7/6/X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84afb012-8043-4962-4822-08dcace0c647
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 19:34:18.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBFz4uLvPccRwA6JRAqvRxe7FDzWf3Pc43NzrcfsuSQzMQ8kWjs5UgjBNinAlsQudX851z+/pY0y3D5dlV/KpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791

From: Jacky Bai <ping.bai@nxp.com>

The value written into the TPM CnV can only be updated into the hardware
when the counter increases. Additional writes to the CnV write buffer are
ignored until the register has been updated. Therefore, we need to check
if the CnV has been updated before continuing. This may require waiting for
1 counter cycle in the worst case.

Cc: <stable@vger.kernel.org>
Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index cd23caf1e5999..92c025b70eb62 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -90,6 +90,14 @@ static int tpm_set_next_event(unsigned long delta,
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
+	/*
+	 * Need to wait CNT increase at least 1 cycle to make sure
+	 * the C0V has been updated into HW.
+	 */
+	if ((next & 0xffffffff) != readl(timer_base + TPM_C0V))
+		while (now == tpm_read_counter())
+			;
+
 	/*
 	 * NOTE: We observed in a very small probability, the bus fabric
 	 * contention between GPU and A7 may results a few cycles delay
-- 
2.34.1


