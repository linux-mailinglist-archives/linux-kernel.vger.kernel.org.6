Return-Path: <linux-kernel+bounces-298427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F295C72C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07582832F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5EF5FEE4;
	Fri, 23 Aug 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nUgtWjZ1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8362AE95
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400077; cv=fail; b=WOYp6KUuWUTC5lQE7dEvySm673KxA2v1uwYBsD2hTilSwgxpZRmzh9k7GQlHCW3Wd3gbjEtYaB1J1KgW/m9f5bhvsInGgN7BjthALbu6HDEVoV5CS8osaa/sySktwnT9c//ZwRGbMJ+hsk6YxcAycEB8qaXRX98z7y3iWmaHp0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400077; c=relaxed/simple;
	bh=S9q4gKlBRSW7RhKghHFfxNtoGO5lJ52qVLz0d3JWAXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N3hz/0KGX4BS1astilR2ejQhsFy2IUSPnP0+UgVQoZQ0QbmWWoYHoU9EkBXao8rduLP2fnddtI4dBL7546Qz2uPFu+54ZKP0OJf75eB88AMFcmnHf4a4FkKaQwHyU/IwdzdALrsdia/SxAOdFDMOcKCbpxKJXnShGgjGtZYlDa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nUgtWjZ1; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpfcSg41pUnfbfld1Jup4lFE3K5ZTr+3LgekmDyf5mP8q8d5azGkyrv50YeXI6LJYG0KJmKVywppFm0O0S1TJhvKHDqcKMUPoXVvQDfox5o4ssI9NWb7OTvr6qIMjPJ3RwFIgAL0w/WLqBBTEBQ8RMP8e/43FxlsGTPTbyWvlVjbVBOUFANN8tLeELcbyaj4x8XyouqSiFSnxjz+lKbuIxilvvqCvVrZ5k6Hm+dxyfcugyn8vsFKoJ33hpDd5/iyayBNkLeYJbCyjTmIsjJ/IjcDjc0Bq7uSg7LpETuOygLwkAIuNDNQDbXTvRrbulsJrK8KiIdsxBgGPPGjs0avZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAlcOu+rZG/E8cKVGNoX+LpgPQVwpXPdoljFheV3NhM=;
 b=TfSyOykzHArlGSsJRJm84bX0BS/8Y3ESq0+OuvRE8a5TjFd4mxIZjnPuYRaEf0IzvnZE0k6JVsGoxEOVIF8UV7Sjrdl/+ReRqGB1gxSUYbaiNKo5ecFA9KknI27Iz1PdUYo8OwmBVz1iE/2ETPGr32jROtNbx0eSF7wBDajvw+A7ydmLHdqBwH2CG7bKE6KFWjYtbyQMWA2uCeF2nqCGpZ4eSY33d+yscYGlQsKmsI2dCULl4nHMTdyAyWr97M2AnGDLbX64STgnWB1DXxxfH240U7FttCDKC/aCe7MXvZLoJ9iPaG9Ozjtuje2XccMDwZKNAjbWAUCv7op4BekkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAlcOu+rZG/E8cKVGNoX+LpgPQVwpXPdoljFheV3NhM=;
 b=nUgtWjZ1yavo0NrHrTkygJ1K3W+rcrFdVfia1270wwIJJ3pLtjtZBK5OMSE4wtT54dinAcIvZHFCwBJZnwCzhhVY+4xmPx5NJsKHAApfYPauokdFRQdkmcuZDpazPD82sOWisWvvjxHDqn0mLzLGDLTp7/T6orIhKmd8L/Q4XvM=
Received: from BN9PR03CA0744.namprd03.prod.outlook.com (2603:10b6:408:110::29)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 08:01:09 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::23) by BN9PR03CA0744.outlook.office365.com
 (2603:10b6:408:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 08:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 08:01:09 +0000
Received: from sh-genoa-67ff.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 03:01:04 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <paulmck@kernel.org>, <neeraj.upadhyay@kernel.org>
CC: <riel@surriel.com>, <leobras@redhat.com>, <tglx@linutronix.de>,
	<thorsten.blum@toblux.com>, <qiyuzhu2@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] locking/csd_lock: fix csd_lock_wait_toolong() error warning
