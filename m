Return-Path: <linux-kernel+bounces-437163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF69E8FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29031164F47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC34216E0B;
	Mon,  9 Dec 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KjO0tYPC"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0712CD8B;
	Mon,  9 Dec 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739218; cv=fail; b=Lpv69G56oarK0Zdo8uyRmTzWh/RqVA5Pn223ll8LH0EyHw7YMaXoK4Hr+s4SnXBqZrukcnMJbRY3c5VxfIecl8cN1k6DMLE3v8EWRpyL3YME3OR5SXpfxU4X5MOMcq8Qccvhwr0u4TrKZAhvmb1NRv4bWNrMCHhwQYEaLaN/biQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739218; c=relaxed/simple;
	bh=NJO8Cgwc2I1dlNqR1h9bzLEFMoOe5mTMz/LfbCWnn3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRUDHf1ao7XsX3BgwbF0Y8AjKAR50NNfW/QdDgNvEs/pPlyQdzpXymBaiOIlCcDdwnwBnuLtMO9vDGXxi7RsMd8noL3JBM6xc9mwMxR9cXWNnrNhq5Cql1Wk6erruprDnWmkSNtlpkUdpksQVUdgTyUEvfQY1E6SBECV0QSAt/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KjO0tYPC; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX8hp8NgfGr3XRKLPC0ZcPKggl6/WUnfm4J3wKIDiMf672ad1IR86pz3bVLxFBMQ4VuC+Ucl0EPzjz1z19KEhi5U/LAlLHg1Sp4gbCqH4/9HaB1/7zWIocbug4o8EzYZh96M5Nf0kR2v4Z9nXH7vRigdNd6nqcbzUPN+oV21nRHKiY3UpP3rc+J5Ym9/Iq5S8/R2C88rem++ckd9/85SuP5F60OLHoSbrl+Vy5kqFWeUnjFEaBnmaCVuvTysd3TEZ4B5ZH74sdNqogUJl4A2BBY48ITuJa0K3sbvcfhgNavhGQxr9bFUml+ckrYdMwtILrEJwWQjUsu0fqFPhIcWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM8nLPqeo6UIacf7sNrgbVIbkiyyvJ6zPuok1JbUqCw=;
 b=ApX6UshekMq+JFVhlVDvfI5G7rjtBVAAhwssiTd4SF/nCF7KIOg334TWu+AvNjLGJ5tvheZiF4/FjM7mdtfkhWjCWXU+g88ZfBmh6hD6per1Vd8qKCu2TNVh2t6uFmBt3QLPQnx2pI5ZfeJlmg9UTKLsZzEokQv3TYp4XAnVXDnnRsVY0bRE0ysUIx53jRtoU2xiCy8UQTfmNJsSvYbsgv1tAwArskoy4pGqRPEcFNUSwq6dZP+wL3aCQrffZu8ao/DaOu0d/TI5t5J7CSBxqTUCE7lRJ1sw5Uc+uk6lRRhNEs3QJ4kHUsBQymJMbjG7xYmbK3nETkc+jgxtrd4vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM8nLPqeo6UIacf7sNrgbVIbkiyyvJ6zPuok1JbUqCw=;
 b=KjO0tYPC2Xht7p1f7w0gCc2dUEfiRhFSqmcRpN7uYHTbDHyOcVHIum5TgUc36Nh7/ly0EtnY0orbBjMDDOkR6+D9K+TrcGCcS/XPumwgzswOiF6FrTqTql9lNWl8IvvTCJkkjRjiMoZ/vkhVtW22beavF5PKGD0W3wuLTs2f/AQ=
