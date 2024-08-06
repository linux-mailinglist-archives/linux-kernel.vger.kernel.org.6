Return-Path: <linux-kernel+bounces-275804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6E9489FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D47A1C22A68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F74166F0B;
	Tue,  6 Aug 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bsvKKE9t"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DB165EFA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928874; cv=fail; b=ECyVYmTXoZureoDaRsMu9pzENQEKsVzH82no2cjU2h7M4FOpV9pYpYC3blddDKZlCRVrZA54x15FajDz7R3dr8oIX4qZMLlrm9tzKXh1iJ4TnvPBK7kdG0m7HN6DtrQxq1pUc31juyUxURbVu8KM2AZ1tYAFnVOMpQRpZPoIaY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928874; c=relaxed/simple;
	bh=1QVIt82FmBVG0I3yuGvqaJvOmsDv2oh6yKkX3gHO5Nk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UcKx+v2FeZWsKLyqYbdw6QJmyH5YJ/mCmagg9PKS5T++amiJGcQa3Z/RwGRIqdKXI27JDsQ1JLgUyxFTv2/vQ1KKnVVAf96nxKLdWZMoFEsCrGj5toRK5xH/ark8tNmPtXO7OU5RTWHASA9Onm/VjHGd77/EtbfN/6PTi4M7QtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bsvKKE9t; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpSKDK8X7G0hgw38e7BB2KlzOJX1Mj5haIA6D5aIKZld1Zfb7QfTvuGk089c+dU0w8crmaftRKwQ91L/Jr894WuirboCb/QRoM02WYe9vbcyX6UDLFHYn7UQeYES7V4h3DqABd8QLQsWgbwEoLBJqbn7c+w8qvfX+jvMS+UzuEhtpozIwBfmn4W3fw+ZhUz5uPabiKiCXaJfdo9SthlY9I2t3YrPKbZ/EV0pjgHkk2VvTzfAIQhUFqMBtU/z612FpYvkqXl7Gv73q4zbWEg3TaYmctC7rX+5m5VYuC0BFQAnGhl8H7UBlqZi7TMesAy9MhAHh4nOsecjyz8uaPbsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL3f7RBWjeZETJtpITzRvKwHX5vD3k7400vwVlavQPQ=;
 b=S255N5xBwpSFfejVIfnuJl5CkV0kbYW432N0+AmPZDnL4dzdLdkbyGqniDmZ6sCbmSyiwFsMt378GwxenlM99bN8azykQQjN0FuLCvwqWW/+S339cUwJ/deZGob0vAJO2L2vvvRvBPbS+AQujB6DBbYnG89r5U+DPEfibXG8kLZUGkgQCCBSq89PLiG8jZIFfQ5gvX/cXa49ykoirC3Ye0aF53JXQ+/KABVUfMuJ7/me+sS8CUI2j5Ax5bJRuN0UovslvXh345u6+u6nm0zckWpb99KIEEk7d2NegaUNqZktIUjJ6VFpRMPmzpqlHz5sWiLcSIBDoeZ8DH6lnq542Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL3f7RBWjeZETJtpITzRvKwHX5vD3k7400vwVlavQPQ=;
 b=bsvKKE9toBTtspNRrnNKoINsBWJDQ5wQKJeQ8IcVAIFkKXw5/mup0zVVGv0OiyckRV7O0nt5FqhSAPk2T3u6yQEXwB6dcKKapZf7xQSA0bEPmKFfq9arLDwjJu84ILLAgOJ7QRMAgLQ9aq8/LtJw86lh5NrhMfvPh3i76tQpIV/vIc0dt76zJ99gdlwdSbLW2Z/VhTiPq1juCqldcbMP2mXwlFVKZfAJId+BKA7ZW/7a7JnjXpVOwFJP+Oyq7X/quP/M2Ta1trOKrsdMDO8LQTvNFYVVBZuzFUQKyBoXQZCiC1k0E8fcvncQbpQT2jNA6QQ6qCf3RoE7Wx0rb19JsQ==
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 07:21:09 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::6e) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10 via Frontend
 Transport; Tue, 6 Aug 2024 07:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 07:21:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 00:20:58 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 00:20:56 -0700
