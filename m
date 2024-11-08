Return-Path: <linux-kernel+bounces-401186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F89C1709
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D42B228D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4CB1D318A;
	Fri,  8 Nov 2024 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s3SHmX2u"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA991D1F6F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051249; cv=fail; b=Q6hAedSfcJgtDnWbIkNbubvPVsyHB1rUm0ozkzcoxVLs9YJ9+IDqGjOGn11PtMpOnyuMbDUmI+jAo4s0b3YbL44TDJJ+O5CegG+a2poL+Jo16M3DFk+Rvew8a3TXA3SQGrCL8F9poa9zFXXaTty2bjvT4uKU0KH8ws4XB7AXxHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051249; c=relaxed/simple;
	bh=M/PfHRk9nXYNICDKekfonDpK4aCZfcw1z5GLsz1Mf0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NS141JOWvAzrz8/HswLRs57ZlM8F/kVMF9RDLgQddbME20zyvvtGDj4Br6vcSkm1r3wOKIA2FS5aezkbglYhJjdRAx3N0ps33mkGWocKFJrsSgWlif1vrfLXLfOUKkd8MkHmbOst4b7iu2ep3W9+RNxiHwvFKze06zXwa8ixk6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s3SHmX2u; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNLQlu/pqbj7RXljicKm3vICHBCxJro7AB6aDad129YD5opOwRfB4mqPBiKUPJxLZHD1rU6LSHQDXoI49q8FVTEABpNW0Jc16j5XwzIroZ1CQvE1oYaTQKVMzbzqUfURq6s14hlEeUEV1mZlU5e7eYHGnN2cEBDNM5Am1huKbkW3u07ZMMGMjzJ47f4m7ijBxzCwsnT9Q+kQYvWKMjilgPeEwu+4tm0Blpor4bZrAirHAOpmv9Rt9J6jBQrF09bIYzhyeQilZCNuaErvwF0gAVHpAqWiEYamnV/TO/nu1WmT7PkoFP8IhHY2DurYiO8MWDUVViUcQ6COxlVOBUxXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjwErfDQy6CzaMnw4++rs8wsNhqpWYxjOdTyHdGRSDQ=;
 b=qw+8o6hmeK5Mml7S0+z5uhfo4pt0DT6MDi/jsEPAJWklgBraVn/voV71m9V6A4bufDCV2Ap/Kf85h72Ci4u+xlrtg/htvN+vPldTHHGqPYdemWULk94w4L6ANjmBgmHebCqHA9qaFDzoEQI7zaUyiyiv22y81yhH3Z7IcIvk5wmJEKM8mlKkZTCkwLPTuhz+jxF/cXlH1RkJxhmB5WHzM9uKUQhSm9ODr+GggAmJpmWgAdt7Tiv2I2NwQNyUMFy73srTxe6fhIMnSJddJ4C/P+UZIXj76yWIkTekKtE1PgTgpvQ73eFJonXRAo75mFYKqa5RUwoBgolb1Evs775YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjwErfDQy6CzaMnw4++rs8wsNhqpWYxjOdTyHdGRSDQ=;
 b=s3SHmX2uALhlDc04lIW9E/WUD8s0lBLrWBplRo1V+gHBGuWRxEsBAVKw072npB5Pu8vSDe7+FqRTxw3YKXZCJnseM9DxHF8IorflBkdXu4sTMeKU0uzGnt/n6RjZFZd8i3KLlriQ0E1fwWmBd6prfJ/iTZH4ao4ULR+QRz0Thwo=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.31; Fri, 8 Nov 2024 07:34:05 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::b2) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 07:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Fri, 8 Nov 2024 07:34:04 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 01:34:02 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 1/5] i3c: dw: Add support for AMDI0015 ACPI ID
