Return-Path: <linux-kernel+bounces-286218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932895182B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C499B284546
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13991AE031;
	Wed, 14 Aug 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="irsmJO+z"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E781AD9F2;
	Wed, 14 Aug 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629639; cv=fail; b=upvEw0VE9V4laSk95gp85//tr3tmnA/kSBGHKYsHnPtv5a7Pg/dPKV+Ru6fWAj8mI9FEdmpwpwImkHeCvS+XXD+GqLQ9gxSkHoWGR4FYSVKNKd6fIb8bVp/rCxcVJkGix71dEDx5tLztfKePb57rj0q8uraXgOxd6fWFN6eUDvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629639; c=relaxed/simple;
	bh=HGHCTZe35h1oHsEN3Hnvb4qtyZ/1Bh+9PGWanej5nJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAR4Df+1Agqc5oh6QwheiOwAn6FWzNqaCkJS9UjSEdwx15wSk2yOA4HZsB5miARsaLU0zdy+jVyKWt4tIC3HRT4WdWvwCGvCv4RwL8KNPk9Fe1yoQWLWE7w5SRuXUwbH9yRIPoC1YyprwtJMgp7PE6FHECdLStuWH2XMVun5NuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=irsmJO+z; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHfwrsNZDrUVEumqDaui22VLbVruSz/Eg5C4k6lSL+LxZMTrNW++cN7muBYTGfmTBFv0h1Zd+gNvlQ8D38Fl6kKKHpe0tM2fQtggggLFlaEz8R3Pp1xTKidGvuXVTDYgIMYqRhjLezCketwzQpVxWFqr1MiUU+F05L69tISFztctGi1gXHZF7ESjAhthRepKXL8c9rxkK2adUtmq0Za1ZpTm7yLIQIAvmcs/VV/0+EQduF7QFWpPsYvZUlGmroxjHqHlRQu+Il6EAqdOSZaHOyfNb/3UjNb1D1TbKJviBPL2FRROSyMge1AZKBdyK7os2yE6Hdrp+oa37dly+bl/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/0/w3II1iOIpl5DB1ApvNmZj1Panp3zXCUseA7KvHU=;
 b=laNsja83MNSwknnOpxyJwtT9tzjuBoVzZ6PLUTue6XwuVDv8FE2Yt6RzrrQjW6qFXCGJXrz2+koTf8ROzxv74QsbUPNtaepWsb2qEHC4jeYfeUnemcazRTkj2+fWORi9bTgLXjnzhJGWoguy4pxEm7XtaPd8/yxfUeAt4uFuMxliEewqFsIGcPqp3MBYMNHDzdgb7g6v09Kdxy2NNis1vRuhteqNurDo0lp1oaIyDIeuh4s/SV0G7Qy7YkEvUsf7JjVMQbINuiz1DUOIZ17PL7Mz5DwhFtlDDIPxKotMiTXgF6cxGxf2icCIvQAewxOPffhlkG9GgKpJ3lHNNF/VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/0/w3II1iOIpl5DB1ApvNmZj1Panp3zXCUseA7KvHU=;
 b=irsmJO+zpqXbymK3J91MoyU6lWGggK6Nt6E2wVGaoWUcan9RoHmdEbHm4pYiCvdKtvI/vgSccV96eg7c8PUj24rvK+st/alko7n+bhQkaMuaP5oDjYilTvNW/+jo0zSWRxof2nEoeLRRIE0uh6gl2AmZ336PrTBkIYZ+NSE5M4M=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 10:00:31 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6e) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:31 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:27 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 3/8] misc: amd-sbi: Add support for AMD_SBI IOCTL
