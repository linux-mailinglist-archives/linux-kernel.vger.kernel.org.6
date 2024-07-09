Return-Path: <linux-kernel+bounces-246527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6792C321
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3294283CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105DD18003E;
	Tue,  9 Jul 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMU03F0+"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDB17B03F;
	Tue,  9 Jul 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548671; cv=fail; b=QGZUze1EsqGqgDFHYyHhNDTk8wg6HjqSmI7erAKNZWWfkUZDP3hvsyLs6K2o/VF8d/uS1SCao7bUJAevOoP/99/Nkunsf9KIeJUsICyxXPqyZUqMdIdy20NYXyc+ncTTDzu4TGfJT5mwv/qDxr90zvqkH67T53q1s0lXYgRu8g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548671; c=relaxed/simple;
	bh=xzA22Am8UF2aBI+kc3n7LN4gVuZEkdeCTyNLY6S++d4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A8GetC1gf+7jnm7zelO0VW3L7/lYvfGIvXczoyuLxXcQNmEzXatKgeRePuOCIg/HPSIIW3qgeILJXlsBWqdkGnsShJg4D/KrHKAba4ol6bkMvdmr789Z6XJoGMzzrp98wMj39E89wCLp7xNMnVBLyQq/1D73veQm+acgWVr4lJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMU03F0+; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkIuWKJJCkQabs5ZYvW2dxI3TMwdFd6BIo8Ygb+3wPoUYXdq//ugGQHhWtCWtbfPWadPG86Z4mkgrrEykwbcg6tLqaHI1x/fhPH8yWd86oJUHDRTVR4bGL7WqM8/7rICTfQ/uvs/p1mkrvH5HTtKuWh1DnYse/Em6WmtEYZz9a6LSO3nMp7j7snsZuEtVHjec2/hBqDCx+M6IwcLhRH4xcxuJxMJjgwJ9oUG016ww8gbA2N36rcLVNBf8U8kmM7Wo8JSP59uSPoVEO9W/95itikSI/Wg7R+T05iQaG6/Oly2o7AC2EIshylsbJi11C0+J8XSc7wE3/0+l9w7RGOElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emnp9CencjKzVw4Acx1WZOAT5fianJonjpQPiqp0Yto=;
 b=PYqgU4jBbQRPoePNVb/Om+SDiSYqNHTDvBCc7q/PjWwmGk7v2XDTAeWBkL/i49nmXLguDyRXva6aSXSAi3sc78zYEff7iPA7HtHfyVYTUrUQ2I4OiTID/Pj3E9rokyKtXLYo6y3umi5YWB7ChndMy0U6QeYra+ihCOXua4cTPNsG9aG6mhufMjLWo8QOjh9gngDaoauJ+/gol9YKLuaNphnbIThzJK99MhDEIR1Y0znyb57Kz+6HHWnI2nzHpMCve4ratLE4HdWP7W39IlKpQk2oMdwM9ypdElAswLdQ0s4PJhhPLmgZacgAaHaoQ7nCya66B9qrtBK/jiKXxGqrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emnp9CencjKzVw4Acx1WZOAT5fianJonjpQPiqp0Yto=;
 b=SMU03F0+3JN+UvCPRgiNyN5wjY+c/R5UY2z2saYgRGEFoZyqvYmJy6Z6EPFLzwc31kJoRPJsETXjY3GJT9Ha48M5cvCrWyNBhvtQRj5/RpwySDCCJbXk5Gy2n2ajmBpwfogOLNgicScBFPfRfqH4YSYmp5jRqtDjjAQe2M4K9JE=
Received: from BL1PR13CA0379.namprd13.prod.outlook.com (2603:10b6:208:2c0::24)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 18:11:01 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::82) by BL1PR13CA0379.outlook.office365.com
 (2603:10b6:208:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 18:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 18:11:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 13:10:59 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 13:10:57 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>, <Frank.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v5] usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
