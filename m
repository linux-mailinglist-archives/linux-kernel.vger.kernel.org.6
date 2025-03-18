Return-Path: <linux-kernel+bounces-565898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD2A670C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF1D3B292F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CA207A22;
	Tue, 18 Mar 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ERFiwmaC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF8224CC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292473; cv=fail; b=QVMcT8exrAgeuSxMIpKKGoiqxFnSLObFEzOdBouACMCU8LGqXmtVscEaeIh4sJzPtGpDWBWk1mYlz4O4bmXP5dd2MbJ3Ypc8nnoY/7y5z77lrA3wbWQVwKmYiHJAmeWHG5/5qm16/EJAJmL5nTs017OifPTHzUi2zlBj3trdcQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292473; c=relaxed/simple;
	bh=Eedy5u1+zLSIrtUQS7WPebu/kQEKa7hLfOXtrF2tW2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BkjAuFspGNvIr8h8+82uqg/AB1h0pUrbuYTs8O0SjQJEmwkL4pLbAivS5BTHS9XtuTvxvrXvOiPg+HGd6UivDgIamx3yAYFKHzHlgt3r+jFI7GTo+2bEzUhrbFXwAgSM5OHJ32FOz5daspmS0qiep2Pf34Xpo3wBqeS9Uo8vXG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ERFiwmaC; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYtsmUfo0KQgJTegrDvw2azfkdyclqhG1ocQN1KRggSduOWqXCTqVfBW+/BMrJrl1hH+vsN8CN/KcwCZlWzSysuPpildXsjsSF5yrPLrWds/5Q1C5QamwqX4kygDydyFyXACkqqimXKkR/M/bRV4+XzZcfJjELdv4TyLzlYPbTx2GMKorCvpxg3ksDpuNx4i4IGpDVdUJul+2lHV8fy/27o7lEF5xH68NDAN11fdfqMRdZT4dNIxzSS9uRaAWaXTF3pZE6i5JrqlIZ9yw03+yNzdaWRLkoWISeMVX4zqwuANbfjjuAOY5XawCtmBfAXnzm20YUDcMMa5f3cP6YapZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eedy5u1+zLSIrtUQS7WPebu/kQEKa7hLfOXtrF2tW2Q=;
 b=kzSAzvI31+LKRsIqZVxOazjKvFGZHJ2IkeJ9VGfvdaUO32zOgQ3tyDAjJSGSaMfSByCOPQIAr6rzBbBdQfFIWmT6lUgdlDU06SpSnkzFhQ9SM1HwyBeLBdySKM65L+cMX4g2s9kTVSOPdldVysO+PW6+/m9qKVY9VWdwIxN64MZKFqTzALaI26nuVQE8MStddabIFsXORla40+9FA+9smzWm75+EdDdKOyFGfpRiVieNoYA7kqtWdz58I6qsPV2y25gO9tsv3OZ9LGSZF+EWk6hZhCbLqaq5BpXagTpMLjgOGIATc8LHlgMUs35KVkwMUc9aVVFlgQ4damRgYjvjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eedy5u1+zLSIrtUQS7WPebu/kQEKa7hLfOXtrF2tW2Q=;
 b=ERFiwmaCa/p9WUC6lso6asG/gIEvw5EN8KVN/genNpKcENJkqt1LBaVx3/8ghKjIwA7117XTsiz5flyZkBTZyxHCM5SnONHMtpHiO1DWGODcTXdjpkWgFZvZAlWkyDvSnRMY8K+4nJd1XyUe9KoUvul6lhiGhO1C923gqVvnuv87Tax+2m/Nlzw+LvqjtZ5RKM2hMM0gu93zufi//51o63QwhspY+E6v+3Naw7aYP32/9UFbTA9q8ueI/C7V4+9IA0gmTxfkz/2i4KD/q60yFfy5db32Wcvyh8bS6UGCf8CyDmcCrfUOf8wgR7vN+uGo6At1ZRDDirZf09C8+K1JnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 10:07:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:07:44 +0000
