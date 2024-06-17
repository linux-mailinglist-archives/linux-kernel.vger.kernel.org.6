Return-Path: <linux-kernel+bounces-216832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C490A71F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AA1F20F53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5718F2C4;
	Mon, 17 Jun 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WLaM5Dc6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71418C35F;
	Mon, 17 Jun 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609401; cv=fail; b=qtvQ4CfF4ChCobLsFad9hIhSXq472EK+XMB8FdLTrDz1JFE8QgJYD2F0rtmKi2Fxg6qxtwZPdF+6dG0OnjRJDmmfmaEVsdxHsCygr+Xi+bfZlj24TT/m6y2H2tkTyX9GCw6evNMe59EPbMunMIONbMQVeG5Pickl/qqCPxRiQek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609401; c=relaxed/simple;
	bh=vuuDorv5yU9uZ8nmuswUrwf/rhSQ0hb8772xklQuG0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDyUdikntHLsMZPL/aspVLRGZ8Z6trdjCCvjtxtUi31wNNqF3ak57Yn232/vEw4IaeWlWoT58FXutKekDp5hJ7pezZD3hNGPh0DwtnvKw9kbbDH88E5nJ5BSn6tEvtsuHKiMV2OjWF4afj5REY24yT0bvE3+kWYmyJ2DHVmvzWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WLaM5Dc6; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCCmaQMORoesPxySth67pKahtY9+IOX+11U/u5bZXX5txFuzgmmAnZ48aLFhbjzyT63yOLwy+ZAiUROkCFK016YtJbj4e0Csc9rBZ+4AU1l+n9NR1QImoC/YQuXKFM8qGnv52gWFbsGzHTLX14toNOA7OHGt9qeFhpZ80w0CT78YZ/cDGHjrRtgCGlu1NLgSYT1CzXhGRw0kqUFGEg4Frz+rVhBHx8LyV2vuXc98nKWHY/651bKNTpIDJrAVDC73Ra/zq8N+/6edh919vThuRgDFWvE1YKrFd9iUt9hkDWb+g4pWPB1BP66BJoxIkJQAs4b2W7pX2+jO6UdOROCwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4xfCBmWCH2rtX3qmdeu9aouZBkbzPtOIQq7kEbX0YY=;
 b=XA2nPt3KcK9Pf7flhlbtXpQuQ0mNC6pYakIdFbjiyQRMs0HI/JP3e5GS7yxQO0PUeXmLPx6I7tQK/GRrDvQNytvxuphoxLsvqVP26m7zb7LT3F0ztNtEfefcrsHEQS69GukD/yB4xFb6/vjgy2TA8vGd/e49Tj7QeiHOvoZmzk3Uqo5cq2qFu0KRu0Ho4Qc08Xp/VCY9vXO5IUxrdZgF4v4gwLD0EZa319q4X8mwAob6iuY4R7sTr+5EyMr3ia7GlQrO6e8Ww7CzO04XiE3El9IuARrMkuR/eNRGKjkEZN5KMVawh+aakwUvojsIKeKSEK+trzTSk5GRJEMPFpeMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4xfCBmWCH2rtX3qmdeu9aouZBkbzPtOIQq7kEbX0YY=;
 b=WLaM5Dc6DWhDP3oa3baGkj4DeZMT4NNhZ/h13TvScphzdPOxocOuYmEIfsTKKjrZQ6BAFRwD3tBO71WXRL3Qaeax/QkATVoADQ+F9VnlcuMao2Bc+rLra290wP3My7jR85CHo3Y4zGZ9iAUtafquFozniX9j/kGy6Ph0OYlRFVs=
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:29:55 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e8) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:29:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:29:54 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 17 Jun 2024 02:29:51 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] ASoC: amd: acp: move i2s clock generation sequence
Date: Mon, 17 Jun 2024 12:58:40 +0530
Message-ID: <20240617072844.871468-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
References: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: fb239c52-b150-4a0a-16a0-08dc8e9f48e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvMIv6T+i3mola8in2q6NmY7RDzGKPdACJJAbP3LMxP6c9MhGswzxQa0gwj0?=
 =?us-ascii?Q?C5rN7qfS71FECD+geIi2IhG+L0XVNaDWIHQ7CaSXTx+T6U7AqjaiY+2pWJK6?=
 =?us-ascii?Q?6cOqP25HhGBvucIsin71TJYBKuzWBg0kWaC/6WRlTenblZtVB6aFlDq4wkzb?=
 =?us-ascii?Q?VRoaYj4MknXGTqBxjnwiKRVq+PRBhEikGL4pQhKq5RxyAhFmELn9oK84M9id?=
 =?us-ascii?Q?b/CIpMGAW67qtATN57sIyD69vOHFBRcEl5uZE7yMFUUSUCa/tQzxVeQNsi45?=
 =?us-ascii?Q?2C+f7bQ9TUykD7NIjwILQHseBAimJ6YdLmB4R/bd/IQl11wGECcYCwxllUkG?=
 =?us-ascii?Q?UHrzBBhyQKltY93ASVWFc1nDqlANnhIigU0jPtM0R2xcFlD1Z7VX1xicnBaR?=
 =?us-ascii?Q?hO09n7VnsSnGqs0XT+dIgBz2iate0cyFk0+AT5gwzeZwzPCvWcEVRliBhhbk?=
 =?us-ascii?Q?eDtcR3q/i4A9IpOVGE/P89waRY5T75GuApLY2JlbhhSb88BoAiHUEYY9civf?=
 =?us-ascii?Q?BewBJvdPDxR+Shix9Utzgz5yfmExgpvBM4JfIfiZ0FVdzvze52ZG85mX7h+Q?=
 =?us-ascii?Q?F4RbAs9IDiXC5q/TD3FCGt5oGb4hnr/gk/RpYaa+CDNj7XpfP5XTWk0ubV94?=
 =?us-ascii?Q?b/rr2fC1wJa5DPi16MTqCXVIHw7o5/+Hf1/tMEfwLSDv6c8eGfdUD+5hIEMN?=
 =?us-ascii?Q?AQNfkeS0AFwapgMAeg39fOhvLW4eyuA2rQHM2kn7++lxdJKk26YRE9UOW6tW?=
 =?us-ascii?Q?3C5enqHPx8U2OiE1+R1HMFSCf1m6nHRm97mCOUVNHJdgeh4vsSsdvb2xt6LG?=
 =?us-ascii?Q?vlb5yeeB2gAfXmrv8JYkSgI2J4oL+RvueJK3ZoFAG/+KJ3SB9SaqA3y4exb3?=
 =?us-ascii?Q?q5nY06vMl5kw4CbcxbtQejbuGByF3Sp5S7MsPuIOX9MezBiUwmv5aVGSOgI1?=
 =?us-ascii?Q?u37aJUWFZcW2pU7xrKgyae+iZOIXoEI9WweGmzLIjVuJtApx/GF3PhWpu2Mj?=
 =?us-ascii?Q?+MnUtJ5Qe65537/8NrC1MOG9PRYfjTz/5I8fVGBdUJnM4ip5kvJ1Pi99BGKp?=
 =?us-ascii?Q?c6VabbYYOqgMCuUJizbSZeXWBXH/0M4Txml1W2cpj6FFEbsyZMmWtaWe70z/?=
 =?us-ascii?Q?a+h5WjYjY/BjUBmNccdwD+RUijtNWmCIYrph4vKU4zA0OI2Kj5hgBoUAj3g7?=
 =?us-ascii?Q?p1rXW9XkLRYcwssRaqgH+WuXK10HHixGLgNVLoObxqyWZ/+lFpzV81FjwRuY?=
 =?us-ascii?Q?LPsEXqsmeDgVlBLOOFdNSCzcaP9eKzrXh9zwmu4weUQR46U2smJwQEL7mxJU?=
 =?us-ascii?Q?lveir/3m8rn2JXu1x2mFppSWXCSdhQpYeNtM5Ia0r3jtbw+e91iXta951W8h?=
 =?us-ascii?Q?5BV32ahqh3Dm6rTu8ljwDFPfHh8JQZ//s6LVXdvNdWv8ISZxYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:29:55.2541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb239c52-b150-4a0a-16a0-08dc8e9f48e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411

I2S clock generation registers should be programmed before starting the I2S
dma when I2S controller is programmed as clock master. Move i2s clock
generation register programming sequence prior to i2s dma start.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 7da414bc3b96..88985e9d318b 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -369,12 +369,12 @@ static int acp_i2s_trigger(struct snd_pcm_substream *substream, int cmd, struct
 		}
 		writel(period_bytes, adata->acp_base + water_val);
 		writel(buf_size, adata->acp_base + buf_reg);
+		if (rsrc->soc_mclk)
+			acp_set_i2s_clk(adata, dai->driver->id);
 		val = readl(adata->acp_base + reg_val);
 		val = val | BIT(0);
 		writel(val, adata->acp_base + reg_val);
 		writel(1, adata->acp_base + ier_val);
-		if (rsrc->soc_mclk)
-			acp_set_i2s_clk(adata, dai->driver->id);
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-- 
2.34.1


