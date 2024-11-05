Return-Path: <linux-kernel+bounces-395953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B789BC543
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235241F22B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F01DCB20;
	Tue,  5 Nov 2024 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ysWXw07g"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7931C9EB8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786812; cv=fail; b=kLj0Iu2Vxkah2ObGiujxO/fZJAAATGBYVG/aSxelL5gcJTL2e9T5yzlbtSCEqSZdC1bhF3O/5KHuxdW24E7jjnEDdyOuWB0lUiMS7yIyDjALSGWUmXm9pNn5MwQvb56mUrVy0m9QREG4Bu/zoTKhVElVzpHGfPT/RUdJhyh/Z8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786812; c=relaxed/simple;
	bh=L9Kj9jMLJwcmSloCHAKxBdETEZvfsIPGc0PHNypSIaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6yRueKR9tVOtOhVqVYF/NUqF6ivGD+894JjFdsYoB+h3D5JfVgQlmdGTgsq8ZQNrHPyTIqlTgQCLhNNqO7cGvNq4h41icuPQ3IcW4u+Wr9bnGYu2kgnDrUxGrtB6oJ8yuhjjDuKKNjCWHF/diJm04p5UQDDhSd4jEC2uzaSqTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ysWXw07g; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0yskjh8GrCURLoNlq5kge75QVn0pDFHGv5oefNfHdeROSpXy6cGGXfeqIYP5dF+ExzYbRtLMzdYc+A0QxWdk0xu4IHc5yXhaLhJ3cipSfx5KclD207t4dNRhx701lkP14t45NED67JYo2LeyR1+LOJxxDXuiQf0TUf7U35Ln7YJ5zFjNwnPpxIyxhCShBTu0s4PWHHd+CvDH6sYBSK2obVjBbhyUUMAj7Xq9tJbE46wSA8RLuYvo/US/aC3AIPLIhHENEQdFUcjGXLY9TVeWjtGWMJeEbh1WUP9gekmIo/gynojIYwfoJhiTurZKTNkRjBilIIy27F9jV1z6c4cIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b4JslHMs6oiBL5XFJcZM0H/8+OnMPztOd2O5O/2ZtQ=;
 b=nnRgXU/TdkUuUKow9THaEpsF0iNF337kDGTh8bPVEEx8OUgKnI8w1i7DdIA8LNNtdjQc6uejmziJExrjSB2tM5QMC+xAkua861p/8k0gi1Psl4g315KIpRz86kJLtsEqBt/4ZnXQIgWHHpsKyojtkRZHBHkwv7b71S2UrZqFF+niA1Y11ebeMlsJ82qOcHqLKVTFrph7y5RYHfoeamhyNoo8ZiJeSXyu6t50rH/HdgWWggDtUaOlD66pW4uuUHoR8hrmRnFqrMOuQ53n+5CYzshhNIaGa+RRDFIPi4NxzGn71mViBFTBTytsqeYIpn+N8wWxcJRBmE83WQIGRoytzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b4JslHMs6oiBL5XFJcZM0H/8+OnMPztOd2O5O/2ZtQ=;
 b=ysWXw07grBzEYB71CqMvPFs4kUpYkF0nOjgJiI8eIFJf/fnJl6Kwg4UqNAydOCPqbHi2IJj1Xd2FpQOBE5hVqnob+VpAz9LIbqiwc7LvVO/sxMj2tStdozm1Ge+qjTP3RXzbmcbeSs2QpFx3ikm1J1Pg/OHlD0Zw5HLu/M0wnw8=
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:06:48 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::b) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16 via Frontend
 Transport; Tue, 5 Nov 2024 06:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 06:06:48 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 00:06:45 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
	<Xinhui.Pan@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