Message-ID: <a21dc7a7-a8ce-4cbc-a393-1b2b5b8e75a1@nvidia.com>
Date: Tue, 18 Mar 2025 11:07:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
 boqun.feng@gmail.com
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
 <Z9hUby9e1JYaE6iC@slm.duckdns.org>
 <20250317170602.GE6888@noisy.programming.kicks-ass.net>
 <8d9e6300-113e-4a89-8fc3-2ae895c77794@nvidia.com>
 <Z9ifV3UcLPNvBttF@slm.duckdns.org>
 <4b8a25f7-c7c8-467f-8d03-6e590712ffbd@nvidia.com>
 <Z9imufPw3NbcpqJV@slm.duckdns.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9imufPw3NbcpqJV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: bb58efe1-fc26-4b40-a4ed-08dd6604ba21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWgySlA5SVNSdUFXMHFCU1VSZFYxQXMyclcvdzBLUzlvME94OU1yd256WlV1?=
 =?utf-8?B?NjZUWjY2S1BKUVdIUFVCSDRSQ1hxcEh2YnkyYThGTmRIem1QM1JPVGlUZHRS?=
 =?utf-8?B?ZjZUTnRxdEZqMkllQVhxZG9xSGd0aGtrRm5LR2xBTkU5Tm05K0x4NkNoWUNh?=
 =?utf-8?B?TGtQNUM2dmRFRC83SkJ6MDNFYzhzc3JaeVd5TWhqWktOci9FektJaUw3QThs?=
 =?utf-8?B?UWk3KzlYZmU0ZVBiMjE1anFFT0ZLWkplSm9ZbVF4YlN2TGdzc1RIQ3h1Tjg3?=
 =?utf-8?B?NGlUVWw3aDNPY2VxdDRRdVQrbGI1NGNlZnB2SFpzalUwMW12c0lUUVV6QnRD?=
 =?utf-8?B?ZTJHYTFQa0VJOGFCOHRYdmVYdklnMDNBVjBqZS9QTnBxNEM2MmhaeS9zZ3pX?=
 =?utf-8?B?a3dIR2I1MzBOS3B0VWgxTGRiYzJma3Q0REU3NFp5R09mNWZDa2VQOEM4L0V4?=
 =?utf-8?B?anlIeUIzTmtBSVVndEpiM3FHcTV0clE2OGhOeU81N3lobnp3aGd2TSs1dklu?=
 =?utf-8?B?dlRwVHZYVWZoWkF0d0VqQ3BkYlJFREVuZXpnRUJRSWtVVHZZUHczU2hraTV0?=
 =?utf-8?B?d0ZOcjJDekJTbHpLSlJNeTBidmNZaDFNOHN0UHJabmltQXVlRUFoL0tpU1RW?=
 =?utf-8?B?bVRWYkVDdUtOZUpMMnlxTlBVUk5mcGhQNEJuL0VjNVBKbHAwalNTSDJydFRX?=
 =?utf-8?B?eE5XVlk4YU0zTlY4OWRFUEZvYU5TSGxndFFVUzFvTGljQWN1QkFOQ0FKQ3pN?=
 =?utf-8?B?MVpSdkxuVFNkWEFzSUNzUXRvTmMyenN0ckxtNEZaaDBCWU5FQ21yNkpEQUlF?=
 =?utf-8?B?bmdkQW9tdEZNdnpsOGZITmxyczc1TEs5OVZ3ME8vM0ovb2VKLzBQZ21wVHNi?=
 =?utf-8?B?T3VoQzFIL2FnYmtaK3hHeE9CczlaYTM4bkpBakFEc0gzcE9ibWxBWW9ya29S?=
 =?utf-8?B?SStGUkJCS1p5R0l4U01ydFV5eXVidmJib1J4NTh1Vkp5TTlFajV6NVl3dnlM?=
 =?utf-8?B?Rkp6bW0rT3lzRzkvMUFzSXJJQ3JXcjM5TlFaY3ZzQjQ5ZnBKekl5dkVxTnRP?=
 =?utf-8?B?TlBiamFrQ3BXRHBPRXJjdHZrazd1cE1UenVBZnBxODFpa2pGZkZzWjlrRDBT?=
 =?utf-8?B?SVdEd0tKbWo5cmM5dE40YWpXN3kzZUlGS0JJbHpGZFdLNjJIdEUrcGcyQlFY?=
 =?utf-8?B?V2N0YWwvKzNlNWF1WWxneGNYWWVVKzJGeHdxN2dQaUgya2ZqOG1lUzg4RW5J?=
 =?utf-8?B?K2lKQUlYV20zMXhuMnNra3JnNll1WDBsaVlUK0hpdUovZlI1ZnQ0VFMvUHFY?=
 =?utf-8?B?MGp2ZXVOOU5VQWdBbmdCbEVtVG1sRmhMbXMyTGs2eW9vV0xSVXRJRTF6ZUpT?=
 =?utf-8?B?ZDVicXR0UW1ucVh3MjNWeWNyT2N2eEdnb21FQURtZWd6a1RLSXNzUHUwMVhQ?=
 =?utf-8?B?U2NjOGtpeVBtM20za2YyZHlxSUtNUmY4ZzJDdTh3ZzUrZXk0bnNxaUJNNEls?=
 =?utf-8?B?MHVlMkZSVXdZZFY5dHRjdkdJMDd0c0ppOWltN3FmandnL1BaTUVMbStBNGpI?=
 =?utf-8?B?c01jYnlJUnZPZDRnSkZUNGxVWEtoTld5Vm9FbU9iSDVjOElMYjRQa3hvK2VO?=
 =?utf-8?B?NlNXOGt0QkNqZVhKZjBCUTBGRlA3T2w5bjZrbGl0MHRUcDNoYVFscnBzOVBi?=
 =?utf-8?B?U1dQS1YzVHpTN3R0QnJMZU4raEtZZFJzRDRTbE1pYkpYTUtINitqaFFWUmtp?=
 =?utf-8?B?NWxsTkNLMWZqT2l5bDhXZzAzOGFRS3lXNDRSYTM0eHJGK2RUemdaRXduUE1o?=
 =?utf-8?B?OURYdFh4MURLb2hpUGFNN3ErdGV1MVovUW1WNGRlNmc3TEdEdkdtckhBdkhT?=
 =?utf-8?Q?JUqyDinnS9F5b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVRkTE5yU01pRUtFK0N3L1hiRmhLeFl0emU3VUZtM1dMYWd3VUJFbWlzOWZt?=
 =?utf-8?B?OHc5a1laNDk0OXQ3Y0hCVHhtdmdJOWR6cUNteUd0eUZsWE4wZGNkYWV1V2k2?=
 =?utf-8?B?M2V3UlEwSURIOVl6dW5FeUs5dHFqTkJ4TnZZT2R0Ykl2N1dsZ1BDeWVBR1d1?=
 =?utf-8?B?WXNaS1dLdXY3bmtJRGxydW1ZUnRSR1Z3aXJjS3Z3SVI2TlFReDBxZmV1dTRR?=
 =?utf-8?B?V0tLN3ROck5JelMzR0xRVGpUUXFxc3N0WHlWS0lyMTlhUWxSL0F6TVhTanVh?=
 =?utf-8?B?ZEs3VmhjekV0V3RQdEZWZEhUdm81TVYxNVVlbjJ1MmZIS1hrVzduVGZHRXV2?=
 =?utf-8?B?Z2J1a0xhVHlZcDZoTjFyMlZXaWlsNXBNLzFVRDVoRHMwVmxrMDV0L0xCVEps?=
 =?utf-8?B?WDNLNGM2ZlJERmFQMER3U2ZUSFJ1VnNXaXV0SWxLQ2NtZkgvWlNSSjRXcGtK?=
 =?utf-8?B?c29wcnVzQzN0VnV1WDNGSDl2ZCtOTWxjSDEwVi9xaHhDV1dsL0s1STRpTVAr?=
 =?utf-8?B?WU11WXVGYmpSM0ZNQWFMNDZsOHV2WllxNVYwRm03a3FvenQreGZ6OGJZZ2c1?=
 =?utf-8?B?MWJGZ2xUUllNRCtPZEwzazJjZXBBYlRmbFAxQVM1M1pRa1hPdlkvdEtMcDF3?=
 =?utf-8?B?TktsYkJxNzk2WDdHeVFTcEgzSjJEeG1MK090SkNBd2hLU08vaTJpczdkNVNi?=
 =?utf-8?B?SVZQV1ZYWEtKUHVqRlE1Mkw3M3VSemFOdTZDNklscFRvd05NQVhXY2wrNHgz?=
 =?utf-8?B?eDJZQ21Hd1hibTkwdXZwc2tPMUlqU0RBVFlhYTJOQTlrNjVYMmQ3YmxNNTFl?=
 =?utf-8?B?MGhqQitwV3dNUGRXaW15UDBJRHBiZTFWajVPTzVJbHJFa0RWN3owM045R084?=
 =?utf-8?B?bUQ0cTF5RnpCNFpnckY0ckltMHVMelpTWUtCUWVkdUNwZnBveTNESXhpckFY?=
 =?utf-8?B?OFZ6NDB3SDVxdW44THN3NUYyREtweGtRUXZKUUh0K3NSVVZWVytGRFoxa0E4?=
 =?utf-8?B?MmdQcmhVMk1IcGhQWURwNnRma1FENUpyOGZNUnBCTUR4YmtmOHhoSVI1dDJM?=
 =?utf-8?B?dUhXQWdlNDhCQzB0c2gvV053RUxBdzJEWnU2Wis3Ym9RU1ZNZTU2Qmg0YWxs?=
 =?utf-8?B?L0ZwNmVvd01vekV3QkZia1FadGVrMU9sNFh6VkkvcnBJVlk1TzNtMk1XTDV1?=
 =?utf-8?B?dDlMRGM1cmVJYWVFQ3FjS0p1SUJQeHU0V0VKdWIyNHd4bFc1cXpJNnJkOHpI?=
 =?utf-8?B?NWliNkQwN3VZOXkrMDZnYkdtQVljVHVvc2gyWDV4dlpYQS9YMW1Talg3T2VS?=
 =?utf-8?B?b0dxS0hKWC9HMGRYTUVvVlVVOVpUREJGNmFzM2lBNDNMZDFhZjBGL2Fia0xJ?=
 =?utf-8?B?cnNtUlpDTmF3WFh2dmZBNThrK01mL0kzNjlnbk9XbjFRVExXdmo3cHZKUTJh?=
 =?utf-8?B?MkZON0sxVThFbEN3dy9zWWU2QzE4SUNEdUFvanMxQ1VDcUlCTExUQm5NazlY?=
 =?utf-8?B?TUJjaGNpd3dwekUwWlFhd3FVL1hqYUllRkJpNTdaTE9JNkQxRm44V2g4SUJM?=
 =?utf-8?B?WkRSVWV2bytqVlpZaEZKcU56SmRYTTYyRjZHR3UyT2lTVVNCS2FoN3YrcUdP?=
 =?utf-8?B?K2NLRzFOTUlVYncySHFPWmtYVGJCMS9neGJkcUl4Qm81WFZLVGFXQ1J5QlBQ?=
 =?utf-8?B?TnVMdjVNd2s3eTQ1aDFxMWJNT3J1d1hpU3dyY2laR3Vwa0FzK295YkUwUEcz?=
 =?utf-8?B?d0l5alBRZmdya2pXQ0FIazFwK0hDVHNTc3lqVHFWUCs0b0ZhYXlVdVM3MHZp?=
 =?utf-8?B?VUdkMWR0ZTVwN1hyUXphUkYwT2YzMFV6dVJacHVFMEtpRGtyNnhpQTkwQVNZ?=
 =?utf-8?B?Ky9GcndxZ2tQZm1Ea2JwMzMxdkVYYmkwdlRBM0RLaFl1c3dKek9KaXZvVlJ0?=
 =?utf-8?B?L2IxM3cwR2tUUnlyR1RKVXYycFk4N3VNbVdnRWlKZU84SDlHVWhOalE3b0p2?=
 =?utf-8?B?UDBqcVYrenZOa0R1M2svUnAwWUF6YTNuRTVyUHRiMkgyU1RmZGl5YVFWS1kv?=
 =?utf-8?B?MzhCRXpVNTVqY1paeUJjV3FnOHAxMVJkVHNLYTdNeWhsMGY1MzlqRUhZVUdW?=
 =?utf-8?Q?Dl7lAZjDFytWP4zbHImgdQ0or?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb58efe1-fc26-4b40-a4ed-08dd6604ba21
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:07:44.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo8S0smNqYqTG/3om4LbN3lCRqWhoS/NOVUpt4xiNKjVPK1lv9ItRZoFqL1h717f8rz/aLb9BMcbcbVlenSCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493



