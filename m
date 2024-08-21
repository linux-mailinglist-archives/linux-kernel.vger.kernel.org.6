Return-Path: <linux-kernel+bounces-295595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A7959EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B671C22271
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9ED1A4AC5;
	Wed, 21 Aug 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hzs5giDS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869301A7ACE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247403; cv=fail; b=VyoTBuwNh7ytA8Ou3MbmU/A5SWtOkaSBghTPibmLvTQRxhUz315IMQh0pb4gx0V2HGvWPcdd8nGeqkXps9+qimdFwjwxRHHl+QHPHBWL+VSYNlBJnV7/qOfRYEkYGhiN0SCnanA9UsBBjE3eP98bHKixyv1DxV2dVwOBDDiIfOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247403; c=relaxed/simple;
	bh=sm3xrkT1mr8mT+qQDs9ETYRK0cSRNR2tjlVsvc0UsCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jegn2FsS6UxDWm1LFxJX1HoQCwilki/3hoTr7k/q21yoUuuPBxevZOljWLd58beRNmFPUDcZ44jyuT6Y9rfisXPOsITHBuHa7qHhYY2QMd0a5A9CnRn5mKL+c35ZjRn3ATX1A3bOm7f5eTYyNTB4gU33WVJ788/fRQGVkjUEf08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hzs5giDS; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZgmSYvxxGDpledFf33C963hl84ekdfjMoMhcWJFyjh0psOMcqxPoKYE6UnlSludBg6zBP2QkyGEULeNIHu+FtKLHKTyWeZFNChGE4J3Hnf2JhA2/etmOlkbh6vL+M100pk4C6lIv9rhUBAr+E+YJC1nUAQn/pkBe7tG+LWayqbZnUnswkpTXUaD7+06MOmx2y5JS+wPIQ8oqNQy+rhL3Tljy1XREDqwu3tFQYY3eR+k/uG7iScIc+Bxg2SvqlfKJvodZicHC7F3qfbUzfmIpHPjIyci3q3l54554Z+3f44gKFORdfee9Mc2LDJBFjf+zWEcIg1W5cc9064pw/7RMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i6iAN0UNrHS44VLGPaZAuChVuWx8UXzuFHKZHt+2n0=;
 b=NXD9VLIZpLJiAYWDcoF3RDuO5dJ5+iAonI9I8amV8VAoFu/xV0Njb2rtXXHU0iSkAkJqRPl5MPPLdEE4CP5LqnjZQOcLPTzlIc4X0P8vDzVpJbym6fdJbhO33FpFUriL5NgExO8RqXLO9X8EARDe/c8UePikU71qF22z9bkd31CIza+7NhM82QWy1+SAmnjzberIfhUvVEmW2Xg4abEPQVFMLwk7ZPpMSC7No8g+m5u+DjP7e7mh3c9oEdsHPgC94nr/XpgLfkPXXGz3+0wC1kO0M7N9/cdnXbBDHGxGcTa1qSH87DbS6voJ5OWiX879I2J+qAZ8JURsyQ9cJEdleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i6iAN0UNrHS44VLGPaZAuChVuWx8UXzuFHKZHt+2n0=;
 b=Hzs5giDSYaHJRsg6p9JY2AQ5ulHOf4MZnXX+FZWDDiASgMkHPFLjAQkxT+pIrVKG5NTIqt8s5fPNPjlKbo2EH3amq7V14zAIGnQI9BKyrdzteRwMlOH07aJROGG1Hn1Hrh/gbEcgiXMo345XsimQPNx1ra9qqQFGAwajh9pB/yY=
