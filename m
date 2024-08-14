Return-Path: <linux-kernel+bounces-286224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FF95183A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4747B280FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AA1AED57;
	Wed, 14 Aug 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q0mH9ipn"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D001AE87D;
	Wed, 14 Aug 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629655; cv=fail; b=uEf8r+XlL3Wo1XR1gppbuvkT3iyrd5XLCHx2H5ORVUC+4bxORdprDASRkU6ahJkEqI2TNReHkd0UM9bdZehqSUaBpPL6HdVJpqhJNMmXCfu5A3oTG5dSx4nhn6gCPfRW49U/TtFyV1C/FpMEFDaj4e+17WlO0GoF9VgtogByQ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629655; c=relaxed/simple;
	bh=MS8M7B2+m1GFrjqbrrquLrAusd6MXYIm+Ry6chG7qzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkT6B2zvmdnKgLPr3fQME3JyBRWhtlk0/0AjQ36LUFXDEquh/ZXY274MBgtO5GC1RhlZ2hKfdyo36b5MMOJ2yQbCpKCoGKJjNcszO8mKOxClxEqa9K3kpM8PO/Au1ajCBOoNUKbw145DzLlfv2/0/5ajXdN5gGCT6PNt4Ivs5Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q0mH9ipn; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3NtThfoFxnW4imCq1qURTGTowOYpaH6i+032BR+wYyOR+35XI/sZgxYh8u43kU8uSFwX5wnPKnwJwsmZggq/V0GZ3EL+MqceiRXErpVWJk7S/+8wRhQHXEZrCM2ydIHgDp4APKOXKTxn6gWmGQwcs2OCAsn1OEDDMZtLebmgr3qD0JxIhw/s2BOwjCVz3pDLvNz+C2wT9YUDkLsjGmrpbeRqk2OOXHm4FgSEENRp4QpJV7rMrUTT0cQ6AKMCiVSBco43XDZPJxyHEdyTkeLq7VoE8GFyhBJ73Vx4puSG2K/99Ig7Zb/wwMI7RYVeKxNwHFbOz5yoPDtJTtJvDbNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kkw9F3hATkuoWEh2QUUZi1MimZ/XSJbMlmTc4oxDik=;
 b=FI8Igsu/SFTN6y/aw750zumHzbwR5xH6W+RSaEnoFyOM/6laXI6ysMsAv/4aPcP7BwuRH1AEhBNSXKDmhaKg1Q35MiTi4jJVVdZwSoT2t0OHQ2ofaIr5/o6JqXliEMksYDq9NjvfqbF8o1BoeYlCR0M/cU0a4jTsieCLHtgKrXyvoFKMtlwpGwXfveYklghVoKmZ7XB7xS/3zLvSPa8chdHHH4x+Kfgd6jYHJe6TJZg9KRq6dd8yX9N9EMI1sFeLKk0TCNEJt7fZYCGNs+ekyv6G5aYCosR716nJSBhKDYSnBBis1EAbLROdxYeaJuGHwX5irEHmHUUSeEsAIhPDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Kkw9F3hATkuoWEh2QUUZi1MimZ/XSJbMlmTc4oxDik=;
 b=q0mH9ipnS9Pc/PY7orEDJTbWvpRG3rU0em4M4RseJa7IzHjzCin1QfqENtq6iW7tZ1w1T/FJHEElwb12lfj6IrsxF0FVV4RQVHNFVqsO4qJaKORml3RSpn78P0ui0vD2U9LAIMAeK98oFXdBhMscdH8yKk1jRWkavsH6ggD7qZg=
Received: from CH2PR18CA0041.namprd18.prod.outlook.com (2603:10b6:610:55::21)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:47 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::f1) by CH2PR18CA0041.outlook.office365.com
 (2603:10b6:610:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:46 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:44 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 8/8] misc: amd-sbi: Add document for AMD SB IOCTL description
