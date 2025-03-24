Return-Path: <linux-kernel+bounces-573881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA5A6DD89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811BE18871E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501F2628C;
	Mon, 24 Mar 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ADXjhzIs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41426136D;
	Mon, 24 Mar 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828325; cv=fail; b=tab1tKJijJMI7c2/F++Xkjiw+SCq+xrCUsOGjF/z5gOQgqa/bnqc4Z8PnqcMnUiVMaYgOkScxXY85Ki5Pz0zl61zZotTPeHW1A5FmIAUZgWcelYN/GxTMC9FFioHYH1HeoaGC0YzcpmZPeFYiudWLbr40OVgD6FPhp7ZpEq6N8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828325; c=relaxed/simple;
	bh=1rVVbZMM43xmRkB1LDORI2NL1Sy51/KISgimfsR1kjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhMBf2S6hU3XEDXV0Hj3txb8F3/wd9QP0RZz/F5rQhx2QecuK4/FCHWerh1jvNrtWjwqU9X4nG+mvnLynjK8ltIUvso83l7K1fWWUha7Ir7viCjLxQrLTcn3cLEWTN4hlVbeE3MCTg4aRaC5Oa+R16qjpaAh7ew3tgXnMFvOZu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ADXjhzIs; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIpUtn5X50bSTuuUnqknVMXu1vjj9QYQrevtlfe9RRfKxdOEthggMIkWEvje3UWxmyyB1gvq8KPtWBcI0vxHHZ2wSDlHtVV3BxTdmLxEPvRwgJrkWXu2R1oTqRzW0fiJ4dS195Vq0jz87mlImi+/nxv+oo71mdNM99bPHfGTFQSA0lAAFXGzOqhLVuOg2dy0ZoOx+OMcrBCu/BMeDxBM0q/sAA2BhE+AGXQ9DN7jb+0/odeGrkeyEJ4Bdot9kqssvcydCuS+HzFZ8Uiq+6OeWuV3SMSkCbWyWhyccRIrwpqjUIYJE5mIJ0zJxI2HPJ5q0vRtm4jN9kbX2kg/gAOfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGa2Dp3ps9Hc4YY0ANXFTkLgiN2wtbYBASkzwUjRC2Q=;
 b=x8h9CdDe2MQR+XHhzrhFwo1Bg+4zwQZzq6WRBRdOA5Rn4F1zW12M41AIZWSR4j2Wfbv9RhZaKas/DBJ0OCYLxx/y5lMXRegP1bl2iNKnA1k6OiipcX0N8ltk4PNo4QsHIh6MmYpMBizSb9GhOQXNkeKuOzacS7sECzxBA4yPv6wFOi9mjY4hARfRi6cmChCLhv2RT91I2fzVSbMc7mN8la+/U2Lht3Wk0M6kp/QqSFCXB2Ma8sMWN8ewgfNzMG7qMcRd6euRnsTJ3COSw1NRdoOn/AhlgHMOvslNKmc++3T/8BEer/tnQmAirQrKPHqzPz97yr5KOh7gnHpv3VsvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGa2Dp3ps9Hc4YY0ANXFTkLgiN2wtbYBASkzwUjRC2Q=;
 b=ADXjhzIsfTGqZfCVgZDW0yk1LXztgS7FxHmQh+1/5Rze6tIs2Fx6ixXoaNSSzokKAKsfUBbNsGZfXfO/bvGKuc33OHkYLb+jco+BHC9HAwbLSrHbkPUoplGH0+mYP+8hQDuvpcP3Wo494tQ6aS/t00U90UG/9YyRR5BqcCZFJcY=
Received: from PH8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:2cf::20)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:58:39 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::f8) by PH8PR07CA0033.outlook.office365.com
 (2603:10b6:510:2cf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Mon,
 24 Mar 2025 14:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:39 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:36 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 01/11] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
