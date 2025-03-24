Return-Path: <linux-kernel+bounces-573885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970EA6DD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402C27A3860
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B326159C;
	Mon, 24 Mar 2025 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oHyVZcg3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C18261593;
	Mon, 24 Mar 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828340; cv=fail; b=hnLS+oGFbTP/3/9f9HJ6lE6EYepeRvpiHNbbHyQsFgRoE20+NJaqyTNJVkMNF20kbCKMN7XvOhrXKHBhnL58eHO7fVuuSUUsXbch1izBmmrWcMNrLD38oUU+zvvNPW4vWPLEAn+X48+4OszAQ+JhZGFePsgrDu4rjgr8s07AVGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828340; c=relaxed/simple;
	bh=5GtngUwv/pFLVs/5jP4e1YTBT+QZloysFbMq2j+bxzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhejakRKR3JeQzDdiFKfbafcf0LtalwzJuCt9erZrRC3DnuhWJjFWlVENWXZ2sQHsj0wCI5Ahwyv9hGLrNGGbSVoG5HB7YVG6dzKNZMcO4c2k3wsyPeSGMPPIvizxICMqutHf9Ujz6PtwhfUKBr+SKWCBsVMjC53kGgMUJg+aKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oHyVZcg3; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIeRIzjU4YzuntjvNhdEuFGzatvM3++qeaihkEFUJyM6011VAus1rpB7JHQOalR1w9nrYy0h2xbFTMw1bF3BF7uKkGvnVgK4VeTjt941Hh7LsHAFj/ZilFJ0uUYC5Il9FGqHmjmEGGTP/cSyyiCBknRZJT2qhZtAfgu2KGt3rHmKIGSbyg9KZDbehRZA4gbNhFIJ05oOpssnqJfJXFIRkSRqpJeFlrkmEleuDBagowFjSfsX5JoYK9V8Xh8KmCLXRNGM4rm2RGUVz1Ff5VrtnDlo8ZwlmHYSsNplSPFNgPUsT93nNQjUB8gsDd0FGXOig4FC4Dqi3S6jL/8KU425sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1pRsfusff5dmd7COF46Efmf3bQtvGWyrIdbo/pp59w=;
 b=vADqp5/eDAjrWW/ftdiQjm3o1OWHIJ8zrQiChHuhCg9CYy0AdgSk6/ktsM/eeqpOtBb7tb8YRrBpeM7vWe+dUjFSr0v0VtTaKwf7+vQtdVJYBj+ixW9dBDRVaONshwmmzXZS4o4ZAlxeGleXd/sw5dGjxweEjoZU22j9/5aW0A3eHXCBkAm3k5bgkvbtPkjmqliRNg/km7cJawytpmnG3z4clEQmWkQJmi3wbLzHBiKNnrHO0FRgf8RDFhWkz8XEBCQePpIbQpnfssvNlL6InbNQZKbxUF379uyo0COnxCyBto/dSTBctHR/T6wEHv2NP7YYpJNyTrU+PQ5YuWsclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1pRsfusff5dmd7COF46Efmf3bQtvGWyrIdbo/pp59w=;
 b=oHyVZcg3LH7KTZ5R9m2ZGc5FLhZRd2DktGclygLU/LxLCRPrcTLAqX8Z3S5ZhnY/Q7mqMfHnxixOS+UKUDcIxCfgNSrUMiAMbYupyH7SuADMqIs68GJ32acYFy9GhpbpGMeF0bpyVVuFn3RZi5cytLwRSaYtK74SZUYSYys0tKc=
Received: from BYAPR07CA0003.namprd07.prod.outlook.com (2603:10b6:a02:bc::16)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Mon, 24 Mar
 2025 14:58:56 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::db) by BYAPR07CA0003.outlook.office365.com
 (2603:10b6:a02:bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:55 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:51 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 05/11] misc: amd-sbi: Optimize the wait condition for mailbox command completion
