Return-Path: <linux-kernel+bounces-569256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB952A6A095
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80525425758
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB05206F15;
	Thu, 20 Mar 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntCjkRsD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2832063E3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456421; cv=fail; b=n8MBVfpfSj1aCAEoiUPFAxjcsIV3jSI0H9Em13tREZxQOqrBav7cG4g/uewev+fSaqxlgeLAJDuGu9fcpRUjJH5kOboNM3E928ZWk0vbfiz3sD77TLiQMomD7CqIfRXyGRcgxtvc5QMg54IDUcpoXbUA0vdZ3ugl+E6qv/A9suA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456421; c=relaxed/simple;
	bh=jKTxoAxrXvpBn7lWujg+NdqWN89RZk8i/am7nybMWNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQHrRSmguP136AglNcq8alqqmaa47E0hcSou7yKXUIIPOYvzy7H1tKm8wYcGnOk+Q9uj0N3lNoZkPMKNXN15fwur43mbCSMH8enRj6iSzP6WxmU3JxGiBXrOEL6GaaCc7gnli668EWv/NGBcD0B/WWH0WrRlnNEDIV+xo4vaqUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntCjkRsD; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5J309OtLphcGyIKcfkIYaC6K5+F6KpdkxvvfpwmHZ8NdSf1MN9Wsbd/BDRdoKprlP2FF524vZOdUcxJcSpFmOCBmc+uSDDeYRDJ4CcLFPvDuoFsr/hU0xbQipf1O5R7aF5fUHVIDwzH9jWFnCbtWzm9FG2UmoOccoGI8kT9S+wJ4VQA4v83h8kr1hH3PezdC/c+HeSS9qhkA5c4vb+Oqt2/7d+H933xtE7NIvau7b2ztf8qY/EXQs2mwYyfGmKqaVCf0SEHrVa58YRE8KLGbuBD7zdqJsm65G3e6/YrV4rgL9H9/7icRaxVMeHke3juysUUG0k2421AXgj50GdgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz0xGZ8Vq/x5hanX4aF/qX4QQdX3n+4+blVCZDmYCeE=;
 b=K64snwTqTrL1sl+LmLB+Gp2l6pg69VuN9jO5aIf7jR+stzFpm4YxVl3Yi5CMBS8cDYGc+Ao8UcRVQy4uvIHJ4GTFyGhxPtMl+O6WPGDm3ow1/09B/mYGD/0zxbsYay6B9U5wif6Akw7b4cdimrQCmRFm1lM+U1YjL+WhElr1PpPaXm2OJUl0Q6v5r1jNVxlkY4cxmzRvWJBKmRaMMjL67od9s4n9tnoLpQmHKvAMO/l/TTmM9qCXc6UHocKr2mkMlrmOJWI6giWqXvPuNkn0C/+ZX4/CAmKRINjn5R8Ix5M1tVVinBAs4FxhFWMs2eItwWeFxWiIGae+8JliyHAZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz0xGZ8Vq/x5hanX4aF/qX4QQdX3n+4+blVCZDmYCeE=;
 b=ntCjkRsDTz3uulv3Ez+gtNcstgL585IvW27km+o/uXgMl67oXwBj0b0MBivbhLtCOyflwFDILvrpOGg8XNNg8sco9KHvdhWdIOOLZlwx5SNcRIV9/bKRPE+5sCY4RTKE+t2/5vTrVqnZdrVu5LOMpfz/8soi8ekf8DyqhD8xbeWZtDT3bIJ+qW7GWXarF6RStx0OXpUyriNmuhdHGgwKvOw4hhsKJPG3XDyvIzKK0IJiWuPPUW0lf5X8TMwuk5VbA1oTBr9/U7g/1yMcsUiGyOZxilJ5N0vy5Tp91sh2R5CzjABIJByjQGEB5d6C+WNdXii0GWcyfxB5aix05XuNKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:40:17 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:40:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