Date: Tue, 9 Jul 2024 23:40:51 +0530
Message-ID: <1720548651-726412-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 84577b95-f58b-4cf7-d283-08dca0427d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+okETdsEOaoh4lv+0346EuTPtO3gIy+qmRTNcpsIRbJcVu4jhlfOATrMI737?=
 =?us-ascii?Q?dAipudEl+C5lveuIpJkmwuUQPuimoFN+RbSdaHAPlU1EaH3PXtma97HrXNiT?=
 =?us-ascii?Q?xquNFnmmLF03VRRlO9Bpv6HNM90EYyICv29zCmLcXketkFRUmsrWe6bUhHUj?=
 =?us-ascii?Q?rfDIaKdZRJQ81XR+cc1jlFT8nIbWWgmR1AkR/xdq5a3JFKGpG1oMXtTzC5B6?=
 =?us-ascii?Q?yQ9xhhr4NILLCq9RJE8s58uAQ4dJtHJa5wNVA0/BH0zghW4UOLb3heTEpenW?=
 =?us-ascii?Q?sHUGI8btMErUIgNS9Zt464RvkZPPEM/olgqSXykr95cC7C3n0lPQvemIZKfL?=
 =?us-ascii?Q?CW8oSw6SRGDCkWfj4yT+3BGgIDC+kvwfIeaL+tnkZOSnp4goO2xjaX2GPcEX?=
 =?us-ascii?Q?WqgFUkIPYFQv/QfVaIcc4dAsjeQh2kJDSx7SsCGtYF6nDvEKWvmh63YuMP26?=
 =?us-ascii?Q?RnCMskKtv5pDqMj4JGM14/u+95swCP6q8J8AG2Gpsv3AGEk7OF5TYAhb4cOD?=
 =?us-ascii?Q?5MyYdSiKVAyFbjNCtNdr9nJa9+qFChRC/ozSySiAX8Ukc8NFtwyl8KoWxxeu?=
 =?us-ascii?Q?CL2obXHpa/vS9TBRB3w0gOC9TkObhRhaT9IiVNACUnbcNVu/NVtYXLAhJyJj?=
 =?us-ascii?Q?KT8bwoyOxCHOhphVEOT6RqkyFoQpoLWiaySgGuZL7TV/KQ8PmdPLOPhgYT/4?=
 =?us-ascii?Q?++RebDutE6m7c9j6gCe958copkA1QSnByhi/2kTJahQGBPUPu25D4l9He+UD?=
 =?us-ascii?Q?bc22DfzzPShH5zt0I+eoiSNoveTtKgFbJvfvzrbld/3K6yH/GKEUq+uE5m1b?=
 =?us-ascii?Q?DxbvzAax+ziF/J7WMySOYEThzUhll7CBH6R2T2d4qr7HkCiXr1hFniTQfnx0?=
 =?us-ascii?Q?jx0MJ84jRoT0ZGj0cyp5t2U9TX4vegpl+xHSCGD2Me+gzsgKzGWQgzXdVvrf?=
 =?us-ascii?Q?lxfAqNGdVEigZZPaUO8Uw+YuCy+wEOdnHV8apk0fB0FUct8flgWvOuGeRAt8?=
 =?us-ascii?Q?01kXTzC5+IgRpQTrCXYx7qjqjlhWwa7avp8LdP7XnEp/dvjmdfiuruEbal/B?=
 =?us-ascii?Q?SQZ3eYvnGzXnFBAVFyCmeOY7hcPwSqkqpQ4GXNqlCFNp+lack0E7Mg1+rwnO?=
 =?us-ascii?Q?4OOE8uCTKHprTiRKsOdNy24NCXuPm/fe7hUkR/FFnSVZEw0ewuv0SZy5q13C?=
 =?us-ascii?Q?kxjRNl/kb3bES170l6854SKmntbTik1/5pQA5gVLvVO8tAITu0PbZwnLakYi?=
 =?us-ascii?Q?/PCpzonnciboIJ5/RPPYZV/GD0JwA6F+91PU+WFRCA/v6bs2870T1DLCQLrM?=
 =?us-ascii?Q?MTRxNFU4CWw1/XQjiFV9KnqKgY4yqIgVb6COLCtPksxpoFuyQueV2j9TlvaO?=
 =?us-ascii?Q?X+e9UqBIllSq9NFB3ql+t8BfIOnAOb1pp2NrhCcFhQ1KC40eKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:11:00.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84577b95-f58b-4cf7-d283-08dca0427d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337

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
Changes for v5:
- Remove linux/of_address.h include from core.c
- Move dwc3_get_properties() implementation above dwc3_get_properties().
- Rename DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED.

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
 drivers/usb/dwc3/core.c        | 37 ++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h        |  8 ++++++++
 drivers/usb/dwc3/dwc3-xilinx.c | 29 ++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..ebb3f6eb191f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -599,6 +599,18 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
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
@@ -1338,6 +1350,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
@@ -1576,6 +1590,27 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 }
 
+static void dwc3_get_software_properties(struct dwc3 *dwc)
+{
+	struct device *tmpdev;
+	u16 gsbuscfg0_reqinfo;
+	int ret;
+
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
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
 static void dwc3_get_properties(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
@@ -2090,6 +2125,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc3_get_software_properties(dwc);
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..1e561fd8b86e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -194,6 +194,10 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
+#define DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED	0xffffffff
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

base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
-- 
2.34.1


