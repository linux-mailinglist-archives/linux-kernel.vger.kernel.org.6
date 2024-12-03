Return-Path: <linux-kernel+bounces-428971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF159E159B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFA2161C57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884851D517B;
	Tue,  3 Dec 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5AtFN0Z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76818732E;
	Tue,  3 Dec 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214353; cv=fail; b=RA6r1Nv8+2eBNTPChaUHJDuA1+hyNYd2soIP/FDCa6PzfjIbp3+PCBIhh3B1rzrGwgILhqHNaewx+98UtaVKdw/tRTY5y/Omb4TZWN2cFKtmklmh/Oi0uR/Y5FOoJdj7aUfNLMaaGxMTYQGr+GazuruLjFzLMIMNsn5L74bMZj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214353; c=relaxed/simple;
	bh=tgcQHnx+7iGFajm3KYwxmomnGyJW5dy33JkYZ0nOlWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Csf5mz+ZjNMGgjAgu7jwzoJTGIDxRBUepQDZAVYct4cvJ+m1qxEIKimF1ahvrizAYAUne7O416Jncf/3EhBgHPkG/axGtHgeAhAfULnkDsqxwayozP+T1Nv0p+kXs0DMPmIIk1pZUV5gFBuTmUwuj/5rbcGdgwYDswwDnfh3zRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5AtFN0Z; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB0H+75Yn0+LoUYkYNb1SCs+H4On2umpligeOvhyg/hJDpIcqBLmUWhTPKXASbERc4iBvs+EfxbMj9TaLndVjhV+sKzvBGP1R2BFGF6qfYvFxKmEteVfVctwu1PZuC+TKRuUhTCbzb7+LpmORd/oZi/UaG+otSuZ7PNVlXzqNlNkMGX35GPmQKdFBznSlAs/bgdZ/iPSd0jvkNvNixU6CcHrz1yHTHqPRQn5Rol2qcrr6VKPed3z6ZZ+s5hRE1bvsK1ZQYLxj9caR7AuotuuQ1ONNeVueJMcPFlu8K3dwPid0VI4vsYd6E5fqVSCTBm6WKVex26BGm3+TFA5rw2J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlzoDTko5WKzMDkMDDSbScPYqLovUsMAuMxHyDa2tZ0=;
 b=ZsWlPX2cb1pOhXOCvf2q4m2nAq+g4wJRntkegTUa65atahFxtwZYsQJ6d1X/AM1XLhKehfLjal0vWkrhW1y3/RYjgxZOydRvdWtXo6aKkWyLmB2da2XjjwN9n5DyTBZ0ngRHkmp/Eupie7CWfV/GtmMMfvwTQltTx4qBCx8pA21S4b6G2MF/D87oTe9NaGLqEnNzZ5DkqfoyMrZusH9PqnY/Y7o7RDXmlNrfYukKTkTToInVV1FFGAuOtjPUo7Jg7K5Jp83Pg6A3PVv6+ZXn3n6IY5ouVRpD7zzFzP9ludHszUroNFovnM2AhmlbanWgs61i7KfzQDptKZZu7yTJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlzoDTko5WKzMDkMDDSbScPYqLovUsMAuMxHyDa2tZ0=;
 b=i5AtFN0ZelhXxPc9+vwV3kVAGkff8NO2oQZT+1Ra9YUT8jjxoiaYs7TnjtbqOVOs9o6MbD4PpSy3i9SpecpJImrUkhqxEPoOLSlCjPu2UknzxlUq8l7q5V4A6aXtNxTemq8gwyO6aJmn6Gb+x1npvadS+aNscjuNBpu8R9a9K4g=
Received: from BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 3 Dec
 2024 08:25:48 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::82) by BLAPR03CA0102.outlook.office365.com
 (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 08:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 08:25:47 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 02:23:21 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Mario.Limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/2] ASoC: amd: ps: add ZSC control register programming sequence