Date: Tue, 5 Nov 2024 14:05:31 +0800
Message-ID: <20241105060531.3503788-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: eda62e0a-e3de-4006-bee0-08dcfd600887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7vgwY34GIxBhzpss5ZWG/dqFHn7UTWaRizsTN+LqF+kJUAoesmswqx/SWIH?=
 =?us-ascii?Q?ZhOkOwAWPwelP29MT+7WviTFvb1WduTD1aEdF9wY3nEVEpG17EbEZNhMG0hU?=
 =?us-ascii?Q?PKr8TOFdJU762Sj5WPY3RXJB/FTjmupvvjvd6DW518yu7ttcV62zZYx9bd++?=
 =?us-ascii?Q?EWkO0JBeKqv5++y8lfjFHAejjVNYtEOU8LxYsYFfre95HnzhkDmiMMzQrUkx?=
 =?us-ascii?Q?FynZN02aTtgtj7sT4MvL3eOUQBNxxy0zY2bcuv3jLBYCEtP94K/wt/ZbtvM4?=
 =?us-ascii?Q?AWvF66JA1pCtcV+5e4lKwIhVx6CdMeTXbFlVeaxjkX1YhXc2ezwDxN9mfiQm?=
 =?us-ascii?Q?9t0em3RTOgmKbJPytflDJevT5qxyO79+qg0PrmDjvV5Pnj9PjPEQYIAnCIbs?=
 =?us-ascii?Q?rtfnzLswlQskSbSBkLC4Z9jx2XVZcB2BZx0tYClHDG7IvuJmFvmZYgwIV/Lw?=
 =?us-ascii?Q?ZqNI8PRWgjkOOwy9xBP4/iE6h6fTnUaorYx9q5DBQU33bPhFtiDX5CEUt4wS?=
 =?us-ascii?Q?RIs0osT/9tSWU0eKJVOkhn9DWuprsZSMe78hDcd66st/f/lJZFRBq8krXIMG?=
 =?us-ascii?Q?dbjkW72kPRixBnS4or1uU0F6ceubLeKadv20oA6sdt3boxI6//kaD2NutoTL?=
 =?us-ascii?Q?nJarUjVJqYouDw/LwR3ptCl4p0Wwtc6n8Pa2i3MVo7Ylkrmn/QFXaAI0cg8o?=
 =?us-ascii?Q?9yRneKvo3l4UPAbaIiaZVUYlbijU9e/8BpTEDa1NNfHEHMKXzUh0kn3Y/eQu?=
 =?us-ascii?Q?CobImCPamzrciniT1HL4ydp9JbjPPMfPEF8ng/PzjLL/WAeSEGRYNn5gqGON?=
 =?us-ascii?Q?5O92I9KjTQ5SfktM2Rl+hNW7hv8BgHIqc5ScIVVAM+B+LkvyLZBXmbdsId0g?=
 =?us-ascii?Q?pfi1ga1f7L2xdY81c5SrGm4fNEMcabeOR3QDMDUN+WKBuaNUgKlmg1M9qaou?=
 =?us-ascii?Q?yyp6jyT4BsImy+0p0TAwb5KM8OeisGhWpT/M7hLCe10iRJaH+8hKT89kgEMh?=
 =?us-ascii?Q?UdGLb8KhE75p+T1lot66DfZOkTdhgJCf3fWzSQRkcHaRqJUBziFsPwW6PX2p?=
 =?us-ascii?Q?PsUJUxdYy63QZdFIe1X73W3FqlKO8pRymYVmdn0Uw5VA/ThOAEe+20nd/Vsr?=
 =?us-ascii?Q?mqB2gBR4+U1OcKWrhdEr8DGa6MLdQ2n0Ii049cRP4ulVNrCc47WuVlp/cHU7?=
 =?us-ascii?Q?kXxxFfhVB/qKhGb4IO1eBIcofsD4PjMcdHWK+pCT0+H9FlAp6GRLdkcWWOws?=
 =?us-ascii?Q?+97u6sQxih3MjjIiIP8od70XwAO3Ko0LyyEXpI900rgCZhRiyBI6tL5vYU92?=
 =?us-ascii?Q?QFQOXvTBLUxuOhD/GqlwG7Mr8KZst6AqRyq8hHKAPKpuAoCxEdN9gRH6J7Mz?=
 =?us-ascii?Q?771hB7+GpF9r6Tr7HEaMCVk5hlVgpizCqmd08Ro7/yG5IFIPQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:06:48.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda62e0a-e3de-4006-bee0-08dcfd600887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

VPCI of Xen doesn't support resizable bar. When discrete GPU is used on
PVH dom0 which using the VPCI, amdgpu fails to probe, so we need to
disable this capability for PVH dom0.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Huang Rui <Ray.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3fb92bbd9e2..012feb3790dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1619,6 +1619,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
 		return 0;
 
+	/* Bypass for PVH dom0 which doesn't support resizable bar */
+	if (xen_initial_domain() && xen_pvh_domain())
+		return 0;
+
 	/* Bypass for VF */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
-- 
2.34.1


