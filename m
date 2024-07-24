Return-Path: <linux-kernel+bounces-260695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAF93AD17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1829E2837AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133913A87C;
	Wed, 24 Jul 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XlTiWPer"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7B139D05
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805221; cv=fail; b=J0q/PQG/l9EiSHsvr88HAYii+UMfPfYMG1ZXl+bpbR+pPIp9Knjtv97C17wjwjKFIyqRZ5x8jYppTk1RzkRBHxNxb47GwQIqioeBKTX6Z5AoDQv+8bBYGHufJAAEJYHrLr9sEu51N2YqruY62WA0sd8tllrtzFNlMcGnpz+FPaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805221; c=relaxed/simple;
	bh=0RBCCl04/+gweLMM7PYIlTnnbmG/eM+N36LRv0drvM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhXeFYmTOP75BSYqqNe1iOpl3EYj1ufN5QAXJH4xZRrABfm30e3d1JlAxHBkK6JNLTpPIIBi3IQ/+TXLt/4WNhhr7kyAnrRSwExs3mCovnTZ03YnwSiIBo5F03ozWC/99WW3+jTD36+7sfP0TiUU3gpzXq2bt+8NOiVZYzaBQ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XlTiWPer; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1vAd1T3JIBhIRt+Nn46p6UwXhId4HyFmcjjP+PXcLhomddjRStVzwgUUIkg0wd7yQd4QMCUROXkFaS+tJXXUqW38AglqsCGfsVMoFzQa5NhKU4F1afKmGbtcYk+xf6KCRPqPiF+0Nh0vXyDK/0nWXhnvCI+HadAYYz4R9aMLxgS2hbgXPlNkZu+7ZocU4sDFRqovVtCbxJ9iSccuUfd3Nk+37Wsk/8goT5H3xQP8CDh/As1E3+lXGkimB48C8H2Sf5WoMhuPs3EWTzktSD+XDp5sXMFOI91Ed5vxeyQ28HWMG1QZueLYy2mdyiXO2vRZ6+EyBwzJPscKjzhZl0eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNndY+4j2BOeK7DkDZeVG2tG+e3ohDOcTGYuJJuDwLY=;
 b=HYrWBnXBXzDxXsBnbnzAPG7L2ODSQ3mXiqcr6p7qHU8a+yJ0v8gZWvrDfnNG26wU/+wZ2+twIO4xOQ/kDk9SELanS0kSICpqNOLk8cpshTMlaKLkQ4hB9gitmUwB9CABeCIPDkxWbIGVlE73Z/6O+kwoCZVnKm3I0EB9L2yNEoiwyTRpK+zxmDQ2lxWJ+v1LDkbaWlauwjgPj8mbBzx74m7milkkAnrHKLmix2rIIjrNIWTe4vPbu86dx6NG+IXgycQTauV6EwaEvDhJguDrR/4WiFyjdzq5yKGd7iD0W0wN3V/mF9ub20YS3wqNdBETj1TerTFJmDcbCbtdaBeWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNndY+4j2BOeK7DkDZeVG2tG+e3ohDOcTGYuJJuDwLY=;
 b=XlTiWPerwNgehjl2tep/rFRq2t3b2vN3YvzQ03FhyF5AKQlkaFH2jtJLarEtL1f8SY+F7ASfNdZQ6vmGmpgOQpusbvS84Mk5na8Vc2SQ4AWMIeGELsyvSrKfl0hlq6zhqv+VngM8pZa/jT6w7n1ASM2FNWYjAu7QejOq5N9FrOM=
Received: from BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) by
 IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 07:13:35 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::15) by BYAPR01CA0071.outlook.office365.com
 (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 24 Jul 2024 07:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 07:13:35 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 02:13:31 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 5/5] i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold
