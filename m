Return-Path: <linux-kernel+bounces-261957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E793BE46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18FE283A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF9196DA2;
	Thu, 25 Jul 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WUoUezUn"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013038.outbound.protection.outlook.com [52.101.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B384196D8E;
	Thu, 25 Jul 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897935; cv=fail; b=M+NOGYfxGQ2bXRyJC2ien5JHtURBANw3hQ06Y3itZbGuhgK+4gF3KI5+xwKdy4zhBPwMGmGNIpv5t6TpvVJ7tpY41y7NhgDFpyMTrt9K/s5Pgpj+FsU4QFnzNYeomYpzIb6nPZ/4NqiBeHydys0pcyqMfdJe18gQZxrvl/W/xMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897935; c=relaxed/simple;
	bh=Qyl7RMFebsj4IEx7FgxQEhHZGkcsSEZsFkFD9AhCnwg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b//rC6IHAnRWHj49BjSD4lVw2DeN9VGxWsAR0gw4nS2KPLKuE1qcguWkDnOS5JS83x0dVrdpYtdtB7CpXUoBEiGUiJSZiu6IVCXZYMKUnhq3P6jYtA/yFI52CZa+WVTUl/WEXI9bG29s/yZyo9XIzqgbO2crSoA6hMgI8/lmFpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WUoUezUn; arc=fail smtp.client-ip=52.101.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWQwRWT529+A02VOPEE3b6fUzUbB6oeBVjjrOJUjmRv7je+WyfS09DeT8r7uj+gFqQJVWrbiajeCWmto7aKn+vRMhpGA1U6AX766mKJhw1sBDTbtLwbM1gJtJ2j3qm33TV6A5AjNdSP+ShtpVYaAvRwWs613ls82gBBAzOrAxaPzI9cov1lSIryRet8DlM5U0r4fZziF7zyQSzN9GALD4ZfHkOcHJ558hVDx3GpneIECugl/kYy6qNMguo1pHFKn7TINlzURCMNF/M/6RSV7BGreSYHx08t17ZS2SbmXN8BK7GSqbd8707AEznHLl+SZyanLt1Sje/zfrbZnhPu5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prx8q3Luk+2gWBiDRsHl11DCO6EizaYEn5wo2kmuQPE=;
 b=dmnnhiR6AdnwtdbRLzMEqQlDQfgXNfijKcfgMuUlPeUDwrGpAUKHD3tOVMUtEqHcveTQcVg2Z+j0IJPlEiS1zQ540JOJ+Rzhi69PVzm5BBRiVXrdYjxkzMb7s8J2Dm1fwY9uwcf4yIazbMwC4jrChEHjH8omQP4NB7nE4E+58pVazdiEb/kqgiZJW+hUmKXPiKJBDXhAtsOpBy49qC2uLaGZiPVh2mqdakHKV2lppE7AU0zNLc/A82xn6FDsMm8c6zywLmrfPd0W/j4EQay5EsUI53/GNBsdmQSyYwI4z4bEJk6BcYQ6EpFUdZe+pN42yTojOK7fEPN9d2tKxGWi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prx8q3Luk+2gWBiDRsHl11DCO6EizaYEn5wo2kmuQPE=;
 b=WUoUezUndmjh+xu6FkAjkjHTaAOmJAzmHRLOpHTYUu77SGoMPgeiB1DH4vSwTNxWJHY/cm5WwC82RszEp81aiIAfICWhbKUbU8s01a1i0dvBufq6ZlrIATAiSebsR11Skr5Rc2Jl0pG4YzgTUA8vfJemfOsi28ih/IgCMpmjyGNh6P32Xq4+cdk+xoszAanMeb9nJYXXqInXeSzPP7e/3JF3AGOdRypVg7byEaGuHoNBJWrZfo1MVfCPROpxZQzKVTdzbLy5XcuMZSrNCCt+2ADyswFG60p4dwHsvgp/7tmDi0V+tGDv3NvYYMR7VDHWAthpP+GJQ2oB+ydGyKa5Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 08:58:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Thu, 25 Jul 2024
 08:58:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: scmi: add is_prepared hook
