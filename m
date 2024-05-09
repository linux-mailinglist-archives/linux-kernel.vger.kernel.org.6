Return-Path: <linux-kernel+bounces-174125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3758C0A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823C5282C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63958148317;
	Thu,  9 May 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zomKlBTe"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF61145B29
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715229400; cv=fail; b=FbTjxDxAqNVQhYTsS5jA7w7J2zBA2qkkZNIG+KRi9+8MF9MaTq5ZBlCHW8wuIeyRwvXVTnu0ZY64Q3fl8M+6Xm3eoYpdkYsOPwie0cwMPjZystTxthrQ+MX4V/a1tngiEOnKwN8eaG1PiusYtU5MxPjCOaUhfZbRikVfeJ8+yyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715229400; c=relaxed/simple;
	bh=ArjcDJXa9u5BDmuB9C/ZVB+7BnypxsKAiKk1XAM86MU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MDBxNkznQLxZmfmig8rVzb5aj0AKO4jHz7M78TiBMT5LfExtjLWX6Tlg27FzHAFrMPoTFnL0r6jcjldPWGrzw1edETrqf3Sf3shS4oLQtTPpqidSxk4aCtoj1lQFdBBByEQucT6O1X7wTJVUJHYF3fao+yYr81UeD6Yuyhuy8PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zomKlBTe; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKL7x6dNWED/BzXGnE3m/Guo7vtuTFK/gKtLdarxcp0P8EY9nSoR6k0IGkizZ+pqFV3FPHNRBwIsJIs2muHDfJNDk96/tcCMSjuzKyN/9IyusfgWy07cW/SAN2/px1qYfcyxBFkpJzAC/lpoedn6g4QAeD16L3MFoyaFQi5czWinMpkdyOLWT2cRqY2x9LJ+pKOqhzCOBlggIwUFbPVec8Wi+6i+T8PGl4R/oo3TDYKWRBpBTsLHE8k98JiUILdpLB7UPl8ncBfFliG4JYFoFNLjp6S/lv/CTrI6krOpRkDoR40cSwHEliUpthK0ERd56EKSPOlVas/5XaHjN3jT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4gZZGd45zLqJSduWMpnITSF1PuE8Qi8BF0SxGUP3o8=;
 b=dKaOILRdm7rnxprlIu5yXytQ7I9ylVbxZwnUBUZVpHl6TEMvkFNXVvVO78e/Nnl3uK9iv+Ltgb1jg6HJsReaNFIBJpor3sGhP6ShNGXigVekejkQ1nD9K1Cqlipj+q/ijp1r8J9VSBvdR77c/StjRUa1XAim6GSfwCkl8ypdHb5z2z9PYaZaopb/+7SUHcAYcXnnb2+T1NQeBAaPfrB8YDWhzHDb08t5fy50E/Kff3LgUiyTv+Pec2t9ZxVNq4vNv4YmMX74GYkEMdOgRMbGTfSfcZCvQz0tIhKBwLRfAEo2DuWiEIc8LIcU5TS2cKRn4SPABLZweBw3xeNP6R5uJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4gZZGd45zLqJSduWMpnITSF1PuE8Qi8BF0SxGUP3o8=;
 b=zomKlBTe6qo6PYr+ej/W84Ts9j1/3k+ldplEdctdrl3t6kOnA1gJyepNUBFIXHGiWzIt5eLtgNBTiJxbTc+Uc/zi0PddEn+L0poG2J/wA1MnFls1lHWCwgHbENTECDKAEKUjolGCEfUXTspCCjik+eizbgFDbhHvFlyCbnYt9rU=
Received: from CH0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:610:b3::29)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 04:36:36 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::3b) by CH0PR03CA0054.outlook.office365.com
 (2603:10b6:610:b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 04:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 04:36:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 23:36:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 23:36:35 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 8 May 2024 23:36:35 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2 RESEND] drivers: soc: xilinx: check return status of get_api_version()
