Return-Path: <linux-kernel+bounces-432183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D139E4703
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF0616ACA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45A1990DB;
	Wed,  4 Dec 2024 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vXlKGLrO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332718C900
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348326; cv=fail; b=CojyQraX9Eq2cwnGSgt2cD6uMzs3c0VD92odg7bm7a2bQZ3rDxZbL+LThK5Lf10677teO0w2tudzAAcBc88UZHIESd4E5LumxFwn7CnY/bgTkPKQqTm/2DhixaUmWfQ0k7AI526nZ9Soqz0L4LcowpPHHuBMYroWP76GQWlRg94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348326; c=relaxed/simple;
	bh=PZbRCfDHvh/O0jVJu7Iq4cmxhTQ3jW4Z8XoF2Q71Z68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upqT6AOcl53OFv2mLiBSn/vVal6PRyMPB5W8zZ5WkLRe3oAnZLucdjEOqfLnVS1TnPaFkDn/F5sZXdcqRjLj55ydZqJS2q10t5I3SBVEn9FWWIOAEF0Zcql/yUXQnzbZ8TFUrSoRoeV0ZrNDZw04OkM1MUFEbrDdcei8wZqOTQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vXlKGLrO; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAghY6XTEwmchuKOqaanEzA9rTfaCLerWFuGQwATDRLBPOUoE/DrvWMG+L+/hhyZDHqCiWzF0aEp9u/JTJ+/1SGe/MTTawUSoJubm5M+m5eObOPqvwuiLm2IXs+E7LSMI0B83m0pN278qYeuaSE5hsFzXDMH4QepqWEEvCm2n94HFBlRoA9RzmvGBwdDfRAdZ57j77FAgAhjILLqmsxRbbyhU2ZY7bYihnwD2X0QQVsNpgyzjxV63V/SAeEZ5VqMI0SM1t7b0ykG1gFdvgdS1oK8hJ/0YhkvH4E6//qSVYoOruYoldZcX87ZOj5JzG/7SjnLNIFAWpL/6WbnOZpq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoSjCcvQNLeUIjyTveH7rOTdYtbr6zgdXLFWBdJY+Ho=;
 b=idBv70RDampUSoABECw17Uhc5qiCH9oA6T00y5puKnZjvAy0I+McdU9jU6BCGx987TI9jwvkEdPxd0ikakvXJgNeRcSzb1Sr1/wqTPW/ICM6fc0K8A2HsPf+s4ElFF9D3kLQFLJmQwjxan1LsAvC5cd7q7PiXWaMWLPfNONhYM6r3LkkT38WebBRCOkZazR9AprGjQ/x36HgVgL3K9tG6ljgpxO8TncAc3mActYp44CVIt480naG8co2CcCknYWXap2/m8jASXTzKg9p0y1SBcFPrIKBFZ92u5RWxRDjcsFP8FbMKrXo0CkdHcgAbk2Hj0MPlsFhUyFB3zmbsmk0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoSjCcvQNLeUIjyTveH7rOTdYtbr6zgdXLFWBdJY+Ho=;
 b=vXlKGLrOFYXXyF2Zl9c8RqeCt3gPIgw8GDkpihsejBj5p5rMSuH55onPPM/Ust4l8isAwk/fZR+9UGQr2yA1vn3TBZ6Z4zCplxfom1le1//7xAhx5667m5h+6837ppisfgCNKH2aWgaF0b/g1LxRqGf07OHbBGSZZQiwbNBzJXQ=
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 21:38:41 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::f6) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 21:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 21:38:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 15:38:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 15:38:39 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 15:38:38 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1 2/7] accel/amdxdna: Replace mmput with mmput_async to avoid dead lock
Date: Wed, 4 Dec 2024 13:37:24 -0800
Message-ID: <20241204213729.3113941-3-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204213729.3113941-1-lizhi.hou@amd.com>
References: <20241204213729.3113941-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 45838a27-bce6-4809-edf8-08dd14ac04f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6LT9I4FSvtf89ely9AmmEOVI1joT7uy/bZvzGkNFqdv5ylDywZQzrtGjLYu?=
 =?us-ascii?Q?3sqy1WmjhvKLIbTtBA5vNwo3X6ks7eB5+7BKbviOvfd0OY+wom3+FyU7bGq8?=
 =?us-ascii?Q?eBPbqjyHvaNhDJNddyGQWlN92TYvR4JTtEpMjJRVoQE2P7Zl1DN1AYIbA3Yd?=
 =?us-ascii?Q?wVyw0Qym1TjyQsM9kM/abK1yJIqrLN6GM9vCY/6oHrmSNlKxmKUJnPsoQvq7?=
 =?us-ascii?Q?LS31sYv0tsHIkDIPK+3cuuzRO3zz/uff8/Ri93ZZxowklxEGfhJYwtBf5jzn?=
 =?us-ascii?Q?QvbT3HBs2DP5FdA3F3/KYfIWE+DblNUGVF1PKzazJmGxCo45Q+t+UwIZcQio?=
 =?us-ascii?Q?s2oVRiNAdS5gfremvb7ZS72sFJOYJC0QKUz7kq1rrNwZH9iIDIpwEqqJSkjN?=
 =?us-ascii?Q?QLKvRIwro7vFYtYH5S7Z+URK6y0Ep+jQcxl7dpgiVauHcTJ0+1/5yYkPhhXe?=
 =?us-ascii?Q?yUNHc4iN8u+9GgHJA9dGJ6rtdfzRD1d0iIKjzkqD7nI+FW6Fo6LojQPg74Jy?=
 =?us-ascii?Q?WUsDgpRetznaRG7X846WuHdIoes1yg5kkBk0NrDQNvHmU/mtd+i+VHb0BaCu?=
 =?us-ascii?Q?HcfSO02Q797sAQfO5JnHqqLlh0++UeAg/v5+FkDDSaLubiFsBQh6jj2f7jQ9?=
 =?us-ascii?Q?dFYJvHfmJpxaFHHVI5gifKAJ4xZdk8/xGU4o08gPzkIKyiVhkdaBpRLDEfjy?=
 =?us-ascii?Q?H5O9i3W1HMJEESTwgK4wR9cQdYN36qAtuDP3CTaXSiXDCpOJaSE6odgfaS1s?=
 =?us-ascii?Q?KH3s2TZ+avVVQ6CLpWvAQO6xpA3qtWyIi2l4Nf1zKyD91tSVCq0Y0tvNP+4k?=
 =?us-ascii?Q?rEpgvQorNYzHOss6N5zBo7PQVe5o2K8xUkpURnG7S5TWi/ZUH0E8LYbNRqLg?=
 =?us-ascii?Q?Kom7UT0Q08WpqsXqRPu6AEwvTCjlaoHtz/nNvZi5ti14Rax3XIcolGrYM9o0?=
 =?us-ascii?Q?c+IudvI7Dvp6K+XQyMhaq485XY3DWScvK+OiD84U+RqIIA7iGhgsj7T4FTwi?=
 =?us-ascii?Q?40lBoL6r0Fqkg/rFwDRt3+CkIuZ/i3gfxP8uLWkEKG2jG3mzbdUJmoUIIE34?=
 =?us-ascii?Q?uB8cJDrFm6kp0/Ccp22LjLihNzzMbVFYZOvyDsD6QqIGF3TkZnEkKXaOe3g6?=
 =?us-ascii?Q?AfJDASSHV/z2tPReJRD3Gra2Xq5FSHH7hBno5wvlsS/tKtYxxZcBGb4qmW1x?=
 =?us-ascii?Q?tUJBaq0zF0I6cjeWqj6DOsQgRd1oBup9Uy/NiPaA/4FVZ6yD2Y9RR2dGtXOv?=
 =?us-ascii?Q?J52cuAu8AjrjCTIRbr9mv9ndCp763lvZzBbDBlAXUEoZifa61uH2oLzfLxq7?=
 =?us-ascii?Q?/Yzn9oF+9PxbDDOMBpxVkLr+o33zEW5FmkmTUV8vRtyPtgG76wbh5rbHheCR?=
 =?us-ascii?Q?PGggZixmo7xR+LEOQ/PChVkzFyr6Ih88nGvplsAFP4TGQ63XMtx6GWt/RH/2?=
 =?us-ascii?Q?owyJn40honXP1XLp9APuSsBnKwn1qth9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 21:38:40.5526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45838a27-bce6-4809-edf8-08dd14ac04f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

Hardware mailbox message receiving handler calls mmput to release the
process mm. If the process has already exited, the mmput here may call mmu
notifier handler, amdxdna_hmm_invalidate, which will cause a dead lock.
Using mmput_async instead prevents this dead lock.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 90e8d87666a9..b5282555bbf2 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -179,7 +179,7 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
 	up(&job->hwctx->priv->job_sem);
 	job->job_done = true;
 	dma_fence_put(fence);
-	mmput(job->mm);
+	mmput_async(job->mm);
 	aie2_job_put(job);
 }
 
-- 
2.34.1


