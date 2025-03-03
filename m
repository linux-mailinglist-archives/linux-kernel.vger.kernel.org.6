Return-Path: <linux-kernel+bounces-541480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966CA4BD6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AB63BDA90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBA1F7076;
	Mon,  3 Mar 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVmDJMQU"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1301F63C3;
	Mon,  3 Mar 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999618; cv=fail; b=VJgbtnhYEEDndBEsca9/CFXmFPw5XaqaJWUV+waXc4LeJTk3KKTOjXmaBBOjurY8CZNXZaeAKJxwpUIshJpUpDGvzNgng5+cQJ2VFOeJHazLvzbSS2kO7xdGxz/aitLDiUHqpLgY2/lKLrqKAKvI69eUNwhSuRWN5TXUKfTv9mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999618; c=relaxed/simple;
	bh=QwFjzdIGLHuIEjCKotTW/idS8H+wha8bKV+IXQ2lSPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFpZQpOl0fcbkUyEYNb05iBh/BldnZfxwjzm0znkTCtTlM5UEffRUPx6fZ4SUXLbd2m0ERmxpdG2zFbRylo+/S9Ew+XkQp0N6ElPDyMRNgtmhTA9FJX5+FP+7zBzEWa9UE0QowznaGRanIG2HfBwtw8h7rXVwIrd+MglRNVx8gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVmDJMQU; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLJTZysGuTGqG/o/i4CBc3uCibGA9y4cZ3JUw3/+7Sazv4T00m0Q2RgTV3usdqkLQZscrpwNUNOZdcoq6/l2UdJF9cHltcs02z57m723Ru6jE/6NS8loCAfNOuzEw10Sy855XW8EelMAXCB2sqqfgQPC5/5yZ1yZ9j5Hx9HsVzuN0RXH3gNCcu2sHPcUuSwyQO2GAXNhd3sQJiZ26vIt5n8mta5rW+/wVl81Bo1R5iTB6Ir07ThNohoFIbpqGjVLGb5/0gks+M0XKla5nUVtH+LB49aMbiExVYFjP+oF79DhrRy9tK45fduEB8D2ba8TRi0omlj+cookTrSIJNTJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehs4H6t56Ucd9PHTttShbnw51gMTfpuRJh+cUERi9lU=;
 b=h7F4/1z1Kc9EHfpnZx/iW0kXNk0h3t04V0Uom6ll3e1FXVLpq9cXZWGuC2jv9oCE2SwHXxj6frnYAiPJEqkbc98/1YQ/NKHdvkYow7zQmjqjBWlPXfdWWjTlgmZCUf48aphWwj+15xUDpDPoFeWeYWhhQtOXe6W1ye5cKg+6gEkg91wnDTmxQD/qVbzDvDF2yzg3IeacIa8Bb2ydq8BXYU7bM3t2V95DJ8FdaEknMnDNeTqx3/973cZEvtNnFg06c8//hXGXx0VkVRj+aWQonqY6SCu/fX44cu4XNtcN5zyQKbL8xD7wuLwQ+o/irh24axoG8AazItZQF+nOKFEDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehs4H6t56Ucd9PHTttShbnw51gMTfpuRJh+cUERi9lU=;
 b=oVmDJMQUoFirC/qZZssPprkkst/3lghVWHD2TcQHiNcbXdQWkYFBrbte/6SIp5P5exhGbRQ+pgWErTBcaSIDporOctn0Mvtv5WqmXDquvZ4A1sCVu/++W9MBbWvH9kjDhxEfE6d/9l5Xe7xEPuQty8sdsqgXQWEkaValRo5TQp4=
Received: from SA1PR05CA0007.namprd05.prod.outlook.com (2603:10b6:806:2d2::9)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Mon, 3 Mar
 2025 11:00:11 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::61) by SA1PR05CA0007.outlook.office365.com
 (2603:10b6:806:2d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.12 via Frontend Transport; Mon,
 3 Mar 2025 11:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 11:00:10 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 05:00:04 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 11/11] misc: amd-sbi: Add document for AMD SB IOCTL description
