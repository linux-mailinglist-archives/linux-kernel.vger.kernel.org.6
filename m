Return-Path: <linux-kernel+bounces-391597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3A59B8917
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9BF28305C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32E132132;
	Fri,  1 Nov 2024 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GzuGNsWe"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4917C91;
	Fri,  1 Nov 2024 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426957; cv=fail; b=RrsG6WLwlLmOfL1HwZhy7paVPNJPdoJqT1p4L8h9K7FuCRqWahLo7nYj2ouZ1PCYxt4mmLgd/7+7FI9tkSTirbEVk81DpDmOPAo4nXFoCIQwsofs9TH5wTmQBZTE86vDA1hlnoWGUjxTOhthPlUYIJphOXsdhnxVpINTNyT+dG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426957; c=relaxed/simple;
	bh=m8Fdimy1uNQJ0phYeZwakJsZ7awf0wC1IRLCVzW6bfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lqzBs3NpJt4ay0+wNFTdDnRvGjwiHHDFMQBFySRaMkOK1KRfy8wrG/fVNdSDYkJqFpa47xoyoBWHnN3GyU6YbQMQdT7aHw0jxt941dWqCAqqRS0iYlF7u6evIlOEMudFaTWK4W6y1+YVAiVylCoYg9f2MeiZim31bO6zGpfe9PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GzuGNsWe; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMo+9nBgdJS5v4UVOI4sBU5088/jKNfJXPh22RHia26uy4LFsK/HxPt/xO2joqnfZXbeR3ZdpMEDtex++3ZuN1q2bDpnDq8GXF1ct0JbWOcETiNJBF0wTArTx0jGIdHPEFRgEYAF4kC+0teZ4c5e0LkbUjthypLRscOihwAzO31tDhmYstguxKj5b+yvZiOhLuZFnl8tJLD+QJmzeAXGjRDjbt6otzFQox5+c0Mz5goqLYyf2Jh8s63wIF+rZJ6CghMwW1Ht6KkDCAXuXnKE2iG/FNSgjvFB6KPCgOv9mvoQQZ/mm1lrzniRz3HZo6aQ1XiI9FW0I3d2zKsADysqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noDUDqaFZhPy6kcmY1mzhsPcf/4dTn5WVMmfAf1hVPc=;
 b=HZoyaZIZuBoPqNRSMOH2ijD3hsqzoS2DR7gEIvW0F7nM3zYoYhY9nrZYcaYyB7NuxgPkXChHkjki5H6NNgq1CPx1juLk4hV8JGdc+FBEbX7NL6QexDlkqIUGOumAVEjscPdHLaFotWKTftpVraua+0kpzFm20KWNwHuRvLhIB9CTYMiW2N648UFPxd2JcnWfXyTxC2hBz6MW5pr5QydtaKXSNn1Xg65IiYZDePHiVI0uR36oyM3HVX5ob8MBJh1oFkbUgszfAB1ioZUz8ad4WoD087lwp/1F6eXZG2q1kRmWHYjgYCRU9WOh1L0b1GCGpweWyJpQSq7UfrDchJwleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noDUDqaFZhPy6kcmY1mzhsPcf/4dTn5WVMmfAf1hVPc=;
 b=GzuGNsWe0yuyJMCRUepCPN4ZrRLza+ezpmCgrVs1iLMtb+oF2d+GwZ8rQbX/+i4V1+MgKOMFWRuss5n4jkNZlGfbJ+W20F4rlU3Yaa4KBH9VqeK9bIFRvJbtQQVp0AGn0rjHn0mLlox5HrwnoPlO/dUiHl9CYueUG/jIOFrXNsk=
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Fri, 1 Nov
 2024 02:09:09 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::cf) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Fri, 1 Nov 2024 02:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 02:09:08 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 21:08:42 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<liam.r.girdwood@intel.com>
