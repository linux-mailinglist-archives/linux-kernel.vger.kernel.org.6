Return-Path: <linux-kernel+bounces-178851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEFC8C58A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D707AB21727
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEA17EB8A;
	Tue, 14 May 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v0I7JsGK"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38983A0E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700210; cv=fail; b=LDNTQV3Gb8GvvyPwFcKNhRZy5DbIrnQ6jyqmqn5C9fkfqxipLbo7swSoGPWVBmBkQsCQqJHdR4AIV5xcxttxRr5GJxBa5YjlocYCh3Yh2j7VsIdsYxjSU8OCrtYLiDfKTszuz06kksArJ1iHR6/wl9y5wohvw8y78gFXZirIqNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700210; c=relaxed/simple;
	bh=neEIiCt3lbjD3NSsbvh5gpXXuYzVuDCDRDg2N64q0VU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cfv7hnfnv28ZKZxpZ7Yj7v/yOkZx5UXoZnPEAbJwfGl+qB/g6a2R3XrWoR4pO+0y/PKS9wrY9m6fVk+orO87C2269/J/WI7GgOyfbGtlLfhOMpGZEJxM+Q+n19Ur1gVnkAnbroolp611Qe39r245jh7aoVz3CJVCeMXrCk5APEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v0I7JsGK; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMFEU2qsW68ZUY4c+6cCNB82R7Z8JGF/t1ez+WMIFAV6L3KEjqTml6Ar0kI2SGVuhyv7S54MuX+sJDLswhN6WL1i/BfIOy4kpMb0d1VSHSPV+CNH/eyfcKX9oT5l3OXGNJwqzeptbGGQSgWnBBUHwtDXFyRgUyZDX9RJJD1HX4LykyTXIk2RWXxz1tWsWoP6emzBwVYFNfbR0yhS+r8u/+QlM9TYhmHyFrMo2/X/cyc2XC/ocHfqjzwnBsFOFt8BCyp5BDe3KcKnxL/C8inHUVnvONeaR2D+dmN85yCjcLwtjaMytXZDDFVfYIenwSljbWKozEeFkuIQkzFOZGWNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNB6zD4JOJ/hxWu5hdw2l4DLqnLFZEy/AWLPmJGX5L0=;
 b=GAA6zY6tWm5pOp4kMfVEZQ2GJUhTAX2AQGM9TYmQBeQSgLsJrQREcPSiePf6nID5q6u8egYiRIsVErEzYehAmARNNXVqMAGnFByLIhTSv1j54gNLOjzkzAOi6QYj1CJwYuS54/DkcLcZEE2ou6LirFTABAvhpuPyd0HhPoQmNr0uMaojXeB9kjgZ/KpEmYvJVNiRsH4NYbWjJgWBpLxCVGZcGyog0XV9eyBVYK7Imv1gFvBMmDTX0oqeMpwjYbHs9qFNWyXAPf6QBW2p/NrGjGFbEItBth9gfpJODepIDUd68mdSNfbaWxjv6enOZVvKfpjzpkj+W5EhUXG9O4csqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNB6zD4JOJ/hxWu5hdw2l4DLqnLFZEy/AWLPmJGX5L0=;
 b=v0I7JsGKixEQgB2m1/1HprG8mjlmP/7re6PvENyKs+yq2akWXyyZc9mVAmLqlGBbPguYJ08CoAaJQnIP9JLGNErNGiLMeDCz3rHUNbrBxsBW3H+eDA8cWhFgovuz8eDSVYrJcCw8edupdOkjSDyH9p6pINBFvXYM5jhfp9eb2IY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:23:26 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:23:25 +0000
