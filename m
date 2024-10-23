Return-Path: <linux-kernel+bounces-377388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBF9ABE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9515B24E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7498149DF7;
	Wed, 23 Oct 2024 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IOpiuPoh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938C1487D6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662720; cv=fail; b=oXr3vysMHLxbyV5W+vpC2Lc8kZxUMJfakptHb1vmeQAjrFFrzzFwaXjRt0xAjDagELXGTwF25rZmDhQ0F9bzR7xy3Ys8lx71hYs9BySAgySNONFRgMIbjaE19LjEDByqfTEG48RPTp3gg1YDjd/tg8Dn66xoFFeWZHoI4AC3kYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662720; c=relaxed/simple;
	bh=3FjjYJ3HnG+oIjAKt64uDxo6vIP9qEDmxkd4c4k9zwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeZn58+qqjnIP99SskyNbqtb7OngfgLWbXxr/8uXYbj97g0oUSD7qlIQnNkRr3GMWs5CTx8qwYJLmoHseEZxyXsAXMyrNTzvtxmWgawEZRFI5XuhRPGSQv8L5MkglE1dtc5YuirjV9NIAzJhPdBDWx68CwwTBEmEKHfICpkqVvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IOpiuPoh; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c34Kzf7UEUW87klXYEL8R9jFrNp11A41Z6uZHvmrbtUSsndHMjb+egE9yqS4wPOPOJybpAhQlHM6ot64hexw66b/P0ncoEwjPijKBy4dXiXzxFExBQ5JOVJ6h15oo2vATNS+USLnVoUUq4yvzUL1a2AHwNu5egTEFUUsenqECLqsi4CqKV1kkFFJnWrwYAsPH2zBvdox7TN6OqBkhavptaNVMvucxlKGzKuXS8Hs8d7k1Tqit4a4gQDwqwPY30J0Igln7yENfh5k+PSPxRVPIA86p2bKEUJSRaCJmNxSMDCUiJ5PWce60yposYzirGtCJ1Yp+fN3Zq5N1EWg6rH/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWL2WcCe7iZUOWOu5UAIApA6N3zRB+R9zcGr2OEi7Eg=;
 b=Ftw9v1UyzOOI7gIiEq2TU0vnHSkXjursWum01JW+ITCV32EBmDlM/5Nl5wTwZEBt0kp05WrrBuTUh31Y/XmUOmUAQFRav8FUnbZWeCdk8oS7hAdNPztWcIRBzCe1S6XkzjTNtyi1HkXATzFFZ/an0R3rVvwurud7zLn0etyvAoTlWpTziGOZRdJR314zSUlB5IjVYfmblsWm+rOsi78hQ0RcNm+xiG+97TmA1ItlbFXHq1OTX9Rv8QkXIrQLqMqXU9R3T62/1rrhTC0jCI7EKBLm4k6E2DjV/PKV5cBDfUyFdOOrXakt+aPzmVP1HpKjXb7EwQsqF8lYCp+AQVmK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWL2WcCe7iZUOWOu5UAIApA6N3zRB+R9zcGr2OEi7Eg=;
 b=IOpiuPohMfRTwgpOIX6B69w52rw8vQIThF46nYm4K/rARZq2kzdTL0epGKTkHp8d14Zq9vD4Z6pC1ZPHZVEKaQ5qFWiTyaRM8xPZMIlTgENaAwVoyG8a+2IQYcf3QCRCTXhu3yirvV4pXW41V06qQV7vF7cWUaxXuIJBWOYpnqk=
Received: from DS7PR03CA0217.namprd03.prod.outlook.com (2603:10b6:5:3ba::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 05:51:55 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::37) by DS7PR03CA0217.outlook.office365.com
 (2603:10b6:5:3ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 05:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 05:51:55 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 00:51:52 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 3/6] i3c: master: Add ACPI support to i3c subsystem
