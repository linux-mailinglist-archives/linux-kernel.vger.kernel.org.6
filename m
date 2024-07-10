Return-Path: <linux-kernel+bounces-247794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814DC92D4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378DF1F23079
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6619408D;
	Wed, 10 Jul 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cdDozM51"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77218FC6C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623513; cv=fail; b=C12mD/nznbk4Pn07K0QOPag3Wrs2+IQ6xFEHkwZ2e2gpsWjBFjzKEs112+iuLW2qg1ru3J20YLHKcYazsil1KWPu+vUqfp8rNSQLS4DIDFNysUQFR3kCE5ezJUPk1gOcE1bBQYeo883UgbuuSNZQMlaSdy7AMqSFL7wh49lpEUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623513; c=relaxed/simple;
	bh=SeQE0H+phj4gzr3BQ5YjuhcwfK2v8F9Im2QpU/4P+GA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwPqJznyLmWl3LdnQt75Rux6wcl46INB4kNvzbjaVhSFl7veH1oySjQld+pjQF3n1JAB8Cuvt/h254CfCpk8ntQTTwNf/2xzSYNTXpETU3/yVhSg6Cb9fVpwgQTf4m7T/HAVd/Mb6dWCnbVtIPUWJI8k0o4pyj82BwHL2RXMDSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cdDozM51; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozn8AoXN/MSScmEr4IsIQX4qedGdF3YumSvefIbd9Efh0T4xrxfBdSYKl+INPnWH0QOGHlEebA9a1k8cwppcX5RO0GHrQWxjtC9RvDvZR37nZS6djcZT2ZhYz0181e7cUI8h66lgQG9VoBxcTGq0Yc0OHzrLgybSGrtXwGOOCcETgzRbmDT0awri6rGpBrLLQl+045nrLI5JecSiHohfbqyX3l1QvQ1411EYfVzZrXnkn2yK9oEIq7Z/ZdLsl7kbuv4Q3jDG3pz2/d3nI7pbVK+U+KEg3YvhmlJ/nlRymTsZAfi3uNTo9Xp9XaCQ99HxCR6HXEC2Pu5S4Vfh5Ftejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FyLhT8NtA/kGv8i9z/+Khk75G1shZwzACy5nuX/5KQ=;
 b=eplTQcER7iVosWdZ4d9l9cmNI20BkhqlaLVSCMfNwOWCOuDmu0Z3ikHa+X/NfdCXkPaUIfUj5L/03BQ2SYAczXvfTKZHCSuA4NEwuYIwXE9wpQfMXljR/fOsjJBuVdMlAqrn6o50hpCvenYsoOPfZkIEkTPkCMnhUMJGxl2QMtysNq5h+QTtOEXA84NiXUHmkZlXpUE+jTS07/CNXYUmBGfvTg5D/1SD1OtSSkio8cUs9fl8b99t1/p7SbVuPcPIj3IOwE21GSvTrMaaYNDqhNZXgbJyZe/H/1B09EifrVMbGYYdDslht0L0y0UqU6tlfUeQ14WUeOjpf5zj50TbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FyLhT8NtA/kGv8i9z/+Khk75G1shZwzACy5nuX/5KQ=;
 b=cdDozM51J43kY1PoMW5vQ5mQ5cMsiSS//eft69Iz9eCF96FWWlJXe0xt6vxdvQOqCmhPWq4fr7nXjJSEl3WhDYkG+ucvyCPOze3cM1SQ4jxDpRPE4JIEcfUmcG5N72fW7TXxDf5k0q9UgSXVSRcva5aiOAnGILY1lmtTn7k1Jg4=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 14:58:24 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::dd) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 14:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 10 Jul 2024 14:58:22 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 09:58:17 -0500
From: John Allen <john.allen@amd.com>
To: <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
	<benjamin.cheatham@amd.com>, <bp@alien8.de>, <mario.limoncielo@amd.com>,
	"John Allen" <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date: Wed, 10 Jul 2024 14:58:02 +0000
