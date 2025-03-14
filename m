Return-Path: <linux-kernel+bounces-560998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B639A60C30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92AC189C119
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D51F3B8B;
	Fri, 14 Mar 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ks9+E6LH"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424A1EE03D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942209; cv=fail; b=L7Nvo5N/AlxmodDYYkm/kg5MKWHtxALblyWVrQOsG/q6n9ZTnSI8BxaGJMDoQzVnxr9bt8uo6ZlBcW3K/g5Rl5C7hw/BhCGbrhMkK0MXGvzbTE2PRmtsZv7nF/JIAsEIiUY1b2NPhzWAfnX55Vfd76hU1iW9GgiEDrpZtkPLv18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942209; c=relaxed/simple;
	bh=t0+n3sNZ3uGKIDHglZH3DOyhTN/gMOqEXVQ9WmHSCSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T718nrTq4S+e+Sy1Jv9AYtI2DLM85R2eZ96R2iMSJEcOs2EAGEPNaFdF/pWT4eDoDKCitYV89uDeOLvHHzGXxv6Xy7YTML3jDzaUmrwGJdWinkOXwlJWP3aiimLkldk5vug2EveSs+EH3HARIwufYDZpMDC72py9riiMesWGEII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ks9+E6LH; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK/Y6z+4qxoNY6+gGh664L1mGhA1TyUqFJEfk2kvTtHZjegJaMtW4U8uvErow7TjBk0ngZwBDQSakeSiEf1pEyAlu7XMuvdvxWn3s40j0Zn+Yi/0x2iSbz1Gy2tPZkMGrg4yj7yvEl0kA+081SoN+5I0LTcab7te24KlB4iSmzFG78ZeooMYh13LFQtcXagmJp77kmPIDEEyqzrtrfoldEp6o/4IN7aGlNjc8OGAs0FlQS8hsREaSwB7bDXRgkgnpIdDErOFLoG3+vODjeWdjGun6kcdoOmAz3CANV1faUIpehji3XxyH+Mn75L1p5Lf1LBiaa7yIstLfqG4rg8PvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHpBxIv93GcOforQlcwLet7dQhe5dacf91rXUpfUCvQ=;
 b=MtOvd9f0DeiKwpVRic2kEPv8fxRJRbfktOiFlIV9+pm7iSDUsGH0MFhq7irj+dGOiqE0uHeWrd7kJ7axdasGuQi9me0MEWEKeGh8ivPw3sBT2mYpkCUnyMgcyJIa7sNYqh8k0/VNvw6wyp1/38J5Vz1MTJ9BzUHhrxDm/B4imVtMDo/IIJ7zzjNN8+juuGeYBwjPGppBitxGOjVJmlfkuiQK9r/tApLEbv9u8BXdugK83cxXJczjkgLmgnbgnDidHPQzlfhWqZ+ib1cTkaDO3EqhWBitykIkIeel05Jmp0y5Gd3lT07Ndr2SKHAhTmQStagLTQw1+UbNkR2XGL35EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHpBxIv93GcOforQlcwLet7dQhe5dacf91rXUpfUCvQ=;
 b=Ks9+E6LHXEY98+ghZ6h81le0y3fO1EpdV9t1oxWScUApSJlAq1ZagxzqXIXmp06dtTUz6I1JZ7CF2LZ7oJvmvCiVRZldkwa0bjp1Nm0BBtJRTqkwqUxCoZg6BMAeBHTAvypnj1MhG1NPVcCHOdtcxTYcygIp3C3p0WFr5uosHIw=
