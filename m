Return-Path: <linux-kernel+bounces-541469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08215A4BD50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C163BAD8A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D121F4191;
	Mon,  3 Mar 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ejT9S99i"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734E1EF0AA;
	Mon,  3 Mar 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999576; cv=fail; b=nodMxnI5x/Lmi++eHUH8sXSQ5cwCZ+IuUO8WeGlKZbTu6uepCIArjTgyL1/SRXGDZM7GDLu2e05pcvqheszRVeE7+4p2mS2OBN7NLoUDkfPUA32F+Fdq5LjbrEwEGV0qqSPuOl14ee0C9qws3mAt/DnI/bfcQUDPp9YWKyM8dXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999576; c=relaxed/simple;
	bh=Pxi9DQYAtr8pjkcL49+BcaKCU3FHH2PIwalsjdxC054=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiGWyPJqTYKwB2iac+6zXbO/qw+8i3IHpu+Jmp/aFgd0+tJr1aaw2poaQk0xhWvl0qDhFn3C6nTd3R+OGosbomi3mrYtFsrD6suYaJDyTePr1P5VoHoewYQnMyrQH54PdLIPPMzN2DkwoKgsGslZ/KyMvBQcmLir1h4euIVrO5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ejT9S99i; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywu1ql4mOFfzCHONrMSpr4YvifuBTArnxOQQOT5/aR5sYsBxSUoQk934RWhabxpnYIOXV3r914LY3w6gZn2sjsRJD1UoPb1/XrtwHDzvfDLN7n9gPTq82kJCYMmc8FHxYW96kY+Nap2WaZ8xyofuZ3Lhn6gzeMUWk7FvNiMqiWbxLr/hJkat7SUEt48VLfl8OCRE4aRLjYa1/v4vBujeWusCtQcRM5UQRrb5d6GNnPFdOGOM4mM/WAs7W6ckpgsLudsWJVJR2rgO4R7MI0YhOa9EuWm0o3fOoR7zWQQXzPJa+LwDTaTDEhN/4AfN7yrFVbDXzk0Un+UXz3TXzROIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24ZoBzqCEpp5mLa6zgWZWDHGF69laEr7zcXx0e9VNV8=;
 b=AC2dygAOP7YUGJuMxrSinKrGjy8P3AMNDd0E4XGjO5cR7isqogOR2xKPbMN83ZzNCWvOM1pt6RN6naZCAP77JvGKTqGXdll7VDO+H6DHLfFWyBgVdGcvE9/lE2cUFCh5tmjpxBB9HBdCfq1y8DHI3CgMbYwbF8VZII36nXCgv7U2cT3daJscxNImnCOIxYGBVPRA78eVovRT+m0JXdGZqmKnbF31jvaRkABGuauB+E0uAxkpg9dZsbjv7AhfKLxc7C+gaFCoUnrfp3jYqk7lOKhZB1y8gbZg6wEzusk9WQdYiXChLLa/wt8lkLGpBjswglO5N8QCIU47mbWYrtju1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24ZoBzqCEpp5mLa6zgWZWDHGF69laEr7zcXx0e9VNV8=;
 b=ejT9S99iw3MzboCW3VHc+hDubznC41Y9eK92Ia6kkk/5nRW9PIdR+0beAbNwg6g56aOPr4Uhvnrr/uMbiOL+c8zigFono28NcXoaKmGAcSqRWvx3HxuLZpoKrOxCXhSQaaMmYLf7czbJp4RYmjFHRA1R20mnxKOE4AXpx+0UH1c=
Received: from SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::33)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:29 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::c7) by SA9P223CA0028.outlook.office365.com
 (2603:10b6:806:26::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Mon,
 3 Mar 2025 10:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:29 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:25 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 01/11] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
