Return-Path: <linux-kernel+bounces-275834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D269948AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089301F24CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8601BC9E8;
	Tue,  6 Aug 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BNZTqeVs"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F291BDA93
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931167; cv=fail; b=JRuukzXnXK/bN7egcFD9a6GstY08lwmP+5cqRjtMmYnsEoOWVBinuW9H9t+a+NH/cyGPYp5TrFRkWsOqyLA7BLTxuZrURyJP37LG78MQhKv6LhxDv4RmPhA/UxbaWPEPq3qMP2jSkqknLBt0se44Qvx0RVGh74lMqR+r9ypXwiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931167; c=relaxed/simple;
	bh=xcDCWcMfpXkk9wQkD0vwkTGIINqPkF31a1KH8yeZMRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVt8ucr8Yb71/1H59u35XkJJzM8OZgBx7S25jnysPAQYTyD2z6pgrtVklqKg0ogoDLHt2kER0vR6WsaGDdPYIBqJTPq7Ek46N7JJBi9mbmWFm+yqKiTspuJtpau6HZQTtn3q451dq7SlYGzelKtHEenyA0UxWI3Dw7b9BL+txPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BNZTqeVs; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDRDjECauwaVln+sMuYrtyy+w3Cqro5Mp2VvAhADFGPbZcmgxCtgl+EQugxSxCmwpevZldBQcpONYsRU+22ZdyGWf3MTeu+O8ZSx6WQhkiGP2ps3HLVuVmb7sUGZkb9QHyYw0anEjPiKEV9okj5mkSM0Z+oibt9qUOSjIr7BtW2bvQIwDHXORTw7Ld0Y8JznZdW56lfJA4LjQC+K7hvSXSbhgs2mW3vrs4b02Qh9TVS77jCCJ1ILEKEs15nz9zDah0zVucXJWQ3xO3ippSP5eU6xvIy946Zzli9yCyaDneF6AxqXLFfQrN7pl3lw4ii6kzRhrzpT2Yw8dxxNalC8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+MpG3FQ6f6K1sK65Q3xCvKHWgQD8wi90mDlKI+icwk=;
 b=QqGe201aqsan39XNJMxNIbNaRvFnwPVf/O0qsK3KCIQDGj9InsvRxZa9Q4GNghCsqo7EhVMXZeggpVzbZ73bW9ri0YXnNhSwvQdKvYG6i+nVFsLBv1T9OwZ2i3qVNR+wbuTwXQaaxGJruL+uAECFh3chQvBf6UZSXFt8PXJADSS1QEdomS48qHNntZdFNO0ibh36AXfv/y4Xk78YpVIZSc7h38UzDXkpOSrGqxTZpkL6n2BWM9/yKZgXWVImrt3AgTCoGKo6FDqsXXpQuyfbSVhqM78vbwC5T9CGTxdGNrHV+m2wm6FiFKjGIQM9Rxtrgz/4RRvV7xwh0iPqOWTpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+MpG3FQ6f6K1sK65Q3xCvKHWgQD8wi90mDlKI+icwk=;
 b=BNZTqeVsMNRrYqsumjenkxQ7q64aobJwTTGgC7B/eHS0m7TZt9dibyXVIEcY3g/jiCDYtxtucYp3th+un0n0gT2TaTELa6GAouXJ3vP3VtuS6u7C9HibG5zm7nCRvTKIIGfJrqJxUrWkx4AHBIS/x6D/6u1tOSsNkto9dagipqI=
Received: from PH7PR03CA0001.namprd03.prod.outlook.com (2603:10b6:510:339::26)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 07:59:20 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:339::4) by PH7PR03CA0001.outlook.office365.com
 (2603:10b6:510:339::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 07:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 07:59:20 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 02:59:15 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 5/5] i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold
