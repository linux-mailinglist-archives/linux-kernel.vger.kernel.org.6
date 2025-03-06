Return-Path: <linux-kernel+bounces-549934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CDA558C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44EB3A4132
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE67208989;
	Thu,  6 Mar 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7EqYumA"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF57272931
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296597; cv=fail; b=JXziGctuEdqfL6WTccpbiARTUQztXMZdk/oadbJI8RtO3Aonmps5pPlW+/fGCGaB5R5yJm0XXldlTZae019knmZ+/ju5p11Kw5cWbXvyifwswEKuP6rs7QTGHvhBcQsA4FUylcIfL7WSwGvcaB6Sx545t1nY2eRGuAhIyM5hJhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296597; c=relaxed/simple;
	bh=nd/TMJM0RYSiFT5zrSLIEbCoOmE9HJA7JhMExAmThCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S02EYI1r4Oc72PS0GVZVgECWtIxnk/Mq66QjLGmj9VYHVg3Ia3sGF98sDU8l5mCUQN8ditWt5WWP+uOosiW0772cqRpYayJ3KrWopzxY6R85ET0UyKCDCl+1nLoA3Rg+5xaYeynQX1k/DcNmt/UMK6+VJJkNCEeAkesQqKQdDI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7EqYumA; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmjAB0tmEVd/cw7Qt6S+aJc5WveDrVisijwCovOzQHg42ouJOAzqdDnCC+ErXKGXrGBMQkETlVJB3LAoiomrLD0CsIx7GIl+RRFnfgM38rNDmTqtJY7Rr/4zm5OJ3ViylFzVxeqrLQBaO2MI5MmgjMFdx1d4OmM17574+05BPZMfSaHdW5yAPeIvCJDE52Ub6ieNvYW9CwJjlFhsSBXCuaDC1SFt5iycDgAA496qnuEV6WNH7TMkocanLR2IZ3Vv7uIPpnxM76+/ePR4isY4jCehlWXIlHgz6D6OfgE7cMkZdAuJcuV2Wp50PuRYnxkJI1XyRkYkZye9FLwY3/KRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd/TMJM0RYSiFT5zrSLIEbCoOmE9HJA7JhMExAmThCI=;
 b=YfArkxAItNGK3rRQieg72MqrNxOaujnFR3MhHPJa1aDljRh5xmtKsEpdbA/wATv24k1jcDqrkEIlcrly1ohhN2Fj426/5oV9GNr/QoftwL1B6SORfbgXymSzEQNGUhXIhuCyI6xM61r/qdCKaaq3m6nuvTWHIlOa6gHey5hvf/fuFOScc/4Aq4D+c1KtjzPZ0HZgvy+Z+Apf3/o1mK7RBejZj/e7Js3aL6GqyoJxKoc1XHJdeZmnKDFGKqIERTpZ1jND1vWDg4v8PttMfHDIFZXYdfw6S2YFu7iRdSuSE4cRxQEaNoIm3c/qQpM2ZslA4Pf2v2n5QqxKKBfJf/QO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd/TMJM0RYSiFT5zrSLIEbCoOmE9HJA7JhMExAmThCI=;
 b=E7EqYumADsWc2ydJbzzUB1bGIcLTRLIdefSgILv3OxBZg8YHRPRN71ytyvEd7w+E/Pj05Nyt26fUoUL4dcgGh0YNE85FTeIpA5mcGdoVZTOqYvLKO4W9QwqhBiBgNA6DnJhSlR5ZffoyyoqxpzG2qU8CwEmql6qGqKJrxbZPQAcuGhCKlfyNJtTPf7ofpPS0Yr7s/cgblPwjrOPcpYY8YgALD6rpiTBjSBnnnDwV+Ym8tEu2xVEM++DWgj4JW5RlQinnGNckWg0etEVg8Gq5PRZTaUkTt4bOWijI2Gi5Xjt8Q7IzJPLDOM48P11ZUr4gmgeiihpK1LulnOCyCIA9Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:29:51 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:29:51 +0000
