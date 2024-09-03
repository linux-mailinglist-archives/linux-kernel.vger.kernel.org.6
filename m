Return-Path: <linux-kernel+bounces-312812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B11969BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013672849AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D51C62CE;
	Tue,  3 Sep 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5rZq6qtx"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D915382F;
	Tue,  3 Sep 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363320; cv=fail; b=pgZkqAnnVUUB//yn+GoNUVWaZ2cIcshS+DhHUXEDXG0r08e4fJLMKCpOXvtyr4rJwSLE2pZazI95mDa9aQipGWOvKqAtXvV128E1ICpQjAKE3a82dCgA67NrcmE3wQNkgmWhCN0x4FXIeHAJTpqBUyhVh4dEn0+3wdRQQT4A8Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363320; c=relaxed/simple;
	bh=yBlgtCI0vR0scXorGL7tJ8nY3CXONw5Ic0CbiCgtGc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8FEd4WWlx1O4E3N93eDP4ICJ99e9jepPT6EJiehpsurm314NAjQ0S31WzHYTq2iM1GMCO6nc4ztXll0R/YStNNdhwAZTFKi3hLWFphe1lkVNLLBonHQ5bjx3DinHx/AocVYNs8/wzC1s5clF0gYeNj4Dd0+pyPGi0InjlvWKK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5rZq6qtx; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb+rtOa4cBgEYPnRye7OANd3ZM7+hgUQ23CYe0z0aLzOFz7IliMIWMiG/zRFcR0f42EYn1Ri1UQ5RT/61hP4mlDfzCo7+ZBDO5Skh3i4cZHS3KykEWH4uGV4ClKAUW+QFGwEM+gzKRGtSla70wciagpCRtlEVUMsljPU7WMdRl2ZtKvAZqMeNtOyFkEWFXBiDpoRTY+WpDCF40cvGfNRehanaSQrt0uxNxBpfZHG7CLoagxP90MBOQiIQwApAyVjF8Pf5YcKpm176ttWSZvWOFutIsOlp1Oj9GPJeAcjuZkkV0exfn+mxdBXJqHqIzXnv8xUhwWvVLi0784jTqeumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0VhpKGGyhT1g4xfstXh5jMXLsaoZbbwEcen263NSGM=;
 b=AMXsHXdBDwXVSlQDT1dQUmWdU7rX38fq81/kMpNjLOnJaCwE9QNBM+EsNjSychfMVEvWa9GRSlB902SFbiEmK5Ahong8szD8ihvFaIEX2MKMQCx4i/wBg+xyd8WhiCZkKn282b77B+0vZfKSZDtsnDrAXkAo+bl+Q9I9E2JXvWFUpP0E5LATGZ6R2MhFFLhgjA7lKb3WErfVo0UQRPoxnHAvXWmYS/FtUQEj9LxY4LYaVE9vFlZ3oJZM8VEAjLPJsQ39BUxMuIBk3q8iJ5xVC9D78CVnRFcUznRRAeAio0Mp3QgQx3gLfbwoHwEbAhrm7iloWp0K3fidUgDNkAyLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0VhpKGGyhT1g4xfstXh5jMXLsaoZbbwEcen263NSGM=;
 b=5rZq6qtxBz1oAW8bvQkm0SLX6tbjJlj7lQwoMsPtkswVv9gEs4p1lMsyCWQ3W/x8DMes1Lv7nS6QT4VCmeWrk2av4Dpi/7WjTW8/6UGQx3XX9ieHpqfzTgFRhYj5MK5R4uWxwpPfPOx1cIziTL9zvnBTEzAhbjQ+q7dEk6GCJbc=
