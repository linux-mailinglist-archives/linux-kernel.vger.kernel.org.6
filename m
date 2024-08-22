Return-Path: <linux-kernel+bounces-296890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B700F95B034
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1783CB24A90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319916EBED;
	Thu, 22 Aug 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Gj4Zcwsb"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010013.outbound.protection.outlook.com [52.101.128.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506016F271
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315110; cv=fail; b=LThqLv6bw//Ths+mMkw4+vH7H2c3OTd+OQzSIffpbq1qe9s3KYgh5p6xmUFITWXur8z1VHNYTATB0T0jvC9TJHf20ms4AZBYOQpiIIHJvDa710WtPaIDoX6MQ2TMdcQZKgiNTHsoR3xXDrx+RKhFAFOmYNSUu3SHWzsUZxPfDf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315110; c=relaxed/simple;
	bh=lbc+QeZKxcAdEAvly9oyzv4/WK7CZGTgnDqebQPIuho=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A8aZqeV+KpEuGkfE5bC5Zb7/3flpUTGd7ogVVN/DMubwknIZc9lzY3P5a/hMs3n28Gc0NosgkXUxIcYttPrpe1xi9dZZJoqHTKDsJW4hL7jwgX1FJ2PsHU56n1uQ+Hoby2+lI10zT21Dn/O5KiZLE91AUaDqDzSQFTRr7ZBnPc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Gj4Zcwsb; arc=fail smtp.client-ip=52.101.128.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHGJeoqfFSheXoypYxpKUYAXAo6LdS+4kY/FyA9FPq5RW08G26ACbsEIlLbnbXiwDW9uqepGCwQ9CcdD2rT3IM9nbitlgkXV40BRDKo4Al3eV5ABYEN9hNlZbeABUNlORSC272dHQz0mgoQIeqXaaZKKz3LCnwUMXyARD3ZDz1n1kI3a/nEw3NfA2E6/S09899DipxhYVNfQKeDGX3gudv1oiWWDxNMsux+n9rgoxCL01CMBt3jgyPJb6WkYd2XQkdHApc6CDFA1ob35b2IIDGjopLogf/yW2xFqsBWG+6Jyd3GhORj3WcO5LvfZWQb0iOsYYDmjfj/9LJSlWJnMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm2gr2/DopkgsiADqGD5hVqBdyoSL/jihrQzsg6kaOc=;
 b=ea/PyCidajtswH4HjjlI17wGVEcnKzvjNEBGZsLNoPdebIYG9khroR8h39YVOXsyK+te9ALXvpc8Ka/xiam+lawYbDOe/8InWFLxvlJZ4hVQsBU4To7TD9MRHBqHr9/xlO3ksIQZRHiJq2RrQbS+OkRewIU6/UXvqHcmY1ycuc4HGdtU7zqlJEXuZYoJgKEdCx27lqQGA/PIuM4S4U9P01GXqCdl5vFFRARJ9JQxzHRJmfXvtQanxF5q7z/iKVEqDDFDYRcSvl+5DhDgLRo+wslm2aJuUNyx04KoJqCQmj1t5LI+L+Pfe6M2LwdLJftMLMv/jmqXVj7oQBElFsmMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm2gr2/DopkgsiADqGD5hVqBdyoSL/jihrQzsg6kaOc=;
 b=Gj4ZcwsbtN7L2hld26nmtVxUHpXlp4m13UGfq9tEURK94BgF4Bn3te7sfjMUeVh19SRf1HVRWMlZ2SVH1xnx6JCS7qV0NaCUQexuubF7CGUlDHUciheiLWRRwOtO9nf40OYn3HKEwCCld6MNFN8iM6kQHTcHFW1l44G2pdWohOeTZOR+uOKGZFCmSVqFLjA5PCT6Jt/77joqNV8emHEd18BuMpzD5uxxGBaZ7BkK6GHIqdJ9ngpwhBJAR/z/H7NLnIxhrfel3d8dgrnzGk8LTchiMfI12ipso1vc61EOtGk6shyx3i7y+GQwb289enud1b3HZxFVwzGw1nFP2kcZPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by SEZPR06MB5991.apcprd06.prod.outlook.com
 (2603:1096:101:e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 08:25:01 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 08:25:01 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chen Yufan <chenyufan@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] X86 architecture (32-bit and 64-bit): Convert to use jiffies macro
