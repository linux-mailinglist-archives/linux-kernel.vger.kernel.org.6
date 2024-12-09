Return-Path: <linux-kernel+bounces-437929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC59E9AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9D81881AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE411C5CA5;
	Mon,  9 Dec 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GZMr89mx"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021089.outbound.protection.outlook.com [40.107.192.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F635954
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758419; cv=fail; b=twOxfrBbWsVU0RSjH50InAMOikiDe00XZueP0lRedNoBoS1au0bM9ea7VRd3d3FzDe66j/+p4ef8qTep5cKmFlbPb5BYvCoiBaMz49dCFTac9MrZKfI2MRBQXei4PfGvVOFi6fkd4lOxwCGg2/0EvMQku6LRwKpk//02vQcqqMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758419; c=relaxed/simple;
	bh=oCPUJBMDeivz0U09gxEIaiAY8Bq4W+m+dmF+CHepv6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3qKGGiEXs7/8Y4l1STBxn8D+DwvOLCd+FYIWGV9RT3uQ7qArb6UpQ9FeFrHIvAs2tK1IXakZS3rjPY7UkdN1OfWuUXrVMTWC16SekFKzTCFgG4xWkRsmUJF8Ze0xFhyJRDyQe0selH5U82WVwCjLbap4Ew1QBa/i4uwe5tLENo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GZMr89mx; arc=fail smtp.client-ip=40.107.192.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6VPe7t0/vQfZiPVTdl89zwNjxYfjJubbbK1IxZFfXmkdTKh3RTBzw28gm1uZ9nqDllMYpGO223PjyeJWaVJfDFJexVyNWC2Ve0IVIhKt1YpehTKeZ7DLqu61i6zJzgR9ZI1ViomKVayImKtyoSRrTKZKsCP81IlBQ7ixCsbu08qH9CwgcQd5rYiBOrqOvs2q8KJGELMEHIG1NAAKzHFKeAu9RxGCSHfpr/AuEoSXJm0vxlUwUAVNb4Cx7aUamyEsrJRhYcRVeFmAaWjhYSDInngQ13w+qtFm7wjqiVbwaCD8jiIQ3+cy31EUFzO+n6PVNMwh6/9nR3u6uumnCi2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9DXgc2QF6uYUb0tZIE7fZOLCi1a5nrHBwBoC+3m5IM=;
 b=AdYQ/QAg+Bh+1/9LuGElNlFSvzUO2Tc1KA4y9b9lo0hmWyMQkkm1vMhjqj56+Jt8X9AAhpemooIL0YwVTHrXwHFOF4BbAVlzecgRCXXuq0gmekC4Br3+Fq2lQ+XoWoHj4+We6cfdMv09+IniNUQO+USqNmqQbmSTtEz7sVuyeZd6dCXtmL0BhnDKGNgHFTBNbnhFKTdi71pPqAoKFJo6fCRBkWN8OCmeDiI2s2QVog95hQQJR7aius3XXsUZ3ib3delaR2n9waQO+72OLJEDmMwclioWeVC5T5icqupMm6e2AMxoYZ2smCUakQzn6LpAs0H7Ca74PHESU2lUAhywLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9DXgc2QF6uYUb0tZIE7fZOLCi1a5nrHBwBoC+3m5IM=;
 b=GZMr89mxUqVuc2UMeecEOPOSKpjVmyNPB2zJ1qNivflMpLpoRJQKr4FYHjmrGmAErdxqTstSZb76XR/zYjPNVP3jLG+Les+JTFteAaecv1AgcgVeI2qkzsYxGPF6s8kmtkCeCoEBQeqRGyXxPu+j4/KJfUYYf+RN4woxLM/JgUbwPMpvIc3m3PkiqgeAQ7atbB09myIjLX5KcJwcKL7N1OMbvZrp2SXFvl9stpI2R4anbU3vmlsY+73Rn87gqijDxZLGNsSUfX+BECklXTN9M5qg+aK9/8wj2g0rhDKueTcwkDMq0EVVlc/DFJE5dCFmM0KvFAbUaMaDYaw00tTOqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:33:33 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:33:33 +0000
