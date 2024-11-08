Return-Path: <linux-kernel+bounces-401187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C69C1708
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5751C22090
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797831D31AE;
	Fri,  8 Nov 2024 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ndvMATa5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BD1D221A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051249; cv=fail; b=KaQ80ksatRTZ0ZSLSu6OPvS64gbB0BqkEINeRgk176leNuchqI9m714gvw9yQRAp6GqKrOznOah+Myacyi468TiHcgv4oS+Y7ez/xetk9iElRHEDbKoSas9AGByf7gtHMZfpWzwqcHTglVVKYNgDQ20j78fBoxZznkKqJ4hc4Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051249; c=relaxed/simple;
	bh=k20GCTSGMXjyPvWAQ5TVR0hErnG5GE0CA0lepAhkC8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMJcEgg4hum6ZVlphp2zKOMTX4zwH/Ya4MkLA3YFYEcw5baC1V49kEWyFes45YlhBTR5sEOQZN8SFS7RrxyXw1OcC4ZnVv7IMPmEbRKxb8N9Cxjoh3GPeK8isXRauUOwMpkKuBRveq32UqCUT99bawyIENYO2gXJUquyQHK05CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ndvMATa5; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtFegiJOuG9Q884ut3xb54Nj8X8aoMLMm/+qmNdPPSVHkQZG73MZJPKpaw1mGQIxsKxR47BapCLubUNdgzC9jBFKhhWkILZaWP7TdloU4X2P7f2y9EkJMdeiqS2jnhpzLUhypWqasm+tvfkOCugx6HHG8KOp/Pz2cZ8C48bS12YNOVQ4jw9HO1F5eOkgibou//lEEXbACpHUeoE2qsN31EqMBI937XNESKQo72TgkEt3kmWhomNL5OXi2J9VGVeWaKuOcUCbrzUZyENTzHy9Jrhr/NSVvEY7A//Jamn/UWBKf1W7m7m8dnuVOxQBHRZiJCW7OcdIE2lD4K1uGVGcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d9GhOoObTqH2gwPJUFVuZVRsJ0JipBxNzfuex1sHr0=;
 b=NaTxMuwVA1XlyQJ7Fo2ghx7IreP1AxZ5b7i4pvAqkHNfSy2fRYOq70nGngGUe35BnO5OOWMaMroaAj9Mmlq1PG/dFdEjv8VJzHgpz1rxyxk0pyi5ckAIPLkOuLEvLwMgUgtkWOZvjR6MdVkIc4/3R3RwnNu2kjiq1DEsj0WB+Uiy9jZ2rRcaLncJUBx7PWTF678SmbRsjiVjh3DAGQh26OELNRj7QN6XenvVrbHbuuk9zbGuMvvijvOyQsJ7U3+zj0JvyKPpyHBVbkpUk/9J78f/AWNSEiDGBvsxmUakH0+zzKvmE298aGda3/uqNOAXgTNwTYcZIF8gIGSO8p9SGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9GhOoObTqH2gwPJUFVuZVRsJ0JipBxNzfuex1sHr0=;
 b=ndvMATa56nuEejVj2eV9CyuLVEdX5mQNMtLALrBpqZ1TxW9DzEsGcT4C/CmW5xFJFhT7BHTqj+Dtsx/3gG3CCuW3FPV7+9XxH56tx2f2BZGCzpZ07pXq5e23OmkeSRLUeVrKf0B7nmBPwl/MA1YjSE+B/WiXDzAzJjY6xIWBww4=
Received: from MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) by
 MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 07:34:03 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::22) by MN2PR01CA0061.outlook.office365.com
 (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 07:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Fri, 8 Nov 2024 07:34:03 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 01:34:00 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 0/5] Introduce initial support for the AMD I3C (non-HCI) to DW driver
