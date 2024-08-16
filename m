Return-Path: <linux-kernel+bounces-289712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161A954AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E237BB23AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9D1B32AA;
	Fri, 16 Aug 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="syk4bgJy"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD11A01CF;
	Fri, 16 Aug 2024 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814110; cv=fail; b=aZGuEU8RiChkjFvKnTqEN5Tdez0HyIa2IYZRflJILRe8ANZpBGW5+ZAILlY4kmTm+qDnG/EbUStUDog6iW3UL0B0V9OZB/4T15K2J82rVjHyNIR0p6sJFYawwoA9yI1jsNSOls3iceBX45y6odf9MQZDdKLqd3UiuKWfkQ1+8b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814110; c=relaxed/simple;
	bh=ny+RHmN7YnAF5Kr73+YGME4SCTAKd93EqkE0jPHCmTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUiIvJzbTF1US0EYX0Zm605S6zjFQZXkKR34CZzbUBSu+S2l+Mj9mXl7JkEZlQiRwNEOcuvZ2i0D4xHzHwlIe5JIamJP2tiPjfTHG/1d9GHVfYUkw8Boa7eEHCUE+gxex5QLFvJFI2eSQQcjhyYNJXtf48QBNNMIBQgGdmbMmpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=syk4bgJy; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=escdrIlQ7uUpRm64qK0o7MW2Ko7vEVpDPtrsDPfaci462mReKWDG3yF9/TGVFlNvWXlro1lEnB6ayjEac8HqmjdxGRAGe7jg7n1g3/tCWQbWK//B1Y1nMJUrw+HFmu/hfjgwRdH0klkJ630LF/IDB7F4bsNScCI8X50d2r46rsQtPpzfGRIoemdSYG2SIHuNIYU61z9e+h7unxBwEylxiVMA5d/6nFfAFZuduQipYhb/FDVG3DbkKyTX6nF8w4Q0ApiuJipBX2eJ5a9QvssHDHn964UBd3QHK5iSbcqL5jg86KAZqKB4OVuIKn1H2h8zcusr9srXsObutDf8BiJRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EirHK2APLKQyb5ahiM40ocXainQadlhZUcuW4WF/hs=;
 b=M1MzmJA3GCI3Qol8PgWCr6qmCV0XQk36OjV/6oG24M67QAPzq6Os7p9CbAW5zXfXxZuUBvdQitzC6Q5tzhGFcel4Oces0re9r6/e6iImlVc6qg0te5dZ09SxuoRV4AH3GSlCICO3FSMk0b56adtjYWE5NndLp/WwFfz1O3qo/AGUOmnylFG9v0MCps0x208FS5xG1lOtmX+FDCvnlr639gLiR+7+ew6XokIbSo7EufE8O2CGvzUIFQIVNIPdM8/jTIEVsfZjDqhwBsIVRP6YAGOH1/pLNClAg4YptdGx2CcSXw+gou3SFnGFYAcAY118VFN9DtnvDUR8u/9OY4SbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EirHK2APLKQyb5ahiM40ocXainQadlhZUcuW4WF/hs=;
 b=syk4bgJylS5lm8SD2BbBFL89T6WXOAYpBmj5CiUK2TRN07TkHKpGeKi2duP001Uxtm23Ql0jFrQUEDahvuYH672mggokWflthQrWN4B4LKsQGjQLX61cqNxCQV1gCWQAf0VrjPZJyd98OTHHBggYc9qEHKZNTPT5CsuPy3EobdX4i45mg/Ox1Qfs84xEk+w6035o1hvMiQbgqhG8bZ9P1uZL9uUA3OtHk18xXc5RFhx3ksQGseKceDUh0kc+5BnNaDYrHm1yxeIkAP+8QuVC1XtniGjvk1jLIlf8GRFeVuiAC8mpCRcTQSK49s6ZMoO+bqQHe3Br3xfBRocMbgh5Dg==
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 13:15:04 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::36) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 13:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 13:15:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 06:14:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 06:14:53 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 06:14:52 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: James Morse <james.morse@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Rohit Mathew <rohit.mathew@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] arm_mpam: Add workaround for T241-MPAM-6
Date: Fri, 16 Aug 2024 08:14:32 -0500
Message-ID: <20240816131432.993859-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 642b96cc-db51-48f0-0e4e-08dcbdf5707a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3Z5u3lBucu9o2RRTluDKGD1Pm5BJeZMQeBYXOOU28hKu/QsbgMgi4A9Wxzj?=
 =?us-ascii?Q?PBivWkH+ixdLcKUVEe1O1QDnQI/V0xlzA0iAfgnSM0IIgmh8Eghtya2pZICN?=
 =?us-ascii?Q?IwUO2meIxV6w4zcqmzkUiNyCBIllE2vcHALogRFToNg+X0jzEygtEMFCuLVZ?=
 =?us-ascii?Q?4P7BQQgKaZSwx2oH+wZJuINv8FtU6+XECzSF5pJRuRln5QxG+VKH+9aT4wtj?=
 =?us-ascii?Q?8H+u7lAqK3lBeSLkLQp1pmYDhpRW84T4dSxK8aE7aHcbEB+tVWEA18u62PId?=
 =?us-ascii?Q?ffEqk193ZJs3+x0yNcHQFWrSx6nXEU1pI3VO2xykTFgDB4ULREbWS7gXl9ua?=
 =?us-ascii?Q?dipW3vY5qi1RI166ydpwnxPiEsmvEXpSuPNDlKTAGPD1a8XTzHqvjd61K4yY?=
 =?us-ascii?Q?/e+kElxmHkC9ysxJQm2RIhjbfHLSGfy7IY/u+kA4XBv3D21PbeoZFW4HwoLh?=
 =?us-ascii?Q?sgBSMUBqIa00gUgevb04838yqY8wrsOhkPSb8T/l7smIl0kEy6kPzLt6ow1k?=
 =?us-ascii?Q?RruqedssVaUU/vb/XLRm/+6M890nHDv0IejQ6CGBmWQQjtAaj2dFYkIgfqjY?=
 =?us-ascii?Q?4ObBnFI5yZMl+3XMrFgKIObloMco5GJeI7sTJPC2b7VpiixqKCuAC3cOVuyM?=
 =?us-ascii?Q?LfvnwBtiUEvuJxHwVs42kRKVLvyU4skbl9WvTsvzamkPQ8Ww64h3p98NZ+ID?=
 =?us-ascii?Q?QbtwI/w3DzxjSd4S1mWtc2vBJ6D0PNSeJ9NZzUwr7P8mD0aiw18PnwMd7cf3?=
 =?us-ascii?Q?G1P9Buy7g0MoZG/GPqHFvcH8zpJlL7ILOK4kzXhNpaksYevvkGZWRRvOB0C9?=
 =?us-ascii?Q?WWyQIe4fCETkGadNRqiAaCpbRAZPGfHK+/VaqCvrnprmq5u8k5vUe6PNRDVh?=
 =?us-ascii?Q?+smUR4dlnB1yYxUnm/1c6eLsATx0ZSHnzvUs/60TrI4TOq4gixKvOPu/yYTp?=
 =?us-ascii?Q?7A0LhdHqDkAYD2IDmWUZkJItXj6CYD5DvPv0m/m4oMPXE4uNr1HglbxkaftP?=
 =?us-ascii?Q?QjsRQLY8EJabELghcdG1TC2uB7+5nnoykbkkTvK7rARcEx8FAqneu7nZ07O5?=
 =?us-ascii?Q?tWOsnDEa1dElBtOkg8b79Z++COmyZgR1tU0IScsJZ2voJNul9FuzbZyYv+at?=
 =?us-ascii?Q?qCt4N9vO/bA+RCaaXwupU+Wsht8OxjzHF9tGTRyqRpd4XFwSl6wPUZaTVrT5?=
 =?us-ascii?Q?1jMNsbskQuyOdg0QV8QnmGXGr3IoemYZV9vq98dT1gJ4aGPlP2JCQDpbr4e8?=
 =?us-ascii?Q?cOeRLpPtesRTWN142lwr9F4Gh8I33AWs0P7DSyjSveX4K7ppWv4CY+X+jTFe?=
 =?us-ascii?Q?jAK4qgZC5kLsMYB+bifrAJgeMDIaGucTOjaUjfya3sa5KRRiXUMR/vpX/1zd?=
 =?us-ascii?Q?b1wxKKr1Mc9gCtxLTiwOZ2oEhDus3bAVlbjTbC1WMVRLHqwOqy2VUemwyZUC?=
 =?us-ascii?Q?lZaR613ow/Rw7X0JsZ+3hMvhy2P06CEv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:15:03.0514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642b96cc-db51-48f0-0e4e-08dcbdf5707a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