Date: Mon, 3 Mar 2025 10:58:52 +0000
Message-ID: <20250303105902.215009-2-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: caf5cb61-4123-4829-41cd-08dd5a42786a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/p6PXIkZbdY1/l2gNGK5/+Cit+xTGvZ6rUioLZ66SKIkelWWY2CsST+Ng5U?=
 =?us-ascii?Q?TDeuPFEiARpldNSCn0jtOXEtyimBdBNz7NCUz6+/sqrbqy7tQKI32wF/4hSe?=
 =?us-ascii?Q?d7+97/hzU0oaHsXqzllBWBKpm9jXMPr7SXvfaIwiruREXf76nrKAzFh/LThS?=
 =?us-ascii?Q?YJn6BpeoXffsywV4YxaS/0t4UUkKXrrYdPvbJrg2YKr8JKIOBO6CooAsJkyn?=
 =?us-ascii?Q?rk28oH1hBWLVxcZ2wPxzmpzETDIDb2oIhlYn1ry5W8ww2X+pvaaV+sR4kLcX?=
 =?us-ascii?Q?pEc6MTKx5hao6nYy/ImbXzYuYc+oZm3tOHYeivwBQycgOI1aqiwIeZx1c9jB?=
 =?us-ascii?Q?6c7iv4eevilAifoWf1xOdQPWcXi5mMRYXFJOYdwSGUBdsJTj+bysoKx6xarg?=
 =?us-ascii?Q?a0KDLTUscfUi28aWzLPDe0pE1fBiafrJP8Bjy100WvurqQa4LRiAyrQJFziB?=
 =?us-ascii?Q?kh5mvJ6Nbje4iaSz8Rf8RpR7j/b26ChS7mcVvEmd0i9urIxgPcOBz7sAg640?=
 =?us-ascii?Q?Ii5TjkcfFXtVvDEKmcs/fC+oJMZLkLaw8uzbU9fVcwnKzYz8469q+VSPGUJo?=
 =?us-ascii?Q?nUEO/LN1G5xrdCtjWuHEwE34TVx4WmC9pTy6M0Ao6N/zHa87EVODX7tc8qjF?=
 =?us-ascii?Q?jcIELSpB+4I+p3V/2NVJVAfDGGZqxMlvNORSjIvtzJX275WLvMDnbKs/alDM?=
 =?us-ascii?Q?SGONcZupeB8cYSNw53JsfWMrpOxwB9Etvv5sCUpHmzO+blEoYQnPNznJaNRe?=
 =?us-ascii?Q?CE/dHPpEiviLfuycNKMkrTG4Zo1xQjyvsXdnDvVFPhzmNr6whx1ZfuyhQ3yw?=
 =?us-ascii?Q?squfxpWZo3un0AyIoNU2rlRXyVZoR5M6RWoE51L5xkVVhi9krRErPxl6ls/a?=
 =?us-ascii?Q?RafVpIi6h1I6LyPAIINNsGiYAg5N38awcmUPDWt9+G7VdlP1FB89HzlfZAzJ?=
 =?us-ascii?Q?Kun0gR1tnHY4WohvFkFbwbiUFQ+Qg18tq/LtWi/kLiKGpHZ7P1/C7ixN/sB8?=
 =?us-ascii?Q?50yrizgXy1c34olMW90/paBSDgCAXg+S0FXqQR7FnYChAmPvwd4drqudiM+r?=
 =?us-ascii?Q?ixb6+cWZtLRDgZoB+gvX7I9dn0YBLzjlB9/rb2YHk1CYI8ZEJ/MJKLmnn9Af?=
 =?us-ascii?Q?TAzXB9UD/698q/+Si9QGDGtnS98kK39PaEtG2mmcGQmzKrQxRk2MpPBwDiC2?=
 =?us-ascii?Q?4AAYrYa3XTWQb2nHzJFOVt9X7BYBhqMypllSmJqSa5+LsmYczAk4Kc+xLNUM?=
 =?us-ascii?Q?/ICN7xJTaeJvHVNtttAGEmUWbRio3SqIdWAptBqAr5RAzJTzSb1uv14CK8r4?=
 =?us-ascii?Q?auu5uBmqSAaLbEvhTd2TNErgPz1lPiSGeKLeTx2g2z3uVjmgVGFyFZiiC+Fr?=
 =?us-ascii?Q?loJEJNykpwJLJ0VOGoczSMt/N6hkmBx8HEvMSDJLe/I4M3kaV4DNjuB5N/nk?=
 =?us-ascii?Q?OGpxXEE2usL0a/fdN0+byfcEUOYb1OcHkFSa8TG6K1/8ZaGmatg4OTIAql9k?=
 =?us-ascii?Q?Tr+x+2eRfm3kXkg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:29.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf5cb61-4123-4829-41cd-08dd5a42786a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

This is done to support other functionality provided by the SBRMI, which
does not fit in the hwmon subsystem.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
- Split in 3 new patches as per review comments
  1. Bring drivers/hwmon to drivers/misc/amd-sbi
  2. Move out the core functionality
  3. Move out the hwmon functionality. 

Changes since v3:
Rebase the patch
Added Acked-by

Changes since v2:
Rebase the patch

Changes since v1:
- File name update
- Add hwmon sensor registration in this patch
- Update Copyright year

 drivers/hwmon/Kconfig                   | 10 ----------
 drivers/misc/Kconfig                    |  1 +
 drivers/misc/Makefile                   |  1 +
 drivers/misc/amd-sbi/Kconfig            |  9 +++++++++
 drivers/misc/amd-sbi/Makefile           |  2 ++
 drivers/{hwmon => misc/amd-sbi}/sbrmi.c |  0
 6 files changed, 13 insertions(+), 10 deletions(-)
 create mode 100644 drivers/misc/amd-sbi/Kconfig
 create mode 100644 drivers/misc/amd-sbi/Makefile
 rename drivers/{hwmon => misc/amd-sbi}/sbrmi.c (100%)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4cbaba15d86e..5b53137f8b89 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1866,16 +1866,6 @@ config SENSORS_SBTSI
 	  This driver can also be built as a module. If so, the module will
 	  be called sbtsi_temp.
 
-config SENSORS_SBRMI
-	tristate "Emulated SB-RMI sensor"
-	depends on I2C
-	help
-	  If you say yes here you get support for emulated RMI
-	  sensors on AMD SoCs with APML interface connected to a BMC device.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called sbrmi.
-
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 56bc72c7ce4a..b2792b9664ba 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -649,4 +649,5 @@ source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
 source "drivers/misc/keba/Kconfig"
+source "drivers/misc/amd-sbi/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 545aad06d088..fde23b0b4f0e 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
+obj-y				+= amd-sbi/
diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
new file mode 100644
index 000000000000..be2d9e495eb7
--- /dev/null
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AMD_SBRMI_I2C
+        tristate "AMD side band RMI support"
+        depends on I2C
+        help
+          Side band RMI over I2C support for AMD out of band management.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called sbrmi-i2c.
diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
new file mode 100644
index 000000000000..304394bf5e59
--- /dev/null
+++ b/drivers/misc/amd-sbi/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi.o
diff --git a/drivers/hwmon/sbrmi.c b/drivers/misc/amd-sbi/sbrmi.c
similarity index 100%
rename from drivers/hwmon/sbrmi.c
rename to drivers/misc/amd-sbi/sbrmi.c
-- 
2.25.1