Date: Wed, 23 Oct 2024 11:21:15 +0530
Message-ID: <20241023055118.1400286-4-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b217cab-f281-45b8-a367-08dcf326cd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WuXUogQjzylRdwzYpOUre+tFVDFgOQvMm2Op69hvNRnDKTDj27gmipXUaBht?=
 =?us-ascii?Q?aqVBdQVyJtigS8ahVozgVc9Nydld4eGyESqPoUImxlMw8pqU+YTn5xQAmEfy?=
 =?us-ascii?Q?1q1Pt1ulHUw3mM20ij8XA128wtyIy+PuslGWZaiPvtJUdMdAUsSjg5bNwjel?=
 =?us-ascii?Q?SRC1I3baKUQN+F8JiEpzOX0grJWjKPv8hpRXTB4drD8BefTEy19LmrGnZ/Y/?=
 =?us-ascii?Q?03EplpNCyksl/7t4RYZjI0Ii0qVCWltOSR2AyerSua2pcons2MNRSgWcimAj?=
 =?us-ascii?Q?gMBW5BqGXddalfqgFJbPVOoADTHwxCLxDM4KO4/+bg6GR2Y5yDhzmsEgOH12?=
 =?us-ascii?Q?tuEuf5X4BxCVVby86Hwp15us9k3LdLnhuGIEHmMxm8TkYRcvn30uygR9Sekx?=
 =?us-ascii?Q?bdNMlW5vpumF9B46yCfCapyk5beAG5c7crxkDVQVFqYBEEdHgiB4laJPjp14?=
 =?us-ascii?Q?wbsmin6OHqVb8xRKFkv7hXAEGwug2klCdvLexkBPVp6zTKa7Bk//loyR+hlz?=
 =?us-ascii?Q?BYyR0HJ/Q3WswsziUIkFIrJzWnQrQ8BF8ip0gVQJgu2zt0aKm5cJiuRnbkBX?=
 =?us-ascii?Q?5vFshAkVmmoY4WUjOaWh5UXY+L+xdQFkHskOtK2aTm7JvXgUIQgXWcVUevOf?=
 =?us-ascii?Q?WA7Jk7MtelrPXdJ0aGEaho0/jh2LoSG5TjJ0XOwYQ/r3wS6u41CZqi3tRvUj?=
 =?us-ascii?Q?lnKl/VgV+87yiCH2pyXzV/ZAcSUiLxQY8xznHx8NdAwC5bJpZXgTYYswcKAF?=
 =?us-ascii?Q?VuqJmDb1dvGa14Z8V05cyylff4wZivoSM1c/kUEYc0jSRTyAxD3lDuRRnsci?=
 =?us-ascii?Q?bVCVjrTc1TICNkViyhxoMuAkiP0/1EiP6pHui4DsNpLQcUtaxra23oLIzVK1?=
 =?us-ascii?Q?wP9EA6HnzFSAuSvjgEqkK3KxfHto8JUGoiYB5pCInxxCHi+hHlXt9QdWoVuh?=
 =?us-ascii?Q?aLPDpdQXiWczCOofneTIawqGk46gAARxbSZ9Rej55OzfNTBEHOhb8g0r9glQ?=
 =?us-ascii?Q?Tvi5qviJ0TbW/QpvLKGMqbdiQP+jqsMHSZOvj4A9cW+31g3kLDVfkIjDDIFu?=
 =?us-ascii?Q?Ds2bPwunqlnBgpEFJ72AeSkpO6vZJoBrNZfKouIXgttoMwkACX/sK0pz3MX0?=
 =?us-ascii?Q?mZtgr/MDsxL8ZBQxpigXkmgPPeNtNx//0xnYhfc8zqG0wpZaOnqoQzlvwapo?=
 =?us-ascii?Q?pSEqd/ctk8BgGdLX0LPUIScPWbBhTllKP4k93UYgHtlCd9Kf2FKgpr/mgbtG?=
 =?us-ascii?Q?zHFghRliDAzDJ0NP9z4wh8R2tJmfVGICtyvZWccwR5VJGB3rfsNIBKH54nzk?=
 =?us-ascii?Q?cdeMhSkEtT6SiEl1eJmm2k0xCYn3MszlsTPj0pj1wdVYqtYWCOxQ0D2m6uqg?=
 =?us-ascii?Q?FAkaQAi+WVi4QKm6JlVuY1vFvwgjJyWf6EBwc58Oa4LFxvvFxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:51:55.5921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b217cab-f281-45b8-a367-08dcf326cd40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

As of now, the I3C subsystem only has ARM-specific initialization, and
there is no corresponding ACPI plumbing present. To address this, ACPI
support needs to be added to both the I3C core and DW driver.

