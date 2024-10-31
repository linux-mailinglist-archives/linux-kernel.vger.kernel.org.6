Return-Path: <linux-kernel+bounces-390039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B559B74C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC341C2457A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33A1487E5;
	Thu, 31 Oct 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OS/QHxWb"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9553148316
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357756; cv=fail; b=ufaHDnuCTrdyfZ2MHqu5GQ7/zJFBzSx6H730Vj2gAaTxBsLF1s0R+EDKTd7vE0O7ABaJ8xFnpEO8k0wGaq2w8QCqupev7I7dCix8wzGrQTz5e1IDuRe+XpKTSxbS4HrKa2sGeQl18Ux6iSEFe2A+gNy8b8sebxnEmOJ65fHY5dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357756; c=relaxed/simple;
	bh=0r4NxURoiO2+6a4jBFWO4g/SCV/Ga4Ik2buzdq94shY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=onrApDzdoxy/MyB56s5Piurv+CZPtMj5xzOwr582MAfQuJJXfIpXjOaEMPQ3MAsQMh+ar38GrtJnUD/2ZC1q9jcJzbhBCGqhM5FShG1cjLsOHPNLboVtecLYY9R8xuARbLbtJQPFDC+gZnIf6ECEw2ECJMdhxCSx9vI0iHg8FWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OS/QHxWb; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7oSshkPdIonnY/Taqs/Knrqt2ApQ6nIrxHNYrkxOgVfel6dUHerjKkZHyRYv2i1XDlahJ6iBwnhnB3d51zzHny5BEhoOT+3j+DcMdzsYp1Qt4v4W8obtdgPduV8YYQrL2kYNZ7gjqEUjT/bSd2yvqR7f+cbqAKlBkss6P0iCMIY7yNw0K8K5JAtgAuCsc76Rg67EJwc0A23Wami+FiyukT4ekfO6ToMaVEJi8uCsUC9UdVwi8XZQQpM99/MuqZu0yAh2DMijdKzd4qQrERVibVllGJvGFK4jA7xUTCe0BA05ONZfQ5HK/AKk7YaOJlXFETp909YGgQZ35jP0miMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hDM8/lJ8rslfz5ctGZSvNTS5su6yZOHQ3L+ShCrRjs=;
 b=uX3XKzGTtNiQ/lSNm2/F9KuUVNYitYuf5SRRKR8lwG6jdUGDbFOPkaw6YRegP/Cq0HxWZFjgJvut6nOgM63xoRsxfGsxGtF9aJ8IK7nGCjEEkL+qIbTu5lXJE7LEljvQbNrLPkypkoNdPdPPbv+kPbgkrn0ExE65NCCmmMQ/Kq/b8LN13nCS3SjZMM3kgH+uMvfFl2n6Dzv4R3zKeWNqMxWvDOgZdOMXIDbDR6Lpe2pu4qDkjZ8gkVPujK8x2/FiPo4SdNpApgF/g4AzRKS/B/esIRNb4t07Q4gaH9ncUnVZq4Ri0la+4EkFCfb5sSHBu4/MbRoBfdlmvQbSO/udIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hDM8/lJ8rslfz5ctGZSvNTS5su6yZOHQ3L+ShCrRjs=;
 b=OS/QHxWbPOSNtcUUaQdPDg2qm+ReHFdtVnrk0cKRU/a3vgK8EVVA/UWS+ncCPPZdPu4Rrx2ahfDLzOsLEp+7jyuiLoXTcadRRMdsrPL5XmCaCaVNHBxKRNDvpQEIKv+mQFTgMyHdZfFL/flHCCAYjZ5sWAK8yJFMWrx30AP+aA5SIvDZrciOb/1JU0un58Qnyvwrk26hH2pWG0CiOp1H1oemmZeExhzdYdT8zuj052MLhavHc5RQQGpBhHg0CZHDI28QOtgszrL/XoQzDsu0m4hBeAcSwJmMxvDTXSRcU0jccaP4U9EAFXav/ExdvlEpZAV1qhJd7z2zgNxfG41hvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 06:55:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 06:55:48 +0000
From: alice.guo@oss.nxp.com
To: alexander.stein@ew.tq-group.com,
	wahrenst@gmx.net,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: [PATCH v4] soc: imx: Add SoC device register for i.MX9