From: Shay Drory <shayd@nvidia.com>
To: <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH] genirq: Honor user provided affinity
Date: Tue, 6 Aug 2024 10:20:44 +0300
Message-ID: <20240806072044.837827-1-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc24504-5d8b-48e1-0515-08dcb5e857ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sa8YwTSHRAneRxsaftf2gfzyyevwv5SYB/M04W82U5G9j0XPKCc54xl7xcqv?=
 =?us-ascii?Q?t3k1Vb805yVT9ktuXvkfmD1TTjH5LpU2oSw+xn7TvwGX4R4gsQZjfBvJ0Pih?=
 =?us-ascii?Q?LOCopbAJOtP9lOxU69bO6g8Nl03f7d4r7YHGt0xkPISjFDOwarfUs4Nap4IP?=
 =?us-ascii?Q?d6vYi63GLPIXP42FNYrMK0zlsKPIfagQ8ypPaEvmVvjuqIMfLDccxv2grZdP?=
 =?us-ascii?Q?hnKVLjKRAcmf0BgHeLpPTnWDAOgKddPC6q7IiNh6jglaOVfjkorAP8SQXa4A?=
 =?us-ascii?Q?NMraUVVx1exxMAs35EbRPtQKIMTChglb5OSUj+NY8VEoCahksjeTlune0rI5?=
 =?us-ascii?Q?3424zUArlO0HlKozeKHMaJHiuL5wHoLecvS7NhQ3FRyJyEoDbJzPfUzU/nT8?=
 =?us-ascii?Q?4jUEwyMe7TOUUeFWqU0PVAhfH2+cveJmpacP7ETCJeGLFEHaOKL8rUbT1YUk?=
 =?us-ascii?Q?LZWNXfrKjYnzlqV3LaXtA3sB1j8O+dS7tLY61uaZH51TjF/4mb+iZv5p67ER?=
 =?us-ascii?Q?/9zmCIAZjt63G1laPabGGQLmgRc3QG6WQBgNEm5TnTXof0ymHpc0X2RZpJr7?=
 =?us-ascii?Q?YHMI8BiLZr2N8T3R0JE1eYgKSd5VbguQRAZ10XhdIC8P3+vsiOL4UG5iSdOm?=
 =?us-ascii?Q?fff4Wj8IobvzwmMxEbT/v3kUeGiNp+MYkma1Z7xjEdA865ShmsV0LX9tE/yZ?=
 =?us-ascii?Q?Knz28YVdAoRA64b/CtUlrXnap7r4GMLh/7Zp8LhJKUSwcy7ig43r9W8sUN0h?=
 =?us-ascii?Q?BySAG4K87voL/CL8ekGXM+YaD/dI09IMuAMV9EfsKZSBj0ZFpVwXoMeb3457?=
 =?us-ascii?Q?9JY7eUMsowyV2//4FIWkHv7bpLvuqhvhqkkOazu6RznR8OcQn5eOgYcy/93r?=
 =?us-ascii?Q?UtzINUBDOlGAH9hzs3G66GTbepJA/XcWOkKQg2uXincz69Zzw6+0Qt9pk0cU?=
 =?us-ascii?Q?d+cKWIvwowT464iep3bTmrci04txKfCUHPb6gDC0leJJ+L758zSUyDonjEVC?=
 =?us-ascii?Q?u1ai/Nko0TApYAYNBM+LsbJgl2iAqqyIw3uz2heX51Um7TK34lzJsRvMCZIi?=
 =?us-ascii?Q?Xz/LJtzfNlRxHYl9deKSVbGFeeawfuKWqzuQUO5MxygoJwtZhSo0co9OpB0s?=
 =?us-ascii?Q?9USpK0baEluVYRcxbgqmHJaNOWtInWkZ2iUf2JpVYTZ+BTOHiDOy25+qnoDb?=
 =?us-ascii?Q?pVAq5FcIRZNMqN6cTmx9WYp6BQTnrmFXm34XH1V5P2g6MC5surULD+1tcY5u?=
 =?us-ascii?Q?m4yif0FFU7rcfi5MGQ87pKXpcA6ygB8bASjWy3JIgpRXn7KjDoGnOJnG/OP3?=
 =?us-ascii?Q?xNdMhwWuMEPhgb50rYQxp1OgtjCgcECee8MMEo6GomgKIWmFhOop/wskgwFb?=
 =?us-ascii?Q?SQPnWUcley9nH/pEdZWQo7K6i+pLWkNrj1u8jgJ9Tt7hn1Pkobn3vXjk1m/G?=
 =?us-ascii?Q?QITAt2f2qEtWV8B2d54YanQHJubWqqOy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:21:08.9040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc24504-5d8b-48e1-0515-08dcb5e857ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

Currently, whenever user is providing affinity for an IRQ, genirq layer
is ignoring it and assigning the default affinity for the IRQ.
Fix it by honor the user input.

Fixes: 45ddcecbfa94 ("genirq: Use affinity hint in irqdesc allocation")
Signed-off-by: Shay Drory <shayd@nvidia.com>
---
 kernel/irq/irqdesc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 07e99c936ba5..1dee88ba0ae4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;
-- 
2.38.1


