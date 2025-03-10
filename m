Return-Path: <linux-kernel+bounces-554885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2FA5A305
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D143AEFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB4238153;
	Mon, 10 Mar 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ce2mioS4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52E22E418;
	Mon, 10 Mar 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631603; cv=fail; b=fMoOh6oyd8Po7JaxHhc//D1HQH0J4JLdLi2/qVQK/TyyGwYNqwU75qv7KB9YZ0lrH85W8P4FM24fr+vUp9ImEPLE7fyollpIt7ycSNwEhNfhbfUp4BsH3LFM+cWztPrCVVkK267gLC+esdVySbif1nEUbUVB3Gzn7Z8MbBpIUNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631603; c=relaxed/simple;
	bh=in96+jdfE9SvEmCM3E3XNbeeIxmOfqymBnKCPwm+47A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igg2N1etOQ/of2BhWeuw8CanLkLIkg/vw3BebvGUaJiVYMRfjbtouO7gWLUT/bCtvpB9vqFUP67xOuLCtWmXCdsO8mZ93n4pMM78Qjkwv0SGj+8quZQs8FaZhoR8hGGmbt4PPm7cPJ0mx8LFttvPyGAj9jF9YGNAVkQ/Igp/kZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ce2mioS4; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOq0FvyMpDGRlyJsw+twusHoL9XQLVf9060Mldv4arEiFnkdO3XrefTYU5RNzmjGCk1Fj/QkotEPSGoWuJ1juHtcNjZUaFS1rS5GqPWVGt94xQOYLrixhLGWLYKycmKcNtpZMtkXM9o6r7xdmg3y86L+QqtvAn9mkEtGBZ/kx08fO5BaurifMzVk2vOV/gxJ/mGVuwvoP40gDypDuw2nrD4NPa4Ld3MAphu48bAvYGIhRRN//A4sKuqCmhMwObvdLBF43SJx3xgt55EB+6ymvSRPmB9k9dpcR4qaVBk6jllYG3oi+Q+hdG3fTvjsaZ/PLyrFEmCG2bgqLNE9Y2uXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW7gUOHJw2LfE5N//FTdZ0etwlP1Vo/tPBSentUpyEM=;
 b=cotmePmW98ZHk8169TZUK4EB4Lnxrd0dai5OAiPr0F2/pBskNuThscvCVAFA1QGNiDdNAI6TQZaBQS5EU6AEgx/xIrbuL7VMJ0KEosT5NY9U2AlOLpFipTedr454Fc0wZZsM5NsenccIvRBZ0VEqgZyAz18e7iiBFWhvmyRg17+DOEGb+2V0SL172cqLcIlZ6YoewWRTRwzm9n52n6Qr5ITFK6/N+mYSsUckAjBFp7UvGNf4+wmpDagWdPQ9AfE90m6L2LSm/BXPuoE1p8C3huiE8hUcQ1gsvgKNVAIcsCwmbAhotjdw8mTzA1uyPXhSylr2+nYdz8wDEu+60YM6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW7gUOHJw2LfE5N//FTdZ0etwlP1Vo/tPBSentUpyEM=;
 b=ce2mioS47zl1NZmM9O1KlqTDkpZYAI0NfcnSMWOBVBPzKbp4k9JI1zAXJ8YBRGPyH+b6ItakBkoJ0wy70L9jgAiSuUEaakbqNmkMcemUUwf9t6EAwxKQNHBFH7SoaQC0Q3btitH9TyItL79zgbrNTqA+Ui6Dr13V5czmmN0KaGE=
