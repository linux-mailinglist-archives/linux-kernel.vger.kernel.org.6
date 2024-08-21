Return-Path: <linux-kernel+bounces-295592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB04959EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746791F217A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC31A4ABB;
	Wed, 21 Aug 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4n4T7C/X"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD91A4AB5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247394; cv=fail; b=aBUZ4BtwHC6jXSVRPmd61pcXt4SCgslTj7cNhiT9xezqFlVLSDBGxGzOQhd6bn3qEdwCViDLsegxbK8c11HuaoZjdEGoEQ/ezgKlbB56HRZYbdRvr7QKW8liDDx21/yDq3Ep+SLBd2k5/Aartir1pmO8oIB1gi7LV3bvAAdjRGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247394; c=relaxed/simple;
	bh=iOTB8ynKCIG6tEporsCszz+x8NfP/DGDvXhMa4+g0cY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iq8PoIgM9CuqupM1n54COVeWA1k6f6SfoihZ8eGWWvnco2beC13BD5qNAQtsEkGXarM6Er89aPun5hGYbhpfZ5wZGqN8fq+MFUiFZ+0CYol+J15jogFsc6CjMZeROeoCD963XjFAop2c6LbQY80AkQS6oGsBjP1p8fnNqJlAHAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4n4T7C/X; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/p2Tt3X4b1KzmAd44KOz4IUVmW6x1cfTUAYehu7PdMoLGKTFzRbwHlN8Klz8sqRITW/RHdq+G2QWfq9hrSC/hsOnkByefARe6Ix123bsJPLypwIOE/0POfEZNrSc3qhpAgKlbl0E9zP/gK9hdpTC4mbc+17WISbM4pvo9QNIPJFxvRpF8A7iI1zJtdI/nlsc5LWzEh95biAZjt48GtkXmirzy5YakhdXkN5YTGlyyQrUN0uDy38OYwQbx2jR1DtFdU20/Xqe0tQ+Y05I7f9QhgXz+LqE/PTLhPv6xhGYC5lSYtYszcwQSdHgb6dL0HWOGYMVneXyR3oCpgj6l05Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO9XXcYzkynjmrliLcKf8WL28zG2iOhuUjHL8J3p6cc=;
 b=R8ZRPY2tqYOGZNrHr4+LuLO54cy70bLgLsLZwEoRCkA/E7ItsIvnB7TyrzLDFOmtw7idXia1Jd1h1kSzrAf1LMl2NC2M2gWYVy/QHYVvyOgNMfw4ir5NzTzGUrgB0AdjBwB9isAmJv/ZfI6+q/PQuG6chHzQm9hp60+S+8JAGoQsfIILmS15LFBh3d0mNktFRNvEjmNsIv9VV5hPe6F5QzyFpIpNKv8DM2SibaQ9ocmUh/qpBCQvgeCtBIkbXON6JAg60SZDv9vhO4jQiPUoO/LAgrekw86PxmOJw3EizACCfLoiiy/7swZmi8Pdo4GVmY89/nA6BCIzPd5debQNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO9XXcYzkynjmrliLcKf8WL28zG2iOhuUjHL8J3p6cc=;
 b=4n4T7C/XxvSy3RtAjuEvL75uJk/EzAmuig82rAVfsXhpPj9xZPGZSjlmmj0alWwrehN52OhUWutn4z/gx1tYX952wQ0qZ37jnMkczdiAa7Rzsbl/Tx0pfMQn2CtcAc+AetXBVG8iyN+f4bI1JRSGOi9rDwawsi3vHZ09uONRwMs=
Received: from BN9PR03CA0127.namprd03.prod.outlook.com (2603:10b6:408:fe::12)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Wed, 21 Aug
 2024 13:36:28 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::53) by BN9PR03CA0127.outlook.office365.com
 (2603:10b6:408:fe::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:27 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:24 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 0/6] Introduce initial AMD I3C HCI driver support
