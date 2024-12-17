Return-Path: <linux-kernel+bounces-449611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6B9F5172
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E603168D37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588C1F867C;
	Tue, 17 Dec 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SILm+u3b"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D61F76D6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454520; cv=fail; b=IkZAjB0NPjsIHliXoUcqF+7H85ebAJVKbephhlSYOXXxtv407pgV+ftuP1B560aqf9xGQEvCM3pltO7jyzW2P2LY70TDvDX9WzPlDLGm6nlelZj5mLFfaq3vhV92TMS3voOKJIgQYY5NbGBwgt7ah/T6Z6DplMYHP/Knsl90td8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454520; c=relaxed/simple;
	bh=FPpvDu2cNOK8xVPkt1Hq+JPrrXebxfS8zIYHJwH1/8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgsTuJ7rjTVO1V057I6XCdwqu5/6LZeiln/OAbze26PnflvzQlULKrwPugAcbh2k1NrirqDR6Cyl8/hdIC5I9YRov6zppw8F9zp+S+klORJZ7ptZkQ4uBiiuV5d3zh60WcZ4AoSru1lU1xapedbEnpEzhtIvIUel2PxP6686quY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SILm+u3b; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqCTqD89NSksiO1m24ftQGcH1aNbDbn/CHMnhnN8L1SC0OQgCpzwVpUTbmEeXpMuTWf2saEWUJqTGkfnhay2sdC5I5K9xI5VEUFxmmAao7t6DIjYjHzSOINq5Cbo9aEoqRLoNEaEKj5eAeSOl1zoIZDff5lEhYNYVlPATluYoqw7HYrNnm0ldzth86iEG1kkyqdJTUduQNGVO0ObUVvI9I6kKemsNmVZVjRJQcVDxZgWApe0ErmfQy8VpLqiHlHLkep2NXNrTjy3V3cvF615MLJeePJW8UJrbAC2PQqfRioPkRxdYpHbfUbbSJbMbm2ciCOK24hyJbhaseRZYQFpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUL+u/FwXBcT+hUXbI0apcTDpqrpGHSh0/gIJvaNK/8=;
 b=ftUcsRELIIGCZWanWce67VML9o0PIfPFqJsfRKyg/c2ce+xXV7IqgsCasqoQU6UvA8CMOD+0fsKH+khy1W1DBEfFu+0RWIg/kkKSPTY2Vy06UOD+NAM50U4vTBkcRmt/lG4OdogXS6ROXGO/SKB2/wLi/Pkq/M+AK+JsLNjM8dyDJg9TK/Y/gpblLrlvSHCQRbGg/a2A4VUnOKVNQB3798wyDPiFFt/6OgNl9Dwl4XqO36N+d6rCa+U5PoQpK0HnRrRUl5AwXGJh1e9iDXd3hK3SV0zzacoOQhTMlaM0y0V7s58hDKOA3ULLUM2tqGgnIpfwBrv77PPo1nwc5hj09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUL+u/FwXBcT+hUXbI0apcTDpqrpGHSh0/gIJvaNK/8=;
 b=SILm+u3bvYYMPmGnf/j+SprWJy9Lx7FQ7+zEVUdX760fc3ygrDSN3zD8DNhKhxqU9yZAgDcmvio0k2a/atLjG+hU48Xz/v0gXaXxdu6M501wakcp/UY8GDThNi4jm4B8YjSRKbRC8N/0f051oETyarseIZvP8P8AGMs//QtQors=
Received: from BY3PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:217::28)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 16:55:12 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::db) by BY3PR04CA0023.outlook.office365.com
 (2603:10b6:a03:217::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 16:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 16:55:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Dec
 2024 10:55:11 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Dec 2024 10:55:10 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1 2/2] accel/amdxdna: Remove DRM_AMDXDNA_HWCTX_CONFIG_NUM