Date: Wed, 8 May 2024 21:36:29 -0700
Message-ID: <20240509043629.21506-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0b1de7-01cf-4c2a-40a8-08dc6fe19cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gF8cnC5dEevEamX0HXQCkVo1SohfHSfeudOKJLeMbT5GK3x5urMo2xLJ+KaO?=
 =?us-ascii?Q?meV7v5oqK86vcqxKYsTAoG0BsVDGS+8e+whywArkwj08lAVlvN+dBCnkzpxq?=
 =?us-ascii?Q?Fbsz2mprehIrCFE/pKHhRx4Wqr7S1TCetZNkmn3i1Q2w0p8U94kymx1Tr57H?=
 =?us-ascii?Q?09Rj9lg4d1MTQR81rKv+lbcqHrmXYlA5sZUgcdFJ89Yqfz24ALjM5ZUlZu4M?=
 =?us-ascii?Q?A84YQwB/NwAiznqTEGOSgAmzgqq7F+Mh+wH/yJvfg4v5wHp+t4Zy92r9/wv8?=
 =?us-ascii?Q?hyF+yNzLvmgRhlHe4XIBpZEuBOubA5Am3hkGUpIh/CHoNuHrC7NuFiMQF/eK?=
 =?us-ascii?Q?2TvSUXH0bxHhm22CP+itmgBzD882WQL+6HEfk2bHv1X5CvTdJZVnWMQIks0D?=
 =?us-ascii?Q?7fOAnd/ldu5OSz8+9uSKbmHDdWVx2Q5O+UgQVkzwTu3Q2h4aK6og1IgV8Kkv?=
 =?us-ascii?Q?3+9Ex+qYOR0lLaDddP0sA1qDgCFlfmxuste3ZgpZ8a20LtPWrPBN0AGqxm8c?=
 =?us-ascii?Q?GQnPLhCTFPJVS0CkqnOXRdhPEATp0JnZRyONzuUfoZZK0sikR5eq6CVdCR4u?=
 =?us-ascii?Q?z2NEwoZNX2+JaT+D7HtMDS01wjgz0PeQPL89D+my9NAEY+eqpODCqW5YPg8C?=
 =?us-ascii?Q?E0hZ1xQs/bJhrg0h3MRJsxAtX+jAP2NdcNX7/X2VZ9Wo65tBR0pU1qhZMzMB?=
 =?us-ascii?Q?N+8cW5N/+jG1mtyfvmSqj3hBlkr6fvxkA0sr6z9kowKvfMMToTP3i39MVa+Z?=
 =?us-ascii?Q?MKRLSaQi029ctwIBqpB1N7wdaFBHmwW229yYQDqFmeomMYh6Ki8eYmrqnW1H?=
 =?us-ascii?Q?hIZeIfrf+1DwD2INddoTJ+bvQkYmC7lRLLqtccuUDIqrEuDrXi7vprfToQNW?=
 =?us-ascii?Q?V0bYS5Ak1DlRWE7DE5PMAQJPmbDTlR7WXjpyW/57Eb7pAZnc7oWT6IjYDJ6J?=
 =?us-ascii?Q?EddYkoZD0lbrvlHscnMmEDcqmw0fnC17ukidVpcy0nb32w6zKIkWvfegkoS1?=
 =?us-ascii?Q?IjlOe6ITymBQsEdikrUWxaDg3jhCrtdWxJloE4RzmohqUGYbzMlrU+fqPKNl?=
 =?us-ascii?Q?vLEklN8EIHLSNbAjGmgI/H/yNwvpPtiRXGUDUFwPuauDbCh0a/ap2idupAzF?=
 =?us-ascii?Q?7U3iI6tlQyr8L1r36XcE9vVZS0uruqASbrWsdjODvCBOb0HI7LTo7W6mmxfw?=
 =?us-ascii?Q?0mfK0pCQDeFrRzgEEFLz/C0AIEFiC0pLhRTJsFxQV5v5mbmmO2XF8O69v38n?=
 =?us-ascii?Q?AxIeuWiWrTwvM6fft4fY7JRtLEyVUZIu6YAH5pZ/wX7JANqMFkA8n1WGErQ+?=
 =?us-ascii?Q?Fr/MWeMWrNGUDzDwutuL7Nxp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 04:36:36.5623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0b1de7-01cf-4c2a-40a8-08dc6fe19cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

Currently return status is not getting checked for get_api_version
and because of that for x86 arch we are getting below smatch error.

    CC      drivers/soc/xilinx/zynqmp_power.o
drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
drivers/soc/xilinx/zynqmp_power.c:295:12: warning: 'pm_api_version' is
used uninitialized [-Wuninitialized]
    295 |         if (pm_api_version < ZYNQMP_PM_VERSION)
        |            ^
    CHECK   drivers/soc/xilinx/zynqmp_power.c
drivers/soc/xilinx/zynqmp_power.c:295 zynqmp_pm_probe() error:
uninitialized symbol 'pm_api_version'.

So, check return status of pm_get_api_version and return error in case
of failure to avoid checking uninitialized pm_api_version variable.

Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
V1: https://lore.kernel.org/lkml/20240424063118.23200-1-jay.buddhabhatti@amd.com/
V1->V2: Removed AMD copyright
---
 drivers/soc/xilinx/zynqmp_power.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 965b1143936a..b82c01373f53 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -190,7 +190,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version;
 	struct mbox_client *client;
 
-	zynqmp_pm_get_api_version(&pm_api_version);
+	ret = zynqmp_pm_get_api_version(&pm_api_version);
+	if (ret)
+		return ret;
 
 	/* Check PM API version number */
 	if (pm_api_version < ZYNQMP_PM_VERSION)
-- 
2.17.1


