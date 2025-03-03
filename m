Return-Path: <linux-kernel+bounces-540986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E351AA4B732
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96757A1170
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0F1D63F0;
	Mon,  3 Mar 2025 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QohRNlkw"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7141AD3E1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977064; cv=fail; b=mgubXGFjz3ngqBJ+lnCStS8tuaOCkJdgg21JhaLea1A27qyHwRM7AisWP8nLfo4ltaHkAzsKWkT5ILL9Prt0p8yQWbQpcUhl1Hj+cKn6hqyzOW0cgW4nypOdSkDoYipGJ07srgrBR5PsfrSCdb6HcrTa6hHCNmw70BmaQcEi9mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977064; c=relaxed/simple;
	bh=XtGjJbAHgyQDywu4sAzTo90MpkCHxk/IlmXCuJPEEIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY0RObNlY6kE0Ut5OAPa9Bo8LsHrlzcv7cRtFCcTKJmLcnt9HuWlO8EE5AX+0EVzL09mUUg8FzriSjcvbuHvb+yzVOnI+BFw1gTgFx0FCcJ0MrjNHIhC1HUMxoY4BZN9dHjLSk8nxgxkmyxVYklDcIMV4wxh82FXO0kbDzA786c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QohRNlkw; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pblDrCjGcufyuZ8fcL+///7svB9qGi+KdqlE+v6/5Tvyza8A45nrjdT4LvLzJcQjeyDoAQL1XvPhXRCbuHkB5RkwrpQNpnTJdUH5XpYht3rr+QVFOc+Uk8JAR47bxUkxjWxYVkJvOzM6rkegc08SM7DT8La7Hxfn0TyHtch03YuFnC5RcnkIkDgQSB6UQBqKTsobY9wbSk59sT5CkrODp90vWr0Cl7yfdK0CrS/sSI49yx2fKFzyoLvYeAs5iQ3yzWonN+CGCZukZysRpmlTzPS9idTEdzB2T35KiKvoQh6YngBNsT6twFNYtb1tbxq0TPCaw6fFJaizwIhTaI9Ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djM+GQuvpvhxQwRb1KrH4iDfNebLIP//8tpauoKvBAM=;
 b=tOgitb0flS6URv6qzwasWbugC7U7eAxlKkgbzL/VlOK9GX3B3Y1BOqmPrf4c1FTjufuUloRrH59XBrpU3Dqc1Crl5zW2NX+xwDDS8lDerQ6yPeoN8meQlSd8CiTCXqTBri+f7jqmwFz4Sq1vnjDLlSkPzPRt5bYhuM6W5StBFoVL12z9FtGigVEbc9l0GYsi0PPc7THAFIqkDKl/aVn+DC+AcWWTJDsYjih6sUWO16S5+HW0D2yTmQYneI1ocUNcXGZWcRDPXXdtt+QA4V3xBm5zlu9hM7Ofpmny1hNeIADmmhgBfT5FwdnTar3VNFerIFABxildLO17xSHFcBQetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djM+GQuvpvhxQwRb1KrH4iDfNebLIP//8tpauoKvBAM=;
 b=QohRNlkwqaI0rA8lbDIjTO/Yx/erPV0YGSQo57yATsmrYWC2GprY6u5WXyDFXz7BHXeeofhh4XnoY126a6PcC0MQU/lebS0Aqu0XX75fFXx9gDHepvEVNRB2zN8+1Zh+aSRtFawjWiTM4UCeCqP9hSIX397wSJ4qFG4wvUUkYdE=