Add support to get the ACPI handle from the _HID probed and parse the apci
object to retrieve the slave information from BIOS.

Based on the acpi object information propogated via BIOS, build the i3c
board information so that the same information can be used across the
driver to handle the slave requests.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/internals.h            |  2 +
 drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c |  7 +++
 include/linux/i3c/master.h         |  1 +
 4 files changed, 94 insertions(+)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 433f6088b7ce..d2d6c69b19dd 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -10,6 +10,8 @@
 
 #include <linux/i3c/master.h>
 
+#define AMD_I3C_GET_SLAVE_ADDR		0x30
+
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6f3eb710a75d..7d23c32e1c0f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
+static int i3c_acpi_configure_master(struct i3c_master_controller *master)
+{
+	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
+	enum i3c_addr_slot_status addrstatus;
+	struct i3c_dev_boardinfo *boardinfo;
+	struct device *dev = &master->dev;
+	struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	u32 slv_addr, num_dev;
+	acpi_status status;
+	u64 val;
+
+	status = acpi_evaluate_object_typed(master->ahandle, "_DSD", NULL, &buf, ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&master->dev, "Error reading _DSD:%s\n", acpi_format_exception(status));
+		return -ENODEV;
+	}
+
+	num_dev = device_get_child_node_count(dev);
+	if (!num_dev) {
+		dev_err(&master->dev, "Error: no child node present\n");
+		return -EINVAL;
+	}
+
+	device_for_each_child_node(dev, fwnode) {
+		adev = to_acpi_device_node(fwnode);
+		if (!adev)
+			return -ENODEV;
+
+		status = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &val);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&master->dev, "Error: eval _ADR failed\n");
+			return -EINVAL;
+		}
+		slv_addr = val >> AMD_I3C_GET_SLAVE_ADDR;
+
+		boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
+		if (!boardinfo)
+			return -ENOMEM;
+
+		if (slv_addr) {
+			if (slv_addr > I3C_MAX_ADDR)
+				return -EINVAL;
+
+			addrstatus = i3c_bus_get_addr_slot_status(&master->bus, slv_addr);
+			if (addrstatus != I3C_ADDR_SLOT_FREE)
+				return -EINVAL;
+		}
+
+		boardinfo->static_addr = slv_addr;
+		if (boardinfo->static_addr > I3C_MAX_ADDR)
+			return -EINVAL;
+
+		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,	boardinfo->static_addr);
+		if (addrstatus != I3C_ADDR_SLOT_FREE)
+			return -EINVAL;
+
+		boardinfo->pid = (val & GENMASK(47, 0));
+		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
+		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
+			return -EINVAL;
+
+		/*
+		 * According to the specification, SETDASA is not supported for DIMM slaves
+		 * during device discovery. Therefore, AMD BIOS will populate same initial
+		 * dynamic address as the static address.
+		 */
+		boardinfo->init_dyn_addr = boardinfo->static_addr;
+		list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
+	}
+
+	return 0;
+}
+#else
+static int i3c_acpi_configure_master(struct i3c_master_controller *master) { return 0; }
+#endif
+
 static int of_populate_i3c_bus(struct i3c_master_controller *master)
 {
 	struct device *dev = &master->dev;
@@ -2771,6 +2849,12 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.coherent_dma_mask = parent->coherent_dma_mask;
 	master->dev.dma_parms = parent->dma_parms;
 
+	if (has_acpi_companion(master->dev.parent)) {
+		ret = i3c_acpi_configure_master(master);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = of_populate_i3c_bus(master);
 	if (ret)
 		goto err_put_dev;
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index fd58a95ae1c3..f683e2a398ad 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1602,6 +1602,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	master->maxdevs = ret >> 16;
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
+#if IS_ENABLED(CONFIG_ACPI)
+	ACPI_COMPANION_SET(&master->base.dev, ACPI_COMPANION(&pdev->dev));
+	master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
+	if (!master->base.ahandle)
+		dev_err(&pdev->dev, "Failed to get acpi device handle\n");
+#endif
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2a1ed05d5782..367faf7c4bf3 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -523,6 +523,7 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	acpi_handle ahandle;
 };
 
 /**
-- 
2.34.1


