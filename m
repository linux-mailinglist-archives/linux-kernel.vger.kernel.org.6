Return-Path: <linux-kernel+bounces-386506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1889B4451
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC75283AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C046202F7C;
	Tue, 29 Oct 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lof/BtzS"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2681F7565
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190930; cv=fail; b=Sf2Kvb/vCoMq4A8FRmlbPZJzJh+ACous698JErBBJVin1f+X8QLPUug+NnLR9bvaThsA/4eEBMx9b5ZbZmm2dEpAWLFczYSrm9a9kUEdKxr4JzEX04K0EWJfOI4mL7qIlzMQ/GW1N2Phpgc3ABMcHoqKtFauA81OAxpUa/VK0Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190930; c=relaxed/simple;
	bh=1mwC+nBkurkNiV1DISaRl8G0T1aZ9dqf1ynJqOBcAQY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ui+srFG/Rkunhp0SNvc0/TueaEgEDtEtuU/H600WSaDfTKknu3yT89oMALIMqQo1WWjF7FYnczPpvTYBuF15NAswd1J8tOopJFxYl5OOtRPZYmKScyzydKLEj6V3QLb4cgXA8T6wCGGq+gMLKZCH2QKFcckeGCsm/ON/811tywk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lof/BtzS; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/AucUM1f26MYSU1/HmkvxAL7tlPgb80MEfhxNKUMEAN1VnIekJN0iQsDrAlNK2lgd0bQo/fCMqRF+0t9TPFuPe94RbIJVfqAyG/K43yVYc9TNqSdtAXR6lsedUt+k4Z2MRYGRhBl+KOJcPXMfW3/H2BiOyTZb1iRXL1pH+ERnBgP/sDvKz+B+YnfpFu88tBtQmhQpWf04eVQ1sGuBB9S8KcitP+Dpa9GHz5PbJG4P6Jw3fLOY6S2OqilJvNaI6xkqTZyR9X/Nu94vxZVUsuIH/0nmPLroBb/38B/4Y1N1tR3Eg2mS/WtExspFCXEh1xA9F+yogi7PcdeBg3Er+Z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5pgSCHzJXwo6cIDYVBvfWIgX8/NedEJ2O8h0eOlm68=;
 b=p/8Fqp1SLvHhLSm2PT0QURRc8VXvK9E2pJSw5WltganZg6rK+e8xsWd60XeRV4C5KhP4UREFdIeMiOWCFN0GC0Mi/CZ+tNz9ZAEl5Gt/gWaG+yUS46lLBqgi/FUrGpE6FZaWg7VKaPOuve96C6a5sztcUf6wf7KxSFqZeDb3MJdCy+8Wip7SCcXzYdMxicdQeLQQW+YknjY6Kn6KtZKFJgUvHaZZAgPr5x+m71jr3L6uFfUZyJj+rKz33NBInbVEVxjAmyxFpUY8HV8jzKkEExhNjMDHu65By+WXO26SyZdLgVVMf08fYXc01zIhKRVUblLRgxcBcfxUC6/duM1v+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5pgSCHzJXwo6cIDYVBvfWIgX8/NedEJ2O8h0eOlm68=;
 b=lof/BtzSo4Ab9wdT3XYede3QPJ0ISCkhfKZGMa3ImZs6dv4elmBTcXAP/dcJ8ax5Ot3k4fJKTJ3jh8jMafZP6CiHx1UIbbqkIQpdjnUkaggqnNe3enV6Asi69vQWEAmvjq2y4YrWTXTweV8Tbh6ixnjmnX3f/5elMcfQVTThVpP4KbwWsbCRdUSwJgh1R2cymISOuntx5wGEvt/Falq1GweDmX6opQN6R4tWvpXQsR3sbx/0i0eZqrWK6+FK3vUsLgoHF10xxVzmmp1jeRFMIRdf6BDocyj3AqIoUvOw+ifrlU0rqxYBt6KHhz9jr39fe/wnqweLepbJ4DwO7khEsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 08:35:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 08:35:19 +0000
