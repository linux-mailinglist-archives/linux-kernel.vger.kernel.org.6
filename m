Return-Path: <linux-kernel+bounces-435704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30159E7B48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1CD281584
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DAD1F9EA9;
	Fri,  6 Dec 2024 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mH021Qtf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17019ABC6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522423; cv=fail; b=E6YJiWgfh/uoWXMMUVSw//nXFWi5yd710QYV4SkavwhihboWcBMT6kvsasE2qeUlJjzPX3rTcwziYisiWQSEKHVSDGPhQe+yPDzDb4rsZx7M/X0Wvd3BtW3UsEXkHf51cbyw3hH1mpFwmHnueX3V/AwR8lXH941wnnfILpCBQYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522423; c=relaxed/simple;
	bh=z9VIZAsHjqc7KT34zGNxCVdaJzhvnQU4Ek8G1q3KYGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIBtj/LPSIZHSsTvwD061z6Wobz1QdYg8KY6d/GAvbAgv25Dnk99ZI3IijwYI9yLBx3NcB4uatTK6Sw5ZiQNfXq8CKNCI5w8poJQBdOyekQHJOcTEKX/xIqO9KtTKCB/pDFBGnM+QN/8i03pnbQDuZC51Y5myc/sgdNcTEvKVnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mH021Qtf; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SraUCSWqhbPft1MwhmjEa6kJRMntkAvAE6HeBuBnqXzScBF8Jw1o3qLRFPIp3Skvt2XGl3d0GUP7YOyA5bfrHtlvGVEdkVCM72wjRwolVa6pa130DfFCmTJTihuWIt9ARtcHR1tlUT1eJUHPSrZ0t/1r811ayxFwvneYO6f1fYWqXhXMw+OSX6DW7XLz0qfgIvIYTrc+eF+VCR+TzPLENV7yk1rjoeTr7orZI4pl4b2FqOD7Vv5mDl5GjmrajCqqZJPKbwH0pwnwxqX/qyLDY+rYklhvAyJ6VIy4yX0ZGqZhIOmTfhifOJkF2DKieBxJ0e1BGdmKAg/h5C1bhNJXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMluGhjzrFDS0jkIdd2tPzSQRtUS5j8qGJSDnUAvrVc=;
 b=a6DKmpFkmxX+4Z8AUZlo0JXbUUjf79EWV8P4m2P1e0wdJ2+BVSJFzTxaa6tErOHXSZYcPGu9y3LE5eqOZOBXjsr023MYwMbgLQVCDI/rwysb51722RXMV75iacGLA79aKHspIPx3waX+b21OZDC9tEkdFLOMN6v78WC9N6b3mY2Lmw1gjb2juYPeDH2VmIOze8XPp+2/r4QIgpQzYre3S/0syFrAfhf9IFE5HaoiPOTcwWM0+belTMJabL1e377tm1XyJVjUQGTzJLqjis7b43VbkyPJT84o5jrhp7o56nHHz/KdQv3++GK2slWzGwyCbL+BKLh9ONqbxwIeEXxKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMluGhjzrFDS0jkIdd2tPzSQRtUS5j8qGJSDnUAvrVc=;
 b=mH021Qtfmen+NdcDtuzX6NsLPjO6Ns+2OnH9uqQ3SNeqrYj1jXIQ+8hNygfH6BKPpw5dOORXNBskb4riukqZpnQnltU78ZJ7Wa3HgXeOT0SN968IEHKMcnhwD3YcL5MHrtqnKr6ifMXUWvSx82sd123Y461xctK44y5J4wL3qsM=
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 22:00:15 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::83) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 22:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 22:00:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 16:00:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 16:00:14 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Dec 2024 16:00:13 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V2 1/8] accel/amdxdna: Add device status for aie2 devices
Date: Fri, 6 Dec 2024 13:59:54 -0800
Message-ID: <20241206220001.164049-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206220001.164049-1-lizhi.hou@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a28a1c9-216b-4142-a56a-08dd16415d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3vL+Slu5wt51E/aJ+kvM21ebVjrlcM5nb/lbjPEZDa+coKQVsB8xL17a9mQ4?=
 =?us-ascii?Q?aZo+O4YF3f6MsfLkgG/FMq1MYIdzgQDfAV0EyrCnX3XnpuiIga4kb3liNSBS?=
 =?us-ascii?Q?orPztFxiAi52oDdYXIxm2YXf8wSWjx2iDTgbLMfyV1T0DOVwgfN7aXvMSsnX?=
 =?us-ascii?Q?58RW+NS7lOCs+pRRKUajFELKrjoYNGnhzKI8p5Rkkii+3jg76OYc2xyY+33o?=
 =?us-ascii?Q?LbAGBdamrYCpud+1/bJpEOlvq6PT6lgpBUI22cbHPaW7gvr//CHr1lP2OGgN?=
 =?us-ascii?Q?Jzezbv+aTsKN+HkIkjocN5/UmnQE22j9xYoTsssAIH5thh/DQDLtkWrp5tk9?=
 =?us-ascii?Q?7XktZSwTFMp1aAy9dBby5cqW0/ue0T0TSZhgwST7HPIAgGO/TVy/xQ4KakMp?=
 =?us-ascii?Q?OYMHuL2XSpAYV3UTW3O8QUI/+OSN2spPwI01vdMo3K7V+OzU/e6czf9+1qG0?=
 =?us-ascii?Q?7M+8dShycuMcOmXKKl68nV+ceSKeyntINA55nmNIwkt9NXfCYlLTqpYHJW/H?=
 =?us-ascii?Q?n4e1sCUXF+GhcilIt3UwEoGxSHim0FrP+JwoafiWbRGCsZtua47+i04DSMbM?=
 =?us-ascii?Q?OTz8m/fLdm9vAQgjuigXlfPXQdeYnGx58cwqWWSFYc7gTfbxWPe5FrCNuvVL?=
 =?us-ascii?Q?oBr7Qqz8y//Iycllcgjk2DK19zA+B6ZmWhVT3urN4/k3YR/KR+tArCPUQXws?=
 =?us-ascii?Q?+jtRD5Q0CQqa9rD874Ph6oyQvErgx1wGJSYBvSdu/3G17I3b/CTX9lsqDlxc?=
 =?us-ascii?Q?KXVfJT03/y1tMiktku/5kQ6e4Ql6k/s19jP+Brfzin0/N02bQBhwj4v94Ow4?=
 =?us-ascii?Q?KJYPFEqCkAm0ZGzom8VugUmG5ShYt/ewiErWstsLSRHBi7FXOPtOkn6A4NXA?=
 =?us-ascii?Q?YCr3CDTWDwaX4KWXO2XJ894i4lHGDUWbjFzNiLrT+Jh00KKrmd+lAi6Gi2Wy?=
 =?us-ascii?Q?nnglMm9UDZWIEVofxOYEWSD//otJZojtXY9KOGfQY+beVEycyDP4fcWW1u8/?=
 =?us-ascii?Q?UlU64vpk6cbVL7u82Ld5PMY/WNaQWmIX0u2/tUZLqeT7fn+KULcGBBQDu8CG?=
 =?us-ascii?Q?xGSwTVPtiOHMIhqsSXIIqmIQ9TbDln5J3MfdzM7IE0n58NoweQMggOTeP5qk?=
 =?us-ascii?Q?biipjN9FNzAZGZy1fWAZJuybvE+T3QyonUKkKYOcB4sE+K2gOLRMwgKL0CyY?=
 =?us-ascii?Q?k4kiyr3rOSuXDi+Zjx+fztf/vqC1cVUHKmejOz6nFuP2iaV1TpOC32u912Xn?=
 =?us-ascii?Q?ONPUYmhamZjRrQ3kjc31Ovhz8e/uyuCD+aUIsUZ4N1QZPwwoopsCxlo3dPmw?=
 =?us-ascii?Q?Zz7Izki+q6VoaQyGTfGBMQIhhzLmZIyFINoZfs0tv0fE7RUBgNRTmGxY/eGq?=
 =?us-ascii?Q?FSjmfX49M6wiiwdXgx+YuhRKsYEaHfgu2fTuEkA4h25//6JlIecFoYrFwbtg?=
 =?us-ascii?Q?xjRLxZImO36z2UL/AKDwGF+sFKG8GwQ/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:00:15.3255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a28a1c9-216b-4142-a56a-08dd16415d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

