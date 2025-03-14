Return-Path: <linux-kernel+bounces-561209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E90A60ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E23C7A7E25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5EB1F4170;
	Fri, 14 Mar 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zyIBi2gq"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE91F417A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947999; cv=fail; b=rGTCjDj/vhPKgmheA4Eo711ERUZ5t28VKgKMvAHo8BnuxUs5k1LmmeiFiHC4dX88fcO9T0VE2NpZzRhsN2b6kFpvpDqe5L2tKiPkcMsTGOFyrtKELlysQUkWGzytzpTBLk7mUNAKFr2LKTX1duoiUkSbYbtbbUeaTaTEZdvAUjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947999; c=relaxed/simple;
	bh=aY6FCyOs/QdcfJP3IT5GERaBg9tmT24X6hEmQcZ9EfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LQceaKbFAxTtBUgwJ7DapGJOepaZPECG7i6/aML/ckQI4AhqWHzHy4RikNgEBUCpejthSGM1QYLxDxEZB8wS+sXMaEm28Szx0TuSsFUUXzEh3VJfgz0VNnMHwuJmf+Htk43yjN1w3uy7Dwm+GtfwfrJIblZc+msWvfZbReiMZso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zyIBi2gq; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0niuIT9iOKFhT6KrrNYw5tbF9qY10fN3NgD9rEgkL8J45TtFbM1FnCH5GYFESyfQ+r+kyJ3fjIrKf0oPuTtKXeN6Kr5hKLwvL4lku2SSk1hCZllBsHOc6EeuGlFdcwSL9VNhnWh+8K6V0rQmwCYt0otgOQIsP5grAcaAOZJeYN/cKnjPUy3TueQwDfw8LXsCHHh6/uzBjlDTCZWwVQ8DGErtixpJa+CQ3NFjWj6EGIbSovgC2mgpLQDpYAynOLCyspMdurmJH/rYJfwWVpo0dqnQ9dQh0JJimxtbj8IXuKFU4CVrjuj2//Cmzj9IAnCMvzt+rotB/ofJcGlQMEBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM498FC6OYfDh8r5IE5jS19qDUX//XBYgvNIOOj/MsM=;
 b=tUwDFGs6xpYgopxtBgaiAGFqVKyod3nVyfC17Hm4wgJHlOM4PrRa7xOax3Tz/fC6yO9QYZwqareKnIlHhwI+Ng6nFzq1nhJwoUtQUviqMIM+UFPM6gcMF3MGzQ9gO+mgDgstq/K71P+d/3qbDcE/ewQvGn3PE6uBL8LuSEdZQOiSmx+/zEoVAKJPwD0lEp3n6SgoHjWojC9mjpJHmykPOGSh/uqC/Hi/JvXUrcESKTLmQABMmWkuwE4iRdSOlj3JXcRGsN4gkVxBIDBszOge4COtEOwndCKJb+0xWukdw2CzSqJgDE9aMe0a3TTAFqmiGyygs3TNgQY/m83honrb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM498FC6OYfDh8r5IE5jS19qDUX//XBYgvNIOOj/MsM=;
 b=zyIBi2gqdNoYU//8Qv4KGFxxwkHpzO3lmBMmf5zlNw+scU1odT5Fbm8CV/dS5GEgwdwRN7q8t6Zjw2i08xRn4Cz5382h8Q2qBvq3JXQVDdq7GaLEtC5kTE1yPx22iAMLfX8L/SdlgkLOrIjuqp7MJ7whGdaY1i/P61pQPFdI3mU=
