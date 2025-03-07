Return-Path: <linux-kernel+bounces-551626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21256A56ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D36B1618D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB623F413;
	Fri,  7 Mar 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWDGzHy/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0B664C6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367692; cv=fail; b=hTN3aUCETIseRR3xRWjCdfuDtgszJT/E8hqo/j1H1P5jbzdDa61V3g5e5Q+1/SCMtimP0uXo8iqSZRWg0qDYXOnAs146pbLNfOVvX/MtElPoYV91+O1EDJau8JuRShiM0B4b8wav4gcvGP+3ssIEjn6n+V0sfg4p0VBJEeH7Sog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367692; c=relaxed/simple;
	bh=t7f/RlYRPVCMUU/wsXiSeGATL6WRjfVi2dezC1FIhFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqZ3jlgK/6UFOSVwwcuV19QIV9kVJ5vR1J7M9N+bhoQO9PcaPlITEwoC/NE5C1Z9oE4Iwc3pRNPEnqQJ8GCi3ru5SqO19EU1OOjuji0tyffGEjm9OCDqmJ+WjpyPdn4G0vzJOxvcWPxbesn2Jx+P7Vjniej/ccUw0kk2fWMzFy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWDGzHy/; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moKjeMTkPIVbcUXlgQw1rO4aeh4MonMhijyCQOHLb7N6lk/4QOC2w5rZoWq/wDDh/3Hg17zEyrCUb3WjKZEuSdtBMGOq5OU9mg4Scq6+veu73TndssvUh6lHEcQyS0TSex56q+4yRMarB6DZh+rkVntsqrlfH/JPh1CeQHOL/W2symhrYONWZ7MiRFTFbGjFYa2KUQhYd22rjJqqV/kSRS+1H/Kfc7O6WV7eXcKxoKg5v4RuEpzXoBXOCiU/WD4xNVOx3dvc5iMCcFQhosbLWHX5RGzgF23GlHjzlmHNAfdsPU7xB63veBiozC6GQ+rUsmYYdsCf+MzSzSmTcZBL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD/9KWzhBUio+CsOsSfGBRgjJEcuzPppXiPsaeqCyWw=;
 b=edAGKkB8k0QIiWY2gT+UELaQPOBjZ3k1naI64dwT+14WlRrN3NoFPL+naVmLniseXpVrWTde1AJp77Dk/WIALekw/PlAt1D03KprVmXSPGPN5/GUZu9bRnGnYm9+UZfy6hyIEjomNigP7jKizWWHCD8Yb+/JAL49+2oyQiTgl1qfOGaYNR84e9a+FpG56YB5VB7gcKD48XKvusZNHzLt9eOisKP+kGwAiQCP8zzjEn/N1c079Xa67SMJgGPh9J0/qNUL7WXwW5v1VxkhuaSAGnyjYMUZFfqJ2FZE8q8cuwMvTWdPoAUKXTnHmY94Za1EqO9xwC+YielK/k+C0aRIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD/9KWzhBUio+CsOsSfGBRgjJEcuzPppXiPsaeqCyWw=;
 b=HWDGzHy/TFCNUo8AyzWPno+LKsHDmTmUYcUrVTHLXtJ4qhLmVHr19UsvGkkGUin3JitubvuM2SIbWfhpAwj0/r5+sVRtpHbAN32mcQDYKFMgfAaAsyKBjBc1b2VbmoBj+HbhAvAnyI0+xYQ2i2aM+FYiimDOGwqCVyiRUWuuDWdYoqWEZTTD/y1coIQ4oQyweyKAsU39WU9rCtTK4C4e00pJcdBynJ8rVVoRFAxt8ohkbYHD28BBns1HeHGwX1mpP2GcefnH/KRGRL8aAB1OtNYLi2uWND+m2YJFf1VutjV2Fri4vohCTI7JZ8e5rwBDyK28DHchMpvG1qDi/3rP9w==
