Return-Path: <linux-kernel+bounces-541473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C8EA4BD58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AB03BBCE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612C1F4734;
	Mon,  3 Mar 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0cz2tci"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E01F4630;
	Mon,  3 Mar 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999592; cv=fail; b=nlkV+7zGLnk3SrZYEk3QI7cffg5Q5eQleG2FC59cZR8f0M/9zJ34YBK4hA5v64vDVv4DHiqPmJKNnZCxC5DbZb0qYRan01G233i/R9m1+7qXnNAXudgWogWLhM9Z+cMhRcuCCc9r7mDf2V+o5aajPMoeuyWy95ZGdL2AeYUxN1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999592; c=relaxed/simple;
	bh=5GtngUwv/pFLVs/5jP4e1YTBT+QZloysFbMq2j+bxzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUmN6niLJ0kgzUhHZyy63CwNrH4c5T8DDnteY/RoCXQM9DXQ2YdJQRpA3Vxc2fba4zd9fy7DP28Xv+Ta5k7iM24iH5IYuiy9JKbbJkMr4n0TgmmLcW+mmCGuEOppcDilE1NK9gnen6vm63kPjSagNM8vhWpSLvITdZm76bG49lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0cz2tci; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3yeuh7s/6HvT9hx02xjskBrNhajO8Jy16RIpwrjJywGPEiRi7a971C2STFvSzsGPADXEsS23QtmIGoOiZxsZtd85KEp//sTxQBrmVCxHvPfIrDEtjvNBmo+u5m1gp6nyNsoNRr1nQmEZuIFGWkupKSuDYQEwl+0MimeC1aoPm79QNYLZ+njcaHIEfmW2Cl3mpnxbttUz6MuPzDWRxdy1q3Tc4eRFCLQwkuTFljoEX/9a4REJdy05BlB5m08odbUzG67/8fB/GeRGLgwn61RISqOmpznpZfQ/9lwcQcjDXFX+hgPeAlouHRhFL65J0VMzQwgzUacg+ghrXxWbLcp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1pRsfusff5dmd7COF46Efmf3bQtvGWyrIdbo/pp59w=;
 b=QfkJaUefh+eHXqtpfrHq8YewN58O77R9UzgqCWvc6/tKmIW7aDAtLFs11ryfZAUCm/Z9PgSuqZvF4kiz9GBQok22l5yvjZ593kZNuk8g6hTPuPm4iom3FgtSQQdC2RdObEeEKjjE7nyd5VwwfD4TRUC/WLWBkClxfZzypVI33/9bLVZHiE92tiNlFIZQGpQDOj8WHeZTEjX1LP1WbJ7ebMOrMkpm2esTmh6RxtV7hFje1r8Wgpnzt0ungsnMkn4zl+ogRSCAl6DKU01+FYRvm1/8mjN0RTgE47N16oA8KZBcAHEmpJXOHe95vNzGPQ3XFJsiyPnJphFzkHIuiDRVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1pRsfusff5dmd7COF46Efmf3bQtvGWyrIdbo/pp59w=;
 b=b0cz2tci3c6oUr0wbuUjWlefFvn7R9nnzIVZz7406Wu9I3ztRTtGJYLMVkaBEZ5NveYm1P31vWM8RxdKckPDAgibFCsBHeJsR2gVVwuuu6bqmtIM1B+7Qqo0+Xh4lXIFxA3EkTetpOJfQ+DFDALv2dbV7DmJd4gIZwkiKtCjwHA=
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 3 Mar 2025 10:59:44 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::30) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Mon,
 3 Mar 2025 10:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:44 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:40 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 05/11] misc: amd-sbi: Optimize the wait condition for mailbox command completion
