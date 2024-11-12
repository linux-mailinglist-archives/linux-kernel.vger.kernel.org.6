Return-Path: <linux-kernel+bounces-406388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 427389C629F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D91B852C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9D216E1B;
	Tue, 12 Nov 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qogpM7u+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9220DD7E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431200; cv=fail; b=aFwiqRVWmPosZzC1FKiLK3GLSic2Q8JTA9kCvEr4yGkUUVd2hlcu+H0w3vqL9Sw2CyoJEx1cmak6zAwmx8T2JIweWeA9GIlpmjiI7HyByv8ihpZ7Lt82QrNX0XgD8bftBU7Zt6qJPCIY75vvUvo51IcqfMMbvrqKtkeU5GU0zZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431200; c=relaxed/simple;
	bh=SP6bVwC47ImWXafn2bI/vz9cPmI9D/KBr78eYOaJ/3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AurjXCIkt7PQ5hOf9REdqPnROy6zUb1sMt0Wpkfku35DxlQ18EfAjhWdw+9lTiZW+XjmJu7yQjZiPFXNP9trJbRHcE5hDqO/Gqlw0F/yQv4r66ursDgDug5VslcnmUjqP+XjvjSBKCbdKo0k428kvzoD0/tQhgt60UDkX6cgXfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qogpM7u+; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6TuaBSp2o0ZjvOchmaCCOB7dO3Iadc+/Iq8oq3G1xWfUfOXDE9+bF/x0flTXG19HdQ3b5awyA9RRFjIAj9AQfa3JphG1aKk7Xf94e1NLNiWBLd/72+LjUR1YxcSo7ZG/dYPeju6HDoJmOpbFJgdCDv02yx1BCHVo8aJG05Nd6/3fSMPJfbUcECjOkrimhoQgAy5Nie5iSQMOIt+U8SYT/JDFiqCjHEXnt34H7l6EhdFq1h6zhxlHNH/CNSrHn3RkTS8P/7o8MIRobgLgfU9+i4QbWP1i5mogkh0htX4jQGuhbTh8MB7Hr5hT0g6f/ANxiy8PQCyY7cS8JVl66+BjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZIAXpp7x3kBP3ITrkgJJxWFYl9efsZALRjUaJknHw0=;
 b=EesBStbrP5uKvp2kBw/CY7Fz+Hh+wnLT4rFL/E010i/InqhTuX9Q5SaTPDyQuwgO9vkfOZ73fZKBKbKfJbX9uspOD4VYkqenSJdpBkyVBIW2As/yL/2+Lj89irSqLbRQ7ne/nPTsHsE+5Bp3lUw3tre/sYwLy5uL/rdszWOsmYbG+2krMl/CYf81QW9kdOXteexuYMWughvhl2KE2Pl+CZYOa08zwUefZXrkWOLPgk6YNffHQcJjPFEoStjcxk6Wl6+YTqLDyW1t7pTytFlQ8nwrcBOnHWctJTuXyTPHONziY+tqJ4d50xtXRMG7EkpXLv/TYtT3fxqGqnHKsN7LSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZIAXpp7x3kBP3ITrkgJJxWFYl9efsZALRjUaJknHw0=;
 b=qogpM7u+ex70qQgBt3c0Nkcaxhioho/PWqCuDQ3LZzTCMxowKh/wr6TknoCip8PW/IP5vYwcKbxiPgy9K9oYJzes6EvECuYHq7mI4xPYLNiUGZsjEJbI2VpJeN85PXhU6txyM14VjpcZOvtfiZy0zdhdZjRsXynPMO45Ps3xvS8=
Received: from CH0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:610:b2::17)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 17:06:36 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::82) by CH0PR13CA0042.outlook.office365.com
 (2603:10b6:610:b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Tue, 12 Nov 2024 17:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 17:06:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 11:06:35 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 11:06:34 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] mailbox: zynqmp: setup IPI for each valid child node
