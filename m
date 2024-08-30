Return-Path: <linux-kernel+bounces-308252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2A696595D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15427B253EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967F166F0A;
	Fri, 30 Aug 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L1rulOsA"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2073.outbound.protection.outlook.com [40.107.117.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC71531D5;
	Fri, 30 Aug 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005054; cv=fail; b=bUWoVZtEq6Zafz9JIOZeDWeUEZDQrZlmHjNiEkR+D8ugMo6s9+RPdY02XzFNH6cwbF9aaEIZL9Lx3HmW77tmbAtt0+BDpIzPazsmo2Lsfor75PhUIZcBXJ0BtLnbkJyUJzO5dKwvFd8dBmEXy63w+irRMr9U/iT/CTofVQnoPuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005054; c=relaxed/simple;
	bh=LjCwgEScOvAbj0GrzJazkZfA2d8BHmBkdrB/mcUp35M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T1kMBR38o7DImcR5L0lWB8pDINOFhq8rlNIg5aIpCSkNdubJ1baCJFQLoM29yl4wmsNfRJlqm6phuymKlkColRGx4+EtwuGUOV5k6Zd5JmjXI5bQNFyTy0jYnPUsXkokI9xb2YHuBQoQkWymKjVDH7d+EBfKhopTC5osG0BIsuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L1rulOsA; arc=fail smtp.client-ip=40.107.117.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk1aRxfVor6TOYP03hiebdujzUhvmzGU1xhJYA1atmv1W9+CDIifNU1r6RJKk3JE1zao9KFlneZNK1m5UdVJgkD5rvAUZiXBXkG1Don0tr+sSyl6kNHduwpyTHLsVfkNtkncQ4feoxnuAzI5p1uRDiv7O/J79yBuPDSTC5CHeE5L+Zi2u2cIi1p0gGCwNISLQehn1kOVvuEvN8YwfOMLHk1z13SFcOVqD6zWb05bTPX03kVwlJ6fK7Wrd43ELL0f3lav/OVCnOBKnX98efgd2Cgnj341IaTwX3RuWm1pVjPm9DGRqg2QxtsrMVOV5xvbvEW2llqEB25KgGYKbaOgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XZq6n0Dv4iLZQWkJkQKPGNPoR/wYUtrmeOz3rvopVk=;
 b=LvwNOtLiVNaWFY3B0/NDSTHUnuTZH1Y2+QAdBXgtBeRh3EyqxfZnAC4HAxLfcQh6JmiunRNA6RiB8T1QSpNqSMm3KRamd65rh2Iha+tIYr8hJCBDfA8bGPCNiMbqE6EApthIK4acXNlDig2T4awcSS/o+0T1vaNnIlBg68stuOgufYl7mEpsr1WRet0IIqQfLe8/e/XbuaFL5BZz/0likONqDLbZ4Qsy5sUpeuBpnoJ4IAk6r6o6wEzsf7IVp5nOsV52yGprxgV7UKlkYydhKpNN4ybpYbDwCoXX4YPFu/OFTAScCWb8OKZw98qqcCAHpKt0uPqOkhwlx8pwxbFvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XZq6n0Dv4iLZQWkJkQKPGNPoR/wYUtrmeOz3rvopVk=;
 b=L1rulOsAxO/NhsNptqUpDsTgMRiBHs/jy+wV32Noz9kL/6uXwqAXNWPDHg65XyoBMIJ/1QZGn/tkyC2cgLDp8XAEM4XNUljSww958lPJMxMS7QQRFSdXem8CkDcYCEwa2g32WegC7rd8uCPuTMb8xXbP0F9qU0qOc007G8lO1t65E+FijQicXCeK/3lsYCtvOy/c0bGBD1riT4IIOD4v+SHLGJ3s3e29VGYhIoIqtppVCXX4Vj1bCWw8xO3W8SOPQtGR6bshnkO5w4QD5AWB0uvuVZVUo1iX+llqzs0tQkMlvULTvV7p3G7UA5JkmRC40jTElV6rrkwL+xYUwB++jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by PUZPR06MB6068.apcprd06.prod.outlook.com
 (2603:1096:301:112::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:04:08 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:04:08 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v1] clk: meson: axg-audio: Use dev_err_probe() to simplfy code
