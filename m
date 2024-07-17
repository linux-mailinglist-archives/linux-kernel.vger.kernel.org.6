Return-Path: <linux-kernel+bounces-254871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921969338B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A881C22ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38059147;
	Wed, 17 Jul 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="td5bFvgO"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407C3839C;
	Wed, 17 Jul 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203884; cv=fail; b=YvoBXyP/Ab95zi4g4ABZwpAtsCswyq+AnIWZmR6X2HCqQE0NNJSuhMzi/7WUthYmvwC6HC0civD5G57SCIdTgzyqeRTBlRz0kPb6FyvI9rw1HemP/VHY4EdvcphJUrk8dyqP+i+oHJlM5dFzauxlUwpYnLzF1/plLJ+5ps31P20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203884; c=relaxed/simple;
	bh=wzCAFswBd3naz7BS1OAajEC09T8XHis76wfenGeVN3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlwGiyDYMxhYXP+faDBlu7tzjHoh8RR37/6I5C4uYiNbvDYkhmut0HTdiaM63Xw7g4jw2eJVlYDpKgsuHXeThUZ1JG1vC0SVePFxo87RmkyxemJDj19b5W9FJT9axjSl/3G6T9iN4OeCRtv8AJDmYlyhcjA8wBJ2R4WRK29KTnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=td5bFvgO; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh/lfcEWKq6ONVEQk8BVTJp/ZI1WR2+RnD/yrs7mmrsKFPaqmzlVoPnLRzfan+w7Af4dzIvJrwPaxFS5zk4BhPzCl+09adKscPKer2hA8gTJ+hJW8dJpEvazLx1qHsZczy1vM2n6Zq+FOShH71SD86aZaH57o3gWXg+hWK3sVaN6WqZz5HQ3A8X67VTi6DSFYcLIsqq4de2PaaEXw44CsBSS/Hhr8lufk9qfmwJLMrsk4NN2c4eEUTjW4RbUEkP/Br9yqgDLUS3ygtTFXfA28hIlOh3U+tixjqouOZFXYo4LtctT734yJWzBCJXT9K5zUMom7iPS0y5KcDDkGiZ7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhLMxzM895EPttDLcr2whw/QtkidYrknO5Y2M2kty44=;
 b=aPXtNHvRrJ1VzYeQzv+k3mLQvYaMWnL+KIa6Ct4kvVk9O6bMC4sxdM+9ZpZ4F17rqRh1K503ix2qm8Y6e7aSMEGDo1SF55fJHYNwUl11Q/Wji+Q0W/4XlX5FH9YwSiL/7HWvvOQjNY9/UUfjaQnoOav1sqPT89uobvLj30+AxHrS9nfHQ1A3CJmSle7rAK/EvB/DRuqM2y0sT6bvF+wgpVyQjAhhYy6aP7txCIbtBNGPL7uvUMOgWki4i+TOFLR345vES7ahqsbUgEzABThWNdqRr6tsdBaMoav8SwheHL5v3k8xBq382csyGRpV7MlH9RIzUEhI5Wp2PPlrGNW4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhLMxzM895EPttDLcr2whw/QtkidYrknO5Y2M2kty44=;
 b=td5bFvgOavuS021S/19qHZgUkikXHrIYf/aMAcmt6I1buj6fLMfgg5y+mYmMaKlGZut3DcZOZIwN1m3GW33V4bBIdjc4RfZqOzxrVcakP7561FtihdxzW3WiVypDSmwq7p9CA64YN38IoYAlWO+nf1+/drRSxv7Gi85H/8D+K44=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 17 Jul 2024 08:11:18 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::f0) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 08:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:11:17 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:11:15 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 8/8] misc: amd-sbi: Add document for AMD SB IOCTL description
