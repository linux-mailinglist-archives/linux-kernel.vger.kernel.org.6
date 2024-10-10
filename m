Return-Path: <linux-kernel+bounces-359520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E4998C96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F751C24728
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3421CB32D;
	Thu, 10 Oct 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QBuJjJrG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED551CB537
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576011; cv=fail; b=l7pkpIuwgAz9GAcALK1dWWXkkEbb6JSIIJsggS86ASnGk7mGFsd+arJygGbpCxv/4LX8UfngjfH2Cwwj6Rr7rTqAGm38V4/+XwwqKH6m0h86tAqy/MJkKLPVXibR2Ux3dKHG7bsQxPIQSiZR1j8yTrXznAksXbez7MMF2QjTHf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576011; c=relaxed/simple;
	bh=xMUnM2GtbPxqxj7BIuhW7E/Q2M7lczvJY6ADdMVXx80=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=btEKfmyfY1PfShi/J78WhXRyFe6FLlkmJwAOvJpmPRaeCnrswC4+Fmu6e2LaN4CDV5axdV5I5K4mirl5S3P0a3X9h/LIrvaRZbgWfl9bBMxqv0OMkzSEM/qoH6ErukwZ6YXeZXBlR7cJ4JM/iWpyOjcKpEJmXfvZgia5w5JWC/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QBuJjJrG; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Agm658lo7OSMVBWTYJGf0M4199FY61BB3fOkDet+nRvp6ifRt3hkl3HIHs9MiPftJzQewDHHo80ZjWIaGgFwl2+A5NZIeNnEYRc/s3V2Lepjoj2VwYTV0Wb4zJV89DwXhcVpdhBas5kuvf+KF3X5ABTdrEnDAFysanGHizsSF7A2DQXo4arNwzfEEMhslwjkhGt+NiIcPxwPqmqyQHYbgdMYi/con56N8jGtimDFgYyhhHZuoOrzGJ7Ju6KCnN0UDaET9GwUnFldV3oeGNsu4ngxRpVpIk6OzFz5CG3oa8rLAeiYgF8rIbZCk74NBpOxcuefzcSBn/KLBH0Q2Og8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nEYfEkNz8AtLQJHlsLgG8tLsmis1rmdJs5WghEMGO0=;
 b=Zxijke6q4iZZVWqinI1mMbmQN2Ew0nLyeYmowjNjEmTsvXrJRWC8vLJ0qhEyRqXBhsj10EE7iitvOsq4r2MsvFSjQFz69mjFqntTvjhlVIYF39SBBPIfMvyzaB/6j0EN7Zb613AYRBpw8g9l1EIDLhxvGxR5QUIJrajXVXCqGGBwat9ST3mjrkoAGEWufY9JrnNnzBGjQRdOyi6FjVDlIll9pp2RCrCjHEeqPotN844XYRPEpIJKpHBUOlp8p8X8DzPvmCIKJcsD9WYH+bid/BrutbbY2lgRzzVWOViaGz3f49DS5WledWazgqvT2ZMsOc8YQMKuuQQ7ljMh2Na7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nEYfEkNz8AtLQJHlsLgG8tLsmis1rmdJs5WghEMGO0=;
 b=QBuJjJrGPaL869gNJ14ozZremCCthpRgYq6VZb6Q5GWQubpJlJaEi6OalgO6Mqv5wXXqSlmtW+QledA6BRfakgPbQbn9bEpQ2LIhRzoSvI554mtZVlTppq6ndiZQUD84dW/lxbmK1i+jP6BrDDNky+qkiOEwKFqe6FFaHxYUEmk=
