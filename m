Return-Path: <linux-kernel+bounces-244039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DF929E47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A00283048
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19F4502E;
	Mon,  8 Jul 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b+9vHwN3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B52F50A;
	Mon,  8 Jul 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427172; cv=fail; b=Y0CP8HB4WFfTeVvP2O4dV/DzAmBqYMIFI/QDILjZoMX42peJWpe48EHFkR+nLwRTpxNIukZceLUpt6/8wRFJrLwYT2MxqYCJtdZeqF7Ez3Bk+3zUfFSGCtgbPc/FfsRw30gp7dGLSdJDGGy55UEe96C69wdJ0Ql3hzw4vkd0QJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427172; c=relaxed/simple;
	bh=f9OIrjTEi2j4oOGL596rZqCzf3aH/pBRdArKhvZ8IQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PJNRCAtbCIlyHbp3yGsb6FL0tlhhvAcbQr9vMSeptajISThM6PVvghPNK3JhhxBrHHdev2Wy+A1wkR1YDte2s4BpoVpGT8rE72Qr4qViFJASR9T9UBnUd6FvsKs0biEcHITA/gr4kTzTiV+HihzdWhEqPYbwItV5HKsJTiNe8kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b+9vHwN3; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5QCo7oGAGdCGPRM/JBauv+LtAJGhFwCExfHxT0UDrapJumDVqdCz1GB4jB8eUt+se6wjDXYz9EewMU6dmWa8CuqBHpCZn/0koO6IZ7KXOIqZLcRiCYMvHs27b4lR8mSzYij+mV37FYjYGvdF4iOPwTzDxTqWHmpz7DSif+6jUuHuU2aB6YFuYR74GeHvQXpeHjh6sQIB1EzVbsUGLv5xkK2baEnfAydhmhrZt3aWcmu3kTHbAnxxNc5ctnGPgvj/7WfZOqW4amD+BPMMqIBwHKC3Bmqgrl/ycNNR6yXc8kpawsth70eyMOTFheXpmB/TSPRsVA61WqfHlikYD/I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZO7m+L4yF8vDDkd7umQhRW55pNpZZlslOhYn2aiS/o=;
 b=oOqdBBbp15Qsh+iT/+rbzlw3NXC6cO25xght4R4U3YiArrDImHUA+GPnAWjh29xfmsRuO81xbsT6C6MsPMs2MKPJP4AVEz2qAYvSFSetkgM8PHGGmeWqP0jl/TmteUpipSn3wlUqmgMwgaM6SU5bpENh39/rZ/FVIAPHHEnldxttA7/wIkgR8wGKc5PPoVWGkNeA3+3gPz1qyKP6nIB18PR9LE0VpOJmvvAGrEYEpMFQOQ+KMMuDGMgP98oo8LPRFpg+/tNtYfLDfC4iAJEevhIYIh9pKyA3zSNwdY+5m8YmIBKsOBSPTl7gzVKMUyFs74pyckcRdVf0JcUKeFVZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZO7m+L4yF8vDDkd7umQhRW55pNpZZlslOhYn2aiS/o=;
 b=b+9vHwN3Lxi58+bZI6gBdig+mlyWb5uP+2Uj3o4Z61Z9qKzfq9sVcFbjRTPGP+2WQvKA7vXcDFJ8Z5sBkjOhFRgFfUfK7Sa0eMGr5Mq3OO8Y9OM46OON0+9gbXH8rmXE3cj6q3MrXX+Y5z/kA/ND9q4jJ908xAaGTvRh5xYisuo=
Received: from CH5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:1f4::29)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:26:07 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::a9) by CH5PR04CA0018.outlook.office365.com
 (2603:10b6:610:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 08:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:26:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 03:26:05 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 03:26:02 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>, <Frank.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v4] usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
