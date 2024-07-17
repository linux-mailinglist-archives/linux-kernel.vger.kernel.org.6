Return-Path: <linux-kernel+bounces-254866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C09338AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744FC1C227DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457AA376F5;
	Wed, 17 Jul 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dTNfFUPM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAA3A8D8;
	Wed, 17 Jul 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203865; cv=fail; b=MAI1UGQyjS6RHrtpv7Gekj5Kn1psb6GYQP9RylbQYvS9Pn8jNuPhM4oKIMh8UZaDz4mY3PhTs/Iy2w5/kxM9zBSgw4ApPN9nVr4w70zYDgfevt5BHBDBqXkYEGXvfzKTLKoChYz7gy9AFgjjrIZM1kbRQNKQr54/jyrw08SaYLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203865; c=relaxed/simple;
	bh=j8/ad0R+XnipNczE2//66OlwyKdWdtZ0QEaPsRzGUqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utX7KXN5sq9rKF7TDqex7KawJFM0IgQ78WMeLLIPYxyRin/N5zBvQzxltmp2uohwPVIMlHUSNUfuWcD0I2JqFT1aj+g5EZRozWiYWE+l+pQwNehJ1ONu+eGU5BYvN07xqecggm31oZkLj52QUvl1inmmKoduXyT9Zn8VHbxCfw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dTNfFUPM; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKsTn7djkvZucyhoxY+zKZh/O/LQVd1kwxyP1tl5OUZVCcZz+GsUR4bhsyCqFPzlZH757AsIDkQnGxakApqiKCeYk9lacKZIlF55rJfhkZqqajS+IoD5Sw9Vd3ZK8GnUD5ntlq2JFYx/NZep40MWecO9YzQU7bXmBLluf06S9ogtogasOc+etzfU/ItVYnCIbp0J14o4Hxlo46PpKPzFcSa9SmLQBLupYOJCzkcUP27NiBcplUpoeBriBUOrX7JixL/Rcj/01kdNPD7JTdTEZnEJHS6CWP4zPoudHRbaVp/IRGNUPDn2C4kTGhGxEBuW/Sbco7J4MyMvC/PCISRKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4sxeW7Y/O7kYe2/hsSIwgsd8XR4Gju8XqQ30vh5rbg=;
 b=r2fLqZnLviCeu/vgC+cqh7mobIemn4LwYB7wX0gna1jlDi8Al/R6qRUImJrxnTwUpjU7I0CB0KnlxxQQmPTG/FZNBR7TbU3AQFWal3C74Gn/GQ7yAwwES18NYs6307y4MlGRUlVwB+ZzcAVtT2tu9+axlUqGvHfzi0MB5LpDYMvyMZS0/doFQTyhhAj0WR+p9pSJfztYyraQnRto0JWOogG8Mgv+nmEvM94jpBj6yyIQAhvLCadlCXcoDSjC5mUVHVko2UEtN0As2r+rtp0JAjuQaEsWc+GFWwdNqP+Ik3Xtq6nkLgBFEK8F0qNqczPAZ11v7zgNx7XC3rPi5dXi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4sxeW7Y/O7kYe2/hsSIwgsd8XR4Gju8XqQ30vh5rbg=;
 b=dTNfFUPMa2zEjhOJwqEA0vqJW38IjGab5lSZ+W4EQp6ltj0S3z8x/Dt6wVSvdk45ISlvcMf0QVGRZLnNcGrcQuSnPfV6vaV9kg38MR8lP5VoYzyD64r5wpOrw6YkQUDHArdyh09BIpg2VnHVS8ThYO05b5HzdrHpQ1D+ljMYdg0=
Received: from CH0PR03CA0308.namprd03.prod.outlook.com (2603:10b6:610:118::10)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 08:10:59 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::fa) by CH0PR03CA0308.outlook.office365.com
 (2603:10b6:610:118::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 08:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:10:59 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:10:56 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 3/8] misc: amd-sbi: Add support for AMD_SBI IOCTL
