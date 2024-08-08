Return-Path: <linux-kernel+bounces-279901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFFA94C32B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F3C1F2111E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F891917DD;
	Thu,  8 Aug 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PASi9naL"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B331922FD;
	Thu,  8 Aug 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136341; cv=fail; b=ELObwFYNHBFptoh2x3rqwc3aWHzLBGmSkIqzbUFH7psov7bNCE9OrZde2l/yaZRPFal932gPL1KhrdtbzvFw4Sj9tW/Th+ZsM9IZO1tC61i0VHbQv8Og+256eWHYfGAPzPaS8wTLPthjJh1r9CWAfER2WRHlnNKG7mN3HFLpDmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136341; c=relaxed/simple;
	bh=QxszdzAXMtanwDxUmQhoRcJ8Iy1ocp7vJQhlv0/g38U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChwRg9JtG4+VmtGHTbJSG6KJXEUknmUwMyYmAsB8b7wS1M3ipWZc0qI7ozFPwhIPafHPQ/KqAQkigXmgM2TNDB2kUsQ8acLi/epW251sVDakiulatfPYL0cZlpR1XRukXzSZ5a9UpdHRzQKYSR5QP50n+/hHbGZ+QJ4zGlQrmGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PASi9naL; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9jesXCd/OAnw5Tb/v1WX3Hz3ftweFEglKlvI2gipJMbY9zsy1JJkEg2GWbt7ZBccXWkVlr8T1ZiQ8HR6WOM8WikKqsBufiFS+SZAtMOi5q8BXDJe+yTwzxC8wvzVFQxhYve+eb7ymLMLkYhRQ+5WXouUf7976PJdnomT6YKQn11U/LvQLj/oVbloJT75KLs/4BdKghvu6+b73vaXiHZy5pW0gt07FQB5ka8lXuezFibVXO38xuhrqEDo3bQFd0aRb0jv2OLUp+TD83i9HADcm6DuIVmY+2iWWhCPHzis5G4spX5oTJlf0YtqbH5Eu/2FdIoPGW3A4zD0hNN1uecfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBNfv35Z9aYp/a4IbdRFX7G0RUSMVnZLZzGXQqLX6hc=;
 b=owLgg+L38fRRozt6fa01f4HgX48zBlN1lKTU61F6k+eb3sYJcR+M+FHHjLDw8ByQjtKxJihcddHdmlPedvO3UtDi0QpWZ75ryln5DQrmjDZUenaFoHO9BP33DIFxZj1ImaLp5Au23LSUxxOl6vKk9MacxYnKt7/HE6nOy65D9WcUlworHMYU8o94vxkWznQtjDK2f4qgqkOHiUufSEXPQXdxThM+Ri4y7BU2bCGsggWC7VMyxwwAlANmScNBF7D4wjYMukZUqAi08Zr4RZrh1DD7vaJ7oJ4NmaHl2gOPPRSdW+F7yORFWiIb/d4+JYc21jRMJBKe8S6DBXD48gtBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBNfv35Z9aYp/a4IbdRFX7G0RUSMVnZLZzGXQqLX6hc=;
 b=PASi9naLVukdrDSW+TQ3pkJw1UGXT9UPnrx+8fIZBFD9doMQJU5UXWuzqRdfVwNewnu6zKBQ6EIJlk8uu8th/yo8vdysAd5z7WS3WvfHM3LrXWMkxlKl0WT7cVsaMB+OdxL7WU0HLmRG6VbhuI186w3vIlTh9ZyS7CbRD10KyBY=