Date: Fri, 8 Nov 2024 13:03:19 +0530
Message-ID: <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbec23f-7213-4bad-09bf-08dcffc7b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ikngAceGnxJTp6B8PUBAqLKCKSfW0HrFijBA/eN71o++jWDYXWp6GvSmfg8?=
 =?us-ascii?Q?a+T319+9cJOeYflft3rMIreH/DZY6WvRrAHK/Ur84XMPGPSa5l67cGNL9Z6D?=
 =?us-ascii?Q?kf6zHmVccINMttS8E3tLef/0CpsbSlKiQH86e3b/QGxqip3T/kCr+7aZwKsw?=
 =?us-ascii?Q?HhgeDfWZ1Ou6uDlzdR7fxQ+fB/jWkWjKmO2uySKGqojaESh7zhjRO3nNuzJE?=
 =?us-ascii?Q?jl2xDuRmQtYOf0fCYOr1drUh/i1fovUWu+ElN9kBXPaawi1umqPvTvrrmyas?=
 =?us-ascii?Q?EHu6/cyppRB0Y6U7cGNbyZ5vTiNjk7z0A4dbgwB1Ly4TmgWmOKvSRVdmoGwf?=
 =?us-ascii?Q?zd7ifWxSWxVyrwZS2r5oM52M+nw04IOc1j7/1P1+jicNoNd8wNE/fBkUwRBm?=
 =?us-ascii?Q?PWeo44z4EH2Y6rrOMGaMz1vZkejGSC1G80fhXhBgJ5wzihp7lkex1fbby0pO?=
 =?us-ascii?Q?d0Iy9Ci8kvGqSczNFPLzliqYxOTQXTj9i8Whaiyu+nfkahOeWnqh7L1lVl02?=
 =?us-ascii?Q?tHnDhX+xSeAeg00oUNEZXKFh8O1Z0P1L0LNNzHW0eQauaNwll4pC2NAjAuis?=
 =?us-ascii?Q?9uA9WFPJ8fIBsTWiqD24isvkIhBVncmTzdqEolI+DLHZUYbix+95KNj6hQEy?=
 =?us-ascii?Q?IN58HuQYGgdPg8UOxenrJLVvookCUnMxABHGQOIQ5GpPbtm4+2C1BaCQCTUM?=
 =?us-ascii?Q?HhPFRoWcSszPJj85yRZmupjgZ1pOw/T0K/qWh5V4FQ/F6wzzpu1E858EfWBY?=
 =?us-ascii?Q?klp6U7PTStAGdlCPRGg5L7TEXrDC5xz/o4X7d6Jp4f9FlXuSUH4HXC/pDDT+?=
 =?us-ascii?Q?anbCbL6SWjgjT2bNmXAVfDGKn0eUKt7gKsvzXu93exWTZJDQfdICXpYbqdfs?=
 =?us-ascii?Q?OwQftuynqU8w5lKPrJbL87EfuEi/GZcG1mVhPRuOpIa9+omQGpIpNDidFgMR?=
 =?us-ascii?Q?exQVJPmNQG7v3/dn82kR3FU9KIyQuTwrEYvx0PBvj1ZOr+ANeOjRyEex0lPB?=
 =?us-ascii?Q?KTed8QdSsL25/zGLXXqQ9WbWrOq2PM6kfYVw48+gBEvSoE0HZNURVmmO2Nlf?=
 =?us-ascii?Q?Am+rp0DOYcICMsYUrjCPZTciU9ZX6Q2BnQFaU0n2LbpVlxbtbRsXE+woUESb?=
 =?us-ascii?Q?yjepGHbinU+nXqoY68NU5ixUUgm+czdkkl7CsrmJH0ymUkTItyJr69xGPmtL?=
 =?us-ascii?Q?ROnrJB5UqvzsJBL3KfFgaGt7Z6+039UkW8G70C4QRjuLywbAofo5GMAhmzuW?=
 =?us-ascii?Q?fmzrV690JmTOdsmLHAKv+6QAXLux/um05xTGe8pzy13FT/UHDjEtbSUs1yZK?=
 =?us-ascii?Q?AWL7eT1U5V8ExX92u4nAHNkGwjKrAGOqXlI/6EI4mVVBw9VoMjceiySnLtxe?=
 =?us-ascii?Q?eIuzkj5q5t9ID4DtTCKvPcyBChd2zMNU5Bebmhi74r1qsTGkKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:34:04.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbec23f-7213-4bad-09bf-08dcffc7b935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

Add AMDI0015 _HID for Designware I3C driver so that the dw-i3c-master
driver can be probed on AMD platforms.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8d694672c110..1a7c300b6d45 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1748,12 +1748,19 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
 
+static const struct acpi_device_id amd_i3c_device_match[] = {
+	{ "AMDI0015" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
+
 static struct platform_driver dw_i3c_driver = {
 	.probe = dw_i3c_probe,
 	.remove_new = dw_i3c_remove,
 	.driver = {
 		.name = "dw-i3c-master",
 		.of_match_table = dw_i3c_master_of_match,
+		.acpi_match_table = amd_i3c_device_match,
 		.pm = &dw_i3c_pm_ops,
 	},
 };
-- 
2.34.1


