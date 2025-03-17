Return-Path: <linux-kernel+bounces-563524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E3DA6436F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C3016E3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA721ABCC;
	Mon, 17 Mar 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p/CUoNVB"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E4215046;
	Mon, 17 Mar 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196281; cv=fail; b=i91ufRLQYJzmBTt7RG4BzC9rik3T/dP1UwPkt8hC2/t1S03O6/s+MibelsolIjkjiHS80zGx3a3TRajgpOzghrcqVs9s2yQuMJmXZqZ6NPwGywRExBpUZFdPjPCxNk2uUu+YnNwaowp0LXRsVJtFefxPPSIB3A6v7rx8yZvni9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196281; c=relaxed/simple;
	bh=s5oamb6a2qmfpjMpAPuFgUrH5vberIukY87Q6gKzRrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJ5N0nT5RB7gfucWRUftWAPVhyDZotADScqntSS3jF9z6v6o7LtKx9tnqion9F70EFNIP5IzjjY0gngtVqEGJ7dTyq6yIZNarQOZDidKuLNQHs+IGbth9AQYiSj0JIPGyATzY3Bsk4B8O/MXu86hVb38wG0uaqSxNODmIKVpM18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p/CUoNVB; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrzP87WLUgyhZ4EO8Z0lmMDwS5cLzTpRsFZF0nlWX5lXspldEyAuQgRij0CY15CISIyOXr0IfPFQk7abyTL+4iabdNboD5h4ThGRbhle3um8zeYcd14847IkK+0nGZvOTBSlyIPpErUZPqzVVC7Ag3c+JYeQAnWXHTQ+bOFc5JuDQhgHM+ROG57HK+eqrGoa41iyFQiR6ph+dWt6Etbf3pMBBWGPgir/rcUYsInCho7s9ywvxmuF9xdGfvCkzwdUs26kNvvsdRYs2sB+74ZrbC1g66Pf4DznFmuM01r3wpqVCQdrhBtkp9K2OYcM0C26KRDkIGJsm8TCfb1rbxl85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggqSQm2k6sUoN56arrnjYVBjyLse4rBrlSmLhyqOgnw=;
 b=FZnZKlr3WXP9KEXkSyzQDHNiGgej9abGg33K7m9VM51+YP4PggmbE1VcAFwGKbeV0G9eo92wTtHV53VNRAM2H2esPwvpJVxHMrN1Pmi9tRnNdxX9cuOeU3zTHQNzeui2QCnZK1pm61+GiXnwkyESSXhp7oqeCdzeDBJN/7vpRR7/xRyG1bAtZ9RXBw/EC1L5+wZXezo1bW/LJh9/3OiYz/j/2aazZrgwG7u2pCSYfyp+If0UHBLcGWP1Rbqj3coRFr0/wSbI18d5yGn3DaHSOFOJSW9fuBhrGrKrrENh9KOymKRe2XYbe4IITeW+j7EOaDwAjlx9bUsGlhZ7Wo1bBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggqSQm2k6sUoN56arrnjYVBjyLse4rBrlSmLhyqOgnw=;
 b=p/CUoNVBaitlDgdqNBpDZjSAARZ4mZBv9vCK9AxJmAt0F2YRAYlCUml2kSauYaOcqM0xD+XfJPS7S36AVFAJRScrEApeWiWLX2hFBqcJB50xRtSP69Sst8jjDzlqgqpdZXcKloHR0troegjvaoIYbsGpPLxLKTIe0265ciAugRU=