Date: Wed, 21 Aug 2024 19:05:48 +0530
Message-ID: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f365493-c5f5-45f9-28bb-08dcc1e64203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jb2oOw6XiFB8Cu2jF0CBBBKDSfzj3K/p+TuS91RIRh/A62AGhnmGvIM8JV4m?=
 =?us-ascii?Q?yWE3WTlWQNzfttJW5LuPsp7Nwk2cPh+/5ZkrKYN4zRHdks44X0i3+Zk7Srpj?=
 =?us-ascii?Q?+R/QRAWHZ3QXYNYsLP1NlqB+ajeOn1SrabCGxE9IH1xTIW4qz1KdUktGyUCl?=
 =?us-ascii?Q?JuDQmRf8O7GukIKan1kAjfNhoL4Qwcf547yRH5lPLuQWwXWr2nmU0VCZJTm0?=
 =?us-ascii?Q?dX0mMH9kAa8/PZliROnTvI5Z+V5Zu9AeEbaJgdL1CFZP+g1AoNcbSQLZFrh2?=
 =?us-ascii?Q?FLfWP+g7QqSLpcEsh8w9xcDkxr82YnJHROIlefr40yq3F9APct3+ZfljPOB8?=
 =?us-ascii?Q?fDU5NbqwlWESsYhDcpE1FV22cCxb90xT7Tes/WpnIrQqBqnZuCZiLnmkfMp5?=
 =?us-ascii?Q?oUQyrmhtdyARKAEfhowJSkZuIAZr+qQUEWebsqgv29UbRPJRhWCyR8jL8bLX?=
 =?us-ascii?Q?tg+CQzj6bLw9z1MbIHIG3lza/wyyfNsNPxnEsDHs0eneJ3z0QLsb2M7He6Fn?=
 =?us-ascii?Q?0rEIjAb2ruQDoJ9fLqUJr8qXWtKgDzRaJxlVRAm0UHGqLwSKbybgmbP4eVq2?=
 =?us-ascii?Q?bRmnCRiCeflOed4NKPxrenAXVaGZehzprH/RYisv1/XPzU8dOXNV79XLHgoT?=
 =?us-ascii?Q?Fv8XNtavrRetoqgW33bCd0rCsCh7FJnX8nC2fweh35hPI1w4JSHdcdq5oJ6r?=
 =?us-ascii?Q?bSIZPBS/5iauQb6qhovAgRSeeh4zYn7CgFzQtjMnMc0GkN3UpK/gRwVDdKYg?=
 =?us-ascii?Q?xNSOWTQ2dhp3d8k0vfMZkqelInfgdEfh6tLA1KnH5uSd+/Q9jzQWReKrnJnC?=
 =?us-ascii?Q?cggeznIDRWeqZU1A+VGEV7oF93INg5bdDHQG1Pn9OmylUhLz/odUdHE0gK9e?=
 =?us-ascii?Q?Cuw5+gsdYs2tZPf1FsCir9+ec/ZDuyseZKJFmdlMF74kx0gZgbF9WaIu7Qi3?=
 =?us-ascii?Q?3h1mg7Nuy3rJY4QoeulRVtLx/qh8tm/htyI9dpXPzwiGgob8FB9So2uaCVDo?=
 =?us-ascii?Q?cjkYHEkEKS1YizgsfOgzyU2sVVt9bRp+yF+iagB4RoHp9gv8kX/kcQhQUaga?=
 =?us-ascii?Q?WkhiSDx0RuE+Uso2YxheGzDrOkIBfrb2u5KWJWlRyjgfFqzPAxQ+ww8NIF8e?=
 =?us-ascii?Q?gwR7DXYUUE+RTinZSzaJRBubMGJVZfpn+4nqFl7T36igCHKARR8McK4QXZo9?=
 =?us-ascii?Q?Q04gepVpuYTAYDzn2pYj/u0LGgGeYAnzOo3Lh36rZE1LbfOwQqaTTK3W0Bxy?=
 =?us-ascii?Q?Um4IYjtysNnFqb8/3gy96vWZ5qdOpyM6Y21v1j2QKa4WDD/GiJxfZiz7GQcy?=
 =?us-ascii?Q?AlNW7osNL8YQzmhXwL06SlIKx24A+ngAfCribgtMPabpthgcXwBBLTwNEFPO?=
 =?us-ascii?Q?2hdJEItsZD9mNvzBKIFAALJMggzbE3cWLq6rwhAXmlmQAojyiLvIhdEnK8je?=
 =?us-ascii?Q?2oIbjmf3eXM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:27.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f365493-c5f5-45f9-28bb-08dcc1e64203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

The AMD SoC includes an I3C IP block as part of the Fusion Controller Hub
(FCH). This series introduces the initial driver support to enable the I3C
IP block on AMD's latest processors.

Currently, the code is closely tied to dt-bindings. This initial set aims
to decouple some of these bindings by adding the MIPI ID, allowing the
current driver to support ACPI-enabled x86 systems.

It was discovered that the AMD I3C controller has several hardware issues,
including:
- Non-functional DMA mode (defaulting to PIO mode)
- Issues with Open-Drain (OD) and Push-Pull (PP) timing parameters
- Command response buffer threshold values

All of these issues have been addressed in this series.

v3->v4:
-------
 - use AMDI5017 as the _HID
 - use quirks bits within the .driver_data()
 - Add Reviewed-by tag

v2->v3:
-------
 - use MODULE_DEVICE_TABLE()
 - address comments from Jarkko
 - split version check and quirks into separate patches.
 
v1->v2:
-------
 - Address LKP reported problems
 - Guard boot_cpu_data usage with CONFIG_X86

Shyam Sundar S K (6):
  i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C Support List
  i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
  i3c: mipi-i3c-hci: Add a quirk to set PIO mode
  i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
  i3c: mipi-i3c-hci: Add a quirk to set timing parameters
  i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold

 drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 +-
 drivers/i3c/master/mipi-i3c-hci/core.c       | 33 +++++++++++----
 drivers/i3c/master/mipi-i3c-hci/hci.h        | 10 +++++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 44 ++++++++++++++++++++
 4 files changed, 81 insertions(+), 9 deletions(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

-- 
2.25.1


