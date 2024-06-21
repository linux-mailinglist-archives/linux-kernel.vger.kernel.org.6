Return-Path: <linux-kernel+bounces-224929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E138E9128C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AED928C1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD4433A2;
	Fri, 21 Jun 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XWrqIRAn"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722538F91
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982156; cv=fail; b=HY4VdwCA+GWYBSNg5OBlCX2U8al2tTVnOMS+Svq7pfyF36aDC3D/ybg9oh3PKB99XRp0ZU+Pj2JN8GV5v4MZuEJdNWD14ePtlA13XaKMgdNIXCd4w1thHHMs7LglD9WOYsOQhfmihyWswDyCy1BQV2/oKWzkkWfWIP63w+VznwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982156; c=relaxed/simple;
	bh=/FIdOyTXCur5puT3llRMZ0loeRoR+asrBxCdjMvLufM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D58xmm89CBhXu1zQP/tCwGlX2kJIUtIH4t++kGmmVeLxoQ3rEIp2kXuKCa9csVMx0jtptARgg+6N3tcGTNnC4xuZibOUyrjcoCFIm3lzB+qXiVdsTNGFNEVY2d/HA0OQevejEWh01hBZVC3d8oQEy/hzuNLmLagbHwwX3gO8fac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XWrqIRAn; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKNcg03nRZsRJaBBc1HRVG95QUSjWq26hJh3rNlN9kJHUR93xlqGnXxjJ3y9Aoq5HSX6LsJyIzkradiVHQA/3aGisQ01ckXSjHNanJ6PhIPCMn9ORJOIsh6SSWOIEdfA4C4cIzlh+60lkj94Mw/3p1W+/fMxuPBlIdcCqMzxUP57SSF2EovY/tfEfjAApQhpdu7dJn00hEGfVg0rc02qOibXURYMIj+zoIYK61ijBYsRkPQxc8zDzKc2oLVfG5Wdx8U+jyHeaEBC2Nltsz2xh9XXS4jipeJaIN7emWWnxuNnptvddU6KwcejfAJDokw8G2DxXs6UW/z9HIEntKqx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKbeRT+kIn0tfKX6CQv4Cr5Qp1ONx0YoYjGUn6iRaTQ=;
 b=Mk8sQjaHY6m03kBP+MWmswhNFnBt7VyMMyILVGZK8RJ0GbbdREP0jsDCy4RpOcPxAKvhmXGsLwVsBja3n8/8XkNtQNBrWK/0p5srsLVWZANqj6HJ4hmrweAcckmNM+BVpjSTDnp5l/N8PhkC7LAs3eKzv+vZGaX6n6do6FlA1P7AO8kUwI9bBer9tfzTF9gJ2vDac5q8aEKqLxNJMpQqZavGbBu8Yrs2NAuEUKUMdMAn5vFW+J9fq0qqBC+WaJN4NKgiDm6XaPghpL5hlQZQMxrHjDLBbv23sK2v811moE6dUTY8dY304y9njjGnYCDsk+V7DFh7ebskii9i6GqnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKbeRT+kIn0tfKX6CQv4Cr5Qp1ONx0YoYjGUn6iRaTQ=;
 b=XWrqIRAnvQOin5pkiiPL3Zjd+Ues/toJHzH2UzLMgFwXQA1HNQwIai0z640qr0nL+UMfjbOdrsAVzIg9WkWY/4TmW7DQxGjdLKRVr4X9uUacma8jYVie+4Dawj4v9y1YddUtz4sN8duJiB3IvTpmQDEkrD3KpMvk5qU5guwifEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Fri, 21 Jun
 2024 15:02:29 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 15:02:29 +0000
