Return-Path: <linux-kernel+bounces-407491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6D29C6E37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9687B24DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215C52003D1;
	Wed, 13 Nov 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AqLoH2Ff"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD671BD9DC;
	Wed, 13 Nov 2024 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498767; cv=fail; b=cgiH73rvtNQcxDDA23p56/atNv8h0cbWMfCHg2ozt2kejyElkE1nlCw6G0Cit1yDm9a9+QYJ4nF/W1qKXLA26uPYVef+fVMBlOx9TifJx2f2kArdT+12DSItMcIo29HO0I+WeupZeCA6yOwCFphCV97NgGoM/vny8IBFexPi9tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498767; c=relaxed/simple;
	bh=M6tnjUWtqIBY8m3M8ci0ysd9GW2BQMfclNJQU5u6VV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dix98ZCl7dNeBsUrCq4JS0DFfWZNHg62vSFphNARYd6CZ579R/LGh5PBgZy04MKvUVP9bZuY0+932GA10LUsdgjF98zJjg9ZAJzhacfwqdhRI6Mp698Zux7/cgv9aOWYEaoH2lI5HrzTB2JJZU4TcXxvo2k3bux+EtfMkqwo8Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AqLoH2Ff; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqI0Xov9dXBWaAWYq4KqW3jelDObaqv/cus4pJyI+r0YCx0AVAZVFNcL+BOq2qbxqEonfIwR9WvKqhqTYSeWGOXDnGf9RMETd1tqxVFVo0fPh+l0Tgx3zkTiPCbL+r3y5SuwPXGY+od+g7/KrPf/pngLiDjcQLplGDrgYnKq+4WgduPdbaVBRSS/PPzdRdgXAOowgIahX+g8heuWcRy4Mr/j7HsRhMxvz053N+tCCo8DFosaj3NzUmUMk2NX8bXG87ryX2HmBR3u18xGZTlwhQljoxmKUmBKx3ukaDXM0RbzaxEAhV/6mWKcGqun+H4f6S53ikKngh8Fs6xKwowFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oUUHd5pbyXWGf1x2EV/E/BKMUk00W9JA52hzgHBS14=;
 b=Rqka/sgFBf5olReMYwm09YGkrH0ZeStYfxtAdWkTm8E3XpqaTlWgpsQjOoSV/k/GgY2z/0G3T5HKCBIctXkArvP+lRyQNT7ncO32YkOvUyl/6UhTMUPu34xDGuMANIl2HU+RS58e1LD26OPBsCMWqdbZ5VB6iD15BHgGTN8uXlonfbPlhuDVTllDNLTphx/kYbQyfppF8zpyPVFqc73qlQm7HzlNIZMJvkk36UZEh1pQlLU4b0C8WuxFpKKR/Y/qt7d0dEDC5UPW3WKP4MlUQsSriWW2Nc461VEsevHPHYfOnjVUYEpziYf1xbspSIH7nqXGqHXiHxPFJoSgazHCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oUUHd5pbyXWGf1x2EV/E/BKMUk00W9JA52hzgHBS14=;
 b=AqLoH2FfSk7F1OeZvNLvxM0mblYeECvTZHYs6uky//dwvcGSu1KmNBieIPEm4eDiJqf6e8/L1VBYdtDl3ztrM6TDTxbCY9NdKC2fMdAfHcLASBY0vJEG/JIE3ii0upBODPQBDS6ZuqKQzj5vSxeVnk/E/fHRrtJDcsz/eUIztds=
