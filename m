Return-Path: <linux-kernel+bounces-299086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E3595CFED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571DC1F217B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E56A194C6F;
	Fri, 23 Aug 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fKI0xcf/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E7194A63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422863; cv=fail; b=vCgcADbkzhNa0+OW6X0sIwE8uLzS7lsk2sBKotAOkzEYxwFYB/irOr9cUQPHWr+V+0W6GwEuNHgB4A7H+uHZ/AT7GMz1SK4fKlnvTBklVJSOh5wpkAl6tT4PNQ7tUcVPMQhuQatXzmTYuVDuvfpBGmR/X97PImdFwzbRmZs7L3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422863; c=relaxed/simple;
	bh=6UI8F/Xa4KGcduy5dtZfmH6vnKtupV6zDYDzH8V6S9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5Q7tZMZKEC6A4zGp+r2i1z+Z/6kwNz2Pu34DdD0qu70PTk8NYQ/XNFk4ScXN4W/eW9ckrC7B6q56T41QmAa5fX3P/64a1W5SZIhE3gjYw/JZrTWFQsny859X8CzUB3ljVj9zyKJrnj9ex3YJSmmAR5Yda1s3pa+vonqieL0Z34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fKI0xcf/; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiN9DSESP+uOAmam+OEFJ9ZFce3XSB0tULdfOtRQ+mdSj2xJT8dNo6L7IOZxA2couKRcjgFPCUmZiEvcZMaO4A37/FO98sbtQC0oEs6m1aV6MYJjWj2A+feO+uzxfj1sd9d7khEHvzsdyTX2h3JsxXArPzQAy4cpUl+SJxjAFwJqmAbHGME19mFLQaDU7f0HlmYcEqEMgihSR1cDwHrXsm1eWMzwuCwwGMZc75VrC23MM8IC77htBhMCvmBocQ4H2rzvgpH3YHAA3hlL/6syKPzK80XQz28dpGUfTpGcQR+28uIh1Fzf4mKQwIzbnlWubN02789uuAnCHFJljJGVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2XNRZIHJv3vl0L1ghOR1iqJ+WQGba+DYJt1stgshww=;
 b=LWsWCNtvmwnva8XK8/AGushCcOge8MA5ClCBXtqaE4DRbSbYsjHLTlKvSSZtRxXgmjDtYX+udQhWOXUJl7a1FFbGZeeo6fAP5sOyDu+34Q0w9JMk6n/XVmWbSKTtpoRnXdrR/h4hWmjQeLIzxxQVRq9vAWSsD3Qj3rce+w4STevMjdxj1m7SdIp9gd0TI3dfVNeQOhoIgRDedq3FsMS25iJubWcI4IJXNqr4wpEOSWUma9BiPcX4FQWsX3b75TP4gXWLVSF0+pppCC+Dw3Z3x6SdS/18VunWyeRLmkxWowP7mNYjYMbONxGOc17E/PcJ4dbru48uKa94+1q3sHz0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2XNRZIHJv3vl0L1ghOR1iqJ+WQGba+DYJt1stgshww=;
 b=fKI0xcf/1RDEIjgFYptOJrKMGJeSldg7YNBuyZUFfPFGKLtT8WUBgFzE1eL4pBo3PUHq8mm1AD/FvYaX09Aw5XXS0QTVl9MzZHKoyl4JZ60bXcuRVd7UdAlHl5IU+C7PWezTBnD5gUKlP6Od6Ly75vQ6rjVZEV8buny5uR6REIQ=
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Fri, 23 Aug
 2024 14:20:58 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::6a) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Fri, 23 Aug 2024 14:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:20:57 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:20:55 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