Message-ID: <20240710145803.89218-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a069b17-90b0-4891-00e3-08dca0f0be81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6TaUEGG9dJuWxCuWW67D56EtEaQp2Aw8paT+v/eUB5ZBxIhhjlqLmca/wuLN?=
 =?us-ascii?Q?/lra/fCNNDerEZs5EpDIt4wGPdAxzWATumAlAeI5z/o6BBV3BdodunkYrKer?=
 =?us-ascii?Q?akYAacr6sqrJJJ9ugUH/73Rqii9MZZLBmQAOLUAHqdecGp1Vye8dHvLMOmPP?=
 =?us-ascii?Q?0GhuUt7FT4wSiKRvj+i9Wr3oCEHJUc+h02mxcV1zgqq600Wgvelp6PXuEa7G?=
 =?us-ascii?Q?Owxe5NtRWSUyj7NwANMB7p+OWG5TtTmfCkNOb5sgpsm7/5/chk+zqRe/rTmE?=
 =?us-ascii?Q?RagR3KKW2jf/S4zkTPHT1Tvko07/6rqMH6FqW5HGwcGYhkYxXz5NsIZM6aLn?=
 =?us-ascii?Q?tGgmrmACymiqi99Fyg02rjfllJebuAbJlrBFiMEL3jubvgpG17L6Ky/+PgL6?=
 =?us-ascii?Q?kCIPqXFgU9fiRauk/Lpg9SCZe7iYGL+l2C215IdK3oVoGTxlOeDqNVYwJeEw?=
 =?us-ascii?Q?pg5uA9Zx5cXz6tP1rd3gE0id98GCalXkEhUvP3ZpEQu9q5+DnvU4Xsurt2gA?=
 =?us-ascii?Q?Uf+maXBTWGB3jRAs8DP/S9GbgIFtl1hkBKT2mvrvgJs9SGSlKsXnHZxAACB3?=
 =?us-ascii?Q?0wLGej5A8KEyYRbYG7AKX/ByIQaDJOz2JjM2WTXzGbQrro36UHI0P04MPpqf?=
 =?us-ascii?Q?olwG0GZs4X2Ipt8A8UZWKbkYbDtfUfHutRObIiKkH7WznsXBs1/CxCOdUX97?=
 =?us-ascii?Q?r0krlTWmbcQxCUNCHFaqnVBa916a4Pz4167AOAAYPVPajt7DBLpsueRX4PXD?=
 =?us-ascii?Q?8WogXUN/EonOdDZLBDxkbaGascEkS7537jan2EOLzT+PHiLmJr/hmWnl36xu?=
 =?us-ascii?Q?90sdKQ5t6gjRyKgmEe+5QB0mTjR7oNpH8Nwp799B2B+fEYFUBr2+O2VcQlXs?=
 =?us-ascii?Q?1Y51732zSuFgORPa1fp4j/wY+BmqFLxVDjMOao2EOqzugZ0TBvT395saIF2i?=
 =?us-ascii?Q?r+xWd4DX0pi4BBPYLtaO/YcLJTvPVJVxVrEPGLeznKG2BFlRODl/+Ng7G5Dd?=
 =?us-ascii?Q?7F6+nPGMPAzQ/3GVo/TMVaY9IZJ8Mgev4+rHwmHT6ndItV9rSGR1sqObF7gR?=
 =?us-ascii?Q?SxdomzoeqDe7xnATcdP5x0UpoRstg0nHvKPpHDx19fItr5lvCho6zjOvLcW8?=
 =?us-ascii?Q?vKnrPfByPX2AS0IeKn+VgLCzSdGBE5emY4ZJZ6aHory9ZpNLjz67FkZRon4M?=
 =?us-ascii?Q?CTkhETJ6UaITm+9Nhx0eWA/GVu18mI56V8k0qq/xZE/SruPinSkfYLE58N5S?=
 =?us-ascii?Q?gQappV8jh1z+BNaM6nICWmEjFFRo2pN5jxM8KgR/vy8ZwDPZv9VqxyqubKjU?=
 =?us-ascii?Q?RkscjTDW0ZKjmXnJrBnQVIZ4X++a/1lsZoVlXgMk28/doByiWipci3XSgB/1?=
 =?us-ascii?Q?BZWaputY3S3NL35wQDnerSbZDVpwypO/UmKxhxrkVYAUAk+hQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:58:22.5988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a069b17-90b0-4891-00e3-08dca0f0be81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