Date: Fri, 23 Aug 2024 08:00:46 +0000
Message-ID: <20240823080046.61736-1-qiyuzhu2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fe49a1-8287-4e73-c322-08dcc349bf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?91BpekuNYg2rlg3JcO8Q/HAXde9inxDpsHFXblsBvUknPwQyRbOzpBKVADgc?=
 =?us-ascii?Q?1nkR6S41EOAKZYsZs05ECwEPSWmyqQdfA18+UkMgya0nCDhb8l6RQOlj28XO?=
 =?us-ascii?Q?e5QMwSblyizXN7HD6pHVWx/DnlnmQfLuYp2goAJg2GMhpFh9yFKPOl5njPFR?=
 =?us-ascii?Q?IllLDsgpI8ySfhyEOnfe5fRFgkC2PeCE3tk2H5YlQpAzZELbM+3nEQlTwnxG?=
 =?us-ascii?Q?oyzUoY78X78obJ4qNm7/MZeljAldUhifyFC7ChTNh9q0Eq7JKC/jZKCfeIiM?=
 =?us-ascii?Q?0G6v+4EzvPyxaF4yzN34N/8RHLg+vFuDeCMJFPdIS2DNuICXQt61N2y6e6Br?=
 =?us-ascii?Q?0zejo0GkBcfKwNfJBr034I1l4quFPr3qR5Rl0qWbnWe3vaVLIfT+owA6ACwX?=
 =?us-ascii?Q?0Ijb75KHhxQ0Ph9jNI9BqLRMiXzfzlQGzP4Hjw3O7tTFlbZqbmM0FIYRzI/A?=
 =?us-ascii?Q?GF/WDFH7Q4qL/D0vXsU+Ri20N98RgOzVs1YkiQd9Ude3Rp5s187KGAAnlwBm?=
 =?us-ascii?Q?7D9vhlEoRlOgVDhdCIvCKtBqsszdoaAcUCyb6/TVrIWlaSsfmB9O7grkeHjD?=
 =?us-ascii?Q?BSxo986fKTyAxvP3PVYtLSAmQTxdfAnndWvgpMzZ1tXreZha50aZGUN8KQib?=
 =?us-ascii?Q?gUEi3GJf2QyHgwBQCDLuCpV9bxlIcN3b6skpPJiFf12csRpBvB5r817xJxp9?=
 =?us-ascii?Q?KxQFmc8+pCOck07v651OVGEq9uYM9XHmidpYYY5agVub0vuObLmX1w/slVOs?=
 =?us-ascii?Q?+MtU8FDufPiYmiML3KrRFUC2o20SA75WMbHr1Xa/xH4DTSmGHVEnw64y4L+w?=
 =?us-ascii?Q?uL3CfNza1ikmUj339ajiFmmmqjGys3wRTlvvPd5dC3rdXgHUE2naN3VE61sG?=
 =?us-ascii?Q?bKTO2PA4I0d2CuHg93MhhuJRRgIAPCekYBnU6obLNvtspBR4Jh/Vwv4gPYMB?=
 =?us-ascii?Q?QcVCQxS/jEbwDIRYGpAjy5VUJ9tdN+EzAC13ZW3bPCz+vRhOaB1kxvjnHDhE?=
 =?us-ascii?Q?7n/jtF+FEQgXX5OswXKo3qulAkQh48dXeTmiIkKbw70yEthptwGBc7JyxWET?=
 =?us-ascii?Q?N+03cggzrX6x70su3FWlq1/R/5m1ullbFtHH3I8Ampi7yG7lA+FtaAN9A41g?=
 =?us-ascii?Q?Zo9CFz4+nsGEHlCxzQhG0D2yn7l2OobwGv9Jwms8h8TSpOIibm1kvuK2K8mF?=
 =?us-ascii?Q?73I+XGfuk+ejhuIWx08olWamcxNO4xcXdrPaz2suHALePYABWcOV0JjO4eaJ?=
 =?us-ascii?Q?6vJHLA4WAZBwQ3DYfPnvKd6Y7JWKFlIpCy5bFUCbyTFhqXPe2+2WhwepkCLR?=
 =?us-ascii?Q?71nb+5nldKiVGfu9XKQv6Rc/m865H7fmxQKEBksq19RwCY4pnjfsj/Bd5pQZ?=
 =?us-ascii?Q?nI+7eLm6Xx/rNn2XbOeN2bTxysNDbU8cJy4WwhHqzPHbn1S0bHfvh57PaE9Y?=
 =?us-ascii?Q?XkzukgPBRxH8GZX/raY1ywNYKGo8bv3U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 08:01:09.2713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe49a1-8287-4e73-c322-08dcc349bf8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269

From: "Zhu Qiyu" <qiyuzhu2@amd.com>

In AC cycle stress tests, it was found that the csd_lock_wait_toolong()
did not reach the 5s threshold, but printed the warning message, the
probability of occurrence is about 0.58%-0.87%.

This is due to the out-of-order execution of the CPU, which causes ts2
to be used before it is initialized. The original value of ts2 on the
stack is random, which may cause ts_delta = ts2 - *ts1 to be greater
than 5s, thus triggering the printing.

The solution is to add a memory barrier after reading the ts2, which
can effectively avoid this issue.

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---
 kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index f25e20617b7e..e58678d424a4 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -247,6 +247,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	}
 
 	ts2 = sched_clock();
+	/* Avoid ts2 being used before it is initialized */
+	mb();
 	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
 	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
-- 
2.34.1


