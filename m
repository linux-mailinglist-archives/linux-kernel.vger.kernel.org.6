Return-Path: <linux-kernel+bounces-261731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2566493BB69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999671F2244A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBC1C2A8;
	Thu, 25 Jul 2024 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FGRh59b+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2781758F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880779; cv=fail; b=CrVK9DzGZvD/RHxCVauQ8SIoJcc2/S8fOmj3u+iNIY6Ru0RU4MGrEKtBZMADip84VF3A7mN7xV0oMbZoZsl6UDePZlxYoAQoFjisk/W+i1JcjrrRjGfdENibRB183H79kiQyg/XigE3+Mjd/JSB5aHIEY/2o2VpuEKiXOMzlDDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880779; c=relaxed/simple;
	bh=EEfGURLq3A73w4wjZxsCkDDUatM4DaODwYERmKAtAmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMS55x5zlWnytba5kotrlzY2Tud1PL/WqTU3cj78LFc3AhyX1F0aSNAmyQCh+1CjSwbLsQjo4kUfq0WiZBdhrZv15yfFVRSO+J9PqH+VK/tmwAVtuRRMJ0aPvf6KGe9HLDx3ZE9be5J9bQANcrTImYWVHJKxzsD8fieKhDmZNW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=FGRh59b+; arc=fail smtp.client-ip=40.107.20.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjYeGgqVVknY83qDhfJztB7aX1q1TsRpQ/dnCWMbjloBKxBGdJf/PNXS29/N/Ex7HN+2Jok+g8BqlLun6f9p2sMlsm8NtdcfFTKiok6fEPmsbViIU3uwwrzSwE6Fb0oCAT7faNioo3d/h9Cvu80tsN99cmraupECN+vOKa1y8KiLXJoOksrJkyJTuXbI7L18y+QsarS1DTmiOTf6Bomx/SxWK+b/cwQxG0Qd9tfSBJuaCSmMQFmcITkN7ezNapbKIbVO0JuyqXbiSvLTbXi1j8DD6/ygGZoHGpqnPs4YTzmOAq5qcADCrWZxcnf5L9gl2P9srfSjI2N4EVkam7Bbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ5WMSht9pnuYA9USKKPw6l+2nuxyVN650Djl8xFZMA=;
 b=ckJeOndk/1RPGQXLYK3Wi6mNVS4dLIgX8KWGx7edabKeZSwiVmQlyHkD2H86u5H/xA8iKugEbsqqm6NqSEtyIxNEKxUWGVB2P9QY8VoWahgL6hOGfr2a4iEPcRbcMnMmPX0yvAjx9DIMv044hQvfgG4RiADXucdRRB/oLLBtQ1Hqh0cQRbjeHp14D3f7Ra3JPzNIEUjItcBJpG/nmvei45FzX95ibrHJmCiEsoIs+iOFkLaCFlDc69rVd2rcsDyayILhoyhXWw+GyjOIsTSl2u69UEtfpcMYcfFjduCnnGLYW/OgZtlF0E2H6DhngsLVnptJ++LixJGgD5Q8j3/Ghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ5WMSht9pnuYA9USKKPw6l+2nuxyVN650Djl8xFZMA=;
 b=FGRh59b+/moQZ6oY3eSFHRcPPo61N5K4g8fgMltdbcJ8YACt579X1vCcTr5ihpS3kMRrcStl1pm4tkyNJQuADBwEplQZ40ABEd59pVm7PoGDFaMwArunCdZ/uA7s2ZLAp7RAoyHCD6uX90xStttYji3YnZy4OKi2QCYlfgoZheRLY1H7NPibdZBmepRJjYPMB1Wv4adcIjg7cfWz/qpJvAv6IoDJ4SC0qgRO8Lg3qKwaDPccsrnozwLCokCNKsZxr3DUXXbAEWpgbiRG8FU3dVPCzCQ0dx8Q84mqxdiyyYIF5bbav63eHka+RmuZ5BJHOEZq2ZSKTSu5SlDpqSFk4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU0PR08MB8788.eurprd08.prod.outlook.com (2603:10a6:10:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 04:12:52 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.7762.027; Thu, 25 Jul 2024
 04:12:52 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	kernel@openvz.org
Subject: [PATCH 1/2] kmemleak: enable tracking for percpu pointers
Date: Thu, 25 Jul 2024 12:12:15 +0800
Message-ID: <20240725041223.872472-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
References: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:820:f::8) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU0PR08MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 001a2add-00c6-469f-c5b9-08dcac600d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dDv+DIdPw40ltt4zKI29nObljxYKLGOEn5wAFGS4bsPY8KiOqiv/ocpHJzu?=
 =?us-ascii?Q?Ke82ZxRz10bemaK9Odn40+wIWjDbxpYMHiY6c5L3nh53I7ENBzSqA36IjYdC?=
 =?us-ascii?Q?PZCLkU9oNsIkDvr8RExbeC1uK6Ei3GuwJruC2iPYMElTYCYZ+7AlibiaB88B?=
 =?us-ascii?Q?GdpesZW9YcEaCv9Wc+5JOoPjBZb07eeC3GZRK4sqdIsjBOIq5hPHFaAiWPrV?=
 =?us-ascii?Q?j55Yr1q8hy8z3UR8UZA+caclxBftW16Jd9HQRybTmvWgFbIhtm6MlDFXnEf1?=
 =?us-ascii?Q?A+uRGdR980O70M3lG6Aa9c1hhRCArz77uf3uopBjeSGRE3auYXra49Keo6gZ?=
 =?us-ascii?Q?JCN+DmTKuGk9rjHAAi3azwbpGc5XvYoxGOgJvjFaz9fupvKASos+mNXvKmku?=
 =?us-ascii?Q?ratmpB9N9/z9GCf64mgUoZS8bYjx3dUxUtZdkwDrHnzvPQMijvxdD6h5ToIQ?=
 =?us-ascii?Q?gIxuO2D74qW7AmQDJcbiCStdzD8P3gU6UKmZlTjz+AfH/Ay+zDt6ilOGKfdO?=
 =?us-ascii?Q?dGGlwbKuUkHSohyElaxPv//1n3H69ImUAXMMXx1mKkrOATbqb24xgM2YJEBg?=
 =?us-ascii?Q?GBZ6nWWmBgJDPrxHDdYd6mNNu+HWP59gch1PE96XiizqmNrEl2dLddIYYCDL?=
 =?us-ascii?Q?F3xRBkgeGCJmGohzwhk8UHqEm9IxITxiHyYPophgrSk6+vuEyKZKRbnW2DWA?=
 =?us-ascii?Q?YcvPB/ei+M0vAC+5poo9Y0IU3jNORpnr0EPk5ny6MDAx3mA/1QK6zIF+OoE4?=
 =?us-ascii?Q?AffC7IbmY0PeTQLoQMp323MTOBmOzIJaTa1IjUdJQ17VKSFABSHIptD6cgcq?=
 =?us-ascii?Q?Gj8/53p643KEOOz3/5fY1x8W1PpYmx+aHlTTAnAOSh84hi1xjNqVZ6hKB0G/?=
 =?us-ascii?Q?p5sQssMj/Z3kkGRhIUZ/xfxqDBJ1uc/tVSoFz3+a52BZZd+VSYgeRqaSQb5e?=
 =?us-ascii?Q?v3n6GF1GlWtEyp2Sg6e6iV1iItXGiQEEVQATzvI9clj8wZYfPyMq9/rBNB/J?=
 =?us-ascii?Q?Mxk5kJR0GG+1NlIDf2nnNSmeDYNJBLb23NknCnMbS9LX5Eq7wWDtJIJa7TJm?=
 =?us-ascii?Q?ZHyVJ/CtLzhKPlmxbV8RzfNYMrXgyCQ27L8dzY9Z+516BlDgV1KSwTckOE20?=
 =?us-ascii?Q?NNul3NbT4pj/09I7iH/086BcPjtY8ybagOOY4iypKXfuT+iRi82dGQ6P89JX?=
 =?us-ascii?Q?jEhthxmiGO6ROJnRiuY/zfehg9En1xYLsmHyS9NDLgIrzLFFo6D1lx5TaTIp?=
 =?us-ascii?Q?Oky3umxRV2kFFn9eTgv8x097qiKu70Jvt58EACchRDIfm3WkaUSL4uDiGyxD?=
 =?us-ascii?Q?/93wuLAm5SLqmrTDb8q6UPgDjv00WwLXPMVJqXb1vKZ30g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YTYm0N182RbAEqDm2YPsnpYreNIx/YwwsMDyKK2NlA8bEglzuJ7+djHhcTs3?=
 =?us-ascii?Q?kDh+164NOTFhPDfqzbUNHQxNRxN2vPPR3uo4r7k9mbeBKru2X7LHW1nojUT0?=
 =?us-ascii?Q?n+4IKlyWIYRZNakjBhV8r1ojP0qcd6eGrMoO7Fpk9VQTKxU/FXWX2+Jc+JVT?=
 =?us-ascii?Q?f/U/Yk2FVBM+y4h+bJLs6SRbMQFGayKCBUHufghU2YL6ha9sxoyzv59ML0m+?=
 =?us-ascii?Q?k7EuYMJab9MA8mbtyDV4u3nmoUdqj6+/g1NIU1pIqKSWt1jODDxkn+NZF1cw?=
 =?us-ascii?Q?MMjE7uQeD0ZdrknAM9GQ9IGh10FPEZK+wIlBY3YfFHIYld9wSPcSSqR2EXHB?=
 =?us-ascii?Q?tYvtxaL3P8dQiedo6E4Lxfo1PBow4WDqwZBxm/T4MtyzCbC4sLttCQJ7WzTQ?=
 =?us-ascii?Q?mSLDHyHdC3FSPLBbTciV/5oKa7L8WGhcAHDPHhRQ3Zz8sSwRDeDH7aYuDr5v?=
 =?us-ascii?Q?BfCctHcHQAW7Bs9cJjKEVRHv86uuY5eAmH8NvjbN+PpdK/QjCfP/SqTXyXo1?=
 =?us-ascii?Q?trjOfpfjXmPQbxJJGZrUaRyz0+NLBXC0ZCPnDOzr2Aec+Af3viXqUF4deUHc?=
 =?us-ascii?Q?1UMP1PJMPvEuBr9EiJiOQgh91BKWkSnkhfxa2dKPXr6+knXGfrKJjfk3MAT7?=
 =?us-ascii?Q?E2Dp8oM3bZI8h/FyWBqFaHz8cm04XeaAr1xq4GgWRuNj0SPsUy+ZMPfS68tf?=
 =?us-ascii?Q?yXLx612N0d+Qt7eSDllAirUIJRkIsq5x4pHXckLtCZV9W5YjNs8ZE6mNP+O7?=
 =?us-ascii?Q?XBTptU1X5UnvNzbwYi/U6ZmvowasOWWXsGPhZ28cWi8hfIuKYOf4FgQVtmrm?=
 =?us-ascii?Q?Cc/t3rAZGVSm2lxtYuH2vLh1n7adTSCWpAGhG/jo9jdJxgD5mOUdpZcZ4Xxq?=
 =?us-ascii?Q?Fzvrw0rOTyoELZQwJuAIfNYU10tJV9OoVWNRPvgQISvpGSkUG64MmrE3tj+N?=
 =?us-ascii?Q?ylqMBlwZJN+9cZ5jn8CjMuwGmJlZHaQyZ8PMk4NE4ctEEApYPIFyDhQeWvOA?=
 =?us-ascii?Q?myL1nFDUGjIAogwwXjbTYpPbsSade3BE8SfXviCw8f8KaBrMTIO0pDz5Bvda?=
 =?us-ascii?Q?+4QDsGy9NaFapuH/2DkSJCKijs4yYWgG7PNtqtWikhAC7rUsUI0wepOuZMWv?=
 =?us-ascii?Q?Ub6KHOXh9t6iFUF74Avyo6XWA9letpsnKnD4F0x+eAdZDBZqgYtjseCZ5PfB?=
 =?us-ascii?Q?M8Lz3kVEBQucqlK8LBHiGq1fju2ma8mIHDrxNk0xPHI8IUFAEv/U2xWdepKx?=
 =?us-ascii?Q?px35fn9ZHwvBiXCMSSGr1wQeZAYm/A4k9gn/zDsAV2HSh1UhkFUHtttHOyGq?=
 =?us-ascii?Q?0/ms3AZrmj15Z/xx1xHERvR3PsbVYl6XIuzL9q0z9tlehpRVHvBIsDNHkP6E?=
 =?us-ascii?Q?2EssLaIzRG10M+mm61/y457AZz2vQ3xT6jUAB8Y4tdxuDC+mN5bRPbFI4q2W?=
 =?us-ascii?Q?8Z80XIFD1ao+OJI54xGSTcFJQeY2qnKDB0pxnBN2bYLGvbs84YYqVfBHyu+n?=
 =?us-ascii?Q?evugTcWi6wqvLIV7egnzL7gJt/Nc3It+aD4ngo1iAhcTqXrPj5vgz9ENQJq3?=
 =?us-ascii?Q?5NhQSPeXl8OWDSsJ3BvsW5ITxmkDF8mlFPOkhqlWaNtVD0BxVXLB905TGM0X?=
 =?us-ascii?Q?dyswCFWJWtoE65IDOywzgdTHGyIan2ckah3Qf/GK/EG82fXsPZepSYxzTDkH?=
 =?us-ascii?Q?lMpfYA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001a2add-00c6-469f-c5b9-08dcac600d71
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 04:12:52.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zATAsZGheVhmo8JiZfn/w/zE9RDmK9fCzhwg9rVrS8QVUcpMAaK7DTX5BbcTTjC0CO3aBhP8c6LEpcKfEJ62lDj+57L2WNB7uwGNpe87h90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8788

