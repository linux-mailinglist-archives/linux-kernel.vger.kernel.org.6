Return-Path: <linux-kernel+bounces-425879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7079DEC1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4D163597
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0381155751;
	Fri, 29 Nov 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VKWdtDBC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB35208CA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732905024; cv=fail; b=ERRIZOCx6Q2kGEGcX45fixQsD2WQIkowX2x+dBcWSUDiotVmuh/go48lNSSi9Y1A7x0HujuEBe0hJ01G+4y6h28+gIM4fiu4UiBvyMX4umrp9Y5M8CqKjeY0Dv9w7Z4Q6IO3QfkIsCrUtgF7tVMZ7qE05GROkjKEEHNLEeac7b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732905024; c=relaxed/simple;
	bh=TKwL9N/Prg/CVcIRkDJRjFfnrDniMUz/Wn8udB9DA30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k1tW/DClLE8tO4LluF6/JOYhnjy6SiktF3/V2WtRs8EJMAbeueTn8F3t89kARxX3b2TuUmtf3RHRuskr9P8S9t5ztOaxEYrlUlHBS3fPmWNZkBClkYQbVDmduWbve31VzQmA1us+P9djJHawUpwnWWOYeGXKY03VVta5buopNPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VKWdtDBC; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km2J4JyJ9L4aIkZ7HlVwqqeQL6MeCqlLbbYi0s8gv2LRVBupDVx3aDEOUyp2f5iNF+2O0mghW3dNh3StjkdWa2c7NjZyThGCZYlNhNY8wQc5UxAWXxVWety/AETCORZ6KaBCuJCyEma1IZj6ACnE5b5hJyEO3C69ChywZ/sp/7Qk9vEM4LEZ1L+HDFpZCj0WSFTuTt/94Y6/dFQBmZWdzIHs/Tp1Tr8UriWCkIUERMtT0VqI3PmxUhkJMHqb4PERcESijgF9B3QhJFwMwyw5HFbpf4IQDttYes1XRLHXKlJnOTGyPCuPJobCzeRIf6VTIrqm8LJQkSzdsZF0PhvyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZt1Bk2OsJbSp0SRkR0DS8Q5269SzHPcn4PJQ/PSdAI=;
 b=p4gaIspq44QYFtLPE+k7oUCQnXkC1dLV0Hh63Gq9T9zbrb/43jfYobQNu7csAvwsnLFdNIH7kbWl3aqCvHw1bbXUi2fg0sVX/l1xqxmxnOLpdarX23Bpn7eb3s4R0jkpJsq95ZHA6gjmGVTqDJQcidBn2rIqln2TSvJfK2SMqWkSJIsaMsDCuZ5gtX5GUPly9mE9sHyITZaCsK16durg89pMtpzO1Nzxc7ukkSg5c52vqRTUhePzFpRrR7d0dIkXRBlptTO4A+oabSMysCWDYlxXgQfICNyQIK82ZYAuahfg7wYhvzGHXv1HehWBnqNu4o7wehNUyPULzrrpJZeu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZt1Bk2OsJbSp0SRkR0DS8Q5269SzHPcn4PJQ/PSdAI=;
 b=VKWdtDBCoLk7DEYKQOH7otwKIEQQbzEzgj7mc5O0fKKdzgDWuhaNfVKsxKlhstxEKEIvy7SQu63gdv7vqCsigOLKvTKEyW7byfmVQpbuQvkCh6+C6LfHGjj2bGpEhyMYAe/QVEsEdgcuKADTETw3MxzqEFyxPBg8cH3TrHwcaW8=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 29 Nov
 2024 18:30:18 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::c0) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Fri,
 29 Nov 2024 18:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 18:30:18 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 12:30:12 -0600
