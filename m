Return-Path: <linux-kernel+bounces-548738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F183A548C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A39188F677
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF320A5D3;
	Thu,  6 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N7IBMPvU"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15120A5C9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259328; cv=fail; b=W1qbHR5qBVyAD4Bb1LQCuUWVh6nggZ+yRFndo56MuuaLKDcuCEzHdtLsMUHuc7Z7RPKqfSq8bw33krIhsmiaDkhtEREzNWo48UVrmkLhRIW//sGldribA/ABiD/ZjfD962WIZmsZsL3W7eUcKaWtfYi8k9b1GRRKHbOJjL9yzRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259328; c=relaxed/simple;
	bh=VKOwm3RPSpHqA/cyU68xN8hX2VZUrzjayGrEKuwFF68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlRfAv1S6H7oTUQO28IvacfBzQZOaXHMchYs+mMQuTbAxXU5K2KKCYqavESn/+djOZLW/+sMVDEzSUse1Kx+r+FP4pir0w2/vW/DYVFHxrzjbWOJNK/GYz2jFE5uM9xtb/Q+E0fDfD/ArvbSIEQs0wAB1Js/VevGSHMcjmTmoyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N7IBMPvU; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnVBTSEVeM7j+FtwSBRMPI7ZIwisZtVSJKt0Ar8132k/M5GuFiw8DURK0efYFDtfviVCOO9DzWWpuluBRzFgPWHnGelrycgG0VAE1Gm2CQcDre3mgzcEN0MZN+Bn661wpEMw0aIccYysL+j6ap97l592+S/d6NY/T9ooat0lJvgATxKrp+tisXo3SfIRQiJrblrifKv5RiY+QAr27qxXRIWiOP2ZUeRvuVzsRVSEqnt+Pt2+4H0HY8nO1knelJwoE01TwAsbM3c2PZ9K/HGpk5zynu7AoBn5rX15959ClrSo1lY2U64liiRW3Vcg1pQRGoU9c1DoWdGrEX6XUsmWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1O71ehfXXzRhaoeOAZGnHL5Nefy6bBzATK2U64FJN4=;
 b=KmqwcX3LYi/hmbpN2fkA+Ic796PZB8KFpimPP9lrZ2ZsCjpOLy/0nECIWBnsXWWeF+3Qw4Jg09Ei7OG7Kdz1zrsZGlpf+omPPAkKPbJWvC1XzEer74oMr8AM54wMdDr7QcL8oGAFVsJtxfJBGRLGadwvjAGyBJkgnysAphzrR2sbjCJ6zsr+3whfHh8txWlP+9Pnd3GUNyfpcu6qhfba+oCxZRG2TYPgvTrO6Ss4AFGzYbxPptXZi7TRLwYgoNlEcP7Xl18Dl9RkylmJdswY9Fh87/H55/xGNBteXNn0R2J7W0Wb05ekXzS27ZT1fxaAWgsquMKnu4XKxeRyE/lsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1O71ehfXXzRhaoeOAZGnHL5Nefy6bBzATK2U64FJN4=;
 b=N7IBMPvUOpXrfFycxQRMzYhYc96NNFvndCBL5wGkYOie+9Fyo+tb2GuVSMR+MI/6YbT/on7q5EUTk8EUwQ43pTYSbzTgK1TAf2jnFAt1JfFtOCFq22H4H2RjaoLuAs7biukjB+ncmdrtQa0qkWELc5cctL96q1HGigdmm4lPi94=
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 11:08:43 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3f) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.20 via Frontend Transport; Thu,
 6 Mar 2025 11:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 11:08:42 +0000
Received: from penny-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Mar 2025 05:08:39 -0600
From: Penny Zheng <Penny.Zheng@amd.com>
To: <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Ray Huang <Ray.Huang@amd.com>, Jason Andryuk <jason.andryuk@amd.com>,
	Penny Zheng <Penny.Zheng@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] xen/acpi: introduce cppc performance hypercall
