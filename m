Return-Path: <linux-kernel+bounces-327840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF6977BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B001F25EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507931D5CC1;
	Fri, 13 Sep 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tcua7b/I"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971384D2C;
	Fri, 13 Sep 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218421; cv=fail; b=o33j+ipfd+dRcnTidh7fmi8RIF06EV7U0zXqJPTwCv7dauP1K0JQC5pcxsqgK7L4GcOQhZcZv+VLIIJ2bAksIbYxV/hw0gYubf5MoVl8nZmGNdrfgbhlb04uPgSHgvvPTnzeg+UH/626iMYZUN9+9uz2xuLdAaCsMFrPoa0sPUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218421; c=relaxed/simple;
	bh=s+VhX4Y+V+2fgGsKjB4s9ozjvyX13QLU7T5XxdXhOSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lCC5GBVz/pGtxi6d1mBdS3SYCUg8dKKiLAB5fyfOEu5l41QKENEQ+8wlXQBOCuSMlQKzgv5Dqg0Cu3scEfxTUOXugqzGVh5FKh1c6pWNxwfbtWapePXYMgO7YkBEFgDsZJD1SQ5yog4b+01xEsWi/fvjn2f9X204a5sX5cbQWWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tcua7b/I; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmVpGe2uMorBZVr2ptphWEsUHWQM0c4vSzHh3R1PMdvReYz7hL8FXKMZcoWSpxVOyz0h369Ndao3psjGPqgCZKTHi5GWffSpB8WV++39LjwBBXW87SkKH2H7VlQulflBML8XEJ84xmEb2UJRt7mlthlaIaTyWR5nUS/RgIR8n009HhdCEJqzYXImYElf2Q4tYTGyoo7szYDTVBNPCgMiWeTb12XnvhTvY+pGK3XpubBJbe7skzxx6jZV70SPweRu6XOMmrAsuJPp2IE0RtBMGWKRBULsb8015mRoIOiIrCINUNgTKCrWlPgUsTPmFyfm96nxBDm8zz1UvokdT2SgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLTUZRjT5uMw5UviRA/8kmrACc/K4fmleBLLYEYwNgw=;
 b=K5H3ak83p/gakxNg8pRh0tJJeXSCBiu3lMPb9REtRpOWgLQq0I5dWXz7E4tELLf//ReJkaA1pJSKu+TrAQ++btXknbBGoc+cxOAbYXHKiCnD5zPWPgN9x+55HLak94zuzQHRIR9nenHqqdXUWlPgYencuzZ2KO2lk49wTGefEUPLN4494n3a7rACy64a2G689xsj69q/Vck6NOlqXyBSxK6b16oXKyPrMxz9vd4blFFnCzG4ABk2iQDvOg5a3nH2ggXvthCRwJuXl9XJaM/Myxf1xeki37OrNYdZpdmh1dRWiM2In17Hm9FjKEFqCLp04tFVszBWuqShVchMFhkUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLTUZRjT5uMw5UviRA/8kmrACc/K4fmleBLLYEYwNgw=;
 b=Tcua7b/IooZtRhhhY1s3Ydp5YXloBYWaIVcbY0pip90NWyImmAntC7QjLuzr9o5FMKXjGv9kUceNegmC6rq0RBswfimIMHDjhgvTGzFYKhIPNFhivsbjad/7pfpNrNMsO8dGYbDOnUaUB/NXktcojUcv/3knEJ2Mh6rVCDAKl4Y=
Received: from CY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:930:10::20)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.18; Fri, 13 Sep 2024 09:06:54 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::28) by CY5PR16CA0012.outlook.office365.com
 (2603:10b6:930:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 09:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:06:54 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 04:06:48 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <kai.vehmanen@linux.intel.com>,
	<ckeepax@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/5] AMD SoundWire machine driver code refactor
