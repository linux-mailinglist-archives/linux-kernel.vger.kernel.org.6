Return-Path: <linux-kernel+bounces-573891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C7A6DDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66841729C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1229261565;
	Mon, 24 Mar 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mz/3NARK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E406262807;
	Mon, 24 Mar 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828367; cv=fail; b=h0XC8lQ5evISETPVpafPJ/uuRh4D9b2EOTfy+/9W+4pSSNgx+uPvI4IitBmBCtztk5UDM7u/tUAgUrHBmva/jyArb6hHt2sc3YK5YxZmHyXijeSRpOhi4iMaNBPUumlm67MS0czJ3uhllsOhqK/UIjTqKM5ByAMburxsFBBCQcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828367; c=relaxed/simple;
	bh=tdqsto+jsTiRlWJVRAg2HTwLR8jcc4txcCdPd3SX2q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0wW9WGshI4H1L9VP1idkOo6rnXUKAqI1GTFNl0rPvArzhUEshZh1mO9daw4yV4JiJUPfu4/cXdzTKtQo3W8rJGlsGG2D8qobiXyEBzxI5P/CMdCniG+sWSFOf70Gm/MxuXAravT21fc7E28C1lcUZfECTx3FTPXeGd71Kj3Bzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mz/3NARK; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWnZRj9/EtiDdWGj21TpYc1rDFy6fVCjK49Q47XVdUQspFKBG4YWbLZ0rHeexBeA8SRKWk6HMo/0axqae/PB5dj69+tv/KhbjvxCiu1J9l+BRaxikeA8rpXEd/E/zFJIgwB3baZY1Pu0xcaX4GKB6Uzx0+hJmr/BgmDxGHOPxKYD/+NkMxmbVBIardBnc3UoGx3ExH1s1RV5yZE/fBoRrsw8DRio8YrpXC/Dp03RMaJBD75hC9kPoxFw+XTKWvS0nDtdpWiwuvMsEL0vd0cZKiI3QEILnIN5jJmpptYWIWfMZu3gDMCxWyUssMDWIDyd8XqUBTUy2jbzc619v8Zk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehs4H6t56Ucd9PHTttShbnw51gMTfpuRJh+cUERi9lU=;
 b=ehIpZ9hLr6PSquUAad3YIjSuTw8fc+xsSlRiADxUfUmHa7QL/XLpqI5+lNTnFzsFNngFLsuuQqwr2x/VO3Djo9sRidEvWBYhc8Fx2Xhan2sZYNkUWSACw6D5agNMMhK1w1f98dLvuY2sU5O29/Hy5Q1lY9bTgNvFOKlXPid5B2MrDzi0XnU/IO4KyTjBhWrcZjNqzsPzMKL8j1wnOPR2Y7E/CqB8GvPu9PP/XZDxNrtEXsh9a49kv5JlWnzk7XnerwuOGqTVradwlLhA9sf0eVd2UKJJpmX9MgdNLBT/Ry+voLHzN6FcXegyTa4tOpSu9Wuvu0thgxFNCUNtZgSFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehs4H6t56Ucd9PHTttShbnw51gMTfpuRJh+cUERi9lU=;
 b=Mz/3NARKzXhIsjZOapT86J7DWWO0XPHkuNH6nWg1Hw1MVY2HLF8sDDaMI75jxTV4Ink8zglJT9pvxbG53CnEhYwU8L11XYmDpigtOzrBRlxtKj+EWWNzwl7nOjjgvH1LXVEPxUXVHDTHlTPoTqi6tpEeRY0q/KU9+52yGx9NuwY=
Received: from BYAPR07CA0019.namprd07.prod.outlook.com (2603:10b6:a02:bc::32)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:59:22 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::a3) by BYAPR07CA0019.outlook.office365.com
 (2603:10b6:a02:bc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Mon,
 24 Mar 2025 14:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:59:21 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:59:18 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 11/11] misc: amd-sbi: Add document for AMD SB IOCTL description