Message-ID: <38a2431d-4c5a-4273-8f1e-7e2f65748501@amd.com>
Date: Sat, 30 Nov 2024 00:00:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10 v2] sched/fair: Fix variable declaration position
To: Vincent Guittot <vincent.guittot@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <pauld@redhat.com>, <efault@gmx.de>, <luis.machado@arm.com>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <20241129161756.3081386-11-vincent.guittot@linaro.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241129161756.3081386-11-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 16116e73-e844-4032-4cf3-08dd10a3e023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdJWnMvZ04veEpCR1NhSlJWTTVZUGNuU0EvbDI5NkxldVlkYjEyNlZBNENO?=
 =?utf-8?B?amdtREIxZ0Nmb0ZRdjFqdzBpdXlkZVFGbm5MalVkNzkwWW5yUms5b2o1Z2ht?=
 =?utf-8?B?dFhhaTMreHgzQU5MSHZnYW5HTEFOVUFYT0FjOUVCcFFBZGNpeFZCN0tDWHV4?=
 =?utf-8?B?Ym1VbloyNmZCajNxNmpONFg5Vmw4dGpsNlNiNDkyZ09Fclc5NGxhWUdONmZq?=
 =?utf-8?B?bWNKcEZhbklJQ0FwRng4RnRmSldzcThCT3ZtbXpiR0pqOG5RazhUS3VOdlhH?=
 =?utf-8?B?cUEwVjRNYXJ6dUZWQzlsd3FTeFpJOENSbXRwK2JFT0t4bVR2a0s5WGp0cjJT?=
 =?utf-8?B?eUtWWkZWNjZNR0hjc0ZqeUF3dmorRTZqMlhFL0JYYzZEaGdqVFVic29RelpH?=
 =?utf-8?B?WjJSOHJiSDFBTXRZaEswWkNqeUcwVHhKSVNQMjl1VlVGVk1la3d6TWpzWUNq?=
 =?utf-8?B?K2RoZlAyRm1pTW55YVg1R3NOUlgwZDBNUW41cnF0S2QwWmVjRmZGV1pJbWRj?=
 =?utf-8?B?Q0xFMG5QUjlXRi81cjVKRHZyNDVXbU9XK1BlcnJHWmNralozNENrM3l0VFJ1?=
 =?utf-8?B?NEZJd2toZ095NElFZnVqd3l3L2M0UWRGMTJ0YXp0ZmNPTjVlajMzYUoxZ2Z2?=
 =?utf-8?B?MjRoVUJnZmVmN2UrbEhiVDNLbE9tZjUrSFVsUWlQOWVQaHV2L0c0K2xaYlMv?=
 =?utf-8?B?Z1RWd2g3WjY2RUR3aElrRk82Rkhpa1p4citNK0Z5eUU4V0tIZExwa1pJOFVV?=
 =?utf-8?B?SFlaTkxHWUpKQk1hbnNyd21lVVRPYkVVZ2M4eU5ML2hQNTF6ZUtwUk12K1BB?=
 =?utf-8?B?dVVHMTBBSmVvTHlvRk42eG5IZTBLa1NMeWVNeERHSVN5WHZ5d2hCdzUvSmho?=
 =?utf-8?B?OW4yTlZEZmlxWnFrZ0d2QkZtemNhN0xQNXY4MStoMHB0K01YdTVEMkVSNXNE?=
 =?utf-8?B?VHBHaVpjYzFqNFBzYXdwdVZLTDB4VHM3YXdXQmZISXROMW40Zkg5OFdzakEy?=
 =?utf-8?B?RGlJSnJnNXpnSHNZOFI5SEV5VzdyNWIwcWRNaVNDQ1RELzQzZmhuemx5Wk1u?=
 =?utf-8?B?d3l3dzkzUEJmL1VFSE5nZ25Ib2JMbXBlSDBBL1ZMdm9FVjZPZHY5ZWUzNGZo?=
 =?utf-8?B?bXpieDRTZFNZcSs5MnR6eDRtM0ZrTjN4WFJ1Nlg1TDBUMERMWW1GWjY5MGJo?=
 =?utf-8?B?UFd6alU3eEJ6bUp2QVd2a2xVd2dzV3dNeERrU1hzUW10RllkOEd2TUNSQlNM?=
 =?utf-8?B?Sk1UQzZ4TDRLMkZibjJYbVdyS2ZFVE41Z0w4eDIyM0srZW5ObFFUSHh1N0gv?=
 =?utf-8?B?cTZlcG5mS2hULzkvNmtLUXJySTVQS0l1WWtvMlBGdjFvYVhTSUI0dXpLWjRX?=
 =?utf-8?B?eCs0OTNocVUwbzhXU0x2QzhMMVN1Sm9NL1Q3NE1mZjVtYXE2Wm9NUVRYWUpH?=
 =?utf-8?B?U3IwSVVaTzduMDhNaFFUNms0YkI5cllZT0cxYzN0QWVWN1lIMUE4dW1hOHJH?=
 =?utf-8?B?Zmdnblp3elFTOW5PUTE2aWFpY0ozUGl1eW9JU2tzMkcxQ2txVkFtRGZrT0lk?=
 =?utf-8?B?WlRvRnIvdlFNUlhPUG54bmxRMklDcWVTV3V5VDU0Ym5MZDlJNFMwSnl4eEdI?=
 =?utf-8?B?TzFyT0pSOHUwTkpoUGRCQWJTbDc3MzhiVVZmbjdJQ0Y1Wld2Q1hkUUU3VjdO?=
 =?utf-8?B?OGZid0xmY2dXb3gxSWp1QThKRU5NbDZpWlZXblhwV09zMDRTNk9hdU1HYTAw?=
 =?utf-8?B?YjhKUEJ4TnRQaFl6QTN1Z1NvZ0M0RXRVRkt6dW53aHVYUy9pNFo4ZWgzQzBJ?=
 =?utf-8?B?TEZtRzZFK3BTSTlBWGtJZWNvNnYrczlxd1RZZm1kV3YxWVNSU0FJS2UrOXEy?=
 =?utf-8?B?ZTF2UGpLZ0hlZ3BEd1F3NC90dHJJNktkb2FMOG1QcVVsQzh3UVpwanJmTldZ?=
 =?utf-8?B?emRXVDNHRDBYQU5TbzRVYUF2bEFDdEk3UzdXLzUrWUN0MHBHQlI4eGlERWdt?=
 =?utf-8?B?bXAwNGZ0MU1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 18:30:18.1039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16116e73-e844-4032-4cf3-08dd10a3e023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

Hello Vincent,

On 11/29/2024 9:47 PM, Vincent Guittot wrote:
> Move variable declaration at the beginning of the function
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c34874203da2..87552870958c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5632,6 +5632,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
>   static struct sched_entity *
>   pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>   {
> +	struct sched_entity *se;
>   	/*
>   	 * Enabling NEXT_BUDDY will affect latency but not fairness.
>   	 */
> @@ -5642,7 +5643,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>   		return cfs_rq->next;
>   	}
>   
> -	struct sched_entity *se = pick_eevdf(cfs_rq);
> +	se = pick_eevdf(cfs_rq);
>   	if (se->sched_delayed) {
>   		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>   		SCHED_WARN_ON(se->sched_delayed);

Perhaps also squash in:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3356315d7e64..321e3f9e2ac4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5476,6 +5476,7 @@ static bool
  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  {
  	bool sleep = flags & DEQUEUE_SLEEP;
+	int action = UPDATE_TG;
  
  	update_curr(cfs_rq);
  
@@ -5502,7 +5503,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
  		}
  	}
  
-	int action = UPDATE_TG;
  	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
  		action |= DO_DETACH;
  
--

while at it :)

-- 
Thanks and Regards,
Prateek