Date: Fri, 13 Sep 2024 14:36:26 +0530
Message-ID: <20240913090631.1834543-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cff6f72-66e8-46ac-9c1b-08dcd3d369ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGODSzpwY//Fz4bFyHc2G49BHcKm3eZJQYcjHUJuUVmUCdAaoTcTf3dKD0w3?=
 =?us-ascii?Q?cBraINg0U88BUtd+r1BYTvZtRcrcrlDCRS5l3VjWDlFWrLzaCjtn8FYY43Q2?=
 =?us-ascii?Q?ualyDQicpD6g2FvT6s/Ggt5Dei1dS0u4wNp893bnXFREC3F4ls6s1CDvTjbH?=
 =?us-ascii?Q?14raeJzM2BIFMCuVk2WqfS5X3bmzwH3A/TaxbHSLo9ysF4f8mgDRfJD7984P?=
 =?us-ascii?Q?5KsPg/RgENiJpN871JSnJM2BCDUXRof70DpM+AgSRUkcFIbomnQMsQA/ztH6?=
 =?us-ascii?Q?B9fRWvEQG9K3zV+2UqicjnV916q9amTauvrnvtgivbQ+QouzJqb3LbsXtHg4?=
 =?us-ascii?Q?olQ6HKGvo48rbUqilyzW2vLkwK65h3WbBgk0ixHUnQHo8HZtaYzkmpfq6U8L?=
 =?us-ascii?Q?CHyy9ch7QhZ2+mYkxqLbQwT7NSukuXbXEwVgj3vsntOyCpDHhgnZnKaoazFS?=
 =?us-ascii?Q?/pLJovDoFY1gCkj6+bLpM0NNrZG+z1s23jeS5hmM6Mb8NG6nCxoa0QWUDF8s?=
 =?us-ascii?Q?GfGkvl6iCaFwVtOCxp8RmxrrflJkj59G1Jh0ubzJOa342cBaxw3qVwn+xcMZ?=
 =?us-ascii?Q?M/Gyx80pIjMzI3NHi5BBbxJMZU6MAm+LzoBAMgaYnTRc1Yq8duwrc6eyOXIN?=
 =?us-ascii?Q?QhS6rERSgMr4Xp/5LK1KJoOZPWvHidfdxp+IPJuzLSID9JdW8x/9wFm/Q4bP?=
 =?us-ascii?Q?hoLfgIsFM3S658Gxp4vNk/4OjeIQxMpjBkoJieadtY2rnAsauR31YLCQiGRS?=
 =?us-ascii?Q?l+c8OddIAXxpiZ6VdvJkn74VAS7MzsyNvAYcUmnNq2NbbpcyRRfzkHCzqD0V?=
 =?us-ascii?Q?8BQLC+gJdyQupAeHCL0P3CL044hcEMrQebq8+wQfOburqDErIgMZj6BBuSaj?=
 =?us-ascii?Q?3IVES/Zx1awREnTHIG9SkFHDWAn0p+SashIEpCsyHf8B00Nde9RUCCWq2dpq?=
 =?us-ascii?Q?Ug/G8JqP/2VqpWhDeXR0Fldin80MBCOIAEeD7/xq8NHbBRXg+/k+hkwJpQWd?=
 =?us-ascii?Q?nbioZZbMMptZBGVs/NKJPMYxKPoX/vsdizgIWLbuTVJNwctwTYrC1bS0kMPe?=
 =?us-ascii?Q?rPQ83YTQDS04UOR9ikPXnPsUAG1fgECE1Z8fhsJ14UKTpUPgPLJrSE47bh2M?=
 =?us-ascii?Q?tVkC33i6aHJY/1eWsr1VmSDV/Gb2ORU9LQOkr8VDNLRIaVWgXCwHgBQKBTSG?=
 =?us-ascii?Q?Xv+hblxkvS3PJMd5mogqLctQSfE7Zf0Qh585WwpmGJl4ajD+Xe5ttu2zLJkw?=
 =?us-ascii?Q?lsZNO6FE63ktXLUaloBU1Lze7W7gxgrvJWFIh8vJE5e3sI6stHXrsaiv/+GQ?=
 =?us-ascii?Q?tocMSK0VS56+YOySjUwllmhIWtRejXrVQmk7vZLD03ivgTKeYRB5X9ir91lz?=
 =?us-ascii?Q?N0pZkjSVakhggzUfpq9+pRsg0DoKjbBgklYk7ZItz9F9j+WW5bo9qKP2P8fS?=
 =?us-ascii?Q?xZnEvBFo+O94FRwMfoM1XPAkQ4zU5eH2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:06:54.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cff6f72-66e8-46ac-9c1b-08dcd3d369ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

This patch series moves common Soundwire endpoint parsing and dai
creation logic to common placeholder from Intel generic SoundWire
machine driver code to make it generic. AMD SoundWire machine driver
code is refactored to use these functions for SoundWire endpoint
parsing and dai creation logic.

Link: https://github.com/thesofproject/linux/pull/5171
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Vijendar Mukunda (5):
  ASoC: intel: sof_sdw: rename soundwire endpoint and dailink structures
  ASoC: intel: sof_sdw: rename soundwire parsing helper functions
  ASoC: sdw_util/intel: move soundwire endpoint and dai link structures
  ASoC: sdw_utils/intel: move soundwire endpoint parsing helper
    functions
  ASoC: amd: acp: refactor SoundWire machine driver code

 include/sound/soc_sdw_utils.h        |  31 ++
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 540 ++++++++-------------------
 sound/soc/intel/boards/sof_sdw.c     | 195 +---------
 sound/soc/sdw_utils/soc_sdw_utils.c  | 161 ++++++++
 4 files changed, 354 insertions(+), 573 deletions(-)

-- 
2.34.1