Date: Wed, 14 Aug 2024 09:59:48 +0000
Message-ID: <20240814095954.2359863-4-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240814095954.2359863-1-akshay.gupta@amd.com>
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 75685492-8ce9-4b90-6e28-08dcbc47ef0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OvXADMlXfYg8FteYHPjjGkK0oqq3ahrkOunXdD0BqE45c+4VNrl1gcABRMjb?=
 =?us-ascii?Q?ghIIAHMchoZu23urmW2e6W5fx48nvRMwFKSn1QlqAb/2Op6crcAW8my+cePH?=
 =?us-ascii?Q?hNTq51uvwFmGoaf9CTCCzjGssDkehf0rNbHkcmulUBf8ruLWiNdNis1C8Sa5?=
 =?us-ascii?Q?A/eOQdAweK30Y1Wkqh7wq7X6bBNZ4szfaofPKgKh5XRxj/icshRRmP7aw4rK?=
 =?us-ascii?Q?hVhRyBW9JJ9PrkObNx7xr771zrDibNXJJK0OKLiNiyuhU/mp+093OZBF1+W3?=
 =?us-ascii?Q?8byN5EosJTraqgqq/CfLaCX/Fm1e4F5yiEvtY08EJi4q7mR3LFS3c/DRvWl9?=
 =?us-ascii?Q?nWQuSol/gj4rSAG+Om078Ivie0an92CCTO8AThdj4CyuVJ9SOm11pmtvm2RO?=
 =?us-ascii?Q?sjb+X2WPnIxH11y6RaJV5iDiIseC/nN64mT3B0A4WE2WsXQNqNyCmAOi3pzO?=
 =?us-ascii?Q?lG8eicQJwcbgzOV5OCgMHZjcCtS7AaYbcAxyFJDBD4wnGufihjkBL9EtaQaD?=
 =?us-ascii?Q?NgOIaKosEnXAOGFIlOboYIWolGK4KUeX4bNwVYRpDK8wxvafcOnPzwL/icXU?=
 =?us-ascii?Q?uPzWmzBeNgE0d7Gr3a1jvjIERAgs9AFiBcAhj/ZF+ZmseSSxKsM7ZTXv9qsL?=
 =?us-ascii?Q?W4QL+EUKF3P2ZKjhBtuIahz1hDyJRtLu0g1K93DCcASxBRQ7f4PfuMN9tnXF?=
 =?us-ascii?Q?2Q7PVmbdB+ySRbOwp4M0wGNiCLaHORn/bqdlrzf+89sDHoLQO75iIugdRqG2?=
 =?us-ascii?Q?omgfYiTR3l7Myqt3liykZMI/Rk9p5cNaC5zyBP4cUjk8BEsfD5rzhOFqQcSw?=
 =?us-ascii?Q?v4v/NH2+QAaNn2mg55QeZHWsoL+sCsW20gnysJGv5lonQVb7fTxOl78f3QT8?=
 =?us-ascii?Q?u59BvZa0vUljTItMmzsL/1l6BD9DeaL8lssBiwpLfH1xm8ldWGpswrXhqrjP?=
 =?us-ascii?Q?rTMbsowpDa9nsfwcW8P+wphqeFNjdmsgKezSsL9eaKwxtdSaFacz0oY53WMj?=
 =?us-ascii?Q?p81QJ+QlQdjdpEQV3DA7POZ1o94wX3q4D17XXj5NP5Tsh3SoJA4Z/3WQ63pR?=
 =?us-ascii?Q?bXzvfF46N3reQCxs3iLZvP5c5jc6CugcnDxcCckRzq2kXXaGSVuI9qcdpl2B?=
 =?us-ascii?Q?5M5hyAV9QASmK7BRVNWuqrDzmrg1F5VSXMwQ0ZGLazNhlE1G1eHmu4VboLma?=
 =?us-ascii?Q?eSKZdkeIoHTt8N3K4lvVP5N72EV/k8nGrao/hYMOUZMmTKNaxdGzBTm4bMAF?=
 =?us-ascii?Q?I9sFZjJ0u+nCGgLDoLJMPDMTDiFtq93SUmKFP6Xysfw8F/rYXW+VW/+TkwZ/?=
 =?us-ascii?Q?gnZOBmPrQmnXYoZa10WhWaLeo7Xit81koGVwPfuSdZMVVtJ6OSW1W70lWaEL?=
 =?us-ascii?Q?8Y1QD+y5wy9P3Pn+GJ3Z2sYDWKE2cSDMOUW4vSSUYoCEBF6sdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:31.8255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75685492-8ce9-4b90-6e28-08dcbc47ef0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

The present sbrmi module only support reporting power via hwmon.
However, AMD data center range of processors support various
system management functionality using custom protocols defined in
Advanced Platform Management Link (APML) specification.

Register a miscdevice, which creates a device /dev/sbrmiX with an IOCTL
interface for the user space to invoke the APML Mailbox protocol, which
is already defined in sbrmi_mailbox_xfer().

