Return-Path: <linux-kernel+bounces-569356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB164A6A1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852B7188B3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A77218AA3;
	Thu, 20 Mar 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="juGiITEx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB720A5C2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460684; cv=fail; b=qTRLjUmubDEQMNVDm6nwcs8F+Jc6y6PHSVgl8eWhAaW/YNHJBsiuwyhb2Z6+qVHP1w609/IJfBlltJF2w8qPSoP0l89JvdR3c+cSkB8xAFPZ3FA+1X45eCs8xurTuI8clYcF78GLEe6rw7b8Ul4LeWe+5+5emaRcc/Hogqnx6QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460684; c=relaxed/simple;
	bh=+EbeuHV+9214CRETzWzzmFtX979U0nuf0rDtGuoHgNc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CfJzZHK9xvMOqHERQyG9HzuC3Gz4bQnBVlyvsZDSfwaLJFb2XjPTya+Fj5c+9fI4G91iQMw9mJfVWQM1PGNRmHl50JtIY50tL92bOxr1WdoOZu27Rb9vQOpochPwOIylYVDySSfIphCZ7H0hz0xDyEbJQh5qz7fT6ZqfKykK5Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=juGiITEx; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLQvp7w3rTCVpx2+p1EKhwzT+jH9Q/lScqafDLUml1VluYC39NM7ao22f+rqs7Zvdk6N2PwegRJi44R4h8afgugFssBS3v/o1GitVWej3MXItA1k8BUj4mxA7WJVjboekudHBR//MEBj4QehIn4WD3oNU55L4+UGHIEcFUnn5bJIG7yy8IXDmsHr1s2vGiUYd10VfRNexZXYveWDaN1aCLfYTZyncLUaY1iWPkwlESLXF3+/6sfgUzow7Guk5Q4cYS/Ij8cPsqH5fQccya4BfghVt7GZRRHmT6w6G7oVrDmy8yqwIkDPseZ3Hs+TTTAHnoHN8oQ74hBonnLofjMz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWKeQomfAlkB2BCoqLaw+DhLfXG5pHKnhgXg5yKey70=;
 b=KCuiinAcgkiUPfEgIy6BTomUB3otk56NHRGx2X8NCi+bdw9M3eiPvO9Kus/zJdMqgavKsW9/7HhsJLQ+/HdsGGgQX0cYCvZmnL4kPksYSJIkkUdjoY0LCLIuAwuNk1StbxDhnT8f5D5lcBYDS0rWmvc35Eoqs/nMumQzOGSS/fUvK8TAdPXfLVWES5j6bDt7v/fCYCWcqkCfejtePlNkKol/QZ4GB0s4UvYb+koTwQbfJ4GVTRoeYWYLPNTAVE4jlG68Ud5U7dZFkub0fChM8A8XR134Xd4BIyjJQGjo8BZFHwOiF4OYTYcAuIV6HYVpSO4tVmsUsfNyNeDGGUVNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWKeQomfAlkB2BCoqLaw+DhLfXG5pHKnhgXg5yKey70=;
 b=juGiITExhyEtZcEHwzfKFwmhCMnXKxMrv5GBSDGMfu/W8Yiqb02eP1b0tc0iiam5GgYdMX7hzgx0BGOmUPRk7JTZU66Z4xmP4wiWEWfkL0hqPUmvZvx5ekf0W+YfuE3gkDNYsNnQJOGyJBfCNvRey5fGHfC4kO9sD0j0Eg3lzGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:51:20 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:51:19 +0000
