Return-Path: <linux-kernel+bounces-302994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650129605DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC9C28191A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306B1A08B8;
	Tue, 27 Aug 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpGzVEdU"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED5219DF5B;
	Tue, 27 Aug 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751479; cv=fail; b=LD/dOQeWL3nekJlc36m4CgnB1vUqJBbjrwkAd9lL76jvD+GU8CCjaGE6B938OdIAmPMpw1+ng6bvvRJTc9LrB6M/oko9K+DcAAOkZKRQmWeY9cyFJ5WsV/Tu0NFrUp0V3HztdvfO7hpkBMd8rLidoqNhFI0mPTYnSk0DmFeS2R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751479; c=relaxed/simple;
	bh=xCvwrCcZ0FN9kUdEmOqt3dNT8/JJ6vROXKfTn/pgLP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdaPHorpjmvHJEN5zWmj5XvHZq0jrSwsFotxBNukkTZtXrPjYlQLSi9N4jZzH2tKPXJm6hKSm1GMFdDrI/WVa5b8Jf7n97Bb4qwMsM6lUDADwqwN8y+xEvnYA7mUSOs9LZJAj2gE6OqoZBzE32gF2ldO+HJ0szI4MCMkzn9o35Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpGzVEdU; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZbP4vphPpdjzso+XwZ1yUDGwqRdvu7iQd/rx3y60xBDgk6cDoeKfXLdpqU/B8bAR/YWV9Txz1O683GPptqcpB494MWxObW1ZTqLtNr2MpPJajKF6qSzH33JnG5b/A9oUp63/8klQVD4g7NnoSNWz4/yt/FR2jwU8ZXovylYTZGEza3gBXzpXX4hBqKaknkRbgXKoSH/X4C11EqTiLVp51TOjXHoQ/s8nflcJoJ3SD+9ed3C12muw7UpPPZEUrZKsV6ZmOu2efFwTp7bYPOyMVtEygm2R/KkRU+tORPvs9RnVSncuzJoG/nATnH1D/2skV1dA5o7dnl3X3YeuUDBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lr40zEtvBWhomm+rqSPYu2oZ8Wh+HVttsWbChLgD8g=;
 b=fdv2tR5btCeZ6+2Xwabd364ijHXog/E3mT92tZvIGM2VbVuMqZY58uUHXps4iR/u0Ruyct1/sFDuADkoLlp5B3SjuacdVYBPVOKX+jfBCAv8O1LVah9qWxnuB48nAp2ByGO2a5IQv9vdfHVt/MvwOVkjjLqvWkht6ry0SQX2Mhbi4PfX2ltc92EE2o/XJr2JyIiIc1vZhKFhZDiJCBjw3fJujv2EHyYpEouaZfKcX8SmTFQa7BZY3kHUncw+FR5kwmGI86OVDHuXqPKCqlcOtIs6xxwqtPE1yQCcMjON5gYddJ4hGzwJ9Izh2olKkEin7moLnXKVcng+ORJShO9URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lr40zEtvBWhomm+rqSPYu2oZ8Wh+HVttsWbChLgD8g=;
 b=mpGzVEdUQW+vhlT49tqrRxxb85D01DVhXskrgQjQioLbnN7GcclGagpUghqH6V3mNTTy1rwYv1eOpUb8n5AersHKmmDhKmx8K5AvDOhN8Job8ZXlkqy00RgyAbRbbO4qljFBrdn7LyPw2Zv4JCSBZZEE0hsBzz3doRpV2Iz/aPI=
Received: from MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:37:53 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::a9) by MN2PR06CA0010.outlook.office365.com
 (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:49 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 11/11] x86/cpu: Enable SD_ASYM_PACKING for DIE Domain on AMD Processors
