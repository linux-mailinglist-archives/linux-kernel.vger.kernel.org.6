Return-Path: <linux-kernel+bounces-311995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1FB9690B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594201F236E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F174A06;
	Tue,  3 Sep 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6tzfPh5"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100B8F45;
	Tue,  3 Sep 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323773; cv=fail; b=DBmePol0GXN6Q+K+XVLY8+0JyJ+p7bI9Tx0NQtymMTWKUX+gu8tyQwHUfW9DcsWrSGJu6t+p/yOCMaroYkMaSQrELCuC1nPWnVyNUMwUuBJgpsAG4jmXl5pfHggPCHwJiaqOpokgpUGBiSRY19w21DLDwrmWCjm1Ng+gI/lisDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323773; c=relaxed/simple;
	bh=1tLaMn45UpYSRwA6Ebyy4U0LV+ynNXbQukYv+T7Lu8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqGs5htO8CIT5swXb/XohRdCS+9zN8B6YNKr1f1v3Ma3TzclPQUPcEdCZvfwUyoMm/1H1vX9LUYzajsVtduUACAbFYaWED0rECZjEVTKKQTcHnECQoGcVn3QmOVggvZkobkGXvv3Z8Aq4TciPzW4Eps8pwmITN4xHRTEgSurqIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6tzfPh5; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFxVdBjkcUCsFgymG2OQ/gPe9WdbnCXJH8HmD/+vivDAYYkygC6NWEepCMzx0hLSHfAJKwy7brOoev7QvhyxhdhrcE/7dc8gVrMph7W2vT+Jop8hgJHgi+bllYCHORwNbuNMk2y7lPyJDMmOTpNAms5EAkhdilotZ9UF5wpC7EhGx+d6IqMhlp2ZyFLiPXs7u9PFEnKP6an/YCqXbxba9go5UIzrRYpFiN9BRHAc4qspOiTflDI2TGAKjUzcJmiVyQZ4AR2EG+s5Z6fogHMSM6ENfv1Cqae8VQFtoSAEF+wfhfcP3pSKQFpqSFRQJIGnCuCEMhZETwjxd+W8yn+OkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+m5338o0rTbrQRZrp4Co13nNPwMuiQVeaq7Y/ZQyGQ=;
 b=N6v8Btv3fEHIm7A/6CgGxmxr71Y+TuDgRac1V7idVLIOMdTFnwf0l3Bs8xDrxGgO1/unqLqKncZj/I7bjv4vwMOoG+Af6RMbo+rgYP38kY2G26op1gOdtgsB9NOqOmU5KW9ZUX+y0P1C46DppvGuweDwTeR61N45EW/O2gxJSjUQ5uctKTcmjAktPUpjQmOHb/ix1HLjtb2vBBfAYmR7cQC49jjBQtZspqd5wDJU2w/k9G10uNxIOpnSrjstV2eNf+wgtM8QEVfhrgGoxzX47FDP6uNHVb/zy5WrW1XwZk2NjeXCJBKxSIDNjVplbUWzCTLQeKWmeZorkH9hYRIauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+m5338o0rTbrQRZrp4Co13nNPwMuiQVeaq7Y/ZQyGQ=;
 b=U6tzfPh5vS8rBTVq8VIgbk2nbka/uNpABZci4yHt+oNAMt7GIegNsWW7Obh7Wjmn6TVqpTqfQ0ZMe7b5WjBtnX8ZoQDY3vrz72m4GRlu/qd03auBfrDnopsKKWPJvpfxKR+P+BVpqMRKrWYZ3zG5YpA5kLeCMoGYZZk7S/D9sp0=