Message-ID: <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
Date: Mon, 9 Dec 2024 10:33:31 -0500
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
 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
 <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: f80920a5-71ab-4644-dbbc-08dd1866d71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHBCa2JUejRJU1VlNkhqUW1tRTJuTURHMm5rblBzdUViZzAzZzB4VTNNakhq?=
 =?utf-8?B?QjhRa3l0SVdmUXNONGN5aEhXZmRVOERiYTZtZHREMlFGVFlVaThOTW5wUlJ4?=
 =?utf-8?B?NVhLSm9OSmlzM3BmOUtuQ0NuSldQcCtEZ25WblpNNVlSTk1LUlRIdW15YzNI?=
 =?utf-8?B?YkxjMEFBQlRoTHcveDNhWjB2YVJiSXVGTjJjZFZQdDVJd0t4bW56dGowa1ZK?=
 =?utf-8?B?WWx6ekVrNGJvMSsvKzZVWGtLbjM3U3FSL0hZUU9XckE0VlNzK09rdjRxeGw4?=
 =?utf-8?B?akM5Q1h3a3J6TVB0djZobkQ2S3ZTa0pmSXdDUG94c1dXRzVYL1kvdm1JcDla?=
 =?utf-8?B?UDE2Q3RnNnRTRmwzNmp6d3dMVGJBMzRNYUVMUE9wVWxCVTNCSzNJRlN6UEhy?=
 =?utf-8?B?aVh0MnRMR2N3bkhuZGJ6Z0hvMmgwclpHbWhpYXpkdldxSkM1TFAzVjN1cXZ4?=
 =?utf-8?B?a3BxY0RYRzZQdGpWcXpZWEF0Nnpia0sxL21mZUduS2l5djBuVU50REhkejFS?=
 =?utf-8?B?YmMwUmNlL3NHeDZ0RXYxZnpLSmRHbE1GenpIZzArc0VwQUhhY1FTZWkvb0F3?=
 =?utf-8?B?MmdNMEROMjQyRW1rSVVSYUM1OGJHbGxUK0xVT1o4S1RIL3JIcHJMUmFKVDRP?=
 =?utf-8?B?am9aNFY5SERIeXlCWUVVSW1RU0R4MTV6NUhlWnQraUlYN0pkV2o1ZEoybnUr?=
 =?utf-8?B?bExNZnhDRFQ0V3ZrRnlmcnpJY1J2MFVybzczK0ZyZmNKWFdzQWYwdVRwUGdH?=
 =?utf-8?B?YlpvaWYvN3JBRFRTRkd2T1lOdFVabUxZdktvckxmSkplTFJSWGhHOHgxVHBM?=
 =?utf-8?B?TjNER1c5VWZuRUVBT0xCSFoyZUJwT2hnNTBrMGl1bFAyUG9GdEtaeUQ3cGNx?=
 =?utf-8?B?bmVsT2xuZGNRTXRWUks0T1dxSytHNlZzYTBOOFZtYitoWXozRG5WMjRWWFlh?=
 =?utf-8?B?ZDNIbEtTYVlURURHQ1NHY3ZlNTFGU2tDTFBDV0Yvall3Y3RJY3lUSXRHaEQz?=
 =?utf-8?B?S1BCekRmejN3ZFFBUjJmUGJWaVZkVXFhbDc3L2xnR1N1YW5OaERySEJzQm8z?=
 =?utf-8?B?WDVuWnk2OHgrbjZXNHNidXIxM2t1S0lWRTc5NDdna1Z2N2hMcVRYMGswck14?=
 =?utf-8?B?ZzM0cnduL2FZZXVJYnRyQXM1djQ0NE5VRnRWTG1zL0hGT3lDU3FaQklQQWJ5?=
 =?utf-8?B?WXRPRGRvZWVJZFFIZUNUTHQrSlRGSWZyVkgvV09zaC9CVkQ0d3lxVGU0cEpz?=
 =?utf-8?B?bFppbmtyN2dqVjl5dnVmN3R5VGpRN1lNajhBR1VTU1k1RUt6ZDVrWTQvYWpz?=
 =?utf-8?B?THRqWHcxOEI4NyswdmNZQjl1YXV2QlFmY3N0L3NNVDdrQ0VNTGp0dnI0UEtN?=
 =?utf-8?B?TTFzYmEzVWhtSW9saGVmMUpTMVpVQVJHcjRrZktZUlh3T0M5clQ1YmsyTTg5?=
 =?utf-8?B?RnI0UUp5eG16VG9uckhMZUJ3aDlUVnlKSDltMy9ESk9tR1hoVVZ3cmdhVFpP?=
 =?utf-8?B?SjB0ZkZjY1NUVjJKNmg1d3BvU1dnZ3ZrU2ZlVSswM2VKUmhibTBTV3g5UUo2?=
 =?utf-8?B?aTZqZU5FQURBbXg3TG1oK1F2SWs3bHBlTVFJMWRpanFvNDlkTmVhZlVvbHZv?=
 =?utf-8?B?S1dTT2JINzlyNHVFU2ZQMDUxTmxkaGRvZ0tGbXRiUmZWQm5ZNjUvUVZJQ1VS?=
 =?utf-8?B?OGVXcWxhRGszRVBRVDJmZ3pVSW9QQmppRVl5bnlXN2pqTFlsMysveGIwOHNh?=
 =?utf-8?Q?c+BwQADIcrl429t0Ck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K244QmZYZ1REYjdJQ2tBRWRuMUtyWHFWMWFzMVFOUHdDMVhVenQrd1lrNEZz?=
 =?utf-8?B?bmc1UHZZaDJlUUM0VEVWOU10aVJ1R01acEpVUDRmTHZzV2dnT2dXaGZPTEd3?=
 =?utf-8?B?SjNsOVJaK1ZNZUQ2NTFWd1A4bk1lejliUGJNMkdqQjR4Y25YS2t0MDcvREhO?=
 =?utf-8?B?WkdsdHpCQmRMM2lRaExxRWFVZlZmV0NDNTlXTXkvb1pSZ0VJM0w4ZWM3MFlq?=
 =?utf-8?B?UkpWUEZteGd1S0loZTgwN0ZsQzdEMXNuZG5lM2h6eGxxanJ5OWNkWFdwOThw?=
 =?utf-8?B?RGl3VDM4eitPQjRjdWZlNFp4d0hSV1o4NW5HZU55dkpJK0Y3RGYramEwSzF5?=
 =?utf-8?B?NFpsSldwOFRSY0krOUd3YXRtV3ZzQ1V1SFVWeVhEOGtFeDVPZXpwakNJVXJ6?=
 =?utf-8?B?QWxBZkx3L0NPWFZ2TjBQUGJoVGlyWUI0aDFDZm5ibnRDVGtEdkFTeU80OVkz?=
 =?utf-8?B?cGxPRmF4YlF5SXBMeW1hejFzQklEU0pwOFFsenJnWHEzY0h2NGhHRUlDWXl0?=
 =?utf-8?B?d05UUFRZN2pUb3IyODJGZ2xBRmZmUk9JTGtkRW12TnZsWHBMT0pKODRpaWUv?=
 =?utf-8?B?YmlHTjZzcEpRQnNHazhlakkrTG9JWFZPZFlWZ2lJNFhqZzgvay9oWUZEcjFx?=
 =?utf-8?B?VEpBb2RTU3A3R1p5VmNDUUU3VlFLNThHdHVMekJYeUFUSXBrUTlRdmtsUVo0?=
 =?utf-8?B?VmFDOFQ4dlh3TUQ5M1grOCtiZVNaQzNVOVUyMjg0L0hxNlh4UHE4Qjl1Nnc5?=
 =?utf-8?B?Wk5xNjdJR0l4WUhJcnZlNjh1Z2QxM21la0xucFhKa3pNL3lVR1Q4bDdtZllv?=
 =?utf-8?B?MWlVSTMvNWNPVGNJdjRBcGlsUm5YN1JGNnlvSllsR0ErNVlrT3oreDd0bU9M?=
 =?utf-8?B?WWZreDlqUG52UEJGZ1VHT0ptQ3dlUjRmaVRHZzdRcmVMU2dlcE45L1RWMjlB?=
 =?utf-8?B?R1VHY3NxT1JMbTdNMnVIdnNzUmhFUXNjUk9FMG9McWRZaUFRM3V1ZjRqeHcz?=
 =?utf-8?B?R2NBd3J5VVZXTzFjSTdRSjJYaUhpcE9IdlpXMURaT0xZVkdwNXNnemdLVjlm?=
 =?utf-8?B?b1hBWTgyU3Jsa3RiN1dXMithSkp2OVlkeklobWdSY0lZQTZ5aURFd2RsMkVJ?=
 =?utf-8?B?N0liRlR2cjJxbzVDektlOGdheXE2SG85WU9LNTVoTkw2TUMrTkxOOUhFYURE?=
 =?utf-8?B?elhYUFFqcVYvSXdlZnd3Ri9HT3FCV1FGdFYxMFN6YmhZMkdvaDI5VExBMkY5?=
 =?utf-8?B?NHlzQmJpdUJseDZDQ1J3MXkrYUdodGluV3hFRnVvd1BXM0owOEVVbkNwR3BK?=
 =?utf-8?B?bGkzTjJFZy9Dbms1THpLODNyb3h4VmhlTFdjQjdCRThOVDZvSTdseTIwTzA0?=
 =?utf-8?B?MDdYMTlRNWhISkFyWkRoUzdQQW9SS1RMdGgwalViRm0wc0lBNlNIYmQ4Zlpm?=
 =?utf-8?B?b2doUUU4VStXbitsR0xZa2krbHpyRkM5cmJ0S2V1cVdzc1dkTzFSYjlFaWNk?=
 =?utf-8?B?cGl5MGkzblArdlQyQVV6SFpHb1FWcWlnemZJOHdsdEZoMXpCTHlpMEdvRW9k?=
 =?utf-8?B?Vm1meTN1YUZOQVNkREJGRzlzYmNCR2hRYU5aKzU5V2YrRVF3b2c3bkhLZlRY?=
 =?utf-8?B?aVFSOXZwejlVT1UwVFQ1MGtPdkQ3MDlwVVdKWHdQU2RXOU9NNVYyTW9FRjF6?=
 =?utf-8?B?Y1lRRXBCNWlXYUpTNmJtbGZNMWJaYXBXcHl4Q2dHcC9heXBTKy96dmtJeU9a?=
 =?utf-8?B?VURuZFFBMU9UN0F0ZjlsNFc0ZDBRbzhNV2FzNlBVbWMvaytZb2tZK1BIVG1H?=
 =?utf-8?B?VWNWWVhZSE9DVkZ5TVowZGUrK0JndFlJRFBmYm1JZTFROC9sQTM4eDRnMkNi?=
 =?utf-8?B?N0QyZFhXNWJEUW5OdENvRG9wSjVjWWhHY2UzNEFhL0VqRW1KZ0Z4ZnMwelNZ?=
 =?utf-8?B?a2QxdmhXVnRKWmloK1hzQ3ZHejRoejh3UG9oc3pKV296MHZoamtQdWltVTZv?=
 =?utf-8?B?UHdKWVJhRWE5bGFGZUlZbVUxL0JpcCt5UFhZN3ppeW1VRnNCYWxHL3NWdzht?=
 =?utf-8?B?bG1mWFVBRlFIMjQ1SjZJT0x0VXQ3aXFoSU5YNFE5UjQyMVczYzNoUW1FQUJV?=
 =?utf-8?B?NUxMdGtyQTBrbytqMGpOZ1dxb3VLMVl1Vy9LQm9oZDZFazNNbHNUT25NZzcz?=
 =?utf-8?Q?kJ9dSEvmDMjDFts+omXiN6c=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80920a5-71ab-4644-dbbc-08dd1866d71b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:33:33.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf9QqvbZz8MxW36xuRy43OaErsnYQ5XamL+NJZmYGtbsayN7gq1JpoApKJaL4fsZybb+4sgIDj2Rx4/Q3rX43mY6HzMm6KxKIn/BEq9Lvmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11083

