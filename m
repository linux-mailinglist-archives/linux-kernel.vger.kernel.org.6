Return-Path: <linux-kernel+bounces-523694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1ECA3DA06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F3E189E4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C81F4639;
	Thu, 20 Feb 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xq4J8K6V"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314491F4632;
	Thu, 20 Feb 2025 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054464; cv=fail; b=cJ5fe/7iKvhPPjFHjXuivNUo59iGORPzzr+W5Eq959ILbPunBiuEMBY2xEnzU0mslJKxwS2VS8UAfISN5TDsSu2ZY2k9Dj5spBfl+LX235hOpQyrGEDXben0UFCiplwFXxakPoqmoz4CbA4ZIObok+L5ukhOZnTbsQKhzfHiL00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054464; c=relaxed/simple;
	bh=sV//YLC0KFNJzc5zUtBTqkn5vGCzgzQVBIfoQpvC41k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aVONIsr8j2hVKGtYmDp9WlPZ5T54AWRZMCS8cmN2esvMx1q9+xPGzSSuayYel1IYoVBM5mjHk0Hg01xCELBK7UFQEZMRZgekvGLu7ryQGIgtgTFOsd1E5Icl+3MRek/GGp4rpwWY8SlSgDhMKxoJ/yRo2enYXu0fy2YKjdC4SZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xq4J8K6V; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkA618zE+M1sAEnx/LJCx0xvD9CCEAEJKPVHdrlQKwwAEZGXeEW8/dBwu8mCsqsZtUXlkOZDfw96Lhdv+zr4JaY9ga3I2vVhQBB1h4RDI23QFFVv1AXkxDI3h6gL/8itvzjERJ+IpKLBOS0GHPw2+7y/JKW3FOGJD4hoMYdjJqGauxUL6AspaMO+48GnCiIGKvMi2WXDp7vck9FqAaZ1z9Q+UQ1h8EQn510oORlfyegggQj/a8SmZh8+YO0SWRHdgHwC3tvuptKOxXVRFKRBWZdjCCOtZMP7Bxq/xdKJFf94xFP4plp0KsMLFab+L3xrfPDPbpoL5zMhYZsQDL0rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etB1G5mAzoQrK78l1YWY2LcFpuySs7wlwxKdhO/oWeI=;
 b=RatTJh9OPZPwpocA6uauINW9vWKxXp+HXZ4sZ3jsc2yQCQkxQMks4AZ/Yot3ukqKLsX3FMJTbn9upwK5cbA4MhQOP9WLjfXI36o/sGUp2lmhEPvx1Oh5FmMjqnxhRm+uwJH0G4rTrcuAe8dDpRjw7ablcA2SpVR9lFgdEszKGdyvkOOOguLmqM1Cte+Viq1a8nw8kmzbEZcEN/woR0+LZcGr9Ove5DwJoHWQdaCtb0E5pse/BvnmnI4i5PdNkT2p8T+zfowfrLMkStIv01KJaF5X++ys87eQy4zL0RXJ1EbYvliw6PKjb/kNBH/hKkgGsVGmK3WVM68IfBEorzTniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etB1G5mAzoQrK78l1YWY2LcFpuySs7wlwxKdhO/oWeI=;
 b=Xq4J8K6Vrn4MTgDr9ng69dExU4S84a8/pW52S3u6TADl30nk+YgAGaoCKrQJgBs3vwSGjsyK6ob2U0R/pglRm/VzGeyidwRoX09VuzT0cLlFI5YpiKiol6kWu7gRmP0cneNyNPvuOKEzB1WXbHfiWtaTpceia4Nv/ClMAGwAqXc=