The APML protocols depend on a set of RMI registers. Having an IOCTL
as a single entry point will help in providing synchronization among
these protocols as multiple transactions on RMI register set may
create race condition.
Support for other protocols will be added in subsequent patches.

Open-sourced and widely used https://github.com/amd/esmi_oob_library
will continue to provide user-space programmable API.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- Previously patch 5
- Add IOCTL description in ioctl-number.rst
- Split patch as per suggestion.

 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 drivers/misc/amd-sbi/rmi-core.c               | 89 +++++++++++++++++--
 drivers/misc/amd-sbi/rmi-core.h               | 16 ++--
 drivers/misc/amd-sbi/rmi-hwmon.c              | 15 ++--
 drivers/misc/amd-sbi/rmi-i2c.c                | 25 +++++-
 include/uapi/misc/amd-apml.h                  | 47 ++++++++++
 6 files changed, 166 insertions(+), 28 deletions(-)
 create mode 100644 include/uapi/misc/amd-apml.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e91c0376ee59..9fdcbe526127 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -388,6 +388,8 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:mathieu.desnoyers@efficios.com>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
                                                                      <mailto:nchatrad@amd.com>
+0xF9  00-1F  uapi/misc/amd-apml.h		                     AMD side band system management interface driver
+                                                                     <mailto:naveenkrishna.chatradhi@amd.com>
 0xFD  all    linux/dm-ioctl.h
 0xFE  all    linux/isst_if.h
 ====  =====  ======================================================= ================================================================
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 5a0b7912cc4e..2a59a3501f34 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -7,7 +7,10 @@
  */
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include "rmi-core.h"
@@ -22,7 +25,7 @@
 #define TRIGGER_MAILBOX	0x01
 
 int rmi_mailbox_xfer(struct sbrmi_data *data,
-		     struct sbrmi_mailbox_msg *msg)
+		     struct apml_message *msg)
 {
 	unsigned int bytes;
 	int i, ret, retry = 10;
@@ -46,8 +49,8 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * Command Data In[31:0] to SBRMI::InBndMsg_inst[4:1]
 	 * SBRMI_x3C(MSB):SBRMI_x39(LSB)
 	 */
-	for (i = 0; i < 4; i++) {
-		byte = (msg->data_in >> i * 8) & 0xff;
+	for (i = 0; i < AMD_SBI_MB_DATA_SIZE; i++) {
+		byte = msg->data_in.reg_in[i];
 		ret = regmap_write(data->regmap, SBRMI_INBNDMSG1 + i, byte);
 		if (ret < 0)
 			goto exit_unlock;
@@ -87,13 +90,13 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
 	 * {SBRMI_x34(MSB):SBRMI_x31(LSB)}.
 	 */
-	if (msg->read) {
-		for (i = 0; i < 4; i++) {
+	if (msg->data_in.reg_in[AMD_SBI_RD_FLAG_INDEX]) {
+		for (i = 0; i < AMD_SBI_MB_DATA_SIZE; i++) {
 			ret = regmap_read(data->regmap,
 					  SBRMI_OUTBNDMSG1 + i, &bytes);
 			if (ret < 0)
-				goto exit_unlock;
-			msg->data_out |= bytes << i * 8;
+				break;
+			msg->data_out.reg_out[i] = bytes;
 		}
 	}
 
@@ -103,8 +106,78 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 */
 	ret = regmap_write(data->regmap, SBRMI_STATUS,
 			   sw_status | SW_ALERT_MASK);
-
 exit_unlock:
 	mutex_unlock(&data->lock);
 	return ret;
 }
+
+static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	int __user *arguser = (int  __user *)arg;
+	struct apml_message msg = { 0 };
+	bool read = false;
+	int ret = -EFAULT;
+
+	struct sbrmi_data *data = container_of(fp->private_data, struct sbrmi_data,
+					       sbrmi_misc_dev);
+	if (!data)
+		return -ENODEV;
+
+	/* Copy the structure from user */
+	if (copy_struct_from_user(&msg, sizeof(msg), arguser,
+				  sizeof(struct apml_message)))
+		return ret;
+
+	/* Is this a read/monitor/get request */
+	if (msg.data_in.reg_in[AMD_SBI_RD_FLAG_INDEX])
+		read = true;
+
+	switch (msg.cmd) {
+	case 0 ... 0x999:
+		/* Mailbox protocol */
+		ret = rmi_mailbox_xfer(data, &msg);
+		break;
+	default:
+		pr_err("Command:0x%x not recognized\n", msg.cmd);
+		break;
+	}
+
+	/* Copy results back to user only for get/monitor commands and firmware failures */
+	if ((read && !ret) || ret == -EPROTOTYPE) {
+		if (copy_to_user(arguser, &msg, sizeof(struct apml_message)))
+			ret = -EFAULT;
+	}
+	return ret;
+}
+
+static const struct file_operations sbrmi_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= sbrmi_ioctl,
+	.compat_ioctl	= sbrmi_ioctl,
+};
+
+int create_misc_rmi_device(struct sbrmi_data *data,
+			   struct device *dev)
+{
+	int ret;
+
+	data->sbrmi_misc_dev.name	= devm_kasprintf(dev,
+							 GFP_KERNEL,
+							 "sbrmi-%x",
+							 data->dev_static_addr);
+	data->sbrmi_misc_dev.minor	= MISC_DYNAMIC_MINOR;
+	data->sbrmi_misc_dev.fops	= &sbrmi_fops;
+	data->sbrmi_misc_dev.parent	= dev;
+	data->sbrmi_misc_dev.nodename	= devm_kasprintf(dev,
+							 GFP_KERNEL,
+							 "sbrmi-%x",
+							 data->dev_static_addr);
+	data->sbrmi_misc_dev.mode	= 0600;
+
+	ret = misc_register(&data->sbrmi_misc_dev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "register %s device\n", data->sbrmi_misc_dev.name);
+	return ret;
+}
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
index 24a6957c8fa0..b728f5582256 100644
--- a/drivers/misc/amd-sbi/rmi-core.h
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -6,10 +6,12 @@
 #ifndef _SBRMI_CORE_H_
 #define _SBRMI_CORE_H_
 
+#include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <uapi/misc/amd-apml.h>
 
 /* SB-RMI registers */
 enum sbrmi_reg {
@@ -48,19 +50,15 @@ enum sbrmi_msg_id {
 
 /* Each client has this additional data */
 struct sbrmi_data {
+	struct miscdevice sbrmi_misc_dev;
 	struct regmap *regmap;
+	/* Mutex locking */
 	struct mutex lock;
-	struct platform_device *pdev;
 	u32 pwr_limit_max;
+	u8 dev_static_addr;
 };
 
-struct sbrmi_mailbox_msg {
-	u8 cmd;
-	bool read;
-	u32 data_in;
-	u32 data_out;
-};
-
-int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg);
+int rmi_mailbox_xfer(struct sbrmi_data *data, struct apml_message *msg);
 int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data);
+int create_misc_rmi_device(struct sbrmi_data *data, struct device *dev);
 #endif /*_SBRMI_CORE_H_*/
diff --git a/drivers/misc/amd-sbi/rmi-hwmon.c b/drivers/misc/amd-sbi/rmi-hwmon.c
index 36913f105eef..5f1634a17579 100644
--- a/drivers/misc/amd-sbi/rmi-hwmon.c
+++ b/drivers/misc/amd-sbi/rmi-hwmon.c
@@ -6,6 +6,7 @@
  */
 #include <linux/err.h>
 #include <linux/hwmon.h>
+#include <uapi/misc/amd-apml.h>
 #include "rmi-core.h"
 
 /* Do not allow setting negative power limit */
@@ -15,7 +16,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct apml_message msg = { 0 };
 	int ret;
 
 	if (!data)
@@ -24,7 +25,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 	if (type != hwmon_power)
 		return -EINVAL;
 
-	msg.read = true;
+	msg.data_in.reg_in[AMD_SBI_RD_FLAG_INDEX] = 1;
 	switch (attr) {
 	case hwmon_power_input:
 		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
@@ -35,7 +36,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		ret = rmi_mailbox_xfer(data, &msg);
 		break;
 	case hwmon_power_cap_max:
-		msg.data_out = data->pwr_limit_max;
+		msg.data_out.mb_out[AMD_SBI_RD_WR_DATA_INDEX] = data->pwr_limit_max;
 		ret = 0;
 		break;
 	default:
@@ -44,7 +45,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 	if (ret < 0)
 		return ret;
 	/* hwmon power attributes are in microWatt */
-	*val = (long)msg.data_out * 1000;
+	*val = (long)msg.data_out.mb_out[AMD_SBI_RD_WR_DATA_INDEX] * 1000;
 	return ret;
 }
 
@@ -52,7 +53,7 @@ static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long val)
 {
 	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct apml_message msg = { 0 };
 
 	if (!data)
 		return -ENODEV;
@@ -68,8 +69,8 @@ static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
 	val = clamp_val(val, SBRMI_PWR_MIN, data->pwr_limit_max);
 
 	msg.cmd = SBRMI_WRITE_PKG_PWR_LIMIT;
-	msg.data_in = val;
-	msg.read = false;
+	msg.data_in.mb_in[AMD_SBI_RD_WR_DATA_INDEX] = val;
+	msg.data_in.reg_in[AMD_SBI_RD_FLAG_INDEX] = 0;
 
 	return rmi_mailbox_xfer(data, &msg);
 }
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index c4207672d1e4..0e80acc61d6e 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -40,15 +40,15 @@ static int sbrmi_enable_alert(struct sbrmi_data *data)
 
 static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 {
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct apml_message msg = { 0 };
 	int ret;
 
 	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
-	msg.read = true;
+	msg.data_in.reg_in[AMD_SBI_RD_FLAG_INDEX] = 1;
 	ret = rmi_mailbox_xfer(data, &msg);
 	if (ret < 0)
 		return ret;
-	data->pwr_limit_max = msg.data_out;
+	data->pwr_limit_max = msg.data_out.mb_out[AMD_SBI_RD_WR_DATA_INDEX];
 
 	return ret;
 }
@@ -83,8 +83,24 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	data->dev_static_addr = client->addr;
 	dev_set_drvdata(dev, data);
-	return create_hwmon_sensor_device(dev, data);
+	ret = create_hwmon_sensor_device(dev, data);
+	if (ret < 0)
+		return ret;
+	return create_misc_rmi_device(data, dev);
+}
+
+static void sbrmi_i2c_remove(struct i2c_client *client)
+{
+	struct sbrmi_data *data = dev_get_drvdata(&client->dev);
+
+	misc_deregister(&data->sbrmi_misc_dev);
+	/* Assign fops and parent of misc dev to NULL */
+	data->sbrmi_misc_dev.fops = NULL;
+	data->sbrmi_misc_dev.parent = NULL;
+	dev_info(&client->dev, "Removed sbrmi-i2c driver\n");
+	return;
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
@@ -107,6 +123,7 @@ static struct i2c_driver sbrmi_driver = {
 		.of_match_table = of_match_ptr(sbrmi_of_match),
 	},
 	.probe = sbrmi_i2c_probe,
+	.remove = sbrmi_i2c_remove,
 	.id_table = sbrmi_id,
 };
 
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
new file mode 100644
index 000000000000..ae597942e172
--- /dev/null
+++ b/include/uapi/misc/amd-apml.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
+ */
+#ifndef _AMD_APML_H_
+#define _AMD_APML_H_
+
+#include <linux/types.h>
+
+/* These are byte indexes into data_in and data_out arrays */
+#define AMD_SBI_RD_WR_DATA_INDEX	0
+#define AMD_SBI_REG_OFF_INDEX		0
+#define AMD_SBI_REG_VAL_INDEX		4
+#define AMD_SBI_RD_FLAG_INDEX		7
+
+#define AMD_SBI_MB_DATA_SIZE		4
+
+struct apml_message {
+	/* message ids:
+	 * Mailbox Messages:	0x0 ... 0x999
+	 */
+	__u32 cmd;
+
+	/*
+	 * 8 bit data for reg read,
+	 * 32 bit data in case of mailbox,
+	 */
+	union {
+		__u32 mb_out[2];
+		__u8 reg_out[8];
+	} data_out;
+
+	/*
+	 * [0]...[3] mailbox 32bit input
+	 * [7] read/write functionality
+	 */
+	union {
+		__u32 mb_in[2];
+		__u8 reg_in[8];
+	} data_in;
+} __attribute__((packed));
+
+/* ioctl command for mailbox msgs using generic _IOWR */
+#define SB_BASE_IOCTL_NR	0xF9
+#define SBRMI_IOCTL_CMD		_IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)
+
+#endif /*_AMD_APML_H_*/
-- 
2.44.0