On 2024-12-09 08:45, Gabriele Monaco wrote:
> 
>> Thinking back on this, you'll want a program that does the following
>> on a system with N CPUs:
>>
>> - Phase 1: run one thread per cpu, pinned on each cpu. Print the
>>     mm_cid from each thread with the cpu number every second or so.
>>
>> - Exit all threads except the main thread, join them from the main
>>     thread,
>>
>> - Phase 2: the program is now single-threaded. We'd expect the
>>     mm_cid value to converge towards 0 as the periodic task clears
>>     unused CIDs.
>>
>> So I think in phase 2 we can have an actual automated test: If after
>> an order of magnitude more time than the 100ms delay between periodic
>> tasks we still observe mm_cid > 0 in phase 2, then something is
>> wrong.
> 
> Been thinking about this and came up with a simple draft, I'll probably
> send it as a separate patch.
> 
> Doing this can lead to false positives: the main thread may be assigned
> the mm_cid 0 and keep it till the end, in this scenario the other
> threads (CPUs) would get different mm_cids and exit, the main thread
> will still have 0 and pass the test regardless.
> 
> I have an idea to make it a bit more robust: we can run threads as you
> described in phase 1, stop all but one (let's say the one running on
> the last core), make sure the main thread doesn't accidentally run on
> the same core by pinning to core 0 and wait until we see the 2
> remaining threads holding 0 and 1, in any order.
> Besides a special case if we have only 1 available core, this should
> work fine, sure we could get false positives but it seems to me much
> less likely.
> 
> Does it make sense to you?

A small tweak on your proposed approach: in phase 1, get each thread
to publish which mm_cid they observe, and select one thread which
has observed mm_cid > 1 (possibly the largest mm_cid) as the thread
that will keep running in phase 2 (in addition to the main thread).

All threads other than the main thread and that selected thread exit
and are joined before phase 2.

So you end up in phase 2 with:

- main (observed any mm_cid)
- selected thread (observed mm_cid > 1, possibly largest)

Then after a while, the selected thread should observe a
mm_cid <= 1.

This test should be skipped if there are less than 3 CPUs in
allowed cpumask (sched_getaffinity).

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