Date: Thu, 31 Oct 2024 14:54:38 +0800
Message-Id: <20241031065438.3912960-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e1421d-7cd1-4570-91a2-08dcf9790d13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VBgBsx8IX1QAsSXVcfRTs6GU3EXMM05sF0wQf2Sloy1LklRrckEyz2ozL0ag?=
 =?us-ascii?Q?8uEDG3Jk7iP8nPRmx5smYejl1aJ/LwDs+1PIgt1Nn8tOP2OpbjMyvmmkWEZI?=
 =?us-ascii?Q?UcLw2r8JzG2o/GDvxZ+YIsv/5fjZl8ztqiExnp9DQ9dlNVjg39beVMLIxJ8X?=
 =?us-ascii?Q?CDNYoUqzyE/0m9LN5pwzb438GctJPiYa7fTXsT7oNmq6SFeHvnSbo0P6cL6h?=
 =?us-ascii?Q?pKiFsI1l7RBVU5Kr/ujJmYNUdp4oxwRvpQOdTMdaIlBuf9aedzoMetmIQRmf?=
 =?us-ascii?Q?kEApJrH60/e0WsvA1zW+4B7u5tHcg0p0rW8D6saIb1I1muaZTK3LqWSJS2dY?=
 =?us-ascii?Q?RcPwb7dBZ/pMulyODHb/xr8CTuksJQktmm7DlcmKpT66Ib0Pv0a7QauokiB8?=
 =?us-ascii?Q?70+qtJok2zzimHyIlIpntvPcs1HHzJQcJ6/2xsysvxFD9+6oPrjHtHPaVMjm?=
 =?us-ascii?Q?WqYX+bjjJgPss+DC9AeVG3+5HSJJcf5Wo0rqfRGM1oVQBbx7h2FkK+9mi2Cg?=
 =?us-ascii?Q?zlOwv/0ShMRGo7SB5qaJ0yKDExvouWA/+X2XzgEMAtzh3MJujlW8Dg7iNJ0y?=
 =?us-ascii?Q?WeQQpyfXWWSnGDgwmEwBMiTyWy1oH4bIicJ82ic38EkbEBquFdc6iX9dza0X?=
 =?us-ascii?Q?cRbhxlWl2KkmR+mpSnswe5j8Md+K4Hpddx5odRT+u0YmXoQzkZub2IEoAYwj?=
 =?us-ascii?Q?mAQFiRsttoay8C3vHsAxSfBUeelc0enYPo4SHiCOwJV3hcYhj1pmU3TYYfgV?=
 =?us-ascii?Q?O1KgUtj68hOCqTAgZyel9WyOrEs8ZFAbcsdCS5BwXW3W4Qosn0rwKotnuGvm?=
 =?us-ascii?Q?DRMyq9tSytQaRYLHpUb/4AB/K5pCTSCieBLuA1C6YfG9UVWAzjzH8ra/5GG3?=
 =?us-ascii?Q?ymQjvSccGxxBV3DdfrcogBQ/LsHmDt28ukxMor7wkI7L5YPR9iR7etOdJjHm?=
 =?us-ascii?Q?iimGvhNG53snpNBbCmz8wOHioSN4IpBljhPH7/LHmfZA+mKv4sMLOMorYz4f?=
 =?us-ascii?Q?orUEkK1o/atAicnNypnRto/gAh3NRBezrZZ0mouYfiKT5u/F/rHMNTj4mMgP?=
 =?us-ascii?Q?bPhKFNJMmok+7oAcHMQ1+ZtahIX9Wbfg7DeAXw8qPCYaIXNvRRLJvA3S0/To?=
 =?us-ascii?Q?/1DD/ViiV3AVpW1Wzd3nYhBKlnJ92700gDZxUTKol5AlGFv+MbreXQrlNzdF?=
 =?us-ascii?Q?+xqUQ3CxX1l9kiIqdM1FHSAljJGUW8O+KWo+7+qGPUMbUVt+6w6273MiPbUG?=
 =?us-ascii?Q?fSW30cxORe4t3SLhIEjQFjpgW+F04BuUwe82lcGUoL0tTSaI80F2AFzZVOCq?=
 =?us-ascii?Q?uxuHapa+rm36gFd6/oyEOwm8W+yBxqsWV3IfCPU7/hcKPwtZSKrLpvv6nNqv?=
 =?us-ascii?Q?CTDwU/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rx1/1nc2xS71rl6hGZm9AzgLT8CkQw2LGk9MfZME7zRJIFIVf3lwQryjJVXM?=
 =?us-ascii?Q?tUF+wrtK2tBY+weaRNjBjvngeFO/chYpTDtFPpvAAk2w3gRAgqrxCPEObb1l?=
 =?us-ascii?Q?/mMsFbVePnNyxwBxSDJTFtrpsIi8ZoFeW49levXkw2SXZwiEhmRqXeZ6eBWB?=
 =?us-ascii?Q?X8MmfLscdu2k4iS/Epplmus6gb3EYy9/dhQEQIIis5VXgZIrp7t3d9HpmluY?=
 =?us-ascii?Q?esGygPJ5MOF00QCelmqYd/S3eSTUwkA4zG94gRH2RRDxo0k9qoWWh3gXHCl9?=
 =?us-ascii?Q?qpkcDPheZoBTljt8AjrkbvBV9Qf3C/v8YqMNrf5A40fSUu2B9nAVZdNlERFF?=
 =?us-ascii?Q?jgdeiVN4vEPHKCDPAr9xLZoyP2usbgpVuPXgGih6ymAI6T3+xBtn+cb3qHQL?=
 =?us-ascii?Q?faf3mjfa6tle9wvNzyrltqm/EFXYMDy/1F6xc23JLD1sf6PWuuLcTWNuIi7Q?=
 =?us-ascii?Q?QMWYjwy46FMJOzjfTz0hXKcQeZRfYUL3GImEl2CgeA34pnionxfWVKr+C/J6?=
 =?us-ascii?Q?M15ZmS6bm/BFCfE+XGdMz9qg2tmknSNZjY9lBwPto9yk8uHZkq1sr7X7JTR3?=
 =?us-ascii?Q?qrb9SfxRbEh3KYXMDw3MykPdBKD+r40RZpcKaiu61zUTiKtumTQUxoRPIQDk?=
 =?us-ascii?Q?s2IMxWgOw5tphT2O+0goeRy0RwiBAoCy/rAbN+kWRgEwgcQCOx90p+E2/3ko?=
 =?us-ascii?Q?Y2YY8DUjH6VltqtqNdg0CzFenSsuKrejPkBwcskxEnrENlKgQ57yXb44qPCt?=
 =?us-ascii?Q?WuigUPNph9hR02A44/YkDqumRU3DNoxLovloEtpOplrChQRgt6fZzgXaDeMX?=
 =?us-ascii?Q?VvwKNNqJJG8bhck4HI3WqwK3V+dhjQ7uacvhfuz9I5YcCYd30gokksuv87ME?=
 =?us-ascii?Q?c4LeRC0NAeBAy+kMW2c1jDcFYXNhrjPa4eSr3ZpXHzEzA/KQEK/spZVvAph6?=
 =?us-ascii?Q?Ah6MeDKhpaKuZjhteO/CclhJHy7drCcJUZaMF4aXG/uJvjBnrVjE1iyCo31N?=
 =?us-ascii?Q?NaXFK9OULoY7mm5D6NRTMgFUb3lkwmqO1GJnZeG6JX8UfOSKip7FtL99rFKT?=
 =?us-ascii?Q?BFjHcpp85zdy/1DlUmT4aIjR5zCVvJi9ofEvRaPZ+A2fEY2Fv1YkCZxzmt4D?=
 =?us-ascii?Q?R2N80Qm1AJyriwZ1Vq9qqqx+j914/X5NgIWOId4ljxWAw0kRwKAqLJNvd0/F?=
 =?us-ascii?Q?W9SSGPD6ZzG0oasK39pMNii/0s0yrMdJ2h4avIQpj2gLvnvxq3LJB3SQAvnB?=
 =?us-ascii?Q?fiLYvbHIOJRV09q/ie5oA9UbSARwTZiqNzpniltJMi3C76OoU62etM8DR9hk?=
 =?us-ascii?Q?phGezyv/v1l4KePaUzT2jeZuHqqegDWNC9WGG6EPFa+QCaKmLDiQ40xu6hYF?=
 =?us-ascii?Q?DAvMWfTzGxnAijMUfP+S72bAuL8QV2vaJahyXoSoHl8ck1qQ+3ChrgrxvctL?=
 =?us-ascii?Q?q9ZjFh5/1OyirtFXgAgF98rmng72o5ZrXGVGFiqd62Lk+IIlx/X/YWPHGJJW?=
 =?us-ascii?Q?cntbe17yA4uFT+kZoBn09MCAH3VT7cF9p4aB3hax4uKGb7gM2fWsCOz6OrlO?=
 =?us-ascii?Q?/3vNAGlTPfLhr4K8s+JSzrQartCpwrgtwLSB/cn2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e1421d-7cd1-4570-91a2-08dcf9790d13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 06:55:48.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgFOLBmlEviPFiUICwvr4t/kzWDbdk7Z9tYu18NCWVXggag8VU2PP0/WHUw3e1pu8N3OHxNXrRpTYVj48+Yw6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383