Date: Wed, 17 Jul 2024 08:10:27 +0000
Message-ID: <20240717081027.2079549-9-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 012c7578-fa69-4885-314e-08dca6380901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IkZyte74prQXvEcsMimEe5w2M1WzzRT+GtXDYvGPqfkcMyYNtQJk1YkyDV2C?=
 =?us-ascii?Q?X/rLo5mchMEWFh9Wz/LB9/YOvZD+9pNlHnXa4qlk2+4NqE4koyjs4d0U+2iW?=
 =?us-ascii?Q?XQcAEDo6EygK4sOVUQYlDTltEvQfHUhsuOWOGnCaw3uV87G0Ft4gLBFCcwkL?=
 =?us-ascii?Q?yC83EjsbvT6yYkWbhNv75HEKFn3jQ0RxXt6S8Me6gK3Rm9sXqYOZ5AckAEK8?=
 =?us-ascii?Q?udzbiLBEsXJLx4ovcRGsnzRafrMK5RJu1JZdKGiFn44VRYSioFpE/cRyX9Sh?=
 =?us-ascii?Q?16Q+1KmXYA7CtL69eqQAVqB1TE0zA0138wJptCBoMu9ZyXF2ntX3yUsPzPet?=
 =?us-ascii?Q?4x2KuimMSGjTZ8xP+RH+idCS3YPrHy9Fi7bENz/17SBiZH6eucwAPZgGJvfY?=
 =?us-ascii?Q?Qx1S7Y1Qy/NtS2QlXEeOYs1+zmFovS8allumWix+WceUvtnnjsmAHluu1CS4?=
 =?us-ascii?Q?3DT1DDDHTvgC2rbbl+9OAyLzI3Iy9Pq7OQdjkYeo/Ceg03F+0BCWkR+/1dbU?=
 =?us-ascii?Q?1eh14fWxa4gz4rdnvBkd65G22XilfzZsFZ5Z8GSqpVPNPeZ443F9NuKZum4r?=
 =?us-ascii?Q?C+YAWNQrQesv4SA7tdbLH0AquB7uKAZ0Rli82bzCW3/uYM2eqSLRlOG5kthS?=
 =?us-ascii?Q?VOZQ12fh5N4EKTbWqc1s+N/eYqop87/W5ifz7HVKAj878ZRWAIbjYtODiwZ1?=
 =?us-ascii?Q?CXO3PGEbIZD6Y2bb/oMAzg5s4hsjsN3Tq8xx/uQiE8n0xmjnhKUA+edOzLVy?=
 =?us-ascii?Q?omcFI8m46jS9ElgyuieogFeFlf3IasGe3GsIDH18oPTj3rp+QBVY1A8VcBzf?=
 =?us-ascii?Q?hkLY7y2PpJdDB/JsgPFFn1jIQAVVxLc60O5nPfthEO9Tae6xiMPj/aLYqJMh?=
 =?us-ascii?Q?ahHm5sdXiFHNiSfTs7UJrLRUxlIisC7vHBrAtGq/oiUgGTvNbsdMpOMrXLde?=
 =?us-ascii?Q?Igwss97fT4q40VK86N8P05XjB0vFjkZNPyMtVePz8OB2TykilZ3/vBJuA/W7?=
 =?us-ascii?Q?QQeVtfcCcCZhNmE2Ga3CwN8aVFbGk8xDzqok26NJ5zJMBVQSVro8f9vo8qH3?=
 =?us-ascii?Q?SPFN0F+5XoZFQe0ULskfajh+Fk+nQTLiRr2Zu15ok140wuM+2icyeoCcEOnY?=
 =?us-ascii?Q?Gs2d+UgoikSH5slGeI52EWa6qtlrKefzbIfRiFbHTM0F7F4/Zg1OPkP37qbq?=
 =?us-ascii?Q?fMJO0u/gUGxwYodkZ+hq1l9mTuGORrB/kGTKsN1RN9+CK4+wgcA9JontgXoy?=
 =?us-ascii?Q?Ri5hmBtuzoipr9L/xhrPacvmFOHtzYu4KslfxytY20VMoBdxOYYFq4/7TJ78?=
 =?us-ascii?Q?FVWhWabLeHm4bYobIV3ap1tL7JLMiqj2JtYgr0ADPE6unIfhKua4fR08uJHX?=
 =?us-ascii?Q?d1e78Sc4JHbRZtBca9qBfCpOo4XE/k2BeQ7fEY6xAygdVP2ztA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:11:17.8282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012c7578-fa69-4885-314e-08dca6380901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

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
Changes since v1:
- New patch

 Documentation/misc-devices/amd-sbi.rst | 121 +++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/misc-devices/amd-sbi.rst

diff --git a/Documentation/misc-devices/amd-sbi.rst b/Documentation/misc-devices/amd-sbi.rst
new file mode 100644
index 000000000000..16c9e9ace816
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
+``#define AMD_SB_BASE_IOCTL_NR      0xF9``
+``#define AMD_SB_IOCTL_CMD          _IOWR(AMD_SB_BASE_IOCTL_NR, 0, struct apml_message)``
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
+See: https://github.com/amd/esmi_oob_library
-- 
2.44.0


