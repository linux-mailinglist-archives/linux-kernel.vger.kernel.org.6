Return-Path: <linux-kernel+bounces-563617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD948A6455C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBE21887B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3AA21D00E;
	Mon, 17 Mar 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4VScKip"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FB481B1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200100; cv=fail; b=Yy6Zq3u60fcfl0gbkN/MpbTbRovnvuY3PhUU5TOL6WkfiU3uuYCpuzA9FwMW14LG6abEbMaMye4Nbcq65njVhDreurxjooOQKckx+Uai1WpKLWZXYKEDoPaj6cGFGNxcz9e2TYwIZ4kiecMv3cagFFkLrgOmipaPc1vmlW7wJKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200100; c=relaxed/simple;
	bh=Gn/8+r6kk9l5MEPXHkOxYgg4/0lp5zcZoM8AmUSkWpk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e+gFOm8JgMCkRfCqGkv+JU1+xH8l2Hc5eS59LzhwxOfJ/DK9jpmoXepQpwFkfeNdgTo6owkSd3jfbNA1lcDkNli1mr7fXG3xoWrCHhLZ/+KSRKhVi1oYj5csEDBneqmkXBHr8zj03I4XR6X+cIWVu06FzKEqqXrGe8VT7nSkYkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4VScKip; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y51BdnR4iDZw+xM5oMxH+fJ3T/d3cy9CzD6AgCUEklPEeT9IRs/qCm4WST2wSXErcb7gz9vNvoo/VipcZW361Lv2PinNUD/sXirYrehhWmpopmEhH+r/bCOZN7B2QUCtFRdZ2o70solkRmX5tsV1Fluy2jZNviWVBEOP1zcS6qySvK7tBaNDSlm+cFAO1E6QWomaiOQAaEqu9Fl+WrAdDxhXCO0LWET+Z3z/dneOjbhdENoqBFZMmI39h1K4jBxxmlKWB1QHS86v/Nfvxn1YcypdVkPv4dVJrqEVO9Vt63M2ToezeI42j3J53CN2QUYaJb6eHVNXkIvWWQXj+y/GmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vFnFhypGkxjiFk2pNQBtJbNi7eVuijP3zAZWENpxKo=;
 b=GVBHAE9Pmh3/exOQys2SrOI88RcEMkLqcFC+5SvsdDU9N1g0cg07NPMXgd+aBgOsAH/KC8gfrRBrjrgonb18u4U9fVsPWQ5Haq+1i95DRo9qB4j4t6S891RI7WY48do/2Bi1vHf5iFDYoEJUwfWWmDiJyQsMbYZpp1RhhTzi8/KT+ZsoJZhyDS/PliquGECuyd0q5t7Iinhb0gUxKfLXuaHoykx99GXLa3tMDS4ur92wL1uc+dNpj3hqU/f0ljR7qSBJT1UmxqwnTqpbtGBnaJu6Emisx+ppOuOMjOgKN11BnGH+Xs/baWuZ929cG9rmDorUseUMT+TFWucUjFLU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vFnFhypGkxjiFk2pNQBtJbNi7eVuijP3zAZWENpxKo=;
 b=I4VScKip/JurnS1kRPu0Wwx/8ox9zg4EM/iSN7Js16z7A/rvVdeb4Q7XpqG7iNyvPRHOKKmFKGtCItKwZ3Mmn0SDmkKC9dZ7cKEDz01hnpYjlJbcIBIvkkWAyjvtR3apRrxMKN3NRTDKhO63EpMWRUGW+XsRpKOfMg86QyVJVkRkFy/qzcxXY6TwktcxU8bzZZUwB0Zs2asWt/gPuz6D4UuWX7NXaMIWFKgI8pQGRliguiZS1yGhIXw8hbxVFzReAkULmocclvAITkosAsK5ueB/FDDzJ8tkqHEBfGdpC+caleBvBx5pUG8B55xOwNomk1rcec+aRPVpOfQfwsPhsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:28:14 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:28:14 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine without WF_SYNC