Received: from MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 17:14:45 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::fd) by MN2PR05CA0054.outlook.office365.com
 (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 17:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 17:14:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Mar 2025
 09:14:28 -0800
Received: from ttabi.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Mar
 2025 09:14:27 -0800
From: Timur Tabi <ttabi@nvidia.com>
To: Kees Cook <kees@kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, Jessica Yu <jeyu@redhat.com>,
	<binutils@sourceware.org>
Subject: [PATCH] elf: add remaining SHF_ flag macros
Date: Fri, 7 Mar 2025 11:14:17 -0600
Message-ID: <20250307171417.267488-1-ttabi@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 880ff62e-9e30-422a-ccc5-08dd5d9b8ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvKFeb7+CGIIE1V53dxdQ8nBPdy69pEJXem8nST6vMsI+XydYHM+4h3kbUgJ?=
 =?us-ascii?Q?++2kzqynSQQQDvwRkKAmYYrK9AXRaEX9VilvLNKc5v43UOC4jiZpBc80vHPZ?=
 =?us-ascii?Q?TdIAtAtQV1YnI0M1riUb+NJgVG32V/233sw4fdKVMx2dLR/j2fxuEPHK/5iw?=
 =?us-ascii?Q?gaGtEirsehAvucJa5iFQPG/4ePFdlAVuvDES1uUE9LuYEY1C8Z5T+BeRBumW?=
 =?us-ascii?Q?aXdZ8QXmFKzM5OfS55apyMBgoRxyx4gLX1kPhU1l94vfOpDrsz79WhF4ib0+?=
 =?us-ascii?Q?DpMnmv3v0d9GegtaunueBtuBm2pWI/H/gu7eQYPmHPGK2tvg0micsxkz6Sfe?=
 =?us-ascii?Q?3iIZJLrs8jUPA1khO5kKrNKhJp4zbvq4ybm08tRgj4M5qBUOLoRLh/Cv7Zki?=
 =?us-ascii?Q?1q6I8oCkupUh43iqqR2+dxTUy+rh12fPZfJM8EVY4GD7IJlqy+kqrhchxwYz?=
 =?us-ascii?Q?q57AWFa+qG3kj9eyen1XnIGjrbqT//RKJeswHFPejuXTjPKI/JCSu9Dh1Jxx?=
 =?us-ascii?Q?KdriMPtjjhc66koKDSEkHQMkLLOB0iU3isM68XjxsFbEnJKvS7CBy4HJzxSW?=
 =?us-ascii?Q?EnpdwhNUOYYmnZyOFwzSwEBVr02FUu5+yfNYwxIe2LD/ml4xKHzOIMfElov+?=
 =?us-ascii?Q?c6+0PULPzlr4Ho13m7JJhQcXmLw6arl5q5V8m46VawvbpcNODXNN29piWaYO?=
 =?us-ascii?Q?qziLICvjfeLfh+lFRS7X3yNnxBmMdGcHihsKLAE6KvMengIkeXP0/c9a9v4V?=
 =?us-ascii?Q?NziABMMdPrDHeuxzlsp/cxSY3DaOMam+RnVL/r/QOmkMtJeXXgMOmy5eahVo?=
 =?us-ascii?Q?oStNzPTGuzA0O5kQGS14p74hKYXEMy/d2rJpiRqyxaVDPMAMc4RTM0ohZdpX?=
 =?us-ascii?Q?bG1aafnfxwUEZWMji91KdpXL71Ij3IdDxo9mqHuwSdBRwDMO82s9RW0BFVXJ?=
 =?us-ascii?Q?UnDpxxVH6QXc/axNKc91kkyMPykTFSldwc64JNRkGLZv9hLS+3v+rx/19Kwn?=
 =?us-ascii?Q?VN5DE+NZugm3ATSqcs7GfC2LuZ44fznVAOST/4kdiru/7ju9SCi4B4rFWSyb?=
 =?us-ascii?Q?dBUEP6oLjScczRwGv8RZK+8NQ2A0PyV1jD/Shl7ljMMbL/pWjEuwCwZsdxqV?=
 =?us-ascii?Q?MJvx/0+oJ+fdj/tvNUyZ/J3KTGGHrNESDUr2ipdIlUKi4Epxvki+8V4i5EZq?=
 =?us-ascii?Q?gF6zS30XI2FNikdH4SsEg3BaHveUuPdT2tsvTAVoUOgUazyherHz/QFlf4lr?=
 =?us-ascii?Q?jDDIA1ylkJa9mGnb3Z1PRaqwgTmGMNb2umj6dUcgAMVwEy/Ae24t5CI3ILk2?=
 =?us-ascii?Q?LMW+BLMRPQuX1xZEmmP/8nfRdsvIa+0KpQdIt3t/xmyNSBgedtkU4KVuDfKk?=
 =?us-ascii?Q?vrUV1t0ym1VfeUKRXDYN8DocOuzvtWU7gJE1TFQAL7KDgwNfRvKfoCVV+5vH?=
 =?us-ascii?Q?1WvWMlWwcUzSeWg5bbaHIGmz67Xgf2kOtCSM5PVDg8D4D8jIbKrcfi1LNGTC?=
 =?us-ascii?Q?zbdaWOsKqZNPnHs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:14:45.2989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ff62e-9e30-422a-ccc5-08dd5d9b8ee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

Add the remaining SHF_ flags, as listed in the "Executable and
Linkable Format" Wikipedia page.  This allows drivers to load and
parse ELF images that use some of those flags.

In particular, an upcoming change to the Nouveau GPU driver will
use some of the flags.

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
---
 include/uapi/linux/elf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cec..6712c7a03596 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -291,8 +291,18 @@ typedef struct elf64_phdr {
 #define SHF_WRITE		0x1
 #define SHF_ALLOC		0x2
 #define SHF_EXECINSTR		0x4
+#define SHF_MERGE		0x10
+#define SHF_STRINGS		0x20
+#define SHF_INFO_LINK		0x40
+#define SHF_LINK_ORDER		0x80
+#define SHF_OS_NONCONFORMING	0x100
+#define SHF_GROUP		0x200
+#define SHF_TLS			0x400
 #define SHF_RELA_LIVEPATCH	0x00100000
 #define SHF_RO_AFTER_INIT	0x00200000
+#define SHF_ORDERED		0x04000000
+#define SHF_EXCLUDE		0x08000000
+#define SHF_MASKOS		0x0ff00000
 #define SHF_MASKPROC		0xf0000000
 
 /* special section indexes */

base-commit: 5734411ec9f9cb6dcd0b3c627ae16b3011e6f4fe
prerequisite-patch-id: c4ea9bb93e2edfc4788c70e5057e5170dbf42a57
prerequisite-patch-id: 5abbe49499a6629f6f4389e86456308022771cb6
-- 
2.43.0