Date: Mon, 3 Mar 2025 10:58:56 +0000
Message-ID: <20250303105902.215009-6-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105902.215009-1-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: f3916f5f-6a91-4d1e-8df3-08dd5a428185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kk4LudVBAwxksmWvydYZ7HZdT4PuWaaDKfGTdntyRhIO8qR2+EVWoFIM51fA?=
 =?us-ascii?Q?fsSJ7XGlCxLA8A6WXlQgSh1V2UsZrS/oeWbY/7B93uGK/C1nuOWkFozOUcWE?=
 =?us-ascii?Q?oROBnp4uYNt0PpzjhV6IsCFD+ZCQPs6N9U3tRf8p0dsgW0uIH+kxvD3m9D0u?=
 =?us-ascii?Q?IxXCOE/+/xSHmGWLVKsuhJKBhwGO+sssu7l0XuDedDseiGXFM22cEPdHYjC8?=
 =?us-ascii?Q?MGTGjApzEsiCcZlM6sV63HP3fOJB3Hg9naTrB757qQEoOI91Jnqc+2/mALvy?=
 =?us-ascii?Q?DyiGXCjlnQkpuz/2KCUOOCiNeJ9mftkox1ziiwISgnwtU9r+jKnYMkg4PvOr?=
 =?us-ascii?Q?n2zoBsmWJHC66eMJ9kIDuvL1OmatcsAjTRMDALsPXWGTOEjjN+9Z/ZIzNtX3?=
 =?us-ascii?Q?51i4PxKsGqCBbKxa/SrjXMfOVTq36HOeZ3bA5LvunST8wkrLZsqsl1mXNrd5?=
 =?us-ascii?Q?ZrH8V9nsgc2BuGexFP1UyEXZGswdu6VaoFnxtReiFCpDOleW3NwvKpfh7SOA?=
 =?us-ascii?Q?r/xdOOah5HzAqMAEYLOXV/Qkr803jcV0+9f16ZtXXgY6JP6ODDMwf6tNszjZ?=
 =?us-ascii?Q?eH9afO6HSQnqKOy//lSnBCIrLviAXZKAmB823MDfnK0xRpRaZvcz2DBbnqAl?=
 =?us-ascii?Q?5RW8JMxbq8v1Gqf2LVJYqAbocUjxOlX5tHr8rj+Grm+1gV+WXoOTZP8IsTw7?=
 =?us-ascii?Q?oY/f8PioYsQ7bNhrEqunItgA5cgUiOXvWlGrs0gdRcXEstCJ0JBgN6WlbNLo?=
 =?us-ascii?Q?g0J+4kNPkdb6OHDrZYGTD1QcBZo0YySoH3Pox8X2//pk0iU/MyCk2pZZG4sp?=
 =?us-ascii?Q?OxF4m+RVGrEyDc89mo9WBcH47kATiqWerc/aD9+tBZ4Y+lLU8vjCx/1+uByM?=
 =?us-ascii?Q?hAtxCUgY03aT58uKQxYFyvykfdBXwCYfxj0sHDUOeH6UqzB/rM0yIbDAA4xJ?=
 =?us-ascii?Q?8W7U0hIb8TMF7B12A9NL1D6aAaQ9Bdiq7F2GvZrVY3dmFeGT34tXv1aPsvCE?=
 =?us-ascii?Q?ifXaC7G8sDXHBsvFRoz/SOyjPiAggQ70+UIV0UvIeR0Rhpn6NvxSD3ApMQ2s?=
 =?us-ascii?Q?zBfxDKlkaB+iBKCL/eCzhGy2mH1/2VMhXbE+MwrC55TeLwYkac6NOb9pSu4V?=
 =?us-ascii?Q?/FNOLRj9hYReRHrDdmmNBwCB3kUaQjeYIJytvPQ/8CJ+uvOtbzO7TYY+2LYj?=
 =?us-ascii?Q?vMH/acQbNSvsEnyLAo71OUwTJy6d3LcZD+KPkMQWXffM/pCWE9ftmubrQz7B?=
 =?us-ascii?Q?ioENV8UCi0blliuGf0cMM/i27aih497acOjg3bx2AkxOPt/I5xHpx230lWTc?=
 =?us-ascii?Q?wcNOoH4FrmDla2ml2TwDv4FacSLa5iSjRjANfI5tcfApV46YVBWOYfS13+Eb?=
 =?us-ascii?Q?/5G7H15Xo9NHokc84GD6s9D6/kL5fzDmgIdkvgPeAPTAlTJ3zWs09VQqQsLN?=
 =?us-ascii?Q?t6rXKZHcNLO9xRdBGazogtAxyMniASZ+3hqJeN5+iKKwG5mIEMTv7e6b3MsD?=
 =?us-ascii?Q?6TnA6hSAsh/zuKY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:44.3052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3916f5f-6a91-4d1e-8df3-08dd5a428185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

- optimize the wait condition to indicate command completion
  by replacing the do while loop with regmap subsystem API
  regmap_read_poll_timeout()

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
- Previously patch 3

Changes since v3:
- New patch as per suggestion from Arnd

 drivers/misc/amd-sbi/rmi-core.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 663ab9176d95..1d5e2556ab88 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -23,7 +23,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct sbrmi_mailbox_msg *msg)
 {
 	unsigned int bytes;
-	int i, ret, retry = 10;
+	int i, ret;
 	int sw_status;
 	u8 byte;
 
@@ -64,21 +64,10 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * an ALERT (if enabled) to initiator (BMC) to indicate completion
 	 * of the requested command
 	 */
-	do {
-		ret = regmap_read(data->regmap, SBRMI_STATUS, &sw_status);
-		if (sw_status < 0) {
-			ret = sw_status;
-			goto exit_unlock;
-		}
-		if (sw_status & SW_ALERT_MASK)
-			break;
-		usleep_range(50, 100);
-	} while (retry--);
-
-	if (retry < 0) {
-		ret = -EIO;
+	ret = regmap_read_poll_timeout(data->regmap, SBRMI_STATUS, sw_status,
+				       sw_status & SW_ALERT_MASK, 500, 2000000);
+	if (ret)
 		goto exit_unlock;
-	}
 
 	/*
 	 * For a read operation, the initiator (BMC) reads the firmware
-- 
2.25.1