Received: from MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:33:16 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::5c) by MN2PR14CA0013.outlook.office365.com
 (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 18:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 18:33:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 13:33:15 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 13:33:12 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Mario.Limonciello@amd.com>, <Vijendar.Mukunda@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<ssabakar@amd.com>, Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, "Peter
 Zijlstra" <peterz@infradead.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/14] ASoC: amd: acp: Remove white line
Date: Tue, 11 Mar 2025 00:01:56 +0530
Message-ID: <20250310183201.11979-10-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
References: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f216947-abf0-4322-5726-08dd6002060d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?10tSINYRS6WsUZYp6+Zq8xVEfYH4GpGv2FtQKgOHANWHJ4bA/a1F41QV24kq?=
 =?us-ascii?Q?LFB18FQMfrAw6Wx+ejdIbhGJf3gmny6UBWY0jfU8i+Sz86ajajIYmhqG2xsN?=
 =?us-ascii?Q?90bXaZ7JRbfnpbse1av+T8y06H6l9xwpo6Pr9B5TOadW7yRv9ggeM3nB0l56?=
 =?us-ascii?Q?cHuvc8bDchYFHLqUtr9ekEo214bTys4hhATTboOCqu1duDnvtd0sJAB3Bf1r?=
 =?us-ascii?Q?4SBopsU0p9idAUV6t5idPArDSqAQ7v2fL9FMryIBSi0PYkp7b8cWdcJOeTO9?=
 =?us-ascii?Q?W0X+Upeh+VOJIqibO85gU8jSyf9sFHRWTOb3I2VdtY6poq4XUSOWGmZ5E08e?=
 =?us-ascii?Q?6uJybEJVaueZXUkEB/4x1ZkeIidjrjjDsgL6yYjGhOext7Rmw4d9NjhjMn0W?=
 =?us-ascii?Q?rf8jHnN4y8pwVDNbXsMq4MIDvvyU9gU1+9WyLFb5K3h4JSip6wIy/jhUJpuv?=
 =?us-ascii?Q?Ff0CLB/3lC9A85bMTXNbV96yHLr43BEYAkvf9HMaBbCr7VCtihK1WWN2ufnV?=
 =?us-ascii?Q?AvF3n6L1nvwEzCg6vO/mE3D5RhvwqCxKHKp7GEXJgWvE0vpJbEhIp7ypv25l?=
 =?us-ascii?Q?9PbX8tHK8PjTc8KDY4bGREJNhFFhWbSWNv3RfSQ5bRqIHXJQweP3C7FMxJQR?=
 =?us-ascii?Q?ccBhXvFmDwtP0HsgLAp93UeLM/St9BjmuK7M3gahydm7KU2w+Elfyken4lZ8?=
 =?us-ascii?Q?l0JMI7MiLaIQyWUYJqoWLZGrgpD7CQ7OXZ4+GNGqoJ/ytQisGJtVPhdM5lt9?=
 =?us-ascii?Q?bzLCX0RbNERphbOMUiz+818n9ojyhdJJJWhSq0B7MHO28wNgOd6QXsIGUdEk?=
 =?us-ascii?Q?II7F+fdjdAjh5IzKLJ+XCQXkFrs1anYHWomNf/EOi4QkWi4n3UMLqFG4nH5N?=
 =?us-ascii?Q?csqBw2L07yre0j6miJ8bn++njlvGHVu3iybmlU2HN6ydt9iwlL4v+eHxP+XV?=
 =?us-ascii?Q?eEObMVfloOogH/g0ZbxHlUI5IzrFF4Enx/OoFPM39msgslSnDDOkdqc6DaUh?=
 =?us-ascii?Q?CiW1Rc+dGgX5BYjN4uWKNw1qWcHkzm/uaexxkRV4ie2+bSwBw3Kl9pxlueFI?=
 =?us-ascii?Q?ulAfocqbW5XyYREso5LnlgKD6d9UFL9sMSyx4/hiT5y94euJeUeQnypTK4HR?=
 =?us-ascii?Q?X7apbmekkVrWqQhaVLG8ywz2hxIx839pNXTM+JXM4AhAdPjkjbJJNE00BM+9?=
 =?us-ascii?Q?MwDQ7hg0NePTgZ/mvCssakQc4JzOEAruUPFf8mwhPdJjSvdhQcZSJQQdirhZ?=
 =?us-ascii?Q?/SpHprOJCUkRAFhf638YRLA3J42kR1tMn7VZi7KWV7LVs3UdiMPLWs3ylL/w?=
 =?us-ascii?Q?s4FN5wC2VzQLl9EZUCPPt/aUTwoRDNJOrz1ZLAUjeCJglAbKLhMd4anGEzaY?=
 =?us-ascii?Q?nFjMYt2k2T6nzve3NfCfCfw3yQPEjGbh4IRilNsZX8AcIzOrnTUvs5JEIeMM?=
 =?us-ascii?Q?S+D/IRzflF6khXjNkzOvEjirm3CYFMjgEXnRXGqVWufYsbx53A1Ut+g2Our1?=
 =?us-ascii?Q?JSLBzl132R4TuIk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:33:16.3748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f216947-abf0-4322-5726-08dd6002060d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

Remove white line in renoir platform driver.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-renoir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 2037af67509a..970ca613a439 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -36,7 +36,6 @@ static struct acp_resource rsrc = {
 	.sram_pte_offset = 0x02052800,
 };
 
-
 static struct snd_soc_dai_driver acp_renoir_dai[] = {
 {
 	.name = "acp-i2s-sp",
-- 
2.39.2


