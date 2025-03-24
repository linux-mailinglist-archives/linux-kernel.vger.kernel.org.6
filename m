Return-Path: <linux-kernel+bounces-573886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B6A6DDA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E31F170077
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18DA261561;
	Mon, 24 Mar 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ni+W8uFf"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8102620CF;
	Mon, 24 Mar 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828345; cv=fail; b=rdZfiX/bmI/dTUbPfZj+S5mAtulQSKPkf3/wfwv6PZ4jDrZnITPiynw2ynJSaek+14hGm5QKHrOEQrJWvRtu8fr/P3jFSXRpV1ztHb1pg8+K5ZVA2ZdvQ7PY8L87N/fiRG+fccZqbnBpy5G78EhrsYBpaN9/Ot+ZWqzBKPi6htk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828345; c=relaxed/simple;
	bh=mrDeMx3q6Wtw4E27WBCX9iq9eHINF5AN7hasJB1Iomc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX6TCNqFZFqgbaoNDlGJH/5q2AydOXmqWof3jOQG2GOYT/JIW3YRinF+kYE9axVW8aKPHmk7Gk+PKV5i7DOjnIgRPZunyKtOmcGV0RhMnGHhPhAz2wT1dNIfqYcFeeoVXnWGT4DFN1GNQyLGsvYF9ZoB7sbyMRyBBQB8Syzof8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ni+W8uFf; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+ERb8Dia41kWDg77XJMsnkxjmxkabb6YvzNhyQZirdGtEJ25Zvl6ys2aIqc4xyqy4sAj/SfnTMH9JooGG5wiqWQAEMh/ifJLRnChUTCDmGydRhCIgDOqTT5c7jhNIj+QhPcJSYN8V64C75Q8AwLeCjnwUquGQ+49O+x0fc2YxGhK2172SOk4q45wvpLIKDs1v8R4ajZohg+eCtZwbh052erQgCcr9hgXmBp5LSAX82wqieYEzSFSXF+eeSv0og52BvYt5YfME9pe7YOw9/LY17juDh/joAG+vzgdR3i5GFvkzVHsWk64tfQybbbBHaO0VR8aoe/R3MPo1C8D+IMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88UdcsZ9/SPtIDhTETpGt1YvOaHYfOWM2tepHMQO/X0=;
 b=gzNe4vkstXuGSRgFMgKk4Dq02avonM0yJq7yIhqg6infC12L/o93N3yRYU1n2GGnT79Uqfq9gQ3Xxmi787xz7f8LbNCSpu1LqiyUPCTbjhe00LqCalY798zP7B6ddKylbxpixl1sWhh1OhZ4h4Rh24FCgFCxM6IsmQoTx016pqFdeor2icWmlqH3fKh8Or83LzcloBNJ+dDI6Ki21IbwAPYqqM5HXVe3uwoNs72qyHbGoHBG3rEMTLEVkb3fXioqxBy0oqnkPDPLUU8ILxA0ZfDXj/4+6rYTnEnv4F3fbX5fPLBwkM0iYX7bBG98al2BCz6LRJ77HeELOAkufwXk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88UdcsZ9/SPtIDhTETpGt1YvOaHYfOWM2tepHMQO/X0=;
 b=ni+W8uFfegcuHlohyAfAS0HWwB1zhwfXC4ARAQ/ayzVsrPglQn6LmoTJ4CF37nI6IzF1kUvKLRNz40vdEElectXIdiL5nvX9mKNHZ1tqdtYOp0VeETBWF1vsRpsTghxgAJ9xTMJ7FbownXAuKgebVp8izGv07u0DCaBh9wU195U=