Date: Thu, 20 Mar 2025 08:36:45 +0100
Message-ID: <20250320073927.216147-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a1b809-1bd6-4e9b-2de2-08dd678275cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ItzH5eG7akVo2v/Yc3ixZqlAck3JT/pD4MF8qcg2za5tZAYbG+AXA+ppfbR?=
 =?us-ascii?Q?277/tTQGXo1cg6hk1zNNMtlQEQZ3TTi0tx8JJfD/g68I2BucrfSowNaZCfRK?=
 =?us-ascii?Q?pLMY8TT0uUQlVPgmsD4ei/Umx/Mly/TU5+19391NC8xJ1z/AvAFpzZGZypG0?=
 =?us-ascii?Q?pYLYRPNMkNrgSTbCgF+nPdJGF10mHzlpA9OrKyNd1WLIW9cfB+8MXwtoME2Y?=
 =?us-ascii?Q?TWj8sfDDfg5mcnLS07A9wDHI7BMDwv3wvRCifAof0Te9NG6S2zFmDdGYT/tK?=
 =?us-ascii?Q?wQbMnbCCFSp1bcHo6meZNe/RVuXWSvHRWOnMoXcONwBlE8bduUuYbNVDmtM4?=
 =?us-ascii?Q?mLJUnbcEaEX4oPYrNoZjkMcNX9DO12FZte/Kd5LXoezNuX7sW/eMJv2Ay7Kr?=
 =?us-ascii?Q?tJgWMRyAO2Ff4nPS73z+yDjB8BhfXsJS5Ys4IlUyRKujAFMp6Rxp+YXyok0r?=
 =?us-ascii?Q?EyB4LXQIjR+hZ9Ul39og1dKEHLG0Xd/xn0/wFajj32Yjlva8D1pG8VYdh6uY?=
 =?us-ascii?Q?2FBXJSmKH7m9JBrJUK6ac8hJSiFOBH+jF6z9UWzIJnXY5YUg7YWgxsHrd6xm?=
 =?us-ascii?Q?QEeX/zcGN3fYR0YumhYfULTBNoF/KFEzwiT15EpJiVAwd2Ix64UBZaVoWz4k?=
 =?us-ascii?Q?T4FWUA9A3nnscoQ89UeIssZubExNWVvkEFwP9jgvAgd2d0IDf7GWk7dXlebt?=
 =?us-ascii?Q?oSL0JsHmJRS1jm/PtshGSEn6BuM1uDgdPVzvSGLwD2XZ7ORbimI6X4WqXP5r?=
 =?us-ascii?Q?SwHPytUD18iXKOtpD8fB9Xq5Pjom/kyLlPIOv6RFiqwuvxjjbZ38yog+k/mO?=
 =?us-ascii?Q?8a25thPJbqCFdb3UxsIEHxmaYu+Hfcij6b7pUlrKPHm+TzNHHDzcvME7sf5s?=
 =?us-ascii?Q?BRlYgRVrWiyUZArNRX4YbdcNVWu2K8fiWAye4EOfEhIKNUKNx+9/kyhmjQXb?=
 =?us-ascii?Q?FHDL4vfizApCKeeWoklWyiC3oC5IrZO4Pdk5RRov0ft8QUWdBsJ3PKAq7F7n?=
 =?us-ascii?Q?PVLW7t5c3pS16bMK02Swf3mcwtKxg+lpmdM9H4RsAZWa8a8+WzsrZaDEXpvt?=
 =?us-ascii?Q?ykgnYadDqu80IEuhcKZLO2Sd3LlXWmAoxvmGHw1cVFHsizurQT7Ue+FcbYmK?=
 =?us-ascii?Q?KFOlUfVjhCaKIhULSi60dgm0T8tjNN0k8yiQk1vuTe19nWAxWfAMw5ezGHGD?=
 =?us-ascii?Q?AkVTOIRVmxMyabd5rMeLmWcqkjFnSGZPFswTh6Pap8Ljgdf4s+N2TyWHxYS2?=
 =?us-ascii?Q?ToTB5Y+x+KnBg5/fYafCsgY0w5KwbNR6nFIo7sOCIxGSxHH/ke2T69+C+bez?=
 =?us-ascii?Q?PSd/jZPCCWI2n8unpM3bbR0DleaPqIp40Fu3qzcuVliyzaaaRt760g1y0yhL?=
 =?us-ascii?Q?I9Vg8aL4nl/X6HLv3Ftci0f2/h5r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MA1SVHOOW54XVCdWeL5gF5FKtlY0EgHzs9saANgVi15fPHDt9rPk2sHGnC2b?=
 =?us-ascii?Q?bEhk+iZ5W4V+6NVpDQaZE5mqOM/dfwDCKrlLKCSkwmRR1xgFipJOT6cozQQh?=
 =?us-ascii?Q?WyiRPafMQd9zNFmpWaGLToq2luM+FSepY6/io8xL+UOf3bNW3TPr2CGuO21i?=
 =?us-ascii?Q?s0kzoP0m0lL6BRqmoYUgfWweRkP5CdvroqauwIJWM9D91lHZ/bK66hfSVqoV?=
 =?us-ascii?Q?vD/wO8/iWgyRMGuiLtdwmCim195mqeqjLO45iQhdGLlC+ZSMP648IJcDx33x?=
 =?us-ascii?Q?yxUB3W6VllFSKiaUBOdP1zNdxRu7+dcZbJAVEsGbToH4Z7+MRab3uoruWnv+?=
 =?us-ascii?Q?YvtI7lEkJ6JF32VcIF1924NK/jGfv9rwYG2BNVTwhyTCVjcFfwxYStgGygP4?=
 =?us-ascii?Q?ohJ0abRPrj0oK+TmWobzdtm08/Xya45RQP7gwit0Vy8ROU8I8ZLYt1FtqxCZ?=
 =?us-ascii?Q?UB3K7rRnu3LbiGDNFyySeuHtH89hPDmurpwHRH+A+IpQ9/iL1Of8TFEit9Xp?=
 =?us-ascii?Q?AOKssnqavJaPzook1fOHvLHr8oo0VMyjAK0BsA2g6AyVvxsDprr42Ki8KogS?=
 =?us-ascii?Q?HRxW7IAfJA8JEsXfRMPXzbwWCeVyER5spKtXXiIbjAcMTRk+KvferqFFpQ/2?=
 =?us-ascii?Q?N1k3IyKAYcUaW/J6bnTHxwgKNo7Jifu57KagMSaDsJyJFvIkp2MpkK/dxr5B?=
 =?us-ascii?Q?EaKlF0JhvSqDGAvvPc9EvbXL/cH1Vnwu0Wb2wcOEGHo+WPDhy/olOg0Gig8R?=
 =?us-ascii?Q?bLi0F/e1Cl8jd+9gAf9fialc0HtIrFqIlHaR3/4nt2iX1zm/Eqa+QHRHJxKX?=
 =?us-ascii?Q?qmgFAfWUKVEbUqh0gznvsARTOZ/XJzMtZ307GDgnUlXYQJgcVGeC+727nAxw?=
 =?us-ascii?Q?wNNkGlmS0QBKkf8erDXs/LkE9KiWyT/WuQzk95W4qpgThbC4/iYGQvnLyvQU?=
 =?us-ascii?Q?8uM1sSqpOrH44fP1isUQJh2hbYVdRpcbjvSfg/Vp97g5Iijb6OArXdfcSn+5?=
 =?us-ascii?Q?jXrzGd+r/rmbenDCkmWNtmT1I+93MQa6EFFhsk69HjIWp5GkoLwFTXF8yExt?=
 =?us-ascii?Q?qCaAVywpR4cq8t2NwDc49jDKu/oDuitgQS2WQtNzgZXbSIW5rCcoNKcIUYLo?=
 =?us-ascii?Q?WtVtRf0neKTJJQO6/JlViokC1fUIIWa0B9tkycilU/eYtOoolssr6pmUGMaA?=
 =?us-ascii?Q?ptWiEK5orxFP0MFXDQ42IrV378gIwk5j6rlxGQgx/wkGModo1vVPBc1jlGHX?=
 =?us-ascii?Q?U0zbVOTiRkNK2abMx2MZchlEnyFnA8M4PE0GM22TTE0nRU5v9QtsPSf6Uqsk?=
 =?us-ascii?Q?fs3eGqz35eJc/uH4Z/9QFNYT12b35PzMSIhe+HlRMEfWeSV/UPPT7IrUtY43?=
 =?us-ascii?Q?0Tpcbj+D8HSNmau0k9PFgtaUY+3dMkLVJP9y8YXJ6nkbAVev6t8Nfuvj4FQA?=
 =?us-ascii?Q?oJU1WHdvD4WO74vIp5Vo/yyOyAT24VbXKJ4/2oBrj/T0mSkPYm7v7+XY+0v3?=
 =?us-ascii?Q?oLjtg6Xkrxoqb3WIKMOTU3DRlsaZG0Crb3nrbjqpvwsIoo1Pg1uo3eHz2ZGM?=
 =?us-ascii?Q?K14pDODg57U18Dor9cCyl8u4/L9YU/cngGmsPQxA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a1b809-1bd6-4e9b-2de2-08dd678275cd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:40:17.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1wc/hD57g/BOq2p7xV2Sw3Kc94n43Qg+qFpmo1dALsgHUQKRln9zpVPd8jW/P4aP7brXzUfjzu4sQre1gG6zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

