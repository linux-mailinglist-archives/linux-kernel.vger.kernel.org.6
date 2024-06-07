Return-Path: <linux-kernel+bounces-205811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F49000A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EA11C21965
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F415D5DA;
	Fri,  7 Jun 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0dTlrkA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE30746E;
	Fri,  7 Jun 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755698; cv=fail; b=g8c0sB+/s/bti2UThdse6/4PCQin795K6Qrpph2lzOh1XP8vyHZJfvr49eqB81Qxz+SusZ7Dh9rRWfTxlJozNumtgqiOkwNefq21wvpM5EMWwy0F+i90Ur+QMMXzRp0Z+8lEsNjnmhkm20BTkLo8p5HfjNge0GMjuOF8iw+snc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755698; c=relaxed/simple;
	bh=rlw+9EgeknZYOaROpyuAMXH0QZJpJRB6lite18Cio9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/I0nu5SMdA1ZDMiy3ybY3SVbIol8MtlanK/HKFym/fKrOoHQDg3UdyukfFlJymq6EA8be8gJArCGPpT62OW8izZG1M4XLz7bjK+5JWIAzrI3CDJXnHlYZhTaQtr/LbmGjKnkFONqt6z311shaOZJELRSZgclU2rTg9iQDlyvD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0dTlrkA; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvHOiDc2tDt/1fwIm/3Zzx0iwIESTJUZ4vM33R+efEqzUdmyu28vFukprTrAgFXITGGkis1x418au/2ztbFTwCBbzulOOylPNX46jLjC/5ik9l2Xa7jr93k4d5caf2aTYZQt30SunCxAPdp7Rz1qSHQZbtV5yfC8gnkUDanifzXyQMZP1xRxDJijAqnb6Q7kyuKTco1qqBQAo0gjGW02UIpf6z1mOCMUQufZnA3eczYdTTP7rKScoiYRCt22lV1WBJOIvlgC1RYYoN+AZ7+icc3Ku/19DTOE+wfg+nNowhfTNwKu3qqQfdoFO1FPQP7lIVMtfXH+/rchwZ8eJuBOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxklPLFgILSCLVjkX2DAgAVcmOLgE4NZCuD9D6ONueY=;
 b=eC1MwmOLhbYY/pHaSF7h0v4uUiJqHIttz96Chf9HiVfo2TepdJEKX1qHsu/Lq+qKdrnSQ4WQ4p74ECmR5G06KXW8biOWvspCkow2A6ou1DOuVnzOfGAuy1xCHpvs/cEGRdakeW+0ESLcJGiTBaSeX8F16NmVxt+TEf/6n21aN710sGpByG8F62Whai+fS+G/8HPJzzPv3cJQvQr/HpCKvls+Ol3Tc09P3g4eUZWAPtNELvqnJJ5c8ZPwBLnbyEO5vHNQJjc4qqpNcYPF98vQCOPN7MbytHX5r9c27nYTD+M7R0TwBLn3yDWT4F5mwIQ6FCqW6EoFO1yjYfiPDBEkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxklPLFgILSCLVjkX2DAgAVcmOLgE4NZCuD9D6ONueY=;
 b=E0dTlrkAOU7edyKThCDtCG6qDjrlE07e3jXW7JVHdy1vqxNt0nkUa1eGKhXU3N8z9H+FRuRCqbs6D3ZQgu3+5MVN+0vNEnStYx8LWke/2PYsJzdSae5lbzWzzO6iLPn767EPcpWOgCOfsPyj1DzJj99z73RJW6KIDIqBrqXzuRYwRYRVY0N/FhxNYX54fwbFM5GKlCtxv8bC9wzLg9MF9Bxly1XcymCJ3dY1qEIas7XngmSy1lfjp/QGaQ+xcbnGas9tw/V06BXUZWsUh7C4ce0irC6xj2pbv8nQ8dws9+NyIoXnqxLydeuAhpF8QwNo1tiyIDQy/p0Im2AokUNj2w==