Received: from BY5PR17CA0057.namprd17.prod.outlook.com (2603:10b6:a03:167::34)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 00:36:07 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::8d) by BY5PR17CA0057.outlook.office365.com
 (2603:10b6:a03:167::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Tue, 3 Sep 2024 00:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 00:36:04 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 19:36:03 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v2 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line
Date: Mon, 2 Sep 2024 19:35:11 -0500
Message-ID: <20240903003511.1530454-3-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903003511.1530454-1-papaluri@amd.com>
References: <20240903003511.1530454-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c1e6df-11dd-472d-a480-08dccbb06559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnMSBUaZDSd2GAUwueK3pMwbJaVEVQ5OLUy9BW1GeQFFopJbptax8vLqyDHC?=
 =?us-ascii?Q?LadsBTZmx9wcr+UXdSLBYtXOrwiUfwjeAR/HVfwAjA/BdCn327g0SxKMar1B?=
 =?us-ascii?Q?BoImIroNSf0kGJMDYgnnIxHtOLhEBs7YuUDajDdY3lkDghafpPuA2c8jh4Wg?=
 =?us-ascii?Q?j+5/TXANAjKsVTUsphpxb10uX6yvHDodxFDgaVPNxxNdyl+kqnDLj+Jvu1Jv?=
 =?us-ascii?Q?XDLZH5R+ev6YRednhtsX2XNPBspeMDX7uGx0MXvf/g4rWq7Mx1NQYbBJGHEc?=
 =?us-ascii?Q?q8OReeG3r9Xl/4zWnOHxn+sauLXCnnKmRFcD0f/lFfbQ3KK5854LlklZzcYT?=
 =?us-ascii?Q?52GIJAn+j5NaTFPszLpK3NisabRWo+Ux56oiCfIEPJ36yJzYWXfjj3/Va39X?=
 =?us-ascii?Q?okFBMK5uuXIU6AncplFIk8Y0/i4pv0mH9sV45jMFT9yugX4rr/ffFAeGkIfH?=
 =?us-ascii?Q?JK6ywHZVu9WOwZp22HxtuUnsOJ+3nc6pGNeKwJ99qfyyZ0G7Nqo3D+Y1GH61?=
 =?us-ascii?Q?809J8QLb5pEu/733nvVq4EK9QYUENqIE+E4fQxodj3UzjN2Z9OBBdHv2Uo/Z?=
 =?us-ascii?Q?aXHk541azK/3Gx+OFtiHEQkA9T67/xmhZUP3Sz5z5qVGLIYZrWUk6PSAqSvK?=
 =?us-ascii?Q?qNqQZybsxdORlNWfYI8wU0f/4H36fVs8zmB8DRxC0u8C6DFenyX2qxqmat/T?=
 =?us-ascii?Q?MgVAE41ELz8Lk/TxSuGxs+fX1m8ouiKrkyKhDmbG54hJe7FuSbBC0rDHE0Xb?=
 =?us-ascii?Q?8AwP9H1pyEii4w5M5CVPAm8FWvGbhC/NWFd4pK2eStnk8PPbnaB1gv3a0+8k?=
 =?us-ascii?Q?CepXtdg8aWrQ8Edyp7iTVGts/F8c72CzsODmVQ7jRpHHM8D0mkEh/ggRrjmR?=
 =?us-ascii?Q?c8rrt74PFz4HukNVC0hAL8JUNscczHRhCkPFfZLaj7n7qhgpIy0OhoaBqBT/?=
 =?us-ascii?Q?w4EcKKNt4wFSi2kTQ0EO/oh7JB8NCX97wNSTCDel8phhvPKqsjPEzINuGh6n?=
 =?us-ascii?Q?a9sxtNaUpq+viBHv5c8AykqiTkE0tge6e2Zig4v7rWJTbETDaubivtB8fsoV?=
 =?us-ascii?Q?GeEjBkPA2yAgLfm5iugphNipbR3tf/8NrjYvDDhHcmven/lrfR4ZTrLkifLE?=
 =?us-ascii?Q?4k2kNqeTnGw6KhYchTVN3crgdM8k6NQ79NePaOVMTTYgCpEqdrSMpnD1fZDA?=
 =?us-ascii?Q?p0AzPtoKAegZtLctq9KW/46VhttaRNHLMCeEccqQIOZWc9DygpsOzlm8Y7xU?=
 =?us-ascii?Q?1nbCvRKwa2OC4gJLTOmRTTI14MPzzRooaLDuilMNBlV0Msw9blZFO+h/meDX?=
 =?us-ascii?Q?6OJiNO2YEHdXNeyImKGwSoJXn2xm3lko7CgMP0/tiBOpOxdlibh28zlMlyGI?=
 =?us-ascii?Q?ZCwB+NTN65OtvwEiC0R7WQE0WbnaNEh4mkLp5r1SldnnrTMLCOeavqN925WG?=
 =?us-ascii?Q?MMy8/sDJdUp0N1YER/1Z1+mcaiQv+20i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 00:36:04.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c1e6df-11dd-472d-a480-08dccbb06559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

Provide a "nosnp" kernel command line option to prevent enabling of the
RMP and SEV-SNP features in the host/hypervisor. Not initializing the
RMP removes system overhead associated with RMP checks.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/arch/x86/x86_64/boot-options.rst | 3 +++
 arch/x86/virt/svm/cmdline.c                    | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..3d4e9a7dccf2 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -317,3 +317,6 @@ The available options are:
 
    debug
      Enable debug messages.
+
+   nosnp
+     Do not enable SEV-SNP (applies to host/hypervisor only).
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 4fe34e831d8f..43039ec67606 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/printk.h>
 
+#include <asm/cpufeature.h>
 #include <asm/sev.h>
 
 struct sev_config sev_cfg;
@@ -24,6 +25,12 @@ static int __init init_sev_config(char *str)
 			continue;
 		}
 
+		if (!strcmp(s, "nosnp")) {
+			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
+			cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
+			continue;
+		}
+
 		pr_info("SEV command-line option '%s' was not recognized\n", s);
 	}
 
-- 
2.34.1