Received: from MN2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:208:15e::34)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 04:44:16 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::c) by MN2PR17CA0021.outlook.office365.com
 (2603:10b6:208:15e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Mon,
 3 Mar 2025 04:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 04:44:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:44:11 -0600
Received: from xsjdavidz01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 2 Mar 2025 22:44:11 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>,
	<christophe.jaillet@wanadoo.fr>, Nishad Saraf <nishads@amd.com>
Subject: [PATCH V0 3/3] drivers/misc/amd: Add load base shell firmware
Date: Sun, 2 Mar 2025 20:43:12 -0800
Message-ID: <20250303044313.679012-4-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303044313.679012-1-yidong.zhang@amd.com>
References: <20250303044313.679012-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bba117-5bf9-4d6f-abf7-08dd5a0e0d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJDiFjHcOgsrYgCSOP+GN6avtQhKiwCRKdvoUwQQBHef5cQ3qQfXGLDmCAIz?=
 =?us-ascii?Q?zc8QHnu5PW4qdgZvtuEhmo6duu+33sPGTjHyXJKbkyos36kwvAwO0clLHuSI?=
 =?us-ascii?Q?xCcTvkqkclsy9vsUbe3jPGTPX029b3yUEMbf6aL4/oPtsEv7xz0CwatgdhWc?=
 =?us-ascii?Q?KM1+0mU13g962NdEzR4FrmpP4qrFRmk0gMEh60EczhzMSvTuk61U17+b4q/k?=
 =?us-ascii?Q?5Ikthkb2fX/xHrXB7EY0go+uirpXSYicn3xsH9ZBRVgX4crPznmg9OxEpK3h?=
 =?us-ascii?Q?rhsxUEbuRUMs7/qtj1XlEbaWe4g4NR7UWCyIzOv4RherG8ZioI+gf2WfGEtq?=
 =?us-ascii?Q?5crjn3KPzInfox5kXasc3IDal0ffB8v8c8hShy/DiTn4sOrgt/kYe1BMnlN0?=
 =?us-ascii?Q?bEaE7pfQ0ZX2inUAilbncgR7ZiN0Ye1UqY+ORl2npSYS++48Xf+tXEzdmenH?=
 =?us-ascii?Q?FpwGn/vqXJVsl4qPvJOh5VbwIyzNWqtm6gsiXmO5x6iuWuo32VQNg6ysm5LT?=
 =?us-ascii?Q?71J3bWD9lGXfGyuNRpChZIiqXJR5D7vjJ9tcdFqgrZblbwY7iA0YehicYmDc?=
 =?us-ascii?Q?CzG7NVQLoyE8o4lj6jdsjPN6jxl9PO+hxTdUhMIv27s65SVj/XTdORoSdE48?=
 =?us-ascii?Q?N1pUVMcSWhumme4MzgIBQAp0AXlUOHlT+sLgLb9/0fJt1Bagc2dO0IfL6rBm?=
 =?us-ascii?Q?bUqMUol015E+dDS+/aHxHwqWom5eyF1w5leO7mRMv5hNR7AvIhpsuZJKFGHU?=
 =?us-ascii?Q?DuyUvs33thVdhXafkZtAWpewYRBPY2a5iq+2mXeiQGVad4IdZDznMKQQT5SE?=
 =?us-ascii?Q?UrotrDfuJje/g7vLanZsBjlyDj++g7nnNRaChDnLCpF39IvRlpyQhwRwP4Eg?=
 =?us-ascii?Q?nMBqNLgJw/yxTa0I6/ZY9QKoE7ePMHlYsvDNOYfS87m+T/wn9hGpkVBwygGV?=
 =?us-ascii?Q?tPCKU18rcrl0zoGqUT5WjQB6wpteazfVH9QqMtL2PHLlDrGhMbvLhPEvO3f9?=
 =?us-ascii?Q?7cxE6kZMj8yDSfvHKWK3VPm0bpzZI0dY9vwWzv3S5BD/IVJq0ec54YezLvdb?=
 =?us-ascii?Q?OJh5vwLA4yEKCFjI8zEfD2xAPanK+FxVTiwpjl4/MbA2ysNgNEc/8YHjE/1C?=
 =?us-ascii?Q?pUGYbODVF95ZlRxah1OBcKE9ptw6jLgBXLsx+Snz8B4igU2ABMk3G1SdeZsZ?=
 =?us-ascii?Q?yGJ1JMFr2f0fTAIFo1hxRmnoe0BaEv9PpTNswABKBB64iLAkM+biP/UYO1I5?=
 =?us-ascii?Q?OHxEx4RlnL1te5Y2Ow5ipM090s077cJ5OavkrOk1EnI1ynoPvtYcrmHc5ZpM?=
 =?us-ascii?Q?YsWeZ3QP9HWvWMIsLdv+FQBuIm1XEpUjki7HFerCjcihRj4eDcC2MhJHChmA?=
 =?us-ascii?Q?qd1QJ/Gr35wva7qeurrj8t8zVgH+3M5GrnuPBg7Q5YS8pDnEAgv74CWnm76f?=
 =?us-ascii?Q?laGqH3xGQqe6monTFAOYATiWhb92W/yNj4T0Jw8hR7HRl/Ob7Uk2AqVnig3c?=
 =?us-ascii?Q?+vtOSkaQeDnyJl0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 04:44:16.0226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bba117-5bf9-4d6f-abf7-08dd5a0e0d99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734

- programming FW
  - The base FW is downloaded onto the flash of the card.
  - The APU FW is downloaded once after a POR (power on reset).
  - Reloading the driver will not change any existing hardware.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 drivers/misc/amd/Makefile                |   3 +-
 drivers/misc/amd/versal-pci-main.c       |  45 +-
 drivers/misc/amd/versal-pci-rm-queue.c   |  14 +-
 drivers/misc/amd/versal-pci-rm-service.c | 497 +++++++++++++++++++++++
 drivers/misc/amd/versal-pci-rm-service.h |  20 +
 drivers/misc/amd/versal-pci.h            |   1 +
 6 files changed, 569 insertions(+), 11 deletions(-)
 create mode 100644 drivers/misc/amd/versal-pci-rm-service.c

diff --git a/drivers/misc/amd/Makefile b/drivers/misc/amd/Makefile
index 63879800a3e5..03394b06fd33 100644
--- a/drivers/misc/amd/Makefile
+++ b/drivers/misc/amd/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_AMD_VERSAL_PCI)		+= versal-pci.o
 
 versal-pci-$(CONFIG_AMD_VERSAL_PCI)	:= versal-pci-main.o \
