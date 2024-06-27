Return-Path: <linux-kernel+bounces-232443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DF091A8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11183B26A95
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E07197531;
	Thu, 27 Jun 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="An+5JICv"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B3195380
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497618; cv=fail; b=u2IEEt49TRaOp9YQNkQGM/nHRgYdrMwsbciy/qO+o0ASu01fgThu629lZAKSwpxPEx9THDxu1HSpMsQAqAUlfxRJ24pRVVn28PzrY8NKCQl+Ol50xlE5U7/+Jaij/asIggN67ZUH8gPIg3Do50gNaMsawji8KYBCpX/nBwdu0Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497618; c=relaxed/simple;
	bh=zxf/PFtNAdrdfT5kzk8y37AcrNwM1kNzV8MoBu6pl6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SQ7u6W0kDq/lDWK9EaugZLUZm99zY2t0DhQsGYts2cG0Ugx6ZpLLic8G5IyzSxiUQ8ObacucToIq73UpH65xdr9hnLVZRZoCvhTwFQwbG9usqX+hYAjJcBMcUcXb/H1gG0Onw7zINiIf+0IwNU1DX9+2WdtLKPNT+jnI/Ac7j5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=An+5JICv; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmF7jHjisLAIEPTLJCZWbxL+ycs48JteNau0LnsxCk36jxw9hCjJPbUBBIVY9uh3QFXWDAyxSqe/YYQsF8DrVccrt2OVnOl1WG/TrNmC/xbpGjurMdSyyfpEBkQ81McpkrgDfn4VKIUpKl+SjzaSgCnhB16sm6S9JjbRvbPcgtn2XvuX+8EUMcoBMcE1NDE8Ey+gSBXksjaA/QYrnzVVKsyT/T4BEgF0hAcuexBOfALy3EDDwBISgG3WUFjPb12vBSx9Ej0z3MEuWXwTp7tYYuf0yprnWAfy17pKIZ9ZqbbvTziy6UJv/tYTZ5tR7kTO5BaVXfNlUVK3tZ3/MRaHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOcaoc5LyHnpovx/jtYbMdeqogK70FrcVg1jvwq2m7c=;
 b=jzyFGuVEkLDFatSjcTsnM6lRp+qTTGeibatGoG7Av1ZDGjtRhGlR+/H4DVG4LYRLcWQD/7U7s9QmroUmZBy9jWiLJ3i/x9zw2sO1XuAc6oIOj2xxBKwkqEq76Lw13tfkt6qiiax7KsHdMeEe0Rrv9Tqf+4PcAuZNsJde4LdAjv5LAyylsnSYgrWz/Sfm4/xlg7df3MEWJS88y55WpgWXFoUCHIlzyOX3mHG7siBxtStzH3OfkxjR8FMpBKLS+3dwJnTJ3io6mtwWdhmOLWRbxruBPmWRm02pccZmwE8Rcq263r2zTZnE99JN9DM3c9/R4lwU65VhbSqBsXbebxXeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=inria.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOcaoc5LyHnpovx/jtYbMdeqogK70FrcVg1jvwq2m7c=;
 b=An+5JICvcJEARxslVrpuYX0wAb5OKQ58eoWkSqc+UgJGEaOTx+AEOTAREE3M/SHyFJcMht79Cw5fJ8+yAQZwPFXCrvVtlu1s+yUteMJw+5pzCS5Wa1M5GT7ZDm3lHkfm50XUq/O3a+xur6St3z38wu2orVQX/69sxmaiK5oXAtw=
