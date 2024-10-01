Return-Path: <linux-kernel+bounces-346352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A154B98C37B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E16B23A32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BE1CB526;
	Tue,  1 Oct 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBLLAz6K"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1191CB510
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800306; cv=fail; b=oKXTSYZWXkGO7OYHaYgy1Zm2HRexZ9EQsVhzzEoEQUJu5D/oNYfA97+/fVEGcUAh25IERlvYhgweTwA9uvKlOA+Vq2SMDTJrk+LLHDjuoWygRFhDAB115Xrs1k+DZYPx8C1KV5XiKeeKDduq4/XouhvE1pLAqG6MTglQQ1xu41Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800306; c=relaxed/simple;
	bh=kKbaKl87MYy95QXGpNCjNdogVafEM+UVLM9xSLOVfKA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KobkiJJ9Db8fAzdVWj/89nx7QIQTLk7NCOMnEevstUHFBDJDOCVQBXsXp+fgtcstfFY1eTHiFtxsSjTIpaEug85cqfk3MiKa8ADhxXc5QbwNdsIARDK/BnYpMAz72I7g4BdUaoud9BmuYhaGywvzDBffESU8mGRPNarqIZkLkv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cBLLAz6K; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv+vHuCSWNmBnGjjKqSZzSB2NKKCYgnvI9zAgTA4ZNC8GKOismD4+jv+haxuQ8e85NlJKiU6kQNxm6m8SrBel+sjaSrGIlh1Beuo1zYV4ZPzo2x7Bbu+eWP9ETKrtq7Gy2APkHOmUrPoLMNOTw1zLCiteJpBhpAWWj4wic3Gr+SUwCuv2O2sZo6dySLwKAzgOr3lhcKhMOfFMbGedqfn7SnQKsZeTmGOG1YokyN/SyC+TDb6jFuW3re4AFCAXQKQ8+MV4Xt/nEPMVpaK5b9CFqNgJNSguN/k8exNOSoer80s6a+HtFOODG6KT+upRhNqKnjU9K+4rHShkd7lRxt7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0K4hB7sGkLSgnFHwqzAOa0zhRzQYfdgw4edcY5fPow=;
 b=YY2rHvgJm6tNcBZJ5vK4ay+HpvIlxG7oG95C8fsGEClJLJQzeyqCKsm060SNIDi4Zl9rKq497MKUjVueNf11Cb8Zid3qxhoMR943f0Cx90hfdtGIVszgUS3QPCh7KdHi4AAZAQWCruYemG3Rurk/pTZavMYLqrdb1u2FJDKIaoLn6deH31FGSVMtoFLyYKbssLWfEZfZed/KjGD6+sbSxvLlGgFm54ZOROU2ViHR2hR/H4Tq3x4nUKmVq5ZLZ2/uakT+32BCKgPPNwrbdsQ+fIE2HzXegAPq2LaKI8Mw0tznPn+cPxATdd42hC8Djxc34xrYmfOn3V5mHk7q9V/C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0K4hB7sGkLSgnFHwqzAOa0zhRzQYfdgw4edcY5fPow=;
 b=cBLLAz6K97cgCVj6H08fAJ8XPrYjudj/EsPNE5wgAZAco8WEksxK9odBpnI+/eOnRI6F1NFE5WKyCRGlX4gcNHC5JhNOMAJZ+LCYiHYSUVdQXMptwc6pcsVMBvo4MXt+buh7h47zWh1hZfJOPBMZqrYZcXEbQaPGcl/QzNuyrrDTxBCG973MH77oEhKEpWaGPMt21/tgTcUzAxPAeoB0ptLZEAhQ0tyfKMrhAnQo3pkYCx0TVpMJ36gwZznwOad1RvQCvj6rgR1Ca8tScrl6A46zVvMWFwn3/VJAJbAsgGru3A2s81fiiXKBuDqUP1/HCOyLVrVbUxUMHcDmj9cajg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI0PR04MB10805.eurprd04.prod.outlook.com (2603:10a6:800:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:31:42 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 16:31:41 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: nand: raw: gpmi: switch to SYSTEM_SLEEP_PM_OPS
Date: Tue,  1 Oct 2024 11:31:05 -0500
Message-Id: <20241001163106.4169421-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: f68fd090-aad6-49ad-2fb4-08dce23687cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Qx5E5dxSTkAHvoRDrHCh4uctOOEKAWhBVmTCfh8erAjI3Fnw2hgFwWFO6MY?=
 =?us-ascii?Q?8Tqje81SYfbKczpZcEhNtcK8yxk6vzEwUY9r948rKygOm1YWGUqkwYm/+mjB?=
 =?us-ascii?Q?x0k0382HK5eWe8O2iUiHZHnfSn5u9zbZXRTUm8Ri3jRgvZZQTOH77b8kl2hN?=
 =?us-ascii?Q?aQoL9nwKNucif2V8I1CWkRepioCUzK6l+Qvuam1n+MSPYLvELNFlDGonmXz1?=
 =?us-ascii?Q?hiJLx53lzPd/ycvibbxX8Bb1BIwf8Vl6YRKzYekY7UPjkv6ddqrrUi5IaISj?=
 =?us-ascii?Q?Ql7G6DesU4Ii4dIbhfbDty+5CipVoH4xvGyIl5VssKKA2yh+kHkS0NCzHc+f?=
 =?us-ascii?Q?WmZVwZvr6y3evfm0jOeOE3q7HqXwkr2nVc6LQduu/W7Apjvhxlz5w8Pyn3NM?=
 =?us-ascii?Q?CuVSXuVB5q+qrdKpLaY3NuZXYY9JwrSCtOSGHMaeSc31BAt3dMIkagj9mK4l?=
 =?us-ascii?Q?3+Afk32YGaY2ykVrED8XybpDd9mfzb9OZp7RgCEDjhU/GryhjGdS4oLVgY2m?=
 =?us-ascii?Q?NxBaTGdupzTMWGR+EyYeUghROLwQ57u9PCKpHcaNtfnA+LT8/cLJPmXEcF00?=
 =?us-ascii?Q?fvNXg1Tb/cY4KmHlliqgNA4f71JRooADP8QWFFgR1YQ4EAMNCK1tBOtKLwXG?=
 =?us-ascii?Q?sNvCtsyo1QI7dZG3/Twl1WYvLtPA7lOlKG8WiDQQc2SCgSovUG69hSM64ERQ?=
 =?us-ascii?Q?SBDTKtUwL40TrbTbCf3v4pvmA5mNY28CgqwSkTUX6s65ypKkRKiP0tmARjz/?=
 =?us-ascii?Q?3wZ143UUqEmxTLrW06A1q0Utr5ERqr4xemz0OXyhF67LnY9nJi0jKo+Dftyp?=
 =?us-ascii?Q?sRZUwaCGmiEA5B2WC//lAI21BbG73FsT5U4gN4l9Yw8BFs9rO2553w0+gLYT?=
 =?us-ascii?Q?6gNubInISFsXG/Y1G/5n90VMB7kwYI4K2CGocQYF9zcM+ufPtNHlAlmLquJi?=
 =?us-ascii?Q?kYO8wK1UefFu1jaLYVW8BuUHfxYqfqUpufiiNDHonm9bwoUTeF5P92E/d83v?=
 =?us-ascii?Q?drW3oX2N0x2DVZZ7LrIaQomDtXunLZcznE+2PScBZ7Bs437/sUy7OxU/ZiGu?=
 =?us-ascii?Q?cnP4NJ9ZqoeqKRzv/Ozn3Rbe0xzXHEgwpNlHv9yEldNyN1CTcCiQZGKBr08W?=
 =?us-ascii?Q?Wf89YeYgI/7jbG+N73PSIVghWImXeOOS01QEFbQZ5EULVXsy5ELXcMNXfsEp?=
 =?us-ascii?Q?rmkw/P59HFhHf8yr9rbiy6sSYVUBZOhyfvOmJLFqf6ShDruD4tEOm3ewK5iq?=
 =?us-ascii?Q?IpW9K+w0yQ6SFlmxzCwIaF8J6SsF0IMXfiHRLT+DxMAOulB6qvMlfGnSmCNE?=
 =?us-ascii?Q?zD7pWxOiZL+0CNnPO7HY8SoX7+Of4M5ntd/nG0QdOHWOHmMWDos5hnJ4tTdx?=
 =?us-ascii?Q?aWL1ARAYkm4G8XR1vpYDWduotja1uPhoyaTA6ZT1I7AxxumRvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vdst2IPCseCwbjA0injnorCmNXl0c7yqiM4kv2L1MJdFX+nB6fC1BW0JnP/6?=
 =?us-ascii?Q?tlDTobWwPWOYW6IJStfR3V6xaJgMRSNJqCeIpslsNcfUpdTUnl3/goXQl18v?=
 =?us-ascii?Q?S2no4evuBfcll9aT8rRdkMP8E0qtYEkASMMbNWZCQtJdrZ+KlErbX/TeSfqk?=
 =?us-ascii?Q?QdhcwMS63AnScBjWwEF2690sNgGX2R8hQEpx4QTDFKVrmQlwoj8tg9kCAJvQ?=
 =?us-ascii?Q?3lD6siEcyCPzTWsrOt67C1lOFOLJC4zvL6bkmCIvoZB0yhRa7SufrTQwKqf3?=
 =?us-ascii?Q?+n5PSH4ZBpQr9LcpVQ9mOoAqgH+dOc1nn363uqJ1+uTV6eB1iIaxxVP3g/lt?=
 =?us-ascii?Q?SkY9yIdSKOPfB4wYhbY4pypalTyNCHrbpN+LuAGKCuW2cMjqw/wlR/Vqr2AX?=
 =?us-ascii?Q?zNIC8e0jwirg6HNwWhYR3KMu0kW9AhQcbZI0IbIcwVtpDE4nmohJzwoXGxcj?=
 =?us-ascii?Q?bneNkUBoByjfFBbtFmql6xUxDwyNH4RLw2YywqdlslXtRfIVpSkDCStLXFNh?=
 =?us-ascii?Q?wK6QnBzKL+6J9JMv7xVL7raAJVjmbK7KrE1gfWXQDjU3eI/f1IBJQ6jIojEF?=
 =?us-ascii?Q?HDRUuof2/eD9kC0lO3nwVETA6sVUjCSNVqEBf38PMhPte/FlSe7YqSjaX6OZ?=
 =?us-ascii?Q?hzjx0FNoBxVAhecUFFFzPFj9UOk8YmRYh9K2GZtuOhkwOmYuZSKwh+2HBmDa?=
 =?us-ascii?Q?P09Xl/ElG6rdnmky+NG1Fcdn+Y8CHgbug5WkHI9uF9L1RI3PDLg80nxMJXZ2?=
 =?us-ascii?Q?6IqLj+R6T9Q1WYAvyD89iN9EsS81g3bZDFvI5QhROj8DoC6HYXUlcvh21ZQD?=
 =?us-ascii?Q?UdsWdMUa7dDy2d5FV1sQd9kNsfSBiOH4mIFH2qFPLodWsStfAinWllOakRTA?=
 =?us-ascii?Q?fIFuAzFyy2UfKcmCAQf7jINKVdBNdoxmQEgieK81MwpRgijXipGYoQOpsn1M?=
 =?us-ascii?Q?KiX9WyuCmUftky/ZlkZbVYJKF4yORve8rEthQFMdf59f5Iryv1cSvicwMfNA?=
 =?us-ascii?Q?0KLQWgDyq0a+xjd3v3Cza47Xrow31OICKsHsDVSI0MuYcAq2jbbmtadLVyaf?=
 =?us-ascii?Q?6VPIATRalOhGeA+fT8gacSNEKK6zptk1X7pCF+itT14T/y9TJ3lVy+zypq+t?=
 =?us-ascii?Q?EJlMRTwub7PorXo5updXJhOFX1ToJOgkYTa+xPG2rBIzJdkH5Z/BSDyCk6tY?=
 =?us-ascii?Q?GmSw2oHrTJxa3afpyCZyo5aCo6Jg9BHK7WjyI3bllkMAZkrOBeTMvlNY8t4k?=
 =?us-ascii?Q?lZB5V7LkpjLRO8bX/V9kopL5O+Z5uhuLfD0gOSU9KLGCPWbiUhmsAlCQKV9d?=
 =?us-ascii?Q?FFJP/K6lGj4Q2NRV8yVv9hCJT9qS0fJkOmDSQwKAxAccxdsPLPVOuU9TvPIU?=
 =?us-ascii?Q?NEeBAPNXoFkcckpLPEEpU2u99Qxvkx9YHcbGiPERTBQPP5KqhlPlo5KuJfpH?=
 =?us-ascii?Q?srFWWjwDndEN/Sf3J5AL+beIPXbv55Q7RVB759vyM4bnmZGwRhqaG/E11ztt?=
 =?us-ascii?Q?nH72r/IionkLbQao1brlr4827TGzrPUwVfLHrd13k6SSgccOW/U8zj0exux/?=
 =?us-ascii?Q?IwGtqQoP89pHTz3zvhE1QJbfv7YdzwT4DfObwZRh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68fd090-aad6-49ad-2fb4-08dce23687cb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:31:41.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X2lnZfN2SatLsuUjIruVCQcm2cH7cdYVOQCkqjzgjhVe+WvyY/K0xkHKoKJJ8An
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

Replace the SET_SYSTEM_SLEEP_PM_OPS with modern SYSTEM_SLEEP_PM_OPS
alternatives.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index e1b515304e3c..b7a05ca4409c 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2811,7 +2811,6 @@ static void gpmi_nand_remove(struct platform_device *pdev)
 	release_resources(this);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int gpmi_pm_suspend(struct device *dev)
 {
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);
@@ -2849,7 +2848,6 @@ static int gpmi_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int __maybe_unused gpmi_runtime_suspend(struct device *dev)
 {
@@ -2866,8 +2864,8 @@ static int __maybe_unused gpmi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops gpmi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(gpmi_pm_suspend, gpmi_pm_resume)
-	SET_RUNTIME_PM_OPS(gpmi_runtime_suspend, gpmi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(gpmi_pm_suspend, gpmi_pm_resume)
+	RUNTIME_PM_OPS(gpmi_runtime_suspend, gpmi_runtime_resume, NULL)
 };
 
 static struct platform_driver gpmi_nand_driver = {
-- 
2.34.1


