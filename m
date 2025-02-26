Return-Path: <linux-kernel+bounces-532781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53FA45223
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3062E189C438
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F618CC08;
	Wed, 26 Feb 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="Z+7jwHWq"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F312156F54;
	Wed, 26 Feb 2025 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532906; cv=fail; b=Y92MN3ruPwaiYMbykovcjTUUvjE6lvYYH2dzhyegNOLmFB7IxpuckFVG74lA5OOUVA4spf6BZqNVXYzGs8Xnk5M2+ZXtnZS25SCJgdHr/+PsfpnvtuvHe6T1MSWMVvIZJ9vlxJyuTrgQlNk2p5MW7N2s21mXEpJIfvqTx9auPgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532906; c=relaxed/simple;
	bh=8DnbL8felPvyaK+MZqJeT9cTWLs2h0E3Df44exM+4Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozjdf47qp5bQZLR59JX1SsuupH7PgPokztSqT4kj4ctyCH8Gz8aKQy+Av/lFMicMAIkhio9MF/UzvrHcRSoVMN0jpnP3LK938mK4sVBJo+SPHzJM1b8xz23MUGaX/3NXqZ77ZOm2vw9gHeAit4rUzwZqlhNSXn7iZIrkTKssdhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=Z+7jwHWq; arc=fail smtp.client-ip=40.107.255.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxTMz73wbT+m6FIn9iVc3v4ARngLWFSlYYDedPp2ndcVSOKOEpwP57HgpUGo/SXrvsiXAmJM5abKW9pMyyDZIAL67IGZ3IXjHnWk1fV48N1TrsNMPRuGKshY6bL1bOM41y7AIehE2crMcgwJdVnnca8v/mHdCcIfpq3V+O/NkphgNE0Ox+jHwaMXdkGisVUVaNdu5qtdttXTC5HYQnUrvMgfbR7jy3c2WBHkpE1u49DpuozYXZFo/oUk+bcwXWiARnnoEWw0Kcrj/Mm2HvVj4k9gVDL2Ws/qZOYNavD5is6C1bOg3y2YEF0BQa0xvmEnymcVZ+2vuyvNznFWEYJlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL71UfVBYJeQ/KbzMosS/q5tPZ8xfhtvgvWv8aVAED8=;
 b=X+YfzUtmuLfjg9RaPH8kbZkeOSlb8YnG3dzMgBpLFX2LZWuKFZPZLkIdtzjx6pt1hRZRZhWYJdLD8QXLz8T6FPg6ChTte9QSgKJy37JeBdonQQZk+w5qO67hnlIPsSJ5GDM9TXtLu6B03A+mResMlqC2Az1S/ttGX/cm+t8KwFTHndt6aqa11fuBfavppdIf04GQPTmStgk3EUWpslZzZhkHCZRGiZEaegg1ynWEoJX27OFbCm1VraDZBIcOv5cbFSTZY8hl/4A1vgyJR/y4M+BMSH5Pd2W7wojMLxp5A7VZwIBzo1sXmXS+vtM+0fi1uJLOXv2xX73jKGANdlrHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL71UfVBYJeQ/KbzMosS/q5tPZ8xfhtvgvWv8aVAED8=;
 b=Z+7jwHWqJDD4NPHc566HRCMWX3ugiDypcqkaaYH8YUH/SGF5av1cf19q/PPMAa+tMRxOaLkhMCbNZ3htkVldF/6DME3IdkbhEEF3+qbUwZqUgylGOeFaPjp9rwGIGOkRr/UBzQvP9RcVWXqQxAu99ddfwjc4gTaLjOmb2ZpdBQTLC80OUxV/rj77ElH5QpFKAQsFxvrurEC6VnoCsxGUnHBpSa+AgKgHmMIoHFpkOcm5/i10rQNCg0cEHvdKDJgwEj99jenRkkmBJNUM1ZiwDVD4hCQ20f+uxCf3CTvwlCN73iG1V4fHpDxxPwQZLviWBFAwDnuJAnq+jiaULPZShA==