-					   versal-pci-rm-queue.o
+					   versal-pci-rm-queue.o \
+					   versal-pci-rm-service.o
diff --git a/drivers/misc/amd/versal-pci-main.c b/drivers/misc/amd/versal-pci-main.c
index 1c61c88120b4..6d3a2833f0c4 100644
--- a/drivers/misc/amd/versal-pci-main.c
+++ b/drivers/misc/amd/versal-pci-main.c
@@ -8,6 +8,8 @@
 #include <linux/pci.h>
 
 #include "versal-pci.h"
+#include "versal-pci-rm-service.h"
+#include "versal-pci-rm-queue.h"
 
 #define DRV_NAME			"amd-versal-pci"
 
@@ -21,6 +23,29 @@ static inline u32 versal_pci_devid(struct versal_pci_device *vdev)
 		PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn));
 }
 
+static int versal_pci_upload_fw(struct versal_pci_device *vdev,
+				enum rm_queue_opcode opcode,
+				const char *data,
+				size_t size)
+{
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(vdev->rdev, opcode, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_data_init(cmd, data, size);
+	if (ret)
+		goto done;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
+
+done:
+	rm_queue_destroy_cmd(cmd);
+	return ret;
+}
+
 static int versal_pci_load_shell(struct versal_pci_device *vdev, char *fw_name)
 {
 	const struct firmware *fw;
@@ -57,7 +82,8 @@ static int versal_pci_load_shell(struct versal_pci_device *vdev, char *fw_name)
 		goto release_firmware;
 	}
 
-	/* TODO upload fw to card */
+	ret = versal_pci_upload_fw(vdev, RM_QUEUE_OP_LOAD_FW,
+				   (char *)xsabin, xsabin->header.length);
 	if (ret) {
 		vdev_err(vdev, "failed to load xsabin %s : %d", fw_name, ret);
 		goto release_firmware;
@@ -159,6 +185,7 @@ static void versal_pci_device_teardown(struct versal_pci_device *vdev)
 {
 	versal_pci_cfs_fini(&vdev->cfs_subsys);
 	versal_pci_fw_fini(vdev);
+	versal_pci_rm_fini(vdev->rdev);
 }
 
 static void versal_pci_uuid_parse(struct versal_pci_device *vdev, uuid_t *uuid)
@@ -180,7 +207,13 @@ static void versal_pci_uuid_parse(struct versal_pci_device *vdev, uuid_t *uuid)
 
 static int versal_pci_fw_init(struct versal_pci_device *vdev)
 {
-	/* TODO request compatible fw_id from card */
+	int ret;
+
+	ret = rm_queue_get_fw_id(vdev->rdev);
+	if (ret) {
+		vdev_warn(vdev, "Failed to get fw_id");
+		return -EINVAL;
+	}
 
 	versal_pci_uuid_parse(vdev, &vdev->intf_uuid);
 
@@ -191,6 +224,13 @@ static int versal_pci_device_setup(struct versal_pci_device *vdev)
 {
 	int ret;
 
+	vdev->rdev = versal_pci_rm_init(vdev);
+	if (IS_ERR(vdev->rdev)) {
+		ret = PTR_ERR(vdev->rdev);
+		vdev_err(vdev, "Failed to init remote queue, err %d", ret);
+		return ret;
+	}
+
 	ret = versal_pci_fw_init(vdev);
 	if (ret) {
 		vdev_err(vdev, "Failed to init fw, err %d", ret);
@@ -206,6 +246,7 @@ static int versal_pci_device_setup(struct versal_pci_device *vdev)
 	return 0;
 
 comm_chan_fini:
+	versal_pci_rm_fini(vdev->rdev);
 
 	return ret;
 }
diff --git a/drivers/misc/amd/versal-pci-rm-queue.c b/drivers/misc/amd/versal-pci-rm-queue.c
index 8c1aca442253..7afc5a1e238c 100644
--- a/drivers/misc/amd/versal-pci-rm-queue.c
+++ b/drivers/misc/amd/versal-pci-rm-queue.c
@@ -23,37 +23,35 @@ static inline struct rm_device *to_rdev_msg_timer(struct timer_list *t)
 
 static inline u32 rm_io_read(struct rm_device *rdev, u32 offset)
 {
-	/* TODO */
-	return 0;
+	return rm_reg_read(rdev, RM_PCI_IO_BAR_OFF + offset);
 }
 
 static inline int rm_io_write(struct rm_device *rdev, u32 offset, u32 value)
 {
-	/* TODO */
+	rm_reg_write(rdev, RM_PCI_IO_BAR_OFF + offset, value);
 	return 0;
 }
 
 static inline u32 rm_queue_read(struct rm_device *rdev, u32 offset)
 {
-	/* TODO */
-	return 0;
+	return rm_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset);
 }
 
 static inline void rm_queue_write(struct rm_device *rdev, u32 offset, u32 value)
 {
-	/* TODO */
+	rm_reg_write(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset, value);
 }
 
 static inline void rm_queue_bulk_read(struct rm_device *rdev, u32 offset,
 				      u32 *value, u32 size)
 {
-	/* TODO */
+	rm_bulk_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset, value, size);
 }
 
 static inline void rm_queue_bulk_write(struct rm_device *rdev, u32 offset,
 				       u32 *value, u32 size)
 {
-	/* TODO */
+	rm_bulk_reg_write(rdev, RM_PCI_SHMEM_BAR_OFF + rdev->queue_base + offset, value, size);
 }
 
 static inline u32 rm_queue_get_cidx(struct rm_device *rdev, enum rm_queue_type type)
diff --git a/drivers/misc/amd/versal-pci-rm-service.c b/drivers/misc/amd/versal-pci-rm-service.c
new file mode 100644
index 000000000000..6dbad1c6563d
--- /dev/null
+++ b/drivers/misc/amd/versal-pci-rm-service.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include "versal-pci.h"
+#include "versal-pci-rm-service.h"
+#include "versal-pci-rm-queue.h"
+
+static DEFINE_IDA(rm_cmd_ids);
+
+static void rm_uninstall_health_monitor(struct rm_device *rdev);
+
+static inline struct rm_device *to_rdev_health_monitor(struct work_struct *w)
+{
+	return container_of(w, struct rm_device, health_monitor);
+}
+
+static inline struct rm_device *to_rdev_health_timer(struct timer_list *t)
+{
+	return container_of(t, struct rm_device, health_timer);
+}
+
+u32 rm_reg_read(struct rm_device *rdev, u32 offset)
+{
+	return readl(rdev->vdev->io_regs + offset);
+}
+
+void rm_reg_write(struct rm_device *rdev, u32 offset, const u32 value)
+{
+	writel(value, rdev->vdev->io_regs + offset);
+}
+
+void rm_bulk_reg_read(struct rm_device *rdev, u32 offset, u32 *value, size_t size)
+{
+	void __iomem *src = rdev->vdev->io_regs + offset;
+	void *dst = (void *)value;
+
+	memcpy_fromio(dst, src, size);
+	/* Barrier of reading data from device */
+	rmb();
+}
+
+void rm_bulk_reg_write(struct rm_device *rdev, u32 offset, const void *value, size_t size)
+{
+	void __iomem *dst = rdev->vdev->io_regs + offset;
+
+	memcpy_toio(dst, value, size);
+	/* Barrier of writing data to device */
+	wmb();
+}
+
+static inline u32 rm_shmem_read(struct rm_device *rdev, u32 offset)
+{
+	return rm_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + offset);
+}
+
+static inline void rm_shmem_bulk_read(struct rm_device *rdev, u32 offset,
+				      u32 *value, u32 size)
+{
+	rm_bulk_reg_read(rdev, RM_PCI_SHMEM_BAR_OFF + offset, value, size);
+}
+
+static inline void rm_shmem_bulk_write(struct rm_device *rdev, u32 offset,
+				       const void *value, u32 size)
+{
+	rm_bulk_reg_write(rdev, RM_PCI_SHMEM_BAR_OFF + offset, value, size);
+}
+
+void rm_queue_destroy_cmd(struct rm_cmd *cmd)
+{
+	ida_free(&rm_cmd_ids, cmd->sq_msg.hdr.id);
+	kfree(cmd);
+}
+
+static int rm_queue_copy_response(struct rm_cmd *cmd, void *buffer, ssize_t len)
+{
+	struct rm_cmd_cq_log_page *result = &cmd->cq_msg.data.page;
+	u64 off = cmd->sq_msg.data.page.address;
+
+	if (!result->len || len < result->len) {
+		vdev_err(cmd->rdev->vdev, "Invalid response or buffer size");
+		return -EINVAL;
+	}
+
+	rm_shmem_bulk_read(cmd->rdev, off, (u32 *)buffer, result->len);
+	return 0;
+}
+
+static void rm_queue_payload_fini(struct rm_cmd *cmd)
+{
+	up(&cmd->rdev->cq.data_lock);
+}
+
+static int rm_queue_payload_init(struct rm_cmd *cmd,
+				 enum rm_cmd_log_page_type type)
+{
+	struct rm_device *rdev = cmd->rdev;
+	int ret;
+
+	ret = down_interruptible(&rdev->cq.data_lock);
+	if (ret)
+		return ret;
+
+	cmd->sq_msg.data.page.address = rdev->cq.data_offset;
+	cmd->sq_msg.data.page.size = rdev->cq.data_size;
+	cmd->sq_msg.data.page.reserved1 = 0;
+	cmd->sq_msg.data.page.type = FIELD_PREP(RM_CMD_LOG_PAGE_TYPE_MASK,
+						type);
+	return 0;
+}
+
+void rm_queue_data_fini(struct rm_cmd *cmd)
+{
+	up(&cmd->rdev->sq.data_lock);
+}
+
+int rm_queue_data_init(struct rm_cmd *cmd, const char *buffer, ssize_t size)
+{
+	struct rm_device *rdev = cmd->rdev;
+	int ret;
+
+	if (!size || size > rdev->sq.data_size) {
+		vdev_err(rdev->vdev, "Unsupported file size");
+		return -ENOMEM;
+	}
+
+	ret = down_interruptible(&rdev->sq.data_lock);
+	if (ret)
+		return ret;
+
+	rm_shmem_bulk_write(cmd->rdev, rdev->sq.data_offset, buffer, size);
+
+	cmd->sq_msg.data.bin.address = rdev->sq.data_offset;
+	cmd->sq_msg.data.bin.size = size;
+	return 0;
+}
+
+int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
+			struct rm_cmd **cmd_ptr)
+{
+	struct rm_cmd *cmd = NULL;
+	int ret, id;
+	u16 size;
+
+	if (rdev->firewall_tripped)
+		return -ENODEV;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+	cmd->rdev = rdev;
+
+	switch (opcode) {
+	case RM_QUEUE_OP_LOAD_XCLBIN:
+		fallthrough;
+	case RM_QUEUE_OP_LOAD_FW:
+		fallthrough;
+	case RM_QUEUE_OP_LOAD_APU_FW:
+		size = sizeof(struct rm_cmd_sq_bin);
+		break;
+	case RM_QUEUE_OP_GET_LOG_PAGE:
+		size = sizeof(struct rm_cmd_sq_log_page);
+		break;
+	case RM_QUEUE_OP_IDENTIFY:
+		size = 0;
+		break;
+	case RM_QUEUE_OP_VMR_CONTROL:
+		size = sizeof(struct rm_cmd_sq_ctrl);
+		break;
+	default:
+		vdev_err(rdev->vdev, "Invalid cmd opcode %d", opcode);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	cmd->opcode = opcode;
+	cmd->sq_msg.hdr.opcode = FIELD_PREP(RM_CMD_SQ_HDR_OPS_MSK, opcode);
+	cmd->sq_msg.hdr.msg_size = FIELD_PREP(RM_CMD_SQ_HDR_SIZE_MSK, size);
+
+	id = ida_alloc_range(&rm_cmd_ids, RM_CMD_ID_MIN, RM_CMD_ID_MAX, GFP_KERNEL);
+	if (id < 0) {
+		vdev_err(rdev->vdev, "Failed to alloc cmd ID: %d", id);
+		ret = id;
+		goto error;
+	}
+	cmd->sq_msg.hdr.id = id;
+
+	init_completion(&cmd->executed);
+
+	*cmd_ptr = cmd;
+	return 0;
+error:
+	kfree(cmd);
+	return ret;
+}
+
+static int rm_queue_verify(struct rm_device *rdev)
+{
+	struct versal_pci_device *vdev = rdev->vdev;
+	struct rm_cmd_cq_identify *result;
+	struct rm_cmd *cmd;
+	u32 major, minor;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_IDENTIFY, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret)
+		goto error;
+
+	result = &cmd->cq_msg.data.identify;
+	major = result->major;
+	minor = result->minor;
+	vdev_dbg(vdev, "VMR version %d.%d", major, minor);
+	if (!major) {
+		vdev_err(vdev, "VMR version is unsupported");
+		ret = -EOPNOTSUPP;
+	}
+
+error:
+	rm_queue_destroy_cmd(cmd);
+	return ret;
+}
+
+static int rm_check_apu_status(struct rm_device *rdev, bool *status)
+{
+	struct rm_cmd_cq_control *result;
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_VMR_CONTROL, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret)
+		goto error;
+
+	result = &cmd->cq_msg.data.ctrl;
+	*status = FIELD_GET(RM_CMD_VMR_CONTROL_PS_MASK, result->status);
+
+	rm_queue_destroy_cmd(cmd);
+	return 0;
+
+error:
+	rm_queue_destroy_cmd(cmd);
+	return ret;
+}
+
+static int rm_download_apu_fw(struct rm_device *rdev, char *data, ssize_t size)
+{
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_LOAD_APU_FW, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_data_init(cmd, data, size);
+	if (ret)
+		goto done;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
+
+done:
+	rm_queue_destroy_cmd(cmd);
+	return ret;
+}
+
+int rm_queue_boot_apu(struct rm_device *rdev)
+{
+	char *bin = "xilinx/xrt-versal-apu.xsabin";
+	const struct firmware *fw = NULL;
+	bool status;
+	int ret;
+
+	ret = rm_check_apu_status(rdev, &status);
+	if (ret) {
+		vdev_err(rdev->vdev, "Failed to get APU status");
+		return ret;
+	}
+
+	if (status) {
+		vdev_dbg(rdev->vdev, "APU online. Skipping APU FW download");
+		return 0;
+	}
+
+	ret = request_firmware(&fw, bin, &rdev->vdev->pdev->dev);
+	if (ret) {
+		vdev_warn(rdev->vdev, "Request APU FW %s failed %d", bin, ret);
+		return ret;
+	}
+
+	vdev_dbg(rdev->vdev, "Starting... APU FW download");
+	ret = rm_download_apu_fw(rdev, (char *)fw->data, fw->size);
+	vdev_dbg(rdev->vdev, "Finished... APU FW download %d", ret);
+
+	if (ret)
+		vdev_err(rdev->vdev, "Failed to download APU FW, ret:%d", ret);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static void rm_check_health(struct work_struct *w)
+{
+	struct rm_device *rdev = to_rdev_health_monitor(w);
+	u32 max_len = PAGE_SIZE;
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
+	if (ret)
+		return;
+
+	ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_AXI_TRIP_STATUS);
+	if (ret)
+		goto destroy_cmd;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret == -ETIME || ret == -EINVAL)
+		goto payload_fini;
+
+	if (ret) {
+		u32 log_len = cmd->cq_msg.data.page.len;
+
+		if (log_len > max_len) {
+			vdev_warn(rdev->vdev, "msg size %d is greater than requested %d",
+				  log_len, max_len);
+			log_len = max_len;
+		}
+
+		if (log_len) {
+			char *buffer = vzalloc(log_len);
+
+			if (!buffer)
+				goto payload_fini;
+
+			ret = rm_queue_copy_response(cmd, buffer, log_len);
+			if (ret) {
+				vfree(buffer);
+				goto payload_fini;
+			}
+
+			vdev_err(rdev->vdev, "%s", buffer);
+			vfree(buffer);
+
+		} else {
+			vdev_err(rdev->vdev, "firewall check ret%d", ret);
+		}
+
+		rdev->firewall_tripped = 1;
+	}
+
+payload_fini:
+	rm_queue_payload_fini(cmd);
+destroy_cmd:
+	rm_queue_destroy_cmd(cmd);
+
+	vdev_dbg(rdev->vdev, "check result: %d", ret);
+}
+
+static void rm_sched_health_check(struct timer_list *t)
+{
+	struct rm_device *rdev = to_rdev_health_timer(t);
+
+	if (rdev->firewall_tripped) {
+		vdev_err(rdev->vdev, "Firewall tripped, health check paused. Please reset card");
+		return;
+	}
+	/* Schedule a work in the general workqueue */
+	schedule_work(&rdev->health_monitor);
+	/* Periodic timer */
+	mod_timer(&rdev->health_timer, jiffies + RM_HEALTH_CHECK_TIMER);
+}
+
+static void rm_uninstall_health_monitor(struct rm_device *rdev)
+{
+	del_timer_sync(&rdev->health_timer);
+	cancel_work_sync(&rdev->health_monitor);
+}
+
+static void rm_install_health_monitor(struct rm_device *rdev)
+{
+	INIT_WORK(&rdev->health_monitor, &rm_check_health);
+	timer_setup(&rdev->health_timer, &rm_sched_health_check, 0);
+	mod_timer(&rdev->health_timer, jiffies + RM_HEALTH_CHECK_TIMER);
+}
+
+void versal_pci_rm_fini(struct rm_device *rdev)
+{
+	rm_uninstall_health_monitor(rdev);
+	rm_queue_fini(rdev);
+}
+
+struct rm_device *versal_pci_rm_init(struct versal_pci_device *vdev)
+{
+	struct rm_header *header;
+	struct rm_device *rdev;
+	u32 status;
+	int ret;
+
+	rdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->vdev = vdev;
+	header = &rdev->rm_metadata;
+
+	rm_shmem_bulk_read(rdev, RM_HDR_OFF, (u32 *)header, sizeof(*header));
+	if (header->magic != RM_HDR_MAGIC_NUM) {
+		vdev_err(vdev, "Invalid RM header 0x%x", header->magic);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	status = rm_shmem_read(rdev, header->status_off);
+	if (!status) {
+		vdev_err(vdev, "RM status %d is not ready", status);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	rdev->queue_buffer_size = header->data_end - header->data_start + 1;
+	rdev->queue_buffer_start = header->data_start;
+	rdev->queue_base = header->queue_base;
+
+	ret = rm_queue_init(rdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to init cmd queue, ret %d", ret);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = rm_queue_verify(rdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to verify cmd queue, ret %d", ret);
+		ret = -ENODEV;
+		goto queue_fini;
+	}
+
+	ret = rm_queue_boot_apu(rdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to bringup APU, ret %d", ret);
+		ret = -ENODEV;
+		goto queue_fini;
+	}
+
+	rm_install_health_monitor(rdev);
+
+	return rdev;
+queue_fini:
+	rm_queue_fini(rdev);
+err:
+	return ERR_PTR(ret);
+}
+
+int rm_queue_get_fw_id(struct rm_device *rdev)
+{
+	struct rm_cmd *cmd;
+	int ret;
+
+	ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
+	if (ret)
+		return ret;
+
+	ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_FW_ID);
+	if (ret)
+		goto destroy_cmd;
+
+	ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
+	if (ret)
+		goto payload_fini;
+
+	ret = rm_queue_copy_response(cmd, rdev->vdev->fw_id, sizeof(rdev->vdev->fw_id));
+	if (ret)
+		goto payload_fini;
+
+	vdev_info(rdev->vdev, "fw_id %s", rdev->vdev->fw_id);
+
+payload_fini:
+	rm_queue_payload_fini(cmd);
+destroy_cmd:
+	rm_queue_destroy_cmd(cmd);
+
+	return ret;
+}
diff --git a/drivers/misc/amd/versal-pci-rm-service.h b/drivers/misc/amd/versal-pci-rm-service.h
index d2397a1a672c..57333bb1443c 100644
--- a/drivers/misc/amd/versal-pci-rm-service.h
+++ b/drivers/misc/amd/versal-pci-rm-service.h
@@ -206,4 +206,24 @@ struct rm_device {
 	__u32			firewall_tripped;
 };
 
