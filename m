Return-Path: <linux-kernel+bounces-562354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F47A6248B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB0A19C19F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD918DB20;
	Sat, 15 Mar 2025 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HQ5Iuav7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47B189BB5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005348; cv=fail; b=K03z+BYNs9jjf33eUbFiLXNTf6z3Wo5+ZcTxLmOPEDZ2ZZ1WohVKRH1ajzxwqkBra0o1C8vnyF3yVQ4Bww8o0Ib5R+2L6ulRjc912zydapXaSUdkL75GUqXrqr3eZQY1vhoeNM4ZoJ6Z4aRBFDfz4xC07UowxGa7rEcKCn9P+jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005348; c=relaxed/simple;
	bh=FA3/30cdCJ2KJkpIGNjWuYm3nTuw+fQESsE9GdJqOfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9wndFfbYixrdp8YQJKB5U9lshX7WnFvsnL60uSL4mIKDhcB2rEYOrF3S8Cp4YS6k7JyJ1ZuqtHbBH9SfoAYbnWWV7JiEy+k4ZApo6/tqmo+LFkVlCEIF766Kn2m9usBP3i71QRE4ygrk+kkssNyRZbVx0Hc9KrxUWkH8Wm2TUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HQ5Iuav7; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPi3wdUSkCsjTdf6E8pVgzsr16uhcZdoqey9pnm/KaJe5HPvNHZLh1kIpYz1kt76KXPMzEgVgswtNUndZ3MC6WrfvRhsugkG8rkRUnIFk9pf/YY4AcGAyTrKWtIJE/2EOrPiUdmHUkFoOBbLkUGXK92BGLGF4o0UflxCDs90P14AamXvYew0zsfBiGl8x3tfVGljPW1H0+gQOz2jAOiEfcR0GNjZE0KC5JddQdCsxggcVBeCjyomi2l4uH9Ao0KNdFxwXqmh0hRUkalrbSGamPI3fOUSDLRS/gKC7yONXhbdwmRVGAD33ni3Jd2f0qxJmGse0nCgtlZJAm3bcGTHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMY56GfI8gNfVBD4JmlSWWK0BR4UtqSgI4+lAJksnO8=;
 b=QiAbwbOHhidr0+A/Hpx/nDEeyFEZRXdkq22EQLaPw91wZpq4UyXwQqH5NLGlE8QjnQoboNJYdmw1w52wjZE8Ugn1ISat6mEa7sHgTVotV5fB9stlMkRCHgDqUBmESzpfWAD8uKcoZaBXrFh5qBgqI1ievMqPrHlseODaUzIt5vu9Wrq+XQiKZIw51BTal9xNpGEQFgGqaso69mhfUDMhc2RcFKhaUuOro1KCU1EwHaprixsAMf2g6IFlMMyjBUT16z4WxlCo8RO0B1zg0RYkHJGkrxJ0Y7ZfJS8P8Qtpd2tlSi2fbfs6RxWhDOFew5sETlQUfj0q5GJNlWLSUaPVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMY56GfI8gNfVBD4JmlSWWK0BR4UtqSgI4+lAJksnO8=;
 b=HQ5Iuav7HlOiH6HJTU3M+oIvDFDiOnQqt0sQwC0xFUyqFl27VY9f5UCANjnSG4LMbaTiLUt9oSrndPWJIL3jogUctSAKfGNbNt2AS4ncPbRK0fiMSgZ18o+Gv2LliVB/ZgT+ZjVFWyR3mDRiaVblJX9+czOFEqbaJqxdvOCQxkQlxX6+xQLphYhCqnMPLD9+1IFZzlCGCdp+v75rPVe5+V8J/RVPRkhBxJLcgj8R8T4Qnm1Q993bUhjEvjuACNVjRIgEgLLFxxGdDCrKVUvprEyv3H2AR484OWSi55AugtDj0PZX8rzaIMOygfkBsk0YaeNDgrh+pdm4kXjT3LC0/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	David Vernet <void@manifault.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC 4/8] sched/debug: Fix updating of ppos on server write ops
