Return-Path: <linux-kernel+bounces-175204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6448C1C43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBED281680
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464313B7BE;
	Fri, 10 May 2024 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="RVMayeXV"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2040.outbound.protection.outlook.com [40.95.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910733CD1;
	Fri, 10 May 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306246; cv=fail; b=IJKuQYebM5qLKlSgZKs6RUAW5bKbYL4dpnfbmeaoWpH8d5CnzAepmeycdPwTkCyOsRm6guAfg2yNMikocrmQEvzMaNHs/Z2ZJJypIlFhXZDQFZb9J1+aBqaHn25kkScxgUv+t2SsiLoMWOs7AFCOJJVgBYNVAJt6/G+DkjrahnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306246; c=relaxed/simple;
	bh=pgWvbZIl9vMv+M9ENkU41/IzQ1NpYJYtTOnkGoNuAEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEoitNNm1IdxviF/XLBQsGrI3LJ2OMm2sd5hrR0eJqp6TioMr+O7IikZf/cYFspq/ryPdUQmY2LA5VITpPXlIUVbtEdHHdc/wOYSnQzbCF0GdDqso0FzXQuIegOx6AW4vUcBkcQZh3ptwWs5x6NqpbjFVJNF3O0Ccf5w7c0zIvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=RVMayeXV; arc=fail smtp.client-ip=40.95.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU5yzPF4yP43pXgVwel92M30njB/a0t4dR+2W0e44gCmfsHoVoiXOI00yKBGZuRA2rYHm45uvdqzJHIvZA9aCjt80Q/6V2r1+J9MM8SueZmgkWnwSNPRNKMkkKeGHl8s3GzCh3TsrPHGB5HpVNpnkrgnD1KFA6AwF7vjAE9aXHevjk5AvL/iFPQERccMnT/HIrT5OXSOvfEOw09B8B9hy3h1hVVKRRX6GDe8MM0ePWfBzK+80WnMQvJZfz3/fKAYUfr2pPShoQGznNnrFZWWk1QMrtBdMjPZC00oPQmjYaQMpA+1IySUiGh0k7kDZB9OWSU7i+s3GX97ErHA779ETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPuEsPZV+1zj8GviQTAJxY/socaQAF9SxgiGqjo4fkE=;
 b=V4IgyQGYSQcOci3Rb5LCwc5r3/PqWUyzBtnE0id94I8dYEdkwZlESWIzxcRcDw0W4mrfBB0j1FmLpvZN/tKvEjPwQG/tnK/HTA/khfg4uwZrbPdBvesS6iaw9n2tQQxrfFzC5nl0M8xigC4BtxYpQlF+encL/qoJro7Tqbg5tZh/iAh3WEd7tromJLTfzlAYo4pgqmVVq/BWmfn5sLBsw2ZFjsftNkyyLxH8obIby6JGDhho/MWKi+xgeiy275CW5oyI3ofLO+hyfqCQbvP+f0m5KqoIJm+D8Kngx2EJd+W7670U8dpyQ/T4up92E213QpvuaY+usmuFBBynxyfADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPuEsPZV+1zj8GviQTAJxY/socaQAF9SxgiGqjo4fkE=;
 b=RVMayeXVTMqx9rohr0sLwvPQAuwVFjbd/m7PqC7Enp0RrQN9KRrPaj/nkD8DIxn3jpZ+4lfFGmRNTtJTb7KduH47UHUgTYvYumDUM9/rUoPwZ1qi3SmEy0God1biVlmWzhpf2Z9uCTgTZO0rIsNwntgPMHqVEIbiM/8452i7nU4=
Received: from PS2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:300:56::26)
 by JH0PR03MB7751.apcprd03.prod.outlook.com (2603:1096:990:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 19:24:17 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:300:56:cafe::8b) by PS2PR06CA0014.outlook.office365.com
 (2603:1096:300:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 19:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:24:15 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 May
 2024 03:24:14 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 10 May
 2024 03:24:14 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 May 2024 03:24:14 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 84C865F66D;
	Thu,  9 May 2024 22:24:13 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 82DA3DC0BCE; Thu,  9 May 2024 22:24:13 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v24 2/4] reset: npcm: register npcm8xx clock auxiliary bus device