Received: from CY5PR19CA0052.namprd19.prod.outlook.com (2603:10b6:930:1a::17)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 16:58:54 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:930:1a:cafe::c6) by CY5PR19CA0052.outlook.office365.com
 (2603:10b6:930:1a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 16:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 16:58:54 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 11:58:48 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <sound-open-firmware@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<pierre-louis.bossart@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<lgirdwood@gmail.com>, <kai.vehmanen@linux.intel.com>,
	<daniel.baluta@nxp.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<cristian.ciocaltea@collabora.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>
Subject: [PATCH RESEND 8/8] ASoC: amd: acp: Convert comma to semicolon
Date: Thu, 8 Aug 2024 22:27:53 +0530
Message-ID: <20240808165753.3414464-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808165753.3414464-1-Vijendar.Mukunda@amd.com>
References: <20240808165753.3414464-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aaa1210-e87e-4d39-dfa8-08dcb7cb62c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUo2iKPYpf9PrHo19/aMjymkQkT9Q6+peoswE2IJ8fg4M8V4eDQerq0MltCh?=
 =?us-ascii?Q?vsY+hdoJDtWYxXKlOpSEj7r7Hi+t1CGFU1lVP4//yY2ajkMZDwjgiL/0yBV2?=
 =?us-ascii?Q?wx+FcG5GzEmGz67jDCzALcrhl2ZKlBphD7aIsUOHwJDLOc4T79CL5lAPyBhd?=
 =?us-ascii?Q?0sQbKlq1KKsW0kkOYsGvNTZuCpSxTx9vlcLF+zvNVylYIE5HZefjOU6Q0If1?=
 =?us-ascii?Q?niaOdFCJTXiIvFJjpgCyg4LtXK9W9jk67istrThBguyy+XTfaitYqRwf6VQW?=
 =?us-ascii?Q?e/6NoUuh8AImEeudQPjvtN4pszj6/ZM16XrbxpyoAD766OMn8i1svjDFkDo+?=
 =?us-ascii?Q?5pI7BeoBjszPn9N0mt/aT4SELe+xHVcULitygYZmLTkK2ipIucHx4oA1DY9l?=
 =?us-ascii?Q?EDi7VOcFy6UK2Z1ziLgWWe2zkf3MCnx04sTR1oTINUQdFBC/V5SCAg7yhzKJ?=
 =?us-ascii?Q?Pq6zrFAhksh/wHfNELSStw7C9trQa/Y/KCExcOyx3KJOPav2liWohM8Wrcd7?=
 =?us-ascii?Q?xqOtrAn/p5MW07e3E7O1M1yu4lv76qA86SiPsyg/39vI8EQPN/YyJnfW080h?=
 =?us-ascii?Q?wGb4DkvjVRjONtVDzBGm+jmrWayxrSkIt62hwxO/kSAbEIQAHdUQwzDqB+BE?=
 =?us-ascii?Q?L9R8ZqewIwh5sl85IUrFqdxgXi09fbOjiaMmbvIQFG4BGU3FWowjmlaWRVvt?=
 =?us-ascii?Q?XjHWI4RebYxWDF8TWx2G04UcGayEPvwT38msZjbS4S1KKjFK/1VErZLUWv0M?=
 =?us-ascii?Q?YFt7wMRM4oT6RYlblzTG9VJqho08/9OMdMhoreZNmXCN3fNXlj878dj2zv6B?=
 =?us-ascii?Q?cCJpxiwmOjFHCvTyQ+cZxwfjvJ0h485ohpYuCsN28+8cvYq0HvOLETW0Y/4U?=
 =?us-ascii?Q?QfeV0QPvM3YdHOnVBMsp16K0c8m21BUdXTQaG3/FzM6isgWJ2cp3Nd/2OMv3?=
 =?us-ascii?Q?KNOV9nJ5sR3rAsmqhc6t4HODWe8FhcFOV3ifk/WQj+/pZzwe2qqVT3SKTLpD?=
 =?us-ascii?Q?0AOKWLEumcgckRcYHRgrMW7xR9pk9gezyyeUb6XaMsOzSZA7RIV5xFheEge7?=
 =?us-ascii?Q?K+ti53zNL2QoZVZ9Zfjh063tZ64S1Y5SzP0n9P4CNj+tgZOA2mybyXiUrxQ9?=
 =?us-ascii?Q?h5NDzX/hMqYDW0921y7YPRyep9KZTZyVaWrmHzpUgKgVMGjh4cdRbfbAo6ev?=
 =?us-ascii?Q?LGXtD7LWIKcCjNhx+5GHQxczmulbn2Gm8mJou8QLVKoNahV05F6wroSgGMoK?=
 =?us-ascii?Q?Btzi7L6JxJXS7KQxduiS3W4l5DitNP1dSGZNiVGWJCKI85/oTFnEYHSMKbnx?=
 =?us-ascii?Q?cQ0VJ5/lZxPE8QQFcZT209+JSxLRWMXEz7uTuRbXFhLFTHiiK0XzKbMrsKUN?=
 =?us-ascii?Q?/XzcgEk3/DGq+AUX/hJ2BGOntbczzy4LvgLJaa1GWEaKLyfks76JXHQHdr4b?=
 =?us-ascii?Q?jsW1dl7eHXWUmTx0bM5E98ZJowKM1KxN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:58:54.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaa1210-e87e-4d39-dfa8-08dcb7cb62c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631

Replace a comma between expression statements by a semicolon.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 3419675e45a9..0995b40d15f3 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -657,9 +657,9 @@ static int mc_probe(struct platform_device *pdev)
 	ctx->private = amd_ctx;
 	card = &ctx->card;
 	card->dev = &pdev->dev;
-	card->name = "amd-soundwire",
-	card->owner = THIS_MODULE,
-	card->late_probe = asoc_sdw_card_late_probe,
+	card->name = "amd-soundwire";
+	card->owner = THIS_MODULE;
+	card->late_probe = asoc_sdw_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, ctx);
 
-- 
2.34.1