+/* rm service init api */
+struct rm_device *versal_pci_rm_init(struct versal_pci_device *vdev);
+void versal_pci_rm_fini(struct rm_device *rdev);
+
+/* rm services APIs */
+int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
+			struct rm_cmd **cmd_ptr);
+void rm_queue_destroy_cmd(struct rm_cmd *cmd);
+
+int rm_queue_data_init(struct rm_cmd *cmd, const char *buffer, ssize_t size);
+void rm_queue_data_fini(struct rm_cmd *cmd);
+int rm_queue_get_fw_id(struct rm_device *rdev);
+int rm_queue_boot_apu(struct rm_device *rdev);
+
+/* rm bar register operation APIs */
+u32 rm_reg_read(struct rm_device *rdev, u32 offset);
+void rm_reg_write(struct rm_device *rdev, u32 offset, const u32 value);
+void rm_bulk_reg_read(struct rm_device *rdev, u32 offset, u32 *value, size_t size);
+void rm_bulk_reg_write(struct rm_device *rdev, u32 offset, const void *value, size_t size);
+
 #endif	/* __RM_SERVICE_H */
diff --git a/drivers/misc/amd/versal-pci.h b/drivers/misc/amd/versal-pci.h
index 33f0ef881a33..89f3590137ce 100644
--- a/drivers/misc/amd/versal-pci.h
+++ b/drivers/misc/amd/versal-pci.h
@@ -51,6 +51,7 @@ struct fw_info {
 struct versal_pci_device {
 	struct pci_dev			*pdev;
 
+	struct rm_device		*rdev;
 	struct fw_info			fw;
 
 	void __iomem			*io_regs;
-- 
2.34.1


