Return-Path: <linux-kernel+bounces-312032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6896910E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7FD1F225B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85331CCED4;
	Tue,  3 Sep 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="D+3d5vd0"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020135.outbound.protection.outlook.com [52.101.56.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488601A4E6B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328145; cv=fail; b=B1gWB3ykoc5joKFwQ2BtKjewfP0iqWbN3+CsgU5BFKOOy/k6CP+9YuFnjucQlgpphA1QcBYUQYJc99Rnlz6vLOfGKWV2XsUGydWiaLipp0sGK7Ic1Hj0UaKc8qMRK94w8HwtjoJt3Em+6weFCDce/JgPqXMVOkkneYcg3K08OzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328145; c=relaxed/simple;
	bh=VVkDk1h7Y2UpRZFiIhad404b9vrKykp5HJPILzfxwIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThPeDG2Ikv/w6IVyqI+1GDCstO0BEkhCfgkrYdUXCsKuzTq+4tucQbvXK4VDVq2UuK7mHkKCvoaqZtDnnCL//kr5V8EGssruDq/xsGsTdyJUnHE5Oa0CtIkyRdCz3miXzOkuYxYrA9wjAr6UHvDz8SqtOJbfdj8L649EtZem/3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=D+3d5vd0 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.56.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYRdTisVXWMKZjKJvShrTPkytKWmOYY2jDl2YSKi6k7sgm/xHonxQ+rlQUuKOf70bq0q8MRr7tgU/ESWAWSWv29IcfeVst+J5faoIoCEi/CqpsSlHFtwBqj2Kgl1AmnbQ0POQbxOVx60cy5I8EebLu2qCQ/d6oV3xXesm9QouN19knREqSodnnRpYes/Wdc704nvKW8nTq9DRxbv2WaKDUTusQEAiupUh/HrPNF4olPlLpnkfS76N09Uy90D+lnnYPD91IrXdyPUeNCWuG6NNHzmDcbcYmdeL61ntWH6XfmyVQTrZz5CQzQGBdEMux1NZSLDEjN7ZUf6oM88qpaTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C52YSdruObTqkdMWARObFDdwz+aoqH3K4WlSSLswGhM=;
 b=v5Acu5LY3tusDaGUngptZiA1kSTE6dLtM5dNz2NP+ACXKUTI2LSDhobYjuurnh6G4jxyXrGnkB+3P1Y67eB64/ovhX8gMusntPl/RL5NIINTCG+4Jc3tZA63t+Vs0hxLL2KfnpuIV35mTzQjpK8m2horZDAeFniIBc3LZagZE+e1szAueuyF0Q0V0hYas3ObZrq8sAOliJ+gZxmE9Ldb20k5KaG8daPx8dS+3iAKrILR5IFYug2yWvqBIS46Nll+CbcGQEWrjcShEpCRyAJZ6oFGlwB2Fx7W0M8CXuNnlDIN3ze0hoo53PLvMNSP/JJEERvWd8tpkl3NgGoayzGbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C52YSdruObTqkdMWARObFDdwz+aoqH3K4WlSSLswGhM=;
 b=D+3d5vd0A+YyiQ5pzqAMkiV1aT61+jOqcMnZqrDIWMxpmG8eWNvkCpdYUKv3Es+7r9sVXAjeSAVNxl3YgL6qqeYA8aDJtAMImB73dIImUC7zPXbU07V0tiFkxOFfUBVWzJrlERdoB7zqWPBad7j6dkNcoRJ+wuMQjZX0xuRLuE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL3PR01MB6980.prod.exchangelabs.com (2603:10b6:208:35b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 01:48:59 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 01:48:57 +0000
Message-ID: <13da5b3f-938f-4536-86e2-7073f781f26a@amperemail.onmicrosoft.com>
Date: Tue, 3 Sep 2024 09:48:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/deadline: fix the hang in dl_task_of
To: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 patches@amperecomputing.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, vineeth@bitbyteword.org,
 bristot@kernel.org, linux-kernel@vger.kernel.org, hongyan.xia2@arm.com
References: <20240829031111.12142-1-shijie@os.amperecomputing.com>
 <ZtAtymo-KB9c20Q8@jlelli-thinkpadt14gen4.remote.csb>
 <20240902111446.GG4723@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20240902111446.GG4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL3PR01MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: ec74dcfa-f99d-46fb-fe90-08dccbba9325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2RNcFZtWUM1cHdwK0FZbHY2RkZwL1I1UFFzVlZPbVFleklEaFEvMi81UXZn?=
 =?utf-8?B?WnB5Vk1YUjlLZVNpdHphd2NMRjYzWGFNU0craElKQlRSaXN1NGJnOWtFSXZ0?=
 =?utf-8?B?SmF6VmtUeWJ3YzhRZm5xSTUxTnhmUUFHNEorOE5NVTlCenlYY3YwS2ROdVI0?=
 =?utf-8?B?L2ErcTUvN2lSaGp6ZitLR0l6Q0J1ZmpoZFpnSVROY3Z1V2lQR24yQTJtbk9Q?=
 =?utf-8?B?TjN1Tyt6WmZWQjR0L2Y1aGZuSkMrZHpxcmJoMXdYN3p4RGhJbVBYSnl0RWQ1?=
 =?utf-8?B?UTUwQjNFV1B0UDBteE9hRG1zby80K09HMExiTExtQ2F3clEreDJWN25LcjRW?=
 =?utf-8?B?eVRzUkZmelRvNHJ5Z0hEcVdnT3FwYnczTUFFcDVneDE5QWVoc3VQWmFwa3A4?=
 =?utf-8?B?V1V1Zk5RZVAwbE94a3B2dHFackplMlR0VlpmRW95bjAzbU9KaTB0aEVxZHFJ?=
 =?utf-8?B?S2tXTXRQd1hucy82eng4Z2J4TVU2RjJyQkN6NkoyRmpxWHJLYnl4dlNZalNt?=
 =?utf-8?B?M0E5dHN0ZGlTeHZacTdvS2Nyd3R5Mi9CU3o0TGx0djBNL0hGdUgwalcrb0hP?=
 =?utf-8?B?cTgxNEt5c1kyZG9TaFVhdU85U2ZzSC9yb0h1ZG5VVnUyM0FEN0VCV2RpTXBk?=
 =?utf-8?B?T3V4Y1BYVGxvUUhEUnNqLytzTDBCelVuYXV1eVd2Rm4zNzFGTkJyMGc2a0Nk?=
 =?utf-8?B?YVRkbHlGYmlQM3RTQjNGcFlqWXk4SVovcFluWTg3UlJsR0hvdElwZ3MvREtR?=
 =?utf-8?B?SmNqYzZmUGlxeGhaVjU5V2E2cWVQcEFYKzB0aXIzRHg4UjBXQjd5T1dQNG5m?=
 =?utf-8?B?V2JFRGE3OCt4bEhwTmJoQ1BuSzZNU1R3SzYwVEllVmhESEZCbXRxcDJSM0hY?=
 =?utf-8?B?MVFmUG1HN2svamcwNlpiLzdNc1F5cE5LTzFTcVZHMDJXSWErbTMyK21aVS9K?=
 =?utf-8?B?ZDQwYnRRdlBhQlpVYmlmYU9SdkpPYUZ0bGZ2QTNRSzhDRUtqWHRTRnZHUmtD?=
 =?utf-8?B?YkRxSEtVYWVldUs3eEJCV3lmUWVoMmZBdFlxN0NyeEQ1UVZpWXd5Ykx6SVNP?=
 =?utf-8?B?aXRiZFRiMDlCMmh1ek03amdDb3lkcjV1Zko0bWNEUmZGS0JWK0Jta0k5M1dM?=
 =?utf-8?B?NmtsbkxEb0t2bkJsU2g2WENlK3RicjM2NU0vRHBLNVBzL0FSRGNNYll3Tmg1?=
 =?utf-8?B?V1lqd3BNWXpiYTBZcFp3ZE4rbGNSOEY5NjJKZzVmUGZaL053L2wxM2NxU2Mv?=
 =?utf-8?B?TWlLRy9scFF0NDZmZVU0TnArMmYweUlGNmpuanlmOXlZNjMycmQ3bTZDYmNk?=
 =?utf-8?B?R01oZmFKeUNhL29aUi9rdVBiZDdxRGtSNlRZUE1mTUJJSEZNTlVaRFp0UFNv?=
 =?utf-8?B?TUMwbEdZZUgvMmNTRitvc0twbGxacVVvZ2tRdkFGVEFRR2JGQzlsaFBMam9m?=
 =?utf-8?B?UjNBSjJPY2xoOVBnakFUbnlEa1MzMURxVnBQRGVGbFhWcE9xUVBEbjZHTnNE?=
 =?utf-8?B?bzZjSCtQWVN4SVJUVmVjNko5Z3pReFQyYXhKcitpTXEyeHhuUmxPSE0xK2J5?=
 =?utf-8?B?UFRpbkMzUlVQQjlGZy90dUpMeEdpTE13T0hSb0tCanZROEdoam15R0hTRlZs?=
 =?utf-8?B?UkpiVHRuVVlubDFHZjNuMnN1ZVcvRmpZUG5TN05SdWVoeWN1OVNWeExpZFhI?=
 =?utf-8?B?Z2ExQkhIR0h3STduVnlodDNFVkxVZnEvQWtBS3R0OWl1eU5pVGJYSlB2SkpC?=
 =?utf-8?B?bDhneENzYU4rOFR6a0Zub01EWkZ3cEY4TzNGaUdvbUZDVUVNYkxXaHJBSkVm?=
 =?utf-8?B?dlh4eTBJeGVLOUZ5TDgxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEREcE13cFo4bXI2N3VoL2ROdm83VGtiamEwL2RCaTlCeDI2TnMxNjRYTzZR?=
 =?utf-8?B?V1VVZkEzVVJ2c3VxZzZxM0tXc3RSMk1oOHp6dkVPY2kxeFd0SVp6MUN6NFZ3?=
 =?utf-8?B?NE16YWtseDRwazNyNUNzYWV1a1FtZHpzK1l6dlhqVE5jNHN5a3h2VGxDUm5n?=
 =?utf-8?B?cXNDMGJYN2VVWXRyTGlVQXNheU5ySW41QmdPYVp6dFIwRXQ2OWVtMCsxcVdV?=
 =?utf-8?B?bTNtbFU2WGhQRTQwL2s4ODVTRC9IeGNZY3I2TmNYODZnU3pTd2Z3UDJFdTlG?=
 =?utf-8?B?bjUrdnVMSkJIQzgrL2ZQYjUwUjZ0M3BaSXIzMGlJSFYwK2tTZkMwa1lRR1ZS?=
 =?utf-8?B?Q2VlT2pocUhPbGNUelNFbUlEK2JqK0d5d3FudTJocmoxaWFBVU5ZQkRTdDkw?=
 =?utf-8?B?bWlZMzBCYVprMWtKK0hBaVpaODdaWXZTMTRJVlNhcExpWWdadWtLcmJwc1RD?=
 =?utf-8?B?dmc4MEZZeTllQTVib1FqejlFdUM5QkVEWkRTdmRFTGdibXhxY2VIUGVCeWI1?=
 =?utf-8?B?NFlYdmNWeDA3TUZLeENtN01sYTlnNXpqUzFYODRKY29mTnB4bW1QNmhueVdw?=
 =?utf-8?B?dGg5QVVHdzQ0TWRjcXEwRnNyYnBYNm95cSs5UVZUUGQ1QkZ4QVh3S0t3RFd2?=
 =?utf-8?B?dE1jRjFFcFg1T1hHYnpLM3FTK0J1UlIwV28xcXg3cFdFVW1MSk9IOS9LS3BH?=
 =?utf-8?B?S1o0bzg5NU4rTlc5TnpvYWlycytZN1I0ZXZ0V2dpVWlRNFdOZ0RqVEIwMUJ4?=
 =?utf-8?B?aW41S2dLY0ZpVXgrUFBFWlNXVU95TEE1UGZLdlNJYzlLRXpOKzdXN2hKL3Az?=
 =?utf-8?B?M2tkUHoveEs2c05zTU11QWplTFM2ZnB1OGtNSjZwNmJyUTFBUFJxSnJzRDlG?=
 =?utf-8?B?MVZBWjczeHkxRm1QMG9IK2hqeGVyNndaZ1VhL3lHY2k4d2J1OTdvL1dOcHFM?=
 =?utf-8?B?WHRVQTc5c1R6Mmx6MnFvK1lyaEFPWGN1c09SUEdpU2dlOE1XaCtSNGlVOTcr?=
 =?utf-8?B?R0F1Szg1LzgxaGFlSldGZ0NmS1gwTHlueFB2aGt3ZWRTeTJPbGlKVGdRNm5l?=
 =?utf-8?B?RGdNaFhJV1M1enYwWFV1cFFqeVpBQm93dFhjazcralBFMTBPTzF5UWNQRHBK?=
 =?utf-8?B?eXdoNmgxRTBWNFhxVWZwRkJ3blh1SmZLOENTcHBjSUxQc3Q2SFNmZkNJdVVo?=
 =?utf-8?B?UEVCWDhhOHgzbGtFNm1RWDN2czVLSWVDZmFSUS9pQUVGUElZbldDcVRXQWky?=
 =?utf-8?B?N3ZhQzZtcW9mM3k5aXRTMzJEWmhlcGdWd1lNdmhid0FsVy9xTUpOM2hVcHRw?=
 =?utf-8?B?bDgyZGZpTHpKcUZ6dy9IeGkvU1JUa3h1U3NHRk5UN2hlZ1hBVUNEeEltL0tN?=
 =?utf-8?B?dndUVHFCRUd2UGtMZDh1a3hQYlV5VFdaSWZ6d1VtTTNhMEFwajhJdDVJWXNM?=
 =?utf-8?B?aGdNNkRLL3hlemZjSXZybVpHa2wzUWo3VDRVVTZZNGJRb2YrZlJ4WVgvU2l6?=
 =?utf-8?B?Qm1sTmhLTFpvUHp6ZFQzTHNiYUdST2VuNGdBcGI5Rnh0ZHVWUHViYkQrKzgx?=
 =?utf-8?B?QUJmS3pPTEFMWEV6REVwWjJ5cmY0SVRGeW56WnEwby9XMlpKYTAzclZjQTdB?=
 =?utf-8?B?Vk12cDQ2ejYvODZtQUVLN3Q1Lzd1Qmo3dzkrblZxaGErbDk1VFkzSzdmcTdr?=
 =?utf-8?B?RFY3UnQ1V0xla01oNFg2bGRncDlUYTZ2R0lORmdpVEhEa094TXdtZEdPYkZo?=
 =?utf-8?B?Mml4N3puV0tFVy9uSVZ1WlYrQVRTZWk4K1NFcXFHcFVKWXZ0dmRvaS9FZTFN?=
 =?utf-8?B?Sm9WWUFuaXBDY0hvWEdPbFkrWWkxUExmSjc2M3lIRmk3ci9NT21VeENYcmlp?=
 =?utf-8?B?dTJ0a0tlMHBLTDZqTFB2WitqY01na3FEcCtYVGdzdHFDTEpUZ3hQd3RHaHNa?=
 =?utf-8?B?Y05RKzFpajh5Zm9nVzJ3aTRDbnZOcTR5eW1rdnR1UTNrbE8zampCWmlqajh6?=
 =?utf-8?B?Z0I5V1VtM3lQUEk1ZmYxcDgwMDNnSnh4UllCQ0RYdjNTVlF1R0ZOUHlDa1cr?=
 =?utf-8?B?aHg4SWwyRU5zVk9iYkpuT0o4NlNCR3dlcHRmSGtseFhHVFlkbWIrQWFIN0hU?=
 =?utf-8?B?bHdUaTQvUDF2SEMvQmswckhJd2x6S2duVnJ5MWlSc0VRQUJYNzUxT3JyVGJH?=
 =?utf-8?Q?wLnnMl0J48iazD5KOm3lteY=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec74dcfa-f99d-46fb-fe90-08dccbba9325
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 01:48:57.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZPMH0TpzlIODaAJw4an4qYKinTabmVRZ2wgv3QccF1S64bwhvZwPHtD8hkPm/zLQfqPNd1nAUe0X9mF/AUUPfFAjuklmY/+uKLCF037Bn1IL+wz+q8EeHdEggbNMEww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6980


On 2024/9/2 19:14, Peter Zijlstra wrote:
> Subject: sched/deadline: Fix schedstats vs deadline servers
> From: Huang Shijie<shijie@os.amperecomputing.com>
> Date: Thu, 29 Aug 2024 11:11:11 +0800
>
> From: Huang Shijie<shijie@os.amperecomputing.com>
>
> In dl_server_start(), when schedstats is enabled, the following
> happens:
>
>    dl_server_start()
>      dl_se->dl_server = 1;
>      enqueue_dl_entity()
>        update_stats_enqueue_dl()
>          __schedstats_from_dl_se()
>            dl_task_of()
>              BUG_ON(dl_server(dl_se));
>
> Since only tasks have schedstats and internal entries do not, avoid
> trying to update stats in this case.
>
> Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
> Signed-off-by: Huang Shijie<shijie@os.amperecomputing.com>
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> Link:https://lkml.kernel.org/r/20240829031111.12142-1-shijie@os.amperecomputing.com
> ---
>   kernel/sched/deadline.c |   38 ++++++++++++++++----------------------
>   1 file changed, 16 insertions(+), 22 deletions(-)
>
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1896,46 +1896,40 @@ static inline bool __dl_less(struct rb_n
>   	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
>   }
>   
> -static inline struct sched_statistics *
> +static __always_inline struct sched_statistics *
>   __schedstats_from_dl_se(struct sched_dl_entity *dl_se)
>   {
> +	if (!schedstat_enabled())
> +		return NULL;
> +
> +	if (dl_server(dl_se))
> +		return NULL;
> +
>   	return &dl_task_of(dl_se)->stats;
>   }
>   
>   static inline void
>   update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
>   {
> -	struct sched_statistics *stats;
> -
> -	if (!schedstat_enabled())
> -		return;
> -
> -	stats = __schedstats_from_dl_se(dl_se);
> -	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
> +	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
> +	if (stats)
> +		__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
>   }
>   
>   static inline void
>   update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
>   {
> -	struct sched_statistics *stats;
> -
> -	if (!schedstat_enabled())
> -		return;
> -
> -	stats = __schedstats_from_dl_se(dl_se);
> -	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
> +	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
> +	if (stats)
> +		__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
>   }
>   
>   static inline void
>   update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
>   {
> -	struct sched_statistics *stats;
> -
> -	if (!schedstat_enabled())
> -		return;
> -
> -	stats = __schedstats_from_dl_se(dl_se);
> -	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
> +	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
> +	if (stats)
> +		__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
>   }
>   
>   static inline void

Thanks Peter,

I am okay with this one.


Thanks

Huang Shijie