Received: from CH5PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:1ed::12)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 10:26:33 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::79) by CH5PR02CA0019.outlook.office365.com
 (2603:10b6:610:1ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Fri,
 14 Mar 2025 10:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 10:26:32 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 05:26:28 -0500
Message-ID: <6688eade-8eec-4d76-87f2-637425b1c2d2@amd.com>
Date: Fri, 14 Mar 2025 15:56:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>, Chengming Zhou
	<chengming.zhou@linux.dev>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
 <20250314094249.GC1633113@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250314094249.GC1633113@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: e05b69e2-f0bd-4518-8ba4-08dd62e2b0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFZtRll5R0RWQWVoNExUWXVtbjRJNG9sWitTSll4K0E3YmpnVzNPYXNTSWpV?=
 =?utf-8?B?UDdXNmQyaDd4RDU1UVlUbTFwNGNSZWJ5K0s3ek1OWkl4RVM2MG5NVlJNTG9k?=
 =?utf-8?B?ZXBFcHpQclpUTGNrWnNPaEc3b3JhRndGb1VCMzAxMG11c1NOc0VlWng0dzk5?=
 =?utf-8?B?RHRiRHczV1Q0dk1aY3dYRFZrOCs4QnZaRFdBRmdjcEM0ZmNkbnM0ZVFPMU0r?=
 =?utf-8?B?U1g3NmlKMklMK2RHSmR3WHdsZFNNN3lUbHhYMVA4V21nRUFyRVZOK3YrcDFj?=
 =?utf-8?B?My9HaGUwRGJnREgyaVJGYkljSXdCQ1d0WXFXT3NJTjlkSUZuNzJNM1BPcmJZ?=
 =?utf-8?B?blRNTDZUd0dlRjl1aEZFelhJSVRYMXl0bXpCbFBFbUo5V2JHMlEzaVpyYzli?=
 =?utf-8?B?L015ZDdrNWNtOGFKSUhTdVBnU05PeEUvb21ieFhMVUR3T2VKZ1gwWFFZY2Ex?=
 =?utf-8?B?QmpaR1JqbjRpekNqdEtoS1A1dVcwTjk0SFNuMjcwY3dlV1VRVWI4VENIZTdK?=
 =?utf-8?B?dkE3RGlzMm53V2dTSmRUQUZkaGpjOUIzSzEvUVMwYm9yWTB5aStwNEgzT0VM?=
 =?utf-8?B?ZjgwV2NRQ1hkQjVtcDhZZTRvZ2krWDEvQjUzSXYrak1IZXJyT1M4OFRsSHRu?=
 =?utf-8?B?M0VOVW85Y2lzdmFYaUdZVmpNeGF3ZmFWS3RocEFGK0ZFUTRya2wyeXZEbW1U?=
 =?utf-8?B?WVdhS3NjQ1d6d2poYmRUa0FLY3ZYNGFqdHBlTElYRVhTR1p0VTRteld5UTQw?=
 =?utf-8?B?T05xWFpybU9LYlJPOFZ4MWdEWHMwcFVueVNINGs1ajkrOUVvMENINHFNSGRx?=
 =?utf-8?B?UVVTbmtycHpVQTZWWFBZeERlVDBraTFxWjFrWDkybW9vSnhRYXlaaENHZ0Z4?=
 =?utf-8?B?aWFra1FBbXozNlZXNXQ4NVp2QWpoK2lMWllXdEN5SWNMTG16NUVEU0hVZ2tm?=
 =?utf-8?B?NUEvak9YQ2Q0Y25zQ2NJMzBtd0VPQlBFMzJpVFBCMjFJUEluYWFjdVVtTlVB?=
 =?utf-8?B?SDJHYkNRTGRhRmk1d3g2R1BLem9MMjMvb0YvNHUrT1g5emorRlNXcnRBWUh3?=
 =?utf-8?B?d3VWZnl2OXF4SEE2Sm45aVJwS3loNHVTQ2hucVY5czVXNmJsVGxkZExuZ3Vq?=
 =?utf-8?B?aXI2QWZYMERPMkhrWVdVUVlQUkhQSFRpcE1qc3Y2aXcrb0Fkem84U3RnVXNm?=
 =?utf-8?B?K1NPem1Najd6NmVEUmJOcnJQcHhvWEdEYXJSVmQ3TE1IT0FIWG1GUGVkamE1?=
 =?utf-8?B?RnUvdnJzR25lMnhEK3pDVHhXV1pKOFNlaklFODllUDZrWEFqb204TWhVeXdE?=
 =?utf-8?B?dm5RVGQ2b1lVbVFRR29xZDhkOG9uK3J4T3VVWHB4d2U1aGZpa1FwL0hpNXJP?=
 =?utf-8?B?WFNyY3RQNXZCWDcreFJvKzBlUGlrdi9ORW1vZ0xDSm9rWFBiYWZqck5DQnhP?=
 =?utf-8?B?TkdMNllmR1ZUOTFJWVB3dWdsdmJkM3A3UUhsQXUzblIvanFlWTBJR21QdDVH?=
 =?utf-8?B?eVp6dXNGZGY3dVVreDdIQ2lCOVRpeDJRMktrazFLTGhlbGJuTTdQOXpvcWd6?=
 =?utf-8?B?Uk95bzYyQUlCSzZHQU14Z1NTK1dKaUxFSVRSSmYvU1F3S1JGQUdXSm4wUlJx?=
 =?utf-8?B?cVU0ODFVTE1PeUw5akVtRmdydEJFKzBEVGNZSlBCcndzZ3lyMG03TG5BR2Zr?=
 =?utf-8?B?UjN5ZGEzaDJ0V2FxdSt0dmFuSFZFTlVkMkdSYUJ4V2hkZEZGWUh0cmwyd0FE?=
 =?utf-8?B?ZG9OWmk0RDFndm1JUXJwaDdqSTFBQ3FRaTRXVVJNQVliQVo3ckJuRDA1YklM?=
 =?utf-8?B?TjZrVmwvanJZZXdSRjVjblBVQjhJWUdxMHVWU3JOVzBZN3drVXRLU2Y5RmU4?=
 =?utf-8?B?cTJLd2FYT2pRTmZ6allwUWh4aFZURm83OEN0OVpJRjZucTRiVi9iU1BGRk0y?=
 =?utf-8?B?Q25NWUpka0cza2hBb1crWDJiRk9OZjhPMVVObmFUUWNlTVRrTnBPdjRhRklR?=
 =?utf-8?B?aWF6anpjaXNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 10:26:32.4769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05b69e2-f0bd-4518-8ba4-08dd62e2b0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

Hello Aaron,

On 3/14/2025 3:12 PM, Aaron Lu wrote:
>> Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
>> for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.
> If we add a check point in pick time, maybe we can also avoid the check
> in enqueue time. One thing I'm thinking is, for a task, it may be picked
> multiple times with only a single enqueue so if we do the check in pick,
> the overhead can be larger?

I think it can be minimized to a good extent. Something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d646451d617c..ba6571368840 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5942,6 +5942,9 @@ static inline bool task_has_throttle_work(struct task_struct *p)
  
  static inline void task_throttle_setup_work(struct task_struct *p)
  {
+	if (task_has_throttle_work(p))
+		return;
+
  	/*
  	 * Kthreads and exiting tasks don't return to userspace, so adding the
  	 * work is pointless
@@ -5949,9 +5952,6 @@ static inline void task_throttle_setup_work(struct task_struct *p)
  	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
  		return;
  
-	if (task_has_throttle_work(p))
-		return;
-
  	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
  }
  
@@ -6000,12 +6000,6 @@ static int tg_throttle_down(struct task_group *tg, void *data)
  		node = rb_next(node);
  	}
  
-	/* curr is not in the timeline tree */
-	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
-		p = task_of(cfs_rq->curr);
-		task_throttle_setup_work(p);
-	}
-
  	return 0;
  }
  
