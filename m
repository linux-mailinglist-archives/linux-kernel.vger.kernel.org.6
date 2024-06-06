Return-Path: <linux-kernel+bounces-203702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B808FDF43
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76B01F25184
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9E13AD06;
	Thu,  6 Jun 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mn1zh0y7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF481759F;
	Thu,  6 Jun 2024 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657304; cv=fail; b=EhnCvx9UAN6FXWQ23OfEKmzxOYkkPc2dTkxnXtbxJaoXa0bvSJvu1IlFnDtnfS2Bc7Y+EfzazLi/EuSanzq+t3p+7HVgYOo42fEpto565ISB9wcNcnL8cGDG+pXB+QhcN9Zz/NSLAy98QmH5vigP2wPLA/6xpoTJfZ8d+u7Tym0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657304; c=relaxed/simple;
	bh=z/lqD/cQ/+6X4XKTB+yWW1zU5J6c7Rdi2kIbjES8+BQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7pL8MoqBXXVSMD6RFC8E0MuMEXmwedwgO1iM+HajddFVcaspaDq9qxP2u4kVnLUwZBotRh6GKuGVVKOoK0Sw2Piaa72/nYtS53eBZXxResgU67BIF66F48WRTHRwl49jiXoPrgfVjfhC+7tK8oPn/8b9c829b0S60CbMTUOPKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mn1zh0y7; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfwjWuGNC61N0DHu07QAxnVSk2uKqr9EqWUPvIq5XLH9fiIN0diVPRQGfyfY6ptKDRlFjR8sExqO00GDL5jTwuPNDVoqiKBIamc0JPwyyktZdoY6bHnlIMS4nsvQh4t/JDXVsSkaW1/hYLknzmlUmdwm3LecoJifQZmusoDDY+YWCuCjhpIl8qoQfazyNtXdwlfb+vof74otiwlH+W5/ScAzertbE2gKTIKTyrtiwJynVMlSqzakQ74QXuyAxpAWQfzILmVVG5MubmngYxdPbDoLtqaewHRmfpQDpMHum6OkHMeVPgy7x+npTDh9RW5sdaYBTOq47TD+cWKsPeqN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzmc/BWh3qSbexQtbZCMKKFjzQUwwUFYPIsoeCf6d4E=;
 b=UaZmkFbxg+V4nv+P8r8W9+Yw8DS52leCc7VJJNkJytRxAL64UnHfL7y7vNg25L5TCu2UB9+terMtEjotuA39OjUc9BSzJDfh1nkrq0J5MJZSTCOL9Mn3XuAfgeNvFZJEgm0CQfIKFygJlejDmJC944ydM937KVn3H5QzZYkVkUEGIinb+WTbpkOvH9UZQ9de64TUBCh4rXV/HlWsVSWCqJLSxyMLMiPKrZMZiMJRfjS8xZoD7DYJoQB8ho/IF2VAUcYeNpD5zveBFMU/Po7OK9dKEeSBf15j7JWue8le0fhIZ2Z3HaNijFdxYQeYC9Jg2in1JHLl7/fImnShmfeu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzmc/BWh3qSbexQtbZCMKKFjzQUwwUFYPIsoeCf6d4E=;
 b=Mn1zh0y7DtZvjOKkqP/IqAR9eU1rBIvAyOs2RiwZKbwZ0xp/nT8pM/NzbpGzg+GSkdzJbTVgCzIc1Q641BIusciPb6HX8yBl5j37aYcD1qx0YJsvsNEAFp3bg+fpUHcjkPW+8xTBVf90Z69qtdQCYPNSukvSWifmSebhvxcNG/c=