Received: from MW2PR2101CA0036.namprd21.prod.outlook.com (2603:10b6:302:1::49)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 10:21:32 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::3d) by MW2PR2101CA0036.outlook.office365.com
 (2603:10b6:302:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.9 via Frontend
 Transport; Fri, 7 Jun 2024 10:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:21:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:17 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 7 Jun
 2024 03:21:16 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Updates to mlxbf-pmc
Date: Fri, 7 Jun 2024 06:21:10 -0400
Message-ID: <cover.1717755404.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: a649622e-ff5d-4c88-ea17-08dc86db99df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7PEaMzLvjoLf+fZwsTInRgUSo1GDFo58FzEnYqfeYjZuaxlZJSSlpPxgbAL?=
 =?us-ascii?Q?cbZ8r9W3tqZ5TBwkAuXF1aVg2+0G6y8HhBkD3v95M/ylzPwtrzNBC30gMEzn?=
 =?us-ascii?Q?eacS19RoPFbB6Es6zzdsIRNTqCWY61hfSsrIa1JcdQluOtFK9W1ECHAxAy80?=
 =?us-ascii?Q?/xXLp8WC11ApnVryhL4VtRhGIV0VJejtHsLV0K/lDSuri2uvd31aSTjpb0Et?=
 =?us-ascii?Q?wTpd/0T4Hmmgees6GFBIA6jePVmA/Gelp8mxNCwx63SpRDzQhFAD7/Ii6ceh?=
 =?us-ascii?Q?NiJ1EvmnmELA7uD+wWejXbF4YTa+Jfe/BxBSrQCKRHf0OIt+1Sy4BwhmGxku?=
 =?us-ascii?Q?yNg721AI8pFfQm1pz9lnSHzo/uU8/tXZu2D6UgXXeNki/bmdTA3L7fziJO1b?=
 =?us-ascii?Q?P6oxJiRvnwVzRKGBLyJFVndkqfdrOADt4ZVffnD44ZVqwn6//t/Nr9SGUToN?=
 =?us-ascii?Q?8DR55MJC0mTmE5U5qHShxL4G0Dhq0NM5RRsLZST7jDxl68RzoSCvdXIen3cU?=
 =?us-ascii?Q?HEE81FtL834v+lxmTFPxQ4lVMLLA87enTQRkYDUvX10heht7WPQyY01Xy6+H?=
 =?us-ascii?Q?rxMoPB8z5rf2wwBNQ5SXzjH6Uqfx5c6Nk2YIG3yWSJRLFPdjOS1W9o/kuwAm?=
 =?us-ascii?Q?8McxGfPWKo9MMfOCMtxujyd++zcpi1O3TpufqLW8XHBdqNthwstVgeVhMX6t?=
 =?us-ascii?Q?Yg3bhH1I8guh045W/zj4lxiYPX/V4PvD1B8pevdohxxcL/cZAMCTSQtQyCDb?=
 =?us-ascii?Q?eDN2eQJq1nMa+NFbeNOVFbPrRQsK1i4gpje4o5x6wLJxSnDKsFXeduvGQomz?=
 =?us-ascii?Q?DNK+Nv86+fg6wYTEw/cWNb2AAVHEbnZ981pyfzPXc8A1Tl4XqvDA2RdcQTmx?=
 =?us-ascii?Q?vWksQkNA1iTq9vD8OI+xCKSITMFcAMGrxP3Dl+7AhDvZLgE1MIL1dftt8pmG?=
 =?us-ascii?Q?yA3+L+HrtwUHVfKvAcz8c7JhBa+UbLoEzljoaJcKjZXFs2ySKGIHLTS9fboS?=
 =?us-ascii?Q?aqYfmzfO1Cx5zduVWzPeg1Bn0mYLFMbc2K++N/WeF0t0cQtxMQjk35fmjhVb?=
 =?us-ascii?Q?cRQhC91km7+Ye03tq4WjkPaNuOlUScNYvSF0UQv2LV3h0xqUySORFuKAkI35?=
 =?us-ascii?Q?spEFFr2EAQK6h0DDbSFx5Sq/1ZXfw+o4CWjtlLzlUoSPbD0DCeMJgB8FHK3w?=
 =?us-ascii?Q?TsEQPSTogP7rtRsVQWmpxmJOytjYf8zjC4CXzW2urXJ7ph7WZsGI0aJO2SSU?=
 =?us-ascii?Q?669ZzbQLq5BJ8Qt+vX7g897RXKUFuxaVVKTEzjJHWkC5QMrUONSHv3paQn6f?=
 =?us-ascii?Q?UK+Ok/VhsBw7QWxWJKKmdtukgs7bE/Fgqz6NjkRLp5okZ7vrJ6Kpt2YhT7oz?=
 =?us-ascii?Q?6hZ3OxYEdi0dMJime2whS4GWCJlteIzt7tkw9kLVdVz5FSa0ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:21:31.6847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a649622e-ff5d-4c88-ea17-08dc86db99df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

This submission contains 4 patches relating to mlxbf-pmc.

Patch 1 adds documentation for the sysfs files created by the driver.
Patches 2 and 3 add specific functionality to the driver for supporting
64-bit ocunters, cycle count and clock_measure performance block.
Patch 4 adds documentation for the newly added sysfs entries.

v2 -> v3
Updated documentation as suggested to provide more details on the
sysfs and driver functionality.

v1 -> v2
Added patch 4 to document sysfs entries added in patches 2 and 3.

Shravan Kumar Ramani (4):
  Documentation/ABI: Add document for Mellanox PMC driver
  platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and
    cycle count
  platform/mellanox: mlxbf-pmc: Add support for clock_measure
    performance block
  Documentation/ABI: Add new sysfs fields to sysfs-platform-mellanox-pmc

 .../ABI/testing/sysfs-platform-mellanox-pmc   |  77 ++++++++
 drivers/platform/mellanox/mlxbf-pmc.c         | 180 +++++++++++++++++-
 2 files changed, 253 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc

-- 
2.30.1