Message-ID: <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
Date: Thu, 20 Mar 2025 14:21:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
To: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
 dave.hansen@intel.com, david@redhat.com, dongjoo.linux.dev@gmail.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
 rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
 shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
 weixugc@google.com, willy@infradead.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319230015.bewglxf3hrf2mx3f@offworld>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250319230015.bewglxf3hrf2mx3f@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 813449b1-70d8-4785-fdb7-08dd678c61e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjhEcmk2TG5nV2k1a21CdEpZQ1U2VzNjUmhzTDc5cEpIVVFkUGhZRDFoVUY5?=
 =?utf-8?B?VUgxUnNPa1Q3MzRkWS8rNk9rdDlRbmliaFhYSThkdDB1Q1E2a0VWaVkyT0dr?=
 =?utf-8?B?ZzRidGN2Z083VG02RXhEVlhteDhENjY1ZWREK21EQmMwSkFCWWFMOFFFM1dU?=
 =?utf-8?B?em1hcWFzSk1HQXg1ZWdWRDNQVUVNWUJOVG9TMTdBRGJ5UTlaQS9WOFNpZTRk?=
 =?utf-8?B?b283clpjeFcwWE0rY2wxRlhQMzVuUUVYZWVENHhySDJzOEhDK1pVc2lpQkdZ?=
 =?utf-8?B?Vy96UzBNaGhlUVFvbFovbEdEY1pKR1NvN3NnZ0VRcWMxazArWHlDeEthYWVs?=
 =?utf-8?B?a3lVelNVTWx5UjFTazExUzlhV29qSUJXQmtHUHhHVUFvc1VxSFVuanZLTlMx?=
 =?utf-8?B?L1VpRXVpQk85alFTMzlwNjRTaWY4eTRlWTg3bW9QSHBZVmdxeFppUy85ak1t?=
 =?utf-8?B?eVM5UFRYOXAreGN0dGVKM1BWTVZKUE1TYk5yYXY0R2JWYzFoVTRWSnNxMkpZ?=
 =?utf-8?B?NzJBZVdJV2x3WUZGRVJTd09WTVhqbkpvV0FGek5rdTIyRDJBVUozRjFyNHMy?=
 =?utf-8?B?c2RsT0Y0V290Snc5NC9PM2FkZnh5ZmMreDRwVW5rVmhNNS9BSklocG8xM1VW?=
 =?utf-8?B?Rm5JVEhwN3UvL1dLY2ZxNGNoOGtoZ2wzZ2tyZE42c2QxN2xDTE5mL2ovWVVt?=
 =?utf-8?B?QU14YTlEb21RY1dtWkpsSlF6QnJiQTJvL012d0toeW14Y0dIWXRCUlFEbm0v?=
 =?utf-8?B?Nm80endEV2RmdHlHbm9aUzBKOVRiRHNSWXZwSVVXR1ViMU9ZTWF2T3BHdWEv?=
 =?utf-8?B?WDk3ZVJ4MUpaNmZwOW0yd2x3RUNaeTFWNHgwdlV4aHZVWlp4UHpZQUZkcElH?=
 =?utf-8?B?REcwQkMrekNMbGF3Z1RPRCtyZTAyWTVZK2drVFM4YXlWMEFWR1N4dVlFdHJw?=
 =?utf-8?B?SVZ1djNvdWNnVGkyb29TbVRVMnBHL1RoRXg4UjZOS016YmJZTEEyakZVdUE3?=
 =?utf-8?B?SGpJNzFWb05MSDBzaGRtaENZY3drVzhVcFYzOWNpRmhCcVVyd0llTEdORklQ?=
 =?utf-8?B?NjAwVDhEK1RHTzY3cHBET0RxR0tabjAyRUZpN01pUVNGY1ZKajlHcVg4Uk5G?=
 =?utf-8?B?bll3S1hjaUh4WGFKV3BTaEs0NGFjME42NUNQSHdFdXpaZEJiZTBCbHo0OGY4?=
 =?utf-8?B?RlJUR1pKRFFRUi8yaE4rYUo1NDFVYzZtTUpLRkUrNTlDUk1tckhIdUlqc092?=
 =?utf-8?B?dFRkRk9TMHpiNDI4YUV5YzlaWHhFSEhVdmIxblVUVVRTM2NhZ0w0ZW9Yc2Ur?=
 =?utf-8?B?MEVYYkFuTHUvRXhxSS81RGhPRGJ0dmZpUDhWV2ZpczhkcWVnZGY0UUlwWllh?=
 =?utf-8?B?cFNORWd6VG9CYjF1ampNbkdoYlFkaEJ5Y0x6TkFWZ2kzK0FNc242Vk9hanF3?=
 =?utf-8?B?eE1aUENaZ1ZXcUIxY1I5bHE3cmlCUHlRZ1FyZ1hKamhlYm9GV0tpMVpnOXRl?=
 =?utf-8?B?aCtaQUMyV0ZVcEtzb0RUYllXOUROTnZzVDdmYVB5VlJ2ODR1QTBGU3I5YmxV?=
 =?utf-8?B?Tnh6ZVFrRzlmb0dOd3k4Tm41bEtQRVQzKzF4MUR2Y0d5eEplQ0EwMVl3dnVN?=
 =?utf-8?B?ZW1NQWZ0ektIelgzbnB0UUliek00b3A2bFVtT0U0Mk1TSDNabzR5OUNXV09k?=
 =?utf-8?B?T1VYRjFqQjRUc2MxeXIralNUUXFCMlYzZk9nU2w5WWJ1VTVzZ21HYTZpdUN2?=
 =?utf-8?B?eFgzVGkzTnQ3TjJUU0JpSU13VytMWk5SaWsvZzB2azdoL3MyOE1SbDRjRVBv?=
 =?utf-8?B?blJnSVFUajlTazdhYU1TT1hVOEt1dno1c01HZzlHUklSclEwcUlWMGF5YVAx?=
 =?utf-8?B?aDdjTi9aTGQyWEFQTDBZT1BFakpmVzFpSFUxamo3QXl1Ykg2SkhRUTJISXlO?=
 =?utf-8?Q?FKifceC9wMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUEyVTluZDJuWG9ROTZYSXE3WDVTRjZQU3QydjFaQzBBaDVwZHlObXN2Unhr?=
 =?utf-8?B?S1EvMmtWUS96Y3Y4bjg1RUhlVlBXWUJhNDVkREJ6a1cwZ2pyZDRDOW5OS3lD?=
 =?utf-8?B?VmR1QW5VRVJHTVlQdld2WlV0YUgwS3IxQTQ4R1F4SzFvcXliL2FxeDVqTThU?=
 =?utf-8?B?QVNtK1A0cTY5M3pBeThSSzlUaGFaRWIyaHFXZGw0NWxhTmo0TWJuN2pNZE41?=
 =?utf-8?B?WnBmSVplQVVET0FCQzRzZHNnUEhtSE8va2dmQzJneERaYnAvSFR1NWVlTG9z?=
 =?utf-8?B?NTgrTGJpSG9rb0dvY0dqeFNzdkg4N2wrMFhQOHVsUXNKNTFHRDVueGRLVnFu?=
 =?utf-8?B?WldRSEJxbVpESU43aG9RZjl3U3NHdk13eEc3am1EYnRkMFRQcm5CYUNnMGND?=
 =?utf-8?B?TTgwZElwQUlleFN2UjB6MWZsNzhsQXhKV05RWnJIMjVTUzJEWUFlZTJGQlhx?=
 =?utf-8?B?clNnVWlDSHUrbW1hNFMxUkpuWFF3cFFOYmlPa1h0ZnE5eGlKbE1lNHZMZUI5?=
 =?utf-8?B?ZHhsUkNYRVVxUXJCMXJ0bHBZZ1M2dGVHMWs4VUxQS1g3bm5ybVdLckRZdXh2?=
 =?utf-8?B?YlNmbnlORWpvcDllcTZpdExUSXp5MGVRdTBLb05pWHZwRVpxdlF4dnRweng2?=
 =?utf-8?B?dnkrQUttYktBSTRYSklycnE4VHBxdkM1VGtFeGZvSit0d25oUG5YNWhuSTdk?=
 =?utf-8?B?RTd3WHpSd1dQMDZWWks1T3F0TFNPc2U0UkRTQnBNSkQvUXg4VThnd21uVldC?=
 =?utf-8?B?K1FPL0V1MGl4cmtJZzNWc21FcC9VSTJmQXkzakRjSUZyeDh2aXZNWXgrSWlo?=
 =?utf-8?B?anBYOStOOWh0OUM1Z3pGTkJXdEJ3dkF1d2FvOUVQWmRXbE5zdFhTdTFzODgx?=
 =?utf-8?B?MktPZElpaGZuRGpIbjhFbFdEbUhROEZObWMwcDJpZWJHTHVIUHhxS2VHaDFl?=
 =?utf-8?B?cXdmMGZyQUc5SUVIVWkzeXAydnBkdTVUSVliZEdGU3Q5UEsybkZmV1hIRUh1?=
 =?utf-8?B?OWlsTm4rdVg0cFpwRmVpRUZmOVoydEJnUVhBN3FpZU9XSXd4SEh0aUtvVnVh?=
 =?utf-8?B?cDc1K0ErekdDc081eEZlV0hvSmM2ZXZoQWdNTUxJeTk2aFBnWWQyazFidmwr?=
 =?utf-8?B?S3ZvbjRqeXVsMFlUN2tnaXN4bkhmM2Nqd2ZXNHRFS2ZnQ2hrM0dyS0JPaWJR?=
 =?utf-8?B?bG5BYzZBU25NcllwQ085NEZ6aVNUTVpQU04zRnBsdmhtLzVpRmJkQmFXaEkz?=
 =?utf-8?B?Y2lKQWNTOWJBWnBuM3RMTGVnS3MvdEZocUpTdUZjSjFWU3d4bVNKRnBESDll?=
 =?utf-8?B?UFBvb0VmQmk1V2ZPQVVjSmFXOTVqQWs5cG91TDNQbEl0TlFrOFk0ZlBqM0Yz?=
 =?utf-8?B?R1ZHTU04ekF2N3ZzTmdxaXg4TkM0Zy9sbkhHZnhrTlRyYmV5aGI5aFBwZDdU?=
 =?utf-8?B?d1Q1aFpEazNRTUNKbk5rS2pHTlZRQmlCY1hMYU1lMkdYTkdrODloV2xHc2V5?=
 =?utf-8?B?NGlMZGFDVExzaXVERDMySXBuUXVrK25DUHBORUZMdU8rVzBvQVNZMDgwMzU3?=
 =?utf-8?B?dGVjTFdLNkgyTno2QjZ3QUx2WDNOVi9UT2xFNDRmVmwrQkp2TDhnNUZWd1du?=
 =?utf-8?B?cHB0R2RnQVJ3ZmUxODB3Nm41aHR6MCtNSmJrNFBzTlVZcW1tZG8zR1JMNzAx?=
 =?utf-8?B?OFdueDV1c0hHS0s4UEVHYk1aYVF6VTIzQ0V0WW5ZRFdwWS8wc1lPQ2NsWFU5?=
 =?utf-8?B?dmZJdFBkM3AvRFdjZTlzRUlsZ2hWcFBNMGtnVFhDdllNeWRrMGRFWVVzcVF1?=
 =?utf-8?B?NW5XSFp2RlVmUGFNM2ttV0Z2OU4rc0owbGlxalJuSmNOZzF6bjRkTWRqVm5y?=
 =?utf-8?B?cWE2WE40WWZIb0gwM0MxemppVTFTWGhQbmlETWMxeWFQL0I5bnJndjJHOW9Y?=
 =?utf-8?B?L2N0R1dMSmozUTJ4eDU0a3k0cUpTUFZLMXJ0cWJXZkZFT0s2RnNJZTBTR0tS?=
 =?utf-8?B?QVRrUUdRQ3B5a2R5aXZxSTM5ajY2Sy9yRFJmSG04RjBkRHl2ZzRpRHF1aDQr?=
 =?utf-8?B?K3RkMXRFaG9NNkQvam8yei9rcUpSYVpLTVA2TUU2TkxZSCs1VHloemxsa05H?=
 =?utf-8?Q?ZHJFCaRHb1iYNzG8eTC3pw9d9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813449b1-70d8-4785-fdb7-08dd678c61e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:51:19.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMDfR8mA0RBsFucex34yCkAhEup0Uj8lCoqpNEcFpaMN8HAT/Ol7Noeve1F644O9/vx/7KxvZKukt+Sb6cvnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030