Message-ID: <0fdafd91-9fef-43db-96c2-8b193170718d@nvidia.com>
Date: Thu, 6 Mar 2025 13:29:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/49] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-18-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-18-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b033388-6acd-48ea-3041-08dd5cf60742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm1CSWw4TklWNWIzVXRscTYrL0hjc3RacGFnMlhrRUtJUFNWOXNSQmtrWXZp?=
 =?utf-8?B?Q3BLY0JvOTlnRnV6WE5venFiNEVQZmxGVXFlYngzU1VZbWNPM3owSlBpbk5n?=
 =?utf-8?B?YzdKSWZEcjFNcjFnV1lYamMwbVA1QUtpK2t4Nk1qZ0FiaS9ENEhndFdZUjJl?=
 =?utf-8?B?eFpZbHZMdWNaM1FSMndSMTVONlFrYVo1L2FiVlVZS0pha3RqSXlTK3R5cXYv?=
 =?utf-8?B?TWZOZFBJWEVzaHNyK3QrQ0M2YUx4R2VuZkkvM2pHbGhocFNUUW4rMnpXTWdl?=
 =?utf-8?B?dHBiQzZFbk5reUFWSTRaRzZYaWlKRFF4MzgycCt2TzFndi8xNDM4cTN0UWVz?=
 =?utf-8?B?dzE0SmVNNTNTVjVkRDhRUGxTRU1valBtSmFhV2NVS25FQXpOM1lNZlFkaDYz?=
 =?utf-8?B?N3c1cGZYbHBSMVd6akZBd09xRTFlRnhrL0pHV2JSZVhFcnZGR1BuSS9uWXFt?=
 =?utf-8?B?aUQwaXhJNTdhdlZseHJEbDZSckp3a3E4Z3Jpd1VUVWcwZ2xLMitlbWVKYUd1?=
 =?utf-8?B?UjJPKzJUS2JxUnJBaWd5TWJWc0k3TjJPcVlyTWlpM1Fla1A4bjZsWU9kRndW?=
 =?utf-8?B?UWphZ2tIQnc3RWlGMU9hRFJUUk5VMkxLbmlOcVFTcVVTMllPQmt1U1htTGdO?=
 =?utf-8?B?OEw5eDFJVkx4U1EzalRtZTl6UUVGTUFFditpc2tkeGl1WEVla0sxb0tHL29p?=
 =?utf-8?B?VzBPOGJzdUNDMFcvQ1ZnWW1GMVFjZ0NrNjExSWZEeVNaeWp1Tjk3U01vT0d4?=
 =?utf-8?B?NTMxUFpYZXJJUDU0S3puY1RSREIzK1kveHNFenF6OFdkYndLUGhUSjdKTmRo?=
 =?utf-8?B?Yi8yN2x4eDQzdzJvR1FDTFZnV2YzeGZzaUtBRVM5K1hMcXN5bWZieERjRXJP?=
 =?utf-8?B?ZlZyTElQRzhWbHY5OEJTUmhGY2RHUjFoSlFHeGY5SzhCMUFMWnFZYW5SQmpr?=
 =?utf-8?B?R3VmR1BUeVJTSHJLd0ordm80UGRMUVFZTnZVYmtZekk0YUNKQ2NVSDVCanZF?=
 =?utf-8?B?a1FNRFNZaENHdUhRaGlEbWdldU13bTl4azJPdmQ0SmNtMCs2b1FoNHJIL2sy?=
 =?utf-8?B?cTJIekdWcCtoZzN2eFZwQ0oyYVdSTG1EUUZ3d0piRGc0ejJSMFZ1SkRxYVVq?=
 =?utf-8?B?OHRKZ3A3a0hWN0o5VHNvN0x2eTl1SWs4Vkprczl1aXgrQmlqb1VkRVM1OC9o?=
 =?utf-8?B?NEU2NWRCSHJWNjRtdVNwMkZzMmwyTDN1Ky9JMnZpYVNVMmY0VUExUlVGbDd3?=
 =?utf-8?B?S201T0ZRN25ZRzVKOTdWR24zbkVEdzVGMHhOTXVkaXQ2SFJ3K2pjUEpQYnY5?=
 =?utf-8?B?dkh1NjBvbmllT0xobUNxczYzbCtnZlBqMzEzRENTT0JXN1gwRXhlaDZwYnhM?=
 =?utf-8?B?cGJXcHdMZFZkYnVlZWhEODl4WGFPYTk0N0ZUSFNwSVQ2MUVoWDd2UDY3ZitM?=
 =?utf-8?B?L0hzTDlVOFhDcVZ0djhHTDZwUGVGcHljY1JOWDhXNFZuekx0b2N4Zjlidktj?=
 =?utf-8?B?dkpZMmFaZDlqRS9vQWJUeVBodEI1RWRzbXlDK0EzdmtXWEFTc2dwc204bTVu?=
 =?utf-8?B?aElHOWw0Z3d3VSs2aStweU43WU1oejgrcmEyb3lueUFYcHVIajhCcHVidExL?=
 =?utf-8?B?ay95R3JvV1dSRUFETmFaOFozTllXV2c3ZmJrV3pQR3pFYk9ZWUd0L1VCWG1a?=
 =?utf-8?B?VDlnc3BTRE9TWnJZaXdhS0NBWmwyN1c5MkFzM3NVUGltY2pMRlhyMUxhbVlE?=
 =?utf-8?B?SHpKRGE2WWdmcVRyRmFLSkRVS2xuOTNVQ1JmNTE2enpVUFNkcWU2a25zUHUr?=
 =?utf-8?B?NTV6WlY2RUQvUkM1M202Rjg3b3BCRVJKN1pnR2ZCckJSaXJ4ekJqaGJZWXdl?=
 =?utf-8?Q?N1E0BihWxzJ/W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2tsOVJqYjFHazA5bldQVVI5SG1SMDJ0blVCWGFxNy9KUlQ1ZEk5ZGdkL05v?=
 =?utf-8?B?LzhReHJWZ1FhYjltbVJ4eEp3RlJNME5uaHYxL3MyRm1tUFU0aTZuMnNVL2tm?=
 =?utf-8?B?WVVBSVg2VWZNbWdmY0txZGRjaVVzZktvUWJRZ2VyQ3Fsa3lPd2lNdW51V3Rs?=
 =?utf-8?B?NHJWVDNaQzVFN1VaZ2dETkp3Q0lzZGhoT0V3RitadG5VZlhRelZnVGpsOFJP?=
 =?utf-8?B?NkluaEh4YVlUTzFtOCtoUmRGUVd4Zkl3Uk8wUHZzRGYyRGFrNFA5WTNqSExX?=
 =?utf-8?B?Z2FmTFdDRXMxdzNkY05FY1FGYjVONUttaEVCQkpoSFc5NXlvcXI0Q1VhK3RH?=
 =?utf-8?B?TC9iZExSTkFUNzBGSDJaSE1ad2RaaWhwNEpHQUxUVzNCcTRSYWtiemRMUjgw?=
 =?utf-8?B?T2poWFFlVWZKTGVUMzJkbzEydlY0TWJ2YnQ1ZnMrTUhvZVZCUklkRHhkYkhj?=
 =?utf-8?B?L0hLblJpTHBBRjRNSTI3N0txSHhjZk83Y0QxWVV4dUk4Ujgyc2Fna1FadDds?=
 =?utf-8?B?N2lXYk1rV2cyYWxKNnRpbm5YYUxRNU9SZ1I2MFVxYy9sQkloUWE0RFA0QnlW?=
 =?utf-8?B?UVU3THN2UGNwUzJ4TlJ1OTRJSkFONldqSDYxUGg5aFF2aGQ2dlQyS0wxa3NV?=
 =?utf-8?B?VGVTRlNRVVU5ZU9zc2I4ZExCOUpTejJHMW9Lb2ovNVNRUXp2YUVjY1dwWW54?=
 =?utf-8?B?eG1vc2NPYURNUTIwMm1Tc0Mxb0ZUT29zNENVUndBaytPQ1lvVXZLZDVaTjE0?=
 =?utf-8?B?N3BOTXpYNXZlT1lBUSs1MlVheXlhd3prVE9tUTVWcG5YbzAyZWgybWxXTk9i?=
 =?utf-8?B?SmtubnFRTXhmQlY0WUR6LytNOUIrNC9XQ0g0ZWJqbFl5dUhOcmt5Q2JQdGtm?=
 =?utf-8?B?a1hSRXh0WlQ2SGdLNnBOekRVUndkN3M0M1htVGRFUyszZElBd1c1dzNqRXN2?=
 =?utf-8?B?Zk94TGdZTHAzT1BXSnZRUHVub0JHYU5jQlBFUDlhbTZBaHBQV1krd0xrOTZN?=
 =?utf-8?B?L3VNT1kxak9LK0RtSUlBZ2QrZWUzaTlHTTZ5L1g5VnJZaXR0UjN6WnhHTVRK?=
 =?utf-8?B?RU9ETG56dFI5QktNOXZEditOWGFSZlF3emUvZXh5NmkrZ0RJR2pBeS9RN2hT?=
 =?utf-8?B?cG9xV0pDSTJrS2xSWXNyQVpPakkwKzM3WmZ6SDB4aG1reEJFUWhFUGdkcHIz?=
 =?utf-8?B?eGJTLzZ0S1l2OG5QaFVSWHB6WmNWb2VEVW9HNUQxVFh3d1o3b0JkdVJ3cWVL?=
 =?utf-8?B?ZEJxQU5EWUtRTlBOa3dKMmwxZmFoQkRFQXQySDVwUG10MkFKYXhPMU1SQVRH?=
 =?utf-8?B?RXI2bis3ZTJXN0dJUFBXb2xGcDhyZ0FYNXBVcXo1citqQk9XdHNIdXdSdjVE?=
 =?utf-8?B?V1BaT1F5c1FUVDFlR3pwMTFzVk8rOHcwcWo5d0xQajJwaTdBaGhXWGJsWjA0?=
 =?utf-8?B?MHBaZWxDNm5RNzI3dHh6VTBKY0k0M1pldWxuVDFWdkl6OE4xbmY4WHNVQ1Mv?=
 =?utf-8?B?VEpxQVAxYzRyaGpvQXlFSlFqZ0MwQnZ4Q3AzSlJxZlU1Rnd1d0M5NEJwTU9l?=
 =?utf-8?B?bXNnZzhzWVhOQXdzbmNRMndLS29iaVJhdzRscDlFSnR6cnNaVkh5TmsvR0Ns?=
 =?utf-8?B?QnhQYzAzbktmZi9FVXA3WTR1UG13alQxSVVmUlpWb3YyMnJCWWlBaE5rVEtM?=
 =?utf-8?B?YjVpS3dqbXJnQVRhNVd6bHkvcFMyalV1VXdya2VPbFdhUUlXeDVYMmRsUm9N?=
 =?utf-8?B?cWxjdVp3eE5wNldFNHMvV1k3VEJpNDVmWXBMTEVTd1gzSU9JeVlIeVF5MHUx?=
 =?utf-8?B?c1VjM1liL0E1TGt5czRKanVGZVREbnV4S21CQmtFSjVkVEZOOFlHcXhBVld0?=
 =?utf-8?B?YUlrKzQzZFRtSm5iajhGdUdSaCt3VHdVM2toS3doZDhla0s2WWNiS1JmTDR2?=
 =?utf-8?B?VG9IczU5Q3VMNVU1VnRGc0NxUHlyZFl0NDFmUW1IMmUxNDI1TEVublFsYTdT?=
 =?utf-8?B?RU5KQkxneFl4dFdzMVduREhQWHcwV0tuaWFBek1rdzlXQllGV2ZZTnJVSXJX?=
 =?utf-8?B?OWQ5YWZwQVh1aXZxUjJscVJHUkx0eWhFWWQxcmludHRQeTFBbkZMNk41ZkRV?=
 =?utf-8?Q?7vFWAvhgOdk3VkowjGrrz3dZu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b033388-6acd-48ea-3041-08dd5cf60742
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:29:51.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeCp2FRfkLHjlitDQ3SsY4l5VgRojALu4141+THzEqNcdzSfvYbrl3JjojBTHnMScrsRip9FwUebmayBJlwYiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> The for_each_*_rdt_resource() helpers walk the architecture's array
> of structures, using the resctrl visible part as an iterator. These
> became over-complex when the structures were split into a
> filesystem and architecture-specific struct. This approach avoided
> the need to touch every call site, and was done before there was a
> helper to retrieve a resource by rid.
>
> Once the filesystem parts of resctrl are moved to /fs/, both the
> architecture's resource array, and the definition of those structures
> is no longer accessible. To support resctrl, each architecture would
> have to provide equally complex macros.
>
> Rewrite the macro to make use of resctrl_arch_get_resource(), and
> move these to include/linux/resctrl.h so existing x86 arch code continues
> to use them.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