Received: from SA9PR13CA0133.namprd13.prod.outlook.com (2603:10b6:806:27::18)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 08:50:03 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::be) by SA9PR13CA0133.outlook.office365.com
 (2603:10b6:806:27::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Fri,
 14 Mar 2025 08:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 08:50:03 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 03:49:59 -0500
Message-ID: <0d0a4803-3e68-4512-b8d8-efd96e8d66f4@amd.com>
Date: Fri, 14 Mar 2025 14:19:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Chengming Zhou <chengming.zhou@linux.dev>, Aaron Lu
	<ziqianlu@bytedance.com>, Valentin Schneider <vschneid@redhat.com>, Ben
 Segall <bsegall@google.com>, Peter Zijlstra <peterz@infradead.org>, Josh Don
	<joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f43ebb6-72c2-4c17-eb83-08dd62d53615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TERGNnZ6ZW13RktKN1hIVmllc3lJRkk4Z3g0M3RXbG1WVWtzSjNJOVNzMnVj?=
 =?utf-8?B?KzJwb0t6OTN3VHBycWk0d3ZNNXd3UmlGbjFNTy9nd3NYSjZheHJqaFlVYjZL?=
 =?utf-8?B?WVRCenRUT0NyckltdFpTSkZyVDVGNHE4RytLaTdDb0dTLzBPK2prTUhBb2l5?=
 =?utf-8?B?TTl1WXhHZmpDRldVbU5KZjR5ZmZObE9idkQ1ZzdteTA0OVlkckhPU3JLT1Vv?=
 =?utf-8?B?SmtTa0dWREFQTWw4TzQ1N0F4YUV0dzEvMTU3OS9xRmRSUDgwaXBxOThwcDAy?=
 =?utf-8?B?RldUTi92SUlubVkwSUtDL1U2K0d0OFFIUXZ0MERkQ0N2MDJvSllyenRYVkNv?=
 =?utf-8?B?WUdVVDJoUEwwR0wrTTBlSUxnaUhrZ0IyajBOcHlxdmNiVGxqdW1nWTZHMHFi?=
 =?utf-8?B?Rm9PWHVTc3VyZmI1cE9zTksxd2lXZnErRXhYK2R1TUJQcmw5QllKR1ZsWFhO?=
 =?utf-8?B?b1d0ektHRW0vR2RKWlNlYkM5NW9BZzR6eEtYcUZSbWdXYnc4Y3E1N0NLRFFi?=
 =?utf-8?B?U3BrRU5NK1NJcnh2Z1BYNU1WREphbUp6dVF4V24zSmtaU216QXpOcHNjeGlk?=
 =?utf-8?B?RmM2dlFyVnVIWkJNRmtvMUlLanFlSGJCSWJ3NktIUDVNcGk5WU9QODBxTjI1?=
 =?utf-8?B?dWlPR2MxYWlOTEN3elVRRXQxM0Z1d2tSb09qTVBNYml0ZzJ0VjFPVDh3RHA3?=
 =?utf-8?B?cjhZU29aSkhXZ1VkTW9qMHJGK2lDYXUzY1k1YklXaUlYV2NJTytPdytYZ0VQ?=
 =?utf-8?B?SloxV0h2NXVqVmNxNlpCTjRWd0ltUFErR2ZwWXlxdVhTYjNTTG5PM0RCN0Rt?=
 =?utf-8?B?ck4zK3ZsVVhMUkwxdldseCsxQVBQTWhXRFUzZUpiL3NwUmg2VlpVRnliYm90?=
 =?utf-8?B?Zi93OCtDQ0NxMEg4dGxRaC9LUHNPTFpGSnczamhHU3VoRFF4RVM5bnNCNWxq?=
 =?utf-8?B?eWZoaWJ5VVY4UG5LVnBYcHBhYXlieXZTVmU0NlhQOWdGclNFU2dZdlZLN1dR?=
 =?utf-8?B?dmZuNHFENk5XTFlSOXFzMWNJQjBnM1p6TE5mSWIrdURoSk0rYTFtQjBGNjB2?=
 =?utf-8?B?dHlmaTQ4dXovdDJ3ejM3am01S005SkJiQ3VETWdnc3JXdjVDWjNOZzV5eW8z?=
 =?utf-8?B?NXk1VkRCSVdWMXdzelVKRkd1b1RIVDNHbldnTVpXeXM4TEVBdEhCMWFKbUFW?=
 =?utf-8?B?MzZubUpwemFlaFc4Y1dOWlcrcUh6eHhNekovV3lsMDNQN1VNZ1FTbFQ0SjI5?=
 =?utf-8?B?c3JWNHlGeDVaVjB1aDc3ZzBaVXhkaXZsSFMvTU5VSC9pa2RqK3E2aUFkczhQ?=
 =?utf-8?B?QklzSHpBQkdSS05Td0RZQjIyTUpSVE1sa0JPWm5CcUpIdWl0cGZkQjN0bkhk?=
 =?utf-8?B?RE9VRnlVK3BXRms0aFl0aU40M2FXKzZBbzV0QytvZVUyYVRuSnJZUm02YXdK?=
 =?utf-8?B?SktTMHkyMkxPVjlESnpuMHhHT0VzbUdWRGE3bnFHSHdoeTBVaXlpR3ZyS1ll?=
 =?utf-8?B?RGVVaDZmMHp3Tkg0cFJxQjJLZGM1c2Qwa0VGUE40aXlmY1dadDRySjMzbnMv?=
 =?utf-8?B?Y1ZlNzF3Y0tUbHFXay81enQxakJmTkNBdE41c3NHQlA3bUZiT2U0Zi9OSFZI?=
 =?utf-8?B?OHZ4cS85ZzVvRzNUUitmWHk4MTdhbnRKNExXNndYcE5VWkd3Qm4vdjRIamt2?=
 =?utf-8?B?MThBejdBeUllM2htZzFFRmhrczFhVmZpUW5SS3lBL0dxRURkOTBpbzFSNjZI?=
 =?utf-8?B?cURSMWt4S2wyMG4vVVBCUU1ETE90YXNHL25EWXJhbnVTVGNkOGZ3bHRDdFEw?=
 =?utf-8?B?eVFXRjFiNkpEQjU0QmRLZFR5ZjdOc0pJZURuL0ZuNE9rRjJLa21LQmhXOW8r?=
 =?utf-8?B?SElaMmFneFk3Z1FTMWdsQ0VvWGd3WXNwQW1hQnAzb3h2UWdxc05IMU1XSklF?=
 =?utf-8?B?L1JUeUR0YkZnVDRxSE5zT01BRzVUVmR0YWNxZDl4SHB2amFmZVJkVDR3Z2R1?=
 =?utf-8?Q?9fGAMBBvJcegJS75Y26Zm2TIoQuU/I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:50:03.0815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f43ebb6-72c2-4c17-eb83-08dd62d53615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

On 3/14/2025 2:09 PM, Chengming Zhou wrote:
> On 2025/3/13 15:21, Aaron Lu wrote:
>> From: Valentin Schneider <vschneid@redhat.com>
>>
>> Once a cfs_rq gets throttled, for all tasks belonging to this cfs_rq,
>> add a task work to them so that when those tasks return to user, the
>> actual throttle/dequeue can happen.
>>
>> Note that since the throttle/dequeue always happens on a task basis when
>> it returns to user, it's no longer necessary for check_cfs_rq_runtime()
>> to return a value and pick_task_fair() acts differently according to that
>> return value, so check_cfs_rq_runtime() is changed to not return a
>> value.
> 
> Previously with the per-cfs_rq throttling, we use update_curr() -> put() path
> to throttle the cfs_rq and dequeue it from the cfs_rq tree.
> 
> Now with your per-task throttling, maybe things can become simpler. That we
> can just throttle_cfs_rq() (cfs_rq subtree) when curr accouting to mark these
> throttled.
> 
> Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
> for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.

+1

That seems like a good idea with per-task approach.

> 
> WDYT?
> 
> Thanks.

-- 
Thanks and Regards,
Prateek


