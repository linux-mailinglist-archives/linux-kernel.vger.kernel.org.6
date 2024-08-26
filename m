Return-Path: <linux-kernel+bounces-300708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2666D95E76E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0411C20B72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632FD2A1D8;
	Mon, 26 Aug 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YQAs0UWc"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010012.outbound.protection.outlook.com [52.101.128.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC495376E6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724644020; cv=fail; b=hxaOwf8MGuRxCqcXQG91pKDiLRlHFclLDf/zai3ESwcdyAWROteNuNG6y6V9HT83cir51QHi5ISJcZ7ptO0z7+hFGwdhm4ebbN3U/mfKDDf9oqfwcjr4TaeMzB0bsPOdfB50oJ1FsZXlIAoXrWAImLnt7xfO5Uw0vVcLme2u2zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724644020; c=relaxed/simple;
	bh=ykC8KbqC9yn4TnszGUfcMW4O5nEqxyhezAjxH5jWXv0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AKmOOxd+7bPUcFh0RP8aJdaUztwi1P6jj8IwIV10WzOrQCGYP2eUTB5JSDoJVeIDLMtnZckQGiaEpK3k6CMOS1B3o133rvl8KSi/zhP7149qaYtaEAA0XOmLFNUgETDlouhOP7O61/H8vbsNX9nzGGOXuGWBIVU6JQT4XEIEuWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YQAs0UWc; arc=fail smtp.client-ip=52.101.128.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfpW2PJYmf6n4qhGpiAERo4WE49uL1LBuORNZkxNSf8KQnk32OI9sppZ6Xmfc8FCj4fYr3gHEpAhJKVFH881qeJU7bDOOfnuz3MpaHrwfZ2AQK05eAjLCFMUeONXL3yit3vq0KSa7Oway6DKZf5aawBewaiYlgTVjI5sqlt5GL4G10FjwVDqNw8AlGbqEymRpgzaX3svbDs+j1RdOztx1yAeI03yLHRQkMOV9tyF+fAaYSFA3nQhbb6/pO2+Lm+rpAKIr3lK762rpVdyQ9Drsf2Gwi64HHM7aAK84Juo6CQ7U+BLWIFtrzR5r8qSwdULES0b1b7tVJRzAZxgjXXx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlX6DJoEvzWKmcHguM5McDJ/TMc0b6cr5MLvB1Rcjw8=;
 b=HyNZlDeLt16+4e200AX8LVvIm3p12kpnot74emLo2O73GPIHoOsMpwSQhfG1bYqoslNG5fLid+/eRTcVWvOAJlI9JaKRO0U2CmL8n6GkyuKQGB9NvxULMuiXpdrjCu2mMNf4jTFSMaGhukToFBV02tvZO44bd3SqH4mQ7v2HCLtxnBFi9dLLvoiVFNCWvMVuNE3RNdg7gAKp9g1lL4BUTBXaM6igWQH44BKrsc98VL2GDCiYt8RPIlzJpt/VxP4bRmT3i+pTt6/djwXxT6xYSZukZypHylc/hKv626+YvzRWr12DaBCxpU8SphVOlzIUvm1LdT2poNvJUEOQpBubnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlX6DJoEvzWKmcHguM5McDJ/TMc0b6cr5MLvB1Rcjw8=;
 b=YQAs0UWc3py8WoJ6cl/30rEr1exCCJcyEm1E0PtmgC1QjMlho94Yw+L7pxN9NeUD1qCUUs6BHHRHp2V5dx5T+G9YoyHKbDRE8Fve9hOEDimXVUwIFvbJIaxLOM1r5gm6P536pKO0XGPZV+3vd3Bnz6FeSLXwi7i5fET7VWRPddRaBFqjinnXXSK4TE4uHORZsabr1Y2Z2ogxCO0FxhIciBoLMBmMQ5l5FtvqlD9YuwbJcLtLxLlHoCJrRlrn+yONA6yde1msVmpXOLQse0PlCeFHxmoKw6MOf+hndr7X84vXwLVKxZty+u5wluc+ezT43GIBSXoj3N9/aetWOY/yKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by TY0PR06MB5260.apcprd06.prod.outlook.com
 (2603:1096:400:207::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 03:46:53 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 03:46:53 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chen Yufan <chenyufan@vivo.com>,
	Phil Auld <pauld@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3] x86/aperfmperf: Use time_after() for jiffies comparison