On 3/20/2025 4:30 AM, Davidlohr Bueso wrote:
> On Wed, 19 Mar 2025, Raghavendra K T wrote:
> 
>> Introduction:
>> =============
>> In the current hot page promotion, all the activities including the
>> process address space scanning, NUMA hint fault handling and page
>> migration is performed in the process context. i.e., scanning overhead is
>> borne by applications.
>>
>> This is RFC V1 patch series to do (slow tier) CXL page promotion.
>> The approach in this patchset assists/addresses the issue by adding PTE
>> Accessed bit scanning.
>>
>> Scanning is done by a global kernel thread which routinely scans all
>> the processes' address spaces and checks for accesses by reading the
>> PTE A bit.
>>
>> A separate migration thread migrates/promotes the pages to the toptier
>> node based on a simple heuristic that uses toptier scan/access 
>> information
>> of the mm.
>>
>> Additionally based on the feedback for RFC V0 [4], a prctl knob with
>> a scalar value is provided to control per task scanning.
>>
>> Initial results show promising number on a microbenchmark. Soon
>> will get numbers with real benchmarks and findings (tunings).
>>
>> Experiment:
>> ============
>> Abench microbenchmark,
>> - Allocates 8GB/16GB/32GB/64GB of memory on CXL node
>> - 64 threads created, and each thread randomly accesses pages in 4K
>>  granularity.
>> - 512 iterations with a delay of 1 us between two successive iterations.
>>
>> SUT: 512 CPU, 2 node 256GB, AMD EPYC.
>>
>> 3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>
>>
>> Calculates how much time is taken to complete the task, lower is better.
>> Expectation is CXL node memory is expected to be migrated as fast as
>> possible.
>>
>> Base case: 6.14-rc6    w/ numab mode = 2 (hot page promotion is enabled).
>> patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>> we expect daemon to do page promotion.
>>
>> Result:
>> ========
>>         base NUMAB2                    patched NUMAB1
>>         time in sec  (%stdev)   time in sec  (%stdev)     %gain
>> 8GB     134.33       ( 0.19 )        120.52  ( 0.21 )     10.28
>> 16GB     292.24       ( 0.60 )        275.97  ( 0.18 )      5.56
>> 32GB     585.06       ( 0.24 )        546.49  ( 0.35 )      6.59
>> 64GB    1278.98       ( 0.27 )       1205.20  ( 2.29 )      5.76
>>
>> Base case: 6.14-rc6    w/ numab mode = 1 (numa balancing is enabled).
>> patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>>         base NUMAB1                    patched NUMAB1
>>         time in sec  (%stdev)   time in sec  (%stdev)     %gain
>> 8GB     186.71       ( 0.99 )        120.52  ( 0.21 )     35.45
>> 16GB     376.09       ( 0.46 )        275.97  ( 0.18 )     26.62
>> 32GB     744.37       ( 0.71 )        546.49  ( 0.35 )     26.58
>> 64GB    1534.49       ( 0.09 )       1205.20  ( 2.29 )     21.45
> 
> Very promising, but a few things. A more fair comparison would be
> vs kpromoted using the PROT_NONE of NUMAB2. Essentially disregarding
> the asynchronous migration, and effectively measuring synchronous
> vs asynchronous scanning overhead and implied semantics. Essentially
> save the extra kthread and only have a per-NUMA node migrator, which
> is the common denominator for all these sources of hotness.


