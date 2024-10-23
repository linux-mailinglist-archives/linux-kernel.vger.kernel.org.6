Return-Path: <linux-kernel+bounces-377387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 090609ABE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F31B24C46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528A1487F4;
	Wed, 23 Oct 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5jpzhWi"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB2146A68
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662718; cv=fail; b=gAHNMHPotNfn3GlF7vUFCWs/pUyIdYD3Flg3KUwPghGtpreX65gSg8jVVwaj5R0MIZkpcQqqdlt7tvbomNmvRZtEF+p/8lMBJ+s+OvHw8Ujkev3LpuWQ3ATI1LY2CZnYZ5JpFbGnzFA7R/hwhdyu60eSycCsAGMLAEUG/8USqno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662718; c=relaxed/simple;
	bh=/CFNbg4hEgoGvzB3Vw6qhOkEGag6ZZGOrm3QGXUMaMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu/XVxDPsmGpWi4Hkk/7fjR48NdG9yR4sOmEDZPKjcxR0Ff+s4DaGSgjQZbvGpP3nf5iL7vEQhxzcqqKuq0JppV1UKca4GE92ljnkpben9Ga0xAjKAOybc+sGnFCe1p6gxv8IwMzlGgb9uMOuBh+QZFCPvGTaGxbHiV3KOIDz+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5jpzhWi; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOo1Xcztk6kuubV+2zQdcfPGWTrQw0tKW4MJIidI5VmgHUqJ83kTrrQPpPFvMelFL1tVMusu++WcKaj1w7UJEyxexjuus+7BGlP6S47O6zTobXq8WUVRqEotfxAfg+MJ69/oSLYyRxWZowzD0l7/wfqZftK1Y6Ln2xPnd2FuwJd/b4TvmGzbYfyfHmlUc2X5V5TcMPbIhVsEgKCiEKEyh+McLy0iZ/Bw76y9t+M1itjZ9ql9rBFnSktn0MVHKh9O0gdyLl4krFXmRa4VYUcRA0crUBywRwGGKl6dSKea8XomALlN3zqy6rWwKWnGeXBvi7oHkdCo+GFBHkwAcP/Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eS3WcoEO94epiLm8nqRo+FQ7Vh0tmifhbEMUh1CaXA=;
 b=iTMAPc5hNXlEpOUunUhuL/qUSeWN/yFbo8GRmHIkwJ8TYXGHKcmfO8Mc2jAEjvakV3qUPR0BeL+0H5qn7wFU36gBGRjeLlmuXszlKXhS0fPNAOXogjApOFR1GGokRf5uMwrQJniNhgcLCTVQDDzcjChw7+Y2inXsn+0S2WJrsKmCxVJGEMBfXkqzt4CeE/F446WSCm7b6qREB4ai+8VCD+hjOwLSheRl9NMBuqgkxq6Aw6GHt5gaDjZbKD1VIkEm5qzw2KgxoPA/rp9vOIH9leCxSsz0rs8LV0C5SYzqZhnj9n4ejcQA4cUArC9CeXPaFDxyJ9ArGzkRY9Mg69IDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eS3WcoEO94epiLm8nqRo+FQ7Vh0tmifhbEMUh1CaXA=;
 b=E5jpzhWiBPl7xSmWfra33yufoQx1kp5eWvYr+/fo0PQqj9v3F0uE6G1r985TmyCCaEt0FjUbcHtyIZEf0prkpXM7QDiRdGvDQzsGnfpzyy5V1SmFC6K+aiTO/JGUygilyM/8ecwYH19SMFSHrLzjddHWKyvd1k70Gin54zTlf2w=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 05:51:54 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e8) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 05:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 05:51:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 00:51:50 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 2/6] i3c: dw: Use IRQF_SHARED flag for dw-i3c-master
