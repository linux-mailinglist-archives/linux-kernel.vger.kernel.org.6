Return-Path: <linux-kernel+bounces-257130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648659375AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D571C21968
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5581AB1;
	Fri, 19 Jul 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V468xO5h"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EE80046
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381204; cv=fail; b=u/E9+YmtL+c5itei5DHu2isuAvuUkshrJ4jaZDIRnYWhWkNKuhkc64Keyvr+oS/C6mCAcigdJk7E5yiLCHJVVK/qqDdSiwpQ1tt6xajc7MF7whyrbUigg3R/mv8PENnanby3d3Dv5Ukfm2WxPaurUwt15bX0SAqap2hkCl3cdRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381204; c=relaxed/simple;
	bh=Qkx/8O/y0b6I+QWANUzkSVObQncFCJe1TMc+P8K+BJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sbidKt/9P6sopwkSsgJOTMGBbar+5rQD8zCZJo4z5Rn0vcgWalzpMkEUp6PWn/SuLNU5sGbw0ab/AUWhuoFZVVeEL9qJNWZcFpFZGLmV3VFRKhjCsU+kK45ouZStDr4944Utc+kOIoUqGhT+BiweLm/wYONX8wAKsOQgzuWHQiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V468xO5h; arc=fail smtp.client-ip=52.101.56.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnDqA/9LsD7sl/03d8l+36WDMu8QiL52JBjXJn7eMO7OOmBEzFYPvJWQbHuF61eHFVjZNYmvqcIcDyPltXVne41dpROn32Vc7yP6DC2SUH8X9BPrf5+WqW98GEwOT8mtPSpLyREkeUIX4W7J+gtVk0g9LjoeR8aCv2y4+3av7EHWd/kKZhIsi9nL4c0ztROHVxjbaP5qLCCOMp/7SvL9uz4olxOykdOyF3JhpjcXXUdIpyLKh+/559SvA+bExGpdWuAKZF0zwxEEGPICasVq13REG0GxW2G8MTcijy77t5GK5B6EkWS9jaoaO7/5GTuymmaphBf5zb0AAOQ5xekk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO5jWfWe8SP1yq06BBIRq3kKg26bQaaUNs3E9N+rH3g=;
 b=j4lFydl1VUyAdcjeH2qSSQcTPlobKXGrLT2lwpctZ9Rk0YpIl0qhtT8Fens38CD5x943jiPaKQ1eDizDAUrOrBRt6JbLaR3no6fM/q+V3BeiKgsvfRjtUVODnBCsGQicwVFmc4vObYPmV4uL6mOYT2GRDnKEs/d/waqN6+ob5d0tVh6Qfg5dh8umcp/NJmvcLKj6V3Xlw/U+9WskghontJP7wh93Iakrg/e/dHFJ81eyUp4CzDaX8HFzQ917zqYgXyDIbe3DU7egEBZqROhZ86DiIyejtIWpECrwZoW+H5IjuCcCJ7J21y1cqg0bGBzNASO1Ar//ti/ZPsks+gq2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO5jWfWe8SP1yq06BBIRq3kKg26bQaaUNs3E9N+rH3g=;
 b=V468xO5hS3mxwqbY1y6ew4xYb0o00slk757NWz7QVdq953vOxdq0U6UNm65hmk/Wj2to2s8urss0KgAf9Q4+gumwGgl/I2vPdSElZRy3s3uFZE2Jv/QNh6yK1XS9niCoHCNRqJsBCyi28dqry3T+n1CfObgU+RegflGdWDpPbS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 BY1PR01MB9091.prod.exchangelabs.com (2603:10b6:a03:5b0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Fri, 19 Jul 2024 09:26:38 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 09:26:38 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org,
	suzuki.poulose@arm.com
Cc: acme@redhat.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	darren@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm if address continuity is broken
Date: Fri, 19 Jul 2024 02:26:19 -0700
Message-Id: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:5a::29) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|BY1PR01MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fb2fb2-2fba-4e3b-e8a4-08dca7d4e452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrPNK0nHxgxgB1rRZcuGcxWgdWhI/zwFIjI2erWZo2ps+fGlUTnAR53FY5XF?=
 =?us-ascii?Q?8C25JT+vMFVnXO4oYUScnrt+L98cYI0g+9UmdVvq5qsz8VGplJGL4t0Df1ce?=
 =?us-ascii?Q?r0Rgb3o63brTBEVV8Jvt3u5l4fD1WErkyYuoqSMlQp177suEmUV5GDBljBqq?=
 =?us-ascii?Q?mJlce1dpO8mIqrsEwg5b0fMWL2MnBHFcDtyUK3VfTB43+A7+YxK7QRp3g4tW?=
 =?us-ascii?Q?dY/cAG4MMdmhuDk3nB8Ztmy68aY8pCsNng51UEBPs4u6Bh84bfD44HgRXT+u?=
 =?us-ascii?Q?pqWvBFB4S4kCLy4c0l83Jj92D6WCiPG+bmIumdzUE7i0V30xPu07NNvbrqCO?=
 =?us-ascii?Q?3MJB7fQ2ze1RS/dGaZWwsREJ7DR3jxtdv+DBUJ5RYsw/QIl5HqME0bep4EJu?=
 =?us-ascii?Q?N0kO+/o9xT8cy0j5eYM1W6O1tiPWIq0wK9JS2cixW5tfxTvbY3uJw16q+pem?=
 =?us-ascii?Q?O6bdtHNpnPXIcx8DJUvSUAbIvww+6WohT+xY+r8NY/U9Kbf5BVxo1MG79qaT?=
 =?us-ascii?Q?KvIgfwdZBNNGxkmaYsKPqGSfLsnXRdIJh3X3vhz2FwF1An3fGrihtqdf5iXE?=
 =?us-ascii?Q?gMox9e54W32AKN4W0qNHZENaXk91cYh0wTGpK2jXX0DLL46eu0EeBN5QTB0t?=
 =?us-ascii?Q?TGMs4V1hqHIrRHeeBoyOC28PZZHeACXTMIbiLgGvCcGnNsWJcvjYZy/q4wc/?=
 =?us-ascii?Q?u1WVuYKJUYNGAV4CWeJjI7rAjdp44aijf8sQF2aMurfpIT9+FtewK1UV5IQF?=
 =?us-ascii?Q?5M8rPnJxI279oqJHaRRp9Z5ND7BtQ/XPA8tswcZoOUrsKwXuJdmB8VnqNEDI?=
 =?us-ascii?Q?k7q4HTCd6K6/e/wyDtxCCcsib+Y989ZY+ufAYjlFCNpFW/lmPl58oixVIHSl?=
 =?us-ascii?Q?B5dyPa8Z4Xkt2st071RgtWaiIlplxT/5T233rUK+n/k7TG7QO8Sy74YJkGFa?=
 =?us-ascii?Q?imU3l4PxMzsN4n58SiOTa9+YEG20qDWmnX/W9mx89x8DWM4Otkc7mcmjTKvC?=
 =?us-ascii?Q?kSL8/IlPSx6FYJDdkNaAuYQ1EDGeF6GbHCNY2/T53EKfM46oEiKrmEFr+rfz?=
 =?us-ascii?Q?Wv4rA0Sqq2rlbEeR/Hp/qPsZIPPR9OLh4pfhFLLB086lZWEhsjNlHK2FePIc?=
 =?us-ascii?Q?YE4qxo5G240ZSvxGdO7ISkR/UtdRb51YIfPOxqMJ4ss9R6OLi69nOi94i2GP?=
 =?us-ascii?Q?c/To2RB8Xrd8HDrmb8NRin2QMRAfi+enGPVDO75WMOzqRfpLaDk1hxhiz5A4?=
 =?us-ascii?Q?9UlA/dDviXDKTguDeKdzQfqPOpI1JFLCZVkFvijh2XxNCAx3pXBa9V/ns8HU?=
 =?us-ascii?Q?lYVi9AdMSprZQ4eEweUF/M1GTqO1jwPh6Ysk9VCRoOvJyYLyWJnv1th/VOyY?=
 =?us-ascii?Q?dvXcrvV5AftX6GPO88CiwXk2OrStonl8nNuDgxqEOfuHbE1+tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHUQP4VpObPn4HZUKBJWEA8kj6r55jMbmON4ogpXfs+FrTHEjBgy9RdOhi5f?=
 =?us-ascii?Q?cVm5su12p0fmqCtz25I+0KWmKacNum6f6ElhDj0GuUvkHmRyw8QL6mxmlulZ?=
 =?us-ascii?Q?Oio0K601d2hLPYM4Xke8L47ntMz0Mh78ktsO1F9v9re7n1XTMOuDW6GhqRMT?=
 =?us-ascii?Q?gMh4cwwvsQUxaW1xCuh0pFv1z/Y1Lhdeq3DP7IyAfr0vfTdsDIUKUDiZ8tl+?=
 =?us-ascii?Q?vK+887yUg1sssldrNPT8KdsqRlijj7V0vWLHSdBGoYLRxviuO5RiGEf9aa33?=
 =?us-ascii?Q?Cqa/HXRx5LHMJI6ikpp7gFKjKd3/iuEjjRGxqkmmHOEYzKPF72plJp0qoHGH?=
 =?us-ascii?Q?pplwvAv5oV0y+Kmq9yT7L2Za1E7KSZJLezXyL2AK14KYPqB/+lt3bPI+rQTc?=
 =?us-ascii?Q?sml/JMQdBE7JljkfCWwSdwRGROx8Z7EQkIWXYa+RKEoILZhdLiM4WEFlmFwZ?=
 =?us-ascii?Q?5fM+vJUKiJ7nt2RbrkvHIpHw+uBSjr9PFbRdxQjSD040c5b4Q6klqMKqhBr9?=
 =?us-ascii?Q?7ulkILZtC7GyVNcbQDFEcFwbgmqHlKR46kBSSDdjENjSlcx2CtyLX5hmYCD5?=
 =?us-ascii?Q?OPhHC0YCDCQN51RxqAO7d9piiINmXYtTWEdelknVV3Pb8CJQWNxrnoD+abxB?=
 =?us-ascii?Q?/5gfAQU2ygrdxnCDg7b9A4IXnqCbroiesAoAOrD5IF9YOXT/59AG/grWBq/q?=
 =?us-ascii?Q?8hbu7X5NK3j/YA/cDDTEYnxekCyZgVX49frQQdEGQs4v3ddzKqhvD2rgPT90?=
 =?us-ascii?Q?uaEb0LA4BxuUJU7vXj21MnPZnvMS7PLL56XOnbSC2fQmDWXgxxIbrFOFCFgw?=
 =?us-ascii?Q?I/AiHYLpP8igIFyihovDthaYzL0zT2DrEH7Mu88+FCE1UNE3dr1ThlQcWMAt?=
 =?us-ascii?Q?azm8bX67IA4O3khEEgXAglpph/sOPcKX5XdiyyT8TX6dROUx0+C6PH71jJmm?=
 =?us-ascii?Q?yQMzsV5opKLxdCFi/SsodBH2EmhRVhGIj4C1gPOZa0lOR0ABH58sLfHpEgpR?=
 =?us-ascii?Q?4H8LXNnk8uby1jgMQvrVskcxbjvYEjJJF/D9+MuYjsJHvrbXKD8kAf3oXjIG?=
 =?us-ascii?Q?7fbVUCJ9953wZvWIeQ8XzfvNlJUAHrIp3D8kZZGMomkEH1tJCtU4gVJsPA8n?=
 =?us-ascii?Q?qTHICZlBmC6hSnqY2BUbDgKaRmPE8tbW2cGqt6sInAMNPeFCnocKtWC1zLit?=
 =?us-ascii?Q?otnRIdK9oz8E1heUdRFj5Kc/p1p2cL7sg3uZ4qAUm11jTVayFa681zVSYSnP?=
 =?us-ascii?Q?mQYrEZd9JoGZfK577Bm/K2l4mbGY1EGO7UnWfFSqkYxFeIEx4AS44/leOucE?=
 =?us-ascii?Q?ZwUWoniYdKdWTh2wcPpa5ci8yogQuNfmsRzxHBLVSpi46/N8ES/LS4LCHFQj?=
 =?us-ascii?Q?04FtEixDuwA2zd4NnioEXDqpF1j4fBzK3Og2ILuMxijRGmPWAq/OhQxQFuIm?=
 =?us-ascii?Q?5LeSSG4POMkH3RZtLnvXTrWUmOwrz3t+GyMbwBl7+jY5DGzRB5s1CHNpPfHF?=
 =?us-ascii?Q?zv0P5vkhZSqjxxWoahaa+ZleWsXZp2Pw+bRmc48Nhu7tvN62tmK+qcZA1vpm?=
 =?us-ascii?Q?fdkrtUGHettkG+ybqYrhoMl+AwldspFlp1QcK0tDh88aOdOOMPJaszkP8in1?=
 =?us-ascii?Q?vQq/Gy0BWaoSbqIJeJjNZwI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fb2fb2-2fba-4e3b-e8a4-08dca7d4e452
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:26:38.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFwrMkncnkgtyBG7AaYwT2na3uPNm5JV0zRG9XJYqpGgjxCy6ZzYHTjFDTAA1sqdVmQXRJpkpbg2RNBthrIX0TfC86G9pvIpbBJxKthWRV3itwRrI3bTz8azO3JoF3g5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB9091