Date: Thu, 6 Mar 2025 19:08:19 +0800
Message-ID: <20250306110824.1506699-1-Penny.Zheng@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dc0703-a8a8-4109-41e2-08dd5c9f41d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVqQzV3ejl3c00wZHlVWlI3dTNmSjdVQWlOK1RmQWkwc3BqZW1tbm5oczZW?=
 =?utf-8?B?bmhVTFBqck8wbWh3Ykk0M0NDVG9RWTBJTlhZSzVjZXBDUnQ4djhTeDIrbnlz?=
 =?utf-8?B?MVVZeVl4RnN1V2Q0cmFQVk0wQlN0N0VoaVEzd3o0Z2RDNFB6cGtlZGM0Mldz?=
 =?utf-8?B?V1JmUjdkMndZcnhPalNhQ2VieC9pdUR4TlNRbVNNMUtSUGdxbU9DR2luWWtZ?=
 =?utf-8?B?RHVMK1E0UzN1dXgxSlBFYTEyZkU3NVNZL3Q3eWxUTWswazJDSGw1MUlzeEFR?=
 =?utf-8?B?MkFoL3dvTWtKby9lMjZjS1FjZEVHVVRlTTlvTi85NEl4dEVsa2c0Z05rMlR0?=
 =?utf-8?B?RDlJQjlrOE1iZFM2bFFPS0tSUGN1bWYzMWNNdlBwTjBaM0FCcndlRHJlQlpm?=
 =?utf-8?B?MHNWaldwSmZJcjhhYmV6STJZWjdkNlhDTFZYWmZyblFMUUsvSDUweTdQUFk4?=
 =?utf-8?B?T1lwQ2VWQmZLN1BWKzZOdWVrdndvTU0rWlhydkk4Q1B1UWFQSmVUeElvalU3?=
 =?utf-8?B?WmtsaFlneGpxVXlBbFc5TzhOMTd4VlAzM2hDRWRtRlBFSG0wK0pvalZic0RN?=
 =?utf-8?B?UmZIOUtrODRoRW1nN0hyRC9VWWRhbnU2VWN3a1hqRTFic3doNkwyeEdIcmJz?=
 =?utf-8?B?a1VVaHJINDJYSFdpaDFiTVJCT1B2UVFDSUNMY1I5VlFCcEo1SUo1UkVGTGdD?=
 =?utf-8?B?ckV0NVJQWVU1MXFLOFY0aDhicmFtZXNNellicDJNM0NWc1ErMTB2elRzNUwx?=
 =?utf-8?B?L0lOR0RBSjRtejd1SVhKeHE2QjJudHdXN0N5VVM5cVAwcE8vQ3BIR1B1TGhD?=
 =?utf-8?B?eEFjZHRqVTNENjFyVDJUYVVpeGJ0bmZPR3NqRzhkaVhuN25ORGc5U0tGMk9P?=
 =?utf-8?B?U2IxVWEzSjQxdVdJV2JzcFF6WllYcW04TnhFaUZuTlpNTVkyWStNSjZFV1BV?=
 =?utf-8?B?MUllT3o0ck1tQkc3QzE5L2FZM3hWUHBIUkhtT25zMksraUhWbnY5QzhFOEV3?=
 =?utf-8?B?ZlkzWEp6dCtYakhvdm1nb3g1ZDZxREVwZWxqM0lJY05PcUxHTFg1a2U2TXAy?=
 =?utf-8?B?aGNUOE9vcCtRaFFEd2RMSGgvTnhRekREL1RBMHp4YTdOb3BBb29kSjY5U2V3?=
 =?utf-8?B?T3RMUGo5WmZRUlMvNzlSb29QNWJBNGlxVUtSZG0xcksrN1ZVdTQ5cFdHWFVv?=
 =?utf-8?B?a3A2N3lrcU9zVUovcSswNzNvcEE0R0p1bzFwbXg0Q3RaSU91RnlVdFphVm4x?=
 =?utf-8?B?MEFOblNOK3hXMHZicGxiRFV6N2ZSRnNZZE44Mkd6QmdXb2tNa3BEbUxmOWE4?=
 =?utf-8?B?WVkvODE2UzVxQkIraElrTDVXZmR0b0p3MDAxVW9BZkpOQ0tvRWtZZFJyQ0JI?=
 =?utf-8?B?ek1mZTVRK2lXdkE5UVNhcU9Ud3JKRExGZ1JsVzhxSWFNdGVYbVkzOW5mOHRN?=
 =?utf-8?B?UmtLT0t6U2YvTENpaVNnZmd0L0k1UU1ZRGx0NlRwb0M5c2FGMlRHbytEeTU4?=
 =?utf-8?B?cnJFZXBZMnpVQUQvZURKdno2RzlLcVdjY0J4bHpNYTlQYzcwZzhWMnFxSXNp?=
 =?utf-8?B?aFg2K2FTaFB5alFWOWxkTjY4RFQyQTF1VDRESlduSDhlQzI5ZkUxa3pxNEhV?=
 =?utf-8?B?OFMvcVZsMkVhMDRmYkVIVlNRZ2sxNTdlcjF0UVM4V0ZYVm1aYXNYU3NZMlZ5?=
 =?utf-8?B?QStTc1Z5V3plVm1FZ295ZnArVk1IY01vSzBERnVEVFJRQ0VFdVV6UnZDV3ht?=
 =?utf-8?B?SnFlclBwdUYzeW93dy9ZaW5GV3dieDQ3S1ZEUCtRZnVRNUxOb0pFZUl1UVov?=
 =?utf-8?B?a2dQR2QyeTdZY0ozc1JWYmxuSFJRb0d3NWVJUjV4WllHWWY0b3UxdHhISGxI?=
 =?utf-8?B?S09qa1hHZ2JsMHA4Um4rTDlMSis2RWpnckVhRXhIZGV1S0xBSmdDT3BXeTJS?=
 =?utf-8?B?VmorSHN2aHZCbUdUNGtLM041enBHSzFWcGs1ZHRPNnBFZmdCTUE2cmMrT01K?=
 =?utf-8?Q?AvEqPRGfYGc3VUABnjRt/np7YuJgaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:08:42.9072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dc0703-a8a8-4109-41e2-08dd5c9f41d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