Date: Wed, 14 Aug 2024 09:59:53 +0000
Message-ID: <20240814095954.2359863-9-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3f5cd2-16e8-4e3c-2c78-08dcbc47f7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	SvdYM19fW+tWK3/eThKHyGftIyobCjl2Bg0zYPZMU4d+HFUnnnH+yPXvdS/O1n7FcFppq4pTTBwkx/npCpX1YBiAUenxpjfFs2aK+Z9b211fq/x2eTtSUy3wxefvUHOPAvHJHVqwT6W4+qWY455TQSTSgD0QBemkv2tW897gZOoQOwl6ZgVKI2a+96xT75r7Uusv+Fe9wvMA3JoUmSdCZf+4dAnM+vrQx/YnjJVMRNyt00mOHjw0zUyg/oQOWaB2d8UlNTMPCIaEEr7NdbbCnWSx8WsmYrSGHS3nt1xZOb2QBaGy3ne+Wrjrz3CjpGRiONb5brkeUPSh6J1qrv353UkLXWmNFbhCNuTsZB0930H1SwixcUa/Nxq27tMi4z61Juw64O95xQ+/wwL0qxmENGhUS4KLlZIRDf+mCzebGZ0pEfGForvqWpKXDL0q+m4LuzwhRXrvUFBCFnN1JiyLwwF6ACRBVTKNc4W/evClYqmaNClCu2Iiae++T4DTqLwlqvWzQk+pEHGWBpizLZqqLcwxqftmwImNQz0yAsWz+CG26ZZqVnOexDUo8fmxK9EU2jAioSJ7IMw2JdWqDOBZC5qxn2nbdY9/rZU0BiNN7uzGVVjZoMWtfwi8g4oos8Bd2s6UPpWXg0yYoniHMZO3Crvd/vzfE59kSJxlKAFWzfjYz20wMfAuNuPZVD5r0YrkBkFgcp06eMRib0WogosEYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:46.7504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3f5cd2-16e8-4e3c-2c78-08dcbc47f7f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

- This document provide AMD side band IOCTL description defined
  for APML and its usage.
  Multiple AMD custom protocols defined for side band system
  management uses this IOCTL.
  User space C-APIs are made available by linking against the esmi_oob_library,
  which is provided by the E-SMS project https://www.amd.com/en/developer/e-sms.html.
  See: https://github.com/amd/esmi_oob_library

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- New patch

 Documentation/misc-devices/amd-sbi.rst | 121 +++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/misc-devices/amd-sbi.rst

diff --git a/Documentation/misc-devices/amd-sbi.rst b/Documentation/misc-devices/amd-sbi.rst
new file mode 100644
index 000000000000..ff90ad50a29c
--- /dev/null
+++ b/Documentation/misc-devices/amd-sbi.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+AMD SIDE BAND interface
+=======================
+
+AMD server line of processors supports system management
+functionality via side-band interface (SBI) called
+Advanced Platform Management Link (APML). APML is an I2C/I3C
+based 2-wire processor target interface. APML is used to
+communicate with the Remote Management Interface
+(SB Remote Management Interface (SB-RMI)
+and SB Temperature Sensor Interface (SB-TSI)).
+
+More details on the interface can be found in chapter
+"5 Advanced Platform Management Link (APML)" of the family/model PPR
+Eg: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55898_B1_pub_0_50.zip
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
+    /* ERROR HANDLING; you can check errno to see what went wrong */
+    exit(1);
+  }
+
+The following IOCTL is defined:
+
+``#define SB_BASE_IOCTL_NR      0xF9``
+``#define SBRMI_IOCTL_CMD          _IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)``
+
+Data structure::
+	struct apml_message {
+		/* message ids:
+		 * Mailbox Messages:	0x0 ... 0x999
+		 * APML_CPUID:		0x1000
+		 * APML_MCA_MSR:	0x1001
+		 * APML_REG:		0x1002
+		 */
+		__u32 cmd;
+		/*
+		 * 8 bit data for reg read,
+		 * 32 bit data in case of mailbox,
+		 * up to 64 bit in case of cpuid and mca msr
+		 */
+		union {
+			__u64 cpu_msr_out;
+			__u32 mb_out[2];
+			__u8 reg_out[8];
+		} data_out;
+		/*
+		 * [0]...[3] mailbox 32bit input
+		 *	     cpuid & mca msr,
+		 *	     rmi rd/wr: reg_offset
+		 * [4][5] cpuid & mca msr: thread
+		 * [4] rmi reg wr: value
+		 * [6] cpuid: ext function & read eax/ebx or ecx/edx
+		 *	[7:0] -> bits [7:4] -> ext function &
+		 *	bit [0] read eax/ebx or ecx/edx
+		 * [7] read/write functionality
+		 */
+		union {
+			__u64 cpu_msr_in;
+			__u32 mb_in[2];
+			__u8 reg_in[8];
+		} data_in;
+		/*
+		 * Status code is returned in case of CPUID/MCA access
+		 * Error code is returned in case of soft mailbox
+		 */
+		__u32 fw_ret_code;
+	} __attribute__((packed));
+
+The ioctl would return a non-zero on failure; user can read errno to see
+what happened. The transaction returns 0 on success.
+
+User space C-APIs are made available by linking against the esmi_oob_library,
+which is provided by the E-SMS project https://www.amd.com/en/developer/e-sms.html.
+Link: https://github.com/amd/esmi_oob_library
-- 
2.44.0