To generate the instruction tracing, script uses 2 contiguous packets
address range. If there a continuity brake due to discontiguous branch
address, it is required to reset the tracing and start tracing with the
new set of contiguous packets.

Adding change to identify the break and complete the remaining tracing
of current packets and restart tracing from new set of packets, if
continuity is established.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..ad10cee2c35e 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -198,6 +198,10 @@ def process_event(param_dict):
 		cpu_data[str(cpu) + 'addr'] = addr
 		return
 
+	if (cpu_data.get(str(cpu) + 'ip') == None):
+		cpu_data[str(cpu) + 'ip'] = ip
+
+	prev_ip = cpu_data[str(cpu) + 'ip']
 
 	if (options.verbose == True):
 		print("Event type: %s" % name)
@@ -243,12 +247,18 @@ def process_event(param_dict):
 
 	# Record for previous sample packet
 	cpu_data[str(cpu) + 'addr'] = addr
+	cpu_data[str(cpu) + 'ip'] = stop_addr
 
 	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
 	if (start_addr == 0 and stop_addr == 4):
 		print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
 		return
 
+	if (stop_addr < start_addr):
+		# Continuity of the Packets broken, set start_addr to previous
+		# packet ip to complete the remaining tracing of the address range.
+		start_addr = prev_ip
+
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
 		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
 		return
-- 
2.45.2