Received: from CH2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:59::16)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 07:01:39 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::19) by CH2PR03CA0006.outlook.office365.com
 (2603:10b6:610:59::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 07:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 07:01:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 02:01:38 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Jun 2024 02:01:36 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski@linaro.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
Date: Thu, 6 Jun 2024 12:31:19 +0530
Message-ID: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 2888137a-7811-4c6e-5a16-08dc85f68392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Day55b5foX5HliPnBz1n3sksqmThBLOLTETpUuskMlbBdNvBW4y8hB6QVRmS?=
 =?us-ascii?Q?VXblE6V9bjejynbTjQM9mV+OY4eNnefaz8RrqViTDoMqmiOS96MHduWpCTMQ?=
 =?us-ascii?Q?RblrEQnW8EJp6kSRPtAHC83I9zPFMaDVGf7wVeBojKEEAZ3/DnfwGIh14S/q?=
 =?us-ascii?Q?3giLUn5rc9J6ZvuzQGxrJ8a0qXjyIahFOW81tf+VUcCjQg4k0G57cq8QbNbQ?=
 =?us-ascii?Q?IjaVeoVG7gAY+HLImCY/UpbXjhfT9HJdcOBblvbEbHXJh/akkHguXhPExN40?=
 =?us-ascii?Q?NvW+1Bzs0qhc3rUEcSyKb9jWzKAHQ8BdFsiXX+fQAsZ53XAor88Yc+S+UJQJ?=
 =?us-ascii?Q?BM7MlJzWcZ29iU6UgQYEovU3OrOHEy7jLjFvOMQIdZsv4SJbikrKPQg2czLM?=
 =?us-ascii?Q?FWACAUt3z1VuJ8VCml7c4YGIrJiH6NBYpsmrR+FajLyiUynrghJktQqxMj3X?=
 =?us-ascii?Q?51YyU1rEgsQ5dfVJ+ojzGepuA/QXWivoGkNG3zcv0gcWSLw5OWcspFcWZYGF?=
 =?us-ascii?Q?6seh3V0cSXvek8oMtAvTIcyAwBPjhb5icz6Ok4VLW3TvrjW5Oi2QRCIXsc8V?=
 =?us-ascii?Q?KJ+b3Dx0JE4Rl8jZ1q8vEaw1PqoABC9keBA2PyPHtMILrZEMllxzsaQ7fnSp?=
 =?us-ascii?Q?gUMlmp1WINpsHzKcLpT7BFExIFtU5R+aWEjemE13KaSRf8cKnapWHsbivHcp?=
 =?us-ascii?Q?a0QqJzE5mTJHWdAXqHEoAaMUFfXGQj/IDi3HkBEMYT1nFYzT+KAk2Sw4LfQy?=
 =?us-ascii?Q?979kkViHhWwedfTtonpTZYLcCqYRVT2LFMwOPDIosMWH9u4R2wngA58MfaV+?=
 =?us-ascii?Q?W7yGhwwF3mFQ6suFpVxBgCLWVAkoTw0k8qjEXsBUumu9qgootXashxROD3Zj?=
 =?us-ascii?Q?Z6toFLTcp4yB6wchPIUsJ4iBobMAyKLJiKDda/tNsGlsJUsqrpzv2x/cGZCE?=
 =?us-ascii?Q?qJz6DK8nT6BKjYg4y2wDA2E8XsdpQ+kP28Q3Dif9RM3+5o+E1ckYON9StISW?=
 =?us-ascii?Q?Id7h1ea+KkTBH2jYzEjlgCcO64/WzyqExU3OMWpTZl6G20GK0BBhXMvyFSLm?=
 =?us-ascii?Q?QfzGQWBFzaM8oZUVYqhVyVPiLs93nbMULTS3Ly/5cSzMjKcKHArxJTyYSkae?=
 =?us-ascii?Q?n0ClwvRxeinkyYmQY9y0YWnUA/IRd+QpPFDxxCkM5B7tOoVKwo9X9LFFeOEN?=
 =?us-ascii?Q?Q3a7lnHCbO5VZjOt373UyhklWzhWjIguZ5mNNPS2IAB+SvOYsP0xrJfxzSXg?=
 =?us-ascii?Q?C+zCVutz9rtV0lyeaJR/eM9d1MwwmvT/Qp1j0i0+ZoX+/k0pTvOm+ven6n2m?=
 =?us-ascii?Q?LuDlKlS8WahYsEyk7+sDeLnnrNcVC3yNDOhkZByl21ERd/jCuoYMer8CYHFm?=
 =?us-ascii?Q?a8J+9SN9Om25K7+Khq8rJVbTCWCk7C7JXN9PuTL6+jXgkrulIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 07:01:39.4842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2888137a-7811-4c6e-5a16-08dc85f68392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

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
Changes for v3:
In v2 review as suggested by Thinh Nguyen, switch to swnode implementation
for passing GSBUSCFG0 cache bits from AMD-xilinx dwc3 glue driver to
core driver.

Changes for v2:
Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
add support for realtek SoCs custom's global register start address")

v1 link:
https://lore.kernel.org/all/20231013053448.11056-1-piyush.mehta@amd.com
---
 drivers/usb/dwc3/core.c        | 24 ++++++++++++++++++++++++
 drivers/usb/dwc3/core.h        |  8 ++++++++
 drivers/usb/dwc3/dwc3-xilinx.c | 18 +++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7ee61a89520b..159d21b25629 100644
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
@@ -599,6 +600,19 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (of_dma_is_coherent(dwc->dev->of_node)) {
+		u32 reg;
+
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg &= ~DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK;
+		reg |= (dwc->acache_data_rd_wr_info <<
+			DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT);
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1320,6 +1334,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
@@ -1574,6 +1590,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
 	const char		*usb_psy_name;
+	struct device		*tmpdev;
 	int			ret;
 
 	/* default to highest possible threshold */
@@ -1716,6 +1733,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	/* Iterate over all parent nodes for finding swnode properties */
+	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
+		device_property_read_u16(tmpdev,
+					 "snps,acache-data-rd-wr-info",
+					  &dwc->acache_data_rd_wr_info);
+	}
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..57b3cb739353 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -194,6 +194,10 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_MASK	GENMASK(31, 16)
+#define DWC3_GSBUSCFG0_DAT_DES_RD_WR_REQINFO_SHIFT	16
+
 /* Global Debug LSP MUX Select */
 #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
 #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
@@ -1153,6 +1157,9 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @acache_data_rd_wr_info: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
+ *                          DATWRREQINFO, and DESWRREQINFO value passed from
+ *                          glue driver.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1380,6 +1387,7 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+	u16			acache_data_rd_wr_info;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 6095f4dee6ce..f3757bfbd650 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -47,6 +47,15 @@ struct dwc3_xlnx {
 	struct phy			*usb3_phy;
 };
 
+static const struct property_entry dwc3_xilinx_properties[] = {
+	PROPERTY_ENTRY_U16("snps,acache-data-rd-wr-info", 0xffff),
+	{},
+};
+
+static const struct software_node dwc3_xilinx_swnode = {
+	.properties = dwc3_xilinx_properties,
+};
+
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
 {
 	u32 reg;
@@ -288,10 +297,14 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_put;
 
-	ret = of_platform_populate(np, NULL, NULL, dev);
+	ret = device_add_software_node(dev, &dwc3_xilinx_swnode);
 	if (ret)
 		goto err_clk_put;
 
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret)
+		goto err_remove_swnode;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0)
@@ -303,6 +316,9 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 err_pm_set_suspended:
 	pm_runtime_set_suspended(dev);
 
+err_remove_swnode:
+	device_remove_software_node(dev);
+
 err_clk_put:
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 
-- 
2.34.1