Add device status to track if aie2_hw_start() or aie2_hw_stop() is
re-entered. In aie2_hw_stop(), call drmm_kfree to free mbox.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        | 17 +++++++++++++++++
 drivers/accel/amdxdna/aie2_pci.h        |  7 +++++++
 drivers/accel/amdxdna/amdxdna_mailbox.c |  6 ------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 349ada697e48..19c76b2b204b 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -267,12 +267,22 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
 	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 
+	if (ndev->dev_status <= AIE2_DEV_INIT) {
+		XDNA_ERR(xdna, "device is already stopped");
+		return;
+	}
+
 	aie2_mgmt_fw_fini(ndev);
 	xdna_mailbox_stop_channel(ndev->mgmt_chann);
 	xdna_mailbox_destroy_channel(ndev->mgmt_chann);
+	ndev->mgmt_chann = NULL;
+	drmm_kfree(&xdna->ddev, ndev->mbox);
+	ndev->mbox = NULL;
 	aie2_psp_stop(ndev->psp_hdl);
 	aie2_smu_fini(ndev);
 	pci_disable_device(pdev);
+
+	ndev->dev_status = AIE2_DEV_INIT;
 }
 
 static int aie2_hw_start(struct amdxdna_dev *xdna)
@@ -283,6 +293,11 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 	u32 xdna_mailbox_intr_reg;
 	int mgmt_mb_irq, ret;
 