Message-ID: <f2eafde3-b9e8-afc9-8934-ca8e597c33e6@amd.com>
Date: Tue, 14 May 2024 20:53:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
 tim.c.chen@intel.com, yu.c.chen.y@gmail.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org> <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
 <422fc38c-6096-8804-17ce-1420661743e8@amd.com>
 <ZkMsf4Fz7/AFoQfC@chenyu5-mobl2>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZkMsf4Fz7/AFoQfC@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: e3eb30e2-3306-47dc-6df1-08dc7429cc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDZMb0VPTTBGcVlKOVVWUTMzNXRDUytnZkNQYWp0MGplQTJoTmYvbWRFYzZw?=
 =?utf-8?B?RnB1bWVhVGtkZ2dqM2Q0Y3QxcWdTWW80LzM1cGpwRm5wU0hMWVdxQ0lObVVa?=
 =?utf-8?B?dk1jNU1DaGtiVGJSdmQzYWprZmp6bjRONlM2RG1TendQMHkxTWEwN3l3dmtv?=
 =?utf-8?B?b0NqOWxhT0pqQ2g0QkhrdTErWnViRFNRdEZtQ1k3cE9ReDFxbTlNUDlBK1Nt?=
 =?utf-8?B?ak9nbW1IZDFTL1ZYdjkyQzdrRDVPZ2FGMS9aZGRpQiszODN1OXZRWWZFVWtn?=
 =?utf-8?B?UjhoNGoyYVdDYnh3Y0wzYndnSHlFalk1Mi9XSjNLemZGenk2TDZpZ1RLMG5j?=
 =?utf-8?B?U05HcElyeU1ncHJRYUNyQWJZNitjajl6TENsaWxaMGw3dFY5YTlGZ0ppU0dw?=
 =?utf-8?B?WDR1WUc3UUdxNXM3bG1PNXA4RW5VN2R1NjhYWno4QnNNMEtndmREWjkrMER6?=
 =?utf-8?B?RGJpYVd4UlZOOGpVMHB3eXY2ODFsZW1XT1JmVUF4c21sOGdFZGJWNnlGMnJa?=
 =?utf-8?B?NVZoMFVORURhRkFadG1SYlRGZW9TYjM0cmZKOTVoTUNzMmNtc0s2RUlncVRx?=
 =?utf-8?B?RUsyV3NUN2pRY2NhWEtiZkoyU0c1eFpuV1JSQldDWGNJSXNRN2NjV0R6dzRF?=
 =?utf-8?B?NnFUZFNUUkZjclN0UlRLZG9LN1pwcGNxQXZKZG5IQjBSOHlQUzZTRG5Xd1Za?=
 =?utf-8?B?MkRpZERvbEZhLzhXL0M4bGV2bW5WQmJhalBuQ3R5WUd3U3ZleEQrNDZ4SjEr?=
 =?utf-8?B?Yjl2ekdYYndLVWk5cy9sbm9lTHB5V1laWkpBOW1NRy9kenUvVC96cXZTZjd1?=
 =?utf-8?B?R0VEWG8xVGRnVUhDUS8yV2hqbGFwa0hNQU5Oa3RqYjNvemhvOERIeFVUaFJy?=
 =?utf-8?B?VGpGdTBIU1lzNVAwYlBDdnJxakR4dTFoRXBkSXB1N0QzNHp1QWRhY2JGNUdS?=
 =?utf-8?B?NnAxcWRTTEhNV0phVXRFR1BiWGdxVGtHNmcyYmdOa2M1YS96eFMveXhjL3ZH?=
 =?utf-8?B?RjEwZnJoc3ozNVVacVYxUmRRdXZYdWsrb3VNZldNVDk2NTJRVEpTM0h5MG9w?=
 =?utf-8?B?ZjFrRkRjeW5XSmk3YzZ5S3Z1cW1wM25Fb1phZVVZdHdoRTV1VFRMTzNwR24x?=
 =?utf-8?B?NTl0UGZRcmRFaG5LTnM0NnBSSTNPMGhIVldHeGtvbXJ5YWhFYnZTdXdhWFo3?=
 =?utf-8?B?Y1d1ZWpxTk1ib1FtN2tuR0FxUnIwWXNKMjFxMnVBcVJDaHdRWlBUNm9rOHVs?=
 =?utf-8?B?dmRHNHJCUVVWVmYwTGlYbFBHemF0Y2JFS0JKbFEvK3BiRyt0Q3AwcU5hdy9W?=
 =?utf-8?B?alpNOUVGWlQxUndvSjMyTkFLL3RRN0FnVldZNTZRKzB1Rk81bUZ5N3lhc0R6?=
 =?utf-8?B?dVpRaWhOazZjb0RPUjFVVlRMSG9jallsNTM4bExiMUhXaFhZcEdQNGxuVitV?=
 =?utf-8?B?S3lFQzU5QldLb0Z6RGZKNU1YS3BuYkNVUWVKY2RudmdzbytBQlM5ODRGa1lL?=
 =?utf-8?B?c0ltWjhJUjdGNjZLeHRsSHJyUUE1UXljSHNkYmlRYlA2cEIrTzBsWmhWUkFZ?=
 =?utf-8?B?NEFsUzBNWlRhcU5lRk9HUVNsN1pUaFlsODh6djFoZ1VQbnhPYXdKelN4M09t?=
 =?utf-8?B?MWJXZHhIQjM2b2dDeEprS05ScUtQL3IxRUh2VzJKZmNwdDQxQzFKS09LN3NT?=
 =?utf-8?B?UlhMYTJlZmdtWEhrM2lJVmc3U1ZJb1BUREVXMnlTVW5oaTlHeVp3YWR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MStocHFDd1BWMlcydzdIckFRRXRkUDJ6VThDS2RVV1FvbFJhMkNJMmZKWW1y?=
 =?utf-8?B?blRUcFhqSCtiS3RVbWNDeDdWenUyOGhaamZOK2J2WWtlQStNbkt4V1Q5cEc2?=
 =?utf-8?B?dUtzNUdjVnBTSC9uNEtKNSt1OVovWE90VmpNUytpRE9RL1ljaHRuME1CSzR2?=
 =?utf-8?B?Tys4cURFZ3Mxc3Zpbmt6ZjlVaGVJMElhTXFzSnVHZytkbUgzdTVQQytZSG5M?=
 =?utf-8?B?MERiZGNBZndRY1pqb1hJcTdEOXd4SkdyVVphMHFKSWovakFIYjJjVDl0Vmc4?=
 =?utf-8?B?c1Zzc0pGcytzdlpvOW1KS1gzdGdyQzdHUGRIcjdvS0FoY2RQRjd3TjlKM2dl?=
 =?utf-8?B?TkltZ3dWZWlsR1ZkbWtkNlpaYmpaSFc2QzRLM29KQjU0RzJVdUVQeDdwWVZr?=
 =?utf-8?B?SW5wT05Sa0MzdUJaNko0aTNsRGJiZCsrRmlGNTJCWlpmTXJQcWRjb3BHRmtL?=
 =?utf-8?B?aGlhRlMzdVRYdlFYQytPNHE2RnBLZDNpbE5qL01BQzlkdzhtb0RrWVNtQ0pk?=
 =?utf-8?B?TEtsTElVM0wwWGhyTXk2ZWpMWDZ5c2FXWEFGazF4KzdQQldiZ2o3ZUVFakNS?=
 =?utf-8?B?bmZidEVXTkp1WjJHWTNhSVdseXB0clZkR0JheEtiTm1IaFI1VXFleVBja3JY?=
 =?utf-8?B?R1B4MEsyUjF3NVh0U29TWW0zWEw0b2l3cEI4czNPWGpLbWtHZ085RDV3Ykk3?=
 =?utf-8?B?QitDbjRCcHdtVGliL1ltRndiZXdIcEJ5ZU5yQVBNZGk2N1VYOW5OMkNUeFRP?=
 =?utf-8?B?bjVWTnNSRTBlU1JWa3dyakpRYkd4Y2xJcXJKNUh2MWhpMDcyS0lNSlN0aEJi?=
 =?utf-8?B?OUFHSGRhaklleUFBNGlONEhjK1N3c0xrc0IwWFFUelZ3bFFiLzRidlo3bVZX?=
 =?utf-8?B?K2JVdUxheFdNZFBZbmYzM1FRdFIycHB3UjVsbjJhTEdXcUJBby9CdmpPaFVt?=
 =?utf-8?B?U0VjNmlvS254RnhoMGpkaS9yamRibEYzN0IwTU83SHl0anBnd243TnZ1N25m?=
 =?utf-8?B?V1BGclpZLzdZUFpCbjN5QmFEUlNzeDhUc1RFUkVlMTI1UFN2MTd1OGJkbjEy?=
 =?utf-8?B?YVp5NzN3d3RTbzdqWnU2bzQxVkxwMUVZYnN0RmhRdFAxdW94OGlhK1ZqWXdn?=
 =?utf-8?B?MzByMHhNa2QvOTNGaUFEMWZBOFpUK3FGNjJmRitKbDdYMWxURVFJK2Y2VmY5?=
 =?utf-8?B?YjQwL3pvRWw0Uzh1UGRsMlVQNFMyVWE1alhSckc0MmpMWFFuSW5tNlRqWEUw?=
 =?utf-8?B?R3ppUWpKbXJhVERaMERlbWVGejd1bXpEbXRjM1Q3TWdXLytTWS9SenR4UUNB?=
 =?utf-8?B?Smw4UWVkblcxNG1lSVQrVkJralZiQnR2R0dBWEJDVWovUHhVY0hpTk5HNXIw?=
 =?utf-8?B?WHR2dFcxcDQxaFdaMk01dlNXV2pFYXBubnFGTUoyL1lJZHpUa3l3cVNub25D?=
 =?utf-8?B?R243SHY4emhDdnUvTFpPY2lzZ05EODhucnRpZzNkMHYvdVJtNlZVbm4yeHg2?=
 =?utf-8?B?S1VRcEgyaklkcW45K3pCOW96clVpSk9zREVnY3RrSkJoUW5YajlEQjNldmxy?=
 =?utf-8?B?Vm5GU1lFbSt1cUVTQSs1bkh5WFAzanE0Z2l2ajl4Qkt2SzhaUnFQQ0dxMjRm?=
 =?utf-8?B?RlV5dGlwaTB3WWRaZUhVQkQyampET2dkekhhZ2ZLaFJrcVh6OEpYdHhkNldw?=
 =?utf-8?B?M0l6aHlhTmFIR29KWDJWZ1VuZG9CQVlveGNZQVNObWZVTzZ2S2F0QlJFMDBJ?=
 =?utf-8?B?VExrRHJtQktpUk5SQ2U5cWx4dWlwWWdYQzBkRDBGeTNIaTRwcXl3clJheFA0?=
 =?utf-8?B?UDRGM2VpaVI3WHI1SUdrQlNnNGhidVp1NnliRzNOS29sbU9ZMS95eEZNSjdx?=
 =?utf-8?B?a3BWK3RGUVBYWU9mczRYWUF1aUJhVWEwWUI4UUsxUEhMSlVORVNRVGpFSTd6?=
 =?utf-8?B?d3ZaUVczOFZvdEthR1dmNlJBNXR5cFdNcXBYckY1Z1dyd2NVUHBhS2MvVklG?=
 =?utf-8?B?Q1luaWM4THNiem5OdVRzUEVOK0dhdlRGRkdxREpQS1NjekJKZ09aS2ZsR29J?=
 =?utf-8?B?SHVLWGFOc0hJMGZwU25pM0JvREdHOHc0ejhJZUdTS3p6dFVYUm9uYzh6L0dk?=
 =?utf-8?Q?YByoCMmgv6xXSAWcNhH6naB3d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eb30e2-3306-47dc-6df1-08dc7429cc86
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:23:25.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqRZ5JQW/plXbQND+CDr72kZIioafM/gcCcXsen+o9/vI1U6hDPxNIo05602/coq2nSejFeNTMueqj9wOAVbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

