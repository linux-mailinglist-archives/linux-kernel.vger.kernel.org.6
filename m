Return-Path: <linux-kernel+bounces-541475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40DA4BD5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB3F3BC3F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E71F4E4F;
	Mon,  3 Mar 2025 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tlpywUyC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6F1F473A;
	Mon,  3 Mar 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999596; cv=fail; b=UnbZUMS7k+LDd3ILy+fiJLGV67ro/OM1+T7q5RDY3UWyky7A/laSFwJauYuQ9F+t94QG+uJYJeZa9IgUrTxKURMAyB/n0rGhGp/taFmzXgDRDQULvHK1ioHAN+6Q/KtIB5WtKKuOpq1Hk6n5CkZ1a+dsQUa9NvbCHV2nLGb8JrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999596; c=relaxed/simple;
	bh=ZEb8aioKH5rpgZaWvCEtVTwH+74krNXWMEBNVrnuPAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjFraHiM/oeM986wgpl0axds99KTiqDCqJgovGidOVDGB+TAYUl8zUfSInEDNYRwDIYcavRPtpzRo7G56Zq113h1GZLLZBJfi0YWplQTRYV3Wb7Lw61jzA3bU19YvpwiSkwR+yrJ2LXkIvNUvWZuy+qKW4m+4q2taD2g3VedqGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tlpywUyC; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s65E+n/iBK5SpI3r19bh91G/N/PB/xaX+9A1fg8oUss9BnOrNGvvAl6hsFlivTvKwWxns5qhanWk5H93JrCVazd7r16SKK+Y72Hkjl0RT8cUFdMCquSqoLid2//KQ9rNTVeCOJ4Z9io/AKkXIJBuTUo1PoEwtcX0lrLu3YC75InB5ibjPgoxsjvPWJ9prkT8KJ9QMCLJyVwHuFVOqvkXEhYWUq9DAIFSG27lrJYKVC5KnbBCVmAUUEDpsBsDO++uZIfeMaWs5epwbHPIM8RNJklJn2BjMLdPjfSjJ3sw/6spY4a1YMukgoc+QxDw56W48Ydlw2iKZ1dZeGloN+T3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFpu8M+oPKWaeK7kDlvv5YCACza9rm706Ex/WzpHtxY=;
 b=DGhdF7nlom7ejHjQ8pF2eh6irMtsgnka5ODRxxTw3G6WniBRmin5aXQRwUZXU2KSftN/tomUnXKMdvYHzO3wm1YoJBZKxb/XNF9jUlKyw1KksfNb8fBh1gec8I3+6c+0LN2C/4PLglAE3RkX651wjFNUOUJ01dTmsz8Ynzm1Ag32SilZNjy7I1T3A0F9uGrKznK5eBbpYbU9ieO2BHG13M0vjTTTG4JZCKJVMLXmrdkTYQ8q6alFry00fHMAr6nbjJZAMn7o1yl4jNVPt7QpRwtHdRExKA8JC1JpSDo+IW83BOr7ZZWQwJB0Ai8QYi/CeePw5YnJk3ozzAGaujyriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFpu8M+oPKWaeK7kDlvv5YCACza9rm706Ex/WzpHtxY=;
 b=tlpywUyCX1yvSQAkVfEaYTcZ2h3zVbPzmxrpF8HnGNJ2oRWVEGL1PpHlqQjguxVp1LLwKvF8YCaseEqZ+P5WD2W9u10nvugOegK2A5a/VN428G0pPF5LpSK12HqAZKo6/kyOk4nkmVg5bA2UbuSu67iqWdv811QRmi1yIcMg9qs=
