Return-Path: <linux-kernel+bounces-202818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF88FD182
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115651F24ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E250118F2E4;
	Wed,  5 Jun 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GYc0pA1f"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98E14D2B4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600827; cv=fail; b=eorUxmDROa85h+IO/iybZDRPrrjlGJqFZiHoHK90UXiAqvovgElc7HkcpyDobJ99yYimgQ55gEpPMu0kW7UCbGA83ag5ENMxGW7PcZR0g8VfcZx2d+Mmsi4erwIX3toNZciWfXujoSrd1CFTTu+ATEJ8b7HDZNdyrMk64KzQV7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600827; c=relaxed/simple;
	bh=hzHsTcOEqbURjjjRPi/mB7pYYfnsTXfd+xMFiWdTu+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKt9Yyor5pxvIC3jtH9U83uMm/Ivk1CTU2/FhKqpU2TbvxlkyzAz3BKHf2CMwWvEPq4dn0a1UZ3oAFQ+riiKHOtRa8uSMtyBC6+RcICo768MzLpsbgzJSy1o6oBFzzFHS1YP3AFTo6dXVJ+CLtxRVMMDeTsiVXwVGyE98xAkFp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GYc0pA1f; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYIzPes3bEkT4yOho403w+UNHLySsSpkdsMItqSUKvNDEgJ1Kvgl5dJ1Zwb8H1RkVIvsBsIiyEVZ40aDryVSQthe2pdn/cfET5FT8aWIVQTEmSn2k/Mpr824mYcn3Ot64uVw4OO1RXVPpszWBu0YTq/h2X593iYrT5NHypq50hKrh612+aA1BD2dTiZMVTZo7DPcFHbo6lpPUSHqMy+d+2HQvAmHY+a6uSBS/04CFk+hdrixECX3kCIe9uLfZZtuIATtoeKgH21lVebULyecPI4FdQa8RRG62cJ182op3kcbTSZRJZ8RinFmy66eIWXTMfX/m9uL+tAPDT3ApFi5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNID2WLx+iUMqQcZTI4bS3857lFpl+P8FdsIcsS2Mjs=;
 b=WzuNupvqWgFdfhIRp+pf0wOanDQOSs8nJ1XED3r363Gogkqx9hBchjWc17Yj1gRnGvHP0OFRfzK+BiurN/f1xMsMV6iSUkveCKmytnEfGg7JQfMMyHFusfQZ1du3Hstp1M7GceXw5i6TVuBeLkHHFZT97VJK7DGSkzR97NZP5NMx3qrgDy89Vs+u6JyXqn+RBkwpWKBed8HoXp5qII4u/Xa2bbRYuJEzMk+5VV0Hx+GSDQdtUS4QgOCrQ2z4k0ZUWoTLvEoQLQbAs7Btek6JlINwzwK6whMwKlBngFe51ubT+ugsELpd+r7OCYQRZarWpjEFzDx+URAD7POFKGPaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNID2WLx+iUMqQcZTI4bS3857lFpl+P8FdsIcsS2Mjs=;
 b=GYc0pA1fPSBjjkeSXS7j65gb4hKSyCK1J+v1P/dDcwUQnP3RFQ10pZrRDHQoaYVLdng0JusPzqy2bnik+HjHqcrCCK53amwvYf7J0WgXcn8BRX+bs6eZ+jdvP/zEkuvOM+wO/vLfGfbWGv/YViHxPrit8wOI/+VL3lCQDjHQzbI=
Received: from BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 15:20:21 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::95) by BLAPR03CA0118.outlook.office365.com
 (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:21 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:20 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 09/13] configfs-tsm: Allow the privlevel_floor attribute to be updated