Date: Fri, 8 Nov 2024 13:03:18 +0530
Message-ID: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2029f68e-9557-4fdb-4d84-08dcffc7b876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuOGMm3EAavJ3/nZSVbW2BmfDuuDW61h1X3is8aRx6os0EVJTQf+DQYLKXv1?=
 =?us-ascii?Q?+gprDZtcn5HEdAVZPR0crre8/1lwUW/h95sm8APBBHfsuP38gnCCZiZHw3n2?=
 =?us-ascii?Q?WEAhOlfHHH7RwwXtUm5lMf4HWabjwBtID+FkZeNFoCTgCTwt/isbrLpuT+aX?=
 =?us-ascii?Q?dMcXf7EFVDVZXIbf+GqzR9lk30Y0N5z1qqBHiN3GULbz9YhTskb470WVvNUz?=
 =?us-ascii?Q?neMmsv2nxw8aaRFRTNGTD5mgNF/y3pe/lgq/S1Ap33NboJcMBms7rwS9rVau?=
 =?us-ascii?Q?w+wIsTXsOQ6NUZfF32bYxTAFERiXpyKh71AY30RqmNylGMmrLD/31itby1SC?=
 =?us-ascii?Q?wUZWbeQGEflIIWwpNCgiIwZAwpdXLAgyguEq9sGLuKU4lGq4W1CsKtndeAxi?=
 =?us-ascii?Q?asJpxN8XBR8OCMuETwCCOHeumWTqYIc7d5V0JXIwJVUm/dfUPn3syuZT5qcy?=
 =?us-ascii?Q?xqMmj9I/Jwxxi4vDi+D5uzEhaaLVzQQVNbPPrqpycK5tRfhiLBEt83fhQWZR?=
 =?us-ascii?Q?+F/+Gv4g84sN3nz56VsYhq/oh+ar1GvF8XEtqdayDRvPXzTeL1LFkjn71V3X?=
 =?us-ascii?Q?+ww9VoCGACsLGkvqqeWRR/40tqln4u8yjgTFrQuBInSGyDkhAlOosWhdNONh?=
 =?us-ascii?Q?6B56nyJPYbwtflOonIgod0IMbtduKm765X5dqdsWlKnG/+ZLXPMasfqxdEX5?=
 =?us-ascii?Q?RGdmZuzimZ8J9ediB08qjCkuhTF2CM015n4VhbyrtCiOMQMhIXVp8gWOXICJ?=
 =?us-ascii?Q?K9KDmzmMPGJwjEkYL4R9kgUcsqvQuT1/cZXtDskUdFOdTCRDCut4h0lWjKfI?=
 =?us-ascii?Q?eJgUwJPGZGuSmAMRY8+3rPsCPKi+ThWayoEohvTFOoWiowO07b4vS+yuY9WJ?=
 =?us-ascii?Q?OuiGRjrKF5uvGtj9W/yiEz6SUBI4bNWw91IHhxCNgcTTr5GQ1f8PCrqgb29W?=
 =?us-ascii?Q?JcQOhUWFIs1ZbcyYTgNout3bXqgBSFOiq8zQCSajyi1pusJigKYz7iZ83MEb?=
 =?us-ascii?Q?dy0bF3eqTtlpzydTP8txfoRyRhPbpWC0MofHTcABpNedemxBD4Uw9jFAzNOu?=
 =?us-ascii?Q?+fEfir3eHT/wOC32zRRIT77qYdZ2vVZGjFZwwHtE0qxNkK/vdV/XxAzl0KeU?=
 =?us-ascii?Q?Vdeo4WN8ODVmCU00/j6xVpTd8XujnAwrOWoEKvoXKymwux7kzZr795OYcGNe?=
 =?us-ascii?Q?zHDhrsUetuQCSr/SqVTVlIp0z1X4C4vozNB5czkWZEEsASbRNIC+uflD/30J?=
 =?us-ascii?Q?ayDfueaesKz5TkIHPG+I70JKSlYdh36cPoAsmTyTOIjz5AlIbrZk1FDEGdSK?=
 =?us-ascii?Q?+71/QKOPJQjTVGKkRXRhW/3hPq2CEjb+kWxiDOWLL/KhpMhS9rXr5X+xcbn5?=
 =?us-ascii?Q?Ns0HrhczEkGHS35q+qZ1jSZZA+kWn0a9WOXXK64VJMLOMlev8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:34:03.7478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2029f68e-9557-4fdb-4d84-08dcffc7b876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

The AMD EPYC platform design has DIMMs connected over the I3C bus, with
each DIMM containing three components: SPD, PMIC, and RCD.

To access component-specific information within the DIMMs, such as initial
dynamic address, static address, and provisional ID, ACPI support is
necessary for the I3C core. This requires adding ACPI binding to the
dw-i3c-master driver and retrieving slave information from the AMD ASL.

Currently, the code is closely tied to dt-bindings. This initial set aims
to decouple some of these bindings by adding the AMD-specific _HID,
enabling the current driver to support ACPI-enabled x86 systems.

In this series, support for following features has been added.
- X86/ACPI support to i3c core
- Support for SETAASA CCC command
- Add routines to plugin a SPD device to the i3c bus
- Workaround for AMD hardware
- Add dw-i3c-master driver with ACPI bindings


v3:
----
 - Address feedback from Jarkko
 - Drop using SHARED_IRQ flags during interrupt registration
 - Update commit message to mention about SETAASA
 - Use bits [6:0] as the static address

v2:
----
 - Address LKP reports issues

Shyam Sundar S K (5):
  i3c: dw: Add support for AMDI0015 ACPI ID
  i3c: master: Add ACPI support to i3c subsystem
  i3c: master: Add a routine to include the I3C SPD device
  i3c: master: Add support for SETAASA CCC
  i3c: dw: Add quirk to address OD/PP timing issue on AMD platform

 drivers/i3c/internals.h            |   3 +
 drivers/i3c/master.c               | 157 ++++++++++++++++++++++++++++-
 drivers/i3c/master/dw-i3c-master.c |  42 ++++++++
 drivers/i3c/master/dw-i3c-master.h |   1 +
 include/linux/i3c/ccc.h            |   1 +
 include/linux/i3c/master.h         |   2 +
 6 files changed, 205 insertions(+), 1 deletion(-)

-- 
2.34.1


