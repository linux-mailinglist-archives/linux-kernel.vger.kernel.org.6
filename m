Return-Path: <linux-kernel+bounces-336603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE70983CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702072824E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC5F53370;
	Tue, 24 Sep 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vpUALedR"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE640879;
	Tue, 24 Sep 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158722; cv=fail; b=FMxAeZYuRJ/r9Du1Pu/f5hhOEeI5W3Md4kSN9b9FPy27rWCtIeUgz0EHu9HarcS5z/sFmem7CX7AanKUB6SjtjVDM0/W0jt+WAeAQkxlo8ZoHE1yTz86CDrNknhZBwsFUJVTP4CyOv242hQhwv8IhCw95CR2sKStRGJlrAkwBkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158722; c=relaxed/simple;
	bh=dWGHTT+poVrRSZFTvXwyF5Hvf3FxF+8H0tmFQzXXwOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ojaibxq3H/p9Tv1nDbNrG03kjbwVxGTKP+3hn1i0R2GmYc76rA5sdK1qkE3II2EjuufmLP2umYtYMIR8CF0hK/ghzpWDPiymvj0zwd1GYMABmU6vVJ2yBXCuglD17+0jLlY5hBF8s424DPw/Xs0i7FkmWmQlIuu+INJNU0hi5Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vpUALedR; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDQ/ISZmo57zMDhC2m53Wgn+albgZKxbTw6LItpvtH8CzfaRL0MjjR0Gca3/OPxUgsptVHLBtsZZqlsWoGWy8i95Az2oF5t5F2nDCoz1Cc6WNwJ6GSckMMLO4XXKx33wNDc36M85Ag+7vEk7hwLBdVuPaqLmox8hAMgW8r8Sxr2j80YQdFkGB5rXeeATIohTh2nQwjw0l0+a0yUoifJ4SPE4PGtEWbJmCEeUfiOk6uLqN89lPxWxj6P5cq0sgR5F7iJcKiVGK60hK2MAH5oi3u4hn/9MtTgSKD/EbPCN8ADwv0RdAfNPoYq8dDUSERdJaOdWMWYl8OBqg/g0QRTmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPExmaT2nIt+cH1CyjmaA98aE1J+qzsigEEBpDhJblE=;
 b=OMqUdXhGvYXW4FzFklgCbhQS3gqRCNmhgnKS0f98igxBUXjzaL9NaiAoBYhXk2xACzNpWLxx3NBOBA/V2R8Ve/9IJ2f5pvdDENN3/+m1EwbSEUDcVZZcsXrqo6UtgANM1VK42Xfm/GJHZm+mta/+kR69xhdrGL5Gp7+qNziYTZ4qy7lmRg7+j8MIOfwAALS3Q3s4j9qifCqsKDcaD8G4JkdLV1Ysg12Ctklzqb8/EhAAtFprG022pyN9U0O5VA8K7p3fBL07K6mMoFfeCjcZ8sbG3HxsQ9duPpq9zo3BXANyqbHrQTkTFxatd2QoylZCNL2nuQKcnO5wr17w4Bg/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPExmaT2nIt+cH1CyjmaA98aE1J+qzsigEEBpDhJblE=;
 b=vpUALedRiW9kBkO+d+5k7UbFWxPbNgjaxweVurFxUrz9o6DjDI+XSZHbiGpJW3tx+j39XZnZar4J/JvzudbPHxxiajdw04THcPiYmHG6dIULZJldEKpiaG2RHow8JJrqwFEuQst8rB6YyP+X6mPGe8bqYPrmQ5nThoV+JzsMYDs=
Received: from PH7PR13CA0014.namprd13.prod.outlook.com (2603:10b6:510:174::28)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 06:18:37 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::85) by PH7PR13CA0014.outlook.office365.com
 (2603:10b6:510:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Tue, 24 Sep 2024 06:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 06:18:36 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:18:32 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 0/9] ASoC: amd: acp: refactor acp version differentiation logic
