Return-Path: <linux-kernel+bounces-271154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECF944A33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C55D282F77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC4189529;
	Thu,  1 Aug 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jSVGk+L"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95918453A;
	Thu,  1 Aug 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511119; cv=fail; b=S/xFkn84fHs3bCFzRUOv4krvE4rIMEzVPYtGK0NDm8HzjSd7NtUf5rpgwfmFLlc2UVEMBERO/ffG6CepTGyD7dmL+Py/QuRkbeTiqxJBN1GaHJnGnMUB2VRp+Ub9F8cHoGeWc8DEgL5ZRBeBsRf9JIyIwprHZ28PvjRIwwALFuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511119; c=relaxed/simple;
	bh=MPZvZJr2dKgEyoC5PT2bfOAWgLLDd/Ys8BCPH9ABZM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=py3yC8pDj0YswC/aK4Q3nofi3deb7N+rlVhAgWJ1SbBKpwfgMUA0zzXA/GBvootI4LVPC0tbbHAwQo516geS9FN20aMW6Wk1d7UJEfwXUKZdvqN1OqC7sJh+62/er0qjkqrbkGpQJhSIujBqZiXzLn4lpAKzGaeOO1ldaz/LzhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jSVGk+L; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IG8lZQySTN6mi29yFHzB33btK6I+TM828CUL82L4kWOkTLU/pacIIlH7mcJDEJfFIN0DamGq4yyeLXfUN6NurJ2nzyJZfuYB+JQ4IYsRzmquckw+ZwiXqzxL92CDr3RliTG3DqRtjkMEeUoYY+e1uU7kJAp/UdAJl1sTZs13DmNvSzXd5Ez5dX6WFGdSSd8K3tQA8Pvm7rQqMrUTnhlVebT49uEKrM1lcxNdyOHsVD6gZLPwx7aYcKuiNhubdrV79s55opr66dogqfe/ClCbRQqJysa5waqt/6wcjNNZvlFCei5tj9kKVjOIDXsZyg3LSr8Lf9iXCGEN2QBZpfdMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDKExy/DCIR6/246/oZSdxS0in9FcMvHavGaSS7dzj4=;
 b=lP4+xax7j4yPWA1xZwGabOGs838rSvLgZGiDJQc86eAqMhlLNQtw6AU+lB8TAYlUkV3ygRuW5s4CISAoTXC+DtEmc8ymhMS5h7LCpwscsEVSkAtrPQTJinPL+yHqLn7vaC9DWFhI3en71Qfvkq0gr2BxESOBwVD7Oaz+735g/UQ0WFBQz4FSwPEJvQxCIH2dHUFWxJosMcdyDyY3jQOjjST1Rw4bh++QZqaFDKA1eYJ23V/6j25uMUd4hctmeFPiI8239D4sPzjHsWsHMpTrVwMEu9tdehNsFJhTM1ZnAE9lhEZRmQX/PKjCCsV9mcutLtKBe67QE11rUBjO212LgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDKExy/DCIR6/246/oZSdxS0in9FcMvHavGaSS7dzj4=;
 b=4jSVGk+L+UGtWdHX4BDiRDfKaJUlwT5RQaWPo4IcVTXO3Rw1Fv7L2LQJbB2lr5QFyBSW7BnUU+mojjbrpPSbKF+TwpFLXp9bbuoPEl1yK+ht0PqFP69iZ+2n7MGlALXF7uiTgOIxgQhu95mxuJbB3/eO0nWPclDQOgCOAdhZ1iQ=
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 11:18:33 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::cd) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 11:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 11:18:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:18:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:18:32 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 06:18:22 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vijendar.mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <alsa-devel@alsa-project.org>,
	<pierre-louis.bossart@linux.intel.com>, <venkataprasad.potturu@amd.com>,
	<yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Cezary
 Rojewski" <cezary.rojewski@intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Charles Keepax
	<ckeepax@opensource.cirrus.com>, Maciej Strozek
	<mstrozek@opensource.cirrus.com>, Chao Song <chao.song@linux.intel.com>, open
 list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 21/31] ASoC: intel/sdw_utils: move dai id common macros
