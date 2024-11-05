Return-Path: <linux-kernel+bounces-395952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73F9BC542
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81172B21151
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D881C07D9;
	Tue,  5 Nov 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FkEhGot5"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFE1B6D04
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786811; cv=fail; b=hNonRYzcRFWJZFhPcuqwgkSwZn/K3798jJ9t/r5YH2blngyQcGhhx35eEBg2EwGbXSoCbkT7TckVJHPbY6+YNnb/Ch8D8gUpCteF5gv8cfphenoPpk+EaegiBQYjc0t5QI1UfQCOZbbwCQr24FnvpXDbpGCF/qi/aozQ0dNJiBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786811; c=relaxed/simple;
	bh=JpSGjzXf88GI+NhH2ltmahwTR8Cj9Hhpqwm710v7Y2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pChptO0yodWzNPe/lH7jBo30EgoCF0yCKC1y+cfBO9bg4V7XdHPZAKM2pwyAxyyQFY1hem7wrz/tWzSy/wBn+mDi0CD804twvRT6vRrQriVEKAOUPxinyJKSj9r0tyj5l7Ch5XIdA66NmgwswNNrAZ438qH0KRXAsRbCftmzYlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FkEhGot5; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqATSM7NvGKi6Qh9b8LMWQiuuqkVIQJnJ1kK5g0f6VRYBqs1JG+fG4Oqtp8wvmS1YWN3nI6OLNov5NbbhWZuCxqwWUbmE8gqLTGrIcyz74rj7Hmuhip+Rvf07hMEqtZdJA9gx9EjcLy/SjZsTko69Gk30qXv7VgwO7aZ7AtwDnPPuhxd7FUnuEP1hOuYzdKsXJIgJtgC6ZnVOLdKaNg+FEJpvJLRMVGrZUel8Gko5mMDi9TPUNKUbGJCeGRFoCKCe5zrysP/sNBaFcAz9bvJrMEo727KpcLVvqFAp7J6MnSWjj+4MV6CyKbtKd9lbIHbL6McK9bu/PULU3sv6IwyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n+6/M0lyAEQSyNlyZjktPxl/2+LQVz9skHen9qRloI=;
 b=LBf0OpSNz3ZEoCAkAn2npOiWwPVAHViJSAGJIzwI42vJuT2B9SKSNTkPlNUOd27oWsGcX7EWQ0bHQEMxpJhYRMjPSlGNkAw85eSN+NOYPYrrgIJmwqYDApPOYEaUiG7PawovZXSosu7DxxVSXCFjpIPo9tgcEMS+3G6loU4KiBz7liX51GFGL5p39ofySkDGnvsSoFacW370sI05OYLrVaJHqmmz/PAeR/LH8Onv8AX2HOMV2Bm0CsyGlNTBhZFLOyAjgOYC+Qkj7t0kJpy1WyyPKl1IAed+eEI0Psi+x62gdXmPAfJeFsaagKP8etOcJLrVEhx1VmkpONKTKkg2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n+6/M0lyAEQSyNlyZjktPxl/2+LQVz9skHen9qRloI=;
 b=FkEhGot5lxmWTQf93ckWBUDhEKHrqguPgupoyZY46fjWPPoqSGZYtMLCBTJL+fYipWcn+VVNWgl/2W+5KsOAj/9zPKwoG1IRRcjBevBhCNGIvNex43SmCx0D8qN5D65hRf07zXz7TKoXfX8UXpSeGjMPgrjlGgLPohPqNQjm7p0=