Add a selftest to validate the behavior of the built-in idle CPU
selection policy applied to a subset of allowed CPUs, using
scx_bpf_select_cpu_and().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 121 ++++++++++++++++++
 .../selftests/sched_ext/allowed_cpus.c        |  57 +++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f4531327b8e76..e9d5bc575f806 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -173,6 +173,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	numa				\
+	allowed_cpus			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
new file mode 100644
index 0000000000000..39d57f7f74099
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates the behavior of scx_bpf_select_cpu_and() by
+ * selecting idle CPUs strictly within a subset of allowed CPUs.
+ *
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
+
+static void
+validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
+{
+	if (scx_bpf_test_and_clear_cpu_idle(cpu))
+		scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
+	    !bpf_cpumask_test_cpu(cpu, allowed))
+		scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
+			      cpu, p->pid, p->comm);
+}
+
+s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	const struct cpumask *allowed;
+	s32 cpu;
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return -EINVAL;
+	}
+
+	/*
+	 * Select an idle CPU strictly within the allowed domain.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
+	if (cpu >= 0) {
+		validate_idle_cpu(p, allowed, cpu);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	const struct cpumask *allowed;
+	s32 prev_cpu = scx_bpf_task_cpu(p), cpu;
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return;
+	}
+
+	/*
+	 * Use scx_bpf_select_cpu_and() to proactively kick an idle CPU
+	 * within @allowed_cpumask, usable by @p.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
+	if (cpu >= 0) {
+		validate_idle_cpu(p, allowed, cpu);
+		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
+{
+	struct bpf_cpumask *mask;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return -ENOMEM;
+
+	mask = bpf_kptr_xchg(&allowed_cpumask, mask);
+	if (mask)
+		bpf_cpumask_release(mask);
+
+	bpf_rcu_read_lock();
+
+	/*
+	 * Assign the first online CPU to the allowed domain.
+	 */
+	mask = allowed_cpumask;
+	if (mask) {
+		const struct cpumask *online = scx_bpf_get_online_cpumask();
+
+		bpf_cpumask_set_cpu(bpf_cpumask_first(online), mask);
+		scx_bpf_put_cpumask(online);
+	}
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(allowed_cpus_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops allowed_cpus_ops = {
+	.select_cpu		= (void *)allowed_cpus_select_cpu,
+	.enqueue		= (void *)allowed_cpus_enqueue,
+	.init			= (void *)allowed_cpus_init,
+	.exit			= (void *)allowed_cpus_exit,
+	.name			= "allowed_cpus",
+};
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
new file mode 100644
index 0000000000000..a001a3a0e9f1f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "allowed_cpus.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct allowed_cpus *skel;
+
+	skel = allowed_cpus__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(allowed_cpus__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+
+	allowed_cpus__destroy(skel);
+}
+
+struct scx_test allowed_cpus = {
+	.name = "allowed_cpus",
+	.description = "Verify scx_bpf_select_cpu_and()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&allowed_cpus)
-- 
2.48.1