* Update AMD cpu microcode for processor family 17h
* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   4 ++--
 amd-ucode/README                       |  16 ++++++++--------
 amd-ucode/microcode_amd_fam17h.bin     | Bin 12924 -> 12924 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
 amd-ucode/microcode_amd_fam19h.bin     | Bin 39172 -> 39172 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/WHENCE b/WHENCE
index 17b7585e..d08ff118 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4177,9 +4177,9 @@ Version: 2018-05-24
 RawFile: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 RawFile: amd-ucode/microcode_amd_fam17h.bin
-Version: 2023-12-05
+Version: 2024-07-10
 RawFile: amd-ucode/microcode_amd_fam19h.bin
-Version: 2024-01-16
+Version: 2024-07-10
 File: amd-ucode/README
 
 License: Redistributable. See LICENSE.amd-ucode for details
diff --git a/amd-ucode/README b/amd-ucode/README
index 9fd019c6..4f862af0 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -31,19 +31,19 @@ Microcode patches in microcode_amd_fam16h.bin:
   Family=0x16 Model=0x00 Stepping=0x01: Patch=0x0700010f Length=3458 bytes
 
 Microcode patches in microcode_amd_fam17h.bin:
+  Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126f Length=3200 bytes
+  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x0830107c Length=3200 bytes
   Family=0x17 Model=0x08 Stepping=0x02: Patch=0x0800820d Length=3200 bytes
-  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x0830107b Length=3200 bytes
   Family=0x17 Model=0xa0 Stepping=0x00: Patch=0x08a00008 Length=3200 bytes
-  Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
 
 Microcode patches in microcode_amd_fam19h.bin:
-  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a101244 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001236 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001079 Length=5568 bytes
-  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d3 Length=5568 bytes
-  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00213 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a00107a Length=5568 bytes
+  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a101248 Length=5568 bytes
+  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00215 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001238 Length=5568 bytes
+  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a101148 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d5 Length=5568 bytes
   Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116 Length=5568 bytes
-  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a101144 Length=5568 bytes
 
 NOTE: For Genoa (Family=0x19 Model=0x11) and Bergamo (Family=0x19 Model=0xa0),
 either AGESA version >= 1.0.0.8 OR a kernel with the following commit is
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
index 4afcc9833d26adc165647ef1c5fa9ada2a7d9124..ae94feefdde4bea0fc3e229bc4df9aa90393cfc2 100644
GIT binary patch
delta 3209
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
L&3yZ+#A^Qk7t33n