Date: Tue, 12 Nov 2024 09:06:12 -0800
Message-ID: <20241112170612.2577383-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d41ee17-014b-49b9-19ba-08dd033c5d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bB1Ich95a73L6Ez0sohyVGq6E6n3WEBToZ65LKA0fTwwhJll/CKCE86C2mbz?=
 =?us-ascii?Q?KkcHGGxC45uwJF1wiMm9XBe4VO0pfbRZDZDyiOE2n7o1oEwx0K2MwEojVo65?=
 =?us-ascii?Q?aBaCKGWWehunztHJZa7cDPbcH7t3u2PRSgODHj1M1iopgKRRQ6GAr0EWj0Nz?=
 =?us-ascii?Q?8k9TjhU0RNIHKtKqRIbZ0h2Ri/bX+thCSaCrs+kiegFtPHwJflNLDOC7YzxJ?=
 =?us-ascii?Q?1gouzKhTXKQicYnCOwxH2cHwojp4EwL2119aN1WiOAIcR9uGvBGD83QwMMbo?=
 =?us-ascii?Q?koChj6oIy8JPBlNv8oBjmMPJlyGC6+rgB0lw1cOrKVJqrVFYq+7FP2FJuBqU?=
 =?us-ascii?Q?l9NJleiZqSnrvPfVcpXOcGhaeazLzfhcNRm4S7uKUx5zhsE2j+32oRYQN19m?=
 =?us-ascii?Q?cNdRnRyGzVTrluZyibh0sezQZiCD7pw9XJbFac2VrAFKM0Pz+w348rwVuayA?=
 =?us-ascii?Q?V32OJy288QFw1syZ5iodS/IXV/oW0GhHPV1omitL+eI+9S4RtujgWZoTMyyh?=
 =?us-ascii?Q?nLzC5xZZ/lpRIBNArk+1MIrdkfw1bN/9RGBvw8IJ6e/jTPGFm78xohF8JBAL?=
 =?us-ascii?Q?AIA4O/ZwXLqHjaMfAo6nQeQzMazhOY869u23bkbNnjzhxMkyuUM0Al3q21V4?=
 =?us-ascii?Q?vzLYfM1hCWZ9qIbBXK5TDFlBsS70QB8L79Jq+6JjaJ8FzuOj8dlpGfBHJ3z8?=
 =?us-ascii?Q?vkYo1qs0Hg2iyykPRdo0cSxXtwiagXUMu45BiaDV6YdM5r2gsme7IPqP7aj9?=
 =?us-ascii?Q?6eucIBZnY1Nc9olYEd2C6gRcz8hH+4mqQ2KXxbXyMkIs2OadhmlSYLNQNMbN?=
 =?us-ascii?Q?ocWcmaytZso+gGQnfNTLAKbpfr++hOaT4l/zo1e3E+mthKQCIaLAOWnTIDR1?=
 =?us-ascii?Q?6b6bHOg/yZQRpTbomBRzwh+4IqYuT95O8JsNB0nilRdvDsUPYJjoMxlQNIWV?=
 =?us-ascii?Q?r6eHELHlvpsuihEJuVqmb5YKj298Y3ESHZoy7B2Fqiv5mGllXq4Pjrg8xMo6?=
 =?us-ascii?Q?s3EvDTzWcGdfuqz1JbHwzpjRFUkRdA/i3GNbF7ePd+Y+diqsqKJZiWNNqw37?=
 =?us-ascii?Q?WJKLxtsZ83ok/2VotVzlzjXP+sF+HTUljnQwa5N6aeC20IDI84IJZ1czB1xe?=
 =?us-ascii?Q?fVbTpRQvjxw74PKdsGNw857IqtmIRDptvSSzhupfDd6FANXBEt/urQZDjdx6?=
 =?us-ascii?Q?W1T735TNvUSTdwmBZ/S/WBIV0WOzBXlqYnvYpBj51VwU1xcIqu5ADdgqfoft?=
 =?us-ascii?Q?ccLM8a86GWm4i7WtkVuvBLtllnWh1vIY+nOAZZWS0CPqUYy4FI0rQTc55uB4?=
 =?us-ascii?Q?ZMHg7B2EVTyeKpCUlbedINWdRtvDvFsuCFnkZ4RnmWDAKxqPU35ooWR3o5VT?=
 =?us-ascii?Q?d2nQPFk1glGMLoA8VGbp9MFap2ogv327owTjMM9X5NZAkUAm4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:06:35.8973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41ee17-014b-49b9-19ba-08dd033c5d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369

As per zynqmp-ipi bindings, zynqmp IPI node can have multiple child nodes.
Current IPI setup function is set only for first child node. If IPI node
has multiple child nodes in the device-tree, then IPI setup fails for
child nodes other than first child node. In such case kernel will crash.
Fix this crash by registering IPI setup function for each available child
node.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 521d08b9ab47..815e0492f029 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -940,10 +940,10 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	pdata->num_mboxes = num_mboxes;
 
 	mbox = pdata->ipi_mboxes;
-	mbox->setup_ipi_fn = ipi_fn;
-
 	for_each_available_child_of_node(np, nc) {
 		mbox->pdata = pdata;
+		mbox->setup_ipi_fn = ipi_fn;
+
 		ret = zynqmp_ipi_mbox_probe(mbox, nc);
 		if (ret) {
 			of_node_put(nc);

base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
-- 
2.34.1