Date: Thu, 9 May 2024 22:24:09 +0300
Message-ID: <20240509192411.2432066-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509192411.2432066-1-tmaimon77@gmail.com>
References: <20240509192411.2432066-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|JH0PR03MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 49036ae4-06a9-4ef9-43e6-08dc705d9d33
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7093399003|82310400017|35950700004|48200799009|61400799018|7416005|376005|921011|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTGlDcTnHR0/r+NnZR9v7m18eNxvM5jd92nPEiyhrZzStpiGsH3u4YxZ4zcS?=
 =?us-ascii?Q?ElpTaKGWKA1n7LaQvKGISWD4b5g53U2BfdP5A9TJBTtVwvnx8tCnPpClHlmY?=
 =?us-ascii?Q?afZnkY8j9z7+E7+ql1jXTpUgE+rAomsUvGITkP8uhLwel85Bf9FHKNakHNMR?=
 =?us-ascii?Q?I3TWL+FeGt/2Gm6c/Jik3I1hIXya6lDXyjFlU0TPRXKDFy+UlNLiDzJIR9GY?=
 =?us-ascii?Q?+lSaOjTNwf1RWJs1r5ZNXwyYYSWDb7Z+GPn7tGClCWpPPonpJ4Pja6Bex5qF?=
 =?us-ascii?Q?xaplC69Mt5TPdPBOnfeRL4J4ndksn5gV8s+e8eCALPlQmmAKFOXm0kpDe/PZ?=
 =?us-ascii?Q?hosgs1PR7Wd11FpS0nAaR3oFlu3F8u1FUwKMpjDydtogBIfLWuRvhy6i2dVc?=
 =?us-ascii?Q?GPftODGRO6YSGWOblL5SgDk0CKzw/VMH+YBxqNoC3nmUnDP8DgxSu7yiT04m?=
 =?us-ascii?Q?lPEIhsCjFhcQwqZtFk4yLt+hxDBbbMHZHhSeHaR/lij+bvHnxmwx/c6JMUrD?=
 =?us-ascii?Q?xieXrC3lBVlbQWlwuC/MnXcxQvhv7trDZXFJwECIFUaBItTXBaNaO/BbuchO?=
 =?us-ascii?Q?Mi/B2e0bFUZk/n4OWyyZ2d2738cioESBVZbFzJvkysGBmFBZ1AkMkeJR4YRa?=
 =?us-ascii?Q?Q0vwGJa+7fhUiAA7dLgUPE7eH6Co+WKvWAbqz8cCoUlJ3aM7WzE/LEfLzKS8?=
 =?us-ascii?Q?oYjwO/tR8eoRNtKcOKE6xBqNOs1RMOObzSjGimrFMidRzdho7ySc1HbbMVxw?=
 =?us-ascii?Q?5AY1dGiV0W8x3zznrcGJEf+vIZ5bW1V86Y/vwQkVb5f8LBJ570E9KzoEiETa?=
 =?us-ascii?Q?UB1A1PPI8pRrSZFDZwIW26RD8QPD1C/5ItJY78C2X4OwDlxU7m17E2EC6nWc?=
 =?us-ascii?Q?6bWxiSK7dHjX5MH6OY9MWq1ZQJ7X8TmQVdhDmTMmn03aU7Ut4evsQouRDalY?=
 =?us-ascii?Q?0S7ufdqMOxSRS6utJrssDHDCphwUWf+uPliwfCGVwbQ8Vf9DEoKYBnBKZEx9?=
 =?us-ascii?Q?ysXyA8oENkNqPMMK7kLFm07IX9jjLFFkhSDiTUZtQQHF2VVj5TZwdBsJHp1/?=
 =?us-ascii?Q?H2w6v1e+CxJ9IQKrYLY5AWJ9ubG2+3wMOWKMnHuszUFDwWVYYWWhTRRsjsXS?=
 =?us-ascii?Q?HkrzM/kJvlujKOk/CbGQKt+/k3Fy4c9Xxsg3CajxLg/Ap87NxLafGPSfHjs4?=
 =?us-ascii?Q?PP6ZpHtU5H7uw75YcQ/aTrnD1UUwHdn+GgXf4tP6jvkBRWcCur0BGdAtEPFb?=
 =?us-ascii?Q?ndbjLoDEnVg3C+M2Eo7EDEWW8GZYO+NrqApkpvYMQnkhPKR/9wk3tglscYgX?=
 =?us-ascii?Q?jx0NBwptyhjmtdZuRwSmxjLQ4D/EtZjHI8q7tk8pz6I9Kn8XuCwOiCbZtmzR?=
 =?us-ascii?Q?cqUUImXv058usZ1x/gOSkT7TH4y3mIbuoiZNGIeQJewdfB2uHgc9Dc38Ubps?=
 =?us-ascii?Q?uHrTpSywx3LJw0ekbORTrZ3igAvrv2XY?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7093399003)(82310400017)(35950700004)(48200799009)(61400799018)(7416005)(376005)(921011)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:24:15.0951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49036ae4-06a9-4ef9-43e6-08dc705d9d33
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7751