Date: Mon, 24 Mar 2025 14:58:15 +0000
Message-ID: <20250324145815.1026314-12-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a249494-dbcd-4f7f-7961-08dd6ae47601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PcRYnGPePdIECn4lVOSRqGvfzkZgl5kxqJyPlagGza0aWtGhSbXPRCYG9R5D?=
 =?us-ascii?Q?0hHi21FmNBnlTIWPPdsbH/NHQPnJzAhrJ52f90R3X6idzy4kWZue1EC/9StS?=
 =?us-ascii?Q?YP+EkVPfPrS6GWgX9hpTO2dPKYz87XRDVWHk5E/b11lO0uAqb1kLm7MxOg2Z?=
 =?us-ascii?Q?ZVD9EPMfmIzYQUavNPGEp0xK6q89WNwg6obWo0aHziNKN5416qhQ3qiXFGQe?=
 =?us-ascii?Q?UDl/x3wTelOIbF71HTQzbEcFTrcaJpuKcIwAmRxBC/1FBgTtSDnV8k71NWEF?=
 =?us-ascii?Q?Rzg+aiUfF4MiMVIijdr7vwF9IKBRrnny0mcopfm3YEWJMzBPKjJ1Z8UsdtKT?=
 =?us-ascii?Q?37Hr22Z2qBgQd2W1o1VFGJ/lkVLfLCHWh0Um1smpjFykHY8o+efCYVhTIrJG?=
 =?us-ascii?Q?KsRqNPkS0162YHvcmnr1JHyqklRpJxlknyfGY8eUZSghvdd9LZK58Q2tO3LE?=
 =?us-ascii?Q?V8apS5aOBOZLifgyTWGVSFHQBnf87myCRWRVGzhwmAi67dqf1Nn6ygbkErBn?=
 =?us-ascii?Q?a6FjwiwcoCBx4gSawk8AK4dcYu/FpQPzIVlyNCzhmo3DzRE/0qJ0Bsfn4BvL?=
 =?us-ascii?Q?Timq3klTNItn2PhgbBFJWAlOl+ew+15SQaEw6GWLoAUzr5YBLoQG2CoJD6Xe?=
 =?us-ascii?Q?OZk3C2lCyqZiD4KQunuqe41LKVkO6F6FKfiDBzJoUzN78ECPBgLSNqJvWyWX?=
 =?us-ascii?Q?ZMYzmb00p1I6nc0gAUnD4BpMxmXe/gDWg6xVo8f1XHnEpxI5CYk4pNZVeGqb?=
 =?us-ascii?Q?qrB40rLqN1p/RfmvpAjFq4AKDFv7yzToMGJUfIgzhxZp4DRCvLaX+WmM+gVp?=
 =?us-ascii?Q?FWV+hvY4Ev9lrtWg31xPvergRn0FR/bUcWq7HTsw3CVKepGqVQ751X0DTNGF?=
 =?us-ascii?Q?Ffk6iEodiM8sWd9+MR73ruLADn4qsiKokGIjs2h4D46CaxhAPqbL/U1TtUY5?=
 =?us-ascii?Q?6EUkwj+krCTwn12ucGrFvLJ2FIR5xzilpwDzoNxCn1EpL+xJiddlnFMq2S93?=
 =?us-ascii?Q?cYPiHIPjaSKPl5ruQd3ScFjvlY+0O/7SuHkcuV5ZB2gKS9slPGtmqfdg3cUm?=
 =?us-ascii?Q?iX23f4/n0SkdEuOCwyp1+v67eLFr5WLX3CDy1e0ryPPLtijPW5GIiYMnW2XW?=
 =?us-ascii?Q?IPFKP9xxw0YcOTZ5Qr6l2BrYYBr/fgexWQZCw6mRyBGqyesYH9w+V9cPj19r?=
 =?us-ascii?Q?rl5iXZV5B4jFmMmI7Ea/pXBo4IrOmWHdO7EeGuOYgyr3U9U2kFtL2k2YKDAL?=
 =?us-ascii?Q?+5v2dJyH164Mf/8qrfnrGKO2QGcj7yya7DPRUnGmBVQ2LdxYZWKf19tbEm89?=
 =?us-ascii?Q?hCuL6oi+kkboHtrlnHypwxqJOSygmSYDEmegOx4hkyM7J2+kbA+DBG8EWNq+?=
 =?us-ascii?Q?oqt0nh67dY5GuEN+S1XupU3PfVJV2zlhSublqZ6CX3Ixqlw9Fl98EfxLTkab?=
 =?us-ascii?Q?0tQy4LT5lpRqOlWDZLC2pLYiU2u1AXnXKGGUR9CMHmFSei08oWW1QLpXxIkJ?=
 =?us-ascii?Q?NYqLXCVWKUvunrk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:59:21.9968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a249494-dbcd-4f7f-7961-08dd6ae47601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

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