Date: Mon, 24 Mar 2025 14:58:09 +0000
Message-ID: <20250324145815.1026314-6-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324145815.1026314-1-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea130f3-1842-4821-d826-08dd6ae46603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cFkV68ZnFdeiAqU1+06sk7bdSpM7AkE10fhw8UXpOnY2b/qFxx5p+6XI3rU?=
 =?us-ascii?Q?DrZWhM7uyW4f4K/yJPhNVNM0F+PVelBb+lvYP1MBmqvt1fM4wMAJs9JzNthb?=
 =?us-ascii?Q?zwIxcwGZjbg7oQdvfr9neV+VkKO6QhuectZ2oh+f7FYyXyRMUJzhhU5T0Z3P?=
 =?us-ascii?Q?mcMbrLcEM17POft9Sksiht3Gk/NvF2VDtyZpaayLWxbbNOW2UfTZqslpmxRG?=
 =?us-ascii?Q?7ZmEVtqKjk4F6qi37NEo3P+xg72yw7KRwe/N8ap+Plo/XY2XHDdWoiC3Xwk4?=
 =?us-ascii?Q?asCy87a64aTrjozKHm1BYjLHhEUqZ5IXGgYAKdxo9a3XFBoeHJ5vebvtJq8f?=
 =?us-ascii?Q?YdFlg5Hcdxg19aHN7/PwtXdM270gJTLXZ8MmAhU+bxG2o7/rm+776bZjVv5q?=
 =?us-ascii?Q?jXrMibxCO8elhgbpE+F68BiT48FDJORDxiJAppJiL1fBjjPxre6zmbjUkq78?=
 =?us-ascii?Q?snlJLpMYF+oyKP2Kw9OiD1QIcdR0KmXMvapMLxYyKRp1uuzTkv6pg4U2oU+0?=
 =?us-ascii?Q?x6s1wy8cGIiSMImU2S+tyTVX1vNXVF55nK0Sm7+n3HgsBEMNfsxUuGc7yr6Q?=
 =?us-ascii?Q?VeM+0YU1FGefxzKQ/ejSiROGqtQTrJe/gjXV+XJXZndjujtIdwLQK9ouDGHW?=
 =?us-ascii?Q?NmaIK1JB78rrCDiTyWyLE83b4/xC9STWcuP8zDArr7Oi8dahIvKgQb1eSxAh?=
 =?us-ascii?Q?eaZAxz52+eZYFFK2EGR8Xczg+PwqvJGkppOXYwKnFv6sflxW4HBZ26M/d+2v?=
 =?us-ascii?Q?3wsWOs8Rd70WiEvX6/l1pX0qQ7RQ34LyOcWXrmwnpYRcwe/UbbkTIPg2ikVT?=
 =?us-ascii?Q?/exGwmb5QsqwJMpCijVDmrLW2aB5Dj/14YEF1tyni80/pNutng5GJ/S5EO7B?=
 =?us-ascii?Q?oeVhFA0ihKtDKYtIL1yhDBwoJ6U0IOgvCsvbokb+/GGFmLi7LiVjw4b6xT76?=
 =?us-ascii?Q?xy2akd+9fhh0QE35zFOjATyJDm7oZl6NtOnAAoD9MT2hLhOZUIzB+Tr1DAkA?=
 =?us-ascii?Q?2KjoFhO3p2dXIy9XHjnRYBiDICnkVTa4Ub0XSYI6a5fHStYZOXkyXuGztVXM?=
 =?us-ascii?Q?ZRgLAqU85AMLeJWvWvOd7PnfSgEBX0VTyUurADm5kL053lRqA8qpGRL2KrZ/?=
 =?us-ascii?Q?dx0BLb0WqskuGkXjU74yOXNi6enxpiZZh5pJ9k6lacg5zA/H8E6U0cXWpbb1?=
 =?us-ascii?Q?+8v5niompbeb2hw67McRbtN5mzGBEftYpGcRXo56dzhKLuL3gEOerIP9igKd?=
 =?us-ascii?Q?G3bG/dhjQCP0XEi813n5BNEqYbqQo2oSxGg/lLI9pkxhD1DiFrvpUqApt9Ac?=
 =?us-ascii?Q?/eLyGTRCDpCBPOlWiOBoHHsVlIwGXTfqQ2aa9nf+imshvLoRYNdPVNzEj3kZ?=
 =?us-ascii?Q?624tJlAOxkAI5b2pmTVyHgNQg8QNeArXZM1/RsQoFETHqxoeponktPG5Zqcz?=
 =?us-ascii?Q?gWFEOCZP9OUpkAIfoUQFSU4gjwM5I22kqTKk6sM0Nenljus1QIMJ6XRURVPF?=
 =?us-ascii?Q?XRfTNvjmfOlP11U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:55.1531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea130f3-1842-4821-d826-08dd6ae46603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

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


