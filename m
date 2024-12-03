Return-Path: <linux-kernel+bounces-430135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C29E2CD3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEB328A4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD21FECCC;
	Tue,  3 Dec 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5bZXxZmH"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0D1F891C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256719; cv=fail; b=GlO9vyJzxcDu0/R8gtOs40EOP+a/hgOGa/BctGJJzpPsb9uG+UORe21ppeaJvcv+Rm5N8m/bZh/xaHC7j2ugdvoHqiU9/NtV8l/CNF696U8B7sPjl4x+6GxsuqaRfGYkdiHolAZiGzzIjl9Hrj1niYHy11ClcN5oUF4UOOgKbns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256719; c=relaxed/simple;
	bh=riwhJABnLEtIcpb0niDvkD/IBqD2UBPHav7XD8Wor1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUYU1YOVSR3I/JM9H5XF/4dNxFLi2jpQchuic5L1KeTEXxAHhTjBMuzuDcFbqBz60HT+fO4/2ez+AVL2WV36x4TR4VSl/RRpJmliOU4yqIPheQnk0c2oU8xhrhp3NxHrA4jpYwHQdEpsBSdBxNnlDPHa4gt9ElR/4RZeMZnJ2mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5bZXxZmH; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNqgjQ1mqlGQT65GMNhL26uh1+uDtQb2mXIykI84oy2kskWwKxQ5Ekfszbkyv2UtIMpbKItqKikdfJkelWdca/3UkP+dHi5mRQGiSI0XH41iyI2YgWOTIUhv1+caUy20Dzo2iKWB8E0Hkhn9LWDeIHmJifh6Vn+HuDI+da4nKvSvatq7olymvLW6GedrKrvRX/sr7+iDkF3RVCKBjzpuGz9jTE8irfgjsqYZQ8KSd5TXZEsfhHAM9rUp7l8btbGODoiWv52NYf0HX3fVgAb88FN/MOZyqO4ybzlj/QppQujwDscHwLxdgMLNM/xZg5mIygrfpMuDC1QX6jNCxmG4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc/LMNoAJBKGKrp1ndKs5ExNAbkpYLkYYWebAegAO6U=;
 b=ht11r9SDeaeDq1Eswirdpz0tJ9LmDDF2CQwpy4K9/8Ze6bSagTgGUUJovixpgD2GIsIT8UPBxcU2GIbni83G/iaPyM5eT7o0bWKixZsWX6AZlWcWcRHak2xXczfQp/aafXZuxbXqFZdrrivAfsg1i5fi0HlJ3yANkSBNrWzs1lA45Pl5UYc4rbZCenOSv9oCZjCfIOcL+WLjLW8PT6YOGYb6/f751DxxDQkSweI3E+cWVZ9HWSp14kmurl65dFC7kpJdaybO8qaYUrEXjZ+ldrPxu75vA3XMShmJrBXwkeSbg0nq1gpFATV6aayxOE/Gy7OGojHq/P+5RhCKtjDvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc/LMNoAJBKGKrp1ndKs5ExNAbkpYLkYYWebAegAO6U=;
 b=5bZXxZmH+FDsILVcM+aOQ5Wvi7W7ORn2Z1bxMOkYcdK+BrKX2hRkU/7zhNuTkNp6gDEz4gISgoCLx9z5N04v4hWU4S6ylqJ62VGb6OFFYDHGO9pRN8OUbaO4syVhiyHDbJRKEU+0QJMYi9N02vqMhlwgqtpcovyrNLc9V6DLSa8=
