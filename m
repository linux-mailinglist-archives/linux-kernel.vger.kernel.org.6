Return-Path: <linux-kernel+bounces-409175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A489D9C8890
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E30B2867D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55531F8900;
	Thu, 14 Nov 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o3DuZU9Q"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751F1F81AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582185; cv=fail; b=d+6cSQ7VdV0Ykns8eZGg+ofLzI/HYWAsFJib6MQtPHqip+BM4RlyfWca8cUpZaaOir3Ntjv4Jhx3QFOXZ634JO0lBuUqif3dcG/bl7BoXAj/pkWMxnRyC+sAGXXngDWpQVQGII/GXGI+pWxpnOMdypxdcKTSzGb4Fw6Jx6IljtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582185; c=relaxed/simple;
	bh=aAMfH8lQKATQAOSruRNCyov0J1YDl63w+dTAXMfhbtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igvVtSEWWby7JDKCtnRAnW2TssP8Hq7YnbqvouwqZSGhznT+oWAxn5rqzZt3YPyZNyUzJJciz+mL+RNLxmmbsEg2nUax3xpVAJrIoIO6tFcbBQ1WSbn0aVp7uxrA2DT3S/iH1if/riwl/7suwOcNdLBQOE1ODybrYPYkdkkPZW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o3DuZU9Q; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbIwicqUX8wg4VCfk94kXt3odusHBSL+B1dWu682zFrwC8RCEc8ZFpiVShbZPwu6eKyRbwg1ExoAFeDlx+vbMROQsoE5PgPr2doYcjkbf7ZTByCc9UwgIRsOxFFmYZiX9XAySWXWZgC0f+PZ/1HfvbK/tn227SltsXCb3hmIQ0NhoFGbrjQlyjlMISrJXvlbv1cDmRtDRzqXjFgTIc9wODiju4okFmvCKF9HXtTvi6TocMvoiUcXHmfvCHphZf/ngSf5FnbGWpqFpelwhFLc5W8PR/ilCN6T2PhbWHyyN8MxaUhibQZerrzZGnzrCPUeJ/XHFOWsg6K9Kp/xmyZqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auMu2eYSNNaAUTISKxeGLqZFXCpNiDqqrMY2ciR1OLA=;
 b=NVewVJpGaRDud5SgZA8MCYRPY6XkcfCAIIi8VzNCdJUGnPRTy6ehECQX6BGH9TA5jGSwqyFhH3a79+1tOEcMjTIxgGK0W1foJZwNYshtKW3pijQtQxmSC0O5PJiG4OPNNB1eFyH6htO+SiskOyjTlKIBab9tCr5MGZCYK1X85hGYTEBV2aI76npDxcpVX557k5x9sgp6pP3OzkpKFb6n0uUETbj759IESE/7ydcf2bUqLnGCuxQzJ6GVYMvHx9zM0mb2usBi5u4ba+bOOW2yLNU4VdX4Pe7xsDmebf3g1MopS2u79+jvxVwUVuujNSwiTsIXPvGu1MOKLgt/1sE3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auMu2eYSNNaAUTISKxeGLqZFXCpNiDqqrMY2ciR1OLA=;
 b=o3DuZU9QrHfDeXh85kB8sSNFAZp3RNSxOjTThKAd3Hw4RjQjBIOh/D4WJOqMUrFcEn0qvGsoUcTrCURUpoFF87N3y3p+hj9bUAatTAeCKUMmKbUFt1oQFt5UR1twVxB49oP9vKU9H5fSWK7XX+e7xxxdoPuT73Id0En+gxH0ICk=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Thu, 14 Nov
 2024 11:03:00 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::f) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 11:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:03:00 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 05:02:57 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 0/2] Introduce initial support for the AMD I3C (non-HCI) to DW driver