Date: Tue, 27 Aug 2024 17:36:59 +0800
Message-ID: <111a9bebb6acccb53ed90e6e4563bfd6ca04f1b0.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724748733.git.perry.yuan@amd.com>
References: <cover.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: d793485d-fcca-4405-b069-08dcc67becc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8z0tY0ENB3fd/ScGwbY26cf5T7qqA8Ehc7GfxHXl41JEIw8zxKK9UqLYv/sD?=
 =?us-ascii?Q?8IYt1i56N7lWTzUJbAnH3SXgTNx4qCD0KofLvuY5eqNSL2L3+oYNzrAJWSz5?=
 =?us-ascii?Q?lzdI/WnHKh+TXX1JA2/d73HWFziR1i5Vfe6Qx+eZpB5dxDMc+NhKB21hNGcK?=
 =?us-ascii?Q?xqS24Dx3XHMYtNg2kyA5wrJRujd6oTFT5BDOmyA6nedtsy5EnBpSG5lgKLcj?=
 =?us-ascii?Q?6ewX8x1GELStUJCOrIWv44GxSAgUpRYZG6s8xf0LeT+JP41MdTmsVkBVtkEh?=
 =?us-ascii?Q?2T6boJ2L7tTYADO0hqcp1JTrgiVCYxQB1yR+0egKioro0lA+wKrw35BpztmZ?=
 =?us-ascii?Q?fJKkV4EuiQfqIK7FqQe5JXsV/DGXD56e0AFKm9eFvJBbfvT8ed1Q+t99kmTy?=
 =?us-ascii?Q?xLfQC1LxdyJ9lov7UgYq4PCu41Ki0+163vDpC+P04ToZ2UnnZn7wxgLTMUkZ?=
 =?us-ascii?Q?xhELXaVpRkmjZhGx4HI4b6a9u6I46cDeYRa/xrsBukrPFOPg77GvEEgkxorx?=
 =?us-ascii?Q?WPq4bhwAnibf/27XpzWVRVPVWUzf0dFGBzCTazeWjYLv9eS3qOYXGBO+G5cG?=
 =?us-ascii?Q?qst2lmqi82QGC0kDvaxqyQWaOscgLcBd/pieJj9a4QF/RPzWH1n0h0Ym6w/4?=
 =?us-ascii?Q?BPWcIY5o7vzsHbRc+FB3DS1ZTXp06ntBBDcTEsryMlScm6Z8Tvh6WzxUbInB?=
 =?us-ascii?Q?JhhuwI6QtVqTnOGKQeweDSw21+4ILMaQ6Qv3I91oqGojmQXrMMwhsbFBpp36?=
 =?us-ascii?Q?04Ge+ECdZz4+l9FysWTI7dOFH/lbvqvfBTH9gHXc3i6IFwsW8Zx0O+vSNyKc?=
 =?us-ascii?Q?9vTCqTlxRWjLf04agujCMwWCaipWdcfxHIHAsYi7ckoml0S69SXIYtbxMRN7?=
 =?us-ascii?Q?C87nHw8TloKTVQi1cKmyUfQBhoNVbfjUdoQ4lXeuwdsBoWrtMyLUNF7iyhGz?=
 =?us-ascii?Q?LWgocxEteN1kjJ8OawfoT5Xl9+xkb8/G3FmBNEkdPFIgImsHSx9louHXe+hK?=
 =?us-ascii?Q?YCSZrEPzMBC3F6BPfON3n+VfzNyFaz9ThU1HnNYrcJLoLjf04bzwBUdhqvuj?=
 =?us-ascii?Q?IN9kMi0Id6V8tKG3IalTgrjEmAZN1pe0joCnaZvaqwtXSKeoEdPnZthkvPNW?=
 =?us-ascii?Q?DdMwLoZRNH0HbCocMJqBQdCjbobt9lWaDZOI0h22YJyf8sHaKPSXdijJaOsU?=
 =?us-ascii?Q?aPGgDMa7IhSljW1W0Snhu4sEzKIG43Sk+tmYRbhq9xXSN6FmTX0SphB9h0sB?=
 =?us-ascii?Q?yq1CQIrFcR3RAhsKxMVVN3sRiPfHWf59HDSRUOAAtFV/xtloS3asnNCVwqBs?=
 =?us-ascii?Q?3vX4KNkVlZhzr0p6uIZfPzAHT2D6gOlOiQwhnMYF8uBJ+CN07Pt8TYhawV/a?=
 =?us-ascii?Q?WMN4lW52KH8GmUgiyAvPEaYYVS09PwPvmYg6rUyP4wJk883PI+tS7Lp5LhOy?=
 =?us-ascii?Q?BlHOwoqG2+1L4g8W+oKpTnieL0cG5uIx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:53.4304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d793485d-fcca-4405-b069-08dcc67becc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

Enable the SD_ASYM_PACKING domain flag for the DIE domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/kernel/smpboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..16a893322c4b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -496,7 +496,8 @@ static int x86_cluster_flags(void)
 
 static int x86_die_flags(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
+			cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
 	       return x86_sched_itmt_flags();
 
 	return 0;
-- 
2.34.1