Date: Mon, 24 Mar 2025 14:58:05 +0000
Message-ID: <20250324145815.1026314-2-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 874475fd-a14d-41be-4c7a-08dd6ae45c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UIkVVzh6fgwOkhH5CNHAn5PmLuwTr6JnGmRRv9NodGNqwmqvt/vRnJqFGPNq?=
 =?us-ascii?Q?2IN0I9Eos4sSgMnxeaNvVF/44zOgkY245oEP/4xNFR0YfWYo7gJZCpWgedf4?=
 =?us-ascii?Q?CDPHhV3a7AlQvrX8d7pyEYz8n8AQQCzvDmynKQf4zN19gfLnbMBrU84W3xri?=
 =?us-ascii?Q?me5mPqQZNYz2BOXvB8OWcplHYIbrCyzcgPbRNuukl0niUE/ACBPJWDEa3iNG?=
 =?us-ascii?Q?ptd2mg0IGJ+EsnTCNwxeJmwoYLxphy0rOlZDf8gY/lwsA7s9igCwZX2WYrQY?=
 =?us-ascii?Q?PP6BUa+658RRtA999wrMdHI13+9q5JfBfqlNTX6zqA6TidoFkBU5tTZ29bsi?=
 =?us-ascii?Q?gcfLR+vAAc4Vm0vwhWPvLmw/cc6H/gm/UwzjUBJgo6EfYAx0oBRWnnGp99G6?=
 =?us-ascii?Q?qVa9rNnqEOioMCg+xkb+s9FQB3PcZWY3zFlJrUtzscneVD+csY7+ocyuzqfW?=
 =?us-ascii?Q?lZED6AdmQRdcmllI5mMGKZTHTWZpJrl6QWpw8RamD4Or44H2Fi5rJPNkEPw8?=
 =?us-ascii?Q?GX16FsF6nD/BeINDr9a2B5uyVw32Gln/ytAxRkUIhrCqiqKcuhoySO2bQFMH?=
 =?us-ascii?Q?BQfV7T+K8hbO0bVOFlRz7g8+WaEHNfDH1tQPGoy7QL0S8fCJuzlBmjrWd6Q8?=
 =?us-ascii?Q?Y/5r1cQJ6y9fwK0wlM+oL4yK3BZ770QN7mMvVTLHb09RaF5lvg3+9GropMZJ?=
 =?us-ascii?Q?hBbnTDebdl9wmDgppDtHpCjbjY/rm64LImduBtYd/xWAPwOD95f72r1NRC8L?=
 =?us-ascii?Q?GVFw+Pauwh5/icmjiiR6UD63qQTPiUfXnHYx39J4cpnTH2NtlnBobkAxPww2?=
 =?us-ascii?Q?jEHUMzor97bFYfNk1TjUSZMlmssUxlUxMHPVQx7QAtaTnjiOdXbHhXjOI3yX?=
 =?us-ascii?Q?B7rwgGTzB/kQYeayYKqk6SFdQKeA2rwTqIHa7Y3+HDxIhwYm5MbeXF2UTFFa?=
 =?us-ascii?Q?o1wPJm7hK9Wj/UrAxXeDgH3lDgovROhcxRKsv5uZeM+eVkMsOCaTE6sF5IlZ?=
 =?us-ascii?Q?Ptxobl/0kqigVswP8rSRFUmjFh7YDSx4o0ngPO/VCVCwaALzyPGD5t6WNV6V?=
 =?us-ascii?Q?BSGN9j0jKOxC7MrpgKjLM4iIoQhh5MMJxp9rfAbmSi2odtCvjmxKu0tVc/7m?=
 =?us-ascii?Q?nBFc1Ul3/2GPBG//oC+QkKTnIA3qTVeesbqSc+QdJmzINLy0frTUD8wGGJ7Z?=
 =?us-ascii?Q?kf4nkrJXkghEDhHTBgApcHxZtN0MQQuVJ3HPQRlH1GBhw61VrxpXVt5Da3iz?=
 =?us-ascii?Q?oCrSDp5LA3Y07CzxL+T3QA1qIkTS811PL5gn3154hG4ZJi4amZ0DJ6ha2Jt4?=
 =?us-ascii?Q?0Pv18rHhRArEks175rsWw86WIA3BkrLSx8QlNjR0YKsaWmkU6gW4Bd9+hMfH?=
 =?us-ascii?Q?vWuJh9Ij6HQ/2cCFweTsJxTRtj9UM74pUUOraEgBQ6H7skgVL6sLLC+9u8FP?=
 =?us-ascii?Q?cg5uI5EVFlva5lnCOEYiEg1lmNa5my8Rli6D/mV/ipq7md7jDbQdkIT0aP+b?=
 =?us-ascii?Q?F/R2c+bd1p0ZjzM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:39.3750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874475fd-a14d-41be-4c7a-08dd6ae45c9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215

This is done to support other functionality provided by the SBRMI, which
does not fit in the hwmon subsystem.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
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


