Return-Path: <linux-kernel+bounces-570289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578EA6AE65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F20464F59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04122837F;
	Thu, 20 Mar 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d6x17K0j"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553741E8339
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497900; cv=fail; b=DCDlMEUVVNHkd4rVImU8exXfYWWhe4FvyG8kJnxPfKkrYdEWQZ0cjniwljSE1WIRyKmeXrAftYyAUuSbSZyraXsPZnH5D09r3CTnuzU+nAFhW5BrOazFtR5d9BBr+woi+w8hlyFKDZzS08BKfZwkC15+nZUbWVbVcmbeRokJc8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497900; c=relaxed/simple;
	bh=fAkQnCc9ZPoJwUG91pn/Jgv9CFhkpCyJLxH60dJrUIA=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9ajvh58CxBKhdNFIOp3Tu1/KNb91a5MpFVOiXQil1DqO2WJsVK9HkRGDPcYjtSgxJC3u8lH5ZKYWYIORed2q/ETYxhC0Pu6vXw+78JrLJ7JeGqv/gE16xFKzDured/I95HMYKwjcFE+1uoAr4+mBN45fyIhAgWSjxUhReZMi98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d6x17K0j; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF+teiCixqSgnXB+Zxga0noEkBLmKUUzVRNzSnj2Tr16JMJQ/ZkfU8P/5Fj1Dd8xVJgcNpIfvMU4oVNNikvNpmj1HKAJ3EMxlcveRCXuuascMnxblBN0YrthvTy8tsgGWCiRVg/U+gQkNVyBiyb2ap/HZfirnLRokR26xfA9iuJ720I6rRCJ45wnOIs0wuHovYyj7WyFOWeaLIoecHyxyj0taglO0unFaVKU6M2MDYnd+kP/5FOlFCu/IXXasVwTKVugAG+ZBPKZUdC/kMiiUITnmf0uRXpU3S7JtNvU/0zwqzMAtOnCrzQtyZ7BH4jWYr5vrlOSIMb6G2A5/cKeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/LhysTcc//H8Feo45A0XNr8LmnvMFV1YeVE8/KGB94=;
 b=iVXjsuPDj7j6R1AO1Fo76TUDAzd3ya+vYMSp4uYgVCYcfV/XzmhnP2OLewd8o8cYO1vZget5UHnpt/OHE2AlgtXuUn56w6TsCrQqx8edi3Q7DvI1v+WhB88jXyIugNyTEgE2cb+XLfh8qPfwYdZuuzxRXyGJxYdlnDTuk7JEWxmAz8r1msQanB2xLn5qhRCeTQWkUP5+CCdGCQqYlXxtCj0a5/oxPZwP1n4zQO5NyCmPKa7bkfyPFIqSVE4Tql/5zE0yUe8645XGmqUcqHTSbF8JKWlVFkNcOJokpAJVhALHw59C3ZNQWVebjnHBs8SRKAxrCfiffGncS6sP3VUw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/LhysTcc//H8Feo45A0XNr8LmnvMFV1YeVE8/KGB94=;
 b=d6x17K0j2Uu9KxgH5K1roOfmbdRpMQyfE/+MHcI4Zaq94xlw1nQlNueX8XLpUTJ2u6HCwU5usMwX75MeeKogYJZlqLJhtQLmX9Pe1kXorOMo0xYPJU8+0fzH4Y+9koqagkwTk3llJnNl8uRzUHKT6fIF4zsEI5hCLr97N5ebSec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 19:11:35 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 19:11:35 +0000
Message-ID: <d0aedf71-047b-4ee4-9175-a67708a389de@amd.com>
Date: Fri, 21 Mar 2025 00:41:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
From: Raghavendra K T <raghavendra.kt@amd.com>
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
 <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