Date: Fri, 14 Mar 2025 22:21:51 -0400
Message-ID: <20250315022158.2354454-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 903ffaac-6272-4992-0ad1-08dd63683581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvYirwrJwyPu374+jTZMOVZDLtnNUi7vM62Tv2bb6Gl5LVaqpyPM8BrJ4J0S?=
 =?us-ascii?Q?04BzU4sCnf18U64KXKTz/2KRFdOJHygaB4iSpyC7L+whiq+wG/Iq/0nkrxfU?=
 =?us-ascii?Q?RscUEMUxzrbFCeaeW+GJpGpclaf8ZZRQ4xVqz2oeZ2HVuU37h6NhVJOhTqd6?=
 =?us-ascii?Q?2NePzXe9rHVCIHfog2FKiBZ91jlFZf6F/JOUg+lz7DLV2R0vPdIXk7vzvZlz?=
 =?us-ascii?Q?WpAj8qUhK1rACBXQMt2dPeMx7ZNW76CM/vaw4pa4EFv8MXS3PYzL8+w1sIC7?=
 =?us-ascii?Q?Fi1SoT4MmFFJ4EQv8NNbINJmjpqQhDjgI2uEfzOS8bguAK8iY28cPH4jP1pt?=
 =?us-ascii?Q?6YdtJjTFcutIg9eFH7/eOO3fwBnJmMMGDee9QCIpK9Kfpir4Lyp0GqkAlMku?=
 =?us-ascii?Q?lfmvpZoO4bR9AYz5eVeAfc0VK/3oKsYMLXaNsRH6PBm81GCfKNe9POVM15KO?=
 =?us-ascii?Q?gbqpn7/aZxicwQ+lW8SsnJXZeRMGeAgnERFLJxI1ELmec7R64WLvzJP9Sxvf?=
 =?us-ascii?Q?rM7fsbxke9mU7n0EKLqwTWdizq62VZTXLL3m1qMSkdiE8YD/reWJmap+hgHS?=
 =?us-ascii?Q?ZHvjhSonoD/cDCJCZdYsC+PN9vI4I2/Vhr6SZEQSBaqozJnWGDGkooQYqyQj?=
 =?us-ascii?Q?aDwSo9BzUSrbQa7P3hFGoFDiHLJ+l93yioogc94lhygRKhJ752EC+cu3r3wp?=
 =?us-ascii?Q?/LmwneZZYWkPNljvstlwgZqVhE1T59TBo7NX3L9j6hc8GHFRnsj1NYpCuqv7?=
 =?us-ascii?Q?+xFtADY2WjvTlr7J9OFHCmt66GfQO1c9+2BmOeKN5htC7GMaMQ47t1W9o6d3?=
 =?us-ascii?Q?Gi6SNjfq2Lj9ZaOh5LDwwRnvTKdA4Ro+sBoO/56cypsj5hEeHvbzXOsyJIPI?=
 =?us-ascii?Q?ZEGl4tQqlVM/3t2n2NsGJdULM/SoPfFqJ4oqUJoOFRgfVklEWQpN3lrBIpff?=
 =?us-ascii?Q?DoMf5qyy6yiHFGVBw9kty24Ckgfvbm4QaInHYLWfQeyxatdH3hvOswLK3GnA?=
 =?us-ascii?Q?NLxCKVZmN3c35+hfmbqL1hWcutVN5jfFIFGdlWcIZqVuONmUVp7X7ruhv0kS?=
 =?us-ascii?Q?ucZRzz6OznhsfgWvl73/73rcV9OR/kzSnxwoiKXrrHRO4KRg5ro5VXgJqku7?=
 =?us-ascii?Q?hksdm0trwCDrSUzLa4H8/ghB4ac9WOfhrY2qEs2m1SBlPntcRqPEVYdoInN0?=
 =?us-ascii?Q?mmV+2pyb+obJsRMdkOhzZFMPArllXlyCPxDK/28hHjSoMePUmBgWjAzi80r/?=
 =?us-ascii?Q?eOO41IR/C2AkfZzNquvty6X7FhtNrZIP6LxUx9W2/84dvteeEANsB1QpKGw1?=
 =?us-ascii?Q?tOYDysoBnQ9k87qWGForCKOdTpr8+3QqDjbiVlm5DwdfYHlIK1nEo/hVOSdG?=
 =?us-ascii?Q?fDeks78C5LDfrLp3UN4qm68bmrjQPTd1F050AAMF+HtfVasxKdH0i8W9wlyf?=
 =?us-ascii?Q?iEOlpgVsR/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wmXQJTo8fwGhlITX22qUo+c7U8a/Rd/qe8Lc8ADQz+O1hC/+onKhFtfPntOz?=
 =?us-ascii?Q?Ft/HqSnPMQTugJgjQotPh0tfEtQ+cZqjmffTjyCZxACOgUdJlA2vhjxD3i4E?=
 =?us-ascii?Q?DKG5J9ekjhgx7JMovT6K73PN9tgpsNo8IsSTUF71gwpuxV+pbDP1YZAjav0v?=
 =?us-ascii?Q?d0Th2Qxm3ps3OVsuu+Qkdm8vZcPcwYj7wEil/p2LsLN9WaFiQdnvqVdF15je?=
 =?us-ascii?Q?vEAo+UZ4ouzYk78KZ+/d0r13+GXfcsqzcCctmpzD0NTTJssvg0Ri+IbhsN1K?=
 =?us-ascii?Q?0mT2XkC0+lGxXZOiE8tS1qJE8blQgQyr+A2pSB5cExI311vTApn5l+vC0/UO?=
 =?us-ascii?Q?yhubDTCi57qkNjnR/AhKYMwPJXXnVeG81qMG6vG8KIryozi6g2z5cpJQfoj6?=
 =?us-ascii?Q?nZTJv7evNVZfkSx6Htr8znvh5rTfuDzYYRmCGD6N2qR093aEqCcwoe8kw0mu?=
 =?us-ascii?Q?9lTZxeLFJpA6FwV5NuqRovLFss88ELwSrX3Qkv2JdL00N4ccLtph8rwV/GU6?=
 =?us-ascii?Q?tdr3gg3lZEBk5FhuSyKRwWnTbNPzCkrZ5Kx6RujseFr6Sv9XxZVS4VvrcMZR?=
 =?us-ascii?Q?LgRib53S2a2YK7ti/V4V+PDZEsitfZmkWSCWdrqoJ+0Ec03gARKIPBRZMV/n?=
 =?us-ascii?Q?jWR3RyN3V+kIoMV6BUS6+xNKS0LQ11hZuTBO3hOpz0S6Ejvh80kqbHM37648?=
 =?us-ascii?Q?B2EGNAi2NTcJVGXdk/QhLlnbZoN56tvrRXRTAfhXV1tBAtQ5U59Osw13UHi2?=
 =?us-ascii?Q?Ny4/74Kxs7GQc+316bXvtLiWidtoBBfx22BPYouUgByFVGLMqDSxm0L3D4x6?=
 =?us-ascii?Q?BXdZDbAVJxoOXuuL8ls98dg9w75gMO5kUGvE6HocaciOaRKcRBs0ip/MWDb/?=
 =?us-ascii?Q?TI9DdwBHbTrM79Nb5Vsi3ahdjO1EYmCl51jZY1fIe6sFzB1PoZ0uB9/u0dSQ?=
 =?us-ascii?Q?GIT1IhXyooUn3yFbcVVcJsZ6vKNDARkskpWgmM6F91vqKM/rKySqs1yntS6g?=
 =?us-ascii?Q?GOJnO1rNJIGGNTqQBvAQZLkLdgCR2DPFEYhl+HqlEmXaIQQsAglIyLajGUqB?=
 =?us-ascii?Q?Ouc+QkSUftOxfBO5Mn1SfBVozJ0oc0Fm4UK2E73uUYN4J/8S39GXONlQHUfK?=
 =?us-ascii?Q?K4uRuw2QBcBs/kWEy57omzyITsvhyoVboaAYreBpHO3PC34R0nQQenDDTrKi?=
 =?us-ascii?Q?1716yO44yHstoHJY6uCDSe5vKyCXka45IUVkx4R9tCwDZZ/rORaN8DCQlRJk?=
 =?us-ascii?Q?2sm6+DpgfmRySg9VrTxxjNYiMDxlhmrG7kyApT+GWe+OfG2rXyDu/r7aGCw2?=
 =?us-ascii?Q?kUPi4SdQvnWTv7NEIzdOrQEepKVj7DUJFpIjkUCy5uTFor+p51TTgU298Tz6?=
 =?us-ascii?Q?P/+aMI8PGXfGMHu8vrQOT5wLuiAdaD9pKTe3RtHrETJ0IzCTHHPv1kStCFHj?=
 =?us-ascii?Q?FKd8AFpbGsqqy9vD1biP+4L6xmDrThFq+UbLZByiMyUsHQMKODJCgenYQI4J?=
 =?us-ascii?Q?eH3a036iGkxwqqfl43rlqOrujRXrVfmX6/wsPrl1wbsY7Vyh5AnUphAZ7guY?=
 =?us-ascii?Q?IO6uSharMmb4gUMmWE2osQHzHsBM1d4arDNjDrYn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903ffaac-6272-4992-0ad1-08dd63683581
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:18.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KPKMtVCjDluQH/kMcqepb8XtXtzi59rI3WG8041ziucLNcI0JJc3bjWegvuG+bBJTCGKdGEtWsjo1GeJtFt4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..1ccc7687e1a8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -348,8 +348,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -385,8 +385,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -394,6 +392,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.43.0


