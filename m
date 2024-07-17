Return-Path: <linux-kernel+bounces-254961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4039339C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E3E281E93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC333B791;
	Wed, 17 Jul 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c18NNvB5"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBA2D61B;
	Wed, 17 Jul 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208385; cv=fail; b=Cm2gw1BsyuJ4XCtsqfAs7tHwpvdvCE2B+LKaXlfsZRYE59xWijSC1xShxunciKANrQk5RfIpF0mYgzJgm9pgE0o7q5VEyi7d+ZK9cF+68Oe+C9JCTsGcpg//n+aysWbUhQHGSFuaWoKclXzTOtgLPDsUqESegbPxHisB3wDzFT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208385; c=relaxed/simple;
	bh=qzKBGS6VeUapWY5eMDvDdWJa9LGcsJaBQlK9McLD0cs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KTSQ8iXooa7SPVqmOwHLxE2tC27fjDLdr43UGxJSjzqlmNTt9PDsht74oWwdv+Ns9rl9V+3a66kR1SJvrkucqmP9tfWHY/D+16kwojivWN8lIRvZWMenYZUvq3nas39pMnQxP05WYTJHVE8KEr9kKus0gCzIU15k27cgnm5fLUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c18NNvB5; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEkaWNwLSatsjOXTsRAmtoKNnQgZzq0wIrIxYEkp7ydVPZGuCE+wkY0EtnchfGPbytgdWveg/XaPyiPkNXpA4Ri8Dti1gjSwYcsbClEFxIJiRm/uqdiPxyPgm/ao3p7fg1aidkeP/pqa47sZ/q0UOaxsiYml/5s5H7JBLQNdCw+1s2+EXUlDVamn7NUU7GE4YTxcvoyU5EHlFIiCmsqSqNnkOpAmPXEM7SI5DUKiYGJIvG8LxgQP8wWy9H51XOcaOwYTkfINeBAx7vu7PVcQXsJn96RX1UNMjq/PEz/5oF1BSQtvwkRVKcZbkiJMLoPeu5z8a1oKEWy2Sex4D5Nqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6No/akmzq0Xu0OdMS1/eT6CGcfoSRGGgGEw2lPMvSM=;
 b=Utw1mBzcVOEt7Lv4GhCl/skB+3YZZ486cdIZJ7FLRfwkzy4W5Q5g8UphwBS7RSrWVwAIsSlQ+tNdb1/0DgLx5KiMo72qaKPLsLpaqnNr0AwRWwoHuTl0zbgpAMlxQ9WSn5pYBOjvOohU2Q+2/YL5B8dgjsLtsd0+hXC6iTns2A+0Vx0viP9oThL8JGcBOudpfZY0bBx8fZdboeLAIU+NaY3v68c5in68L/DxV6xD22/hXsQS0z9wFVPTGUA2CRDMM5Gy6t2CV/IDtSeIUo+DpojKRBnUF7eah6DdOpDkQAZNiV3Dw/sMzjS39/bCy3H9jWoregGzgskw6YOMwgmNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6No/akmzq0Xu0OdMS1/eT6CGcfoSRGGgGEw2lPMvSM=;
 b=c18NNvB5ROYDZT/D0rgVBNYFajVgrJc8+nNiIXWgPEYnHzuafZtqsvQQ26KPrPT1FvtYhUXQND4Q1grFyEeoExcyozKVReckuZA1c7s/XoNbKyD/6zf7ttnOvLFR0MEi8yq5xu2akBAn4no+UG/PVYJsBmkUkindWul8ILac87M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7424.eurprd04.prod.outlook.com (2603:10a6:800:1a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 09:26:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Wed, 17 Jul 2024
 09:26:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: bus: bypass set fwnode for scmi cpufreq
Date: Wed, 17 Jul 2024 17:35:15 +0800
Message-Id: <20240717093515.327647-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: c41f6d58-e0c7-4b5a-5f60-08dca6428328
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXKKQ1o0tsdDBXotjnOmC+NsMKlT+KbmSAI0NxKcTE+LjJ5CzQk6S9gsjb3I?=
 =?us-ascii?Q?d5AEVKKu6SU4Rfl38zmsKl7Z0s5BT0xA5ykLKfOkM4kL1yhRxP2Mz57bwoac?=
 =?us-ascii?Q?TFad+oWzG8h+GuK9woAjrbYJiHauxAfupmnZGAWFNBZ/O/rCpkkxGrSWavjg?=
 =?us-ascii?Q?6noD/2FtzeqPRaK24zSOQr9ovEI3mFa/7ImmHvcU8BfaE4vAdAQ4IoxCku/k?=
 =?us-ascii?Q?rYEZXsdXiPJfWwBz13km8bKuoyRO9Ir+jR4kFv6JIBAGaXqZQjH7RtbYBZ+J?=
 =?us-ascii?Q?vjnoRQn8JC8ch19DCLg4wdcobElxFnkqLOAIrxRbkBFxJWZiw2TfxDxOTtm6?=
 =?us-ascii?Q?aAhU9sH8ailRVqSI5TrO819EsUv9fdILGbRDm0E3BeBlTVEy3gRuG0cdeC6k?=
 =?us-ascii?Q?2zjAmKBDhoXzqesTsGPMn9lRd6yVjoHQ+ksw8SoKZPUs+3+6y+bL38hLVdhz?=
 =?us-ascii?Q?BZtm4N3wewPkqlM8UqWC6MNHpMeDpnM9xGEbJgQEy05yV/zYGq3ApwpeBAJ8?=
 =?us-ascii?Q?l55sJaY4zLX4HbCdG5fUeohvOb+0lPLtomM6bL3E24+yRXamV/aL4OhxtYIQ?=
 =?us-ascii?Q?/U+71Aw6GOWiNZ7d6Jb+fIZCL6TUFm3lA7Kc3AqoiOTBmUXxWWtChB8VW225?=
 =?us-ascii?Q?oZiiGApWfFBaqkrMbWY+ASpej4bFLnN6mqY79HDLaOLpkOkwWoqBSKHF/ABF?=
 =?us-ascii?Q?MX0Ub/6RQYza5klBk32Arw0PQH/By7V/4/wqeDM9Y8YG13cg8K8hLwT9/IAz?=
 =?us-ascii?Q?9MdfQv8B3Rk7KSXLuJ0IISbJRMs0vZTmK66qImphqNO/f3INkIdsCq3NrQz5?=
 =?us-ascii?Q?tzwZHaO5AqFHmeCrxLsCM2UBAq/GogWnE8FX2dGUzu+zBproSx40j7PKJCgv?=
 =?us-ascii?Q?4MaDXwiSM5g/tbLgArXJRx5uqyrS1Ju2J5T+rDHk0/SEmq9Ma2lZ2ke01+6m?=
 =?us-ascii?Q?iP+seUauJ2bcqNnYRupxxtztHE6u4TUxiUilDW5WPDe9Ky3QlMMFaXrwrfj2?=
 =?us-ascii?Q?HWZPG111GItDIn4uUsH7LsBdLfE3b/mXOrNISUlUoRJIt3RrhZp7RMOV5y4g?=
 =?us-ascii?Q?qUGS5dyDGPf3XXlAEByrS/EaFnk6QWvJmfxYwSo7CjlSWWZEqlfqsSN8uilT?=
 =?us-ascii?Q?FCU4gKTJHbTO93Gr29iGc69qPpCMhcisheTfTTKzSwO4iHI90lFrdtosgz8/?=
 =?us-ascii?Q?+oGCEcPhhEavps+IxMgE7ysqmGZT+2Wk3MABI7rzpM+Ie81QHjU8C0Gn+Nmw?=
 =?us-ascii?Q?BfK2SyDfLrcXyNmfd3rzXxkBa9OdD2Bbj/oBH6M0sb7ePd8XL58nDMCwXBnL?=
 =?us-ascii?Q?4adxat0eszUhQRGi+7ovPsJDdMBhRROrhm9U9FzKNPg3jjX0doFX0XMkPo9y?=
 =?us-ascii?Q?RDgdvQlHM2RHCPeei0szy7BcHRlUlfk3uMqXV1z93LaZb9MnhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rgutCSQSss2c+oURP9lf91s8VTaSkya3Ob8CMmsFPo6A+eEb/D65rZhKzXaz?=
 =?us-ascii?Q?k5xojPA0fQOOPdHtKAgN4io2yDO+4DjgKSavAu86jH/xQ718xTa3Kk56s92b?=
 =?us-ascii?Q?sF+7ATyubh9t1ugGyPzm96nIhLqYnMykPpveixzRLfy8xSWMsECvhbej9V+P?=
 =?us-ascii?Q?dns/919dTG623goHcfZNm9fmxSw0hes78A0PhyNuqXAqv0yTe//Ahogp2IAP?=
 =?us-ascii?Q?stPAokercLs+nTip3313MkLJB+Hx/LEIXGDaZmIfx9mryYF8X5qKNTRO16yG?=
 =?us-ascii?Q?JjKcT2oUu+Th70PdamGW6lsV3JMGm/mbpdIceZ2qXUQmMv+3ibVSZHRoJ4Pw?=
 =?us-ascii?Q?TASqguXdI/sv0m45fmTOp0gTr0nVehRMUsM1Ns5FwWoDfNBp0cZ+lNFMbKaj?=
 =?us-ascii?Q?8GtClSLtuROG0cfoK15mXid2cvjoUQVgstOcqcTw2fqkCrKRqK1rKNN2zTrP?=
 =?us-ascii?Q?OsoHDHlvrVyjWzB7vIPmsbXcsJhv8MrnjXFFG+PLuO/yZ8qeVAL1y7rp01OA?=
 =?us-ascii?Q?UoN4euKgkzfjPKHG7Y5zCu9yPkvTe1IEcrBfiTWb+sND+okMKq4fJwjOZK4Q?=
 =?us-ascii?Q?1hK4klEOsyC+m+I/lxB+YvcR4SuYNW7KrqD870lfNhycpzSJ/jw7KPUNNmgk?=
 =?us-ascii?Q?R7nE/yg0sNhHH+889xpotHUIMV9XECYQaRDrO/ZmNQhVnOQzGTNLdzXU1IAp?=
 =?us-ascii?Q?JuJVp7pLz9SYBxiaCC1hpzxAs2wnta0riBRaiVVFWzQkChufZfcy44IsWPe2?=
 =?us-ascii?Q?VuXiNB3ag1RFAHroGTTVsOhLOli7KI/GMQ14LjkLZ2DtuyNKTsa4eUghUee9?=
 =?us-ascii?Q?Q4mvfNaORdMTPUTqKLfBQj5MvpVYrFUCVDscdY4bWwNvXwUAprRqJGEIKNDw?=
 =?us-ascii?Q?nHC1Z8uTNyq++OSb/FOO7BDqLKIPfY/1wkIkuOczBUr0ROpEAY2X6+vngLyI?=
 =?us-ascii?Q?vlveZeGZNw2Qa1nRFAq2oFTWE7tdNe4EtYMTZUHPAIUmQ99gJzgp/DUb9Z71?=
 =?us-ascii?Q?kgVDuPGYU1ZtwTgJ8A9G9p7xu0OsVyUQqG1maHeKbFXZtAiiYk76HTu3jN4W?=
 =?us-ascii?Q?Jw9Gb5GdGJCU7LGfrtOCNhOGN1jPzHAGzp4Qu8lmMbYyAjDLpRJ5U5YDP3FY?=
 =?us-ascii?Q?tLyKsCQY3rNrYCtGF7lvMJ/1wCMR25OAuGHqs6AE5YF01gGDwbVpP68aWrEF?=
 =?us-ascii?Q?hbiFVu5Sx3d0mUKUIYgxHxXTr0w7nkg3iyfYmPHTtrsg2upBF7CEFUtcI8Gb?=
 =?us-ascii?Q?OUCqePO6DdL7fnVL5YizAFJMXRVyMgxzHJo+/4+RALIWsAh5gpr8YDFr+UW1?=
 =?us-ascii?Q?E7JpZAts6M8Bh3JFY1Uh4lI2qaBC9VaRd12qTWS/M5McFdO+/rtYTKPG2VhD?=
 =?us-ascii?Q?zPfyap0MilLhTXJ4QFSG5jGUrhDt1sYK7ME8+kqVbCYKhwNBuGLRz9xg0/ZW?=
 =?us-ascii?Q?8JSjFqdOSPEpc7jhNUT+MoVmRDzup/3n6mwPJj99F3ZcUsRPTHMB7bQauIXL?=
 =?us-ascii?Q?qq5Mi0jrkZ4PRvBmsXOcFLU+5GeyOkdiGwT9RIFIcqvlLy218CY1YxmfIUBQ?=
 =?us-ascii?Q?C2QFRFYVS1Ijo3fvvSeiPdF+pNMEfzovRws34b3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f6d58-e0c7-4b5a-5f60-08dca6428328
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:26:19.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNLtXrIJ6SDzM0XnWfrhURmIn7Hnk8HM1KDlJ91k8vmxXWJQNJqqENVnGHqGHqUCKAtdy3Ofc+xg1Y1KVztPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7424

From: Peng Fan <peng.fan@nxp.com>

Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
SCMI_PROTCOL_PERF protocol, but with different name, so two scmi devices
will be created. But the fwnode->dev could only point to one device.

If scmi cpufreq device created earlier, the fwnode->dev will point to
the scmi cpufreq device. Then the fw_devlink will link performance
domain user device(consumer) to the scmi cpufreq device(supplier).
But actually the performance domain user device, such as GPU, should use
the scmi perf device as supplier. Also if 'cpufreq.off=1' in bootargs,
the GPU driver will defer probe always, because of the scmi cpufreq
device not ready.

Because for cpufreq, no need use fw_devlink. So bypass setting fwnode
for scmi cpufreq device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 96b2e5f9a8ef..84c8e2714cfa 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -395,7 +395,8 @@ __scmi_device_create(struct device_node *np, struct device *parent,
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
 	scmi_dev->dev.parent = parent;
-	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
+	if (!(protocol == SCMI_PROTOCOL_PERF) || strcmp(name, "cpufreq"))
+		device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
 	scmi_dev->dev.bus = &scmi_bus_type;
 	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
-- 
2.37.1