Date: Wed, 24 Jul 2024 12:42:45 +0530
Message-ID: <20240724071245.3833404-6-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d07a187-95d6-4136-1ea8-08dcabb021ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRUQfKaJMZo3X85JtlNMqLUQ8Ha9ijoJi+2yZYFDZFsrlXK7xlCuYc/4YXRp?=
 =?us-ascii?Q?kGQi6kGYR31+MAR6KC+IVCx1d9cUV51UvCn4MVLOj8dvwYaOADG3sWebrm/X?=
 =?us-ascii?Q?dQAS1CdCyAVb6OJwZdECFDDuVjZ8e0U0yg0YDq5LzjRHwA/4qJ+W6N030sUf?=
 =?us-ascii?Q?TZpMqPfmPvVDowkpmpS4VzI/zp9NdqlgMUg1Y8MbagfDgjMuveGrJX5YzSrD?=
 =?us-ascii?Q?jX9vVl9NrCjkfhsZGceyAI2fG2TObEZj6VF50h8D8MIxaFvtbxced8AGLkF1?=
 =?us-ascii?Q?TUSPxJgzqLdzBdZcbNCMkPXOoWz7apXqr11JNsQvyXn6IQ4Z24t+qWTLZzGW?=
 =?us-ascii?Q?OkfJ+FBdmQsOVWdTq9rBIW0NTHeTEP3bQUg/pvnaLu1dUef2Kk2Jt8GNE2iF?=
 =?us-ascii?Q?oq6NATmkWZSHQFrZu6h4e58syYbrrnBQ5TUDgLSg2TcVpVwSlvsKVzwzF9cj?=
 =?us-ascii?Q?KJLEq2eNU6lvwckT+IUPfbs3dmAVsDIQofP+K8ogwFsQc7gt8YkmiX4QPBhw?=
 =?us-ascii?Q?I8msSWeB0yeDEZikAPkc3qkRwuk97ACPy0N+3k7zNkyLktV5MA2/sXOgX5u7?=
 =?us-ascii?Q?5l4kGVKuc0E6Wg1FJjg6TFUjEljhrMMiGUkTDtq4lYQBFK2jaZCbbE6PUzy+?=
 =?us-ascii?Q?3UD8ek6XDMfQNnXa9bSK6WbawbBgOfN3a8SdqOfo61g5qlv9JVLDj9jcLh4J?=
 =?us-ascii?Q?WJ5sM2PvMawtA7JayfZNoI3aHSR1b16/dOfTpk582bxm/T244HGD9pn0gA/d?=
 =?us-ascii?Q?ngP6pwhL0xrVxt0Y0NvDrm2rRquz9O3aEY3QC804YhJRR8LWsC9DaejGHrs9?=
 =?us-ascii?Q?KrMF9CpYoFzQwInqKYOB4jyhAKuMJ2+Fa7llpZ6aDEWREffR1HBHyS+YsoXk?=
 =?us-ascii?Q?K9GOmH1eM6jShBvsITkzrD2oW/Dv2QmY6HMnidTRvE5GQ7E7RG3ThIc9uMZK?=
 =?us-ascii?Q?yVd85wzpWtvLHUXe7Z/ZYnocio5Jvil5GHktZSVQKMkrNfJ08TvmVnqA1+Rb?=
 =?us-ascii?Q?UknuK2OEHtNwI3GkuBAgxEH/M9PDZkXdLLRx3WElZTpuA6hisxE7+TwDihUX?=
 =?us-ascii?Q?+6+Hn/9NRw3X2gvidRz/KRRT99AtBDnc67l3a0byJ9Sc4UnNIVkJ0Rd9ULLE?=
 =?us-ascii?Q?tA1E4Iy9wGXdLzW/4KSac+2JYQ84W2ul3k3UivOEnTkv+dHcxHl+HaezXSmX?=
 =?us-ascii?Q?SE9y2EVaySM+OYWRpo32vpjDUR3nUuWnWgiwWXG6Hahk+lQ+rjGI0Ic0K8x+?=
 =?us-ascii?Q?4hl6KSOmnkEqXEWIDfvkxrAIYy2yL/sbw5eRptIvuK4Kp9crynp02Vz3AePL?=
 =?us-ascii?Q?P5LZRyPiEAn0Z/CPIfmZt66RAs3cu07eNYm0Nn0Q9OVrCOqk+6ENELOuQQ4P?=
 =?us-ascii?Q?2UW+j8OtY/M1qWd2EK1teOskoplUXIqQ91QepRux9UxjnA+Qm/nEtuHDX+JR?=
 =?us-ascii?Q?JxvVcnmY9lfqgrnqhMdSuiyvYrS2RoOc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:13:35.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d07a187-95d6-4136-1ea8-08dcabb021ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

The current driver sets the response buffer threshold value to 1
(N+1, 2 DWORDS) in the QUEUE THRESHOLD register. However, the AMD
I3C controller only generates interrupts when the response buffer
threshold value is set to 0 (1 DWORD).

Therefore, a quirk is added to set the response buffer threshold value
to 0.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c       |  4 ++++
 drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 ++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 12 ++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 3320e6331c86..eef5059177f1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -147,6 +147,10 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
+	/* Set RESP_BUF_THLD to 0(n) to get 1(n+1) response */
+	if (hci->quirks & HCI_QUIRK_AMD_RESP_BUF_THLD)
+		amd_set_resp_buf_thld(hci);
+
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE);
 	DBG("HC_CONTROL = %#x", reg_read(HC_CONTROL));
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 06a4d54a5a02..58c3643c6390 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -142,6 +142,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_AMD_PIO_MODE		BIT(2)  /* Set PIO mode for AMD platforms */
 #define HCI_QUIRK_AMD_OD_PP_TIMING	BIT(3)	/* Set OD and PP timings for AMD platforms */
+#define HCI_QUIRK_AMD_RESP_BUF_THLD	BIT(4)	/* Set resp buf thld to 0 for AMD platforms */
 
 
 /* global functions */
@@ -151,5 +152,6 @@ void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
 void amd_set_od_pp_timing(struct i3c_hci *hci);
+void amd_set_resp_buf_thld(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
index 6ce08f9c92a8..954cba95e4a4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -20,12 +20,15 @@
 #define AMD_SCL_I3C_OD_TIMING		0x00cf00cf
 #define AMD_SCL_I3C_PP_TIMING		0x00160016
 
+#define QUEUE_THLD_CTRL			0xD0
+
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
 {
 #if defined(CONFIG_X86)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		hci->quirks |= HCI_QUIRK_AMD_PIO_MODE;
 		hci->quirks |= HCI_QUIRK_AMD_OD_PP_TIMING;
+		hci->quirks |= HCI_QUIRK_AMD_RESP_BUF_THLD;
 	}
 #endif
 }
@@ -41,3 +44,12 @@ void amd_set_od_pp_timing(struct i3c_hci *hci)
 	data |= W0_MASK(18, 16);
 	reg_write(HCI_SDA_HOLD_SWITCH_DLY_TIMING, data);
 }
+
+void amd_set_resp_buf_thld(struct i3c_hci *hci)
+{
+	u32 data;
+
+	data = reg_read(QUEUE_THLD_CTRL);
+	data = data & ~W0_MASK(15, 8);
+	reg_write(QUEUE_THLD_CTRL, data);
+}
-- 
2.25.1