Received: from MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::19)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 12:27:37 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::ed) by MW4P223CA0014.outlook.office365.com
 (2603:10b6:303:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 12:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 12:27:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 06:27:32 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: trivial-devices: Add ti,tps53681
Date: Thu, 20 Feb 2025 13:27:25 +0100
Message-ID: <26aac15b8f0fdbcc2633d3843e216e6c8d30bb31.1740054443.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=michal.simek@amd.com; h=from:subject:message-id; bh=sV//YLC0KFNJzc5zUtBTqkn5vGCzgzQVBIfoQpvC41k=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTt8utcboj88U4T3N8SY5i9t9N3fnDFmw6Dtp/7L109n Hspu0inI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExE8D3Dgh7+/LmBXN639Bcc jZJSefPmVN3TKwzzy1hMUyu3efLYOu4Rt06wz3sg++wMAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 787a910e-fac9-4357-626c-08dd51a9f50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1z30hN4DqhFBpUsMMfLeVMaLQe1ufRpOVU9YwkHRR7mdSOlwikzkg+eUptSe?=
 =?us-ascii?Q?GNZQ7dmGHXY8w35HCyrgx/N8Mnz/dIzX/F5N33+AOY49AaKgJ8Gt8vI2FyjB?=
 =?us-ascii?Q?ocnW69mFyQk4qz6Mdj54NYKyd8/XR4KwvBZmRrQP1eiV47t7AlxtvBhuCnuv?=
 =?us-ascii?Q?OlOxG9wZNmdO2JI9lk+ybvB/wADsA5WcTSHaqhl3KRkmWD5Ef5gTCKFSXBat?=
 =?us-ascii?Q?oHMdHuGWo8zV9TJPRj5Zg4ZRS/xmXJ+BAAaL/xUbvLvn9v8C9EczQ891xMCY?=
 =?us-ascii?Q?rijIkcEaocLO1DCPHCfzIzNKZw1yy2IXG/aSZTlImddC5Hm0IksXW4MGii50?=
 =?us-ascii?Q?azO1eFTlW/a4yJ053qpY+Ke+C9Dgm+OBDzyyzNq1jFrmk6oD/R8AHiSyumYO?=
 =?us-ascii?Q?pNJkxG92/Ob0cPgwGIa/q+8pODQYAfQVsBBGPDZRwlMwid0vSSVzxDXVqBMP?=
 =?us-ascii?Q?HHeMUOS1JNMsWgUKVDHIBHuwPr+pVwe0yQ26Ekl0oVyVaZunpnE9hPXwoc1s?=
 =?us-ascii?Q?69LEAt8KowgBvTeHyZ2bS3wHRJKmaCBDxVn8dOxjl+bGiIKxIX/vBBk+MgV3?=
 =?us-ascii?Q?i2kLoqM4IwOk9Pxvky3A2gy8tiCYDG0tT01WGfMpaIGnL0A/QGzoYdynOGNC?=
 =?us-ascii?Q?qxvf2Shd1wQObZIXf2T8+/ZLvtr9nOnVGUAr+oluWaYUCMHjlJtzDglGKHw8?=
 =?us-ascii?Q?jkg+d8dYUjDXg2P2UtbYro20z+XfhouOqBQ9HG0WPKPgSCNYxsibr+lP8VE3?=
 =?us-ascii?Q?uDZiO6hRMc2W+/5AmWU9xv4811muLqtAItgT9hJYWkM0lYLV/Hal12gLn8pm?=
 =?us-ascii?Q?+8PAs3LNfmYUmDpod3mki9Xr3BT8JI1CZJw/NVNkYcDD0TcBUrvSnGdyda6o?=
 =?us-ascii?Q?6RP8YsB8cRl0cuju8gaFEUNYkXNEIPXTmHSAvkXDs985QRxSYkCYTh9+G9BJ?=
 =?us-ascii?Q?WKIkglsxNLlRTz7TtWdgnt0/jhUtHY0V7z6ADo8gz1axmBkSfSGu5Hy0U/j7?=
 =?us-ascii?Q?sSoOZjvS+0zMhBDtSJtohMVY/IOdF0FhW9BLE2fn+Xz2AffnloCnSok0PKU4?=
 =?us-ascii?Q?9mTGzwLaCz/MOcyzJH1/enzokgnaqWiO0gQw2M88qH0i+3OTWcVSmjALfwZq?=
 =?us-ascii?Q?1pg8MlVuIgEugvdlZTReVvH/jumNXAoqz9WcuMeV9tPno7Qy05q3xf+Y2ULm?=
 =?us-ascii?Q?hSI9bPQrB22Kl6lDY66SQJFnkP+RvxbXOTrplwkVjfGncAF8aOoV6GWpCzp5?=
 =?us-ascii?Q?y1fKWNnSO4gDEt+8yDUbysqyQBscsDoNoWF215L6ClNJ02lV23F0AoqRSMq4?=
 =?us-ascii?Q?qUkkuOdygw1edk4y2aQ3OzQ2fksQwbgnfSvKIv85lnnum4P8DiK1ni/Vef8N?=
 =?us-ascii?Q?xBAWGpNKoOACe/Qu4DjDpLBseTVPgRB5j5EtZsZfWOvKliAU3OGrL4IqbbCc?=
 =?us-ascii?Q?AVAwNP2EzwLymSPMQH9RRHlvai3vYuy7vuvpXWXRmCJx4uN8+Hzy/ciw0We5?=
 =?us-ascii?Q?qVNyFmhxsPFCJH8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:27:35.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787a910e-fac9-4357-626c-08dd51a9f50f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

Describe TI TPS5381 a dual-channel multiphase step-down controller
supporting per-phase and per-channel output telemetry.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Linux kernel driver support has been added by commit 53030bcc87e4 ("hwmon:
(pmbus/tps53679) Add support for TPS53681").
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8..fd6389aefc30 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -380,6 +380,8 @@ properties:
           - ti,tps53676
             # TI Dual channel DCAP+ multiphase controller TPS53679
           - ti,tps53679
+            # TI Dual channel DCAP+ multiphase controller TPS53681
+          - ti,tps53681
             # TI Dual channel DCAP+ multiphase controller TPS53688
           - ti,tps53688
             # TI DC-DC converters on PMBus
-- 
2.43.0


