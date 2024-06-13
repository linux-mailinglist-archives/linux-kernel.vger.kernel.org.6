Return-Path: <linux-kernel+bounces-212552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A0906318
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1F2284665
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D01132131;
	Thu, 13 Jun 2024 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qJq7oKg4"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307B18C05
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718253663; cv=fail; b=cOKvo76fYHwCuBBu4AVDcVLtr5q3JZjkYPOr6UHMqfgGUQxdJJO58naTL1fbfsNEUoavmowbzgnc9ezAR/lleLkxQ09Pe6Lt0zEBnJo6ohiLqIkhKgXRpBjODDQxJ35uSwSD/q/X3sQJubZf+a7WgycS3aRYFRLQmPfWzc+XX3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718253663; c=relaxed/simple;
	bh=kG/LethP2f75at+eNoTP4tWnn20IatodlLMLeiOkhGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pfduZ8WA36Y7YBVOGsjnpRrtZlJUdWNCB0uBPakgQvnQ3IM0Ydrf7WqqV0beqN4ahtQFRPiJmdkTzTqe8Q85iHbMSNYPimZ5cLDggXhfQj5M1AcvLJVqwK8L3HmrHrS7HwXdYYkJRhe/K+L0FLWFGMPijb0W5Pm4J19tB1r3Cm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qJq7oKg4; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrXM0TL98wj0eylBpnit8Mzt8d5nM3UhVD+r20Mi/y9H4BU1rh77X9Niw+9Zq2uQZb8QJask/o/zHs2eC2rlPXWSe24w8JI7U4+4tXidKvyhOVcnvmtQoR6KcolYI22tz0El1/kPlWRmMdZEAAZxjyy4wujg/lAV3E3rdw+e79hyME6F/OnpEBjS6IQL/MRi9zzHaGw/ULLASuZ33BBf6VujE9CEBfpnZITe89uaQGRPZAV39wVRi/5EMNHqAvbVuqnsUA4r+mB+qJhgnzeC2leLNryMmtfl8KCbC+AUdOHlEyr743pv1S7KEwqOs5vmogu8gap1/HjfPyhTGHzanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=247Pu+Xi8dFvyBjk5pcfAfXqOdG6L0KQYMQ3GEImZcE=;
 b=jT1MkOooRoR8weaMqexPN50yULV+mmXKMC7dT0JgHWVkqUo7yrpjEobS1N3NBLXnPVGI/sF9kiQoZ5RrZrGFMBuvEVvVb6KldrNf5GG7qnLAdiWOV8gJdLMnvpVEzj7SOlSeKq02MiZJvU/JhGs0+WYaccJrhYj8XqR/EXna8ffAZcmJpn35whLBGaH2MfaE7XqXAx15UjY2lOnY2ReHKacbIimoPkEniP6p9Yymnh4z1sqklPxITN1vOk9JIN0zVGTjczJHDUelzQNtTrpz5BnbVzY9Ds8tAgN7wbIGZif4WHHAsXtuOLkcBE6WcpWg332PjgFJS997W1+nzVv9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=247Pu+Xi8dFvyBjk5pcfAfXqOdG6L0KQYMQ3GEImZcE=;
 b=qJq7oKg4RCK6ms6Q+SxoMFc76IwEe8wEO9hghs33Pq2BsnQBVMHjJpxm4zkNXy+dLIIXdhvA5qm6o8b00uoADuFOT2ygGOi/eeGXBLDjYdrx1SmkHwwOdq+yfIAhKTaA0oI9L+cU7MB/bgcDxlplTKfY6JJBNn4+Md1wMzUwwnY=
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 04:40:37 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::d3) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 04:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 04:40:37 +0000
Received: from [10.136.32.87] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 23:40:33 -0500
Message-ID: <65c19534-6eaa-a7c5-2131-b9e6cea8e7c9@amd.com>
Date: Thu, 13 Jun 2024 10:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/fair: prefer available idle cpu in select_idle_core
Content-Language: en-US
To: <zhangwei123171@gmail.com>
CC: <linux-kernel@vger.kernel.org>, zhangwei123171 <zhangwei123171@jd.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>
References: <20240612115410.1659149-1-zhangwei123171@jd.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240612115410.1659149-1-zhangwei123171@jd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b57d7f-aac3-499b-ceca-08dc8b62f8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|82310400020|376008|36860700007|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0NnbHRjSVNBSHU0UmNicDNzbDgzNlJHUVBCRVd4cXNPbW1UMzRsbmg1Sldn?=
 =?utf-8?B?cVNROGJ5TG9kelE0Z21laHlTNjhnVXRwc1NKSXZXSzFMVjRNUWkyM21yNW8v?=
 =?utf-8?B?a291d2U3NndHMzRnRjNZcmp3WTJPbEg3MjNUbWIwUFltejFQS2VqSExmU05a?=
 =?utf-8?B?aUhkb2lyb0p2NldGUUJIMDVGM3dQSWNCYnIyRWJrTFoyM3JNR0pCay9QdlBW?=
 =?utf-8?B?bzlFTlBmaFJOMVlhRDg5SkZWbmtzQzN2QWtBdXYyRC9na3pwamZQclNqQWJx?=
 =?utf-8?B?K1RMZEVjdkJoQTRpNHdTOVYveUJrbDJ2bVFMT29kVjhYNk94dExQdUlkemJH?=
 =?utf-8?B?eTBGRGJuRzNoeW1INHhTOElnMlEyUW9PR2tHa05Dd2JqTEpna2hPSkRBS1lt?=
 =?utf-8?B?R21oc012UDI3TzJFcFRmUjVuaUdVYUJzUlBhTHhMZlNCY0NrbDdkSXp6N0JS?=
 =?utf-8?B?V2oxSUJxVzNzQnF0VWtzQU9LeTNNZXlsUjcrWkpYb2lUM3RFYmhibGduQ1Fj?=
 =?utf-8?B?ODdPZjlURGljR1hJVklkSnpxdzFkcTVtcVBzOXUxRlgzTUFVdjdpalhUOHNQ?=
 =?utf-8?B?cGc3Y3JiNEp3VlJsZTVvbjFqb2E2T0RtZnJyQTRIUkFLY080VitmaWNyaFpl?=
 =?utf-8?B?WkZxVHQ2cCttWnRlRENIRk8rMHQ1czhyMnNDa2Fnd1doOVRSaVFMOFBlSWpm?=
 =?utf-8?B?T2hGQ0dpaUhoeVViRHVYeUJzTW1GMloxQjRMUWs1czd0MUVubmVpbXUwVjJQ?=
 =?utf-8?B?aVpTUnNVMUFVVHdIT3dwaEwzTUtuWGFOVmtoUEtzeXpDNG9JcDkyUDcxQlNW?=
 =?utf-8?B?SVBiVkxYSEsveHFvNjF4WUdvSVFpNDl0TEdHS1d3OHV5cmQxdVd1WGpRSjBB?=
 =?utf-8?B?a1dzTTU3ZmFFb1FLZnpMNGtMdW9ENGRRdHAzMnVnMFVBSlVtWnB0d1NrVDF3?=
 =?utf-8?B?Rnh5b1VEeGVDbXdhaGx1T1FsNmdqd0FXYkpEa3RGc0lKaUdnOUhkd01YQXlk?=
 =?utf-8?B?eUxvNHQzajkxRXZBM1pKYTZrZ1N4bDRZMVNDbXZIMDBES2E2OVlEcVl0VElr?=
 =?utf-8?B?WE1BV2k3MmNsakYzZ1J3SnVYcG5ZVEdNZ1ZuR3FpQkM4WkVZZkVUckliejE1?=
 =?utf-8?B?b09DR3lSUjJIclYwK08zV2FGUVpQMllySFJwU2pvNnYzeWVRZVBuTW1PMm4x?=
 =?utf-8?B?dlBPd0pCaisrY2hHWmhaTmp4YXNNZGJWNmFvZExCY3h5Z1ZtL0R2YUp4cGlW?=
 =?utf-8?B?YXhoOEFNVlQ4eVJTR293Rnczb3hFSXp4VnpuanYyZEl0TkdVL25BcENmdHlE?=
 =?utf-8?B?RERnZXI2ZUFodkxuZmtNYit0MEVCN3VodW44NTZiTnFhK3dONkVGREp3RG9J?=
 =?utf-8?B?ZTc0UVdabDJJK2p0L3gvWURjQlhPUFdaQkl5MUR2OWQ2ekpvaFlWVTR4SFY4?=
 =?utf-8?B?TGtGK2lUdWZaakVpa1JOdHpncGZlVXZZS0JVc3BON1h6MUNrQkUrdmFvanRs?=
 =?utf-8?B?aC92TkMwbHArNUk1dUNna09rbUtpRWJZRTNEZVZhSlNrQ1BGa2NETUVpZ1Iz?=
 =?utf-8?B?M2t5cmgxWmZQbU1jQlRBMmJwY2FvTTV6bzFKODM3dnB2RUlQTWlPTFpUTXF4?=
 =?utf-8?B?WHprSjYvekU4V2RFcXBuZFg3UFE3dHk3Q2Qzaks2QVpUMTFDaG41Skp4NFRp?=
 =?utf-8?B?eTE3R2FQcE1xTnRMRkFDMVZueitId0pRaTRSd1Y0T0RlZXhKdHp2ejhOWjJk?=
 =?utf-8?B?dkV4d1VEaDNCSGdDdmZLaGlUdUZFUnBpU0p2bENYVUVXUmdLRlRHSDA1NlN3?=
 =?utf-8?B?OUN0U1loTHBJMjZjazRoeDNoNk1uRUtaUEIyVmR3NG5hVjEyU0pUa0syQmVD?=
 =?utf-8?B?NEh5TkxlM2JXTnExcFRmNUNsNEpOU1ZVNkg3QkpDbVh0V3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(82310400020)(376008)(36860700007)(1800799018);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 04:40:37.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b57d7f-aac3-499b-ceca-08dc8b62f8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