Date: Thu, 14 Nov 2024 16:32:37 +0530
Message-ID: <20241114110239.660551-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb2c59e-ec6c-4140-460e-08dd049be730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wvUBh6z9R6OYpDBRjxFS3GPvVPDRCIDVr4fSOCGWPTaAfPY20NITh5h0lnvF?=
 =?us-ascii?Q?d2OXS7iyWmCXlYFIOLJ0TzfD3jZ/qEBGdqkIjT1J2eb3kIiXTsb7/KwVkjHu?=
 =?us-ascii?Q?pAfvi1b6lp8sukklwUZRplKHOGdJWqHymuiGpPDdl+R3I7X+U2W9xwAS441H?=
 =?us-ascii?Q?uCgLtp4Zr5cJ1zsbZRTvbrpVE4xQ5Zl+fYkw4ufLk6s3BxzR5os5imZ/MrMi?=
 =?us-ascii?Q?88W9zvLBe13rNWdqsVg6zWarb5ekC1UoQ+zcH+T7cSL6f1Sva75HPxteFy2e?=
 =?us-ascii?Q?82Kgp2DShwlqBmFFQiH6slIu4ODJv0dXTkd6PXtDbAMUWZLp56VRVHypDGRm?=
 =?us-ascii?Q?tVYIGJNbPONf3UighyQBKFAZRVie5xCBUPQky1/R2z94F46aCa189ouVGNEA?=
 =?us-ascii?Q?O5lijIsIyhHkvkWn+Og6e/eeeNgAVn5QZ/sM45i3ybSfpU4rI/EhLq+MleTz?=
 =?us-ascii?Q?UzDan42ugV3q+e5tjPiqrQiygqVBfVpqeIvDCv5eVtyMEyntKWMvU+VPnplz?=
 =?us-ascii?Q?SCFJXl3siyc2DP3hxUzlJ/K47XNTvwe4F0yP4aN+kCanO9VbTNRaWIk06RNs?=
 =?us-ascii?Q?V+kUzw5yzXYRefJa9oQYm8Av1iFW2TJk6qUqOUXQKM7BVz3USzv3crs9AbZv?=
 =?us-ascii?Q?mWRsdpS4udrogLqQwL++shEPfJ1tsdFngBAy58h6HOYui1zckpYC/XDQ5CZe?=
 =?us-ascii?Q?n6CEo5V0Opbhs2O6PXACAhePyurO+m1zy8Xr65U4vCiiSX1eNMtsRH1O6TiX?=
 =?us-ascii?Q?C8/utUJAO0asKsz1ApEIg/P0jU5DmC9XXZCauzsJ192BtJ62VbnRiKPtG51h?=
 =?us-ascii?Q?e0fxvIO9Ydp63/T1TIY9yMJ7iu7sOSWsCpOJ8R4vRDYqRaQu3m8eGUoXGz86?=
 =?us-ascii?Q?RuRwOZAaKc7wd+YNwTRxNhFANwpdo/oWwY2NlgHjZl5YlYT06sD1iPp45JDX?=
 =?us-ascii?Q?poWDgMKqSHT7CR4mFLJWYZXjubqbT8QwZQ/syed7cf7AxwSrqVejvZC/kesR?=
 =?us-ascii?Q?OyGwpBcZ1iKUqt/smcmHA3N6HQUWrK8TCt81QR6xWrAoLXt7t2dRr2dNnGzi?=
 =?us-ascii?Q?gQzbVQhoRWcKYiHMxXq/LPT1ry877nQaHh8olU77S/yPGhmXCeup/II1dIHH?=
 =?us-ascii?Q?H2JYPcjo7URrfjD24XsxqoXJsG3NvnzxwAmQu88gZRG720x5HA2hSv94eJG7?=
 =?us-ascii?Q?8GyOXSedRfDWNtJOUzJxPctUTPa172CuaC1mfV6s0HWSWo6ws8Bc6kez+b01?=
 =?us-ascii?Q?jnt6Rwqmkq+nYG/iKeaOy1XDaaksnslpMwJpDyoQkNSoY4OUPOAqQ8bd0HId?=
 =?us-ascii?Q?ODdQLiiA/WWT+AMwmbdYZl58RQgBXt0qZQR5Gc7hnrkNEq/OKX9/WU2fhEtB?=
 =?us-ascii?Q?kTU2Hkdc25VdIUZHFhTCU0cx318G0RttBsNAC4K7S2e2ZLdLMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:03:00.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb2c59e-ec6c-4140-460e-08dd049be730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

In this series, support for following features has been added.
- Add dw-i3c-master driver with ACPI bindings
- Workaround for AMD hardware

v4:
----
 - Split the series into two
 - add Jarkko tags

v3:
----
 - Address feedback from Jarkko
 - Drop using SHARED_IRQ flags during interrupt registration
 - Update commit message to mention about SETAASA
 - Use bits [6:0] as the static address

v2:
----
 - Address LKP reports issues

Shyam Sundar S K (2):
  i3c: dw: Add support for AMDI0015 ACPI ID
  i3c: dw: Add quirk to address OD/PP timing issue on AMD platform

 drivers/i3c/master/dw-i3c-master.c | 34 ++++++++++++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.h |  1 +
 2 files changed, 35 insertions(+)

-- 
2.34.1