Date: Wed, 23 Oct 2024 11:21:14 +0530
Message-ID: <20241023055118.1400286-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eabae4b-8b96-4832-ebf7-08dcf326cc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o4zBTDn9V6AOAGqJt5fWpgwW66QD3ZuyIJhRFQLeypSXLUEgZTrOHbBxgIQv?=
 =?us-ascii?Q?i8G3/PlLzULOe7HfybhLPy/kmkexbqeGr9zfkqyXW7Azedesuu23vs3rkQkX?=
 =?us-ascii?Q?HzUA5KngEqATzb3MNbE5WXk8aeP4tus/nbCdmz39e/rioy8uBZb/0JAL9pD8?=
 =?us-ascii?Q?Aqwgm+fyc91OtnTcWtaQ+aePGJECaevAf7ygJwjGF8JLJjtYdtKGVCKM97I3?=
 =?us-ascii?Q?xgnx4VonuQ0A40bcCwQ5qwIdzBl2qbyBxFZxM5+hSLsVbJqellXOXqIDBt2z?=
 =?us-ascii?Q?PP0ngG72oV+QEAmJr7/Rl7Wsz3OOarCB37JpyO6OqlsY1qW1rQDOSUrEULQL?=
 =?us-ascii?Q?J8vIoUPnARTZj6ghpcfogRmeBqGDdsaBHy0UZqMChIC6bGM0463Bc5MllC4R?=
 =?us-ascii?Q?eRrDWaa0Zm6hAhRTWQfiDMzeQhnqpyiYkxdj0x8bmHLssCb9soTru1f9s6hw?=
 =?us-ascii?Q?/h0S7NrcOkYr6haG2aCHzoYNFKNEN7KUsAjTyiEpV1TblrkQgISjXzHvKuUl?=
 =?us-ascii?Q?J5lIq0UiZICxmDRr38/omvp4JXAzZcm4iKtJWRmbDYKV5qTDA9GU6ilWvV+2?=
 =?us-ascii?Q?dzn3HZNklj/NDXNaLhc6hmSHebrc64w0IQZvelzcn9lCah8Xid9i2sLwmhMz?=
 =?us-ascii?Q?msq4j1EEWLW0FwlSTTaSVyyeY6aqW55ZV8ONOsnuwcsE1gJdodul6KIrBfQW?=
 =?us-ascii?Q?yZ5TrDKmILsiPAm5tFOA0UjgXH54819GTa1kx66SHydn6Ur4+AmHgiDIAL4G?=
 =?us-ascii?Q?i10AHbtgWqHyNOpflJO7dGqYIX/GwW1aR5nx+r1ou9t9fc8z+4xDfaQ6nSYE?=
 =?us-ascii?Q?Zz7Nl7AyGYosJAQtX8Jz7kz7G6LAgeblg4TUWRD8Z1qhi1wyCvaNVtRzuce3?=
 =?us-ascii?Q?LnTlRCigRADqwgDJ49WTD8iPynAinqv4O7e6EwjGxiXRtzY+lfB2B1x+Fsh3?=
 =?us-ascii?Q?qNyLTsn8MVaPHBod1VT461TDePufJqHsuVxbHncHLeaX6Ad8WYk5BOerlKdP?=
 =?us-ascii?Q?4QL57Uhb8V2+VBp7Bm4+jCbZQKMTavnWLaWVowOCAi6+jv/lzzs6aijth1K6?=
 =?us-ascii?Q?TSTecna+rVEfnX+AQfirieE1++M5+SzeU3IbCmX/5BlADVzZ92GAGri2RCMN?=
 =?us-ascii?Q?2FK8viyq/iizZPmFCjqLdZE7IJM+9hP2SsL+ogq1/I1vtJw2w9/y58elY1E/?=
 =?us-ascii?Q?mb27KjcorXyuRGZ+dZRT8X1yi+JHTPPdjfhEc9upy+XpRbIrp+qJJZggGuNn?=
 =?us-ascii?Q?QOJsi6t5zmWjqJuIv9969tnbGwsT2kpB0Z+QYFQ8IRy3FLNxsgDycRp8DheS?=
 =?us-ascii?Q?pqfZYWkfWg9x6n0m0HXjHQXO38gz54uLn7eVgCHlzOdsbIblyuXh3tQj4pnn?=
 =?us-ascii?Q?lF/wmvVm0y3L67aG3rUrewH8smOLzByaTjtCnfIy5gZGof6W0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:51:53.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eabae4b-8b96-4832-ebf7-08dcf326cc24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196

On AMD platforms, the IRQ lines are shared between two instances of I3C.
Add IRQF_SHARED flag during the interrupt registration process.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1a7c300b6d45..fd58a95ae1c3 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1578,7 +1578,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	writel(INTR_ALL, master->regs + INTR_STATUS);
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq,
-			       dw_i3c_master_irq_handler, 0,
+			       dw_i3c_master_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), master);
 	if (ret)
 		goto err_assert_rst;
-- 
2.34.1