Received: from PUZP153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::14)
 by TY0PR06MB5233.apcprd06.prod.outlook.com (2603:1096:400:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 01:21:40 +0000
Received: from HK2PEPF00006FB1.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::33) by PUZP153CA0018.outlook.office365.com
 (2603:1096:301:c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Wed,
 26 Feb 2025 01:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB1.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:39 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A0400416050A;
	Wed, 26 Feb 2025 09:21:36 +0800 (CST)
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
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v2 5/6] arm64: defconfig: Enable CIX SoC
Date: Wed, 26 Feb 2025 09:21:35 +0800
Message-Id: <20250226012136.854614-6-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226012136.854614-1-peter.chen@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB1:EE_|TY0PR06MB5233:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 189a7f49-b430-477d-a256-08dd5603ebc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/PFE/UCWQBMdyjCKFICzBiXvcqY4ff1xAQLqeHmPATYjfVXv0r8nk22+iW3?=
 =?us-ascii?Q?xL+oI9AXg2RPa0gp2muGvtem7SqSyU7psxLOq7sImvAMJP5vLxG6CYTcWTdm?=
 =?us-ascii?Q?O8fO9R9srPaChEsYKP2xgXuLv5BGKGCB7EE/9kdXY0D//fiY18rAYr3MJIzt?=
 =?us-ascii?Q?PCbTGzCaziiC8Ur4tTYGKIBMv583l8GsNg/v6quaws26QRK05fnNPqHSir6Y?=
 =?us-ascii?Q?NTHB++gsxnD1AxlnRXvOWAw+7E7lsi44vBiZbUjWjBz14hRJZ+e1r+Jzg83B?=
 =?us-ascii?Q?cjPNgiBiL686vKgiaSc/3ZMNczI08MvVMrQti95jFZ366gsA2rY9mHVGKmVR?=
 =?us-ascii?Q?70eW0eD0q/9tmHYdc1vlPxAAhiqb1udu+ufb1SFcXV7RTX+adXLKYu1jSsrv?=
 =?us-ascii?Q?CZNso1JUPLq3flYWknozvVnJ8NNN0bYvcOmRJohKDy4CDznHb8+n1NJPKnqi?=
 =?us-ascii?Q?vf+/8z3vSXBo90yxJegafNlHJrzORUNaGTkQcatSBFcKkppL69aAKqPA0b+p?=
 =?us-ascii?Q?dLu9RHO2cByHNe03caObGAuvM6agyqOIAygx19QIbjvGy9hBkmCTBp41ZyGe?=
 =?us-ascii?Q?VWJkzre+OeKkPbgnFT1kR17Mv0Bxw9Dvh7Zlwhekso8FIUYKjKqNiJMSFTdz?=
 =?us-ascii?Q?S0Czqij39tybh6/SM+kLzY+664k6Ez8x9j6k/CTc9gJxJtRJlThivnRb2n0B?=
 =?us-ascii?Q?w/BbYz5iv5y8wiOilsBZuzZ6BRgYS97cBe8/VzaBbXMQvIB89anUqAyS9wpd?=
 =?us-ascii?Q?KZQRjWUpJvuofzMNQjndopo03b0D7CkmFCmW9+lZztoRSW5vSIK7s0uHBrwG?=
 =?us-ascii?Q?RcjsuMyNuUY60X9rw4j+1hUdGrCVccUOJ1Y6E0rh9hFALfmcZbXPEIG5aEK/?=
 =?us-ascii?Q?VsMvVtWz+w5IOjtkYtfIZnii5Z5f7a55oGF0Ldic1XAnAXONCyR/fg9GSwAm?=
 =?us-ascii?Q?pt4ZelC1UyiQiTMPLWGa9cIW8vOg3DPm8UnfC0MCNqD3mWSrNa2/dQgCuV+C?=
 =?us-ascii?Q?u/DbDzr3b2LJ0lOnUNl98cvSVsJ9tECkwUIJg3UaXSG7JR2bx9Wd6ndEq1Q3?=
 =?us-ascii?Q?33vcbXRbpOEAZHelAu2zmVvk77lWcxSXYvMFs4aTcQBPUXy4CdnLsX/yi1qK?=
 =?us-ascii?Q?WPGhwe0MjVH0bCr1Yeds449bB3KotIGOQbXrYFJWvUghmS+qlbuZFO7ragvS?=
 =?us-ascii?Q?nlg+p3Ot081AbijRxr64gzQz9CcAV4EN4Ube1uP8V2VhtKfDM5qEzB0eiAB6?=
 =?us-ascii?Q?U9rHwDVwMMuu9Up+8/M0s1DbSuxNZJiVr2/q7Vg13vBsO9P5KgQn4NXGwtvz?=
 =?us-ascii?Q?eOzMcAb/AlUNezjdSblBvFbHEf97UbZZbSpBGQVj/1tTLIQTMeZIR4gAZVK/?=
 =?us-ascii?Q?uJY2zWmMzc6O71UbPJAyTulvUSEwKr+aqlAaccd5tKQvELfdX7x6fcTFRuB5?=
 =?us-ascii?Q?6vV/0yeVnqhKSCQbrqpQKBHlIF9L/Q8JiamYcVbDNlxYDul987O7C8vv2Chp?=
 =?us-ascii?Q?rd8Fif8lDa8WbWo=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:39.4663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189a7f49-b430-477d-a256-08dd5603ebc8
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5233

Enable CIX SoC support at ARM64 defconfig

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v2:
- Corrects the Ack tag's name

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb7da4415599..1dd46d200401 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BLAIZE=y
+CONFIG_ARCH_CIX=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y
-- 
2.25.1