From: alice.guo@oss.nxp.com
To: wahrenst@gmx.net,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: [PATCH v2] soc: imx: Add SoC device register for i.MX9
Date: Tue, 29 Oct 2024 16:34:06 +0800
Message-Id: <20241029083406.3888861-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: c2862358-c05e-481f-6785-08dcf7f49ecb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmKdiZ78pcE8BbLY/sIgksHFx6x7zaFmJkUR2+tXiXbarqhQwvUMEwqhlsxg?=
 =?us-ascii?Q?nMFWfntJeMuO/6qzBtqHB5V1KS6CTstSbzkoyZP6IsXNgKHDPtFz3Z3BVZa5?=
 =?us-ascii?Q?i73Dc1kBJsTmZlJO5uilE9jE1/IgtE/1H4zuyuWVLK6apKW2ARce8cMEPFfB?=
 =?us-ascii?Q?EK2GjnR1rGizqI0T3V1eK+j+tY9x/fJ2kmGLQd54S8nPho8OfupJhKkHfZ/J?=
 =?us-ascii?Q?81dtcvuwBr+/9EcG57zwio91pTKNagoe6l1bVMWk/06cRC6TeRr1MQ2t03CO?=
 =?us-ascii?Q?eGZI29VtYfJdCsoW2KmkPz55mmdXebXIAn2lvy0t9cmO+8pFbI5FWLvQrjyZ?=
 =?us-ascii?Q?vY0O/4ugVCt2e9nzJ8++s8ifHpN87TRQbBnMr5iP2VWQqa2Xt0/OgRtbUJHl?=
 =?us-ascii?Q?MNboLrC4Bi0B/63X0D63PtJLBr112pfc7v+7cvsHaI7Eo+oSf01z1/Ci5EzI?=
 =?us-ascii?Q?6vwP4ht014MeJWI3mp3Q21QTJk+x1fc+aGGwo5Q6tHjcDkDknCvuh3lrnUjF?=
 =?us-ascii?Q?+r+YZZOQhwapQp3SvgA9Jn54e+ipeCrfUhbSUDoXzLjgpOchi7pFVxt09JnR?=
 =?us-ascii?Q?Iwn/lK/RwP07pVp53YUriiP+YyHfDIjgxxGN5fFtJ1CMvverDljOltXEaS7f?=
 =?us-ascii?Q?jNhTbuJBMGjSArCqGan+vdf7Itw0DaO+xBhPtbGpq1rcCLQsVmX0jWH3NvIp?=
 =?us-ascii?Q?KgL2zufUq2Hhr7/bJzIbFuebogCvxLXZaGkw6Pr8p8cVSzXvh2ssK2XdvHAU?=
 =?us-ascii?Q?NSHTYUUUaBveUvbcznQqGf4QhoOJk5OucdYrnsyzaAwz45nh9x1gx0o2aK9O?=
 =?us-ascii?Q?eVFRRWR8B20wAJUQJ6Aw/n/uFDp/uPBUXmbYPiKwKG6ZRVoYRSX5W0xG+Uhv?=
 =?us-ascii?Q?Z7TCggnPnKVJB05Iyizzs9dfMAy6iVe8ypvrVkq4ksPwv4DWMtwAg3Y4VI/K?=
 =?us-ascii?Q?RcESWoE/IIBEhTDmhx2ViNN3EbPp8DYC/ZmX1W3LQkRNgJlaVDK3EMsw7Q9b?=
 =?us-ascii?Q?/p/pLurZB8GeylI1Vu9vq0p3pmZ17K02RsW3pK/gVc51m6ecJk6i3sfavYhK?=
 =?us-ascii?Q?KO4ZWyTa0xg9UTVQxK7ESqiMOD/3GDhW08EsOiABLm5950AVEplMD4a6nnKk?=
 =?us-ascii?Q?sSz9mopKjJVAS9LfXwdFuV8TmtIa5fie8XiVb80BWNd9HV7UlEQ+HglRmXub?=
 =?us-ascii?Q?XgeJ3zabVSsOaIKMw3MU9py9v/L51CHLo/G/KBZ9fdhPAZHrV7NVhVmCzoUF?=
 =?us-ascii?Q?WR7LIDBdgPo/wDka255u28UE+TbLzFmpiDIQPqh57NfwWT1srJKV37wP2F7r?=
 =?us-ascii?Q?W1ihtNUuJ5metprAwrqvYq+91rL8TGeqIDl+0kUzo4FUtyhQoXmF+OTjvSaS?=
 =?us-ascii?Q?/UiqKmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GerP9BiKBUE6zS/yEG+faxB0Pw9tyI5aDA3BdhTjXxCA799Y3f+6zuA/a8ul?=
 =?us-ascii?Q?No7NlT51P4tFQhn6cvVAEhAxltyr6H20XtDRVqb4JHqqNH/bimkRhT3q4xC3?=
 =?us-ascii?Q?vvY/0EDMujNWztUFZYvzID+M+0267vQyrNvrGReOgVfB8tMFV1sFEthXcITu?=
 =?us-ascii?Q?4vsmgePhd89e4zF09O2eGuCSeEMgL0cCwtrLG/DlFwUH7r4XaGTbaeNgT09W?=
 =?us-ascii?Q?wy5pLFbFuArRZ+x9gZ3YRYjwPmhnuR37HvfY+mA5qMJxAJUF4WRtTKC5Os3A?=
 =?us-ascii?Q?ZUL7BpCB52dWWCbzvYwosFqQX6Og7R5V4/PFXAuqoWMtYmhrLZwhWKU7W26D?=
 =?us-ascii?Q?cN0LuPWUenmqG+63E05hlFrK4CTfvmkIXz7600Zgqr9dKfO6CnPIWPpb8F1k?=
 =?us-ascii?Q?9/lYOCvLqWMO+8SYAUuJfDxcqTWpl9xE2H9RX0kjSFZpnwxslx+KDp/QwbMf?=
 =?us-ascii?Q?AlaZa+YpkkkclctmDT4Vsk/DGteSyhuSOMo7aGKO7FcOPd5cLh8f+sDyS9yz?=
 =?us-ascii?Q?fn93Fwas/AqvFLcS811yOJKZg5Y8QP0zq3hDA12tztaeegHT3kXfpVhJ4tnQ?=
 =?us-ascii?Q?OthMceZwd9u7Xv9ICh7dddP9Qtp9XQTgXDZGZ/m/SKQz9V/2W4D1vleuQZFa?=
 =?us-ascii?Q?3UPtv5mwdzGbRv8SY/L1L3sECbnI657DMIDZOQlrY3q903+1jEC4nJZwnytQ?=
 =?us-ascii?Q?EVY9ZpiIJ0Rsi8Mj8vwspuUGIeIN2x3IpJEzGP4iB3CDAafc4R/IaOOrZQfC?=
 =?us-ascii?Q?qh/cN0JHTNTc4Hi7GY0adoaR441IXRC8/6ybMtwotb4qQhpyceG3MsVZSs0J?=
 =?us-ascii?Q?JrysLuOjn+nzzChdlOwAzuls8adeQYMfo33SRB6yTpFzEW/TBx4VI+SiiY9h?=
 =?us-ascii?Q?9Z9irwwnpE9lkNmss+C4XSY4HbYfrNotYv3vdYShfDLOPnCLsNMIulAozDJY?=
 =?us-ascii?Q?jdWzr+rHdkhsZhU5A/b5yN3/19GUSRavZerKVHELskkcL0+iEOzbeUkwDi17?=
 =?us-ascii?Q?I9BbHk7KuQ/kx2RZE03d434/mto71/+tD0gw6ql2Htwy2z9kJpywdMWFO1up?=
 =?us-ascii?Q?hCqJfMYaS7w2JY5PZetdFVBb+WHPoSIsItiTfqnh+T+67732GM0A0VWDszUY?=
 =?us-ascii?Q?/dDzeYybjyr3KNvV3YXCxDD5WoB5UdkSCID/7yBEc9SxxDJhuD2s/+9ISEs0?=
 =?us-ascii?Q?+TniKg+wd22zv24MH8+AWWvXK5TaHojD7NjxB6cflWUN4rAJgwnlSry7RmLY?=
 =?us-ascii?Q?omZpWikhUeMmXzFI7UsaMd947Fek++tnlKzfxikkimM7o1r1yVKCtBu5kAhf?=
 =?us-ascii?Q?C7jGLWoCVJAH2v7eHzohnXoe6/K4BBN6i0gL5WmMVLuU9wwe2/COvcYuVnW7?=
 =?us-ascii?Q?83g9UvdlohJCaQnfG4JbrzwSB5BK+WruO5jFFIZdiIt+Bftf9QpaBpSoyoms?=
 =?us-ascii?Q?MGzi90RX3cdD6rKbBNuPVy/qiaS+7SGQHJyfJIDgDPcuu2DVy2qFkikZ3C+6?=
 =?us-ascii?Q?FjlBPlybDr+hSUXA4bO4rt0EXzrYg/TTQFyAd8Tn2OfxDryHHt9aadNISkjy?=
 =?us-ascii?Q?4+HOeb+qk93qpS7aKEKQKZ/QMeklX6eQO4omB7wo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2862358-c05e-481f-6785-08dcf7f49ecb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:35:19.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwiAYxgJiAOtd1UwmhDFD5AiN0BwJot24yBPilCWLbdSSFsdUJL3hzX/20uguNIs7m2uXhAFIKT4Ffjkoi0rmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100