Date: Thu, 25 Jul 2024 17:07:41 +0800
Message-Id: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: c8baf258-681a-474b-db16-08dcac880016
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DGbZXD4OjSxV+0kSUepU+gTrvCMBubfMrM2J7y2sCzv596B6fwKEyyjf0kJK?=
 =?us-ascii?Q?VAmu3rIK0XlhnEjiv2qQg/a0dNhXIv9YTdhoHsWZChgNk6KH7wVfADy9U7uw?=
 =?us-ascii?Q?f/pbHoqtyeZSoV4Hs3xQsC5rS/Qh2RokS+czEIUiWy8tEYVk+kzkRItLJ2QN?=
 =?us-ascii?Q?ZV+TKnen2xFJh0RmPvTHrco0UIUMdMKaM6c9/LRJalyGvQP1w0VTfEq4yd63?=
 =?us-ascii?Q?Ie4YKy9+VnkpWkshoex/suhbWA0VodKMzfPIFEDURbOf+8k0RF/SW2kOYgod?=
 =?us-ascii?Q?BfKq+A6OjaHE5kb2jW0DebJBJKJrallBzHy3Yc6gGniPkkl/HsE5QG56MjTf?=
 =?us-ascii?Q?s38AwST9AIwbNTCKcMly81jmRTnnWDLkRE2XAZRNpzIYrgfdklI5gF9CBtdW?=
 =?us-ascii?Q?vMdZ9jG2nond57ALO48jBESB6/5feXdL0VVSuYbS6NgIR2RAaFFfAKhiJptf?=
 =?us-ascii?Q?g/NOCUeGLS7QtqiG0qYalSHRMeMUbxNIRfnn9DRK74BtqN+tRQQGdREP9nTu?=
 =?us-ascii?Q?lWPV/LIneQ7hIlH6/9mksVsvdQ+fXxL1xytqWCZBkgacSkWenVOXE7f694Xf?=
 =?us-ascii?Q?YMteJXHaxkp7rlvkyHT1KzKmkjNEqMfZS9GOSO5zZZyzCQKDdBQ+zCjexuda?=
 =?us-ascii?Q?ymRbswT5zIhxP5WvqcUEA/uojOdDgFwGgeBHAxGO50QdqaE3NKdZAg3bvR3F?=
 =?us-ascii?Q?l0Da/Bxm0tIrR3TDLGRTIhrs574Mz9JMUgK5ErgINXvUvzgdfh3MPcv/1X1O?=
 =?us-ascii?Q?xxvjLPAQ/2KmYah563jCUdSC/jKt388pvGo2H9UCApoQ0sl0RO9m1GcUCsS1?=
 =?us-ascii?Q?1z33bnxZr2eGZYlm1xVMSKXCCQljYi/sr2m5On5sfxOgfqprCfT3ySfwNg0H?=
 =?us-ascii?Q?Y7iw+UJl8f4lQOrsUDXzrC0hbBfleOFn7Oyq9HPiJrbygyshT2BqnNevIfWo?=
 =?us-ascii?Q?Ar5kvO9ve5lABKLCCKmm2FZSQufKAX4G6I9DbklD3MyUPCv0VTHY5BA1grlO?=
 =?us-ascii?Q?3jhY6hZg0ROaJFGmZhFHNixn8yMesK7B6KjoiKzOVdCuC1oqPcNAUvLGr4QK?=
 =?us-ascii?Q?2ejOly63MIc2v33jfyWRE+y/W78m1fD5Nw722Z0EbCEWmwjBsYVS1uVmmdUz?=
 =?us-ascii?Q?hrM1w0wPly7yFO50ua92bweZxy/oM2Pm10UNzn5DGdLWTperFc1N9klmAyzn?=
 =?us-ascii?Q?/vx0+liJPBOUqjlUuPPdcjGRFq56f+/+qE8U8nemicG32Pmwc47EDNlc8yos?=
 =?us-ascii?Q?OlaiKpKGdRdP/2I/7jwYaMpwpL8HX9q/B38PMId3tSOoW7qf6VOL+KalzuBT?=
 =?us-ascii?Q?SD3kZnf3PwEk9zEwIuU6sj6Ela8WJxrdNfgqc6LciF1qIkQTeoTMzxAMl4bL?=
 =?us-ascii?Q?5oJJeF5sM7m1RBMUd99wZo/LAHC7ishUqY+t0SoopOzPKu0tIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txqCbMCeKp2qJJSykeepQhxcj5Ls7WRJSwHH/eOiRolZrcstehrRMNuvlvni?=
 =?us-ascii?Q?Z/Zx1q7/bbDZmVdDIDTuTnRkoqpgEPqES7ELslDIEmQMTic60Nq8fSTlUnId?=
 =?us-ascii?Q?sx/ytwIC+GmoW1WcQXkc1vD2etqvpnnTfV87E1OsnNcXYIYDxATtUbPfC771?=
 =?us-ascii?Q?UDLI9AuTANM253dIXjD9KmteeHw30iVO5rwGJ24uTzadhiHomiRlNPygKKaI?=
 =?us-ascii?Q?NZRxYf8MNeGEiFWO8UV4Gu5+pJ8VefMqLmQqkakPf43siSc1t0fqsl3MQjp9?=
 =?us-ascii?Q?r6R8eEjDCG/UQRgFlCDl5x35Qu19wuA23OkwFiovKFn/auotjsH2Cxtc8zfV?=
 =?us-ascii?Q?Do9ulNmq8hsz37qOhBbmJUqdQ96IcqeS/+qd+Zlv8A5EYLq2wXmyR7xgDjCj?=
 =?us-ascii?Q?a8C53hCLPzJQ3WtuDYFXRkB9rZ/Pv75tB1ZiicI/JrBEeWPK9pFh0e+8rInt?=
 =?us-ascii?Q?r2aH4ATeJLLdW8q6KoxINTWWWjBPa/JerAPqIqgBNLRFEyIySI4ZxU7nr5rc?=
 =?us-ascii?Q?sOsb258NsVVcdOfLqohITr53Ft3oC0rNG8+9tLXXOPWYBdF/ymsHJeEIhDOc?=
 =?us-ascii?Q?fBf8NgUs9djdAbE2Lc3PqriOkw+2E9tVfH0EKpdsBKlIGpbUyoj/Xm2WWyYg?=
 =?us-ascii?Q?hBAk7cbOZCW/DVQhfexXkin00vMQa87thfwYOSEPVO0GrOBR4QbIbH4yVpSv?=
 =?us-ascii?Q?1bxAj0SwhtUUmMuokoB1wgqCNFeKJrdt0rsgdeFHwg3hPABs82YKt1r+yvGk?=
 =?us-ascii?Q?yOEKUW02DF1pJ42OisTvoeI9IQZNwQAvP1uWiRfruyADhIEKk+9Et8NOogkJ?=
 =?us-ascii?Q?SvO8VuukGl2Pzsg3FhLIs7EPGnngeoI7JM1hu8NEd9Xb2Im/9Uu9eQRkOh7w?=
 =?us-ascii?Q?rA8HbUW7UMe4/zuXcLVsihegCw55aHF4idlVPZkEcIThn0QBmCp/cpKGqCIX?=
 =?us-ascii?Q?oPYOL63nk44i6senvCZcGEvAz+M9RNdI4f/bAgvc8kPiqMGV7ikMkBizXtb8?=
 =?us-ascii?Q?miSXzf4QMpv8qJZuHanDtB7Mdc2/PYJhs70e33MNkQnY0rs3dT6ytjbgOpTs?=
 =?us-ascii?Q?QOsnC3zmpDDC7Yp5fDtKEfgIpGACg9+p+s3VPCv2vdLQtzOaQKt5Zj1jt0jH?=
 =?us-ascii?Q?l0vLBDxc3aZE4fQjrR9vaMNzZaPClnySq4sxke23OlOvrQtd50a6ucCet82r?=
 =?us-ascii?Q?ygEy+ufBvbQnL/svA04HoA86xOweV1uU0r8tLWBs8OPFOkWp+iEgsUEKii3R?=
 =?us-ascii?Q?FFBB4QegCAoRxFC/NtQ8jTTnOUImi5pr5rahgBjEQcN6nM4vOE8OI0XmHpHQ?=
 =?us-ascii?Q?ixL55uANsQ/oGPqYUZKZcnuoR0vaXXHhBPMAMcXxJ2dGeOh8n/rx0j5ay5ce?=
 =?us-ascii?Q?QJ+N2L7dWeaK64tz5W+Q/dmiPYGQcQCkPZqCjXy6087N4dboA5Ue5mGV1JnU?=
 =?us-ascii?Q?n2ZfljYl7ThdVogvw+syiCxtxejN7Vmy1uMAL6spnFv7t0bqzYFCNO+0SYvH?=
 =?us-ascii?Q?ivSoqdXp2EL/gZ3OkgkZZ1KWGqt5LXdMjy/Dikp8pl3s8RQ0uLp8q/aZL9Eu?=
 =?us-ascii?Q?Rdp/xYpTNNFeB4EMQvZN/G5T+fjOkgd0/m9EYgHu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8baf258-681a-474b-db16-08dcac880016
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 08:58:49.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQlquTWNTbnr2NpPEwOfUNSmL9tCUWKjiKqBTR4nIHvQnwqK5LKCFWtsZqJv/HjoEuVSqTv/JwqXZ+DzIqHfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124

From: Peng Fan <peng.fan@nxp.com>

Some clks maybe default enabled by hardware, so add is_prepared hook
to get the status of the clk. Then when disabling unused clks, those
unused clks but default hardware on clks could be in off state to save
power.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d86a02563f6c..d2d370337ba5 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -142,6 +142,20 @@ static void scmi_clk_disable(struct clk_hw *hw)
 	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);
 }
 
+static int scmi_clk_is_enabled(struct clk_hw *hw)
+{
+	int ret;
+	bool enabled = false;
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, NOT_ATOMIC);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to get state for clock ID %d\n", clk->id);
+
+	return !!enabled;
+}
+
 static int scmi_clk_atomic_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -280,6 +294,7 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 		} else {
 			ops->prepare = scmi_clk_enable;
 			ops->unprepare = scmi_clk_disable;
+			ops->is_prepared = scmi_clk_is_enabled;
 		}
 	}
 
-- 
2.37.1


