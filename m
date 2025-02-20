Return-Path: <linux-kernel+bounces-523199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7BA3D374
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B7E7A49E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708D1EEA51;
	Thu, 20 Feb 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="Lji/C+q4"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021123.outbound.protection.outlook.com [52.101.129.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F01EBA08;
	Thu, 20 Feb 2025 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040830; cv=fail; b=GH9As4H7IWNpqLuRIPcjyzz+R3cfR2eqK3IwlNXoP991RfHybWQcTG6Se8FUJ+7CWoV/lvjwTWbblIxKE719+gD4+Z29+8obpvgtn5o8nXkEmLBUa7EqwFivu/CAiVq6HTuxvdW4YaQp58PSybx77aYWGF1dhHYr4DPY52FYieI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040830; c=relaxed/simple;
	bh=D5UxvB/rcwgDB70h5pGi2e6NHHvIJHvHIyZzw52QaPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDnF61OYa2x7vwY21rUtcWmWcxga7h7ZTYo/k8cubdBEUQMimE3jGLznf1nLqHU+Qjs3YaWF7432qu8+8TMg47p3C3RNYIfYSlOJsYamMnli6GUtaXmXRRfTp3Ef8LXAoVS5u+mJduIOGwvIG0C9PgaupQPJjDOOpJVt/LlAxiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=Lji/C+q4; arc=fail smtp.client-ip=52.101.129.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf5evNWLCWXHdAzSBFI/jFfBb3nMw2t0TKhLyJJKXirAajoAiUKCT0TFEppqMpiFMCrdUqjEuTNq5QVWG/JuXfj2c/OxHwTZwqIrUOjCQu+WBLIFfT40xHRYoAv8QcWG4X+2mUpA8IZIysd/bPcnvao69XPPNg+THDnEg6NIEA8+mmrTk4eO/Ev4giuFZ9XLQEtUzyVU3jj1FxpeHE6aC0LdgEL/zF/kQxkih+Daif1Uzbqs+DWL+XtUBhqC9XZOLxfPqnZXYSZ4Ye4LtVridVorNRyotvBxlCSz+bY4a6G/yr6WpGC9H0gQ9R6mWvtth7nWxYOtyFe87qwmdWwAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwHdi4c5jKA/hCUKvJNl9GNUoBuZGBXsnJ1hlhpTgqk=;
 b=rCxl5goMsSZL8j/grer8KtCydg3SyAj8Uq7KgIkeK/lc4iIrBPZG3lDQIySNgrNhaAR/32X7f+fkQfHay76P4B3Y8jz0o68+SmOLxkAtFKSsvvkpDIjY/cd0GvyMMmWRvSM+hO60xSgWi6e8Hja7vBREwaz9AikUKFO0blj/LIhrs1KEBXq1392o8eJhRfyVSsWBZUvkxZojt46QruLhjFnZECFHhjKAf3mtPn3kgsf/brHwoaZhgJGgxrxN43q9p2+C8k3je7BvYrWNtASyhZSdhONiHlVGys8PgBaP+1OeybNGzI3FWTWlsqok9Duw2HA+pU+2um3PRUvuIYKQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwHdi4c5jKA/hCUKvJNl9GNUoBuZGBXsnJ1hlhpTgqk=;
 b=Lji/C+q4f6Ob41sN6iyXQDATd/vq0zK2vKnqLKw8cjFNM7gyZB+6xpM6sVEPC13oimqpsWOWBFDGrVgTZqAaMiCyh9RSIZDxjRQhB9yyNJkzxIbWeGp7eWvgDM20PvhtujPx4gAhMWuSVqsaVtxnUnuBanrt8kb5dVJbbu2IolfK/I6rlM6kbS2VxKZGit+PchNo+zXnr/SRVAl6lD+prZNfULqszcN/QnG3Y5meHvxuyQYMIMFr0xCH/ERxcOv98ngYSSkYBqact9k9TY7WaLg3tc9aeU7vZ5NcG0kxz2znRv/ovnIEFQ80+53IgHq1gUpiOxylbLGnGHX/una0ng==
Received: from KL1PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:820:f::20)
 by SEYPR06MB6375.apcprd06.prod.outlook.com (2603:1096:101:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.13; Thu, 20 Feb
 2025 08:40:23 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:820:f:cafe::7) by KL1PR0401CA0015.outlook.office365.com
 (2603:1096:820:f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:40:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9A3D741C0A05;
	Thu, 20 Feb 2025 16:40:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Fugang Duan <fugang.duan@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH 4/6] arm64: Kconfig: add ARCH_CIX for cix silicons