Date: Thu, 22 Aug 2024 16:24:49 +0800
Message-Id: <20240822082449.34601-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:3::25) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|SEZPR06MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e92f5b-d11c-405e-daeb-08dcc283eacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?opa14K1nEZOhq+UShCU4t1QM+sDIuRzJd+halcNd/0aN72YE8G+Ebw8ReiWF?=
 =?us-ascii?Q?4+li9PMYapIC6CSQUhGMhZ/6gposCyuzRwVceJGppXsy7WvBa28QL+BDXGdD?=
 =?us-ascii?Q?Ax3KxqRQFRmdN05V0ka6d6022AMEANYsbdXTOigrbz0UGdtj7Oww/tkxG5hL?=
 =?us-ascii?Q?Rie3HBSZef705amz47tOu7LaODE0z3vvfTcS7f/QiaD7xtv9ByAzYqMIZamy?=
 =?us-ascii?Q?s7zYs+n457HePQ42aCZvI7AVlMQE5LPXOm2Ks2dhLgQww1yNNpCQysr8+nrd?=
 =?us-ascii?Q?cHnj35cFJEkGO5n9lujeVHHpfI0uvj6QgrVapSXLBH+qs7On/cTyAV33rISJ?=
 =?us-ascii?Q?IO/wkIANid0YfxDT+5POS4DpgZtTKZRLE+ip2knwUC9+0XBqnEpIMJ8yekKP?=
 =?us-ascii?Q?q75aMx/oNF6QKtufo4REGQrwFe+B/gzmAaQi7vNzmmOG1m77OsYvqsDr/uzz?=
 =?us-ascii?Q?5fxoG6VVYhSo+LTt4Wn6q4WYihc2JJmNGN417HdtBvm1KYnzrrZyN16GcUNI?=
 =?us-ascii?Q?CuzPI6wsmz+4Bfc9DUpp9rjlnCh+1L7zqIvR58n05VbD2dpc1sKDL6KX0ht6?=
 =?us-ascii?Q?OvDlPZaFD2rDcj3Uv1ppzLu22MCZJ/IgapST2jXTr8QnIu1UPJ9UhISAiUAo?=
 =?us-ascii?Q?usknP2pTyC9Xt6tgPnQ6O3bx6SSoayRCLDKomf+MWyvFHtgYkHlHs6ynJ12K?=
 =?us-ascii?Q?30Ovt0tO/WdjIXnMB6sKtp/mB6rAoZn7gDEFzUoLrs7BBDCNiSFLBQy+buBs?=
 =?us-ascii?Q?pG9qu/07n8w8YBLCfP5YaHlpGoK9PrhflxLNIDi/403ZYpFpv6ntwHNbyTnD?=
 =?us-ascii?Q?onI2UBPoliG9ijSVU59a8WcEO9SzvQU/QtPCdB99gHb/DZKzcDEULVfM1mfL?=
 =?us-ascii?Q?MkH78r7ja1ii7FBFXpYvPyN2kJZ/0gd89nWx/B9rKLfjRSZY46fTBvxd2hfI?=
 =?us-ascii?Q?odAhfaf3b8VYs6Vw1gvjTd2dfihZwRrw3qVCvoy4A+cZxapcuerkZbSq03+t?=
 =?us-ascii?Q?z+Zf4sBE3vxxgvvYcQUme1V8GRbSbSEI9mQZLV62xoqIbK18F3TYbhEdCmPz?=
 =?us-ascii?Q?UkFdn4fOL48WN1X9KPfUI0b61agacvzD0YL3VmZ4jmzm5HmVGZlmas7R4+Y9?=
 =?us-ascii?Q?QPaVL/n2Qqkq4yg/Fv99ZrRxFpIFJc3y7M7RX+8FItt6PhBZ01sqQtFC250m?=
 =?us-ascii?Q?swDYOVyFRMGgO22fQpTHLAKnJqRlvv6D/hTHdoPrNwVn2uYuq64i6912PrI5?=
 =?us-ascii?Q?9+XwGDqTpuqmYu3f92IzXHtO9+0ZoHk+znU80woERbIZq5/RWTM1GKS6faDA?=
 =?us-ascii?Q?KO5F6mZGSGeldGNpW0jxQebc6hiFkgQvMPhhUNzp8BplfbAqEkBcxvG2G1IE?=
 =?us-ascii?Q?ufsGqcKgbilmaYccRNVBMcsn19WeTIRItqvLs9wSIOZfqH0rTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16mTe+AJctNZjlT81D2DLCVN9PmWub0qyI7hJ4awSlnPL49yrX2t1fG92Gej?=
 =?us-ascii?Q?bkol9DRB/KUU1dlkulQ0Ghwx6IQAMxQvF4PnBA/JggxWpgTcNaSK4uXxBpJt?=
 =?us-ascii?Q?Aui10yIMeV+mUu9rQ49+UspynLuPU9zzMxZdC4XA72TgqRB57fnDlNqJ6PKf?=
 =?us-ascii?Q?qTjBJX96vMuYrE8FqQT+dQALXMe42CiD0J74IX9sahPWkAncM322KH8YTGpK?=
 =?us-ascii?Q?NBXbbHD5FVP6ZOSQhx5YLGmY9+xwBNJee/X8alEDr52Ntx0OJLfTzQaehSVo?=
 =?us-ascii?Q?3XIAIAdPaV83ktKwXLLLZULamfwwc3XJcD6C5qzjknA1M6uiRKUZarH/QEo4?=
 =?us-ascii?Q?0Bm8xqN+Zqu9ibz3QR4DpsPgmpuYk96lobNP2shAOKOdLvRq8FvUXq00r/4Z?=
 =?us-ascii?Q?n5HVZAr9tez+0dfM/vBVlmLzk10zbXVZEwTGjUt0/BC93Hm/7hIQhq74C11X?=
 =?us-ascii?Q?vP1m1ONE2jxmE+o++CFiWOxnqSwuSHJK0lwaXISardfpwIEZB/31bjbQqMdm?=
 =?us-ascii?Q?R7vhS85ERB8cIefiuBMXcVAFm75KVL7PZbDypTxMXLM+906eD5WdCUGN6TW4?=
 =?us-ascii?Q?YLbpzm4QEIroUFvGkOLKYXjGMaI5P+9C/NzAqzZZ9UD9+KjFrq2XMnKjJudd?=
 =?us-ascii?Q?QHAfg/rojyOCDkEhgNKltGyA5lOMDLlQROKtIK486Huc9tu0bmvij1+APbtT?=
 =?us-ascii?Q?bJTdpyDfQ9CgBx+rFIGlokiv//BU1jqg38nOWKlax+t2C+JOY762jWaibOru?=
 =?us-ascii?Q?FCeIyUWAiQB8VMyA3ST/XfJaXMUTx0Kd4HQjjRe/SxxO18Feif2MYlEATsUJ?=
 =?us-ascii?Q?rENQXRsS+N20cB1Ykoc6ZEKZCvdkPQGqzfZC7w1O56UR3fUF8Da5zQWFNKWL?=
 =?us-ascii?Q?BoUxemlSn+afK97cDXZuzUnKUPDnhtJ1bT8dpDVX80RrlIZAg2ZdlYx7BwLF?=
 =?us-ascii?Q?ecmtPkms/1T6JMI6V5EPXh1z3/uLY0Sh5KHITLyKBxSm1eMMETa5tiSYxGxG?=
 =?us-ascii?Q?x/IfKTP1KUPbHXijd3eciJYCesBUqszfZz/V5iuLAzhB5vLozUUYnFdtdNbh?=
 =?us-ascii?Q?4qRuoKADSC82iqLFmErxFZOgy3yw+Vv5RPNThQnV5cULCJkfaQ4qSSuqndnB?=
 =?us-ascii?Q?ejzUeclj/JZ7BR2/HpA8ZpRMJmKBnwuBUz+b9Qyc50VvMmyz/ENs1petF8sm?=
 =?us-ascii?Q?B8YuAbkMQ6lJjqabUbWGf5Ia0SogNu1vNrTbztxk7W9tWDdgoQsEzZYjmtd5?=
 =?us-ascii?Q?9YiZMvdFH7CQQRCWgjuRb+nBNtYR0yAIBmQ6coIQXtPD5heg5N0dbHffxbpt?=
 =?us-ascii?Q?u2MkPcNwGo+1eexd16lx3e5KyZhXXDSNSabRgG4HJ8RPSk7gGbEg6b7dktgV?=
 =?us-ascii?Q?HbjsX9uJc+OsB15uT6xmHV1CCEOBLfYsYvaGOyg4d8QWIgd71s/cSQx0EDAb?=
 =?us-ascii?Q?toe41oJ2u43q72/6793CxmRYxkj1IZBghP6o728tP0JsMPyotolEDQKlMo8K?=
 =?us-ascii?Q?1jxkAm+V8a0b2cQpK3/OCZY19Am2K77M/eWmM7W9BW7D24dNQ0KR4AHT0N6u?=
 =?us-ascii?Q?oA72eG99a+DWbCB6jYXM//Q9RXK79ecBtNnCZQHq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e92f5b-d11c-405e-daeb-08dcc283eacd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 08:25:01.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 524VUdR1CV8ArKMZRF2C+yCAU0+YK2SAYs6ZeRMcgbzvuqcQKhNWx+7W0HCvQyQMw7cjajTlKK4MvcqSgiqo3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5991

Use time_after macro instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>

The modifications made compared to the previous version are as follows:
1. Remove extra '+' in the header.
---
 arch/x86/kernel/cpu/aperfmperf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 0b69bfbf3..5fe0a7576 100644
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