This basically does:

- Add min_percpu_addr and max_percpu_addr to filter out unrelated data
similar to min_addr and max_addr;
- Set min_count for percpu pointers to 1 to start tracking them;
- Calculate checksum of percpu area as xor of crc32 for each cpu;
- Split pointer lookup code into separate helper and use it twice: once
as if the pointer is a virtual pointer and once as if it's percpu.

CC: Wei Yongjun <weiyongjun1@huawei.com>
CC: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
note: excess_ref can only be a virtual pointer at least for now
---
 mm/kmemleak.c | 153 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 94 insertions(+), 59 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6a540c2b27c52..7aa5727aff330 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -230,6 +230,10 @@ static int kmemleak_error;
 static unsigned long min_addr = ULONG_MAX;
 static unsigned long max_addr;
 
+/* minimum and maximum address that may be valid per-CPU pointers */
+static unsigned long min_percpu_addr = ULONG_MAX;
+static unsigned long max_percpu_addr;
+
 static struct task_struct *scan_thread;
 /* used to avoid reporting of recently allocated objects */
 static unsigned long jiffies_min_age;
@@ -300,13 +304,20 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
-	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
+	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
 		return;
 
+	if (object->flags & OBJECT_PERCPU)
+		ptr = (const u8 *)this_cpu_ptr((void __percpu *)object->pointer);
+
 	/* limit the number of lines to HEX_MAX_LINES */
 	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
 
