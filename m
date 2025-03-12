Return-Path: <linux-kernel+bounces-557491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7BBA5D9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93EF7A7579
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46A23C8CE;
	Wed, 12 Mar 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c8eEJu9c"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0D23E35E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773276; cv=fail; b=IPUcCh7OKTIf9eDJM8TjQLdleDCWv+sYryXZXCYyG7i+cmUnP/DUwtKA1vmEU/IvXNVrsTowfjemr1c+FJN07doOVxMXPrcbf/IjQSuUDF2nJ++V2kDJGJ30yp1ZvNoA9xcLylZ2g+ZPwgNxQRC9un3C2K1xm/d+Sw+RpI5B2hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773276; c=relaxed/simple;
	bh=lVbkmlDClNnM/RvvpthQbYX0UaQv5HyTxrNs6f7Hp+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6Ev1BcisWM8Onm9A8IngT1XXQC8jChPh8e2fYYVOBR6pI5fIudoJNL+k9GOdSpetzGgjdAwnu2Hj3+BPghZDkkHd+2rr5TOmTTPoyq02xZjB5H+xH98tJXZJEOoHiqvKaSZFGHvJudZEA6pXaTbNoAW/TC+WGOja/zHf8QfJTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c8eEJu9c; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ90j0gqrwVgI455tMr4XQm7SMCX8PYhaSVSos81EN4OKvc9dY5/XU0dkThgkbmHotLWDMoSz8msXDKveYkVT7YQUDBsD1jPvfC5DQhRmTwaTLUC8iyDUXRmGywy9luXlJayC09G3ggouffXHkGE4FPLkkfThiUg+AOfCbTYK9D2YFDzfRb8toGsoJlDMfS147DrUXQr3Vv5COVnFDBijVq4X+/1JGtZhNMPkp3CsQEb/KingAn+7UuLd6/L0EcadI/cmh4eKyoPXVIgU+KdkvNgxNB0FEu3Y/tq5GcvOZ900FTKD8XKpt9EO0VH4rYLxPiie5r145RZCku8wSZe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgosF41C/QvOtDF1O6n1xpSn0xyth5REK1JOcv/ZNuY=;
 b=uLvAla56054V0ad9XZnbb+R2ya4kZulq5dHKbBrBeyYCJ2QsMxQ0jbuf/pBfnMveXdU3MV8fBZcrieDNjy3txl4bYXiKsg/CmZIdLtG7Zp4S872V7zdoxxmIt+r2jkgz6DZ51jT7vRdACeUCRMfbFixkExL7AmspDSmJVRSXVK6liXtMaczXGOAIctMt1P0gKCHcf52wN2sXxLnRIBF5D8l2evcfk+ucQJ+rqeQWPKVvqd6jwV01PnhzD8b83VDs1RlQu+GSBzVUqbz+1EdcIeYrN9B8DD6vBf3MpXGZpGP66s4LGFWKHWNIUbfWiKwIROAXU//osEFi7mo80d5YdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgosF41C/QvOtDF1O6n1xpSn0xyth5REK1JOcv/ZNuY=;
 b=c8eEJu9c5iK/gUqK9nJc5PhgyoRNnKM3WD4gVUVFrIRK/Q8AVsE8NGIEH71RWXISIEvgLM1Hlef3vBGL9wRJDZCTTnWqKUQ27gKQEUbnK+V5C3E84To3aOMvhYzYkra+w3QeEgoDbkStqLxMbwoxefAriRxwIC8cEI0Ro3808Ho=