Date: Wed, 17 Jul 2024 08:10:22 +0000
Message-ID: <20240717081027.2079549-4-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240717081027.2079549-1-akshay.gupta@amd.com>
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: a413b20b-e8ec-46b8-5b3b-08dca637fdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JNvAFn6d6IcErtUog1bbvaA5A3b7evsvcKc+5t69IaYkIb6/9LjtiasD5Vke?=
 =?us-ascii?Q?CqRoG+fg7oM/E5wOZVAP/TSnbtUbkMeztSUGdAUQ14TcyOx53z8lB5ctbcjQ?=
 =?us-ascii?Q?g5dbW0Few1bUAj5GUDZHsI++hiJfpJJu+aX9gN5bWRh0HBK96bg6jXMAhYFZ?=
 =?us-ascii?Q?18OC3Fbmb8+7OsSwt/MqHIIxXjRmd8FyiDk3606+eclHxBCas1nfuCZITAXg?=
 =?us-ascii?Q?YLLi273G2uqCc66KZIiA9SE6OUd+C2f8/CSbftHLnuwk7VbkurMhotX2iAxz?=
 =?us-ascii?Q?SlsI8s8D73edhmHDjMcYCcFL0QSqlDxNfHTwqL3M3xG/luNfDBVeVvsEikOl?=
 =?us-ascii?Q?MbwP8Cgz965EdJae7vESkjFltR9Xc6p4Lw8LDU5GHRNLOUrCp+m+bcBIrjJl?=
 =?us-ascii?Q?PaHyIdZzUjGgRBYenXw+KZLM7pugzTfIdmTrW4nwzG8AWst5wjRPOyFxVL0T?=
 =?us-ascii?Q?g2rYNpXXsahvNKmjob63eY2laZhONA47lJhz8iL/OZkO4QxX5xIuEFpCkY6b?=
 =?us-ascii?Q?sHnH3eqQA/3oToG1Qxhp8Q4baGMWTyVacbjAX4VPqFvnjKosgcnpoBIsv4RI?=
 =?us-ascii?Q?O0e+5OLNGnKdhg09f1qB7TDOYNqyms9uffKAcORYaxLa9av5nNDuCBQIdnti?=
 =?us-ascii?Q?v9EqzL4/W+zBW06Sg2pnSymid+loX3gd2FP1vmj4xyPg04jSsoLDGINTGioJ?=
 =?us-ascii?Q?e5KQuqh70O6Jh9MSGeR6fkzsojBr12w4KPpeHPJnkASn5Q9AjSDP+lpqZ/CD?=
 =?us-ascii?Q?EHb65ImSqJ26hapgLo5X7fn6bEAKTHMMTtF2uuAjhftXruTmOMsvNAkZ077k?=
 =?us-ascii?Q?GVys9FlwBrq8ex6ozMrtcUcmwPbyMIwXPuwhprepoQmBGobcd0DsF8p1K9y+?=
 =?us-ascii?Q?gCKw8EuFrIpPw1FVQ2B5pSSHNFgipmreCBH7tTrZmcIYq8BylAP5n7StT+TT?=
 =?us-ascii?Q?EJIBmHbJZiKPYzZfLuhwUfNLaFYfC+4M/BVNcHn5SSOikfGoaUkTRKVBA80J?=
 =?us-ascii?Q?bIl1GDuSdUkhowgfVJ8w08StlSOk4ExgnfmaGspQ9yUiJWcXOBJUGbi0wyqX?=
 =?us-ascii?Q?At0YUUnmXSnN2uplxm2Jlk8PnUjf69xR8hh6G37Ma+Hh9EMtdbp5zXPpTRjb?=
 =?us-ascii?Q?+pPdw8YRaaz54cbyhRlAnO3TJv1PUwwk1wkN3sZfSwKKBOBvOVzcOuga4LIX?=
 =?us-ascii?Q?lOnyiAxkXfVhQMo/1zlpJlHquu5r/7xl+zufBrCtQEhx0vnI5ewocZ+8p/Xt?=
 =?us-ascii?Q?UJEphWEWyllTNOwI8F4AtDVx8DE39v9jmttV7+PbexAJ+eZjOoALqaUp0Ul/?=
 =?us-ascii?Q?hcLACy/DSaWuYqFp8LThWGaJZjP9B7eBH1gI0HTBduin5EHsFvC2VLzbbHt3?=
 =?us-ascii?Q?Ss0d+j9sRtJTSHMC4qoN/xN0lzzAp5G9rGeED5NdfEhnmQgPPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:10:59.2367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a413b20b-e8ec-46b8-5b3b-08dca637fdec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

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
index 9a97030c6c8d..2665993148dd 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -385,6 +385,8 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:mathieu.desnoyers@efficios.com>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
                                                                      <mailto:nchatrad@amd.com>
+0xF9  00-1F  uapi/misc/amd-apml.h		                     AMD side band system management interface driver
+                                                                     <mailto:naveenkrishna.chatradhi@amd.com>
 0xFD  all    linux/dm-ioctl.h
 0xFE  all    linux/isst_if.h
 ====  =====  ======================================================= ================================================================
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 5a0b7912cc4e..e7778749940e 100644
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
+	for (i = 0; i < MB_DATA_SIZE; i++) {
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
+	if (msg->data_in.reg_in[RD_FLAG_INDEX]) {
+		for (i = 0; i < MB_DATA_SIZE; i++) {
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
+	if (msg.data_in.reg_in[RD_FLAG_INDEX])
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
index 36913f105eef..dda9d9220b58 100644
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
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 1;
 	switch (attr) {
 	case hwmon_power_input:
 		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
@@ -35,7 +36,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		ret = rmi_mailbox_xfer(data, &msg);
 		break;
 	case hwmon_power_cap_max:
-		msg.data_out = data->pwr_limit_max;
+		msg.data_out.mb_out[RD_WR_DATA_INDEX] = data->pwr_limit_max;
 		ret = 0;
 		break;
 	default:
@@ -44,7 +45,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 	if (ret < 0)
 		return ret;
 	/* hwmon power attributes are in microWatt */
-	*val = (long)msg.data_out * 1000;
+	*val = (long)msg.data_out.mb_out[RD_WR_DATA_INDEX] * 1000;
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
+	msg.data_in.mb_in[RD_WR_DATA_INDEX] = val;
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 0;
 
 	return rmi_mailbox_xfer(data, &msg);
 }
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index c4207672d1e4..e244e101f173 100644
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
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 1;
 	ret = rmi_mailbox_xfer(data, &msg);
 	if (ret < 0)
 		return ret;
-	data->pwr_limit_max = msg.data_out;
+	data->pwr_limit_max = msg.data_out.mb_out[RD_WR_DATA_INDEX];
 
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
index 000000000000..81e505eccac4
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
+#define RD_WR_DATA_INDEX	0
+#define REG_OFF_INDEX		0
+#define REG_VAL_INDEX		4
+#define RD_FLAG_INDEX		7
+
+#define MB_DATA_SIZE		4
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
+#define AMD_SBI_BASE_IOCTL_NR	0xF9
+#define SBRMI_IOCTL_CMD		_IOWR(AMD_SBI_BASE_IOCTL_NR, 0, struct apml_message)
+
+#endif /*_AMD_APML_H_*/
-- 
2.44.0