Received: from BL0PR0102CA0072.prod.exchangelabs.com (2603:10b6:208:25::49) by
 CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 06:06:46 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::8b) by BL0PR0102CA0072.outlook.office365.com
 (2603:10b6:208:25::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 06:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 06:06:45 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 00:06:42 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
	<Xinhui.Pan@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Huang Rui
	<ray.huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set passthrough mode for xen pvh/hvm
Date: Tue, 5 Nov 2024 14:05:30 +0800
Message-ID: <20241105060531.3503788-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a09b216-f5dc-428d-772a-08dcfd60071f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5RUPp0TLPlHZG8zQ8D9QrOAFKI84NIIFgAU050JkUQtxJnVePyHxsstCwVm?=
 =?us-ascii?Q?FxH82R6mPu4grTJHKUt2GE20eg6ZqoZWO8TPHV/z8B6MvPi2wAmI/vLkhC3m?=
 =?us-ascii?Q?Cq/leGhxFW/12N35mNj+T81apj6bzLwWGEeRYAwAaRYSR/6d5vQS5l+aaCCZ?=
 =?us-ascii?Q?KP4SiIBSXsr6vCqr3tK8SP6vylx+r4NVknZ5XlqoSn8+z9BvYxe7SoRggU9u?=
 =?us-ascii?Q?EqU9iMtDqFGldY1OFqFk+CnLukrNtg8F2rXP3gxOfJpKGVtusginkNav96pK?=
 =?us-ascii?Q?7mISH4XSUda/AO6LPSUfr3wbL8eIFWklvWyu7OJ5E4EVCogs1Kn5QqDom2m8?=
 =?us-ascii?Q?O837O2KjIOoPHqmDqm31tupDcc6z8Np+NkYRnXuTxFdkhfZmtFjAkctucKgx?=
 =?us-ascii?Q?GeG3FyyyC7S1Hv6zy34/jWTwo9OrKYPbL4aXEJBTxIl0p+p0fvAQ+YBSnppk?=
 =?us-ascii?Q?p4IEOm/aL5no7b/radfyL5spvGyEU6nA2X2CWDFsvwLzJMNsPz5omSjw7uIv?=
 =?us-ascii?Q?Wb78Cs51/7mcQLuWBO5zmhdEe23quiAIxKsZJn4zVxA7tCD7XusGyMfE4d4A?=
 =?us-ascii?Q?Z38/+dh/GD2jeS+x1EEOXpNazLxGSbKH+kAC3eURnT21/hXhjVAwvRLMoipl?=
 =?us-ascii?Q?3BDSKjA1DVnCwWKOBZBBT2mUMRmehqPLy52UAmzxe0qPsW+h1oSfK4uoR+7A?=
 =?us-ascii?Q?oQ45LisgfGNYnZg/GIRUSPpNVxOtWcdqwOK0KPfw2g8yj76VyqsNs+RcZ37Z?=
 =?us-ascii?Q?ZpsTQPblpgVg6DaMsrMGvyGmeb3akOvZZ6Z04ummjgwLnMtihPqjedzsHOon?=
 =?us-ascii?Q?5zfGW5Cc1pqDFveQW6gdqXumfrlf7b3GlAiLTDxTNLHIpKoRvvXfMmihYSPT?=
 =?us-ascii?Q?0+EczFcG4liMKO8VKP+JJYQy/gZ8u3wNRJf2jEgtzypYDMFJJ/75mJZHjiIN?=
 =?us-ascii?Q?HCRl20v8a21RSXRFUmjh8o+lMrYK52Md0tiSs7rj7vQ3UROOeWJAs3ePuOt0?=
 =?us-ascii?Q?FFbnQLOkoci0qbHITPrGiU98mEwztm/m3A/sbIh2Zy0+W+qpxHmnjzLjENTn?=
 =?us-ascii?Q?re9qgd0GFBFwKeC+DK9mpiuFUzF/S1KFfRtNMGmjybtNENPBPGeolalX7A83?=
 =?us-ascii?Q?LhfANJi4CUpAY6jTfrs2/vzdRUNA4OGKZT4v8Vk5/QENmZlVOY1raM1hR9ht?=
 =?us-ascii?Q?9GnywAd4BY4Q2KcuXBFWHP+EGRl0OyosI/lRQrT8yW0Ou5vpuv/tMpR+xaqH?=
 =?us-ascii?Q?gHb81rJ/licexZscPqo0ebLufCkropzEcTri+os4rUbQIGqdZA6NOaOsH4gW?=
 =?us-ascii?Q?T5icR7TBpi0C3bS+u7mXrHyy1zPT3ncml0VmcWZRhVisBwrOzBt/LEqklE/S?=
 =?us-ascii?Q?vUSQF7n3TsfHCaC0HSqiFwq1TNVzFNKXT2sJmtO97bRlMxWqTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:06:45.7333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a09b216-f5dc-428d-772a-08dcfd60071f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

From: Huang Rui <ray.huang@amd.com>

There is an second stage translation between the guest machine address
and host machine address in Xen PVH/HVM. The PCI bar address in the xen
guest kernel are not translated at the second stage on Xen PVH/HVM, so
it's not the real physical address that hardware would like to know, so
we need to set passthrough mode for Xen PVH/HVM as well.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b6397d3229e1..0836fb77b263 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -764,7 +764,8 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 
 	if (!reg) {
 		/* passthrough mode exclus sriov mod */
-		if (is_virtual_machine() && !xen_initial_domain())
+		if (is_virtual_machine() &&
+		    !(xen_initial_domain() && xen_pv_domain()))
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 
-- 
2.34.1