Message-ID: <e41238d2-5a20-5497-76ee-4eaa39d3df89@amd.com>
Date: Fri, 21 Jun 2024 10:02:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
 <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
 <4c4c8208-7194-79d0-a9cf-e625e5feff23@amd.com>
 <20240621142911.GIZnWON-Pgx4dSzlGZ@fat_crate.local>
 <187a0e4e-6e05-7da2-37bd-d75f9a6034e3@amd.com>
 <20240621144956.GJZnWTFLIwvAxy7bMr@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240621144956.GJZnWTFLIwvAxy7bMr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::9) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 265fad03-3228-4e80-4108-08dc92032b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnNiTnlIRHdQa1IvYkpUTzJ0dUFqbi9xaUVzU1pJaVIwNG1tZmNsVTliOUVk?=
 =?utf-8?B?TGRrRFJ2Z2VGMXdzNkRMSUlpUFZzNWJvWVpHTjNObXZPcGJiSWFGZ1hvQ0xM?=
 =?utf-8?B?eHNsblhBSHF0dlVUbU5oeUhOUFl6RlUzS05MSzZHVDBOWWVtL3VNb3lZcXNO?=
 =?utf-8?B?T2NuVkp4aWRCc1c4UFUvSExlVmhTeWUvRDZvb09mT0ZOR1k2djBEZTlFTzhi?=
 =?utf-8?B?MU4yOHhXTlZ0N3Z3S3hVQmlhaXZvTzl2RGtFNSs5NitoTWhsMGgzQXBmZTJv?=
 =?utf-8?B?K2xyZTYybGM4cHIrRWpBOWtncFV0M2szTGg4UTFjbDhBSW9Wam1WRmZZdVlJ?=
 =?utf-8?B?NGJ1MVh3d080UVhvZjNHa1l0NTM0YlN4ZzhxWGtmZEdQa3g5NlV6ZDkyR2x4?=
 =?utf-8?B?UExENFl0bmhob01nZFdsR1U3T1dkeS9rQTNmSTM3bW1xVDlCcU96VUtIT2hw?=
 =?utf-8?B?amw3MG11YjVNb2tXQWlxYm1ocmNIejl0Y3BPMmEwdTUvMGUwVjJDZW44T0I4?=
 =?utf-8?B?b1oxSXNiNFdzc1BVUVYvRkNHVjFmbk1nb0IxN0JhNnJ6OWJTdS9BTXdhOUFV?=
 =?utf-8?B?aVR0ZlpIR1piVnZkRFhkSk1TZUtDdDMyY0hxaW5GblJOaVEraEovdTZSSk1q?=
 =?utf-8?B?MUZGQXAxNkYzSlBBRTByd0R0Vkc1dkkwM1hRTWNzK0djN0t5c3ZVVXVid0hE?=
 =?utf-8?B?bG14K3l4dUpHMDJpZlI3OXZ3UUI4c0dZTy90TllGQnpIbkg5ZkIrMitub2Vn?=
 =?utf-8?B?NmtCd1Z5MC93WHhSbmdWM0xjMTY3VlpNNitYNWI2THVSbVNlU0tuVHl5a1Ir?=
 =?utf-8?B?bDZ4cjZXYkpZNWpUR0JIM3ZmV1k0bnp6RUtkeE9Sc01zQzVHUWk5azcvMm5x?=
 =?utf-8?B?VFA4RGdyMEdnZlNUVCszemV4cGo4YzB3WVVweWw4SkFoeEJVRWFZL3IwWUFL?=
 =?utf-8?B?L2Z0T3NrTWd2YlprdWozbjdFUjkzamtlTVdsSVRzeCttR2djKytZcFF6SDdk?=
 =?utf-8?B?UHBXVVdBTE9hOWxpQUZvOC82V0ZmT2dnVEVIblJ5RDYwdVBWQ2oyZlI2dkN1?=
 =?utf-8?B?R29YYmNxN0xEOGhyRk5yKzVYT3BWRDgyTUE5VU5QVlU4ZmNDR0V2Y3QvemJZ?=
 =?utf-8?B?Zmw3SXVHSXpMaWk1SC9SZVJ4Z1EzbXZPekY0TlZPQzBlbXo2UzZjYWtFNG8z?=
 =?utf-8?B?VkpRRGRRRUJwMDZPeWw1aGpDdDVyclNyd1VBRGpVOXEySjBzWlZ2aXliQXIv?=
 =?utf-8?B?b1NDMGVIU0UvSHdkbkpzTVc3aHppTHlsa3NnVTliU28xOU8rWUlCYnZaVVRC?=
 =?utf-8?B?aUpzWWxvc0xJODRaQ25uODhiQXZ5ODNkM1RCemhtRXlXNmk3SEJDTWVqNi9z?=
 =?utf-8?B?MnVXSUg5STZIU3lMYTdFZWdEbGVZQk9sdWc1czhvbmRqaHBDRnpGdHRWL2d2?=
 =?utf-8?B?V0hOenQ1bzZ1MGhrZER1T1Z0WW8vTTBtMnlZeEFlQkJLY0FVLzdJQkFEeDlK?=
 =?utf-8?B?Ni9qdldSbUJGRExlMmorVWxkS2srdlV3dG8ranFsQlFoT3h4c2h5OEhRMDlk?=
 =?utf-8?B?cElheUo3NUthc05STWtwZzdNWk13dzVRM1gzZWpRRjZkRUNWaXpHcmNkYkZy?=
 =?utf-8?B?Y0Y1VGVLYkFVM2M0YTNkZURiQVlPaVhUT2R2SmpPeG0yeHM0S0dIYnFWKzBt?=
 =?utf-8?B?dTV1OHlyVkgwNHU2b3hBU3ZCTTRUWUNqVDcvM0JBdGN3RHlpVGZSS0EvbTZy?=
 =?utf-8?Q?X8gTdA00Q5dCMzDqTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHI3N25OaEYxb0xibHduWWc5UE9KNE16aWMwbTBzTm5INkZyU0dpczdqNkxS?=
 =?utf-8?B?RFhRZUFoRE9RNVoxVEU4K2JXMUxzdkpnQlFOQlJMa3UrRGptQkdRNzN2QVZO?=
 =?utf-8?B?V0VVMnMyWmo5NWJRbi8yM1VzbWI0VHJ3eGNuQWVTdi9pOElOQjA2Z3VKa1ZH?=
 =?utf-8?B?OVJTWHUrZzlMTWdnNnR1UU1lUDNUYzZJK2lNcWpoK01ObGpsZmMrem1sci9M?=
 =?utf-8?B?b2xIdkIxMGQ2RzR3R1lERGVFNGlScEFqd0todlYxejFBZWFPQ2ZVaGw5NkV5?=
 =?utf-8?B?WTN1Y000M2QvR3duNXZYTVorRlRaNXJvamhKL0FVR1Fvd0pKL1I5MVBPZEZX?=
 =?utf-8?B?dERXTHZKa2FyRWFyMVIrM1VHb1JveG1CUFgyZHdBOEY2RW1VMUV5ZFlGL3BL?=
 =?utf-8?B?Sk9TcDBzZXhTc25uckdkOHNsUjBwU0N1bm9SbWs2Z08vMHdUd2hMYzVBNGp0?=
 =?utf-8?B?TWJmSi9Qb2lsL2s5YkhTWjlmZDFUL3l6WFJuK2NiYzMvaVprT3hKYzhJVnNh?=
 =?utf-8?B?Q1FkdDJyQkdFbFRHcHdWcHFWdENiVjZzOFI0d1lXcC9lSWdGY2kreGdmczdl?=
 =?utf-8?B?RTFQRW1ITFFWeDFWcnBsa2Z6QTJBcld5ZmF3blkzUU9jYk11dUl3S2tjd041?=
 =?utf-8?B?a0krRS9jSm9GR2xMcUUxUm41ckVuNDg5eE9rT0NzZWx6bDNrMXFtRWZRRzhX?=
 =?utf-8?B?N2VibmxkMjViYmMvWHF1aVpvOS90UXhwdE5sbkJpZ2NaUjZhL29nVTdmOGlI?=
 =?utf-8?B?VHhwcFA4NUFpR0lxcGdaVE1FZjJaSWJIdTFqTFlaS0UxcTNEbkdKQ1FWRTdU?=
 =?utf-8?B?NFhRUVpXaGtpeGc5eHUyNU4wQktWYTZWTENOd2VNdlBPYms1Q1NucWRKN3FU?=
 =?utf-8?B?MmFwNDBJczVYS2Y3TUxsSHRWM0xmVW00R2RLK3F5TXQ1Y3hlREpib0Y3Zkpq?=
 =?utf-8?B?dGpoRzFBSzhiY3BIUXpOOEdKSzl6cU12ZFg1UGs1UnhGdGpESmpqMjFmU3BI?=
 =?utf-8?B?empnV2lRZ0c2K1FEbWFRWnFTdjFReER5dFVhS2lybmhwLzJBY3B2TmhsM01Q?=
 =?utf-8?B?WFRhbmlkc0p2SGxtRGNOZnoxY0Q4UHZKa2l2VmZHK3FZUDc5eHM4dEtkQ1Bo?=
 =?utf-8?B?bkhIQml4aWdqNjRyVXhpZ3BNaEMrY0FPWWtwVWh4cG91c29LSHkwU3Z4RVl6?=
 =?utf-8?B?Uk92ZFVWdFVKeWh1TzlsTkliLzd6YUlraEZ2SDFTV29hM2I2VC9YVG9WSU0w?=
 =?utf-8?B?NlEyWWN0ODdHNG1RSUhHdTM3MlloS3pIbDBKRzlEeGlzQzQwd3FkK1drTUFv?=
 =?utf-8?B?bGZNNW95dEd6NzhuRkhTK3N5NnhOTkpCTGlyZGVxbFQ2RjRYRVo4WjN5UUFl?=
 =?utf-8?B?QXBTTkNZR1pkRktJdVdkak1KVFR1WGpkOTUyV3BPYVYrNVdQeldyanFtWXlh?=
 =?utf-8?B?L2NvWjlyeTVzK1MvcERZeGd0cHgvOVl6VDJQdm5qSU15eDc2bzJ2WXBJaUFi?=
 =?utf-8?B?dktmV3hKbndETXlDcERzd0oxcUl2aEx0eTUwVEhjU2lSMlBZUGJNUnFEbU9I?=
 =?utf-8?B?b285QnJ3ZE5JUlNEcEFLK2JBYVB1VHJYZDhFY25za0JFVDMwZi9JbHFzbTJy?=
 =?utf-8?B?TGpCQzNJZ0VSdHpQN1RwZHZiWVplNEVUdER6SkFxeUNyQXlZRUE4SDVhMVdh?=
 =?utf-8?B?WDlpU1VrK2txRXZjQ1hRdVM4NzhsS3Nka0JHbWZhQ1dHOXkwV0FoQmhkbHJV?=
 =?utf-8?B?a1ZlN3NMKzFCUTV5K3EwT2FEVWQwU2NwUzBtRThQVGt0NW1NRzI0RHhmL3M3?=
 =?utf-8?B?ZjRNZHp4SnhVRzdyUnk4TEdPSmRoMmYxei85bTF6QjE0eDZiZVZScUI1UmxH?=
 =?utf-8?B?VWlOOU82d01jOThvRWxHRkNEMlZ4TWVWVUFXZmNmVk1XYitheHUxUjF4aWhs?=
 =?utf-8?B?NnFwcTFQaGpzQmlpZ1E5R3o2THcxZlA0Z3hGVW1LZUp6QThKV0xQWGRxVm02?=
 =?utf-8?B?bTh2a1Vpamw1amQ1U1JxcjhacTN4ZEFqR05UbjQyeFdqb2RjbWtReWRCWSsv?=
 =?utf-8?B?RmZZcTFUclFxUitFNCtVTHVaYWVRa3hSUUcvQXArU29wWDVZODZPblBhZUll?=
 =?utf-8?Q?pr51pEJznCFejt3xwE/j8qOy7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265fad03-3228-4e80-4108-08dc92032b9d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 15:02:29.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iwJIKCHmlxZA7iHvhGON+DkE8yHGurSSZfkfgZ4UBK8LvaqMobrobOyN/zi1V00Fdr2l3pHc46IRjlisMEHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

On 6/21/24 09:49, Borislav Petkov wrote:
> On Fri, Jun 21, 2024 at 09:37:46AM -0500, Tom Lendacky wrote:
>> Ok, I'll remove the new static and resubmit. There is also a logic error
>> in the original check which should be using PFN_UP instead of PHYS_PFN, so
>> I'll include that, too.
> 
> So we said this fix should not go to stable because SNP host is not upstream
> yet.

Correct.

>  
>> Do you want a single patch or two patches, one to fix the PHYS_PFN to
>> PFN_UP and one to move the check?
> 
> Since this is snp_rmptable_init() and that is also SNP host then I think
> a single patch is fine.

Will do.

Thanks,
Tom

> 
> Thx.
> 

