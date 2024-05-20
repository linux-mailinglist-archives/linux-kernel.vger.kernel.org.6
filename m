Return-Path: <linux-kernel+bounces-183701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4D8C9CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E41F22D71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8D53E02;
	Mon, 20 May 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BynA7bod"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAD1B960;
	Mon, 20 May 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206217; cv=fail; b=GIOTMQEVHlfnKa5jZJ9TcO9IaBssgeR5Ohrg0SwtecIitFbTGzR03QjUlxPzCFqzoF5ajMdld5a+RtmbdsKjXF/42WrQPY5OMxVWyKZL4LJ9uWPgqrKRiz+eaUBImBXqFFd9RyUPJ0tfvrknVkmINArO2mB1Y4XxRT/cazOP+V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206217; c=relaxed/simple;
	bh=uE70h/Cb/+MqCqwC0ECOjifx/OhfsMbzhpDhr3rlZKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVElVVhhsGs8krdFf52oa9UfDMSGGyfV0oaUsY/gchP4otXC7X+hhoo6a6p63OGomQj7T9O2Hyt8UX6h3hlXsjQSPa+0hBfLnRElefI7PHZRollQGgyKTvLy0FDX5pAOMvY4fAG1CAyzLoC6emhoZwGv2NmjBsKNlgqwEHu6mbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BynA7bod; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNfcNrxOD1RVmzGbx4szf8wg6jkJFVuc4QROgZ5GPbM0kSWz2KkoCqZ6VOJ4IiwQ/Wls/dPPCmh3Z62IPq/+Nkbm0mEjUu0eyKL/agT6f4B5kCfrfcXR/0LUNtW9jPvs5VPS29otSw7md/RgulCphJR7MPUbPtBWTMa1AyYF8sHIl7ym9xATE2Cenljx4eEcY5AWs3QSoJykuTCpLZWZxiwqaccmPIhSpjzfNV/goCjEiQ4XY8g6tJE4xH/XlMC7VU7FZk6uTha8hM4Ma3xUmzJqJSUyppMURdZDJPJt9tGqakBsSrDonOrl39zp9xBPizibBZk6IdyYDsv1hlxdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9Yxu0K1y6YksFBntK1Qv6LchiA5OveWmXePqCUc+ew=;
 b=HmeVDtDGlmYkGdfbbzKXPsKBdHBUQLkQ9KhnpFz+O1s2XsyKCo2JV9PT/izlaE6xwKF/TEuG+95SUF5BZPIl9E+MGczu2DR1Z8NWtaVKyb9W9rHJw0X8U5JzThkAYYnFbFP8IOxeExslS536dPSEPLC/YgRNpqQM03vZQtIcYuz+FNT3X6JE66TPfchhlNS4SvPhjItMrFO74l1+KXor5NZ9GuwNi6LLu52q46DB/S6nLxQlc+/rX/GA25qhw21dblrZQA9aSpquX93GGqeUAEsy2EGjsvXYuvp2rr6PSGgcWjqmoR5h1UUEAQtJvqemDWe6SflIwVH0UPbASFFDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Yxu0K1y6YksFBntK1Qv6LchiA5OveWmXePqCUc+ew=;
 b=BynA7bodr0dyewCBh6OIv7g7s/TAQ2kLCBHTZ9wHqvogUDD9q1xP1Cm8Kp5SGPNgmrEg+/jOHoA0Nlv6VjaVG22+xaCskwNMS85oJNjxrU4ELF4eHmBzVTdGBaUF5UujKkVmz+ijyTcXwAOz8uKnjnCvDTJRiEJa1uUgSbP0e4ks5fHlYldIC5pPPMMqT1JjKg1zc5oaTpQoNwvq7o6ZAYxqUsOr89jQIGuKrrCUJBEITdO/BtGRhUW0rUMA9GRs1kvF7QSIXzWurHH3XRNkoQx7qtBg3TIc2Z02lCgtqwOdSVJT3uxp+WMrXLHShkH4kpGGc/S+3OgRwQflyYJEYQ==
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Mon, 20 May 2024 11:56:50 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::81) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Mon, 20 May 2024 11:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 11:56:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:42 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 20 May
 2024 04:56:41 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Updates to mlxbf-pmc