Received: from SA1PR03CA0013.namprd03.prod.outlook.com (2603:10b6:806:2d3::9)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:54:28 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::b5) by SA1PR03CA0013.outlook.office365.com
 (2603:10b6:806:2d3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 09:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 09:54:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:27 -0500
Received: from xhdnipung41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Mar 2025 04:54:23 -0500
From: Nipun Gupta <nipun.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <derek.kiernan@amd.com>, <dragan.cvetic@amd.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <praveen.jain@amd.com>, <harpreet.anand@amd.com>,
	<nikhil.agarwal@amd.com>, <srivatsa@csail.mit.edu>, <code@tyhicks.com>,
	<ptsm@linux.microsoft.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
Date: Wed, 12 Mar 2025 15:24:20 +0530
Message-ID: <20250312095421.1839220-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: nipun.gupta@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdcfe7a-071b-4e6d-2dc9-08dd614be107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnZicmNQaDVZRTAzcDVNaU9CWjFHUVZwMXRIOW1Ma0pnMDZKTjhLZXc2a1dq?=
 =?utf-8?B?VHUyY052MlRTd0p4K2FneXZQTXRBTnJNVG9sOHdlbGF4QW1sQ2czTXovSXJ0?=
 =?utf-8?B?Sk1VMjl2U1JnR3VpVFlwNmQ0NW9LVERRcVF6cG43R0U5UnFCYm5SVVhkejRH?=
 =?utf-8?B?MzRkeGdFTkhwR1htbEtvSTJsZ1hLVGxSMk1GalpUaVpEdVg3RGpqSkpzRjV3?=
 =?utf-8?B?aEt1c1MyQnBNV3RTNlZ1TjBlZ1Qxa2pJb1JPc2E4VkdGemplZXdYbHdicHFW?=
 =?utf-8?B?eXFQUlFKUUN3ZFJJSTVhYS9MdmFaYVlwTnlXMDYrWEtuNkZISTBINE5YYTZE?=
 =?utf-8?B?dTlZZ3RROWZiUUNhQkhaYm55RVRSQkN0R0VDQ3VsanJmdDhHMEpCUzhGd05U?=
 =?utf-8?B?dmpkZGFoOEJsZEdIQ0FxdlB5TWxPR1hkTXdVc1llTjdEenVjeVNrWWhWR1Jy?=
 =?utf-8?B?dlF5U2JsMittUERrdW1HME9oK29FSWxHTHVTYTY1Z2p0TG5mZnllOHhsVVQ1?=
 =?utf-8?B?OE4zTGIxbUwvcU5SNkI0czRxaWZVZzZvWUlEcTNnV0R4WldtSUJTcjdRNWxj?=
 =?utf-8?B?SXVVV1B2TGZuY0Q3VkVJK1BORkhUT0dDaDd3ZVZObk51ZElTTHdrcjhSQmRr?=
 =?utf-8?B?cnprK3RRQUFpMUJjaEg2T1R2YzU5SXA3YW5DTVc2aVI5TWMxNEJVUEJYdFMv?=
 =?utf-8?B?RGxmaitlNWhkMUtRRkVrdXVrc2o5SFN2M3pNKzhZNmVyVEhpb0p2WmVueFdK?=
 =?utf-8?B?VjJiUXg3OERoWmJ6ZXkvNE5JZU9kb2VpVGtKNUsvRHF0WDdHWWEzUG5NV3Vl?=
 =?utf-8?B?bGh6ZXBmaFFuQnU2bDFMVVZxQ0ovditXNFBldHl1aXhnZitsNGNMLzRUNzJS?=
 =?utf-8?B?dWV6QWdhQk16blNiaVFPeHROaXhLNmtKVmdLWDlydTY4Y1ZzWnhyTnhJNXFk?=
 =?utf-8?B?cGpaaktlaEV4TzJyV2NPQzdDU1IwczhwVzVOelFKeGtYKzdjbFRsaGNMRnBG?=
 =?utf-8?B?WGlIS01qQUlCVWZvS2pHTnhlcXhmWGEwSDBtTEg1YUJhYXQ1WGJiNkozQ3k2?=
 =?utf-8?B?Mzl0Yzlmc0hNZkx0KzR0cWpKbkdQam1Ea0N6SHhPOVNuMWxwR1NrUTRlUitt?=
 =?utf-8?B?Z3c2T1NlaG5QbUZUakZiMjRjWVd5akRkTW4yOGtRdldTU0xBOUhBejErbWli?=
 =?utf-8?B?MGdSZzNSU3BsRU5pb2xsdGs5Z0RkWkNQY2dOT1p0MTJ4V0FiMGlBL3djTm9u?=
 =?utf-8?B?OVV6ZjNFNEhxaUhOYldyeFBVWU9NK21ucHNucVpocjRIOG5DNW1MQ0d0YnZL?=
 =?utf-8?B?UXg2R2lEejdiZjY4NXV2MFN2Sk0wajlFRkd6SmFSWklzSTJaNG9TVTV6eDM0?=
 =?utf-8?B?bGlnU1hLSWhxNm96WkMvbzZMd2x6NFVBamlaL1RnVUxLVUQ0M08yVXZCM0F0?=
 =?utf-8?B?T0xXWDNZVlRncGsvU2xaV1R0M3haaHJTTUNDYlV2eStSamNWUWJzWkpycnN5?=
 =?utf-8?B?QnZWVThhanUvM0MrOTBRdXJEaUE3VFJPZW5zU3ZoQmdCN0xWVlRjRW91OW4r?=
 =?utf-8?B?VlhKQksxRklidjlFd2g0ZlB4VFNER3NJYk1sUi90amZQZ2tLK3JqdmVMK0Ey?=
 =?utf-8?B?ZHRjdzVHL0VWK0o4T2hTdXZSdEc2dUZuSWxqdUs3WndtWVNGL2IyT2xiUFB3?=
 =?utf-8?B?MkU5MTRXVjhMTFIzVW90ZHBTcHNjRDBqbUluWjZmZjFGQVRyY0EvZ0s1N0dh?=
 =?utf-8?B?TVAyT1Iyd0lEWEQvL3o4SmNnd2xieGs5VDhCN2svNzdpTzU5NVRvRVFJblN0?=
 =?utf-8?B?SEZtZktJWnhBMU5NMVJOaXA1bzgrMUhTVXYrd012N2pqbTRwenZCMy9rMmsy?=
 =?utf-8?B?a3orWS92MXpLZ0pQbW1Tb1p0ejF0S3lwb2VTMXZ0ekZQQk9oUFlBVW9NYVRx?=
 =?utf-8?B?TkMzbUkvQ3B0MHFUY0VDRndyYVQ1cXVoaFhNSE1MUlExYnFGS2NmSUx6aGJv?=
 =?utf-8?Q?y8xuN5MGhgthXqiHZgBogfDbSFV2Gw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:54:28.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdcfe7a-071b-4e6d-2dc9-08dd614be107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

Silex MultiPK device provides a char device interface to interact
with Silex device for offloading asymmetric crypto operations.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---

Silex MultiPK device is a PKI offload device, which has multiple PK engines to
perform asymmetric crypto operations like ECDSA, RSA, Point Multiplication etc.

Following provides the brief overview of the device interface with the software:

 +------------------+
 |    Software      |
 +------------------+
     |          |
     |          v
     |     +-----------------------------------------------------------+
     |     |                     RAM                                   |
     |     |  +----------------------------+   +---------------------+ |
     |     |  |           RQ pages         |   |       CQ pages      | |
     |     |  | +------------------------+ |   | +-----------------+ | |
     |     |  | |   START (cmd)          | |   | | req_id | status | | |
     |     |  | |   TFRI (addr, sz)---+  | |   | | req_id | status | | |
     |     |  | | +-TFRO (addr, sz)   |  | |   | | ...             | | |
     |     |  | | | NTFY (req_id)     |  | |   | +-----------------+ | |
     |     |  | +-|-------------------|--+ |   |                     | |
     |     |  |   |                   v    |   +---------------------+ |
     |     |  |   |         +-----------+  |                           |
     |     |  |   |         | input     |  |                           |
     |     |  |   |         | data      |  |                           |
     |     |  |   v         +-----------+  |                           |
     |     |  |  +----------------+        |                           |
     |     |  |  |  output data   |        |                           |
     |     |  |  +----------------+        |                           |
     |     |  +----------------------------+                           |
     |     |                                                           |
     |     +-----------------------------------------------------------+
     |
     |
 +---|----------------------------------------------------+
 |   v                Silex MultiPK device                |
 |  +-------------------+     +------------------------+  |
 |  | New request FIFO  | --> |       PK engines       |  |
 |  +-------------------+     +------------------------+  |
 +--------------------------------------------------------+

To perform a crypto operation, the software writes a sequence of descriptors,
into the RQ memory. This includes input data and designated location for the
output data. After preparing the request, request offset (from the RQ memory
region) is written into the NEW_REQUEST register. Request is then stored in a
common hardware FIFO shared among all RQs. When a PK engine becomes available,
device pops the request from the FIFO and fetches the descriptors. It DMAs the
input data from RQ memory and executes the necessary computations. After
computation is complete, the device writes output data back to RAM via DMA.
Device then writes a new entry in CQ ring buffer in RAM, indicating completion
of the request. Device also generates an interrupt for notifying completion to
the software.

As Crypto AF_ALG does not support offloading asymmetric operations from 
user-space (which was attempted to be added earlier in Linux at:
https://lore.kernel.org/all/146672253157.23101.15291203749122389409.stgit@tstruk-mobl1.ra.intel.com/),
RQ memory is provided to the user-space via mmap, so that application can
directly write to the descriptors.

P.S. Most of the above text is also added as part of silex driver file.

 MAINTAINERS                   |   7 +
 drivers/misc/Kconfig          |   6 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/silex_mpk.c      | 860 ++++++++++++++++++++++++++++++++++
 drivers/misc/silex_mpk_defs.h | 205 ++++++++
 include/uapi/misc/silex_mpk.h |  29 ++
 6 files changed, 1108 insertions(+)
 create mode 100644 drivers/misc/silex_mpk.c
 create mode 100644 drivers/misc/silex_mpk_defs.h
 create mode 100644 include/uapi/misc/silex_mpk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..04d82d0a7d55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21690,6 +21690,13 @@ S:	Maintained
 F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c

+SILEX MULTIPK DRIVER
+M:	Nipun Gupta <nipun.gupta@amd.com>
+M:	Praveen Jain <praveen.jain@amd.com>
+S:	Maintained
+F:	drivers/misc/silex_mpk*
+F:	include/uapi/misc/silex_mpk.h
+
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 56bc72c7ce4a..8c5c72c540a6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -632,6 +632,12 @@ config MCHP_LAN966X_PCI
 	    - lan966x-miim (MDIO_MSCC_MIIM)
 	    - lan966x-switch (LAN966X_SWITCH)

+config SILEX_MPK
+	tristate "Silex MultiPK driver"
+	depends on OF
+	help
+	  Enable Silex MultiPK support
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 545aad06d088..456758b29f71 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
+obj-$(CONFIG_SILEX_MPK)		+= silex_mpk.o
diff --git a/drivers/misc/silex_mpk.c b/drivers/misc/silex_mpk.c
new file mode 100644
index 000000000000..e03579780761
--- /dev/null
+++ b/drivers/misc/silex_mpk.c
@@ -0,0 +1,860 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2021 Silex Insight sa
+ * Copyright (c) 2018-2021 Beerten Engineering scs
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/cdev.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/idr.h>
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/eventfd.h>
+#include <linux/kthread.h>
+#include <linux/sched/signal.h>
+#include <linux/bitops.h>
+#include <uapi/linux/eventpoll.h>
+#include <uapi/misc/silex_mpk.h>
+
+#include "silex_mpk_defs.h"
+
+/*
+ * Silex MultiPK device is a PKI offload device, which has multiple PK engines to
+ * perform asymmetric crypto operations like ECDSA, RSA, Point Multiplication etc.
+ *
+ * Following provides the brief overview of the device interface with the software:
+ *
+ * +------------------+
+ * |    Software      |
+ * +------------------+
+ *     |          |
+ *     |          v
+ *     |     +-----------------------------------------------------------+
+ *     |     |                     RAM                                   |
+ *     |     |  +----------------------------+   +---------------------+ |
+ *     |     |  |           RQ pages         |   |       CQ pages      | |
+ *     |     |  | +------------------------+ |   | +-----------------+ | |
+ *     |     |  | |   START (cmd)          | |   | | req_id | status | | |
+ *     |     |  | |   TFRI (addr, sz)---+  | |   | | req_id | status | | |
+ *     |     |  | | +-TFRO (addr, sz)   |  | |   | | ...             | | |
+ *     |     |  | | | NTFY (req_id)     |  | |   | +-----------------+ | |
+ *     |     |  | +-|-------------------|--+ |   |                     | |
+ *     |     |  |   |                   v    |   +---------------------+ |
+ *     |     |  |   |         +-----------+  |                           |
+ *     |     |  |   |         | input     |  |                           |
+ *     |     |  |   |         | data      |  |                           |
+ *     |     |  |   v         +-----------+  |                           |
+ *     |     |  |  +----------------+        |                           |
+ *     |     |  |  |  output data   |        |                           |
+ *     |     |  |  +----------------+        |                           |
+ *     |     |  +----------------------------+                           |
+ *     |     |                                                           |
+ *     |     +-----------------------------------------------------------+
+ *     |
+ *     |
+ * +---|----------------------------------------------------+
+ * |   v                Silex MultiPK device                |
+ * |  +-------------------+     +------------------------+  |
+ * |  | New request FIFO  | --> |       PK engines       |  |
+ * |  +-------------------+     +------------------------+  |
+ * +--------------------------------------------------------+
+ *
+ * To perform a crypto operation, the software writes a sequence of descriptors,
+ * into the RQ memory. This includes input data and designated location for the
+ * output data. After preparing the request, request offset (from the RQ memory
+ * region) is written into the NEW_REQUEST register. Request is then stored in a
+ * common hardware FIFO shared among all RQs. When a PK engine becomes available,
+ * device pops the request from the FIFO and fetches the descriptors. It DMAs the
+ * input data from RQ memory and executes the necessary computations. After
+ * computation is complete, the device writes output data back to RAM via DMA.
+ * Device then writes a new entry in CQ ring buffer in RAM, indicating completion
+ * of the request. Device also generates an interrupt for notifying completion to
+ * the software.
+ *
+ * RQ memory is provided to the user-space via mmap, so that application can
+ * directly write to the descriptors.
+ */
+
+#define DRIVER_NAME "multipk"
+
+static struct class *multipk_class;
+static int multipk_major, multipk_minor;
+
+static void sx_wrreg(char __iomem *regs, int addr, u64 val)
+{
+	iowrite64(val, regs + addr);
+}
+
+static u64 sx_rdreg(char __iomem *regs, int addr)
+{
+	return ioread64(regs + addr);
+}
+
+static void sx_wrreg32(char __iomem *regs, int addr, u32 val)
+{
+	iowrite32(val, regs + addr);
+}
+
+static u32 sx_rdreg32(char __iomem *regs, int addr)
+{
+	return ioread32(regs + addr);
+}
+
+static void sx_pk_init_cq(struct multipk_dev *mpkdev, struct sx_pk_cq *cq,
+			  int szcode, char *base)
+{
+	cq->mpkdev = mpkdev;
+	cq->generation = 1;
+	cq->szcode = szcode;
+	cq->base = (u32 *)base;
+	cq->tail = 0;
+}
+
+static int sx_pk_pop_cq(struct sx_pk_cq *cq, int *rid)
+{
+	u32 status = CQ_STATUS_VALID;
+	u32 completion;
+	unsigned int sz;
+
+	completion = cq->base[cq->tail + 1];
+	if ((completion & 1) != cq->generation) {
+		dev_err(cq->mpkdev->dev, "CQ completion error\n");
+		return CQ_STATUS_INVALID;
+	}
+	*rid = (completion >> 16) & 0xffff;
+	/* read memory barrier: to avoid a race condition, the status field may
+	 * not be read before the completion generation bit. Otherwise we could
+	 * get stale outdated status data.
+	 */
+	rmb();
+	status |= cq->base[cq->tail];
+	/* advance completion queue tail */
+	cq->tail += 2;
+	sz = 1 << (cq->szcode - 2);
+	if (cq->tail >= sz) {
+		cq->tail = 0;
+		cq->generation ^= 1; /* invert generation bit */
+	}
+
+	/* evaluate status from the completion queue */
+	if (completion & 0x2)
+		// error reported by the PK scheduler
+		status |= CQ_COMPLETION_ERROR;
+
+	return status;
+}
+
+static int sx_pk_trigpos(struct sx_pk_cq *cq)
+{
+	int trigpos;
+
+	trigpos = cq->tail / 2 + (cq->generation << (cq->szcode - 3));
+	/* Set trigger position on next completed operation */
+	trigpos++;
+	trigpos &= (1 << (cq->szcode - 2)) - 1;
+
+	return trigpos;
+}
+
+static void cq_work_function(struct kthread_work *work)
+{
+	struct multipk_dev *mpkdev;
+	struct multipk_work *mpkwork;
+	struct multipk_user *user;
+	int qid, rid, trigpos;
+	u32 status;
+
+	mpkwork = container_of(work, struct multipk_work, cq_work);
+	mpkdev = mpkwork->mpkdev;
+	qid = mpkwork->qid;
+
+	mutex_lock(&mpkdev->lock[qid]);
+	/* Return in case mpkdev user is closed */
+	if (!mpkdev->users[qid]) {
+		mutex_unlock(&mpkdev->lock[qid]);
+		return;
+	}
+
+	user = mpkwork->user;
+	status = sx_pk_pop_cq(&mpkdev->work[qid].pk_cq, &rid);
+	if (status != CQ_STATUS_INVALID) {
+		u32 *status_mem;
+
+		status_mem = (u32 *)user->shmem;
+		status_mem[rid] = status;
+		eventfd_signal(user->evfd_ctx[rid]);
+	}
+
+	trigpos = sx_pk_trigpos(&mpkdev->work[qid].pk_cq);
+	sx_wrreg(mpkdev->regs, REG_CTL_CQ_NTFY(user->qid), trigpos);
+	mutex_unlock(&mpkdev->lock[qid]);
+}
+
+static int multipk_open(struct inode *inode, struct file *filep)
+{
+	struct multipk_dev *mpkdev;
+	struct multipk_user *user;
+	int ret, idx;
+
+	mpkdev = container_of(inode->i_cdev, struct multipk_dev, cdev);
+	idx = ida_alloc_range(&mpkdev->available_rqcq, 0, mpkdev->max_queues - 1, GFP_KERNEL);
+	if (idx < 0)
+		return -ENOSPC;
+
+	get_device(mpkdev->dev);
+
+	user = kzalloc(sizeof(*user), GFP_KERNEL);
+	if (!user) {
+		ret = -ENOMEM;
+		goto err_alloc_user;
+	}
+	user->mpkdev = mpkdev;
+	user->qid = idx;
+	user->rq_entries = 0;
+	filep->private_data = user;
+	mpkdev->users[idx] = user;
+
+	return 0;
+
+err_alloc_user:
+	ida_free(&mpkdev->available_rqcq, idx);
+	put_device(mpkdev->dev);
+	return ret;
+}
+
+static long multipk_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct multipk_user *user = filep->private_data;
+	struct multipk_conf conf;
+	int i, ret = 0;
+
+	/* Extract the type and number */
+	if (_IOC_TYPE(cmd) != MULTIPK_IOC_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > MULTIPK_IOC_MAXNR)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case MULTIPK_CONF:
+		if (copy_from_user(&conf, (struct multipk_conf __user *)arg,
+				   sizeof(conf)))
+			return -EFAULT;
+		/* Maximal value of rq_entries is 512. There is 1 CQ of 4K bytes.
+		 * Each completion status is 8 Bytes. Only 4096 / 8 = 512 entries
+		 * are possible at any time
+		 */
+		if (conf.max_queue_depth > 512)
+			return -ENOTTY;
+		/* If queue already opened */
+		if (user->cqmem)
+			return -ENOTTY;
+		user->rq_entries = conf.max_queue_depth;
+
+		for (i = 0; i < MAX_PK_REQS; i++) {
+			user->evfd_ctx[i] = eventfd_ctx_fdget(conf.eventfd[i]);
+			if (IS_ERR(user->evfd_ctx[i])) {
+				dev_err(user->mpkdev->dev, "Invalid eventfd: %d\n",
+					conf.eventfd[i]);
+				return -ENOTTY;
+			}
+		}
+
+		break;
+	default:
+		return -ENOTTY;
+	}
+	return ret;
+}
+
+static void multipk_free_rqcqsh(struct multipk_dev *mpkdev, struct multipk_user *user)
+{
+	int pages = user->rq_pages;
+	int pagemult = pages / 4;
+	int i;
+
+	dma_free_coherent(mpkdev->dev, PAGE_SIZE,
+			  user->shmem, user->physsh);
+	user->shmem = NULL;
+	dma_free_coherent(mpkdev->dev, PAGE_SIZE,
+			  user->cqmem, user->physcq);
+	user->cqmem = NULL;
+	for (i = 0; i < pages / pagemult; i++) {
+		dma_free_coherent(mpkdev->dev, PAGE_SIZE * pagemult,
+				  user->rqmem[i], user->physrq[i]);
+		user->rqmem[i] = NULL;
+	}
+}
+
+static int multipk_release(struct inode *inode, struct file *filep)
+{
+	struct multipk_user *user = filep->private_data;
+	struct multipk_dev *mpkdev = user->mpkdev;
+	char __iomem *regs = mpkdev->regs;
+	int ret = 0;
+
+	/* As kthread worker handling CQ will be using user memory, free needs
+	 * to be done in a lock to avoid race condition.
+	 */
+	mutex_lock(&mpkdev->lock[user->qid]);
+	if (user->rq_entries) {
+		unsigned int attempts = 0;
+		/* Disable RQCQ pages to help the hardware finish potential
+		 * pending requests sooner.
+		 */
+		sx_wrreg(regs, REG_RQ_CFG_PAGE_SIZE(user->qid), 0);
+		sx_wrreg(regs, REG_RQ_CFG_PAGES_WREN(user->qid), 0);
+		sx_wrreg(regs, REG_CQ_CFG_SIZE(user->qid), 0);
+		/* The hardware does not have a flush mechanism for the requests
+		 * pending in the RQ. Instead check periodically with
+		 * REG_CTL_PENDING_REQS if the user still has requests going on.
+		 * If the hardware never completes the requests, abort after
+		 * a MAX_FLUSH_WAIT_ATTEMPTS and don't free the resources.
+		 */
+		while (sx_rdreg(regs, REG_CTL_BASE(user->qid) + REG_CTL_PENDING_REQS)) {
+			attempts++;
+			if (attempts > MAX_FLUSH_WAIT_ATTEMPTS) {
+				dev_err(mpkdev->dev,
+					"Time out waiting for hw completions. Resources leaked.\n");
+				goto abort_cleanup;
+			}
+			msleep(20);
+		}
+
+		/* Once memory has been allocated in mmap we need to free more resources */
+		if (user->shmem) {
+			atomic_add(user->rq_entries, &mpkdev->allowed_reqs);
+			multipk_free_rqcqsh(mpkdev, user);
+			kthread_destroy_worker(mpkdev->work[user->qid].cq_wq);
+			mpkdev->work[user->qid].cq_wq = NULL;
+		}
+	}
+	ida_free(&mpkdev->available_rqcq, user->qid);
+
+abort_cleanup:
+	clear_bit(user->qid, &mpkdev->ntfy_mask);
+	mpkdev->users[user->qid] = NULL;
+	put_device(mpkdev->dev);
+	mutex_unlock(&mpkdev->lock[user->qid]);
+	kfree(user);
+
+	return ret;
+}
+
+static const struct vm_operations_struct multipk_physical_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
+static int multipk_mmap_regs(struct vm_area_struct *vma)
+{
+	struct multipk_user *user = vma->vm_private_data;
+	struct multipk_dev *mpkdev = user->mpkdev;
+
+	vma->vm_ops = &multipk_physical_vm_ops;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start,
+				  (mpkdev->regsphys + REG_CTL_BASE(user->qid)) >> PAGE_SHIFT,
+				  vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+static int mmap_dmamem(struct vm_area_struct *vma, struct multipk_dev *mpkdev,
+		       void *addr, dma_addr_t phys, off_t offset, size_t sz)
+{
+	unsigned long vmstart = vma->vm_start;
+	unsigned long pgoff = vma->vm_pgoff;
+	int ret;
+
+	/* Here vm_pgoff has a fake offset to tell which mapping to do.
+	 * Unfortunately, dma_mmap_coherent() does not take an explicit offset
+	 * argument. Force it in vma temporarily to 0 to make sure
+	 * dma_mmap_coherent() maps the buffer from the beginning.
+	 */
+	vma->vm_pgoff = 0;
+	vma->vm_start = vmstart + offset;
+	vma->vm_end = vma->vm_start + sz;
+	ret = dma_mmap_coherent(mpkdev->dev, vma, addr, phys, sz);
+	vma->vm_pgoff = pgoff;
+	vma->vm_start = vmstart;
+
+	return ret;
+}
+
+static int multipk_mmap_rqcq(struct vm_area_struct *vma)
+{
+	struct multipk_user *user = vma->vm_private_data;
+	struct multipk_dev *mpkdev = user->mpkdev;
+	struct multipk_work *mpkwork = NULL;
+	int rq_entries = user->rq_entries;
+	int pagemult, pagemultshift;
+	int requested_pages;
+	char wq_name[32];
+	int i, qid, ret;
+	int trigpos;
+
+	requested_pages = vma_pages(vma);
+	/* As the first page is reserved for the cq and the next ones are for
+	 * the rq, the mmap must be at least 2 pages big.
+	 */
+	if (requested_pages < 2)
+		return -EINVAL;
+	if (requested_pages > (8 + 1))
+		return -EINVAL;
+	/* Store number of rq pages. 1 page is reserved for cq */
+	user->rq_pages = requested_pages - 1;
+	/* Requests memory can have up to 4 hardware pages. All hardware
+	 * pages have the same size. If requesting more than 4 OS pages, the
+	 * hardware pages will use the same multiple (pagemult) of OS pages.
+	 * Thus the requested size for the request queue must be a multiple
+	 * of pagemult.
+	 */
+	pagemult = (requested_pages - 1 + 3) / 4;
+	if ((requested_pages - 1) % pagemult != 0)
+		return -EINVAL;
+	/* hardware page size must be a power of 2, and as a consequence
+	 * pagemult too.
+	 */
+	if ((pagemult & (pagemult - 1)) != 0)
+		return -EINVAL;
+	/* Set rq_entries if it has not already been set through ioctl */
+	if (!rq_entries) {
+		/* For the purpose of computing the allowed number of entries in the
+		 * request queue, the size of the rq is divided by a typical small
+		 * request of 128 bytes (4 descriptors (4 * 8 bytes) with 3 operands of
+		 * 32 bytes).
+		 */
+		rq_entries = ((requested_pages - 1) << PAGE_SHIFT) / 128;
+	}
+	/* The first page is reserved for the completion queue. With page sizes
+	 * of 4KB, this means that a cq can receive at least 4K / (4*2) = 512
+	 * completions. To be safe, only up to 512 requests can be pending.
+	 */
+	if (rq_entries > 512)
+		return -EINVAL;
+	if (user->cqmem)
+		/* Mapping already done */
+		return -EINVAL;
+	i = atomic_sub_return(rq_entries, &mpkdev->allowed_reqs);
+	if (i < 0) {
+		/* On failure give back the reserved entries.
+		 * This construction could lead to smaller reservations being
+		 * refused while a bigger one is going on. This is very
+		 * unlikely and should never happen in a correctly dimensioned
+		 * system. Thus, there's no need to worry about that.
+		 */
+		atomic_add(rq_entries, &mpkdev->allowed_reqs);
+		return -ENOSPC;
+	}
+
+	/* Check if status for RQ entries can be accommodated in PAGE_SIZE */
+	if (rq_entries * sizeof(u32) > PAGE_SIZE)
+		return -EINVAL;
+	user->shmem = dma_alloc_coherent(mpkdev->dev, PAGE_SIZE,
+					 &user->physsh, GFP_KERNEL);
+	if (!user->shmem) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	user->cqmem = dma_alloc_coherent(mpkdev->dev, PAGE_SIZE,
+					 &user->physcq, GFP_KERNEL);
+	if (!user->cqmem) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	user->rq_entries = rq_entries;
+	qid = user->qid;
+	for (i = 0; i < (requested_pages - 1) / pagemult; i++) {
+		user->rqmem[i] = dma_alloc_coherent(mpkdev->dev, PAGE_SIZE * pagemult,
+						    &user->physrq[i], GFP_KERNEL);
+		if (!user->rqmem[i]) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+		sx_wrreg(mpkdev->regs, REG_RQ_CFG_PAGE(qid, i),
+			 user->physrq[i]);
+	}
+
+	vma->vm_ops = &multipk_physical_vm_ops;
+
+	/* Configure unused rq pages with start of allocated shared mem.
+	 * Those should not be accessed, but if descriptors of a (malicious)
+	 * user writes descriptors for those pages, it will not break the rest
+	 * of the system.
+	 */
+	for (i = (requested_pages - 1) / pagemult; i < 4; i++) {
+		sx_wrreg(mpkdev->regs, REG_RQ_CFG_PAGE(qid, i),
+			 user->physrq[0]);
+	}
+	pagemultshift = pagemult - 1;
+	pagemultshift = (pagemultshift & 5) + ((pagemultshift & 0xa) >> 1);
+	pagemultshift = (pagemultshift & 3) + ((pagemultshift >> 2) & 3);
+	sx_wrreg(mpkdev->regs, REG_RQ_CFG_PAGE_SIZE(qid), PAGE_SHIFT + pagemultshift);
+	sx_wrreg(mpkdev->regs, REG_RQ_CFG_CQID(qid), qid);
+	sx_wrreg(mpkdev->regs, REG_CQ_CFG_IRQ_NR(qid), qid);
+	set_bit(qid, &mpkdev->ntfy_mask);
+	sx_wrreg(mpkdev->regs, REG_RQ_CFG_PAGES_WREN(qid),
+		 (1 << ((requested_pages - 1) / pagemult)));
+	sx_wrreg(mpkdev->regs, REG_RQ_CFG_DEPTH(qid), rq_entries);
+	sx_wrreg(mpkdev->regs, REG_CQ_CFG_ADDR(qid), user->physcq);
+	sx_wrreg(mpkdev->regs, REG_CQ_CFG_SIZE(qid), PAGE_SHIFT);
+
+	mutex_init(&mpkdev->lock[qid]);
+	mpkwork = &mpkdev->work[qid];
+	sx_pk_init_cq(mpkdev, &mpkwork->pk_cq, 12, user->cqmem);
+	mpkwork->qid = qid;
+	mpkwork->mpkdev = mpkdev;
+	mpkwork->user = user;
+
+	/* set trigger position for notifications */
+	trigpos = sx_pk_trigpos(&mpkwork->pk_cq);
+	sx_wrreg(mpkdev->regs, REG_CTL_CQ_NTFY(qid), trigpos);
+
+	ret = mmap_dmamem(vma, mpkdev, user->shmem, user->physsh, 0, PAGE_SIZE);
+	if (ret)
+		goto fail;
+	for (i = 0; i < (requested_pages - 1) / pagemult; i++) {
+		ret = mmap_dmamem(vma, mpkdev, user->rqmem[i], user->physrq[i],
+				  (i * pagemult + 1) * PAGE_SIZE,
+				  PAGE_SIZE * pagemult);
+		if (ret)
+			goto fail;
+	}
+
+	snprintf(wq_name, sizeof(wq_name), "cq_worker_%d", qid);
+	mpkwork->cq_wq = kthread_create_worker(0, wq_name);
+	if (IS_ERR(mpkwork->cq_wq)) {
+		ret = -ENOMEM;
+		mpkwork->cq_wq = NULL;
+		goto fail;
+	}
+
+	kthread_init_work(&mpkwork->cq_work, cq_work_function);
+	return ret;
+
+fail:
+	if (mpkwork && mpkwork->cq_wq) {
+		kthread_destroy_worker(mpkwork->cq_wq);
+		mpkwork->cq_wq = NULL;
+	}
+	multipk_free_rqcqsh(mpkdev, user);
+	user->rq_entries = 0;
+	atomic_add(rq_entries, &mpkdev->allowed_reqs);
+	return ret;
+}
+
+static int multipk_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct multipk_user *user = filep->private_data;
+	int ret = 0;
+
+	if (vma->vm_end < vma->vm_start)
+		return -EINVAL;
+
+	vma->vm_private_data = user;
+
+	switch (vma->vm_pgoff) {
+	case 0:
+		ret = multipk_mmap_regs(vma);
+		break;
+	case 1:
+		ret = multipk_mmap_rqcq(vma);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct file_operations multipk_fops = {
+	.owner          = THIS_MODULE,
+	.open           = multipk_open,
+	.release        = multipk_release,
+	.mmap           = multipk_mmap,
+	.unlocked_ioctl = multipk_ioctl,
+};
+
+static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	int v, hwv, cnt, maxtotalreqs, rqmaxpending, mults;
+	struct multipk_dev *mpkdev = dev_get_drvdata(dev);
+
+	v = (int)sx_rdreg(mpkdev->regs, REG_SEMVER);
+	hwv = (int)sx_rdreg(mpkdev->regs, REG_HW_VERSION);
+	cnt = (int)sx_rdreg(mpkdev->regs, REQ_CFG_REQ_QUEUES_CNT);
+	maxtotalreqs = (int)sx_rdreg(mpkdev->regs, REQ_CFG_MAX_PENDING_REQ);
+	rqmaxpending = (int)sx_rdreg(mpkdev->regs, REQ_CFG_MAX_REQ_QUEUE_ENTRIES);
+	mults = (int)sx_rdreg(mpkdev->regs, REQ_CFG_PK_INST);
+
+	return sprintf(buf,
+		"Hardware interface version: %d.%d.%d\n"
+		"Hardware implementation version: %d.%d.%d\n"
+		"Count request queues: %d\n"
+		"Total max pending requests: %d\n"
+		"Max pending requests per request queue: %d\n"
+		"Pkcores 64 multipliers: %d\n"
+		"Pkcores 256 multipliers: %d\n",
+		MPK_SEMVER_MAJOR(v), MPK_SEMVER_MINOR(v), MPK_SEMVER_PATCH(v),
+		MPK_HWVER_MAJOR(hwv), MPK_HWVER_MINOR(hwv), MPK_HWVER_SVN(hwv),
+		cnt, maxtotalreqs, rqmaxpending,
+		mults >> 16, mults & 0xFFFF);
+}
+static DEVICE_ATTR_RO(hardware);
+
+static irqreturn_t multipk_cq_irq(int irq, void *dev)
+{
+	struct multipk_dev *mpkdev = (struct multipk_dev *)dev;
+	u64 active = 0;
+	int i;
+
+	active = sx_rdreg(mpkdev->regs, REG_PK_IRQ_STATUS);
+	active &= READ_ONCE(mpkdev->ntfy_mask);
+	sx_wrreg(mpkdev->regs, REG_PK_IRQ_RESET, active);
+
+	for (i = 0; i < mpkdev->max_queues && active; i++, active >>= 1) {
+		if (!(active & 1))
+			continue;
+		if (!mpkdev->users[i]) {
+			dev_err(mpkdev->dev, "multipk: interrupt for unknown CQ %d\n", i);
+			continue;
+		}
+		kthread_queue_work(mpkdev->work[i].cq_wq, &mpkdev->work[i].cq_work);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void multipk_dbrg_init(struct multipk_dev *mpkdev)
+{
+	u32 perso_string[2] = {0xB0A04033, 0xB0A04052};
+	int pers_str_len;
+	int entropy_len;
+	u32 reg_out;
+	u32 buffer;
+	size_t i;
+
+	reg_out = sx_rdreg32(mpkdev->dbrg_regs, REG_HWCONFIG);
+	/* Sizes in 32b words */
+	entropy_len = (reg_out >> 12) & 0xF;
+	pers_str_len = (reg_out >> 20) & 0xF;
+	sx_wrreg32(mpkdev->dbrg_regs, REG_CONFIG,
+		   CONFIG_REQUEST_NB_BITS(512) | CONFIG_USE_AES_128);
+
+	/* Reset 32bit data control counter */
+	sx_wrreg32(mpkdev->dbrg_regs, REG_DATACTRL, 0x01);
+	for (i = 0; i < entropy_len; i++) {
+		get_random_bytes(&buffer, sizeof(buffer));
+		sx_wrreg32(mpkdev->dbrg_regs, REG_ENTROPYIN, buffer);
+	}
+	for (i = 0; i < 2 && i < pers_str_len; i++)
+		sx_wrreg32(mpkdev->dbrg_regs, REG_PERSSTR, perso_string[i]);
+
+	sx_wrreg32(mpkdev->dbrg_regs, REG_CONTROL,
+		   CONTROL_START | CONTROL_USE_ENTROPY_INPUT_REG | CONTROL_DO_INSTANTIATE);
+}
+
+static int multipk_create_device(struct multipk_dev *mpkdev, struct device *dev, int irq)
+{
+	u64 max_total_reqs;
+	long magic;
+	u64 ver;
+	int ret;
+
+	magic = sx_rdreg(mpkdev->regs, REG_MAGIC);
+	if (magic != 0x5113C50C) {
+		dev_err(dev, "Invalid magic constant %08lx !\n", magic);
+		return -ENODEV;
+	}
+	dev_err(dev, "Correct magic\n");
+	ver = sx_rdreg(mpkdev->regs, REG_SEMVER);
+	if (MPK_SEMVER_MAJOR(ver) != 1 || MPK_SEMVER_MINOR(ver) < 1) {
+		dev_err(dev, "Hardware version (%d.%d) not supported.\n",
+			(int)MPK_SEMVER_MAJOR(ver), (int)MPK_SEMVER_MINOR(ver));
+		return -ENODEV;
+	}
+
+	/* Reset all accelerators and the hw scheduler */
+	sx_wrreg(mpkdev->regs, REG_PK_GLOBAL_STATE, 0x1);
+	sx_wrreg(mpkdev->regs, REG_PK_GLOBAL_STATE, 0x0);
+
+	mpkdev->max_queues = (int)sx_rdreg(mpkdev->regs, REQ_CFG_REQ_QUEUES_CNT);
+	mpkdev->users = devm_kzalloc(dev, sizeof(*mpkdev->users) * mpkdev->max_queues,
+				     GFP_KERNEL);
+
+	ida_init(&mpkdev->available_rqcq);
+	max_total_reqs = sx_rdreg(mpkdev->regs, REQ_CFG_MAX_PENDING_REQ);
+	atomic_set(&mpkdev->allowed_reqs, max_total_reqs);
+	mpkdev->max_queues = (int)sx_rdreg(mpkdev->regs, REQ_CFG_REQ_QUEUES_CNT);
+
+	sx_wrreg(mpkdev->regs, REG_IRQ_ENABLE, 0);
+	sx_wrreg(mpkdev->regs, REG_PK_IRQ_RESET, ~0);
+	sx_wrreg(mpkdev->regs, REG_IRQ_ENABLE, (1 << mpkdev->max_queues) - 1);
+	mpkdev->ntfy_mask = 0;
+
+	ret = devm_request_irq(dev, irq, multipk_cq_irq, 0, "multipk", mpkdev);
+	if (ret)
+		return -ENODEV;
+
+	multipk_dbrg_init(mpkdev);
+
+	if (IS_ERR(device_create(multipk_class, dev,
+				 MKDEV(multipk_major, multipk_minor), NULL,
+				 "multipk%u", multipk_minor))) {
+		dev_err(dev, "can't create device\n");
+		ret = -ENODEV;
+		goto faildevcreate;
+	}
+	device_create_file(dev, &dev_attr_hardware);
+
+	cdev_init(&mpkdev->cdev, &multipk_fops);
+	mpkdev->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&mpkdev->cdev, MKDEV(multipk_major, multipk_minor), 1);
+	if (ret)
+		goto failcdevadd;
+	return 0;
+
+failcdevadd:
+	dev_err(dev, "chardev registration failed\n");
+	device_remove_file(mpkdev->dev, &dev_attr_hardware);
+	device_destroy(multipk_class, MKDEV(multipk_major, multipk_minor));
+faildevcreate:
+	ida_destroy(&mpkdev->available_rqcq);
+
+	return ret;
+}
+
+static void multipk_remove_device(struct multipk_dev *mpkdev)
+{
+	cdev_del(&mpkdev->cdev);
+
+	device_remove_file(mpkdev->dev, &dev_attr_hardware);
+	sx_wrreg(mpkdev->regs, REG_IRQ_ENABLE, 0);
+	device_destroy(multipk_class, MKDEV(multipk_major, multipk_minor));
+	ida_destroy(&mpkdev->available_rqcq);
+}
+
+static int multipk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct multipk_dev *mpkdev;
+	struct resource *memres;
+	int irq, ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret < 0)
+		return ret;
+
+	mpkdev = devm_kzalloc(dev, sizeof(*mpkdev), GFP_KERNEL);
+	if (!mpkdev)
+		return -ENOMEM;
+	mpkdev->dev = dev;
+
+	memres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mpkdev->regs = devm_ioremap_resource(dev, memres);
+	if (IS_ERR(mpkdev->regs))
+		return PTR_ERR(mpkdev->regs);
+	mpkdev->regsphys = memres->start;
+	memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	mpkdev->dbrg_regs = devm_ioremap_resource(dev, memres);
+	if (IS_ERR(mpkdev->dbrg_regs))
+		return PTR_ERR(mpkdev->dbrg_regs);
+	mpkdev->dbrg_regsphys = memres->start;
+	platform_set_drvdata(pdev, mpkdev);
+
+	/* Only a single IRQ is supported */
+	if (platform_irq_count(pdev) != 1)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	return multipk_create_device(mpkdev, dev, irq);
+}
+
+static void multipk_remove(struct platform_device *pdev)
+{
+	struct multipk_dev *mpkdev = platform_get_drvdata(pdev);
+
+	multipk_remove_device(mpkdev);
+}
+
+static const struct of_device_id multipk_match[] = {
+	{ .compatible = "multipk" },
+	{ },
+};
+
+static struct platform_driver multipk_pdrv = {
+	.probe = multipk_probe,
+	.remove = multipk_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(multipk_match),
+	},
+};
+
+static int __init multipk_init(void)
+{
+	dev_t devt;
+	int ret;
+
+	multipk_class = class_create("multipk");
+	if (IS_ERR(multipk_class)) {
+		ret = PTR_ERR(multipk_class);
+		pr_err("can't register class\n");
+		goto err;
+	}
+	ret = alloc_chrdev_region(&devt, 0, MULTIPK_MAX_DEVICES, "multipk");
+	if (ret) {
+		pr_err("can't register character device\n");
+		goto err_class;
+	}
+	multipk_major = MAJOR(devt);
+	multipk_minor = MINOR(devt);
+
+	ret = platform_driver_register(&multipk_pdrv);
+	if (ret) {
+		pr_err("can't register platform driver\n");
+		goto err_unchr;
+	}
+
+	return 0;
+err_unchr:
+	unregister_chrdev_region(devt, MULTIPK_MAX_DEVICES);
+err_class:
+	class_destroy(multipk_class);
+err:
+	return ret;
+}
+
+static void __exit multipk_exit(void)
+{
+	platform_driver_unregister(&multipk_pdrv);
+
+	unregister_chrdev_region(MKDEV(multipk_major, 0), MULTIPK_MAX_DEVICES);
+
+	class_destroy(multipk_class);
+}
+
+module_init(multipk_init);
+module_exit(multipk_exit);
+
+MODULE_DESCRIPTION("Driver for Silex Multipk Asymmetric crypto accelerator");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/misc/silex_mpk_defs.h b/drivers/misc/silex_mpk_defs.h
new file mode 100644
index 000000000000..85dab916769a
--- /dev/null
+++ b/drivers/misc/silex_mpk_defs.h
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2021 Silex Insight sa
+ * Copyright (c) 2018-2021 Beerten Engineering scs
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __SILEX_MPK_REGS_H__
+#define __SILEX_MPK_REGS_H__
+
+/* Contains magic number 0x5113C5OC.
+ * Used to validate access to the hardware registers
+ */
+#define REG_MAGIC (0x00)
+
+/* Contains version of the hardware interface as semver
+ * The semantic version : major 8 bits, minor 8 bits in little endian order.
+ */
+#define REG_SEMVER (0x08)
+
+/* The number of request queues available in the hardware */
+#define REQ_CFG_REQ_QUEUES_CNT 0x10
+
+/* The maximum number of pending requests from all request queues combined. */
+#define REQ_CFG_MAX_PENDING_REQ 0x18
+
+/* The maximum number of pending requests in a single request queue. */
+#define REQ_CFG_MAX_REQ_QUEUE_ENTRIES 0x0020
+
+/* The first 16 bits give the amount of PK core instances with 64 multipliers.
+ * The next 16 bits give the amount of PK core instances with 256 multipliers.
+ */
+#define REQ_CFG_PK_INST 0x28
+
+/* Writing 0x1 puts all pkcore accelerators and scheduler in reset.
+ * Writing 0x0 makes all pkcore accelerators and scheduler leave reset
+ * and become operational.
+ */
+#define REG_PK_GLOBAL_STATE 0x38
+
+/* The semantic version : major 8 bits, minor 8 bits,
+ * scm id 16 bits in little endian order.
+ */
+#define REG_HW_VERSION (0x40)
+
+/* Bitmask of which CQ interrupts are raised */
+#define REG_PK_IRQ_STATUS 0x88
+
+/* Bitmask of which CQ may trigger interrupts */
+#define REG_IRQ_ENABLE 0x90
+
+/* Bitmask of CQ interrupts to reset */
+#define REG_PK_IRQ_RESET 0xA0
+
+/* Bus address of the page p for the given request queue.
+ * The address must be aligned on the page size.
+ */
+#define REG_RQ_CFG_PAGE(qid, pageidx) (0x00100 + (qid) * 0x80 + (pageidx) * 0x8)
+
+/* Size in bytes of the pages represented as a power of 2.
+ *
+ * Allowed values :
+ * ================ ==============
+ *  register value   size in bytes
+ * ================ ==============
+ *     7               128
+ *     8               256
+ *     9               512
+ *    10              1024
+ *    11              2048
+ *    12              4096
+ *    13              8192
+ *    14             16384
+ *    15             32768
+ *    16             65536
+ * ================ ==============
+ */
+#define REG_RQ_CFG_PAGE_SIZE(qid) (0x00120 + (qid) * 0x80)
+
+/* Index of the associated completion queue */
+#define REG_RQ_CFG_CQID(qid) (0x00128 + (qid) * 0x80)
+
+/* Bit field of pages where descriptor can write to.
+ * When a bit is 1, a descriptor can write to the corresponding page.
+ */
+#define REG_RQ_CFG_PAGES_WREN(qid) (0x00138 + (qid) * 0x80)
+
+/* Maximum number of entries which can be written into this request queue */
+#define REG_RQ_CFG_DEPTH(qid) (0x00140 + (qid) * 0x80)
+
+/* Bus address of the ring base of completion queue n.
+ * The address must be aligned on 64 bits.
+ */
+#define REG_CQ_CFG_ADDR(qid) (0x1100 + (qid) * 0x80)
+
+/* CQ notification trigger position. */
+#define REG_CTL_CQ_NTFY(qid) (0x2028 + (qid) * 0x1000)
+
+/* Size in bytes of the completion ring represented as a power of 2.
+ *
+ * Allowed sizes :
+ * ================ ============== ==============
+ *  register value   size in bytes  max entries
+ * ================ ============== ==============
+ *      7             128             16
+ *      8             256             32
+ *      9             512             64
+ *     10            1024            128
+ *     11            2048            256
+ *     12            4096            512
+ *     13            8192           1024
+ *     14           16384           2048
+ * ================ ============== ==============
+ */
+#define REG_CQ_CFG_SIZE(qid) (0x1108 + (qid) * 0x80)
+
+/* Interrupt number for this completion queue */
+#define REG_CQ_CFG_IRQ_NR(qid) (0x1110 + (qid) * 0x80)
+
+/* Control registers base address for the given request completion queue pair. */
+#define REG_CTL_BASE(qid) (0x2000 + (qid) * 0x1000)
+
+/* Count of how many requests are queued at a given time for this RQCQ.
+ * When this count reaches 0, the resources of the request and
+ * completion queues can be deleted.
+ */
+#define REG_CTL_PENDING_REQS  0x18
+
+#define REG_CONTROL 0x00
+#define REG_CONFIG 0x04
+#define REG_DATACTRL 0x10
+#define REG_ENTROPYIN 0x14
+#define REG_PERSSTR 0x1C
+#define REG_HWCONFIG 0x40
+
+#define CONTROL_START 1
+#define CONTROL_USE_ENTROPY_INPUT_REG BIT(2)
+#define CONTROL_DO_INSTANTIATE BIT(5)
+#define CONFIG_USE_AES_128 0
+#define CONFIG_REQUEST_NB_BITS(bits) (((bits) - 1) << 16)
+
+#define MPK_SEMVER_MAJOR(v) (((v) >> 24) & 0xff)
+#define MPK_SEMVER_MINOR(v) (((v) >> 16) & 0xff)
+#define MPK_SEMVER_PATCH(v) ((v) & 0xffff)
+#define MPK_HWVER_MAJOR(v)  (((v) >> 24) & 0xff)
+#define MPK_HWVER_MINOR(v)  (((v) >> 16) & 0xff)
+#define MPK_HWVER_SVN(v)    ((v) & 0xffff)
+
+#define MAX_FLUSH_WAIT_ATTEMPTS 500
+#define MULTIPK_MAX_DEVICES 1
+#define MAX_QUEUES 4
+#define MAX_RQMEM_PER_QUEUE 4
+
+struct multipk_dev;
+struct multipk_user;
+
+struct sx_pk_cq {
+	struct multipk_dev *mpkdev;
+	unsigned int generation;
+	int szcode;
+	u32 *base;
+	unsigned int tail;
+};
+
+struct multipk_work {
+	int qid;
+	struct multipk_dev *mpkdev;
+	struct multipk_user *user;
+	struct sx_pk_cq pk_cq;
+	struct kthread_work cq_work;
+	struct kthread_worker *cq_wq;
+};
+
+struct multipk_dev {
+	struct device *dev;
+	char __iomem *regs;
+	resource_size_t regsphys;
+	char __iomem *dbrg_regs;
+	resource_size_t dbrg_regsphys;
+	struct cdev cdev;
+	struct ida available_rqcq;
+	atomic_t allowed_reqs;
+	int max_queues;
+	struct multipk_user **users;
+	long ntfy_mask;
+	/* Lock required between release and CQ handling */
+	struct mutex lock[MAX_QUEUES];
+	struct multipk_work work[MAX_QUEUES];
+};
+
+struct multipk_user {
+	struct multipk_dev *mpkdev;
+	dma_addr_t physrq[MAX_RQMEM_PER_QUEUE];
+	char *rqmem[MAX_RQMEM_PER_QUEUE];
+	dma_addr_t physcq;
+	char *cqmem;
+	dma_addr_t physsh;
+	char *shmem;
+	size_t rq_entries;
+	int qid;
+	int rq_pages;
+	struct eventfd_ctx *evfd_ctx[MAX_PK_REQS];
+};
+
+#endif /* __SILEX_MPK_REGS_H__ */
diff --git a/include/uapi/misc/silex_mpk.h b/include/uapi/misc/silex_mpk.h
new file mode 100644
index 000000000000..e869f38dcb60
--- /dev/null
+++ b/include/uapi/misc/silex_mpk.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __SILEX_MPK_H__
+#define __SILEX_MPK_H__
+
+#include <linux/types.h>
+
+#define MULTIPK_IOC_MAGIC 0xBA
+
+/** Set the number of multipk configuration **/
+#define MULTIPK_CONF _IOW(MULTIPK_IOC_MAGIC, 1, int)
+
+#define MULTIPK_IOC_MAXNR 1
+
+#define CQ_STATUS_INVALID 0x0
+#define CQ_STATUS_VALID 0x80000000
+#define CQ_COMPLETION_ERROR 0x40000000
+
+#define MAX_PK_REQS 128
+
+struct multipk_conf {
+	int eventfd[MAX_PK_REQS];
+	int max_queue_depth;
+};
+
+#endif
--
2.34.1