Add NPCM8xx clock controller auxiliary bus device registration.

The NPCM8xx clock controller is registered as an aux device because the
reset and the clock controller share the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c          | 72 ++++++++++++++++++++++++++++-
 include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 8935ef95a2d1..2db9e56485f6 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -15,6 +15,8 @@
 #include <linux/regmap.h>
 #include <linux/of_address.h>
 
+#include <soc/nuvoton/clock-npcm8xx.h>
+
 /* NPCM7xx GCR registers */
 #define NPCM_MDLR_OFFSET	0x7C
 #define NPCM7XX_MDLR_USBD0	BIT(9)
@@ -89,6 +91,7 @@ struct npcm_rc_data {
 	const struct npcm_reset_info *info;
 	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
+	struct device *dev;
 	void __iomem *base;
 	spinlock_t lock;
 };
@@ -372,6 +375,67 @@ static const struct reset_control_ops npcm_rc_ops = {
 	.status		= npcm_rc_status,
 };
 
+static void npcm_clock_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void npcm_clock_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
+
+	kfree(rdev);
+}
+
+static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct npcm_clock_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->base = rst_data->base;
+
+	adev = &rdev->adev;
+	adev->name = clk_name;
+	adev->dev.parent = rst_data->dev;
+	adev->dev.release = npcm_clock_adev_release;
+	adev->id = 555u;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = npcm_clock_adev_alloc(rst_data, clk_name);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
+}
+
 static int npcm_rc_probe(struct platform_device *pdev)
 {
 	struct npcm_rc_data *rc;
@@ -392,6 +456,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	rc->rcdev.of_node = pdev->dev.of_node;
 	rc->rcdev.of_reset_n_cells = 2;
 	rc->rcdev.of_xlate = npcm_reset_xlate;
+	rc->dev = &pdev->dev;
 
 	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
@@ -413,7 +478,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
 		}
 	}
 
-	return ret;
+	switch (rc->info->bmc_id) {
+	case BMC_NPCM8XX:
+		return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
+	default:
+		return ret;
+	}
 }
 
 static struct platform_driver npcm_rc_driver = {
diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
new file mode 100644
index 000000000000..139130e98c51
--- /dev/null
+++ b/include/soc/nuvoton/clock-npcm8xx.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_NPCM8XX_CLOCK_H
+#define __SOC_NPCM8XX_CLOCK_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+
+struct npcm_clock_adev {
+	void __iomem *base;
+	struct auxiliary_device adev;
+};
+
+#define to_npcm_clock_adev(_adev) \
+	container_of((_adev), struct npcm_clock_adev, adev)
+
+#endif
-- 
2.34.1