Date: Mon, 3 Mar 2025 10:59:02 +0000
Message-ID: <20250303105902.215009-12-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf55eb2-6151-4628-fcca-08dd5a4290e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiexCFTykxeKXVUFAGlQiZPa3/fLCXW6Yr7Kf4ITz6t5c5ajGw439iSKSkwm?=
 =?us-ascii?Q?feIce3F62I/VN/4oSWnqcsaUJ9mhO12KPJqRbIei0w8dNXGmGCKlEEaBmVq7?=
 =?us-ascii?Q?QPMpW77pNnr3Op9x/envHHNQIHH+ou26+3d+hPmxSrIO02dmDjZspIKWoVjD?=
 =?us-ascii?Q?scqd9WtXM0wAGV6PtsVGnRMo4kDC+r+Y0dD3QlUFIpeDRLrCb/bsZ+SbGVAH?=
 =?us-ascii?Q?mddtaK8AlRLTMCW10V3r4CPfVHLgSA8UgWD98QFnPAu5C03l0y1qiW4QLEtA?=
 =?us-ascii?Q?kP3QvpAz1RApMQ2SWVvFWl5XfuSpHwIaI2xLcIiwnZPnmaWojMzmJPyta68Q?=
 =?us-ascii?Q?Iyccm9swSLtgYmgv3mE46JgB/0pPFonutUD40Y1KurMPmjm/X5bariKhs5ru?=
 =?us-ascii?Q?S+C4Z8VcZMDuiKSN1qJ3518GqdUzyZ+dW8zhlsTiMcJnSygFmFUhaMqzzzu6?=
 =?us-ascii?Q?Es+l8so3rptPkG8/y6C84HPsM/d/Mg/5LXZcNb0SboOwyGvWRlHnkOwWzHVz?=
 =?us-ascii?Q?lVjtcH59eCFWebhUPV2Sf2wKhrb0Ot8a8w5ENaMQhaHzat+eXF4m7Ag9M+yj?=
 =?us-ascii?Q?0By72Spnt3om4lXq9Q3gxrhO7olPSK4z+shQOZKvRD66ov7pgEOPONy6SP0l?=
 =?us-ascii?Q?2QwSaEkIo/Nxw7pW0PkGfbrjavjd47A9q+ViQsYN+zjae6PfNS1mg1JasDCL?=
 =?us-ascii?Q?7yM+/D7SqM5szH4FaMKZ77tma3LFeJjQ7J7GlDhdwiDv0SJ6EobvR/Ka4mfq?=
 =?us-ascii?Q?crq4+iVWOMF2eKKaYQDvpRghN+IVS1EfiKlvKdPCwdwaNuNNLd4vIlpyBo/o?=
 =?us-ascii?Q?bpEMcAPpauW+2D/1cOhjGKoKFhFcGpGiFeJf4ln4sdH1aiew4YArewXZKZqg?=
 =?us-ascii?Q?dkAWtUQPagbLkgs5Li/fKHnhtStIQ6F+r6HJZsW5s9F04e4d8h70nUchfH8F?=
 =?us-ascii?Q?ZQFT1NT0GbSHkCBHB7GOo1xVJdwV/jf9lmn4ToqioQR5AEUqUTNp4S0CrRVe?=
 =?us-ascii?Q?2Dmhn9y6nacxsFfAttc6s8Rlt3fnpfthwDmcucSAipsBu5O6OIucEpAfuSDI?=
 =?us-ascii?Q?BwFvPvoElcN6zF9lA2GGBrQy1gxqYdeyuRrqJt4qkPCkdtzeWj/RWkDTpGcW?=
 =?us-ascii?Q?A27thTdGCsnXQtIrmzb6Ndhq5GOcFBUDF+SYPwd46g6Hdb+Z2OspCFt9IZCR?=
 =?us-ascii?Q?rFcEvXTe88aMaieNI036FPkvZYGIuDGUmcRKqG+OTbgg2Yy7eD1NHmy1WS5h?=
 =?us-ascii?Q?J/xEvZqJr6kqZIXvAeDu9FdOKA91kce+u5KFqhWxgdZQZJbElSlTCmxsgxey?=
 =?us-ascii?Q?1jM2bPKCffgxzxtcoB+Z99F3B+3mem0er4d39qb4117yLrF7rJe7SmwUmhdR?=
 =?us-ascii?Q?m6ibVph6d7xjYClBkB0bkDycmAhIkvCVGuY0kE/eVyS3ox4lvJlPCCG6z7gp?=
 =?us-ascii?Q?D1hxmY1Ruwn0UknNpG/qpfXMtrEA5YuS95wa8y22rHbXOqHKRizoqYAfAnYu?=
 =?us-ascii?Q?aqNdXXtBQHv8Npg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:00:10.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf55eb2-6151-4628-fcca-08dd5a4290e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