Received: from BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::8)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:00:05 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9b) by BL1P223CA0003.outlook.office365.com
 (2603:10b6:208:2c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 16:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 16:00:05 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 10:59:58 -0500
Content-Type: multipart/mixed;
	boundary="------------gK8PPUa02V5DOV4gCZpCLsDV"
Message-ID: <8ec979ca-21e7-10b0-160e-66c6a7e9f325@amd.com>
Date: Thu, 10 Oct 2024 21:29:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Peter Ziljstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Suren Baghdasaryan <surenb@google.com>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Youssef Esmat <youssefesmat@google.com>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>, Bert Karwatzki <spasswolf@web.de>,
	<regressions@lists.linux.dev>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241010130316.GA181795@cmpxchg.org>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dbc1b7-54f7-49ff-ef07-08dce9449b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGZVWGJyVFh3RFlqN3VGLzl0emZpcGdYNTNBUEFQNTBCaE5ESVFBOVllWkdI?=
 =?utf-8?B?MUdrbCtKeWp2c0RaeWZ3a3B2RTlPOUlVMEdLTi9pK0ZXYS8wNTVvVTVYalRZ?=
 =?utf-8?B?Yi9BRjVZbDFKV2UvUjNVTkVkako2bG45eWtiVGJwTWtNL1ZobVo1Zy9SdXU1?=
 =?utf-8?B?cmVwTXlyajRnQXhQZDBaUW9uVXoyb1hpdGlBSERzbjFBTk1iWGdldnIxdmI3?=
 =?utf-8?B?WWxVQmlGSzNQODFoMEJRcE5PQmZKMzk5SUdDNjlnY0RTTTczbS9tOU5YeHlo?=
 =?utf-8?B?RVRMTlp3QlNBQ2s5Rmt1Yy92bmQ5eXVPQmh1Zjc5c3ZHZnJSV0liajZzTVZw?=
 =?utf-8?B?VjJzT2xBd2syWjhZbDRoRzArRi9JeWUrdzFuREp6Z3J0eFhmK0ZsMklZeEtu?=
 =?utf-8?B?S2g0d29sVlUyVHJuS1hGRldEc0U5Ky9FNndoUVhEVGU3OWJxOWE2TENUTTha?=
 =?utf-8?B?OUtQbUUxR1lBcWN1a2hzOTRETEc0OEZtZEk0OHVpM1gva21ZOElDcFdjZlJ4?=
 =?utf-8?B?bTN2SnJoakkyNlZuVW5oaVhRWTVLd3haYnNzbE5ZNVVuTzlCYnF3WnZYemlq?=
 =?utf-8?B?Vkh3SFE2Z1VtcVB5NmVOUUd4RHVSVXUyVHU4elMvV3RFL1J4TENEaVZqNTZh?=
 =?utf-8?B?VVJ6SWNRcUErWDNNaW9KUVhybEI3TU9IYSt6bzd2bXJrVzJLdEcyZkpWSUpa?=
 =?utf-8?B?YnpkbXVZVE1oU2t5RWpCQTNJcW1ScXlrd0dKMkR1dWhZYlJtU2prWkpyWDVj?=
 =?utf-8?B?N1NIME1jRGFoY1FsMnZlbjFNYW4wdUhWTng4RWFGWlVHU3hqUi9XYUQ1WUxC?=
 =?utf-8?B?MmJIblY1WkxIR1ZtQVBueXRrWlFLR3JCT1Y5TytGSktuM0ZrVVdrYmNlalFH?=
 =?utf-8?B?ZG4reUlTejlXOTZTRXF0WnNCam1IeVVrRytjTSsvdDNnNWxiRGRtbFUrT3VM?=
 =?utf-8?B?TWxKT0hzaHZuUnlNY0NCNkxnTmVHanNoMUxHa0dxbkhSeThSYytrVElDYUNy?=
 =?utf-8?B?REdyRUFDQjdnbm81NjFzb0N2aWhpRm9IZnpZQ1FUUEJzcWROMStVR0pCZ2VF?=
 =?utf-8?B?cDAzZHNpY242L0Q2Z3BDZWxxSVB3cnVXbExCNkprL3B2Ylp0cEt6TXU3VFBV?=
 =?utf-8?B?OWhpRkZ3Vkh1cVNBVGFLYUZET0lNS0hNZE42dHdBZ2txVHptMHd2bVVpMVZt?=
 =?utf-8?B?dkhveUNXcWJZSmVOcE5BWVFEVzlYVVB1U1VLZ3lrbExqNnJqRVYwTXJEV1FU?=
 =?utf-8?B?OXI3ckVKS05GZk9Fc2tWdkpHSzdQT2YyUlZBZkxnTnFNOUxEWmlUTkdsd0V3?=
 =?utf-8?B?WllvUWZKRXY5aHpPMXRhZTlwZ1VVdEZvZmhoZDRKVXQ5ZFYwTWQ5N09Bb0I5?=
 =?utf-8?B?WG1QejhCaGtQR2EvUm9PVm92dDI4dVBYTHhXTnduME9wWVVaaGQzR3lTMWVs?=
 =?utf-8?B?bDcwd3N4bWhyU0RlODU2Y1A3R0pwTXBYWWxwcGRVbTJpSUxHbzNYVk93TWQz?=
 =?utf-8?B?dC9SWkRSZVdDbVA0UjVZTTJUSEh2dkhXOVQ5dzBqdVFCcHBJVkREU1czZ3B5?=
 =?utf-8?B?YkgyZlRtc3lZK2Y3OGVXVDM4L3p0OFZGK1VxMVRyeklHckdaeUZudDlPV2RI?=
 =?utf-8?B?RHBjT1FYcUhPWU4wTXU0MVo2cUF5NzBud3I2SzM0Y2VMR3NlUU5zeStYUHhN?=
 =?utf-8?B?OUNhMmg3TDRuaXlRa21QY3k5K040Q3RuQStrTGgwaHpqUXJ0SjZ4Z1pOcTQ5?=
 =?utf-8?B?V2RwbjJJRzY4c1BFVmNVWUtoRVdoSFozK2Zid1dndjVVQnZFY1ZDWTAzcjM2?=
 =?utf-8?B?bW1RZUEyYXBkZVhjMlpmdTNEcHNVZWlkNmRBUnJYVGlieks3Q3lULzZXdURx?=
 =?utf-8?Q?MPlWldgUuK/Ga?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:00:05.1897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dbc1b7-54f7-49ff-ef07-08dce9449b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

--------------gK8PPUa02V5DOV4gCZpCLsDV
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello Johannes,

On 10/10/2024 6:33 PM, Johannes Weiner wrote:
> Hi Prateek,
> 
> patches 1 and 2 make obvious sense to me.
> 
> On Thu, Oct 10, 2024 at 08:28:38AM +0000, K Prateek Nayak wrote:
>> @@ -129,6 +129,13 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
>>   	if (static_branch_likely(&psi_disabled))
>>   		return;
>>   
>> +	/*
>> +	 * Delayed task is not ready to run yet!
>> +	 * Wait for a requeue before accounting.
>> +	 */
>> +	if (p->se.sched_delayed)
>> +		return;
> 
> This one is problematic. It clears sleeping state (memstall, iowait)
> during the dequeue of the migration but doesn't restore it until the
> wakeup, which could presumably be much later. This leaves a gap in the
> accounting.
> 
> psi really wants the dequeue and enqueue of the migration, even when a
> task is delay-dequeued. We just have to get the context parsing right
> to not confuse migration queues with wakeups.

I see! I was confused in my interpretation of the expectations. Sorry
about that! Can you please give the attached patch a try on top of the
first two patches of series. It survived my (decently stressy) stress
test but it is not as extensive the ones you have :)