delta 3333
zcmYjTXEdDa79I>U7>wwQ9-?=NXrn~*9&Ly&IBFt#`6kFj3t{v+I)jK_5+x2IM+u^f
z5+r(eh!U=xlY7_QYwh(syT9++fA)prg`?IzU1iWOF}T)nD)cY<kA$N^AUIXTZ|j=>
zqEs>evq9JN#{cEtKqqQ3*F9y5ff3O|gR%QC7T`JLD+h+;5u^X6rk=lq&+#8d6Rc`~
zG?KYVS>Zkz?jKOlFiStOp-l8_<3I6;j%-9wI+A}X@D2kR%9k|rFvcyRg=TSnD81Cl
z<>r*6Y$s=MV+?!TcmtWc3)^5q)%nHr^AMKpVU~wIm9dt`B;yj65}~WzEQY};1)irX
zk$`lZg@O@vA!=e4r}-i@&Q|Dbb*YfuI1;+DE|r(Ju?ZeoOJqZ+WU}$_Z{K6GM_q-9
z=(KrNKYkq8c27wRO{!sC-%RIwWVBK~A|rFi`lGvG+kk5RnY%Mw-#r8_X0!Ljo1D4N
z1y!j8?)A2g#pZA3rkU_Cb$Bp1u)KS3M`&$XhqwhM1cKpW&?55ST|@|jrT3WaLXU%-
zDOyUg+DW%ZUzN<#!Ia{1pDV$Q^L_m-37XM#+>_;>fo&g23>hl*02^V?A3_n26O)_Y
zGL)fK+&|%KLQAyOV23J+a|^HYoBh%7D9V_H*{hUH$ldi<#%dNgzT!O<RxJw|oTnMN
zyYR#^@Kk#>!}4W+#@LnfLX<E;)0S?%=hNAMq)0jIB9B&cM#Uhnh0g$$ys?!=civk?
zb_HnN-4}29w_Kht^>Gbrory4{_DT7f>G6t9O>82o4?WujyQ`2($&97gkPluau2UeT
zH&30PsRhhliP&@=T&eL*v!7KYKzSuu<nzKdfZeoGIs3SdtM&+GR&WFT_?E7dTYS&i
zgji5N_I{zacrjO*vrKe&(;i1NnebdTHm_i+D|FIhk3*eOU)9t+dDx@HVTyImD%uj4
z^HLa@*dhbFh;Ua?a^fPC^oos5L3h8g#<TjAMx{fQkTzY}sCrEdLdDOsB`3Eu_!ANc
zpX_FF;1U!{219XN9Yh&<8U@<Sdt?ts{-#;xhb{*=h|HnV4##G{1<iHv;={w^PO32+
z68v|9;1tY*17smxF7D{Ng4wJlFY58PT?^f6l8q)3Jcj;iJN&6L`iJJ)cAgbTgk9L(
zfxL%%ZqP*a!mJ@tjj?4zF!G7+$Y}+@7GyGBBk!;gG%0wXUt||6&$$U&>Y+c#4O}s)
z`4}m*p9yI=GfU<TJHMKex{^z~T}EP@IkG!g9xET^VHY#`CjoEz@>^B-RecFf6Gn4Z
zZiMP@vL6|z<_((4XURWF^-tGB$!T}y*d0sON;HIxgU~yZbHRcv#;-3+Vbc0Qb8Kq+
z;jLa%Tc3Nl+LO7^PX_Z2yiSuQzSin~Oh5Gp_bZ84gJ%Yq(u=CcYBP>oB@_KpM+XfM
zvUkqswfc)wst4B*qR_Fv47CN(7kj4WPHxe?rR~ZpxvH=6!Bj=_qC)_0l43-wN<-H>
z7P(6v-@q@CmZR-{)RmY6y?53CP@`872TqSbet<xZ17YCDloVVyfj$9cV$&x9`1KcR
z^wHey28;2FhI*wB03r7U>kS%=`Zv4S$50*vxpc{5|5Vd=A9Nm!`K6!*d@cSqPQCq{
zw%}w}dW{luT3STuGECrqyayqFh;r1-J-XvH0vTengQf(=--be#tZac0!Vi!7W{UUS
z8qWlK(S6@nQR_{q3zqq-R1l2HfQp0#ZCSN|h{pK4v1iS@{--x)Cw_uzze$%tODB^x
zea@c4F^GKA<Vg-jA1}?lnVajB`1cA=(#S*CqxpQgg<_MUIoYg{>%$p3h>ykESclRN
zWgTj<9DbE0x5G}=+vb3hXSC+_pQU0r7oEx$^QH2>|8RAFy(uj%pcTH`{V4ov?Ye|F
zgul#7xGs#&X2#Z%4{r0^ke_&xTQ(3QfR#s~)2Q3+iLg7H&Yu0b0_OEcXA;5p5$qw$
zLg7x?m;Jga%+sf555HaLMni*bjVc;<YuWC*^Xl2ZY+g$;@E!o-Tr!iRpe-Ks0Om*F
zm+2uXTj#IFM--U}y4F?V{X-3}8u*=MH|}m<O6E0ry>H-K;c<dBLlqQd2TwsAe?mtc
z=|tl{lQy1%JuT_iZXXdMWu%@nG>UKSdskI<^%yN)MyiXaPPpN-DD)s?HxJBOVq0d4
zDa`uPxP@|A+?atGb<<uEy>xMLck%a&M*9^HLo?E|L=hdstj32Osi#9<bJc72@oxAU
z&(+46H(9r+<Z?)j$}Pjp3sDYwQ@%7-g$-fC@i$)DXs|jBOrq>Lsr}_hC#G2yK;`j7
zCB|28UXzZ|WwO@})%m_2X$W0Y?!^vmsgm~E>_VBAzD5C!i~}p1J}yL3HkI3o#s^7R
zVrj1uqUHuxRu|;kS_ymT$I_t_@D0bM>V6&);SX|Zq2lx<k_%KpgL>Q3MhzobqVa4o
zd2~(c?E<U?FGpibCXQ*lt0Kw9sBX`bXo<FWGjDCHmK@T}zfYQRHewCvdxQKN;B?3w
zkR>aIe18qd4m%14Qq2z7kz$qjVIhc0OwNEXfdpM(b>~NFk$Vd~A{H~+cCPA_-LtNW
zu8q!4)Fh`YoJ=~E;+=iPBjz;~T!wQVKdmG;veDL_t-&$P4=BD}uL&j1IhMc9Dz){I
zB93piFZjSw=2>f4+_Oq9FqnYQv*YgZCJt_T{17l47FEY0xU~B=bEPWDd+9eX52q_K
zlo=V5?a5v4Gn#1gYm#>Y<|&2vNCh{ohAFS9iLWP>qb!WGAE@T2NuURb3T*eN8z(zr
zndQsFRf1jlicZ+pTNJ(@k?~=IHa?3*e+iGuW*a8uo4x77{cK>q%YX4ZJ!piYbaJr?
zRu3q5aJlNY>OH00jF#lZQJ|l7-T+f$4=-wv_O+ap1v`Jd5nwz4d#l^PW%b-|J$-yi
zGY+|{4Sl<8nonsyxij<*dL;mn_{J1RK;O-mq^#q-iIMm5eOJWy?T(SkY#O}Rx;e-G
zGWf<f9`rk4(5$zxkm@R_-}X`QeX&0y|Kb3qHS)?mF^?3|j<S5?NsRmCGw5Wy!VCO0
zOcZea<HULl&b<uHYq8Yq{G@8GUn*=Pn30<Gl!pVsQ{~5Z%J)*ty3`L8Z@;>PpRbyf
zW~-S0W$<t<W))-k@#^iH*~2K~J5BltYQpv_Z9GZh>AEHtKgqXtir8G4mquk<I?+Nv
zzzj(i!_zU-L$UP=zv+%ld?`8HmzKNymOFj!8S4vi-6L2XM7p}jJ2VYM^Ce#?OZF;G
zl}r8ghSB}=370PMG2f{`#XUlWXdf^sYxM+ZSf}c&K<f}f*~QhJaOx4HbzBIrZK%!_
zz;0!dJ2W~KHC3Z`E-5Tw#ND;-ObdX$g#tz@CYU$nRaw~-)5I&D+~UmVR^reFP^+7B
zEK_-Jw?zftM(>ugWOI2uQhUowpT|#@kQ`!4C;Z+?Tg#)GlMRIus7me5&N%_6$m15#
zhkK<U6aL3WRRilt^YBZ(3T7T_C(;+!CrNxAh-Pm!T6P>i8PW^CxHD~00erAHl+;mt
zv#=5(T{FvnvUzqU3ZVGOU%BFHkwBO4$CP~_{EK8#?mX!DbY{k7>4__QXTA&!dpuln
z7C>M|Gxe2t?R+_!o>FI#GxlixQ>S*@DHB~lY%?iu1ff(P@~iIIeWPt(_bQbX>G1%9
z>k}0X1A(|X=t!U-928tf%<B)M_^+FjgPPhi(Uk?rF5oZTvQxEPH*D>W2r3t8w_Tf>
zBa7e}UN0zN^318wy>cI;7X7P1_7y&6RPL@m%8#Du1rkeqzvn=IC>OJ}R)B&a#A5@+
zJnk^VydJ8`U3^aDRcUe+R6bvD9OYKYAw@~;+L?lpEr1`1w-t9D9-gX^H8_wtXRE0+
zRSa}Y?hcJrL$c4iQw$i|P_mGlcOebLKG_V4-{YD6o91hJ^9xtG*?SY(ig)U2M=6Et
zbP%kkJw<u&LoG|2$jMbnol2RLjDgPPx@>u)DYHvyj?SHowT${iY0gTutck2qVsiqC
ziXWvR%0<U<iFmH!PWFgJd`Dw$jBu(J1z}olA&ioc_}4-2iH#<@MbK7PLo^NMP^zLs
z*vNoD975<E4jBX-3bM^6!Xe-q!l3LMxK(y69;zj*41)4W!?XhG$gaZ(BHXVoplskD
z_=O3W8(>Wk^d1_<7jTXh=R$HKLC{D#1a|-kWLr#|ZGJt#mY?n){I_xkYskTkEh24J
zyIvm;`a1I8(bsnQznMxrzbb!i^17On_WGHOXl^N5d7EaA-^lkHe_VId#%_^KF^c{6
X$o$6Zk8wQ6)|A1Du|B|x!Rr45KPvyg

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
index 49a9f32b..7c428495 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmVCWc4ACgkQ5L5TOfMo
-rnPh/wf+LAIyLbenqgpit5OPRZBhw/zWk3Wtl08328h1LJilI+ebJxtjYLlL8sQc
-NAkfN2f1RqRAoqhktxEMiWc9G4C7gqji1CTKTFLdALk+NaHPFA9z1E8nc+aUp58Y
-EXfmr0wWjKdMfyGzkDt+gX2QVGom5yN2uAe+rg/OeepuzvVMQtijOHsu4jKlDk4o
-lcuD8m+oRxCA4umPGQVNoeAhqTK+0MIAYQ8Igv6v/yk6bmYvd9CTCs16OrL1cFPm
-153kvq2agnmqLlB9Tl9yVApqkE0iinzWBBDuYuno+1I/tfs1k5AOmsxGa1CVVz45
-ZrYL1jovjWpW7VTiyKxIUlR2SHv22A==
-=B89Z
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmX+B5wACgkQ5L5TOfMo
+rnOyEQgAjcQdiUYTOecifIkRdvIotUmd0rYG4Y4atXIkcMKpuZXY3ipiIJQTi+zb
+fsTrrzqvfdS0FeG9GPePsgZwBvUCbvxbW+I2ffw4KXmZQh7J0WE3qYAEx3uV3IaE
+UtV6yM9OW6EEFuIwx8m2LQsl3bP6X/Cwgf3DEHlsVZzDexrYNU9lP/BkujpO0m/q
+s8PanPluQqesoaOm+DAQnceMC4r1jpfeZ3DShvyGqaNzB9HeOE2uQEfWW69cfkU9
+n3Lsqxjgl45EmKyNqqy5o3uMBwMJzl0jW2NR5k80+H65hv4Skclk6YCz651zx9C5
+bisCiEwf4gg7ffQPLYW9MCsK3yjTaQ==
+=vQEt
 -----END PGP SIGNATURE-----
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index 2717d54cfe69831e89143514eb28b2767aa71f41..4dcdca899694302a73f7886e2bf90fd7c0f99033 100644
GIT binary patch
delta 30631
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

delta 30633
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
Ns3%GXH~h3QrR9pM@RR@m

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index 9793fb43..dcd5a235 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmWm4Z0ACgkQ5L5TOfMo
-rnOnPAgAl9jY26pXhFO3qVTFhjdZMVU7YxmzX9RQqJz3pNHWo4hIRj6m2i2pY3lr
-zJYNO9jeQj/XeKdq5VikAwmZxverrHAlQQiFg0XLd+BEt4yeuq0QvcQAToCCd3mO
-OvgkfT87ePU2SOZ7/HT+Blz25qEyR4WnJgUonTsJeVPyfWbcOjXynqnDjhMRlp/r
-Fc06bGrnu5dXT0Bom8zJ3WPLTfxwDyf5AW4CxH5dDspfd7skCYM0vXHxtL0Rb0l7
-ycQ8XruNYMXz2zy9lR2COu3+yx/oEB+Skr6Bhsr2zBX7niqb6Zt7Yt1S21+W5Wge
-Vv5LBIfslMGAM3ZphlwuSepDwGvCUA==
-=5Znh
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmX9xsgACgkQ5L5TOfMo
+rnP2aQf/QBOiKUZsrVIbnn0+Ls84yDYovoesYriy1rbK+K5CVRb/0iqoFn5xKIu6
+bvyHN0fnj7Ko+oedNvcRCmlu+jiw08s3WArQb6r3fK4QT/2Wj2f+qX14uoFuCGUd
+QgZTc4hZxNxSZBbQuKVbtDmT0iFtV0jKBp/ajdYD9++rA+VcIemKtwX/sxEZnUFi
+fXg016uAs/Q9LQ5KWvz3VhFz2G77BEXjDIJNAHSVCxmWCvsd05kf1SbXUswlj/T8
+JtuH840zfZicZEk8e3grO4fSywLyrZCjqATSXa+XY63thCIglM9c6V+EBL3jGXxh
+Cs2tZH8/ge+tL/UBBJ8FdOZcVSpkeQ==
+=HHoV
 -----END PGP SIGNATURE-----
-- 
2.34.1