Date: Tue, 3 Dec 2024 13:49:40 +0530
Message-ID: <20241203081940.3390281-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203081940.3390281-1-Vijendar.Mukunda@amd.com>
References: <20241203081940.3390281-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d0bea4-41ec-41bb-7837-08dd137416b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLaDaX+LAzrdM2V8UutdIlQ4AzC9zAVcCmNLNuAReDzka3VhttMv1qjOdoN/?=
 =?us-ascii?Q?N1nbCBfFfS849f2K6OMD3czEXJkpRuc8+QGHMVgfLK4UNolszuuO/B+Z9JOB?=
 =?us-ascii?Q?gkRQncOWoQdjZZrgsr4ILNHf9JpXwf2jYqSxVlyRo/Y4v+KnGaFqrG1Wk8Bq?=
 =?us-ascii?Q?LNgxqN8Z7Wo2cSxeA6i+3yUs0ulVhHJNuCWh/sQivwdZ9Qytm1SwCUS3DQW+?=
 =?us-ascii?Q?VHe4MdhyDym5OcaD5sZbQ9rr1li+mSuYTkMNcYQ6j+6RppcJrzWfjKjneC4X?=
 =?us-ascii?Q?TI+gE5VQD/vXCTM7Fk0HZ73U6lEHGXHhafpO1zB4thlHy6nt96CYErVuktQe?=
 =?us-ascii?Q?8Oo30FWYA0z//Eb0N7SQ/3rFHY53StGrK+054Y6sw1gcdMnV2akb6I5vHQto?=
 =?us-ascii?Q?p71Tf41DJ5bQPOTlcJhkncPk8dZ1bY3bvH85PiZ0BM9c5pVcPLaNCA1nRaZe?=
 =?us-ascii?Q?jR4gxiQoOZMizO1QxrDfX4vKFVyl960t/nuFxvHHUO2KdXQaYpX6RYoocTeZ?=
 =?us-ascii?Q?r4psuIHIV5XL2P6l171W9cz12JfbvzECgtNK+HWBL49xCFSlqmzNAT+45cYu?=
 =?us-ascii?Q?j8/XLb7cIJ9wYGv9YSVzIKP4v7sZWAdjbZ1BoNhEV8cxDwKwz7KGMJst+9BE?=
 =?us-ascii?Q?K5FtlOmoQ1ayM8nATwWqcrxcoXrZrv33vElMhkmhIzefvK8RaVjEA++ZHQki?=
 =?us-ascii?Q?yORoDkKVXYfF3srKbYxIoUHDsjuV/nNuqJI8NNSnBu2szVBTGDVffRvT8UnZ?=
 =?us-ascii?Q?eV9StkcOwmlKygXT7YKdIe1JyK4gznhGLrIpd8pE0eW53ypBd/ClOS9MhsKb?=
 =?us-ascii?Q?TMhsVNQgVDRLkBuO6EjmSROIuJgy+OxdHRtRxqlNliJDlQpiMdbKjTkh3LrC?=
 =?us-ascii?Q?erosMrI+Ll2/3oZ2UkSgFHcBt05UpnzW9z6F/AsDo6CutsdJdwKk0TIqeAA6?=
 =?us-ascii?Q?rhel4g6OOPMzDW/PCO1m/hH/3MXEFsE2358wmj2+3fu6ZCEo2W3t+/7ZZ584?=
 =?us-ascii?Q?3iHA3g2ogGPqIqDei06jwH80K1Fd0gqBkD7wXZoWVGsOMhbOMdbYjPCP0j+D?=
 =?us-ascii?Q?NTEOa9l5Kuqt51ZT6H1Gr89RvdVZYlaHeIyDfKG+sCuVkD06d6NEnaX1fO5H?=
 =?us-ascii?Q?NvJA94kaIBsTTAXB3uDzH3X3Z8gx/Du78nvOzMcj+IFUIhauaEkEj574Ih1K?=
 =?us-ascii?Q?D/a4ip+J+WFFYc5FcinuU6fKs8NWuTXOCqwqfWIUoBhgYyIa9ThquedeR0tM?=
 =?us-ascii?Q?bLCSjfs3IsGmEWdMz1FkqCPr/vnwzgjfOwi2iHePLuu1+lvn6rfhocm5LEVN?=
 =?us-ascii?Q?LBL4IYcZvpnpSNmyptuxtjxgvCBqcRO1KByKLhRb+Qy4CM1LDKydFuqdIg7i?=
 =?us-ascii?Q?GShjdUYTF4GfF2MMKT3dZDJvTuPtXt/nejZZIt0KwGDEJKKQkalHMccvbu0K?=
 =?us-ascii?Q?2G9zNYTjlgDwqpzgZpOwMq+TzCcEGNPp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:25:47.2935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d0bea4-41ec-41bb-7837-08dd137416b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

Add ZSC Control register programming sequence for ACP D0 and D3 state
transitions for ACP6.3 platform. This will allow ACP to enter low power
state when ACP enters D3 state. When ACP enters D0 State, ZSC control
should be disabled.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 4ed50cebadb3..22b677a026e1 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -83,6 +83,7 @@ static int acp63_init(void __iomem *acp_base, struct device *dev)
 		return ret;
 	}
 	acp63_enable_interrupts(acp_base);
+	writel(0, acp_base + ACP_ZSC_DSP_CTRL);
 	return 0;
 }
 
@@ -97,6 +98,7 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
 		return ret;
 	}
 	writel(0, acp_base + ACP_CONTROL);
+	writel(1, acp_base + ACP_ZSC_DSP_CTRL);
 	return 0;
 }
 
@@ -655,8 +657,10 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
 	adata = dev_get_drvdata(dev);
 	if (adata->is_sdw_dev) {
 		adata->sdw_en_stat = check_acp_sdw_enable_status(adata);
-		if (adata->sdw_en_stat)
+		if (adata->sdw_en_stat) {
+			writel(1, adata->acp63_base + ACP_ZSC_DSP_CTRL);
 			return 0;
+		}
 	}
 	ret = acp63_deinit(adata->acp63_base, dev);
 	if (ret)
@@ -671,9 +675,10 @@ static int __maybe_unused snd_acp63_runtime_resume(struct device *dev)
 	int ret;
 
 	adata = dev_get_drvdata(dev);
-	if (adata->sdw_en_stat)
+	if (adata->sdw_en_stat) {
+		writel(0, adata->acp63_base + ACP_ZSC_DSP_CTRL);
 		return 0;
-
+	}
 	ret = acp63_init(adata->acp63_base, dev);
 	if (ret) {
 		dev_err(dev, "ACP init failed\n");
@@ -691,8 +696,10 @@ static int __maybe_unused snd_acp63_resume(struct device *dev)
 	int ret;
 
 	adata = dev_get_drvdata(dev);
-	if (adata->sdw_en_stat)
+	if (adata->sdw_en_stat) {
+		writel(0, adata->acp63_base + ACP_ZSC_DSP_CTRL);
 		return 0;
+	}
 
 	ret = acp63_init(adata->acp63_base, dev);
 	if (ret)
-- 
2.34.1