The registers MSMON_MBWU_L and MSMON_MBWU return the number of
requests rather than the number of bytes transferred.

Bandwidth resource monitoring is performed at the last level cache,
where each request arrive in 64Byte granularity. The current
implementation returns the number of transactions received at the
last level cache but does not provide the value in bytes. Scaling
by 64 gives an accurate byte count to match the MPAM specification
for the MSMON_MBWU and MSMON_MBWU_L registers. This patch fixes
the issue by reporting the actual number of bytes instead of the
number of transactions from __ris_msmon_read().

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 drivers/platform/arm64/mpam/mpam_devices.c  | 17 +++++++++++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 1959013447ee1..1733875f41cd2 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -239,6 +239,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | T241 MPAM       | T241-MPAM-4     | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T241 MPAM       | T241-MPAM-6     | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index d0b787dc4de12..cedf2c896ef5b 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -759,6 +759,12 @@ static const struct mpam_quirk mpam_quirks[] = {
 	.iidr_mask  = IIDR_MATCH_ONE,
 	.workaround = T241_FORCE_MBW_MIN_TO_ONE,
 	},
+	{
+	/* NVIDIA t241 erratum T241-MPAM-6 */
+	.iidr       = IIDR_PROD(0x241) | IIDR_VAR(0) | IIDR_REV(0) | IIDR_IMP(0x36b),
+	.iidr_mask  = IIDR_MATCH_ONE,
+	.workaround = T241_MBW_COUNTER_SCALE_64,
+	},
 	{ NULL }, /* Sentinel */
 };
 