Received: from BN8PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:d4::33)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 10:13:31 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::dd) by BN8PR04CA0059.outlook.office365.com
 (2603:10b6:408:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 10:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 10:13:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 04:13:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 04:13:29 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Dec 2024 04:13:26 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <mario.limonciello@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<syed.sabakareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, end.to.start
	<end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Fix the wrong return value
Date: Mon, 9 Dec 2024 15:43:17 +0530
Message-ID: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 155171a9-e7fc-441d-dda3-08dd183a21a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOC0Q7jMpT/Lm71GoKdImUZXk+T8x2gKeZqhVXDAnNyEsS94kp87FTkvad/o?=
 =?us-ascii?Q?CrG9Pk9lmGXCckbALWCs8OSxNpgr082wKyGj/OnAKJRi0e9ijDW8tYTaMXJO?=
 =?us-ascii?Q?Vw/3YDhwuv3XIduNhjnMlMIdS8I88C5roOx8JqtPDr/h2kSZKSXz1Mgk80pJ?=
 =?us-ascii?Q?q4qDmeJf3egf3iyFqupB4CbgzACLZwo1anfaw+C/T0fc7tUxmGIzaxt/A+dy?=
 =?us-ascii?Q?Fl/cka0c1KbKVsgjEqqMALwDhSdtsPOIWnnLCMlO8x9x7yUrbvCtX/wBJ3Cb?=
 =?us-ascii?Q?Z69TnDTDAJkhjIqD+BdbAuLmKjW57Yt1o9A9W2wbUcZAshEd+3BmDr/tnwtE?=
 =?us-ascii?Q?SFmHKi4BGR+c+SQQP5JWICX1tbrcpASLJW863yHl/sqbKGeF/Fex72B0P6Pa?=
 =?us-ascii?Q?wz1qj/DSKbedx5e6tx96W6lesFFDDA/LM/X603kXXSTVyMr3WTEFJJXdQ69L?=
 =?us-ascii?Q?KjGlAZAU5VxOS7Kc2NbQGK1bdOd50B6dZK7IV6H/NWQcaXkOK4aTQnLLOWmL?=
 =?us-ascii?Q?Ee7gmXxhORzNhG3WWc3rS7bV33WE3dL4el0hg+DeS16cpWi7y+YiDaQbaqxm?=
 =?us-ascii?Q?LudayBl0GTttCTLItAJgSpANmbkjqKpDyWdcyajBHyku0MlE3LR5fGMtQ/wv?=
 =?us-ascii?Q?P500rs8/yANL8R9w3BbEw3RKmIN67fBojnXq519SuyApZTjv+w+Rw6jFpsuy?=
 =?us-ascii?Q?jr1SSaO9CDoW6JKq0q51T6YG/S93JHTEM9hmIdaHE0y2v2/rffaZCAgbtE8f?=
 =?us-ascii?Q?2/GMgkCjx2TW80RJsKE/bJHhZTKgNWG1QUAeE8KDrBYTeMQv5+5Zdg025BDr?=
 =?us-ascii?Q?4KNQLIyauOsyDvyWr4+lhPJHGg6Re/TxgGVfyJVkplr3rzZ8VS6NCrhRC/6Z?=
 =?us-ascii?Q?ulttdEBrhyC9+lVJiuQm+YKqnumblRAjK0d3iE3mJMR0N1GSI7Sz8j8WXHKl?=
 =?us-ascii?Q?64b0JxtLbgI0/To+fvKIcEcD8BCJ5Rh3icZtHx51hlt/7aRpxL6kfHD3crV3?=
 =?us-ascii?Q?6GGKkvJ80pbLf10+T7InkpVvYZSCdjZ9MOBVEuv0NkjYf7jOTA3KHPdUAGf5?=
 =?us-ascii?Q?nls2x6fH0i5bOpfcSvQQP5rTeLTXwnrxr9lVZkUiEtgzLH6Fd3XFh5owTYxG?=
 =?us-ascii?Q?9W/Pve6BXjK3q/1OR5L+rD8/cIj9wPMfO3uPqGX/VLxTafOb/tNFy7AVeQAp?=
 =?us-ascii?Q?bHGd/416R7dtecwr7pFnIhoEk557ZVuNR2CdExg42nU/vozQtotsjJrSwSOi?=
 =?us-ascii?Q?5UCx3ZuKqvr1C/MO6HsYRCuYq2BB18te5Upr+602/U6gCPS4GBTWpSKmVpd+?=
 =?us-ascii?Q?hh+jakG1snYPx0SjfcnrCqyzoF2XYpmvk6Jfy9I3GwQOy1J4bQuHMpZ4SuLV?=
 =?us-ascii?Q?25ThgFpmHQ2Wg/USQsf2OBG9EqyWJoqdr3WyBuZI04J6pqSxDv6pXBpi97uV?=
 =?us-ascii?Q?f1i5+1xigbGC3AzsO2/q/0TJ9nAwW/cY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:13:30.7213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155171a9-e7fc-441d-dda3-08dd183a21a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

With the current implementation, when ACP driver fails to read
ACPI _WOV entry then the DMI overrides code won't invoke,
may cause regressions for some BIOS versions.

Add a condition check to jump to check the DMI entries
incase of ACP driver fail to read ACPI _WOV method.

Fixes: 4095cf872084 (ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry)

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e38c5885dadf..13af1d485eb0 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -578,14 +578,19 @@ static int acp6x_probe(struct platform_device *pdev)
 
 	handle = ACPI_HANDLE(pdev->dev.parent);
 	ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
-	if (!ACPI_FAILURE(ret))
+	if (!ACPI_FAILURE(ret)) {
 		wov_en = dmic_status;
+		if (!wov_en)
+			return -ENODEV;
+	} else {
+		/* Incase of ACPI method read failure then jump to check_dmi_entry */
+		goto check_dmi_entry;
+	}
 
 	if (is_dmic_enable && wov_en)
 		platform_set_drvdata(pdev, &acp6x_card);
-	else
-		return 0;
 
+check_dmi_entry:
 	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
 	if (dmi_id)
-- 
2.25.1