+	if (ndev->dev_status >= AIE2_DEV_START) {
+		XDNA_INFO(xdna, "device is already started");
+		return 0;
+	}
+
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		XDNA_ERR(xdna, "failed to enable device, ret %d", ret);
@@ -345,6 +360,8 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 		goto destroy_mgmt_chann;
 	}
 
+	ndev->dev_status = AIE2_DEV_START;
+
 	return 0;
 
 destroy_mgmt_chann:
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 6a2686255c9c..1c6f07d9b805 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -149,6 +149,11 @@ struct amdxdna_hwctx_priv {
 	struct drm_syncobj		*syncobj;
 };
 
+enum aie2_dev_status {
+	AIE2_DEV_INIT,
+	AIE2_DEV_START,
+};
+
 struct amdxdna_dev_hdl {
 	struct amdxdna_dev		*xdna;
 	const struct amdxdna_dev_priv	*priv;
@@ -171,6 +176,8 @@ struct amdxdna_dev_hdl {
 	struct mailbox			*mbox;
 	struct mailbox_channel		*mgmt_chann;
 	struct async_events		*async_events;
+
+	enum aie2_dev_status		dev_status;
 };
 
 #define DEFINE_BAR_OFFSET(reg_name, bar, reg_addr) \
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 415d99abaaa3..eab79dbb8b25 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -530,9 +530,6 @@ xdna_mailbox_create_channel(struct mailbox *mb,
 
 int xdna_mailbox_destroy_channel(struct mailbox_channel *mb_chann)
 {
-	if (!mb_chann)
-		return 0;
-
 	MB_DBG(mb_chann, "IRQ disabled and RX work cancelled");
 	free_irq(mb_chann->msix_irq, mb_chann);
 	destroy_workqueue(mb_chann->work_q);
@@ -548,9 +545,6 @@ int xdna_mailbox_destroy_channel(struct mailbox_channel *mb_chann)
 
 void xdna_mailbox_stop_channel(struct mailbox_channel *mb_chann)
 {
-	if (!mb_chann)
-		return;
-
 	/* Disable an irq and wait. This might sleep. */
 	disable_irq(mb_chann->msix_irq);
 
-- 
2.34.1