Date: Fri, 30 Aug 2024 16:01:03 +0800
Message-Id: <20240830080103.12811-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|PUZPR06MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 778a5000-be46-43a5-4492-08dcc8ca52f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KgWRT2m+b8C/ima6GZEZXzYRjuL/V2yJxNulSKSqaqUk6Oq/CR6eH3r8z87c?=
 =?us-ascii?Q?aUC7OoZgcD95UkdB/cgDQgyKd1rj36mHgpAaHzIOj6wfF/CTxRwa3FV2zxg2?=
 =?us-ascii?Q?9qACMCLo23KPr36J/8FpSTxV4R6gWjKgvPD8UwLCa8/eOp4/UInVEsPu3Lpy?=
 =?us-ascii?Q?jmihBTy7reBKPtwI4zzI/LmwvpwE42Kti3luHSonFXoCKOUvDJofWt0zKD5s?=
 =?us-ascii?Q?OIxcrPHwWudwR8PD+xzTFsmMsE/o35jZj1CHiMN57EV58rYWNShZtbDcrKwP?=
 =?us-ascii?Q?b+W4Z/VxGIH72OuEgZnnJh7FDAe7Yril5ffRkwgoT4dw39wAHcg8mfYXSuXU?=
 =?us-ascii?Q?y9b1MRwikDgLkzLtZNHMMEKAb3NDAleJvJSu+7GlLL8asT0zDD+uYt9Det+j?=
 =?us-ascii?Q?Gnhlg5h90UOJJyNSCOa4fqckzVGUSqtINSnitv/NJ+I0omO9XLq20kTWivEc?=
 =?us-ascii?Q?LnIwcaHD34UmL+4AOSgTBnam5hcy/P8CAKl7mLY4gPndg6G1xbpGSZiBgCAG?=
 =?us-ascii?Q?LJlFfPhxdYlE+I6uUo2Y4pNfmIqfr8Mj0tFLLiuqYjzVz0tHqp5z+wWg/x+m?=
 =?us-ascii?Q?jW4STG5btMdpVuz5yyMXByqTlvP+gGPgfId2sA9Uxfu/bOApSY6So5mm0tkG?=
 =?us-ascii?Q?1aH4a+2mlUrWkI2GWsfQN4bzJ2MEYFSPHKXkwAxP10b1eHUSkYd2DrBBZ7Vo?=
 =?us-ascii?Q?NYXL23/tU0rmeEVMWl8ZkB7ShlvpXEo7kNQqqVyZq3pxNxHUDeGPAcdhe7Ma?=
 =?us-ascii?Q?CMb1v4sIPrpx+JBn4FVjhWaNWY/Djs7u0RaIfmWVDiE6yHHbludqtAHtRye6?=
 =?us-ascii?Q?SlCGVs+SpLBTUMhhxETUz+uCd2BeD9ueuyY1OTmKuMBs6NqWyz/rIo3uZgVK?=
 =?us-ascii?Q?ykOg1uWiR5pDdy7ldp6IBg9zygKbdM6qpGUJps9cZIMm1wW4OPqrjo5Yai0v?=
 =?us-ascii?Q?jwju/IHR1IDxN2A7GeLwecbF9Xj68wPDacb3KS/5pffk/zLCCeHNlr3F4Yp1?=
 =?us-ascii?Q?P3jdHfKGiQnyBgt9N0ouorZM4DcDhJYwLgv3jvUeSAFTmKj3Zr9ZeavsJqXc?=
 =?us-ascii?Q?cIMXWGSfTDkPPx5AzTMUJ197nWYSQr5YKc8ccy0JnCB+o6zd6xWnIKFCMRHq?=
 =?us-ascii?Q?ZofHXICT/FfKDiEy4kXg3qgbMQ6/7FERQ8Do8xMt9xaKxK8bGY0E1XJfD9U5?=
 =?us-ascii?Q?IkeKUcxB+EjzOAM2d0jNmMWh1jzzlY/4dR6QkFljePo+oP0YlxKOiImYfdgC?=
 =?us-ascii?Q?urFrxaBNok19V4Bzexn+E7QF2eL45z/+NX3IX0aBAQ4XdU7+E+w1dURH7B2R?=
 =?us-ascii?Q?xx2FsbtqOP7NPQr6yWipN12JmQds5SefDkQ93hBnM2L0ZLO+GR+0Vsy6iHGL?=
 =?us-ascii?Q?mX6kyFTLcopPc2WY5YBBxi5URNCzhbUeicebkEDGnrBCegNg8jXWsyjkP2NI?=
 =?us-ascii?Q?bzduOMJNiq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3BpCobcvDdPrJZAkygXKOLr5VLLOKTC2fxvtPM+8ugy/ZZvEgeo0ySoFWLs?=
 =?us-ascii?Q?7l8VbYuavp5nFyLnpKDC2qrSayDbEIpzohUOc37CEEEgDytv6lKi1smrGeQa?=
 =?us-ascii?Q?7D5Rpcj/8LPN7gFN7/mnS2w+IRSDTvfkpa/LJv9+7+BlVOD6aSgfDJcWW3Oi?=
 =?us-ascii?Q?Bw7crzcZCixIlm70mPN2DNkKBdI1OpbJoG9lpqkv09lC+MFpUq/pX0mZFZIs?=
 =?us-ascii?Q?qcrAYCcya1+Fdj7MNgftC9mKW81gLlAvm2JwrV1ATGALjHBWVTxbjXmcItEH?=
 =?us-ascii?Q?zJr16batelZ6AasVpLBwgeyhSztQBNurlwvnSwB1ldRS88Lj1hbgmi5qZ6Z7?=
 =?us-ascii?Q?YJtqNJ1kGq4dAm4cYbVECgnmgdR1KxFLecvU38A41lGLfQoAMGWX+tt0INbV?=
 =?us-ascii?Q?OEL1ibXXIUuwL0LUBQE/deBpOd8HQsJh3E3WrJLSkdWzPwV8r2ICtyznM3iB?=
 =?us-ascii?Q?oLK6wbn2H5khTVqf9zTfUy6bWqQuPcue7sKGL6GahlBxvaOEfWxWO1j01i7L?=
 =?us-ascii?Q?wiOuGmEN3lPMrwJP7B+bauIz4EOksR6D46gOgKbOjVKtiYC7dd6qZpBDIYSU?=
 =?us-ascii?Q?b5ai3QepJVI7JDqx6RDITMhNnXeqrQ6R+2zHgBJ+irUtHiiD9nwctzlEYwcq?=
 =?us-ascii?Q?Gb6LVETaxGdVmlgdOeTZ45dG2GRwkqmoFsqVdxI23u7xLdB12x6EX9pF8KwC?=
 =?us-ascii?Q?RwMp08cuINrBprlRBQWj62CyJYs8UdY2skjzEv6k92cXTcY0X3Rn5RzmZ/65?=
 =?us-ascii?Q?0HBV+xvU8oeYEQeG8mPk51np5yFiCQBdVOzTPWjO4JPUddBksO+/MOG0q0Wn?=
 =?us-ascii?Q?vKCXH8F2U2WOyPt5oE67WoYxCThHyGsP+cCzFavDe4WH/nWZhT9CUzOVf1jM?=
 =?us-ascii?Q?QjL7LmvODGGsT4KuYVUsxMpImjRAfPm7SCgKecK3hZofs1eagoWPZTPB7XAU?=
 =?us-ascii?Q?83aZEf0bWnOyuwyTxFuCjapPaxq6qvEUHCeybiryCgJe96mBjmmPd33SUFiF?=
 =?us-ascii?Q?/OpA41dtKCx2OM+khH4PJ4vwd4bk1mifEw/iUf5y2lOeNRZJQcUljle62U0X?=
 =?us-ascii?Q?Vwvw6v8llkj/E8u+HrYRjZl5iLOK+p711UdQFxdW+heLOqxOVcCzkInnPVU2?=
 =?us-ascii?Q?5JYkSYtAVwA10D1eiMY7Up9DJhkBpxQh+cao4Pg6Y4Zv6RmM3mW1OcJIH55d?=
 =?us-ascii?Q?G/Vk8kIQ1VowcwOXYVU6JaJBmukll1lQ9KGZRcNX3NDlKAYTXan3tVhofMLe?=
 =?us-ascii?Q?LQ20umxZGHZQ/DCBBKy1OMNVDoXrJSELWJPFMfZJlWw4ssMySuUOqheQLGZ9?=
 =?us-ascii?Q?Pwg7VYkfxtjfIBGjkuEUjF6SMG4IpTRsdQsSnz6zk6pHZ84kEU5FiCe4+7Jk?=
 =?us-ascii?Q?WF+gDIlahIZfOy9LFYO5HW65PsIHu4USlyvVpmlvHaQw3kmNv6A4ya4ra6Oy?=
 =?us-ascii?Q?GP9Q+1HGPccRwf422SKHQNoT75OoFl0c9aGRbDJLHpnFNwpx/QuM9e65s7Ju?=
 =?us-ascii?Q?ytkhKuBiqD42m8DfgrUV2zvKD8RbhYzb+d6q3xVTc8szhDQVHttC7ugJedWX?=
 =?us-ascii?Q?3zGQR7dBYJC4hiwECbeg1/VntjdMhYz3EEELmKiu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778a5000-be46-43a5-4492-08dcc8ca52f5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:04:08.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gok9zHtn0TyPLUHaN3pNwijzm8W3U38lx5mS+wAXSJRmW14xDeerj87NLE1fSvBicdkp6APDClHK9YahCXIulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6068

Use dev_err_probe() can make code a bit simpler.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 drivers/clk/meson/axg-audio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index e03a5bf899c0..0637b05a4c89 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1761,10 +1761,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	map = devm_regmap_init_mmio(dev, regs, &axg_audio_regmap_cfg);
-	if (IS_ERR(map)) {
-		dev_err(dev, "failed to init regmap: %ld\n", PTR_ERR(map));
-		return PTR_ERR(map);
-	}
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "failed to init regmap: %ld\n");
 
 	/* Get the mandatory peripheral clock */
 	clk = devm_clk_get_enabled(dev, "pclk");
@@ -1772,10 +1770,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	ret = device_reset(dev);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to reset device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to reset device\n");
 
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < data->regmap_clk_num; i++)
-- 
2.39.0