Received: from PH7P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::9)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:49 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::f4) by PH7P221CA0013.outlook.office365.com
 (2603:10b6:510:32a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Mon,
 3 Mar 2025 10:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:48 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:44 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
Date: Mon, 3 Mar 2025 10:58:57 +0000
Message-ID: <20250303105902.215009-7-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105902.215009-1-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b05823-5431-4b73-2c55-08dd5a4283c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wD4r8jGuGEOmX5y1KWs72dkGUTpT9UR52kOK4ZhImtYhqtzMcx7AtI/r+9nY?=
 =?us-ascii?Q?gpTKgycZYaN8/Bt/74jeNlfDtg5MN6RthgfjVtroLltGnPavYY9ycXxjVSXB?=
 =?us-ascii?Q?ssTR3/lV6Rf3jf61hPoDAPR2I4uORUpz+3bjxos0fuQ/H2oZbPJ+GUas2MGh?=
 =?us-ascii?Q?JrscJyplh21fVmwK0YrVqa9/9E3GjnNPR3cYomxlpCzwHCOVOiro25ZBn+Cw?=
 =?us-ascii?Q?z0G137VdSyIMAqE8ThF+hCX3S1rUJKi4V05jaQdYXitVaJ+c5eVO0MYenDzi?=
 =?us-ascii?Q?cGWksN7vSs+7m5S1mnhC681ri38nu+98etzWeMC66AtXKczBcumcCRNkJzwl?=
 =?us-ascii?Q?9r2SipHZKLSn51kFcRd1hQVZ2b0FY0rMb7aAswyxHoW+r9J54HJSdJmIgAOM?=
 =?us-ascii?Q?fGkY02+12jRHvC25peYOpsqYEABI8OPQVh4UTHKH+rj1xl/MwpEHu+E1nyjl?=
 =?us-ascii?Q?38mL1j/BtVzf/NUs4KmstJeMGtuq2tAvIa3l/SYPdfaDUPOqyo0hwnJpnT0T?=
 =?us-ascii?Q?kdVeO1aN10Y5Kws8+sX4vW/gKe7t07p2v3gD+PY7SLVaKb95nFvPhU1arF/F?=
 =?us-ascii?Q?yylHKddBb+hpCKAsqnfN2OAQ/5uKU6HxYgvayfkNYGLbDSAyyxNZCs7y5H2j?=
 =?us-ascii?Q?JXLzV5VrCxr6z3CLEezV7a/Zk5jvMzi5CVFMHTJFqEkNh27gJeBiiFZKZN3M?=
 =?us-ascii?Q?c3uujsJLQAgjCQN6GvOFuXsmT7VvhPXoyjpi7JCt+zl0x156am3IoztKHnfB?=
 =?us-ascii?Q?wpMdglx5KNcSHDMxY6IRWI/wpZ7isC4yFhdwtpZCCqGw0ZH0hJruVcVf+JpU?=
 =?us-ascii?Q?ARTO0vSynm+KUD0WrbIrswYraIGi5Ve9xs09jnBEDT0f827NLoiQKU3shfUB?=
 =?us-ascii?Q?ijti3WN9324sZG8xGfqt2nRLuBHdLu6+KW0psTgV4aG/RMKlNQsqKABrH+Li?=
 =?us-ascii?Q?aqE7ZhcZckGExZeiKbyucr1HnkAzJeGj/nin3wenZnYyzwxODmosTwat2wWA?=
 =?us-ascii?Q?V+ZQdsNEo/9dxOSdM/7/S122TwacAIx7axaxKULP87FpowrFJWQt14R7gg7P?=
 =?us-ascii?Q?gLoY5uJEug0jZOL4Fx6JbIHu8nnD7Y8kEr9suj0Q0rzkaA0QWdl2EMR7trZt?=
 =?us-ascii?Q?hfppRYMcrLo8+nQsZxSBqq1lcpZFXNNPJg8gayoJ8L4hy0qW8V7v9AJDaPtt?=
 =?us-ascii?Q?pgH9zvqOpNnoaBnFzNlayiG2LXhYwaP/u4eLTeN6jJHKidsA5yj/SrcBYGRn?=
 =?us-ascii?Q?zGHrwCm5domJtOh8CZKMkiqkftsOZo1z5dgQIHBDlsUYCjxcgLWkrzmW9257?=
 =?us-ascii?Q?4ykNuo95HanyZ7Lj0LQ4uTq8IJk6sT6PaL2JIxWyapm+yj6Hcp8pQWS/u8tS?=
 =?us-ascii?Q?pyOjhjFFfAcFZ44q7EDQecHR26VgTxsan5W7JvTeSMyzG+TE3AP1V8vJMdkY?=
 =?us-ascii?Q?LO0vmFn7a0MS+OGTDiiBTymbvrsElnw2ytswcUpojx2I4bvim2DUhpe8CWWZ?=
 =?us-ascii?Q?LQ1egzPnAE150dE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:48.0488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b05823-5431-4b73-2c55-08dd5a4283c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

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
 drivers/misc/amd-sbi/rmi-core.c               | 81 +++++++++++++++++--
 drivers/misc/amd-sbi/rmi-core.h               | 15 ++--
 drivers/misc/amd-sbi/rmi-hwmon.c              | 15 ++--
 drivers/misc/amd-sbi/rmi-i2c.c                | 25 +++++-
 include/uapi/misc/amd-apml.h                  | 66 +++++++++++++++
 7 files changed, 178 insertions(+), 27 deletions(-)
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
index 1d5e2556ab88..c39a29d90c27 100644
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
 
@@ -90,8 +93,70 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
+	int ret;
+
+	struct sbrmi_data *data = container_of(fp->private_data, struct sbrmi_data,
+					       sbrmi_misc_dev);
+	if (!data)
+		return -ENODEV;
+
+	/* Copy the structure from user */
+	if (copy_struct_from_user(&msg, sizeof(msg), arguser,
+				  sizeof(struct apml_message)))
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
index 720e800db1f0..ee0c3b72174c 100644
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
index 7a9801273a4c..919ff7f61225 100644
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
@@ -81,8 +81,24 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
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
@@ -105,6 +121,7 @@ static struct i2c_driver sbrmi_driver = {
 		.of_match_table = of_match_ptr(sbrmi_of_match),
 	},
 	.probe = sbrmi_i2c_probe,
+	.remove = sbrmi_i2c_remove,
 	.id_table = sbrmi_id,
 };
 
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
new file mode 100644
index 000000000000..5721aaa0c6bd
--- /dev/null
+++ b/include/uapi/misc/amd-apml.h
@@ -0,0 +1,66 @@
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


