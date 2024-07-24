Return-Path: <linux-kernel+bounces-260689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3D93AD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F032835B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C46BFA6;
	Wed, 24 Jul 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LsKmtxRi"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69921D29E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805208; cv=fail; b=KmN9hBZdiReXOz79mGdr1JjGBxsI681EJH6yQlHRmH4/J2+lXUQSa7Eoc3sBqzxnLxfYLcqplmLcsDnxDSZOOoYUZcEFTYIAgPzf8SPw1tR77AL+jys/Xb4ppUlFlSil256pmPMc/rsIar9DBqEB5Ytk3UPipjjW27YZsC0o4LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805208; c=relaxed/simple;
	bh=iFEjaSK5B+52ew6A91NK37hfR1Xvfi17JXArbDrQdXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1LU2POBG11QtwJahBGPolMkwMzeB+s0cMFxACIros5loHn3PiERC7foibc2K6Km7E6fRK5Ucyrd/1VWl4CQKqCGMrSINdt+Q4HMhnhSxMw5ExhVxDwPtIUhreC23dIXQ/fmAeo5mM0b+NYDzRx4/mxPvkIKQ7NRbbKuoRsIIU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LsKmtxRi; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrE7wtHGVfD+yazKoApY2Evqs7kcb3seoD5fY10fNQ++LqsZqfnBI04PlYWqxvVs3bLDCPgBWlRZFdUWH2bxECOYRKoz2ZT0dbcgGaRbPsJY/3YsgSnZ63wYLBbEDL972tCaJFbmN38ILs7vJYp7KWPsYg9PyedWtPzUp33eLkLaAZFwBYSx1/C/U/NzdW/gvaiML7Pz/UHAqhPLIWdLoflnUUv/7wjFP9PNdtYHg2cmKXmgUFth3FI2cJZgLsteguo3MVB6nP/gHeGqofl3bfgpQa6SyLrIs7m4XxrjXn9QSHLMftvee4xeai1px4tB5lG+XxO7iaVgCBQQ6YNY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEwNApABykYuCcz7eUAEN8wjeJN4gEDzFQcfAZ0wNCs=;
 b=PE36J+uBETBOmzS46H27NP4uk5G3vyz5tUpg5IlYQyIdMDl7bXeTqEJEth0RBFDIW26ZE+zmWTXeudX5pm8aKfoY0YZmyxzwJjnKKJe84ES/B/QCHalbfPgzcLu/Tlfp+jupLw7qJdVbK/0+kwKR5TzblQ1PhIULoTnWst2pGGcL4nvSBodtuQGvKbJXQf0aphKPJEiHyA6m8cVdZ6WK7nZawU9qiPoIyR/O2ITcoRvCvur4Wz/wxfV+h0CEqXbBJ/RyKxn+9COFiqr0qlqx6PF9rmV94DXUBoV/ibqVyAHKuNmFtUQqEqHPsCA6T6AcAuwEDxAONJnXpZYzBGpREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEwNApABykYuCcz7eUAEN8wjeJN4gEDzFQcfAZ0wNCs=;
 b=LsKmtxRiajXFRRKXpM+2olz2rWnE5Q6l/+o5w6vPziW+fNAtizbxkIPs8LJ692JXHvB/IwGqfGV4fMAHHiSAK+6Zwn0QG15Vdxpakosr0rHKDnPvFf8/+OIq1cDA+swlidh3Fq4Rc3PoiBkX/cduXeZcrUzkSfJdGWsMeVeWb9o=
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 07:13:23 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::48) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Wed, 24 Jul 2024 07:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 07:13:22 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 02:13:19 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 0/5] Introduce initial AMD I3C HCI driver support
Date: Wed, 24 Jul 2024 12:42:40 +0530
Message-ID: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 181cf4fd-4006-47a7-8dfb-08dcabb01a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZLpG1YrQXrNmevhhg8cwb0TGCvG67HMUUIN9EV0hivkNWLeztvwuFkzXR7XW?=
 =?us-ascii?Q?+VOCyuk0jvjLxxYPJF0OPjtYhx88/nj6Eh/rIA1xL6yBwo9WABexdnt9MbNn?=
 =?us-ascii?Q?AvKHGMmGsgDR+FxcRGiySTgJ0NGVhdEoDTGuTFMYUCoavY5QQqMZjbtEvhVi?=
 =?us-ascii?Q?7Xso28X4M7DUQHZ/G+8FRF8MGQpE2lKNbThx22jKStlQMMkXdAHvSN/9GKLy?=
 =?us-ascii?Q?KQYv72nz+8FFzneWdKPGgo7vp9s0jfhqCi7sLAJBMylmhLlh/ToAmK/Tk0y2?=
 =?us-ascii?Q?U/9jWOE75fbwjkGCzJHrJDVeUZbtaiT3rZnIeTZuG4CNKKbY+DbDBImZ22CI?=
 =?us-ascii?Q?LBHuNX5Dx7rkgNK02jdaI1nWNLeOolqojipwChF15KNKYNKL/+deIYtHKCyw?=
 =?us-ascii?Q?YYKo63qw9PGVfPoYftkem1DL9C2FRCYGDMiQuaxiH7G8ce56hZqjGbNctWlS?=
 =?us-ascii?Q?OYucXKlXATX20z5VIiJeKLlJCuqLr1PrVJf+yomMClrXM2ButRU7Wat+bm8i?=
 =?us-ascii?Q?kkHFwxBqxs3OhWvEo/RcQtagS7Wu/3+FtAHK8fkIESr52dDjl4Iz8REm23gl?=
 =?us-ascii?Q?F+e75KEYUyX3uKnJgGKoQKspuV8JECKjEsYw+m1ew7xDfM0c6fkeU6zcaleg?=
 =?us-ascii?Q?6yDEUlyd8FXbLkMrV370CiQUHRYcVUpnGEEm76zpAuVV/fGSgHg1DXrPynTu?=
 =?us-ascii?Q?exbRnw8s9fCc1WukoHbMtpqrdh1QBxb9JhVtHxesOItlwiefZAwl1lNuCaoF?=
 =?us-ascii?Q?oJF3yDkiEt68ynF0EfM0li5UF0QAMFVCyDsFy+oh/o2f9WkpGYDxKDBJYe+P?=
 =?us-ascii?Q?bPn1NUe8/qwTA4a+wThcI/+GbdZ3yS/TpDLFVOOih3Iu8+z8/NJ4j2SNozUB?=
 =?us-ascii?Q?HV23PtfuYu8zfn8FbgLadLttyfSONRxUqC2wucVL5pgfXhBg81Rrn3sP06k8?=
 =?us-ascii?Q?U3iWhepuqgJ/fpLea7WiliPkqO5doCF8nV1pFxTSH17H8urerr41LXdFMEl8?=
 =?us-ascii?Q?JDKGuSmelb2NZIrA3UWgM2mEMHPVvFJeV2WgUkT508UcochexgW3jkHgdrfL?=
 =?us-ascii?Q?jrGEDmAfSe4xEc/HypNjUzQdPmTfEUXC9A66FjGcBU4CHp36e4T84sE6WRmS?=
 =?us-ascii?Q?0YWLd2tf+CZey7tq9gSClz/WIW0BN3ePZYVhXgi2ZslvpzTwRXiK/aUUr9H/?=
 =?us-ascii?Q?2jMI2YAux0nUKY3oTegPWOS7s9nFELE2ggtRzIHKLEzc2SYDeGC8V7GScnoM?=
 =?us-ascii?Q?ZmVzDL2BIDG6r58kqSNtrF7w04cdxnN80YOn03BxtwpdakgOhM1ZF5KSMGJE?=
 =?us-ascii?Q?l7pxSEo9LloSYuAdVWXM8//wjYIh6b3aa+bdHwI+SuBTgm2a8HBbTYCraxXc?=
 =?us-ascii?Q?dFrgP52EyIIszIwaAjqSooWlznAtmf+eEtMUAlZt3cSUr1EQCjA0mXZdZ10z?=
 =?us-ascii?Q?kOQ4va08UpU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:13:22.2356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181cf4fd-4006-47a7-8dfb-08dcabb01a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

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

v1->v2:
-------
 - Address LKP reported problems
 - Guard boot_cpu_data usage with CONFIG_X86

Shyam Sundar S K (5):
  i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C Support List
  i3c: mipi-i3c-hci: Add a quirk to set PIO mode
  i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
  i3c: mipi-i3c-hci: Add a quirk to set timing parameters
  i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold

 drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 +-
 drivers/i3c/master/mipi-i3c-hci/core.c       | 35 ++++++++++---
 drivers/i3c/master/mipi-i3c-hci/hci.h        | 12 +++++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 55 ++++++++++++++++++++
 4 files changed, 97 insertions(+), 8 deletions(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

-- 
2.25.1