Date: Mon, 17 Mar 2025 04:28:02 -0400
Message-ID: <20250317082803.3071809-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:408:e5::19) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 86dac268-c262-4206-6ee6-08dd652da8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+F5LZGQC+D7BDD84Wq3wGjD+JyUNZ8ErYHcRnR4lg2qO8Xu145pxdLYHN37M?=
 =?us-ascii?Q?ZHiaEI8g2dWQfjisCLttj3kynSNDA5pdAYUL7cjmNnurqR06D2QTuvDA289t?=
 =?us-ascii?Q?vgQpmeV6171X4wkZhOLmCwYtqAIWfqM/uXF0BwRQhkTVsPLOKHlBCyIHMajd?=
 =?us-ascii?Q?cHXiH5ehiDPROYtV4bwIq0KCxsOWVAgrM23kiUAp2rkWtV50dGl6gnXpQsVd?=
 =?us-ascii?Q?MXx+7SoyzYrEk5CyU62jEcJohf182czjp8RTcoaClp/xEnaG13QSZYvuv17T?=
 =?us-ascii?Q?aYuzC0e5SoAE53OKaPIMeztJSdeNM7Yz0UcmiAP0k7lZQvJmM2WMf+BYzA3c?=
 =?us-ascii?Q?nQvjWEfKf/xpxNqwv8onrRgR8L/3qRnbLjmWzrAZV8YjUvN65wSmJmOHXFn4?=
 =?us-ascii?Q?YdJXju2NAT3qkXAVX2LbMcZOu083fb14UIbi1vJKk/7Z47c7lVMX755j3chF?=
 =?us-ascii?Q?GqnBtfyfQ8NqUBIQVuuV5nEyIjBg3lS30rjx8KRmy/H7x7OJYFkGG8d1VvxK?=
 =?us-ascii?Q?Y2rlnwq//ofsxP4o81LyYUFb5RONyXEZBIxmqpbrgUEtWGiyoN3WyddAmd/t?=
 =?us-ascii?Q?jhn+Dfxux1HRTq5kkboUBRIntosQc0v6DaSyKcfA/QLR9SCSDt6a+WQAH5o8?=
 =?us-ascii?Q?l51hsShcbBV7v+w95tcBQAgJSCnptll161VAYTKMiLU6xoqzhH0+e52Akidl?=
 =?us-ascii?Q?vhxvPyfNn7CDU43yHZZCzwiUs5zcGYxuwwi9gg1b9T6dKta52tF0iPiX+VrQ?=
 =?us-ascii?Q?3PesBJU33EoGHsio+O9ccZxnsnYKNM9yLL0Xzw37zLymh1jcjPU38yHvhd7W?=
 =?us-ascii?Q?rK2PiPa6fyT2xaDbXTr6AhOe68fPGdZMe9pAUwWeBHm4GyU3UxuQ3Fx9K+N4?=
 =?us-ascii?Q?YxvJngn522yAdSMBrOJHezbsGW9z98y5daBdhIAqjLqj3QkQGcEfAyDjjtOZ?=
 =?us-ascii?Q?jDbcQu5lBJ1gfDG4BKUvu0ZRNcjC9dVtbvD/WpftuSFBCfXMVlv0RTDnDeUi?=
 =?us-ascii?Q?Pv56gJL8ByjUqHrcns91mct7xkcR89yoa+7xibLN/5oN/9WV32dM5dwrziMU?=
 =?us-ascii?Q?O7rt1rpz7YjSckYnc6Vb84ZP09V1M0+K5Nl5mVitv+CggqvHj92olsuEV1wP?=
 =?us-ascii?Q?PS49nbMFdR89KB7wNcPk96pPRKuIVyfTm5wmJn5dm/ogBp+gQLKlBO59i2aq?=
 =?us-ascii?Q?zSOMlDXQRovBu1ncoGou+CprFmmNxCqjrQx7KhGDqHenDN/hV2U1hpGbrXJn?=
 =?us-ascii?Q?yI3BZSb2Dw85zKfSxDHcK49le0lF8jzemvUMPGgDxA4WWMNENTzUGXRH9rCI?=
 =?us-ascii?Q?rKFpqpjL3qT/1re+RSe2G06J+UCcsPoEz807jbcfNkMdoKOsuA4xcq61T8Vs?=
 =?us-ascii?Q?SM/14KE8vIIsJYtJZvbx72X9OE0II+o1ITAaIu+utnhmA4fJEvjEF6XokPoo?=
 =?us-ascii?Q?0EG65+U6luA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uzod41q3YsbKU3TMdK/roMRCklnfBWERbjAMDouIYFoCIVDpGeDEsz9Yzb4C?=
 =?us-ascii?Q?mAIn8dMMfDnsiYMOe0XqX+KO5dvz6yTvmrjLNqzewzWxCdBdjd4S8WWwFJ0E?=
 =?us-ascii?Q?w8F72xh/z+P5V3xf20OPybFQb6HTkJWYWMYQc3FGRjMDSkqgVS9egcVK6+3W?=
 =?us-ascii?Q?3TeNxBjSrTpfIVpci0fm4OzMpraXZ9OnL9WXyE7G15Nuzj5dm9y3kyHxvyUh?=
 =?us-ascii?Q?Fez6Ml5cFxMCofVtzMfibcqx1enbD3b5jGRtWjLD2nVeteMWFAeAfQDWFxGy?=
 =?us-ascii?Q?VZUhPpbkg/0/GHYNnMtL/qUkXzP+niaG6RUg9ODobyEM2hAQnUtHsxom49WS?=
 =?us-ascii?Q?nRthL1YjY97aDM1XXkGAwD99UwpxhRvz/gFE8a3a7Nbd4ZnuazjMIVIIvRDC?=
 =?us-ascii?Q?oDzrl4WkYeh0dOmYMSJfSlrsDhpxDeaxCnOdRmphBom0pVqiR3CDOrEO3g1M?=
 =?us-ascii?Q?c5WRzJUAV+4NwdKHKTXz8f1luKhB02qOFTVvacZkz7llHH5jcjIKdf+bXslu?=
 =?us-ascii?Q?Afj1o1BHceuS1kquFHHdoxQkxGDDIXSYaD70sqnwnbFL9sAA2pBvSELW0HLL?=
 =?us-ascii?Q?giRiTgnkEej4v07BMyNZPyvm/qT2kWWZrN0IYgkCtWvnPWu3/+IC7CeYIgxU?=
 =?us-ascii?Q?xibRnQ0924mBYI834HqEuWCNqKVX//aoFPzc/UwbEsMK7n+aWKk7GE8K7BYC?=
 =?us-ascii?Q?vIEm5/bJ1KAWwNeUrz8rTPQ899zT3R8pWLHFeOwCPodGTUA3pNnLKV3vtAD3?=
 =?us-ascii?Q?STZSXt0NqDo/FbQ8vtaINKS0+D8AUZYb2ZjAu/Bbf7rzWsr9ioGz3VfmgeWF?=
 =?us-ascii?Q?OoNr6hou7fXFeRaQsK/AyUiN/9wix+jqnzmZ5Zzt54a+nh/8UYTSX4jRh3NB?=
 =?us-ascii?Q?/WwpcwZ1rkAJKy1wVaIkvk71m8+vwDRQUyh6JsNN7C+fyES/0PoWB/Sj4q3v?=
 =?us-ascii?Q?sY+NyAiwfywqvRlzrT5Sm7MYMUCj2UFH7qyAMRcX6uG3sG2Yusw/WfgKldq0?=
 =?us-ascii?Q?1wZReOGQgAz1eCLZmV4GSw03UPFY4mW+zyKxHGK1Y9i1zuZBnbIJnU6hzqpK?=
 =?us-ascii?Q?g1R8jLpfDHikQPukjk+z8CRQBetAaUIHHO7K7UMqMjROb2f8+8slQ18fDTYF?=
 =?us-ascii?Q?uA5J6tdBohxM05tvIRShQt2j+V9WyHhU0qFVUJe0Qdm6HW6YhYlKDrr5+S2v?=
 =?us-ascii?Q?zu+i0Go8GtvyO3qvN7VS50l4wAlWe6BRGy2/qXDmRvCZviUTO/Jl88mk3Q20?=
 =?us-ascii?Q?RE6u7naCTncOPI2DNdvIkN7XGuoo+p/rT6RPsGJ6OZQ1PDltNvTIw1u7X9Yn?=
 =?us-ascii?Q?9bMmlPRZCilOpbvtdhrp04R5F/wvCUPQsZstnPmrCOiOdtoav4g2eZIXtsW0?=
 =?us-ascii?Q?m+7K/wQXvRjjbUEKUjN3o6819QOx4/FibxSyV48FwG8b/zhOod88Yq3Lwjq1?=
 =?us-ascii?Q?4mt6hLIJ6bLmaFwTlFNd1oyXCo2C0rTf9p5xIXzM/fwtpIENV5iTJ6a07QE0?=
 =?us-ascii?Q?PhH6Hd0JANFZXpT+WZP90EkJlWRUY2ztMkXel6v9tkQ4ujRpBdX8yHsTwcSw?=
 =?us-ascii?Q?1a3YeUndzmESl2A/0wmdcSIb6KGZbQhfrID8Su46?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dac268-c262-4206-6ee6-08dd652da8e8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:28:13.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo3IvoihngLF1BRqVVe+7S1GHOOQ9vg4qp0vrrreCWcJ8veYhb+5u/o8mGqnWWWw5ZNi/FmqEXwP8Kx+nEh5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

