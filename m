Return-Path: <linux-kernel+bounces-407103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69D9C68DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502E6B25314
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22A178CEC;
	Wed, 13 Nov 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PePZ9CzC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5316FF26
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476624; cv=fail; b=KYKVV39U3lj1l38gBr5dwmkaJoPG5ehcsLL/bk4W/cRUdRMDKlG6+mtB+fRsVWL8iu7EYZt/xRXTVaOKICzuiGpUZ1SuDpgKJpC7BWNsLLgHhMPelxnEsPOTlcZcVDZele/xhns2lpooe9y0ka6OLoJjrkpb2nP4irJQGfDoR5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476624; c=relaxed/simple;
	bh=ryo8sh1qV5PgLrAwKhNdypWydTUGWO71zUPbPjSUnZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DeN2sVb1pdROLAEJAH3VocS/akxbptSTv2zxRd+CQ+66sK70JSdzY6Auoo/jjgg9gQZ15jLRHz0QXYoJ6O8efB0lfcs5Mjo+aQgjRGV9leS6tcqmHQ5/ghKw39Tu6FCNxa38CrxnfhE1wpV0Lup8DvWCOiXll7ysGtZXmFqHeRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PePZ9CzC; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICxEPkGeulk0BwWT9Uz0zIkecCoEBMESkTZif41wv5FXx952H8nXbsiDMlu8SOTAgKKMZ1yKtLvFWfjBhudhcNxVgc70zFtWs08GfH64ZFIz0tLIp181sLBwFDCpHqxNR4dapPny2H41u6iJS4SqD01V1nAdaANaO3QTtx3y388G0rVLidLdz0fiNYfXu/sBJgu4kHlITuNJJBGq5G2JTi7xurXa4gm7VVAWqRQVCUGRXkrFnmoIgIGIVn/gmfTcQneG5BARe/7pFOUklV34M+lxsZ6amtPpSWWHmFto+2pw4sUh0poyHzQtCB5U8eADkxFqVKdQ2VoDUAiefgpc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPDPW+k7ZQRmcD6Oz7yXG9BnjfJoHzW6XUs0cBchzvo=;
 b=sbfYDN8TpFupce4hVejVOw1bbbq/5C/VMyN4/WLokSImR+YptEtICczqdjP3EYP6Bd56W6NW4PX0t8tHkna2JCW5LTevaqst5xsqQVDnf3cirG0CrA9tGne7XKWZNOr/c6d2S8JjStCFq8mvRa4LHSUOsvAC9AIAB304kRB3GC3wVtuT9Dw65BqD1ahOXEx0fPoxxImdgoS/aMfbsj99pJ//B9mCggJ30EwIfi+xkXVl4XwIfSuWjw27dM7QAhscU+7fQdusBcFtuuqzeufBSL8O/38rmzaUbuvfVucFwrLHCZRfYgVZKr/Ue+XG6rgIPPcTmIkmKyZVgTKJkfnIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPDPW+k7ZQRmcD6Oz7yXG9BnjfJoHzW6XUs0cBchzvo=;
 b=PePZ9CzCevLLnLfq6e262CqobMQpn3X8H9TcYt4oPLTfWBMIk55SjT2zuLn5y0XoWEPNi6/HAgweXFNQyUq+D/Yu3XOKnB1eLIDfOnPrVA9sdC8LrKbP7kzsMvxlmpx8ZoYqiBUilVZO2L2+ufGbEofs2mNe0tRsfcgnAGAuHww=