Received: from BN0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:408:ec::8)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:11:54 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::53) by BN0PR04CA0093.outlook.office365.com
 (2603:10b6:408:ec::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 20:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:11:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 14:11:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on systems with AMD preferred cores
Date: Tue, 3 Dec 2024 14:11:29 -0600
Message-ID: <20241203201129.31957-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 893b2c65-58a3-42e0-5677-08dd13d6bb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sTX9F/x90DBJNnW8Tf0Tf+BlFDNwWPokRZVfiJy9j/1OfMo7GtuefEJZGaux?=
 =?us-ascii?Q?Ehq+CPHAwdAZvPuW+3Qj+FB+l0WVVnGNvfVTsjH+cfSWY/Qw8DImUX25+0Qr?=
 =?us-ascii?Q?1kXlVHMaTkx7gSPKXE8FEBY6hZ7WBs1bMn/ZuV0yBXlBvS2UZOG5QtxilZsb?=
 =?us-ascii?Q?VmkR5c9D2fd3bj+l65TNf75Zrfki5P0BMMZxVQ0klliC/SMrf4EvCaDFcHnK?=
 =?us-ascii?Q?Dzg/y4ZWnqvoKCr9nn1H9p8FfETqfu9XoikQIA7xOIvUOR8yfXL5dPXvVTFi?=
 =?us-ascii?Q?FXiE32iK9yCbxLE1MmW0wDa18miuwgNzppS3u4+Njrxc0QMm5T+l1H70veGA?=
 =?us-ascii?Q?BSja86aulhgUryZdkX79z1OELhfGxmg18AluXJ0TsANpU8DP+QZrUwt9wnlh?=
 =?us-ascii?Q?uK5YZgZAqK7BvTxo7U7F1u+eWgJNShA8lmFOxG4HKeYs3Y6Hk9UVuM9kFurK?=
 =?us-ascii?Q?mZwJWwlVoMOEIcVvZA1JNcHC14jbpmVQEQ8b+eRqTq+fRHp8Z1v3GYf6yDEK?=
 =?us-ascii?Q?pT71pvOTIwbCAAkB2aWZVxanOY5dyafDE44yXhwogw8OGAaxGK04NGxShINJ?=
 =?us-ascii?Q?uN35NCMNvoWuPyNC0fNRPD7prvJsmPvQjfV0r2mdUvbn2KsxmEQ0WbdAb5Va?=
 =?us-ascii?Q?HwKvU/PeJ/MdlFN05vY8KUhid2lgUNHdivBpPfYldHuruGRNRj0E1vxp7aXU?=
 =?us-ascii?Q?5tINNhhm1gz67HywGTQ0V24qp2fL84s3/cOOuvVc4318zxPnusoYqr+3ZMiT?=
 =?us-ascii?Q?sFK1Y1wemSI0wxA4+gNO0TAv3lClCFf+M+S8gi3q3Tk6VQHz8Iy93AQQsQVI?=
 =?us-ascii?Q?CuaEdDNOP61nsDEUGcAURlYp8s5ogfhcG+e2YM0nP0+pqfcFZGOFE7zoHjyl?=
 =?us-ascii?Q?AHx1uwaokyJlJlxUi9D0tmt8+Cl1qcT4x+nZfU/dUEH+3NNhIwlS0rPqKQlv?=
 =?us-ascii?Q?qd82IpSh0YWbg1XKFV4sr7inLz/DyfZmVhWEugxNwvGkzJeGbdVTkrznjewe?=
 =?us-ascii?Q?WyxKDCFHjjxY+AMh5xBdwJ0pGfMWEO+XPkXN1VaKKjSJsJlYVLe++02QDCcM?=
 =?us-ascii?Q?lQm7hqnOasv/lEjjtQ8VW6goWyiad8gyk680gOavG4qRGtzIj7CIzq/0y3Hr?=
 =?us-ascii?Q?XWA18aYW24VvhzZF6UKCtOjKErRWXkpwpiHCCwh/fann6t8Km7pjPyWeujIR?=
 =?us-ascii?Q?CEye4CduvhNwXjFi8L0BTIh9fkHuypQoLuCi/kiTomDwpgCYkOPMQLS+16tI?=
 =?us-ascii?Q?4IFkKCtuU/PAUiaMmdxr0vdOZ+GRKJ12UWV6mFYwcn/8UYTCLYUv1cb8DMI0?=
 =?us-ascii?Q?e3f9H6EFLxN0a1tKfQDxZqdzHA/3O9mTLOUfU9R7jdr5mQAyIDXo2gKzdeE0?=
 =?us-ascii?Q?TaJagjPMpqrtm25U7c91CnnsDsw58s9FglSLOAISqx44kI+rUHmVUBXO81pK?=
 =?us-ascii?Q?Yx2aJTEEQ2JdwH3H9O6JBqcmAwV0kIL7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:11:54.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893b2c65-58a3-42e0-5677-08dd13d6bb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090

For the scheduler to use and prefer AMD preferred core rankings set
SD_ASYM_PACKING for x86_die_flags().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Fix c23 compatibility issue reported by LKP
---
 arch/x86/kernel/smpboot.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135b..6a38cf3feb1a9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -62,6 +62,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
 
+#include <acpi/cppc_acpi.h>
+
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
 #include <asm/desc.h>
@@ -501,6 +503,15 @@ static int x86_die_flags(void)
 	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
 		return x86_sched_itmt_flags();
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		bool prefcore = false;
+
+		amd_detect_prefcore(&prefcore);
+		if (prefcore)
+			return x86_sched_itmt_flags();
+	}
+
 	return 0;
 }
 

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.43.0