-	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
+	if (object->flags & OBJECT_PERCPU)
+		warn_or_seq_printf(seq, "  hex dump (first %zu bytes on cpu %d):\n",
+				   len, raw_smp_processor_id());
+	else
+		warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
 	kasan_disable_current();
 	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
 			     HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
@@ -700,10 +711,14 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 	/*
-	 * Only update min_addr and max_addr with object
-	 * storing virtual address.
+	 * Only update min_addr and max_addr with object storing virtual
+	 * address. And update min_percpu_addr max_percpu_addr for per-CPU
+	 * objects.
 	 */
-	if (!(objflags & (OBJECT_PHYS | OBJECT_PERCPU))) {
+	if (objflags & OBJECT_PERCPU) {
+		min_percpu_addr = min(min_percpu_addr, untagged_ptr);
+		max_percpu_addr = max(max_percpu_addr, untagged_ptr + size);
+	} else if (!(objflags & OBJECT_PHYS)) {
 		min_addr = min(min_addr, untagged_ptr);
 		max_addr = max(max_addr, untagged_ptr + size);
 	}
@@ -1059,12 +1074,8 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 {
 	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
 
-	/*
-	 * Percpu allocations are only scanned and not reported as leaks
-	 * (min_count is set to 0).
-	 */
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		create_object_percpu((unsigned long)ptr, size, 0, gfp);
+		create_object_percpu((unsigned long)ptr, size, 1, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -1308,12 +1319,23 @@ static bool update_checksum(struct kmemleak_object *object)
 {
 	u32 old_csum = object->checksum;
 
-	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
+	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
 		return false;
 
 	kasan_disable_current();
 	kcsan_disable_current();
-	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
+	if (object->flags & OBJECT_PERCPU) {
+		unsigned int cpu;
+
+		object->checksum = 0;
+		for_each_possible_cpu(cpu) {
+			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
+
+			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
+		}
+	} else {
+		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
+	}
 	kasan_enable_current();
 	kcsan_enable_current();
 
@@ -1365,6 +1387,64 @@ static int scan_should_stop(void)
 	return 0;
 }
 
+static void scan_pointer(struct kmemleak_object *scanned,
+			 unsigned long pointer, unsigned int objflags)
+{
+	struct kmemleak_object *object;
+	unsigned long untagged_ptr;
+	unsigned long excess_ref;
+
+	untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
+	if (objflags & OBJECT_PERCPU) {
+		if (untagged_ptr < min_percpu_addr || untagged_ptr >= max_percpu_addr)
+			return;
+	} else {
+		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
+			return;
+	}
+
+	/*
+	 * No need for get_object() here since we hold kmemleak_lock.
+	 * object->use_count cannot be dropped to 0 while the object
+	 * is still present in object_tree_root and object_list
+	 * (with updates protected by kmemleak_lock).
+	 */
+	object = __lookup_object(pointer, 1, objflags);
+	if (!object)
+		return;
+	if (object == scanned)
+		/* self referenced, ignore */
+		return;
+
+	/*
+	 * Avoid the lockdep recursive warning on object->lock being
+	 * previously acquired in scan_object(). These locks are
+	 * enclosed by scan_mutex.
+	 */
+	raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+	/* only pass surplus references (object already gray) */
+	if (color_gray(object)) {
+		excess_ref = object->excess_ref;
+		/* no need for update_refs() if object already gray */
+	} else {
+		excess_ref = 0;
+		update_refs(object);
+	}
+	raw_spin_unlock(&object->lock);
+
+	if (excess_ref) {
+		object = lookup_object(excess_ref, 0);
+		if (!object)
+			return;
+		if (object == scanned)
+			/* circular reference, ignore */
+			return;
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		update_refs(object);
+		raw_spin_unlock(&object->lock);
+	}
+}
+
 /*
  * Scan a memory block (exclusive range) for valid pointers and add those
  * found to the gray list.
@@ -1376,13 +1456,10 @@ static void scan_block(void *_start, void *_end,
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
-	unsigned long untagged_ptr;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
-		struct kmemleak_object *object;
 		unsigned long pointer;
-		unsigned long excess_ref;
 
 		if (scan_should_stop())
 			break;
@@ -1391,50 +1468,8 @@ static void scan_block(void *_start, void *_end,
 		pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
 		kasan_enable_current();
 
-		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
-		if (untagged_ptr < min_addr || untagged_ptr >= max_addr)
-			continue;
-
-		/*
-		 * No need for get_object() here since we hold kmemleak_lock.
-		 * object->use_count cannot be dropped to 0 while the object
-		 * is still present in object_tree_root and object_list
-		 * (with updates protected by kmemleak_lock).
-		 */
-		object = lookup_object(pointer, 1);
-		if (!object)
-			continue;
-		if (object == scanned)
-			/* self referenced, ignore */
-			continue;
-
-		/*
-		 * Avoid the lockdep recursive warning on object->lock being
-		 * previously acquired in scan_object(). These locks are
-		 * enclosed by scan_mutex.
-		 */
-		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
-		/* only pass surplus references (object already gray) */
-		if (color_gray(object)) {
-			excess_ref = object->excess_ref;
-			/* no need for update_refs() if object already gray */
-		} else {
-			excess_ref = 0;
-			update_refs(object);
-		}
-		raw_spin_unlock(&object->lock);
-
-		if (excess_ref) {
-			object = lookup_object(excess_ref, 0);
-			if (!object)
-				continue;
-			if (object == scanned)
-				/* circular reference, ignore */
-				continue;
-			raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
-			update_refs(object);
-			raw_spin_unlock(&object->lock);
-		}
+		scan_pointer(scanned, pointer, 0);
+		scan_pointer(scanned, pointer, OBJECT_PERCPU);
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
-- 
2.45.2