@@ -6049,6 +6043,18 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
  	SCHED_WARN_ON(cfs_rq->throttled_clock);
  	if (cfs_rq->nr_queued)
  		cfs_rq->throttled_clock = rq_clock(rq);
+
+	/*
+	 * If cfs_rq->curr is set, check if current task is queued
+	 * and set up the throttle work proactively.
+	 */
+	if (cfs_rq->curr) {
+		struct task_struct *p = rq->donor; /* scheduling context with proxy */
+
+		if (task_on_rq_queued(p))
+			task_throttle_setup_work(p);
+	}
+
  	return;
  }
  
@@ -8938,6 +8944,13 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
  		struct sched_entity *pse = &prev->se;
  		struct cfs_rq *cfs_rq;
  
+		/*
+		 * Check if throttle work needs to be setup when
+		 * switching to a different task.
+		 */
+		if (throttled_hierarchy(cfs_rq_of(se)))
+			task_throttle_setup_work(p);
+
  		while (!(cfs_rq = is_same_group(se, pse))) {
  			int se_depth = se->depth;
  			int pse_depth = pse->depth;
@@ -13340,6 +13353,9 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
  		account_cfs_rq_runtime(cfs_rq, 0);
  	}
  
+	if (throttled_hierarchy(cfs_rq_of(se)))
+		task_throttle_setup_work(p);
+
  	__set_next_task_fair(rq, p, first);
  }
  
--

.. with the additional plumbing in place of course.

-- 
Thanks and Regards,
Prateek