Yes, I agree that fair comparison would be
1) kmmscand generating data on pages to be promoted working with
kpromoted asynchronously migrating
VS
2) NUMAB2 generating data on pages to be migrated integrated with
kpromoted.

As Bharata already mentioned, we tried integrating kpromoted with
kmmscand generated migration list, But kmmscand generates huge amount of
scanned page data, and need to be organized better so that kpromted can 
handle the migration effectively.

(2) We have not tried it yet, will get back on the possibility (and also
numbers when both are ready).

> 
> Similarly, while I don't see any users disabling NUMAB1 _and_ enabling
> this sort of thing, it would be useful to have data on no numa balancing
> at all. If nothing else, that would measure the effects of the dest
> node heuristics.

Last time when I checked, with patch, numbers with NUMAB=0 and NUMAB=1
was not making much difference in 8GB case because most of the migration 
was handled by kmmscand. It is because before NUMAB=1 learns and tries
to migrate, kmmscand would have already migrated.

But a longer running/ more memory workload may make more difference.
I will comeback with that number.

> 
> Also, data/workload involving demotion would also be good to have for
> a more complete picture.
>

Agree.
additionally we need to handle various cases like
  - Should we choose second best target node when first node is full?
    >>
>> Major Changes since V0:
>> ======================
>> - A separate migration thread is used for migration, thus alleviating 
>> need for
>>  multi-threaded scanning (atleast as per tracing).
>>
>> - A simple heuristic for target node calculation is added.
>>
>> - prctl (David R) interface with scalar value is added to control per 
>> task scanning.
>>
>> - Steve's comment on tracing incorporated.
>>
>> - Davidlohr's reported bugfix.
>>
>> - Initial scan delay similar to NUMAB1 mode added.
>>
>> - Got rid of migration lock during mm_walk.
>>
>> PS: Occassionally I do see if scanning is too fast compared to migration,
>> scanning can stall waiting for lock. Should be fixed in next version by
>> using memslot for migration..
>>
>> Disclaimer, Takeaways and discussion points and future TODOs
>> ==============================================================
>> 1) Source code, patch seggregation still to be improved, current 
>> patchset only
>> provides a skeleton.
>>
>> 2) Unification of source of hotness is not easy (as mentioned perhaps 
>> by Jonathan)
>> but perhaps all the consumers/producers can work coopertaively.
>>
>> Scanning:
>> 3) Major positive: Current patchset is able to cover all the process 
>> address
>> space scanning effectively with simple algorithms to tune scan_size 
>> and scan_period.
>>
>> 4) Effective tracking of folio's or address space using / or ideas 
>> used in DAMON
>> is yet to be explored fully.
>>
>> 5) Use timestamp information-based migration (Similar to numab mode=2).
>> instead of migrating immediately when PTE A bit set.
>> (cons:
>> - It will not be accurate since it is done outside of process
>> context.
>> - Performance benefit may be lost.)
>>
>> Migration:
>>
>> 6) Currently fast scanner can bombard migration list, need to maintain 
>> migration list in a more
>> organized way (for e.g. using memslot, so that it is also helpful in 
>> maintaining recency, frequency
>> information (similar to kpromoted posted by Bharata)
>>
>> 7) NUMAB2 throttling is very effective, we would need a common 
>> interface to control migration
>> and also exploit batch migration.
> 
> Does NUMAB2 continue to exist? Are there any benefits in having two 
> sources?
> 

I think there is surely a benefit in having two sources.
NUMAB2 is more accurate but slow learning.

IBS: No scan overhead but we need more sampledata.

PTE A bit: more scanning overhead (but was not much significant to
impact performance when compared with NUMAB1/NUMAB2, rather it was more
performing because of proactive migration) but has less accurate data on
hotness, target_node(?).

When system is more stable, IBS was more effective.
PTE A bit and NUMAB was effective when we needed more aggressive
migration  (in that order).

- Raghu