On 3/17/2025 11:48 PM, Tejun Heo wrote:
> On Mon, Mar 17, 2025 at 11:39:32PM +0100, Joel Fernandes wrote:
>> On 3/17/2025 11:16 PM, Tejun Heo wrote:
>>> On Mon, Mar 17, 2025 at 10:48:16PM +0100, Joel Fernandes wrote:
>>> ...
>>>> Just to clarify, Tejun is suggesting that in mixed mode, we boost EXT
>>>> independent of FAIR. And in normal mode, we we boost both FAIR+EXT, because well
>>>> - nothing would be running as fair anyway.
>>>>
>>>> But what is the point of doing that, if we have boost EXT independent of FAIR
>>>> anyway? We need that code _anyway_ due to mixed mode so it would not simplify
>>>> anything.
>>>>
>>>> Or did Tejun mean something else about "toggle the reservations"?
>>> My understanding is that if we have both FAIR and EXT's DL servers reserving
>>> execution time all the time, we'd be reserving execution time for something
>>> which can't be active, so the only change necessary I think is just
>>> retracting FAIR's or EXT's reservation whent we know they are not active
>>> (ie. if EXT is not loaded or EXT is loaded in full-sys mode).
>>>
>> Ah, I see what you mean. We already have a 'toggle' like that though because if
>> FAIR or EXT is not running (due to whatever reason), we would have already
>> called 'dl_server_stop()' or would never have called 'dl_server_start()'.
>>
>> On the other hand, even if full-sys-mode, we need the EXT server to boost it to
>> above RT if EXT is running, so we need its server initialized and ready to go.
>>
>> Let me know if I missed anything though, thanks,
> I'm not very familiar with DL but it looks like a stopped DL server would
> still be reserving bandwidth which limits what other actual DL users would
> be able to reserve without causing overflow. It looks like EXT's activation
> modes should be calling into dl_bw_manage() so that FAIR's and EXT's
> reservations can be retracted when not in use.

Ah, you raise a good point. Sorry, you were on to something and that makes sense
to me. Let me see how to wire it up. Basically, when we switch to full-mode from
say partial, we could/should remove the bandwidth reservation of the servers. I
think I confused the concept of "server not running" to "server reserving
bandwidth". My bad!

thanks,

 - Joel