Date: Tue, 6 Aug 2024 13:28:43 +0530
Message-ID: <20240806075843.277969-6-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
References: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b494f7-04d8-46ce-cc11-08dcb5edad8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kiaUt6MqE7x6OHy2j8tEYASPE5SjMzbVFxI9XmFD1TzX/XiLMCOMA3VsuPf4?=
 =?us-ascii?Q?ZkfNgjFz81qJVDegMvTX1K7n9fD7gw5IM9rlf6NSSSZIPpe8sAY1mdBfP8Z5?=
 =?us-ascii?Q?Gxil+9/hMAKykHxLT+6dLipXSVs6Cu7aXCPXFdA1Qq+f5VJEPX+GV1BOFL4c?=
 =?us-ascii?Q?cgBHz3nwWGgN9Co/F7DzhLFA0P8wqxxdZcRaCbQDtK+5W8TLsK1uPQ2Lq82F?=
 =?us-ascii?Q?cvmOWHGtxh5OwwYDTIdJnrn03kw4YGywVmQqZwyn28tyyyAjrjpT0r/9mOg3?=
 =?us-ascii?Q?KTSsf+Ghv3wMfF7ZuutxjhETuvcuy4LGLWg7YPV9hbbWRwp5Mm2LqYldW5RC?=
 =?us-ascii?Q?VkvX0glJCT0fVuUxhZf7P2Px/308AsLBpC7eM5ZaotwiWqrOzk4Yhv0GYzzQ?=
 =?us-ascii?Q?lQtJg02HZyNnvjdwTEaoHneXQXjNrDAprXwmQf4ckKTcL2Q7CjDyoVdMGUxD?=
 =?us-ascii?Q?i5ZaUhm/+ldLtwabSte29Bbut6H8ptyd/rUUvaHUegRQJRwWYze3/DfTL+JR?=
 =?us-ascii?Q?VrdhmFbEVpc2aG2LCYwdQtxCUPysYYCfpcT2IQKX3iZFV5gFRSWp5DfmFSvx?=
 =?us-ascii?Q?IF4N6LXzcQ8qGFNHiyrjdGGxl2xjZVAq7Lwxkl+UeAJQP6H8gy2+Ku8s1h4P?=
 =?us-ascii?Q?A0umtE5XlUu1YE3DY2Zj5EXNHR0ux4KTcoeOgd5K25dAIvquvvopYeWKLCbw?=
 =?us-ascii?Q?3Ntc1AJ2cd6hp4i4I1iutahBHyXNYZkyMFJ8Bu9rYyOO4+zdwft9DvJF7lR+?=
 =?us-ascii?Q?FTwzCzwolFo5Rr0PZHDOIGKIOQPxsQbwZmQ0Pjwdj2nQu9jhgoreqUrwB8Zb?=
 =?us-ascii?Q?qHUBw2sUQvmIWa9VLetgZ9983pw0HXsKzChQXUgZng/sZJULKmH9FdNeMZ11?=
 =?us-ascii?Q?QA7xZ7fKNNxUH9cchhkhecWvR7xtfN6ejgfcXpkgLGv9VTm3GFxAPLURIauH?=
 =?us-ascii?Q?Xm2DEDD8Dw/zdNVg2UNvR91Zw1uJ3ezNjpOV+XpgiyE8USzjYvb9tYpspJMO?=
 =?us-ascii?Q?n4S1wK8SejRSFiz75clRYi1B3YeGhwxNeJ9jyUicCwnMeah6gbIVWojLR9Qw?=
 =?us-ascii?Q?NamqL4CBPDtXjNyodxh4hTpl959beZy6m4QXZTbf98jBy0BFqNP03w0yDSlI?=
 =?us-ascii?Q?D/zKpceoNZTUEwszsYtIbsjwx/Kc1VT4hzPijyK8NtFJ+R0BqlUmCljxMzmR?=
 =?us-ascii?Q?OWuy8q2dn9jfuZJ7ZBozRegzKprIy/iD69yCXSd5TpKTyYb1sExsGiEXjoP7?=
 =?us-ascii?Q?N8Ad/IuV0OXfm/cOxYVKK8tbjbckuYa8wZbkQr2P3TcaahpLSY/MYFTOLf+V?=
 =?us-ascii?Q?KYNOMm2G/fUM5lxjBA8bK23wzWSMPQJ9tBh7NvLHeTX5TqnpzchnsvTfN6Np?=
 =?us-ascii?Q?rPJIKtwcMkd5ebfQB2g0tjyzx1O6Egs8lv6KUaoRKohtHjpPGBczDi9Jo3z5?=
 =?us-ascii?Q?FmVqWNAQk00KH26jGRkv2uOwq8AojIJF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:59:20.2483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b494f7-04d8-46ce-cc11-08dcb5edad8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053

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
index baec2c42e0e0..248f07f41c16 100644
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
index e1a65cfb43c8..b6f1b97f9e04 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -142,6 +142,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
 #define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
 #define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
+#define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
 
 
 /* global functions */
@@ -151,5 +152,6 @@ void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 
 void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
 void amd_set_od_pp_timing(struct i3c_hci *hci);
+void amd_set_resp_buf_thld(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
index a222bfab0676..43210882ec4d 100644
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