Date: Mon, 20 May 2024 07:56:32 -0400
Message-ID: <cover.1716205838.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce6b660-a8a6-452b-cc20-08dc78c3ef22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8U5ngXj3yPqSIMYutME/ICW3YBG//pB5bK8Np2SfbQ4EAn8G60VEuMrtQR0p?=
 =?us-ascii?Q?3JrocMmGmeqisQfNMy7P/PI5Y89LL9gKyoUbhPZLkrh/yErffeT5aJoa5QZm?=
 =?us-ascii?Q?i/RX4d0Xjmo/1MLMfkEhzgXBcDMwN+pITHJ301cBlFS8jDwxajWaxStRIheH?=
 =?us-ascii?Q?s4Hi6RFdnrTIsCVW0Wr9ZDzARg0M4ABBXIu81qwIwiFzWj4BNpKbDqzeT6VP?=
 =?us-ascii?Q?16/zcxqY89oNwzsZp560UnrtkeI3cOJTuB6nsJg4W8ciRvpL6w0B3S2SA+hY?=
 =?us-ascii?Q?UnXsp3oVG/R+1j8DNhFv5UUS4cQT1YxkdEDgnGF2gsfANExjmBWTVJ758hKz?=
 =?us-ascii?Q?+/QquZ5pX5owJD7szgUfAQyHBBHAbx5FleB6LeHpOEpK4rSYyr304ehvG0r/?=
 =?us-ascii?Q?wBOBNYcXeqZUDC/KT/qslNpXGP02+G7lsWbxepe1DBxBtQaCEhDaxWI5+Wvg?=
 =?us-ascii?Q?Z/dDWWqt2o5pEDJqWWpNxT5jAZzbTHCPaX8pz2SqehazwLzpzTI2v2C1Cht4?=
 =?us-ascii?Q?dQV/5m98GvdP8pmdPf4tsOOD78CF991ycLyrjLzanMIzBUpAoODajMcagk8n?=
 =?us-ascii?Q?n0QUDgbCbzoepPV60KoS1bk7jjnIP8vitCdHhahVrzNgkdNT8NeWOMkBSfEg?=
 =?us-ascii?Q?YcYDpFFCk5oIKdYueqi/Egi5W+O8tSbEmnAeaM20Rh58f66Nkbry5CLw2Fz4?=
 =?us-ascii?Q?onZDISrta8P1/7Ff4T7dsWw469qqGxKnKe0hS43Nnlh2p3KYOpffmAaoaPfq?=
 =?us-ascii?Q?hpFXfHw9D9mJjhFtEzF3+W6l5kX9ZymwXl7vf09LVGdU0PJJqFw1VMlDAA3s?=
 =?us-ascii?Q?n/mmJw3AItoj+H6lvNv+WAoGVl6ri2UE64b8n7xNZw/3MXiP6m+s3mpFqTOH?=
 =?us-ascii?Q?BYvwhUxfzNxY1PqbpKM19JcAuHhbpP5/daAF+Y8a2FHDnbkSX9vb3v+OIlo6?=
 =?us-ascii?Q?yruC+XihXMMqLPIbL0XSIQgm5s3QHyE8tqMQequ08mrb+3wTUGrIAqx4SuVp?=
 =?us-ascii?Q?/4wiLTXfUo3sIldZPVH09XykpgSG3nfCRNhgpjOYFgkwXmqAJfRihs8ujGGs?=
 =?us-ascii?Q?EuQ+oYaz6/hTEhhsoRMqx0UO+xIJyZFKdkvqCuTCdsCPsK2AQdJ3I+o0GB4M?=
 =?us-ascii?Q?D5dUpT/PuKvV+zFBAPewzkGKCfE1YHDpzVukBR4tEKnUQRD+o2A8Y0PoZpm5?=
 =?us-ascii?Q?Jsd5krsqlWOvO3vNNe8qDDeSioJLQM21Jqh6WSIbX+FAYp3tf7l6WObRg6i7?=
 =?us-ascii?Q?nsHgCvBFi4Li2MexhJVnSgaCjfEt7evq6YUzTgJhE2ddYw7SvCx9IjO6rpIM?=
 =?us-ascii?Q?vV/MoueZbRhnkpFidWnFA1DxByKjbZBzw1fu3+dJ00bt4i4BVxNvmi0C23Yv?=
 =?us-ascii?Q?uQp2UqBor70lKyiEIVOSmLsMKsTw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:56:50.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce6b660-a8a6-452b-cc20-08dc78c3ef22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

This submission contains 4 patches relating to mlxbf-pmc.

Patch 1 adds documentation for the sysfs files created by the driver.
Patches 2 and 3 add specific functionality to the driver for supporting
64-bit ocunters, cycle count and clock_measure performance block.
Patch 4 adds documentation for the newly added sysfs entries.

v1 -> v2
Added patch 4 to document sysfs entries added in patches 2 and 3.

Shravan Kumar Ramani (4):
  Documentation/ABI: Add document for Mellanox PMC driver
  platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and
    cycle count
  platform/mellanox: mlxbf-pmc: Add support for clock_measure
    performance block
  Documentation/ABI: Add new sysfs fields to sysfs-platform-mellanox-pmc

 .../ABI/testing/sysfs-platform-mellanox-pmc   |  65 +++++++
 drivers/platform/mellanox/mlxbf-pmc.c         | 180 +++++++++++++++++-
 2 files changed, 241 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc

-- 
2.30.1