Date: Tue, 24 Sep 2024 11:48:12 +0530
Message-ID: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e6e500-cef2-4844-7c4a-08dcdc60b994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04DBb+1KbTbXzt9TMWYml90KysD+HVrSm55Pz89C77X0e/KkGZV1Jxp6z1v6?=
 =?us-ascii?Q?jaUFatOPBvwCa2zvUBbqK68iKJ3NZR6O4NFy9ExWaYRRzQXu+VTpe6nfAL9T?=
 =?us-ascii?Q?vnDpVlgsMcmcFvR9rTikcnaYdRZCWy5NY6kXqQWmuxbbgxFtLxtWTTnXLZkV?=
 =?us-ascii?Q?hSPugJqaK+03a/57lvvUhSp0LnEXWZwVunBLU6bHZ8lSEmHpvI4fXJCmuHVa?=
 =?us-ascii?Q?B589GCJvZyaapWql0fw2gkO8jR4rQnLcT3yFkeqz29bTYeQo38NMtP5evsTX?=
 =?us-ascii?Q?K7as8ui2CLN0wGk8UZyzzZ+TJhDiGrJY1WVTsv7Ipqsrup05I1ucmBfokHdr?=
 =?us-ascii?Q?S1HyeHf4OsyBlWJLOuwCb8/AllYE3HgOrXdQeQf4ZyYixnxJt0Dt9f4dZFv9?=
 =?us-ascii?Q?Wf0/huWpxgmi59ohdBKumYKR1BSk3+4/66etuS6LeVlOdIlN8Fo7Jsdxms3W?=
 =?us-ascii?Q?Wk/2/O/eWiU5f9W1EDk4HZ6dprDQTUHJaYTSKCLQsurWtbr54a/eQ8kY5nMP?=
 =?us-ascii?Q?Rzh3EbBnNcZiHn7rro8VR3YCo+7MaUW2ZRw2E6KzdZY0ni90ojR+wLEzVPeh?=
 =?us-ascii?Q?o4kNIGshW3LHcmsP+jeyaAyTqN8aPYNQZDlD9wELnKBuY6uXyo+nuxE6ERla?=
 =?us-ascii?Q?Z0coStSFe4uNhheV22a1RKFl34erVTENs1gasrVln29l6bGfuBWSSlX416cO?=
 =?us-ascii?Q?IolS0bFG38uYKECHihLe5ULBLSIaz6j6J2C7BogeEXy0JHmbAak+B65QftTZ?=
 =?us-ascii?Q?HD07yrslX8A9lQ4P82LyDqHpVBgttTuejsopanDqeo5L0F3OBxdyFnjZW0BS?=
 =?us-ascii?Q?BPV4mmJyqglKjbmuXpXLe+VfgrgpJ7LMaG0dGmEzgcOEjNIDszZ+3/5Jpx2b?=
 =?us-ascii?Q?o3CtZvcA/m68Bjg8NEnxKjt7D4yb785f5rIDGmRs4Z84RMBWkTLhJjK24SHM?=
 =?us-ascii?Q?13FtVTCnmMeyaN9KWGvohoxC82QxQ+cI9bB2FjrccKEpMESlisepyUhINQCO?=
 =?us-ascii?Q?2BDkKnE/IPak/OvsPRjKOCMuTXRnubzUr3bcOH4U7YmCy/r2DyHHzU2Z/14S?=
 =?us-ascii?Q?B6mOe9EaTeBYzHLQRIBz7oGtYRAtjYAoz8hqV9u2VZJwy5Lfgbap0//z6ZYI?=
 =?us-ascii?Q?O8bvbZY/MioilmTBCbtt/2TVV3nPBT1g38FXY+jFgkjLkkwSyoGhon7G7Uui?=
 =?us-ascii?Q?z2f+ZWJJ3wfaK3ZgaKxvL591i0BuWySON2X2yYtN1BlmZxR6ARo+nz9Q8Cwc?=
 =?us-ascii?Q?8/CIkB7bO9OYE3idkt5fbWYffsk8Ulk/xJof3/lbgRbXKRUI9i/Bf5bAQhkd?=
 =?us-ascii?Q?GgFy069c6Btg/HR2VdVzK8Ftf4XnMDPI6V+ZX16oH3uTZqlTLVgT9Q5FYACr?=
 =?us-ascii?Q?Fr65nZMUw7LVktJIAjGQjpjSQ0A2YqdCk/EzXg8Nq4QK/0qX2ddOH9co9mrM?=
 =?us-ascii?Q?P+Ckxo61/eON7JS2uDJrvgWttI9LYnHR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:18:36.7473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e6e500-cef2-4844-7c4a-08dcdc60b994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625

Currently different logics being used in the code for acp version
differentiation. This patch series refactors the code to use acp pci
revision id for handling acp version specific code.

Changes since v1:
	- Add patch to update mach_params subsystem_rev field in
	  machine select logic.

Vijendar Mukunda (9):
  ASoC: amd: acp: simplify platform conditional checks code
  ASoC: amd: acp: use acp_rev for platform specific conditional checks
  ASoC: amd: acp: use acp pci revision id for platform differntiation
  ASoC: amd: acp: store acp pci rev id in platform driver private
    structure
  ASoC: amd: acp: pass acp pci revision id as platform data
  ASoC: amd: acp: update mach_params subsystem_rev field
  ASoC: amd: acp: remove unused variable from acp_card_drvdata structure
  ASoC: amd: acp: replace adata->platform conditional check
  ASoC: amd: acp: remove unused variable from acp platform driver

 sound/soc/amd/acp/acp-i2s.c           | 38 +++++++++++++--------------
 sound/soc/amd/acp/acp-legacy-common.c | 24 ++++++++---------
 sound/soc/amd/acp/acp-legacy-mach.c   |  8 +++---
 sound/soc/amd/acp/acp-mach-common.c   | 38 +++++++++++++++++++--------
 sound/soc/amd/acp/acp-mach.h          | 12 +++------
 sound/soc/amd/acp/acp-pci.c           |  7 +----
 sound/soc/amd/acp/acp-pdm.c           |  2 +-
 sound/soc/amd/acp/acp-platform.c      | 15 ++++++-----
 sound/soc/amd/acp/acp-rembrandt.c     |  4 +--
 sound/soc/amd/acp/acp-renoir.c        |  4 +--
 sound/soc/amd/acp/acp-sof-mach.c      |  6 ++---
 sound/soc/amd/acp/acp63.c             |  4 +--
 sound/soc/amd/acp/acp70.c             | 14 ++++------
 sound/soc/amd/acp/acp_common.h        | 19 ++++++++++++++
 sound/soc/amd/acp/amd.h               |  9 ++-----
 15 files changed, 109 insertions(+), 95 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp_common.h

-- 
2.34.1