Received: from BLAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:36e::15)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:13:32 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::89) by BLAPR05CA0015.outlook.office365.com
 (2603:10b6:208:36e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Thu, 27 Jun 2024 14:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:13:31 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 09:13:26 -0500
Message-ID: <bb174ad3-e5f6-8643-21f4-40604323c00b@amd.com>
Date: Thu, 27 Jun 2024 19:43:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: softirq
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <ef964f57-7c9d-aa77-c958-793c899dc4d9@inria.fr>
 <CAKfTPtBTc3Z_oK_Gg=79g4eUfA1iUat7gsZ2wqKkj=QXULYzng@mail.gmail.com>
 <cf7716fd-a148-aae2-45d-94862549e20@inria.fr>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cf7716fd-a148-aae2-45d-94862549e20@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3902fd9e-f28d-4794-435a-08dc96b352e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjBOOEk0TEZqMDhiTis4WFJ6TE5UWk9XMm9KS1ZsMkJZYS91d1VKMVY2MFR5?=
 =?utf-8?B?ZTZHeUJvM0M0RDd2MCtHR1A4V0FaU29haVRueVBWZmIvbno2T2dIWndVWHJK?=
 =?utf-8?B?N3NGL2ZsUjFLU2Y1U0xORmswclhtMnNWU0Z6K25ZTG9TM1VHWC8vcm5pMzEv?=
 =?utf-8?B?ZXd5UkVTUUpGMTB6VE4rMVF1YVJPVlR6WEF4RWtCT3J0Zi9NK1VpclFXQ0l5?=
 =?utf-8?B?ejh2b2tCUmluYXVjOUdoOGI5NkI1SGN0bExGckM1dFNrQWIwWkFtWnZtbklB?=
 =?utf-8?B?MkhZMWVmZEJsS2liZjhNSUtPMnBtb2trTWFUaUYxbVRFeWZiR3c2bVZvaWxY?=
 =?utf-8?B?dzFFNllVYi9VQnhIY3ROdnF4Y25tcS8vSGV5RzFoL0E2SlZsWUc5bGxEcndZ?=
 =?utf-8?B?bFZiNTJNYVc1ZDdVcnNiMFBPb3hSTG4vaFFSdGRnY0JxS2FtZ3lUd2RFWWtl?=
 =?utf-8?B?bjZJVUtaRGJXTlRsOEdmK2h5bmkrckRCUjhLWjVYUVRadXg3VEJCdnJJbisr?=
 =?utf-8?B?QXFRMzVpUmJKVUxSck5hTE80UTZjdEhyb01UUnQ0K1RYUTdnZUhsS0VXWUtt?=
 =?utf-8?B?VERTdjk1bW5RdTR2OTgrRFhSby9Dc2lkK1diVXEwWWszdHBRbmRONC9iTXpG?=
 =?utf-8?B?Y2t4SVA5aDZ6TS9WY3NYaVJzZW5lQnN1amtTZFZnak9DRFpnWUdGcytJN01R?=
 =?utf-8?B?bmVaR0dSNjBnWXJ0STJiajF2TkNCQ2dIU0MvV1VLQk1STkhZTXVRNlM1MkRu?=
 =?utf-8?B?WmF1QlVmUjR6Y0ptWmd1MS9Ec3hUc0hBV2lWRVE5MGxMZEZ1L3o2RW0wdEtH?=
 =?utf-8?B?OFhoUWd0ZjVHZFNURStKendkelRVTUV0Vm85ZjU1anFlVHRqRlpTT05yend5?=
 =?utf-8?B?YVdIQUtyaVZoTlRMaDdMSUhLMTJKLzArVXRwQ2xlUml3Vjg4dE9VNkVQa2RP?=
 =?utf-8?B?OWNNempVMEpMclpvYm5JTmFJQVJ1djB1UGhNZk1yQm1ScFV4QVZncmdvNVJC?=
 =?utf-8?B?REZyU05JL0hIRnVMQjUwck0xMjNwYWVQR1hidU8yYkJydDdOaWVRTjkzUkZq?=
 =?utf-8?B?aFMyM3F5VmNQTUd0dHFXY1NjK2hGN09nVVRINU5CaVp2Q2NDU29RcnJhY1VK?=
 =?utf-8?B?RTQxOGtkZ0h0UEZ5U2pOanNjZG5kYzNEeGQzY29JcllOdVVudnUxWFY2QWFz?=
 =?utf-8?B?d1RGSmxYMjhsZ2QxdlFKeis1SkZ1M1RKcndSQjlsRnczbmc0c3NLeklZMElB?=
 =?utf-8?B?ODVlRmQ1N0EwTllTWEZ0WjBsMndxUkVyaldoL3RBK2JCbXJzQXpFamRxb09J?=
 =?utf-8?B?QXN3K205eFlIdE5tdGl0dEJrSW5nN3k4R3dLelprUHcrRXZUWVkyTXRwdXFP?=
 =?utf-8?B?aWRJcVZ4Yk5ZQVFoM3lsL3FxN3krOFVkTWhrb2NzOE5nQ0FTdFg1L1ZFb0Zv?=
 =?utf-8?B?OHJBYncrSnZNOXlRTnpKR1JqSFlpcXBSOUpELzN0SnNvU1RydzJpZDBNcGQ2?=
 =?utf-8?B?YWJJZ1A1V1VxczFNVXdrWkJsSjBCUlFkcjUwaCtVaW9xaXdsN1hudGNjTUVP?=
 =?utf-8?B?NHFmRWIvdGtubDlIWTFoTWRrS2p1bVNUeTBxT0FUdVdLdHcvSU1TU0xibDEy?=
 =?utf-8?B?VWV2WGkwS1ZIT09LNXJ5RFcwTm5rSUtxek1pQTVGRGRObmVHUmg0bWREaWR4?=
 =?utf-8?B?NHJjRWZiOUFkV2czbDJteGZURzVyS09QbFZld3VwZ05iN0hwUno1Sk9QZjVN?=
 =?utf-8?B?by9lZTA4bGhUV1FYRS9La2tWa0JNV1hwQXdyRkwyVElaU3JlT3Z0dVh5eW5Y?=
 =?utf-8?B?T3U3UFhjQlg1eTZZaVhSamtmMURhT1dhSzBVVmc5NXQ4U3NaTXBLbW1CS2hU?=
 =?utf-8?B?UFRYMEFtczlhQm0xZDlOMW5USGcxWkFJTVV2cTk4bG80NDlyZ0ZXR0MydHFG?=
 =?utf-8?Q?a0g7hSfJeBdBClad9y+bA4bljB3jWMul?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:13:31.3474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3902fd9e-f28d-4794-435a-08dc96b352e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

Hello Julia,

Some data from my 3rd Generation EPYC machine.

On 6/27/2024 2:37 AM, Julia Lawall wrote:
> 
> 
> On Wed, 26 Jun 2024, Vincent Guittot wrote:
> 
>> On Wed, 26 Jun 2024 at 07:37, Julia Lawall <julia.lawall@inria.fr> wrote:
>>>
>>> Hello,
>>>
>>> I'm not sure to understand how soft irqs work.  I see the code:
>>>
>>> open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
>>>
>>> Intuitively, I would expect that sched_balance_softirq would be run by
>>> ksoftirqd.  That is, I would expect ksoftirqd to be scheduled
>>
>> By default, sched_softirq and others run in interrupt context.
>> ksoftirqd is woken up only in some cases like when we spent too much
>> time processing softirq in interrupt context or the softirq is raised
>> outside interrupt context
> 
> nohz_csd_func calls raise_softirq_irqoff, which does:
> 
> inline void raise_softirq_irqoff(unsigned int nr)
> {
>          __raise_softirq_irqoff(nr);
> 
>          /*
>           * If we're in an interrupt or softirq, we're done
>           * (this also catches softirq-disabled code). We will
>           * actually run the softirq once we return from
>           * the irq or softirq.
>           *
>           * Otherwise we wake up ksoftirqd to make sure we
>           * schedule the softirq soon.
>           */
>          if (!in_interrupt() && should_wake_ksoftirqd())

I think it is the !in_interrupt() check that fails. When I disable C2
(which is I/O Port based C-state on AMD) and only leave C0 (Poll loop)
and C1 (MWAIT based C-state), both of which set TIF_POLLING_NRFLAG while
idling, and I add the following log line:

	trace_printk("raise_softirq_irqoff %d %lu %lu\n",
		     preempt_count(),
		     in_interrupt());

just above the "if" condition on previous line, I see:

#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           <idle>-0       [000] d..1.   364.875516: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   364.879504: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   365.299507: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   365.963524: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   367.291500: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   370.339504: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   371.875481: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
           <idle>-0       [000] d..1.   374.875462: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
	  ...

(Note, this is only for SCHED_SOFTIRQ being raised from nohz_csd_func())

Since for !CONFIG_PREEMPT_RT "should_wake_ksoftirqd()" always returns
true, we end up waking softirqd for idle load balancing. Note that
"hardirq/softirq" column is always a "." since nohz_csd_func() is
executed from "flush_smp_call_function_queue()" on the way out of
do_idle().

With C2 enabled, which is an I/O Port based C-state on AMD and does
not set TIF_POLLING_NRFLAG, I see:

#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           <idle>-0       [000] d.h1.  2880.497140: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
           <idle>-0       [000] d.H2.  2882.193270: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65794 65792
           <idle>-0       [000] d.h1.  2884.857103: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
           <idle>-0       [000] d.h1.  2886.769577: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
           <idle>-0       [000] d.h1.  2886.989832: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
           <idle>-0       [000] d.h1.  2887.281561: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
           <idle>-0       [000] d.h1.  2887.825556: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
           <idle>-0       [000] d.h1.  2888.817564: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536

Raising of softirq here happens in "hardirq" context which, I believe,
will lead to SCHED_SOFTIRQ being serviced on the way out. When enabling
soft_irq_enter and soft_irq_exit tracepoints, I see:

           <idle>-0       [000] d.h1.  3309.994942: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536 65536
           <idle>-0       [000] ..s1.  3309.994943: softirq_entry: vec=7 [action=SCHED]
           <idle>-0       [000] ..s1.  3309.995026: softirq_exit: vec=7 [action=SCHED]

With the former, I do see nr_running > 1 whenever "ksoftirqd" is running
"sched_balance_domains":

      ksoftirqd/0-16      [000] ..s.. 10153.805434: sched_balance_domains: nr_running: 1
    ksoftirqd/168-1038    [168] ..s.. 10163.765221: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10166.761349: sched_balance_domains: nr_running: 1
    ksoftirqd/120-747     [120] ..s.. 10166.809204: sched_balance_domains: nr_running: 2
    ksoftirqd/132-820     [132] ..s.. 10166.813203: sched_balance_domains: nr_running: 1
    ksoftirqd/246-1511    [246] ..s.. 10166.845532: sched_balance_domains: nr_running: 1
    ksoftirqd/107-668     [107] ..s.. 10166.853201: sched_balance_domains: nr_running: 2
    ksoftirqd/120-747     [120] ..s.. 10166.865359: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10191.273328: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10193.137307: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10235.057105: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10320.172832: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10323.708863: sched_balance_domains: nr_running: 1
      ksoftirqd/0-16      [000] ..s.. 10338.912787: sched_balance_domains: nr_running: 1

-- 
Thanks and Regards,
Prateek

> 		wakeup_softirqd();
> }
> 
> My impression was that wakeup_softirqd was getting called.
> 
> But it is true that if the code is being executed by idle, then
> in_interrupt() should be true.  So perhaps it is someone else who is
> waking up ksoftirqd.  When I switched to __raise_softirq_irqoff, the
> behavior seemed to change, but I may not have fully understood why that
> happened.
> 
>>
>>> (sched_switch event), then the various actions of sched_balance_softirq to
>>> be executed, and the ksoftirqd to be unscheduled (another ksoftirqd)
>>> event.
>>>
>>> But in practice, I see the code of sched_balance_softirq being executed
>>> by the idle task, before the ksoftirqd is scheduled (see core 40):
>>
>> What wakes up ksoftirqd ? and which softirq finally runs in ksoftirqd ?
>>
>>>
>>>            <idle>-0     [040]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
>>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting nohz
>>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting _nohz_idle_balance
>>>            bt.B.x-12022 [047]  3611.432554: softirq_entry:        vec=1 [action=TIMER]
>>>            <idle>-0     [040]  3611.432554: bputs:                _nohz_idle_balance.isra.0: searching for a cpu
>>>            bt.B.x-12033 [003]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
>>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: ending _nohz_idle_balance
>>>            bt.B.x-12052 [011]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
>>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: nohz returns true ending soft irq
>>>            <idle>-0     [040]  3611.432554: softirq_exit:         vec=7 [action=SCHED]
>>>
>>> For example, idle seems to be running the code in _nohz_idle_balance.
>>>
>>> I updated the code of _nohz_idle_balance as follows:
>>>
>>> trace_printk("searching for a cpu\n");
>>>          for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
>>>                  if (!idle_cpu(balance_cpu))
>>>                          continue;
>>> trace_printk("found an idle cpu\n");
>>>
>>> It prints searching for a cpu, but not found an idle cpu, because the
>>> ksoftirqd on the core's runqueue makes the core not idle.  This makes the
>>> whole softirq seem fairly useless when the only idle core is the one
>>> raising the soft irq.
>>
>> The typical behavior is:
>>
>> CPUA                                   CPUB
>>                                         do_idle
>>                                           while (!need_resched()) {
>>                                           ...
>>
>> kick_ilb
>>    smp_call_function_single_async(CPUB)
>>      send_call_function_single_ipi
>>        raise_ipi  --------------------->    cpuidle exit event
>>                                             irq_handler_entry
>>                                               ipi_handler
>>                                                 raise sched_softirq
>>                                             irq_handler_exit
>>                                             sorftirq_entry
>>                                               sched_balance_softirq
>>                                                 __nohe_idle_balance
>>                                             softirq_exit
>>                                             cpuidle_enter event
>>
>> softirq is done in the interrupt context after the irq handler and
>> CPUB never leaves the while (!need_resched())  loop
>>
>> In your case, I suspect that you have a racing with the polling mode
>> and the fact that you leave the while (!need_resched()) loop and call
>> flush_smp_call_function_queue()
>>
>> We don't use polling on arm64 so I can't even try to reproduce your case
> 
> This is with Prateek's patch.  So need_resched is not true any more.
> 
> thanks,
> julia
> 
>>>
>>> This is all for the same scenario that I have discussed previously, where
>>> there are two sockets and an overload of on thread on one and an underload
>>> of on thread on the other, and all the thread have been marked by numa
>>> balancing as preferring to be where they are.  Now I am trying Prateek's
>>> patch series.
>>>
>>> thanks,
>>> julia
>>


