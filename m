Return-Path: <linux-kernel+bounces-425853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0B99DEBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CA4B21346
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D019F40B;
	Fri, 29 Nov 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ov0aUcXS"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C4199EBB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902806; cv=fail; b=VZ21oMNaULJY+1KkOgCb2TWW/dg396Px3XGTYLZnKRDvGx/VuCypkxAlLBLWYLvYlZBTIokZavsqqovk3f0KXL3m65xzdRvzrPiOFE25qz/rm+mX8WvP/6qXfgs/sevcVGvlKO64Yf2E6wvfywMAo+3XmVGI4jxFJzhZLIPuQpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902806; c=relaxed/simple;
	bh=obBwr0RKES+yiyHB9RPDOp1LFxusFme0uscZ1rPFIaQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JcR/6SL2a3io4NA4BeGYtcp3J9tBrMmrQuz5hyKMXUPBUBUyQeuzRbhkzqkCSm+p57EZ4sB1nfBBUr91gdU6ON9Oh6e1a1S4Xisi8506ijAiScp3Msd+GbrKH8KO32H+DzSHddRgjl9Co27Id0C5U+fXFMPphPq8VyHG5lOcC+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ov0aUcXS; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yjr2QFrYy+lb/mJErN/oEz57p4a0Nn97HMlnVIHx4XL66SpeVWMPyZUcjFjULJbe7SYJPaeWw4PLGdMLJrVemCE2iJHrdsCwly09j5xDohFO89W9c0GfoswChW+FSIbWs4bfAa14HlGaXpfwmTni/7jgPMm9MmnWokC2LSqyu3zk90xNBxUrAl5z4b6Ys6x6eb71fkexTK6Bm/rKRcD8vjioVIDo08BU5TH/CZPB4Z/bZ7Tc8/sBwiyWeGSUY82LeO7bL/KPmZWyHxwQgOXhm5lboB/yXzQ7xhYDE63crl69C/GgNgdD8oZd33egWdTgVLDn3YC1ovpa3ip0tOBuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4MzQTYCcuE33JX//VsycgBaQpJ5xsTfHtF9MizSYcE=;
 b=CCT/FHlnENnh0iTbCqUiirgzAGYy3XFQ//EThQ8HjvZgXy+98nmX+CcZinhsQ+WXPgTHStQvyxoyI+t+f/zxqfiXN+MPocFQe3Nn/9vyX6dn3E3BUu0RWZB9++n5Z7j+3QI1zp5H5Tm8+R1pAeMMaZmPd1ED3yXf6uyrj+jh0aEs41pdQUnYdEOky9iUFKRvGKh4/Uepu04BPgsIxccvCbld/8oGoU/HmNpgXhMM/vRqRTkTZsCPHE+VBjZz+RTqCShaCc3V/U1jySJq5FPbHitSwnUkmxDU72lfva4vsRX/LibClmgiUR3jhIrOOTFQmgUtp/1my7RcUHfYZOinjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4MzQTYCcuE33JX//VsycgBaQpJ5xsTfHtF9MizSYcE=;
 b=Ov0aUcXSJTu+4eg8yrgCZZA9HrlP7ejI98gQt4jdIW/f24pgXO3olGNlYL6GDVmZpQB1fomwuzsGqXkEq9pFBsTP04iiJgKxkrpfZA9/ykw6zVcNUbYiLXDoK8BVB9qbRcNT/eKNQpHlp03P9BwUQL8i2BQaNyOlzZgs400maVE=