Consider that the previous CPU is cache affined to the waker's CPU and
is idle. Currently, scx's default select function only selects the
previous CPU in this case if WF_SYNC request is also made to wakeup on the
waker's CPU.

This means, without WF_SYNC, the previous CPU being cache affined to the
waker and is idle is not considered. This seems extreme. WF_SYNC is not
normally passed to the wakeup path outside of some IPC drivers but it is
very possible that the task is cache hot on previous CPU and shares
cache with the waker CPU. Lets avoid too many migrations and select the
previous CPU in such cases.

This change is consistent with the fair scheduler's behavior as well. In
select_idle_sibling(), the previous CPU is selected if it is cache
affined with the target. This is done regardless of WF_SYNC and before
any scanning of fully idle cores is done.

One difference still exists though between SCX and CFS in this regard, in CFS
we first check if the target CPU is idle before checking if the previous CPU is
idle. However that could be a matter of choice and in the future, that behavior
could also be unified.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/ext.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5a81d9a1e31f..3b1a489e2aaf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3479,7 +3479,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
-	s32 cpu;
+	s32 cpu = smp_processor_id();
 
 	*found = false;
 
@@ -3507,22 +3507,20 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			llc_cpus = llc_span(prev_cpu);
 	}
 
+	/*
+	 * If the waker's CPU is cache affine and prev_cpu is idle, then avoid
+	 * a migration.
+	 */
+	if (cpus_share_cache(cpu, prev_cpu) &&
+		test_and_clear_cpu_idle(prev_cpu)) {
+		cpu = prev_cpu;
+		goto cpu_found;
+	}
+
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
 	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
-
-		/*
-		 * If the waker's CPU is cache affine and prev_cpu is idle,
-		 * then avoid a migration.
-		 */
-		if (cpus_share_cache(cpu, prev_cpu) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
 		/*
 		 * If the waker's local DSQ is empty, and the system is under
 		 * utilized, try to wake up @p to the local DSQ of the waker.
-- 
2.43.0