Received: from MN2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:236::8)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 11:35:15 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::aa) by MN2PR05CA0039.outlook.office365.com
 (2603:10b6:208:236::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Tue, 3 Sep 2024 11:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:35:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:35:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:35:13 -0500
Received: from prasad-r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:35:05 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 04/12] ASoC: amd: acp: Add I2S TDM support for acp6.3 platform
Date: Tue, 3 Sep 2024 17:04:19 +0530
Message-ID: <20240903113427.182997-5-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903113427.182997-1-venkataprasad.potturu@amd.com>
References: <20240903113427.182997-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6529b8f1-6f4e-407e-fdad-08dccc0c7a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbFbQiOB66t01bwP9cNaOssVUSsO+V9DaEwn/wA6qNTRlMuQlZT/Exs6fOlA?=
 =?us-ascii?Q?Ga9xiWZHPWGTFQZ8ObIdtOjj6DeJp+lAIG4Ouc9fT+ixgjKmM3lL/CuUAFy1?=
 =?us-ascii?Q?Y3aZtXYobMCHdBjoJrcINEYG7WL+cc6pfZAyWzPTz9KKHT98ZTBp4L1mPXGV?=
 =?us-ascii?Q?r9Z9H2kSpkr/kBCGC4LFg47v442LAtXlOghpdA3u6U4DPvRgdkc+HXQHnr+q?=
 =?us-ascii?Q?64+hW2agaIHfmo39am4GFwGID1BaCiNQgs/5AKBQgtiOiSMzkFjjfMJZyWgk?=
 =?us-ascii?Q?R60mr3Pzhi+ArNH9dGIdyqdfyTXlAMToXLAISizSx8vErvt2jS/TPpKjae+w?=
 =?us-ascii?Q?+2TZSzRZeAGM0hKq8j1Oy6w/m8BWTucDvCTWnCf6LrgyDeOIZD/iDxK8ZSEl?=
 =?us-ascii?Q?5BdieKrQYZf3uzY9+gRktTK+TVRy0uxHCUmQFde+FGnExxfxDmi3Pz4Dbhv1?=
 =?us-ascii?Q?pXlilq3JctLkbE/7xs3oGsCZCursb6/Zq2NF53MKj45op+XGIi9TkTeZZcoj?=
 =?us-ascii?Q?g+Dao7Ds0b+Am1hMvZprrmeGCW94iu8em8plkQluBcswVAlmhUykIMnuCSJf?=
 =?us-ascii?Q?b/jqckGkuabbZNZyQbCKSTxIMgJvbC/vEUZO5BCFimoBfACQpP8yvmngZMH8?=
 =?us-ascii?Q?VZsIOfOcsLqIwaKEKarltuGjjpTFNwJeFEMw+KmaMJ3vNWiNWuB4dpKcUaYy?=
 =?us-ascii?Q?TvFVIlY66RDtBoPpnZra9PpU8syj/808obkfQXeWehKgh/SBbzj9eZvXpbck?=
 =?us-ascii?Q?NLrBlsrxPwAII2rdWIjgf6WVZL9R13FFUozRyerdiUv7gpHDLBZ06zxQN8Jt?=
 =?us-ascii?Q?j7F/UCTD6BRiLOINDnwdKOfm6ePZdVGuDfFicI+VW/o6sQRlIDEg7kiybX4L?=
 =?us-ascii?Q?fnjC73j6xP1tk6fR4TM0qBQihB9anawCQ20ywnmO4XkaXMoCOtQtQwssn8HP?=
 =?us-ascii?Q?U4AoZmq64xpWMy+LjhA7GWgpHawOENsPNziPVgBmceoiO1xgjAQyLR4isgcH?=
 =?us-ascii?Q?Mbnhv1HUsFWm7s+q55s+Qdi+ezgH4z0p/RMxRysAGnYB6jXjUH0RJ5OeU4AY?=
 =?us-ascii?Q?7gLoAfUc339TfprYXyal8QGnh4IH8cDLxabacEg2F5/pgaKiYuKl3mxpCdae?=
 =?us-ascii?Q?VieJKmh+7Fj4MiHh/Xxl+gPYuKyQOPBkpRaHG7lIYEm6QmohshnNPh2Qr/a3?=
 =?us-ascii?Q?Wx6jdeb+ox6d8cVWFv2ErEPGpKPMwIrtdy8kYgPR4C2mc/TQ9uWmQbrk/hQr?=
 =?us-ascii?Q?Z96uGzq8zecw6tWX8j2QJhRZieVyCSgUFMITgD1pU5jXFPIOhVNpBa3UhJmB?=
 =?us-ascii?Q?1zN5nrj0WB0Z6ss1X4p+IFpbWe1bTM+VNMFjS30Jl+Dakc4XpN31FcJNmBA/?=
 =?us-ascii?Q?cHTjxrEMjMzO0Ywe4MVTRbBrgN4dwA0Xih2k+XYFI5DQQ5ROkJtULBa+MRM4?=
 =?us-ascii?Q?AMDRSbcMXb3SrBtGBsMrIlauC5gRHDeJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:35:14.7744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6529b8f1-6f4e-407e-fdad-08dccc0c7a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

Add slots selection and 32-channels TDM support for
acp6.3 platform.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index aca99020120a..eceffc69bf3e 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -133,6 +133,19 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 			return -EINVAL;
 		}
 		break;
+	case ACP63_DEV:
+		switch (slots) {
+		case 1 ... 31:
+			no_of_slots = slots;
+			break;
+		case 32:
+			no_of_slots = 0;
+			break;
+		default:
+			dev_err(dev, "Unsupported slots %d\n", slots);
+			return -EINVAL;
+		}
+		break;
 	default:
 		dev_err(dev, "Unknown chip revision %d\n", chip->acp_rev);
 		return -EINVAL;
@@ -152,6 +165,14 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 				adata->tdm_rx_fmt[stream->dai_id - 1] =
 					FRM_LEN | (slots << 15) | (slot_len << 18);
 			break;
+		case ACP63_DEV:
+			if (tx_mask && stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
+				adata->tdm_tx_fmt[stream->dai_id - 1] =
+						FRM_LEN | (slots << 13) | (slot_len << 18);
+			else if (rx_mask && stream->dir == SNDRV_PCM_STREAM_CAPTURE)
+				adata->tdm_rx_fmt[stream->dai_id - 1] =
+						FRM_LEN | (slots << 13) | (slot_len << 18);
+			break;
 		default:
 			dev_err(dev, "Unknown chip revision %d\n", chip->acp_rev);
 			return -EINVAL;
@@ -314,6 +335,41 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 		default:
 			return -EINVAL;
 		}
+
+		switch (params_rate(params)) {
+		case 8000:
+		case 16000:
+		case 24000:
+		case 48000:
+		case 96000:
+		case 192000:
+			switch (params_channels(params)) {
+			case 2:
+				break;
+			case 4:
+				bclk_div_val = bclk_div_val >> 1;
+				lrclk_div_val = lrclk_div_val << 1;
+				break;
+			case 8:
+				bclk_div_val = bclk_div_val >> 2;
+				lrclk_div_val = lrclk_div_val << 2;
+				break;
+			case 16:
+				bclk_div_val = bclk_div_val >> 3;
+				lrclk_div_val = lrclk_div_val << 3;
+				break;
+			case 32:
+				bclk_div_val = bclk_div_val >> 4;
+				lrclk_div_val = lrclk_div_val << 4;
+				break;
+			default:
+				dev_err(dev, "Unsupported channels %#x\n",
+					params_channels(params));
+			}
+			break;
+		default:
+			break;
+		}
 		adata->lrclk_div = lrclk_div_val;
 		adata->bclk_div = bclk_div_val;
 	}
-- 
2.39.2