Date: Mon, 26 Aug 2024 11:45:36 +0800
Message-Id: <20240826034538.8225-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|TY0PR06MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fac6dae-ce4d-429c-d176-08dcc581b983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R9gMyOxx2RLhgUPFbPXMyYycvTO/IJ7Vgt/A0vGD63qVqnirtVNBOG439xez?=
 =?us-ascii?Q?717ekMbafIEnosQ2ea+5f94oSWCTc+bBSlItGak1LS3iFH/N/jqAROx8XYz4?=
 =?us-ascii?Q?2qt3vbf+PDmGJ5ticK/qFMxymVvALUgtqx8LZgDUkeqR5Qlqc7G+C8lWbYRe?=
 =?us-ascii?Q?DfEMvNziScCTL9Wt/UmqtPo87AgNjijB7gciUAxWIpRoMU/YynvykaPu4bLD?=
 =?us-ascii?Q?2pbzUd6XLrEIAYhkhE/QPH8CUhyBs5iBsVixDiVveHsZdoXYq0smqzpiz9c0?=
 =?us-ascii?Q?k6DA+2VU4m11zDwCTsxMH3DWgzTrGyw9iCnU45ABTlHOTbfOGOBA7XpXmSpo?=
 =?us-ascii?Q?/00KY/3s3x/6G+wVb1CDDDIzd3NVKMP3d1nRNsQ9ONNUGt4bfj53VL0crDOh?=
 =?us-ascii?Q?Tq11K5cU/NJ0IIR5aKlp3+BEeKy9qHiz3uYCgcqDiTGhaLCnGxfqrz2VwHjw?=
 =?us-ascii?Q?YxK0Y3ow8qRTUv6Rc1t87oi6IaluMkarDbz1wQHUD9mbJNHVJo9OIBcO1t1z?=
 =?us-ascii?Q?INoBL2D9hWtZ8AqZGMyKJioW8bCFnvLsXN8zLOKAR2ccfW/molL140PaqQga?=
 =?us-ascii?Q?Gy0dF+s7ItVf942Py94mCfqAMMj9ByQoHPtVZdka73vKUvq5Vtwt2rskg7XH?=
 =?us-ascii?Q?aVP3Ky1Vlum6sfWDqHeKOkWGCxSDjCJazi2tYBhbTcgFH6I3lCLdp7ois/jJ?=
 =?us-ascii?Q?TvuwaV6iHCex4ASyi5K9foErlQAdAeSnHSUeT6stdUbK+Al0Ykde0/wMVcAa?=
 =?us-ascii?Q?lNaOf/g/WdzJetksLaHTSpW2/JM4xhkRS/MNzoup/HS+3UhcmIfoIBEHIYj6?=
 =?us-ascii?Q?BvGWg8NNBbwXbxrQb8XwaRqF7slzu5DAmveDzvTYhXyP5sKccQatQ3dxROeE?=
 =?us-ascii?Q?zz0l6fdne5iiy5ESGRhxkvgh8yTL1P6JT4BwNSNMC+otWfmF0LfSI6lhU1dD?=
 =?us-ascii?Q?fJ4FOrUTEvIg0TymQw/vfGv3Dsv71JEoYTFwUsMRYC5MRiRXSc1b9e5pjChc?=
 =?us-ascii?Q?4g94VZhyUTb3uoU7rtCmJURVt64FTsjvpMy1cXUmkDJi/WWmwMmHleG2tvls?=
 =?us-ascii?Q?dSlNhDoey8c2JqTnsqo/NtVpoZyBpCAJsIeugBvyFD9B+nfSjkbCShSiLWlA?=
 =?us-ascii?Q?rwDBAvIWY5+osn2o4WDMho1Isq7oeWkWvXiO3byb9Ac2TQNPGhHnmgej2qNB?=
 =?us-ascii?Q?g52QioKhFJZFao96tiV33PmQnT1OtK7YPl8d/g2WLRsb9xqRvSalBYCmTeuI?=
 =?us-ascii?Q?XojOSvtOJLZGZv8UrZAF/PYUSLs4iaTOFy/X2XyIrx3CxtYDFCwgPDqTeKsd?=
 =?us-ascii?Q?0qk7T6CIgdBDL4gVq0FwXs8/o9APUJtUKCoZWsY5T7XlRgUjEQbGcykFRvXH?=
 =?us-ascii?Q?DsyomDbGYAtCWP/rv62hhMGfG/OtNwdGqfI4QomBssKXAE65Cwq2hoD2Y/VG?=
 =?us-ascii?Q?BkxzjHTvgR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6W5Qt/AVmwd2UdtmhoMoVLBT+LB5vj4seXwvncHweT5DHxenrdlLCmfEP4Mm?=
 =?us-ascii?Q?TGdRaU59j8FEasQcXrj37xTu2rcZriU54YZZeeLQBr8LoTzU/dgOE4XDw/mf?=
 =?us-ascii?Q?z0Tl22zMTNnEOIFwmKKBHBDty4eU2oGUNRl1Qwkrd5bfXs4UciPIZALu96b5?=
 =?us-ascii?Q?0XuVAbGUsVGALrWgbwICdAWAgvn+RiRMrN25DZOSgPDozE6I8f5SDnvZBan5?=
 =?us-ascii?Q?NVNlKS/UeHGckIsqbv9Uo2m4BcY8Ttewiqap9kcciX9KGj2pkJSeAvYiyxQE?=
 =?us-ascii?Q?KT2AhvmI7zmnWKOc+8lG3t0Xjtt3nWZm2cHU4FuNl73fu472iRd2WYAm3yvb?=
 =?us-ascii?Q?DK2bMTtascGsZalyla8aodpYFKliBZvJGXQffFpCBPSwiD81zmsEn5o8pKBF?=
 =?us-ascii?Q?VRHlijwq4QrY7jBQtOqzU2uxOnYLe8gNp/LouA0+chDpiKn+gJQUmXQydOWN?=
 =?us-ascii?Q?UlTPsDFyNWUl9CltU9xc+4ZJbIzcMBqcJIKjSshzrFgVgCj4O4qrwuEQ7cUP?=
 =?us-ascii?Q?g3B4JZ2bsQ30V2kKE9NWT23HUTiq/xJNM0yX2nZ0mmPHl9aTSEYvDXfcbyeM?=
 =?us-ascii?Q?GOBuQQzjjEonf/dOwyy/7ZGh9+8Njnii6PlL8pPvPI6CBra1YSfp9Htj5qG7?=
 =?us-ascii?Q?uu3HTat5d2JFoR4yRTXWJQ/7Rw5uo3M6hAxoFvB6Yqut44PJ6ig2MUdxb0PD?=
 =?us-ascii?Q?nzVe88iJr5cZXrTzOmoAAG7NvaPER2gNQe6dS9BXl2xgmYslF6IRkexBdAgq?=
 =?us-ascii?Q?IjFtVwI+CcwxwgkTX3P3F/hJo0jpi9uIl5J8ugEwN8EBu6/cMTDEHO4UEp8X?=
 =?us-ascii?Q?Owh6ay3ISkJhYGbAM26j+CZg4no5ju0zfYW6lr0N7abO6qz6is9f2B1pbLXk?=
 =?us-ascii?Q?jUb/1MMEM1awdxwUrVNCch19fL6Gs84TYHudwt5PHqNo0vEmc53PAqUs3mLA?=
 =?us-ascii?Q?xH5vr0WyrepatNEXwxlp+cgs8MMLTP0qpp86H2zXyqhSGpgnYF0/qJu8N1fw?=
 =?us-ascii?Q?d6h7brAfhbNB4kxXxKlBGybCasOtarLyEDH9AOoFb6Hhg+7uawRN0Uesl2yG?=
 =?us-ascii?Q?aFwxfesZfNmZ+CGuXRTjlBGQAGQeKnikPuy/5+Q11VRtNghgaV7xWXSs9xdL?=
 =?us-ascii?Q?G+Pc+rjzIfRYynonLJg+4xeG851QTu8aJo/sDc3LdZ6wgT5rQPaSCs04JJmY?=
 =?us-ascii?Q?0KVJNF0Y5vsVdyn+9To3ZbFxDrMHK25U01zGBFfU92R5qpThv/bIZ2IebgNf?=
 =?us-ascii?Q?2xWKKjxonGPr4L6DpYcYf69zdD8chvwOg4m7mhztTxZWPc1XioVcvP3L9be8?=
 =?us-ascii?Q?DcxaGwsaSOIQ1s+itevyBz63/OLQaovBE5kOtzUzp8FpwbvohNxpWFQ/cy4x?=
 =?us-ascii?Q?101sXYVO1NejN6T9R4PyrYvWDzjzmDY6FzoJHgpy44iELFxUFzV7PhzzDsKs?=
 =?us-ascii?Q?HKZbIth2pjo7/ttiq64XFY87BGuSESojCdCXl6w6bpxC95LnrHe+dCtnpayW?=
 =?us-ascii?Q?adOOgpRr2e9DbAtG1MqGw+mS3SJhBRmdNjlFsOmFKbY6HZkF+/tzKFAn5oSx?=
 =?us-ascii?Q?ICyTwdsZgvpv0logZpZ8cPx2xNyEwLaVNsSABvP9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fac6dae-ce4d-429c-d176-08dcc581b983
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 03:46:53.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFO/j8uIMRf0UjVIWqfQ23an/EbixiNPF0DW7U2RvGePDGXiE8NpJHqn9ZsGP0Qr+ixEkP22kN+D0KUbMIoF/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5260

Use time_after() instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Remove extra '+' in the header.
2. Change the subject and description for clarity.
---
 arch/x86/kernel/cpu/aperfmperf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 0b69bfbf345d..2772cc166b1b 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -16,6 +16,7 @@
 #include <linux/sched/topology.h>
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
+#include <linux/jiffies.h>
 
 #include <asm/cpu.h>
 #include <asm/cpu_device_id.h>
@@ -434,7 +435,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * Bail on invalid count and when the last update was too long ago,
 	 * which covers idle and NOHZ full CPUs.
 	 */
-	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
+	if (!mcnt || time_after(jiffies, last + MAX_SAMPLE_AGE))
 		goto fallback;
 
 	return div64_u64((cpu_khz * acnt), mcnt);
-- 
2.39.0