- This document provides AMD side band IOCTL description defined
  for APML and its usage.
  Multiple AMD custom protocols defined for side band system
  management uses this IOCTL.
  User space C-APIs are made available by esmi_oob_library [1],
  which is provided by the E-SMS project [2].

Link: https://github.com/amd/esmi_oob_library [1]
Link: https://www.amd.com/en/developer/e-sms.html [2]

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
- Previously patch 9
- Update description as per review comment
- Address the review comments for documentation warning

Changes since v3:
- Address the review comments 

Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- New patch

 Documentation/misc-devices/amd-sbi.rst | 87 ++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/misc-devices/amd-sbi.rst

diff --git a/Documentation/misc-devices/amd-sbi.rst b/Documentation/misc-devices/amd-sbi.rst
new file mode 100644
index 000000000000..9fbb01b33032
--- /dev/null
+++ b/Documentation/misc-devices/amd-sbi.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+AMD SIDE BAND interface
+=======================
+
+Some AMD Zen based processors supports system management
+functionality via side-band interface (SBI) called
+Advanced Platform Management Link (APML). APML is an I2C/I3C
+based 2-wire processor target interface. APML is used to
+communicate with the Remote Management Interface
+(SB Remote Management Interface (SB-RMI)
+and SB Temperature Sensor Interface (SB-TSI)).
+
+More details on the interface can be found in chapter
+"5 Advanced Platform Management Link (APML)" of the family/model PPR [1]_.
+
+.. [1] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55898_B1_pub_0_50.zip
+
+
+SBRMI device
+============
+
+apml_sbrmi driver under the drivers/misc/amd-sbi creates miscdevice
+/dev/sbrmi-* to let user space programs run APML mailbox, CPUID,
+MCAMSR and register xfer commands.
+
+Register sets is common across APML protocols. IOCTL is providing synchronization
+among protocols as transactions may create race condition.
+
+$ ls -al /dev/sbrmi-3c
+crw-------    1 root     root       10,  53 Jul 10 11:13 /dev/sbrmi-3c
+
+apml_sbrmi driver registers hwmon sensors for monitoring power_cap_max,
+current power consumption and managing power_cap.
+
+Characteristics of the dev node:
+ * message ids are defined to run differnet xfer protocols:
+	* Mailbox:		0x0 ... 0x999
+	* CPUID:		0x1000
+	* MCA_MSR:		0x1001
+	* Register xfer:	0x1002
+
+Access restrictions:
+ * Only root user is allowed to open the file.
+ * APML Mailbox messages and Register xfer access are read-write,
+ * CPUID and MCA_MSR access is read-only.
+
+Driver IOCTLs
+=============
+
+.. c:macro:: SBRMI_IOCTL_CMD
+.. kernel-doc:: include/uapi/misc/amd-apml.h
+   :doc: SBRMI_IOCTL_CMD
+
+User-space usage
+================
+
+To access side band interface from a C program.
+First, user need to include the headers::
+
+  #include <uapi/misc/amd-apml.h>
+
+Which defines the supported IOCTL and data structure to be passed
+from the user space.
+
+Next thing, open the device file, as follows::
+
+  int file;
+
+  file = open("/dev/sbrmi-*", O_RDWR);
+  if (file < 0) {
+    /* ERROR HANDLING */
+    exit(1);
+  }
+
+The following IOCTL is defined:
+
+``#define SB_BASE_IOCTL_NR      0xF9``
+``#define SBRMI_IOCTL_CMD          _IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)``
+
+
+User space C-APIs are made available by esmi_oob_library, hosted at
+[2]_ which is provided by the E-SMS project [3]_.
+
+.. [2] https://github.com/amd/esmi_oob_library
+.. [3] https://www.amd.com/en/developer/e-sms.html
-- 
2.25.1