Received: from MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) by
 DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Fri, 29 Nov 2024 17:53:21 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::5b) by MN2PR01CA0018.outlook.office365.com
 (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 17:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 17:53:20 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 11:53:14 -0600
Message-ID: <2ab494a6-e5d7-45a9-800a-d104f905f12f@amd.com>
Date: Fri, 29 Nov 2024 23:23:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Adam Li <adamli@os.amperecomputing.com>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<patches@amperecomputing.com>, <cl@linux.com>, <christian.loehle@arm.com>,
	<vineethr@linux.ibm.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
 <6683a7dc-b83b-489c-bdfc-ad225ab816c6@amd.com>
Content-Language: en-US
In-Reply-To: <6683a7dc-b83b-489c-bdfc-ad225ab816c6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: ed82c141-933b-4c29-b747-08dd109eb679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVNsOGhNSWZDdStJdVJLcFh6K004b2Jab1R1b1ZtczVzeXdXS3Budk8vVDhk?=
 =?utf-8?B?R1NXNkFRZk42VzdtdUZkWlYwZnV6WTd5VFNhM2dBTUovY3gzQU02N3NlcEFE?=
 =?utf-8?B?c01VOFFzKzZ5T2o4aG1xUU5rZHljZnk0enEyTXBCYng3ck5ab0t5S2dGelgv?=
 =?utf-8?B?OFRyZGgvT3lFWUJyRTlYZ1NCYUxzeXJZQkRNUkdyMDVQb010MUEvalZPeEds?=
 =?utf-8?B?ZllLdURMd3d2MzZnRG9xM3dzTHRtUlJXN2lPNEtlS3YzbTRseWNnZEVvUlJa?=
 =?utf-8?B?eHJ1NENZa0xEWGFDZk9LS1pvQitPQ05xUVBmMXFsa0RyN3BmT1FzUUh0RE54?=
 =?utf-8?B?amNUa2xpMDJlTHhrSlJOSDRNVlExdDF3QU53eE82TmtaQXBOOFMwZ0ZIZmc4?=
 =?utf-8?B?RFFhVU1tVE9Xanlxd2VVdUJkRS91R3UyeWNGaVNvRCtxRzFvVm9ZMUNjVmEz?=
 =?utf-8?B?NUl6Um1PSlp4Y2xwR1BuZjNGcEZudWZPVEZjMEc1cGhkK2dhN05taUR0Mk1q?=
 =?utf-8?B?Tk02bE1JdERXeEo2UnU2MUx3UVBmaldQZWdsTDNNV3J0ZDhXSTl0QjJlUjdp?=
 =?utf-8?B?clR0cjJaVFcwaGJsMXg5R1dVWWdhRVJqUkZ5aWdyU0tHSFp2a2pEdzJyUGNZ?=
 =?utf-8?B?ZGRoR3BDLzBmaW8vd2dKQTZpMVZwZm9oS09NL1JaTEFyNlg4MldHa3JHa3oy?=
 =?utf-8?B?b01Td2V1b2hFeTRFeG0wSUp4NlpxN3ZyaHAza0JCeGpJcHJUMnNnOXNDMHJm?=
 =?utf-8?B?cS9GZkhMaG11QjJwZnpYaWlOd2lid1BNbHN1WlpMNyt5VzNQa0ZJZkFZeW9Q?=
 =?utf-8?B?UnBNVDMvMVM4VndTR2dxRnppL0tRUGJtb3ZqUjJBL1p0cndnVURlWXg4ckR1?=
 =?utf-8?B?SzRDZXM1K1ZUSTl5R0tibGR2ekZDL0E2R0YxWko4WVZsb3oyZzFqYzVpZzNY?=
 =?utf-8?B?VDM5MmliZDJZbFhjMHMzc3dLZnRoSWhma0VFM2dMTTVsNCt1QTNIcWtKM1dT?=
 =?utf-8?B?VGhwYkYrWFhla3ZnSTgzWlBlb3FIVldIQ1NlSDlTdTVZM1VHK2Z5c3NGL0dz?=
 =?utf-8?B?eXk3S0RwNXloQ2xBRFpCWDU4MDlBditBQ1B1NS94RHJMNXNHc0pxeTVZV0N3?=
 =?utf-8?B?bDlNVUJUOEZQK1Jpc0ZqQUNlQjFTT2h0ODZQbWlORWFiM1Zvbm5LR1ljRkcv?=
 =?utf-8?B?eGVSMWdXNUpFbnZpWndYV2trMmZ1dVZzbmphWmprMFB0ZW5ZZmVnRlcyeity?=
 =?utf-8?B?Z3h0cittSDBGakcrYXlXNTdJWHNsczVhV29ZdUt2UlJQUEpqWTNtUEZYaFo0?=
 =?utf-8?B?SEZhWm1TenBaNHo5K1UxWlZCU3d0dU5UZVNTeUI2SjNIbmN1cEdxUlRlQXlT?=
 =?utf-8?B?QUh4bG1sbEZ1UW0ySSt5R2d5bjdKeVdlR3U3YlZKNW5FbXVDcWdRMVNKbWhD?=
 =?utf-8?B?QjcxQzVGVStoTTNmbnhTNDNYbWtWamZUelp5QlF4YXozdS85cHo4dENjVFk3?=
 =?utf-8?B?TFhIOUR1QllqUEVYd1YzOS9uc3hVSzd2Q3o3MUNJK1JyTU5lcXE1andiSFBO?=
 =?utf-8?B?a2crZERNemxnMVo1c3dxcmVvdkh3Z1dLcy9BSFNqVFNsZzZFaVN2SUhyY040?=
 =?utf-8?B?Y2Mxdk1veXM0R0VsRmI2LzNPRXJkUXlVaXVrdWoyb0lwZVY5czNmV2VOWFVl?=
 =?utf-8?B?NFhqV3BTWUxvRm1wNENvakl4QS9wdG9COUNBSkVJMTcrVm9ERVBjZ2Nyb0ZJ?=
 =?utf-8?B?NGFGaVJhVml4Y0JsMkx5Wk5GQmk4eWxrcExtU0oxR0pLY25taVVrUnNhVXRC?=
 =?utf-8?B?YnAvZTVhY2ZGTC9kYmFEOW1JTFlVVGNYOG45c1Y4MUhRMzZtWEdtQys3bzZQ?=
 =?utf-8?B?REtxcW9keE96Mkw2K0lHMlZ6NW4zZzd1UGZrM3N3VWJ2UXJUNXVlMzFhcnh4?=
 =?utf-8?Q?HGVCrppH8pN9KV9LAzdA3MRup9rceMNy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 17:53:20.8160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed82c141-933b-4c29-b747-08dd109eb679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

On 11/29/2024 11:16 PM, K Prateek Nayak wrote:
> [..snip..]
> newidle balance pulls a delayed entity which goes through the
> check_preempt_wakeup_fair() path in attach_task() and is set as the next
> buddy. On a second thought this is perhaps not required since even if
> this delayed entity is picked, it'll go thorough a full dequeue and the
> clear_buddies() change above should take care of it.

That said, it'll still trigger the following warning in
pick_next_entity():

     /* ->next will never be delayed */
     SCHED_WARN_ON(cfs_rq->next->sched_delayed);

which is also why I added that check in check_preempt_wakeup_fair() :)

-- 
Thanks and Regards,
Prateek