Received: from BN0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:408:ea::29)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:36:35 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::31) by BN0PR04CA0084.outlook.office365.com
 (2603:10b6:408:ea::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:34 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:31 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
Date: Wed, 21 Aug 2024 19:05:51 +0530
Message-ID: <20240821133554.391937-4-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfd9d39-1b61-422d-d58b-08dcc1e64652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23jgJRIUh3Wdun5IiXwyORJ96qW76vT69gskh+hWbKzvSr7KKeoDkFUg5vQE?=
 =?us-ascii?Q?f3iFVyX+1D927NggeAUY3H3sVdgL6xFVZLqmhCox7GW7j54iEsfd8stcJZNj?=
 =?us-ascii?Q?fm3t6i48UCRM+uIGQIaW4hUCRvXTmB5UbmFfycNikA9Egk/Ms9QUcTAk9AtI?=
 =?us-ascii?Q?lTGrmk4UyrGpwmPWIOMxbargflRmUwLqS4tkwa2j8XDF0kjXNnElh5dEjg0m?=
 =?us-ascii?Q?9cz+vKfNffo1jlthfzvv7zZOXSHxlO/yy9I9KoWX3coliBkWGOG+AbVayare?=
 =?us-ascii?Q?5naArpu2xULfzt1+cL0E124L/xS9/c1tw0TPNKS7byxmizOWPsN3MzlQrK2r?=
 =?us-ascii?Q?W93Ih/qm13xe57+1EL+ktNIYMuH9C24TKM7min2g/UvewI60nGWbmg3FoNii?=
 =?us-ascii?Q?HoddggIV1z9tZKtYev+2t98Dbg7QbpuHKP0+Rgbh1qe48aPKBeGhYgVhSMQS?=
 =?us-ascii?Q?GvSRWnaEmgtVI2SEvhmieAu/6WdeiwNMPt0ugzJYQAIysMDnQQhjNIcHcmii?=
 =?us-ascii?Q?s+levgqeBsiz53jj4aC+nX22hJ+ecu7dum6WRHD2+dJDQ5ulB4+hbaO7KeAy?=
 =?us-ascii?Q?LhH/ev4JZ6w4fX0am4zzl3DTecVtVCRc62389PFa+SpPqt7p2ZenDW8HSkm1?=
 =?us-ascii?Q?pMoM7dR4RcgCVKx+cdRJtaaZLlohAJVwe6mhz1CY7jFUZwZ40QT4lAN+KR1d?=
 =?us-ascii?Q?V6JEGg0NH3gzE9PdQYjFcrgaMo09gAUIe+fBYglY/+ciRdQQcRXoapbGc7+x?=
 =?us-ascii?Q?/oF1OpD2NLa4lK/tVoR06KxR0I5E0WJ4G+RDFTTX7bgCmVdblcr44rfpISWr?=
 =?us-ascii?Q?vP5SvTh+qTJmAec/LHMIoVufx01WKI1rlr0Wz8AzfNJ9qr95c0P28l2uICfz?=
 =?us-ascii?Q?nqFD/zxTYJKujF5iFraqT0RNdt3+2P2ZV6rdfQjXmNmL8Zjxd/kQCqezFCCd?=
 =?us-ascii?Q?7zaDD8H1zGwvpU8O5G0GLsZEiG1Vwha6/AIwszEH56MqRkOeJI3nt2elNKhg?=
 =?us-ascii?Q?ziDcq0Uxsm1JLwrgE7YOquvUACOyXSCHqXoyBcMmAKn7ImQpJeXVR+qEaYIi?=
 =?us-ascii?Q?RfyFOCwVOXygVVKPF5Pm0NzYCI7LAgo1J3tuXCsfv1KEhjb1MIQF0XnYCjju?=
 =?us-ascii?Q?8V/qf/VSjWZnmtHeGMusQlJgyU2pBwZ+lYUvCPJ+NlFAzMq5fui87ROWrhQA?=
 =?us-ascii?Q?scDglT3HkGiMT2CbcVoWjCNTI+WuZkV+3TB2e6CwBpZer4j5iX8v3/tBRH8Y?=
 =?us-ascii?Q?ENkJuEIlW+sckUtVWOTvQvxiOU8fcNgwxVokXvbeioSr8dDPeUjmVsTaUysk?=
 =?us-ascii?Q?JuEgjPp+V7jJ7tE1wVGEjqaXeXZ2OhiQJT4wdjDZavXujBNIZwYB9d/goAwd?=
 =?us-ascii?Q?4RcLpQOaEgX5SXccrpze24kTvpAKV/E+FZ/itojKM9MN/JOqxa6uX+ELAYQw?=
 =?us-ascii?Q?01wJPi8NOmiKUhJ7SVxDhF3a9s9BVXnP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:34.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfd9d39-1b61-422d-d58b-08dcc1e64652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

The AMD HCI controller currently only supports PIO mode but exposes DMA
rings to the OS, which leads to the controller being configured in DMA
mode. To address this, add a quirk to avoid configuring the controller in
DMA mode and default to PIO mode.

Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
driver to facilitate seamless future quirk additions.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++++-
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index d1952a5619d4..3aa4aa9deb56 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -754,6 +754,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return -EINVAL;
 	}
 
+	/* Quirk for HCI_QUIRK_PIO_MODE on AMD platforms */
+	regval = reg_read(HCI_VERSION);
+	if (hci->quirks & HCI_QUIRK_PIO_MODE)
+		hci->RHS_regs = NULL;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
@@ -804,6 +809,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	/* temporary for dev_printk's, to be replaced in i3c_master_register */
 	hci->master.dev.init_name = dev_name(&pdev->dev);
 
+	hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
+
 	ret = i3c_hci_init(hci);
 	if (ret)
 		return ret;
@@ -836,7 +843,7 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
 
 static const struct acpi_device_id i3c_hci_acpi_match[] = {
-	{"AMDI5017"},
+	{"AMDI5017", HCI_QUIRK_PIO_MODE},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index f94d95e024be..c56b838fb431 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -135,6 +135,7 @@ struct i3c_hci_dev_data {
 
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
+#define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
 
 
 /* global functions */
-- 
2.25.1