Date: Thu, 1 Aug 2024 16:48:07 +0530
Message-ID: <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
References: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe03777-542e-4b27-ea6a-08dcb21bae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3VCAdaSk/WIAEXzSG/8pF6GIjsJ6mrMlnf9DRHQs5d1sXGjD3BTcD34nDoBO?=
 =?us-ascii?Q?n5lRLpm+Ok2D1iDVrMfiQCulpeod5OQhn49Cgjb/Ur/EWImEIcmN+jsORsoN?=
 =?us-ascii?Q?P4HpLmdNNNtwl3ChYKzR3ZwVJRrRTG9/wVxI3sRYNunJRoJirVC8hwyzjjk+?=
 =?us-ascii?Q?kbPh4jU5eUWkFjSOJAaFc7F5Qd6U4YampAflDWa7Kvy5Z7qUBvs05Z9WDDeD?=
 =?us-ascii?Q?wav/USq7dwhuHaSx/Rib4SknywUKdNhb+DYJAJKmGWk3XWKqQC7jET0vdx39?=
 =?us-ascii?Q?tOfU+fTWww92/YkepsF4Cp998Fc97dzbdJOqPu6Jm3OxJu/DbXux8XwBxZK5?=
 =?us-ascii?Q?1Zn4XDmchjKXGkdftyCDaqsO6IBuIF3aOamb9HW02rqf/91IsNp/lKSPtv6y?=
 =?us-ascii?Q?kx9nU/Y27SPfVo5SH0mROlBmjDrFCqJwTUnayxc7ShEy0kjk4Nap5SyM2GB4?=
 =?us-ascii?Q?bxeFUZAupA5DxHyeMgc0h3Y3O9N3e7zcOIXQEgS2otyXtqaJxtVS3yU41LMg?=
 =?us-ascii?Q?Z4bExMgH+kbS0NXIknaQIlqEDwUQz363n9FraDZjZAf2FTi73Uv+/0CNJ6fH?=
 =?us-ascii?Q?1vO6ldMNTE785Y5L4FoNz1Xrmu+ey1619jIBUD50+CE66XKV4J+j3FdEDrqN?=
 =?us-ascii?Q?dYRg5iHYL9TFaKhk2y0Ujrxn/rtEXv1knTF9Tc1+rwpbWeN403rL/a3+3lvi?=
 =?us-ascii?Q?XN1TLqfgoNJRW+91ftNVV+w0tIXMeFXWmbMX9wfrFLcOkUNU0QOVxloPH4gl?=
 =?us-ascii?Q?ec/9eZdwXeAI+OmUvGsyNa+LjV4EeOEpRC0KDi8e46MF4y1CTHd/VoP5WaBk?=
 =?us-ascii?Q?IOKo8TIbIKAd4Vp7dRLZVnwj8LnWZkO9uFYaznw9I9qn6Q+laV6mDJNxV/u3?=
 =?us-ascii?Q?4xn81vqbjjm4EvEbw4k97cuggn+K6hPaRwrUykYZt76k5yLEd9hNSQux8+Q4?=
 =?us-ascii?Q?PF22elRwcjkYv9JP23NG3WtPxOd+FA2Y51NLgjTXE3/aUNisU/QnvQd+KSl1?=
 =?us-ascii?Q?khk4ivVTC1Ai9rOjCTZ9juPaJPTsdqH/Mik8jpT0XoHD9yBVirtuxKS0YBfP?=
 =?us-ascii?Q?Dv45apI4ZvJER1lx/Nf3fkkOUqN6YIg2K5gF6gaI0krs8ayt/s39aQppPCaz?=
 =?us-ascii?Q?gpH31P9rHv3OwwFG3HXoLMNuPdpo8exmd6eQXqB66Boa/W8POeWg0zmg+0iK?=
 =?us-ascii?Q?fAk9VtHxSs8IldrH8AlIZebzqSubvV0b50wuvX7kCYP6dyky2fSaAHgLkFOv?=
 =?us-ascii?Q?ahSr2ckrPAQrcBZuR6PbvR/7c1/aVNrqpHrcZs3HY/SFY7SOcY+QlxsdKjRa?=
 =?us-ascii?Q?HRsZqYIZuMADXntUTBFG+8sSlN3is+fcMye/m/hy1LBYePhyOEbQFnwdvgKz?=
 =?us-ascii?Q?dKjwtpu4rRD/5DRaByZif6HSGE3EncvbDKtMuPgymdHmH7ed0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 11:18:33.2208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe03777-542e-4b27-ea6a-08dcb21bae01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

Move dai id common macros from intel SoundWire generic driver to
soc_sdw_utils.h file so that it can be used by other platform machine
driver.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h           | 7 +++++++
 sound/soc/intel/boards/sof_sdw_common.h | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index 9e84d1ab6cd0..13941ddd24c8 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -29,6 +29,13 @@
  */
 #define SOC_SDW_SIDECAR_AMPS		BIT(16)
 
+#define SOC_SDW_UNUSED_DAI_ID		-1
+#define SOC_SDW_JACK_OUT_DAI_ID		0
+#define SOC_SDW_JACK_IN_DAI_ID		1
+#define SOC_SDW_AMP_OUT_DAI_ID		2
+#define SOC_SDW_AMP_IN_DAI_ID		3
+#define SOC_SDW_DMIC_DAI_ID		4
+
 struct asoc_sdw_codec_info;
 
 struct asoc_sdw_dai_info {
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 664c3404eb81..8bfdffde16a3 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -16,12 +16,6 @@
 #include "sof_hdmi_common.h"
 
 #define MAX_HDMI_NUM 4
-#define SOC_SDW_UNUSED_DAI_ID -1
-#define SOC_SDW_JACK_OUT_DAI_ID 0
-#define SOC_SDW_JACK_IN_DAI_ID 1
-#define SOC_SDW_AMP_OUT_DAI_ID 2
-#define SOC_SDW_AMP_IN_DAI_ID 3
-#define SOC_SDW_DMIC_DAI_ID 4
 #define SOC_SDW_MAX_CPU_DAIS 16
 #define SOC_SDW_INTEL_BIDIR_PDI_BASE 2
 
-- 
2.34.1