Received: from BYAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:c0::16)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:24:34 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::af) by BYAPR05CA0003.outlook.office365.com
 (2603:10b6:a03:c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Mon,
 17 Mar 2025 07:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 07:24:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 02:24:31 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Mar 2025 02:24:27 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <mario.limonciello@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<syed.sabakareem@amd.com>, <nathan@kernel.org>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, kernel test robot <lkp@intel.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: amd: acp: Fix acp_common_hw_ops declaration error
Date: Mon, 17 Mar 2025 12:54:09 +0530
Message-ID: <20250317072413.88971-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317072413.88971-1-venkataprasad.potturu@amd.com>
References: <20250317072413.88971-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: d0776bef-4b80-4a13-1d8f-08dd6524c482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkEzTDFOBBIc4WLr0h2s0cVsb79C8D67tjN4v9USn/HEg8YptY6DaBHfi64W?=
 =?us-ascii?Q?A4ZxLgeTOjQKAP3P25nSwckZWB+Ja7Pp9gG5xc9y6B4y1CdlIRZYlv51IKUp?=
 =?us-ascii?Q?y8j0Wk28gCnfjYCsCwZYfqkp5F7mvwLss8tqvSc1UMWUj/O174EVkhElHwg7?=
 =?us-ascii?Q?WE+i/TD+6ce1V1UTHv7IXGZSa6nfA0pdXNBr1zN6XCtZYgWemwHmeaQjRzd0?=
 =?us-ascii?Q?AxOH0RXe2naYV05Mg5iFXahOKWBjvQCH8BWEsXieVNez2Nz8dsByaWrhEfIm?=
 =?us-ascii?Q?4yWtDivfmyH4i6Z1I4mRNF0iUuD8AMHsU/1ufPVBP7xUxZG91DYvuOoIzxqX?=
 =?us-ascii?Q?5PSvcmAiWAt9pYHf86RXQRAsdRKEGc+KOyisNGrCjSyd/OPfUP3ixPM5qXHM?=
 =?us-ascii?Q?vPJqdeoYip7yXEIHpfG/4gtijkYsucTGD2CaZbyk4+Q5jIwidNWPqH2+b0yX?=
 =?us-ascii?Q?i+xEV9syaFVnrM4QBqpc6GF4K3kWeXO0zIYBw/T7rZ1jkgLoX3z25+hhTk9t?=
 =?us-ascii?Q?y2T4mBIqq03pGvCBhwLhVqpOdQsr5u9v5bBu8LbyDdUv2MrzEswRSyey2HCt?=
 =?us-ascii?Q?6yXWuV4x55OXGu5jFAH/PRdDjl0tFpFeULPgZzPKjus9ErkawdkKMPCn1d2p?=
 =?us-ascii?Q?KzR6Rd0lWPtEoxHzfz9Zzw8Yqgivr7SfO1vhN30W+VIQtmuAPJKZXfSixGt2?=
 =?us-ascii?Q?XlrNZtWM/pM/b4UUUQfe3DWC16H1+yhnTx0+dO9kT0b+ZM0b2X1qO6428tFz?=
 =?us-ascii?Q?awWElKWy3uUjWvvqQ1T5hXYhSN+zr60cW+9uryBiaCwaZ5CBa9sXUz9k1GzR?=
 =?us-ascii?Q?YxrKwCgxuQEfvrJlW8CRCqLQI0ZYpViuj9LEz8HOtl26EcX971VjfCsK1No5?=
 =?us-ascii?Q?mYkFW5z2peGMJaF1QGb4+YS98Q67mwPueq80j7yxXSkcl4TEe70NjUkHhIsQ?=
 =?us-ascii?Q?lfHVWLuRBiGcwNat90HUhzl0UUeCQjkaK0j7eyQ5bE6gij/e9XCtrC3Dz7d2?=
 =?us-ascii?Q?Rcn5QZlDkNsrVKNIyl/tgYl+6MDy7Xrqexx1pb74/T0xIp56BFfPRY0CQ9Jj?=
 =?us-ascii?Q?oQjqhqmFDIMEg1H9W1hbjL/icQd1q/3lgYNs0sH1IowGrMvk0xr6Brc8ugtO?=
 =?us-ascii?Q?pgTIH7NO4YbmzS0Gpyd+muza2oOP5boKOzl9RCZP8UmidfhxJlJWZNSHVaVu?=
 =?us-ascii?Q?o55OTNDDcF1Q3YxEbdsQ12763dtKSjGCS5qpp0cQxm+yKxNjQ3ba32XRxtqM?=
 =?us-ascii?Q?eWN5rrW7JavEcgcI4l3RIVqsiRdUlNiV/iX+UO5d9mNgOd0tpKlXWfNZVNP7?=
 =?us-ascii?Q?dX+YZn/3zL3O/prTusIO/TO97P4rh0gNj7iRuyI2qlT8SUUdpyCGJ31pMd9+?=
 =?us-ascii?Q?SthV9IGHic6RqFmT4avgPUS6FrJmHNfB9Wq70sSEk2AJO57JY6WtHyJ0E6ip?=
 =?us-ascii?Q?viU72bLhBZHZZTEdERnfx58kw5gF5yNlxJc5UYSZCgydSrx9cA+bwhIf1Urq?=
 =?us-ascii?Q?x8Crc69IJl0Og0s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 07:24:34.5161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0776bef-4b80-4a13-1d8f-08dd6524c482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Fix acp_common_hw_ops declaration error by adding static and
remove export symbol.
sparse: symbol 'acp_common_hw_ops' was not declared. Should it be static?

Fixes: 8ae746fe5104 ("ASoC: amd: acp: Implement acp_common_hw_ops support for acp platforms")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503141442.iT0LHEMx-lkp@intel.com/
Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 5fad6c4a8d86..b4d68484e06d 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -67,7 +67,7 @@ struct acp_resource acp70_rsrc = {
 };
 EXPORT_SYMBOL_NS_GPL(acp70_rsrc, "SND_SOC_ACP_COMMON");
 
-const struct snd_acp_hw_ops acp_common_hw_ops = {
+static const struct snd_acp_hw_ops acp_common_hw_ops = {
 	/* ACP hardware initilizations */
 	.acp_init = acp_init,
 	.acp_deinit = acp_deinit,
@@ -77,7 +77,6 @@ const struct snd_acp_hw_ops acp_common_hw_ops = {
 	.en_interrupts = acp_enable_interrupts,
 	.dis_interrupts = acp_disable_interrupts,
 };
-EXPORT_SYMBOL_NS_GPL(acp_common_hw_ops, "SND_SOC_ACP_COMMON");
 
 irqreturn_t acp_irq_handler(int irq, void *data)
 {
-- 
2.39.2