Date: Mon, 8 Jul 2024 13:55:52 +0530
Message-ID: <1720427152-4052539-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 17977412-5315-4d4f-418b-08dc9f279d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?12OPPHZLUwdNGICQNcyslwcGNPYmYjJaSP5tUDNfo90kCoCSgnFR3vFYZTnB?=
 =?us-ascii?Q?yGIaM0tfqtsNulHrHzFwAV5QAjXt6L5elTgPC2j3kGTWcCfJ9b9gctY1i0hn?=
 =?us-ascii?Q?4Xu83xfT9tC0szorFFu+50jxe9ihEYP0ubNwEY3TZIJuo8w3cFYLOlXGuRG5?=
 =?us-ascii?Q?72xA0otTBkygf9sJ/iMip0Hw9qgf/zQ0jZQ/7pavR2JcnEEwjFs1Ip3ALPsI?=
 =?us-ascii?Q?hYG+bFmAOxz0Y+bRBxoiS8R+ecMuafQtM9k1fvRs9sGTwrY4+n9S7MQ/0h3X?=
 =?us-ascii?Q?Dpyr2Hfo3CXjQ/n9zEK3J6uUJWy4/9KzhMfd9UAIwYA38fe3OGRVwCz2MU5B?=
 =?us-ascii?Q?Y3cHxrZHnoB8JNyR3w8VqS0BpC86Uiim6lrmtIUSoZLptl+xXLqq0Oc6O9NE?=
 =?us-ascii?Q?6dlaTuXhpj546e4odci83Ft/0Tq2ywcZ377gat+4e1v2lUDJFNjhZue2QjES?=
 =?us-ascii?Q?7s6QswniArIa2p16MpBxWDmXy9gij9hkY8Q5hhiSl0ZUCpUG/7RQhfseCPzK?=
 =?us-ascii?Q?SsMB9mJ3KT4r2Kwcq0RirBqehvnzrITSCpBrIyK0poet5kG4Y7OmJuHxlhau?=
 =?us-ascii?Q?046rE3EJ4ESud06TVjoVNNh0kcX1LkLRmFLiEM6LDLOkyoi3Sxh3Z64it9nu?=
 =?us-ascii?Q?X8ntPmAU1xG2XD69psmSicEvy0y3/WFMiCRlx3aJLY38yCTvZyDrJvfyEAgb?=
 =?us-ascii?Q?ZBrLv5210bjS6ZpUj7tfEcB+hA5QbHj6kufVCdfaPp3/p55zi3Z7NLX+jaW4?=
 =?us-ascii?Q?0p5MoJM/Wqjmj2tuuhgdAEuWFwY511WfyfIL6eNZzzrZZOvYIvMp75+jvo6X?=
 =?us-ascii?Q?slPG9mo5XMInytdOsv+r5MZh+aVy2MJAewY6n4Q/O9m6b6h0Img/D7yK3/u4?=
 =?us-ascii?Q?nzTHIfYwo7gX1MDqpczlCVLctFXKtiNsXkOJz4IovMRv2h+TLaIPrGT7G3ub?=
 =?us-ascii?Q?BS2w3QKoAm8azitbjF3yxkHUHj6mFAEeKehRzG30/+hEW+ojTjeokIJ0O6M6?=
 =?us-ascii?Q?npZK+7MfaQ2OCbZzXZDhx5P+bWGSf871jhCiuU86Uy2LqUKuZRcGeqSr2pv5?=
 =?us-ascii?Q?KIW1dN9PYDj9LuqG1CIEdnKT0oMFHYJQDtmbEw6vMLqrORfR85/y+KObG73D?=
 =?us-ascii?Q?4IaEvguFHLsbWNK/jjxzaeWN6meS0/tHwutM1RR2avdktTIs4rW4Qcph/GSt?=
 =?us-ascii?Q?OQMaqmqdbMh6ck+MYqYOW2lmf++29Ft7iXOD3i1dCKBQX8vk0YEgB6ngx9aT?=
 =?us-ascii?Q?SLonVTw6UPnGsMn5sA+dWFBcviM3xbqL6w6SteQ25kKtc/IHTjJB62rUuTdw?=
 =?us-ascii?Q?s3YgmGVg8rnLOgzYWN39R9f0F5hgQZ6EhSCS+JkfYAGlxcBuPpvCy2ul50v5?=
 =?us-ascii?Q?bWi2NWto7M2HYKLcLsCmiAQXXw9G31n3hW7AS/mLlXZzZff7Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:26:06.9408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17977412-5315-4d4f-418b-08dc9f279d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617

The GSBUSCFG0 register bits [31:16] are used to configure the cache type
settings of the descriptor and data write/read transfers (Cacheable,
Bufferable/Posted). When CCI is enabled in the design, DWC3 core GSBUSCFG0
cache bits must be updated to support CCI enabled transfers in USB.

