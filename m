Return-Path: <linux-kernel+bounces-277312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B67949F24
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A8DB25602
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F05198825;
	Wed,  7 Aug 2024 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eCGpQ+iF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97161196DB1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008315; cv=fail; b=ayoOBnctORjq40tl8aIA5Pw1BBP3q+rJSd3Z5PC1wmCbaxMB+QnOZ17qSQjo2GKMi69J3JEcuTS9l7DPokJlPTLAQVsO5vijnIUDYAPEqsx9mwPFsjeGPkhEQ6KuCnxattVPCArMkwEmd9J1xpFZUv8S6MaVmZpf3rg8iNRX3s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008315; c=relaxed/simple;
	bh=yJYrbRuY7uYaP8uGrI3z51C7qEExmUkAjD5mZMqBJC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sk5WN8Ev6fXKr496pkqb+F6rm5KD3f1bJ2p0hHtsTA24S+xvix2WOilZYVdjGYc79gSFta6btb4e69amzu4q99f7b76W81LVQ8qe6SxcQiPchvsHcOfaJ7wjVOaQvt3ym9oxnb8ZfzKEZke3JEPHukNUkw3SKadbjnIWzyNEg5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eCGpQ+iF; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/qbNlPAtxFCPzkPkGyodwLPiXaXcdXM3K87BrdH+C4lpzjmBUNaD/kGqz5Lcaxf/RS93SQD4IOsz1ZjRuFlf4PDe2qCfALDbwU3Gm1BoXcpBT0mGmaqz2RC59tpPx5IYUNA4wGu4qNEfkMTi0yxX4H7NuEvAfkqVTjvCt7hDeMppZC1nOW56nwEYN3jII2yJu068MGmZMqUIt8BMkvox3463OXvUrkezyr49DvehbwJjEAAmerMgrrpmAGn8TGYAfJEfofpfxXDt+MTiyxEGpLRjbQWlnY5WYjaxCujaI+q4aO5MJSPW41Jz5HDz4kLDJIHQVCv3qI5dKFy9eEP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeIRMTuLuC8RbvDwNej5F/2tVh3imeBbCgroiZesH9c=;
 b=ck6BuHg4CDLLQGBb1rDD3Y+xslWDF7O61cihrFKU4niEJojjCK3IQZrXa/WLqqtn7CHrYeyC6iLXjzZKcSATV4Scbta/SbjmGNv8/HtsUZyoXuC9zOuFm1/N5YQUv7MHJcvXx+aSKL9yj1EVpBhJMHRp+klsreid5F94YHYsPxDVvjXQ/zkZu4L9ZHwkDWYmR4K1zuXjIRQi0tktTZEIgUNQ7qrNLqVli35lfsm+4z45txX191dvIsN50MOxHwnbsunt1Um76KbKYsae4DP01TTswXGMGkNuDk4SF4Sbt9FdgHhpxqb5+DH0Y9D+ZrtxBrf+vemo36cXP8ApRsUKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeIRMTuLuC8RbvDwNej5F/2tVh3imeBbCgroiZesH9c=;
 b=eCGpQ+iF7KE/eTM35H/ADeJVyZknrdQlTA3EfyMz2f3G3r6kvFJII5TpQDUrEIbsfKwOeMpY1ElgHprMgLLUBMzP6VckHCX49wYmPNemF9SqKRRGs4Hl76OtCb7JU7/3PzE8gzzmnwz0Z2wMWRC2IzWc2/tNWyczO74EvHvGAPg=
Received: from CH0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:b0::20)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 05:25:10 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::5d) by CH0PR03CA0015.outlook.office365.com
 (2603:10b6:610:b0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 05:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 05:25:09 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 00:25:06 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH RESEND v3 6/6] i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold
Date: Wed, 7 Aug 2024 10:53:59 +0530
Message-ID: <20240807052359.290046-7-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 855716cf-a11f-4a87-c505-08dcb6a14e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9OdX/dFHSXMkTe2tShHlRXAhWv8PkZOHsZBIDt3MSSOVbk74lql4NfN/pTsA?=
 =?us-ascii?Q?RBeCoNRIkDKAUd7KR2QDHyuovk38gWDotrHi/EWJWDwpOndUoDgYvC6vs+AT?=
 =?us-ascii?Q?HGQA/1p48Jjexz3jqGLrIpfRWUSJO9QFNCXyDvHzxIyEr8YVprw1f9YId2yz?=
 =?us-ascii?Q?LvmkVgMPDIV5CBrGv+7E3r4bFUu2el6DIFpDKMBo91t8wB1GBbIc/rc/aedV?=
 =?us-ascii?Q?FJb2Ov4os143K2lG1C8ClGcwgQnHWidXJVZj4PU9HQ58Y0x7Zol8ZfDSMQCR?=
 =?us-ascii?Q?HRdLElBME++ye8Fuu51TgcG2Q7Z8XMNKPvpGat6ShUt4oDN//OlHxrTnARg3?=
 =?us-ascii?Q?NZrmEjet/AsQ1x8jbTYhVYy9VlDOpT3w5++AjkEnlJrTRIu4MkTkypMp8PdX?=
 =?us-ascii?Q?A+6q3WYjkZAn0kVIfT/V0W2rI7h08o/4i+Lqj24qO30SuhaIX6P9YuD4V6gQ?=
 =?us-ascii?Q?I8xCh22X7a3pKpHRbMMohjwA6P6Vjw893AXez7TmFfSuo247Sf/542Q+LWU4?=
 =?us-ascii?Q?AZQOtPbOqDxnHQqJWAUK2piP73kjehaVQmbPVnF9/PYyzT8Ii2W4+wrcavjL?=
 =?us-ascii?Q?iV9lMnKxqJlqA0QiRgXD/5A9abj4tZD4kXEsgkLOY8gasJIzm60UAs50dTph?=
 =?us-ascii?Q?b80iySJdUEa7+lkyH9csGFCUNPEhVRPk0WGOYaE+/DBarIzsHYThAQ6hEUYC?=
 =?us-ascii?Q?JEfT3UIO5Ez5JmZUZSBCDybRhZsZTIa5r8IrrH2Zjo9SN/n6KyieQVFj8gjJ?=
 =?us-ascii?Q?/tKGyT6yZt+qm3xPvjoRyX1VkkEvBr948aNNbxoRg4/+e9bzaYGgF5wrGN9i?=
 =?us-ascii?Q?/s7LDSZbrLby0toN+MrVGVgegtu7Bg7oiCt1cHpEgRsOCOVVj5LVLwu32xuj?=
 =?us-ascii?Q?x6P93gW2V0oL54qnIrq8EbaOMTSF7uJajAUTub04xGMfU9G2kXRwi9MgQa7l?=
 =?us-ascii?Q?pqUs+WpvD7JO+Z3MDBDraUuWknaJSgtH4A2e5shb3LdRfR2Wt4SWqPu3YfbI?=
 =?us-ascii?Q?W2XTcotajhAJIPHL074wUOVwP03Yy3eJhVTLZlZy0oZRcmZvf7niW1pXB4uX?=
 =?us-ascii?Q?hNgfwAqZh5awpa300RJ29WIFHQaEzTgZ7CJvqRUAnuHmNmFhXZmWXTle5ajZ?=
 =?us-ascii?Q?colhNxoSo4YekK+UGOji04C17w5qNaGYNhgIyILyEUbBYi1RjnVHYAK/+DR3?=
 =?us-ascii?Q?IzzfRR3oMTry4ggUlCRG9UbU/kuD+xNlfvKkVxRSfUHvZzqkHOQbzeo6w7DX?=
 =?us-ascii?Q?0d197V27z88cR7UBKUTlFCUBrInYPlrSfIYjEzMzBB92Nzl9bovnN9AorUUU?=
 =?us-ascii?Q?NlCgzlmaegqVRuFhqP5VcACe+ElrxSC9ZpDNBAZI8XKa8ZBNiYVBctvQllOm?=
 =?us-ascii?Q?crHrxyjchmBAT8nGPfS/S+jzPOeiAJ8lNJLcNrzp6lbey5g+o+Bq9xnZpU3g?=
 =?us-ascii?Q?dB8UFqjTZpk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:25:09.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855716cf-a11f-4a87-c505-08dcb6a14e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

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
index 23cfdf0059ae..00c085a1187f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -147,6 +147,10 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
+	/* Set RESP_BUF_THLD to 0(n) to get 1(n+1) response */
+	if (hci->quirks & HCI_QUIRK_RESP_BUF_THLD)
+		amd_set_resp_buf_thld(hci);
+
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE);
 	DBG("HC_CONTROL = %#x", reg_read(HC_CONTROL));
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 5a3b4a014d62..6bda266516a1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -142,6 +142,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
 #define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
+#define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
 
 
 /* global functions */
@@ -150,5 +151,6 @@ void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
 void amd_set_od_pp_timing(struct i3c_hci *hci);
+void amd_set_resp_buf_thld(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
index 6530b9b6128f..f906e6476abd 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
@@ -20,12 +20,15 @@
 #define AMD_SCL_I3C_OD_TIMING          0x00cf00cf
 #define AMD_SCL_I3C_PP_TIMING          0x00160016
 
+#define QUEUE_THLD_CTRL		0xD0
+
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
 {
 #if defined(CONFIG_X86)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		hci->quirks |= HCI_QUIRK_PIO_MODE;
 		hci->quirks |= HCI_QUIRK_OD_PP_TIMING;
+		hci->quirks |= HCI_QUIRK_RESP_BUF_THLD;
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