Received: from PH7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:510:339::34)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:58:59 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::b3) by PH7PR03CA0008.outlook.office365.com
 (2603:10b6:510:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:58 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:55 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
Date: Mon, 24 Mar 2025 14:58:10 +0000
Message-ID: <20250324145815.1026314-7-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324145815.1026314-1-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffdf19-c0ab-453c-d864-08dd6ae46846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/axbSPA1dQnkqfjCQpRBed7AdgBRKaeGcqjidrl4HsbYcgnNgIf/nYAgYfr?=
 =?us-ascii?Q?Mqn717vA1gwiyirr45Rw6g9p8htUsWEGD8Z4Kdt8N9OpEAb72UUh5U+29PCJ?=
 =?us-ascii?Q?1GxSMR9gDUKG+18+IEJ85Zc3/OTkPnFobKAkQpbSaON87beB7gN5lrkmaETk?=
 =?us-ascii?Q?s8bBx93WvQb+bN4dwsSrVlKFPTBrFYpIPNIsImvJFa3OuUEX3fsf2ogfVWII?=
 =?us-ascii?Q?UA5A9ofXk/wn0WJrL5XdwPRdfiBTXDyTUWYrW+jT7jwsECj/TLClfA3Fjxju?=
 =?us-ascii?Q?Q1k+nTCVsEjEKYbjwtchizbFojTQ7ADna2ZojwB7fDaxXA1awV+tGuqdff/z?=
 =?us-ascii?Q?X9vOWUWc/H8uZuiiOHFOfzXJh9kuGdZ+wcJ31YFVwRCly8RkCAhBMjDFTNEf?=
 =?us-ascii?Q?tIdsfuJzeHeRoZLlvkQ7heDscs55RZpMTW6ukGa3oADrsOhvPksVL9PXO4m8?=
 =?us-ascii?Q?FaxnHLQ++yEK+J52J8wQlrO/i/zTXpBkr6x6/IG2AV6NUeHQlSMgktPepIxy?=
 =?us-ascii?Q?2fqGvTmYP5Ila2BDODub13+AMhvX+1EL6Lj9s74GqjmdNqbmbUZCrQUlIejs?=
 =?us-ascii?Q?oPfIyoECMYvsghdQ9XhrdrPtGCi2GiOlEws4EMvtgZO/d2Gm7ZQbfKq5RDTW?=
 =?us-ascii?Q?mJVGmShGlA3kRfXleteqMJMfzPd3Y8E9wUUsZ1ml9GeWBOMu3UjBnwfsNvvT?=
 =?us-ascii?Q?b1DHfHPdgL6vvPO5OGw5Y5HwGbPDSJYghLAyX9LtJq1D/zWd6CLymJ7oMx9w?=
 =?us-ascii?Q?/2Mr1cChsIvvGnj6L9OPF0SPevnnVffTcnoMK9IaM4ATz3CN0zVeRiVmvDG+?=
 =?us-ascii?Q?dRjzCDCz2/sSYi9hJ5S2F13dga4ZzGExN4GKJ9PZKQOpeJwu86KG9yleHtJa?=
 =?us-ascii?Q?1z6zkq7IV88s02r5YrBY1p7zpaEUbXmtIsDT/b22TTZOA2ha8gPfwK0YdKTJ?=
 =?us-ascii?Q?qyqUbQx1AfWKVlEYXEsTB3tC85CJnihcoJOGNjStIkedY6GrCabsNoK7QgYI?=
 =?us-ascii?Q?oVCgP1a5vnp/YUzlDyZkMf+PQ+ZIOubtOQNiozhArUMh679dQv6Om4pnb9jk?=
 =?us-ascii?Q?L+Si1gR61Nk9Ck7BoTZwQYTiVrij2LSsnwjq48y+O5nevijgXfSJO6yrwvox?=
 =?us-ascii?Q?iE5s1h7+zqUS1MyxKawytP6DEZOzvoukOzyAOZ8safaiyDUS+uTHGKHx1YT0?=
 =?us-ascii?Q?xQd6rH/IH3+5Yg3EYzS66I251lhUK5HgoJ6M4TfInYSL4fYm2FP+oDiqupub?=
 =?us-ascii?Q?AgX0IXnRXcX+bNjxdHa2MH4wVvipng5LXB9afH2utD20XQH7ww5YunlVTgId?=
 =?us-ascii?Q?FAorajk5DL3hPKE4TmA7YO6wo5k9BUFQ7zz5YGfjDqvKQhEuPIjhnqmoSDX0?=
 =?us-ascii?Q?pXg+7FK7D03Lzpg9D78qvh6MQo7MyCqfWtuNTVVVmLyrJF/4tGyyXAmPIzNC?=
 =?us-ascii?Q?OeEPm8NK9BXwCnDWWDlCFiD+T8MHyrEtGm9I7J8jVJhQg8XU95/L2MeedHoU?=
 =?us-ascii?Q?ZLDy8umXQskkWtY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:58.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffdf19-c0ab-453c-d864-08dd6ae46846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

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

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Address review comment
 - Address Arnd comments
 - Add check for cmd in ioctl
 - Remove attribute packed from uapi header file structure apml_message{}
- Address kernel test robot warn:
 - warn: can 'data' even be NULL?

Changes since v4:
- Address review comment
 - Address Greg review comments
 - Not initialize ret
 - return on error
- Previously patch 4
- Fix documentation warning

Changes since v3:
- Previously patch 3
- Documentation and comments changes

Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- Previously patch 5
- Add IOCTL description in ioctl-number.rst
- Split patch as per suggestion.

 Documentation/misc-devices/index.rst          |  1 +
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 drivers/misc/amd-sbi/rmi-core.c               | 85 +++++++++++++++++--
 drivers/misc/amd-sbi/rmi-core.h               | 15 ++--
 drivers/misc/amd-sbi/rmi-hwmon.c              | 15 ++--
 drivers/misc/amd-sbi/rmi-i2c.c                | 26 +++++-
 include/uapi/misc/amd-apml.h                  | 64 ++++++++++++++
 7 files changed, 181 insertions(+), 27 deletions(-)
 create mode 100644 include/uapi/misc/amd-apml.h

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 8c5b226d8313..081e79415e38 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -12,6 +12,7 @@ fit into other categories.
    :maxdepth: 2
 
    ad525x_dpot
+   amd-sbi
    apds990x
    bh1770glc
    c2port
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 6d1465315df3..5692b50b3c6f 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -392,6 +392,8 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:mathieu.desnoyers@efficios.com>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
                                                                      <mailto:nchatrad@amd.com>
+0xF9  00-0F  uapi/misc/amd-apml.h		                     AMD side band system management interface driver
+                                                                     <mailto:naveenkrishna.chatradhi@amd.com>
 0xFD  all    linux/dm-ioctl.h
 0xFE  all    linux/isst_if.h
 ====  =====  ======================================================= ================================================================
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 1d5e2556ab88..eafdd2799034 100644
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
@@ -20,7 +23,7 @@
 #define TRIGGER_MAILBOX	0x01
 
 int rmi_mailbox_xfer(struct sbrmi_data *data,
-		     struct sbrmi_mailbox_msg *msg)
+		     struct apml_message *msg)
 {
 	unsigned int bytes;
 	int i, ret;
@@ -44,8 +47,8 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
@@ -74,13 +77,13 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
 
@@ -90,8 +93,74 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
+	struct apml_message msg = { 0 };
+	struct sbrmi_data *data;
+	bool read = false;
+	int ret;
+
+	if (cmd != SBRMI_IOCTL_CMD)
+		return -ENOTTY;
+
+	if (_IOC_SIZE(cmd) != sizeof(msg))
+		return -EINVAL;
+
+	data = container_of(fp->private_data, struct sbrmi_data, sbrmi_misc_dev);
+
+	/* Copy the structure from user */
+	if (copy_from_user(&msg, (struct apml_message __user *)arg,
+			   sizeof(struct apml_message)))
+		return -EFAULT;
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
+		return -EINVAL;
+	}
+
+	/* Copy results back to user only for get/monitor commands and firmware failures */
+	if ((read && !ret) || ret == -EPROTOTYPE) {
+		if (copy_to_user((struct apml_message __user *)arg, &msg,
+				 sizeof(struct apml_message)))
+			ret = -EFAULT;
+	}
+	return ret;
+}
+
+static const struct file_operations sbrmi_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= sbrmi_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
+int create_misc_rmi_device(struct sbrmi_data *data,
+			   struct device *dev)
+{
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
+	return misc_register(&data->sbrmi_misc_dev);
+}
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
index bbb6bb1cefde..e3a11575d19e 100644
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
@@ -48,18 +50,15 @@ enum sbrmi_msg_id {
 
 /* Each client has this additional data */
 struct sbrmi_data {
+	struct miscdevice sbrmi_misc_dev;
 	struct regmap *regmap;
+	/* Mutex locking */
 	struct mutex lock;
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
index 68217f2afb89..318bf4fed967 100644
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
index 7a9801273a4c..d9308b52eab9 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -38,15 +38,15 @@ static int sbrmi_enable_alert(struct sbrmi_data *data)
 
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
@@ -81,8 +81,25 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	data->dev_static_addr = client->addr;
 	dev_set_drvdata(dev, data);
-	return create_hwmon_sensor_device(dev, data);
+
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
@@ -105,6 +122,7 @@ static struct i2c_driver sbrmi_driver = {
 		.of_match_table = of_match_ptr(sbrmi_of_match),
 	},
 	.probe = sbrmi_i2c_probe,
+	.remove = sbrmi_i2c_remove,
 	.id_table = sbrmi_id,
 };
 
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
new file mode 100644
index 000000000000..451cab135a08
--- /dev/null
+++ b/include/uapi/misc/amd-apml.h
@@ -0,0 +1,64 @@
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
+	/*
+	 * [0]...[3] mailbox 32bit input
+	 * [7] read/write functionality
+	 */
+	union {
+		__u32 mb_in[2];
+		__u8 reg_in[8];
+	} data_in;
+	/*
+	 * 8 bit data for reg read,
+	 * 32 bit data in case of mailbox,
+	 */
+	union {
+		__u32 mb_out[2];
+		__u8 reg_out[8];
+	} data_out;
+	/* message ids:
+	 * Mailbox Messages:	0x0 ... 0x999
+	 */
+	__u32 cmd;
+};
+
+/*
+ * AMD sideband interface base IOCTL
+ */
+#define SB_BASE_IOCTL_NR	0xF9
+
+/**
+ * DOC: SBRMI_IOCTL_CMD
+ *
+ * @Parameters
+ *
+ * @struct apml_message
+ *	Pointer to the &struct apml_message that will contain the protocol
+ *	information
+ *
+ * @Description
+ * IOCTL command for APML messages using generic _IOWR
+ * The IOCTL provides userspace access to AMD sideband protocols
+ * The APML RMI module checks whether the cmd is
+ * - Mailbox message read/write(0x0~0x999)
+ * - returning "-EFAULT" if none of the above
+ */
+#define SBRMI_IOCTL_CMD		_IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)
+
+#endif /*_AMD_APML_H_*/
-- 
2.25.1