Content-Language: en-US
In-Reply-To: <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 8690a87e-9788-4669-a5ac-08dd67e3086b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXkxR2lHUThjNzcxL3AwbEpGallpM243NDhGQ0tCWVB5cE5IUVMwZzRFQUNj?=
 =?utf-8?B?am5wb0xUS0NWUXRlUGVLMzVGdUZJZ3gzNStHSHVYQ21heC9UQ2grM29MYWdy?=
 =?utf-8?B?RnNEd2tWMlZBUENDbE5kRnhkYTU0ejM2SDUxcmQxT3VSTS9udmhXdnFLNFpw?=
 =?utf-8?B?MGc4UEpjNEFFK1pEcjhHdURPczUwdDA4TUJYOUc5RmVOWWZLQnFaMXN3UnZO?=
 =?utf-8?B?RHFhc0xwV1VyZWZQd2FkU0FDaGY5QWNJTUxzUkxpOGx6NnZkckJtMlZ1UU9h?=
 =?utf-8?B?cXg4ajh5dE1MY2JtKzhDYWpzVWs0TnEvVmVoTUprMElLdzZzY0hEL2JPY2tj?=
 =?utf-8?B?dXpJZit6UEJmcjRCUzJBZTNSMnFJSEFSNFRjWmJxeTcyckJKSmxuTmNSdlJP?=
 =?utf-8?B?U0pVT3U0MU15V0lXN1RidXF0cXJOaXVsK29FeTRyVVBJT2RsbHFwUC85N0gv?=
 =?utf-8?B?UnlERVh2VVgvVU1wUDlDQjJOYlRwOVlpUUE0b2ROQ2RQbzZhdVVKTDNJY3RI?=
 =?utf-8?B?ZHhOcFA2UFZ6T25DNFZiamFnT0ZKaHQ4QTlHSHN3YWNjL3U3SkhDNlByWWp1?=
 =?utf-8?B?TUxvbzFjMEtkN05tamN2aUZMbGdZVXZqaVFSS3hiMVNrMXdmRnZGOFhNQ2Zo?=
 =?utf-8?B?cDgwWEh5cDJMUldJbXFOOEVKT1ZNK05TS1FMdnMxUGdKenVtMWM1Tjg2NUE4?=
 =?utf-8?B?NWhqeWlpUVRkdklUajNUZDJ1VElBcDY2VGUxWit1NHR6ZDNDVkhkMDF2UDNi?=
 =?utf-8?B?QXBCOFVUTmxTNEtiZ1gvQXNBQVNpUWxZUkNIMmpXY3pUK29mOEgxZFU2T3BD?=
 =?utf-8?B?ODN5TXJsYmc3a2dOM1c0anVmY0kxN0Fac0pYanVsRmQxTmoyRG0wVnNHNDdq?=
 =?utf-8?B?eUZLZWpsWDNCWEV3RzFNb1E0eVNXMDd6ZmthSGVHbXNobHc1MllLU3Q2Vkpp?=
 =?utf-8?B?eUdQdHZvMFRJZHhXZmdjOG0wMlplUlRDUW9mV2JBK05Na3F4akh2NUZiZkVX?=
 =?utf-8?B?RUIwWnRlZW9vZk03bnRyenM2N3JJNlpOK2hzQml0ckxBNEVBbWo3ZlpKbnVS?=
 =?utf-8?B?UDJjeGpCczBzQkJjNi9ib05hRHBQRUNRWEJJSzM4cHYrenp4M0k0dFphMlhY?=
 =?utf-8?B?YmIzRjg0Q2RRTEl1MUJlbjJFTFNLRXl6YWFDR2JaZnp6RDR6SVRwSjg1amtK?=
 =?utf-8?B?VHlVR0xPWnNVS3U4NHRoeDZMd2lFTHNCSmE1RkYzanJtenhOS0pYdzdrcHhX?=
 =?utf-8?B?aStFYVZyMWJrQTVvb0JDZ25PUDdmcGs4ek9YRE9xejZhZzdDUHZ2bzlPVVhv?=
 =?utf-8?B?OHdzdUwwdDh2WnlsM1ZkVDBzWVdialRaVmNwTkg2TS9Wakl2ZlJlN0tFUEtt?=
 =?utf-8?B?b05nS1NTUGdDaFR1Q1dncnlkdnVNRlRrUC85a0FYdEpEZVcvdTQ2eFcrQU5B?=
 =?utf-8?B?V09tc2pRVEl2ZUtEeDloQkF0RU9BQ0xVWE82bkNXY2wwWHlJSVBlN0cyRzJ3?=
 =?utf-8?B?clN0Mk5Zbm0zVXB5Nmt5eVJYaXV3djMyMHA5NGFOeUxMaENBeXZJQnMrTmxt?=
 =?utf-8?B?eXJiUUFKcDY5RnpKVldTcHgwblhhRVZvUzVsbDJsOWd2TGJ6R0J0Z2FIakpQ?=
 =?utf-8?B?bFZkRzREUDJpWk1MQVRDcDdhdnBvbW9NWVhsdk5rcXNkNnJZM0ZpOHl1NDFW?=
 =?utf-8?B?UHM5WVVCT3Z1Uzg2RmRqUko0bXZhYzhKSjdSNE1vMnU5VzEzZTFCMUtEZ2Rw?=
 =?utf-8?B?VG1xZ0JXcE9jQWF0alRQTllNQzI4OHVjN3cyTXBSaStiMmVLSkFGSHNZZW9t?=
 =?utf-8?B?TzRkc1RPTk9rQWprOVBETFZwZVd1ZmM5NUg3N3lES1BMUHVXUVJvSVVyYnNG?=
 =?utf-8?B?Qk13Y1lvZkZ4ZGp4TnZBdDg2MkdISkU1Z2R1WTMxZ0w2K2MxMmUvZmJrTkl5?=
 =?utf-8?Q?tkiVXOCdg7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzBxaUsrMEhJald2WnpCMUZGN0Qxb1N5bHREVklLRXhPSmw0dzdTZW9VYkRY?=
 =?utf-8?B?Mk5oL1NjNzVpRlQxWWxleTZjYTdVRnYzZlFVQTJxUDdaNllPYVZxRm1qMkdO?=
 =?utf-8?B?RnlrQ0hpYVZ3VTZac3VkK2IzOHJMb0tnK1grZWtjbzBYMlFkamhMRlN4KzNw?=
 =?utf-8?B?NXZFYkZMNm9UNmdDVTZLSnloMTdrOUw2Tm1SR1psMWNDMEpZMUd5MkhGVFR6?=
 =?utf-8?B?anJrcWgrWU92QUtOZDVPeG9xdGxKUWNUZ3dzYWFsbWpNVEpmRXU0ZHRaR2ww?=
 =?utf-8?B?TGQrK05HSGtZTXk4VlRHUTIvU1pTM0FlczVWK1g0eXdaR1Q3VVBzRVNvZjZy?=
 =?utf-8?B?MU45d2Jzakh1NTVhT3h3L0ZQYUNYdDJGUWVkV1dwV0pUbUs0U21nOXRRdHI1?=
 =?utf-8?B?eVhBekRnOSsrbVBqK04wYzBUaHdhZWF5amRwMG5YSS9YSGdHZWprTVpXNlJ0?=
 =?utf-8?B?VzI2b0MrYVJqM1NsT0JvMGY0Y3B4QXZaRi80WmFXLzJKQ3dvdmpuUkxTeW0x?=
 =?utf-8?B?c0V3RWFybjdLU1RIR0szbm96ZElKakdzMlJ4Ym8wZ3NxM2ZFYmRoK3MxdSta?=
 =?utf-8?B?cGVuWUdVWXQrdkNyQnRiRTNIQTc3TmhrbzJDMGxVUWlLTE50NGtwRUxjOTZu?=
 =?utf-8?B?cC9CYzNmZkFHcHpoNkZWRHpLR3RjTzhUNVVsMVJBaGpDMk8vRG9Wek53T3dH?=
 =?utf-8?B?Y2pLOHJ0ZURWZWtrc0EwY0FFdkltblF6Sm5CNEdLcm9NVnhIdVo4QXJ4Tjda?=
 =?utf-8?B?bzExa0YxS1NDSzY5UGZZYjh4d1phUXRzdkpZZktRVGI5dGxjN1RYeGNRMkRq?=
 =?utf-8?B?a0NsQ0dVTFdMS2ErS1dkeU8rTEJxaFB3YUEweVBhSXlNZ0dyL0Y0WFE2K2x5?=
 =?utf-8?B?RE1iZDhlK01IdXdXazF0T3J2TWJ0UnRINWZHVzZ2K0JLbkp5YUFsOU1iYXF4?=
 =?utf-8?B?UFFDL3IzRktBWWJ1aFNCRFg2WU5oZVdtMXI2MExMbEpPSEN1ZWU0TmN5M3BD?=
 =?utf-8?B?YzlqK2JWUE5OdWhpMnhkN1d6THNFcGhOY1R5T3NXc0pOZzNaM1A0Wm5KNjQ5?=
 =?utf-8?B?MlNkdjJXdU43QjR2WCs2eWNpbW12VnFwVm8rMTVrdVpycWhZSTFNRnZmU3Z1?=
 =?utf-8?B?bWpvQ0o3WTJDb3FwblpHbWhMQ29aWmkxSko3WjcxRWZySmswOE80RGVNZkRR?=
 =?utf-8?B?UGRJMEpkTmpwc255ZzdyRGFpL3FUV1A4YVh4UjdoY2lIcnZLVERZdmVJU3pz?=
 =?utf-8?B?UlBoWnpWMFJoZGFzR0hPby93NWdkRlQxL1RDTm1sM202ek1YRGUwWXJXbVJ0?=
 =?utf-8?B?d2hWSytCaXhldFU4Wk5iL1J1YUJIUUlCdFZMVkNrOUJ4cStDUHpGWUZndU1a?=
 =?utf-8?B?Q1JvbW1ncE5VTkZYTFczejg3K2RQdmhmaERvRFU4UDVmQnlJZWJjZDZvNUNC?=
 =?utf-8?B?RnNabzJwbVFjUHJ6bkUvaDBkK05Mem5wcWc5dUt5R3lwSE44QWhqbDh3U3Y0?=
 =?utf-8?B?L0FCT0QzVjE1T2t1VmorSkxOVEhCUGh6TXE4RkhJdTM5S1pNbC9IdG5wVVZq?=
 =?utf-8?B?YWw5Y2psQWR4bXlxOWsyTlByU3hpeXZISnplZUZGQXkxdmwxblh6dXNQenZH?=
 =?utf-8?B?RVNqcmlMTHlzTlpYajdsZU04QVhhWU92YU1KWnhLSlovQ1Z3Q21kaEpmYm9P?=
 =?utf-8?B?KzlQYmxjWHNkSFY4U3piNFIySFM3SkR5MTVyaktjYTNHb3pJZXJvYmNZeFhE?=
 =?utf-8?B?WnVxLy82ek56c1JRbEF1ZG9Fc0VsT05ieXREclVFQnY5OVBVWTMvUTYwSGtG?=
 =?utf-8?B?WlJXVndZTkFmVnRDMHNqNlMvTGhkcVQwclhzTkJ2K21MYk5UeEtXblNIZGdU?=
 =?utf-8?B?bE1XUlM3RDJLSUluUmFiRXQzakdhZEpPRVllMklkUEpmMjJRQ0NZdENNWEpM?=
 =?utf-8?B?NTduYVBlckJCWFpRNW5JTENCWjJQRFJLZ2pybW1PZ2ZCMVVBVVlON1BZcG0v?=
 =?utf-8?B?YTg3emlEMHY3ZWllNU9kdkJyNmxWVjBrY3hYZmVxa2d1UFltdmQ3SXlJSXZU?=
 =?utf-8?B?Ky80WmdoSzFXdysyaC9lZHRhSmZ5RjlqOC9SZEh4WVpYSE9hdjFSSE02b29u?=
 =?utf-8?Q?rHcwBBOFtA1QoLIkJQFd/BgLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8690a87e-9788-4669-a5ac-08dd67e3086b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:11:35.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mduZyoxHeD8BTaUiWPHT1CIPRfucR41PLFj4Mp1e/giIZIPyH17bNrlMGNo0XdlimZluFn9oXzqYQb1Udh+p5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

