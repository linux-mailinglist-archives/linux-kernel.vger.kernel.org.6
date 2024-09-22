Return-Path: <linux-kernel+bounces-335029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA08497E00C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 05:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131531C20A10
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554B193081;
	Sun, 22 Sep 2024 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6qAVGyk"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC5374F6;
	Sun, 22 Sep 2024 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726976234; cv=fail; b=b4pclB8/xQyWNaKedB9SMRp2dXIip0PZuDuEX4+x52ztm0BKIcxUv5p7w77CoYA3sZBU3BqVhvn8WeA41v7+j0a/qvOCVgeiWgP9RVCjaH/POPe7bXhG4lLykXoyiDkxBdvQbpQZbxqGn6k9wPP5dkvsyBJs9fkcnU6+VEqa9OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726976234; c=relaxed/simple;
	bh=1DD6H8XyIqwlquiqQxctm8E4XKoS8E2bHPQ5/5Jrl0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bTkhxyiCxSJVo4vVIqXJ7qjMIm3BPZE0HThvHpFvto9NiG+D7HTADXzJnFVDcS71u49aibE4CY2zBWr4DPq+t4mjhILMFE8hRBsC8oOFNQXTK/SsoUL/ASiaTuiPtfrRkKtE6lh1YlWimkstd14O67Wv33nKv4qc4aKMTFi49/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6qAVGyk; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKxhgWvPdRSqt/jVudQ9g2nesTl5ME8QDVuGtMiPRNtf+8lAYtNUWErVOIbTUbqPm1SdNdZAI0EBN9Wi2btohbQ4OXS9+xL/MUIxJdBTsgv8nhLFXR+Ng4GF40lMqcYFaA6vKQ1X/Y0zYbfKO1Vx3wAi9jhGKjg6SKiuPbvKtDkGCE0TnaHpwt/O6jfGP8Xm4vhyi1owfAp0NyTmxth4xv4xECitZChDL09YH+96eRkWczrVf2yuEIIYOfirI6ZwGHsdaDCoAeDUvtLvIBJimNTVXTTbcVGGC7Ikcj57WROic88N9cr9HzFglaUMsxMxRhcxGICca65JKvJQ3sJWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBTW+d5lXKisMgIjBC0BnjYwLfzg7OdFb0jLn38yHsE=;
 b=esnv+CEvR/tJA8yQxHGfYEn2OetPmnMlUaBj9QY/YGCifnsGB3OC4WZc6ubdydvf5lxsK0xYYFQhesariki3bnsQbMFIWGDWYtEbuCnD2Qg511lRGp6jiQuGAGTO64348UnUZNihmDZA/fB9WlullOzN/3QTjCmYrpMEI13BxoQCO0Cu6pu6ivg/oluD70AIffPLzR2B0U7TCl6ArOdyQY8iH8LQi2GbaT0IPqkMxr1laQ6BO7yNIEW36s2ewcD7mn1fcWXsCXi7kKaH9+HosJt2xV8eoD5Pj2g6k1YDMyS/ed0QVAoHEJa6xlPQtpjg8C/SF7oUVGk+zRqn52GxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBTW+d5lXKisMgIjBC0BnjYwLfzg7OdFb0jLn38yHsE=;
 b=B6qAVGykofpPiTaDj7eQX22Wq8aqrplCLKqJX5rAshu4H4/X+/megWDEtp/e+NGi75SHFSko/ehU/eEJAlxheE+4ZdnOiqryEGjnZtJQ2W3gJoeE2Ck8vzZKg4dR4x+rIZFsCIgoyfODYN1C11ub3DjRtx9RDcrPz0aE4KKZpzM=
Received: from CY5PR22CA0037.namprd22.prod.outlook.com (2603:10b6:930:1d::7)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 03:37:07 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::22) by CY5PR22CA0037.outlook.office365.com
 (2603:10b6:930:1d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Sun, 22 Sep 2024 03:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 22 Sep 2024 03:37:07 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 21 Sep
 2024 22:36:34 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v4 0/2] nosnp sev command line support