To program GSBUSCFG0 cache bits create a software node property
in AMD-xilinx dwc3 glue driver and pass it to dwc3 core. The core
then reads this property value and configures it in dwc3_core_init()
sequence.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v4:

 - Pass swnode GSBUSCFG0 cache property from glue driver based on
   dma-coherent flag.
 - Introduce function dwc3_get_software_properties().
 - Rename DWC3_GSBUSCFG0_REQINFO_MASK.
 - Use DWC3_GSBUSCFG0_REQINFO(n) and get rid of mask shift define.
 - Rename dwc3 member gsbuscfg0_reqinfo and change it type to u32
   and define 0xffffffff as unspecified.
 - In comment dwc3_get_software_properties() description also mention
   "non-DT (non-ABI) properties".

Changes for v3:
 - In v2 review as suggested by Thinh Nguyen, switch to swnode
   implementation for passing GSBUSCFG0 cache bits from AMD-xilinx
   dwc3 glue driver to core driver.

Changes for v2:
 - Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
   Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
   add support for realtek SoCs custom's global register start address")

v1 link:
 https://lore.kernel.org/all/20231013053448.11056-1-piyush.mehta@amd.com
---
 drivers/usb/dwc3/core.c        | 38 ++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h        |  8 +++++++
 drivers/usb/dwc3/dwc3-xilinx.c | 29 ++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..fe216a6ff652 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
@@ -599,6 +600,18 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_DEF) {
+		u32 reg;
+
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg &= ~DWC3_GSBUSCFG0_REQINFO(~0);
+		reg |= DWC3_GSBUSCFG0_REQINFO(dwc->gsbuscfg0_reqinfo);
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1338,6 +1351,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
@@ -1756,6 +1771,27 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
+static void dwc3_get_software_properties(struct dwc3 *dwc)
+{
+	struct device *tmpdev;
+	u16 gsbuscfg0_reqinfo;
+	int ret;
+
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_DEF;
+
+	/*
+	 * Iterate over all parent nodes for finding swnode properties
+	 * and non-DT (non-ABI) properties.
+	 */
+	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
+		ret = device_property_read_u16(tmpdev,
+					       "snps,gsbuscfg0-reqinfo",
+					       &gsbuscfg0_reqinfo);
+		if (!ret)
+			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
+	}
+}
+
 /* check whether the core supports IMOD */
 bool dwc3_has_imod(struct dwc3 *dwc)
 {
@@ -2090,6 +2126,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc3_get_software_properties(dwc);
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..e04640662d36 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -194,6 +194,10 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
+#define DWC3_GSBUSCFG0_REQINFO_DEF	0xffffffff
+
 /* Global Debug LSP MUX Select */
 #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
 #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
@@ -1153,6 +1157,9 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
+ *		       DATWRREQINFO, and DESWRREQINFO value passed from
+ *		       glue driver.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1380,6 +1387,7 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+	u32			gsbuscfg0_reqinfo;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 6095f4dee6ce..bb4d894c16e9 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -246,6 +246,31 @@ static const struct of_device_id dwc3_xlnx_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
 
+static int dwc3_set_swnode(struct device *dev)
+{
+	struct device_node *np = dev->of_node, *dwc3_np;
+	struct property_entry props[2];
+	int prop_idx = 0, ret = 0;
+
+	dwc3_np = of_get_compatible_child(np, "snps,dwc3");
+	if (!dwc3_np) {
+		ret = -ENODEV;
+		dev_err(dev, "failed to find dwc3 core child\n");
+		return ret;
+	}
+
+	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
+	if (of_dma_is_coherent(dwc3_np))
+		props[prop_idx++] = PROPERTY_ENTRY_U16("snps,gsbuscfg0-reqinfo",
+						       0xffff);
+	of_node_put(dwc3_np);
+
+	if (prop_idx)
+		ret = device_create_managed_software_node(dev, props, NULL);
+
+	return ret;
+}
+
 static int dwc3_xlnx_probe(struct platform_device *pdev)
 {
 	struct dwc3_xlnx		*priv_data;
@@ -288,6 +313,10 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_put;
 
+	ret = dwc3_set_swnode(dev);
+	if (ret)
+		goto err_clk_put;
+
 	ret = of_platform_populate(np, NULL, NULL, dev);
 	if (ret)
 		goto err_clk_put;

base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
-- 
2.34.1