From: "alice.guo" <alice.guo@nxp.com>

i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
which are provided by the corresponding ARM trusted firmware API. This
patch intends to use SMC call to obtain these information and then
register i.MX9 SoC as a device.

Signed-off-by: alice.guo <alice.guo@nxp.com>
---

Changes for v2:
 - refine error log print

 drivers/soc/imx/Makefile   |   2 +-
 drivers/soc/imx/soc-imx9.c | 103 +++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 1 deletion(-)
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
index 000000000000..0722e69110f9
--- /dev/null
+++ b/drivers/soc/imx/soc-imx9.c
@@ -0,0 +1,103 @@
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
+		pr_err("%s: SMC failed: %d\n", __func__, res.a0);
+		err = res.a0;
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
+		goto soc_id;
+	}
+
+	return 0;
+
+soc_id:
+	kfree(attr->soc_id);
+	kfree(attr->serial_number);
+	kfree(attr->revision);
+family:
+	kfree(attr->family);
+attr:
+	kfree(attr);
+	return err;
+}
+
+static int __init imx9_soc_init(void)
+{
+	int ret = 0;
+
+	if (of_machine_is_compatible("fsl,imx91") ||
+		of_machine_is_compatible("fsl,imx93") ||
+		of_machine_is_compatible("fsl,imx95")) {
+		ret = imx9_soc_device_register();
+		if (ret) {
+			pr_err("%s failed to register SoC as a device: %d\n", __func__, ret);
+			return ret;
+		}
+	}
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