Date: Wed, 5 Jun 2024 10:18:52 -0500
Message-ID: <5a736be9384aebd98a0b7c929660f8a97cbdc366.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: fef2d0fc-789f-45e5-0f89-08dc8573040f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QN7C3Q7+xP9ecO57nZ4SXmC5OT1DVYPtmvH8xigcQHc3G364DgGQsGX3AWmQ?=
 =?us-ascii?Q?Dca2HQgjaFMCOnH06j0xMjazFXDnhqHUmtY0n9m3b3FxSwXDZ9mkGUda6BoH?=
 =?us-ascii?Q?YFWfsMbb61hZBgXArU4RspNqtMG+3m2wl5aFEXHOrA+R1ABCUld/tJlnBymu?=
 =?us-ascii?Q?oR8aTesfrEESB/syrWhKZmJBdg9FZUw2TOiYhO4R2TcJo2vxUDN+Huu/pWWx?=
 =?us-ascii?Q?iNEE/w5PnjUEIrMlMT/5KFxSV0kOeDlWRr/YjBPKmlGN6CuWiL0cn+eCMdjv?=
 =?us-ascii?Q?/Nkv4fnMPr13SdFhLG6PxprgTOBJcCAcj6eBUy7PloyqUOcTZAfdoDQMcYhW?=
 =?us-ascii?Q?Xvt3FKpN2Hg55g05A7UyXDNxVG6DLVWBzif7GsYKSFcc0kKWyhkQ36DuitF9?=
 =?us-ascii?Q?foP+kA2URRoDMkA5V3y8BbLcs7NYXrf9CQfFeoGss/tNzuAmXuRYw0GEOw1E?=
 =?us-ascii?Q?WZl8o3UUqFBpkx8ExRrlJClLx5yoae6n3yxFUcihA2n1iZLkjOfz8rCWCBSO?=
 =?us-ascii?Q?/ch/HNGQ4M3/tijzEaebNAloNzBSmvxp9wyqm2UPm622if3qPCKyxGqb4ZmD?=
 =?us-ascii?Q?qU1BlPoq45qDe23K60lGl0USEAiCTqr2V33k6+y8Q8F+l2j+vVESRwR3Y2YF?=
 =?us-ascii?Q?TZmRuhqSACRufeHx1vVSNjeL4vIftjmn6VHXWqMLEbjh83VOR+m6hfn+Lt/E?=
 =?us-ascii?Q?u49BzWAjygZEE4drXkv6PjLF7Ya6dTpsGJKlsyVxuU8f82I9MR2RkZCyEVC9?=
 =?us-ascii?Q?26yIMlwjA49uCGMi9S8EHwzMStRI6NZtk4rUbRDLz4fL4a8DqFjDYCq1rIIg?=
 =?us-ascii?Q?MshBAQ6WQcsx2lr5L+/4Ge+G/avIkm+jOYWRGO9D+YR35BOnl8541VhSZwWf?=
 =?us-ascii?Q?QPp54lRRGLJJi80S33dsqQL/ttQQAeBvFu35F3RXf+uzAd9KuSSinD6fm/Op?=
 =?us-ascii?Q?6HV+Liq/uKueighgq/YPOtTPULouSWq2MPo9JoUNqivVm1q8o/H9Z0gNOLjS?=
 =?us-ascii?Q?DLNXv2Sc5hTZABV2uYZsFsCyxO/jhUDJGpoJVyoCo3ORV5gp4gWOSEkBa3Cj?=
 =?us-ascii?Q?NB/25vruTVLwEgg2Ojgn+0x2X6EHoIM16WT/oWqMn6VfEV57AgRcXRI7FRIr?=
 =?us-ascii?Q?iV/rK11/pBdVc9jlaJKFe5q09cI6hTF0hJRssdM3dHszTLpXCHI5obuIuX7N?=
 =?us-ascii?Q?W0Jo7sD6egSJsElDGNVA6tsbyzvSLcxkjORNE/67FGiRRO0bptvxZ6X2e7M7?=
 =?us-ascii?Q?y7fXg76739IpzKuWaAAtZyhgGiq83QacLQwupPF52G0mOjSA5nyf10losSkf?=
 =?us-ascii?Q?shlwocGuUMf8lhUIpEnEBNz9Aj2Ocn/ZoAK1eyoKJHNSMJP8K8rVYYCzQqFW?=
 =?us-ascii?Q?6ScSO4iy0C7bfPRNY6JyHEyUIQGoJmQtWa1I/imHIAtEE/1IqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:21.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef2d0fc-789f-45e5-0f89-08dc8573040f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

With the introduction of an SVSM, Linux will be running at a non-zero
VMPL. Any request for an attestation report at a higher privilege VMPL
than what Linux is currently running will result in an error. Allow for
the privlevel_floor attribute to be updated dynamically so that the
attribute may be set dynamically. Set the privlevel_floor attribute to
be the value of the vmpck_id being used.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
 include/linux/tsm.h                     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4597042f31e4..3560b3a8bb4d 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -892,7 +892,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
-static const struct tsm_ops sev_tsm_ops = {
+static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 };
@@ -979,6 +979,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	/* Set the privlevel_floor attribute based on the vmpck_id */
+	sev_tsm_ops.privlevel_floor = vmpck_id;
+
 	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..50c5769657d8 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -54,7 +54,7 @@ struct tsm_report {
  */
 struct tsm_ops {
 	const char *name;
-	const unsigned int privlevel_floor;
+	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
 };
 
-- 
2.43.2