Date: Fri, 23 Aug 2024 19:49:13 +0530
Message-ID: <20240823141917.692336-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823141917.692336-1-Shyam-sundar.S-k@amd.com>
References: <20240823141917.692336-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b55cd5e-cce7-48ff-3f55-08dcc37ecea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sEcVVhWEvuZD0SUihixk6+yj2D/HRaZgtHRWdq8w6ZG9Gl0+H4taGf6jDJbb?=
 =?us-ascii?Q?BQvu/psAEADHkVZG/WgKIPkjxrXG+7IfqeaYjYqhDbgjtskSyIXeoZJvwMST?=
 =?us-ascii?Q?K7z98bwgiZ4qXuWql6EbTfT/GkEa5m8pIjZh/+FG3JCmu8c6/6Hmfa9N2xUK?=
 =?us-ascii?Q?YJI+rw15MWNw8+Kv6TGgvDBiB1dZK65sp+TPeTCjOt8DEPhXkluNTgKGBnYp?=
 =?us-ascii?Q?6zsfKsIQMa09a1SK7uVZxVuHp0phYSDR1c94oRmKW8bXohZ3oY7lt/w6fvP+?=
 =?us-ascii?Q?FAexkAA8Y5sB3xKpTaBNNl68ebs61arSfSMUePBG9MT8AKDn8UZC3xWBelzL?=
 =?us-ascii?Q?eOy+cidTJKGpbxRpjQCCVjC/d2BJOR2SAe3oBrCktAYS19nA2y8XYfblgJZ5?=
 =?us-ascii?Q?ub6Kkds+IpeT3sz23VfxZp5DGrUxeJjdxk9DMWuhYdqLEkBmcSW3H7B8+ts1?=
 =?us-ascii?Q?8mRi9EdEAK0FvY0iWFvw5i4MJnjcIyNvXpLcsVeuwBxOTMN466pHoy06Hgge?=
 =?us-ascii?Q?pyyC5Xx9IkKEue/D1KNyf0whqby3S4rwG18IFAG7AHKi6xYPpLbQV+dDliJy?=
 =?us-ascii?Q?KLGGVJfthtiEP0KBLOj1Pvpx3Ps/JY2Bi3P+mDuZLesWxRsnIQHYJvX2nofA?=
 =?us-ascii?Q?WIGdXOh4kUg48IfQb6gQbW+6aerBdCHcN2jNqyWCJzupdEfU2f44UtCJ69xs?=
 =?us-ascii?Q?WEgaOtG1KzQXCEhf8A0HqT5HMPoU9J5mbRcGaxbn3PI9pr7jiycn4Lk/2HjM?=
 =?us-ascii?Q?pDbNBVZAPbFs+19WCkELpDUXGLBxi3LtE0hUbmAM1I3TAWbB7QrK+7StN1I/?=
 =?us-ascii?Q?l3TIFRJTzcTAH+7hGYv3PZUQ0JsxPi4/AT+ZwFn62a1triYAH4innxbSmd/X?=
 =?us-ascii?Q?U2Laz0DNjDtXReuvy4FhAZjfpbwegI1dOB5E02E84CoP+gY3bZx0Waswzaj/?=
 =?us-ascii?Q?HwTFiSkhALmyZdBRX14MxJ2KL/mVw8QRbnOqiwid27xonwWPNINmGiRuFmSS?=
 =?us-ascii?Q?s4bGAGJbhMmcQeu37Ilh4F/n9iQ8vC/SzmnyMUsRT6IZU8GB9Kf2KNUfokxY?=
 =?us-ascii?Q?O6v9fkpCOMIt+MVC6I8hka+vIZldnP0LsZbCIAT9wvvoqJHuf66DOgHq8Gy6?=
 =?us-ascii?Q?Mf9R9r+VJhu6JpruZJilF+NlE5XF9DFel0AoV1K9ZX/TqA6wyBRQ4bG1dYM6?=
 =?us-ascii?Q?o5rsdOnhyDRYvZ0L2FPB7vvVzRt83296u4jbePnCd/vdM8PQYvwFu4WRH2hf?=
 =?us-ascii?Q?JjWTXoVom6DnDuMedQcO2U1vkmIfcpTkK9H+X8RplR48her2Ls6q/UhxYvBq?=
 =?us-ascii?Q?HTL97IwRzhTaP28ydCRxkiZgokxE31YKkHXjuLMbFUhavwPebU0WxULLR8oB?=
 =?us-ascii?Q?rbbHpsFCPA/KbpunuBIYq7LiSJd8hz4L1/bVU8ozvjv9lGj9K9TLY1C8qpmp?=
 =?us-ascii?Q?m1okWdL0UEpvFAqzgYxdCJn1NeJgkTak?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:20:57.9324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b55cd5e-cce7-48ff-3f55-08dcc37ecea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
on hardware that adheres to older specification revisions (i.e., versions
earlier than 1.1) is incorrect. To address this, add an additional check
to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
status.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 07de1cecfa30..42d2362d072b 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -630,8 +630,8 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 
 static int i3c_hci_init(struct i3c_hci *hci)
 {
+	bool size_in_dwords, pio_mode_support;
 	u32 regval, offset;
-	bool size_in_dwords;
 	int ret;
 
 	/* Validate HCI hardware version */
@@ -753,10 +753,13 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return -EINVAL;
 	}
 
+	pio_mode_support = hci->version_major > 1 ||
+				(hci->version_major == 1  && hci->version_minor > 0) ? true : false;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE) {
+		if (pio_mode_support && (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "PIO mode is stuck\n");
 			ret = -EIO;
 		} else {
@@ -768,7 +771,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* If no DMA, try PIO */
 	if (!hci->io && hci->PIO_regs) {
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
+		if (pio_mode_support && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "DMA mode is stuck\n");
 			ret = -EIO;
 		} else {
-- 
2.25.1