Received: from MN0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::11)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 05:43:38 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::4b) by MN0P223CA0020.outlook.office365.com
 (2603:10b6:208:52b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 05:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 05:43:38 +0000
Received: from [10.136.47.222] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 23:43:30 -0600
Message-ID: <a8b828bb-7e8d-1f57-3c9a-3c4e65a185b8@amd.com>
Date: Wed, 13 Nov 2024 11:13:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Content-Language: en-US
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
	<linux-kernel@vger.kernel.org>
CC: <rostedt@goodmis.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<daniel.m.jordan@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241113000126.967713-1-prakash.sangappa@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: f551f638-75a3-47ff-e950-08dd03a61fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkhRR3UvV0paOFg0NXE2RjkyU2d3bUJFOVhkMDFISW9uWWNJaWYxWVg3ZlY5?=
 =?utf-8?B?blU3SkhvdUZTQ096Z2RiSlpSa0dpamR3Q0J1am9iT3k5S0dBMTVITzdFSHk3?=
 =?utf-8?B?R0QyZUIrRmdXb0YyTDRIL0d5c0c1aHQ0L0QzdW15b2F6RnhPR1I0Ti8vVU9M?=
 =?utf-8?B?NXE5SU5EOGhpRVQzNE8rbU1LdGZlK3M2eGpHbDJTUThQMHhOeWxTNG9wbHZa?=
 =?utf-8?B?WWNPUHV4Zkt2MnR0MWxPU0pobDJleHp6WDlNeC8yM3VaeExEV20vVFdUcHBP?=
 =?utf-8?B?bzdPenlzZlZMWGR2NTdCSTVraHZvV0YxdllocVNPS3o2cG5taEtXRDFTQldX?=
 =?utf-8?B?VS9SakJPVXkwQzV4bDJxS1puSHp3T1dPVk50bUhrdm00RTJEMDBuZ2pXanlu?=
 =?utf-8?B?YnRTcTBhbXBldFpHQnBlOUErRjhPK0pjWUMwM1pJc0RqWDZwemZOMnpwT1Vn?=
 =?utf-8?B?R2Q2cUNLYUtKQVJ6dENSQ05qNzJsNElCZlY0SlluMnovNXIrQnRRNGhaLzhu?=
 =?utf-8?B?bi9kc3U5L3BINEhZZ2o4eit6MDlTblgyeVBKMEJPZWtvTzdaOGJNdE9lRmVq?=
 =?utf-8?B?VXdQZFJad2t4U2hMY1hQb3NCQkYycHNLRkFxQlNpQXdXYThzc3dFS2tnU0s2?=
 =?utf-8?B?Q2NBeklzMVhkV2pkRjBOMSsyK0VsWWttVGVVVXBISk15Y093bTdUMFVYNS9E?=
 =?utf-8?B?UjBJWDg1L3AxT3ZMMXB3ZGpxcktZQTRtRGFwZ1Vkd2dpMzJyRWtQalptcWJ4?=
 =?utf-8?B?SXphVTZCc1MvU3l5TXZtNDY2ZUwrSmZKeVlZdzg1WTFPM1ZjNEVCWnh5UlJF?=
 =?utf-8?B?YmZGVVZpd1pHTEV5TktXQUczanltUnl4VUt5UFRIU0hwSnhEaitKY3l2N1E5?=
 =?utf-8?B?S0VzQmxvazNjR2FORHdlaTFacktsY3EvTThJTi8weHpGMWFUZVJkUFh0MGJW?=
 =?utf-8?B?UGJjdVB6VGN3SHpWd3ZlWStMTENMblRrVUNzUVJjM09NQjNjTUNGUzNpSjhO?=
 =?utf-8?B?ZzRvLy9vV0NxOTVEdzhQY29lbVoxRWdqSExRNUlOeXEzbGVMVnpoczNuMkhv?=
 =?utf-8?B?dXhHT3VJWWNJUWxtY2NRMHVXbElEa0V4THZaQmhWdzl3YUN6Ym9ITGZaMVBs?=
 =?utf-8?B?amRESC9PeWx0Y0hqaWo5MXc3R0swQW9NdFoyNzJZNW9tYTZsRnozbDFlRzNl?=
 =?utf-8?B?ZmhGNitYRVlYWTRwcFkzMXBUOHBXUS9pQUkxQVhROVh3dGkvK05FaUQzbHpw?=
 =?utf-8?B?K2dwbzk3TkwzOUdtS3BOMnFiTmMraEVQblRrSFl3MGxRa0pwRURwQ0pmVmtm?=
 =?utf-8?B?dVdyZTcxWGo5VHZtZituRVFNN2w4THZadDl0aEkyTXFSMUt0QXNpcVNoQy8y?=
 =?utf-8?B?OW1qdW55SUpPbGdRNXBNY3VNRWxKNEtBcDkySTY1YjdCOEhYRytjeUZvWjhB?=
 =?utf-8?B?S3BWNkl6T2NFMStiSllSV2NLeDdlN01JQUc5Q2NXM0VUcCtnYVVBdy8zV0xC?=
 =?utf-8?B?QWJVNHIwN2hoU3pRYmxLVFB1LzJWeWE3QklxTHpJcnBES0pHUVVQNmt6NHJV?=
 =?utf-8?B?SVd2ak1MWENhVE01TWMrVHlIbjRtZEdGMk5XRnArMzllaTduUEJFcXM4aXFw?=
 =?utf-8?B?bFRuTXQyQXgyeU43Vko0b0J1NndiUGRwUG9pNFJ0Ym5wbDNrMU9UM1hRSG9U?=
 =?utf-8?B?Y2FVUjltNWt6OEs1eUZwcUNMR2FKdHkxTTMvREtFbmNaM2hiMHg5N05FUTJs?=
 =?utf-8?B?d0RWZCsyWXpaRlZYSTREY2tsTGxrM3NwaUJscGFkMHVxUS9wQmwyWjE4RG9s?=
 =?utf-8?B?ZDhuZVNLRExVZmZWeHlMUWNLTDRWUS8zQmJZa1RxVmtrWE5hOEE1WHlTTlI2?=
 =?utf-8?B?MVltTkJkQVdnckZOeTVUa0xhV2VCRXBXejR6WHpjQVdjbEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:43:38.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f551f638-75a3-47ff-e950-08dd03a61fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

Hello Prakash,

Few questions around the benchmarks.

On 11/13/2024 5:31 AM, Prakash Sangappa wrote:
> [..snip..] 
> 
> Test results:
> =============
> 	Test system 2 socket AMD Genoa
> 
> 	Lock table test:- a simple database test to grab table lock(spin lock).
> 	   Simulates sql query executions.
> 	   300 clients + 400 cpu hog tasks to generate load.

Have you tried running the 300 clients with a nice value of -20 and 400
CPU hogs with the default nice value / nice 19? Does that help this
particular case?

> 
> 		Without extension : 182K SQL exec/sec
> 		With extension    : 262K SQL exec/sec
> 	   44% improvement.
> 
> 	Swingbench - standard database benchmark
> 	   Cached(database files on tmpfs) run, with 1000 clients.

In this case, how does the performance fare when running the clients
under SCHED_BATCH? What does the "TASK_PREEMPT_DELAY_REQ" count vs
"TASK_PREEMPT_DELAY_GRANTED" count look like for the benchmark run?

I'm trying to understand what the performance looks like when using
existing features that inhibit preemption vs putting forward the
preemption when the userspace is holding a lock. Feel free to quote
the latency comparisons too if using the existing features lead to
unacceptable avg/tail latencies.

> 
> 		Without extension : 99K SQL exec/sec
> 		with extension    : 153K SQL exec/sec
> 	   55% improvement in throughput.
> 
> [..snip..]
> 

-- 
Thanks and Regards,
Prateek