Subject: [PATCH 0/2] Soundwire dai link init logic refactor
Date: Fri, 1 Nov 2024 07:38:00 +0530
Message-ID: <20241101020802.1103181-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dc4bfa-0e2f-4397-3bc9-08dcfa1a2b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6lNs6oBcgPIENgawVKcZz9mmogmPLt2Fi7CIG04q+HHUn6Gu7hKzoUOQZYhF?=
 =?us-ascii?Q?it49DCDSqKP0B4Nz4uKVNBsSeibnVaOqF5TWWHGTXjKx3zC9+Re29vmH8i9J?=
 =?us-ascii?Q?FShpJ7YrHJI03T4f5sdGebDuMwDpjumHWm3rvEczcpwsTAk7Uww2uNFX310X?=
 =?us-ascii?Q?Hb33KkL6cnwyg4D7ZCpsJT2W6wk81mhkkRALtpSY5sjHa1Kt3EkTj75+djzF?=
 =?us-ascii?Q?TdJ2e9YGUNeOBBYHqveWpSvu/534vx7sTtcWDHfL6ZCznEEYbpB13kbaezj1?=
 =?us-ascii?Q?dhme0YlkcQntxQro/ZkBqdrPHhbaf2JoF2CxRblX3ZGDFMdgmgYMlf6CGF6j?=
 =?us-ascii?Q?vV0t5/J2NSAM8N5xKKUxgjqYLU5ozw7q8/qE3Ihk8uk8abr3uX5w4Kwlv92b?=
 =?us-ascii?Q?Jz3kcyg6qHD9+aleP5OoeQX+QEInabo4M5kYX9QhUjIxvgR1NC3jjXxo3dEv?=
 =?us-ascii?Q?lUJbq4xHQoXqBmajLmfTFJFs3r5hI9NjUkqOn9TcqeAIQEupO/Sy9RxLFi1i?=
 =?us-ascii?Q?TWTMCHluUEXlcBWHdwL2/MTddqG6AZ9YbcgWs2XLNHCoMvP9W2kfCPgKC37J?=
 =?us-ascii?Q?zwKuhS9ZlgP+tOa0cJGQ5pzJjSYO5J2nvXDZFFH2BFMkVcjavhTy0JC0xSj2?=
 =?us-ascii?Q?PgMVJGTGJmwfTR22BOZTX+aXnIDbquWRw7fbIIpBzCttmBNCzQjPj5Zttxa9?=
 =?us-ascii?Q?JGf4zF4ah19qMVtCbeptHfa9YWs2W6AwyMIKAvNpuggUPSfmMvX9vIg0/2SS?=
 =?us-ascii?Q?7YgYqDHK5X0AvVvhvCGEabN6KdM4Pymwm6ob9zU/lhx+NrRrvwOE5JNQY5qR?=
 =?us-ascii?Q?+EAF3QgAKznScUVSPR2QcuxtqWM6t2bmWINsPgL5GB7qud6ef1o24XmKbeUN?=
 =?us-ascii?Q?rNTjCnkmBHZTo0Pq9BCs+uKwcMdIWibkTXzlyCgu/yMdCavp3wO59UHu32jz?=
 =?us-ascii?Q?c0Ojmiqm+9eT6CJp/3Z5Eraewnopsy1yOUbfw1pvvGIzQMDtAypXPkes1JyS?=
 =?us-ascii?Q?R/NJMj5qqleCSBqTK8WcX+RscaKEYnlQDO76rxqLq3H+1oy/x4bmCGZsG+X1?=
 =?us-ascii?Q?DQPW6GkD2xFIsZsHyWUZUcclZjgT1rU/ioyntVF2d0GeBf7kcDctk3VpHM7t?=
 =?us-ascii?Q?i4p3kpDi1taWz55iy3Ez2/WVbCKuRuuKtNUVoQ8RTi5S/ZWo/6dVfuzkwPOU?=
 =?us-ascii?Q?pwxA5JipQ0hnnsQ3B+KkHKeZJKrCJme/g9XkchdNDYgvWchNBk8WwR7RYmtP?=
 =?us-ascii?Q?qDzUDpucFrSk5I7HNvC5bZnHAE5FYLcc03JOrVvebSG9UOuZTwGltTUBmU4W?=
 =?us-ascii?Q?qAltce+aiUHb3Jj7IMYxlLZFCPiseFYiWhJYCiGG3a5y6oDXXqFK6S00xP6y?=
 =?us-ascii?Q?3Wq22OPEu3yPX2CyFI6z2hDbRwSXO0p5mF6vqaZ3b7765kEZVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 02:09:08.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dc4bfa-0e2f-4397-3bc9-08dcfa1a2b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285

This patch series refactors the SoundWire dai link init logic for Intel
and AMD generic SoundWire machine driver and also updates the stream_name
in dai_links structure.

Link: https://github.com/thesofproject/linux/pull/5218
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Vijendar Mukunda (2):
  ASoC: sdw_utils/intel/amd: refactor dai link init logic
  ASoC: sdw_utils: Update stream_name in dai_links structure

 include/sound/soc_sdw_utils.h        |  5 +++--
 sound/soc/amd/acp/acp-sdw-sof-mach.c |  8 ++++----
 sound/soc/intel/boards/sof_sdw.c     | 12 ++++++------
 sound/soc/sdw_utils/soc_sdw_utils.c  | 10 ++++++----
 4 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.34.1