Hello Chenyu,

On 5/14/2024 2:48 PM, Chen Yu wrote:
>>> [..snip..]
>>>  /*
>>>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>>>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>>> @@ -7384,10 +7402,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>  	if (sched_feat(SIS_UTIL)) {
>>>  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
>>>  		if (sd_share) {
>>> -			/* because !--nr is the condition to stop scan */> -			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
>>> +			nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan));
>>>  			/* overloaded LLC is unlikely to have idle cpu/core */
>>> -			if (nr == 1)
>>> +			if (nr <= 0)
>>
>> I was wondering if this would preserve the current behavior with
>> SIS_FAST toggled off? Since the implementation below still does a
>> "--nr <= 0" , wouldn't it effectively visit one CPU less overall now?
>>
>> Have you tried something similar to the below hunk?
>>
>> 	/* because !--nr is the condition to stop scan */
>> 	nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan)) + 1;
>> 	if (nr == 1)
>> 		return -1;
>>
> 
> Yeah, right, to keep the scan depth consistent, the "+1" should be kept.
>  
>> I agree with Mike that looking at slice to limit scan-depth seems odd.
>> My experience with netperf is that the workload cares more about the
>> server-client being co-located on the closest cache domain and by
>> limiting scan-depth using slice, this is indirectly achieved since all
>> the wakeups carry the WF_SYNc flag.
>>
> 
> Exactly. This is the original motivation.
>  
>> P.S. have you tried using the slice in __select_idle_cpu()? Similar to
>> sched_idle_cpu() check, perhaps an additional sched_preempt_short_cpu()
>> which compares rq->curr->se.slice with the waking task's slice and
>> returs that cpu if SIS_SHORT can help run the workload quicker?
> 
> This is a good idea, it seems to be benefit PREEMPT_SHORT. If the customized
> task slice is introduced, we can leverage this hint for latency related
> optimization. Task wakeup is one thing, I can also think of other aspects,
> like idle load balance, etc. I'm not sure what is the proper usage of the
> task slice though, this is why I sent this RFC.
> 
>> Note:
>> This will not work if the SIS scan itself is the largest overhead in the
>> wakeup cycle and not the task placement itself. Previously during
>> SIS_UTIL testing, to measure the overheads of scan vs placement, we
>> would do a full scan but return the result that SIS_UTIL would have
>> returned to determine the overhead of the search itself.
>>
> 
> Regarding the task placement, do you mean the time between a task is enqueued
> and picked up? Do you have any recommendation which workload can expose the
> scan overhead most?

Sorry for not being clear here. From what I've observed in the past,
there are two dimensions to slect_idle_sibling():

i)  Placement: Final CPU select_idle_sibling() returns
ii) Search: Do we find an idle core/CPU in select_idle_sibling()

In case of netperf, I've observed that i) is more important than ii)
wherin a placement of client on same core/thread as that of the server
results in better performance vs finding an idle CPU on a remote LLC.
For hackbench/tbench, when runqueues are under high utilization (~75%),
reduction in search time ii) seems to be more beneficial.

There was also a wakeup from IPI / without IPI angle that I never quite
got to the bottom of that Mathieu has highlighted last year. I'll go
get some more data on that front and give your patch a try. Expect
results in a couple of days. 

Thank you.

> 
> thanks,
> Chenyu
>  
>>>  				return -1;
>>>  		}
>>>  	}
>>> [..snip..]
--
Thanks and Regards,
Prateek