Received: from BYAPR06CA0006.namprd06.prod.outlook.com (2603:10b6:a03:d4::19)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 11:52:42 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::33) by BYAPR06CA0006.outlook.office365.com
 (2603:10b6:a03:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 11:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 11:52:42 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 05:52:37 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/6] Add generic AMD Soundwire machine driver for Legacy(No
Date: Wed, 13 Nov 2024 17:22:17 +0530
Message-ID: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: d981d179-4c6f-460b-3025-08dd03d9ae63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06/vVSX2ku7t/8x7MI9ZQgCoT6Ehrrv6vZdRldoYU4sSEjpwhGevYzDPf96m?=
 =?us-ascii?Q?Ywn1dzSSNa/xvG4XYPm7R+YJuthFlxTBafFQRwc4xQg5Fcily83V2nUOSw4N?=
 =?us-ascii?Q?iEWRvfjqC1i90KqOUfyKztYwvin038wiFoEZ/jjrJ5IvDTUU3XM7gn7mCmc9?=
 =?us-ascii?Q?FOmDQORmytaLXKfke1/4bdJCrqRmZlJO5VcBD+BmK20cxy0q5Aekkmhwufj3?=
 =?us-ascii?Q?T3C3Is2s3nQmWc5gu1OP9xq+IhgVfuL5Jb0NmRuap4EcNQyoJc6uEQ9E0zlh?=
 =?us-ascii?Q?aiTQcuAlhhg0uk4LSTQg3gI71KeslxC5n2Ya2xr/xfiwoRFIm6shDcZzbYk5?=
 =?us-ascii?Q?81nrnkY2LVDcnbqTAM38DQExuFS2rT0Kk5j0RuSS858FJUe+tUY0VWJKokdd?=
 =?us-ascii?Q?JEoqCMD4VPh9bXN3XrAw2eDZxKvxFCBT0I4wVL+cyw2qkIMivp6XLnD9JBds?=
 =?us-ascii?Q?rSDj4mLyEn2XXDzaSZScZCbHolpt+QZbzLrANihzZDmeS9zoEyQeRtsByLY5?=
 =?us-ascii?Q?f+Iil8LL/t/Fflw5QdiDiQxcvEIlLLXHykDbY5B5If1/5cG8dMMWBLfSKYsR?=
 =?us-ascii?Q?Da+zSRe1CmwoPPI4YcNkHJ2EQ9Izx6KcByXktVq2c8koSv9Pks5S++LkuESe?=
 =?us-ascii?Q?imQsTVqiR9QcWzvRvIuGPThbPPED7pPdGxGgBLr2NIKt9WfVGV7Fhwn2ewnh?=
 =?us-ascii?Q?OZN4gaqiO+VtP4363nNmSaePse+Pn5oYZpl6TkYMMfudguOEuVs6HyqsnNxI?=
 =?us-ascii?Q?Ec63gMoQtprRQpYfv3OYq4BcHpKCR8desKYLy/TYW2E9frx+I2ARDTGoGKV9?=
 =?us-ascii?Q?NadV4kwePGknc7jd4Jw1YZmuujz4TGpiZRplbdM+TLXVbcA2qoaZ/z8YxtTP?=
 =?us-ascii?Q?+3wQHv8WkHiYsWWlVuVrXPmdlXYxV4D1/sMItD9yO2C5ApQMfulxEThDIjUE?=
 =?us-ascii?Q?vkVCCuUWuWvo7Zfy4nZPWCWWWynk1Ur35FoS8dfx9zndMZWCiY/7BZZ88Xf4?=
 =?us-ascii?Q?+wc0S2WoEXYObg3knl5OF/OtXt9vVagZlO7HZB4eegKgDZOoLykg6ZRNP12G?=
 =?us-ascii?Q?nSYS+5t6pMomUSBFt0Haiebkux44vqfoHbTQnWLyzLLdO8GRd9Rbk9Iazkbp?=
 =?us-ascii?Q?yKyey9yBUCQNugF+8I2PQ0rFHNJRFZxdLCe6CoUZfvQm2mDDAtaP3Gs/JteD?=
 =?us-ascii?Q?9ZTQaYJdO/Vcbn2/lip92utAbCGllbS1hWmpJOD/RuMax1EWBvMmMZ0zWAEt?=
 =?us-ascii?Q?Dz+GqOg80BQK5LMHRIJZKim5GSWzheNCGSpPD90bXdNNSI9V42sGvn0tcPPT?=
 =?us-ascii?Q?8hOUSJubj1HY5I61HXEnq4KcmZVaeoYsbgEXSSA8WS5vBA0Z1pVOtYNOHbhs?=
 =?us-ascii?Q?VRvYFrRpFPkm3kszGERwGQtmRib05O+X2BSVD6TgcE42GAYb2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 11:52:42.3438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d981d179-4c6f-460b-3025-08dd03d9ae63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548

This patch series add SoundWire machines for RT711, RT714, RT1316 and
RT722 codecs for ACP 6.3 platform. Also, it adds a generic SoundWire
machine driver code for legacy(No DSP) stack.

Vijendar Mukunda (6):
  ASoC: amd: acp: add rt722 based soundwire machines
  ASoC: amd: acp: add RT711, RT714 & RT1316 support for acp 6.3 platform
  ASoC: amd: ps: add soundwire machines for acp6.3 platform
  ASoC: amd: acp: move get_acp63_cpu_pin_id() to common file
  ASoC: amd: acp: add soundwire machine driver for legacy stack
  ASoC: amd: ps: fix the pcm device numbering for acp 6.3 platform

 sound/soc/amd/acp/Kconfig                |  29 ++
 sound/soc/amd/acp/Makefile               |   4 +
 sound/soc/amd/acp/acp-sdw-legacy-mach.c  | 486 +++++++++++++++++++++++
 sound/soc/amd/acp/acp-sdw-mach-common.c  |  64 +++
 sound/soc/amd/acp/acp-sdw-sof-mach.c     |  49 +--
 sound/soc/amd/acp/amd-acp63-acpi-match.c |  54 +++
 sound/soc/amd/acp/soc_amd_sdw_common.h   |   4 +
 sound/soc/amd/mach-config.h              |   1 +
 sound/soc/amd/ps/pci-ps.c                |   1 +
 sound/soc/amd/ps/ps-sdw-dma.c            |   2 +
 10 files changed, 646 insertions(+), 48 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp-sdw-legacy-mach.c
 create mode 100644 sound/soc/amd/acp/acp-sdw-mach-common.c

-- 
2.34.1


