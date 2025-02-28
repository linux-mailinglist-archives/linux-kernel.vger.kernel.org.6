Return-Path: <linux-kernel+bounces-539106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD1A4A0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB303BC42A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746527426D;
	Fri, 28 Feb 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="coafpVIb"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022111.outbound.protection.outlook.com [40.107.193.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EC2702BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765188; cv=fail; b=OQyYiFTxDxQWKrM2JX1VsV1VlNVM/3hF2J1biCjmfcPa9fi7FswVgMMUY79PFQVVw+rVEYoBrVrtVIgM5Qx0DErrTKxkI+gTiy8bQRMnuusQ5Gi4+K1ysMfZOedhXal5HTdYOVh6JeozSVZDLgv31yxPNUPYqN9CdoEkfZjMBx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765188; c=relaxed/simple;
	bh=EndrSJSnBqsceLgF5wAHiQ3FTIqj1BFPHrsS7Bg2elk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XugNKI2Um9paIG+IA5qk1tqlT9WeleNuNiq8B3P94naP4RJFqc3Kmb0B6zfJ6fGWu3HPcKizF2qlnaO+T0yQEpsU0LsuFRjr3MWmJdsTEAtPpLQzSxpm0u2OiNUwWpiP27kDf5BcOLwCMCatdOz3BZhP5HlF0/+/stUk4NhVBog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=coafpVIb; arc=fail smtp.client-ip=40.107.193.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJQ49nI9fELJkSZVIox598eaz0hp9fGbAWHs6h6gS0kmCCf1OutMLvQYGuhM1BFPdaSk+SH3TVlO4VzIbuRl/elGSylCh1HTgrHAWKwVldOXCRsig3GT6oRgI54NO4JqzMr6CgFJWS+qYE/HMCuhmaltD3D+mTGpnwRK5ApeLVL5JP/ztqJHmTxVQvLzNZ9H52itlEubouQISlkds0VjxgsHHrJqOYJGGIWubi4siQECtddpoNRyb7LjAxhaEJ2XUBTt61DfJAUCVr3Cgqvt79OrrFTnKyUdr7V+FMiQ0Gn6b2a5UEBCojm9Uahw59yvMjmCKcL4+wZ/7JRUSQlaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NczTfAxgsutkxeHgSfuzyJDOaYtqWnhHqGYWpvxQhc=;
 b=BQzVuRmHPenO7E2srVOznCdbOVLFssBDiaZY+P8ebocefNNCm22gjfz8Q0bw++RMyjzH4K/zZoU8iI7XB/w3JQgdUYgt5bbfr8g0eXRTswGoPB6M9MCNhHLzhFF2mIQ8Sb/RkvhBo0n1gric8Iv3aF5//g3pp01GpzpC2AYhLIUVfddqblQmBu8xPFdueAHhsuh3dUIaItKmueyLKHqmSCDSusNCAePY/08nU7W8GLDgG7ZAQq3810VuK/GK1GW6D1Cjgkq88QGXfaotpdCWE/WIrEC+bXavQxnFi7XsXlpLA3RSucDOhnWSKDSPhyhyJFdwpCbA5aQkwDYge0s0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NczTfAxgsutkxeHgSfuzyJDOaYtqWnhHqGYWpvxQhc=;
 b=coafpVIbnRvXpWLjPW4E8Mlr5CyrYCdl79vg7utpPDYV7tc9E3Cb4Bawasm+EWGf4pafBKkfc3EbiSmyP1/m9iuPfUJT3N+Mh64UuywFTHkJmnAOudkWkYQJ5KJKKjMOmjhz5HXyUC/CGz441w8hyMQjEZ8/dzVDuz23v2joqm/AWQxo1y15rNz0dLRmvI1NsiRPS+w/bDFp4wb6mvEekiGZ0HnxD4b7h9WYGzkJ3R0iaN5G2KXP6PigiscOHl4tE3akP6uJbka9mAZqP/XJ8DrV3OLZl9q2Pc5FahykMw9aQYC5+Ko5zqz2W3z06W+r8HKMJiiYtNk6vQVwLldTgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Fri, 28 Feb
 2025 17:53:03 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:53:03 +0000
Message-ID: <60f148db-7586-4154-a909-d433bad39794@efficios.com>
Date: Fri, 28 Feb 2025 12:53:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Z8HlL4FopVjeveaJ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: a97f29cb-ddaf-42e6-dae3-08dd5820bf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bko5eVlvYURLV2paYnA2MzFmZVVlM2hiMU5OeEhhMUZjQnJUOW9yUHJ3VEtC?=
 =?utf-8?B?NnoyNkRwWjY5eWxZSGNOU0RnT29nYUpDQlhtTmRRRnlGWkNyVmQyNFlhUTMw?=
 =?utf-8?B?aEtNclJLSmRDV2ZQTitPTnRTZ2FYbHRVaURqazdyc3kzT2g2Y0xiUkI4ZTNn?=
 =?utf-8?B?MHdFZHNKbmFNS1U2dlVIZ28zYUxTWFJDSi9nVUUxWUJqRXlBa3hiV2orWjVo?=
 =?utf-8?B?UmdNbWp1bkFyYlkrZTRabDNwZHhvbTVEZUw2MUo0SThOWERCNXVYdDF1V081?=
 =?utf-8?B?dFRkYUt4aTArMXlHRkdLNkpNNTN3VGFSc21kOE52U0xSUFF5TlpJUGdZdmcr?=
 =?utf-8?B?U0Q1Qzd6N1lmcnNTSVRxVzFVeDJlOWw5WW9na1lYYjg1bDNpdnI5bHFpZzdx?=
 =?utf-8?B?NE94UkFnQXZKTVdqWHpjSG1uTWVjeVl2MDMxUDZDUHhRb1VkaTIxOXBCZ21a?=
 =?utf-8?B?K1ZCc3l3cENCaWJ1dDJnYW40R2dJTU1Bb1U2dWVQMTgxMVFXamNSL1RibTJm?=
 =?utf-8?B?R01QZjFoVmtaMWdoWEZGcDlVbVFrT1VoRzcvWU50cmY5TmZsMHNldmRXMHEv?=
 =?utf-8?B?YTk3ekpmVzFUQUVZMDZXbjcwVkx3c2xmSUtaVWphdTl2bDhrVWFFS1lkWXVz?=
 =?utf-8?B?MFFQSCtxdU15cTBMeC9xL0VZSTBRVy9Va0g4b2VQUS9tNjBoZGhLakoveVZo?=
 =?utf-8?B?SW1keHZMMncrRlZPdHJrUU01TkV4VURwcXB2b0pMV3l6eEM0L3pCRlM5SFpu?=
 =?utf-8?B?Tm5Za1lOSFc0Z0RmS0ZJRW5qbW9EKzRvMnhqVzl6czZCYU9pdU9JRi8xTllI?=
 =?utf-8?B?bkZ3OU1EWFhrOStib3RWWTJOakU1YlZSVTkycTZNNDJSQVVidm5id1NISENu?=
 =?utf-8?B?UFRjOGFYTU94QWYwUHFEcC9mU2tnNUpqQndMVngrSy9wZkI5ZFVpWVZaTFhL?=
 =?utf-8?B?OVUrSWdWSmpnazVBY3k1c1pvT1NOdGJqRnZ0eUxHa2NhWERIOEFFTXoyMFB4?=
 =?utf-8?B?Q04vNnZFR0QxTUFYQ1BWR2YvWFBxZkNwcFZXQXZWVW9mSm5oSkw1aHljZWpo?=
 =?utf-8?B?WExQWjNHcC9OY1pCNDNSbEdRQ0N3NzF5Q21nZ1lXeWJ2L29zRENaYndyWVEx?=
 =?utf-8?B?cjd6TUE5VURWMzZndzlOWVJhVVJIOFNHQ2lYRlZmVmh6dHJoZkpCR2ZXSXN5?=
 =?utf-8?B?bzJsamVrdjhqam05WWppek9FMW83V1Jta1VvZE8rRGh4OTlvMjdIdDF0VVhz?=
 =?utf-8?B?QTV6MkdCQlZRNmtqWmlXMy8weURvRFU5V0huRHdsQ3FxbnlCS3F5MndyVWpq?=
 =?utf-8?B?MExOR0dXQVo0RzZwQlY3bDRWV05nYWRJS3g1K3dOcGhkYVNHcnlOd1ljTWF1?=
 =?utf-8?B?UFFHeFcrU21jT1I1MDl1amhwVTFaZ1IxZXdGd3Y5TUVHM0pJWmFoYWJUY0NE?=
 =?utf-8?B?WXZZZ1dCTjFqTHhiMVVUbElJeU1BV0EvczNsT1lObkZxTzRLOCtGeVdlY0xr?=
 =?utf-8?B?Yk4yblRKeittTUU2UDZ2TnBndDlVSUxydXFCUHllS3ZUZGw2RWhrNk1QNTdv?=
 =?utf-8?B?Szc4MWlsRUVobkdqMm1zWC9yNnlhb3ZJWEZPdllOR0IxMERYc2VjdUN6ZE16?=
 =?utf-8?B?bWJzdS96YVN0VFp1T3p1UmN4c2pLaHI0Z3RUYWN5b3VMSmdEQkFnRk9ZS0hY?=
 =?utf-8?B?SDcwRExzK3VyZ1hGb093NS85cmQzT0ZFVERSSmtmUnVzUXg5czZ1MEkzNy8y?=
 =?utf-8?Q?zDjd3rtSZQDoD6ro7WC9ZlNLjODx1YFy/RDgIzU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1hjQWp3QnpUTFE4YlBNNUV1MS83NGFWOHJJSDdJdUJvU0RSZmkxVGo2eGZs?=
 =?utf-8?B?Y2VUUVlKSDd0aWg3cHg5S3E4VEhIQlNyZ1JJQkFBTHlPNGEwOHR6YnZ2ZDFO?=
 =?utf-8?B?WkZyS3dOSzEybzdDNjhtUWNvRmd1UTY4d2lXWHdXZzlSZndDVDNRSE9vVlVl?=
 =?utf-8?B?ZmtCZW9jMndqUGwrSXgwRXlhSVc4Z3grZkpQOTdmUWlSaTlSeTBxMU9xVEFx?=
 =?utf-8?B?Wkpwa21Fc2V3QmZaUnpRK3lDZCtJZlUyeHRlN2lBQk9RdFcvaVc0ZDZ5MU1C?=
 =?utf-8?B?RzJUbUM1dVR4Nm54Y3MrTWRXZWRuK2tjWFNXQzJpSUJDcENtUkpjcEtTeWlz?=
 =?utf-8?B?SU9GS3J2d0U1UG5LTm9wS0tJSkNrd0t5R2I1Uko4WTZrNkNvcnVyWnlUc3B6?=
 =?utf-8?B?WXd2eDlyeGlGU0x4N3hPMUtHMVpySWVJNWdtajYrbklLUGhHTlE1QjRwZEhi?=
 =?utf-8?B?WjJ0RFJHdm5mNHhJYjlYejMxSmV2dkpralVrRkw3SVc3QU95dWF0UzgxS2R0?=
 =?utf-8?B?bFRxeUI3dUNIYTBhazhub2JtS1J5cTl0bTJpRWt2aDRvM09MT0Jic3Nzbkxh?=
 =?utf-8?B?VHVJMHp5QWV3OW9FclJBT2ZRUzg3YWh0QzBuTWM0R3lwczRxWC9zaGZVeXVv?=
 =?utf-8?B?WU9yOTMrbTNJYWlHdzBhQTdKNlc3eXljcWYwcHJNUnVsZGpsZWtheW9URnUv?=
 =?utf-8?B?VTRqQkdwZmZJdmc1MEEwWC9iN0Zzb05zNnVlekhIbEIxdGlrR0NJN1l5U1pi?=
 =?utf-8?B?MUJjVk9uN3Vhb0tiNXJzZDJwblEvNjYvVXBzd2hYdW9pOVhLUU1nUTFuTVla?=
 =?utf-8?B?M25hYTY4dHpENzNpdWcydll3cElYM0tRaDV2bE5OZ1hZbzJhbG8vR3gvTDFR?=
 =?utf-8?B?NUljLzRMeHJ2aU5zUG5pK1IyUERWazBnbzJUVFRFa1krTUFpWG5lNnNnOHRs?=
 =?utf-8?B?Z1dIRThoR25rSDhqZitVdEpiY1BvVXlxd1pUTXF6c0hsQmNFa1hUWWhVQkJj?=
 =?utf-8?B?OUhPdDFGcGYxQXo4b1lRbFVFVWY2K2pWOVdZVGo5Mk9kVDNGaFY4Ylh0bjJP?=
 =?utf-8?B?WHg4MktMcklHL1lVRGl4WTRlNDZKNzZTRTA2SWNQWnlubnNNUlZlM1BGRC9h?=
 =?utf-8?B?RVYxRk9kWERabGh0RVQ5UUptUGMxSXV6ekxIazBYOEVGQnF3MFZuNFRaQW8v?=
 =?utf-8?B?WHlpWElDQ055aUpFRlZOVmxVWVNvYTN4RzBQZFh4V1BCdnZRTlp0a3g5MTNZ?=
 =?utf-8?B?cFNMNEV5bUZxV2NUMjNoeHkza2VMK0xSN0ZvYUtrcWZkNHQzOHo0c21SSlh1?=
 =?utf-8?B?WXVUS1gxYWJaTmpxMkN1RUNNeGlIbVVBc2c1b0Q4bXRyakYvVnFxMGpXSnF0?=
 =?utf-8?B?dVFmMklJUlh6ZlNaTnAreC9sdUl1QmdreDVTR1pjWEhIblRCcElhMTJSMDRX?=
 =?utf-8?B?VnlRR2R3UCtKS3MwNDl0MGsxc2tLcFMvQkQ2UGZFMFY3OEYyNlJaZ0Jzd3Z1?=
 =?utf-8?B?N0JDdVVmK245M0F1TFBVSGs4a2w2N1lQSHYxUTFHR0xubHh4L3FMeml1dlhl?=
 =?utf-8?B?M3NYMmVXRHNTZzNKcXlud1BRVzhkR3F0ZmdHcFdETFlxRERta2VWQ3NWM2hu?=
 =?utf-8?B?cjRQcTBNYWdBa2pXTVBrd3AvSUIybHZXdE9DWVdnMzMvNi8xcVpQQXlTb0pl?=
 =?utf-8?B?Mm9NdGYrK003bmZtNElKRGp0aXk2aTEvMmdleWp6OWhkMm1ONW4ydm41dS9X?=
 =?utf-8?B?WDJCQmhuK0hYdWlTbndVeHJoYUM3aDh5M2pHVG1MMVNpMkc0L0xJZlhRSGI1?=
 =?utf-8?B?UFY0QWMxTG12YWhJQkFUTEwxbysvTEVDZXNKaFdjSzZmUWx0MVh3cHlXa1VZ?=
 =?utf-8?B?LzRNdnlTemI5TTV2elFiOXVsMkxEK0pSbC82aGVlVGFPR2VKdGZZNW9jNFl1?=
 =?utf-8?B?WWluclVCL25UYmx1cndIVkZFY3hyNXNJOVlRazBYb2Y2ZU5CNjlhTG9YQ3pN?=
 =?utf-8?B?QXB2YmYxT3lDR2JFTVVCWlMrenV1dDlwL29OOWhTcTdFMjF5QVlwdWVEQTY3?=
 =?utf-8?B?dHBIaTByN0pkNGQ5ZHJDMllCcm90WVN0b20xeEthQ2J3TjlGNVFaS2wxamJz?=
 =?utf-8?B?WGZPa216QjZHalEvWE1CME44ZWNoZlNYTTRROWpJamM2YTk2RUN1WGx2ekVZ?=
 =?utf-8?B?WHhFTmh6MDlnS2l1dXh5THo0citGM3VUSzZiQVN6QTBPZmFqWFFab3FuTTR5?=
 =?utf-8?Q?b4a1OX8jTtGoO4zRcQRDPkZc84BfBJgbtq9Z5FCrMI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97f29cb-ddaf-42e6-dae3-08dd5820bf76
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:53:03.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm2eHmL66/T5btuQY+HDdtOSoHzJFMdgcN9G9j9pxSStPyQSwKsGFFiFb2QgrkZrvAQ9XPHg3RXfG7a59wcxSLV34ujG+6ORbM1aN+nJSus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9011

On 2025-02-28 11:32, Peter Xu wrote:
> On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
>> For the VM use-case, I wonder if we could just add a userfaultfd
>> "COW" event that would notify userspace when a COW happens ?
> 
> I don't know what's the best for KSM and how well this will work, but we
> have such event for years..  See UFFDIO_REGISTER_MODE_WP:
> 
> https://man7.org/linux/man-pages/man2/userfaultfd.2.html

userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
resulting from a mmap mapping, but returns EINVAL if I pass a
page-aligned address which sits within a private file mapping
(e.g. executable data).

Also, I notice that do_wp_page() only calls handle_userfault
VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
set.

AFAIU, as it stands now userfaultfd would not help tracking COW faults
caused by stores to private file mappings. Am I missing something ?

Thanks,

Mathieu

> 
>>
>> This would allow userspace to replace ksmd by tracking the age of
>> those anonymous pages, and issue madvise MADV_MERGE on them to
>> write-protect+merge them when it is deemed useful.
>>
>> With both a new userfaultfd COW event and madvise MADV_MERGE,
>> is there anything else that is fundamentally missing to move
>> all the scanning complexity of KSM to userspace for the VM
>> deduplication use-case ?
> 
> Thanks,
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