Date: Tue, 17 Dec 2024 08:54:46 -0800
Message-ID: <20241217165446.2607585-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217165446.2607585-1-lizhi.hou@amd.com>
References: <20241217165446.2607585-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 160804ea-d0f1-4cec-d0ff-08dd1ebb92ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRxvIdwgshQX76NBJhJn2ODwRigi1huAFJECzBXMNKWgZlgdUABvo7kw9Rh8?=
 =?us-ascii?Q?7BqNsg+rmX1qNpUq+jRu9WzqlUYlRheEHjm0GzPQL4BxbZ7gBhe+xZZjW7+S?=
 =?us-ascii?Q?ymS5s3aAWHX0y0Ij5mCBXrOy6j/80rfP8IkUgl47+ksTNFMi1ibT0RK6rrkA?=
 =?us-ascii?Q?ZVdUB0LpElvOvz9kS1NIzQAojkqs/gd1haHFDHctMy7bjNkdFJyh05/XkCFe?=
 =?us-ascii?Q?AEK+ACPwdGL+XSczeE4jN3ryrU+wycyoTamo7kZse+MmSUG4vGw68B4OgQ5W?=
 =?us-ascii?Q?dG6JictxhBBsDkd7CgL2ykik+EC0SwWf7m1EBFetvKFzKoUrj6cJG86fNqEu?=
 =?us-ascii?Q?91dQBhdalhk+8oD9PN6dVgmSuhOTanT8PYKvHt/C5aqVy/NNvX0gA2H9uvP4?=
 =?us-ascii?Q?K6cF8FiFNHoPmDJAnyv9wJ0Tz8i2v75O+8NBWwxqMMHTU2Szl91u6y8e7rGJ?=
 =?us-ascii?Q?7LCjfR96YOmSNrieiamUaByD7Hk0/HtEI1NHqOgECpsH+OSSURTyolkdkWGA?=
 =?us-ascii?Q?M1CBNB+aey+30OSnXHq9pdQfUwYOX4AW4AmkVftvESnK8Ywl1amSBVKfpDxM?=
 =?us-ascii?Q?yHYY1drTdUcFWsJAqip+FHhQPAapvwZuGE2GvAZNUr/2mtMApXKBRG7ckJWI?=
 =?us-ascii?Q?pD7G5zdWCgzYYnocjGBEO2ZUmOmqfauK4NKiRCJOF0fWfceDE6k+BPVt4U8r?=
 =?us-ascii?Q?hPnUgJvBJ7o1OvEaOs9Wm3tWWB5/jz4ni4TpF2gQAcCuKeGuZFb5FVUmysd8?=
 =?us-ascii?Q?7jD5Y1q0NFdsbgJHar8dT5y/zc/PSpQlLun22CXM8O/FLGqkh0Mu1PTncyUc?=
 =?us-ascii?Q?LX44iz9QtA39NLMeJRca/mGyuk3nicW9/7FoG7pWdcoe3FF4lmapUzWxI+jg?=
 =?us-ascii?Q?DC681XlzHOdwNGM13RB8pqg7+JzLNeBm9jk/IMGx+VtPk/hJ5pdnZAsh8YtF?=
 =?us-ascii?Q?F1CNGkQPIqUZRoVQt7KwX/Cfx5vPUHj9GV/5yUy3ba8vdJzDUDKWY7V9HOES?=
 =?us-ascii?Q?ql04sgooPsWkj5NBnJCHl0zHrpdpHedtQmPdL3vZ1+T6cjdr6+QVcOl3gR8K?=
 =?us-ascii?Q?eCtFuCtfQRBfaVWDD+gwKunoK0A0tu0BapDF+2kZ+35Lzih6Sd0hn+BIRMkZ?=
 =?us-ascii?Q?ICP5nJuGp/YtcwCmV/Z48Xu57ZmLEitaT0n3soIrCL8BFmcezHcsDHOjgpmm?=
 =?us-ascii?Q?qcjsdVqBhrZaz9GwE8xn4jcyNrSiV+xdvGZAbYvFSxegurMCwQZ827JYSOpg?=
 =?us-ascii?Q?zelBOrLGfgpwSpUfISFk6VJtiXWpp7OnYlF/lT6+wt7gvYgTzRfB9skkVNSm?=
 =?us-ascii?Q?p17S5Wht04YIFU+6/EIJD2wqaa7JMmYrk/6Sqrz+ov83fvxlaCCB1D140Zfy?=
 =?us-ascii?Q?2xVFNZn92uTP0miTrFe8lMx3yPW/TaR5UH4tAJsHjVWLh/i/IKDuFpwiTrkp?=
 =?us-ascii?Q?ye+sRXPsQHvse7jY6Wm44mXVSPgXLDF3/LEaIkU/7QW/QvZoekO5EqbdAgOs?=
 =?us-ascii?Q?HRC215Up1EHH4CM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:55:12.6127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160804ea-d0f1-4cec-d0ff-08dd1ebb92ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445

Defining a number of enum elements in uapi header is meaningless. It will
not be used as expected and can potentially lead to incompatible issue
between user space application and driver.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 include/uapi/drm/amdxdna_accel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index 92eff83fac1f..a706ead39082 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -122,7 +122,6 @@ enum amdxdna_drm_config_hwctx_param {
 	DRM_AMDXDNA_HWCTX_CONFIG_CU,
 	DRM_AMDXDNA_HWCTX_ASSIGN_DBG_BUF,
 	DRM_AMDXDNA_HWCTX_REMOVE_DBG_BUF,
-	DRM_AMDXDNA_HWCTX_CONFIG_NUM
 };
 
 /**
-- 
2.34.1


