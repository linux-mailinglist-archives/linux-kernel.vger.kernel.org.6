Return-Path: <linux-kernel+bounces-435110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D965E9E6FCC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E0418804CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E1204F93;
	Fri,  6 Dec 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="E+HCyHfH"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021118.outbound.protection.outlook.com [40.107.192.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0B79D2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493977; cv=fail; b=oJSiFo6Aw2wgNg4ZmgHHYRjGFU00qoVzWFNNUrDEoEmjDDpG59BdYm9TtmoIKihich4SXgzId+TKn6FV/OmPOeFk8sb/CcJmEw7Kilb1rEHVEvEHncHvBfGqSX9uD5TPzoJfl1V+fDjziJKMjXDVUzT1iX74IA9BPKeaMjk8yTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493977; c=relaxed/simple;
	bh=YCqJuulIXCn4Dy4dyR5SxGyGfJh9xUkWdiaCu9idPs4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DV+05mqDm0NFFQ7BginbAV9tTyYPTnQz7Mwx+FXYaxVlxplgp3ikV2wuebZnsTFYT2vzfGvluCmcCutIU9goY19ciF2FLryaPyXmwEkXlm7n0mSiTJxtJY8h3HsCCE+bEWJfCTQCM9SDSGcImeF85XRXI7Vra5eH3iu1PeOHZ/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=E+HCyHfH; arc=fail smtp.client-ip=40.107.192.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4FX1DNd341kcxTZPf7q8+gdSxq2fCpDXaCvlQNCW/XWZ0IgI6q0p+NKvm21vmFHeVXW7iYjPZZnXSoBRGc0XRfMziEQIW6HKwBBcUb+yaFyGRNXO/MwRlnKU4MqAuxIdRUucRlXkpg2sW66kHzvLbuIaj5xye0n3UXZEg4fTzBQ8OpxPNADrEWhEMMY56wA3wnPRFpdGN2vaxB9iFVdRNW2Vsgx8/HcEQuMQYmJ5pReZ7Hzf/oPbHROGXoML82B+1BMFGZ+loU5Ht2OSW1yuetI26qwxCIyboVA0SownoGB7YJscIQmgsBbrBfwAE0OPOweXf4tjm1zXQ9RBTJTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq1yfOyjKeYmBlRea1espCtf1O4pCLr3YwciCIfwcvo=;
 b=v0ABMt7nXCcM3Ms9NcqLZJLO5eO6NeYd7LX7HL3Daqaot9rFzJc602YL36nzKqPHBjQ1pDNrihCgt/27hZv+vz7E9kakE3xBss8k8hpB/F4Jp95SVf4WqcQ2o48wg9OIFbxpdbSn6DryOUiqbGdupv3jsyjWBvYle3TyNHMhZRFmz6SmlWipJJzR+apSVwG1go4UBeJUr6Fv9vpmHGWc9bdbmiluUqIx8oNn503y7x1MAPdmkNbP5FT7WmJMX1U7umprWK9crsVJ0LhGjqnwjThvjiJdiLglUou8/4b+hMbjRG1ntVu8WKZ9CW8PSolAkt0Ksp9RcdowfrnNgW+tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq1yfOyjKeYmBlRea1espCtf1O4pCLr3YwciCIfwcvo=;
 b=E+HCyHfHuF1TGraMZHqCY6DD3120SfvFmDHYwOOfj8+v4MVUtd1n+60PjrPJfkCbBUQVjVh91NCxr5LQmVnMv5Xift+gEQACkyS1b7vXBPwoPACyL9wA+BEy8yS2wmG+TG6CzonpU22FzGm4sBWJ5vatsTRHlt97aZz9MHUARVE0+21xjdnMzENdwCV/ZSDp3G0Mm8jSYOpYng9PGO9nsto/H7cO4MHtV5MKy0FuW4gVVb1GcT8VSuLBwQPnuOItyXwhiaO3YHtyejUoFdNF1DT1qajm1Yci+nag5nhhz+mu+c5ZuRsp7FK0YG+kyyJF22dzFivsas+tBVf2JJo+vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF1AFF9B787.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 14:06:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 14:06:12 +0000
Message-ID: <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
Date: Fri, 6 Dec 2024 09:06:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20241205083110.180134-2-gmonaco@redhat.com>
 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0056.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF1AFF9B787:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f9ac5f-ba6d-4628-a584-08dd15ff23fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXAxT3JnOEpaT2h4dUVHUnVEbU9QYnJyOWN3ZUZNUk4rcUVBZUNpdUV6UGlE?=
 =?utf-8?B?cEhlMWlTaWl1NmNGU2ZJNFNQSzBNY1Bsa2k1Y0QvcFloS2pCUStWTS80Nnpy?=
 =?utf-8?B?NHpteFFsY3NWMlNvdEpiVVZqR0MreWRJalhCMGJ0YUttc2FaS3FkVzR5anZ5?=
 =?utf-8?B?bTc3NlBHTWw5UGZNSWRaQVRmdDhnb3pQNk52cnF4eldhS3Yrb1BMeUVBQkpL?=
 =?utf-8?B?TzQxUWtmblZ6ejJ6NGg1MmtERCthVE5RVVJwMVdLVWVMWXIxYThQZnliMERq?=
 =?utf-8?B?a0xPb3NrcytJekltUm1YSUg0SzNKTWJ3Ynk3bXZDSDZ1RnpWMHJiRG5kU0VD?=
 =?utf-8?B?SHVyeGZvSnpIWUdacHVyTGdidUY1QjNFVGdrbDIzTGVMUlBTaDdBZHpzcnFG?=
 =?utf-8?B?YXQrNVdQZE1aTUZJM1hyTWs1T2FyMFJuOGFBMEEybTVndncrakovaVhhNnRr?=
 =?utf-8?B?NkUvZ2FMRkNGK3BaYm5XbllQbmp5WDNaRVc0MXowRTdzNmhqR0ZFT21XeklK?=
 =?utf-8?B?NHkwVm0yTkw0QS9hWTJ5WDZ2eUJyVms0U0s5ODc0NFdDNVpLQUc3c0pjY25Y?=
 =?utf-8?B?WWNEanMwaW0rY0wvZDg1MEVCcEZoRkk0WWY1d2xoOVoybDMycWhuVDhoK0pJ?=
 =?utf-8?B?UUQwamkyTWl5bUZSak9HV0o0bjVJVjJmd3pyRURyVWI2NUJDYW1MQ0VjYUth?=
 =?utf-8?B?eDBmVldXK0dCbS9sWjhOeDhFa3lFcWRnUVhCMDlxUXFvWDM5SnhpNjBRRE03?=
 =?utf-8?B?ZExoczNyZktROU9PRTg5ZlhaUDE5OCs2eWdPZ0pTTjd5RkdJeXczRzQ5NWVG?=
 =?utf-8?B?eWkraUFXR1RYbmdrbWRTVWdaeENvVjMvV2dJY0t4S3RydXUrN1ZXdDZ0L25T?=
 =?utf-8?B?dTBLd0RYaHQ5WUpYcmpRUDgyam5kUyt2NGRsNGIzQzFaTStjdER4Yml6Sjg0?=
 =?utf-8?B?ekMrS0JpTGwwb1lBK3JSNnd1ZGRVMUQwU2xyWmdmZkNPcUdhNXRqbENIYUdh?=
 =?utf-8?B?SnE0M3BQaFBoVElDV3FVekVhUlpmRzU2ZTdhYXY5TXVGbjRiNk9rdUgvelJW?=
 =?utf-8?B?UUphUTlhZmZ3RVZMOEJpV2FKc0JpcmdialpkQUxrUms0YlpOTUNsQ2ZZWWZn?=
 =?utf-8?B?MHlkSGlBOXFMZ09BYlh2UmZ3Y1hZMkxJN28vVzdkb2l6dEJsei9QUWxTb0lr?=
 =?utf-8?B?Q3FycGZvaTBqb0hHVzR5S21keFNaMk5VMGl6d3puTTdueDdQeEdlVkpYUmN6?=
 =?utf-8?B?NzR2VWhmTXVRbVg5b3diMFp2Y2tOUTJFcDh0aHpUcU0vZ3k0SVZEWHY5UUFj?=
 =?utf-8?B?SmZxUXNDenU0TEMraXBTRkIwVGE4ck5ROGg5aFB5d1RobDVSTVl4aGRXbE5h?=
 =?utf-8?B?Y3BWVS8zSjNveFVpd1kzc2RqdTZObXpNSStqTDRVOWdCWlBLNDZ6dlN3VTlS?=
 =?utf-8?B?MkdhOUVheGhBQ0w3b25ST2xua1dzRmdwTUorbzJrN3JHbkVoNW1IdExlVE1C?=
 =?utf-8?B?Nm5rWnhvUlZ0Wk9wUnF1Rm1MV3FmMStMQXpjVmM3SGcvb0NmT2xWalowN2hS?=
 =?utf-8?B?OHpibzlBOVE3anNiY0lZcG5Oem1INlV2aXA5MUg2THQ5dnB3c2lzTnpSemJV?=
 =?utf-8?B?QjUrSzJHZStsWFlISHV1a1dZNENQTUZXL3htSTJ0NTRFT0tsWDRrYVBxaHc2?=
 =?utf-8?B?dzcrSTNRRTNyTDRHcUFzbWdtUW8zbGVTWFRMNU5tZGJOSmIweTlyRklkelJw?=
 =?utf-8?Q?gAo9Vk6EyH2ZSIS7kI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTUrQWNZcWtvMlJodGgyRGNGMkdTeGZLVExlRHlXWmRhZ3hnMFY5N2QzMGR0?=
 =?utf-8?B?RTFOSWlaTE1lQ3ljY3Fnb1BTSXNpOXdVUC9sb1VJL2phS3o2UGNmK1ZDVk45?=
 =?utf-8?B?cDRkSFJkanpxNlB4NGtnTlNuLzZ2V0lscmhnWVV0bDc0Q21BMWFvRXRXQXZa?=
 =?utf-8?B?eWpLSHYzU1NhbytnWDd6dDFaRkF2TzIybkJudmg2QkQ0c3BUMm1oczVtakhv?=
 =?utf-8?B?VERObTdydXNxRkF6Mjd4LzQ1MXdLV3VJZFVXNzlRaXkrb3lYTHBhMW1Ed0RS?=
 =?utf-8?B?VXVkVXByckoySThzN3oyQTlGU0VKVFI1OStIMzNsRG9PUnVoMklIY3JTVTNn?=
 =?utf-8?B?bUV1NjVTV2NLMGRKYUx4aG9na1U0M0dsTmRIaFcrNVR3R0czVXoreVUzTTJP?=
 =?utf-8?B?WmVEVUpQQTdGQnBWcnhNekN0b1lxeWoyS3ZSa3VmWWttQVNQbUEwcW9xRUZn?=
 =?utf-8?B?KzhmTWdKWCszYTZMc2JSazl6ak5ZZjlJL1k1Wng0eW80djVid1NkbWQxaUUz?=
 =?utf-8?B?bG56Qm1JTGNJV0twWnFzYWcyOFB6WXg2Sk5zeUhRTGFrbGQ4dmw3SStuUUty?=
 =?utf-8?B?MGREU05RVXplNjgzUGFGYTlvTUo4RlJGQTJNN2Vha2FHWnM5REh6bm1UU3Ni?=
 =?utf-8?B?SzI0MzVZNzFxWkxaT1hWNDNmbkVQYXlMYlBzTXYwU00vR1h6dktncXFITHNR?=
 =?utf-8?B?QUM0bVpQVnhFMHEwNEs3TFd1a2hSdHRWM2RBTXJUYnc3bzJGdFgzZ2tyMEk2?=
 =?utf-8?B?ZE5GVnpFTXA4NkNza2hpMmRHRWQ0RFJRWkt5aTlBMllRcGFubVVRSUhOeDhI?=
 =?utf-8?B?TmF1VEc5Y21STi8xMVIzenFBVzlteE40MnArMFM0eTBjejJYSmJXRmZNbE53?=
 =?utf-8?B?eTVHTG5xOTNsRGVUZ0dJUS96dXdlWVR5dGVXZXVhRjNxSWF2TFpyUUlUNmho?=
 =?utf-8?B?Z3hwcWw4U1RQalVqM1JoeU1qcWVqVEt5a2NjUDVVVzE5MW5MRWMraG9KWUIv?=
 =?utf-8?B?V1plR0ZueHM1a3lnVE9qczZTZWwrSmE2ekxHbUEwVlpWQUlIdlpSeUZwTk1N?=
 =?utf-8?B?dlhGV3ZUWGNIVkxycTFOTVdPK2lUSXVRb0MxMjdyZSsrVVVJWnVFSFVIckJn?=
 =?utf-8?B?QkZaVGdYbDMzQUtZNkxOTW1STlBrbUk1OXVsYzNQSUV3RElDcVNNTXlCQng3?=
 =?utf-8?B?ZU9lamZHOThDQm1yN0xzcGwrWEZIdDY5MkI5ejlBeDFxYWxQbGhsYUFyeUZy?=
 =?utf-8?B?S3BpRlBmZE1raGhBRndraHhTMUlkTWw2UE1QalhkSkFjK2kxeXhjK09WZFRC?=
 =?utf-8?B?dHUyamFRMXp4RW54d1ZYODNtV2JwNFN5U1dsTzdyRU1FaVREbjAvbjVMdXJv?=
 =?utf-8?B?WFQ2UGhxUjBJc2JZVlY5cnRqVXRZbGVZUTB5cHZQUUIrY1pEMHpZME01eHZH?=
 =?utf-8?B?UUdJVjZ4MHVKNVFzQUtPTU1XanN3bEtmYzJsQ0d5d3EzZUs3WFV3eHl3em1Z?=
 =?utf-8?B?eW5TTWVINjU1dGVRT2lmaGViR3d5em9xY0NaaEEzMUVJWGhIdEQwNkFueW54?=
 =?utf-8?B?RjIvcjN6YUpndVZscW53RWZIaDhyd3JhZUNoQW1EU1NvYnlwWFNZYXNGamEy?=
 =?utf-8?B?V1dVWnJvRWlTZ3p2RzhBRnBRSU1WcFBrV2VKcUpHRGdmb3FFRGRhRFU2OGh1?=
 =?utf-8?B?cmxWM21sMjllN3NybUN5bUdBdzFwdC9Zd1lxdDRGUEtLcXRNeG1uMmNGQTlC?=
 =?utf-8?B?YmFHMzBOc0xHRVh3aE81dndDVEdNTmVHcnF5VTR4QVd0YjBQS1JyUGFHTVNs?=
 =?utf-8?B?aFVFUDlXWmFtM2R5OE5yeFBKUnV2bGxEVVRJK2FrcFRFWWp5TnJlRC93Wmt5?=
 =?utf-8?B?MHVKOGJZSHpheHRoRlFCS251ZXhYZVZETld4Ykhjc000SWlEL1piTmVOcVpa?=
 =?utf-8?B?SlFNZVc5Y014b3BLNis3UkJST05hd0Zac3JZT0g0anJySHEwWk9HaVg1bTZu?=
 =?utf-8?B?bjlnSXYrUTZBWEtLTFJDRERTTWFxbTRyZUo0dm1DNENsYUxaRXIzRFhSUyt3?=
 =?utf-8?B?dGxXamNkQitITUczV2RFUjl1M1FnWlJwOFo1NzZmS08vL2cwbk1xeklpN1pp?=
 =?utf-8?B?RUw0aXJqc1ZJRkNzODcxUWkwYjI3dysyOGd1N1FHRE9NV1ZiRURiUGVWNktZ?=
 =?utf-8?Q?vwmg6cTNyoDaDIwtM8E6NcM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f9ac5f-ba6d-4628-a584-08dd15ff23fb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 14:06:12.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7XPt8Tk2oxvRSjfoEgurB+JekYNut0NTyize409z4KUornFAAsVkXXV9t1g1e/elFM9XCkztq0z6ThZs65hsl0j08jpQOOkmvyRItLanvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF1AFF9B787

On 2024-12-06 03:53, Gabriele Monaco wrote:
> On Thu, 2024-12-05 at 11:25 -0500, Mathieu Desnoyers wrote:
[...]
> 
>>
>>> The behaviour imposed by this patch (at least the intended one) is
>>> to
>>> run the task_mm_cid_work with the configured periodicity (plus
>>> scheduling latency) for each active mm.
>>
>> What you propose looks like a more robust design than running under
>> the tick.
>>
>>> This behaviour seem to me more predictable, but would that even be
>>> required for rseq or is it just an overkill?
>>
>> Your approach looks more robust, so I would be tempted to introduce
>> it as a fix. Is the space/runtime overhead similar between the
>> tick/task work approach vs yours ?
> 
> I'm going to fix the implementation and come up with some runtime stats
> to compare the overhead of both methods.
> As for the space overhead, I think I can answer this question already:
> * The current approach uses a callback_head per thread (16 bytes)
> * Mine relies on a delayed work per mm (88 bytes)
> 
> Tasks with 5 threads or less have lower memory footprint with the
> current approach.
> I checked quickly on some systems I have access to and I'd say my
> approach introduces some memory overhead on an average system, but
> considering a task_struct can be 7-13 kB and an mm_struct is about 1.4
> kB, the overhead should be acceptable.

ok!

> 
>>
>>>
>>> In other words, was the tick chosen out of simplicity or is there
>>> some
>>> property that has to be preserved?
>>
>> Out of simplicity, and "do like what NUMA has done". But I am not
>> particularly attached to it. :-)
>>
>>>
>>> P.S. I run the rseq self tests on both this and the previous patch
>>> (both broken) and saw no failure.
>>
>> That's expected, because the tests do not so much depend on the
>> compactness of the mm_cid allocation. They way I validated this
>> in the past is by creating a simple multi-threaded program that
>> periodically prints the current mm_cid from userspace, and
>> sleep for a few seconds between printing, from many threads on
>> a many-core system.
>>
>> Then see how it reacts when run: are the mm_cid close to 0, or
>> are there large values of mm_cid allocated without compaction
>> over time ? I have not found a good way to translate this into
>> an automated test though. Ideas are welcome.
>>
>> You can look at the librseq basic_test as a starting point. [1]
> 
> Perfect, will try those!

Thinking back on this, you'll want a program that does the following
on a system with N CPUs:

- Phase 1: run one thread per cpu, pinned on each cpu. Print the
   mm_cid from each thread with the cpu number every second or so.

- Exit all threads except the main thread, join them from the main
   thread,

- Phase 2: the program is now single-threaded. We'd expect the
   mm_cid value to converge towards 0 as the periodic task clears
   unused CIDs.

So I think in phase 2 we can have an actual automated test: If after
an order of magnitude more time than the 100ms delay between periodic
tasks we still observe mm_cid > 0 in phase 2, then something is
wrong.

Thoughts ?

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