> 
> I'll try to come up with a suitable solution as well, please don't
> apply this one for now.

Thank you Peter for holding off the patches and sorry for the late
surprise!

-- 
Thanks and Regards,
Prateek
--------------gK8PPUa02V5DOV4gCZpCLsDV
Content-Type: text/plain; charset="UTF-8";
	name="0001-sched-core-Move-PSI-flags-when-delayed-task-is-migra.patch"
Content-Disposition: attachment;
	filename*0="0001-sched-core-Move-PSI-flags-when-delayed-task-is-migra.pa";
	filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0YWQyNWU3ZTZhMGViNTM5YzU1NDRhODFiYjNiMjJjYTdjYzA1ZmUwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLIFByYXRlZWsgTmF5YWsgPGtwcmF0ZWVrLm5heWFr
QGFtZC5jb20+CkRhdGU6IFRodSwgMTAgT2N0IDIwMjQgMTU6MzE6NDEgKzAwMDAKU3ViamVj
dDogW1BBVENIIHYxLjEgMy8zXSBzY2hlZC9jb3JlOiBNb3ZlIFBTSSBmbGFncyB3aGVuIGRl
bGF5ZWQgdGFzayBpcyBtaWdyYXRlZAoKU2luY2Ugc2NoZWRfZGVsYXllZCB0YXNrcyByZW1h
aW4gb24gInJxLT5jZnNfdGFza3MiIGxpc3QgZXZlbiBhZnRlcgpibG9ja2luZywgdGhleSBj
YW4gYmUgbWlncmF0ZWQgZnJvbSBvbmUgcnVucXVldWUgdG8gYW5vdGhlciBpbiBhIGRlbGF5
ZWQKc3RhdGUgYnkgdGhlIGxvYWQgYmFsYW5jZXIuIFdoZW4gdGhleSBhcmUgZXZlbnR1YWxs
eSByZXF1ZXVlZCBvciB3b2tlbgp1cCBvbiB0aGUgc2FtZSBDUFUgdmlhIHRoZSB0cnlfdG9f
d2FrZV91cCgpIHBhdGgsIHRoZSBldmVudHVhbAphY3RpdmF0aW9uIGlzIGNsdWVsZXNzIGFi
b3V0IHRoZSBtaWdyYXRpb24uIFRoaXMgdHJpcHMgdGhlIFBTSQphY2NvdW50aW5nIHNpbmNl
LCBpbiB0ZXJtcyBvZiBlbnF1ZXVlIGZsYWdzLCBQU0kgb25seSBjb25zaWRlcnMgdGhlCmZv
bGxvd2luZyBhcyBhIHdha2V1cCBmb3IgUFNJIGFjY291bnRpbmc6CgogICAgKGZsYWdzICYg
RU5RVUVVRV9XQUtFVVApICYmICEoZmxhZ3MgJiBFTlFVRVVFX01JR1JBVEVEKQoKVGhpcyBj
YW4gbGVhZCBpbmNvbnNpc3RlbnQgUFNJIHRhc2sgc3RhdGUgc3BsYXQgc2ltaWxhciB0bzoK
CiAgICBwc2k6IGluY29uc2lzdGVudCB0YXNrIHN0YXRlISB0YXNrPS4uLiBjcHU9Li4uIHBz
aV9mbGFncz00IGNsZWFyPS4gc2V0PTQKCk1pZ3JhdGUgdGhlIFBTSSBmbGFncyBhcyB3ZWxs
IHdoZW4gZGVsYXllZCB0YXNrcyBhcmUgbWlncmF0ZWQuIFNpbmNlCnBzaV9kZXF1ZXVlKCkg
Y2xlYXJzIHAtPnBzaV9mbGFncywgdXNlIHRoZSBzYW1lIHRvIGNhY2hlIHRoZSBvcmlnaW5h
bApQU0kgZmxhZ3MgYW5kIHJlcXVldWUgaXQgYWZ0ZXIgZW5xdWV1ZSBkdXJpbmcgbWlncmF0
aW9uLgoKTm90ZTogRGVsYXllZCB0YXNrcyB3aWxsIG5vdCB0cmFjayBUU0tfUlVOTklORyBv
ciBUU0tfTUVNU1RBTExfUlVOTklORwpzaWduYWxzIGRlc3BpdGUgYmVpbmcgcXVldWVkIG9u
IHRoZSBydW5xdWV1ZSAsIGhvd2V2ZXIgdGhleSdsbCBzdGlsbAp0cmFjayBhbmQgbWlncmF0
ZSBUU0tfSU9XQUlUIGFuZCBUU0tfTUVNU1RBTEwgc2lnbmFscy4KCkZpeGVzOiAxNTJlMTFm
NmRmMjkgKCJzY2hlZC9mYWlyOiBJbXBsZW1lbnQgZGVsYXllZCBkZXF1ZXVlIikKQ2xvc2Vz
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwODMwMTIzNDU4LjM1NTctMS1z
cGFzc3dvbGZAd2ViLmRlLwpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9j
ZDY3ZmJjZC1kNjU5LTQ4MjItYmI5MC03ZThmYmI0MGE4NTZAbW9sZ2VuLm1wZy5kZS8KTGlu
azogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTAxMDEzMDMxNi5HQTE4MTc5
NUBjbXB4Y2hnLm9yZy8KU2lnbmVkLW9mZi1ieTogSyBQcmF0ZWVrIE5heWFrIDxrcHJhdGVl
ay5uYXlha0BhbWQuY29tPgotLS0KQ2hhbmdlbG9nIHYxLi52MS4xOgoKbyBBbHRlcm5hdGUg
YXBwcm9hY2ggdGhhdCBtaWdyYXRlcyB0aGUgUFNJIGZsYWdzIHRvbyB3aGVuIHRoZSBkZWxh
eWVkCiAgdGFzayBpcyBtaWdyYXRlZCBieSB0aGUgbG9hZCBiYWxhbmNlci4KLS0tCiBrZXJu
ZWwvc2NoZWQvY29yZS5jICB8ICA5ICsrKysrKy0tLQoga2VybmVsL3NjaGVkL3N0YXRzLmgg
fCAyMiArKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2Nv
cmUuYyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMKaW5kZXggNTJiZTM4MDIxZWJiLi5jM2FjNjNk
M2ViOWQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMKKysrIGIva2VybmVsL3Nj
aGVkL2NvcmUuYwpAQCAtMjAxMiwxMCArMjAxMiw4IEBAIHZvaWQgZW5xdWV1ZV90YXNrKHN0
cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IGZsYWdzKQogCWlmICgh
KGZsYWdzICYgRU5RVUVVRV9OT0NMT0NLKSkKIAkJdXBkYXRlX3JxX2Nsb2NrKHJxKTsKIAot
CWlmICghKGZsYWdzICYgRU5RVUVVRV9SRVNUT1JFKSkgeworCWlmICghKGZsYWdzICYgRU5R
VUVVRV9SRVNUT1JFKSkKIAkJc2NoZWRfaW5mb19lbnF1ZXVlKHJxLCBwKTsKLQkJcHNpX2Vu
cXVldWUocCwgKGZsYWdzICYgRU5RVUVVRV9XQUtFVVApICYmICEoZmxhZ3MgJiBFTlFVRVVF
X01JR1JBVEVEKSk7Ci0JfQogCiAJcC0+c2NoZWRfY2xhc3MtPmVucXVldWVfdGFzayhycSwg
cCwgZmxhZ3MpOwogCS8qCkBAIC0yMDIzLDYgKzIwMjEsMTEgQEAgdm9pZCBlbnF1ZXVlX3Rh
c2soc3RydWN0IHJxICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgZmxhZ3MpCiAJ
ICogLT5zY2hlZF9kZWxheWVkLgogCSAqLwogCXVjbGFtcF9ycV9pbmMocnEsIHApOworCWlm
ICghKGZsYWdzICYgRU5RVUVVRV9SRVNUT1JFKSkgeworCQkvKiBUYXNrcyBjYW4gb25seSBy
ZW1haW4gZGVhbHllZCBhZnRlciBhbiBlbnF1ZXVlIGlmIHRoZXkgYXJlIG1pZ3JhdGluZyAq
LworCQlXQVJOX09OX09OQ0UocC0+c2Uuc2NoZWRfZGVsYXllZCAmJiAhdGFza19vbl9ycV9t
aWdyYXRpbmcocCkpOworCQlwc2lfZW5xdWV1ZShwLCAoZmxhZ3MgJiBFTlFVRVVFX1dBS0VV
UCkgJiYgIShmbGFncyAmIEVOUVVFVUVfTUlHUkFURUQpKTsKKwl9CiAKIAlpZiAoc2NoZWRf
Y29yZV9lbmFibGVkKHJxKSkKIAkJc2NoZWRfY29yZV9lbnF1ZXVlKHJxLCBwKTsKZGlmZiAt
LWdpdCBhL2tlcm5lbC9zY2hlZC9zdGF0cy5oIGIva2VybmVsL3NjaGVkL3N0YXRzLmgKaW5k
ZXggMjM3NzgwYWEzYzUzLi5kMjY3YTE4NzMwNGMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hl
ZC9zdGF0cy5oCisrKyBiL2tlcm5lbC9zY2hlZC9zdGF0cy5oCkBAIC0xMjksNiArMTI5LDE1
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwc2lfZW5xdWV1ZShzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnAsIGJvb2wgd2FrZXVwKQogCWlmIChzdGF0aWNfYnJhbmNoX2xpa2VseSgmcHNpX2Rpc2Fi
bGVkKSkKIAkJcmV0dXJuOwogCisJaWYgKHAtPnNlLnNjaGVkX2RlbGF5ZWQpIHsKKwkJdW5z
aWduZWQgaW50IGZsYWdzID0gcC0+cHNpX2ZsYWdzOworCisJCS8qIFJlc3RvcmUgdGhlIHN0
YXRlIHNhdmVkIGJ5IHBzaV9kZXF1ZXVlKCkgKi8KKwkJcC0+cHNpX2ZsYWdzID0gMDsKKwkJ
cHNpX3Rhc2tfY2hhbmdlKHAsIDAsIGZsYWdzKTsKKwkJcmV0dXJuOworCX0KKwogCWlmIChw
LT5pbl9tZW1zdGFsbCkKIAkJc2V0IHw9IFRTS19NRU1TVEFMTF9SVU5OSU5HOwogCkBAIC0x
NDUsOSArMTU0LDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwc2lfZW5xdWV1ZShzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnAsIGJvb2wgd2FrZXVwKQogCiBzdGF0aWMgaW5saW5lIHZvaWQgcHNp
X2RlcXVldWUoc3RydWN0IHRhc2tfc3RydWN0ICpwLCBib29sIHNsZWVwKQogeworCXVuc2ln
bmVkIGludCBmbGFncyA9IHAtPnBzaV9mbGFnczsKKwogCWlmIChzdGF0aWNfYnJhbmNoX2xp
a2VseSgmcHNpX2Rpc2FibGVkKSkKIAkJcmV0dXJuOwogCisJLyogRGVsYXllZCB0YXNrIGNh
biBvbmx5IGJlIGRlcXVldWVkIGZvciBtaWdyYXRpb24uICovCisJV0FSTl9PTl9PTkNFKHAt
PnNlLnNjaGVkX2RlbGF5ZWQgJiYgc2xlZXApOworCiAJLyoKIAkgKiBBIHZvbHVudGFyeSBz
bGVlcCBpcyBhIGRlcXVldWUgZm9sbG93ZWQgYnkgYSB0YXNrIHN3aXRjaC4gVG8KIAkgKiBh
dm9pZCB3YWxraW5nIGFsbCBhbmNlc3RvcnMgdHdpY2UsIHBzaV90YXNrX3N3aXRjaCgpIGhh
bmRsZXMKQEAgLTE1OCw2ICsxNzIsMTQgQEAgc3RhdGljIGlubGluZSB2b2lkIHBzaV9kZXF1
ZXVlKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgYm9vbCBzbGVlcCkKIAkJcmV0dXJuOwogCiAJ
cHNpX3Rhc2tfY2hhbmdlKHAsIHAtPnBzaV9mbGFncywgMCk7CisKKwkvKgorCSAqIFNpbmNl
IHRoZSBkZWxheWVkIGVudGl0eSBpcyBtaWdyYXRpbmcsIHRoZSBQU0kgZmxhZ3MgbmVlZCB0
bworCSAqIGJlIG1pZ3JhdGVkIHRvby4gU2luY2UgcC0+cHNpX2ZsYWdzIGlzIG5vdCBjbGVh
cmVkLCBjYWNoZSB0aGUKKwkgKiBwcmV2aW91cyBzdGF0ZSB0aGVyZSBmb3IgcHNpX2VucXVl
dWUoKSB0byByZXN0b3JlLgorCSAqLworCWlmIChwLT5zZS5zY2hlZF9kZWxheWVkKQorCQlw
LT5wc2lfZmxhZ3MgPSBmbGFnczsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIHBzaV90dHd1
X2RlcXVldWUoc3RydWN0IHRhc2tfc3RydWN0ICpwKQotLSAKMi4zNC4xCgo=

--------------gK8PPUa02V5DOV4gCZpCLsDV--