Date: Thu, 20 Feb 2025 16:40:18 +0800
Message-Id: <20250220084020.628704-5-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220084020.628704-1-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SEYPR06MB6375:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a7fbf37-a13f-4f1f-2379-08dd518a3691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYJpgjqvw3NXxzhXDu3Il2tx2jyelEpIwTK67vP/Wsvgr0x+4y6rpRwTmGS0?=
 =?us-ascii?Q?xzL0s7Z+7a2cNUhuNHQHmnQiidSk9zXWKZnXR1j1z3SJiwAlp5SA+tHDQUh3?=
 =?us-ascii?Q?kfs2cAbsDcY2OI+WEZQFE8CXs5DIfa7oQhVAdkja8eRmYfiKxSUZuuSiCcN+?=
 =?us-ascii?Q?szwPWRZauD+CfBp0vzwiclPhoYtdPCXwvSVi0SWo/sKF5PqADDtLlIlnPitt?=
 =?us-ascii?Q?9Huk5uUE6hyMq01mwucKPrHfWX99xKJdn8/ki901Yn8OjKM35HIvH6cQZ3iB?=
 =?us-ascii?Q?ux6QNsMnwIp0LQtybIdxeW8Kj0FiizoTLKncOfC8Or35avamZny5QgI9ZgDr?=
 =?us-ascii?Q?I8PdNOsYsqwcnXqbKZ/k8ogpWo6gMLc8kmCvCtVfcfo3wm0xkvu0jZO+YBep?=
 =?us-ascii?Q?VTbbMjpZxXOx5J0qlOxAVGVn3cCg3HqUdkcPttlf+S8znGafC9BOhyGqFbC8?=
 =?us-ascii?Q?Gol2XlXrn0Fuifs6pYDD/Ar5MiwhQ0EJ97l6Fe2f76PbeiXfNBcmx9v3IVwy?=
 =?us-ascii?Q?bmdoJWZ0b1EQJaXHSc3dZNxeUWjQOIIdkoj43143ayP/QsOxDwjBPbZKTctD?=
 =?us-ascii?Q?DQyLhSsx2OiT53HbMAMhFJF9c+I/4ynTdxjRPWgzK7wyaiZYFDYT0tfthLo6?=
 =?us-ascii?Q?9d3vkYPWIwew3Htyhx/vtjK16E2SZwR3tXf2jtPitXsJDnbK783MJVGQHYSL?=
 =?us-ascii?Q?0Y3m+hZoFflruBgDVwOrS6vyqbOKF7m2B7tXn6D+tB5IxV/Us26s9wxHbNrY?=
 =?us-ascii?Q?IH9xq90A5XRkUSrlqo0FyipC5DDemKDdHXJii2ZjGRTMKi5ogf/MI2AJCczQ?=
 =?us-ascii?Q?hjOR3+YcQTNAsQq5og2OXuv1ka1tM2fa7AGxFReolqsf/LKc6RvBedciF50P?=
 =?us-ascii?Q?U0FU9yU7hbEzvOc+lONKcjKfPfI18AsWeMOV+sI42PMR8kfRNOoWyvWdXOCw?=
 =?us-ascii?Q?qdqeqt2NVw1qBvqhiGyy1ffyBTttlhiNzYpLRMq6mKyaGNk7KqVqUKVd7SHS?=
 =?us-ascii?Q?Idi9513gP+P480+Xm+xlWwZjGyoET5Ox7wvjff2ZORYPB9RhWmavvZd2BZ//?=
 =?us-ascii?Q?KpZpXSZQy1duW4vh/ujUssLFYyuNj/hrSfaM31jwId0UqCJbpT5bQU3mKpfE?=
 =?us-ascii?Q?IlaQQNbrKfUwHBJRHKIJ+dTKUVeWFY8JjpUxvTwHtMTULz0hEFrllfEqw1Z4?=
 =?us-ascii?Q?bzU7+49d06ttrRNf4eFnqC3b+d7iEk3ff4ul6qAYyAFmkhMHhsOMQLHHkcQh?=
 =?us-ascii?Q?KbMwPsF9HAdKZ2oYHekqoWJv7z7kh1nQZmwh7j9IRPx6jGs+5gMzMMiru0DK?=
 =?us-ascii?Q?7Agtt8/sOJSAMyGcKxlJB/jBofGHcx/Niepq1dBLXXLYLMrdVeWnPsY4nXMQ?=
 =?us-ascii?Q?xJ/95KRWR42QeTfuYS/4wwQ9JEQfeTQjb/GSeT4icHv8cGm4f311YF8muskD?=
 =?us-ascii?Q?EMjaFXhtExPGaIf0KOcdVI6kYuXRLR8X97Sc7rBwJX++7o1VSwNBCZru0Fxj?=
 =?us-ascii?Q?swh7M+f0P9tyozg=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:40:21.6640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7fbf37-a13f-4f1f-2379-08dd518a3691
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6375

From: Fugang Duan <fugang.duan@cixtech.com>

Add ARCH_CIX for CIX SoC series support.

Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84..977b61894cbc 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -399,4 +399,10 @@ config ARCH_ZYNQMP
 	help
 	  This enables support for Xilinx ZynqMP Family
 
+config ARCH_CIX
+	bool "Cixtech SoC family"
+	help
+	  This enables support for the Cixtech SoC family,
+	  like P1(sky1).
+
 endmenu # "Platform selection"
-- 
2.25.1