From: "alice.guo" <alice.guo@nxp.com>

i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
which are provided by the corresponding ARM trusted firmware API. This
patch intends to use SMC call to obtain these information and then
register i.MX9 SoC as a device.

Signed-off-by: alice.guo <alice.guo@nxp.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---

Changes for v2:
 - refine error log print
Changes for v3:
 - return -EINVAL when arm_smccc_smc failed
 - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __func__, res.a0);
 - drop the pr_err in imx9_soc_init
 - free the memory in the reverse order of allocation
 - use of_match_node instead of of_machine_is_compatible
Changes for v4:
 - fix the build warning: 'imx9_soc_match' defined but not used [-Wunused-const-variable=]
 - add Tested-by and Reviewed-by

 drivers/soc/imx/Makefile   |   2 +-
 drivers/soc/imx/soc-imx9.c | 106 +++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/soc-imx9.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 3ad321ca608a..ca6a5fa1618f 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o soc-imx9.o
diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
new file mode 100644
index 000000000000..3d5df479d8c0
--- /dev/null
+++ b/drivers/soc/imx/soc-imx9.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define IMX_SIP_GET_SOC_INFO	0xc2000006
+#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
+#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
+#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
+
+static int imx9_soc_device_register(void)
+{
+	struct soc_device_attribute *attr;
+	struct arm_smccc_res res;
+	struct soc_device *sdev;
+	u32 soc_id, rev_major, rev_minor;
+	u64 uid127_64, uid63_0;
+	int err;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	err = of_property_read_string(of_root, "model", &attr->machine);
+	if (err) {
+		pr_err("%s: missing model property: %d\n", __func__, err);
+		goto attr;
+	}
+
+	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
+
+	/*
+	 * Retrieve the soc id, rev & uid info:
+	 * res.a1[31:16]: soc revision;
+	 * res.a1[15:0]: soc id;
+	 * res.a2: uid[127:64];
+	 * res.a3: uid[63:0];
+	 */
+	arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != SMCCC_RET_SUCCESS) {
+		pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
+		err = -EINVAL;
+		goto family;
+	}
+
+	soc_id = SOC_ID(res.a1);
+	rev_major = SOC_REV_MAJOR(res.a1);
+	rev_minor = SOC_REV_MINOR(res.a1);
+
+	attr->soc_id = kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
+	attr->revision = kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor);
+
+	uid127_64 = res.a2;
+	uid63_0 = res.a3;
+	attr->serial_number = kasprintf(GFP_KERNEL, "%016llx%016llx", uid127_64, uid63_0);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev)) {
+		err = PTR_ERR(sdev);
+		pr_err("%s failed to register SoC as a device: %d\n", __func__, err);
+		goto serial_number;
+	}
+
+	return 0;
+
+serial_number:
+	kfree(attr->serial_number);
+	kfree(attr->revision);
+	kfree(attr->soc_id);
+family:
+	kfree(attr->family);
+attr:
+	kfree(attr);
+	return err;
+}
+
+static __maybe_unused const struct of_device_id imx9_soc_match[] = {
+	{ .compatible = "fsl,imx93", },
+	{ .compatible = "fsl,imx95", },
+	{ }
+};
+
+static int __init imx9_soc_init(void)
+{
+	int ret;
+
+	/* No match means it is not an i.MX 9 series SoC, do nothing. */
+	if (!of_match_node(imx9_soc_match, of_root))
+		return 0;
+
+	ret = imx9_soc_device_register();
+
+	return ret;
+}
+device_initcall(imx9_soc_init);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP i.MX9 SoC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