@@ -1262,6 +1268,9 @@ static void __ris_msmon_read(void *arg)
 			now = FIELD_GET(MSMON___VALUE, now);
 		}
 
+		if (mpam_has_quirk(T241_MBW_COUNTER_SCALE_64, msc))
+			now *= 64;
+
 		if (nrdy)
 			break;
 
@@ -1269,8 +1278,12 @@ static void __ris_msmon_read(void *arg)
 			break;
 
 		/* Add any pre-overflow value to the mbwu_state->val */
-		if (mbwu_state->prev_val > now)
-			overflow_val = mpam_msmon_overflow_val(ris) - mbwu_state->prev_val;
+		if (mbwu_state->prev_val > now) {
+			overflow_val = mpam_msmon_overflow_val(ris);
+			if (mpam_has_quirk(T241_MBW_COUNTER_SCALE_64, msc))
+				overflow_val *= 64;
+			overflow_val -= mbwu_state->prev_val;
+		}
 
 		mbwu_state->prev_val = now;
 		mbwu_state->correction += overflow_val;
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index 6e43acabdcaa2..266d8a4e91905 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -237,6 +237,7 @@ static inline void mpam_clear_feature(enum mpam_device_features feat,
 enum mpam_device_quirks {
 	T241_SCRUB_SHADOW_REGS,
 	T241_FORCE_MBW_MIN_TO_ONE,
+	T241_MBW_COUNTER_SCALE_64,
 	MPAM_QUIRK_LAST,
 };
 
-- 
2.25.1