On 3/20/2025 2:21 PM, Raghavendra K T wrote:
> On 3/20/2025 4:30 AM, Davidlohr Bueso wrote:
>> On Wed, 19 Mar 2025, Raghavendra K T wrote:
>>
>>> Introduction:
>>> =============
>>> In the current hot page promotion, all the activities including the
>>> process address space scanning, NUMA hint fault handling and page
>>> migration is performed in the process context. i.e., scanning 
>>> overhead is
>>> borne by applications.
>>>
>>> This is RFC V1 patch series to do (slow tier) CXL page promotion.
>>> The approach in this patchset assists/addresses the issue by adding PTE
>>> Accessed bit scanning.
>>>
>>> Scanning is done by a global kernel thread which routinely scans all
>>> the processes' address spaces and checks for accesses by reading the
>>> PTE A bit.
>>>
>>> A separate migration thread migrates/promotes the pages to the toptier
>>> node based on a simple heuristic that uses toptier scan/access 
>>> information
>>> of the mm.
>>>
>>> Additionally based on the feedback for RFC V0 [4], a prctl knob with
>>> a scalar value is provided to control per task scanning.
>>>
>>> Initial results show promising number on a microbenchmark. Soon
>>> will get numbers with real benchmarks and findings (tunings).
>>>
>>> Experiment:
>>> ============
>>> Abench microbenchmark,
>>> - Allocates 8GB/16GB/32GB/64GB of memory on CXL node
>>> - 64 threads created, and each thread randomly accesses pages in 4K
>>>  granularity.
>>> - 512 iterations with a delay of 1 us between two successive iterations.
>>>
>>> SUT: 512 CPU, 2 node 256GB, AMD EPYC.
>>>
>>> 3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>
>>>
>>> Calculates how much time is taken to complete the task, lower is better.
>>> Expectation is CXL node memory is expected to be migrated as fast as
>>> possible.
>>>
>>> Base case: 6.14-rc6    w/ numab mode = 2 (hot page promotion is 
>>> enabled).
>>> patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>>> we expect daemon to do page promotion.
>>>
>>> Result:
>>> ========
>>>         base NUMAB2                    patched NUMAB1
>>>         time in sec  (%stdev)   time in sec  (%stdev)     %gain
>>> 8GB     134.33       ( 0.19 )        120.52  ( 0.21 )     10.28
>>> 16GB     292.24       ( 0.60 )        275.97  ( 0.18 )      5.56
>>> 32GB     585.06       ( 0.24 )        546.49  ( 0.35 )      6.59
>>> 64GB    1278.98       ( 0.27 )       1205.20  ( 2.29 )      5.76
>>>
>>> Base case: 6.14-rc6    w/ numab mode = 1 (numa balancing is enabled).
>>> patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>>>         base NUMAB1                    patched NUMAB1
>>>         time in sec  (%stdev)   time in sec  (%stdev)     %gain
>>> 8GB     186.71       ( 0.99 )        120.52  ( 0.21 )     35.45
>>> 16GB     376.09       ( 0.46 )        275.97  ( 0.18 )     26.62
>>> 32GB     744.37       ( 0.71 )        546.49  ( 0.35 )     26.58
>>> 64GB    1534.49       ( 0.09 )       1205.20  ( 2.29 )     21.45
>>
>> Very promising, but a few things. A more fair comparison would be
>> vs kpromoted using the PROT_NONE of NUMAB2. Essentially disregarding
>> the asynchronous migration, and effectively measuring synchronous
>> vs asynchronous scanning overhead and implied semantics. Essentially
>> save the extra kthread and only have a per-NUMA node migrator, which
>> is the common denominator for all these sources of hotness.
> 
> 
> Yes, I agree that fair comparison would be
> 1) kmmscand generating data on pages to be promoted working with
> kpromoted asynchronously migrating
> VS
> 2) NUMAB2 generating data on pages to be migrated integrated with
> kpromoted.
> 
> As Bharata already mentioned, we tried integrating kpromoted with
> kmmscand generated migration list, But kmmscand generates huge amount of
> scanned page data, and need to be organized better so that kpromted can 
> handle the migration effectively.
> 
> (2) We have not tried it yet, will get back on the possibility (and also
> numbers when both are ready).
> 
>>
>> Similarly, while I don't see any users disabling NUMAB1 _and_ enabling
>> this sort of thing, it would be useful to have data on no numa balancing
>> at all. If nothing else, that would measure the effects of the dest
>> node heuristics.
> 
> Last time when I checked, with patch, numbers with NUMAB=0 and NUMAB=1
> was not making much difference in 8GB case because most of the migration 
> was handled by kmmscand. It is because before NUMAB=1 learns and tries
> to migrate, kmmscand would have already migrated.
> 
> But a longer running/ more memory workload may make more difference.
> I will comeback with that number.

                  base NUMAB=2   Patched NUMAB=0
                  time in sec    time in sec
===================================================
8G:              134.33 (0.19)   119.88 ( 0.25)
16G:             292.24 (0.60)   325.06 (11.11)
32G:             585.06 (0.24)   546.15 ( 0.50)
64G:            1278.98 (0.27)  1221.41 ( 1.54)

We can see that numbers have not changed much between NUMAB=1 NUMAB=0 in
patched case.

PS: for 16G there was a bad case where a rare contention happen for lock
for same mm. that we can see from stdev, which should be taken care in
next version.

[...]