Date: Sat, 21 Sep 2024 22:36:24 -0500
Message-ID: <20240922033626.29038-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5063f3-3bcb-46bb-e0bd-08dcdab7d566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTLicgLOwLnjI6ALVH0MUD641C+jEy6FFehkEw1jwtb9auKONuHe9T9Rr9QE?=
 =?us-ascii?Q?SBH/LAVqEgELfMM/GnthjPBUFlIRxvKYN1dWyxugwJvxVYB80SQSiIF+VL7d?=
 =?us-ascii?Q?mM01iMgjzWHxuoe3rSV9EsmWtqE0A4AIaodmQ/uvDcRqqShmHh1BeAy6cm/N?=
 =?us-ascii?Q?I635cyQSwriqsfgY9JoJmQgTijNmZxwZNEyMS781UTmHh2Ksoz2iDVoIrqjd?=
 =?us-ascii?Q?X/QfTdotnS1G+0ucmwia2UuHG9tIT/ZHAaQPol/eJcFRZpKC80z2X1KOE3KM?=
 =?us-ascii?Q?ZB7xvoiiI097ShWuaJqJfArvXwJ4taP2DbLq5rWZ7hkyTiqcrgZigZNRRDeT?=
 =?us-ascii?Q?kd+Fk9i0HuuptiOnPIYnjINCbSKsmajf4ldvdHR6QY7jZDDFfq6uekcO4ukJ?=
 =?us-ascii?Q?vBcdmfUP/oolKz/HxKFdfN1h4BUUsDcPYNMAqoHWQjgm645WGPIehHiDORDT?=
 =?us-ascii?Q?d7Yd42Iv1UOqKv17t4t4nAeDWddgx9UsWGDtq7i6m/OsMPo7/4HHAqIsObIg?=
 =?us-ascii?Q?26K8TWHc/r9onhIswHhfpQVF4Oo6ffQAq4UPDs0hQZ8taTE5myrTbAtunIW+?=
 =?us-ascii?Q?+TxqtnfjWZo6nEG6H7X09zY2HgTS6ebZgzioIaTxhmK7HhrlcoXpcZieX7a1?=
 =?us-ascii?Q?i/iXGqpmvNgQFVOT5GDskFmKUMveMoNpSbaEU+Ahxm72VisiyjC4I3uLRlFE?=
 =?us-ascii?Q?z5/NsiNpMEyA8qwJv8TGJn8/t8uDAp1t1BXe0S+FYez/zWh1xLXzoP1YYxlc?=
 =?us-ascii?Q?utHoD5QEN2cxbQSivNypyhqFeEAnxkk6akphYK9zhLhP12pDPFtB8ryjqA7j?=
 =?us-ascii?Q?G3qKT7uchXYs1eH7U4R7zBfHI7VM4hzS1rudXKIar/BBwSu9Gtr2lRiNTgis?=
 =?us-ascii?Q?hIUxTiDNRPNKStXPih1hmUFnTG/AWUjbGx+tO1p96i+SbfAzhPVprFkXoW8c?=
 =?us-ascii?Q?faI2apnpJehYbQDCeYY+C8dwYf+aX4ANGWOlZugkjesfkPz3MVWbOulCamUu?=
 =?us-ascii?Q?ky6bVQeJm38liBZxloK7n9KWrJNmq1x8ItjAdDlLmCvzZcNi+LzBEq4oMwWB?=
 =?us-ascii?Q?vCdibjPv8mJr169CJH9MwW3Pox0orkyE1JiEhGEEqwcFlDoJIc+N+vlCBzLF?=
 =?us-ascii?Q?0jpYG0SnXEeKt3XCDb1JWe9910zIRFFKfk4cDw7ACt7UJ/nhKDEvnwPgLLpm?=
 =?us-ascii?Q?Er4FnjSXdn2jqqPBxynw5FReV+CdpRdtw+SvelegxA156ea5Pb0qt2snefUh?=
 =?us-ascii?Q?lOmdRPYAg7FngDPzCCARr0aYCGLeybl2Bglz5GuWqbTv9g0Gia6e12XcwCDj?=
 =?us-ascii?Q?yDGRd0HSJ4BJ892bY3V/4DZ7tLxjmapGNVeOHU0DEN/no285u7iBI2PKfMtc?=
 =?us-ascii?Q?dGNZujEUmtwTN5ztAryuKUfre+cXTYafJNKv6hba9Nd2IaZupawhPF5HiXsZ?=
 =?us-ascii?Q?zOe+YCKwGYVdtYZt7URTgHnzfWZMKRtE47PNWZuLXShBNqr34B6y2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 03:37:07.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5063f3-3bcb-46bb-e0bd-08dcdab7d566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SEV-SNP[1] capable host kernel from enabling SEV-SNP and
initializing Reverse Map Table (RMP) [1].

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

This patchset is based on tip/master.

Reference:
[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Changelog:
v3->v4:
  * Remove an irrelevant header (Boris)
  * Rebase on latest tip/master
 
v2->v3:
  * Fix the build warning reported by kernel test robot
  * https://lore.kernel.org/all/20240905143056.48216-1-papaluri@amd.com/

v1->v2:
  * Pick R-b's from Tom.
  * Include only those headers that provide the necessary definitions (Boris)
  * Provide appropriate references to SEV, SNP and RMP (Matthew)
  * https://lore.kernel.org/all/20240903003511.1530454-1-papaluri@amd.com/

Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  3 ++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 29 ++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 39 ++++++++++++++++
 5 files changed, 72 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: 6d3e8e28e20d250d2f3ebb3f5afb63848a2aebf9
-- 
2.34.1