Hello there,

On 6/12/2024 5:24 PM, zhangwei123171@gmail.com wrote:
> From: zhangwei123171 <zhangwei123171@jd.com>
> 
> When the idle core cannot be found, the first sched idle cpu
> or first available idle cpu will be used if exsit.
> 
> We can use the available idle cpu detected later to ensure it
> can be used if exsit.

Is there any particular advantage of the same? Based on my understanding
the check exists to prevent unnecessary calls to cpumask_test_cpu() if
an idle CPU is already found. On a large core count system with a large
number of cores in the LLC domain, this may result in a lot more calls
to cpumask_test_cpu() if only one core is in fact idle and there is a
storm of wakeups.

For SMT-2 system, I believe any idle thread on a busy core would be the
same (if we consider all task to have same behavior). On a larger SMT
system, it takes more overhead to consider which core is the most idle.
Consider the following case:

o CPUs of core: 0-7; Only CPU1 is busy (i is idle, b is busy)

   +---+---+---+---+---+---+---+---+
   | i | b | i | i | i | i | i | i |
   +---+---+---+---+---+---+---+---+
         ^
   select idle core bails out at first busy CPU which is CPU1 however
   this core is only 1/8th busy.

o CPUs of core: 8-15; CPU10 to CPU15 are busy (i is idle, b is busy)

   +---+---+---+---+---+---+---+---+
   | i | i | b | b | b | b | b | b |
   +---+---+---+---+---+---+---+---+
             ^
   select idle core bails out at first busy CPU which is CPU10 however
   this core is in fact 5/8th busy.

Technically, core with CPU0 is better but with your change, we'll select
core of CPU8. Bottom line being, there does not seem to exist a good
case where selecting the last idle thread is better than selecting the
first one. The best the scheduler can do is reduce the number of calls
to cpumask_test_cpu() once an idle CPU is found unless it decides to
scan all the CPUs of the core to find the core which is the idlest and
in a large, busy system, that is a big hammer.

Thoughts?

> 
> Signed-off-by: zhangwei123171 <zhangwei123171@jd.com>
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..653ca3ea09b6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7341,7 +7341,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>   			}
>   			break;
>   		}
> -		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
> +		if (cpumask_test_cpu(cpu, cpus))
>   			*idle_cpu = cpu;
>   	}
>   

--
Thanks and Regards,
Prateek