When running as Xen dom0 PVH guest, MADT table is customized
and may have the "wrong" UID processor number, which is
inconsistent with the UID in Processor entry in native DSDT.

As a result, during ACPI boot-up for dom0, linux fails to set
up proper processor logical id <-> physical id map(acpi_map_cpuid).
Furthermore, It leads to that some ACPI processor feature capibility,
like per-cpu cpc_desc structure, failed to be correctly stored
and processed.

With upstreaming "amd-pstate CPU Performance Scaling Driver"(
https://lore.kernel.org/all/20241203081111.463400-1-Penny.Zheng@amd.com/)
to Xen community, amd-pstate driver is supported on Xen platform.
And as Xen is uncapable of parsing the ACPI dynamic table, like _CPC
entry, this patch serie introduces a new sub-hypercall XEN_PM_CPPC
to deliver CPPC performance capability data.

This patch serie is based on commit "xen/acpi: upload power and performance
related data from a PVH dom0"(
https://patchwork.kernel.org/project/xen-devel/patch/20241203225338.1336-1-jason.andryuk@amd.com/),
which is still under review.

v2 -> v1 :
- rebase to the latest v3 version of "xen/acpi: upload power and performance
related data from a PVH dom0"

v3 -> v2:
- add new commit of "introduces XEN_PM_PSD sub-hypercall for solely delivery
of _PSD info" to be compatible with
https://lore.kernel.org/all/20250306083949.1503385-1-Penny.Zheng@amd.com/

Penny Zheng (4):
  xen: introduces XEN_PM_PSD sub-hypercall for solely delivery of _PSD
    info
  acpi/cppc: extract _cpc entry parsing logic
  xen/cppc: get xen-required cppc perf caps data
  xen/cppc: introduce cppc data upload sub-hypercall

Roger Pau Monne (1):
  xen/acpi: upload power and performance related data from a PVH dom0

 drivers/acpi/cppc_acpi.c         | 204 ++++++++++++----
 drivers/xen/pcpu.c               |   3 +-
 drivers/xen/xen-acpi-processor.c | 398 +++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h         |   5 +
 include/acpi/processor.h         |   2 +
 include/xen/interface/platform.h |  19 +-
 include/xen/xen.h                |   2 +-
 7 files changed, 529 insertions(+), 104 deletions(-)

-- 
2.34.1


