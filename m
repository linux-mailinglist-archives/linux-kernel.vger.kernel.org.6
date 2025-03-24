Return-Path: <linux-kernel+bounces-573872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F68A6DD71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CB2170127
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9F25FA0E;
	Mon, 24 Mar 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cvQrNuhB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A181DD873
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827903; cv=fail; b=s3Xl8sfBOi/PYNF+qM7AmWuXBMd+JmThnagCu53Zu3LCNp5CWAVKyi42pf4Wp/he0po+Vo5Iaiw+gksjc0/kLrXL3Ibp76FsFKDum0b7Ef72s0Gbp3ZKQPnr1uQJMPQz64DkEEJWzvRTn1d9ymoUB7W+yIeMjpMTIOIdINwVfrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827903; c=relaxed/simple;
	bh=YqMWSE7FCoiSMLxKms6CwapNwxebQUBiEQj7eFjKAwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b+d0DcVqMIFGlbqc+OMUY4zWcxqbp430blYwiQfrsmYtlxVgWdq1C0QyOVKsD0nniL2GhB6Sx6Y7yzueWdJfob78oE6qSm1iL9m61D9A6o73xI7aSighna0uaZsETHNYzBQHqT4KwEZIFKA4kOBD9cNdX9uW9RlMWfeLwT7IKwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cvQrNuhB; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzFd51k4n5BsnIcMKmcdYWSa8HPsSB71X9cS2otrF8yxM/Gh/hlnpu8DRYgFPgDIP7ZWb2IsYxkQCaeObZekxtb7GJMEv0F/Am73jvs1ibOD8QVP4hvQ+69o1LHbGckWN9uKFe/eew2+Wt0lJcyicwsdY8n8kXF9N9igjd8RnPmuB8BZv2fBi/GRnkDck2g1VIAQbxm7u7/iantI4J21QcqNk2qvQO6GtJyAqQEmansdLuB5y0reFFNOujBIB2WyOx0M0Unz0PpMYA/TlmRnjC0UFWv+alBOq+eHqrVkwcgX3dIbUZPlurQeRunnLNlup9/6Upj7RdtKHqu8D8RMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yywzJMOebM1M6NoFcD1jevDa/LAJgyNlhryq76mlQX0=;
 b=iEOlAHv/QyMws/EcKEagGJBbQu5Vh743FVmgS5NS525EAa8nhb5XiGh3xOGitGPtAPkqx//q8fhxCNrC3HrwkA7jSIaLlX3jNGhU3AHX+9RLiW6lzvwEl0zVrC9pwizunO4VRX7MsQyGXo9mG5qASHWv3mrZT6D+Q96O6NBOZehdgABYVNkPJ7zEm//GO9Zs2CkX4okZvpRtDIDu1lP2HLz92+eav/WvC07nDARAd5tHxKT6bzWKPohoPAZ6PtUapUNf+sey2R4A81pYTowpvfwSY5zdofbAZNaTAhmOc/olzkdqgPDdEWJhFjDCM0E7kyLtxlHL88czBfdFQnz4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yywzJMOebM1M6NoFcD1jevDa/LAJgyNlhryq76mlQX0=;
 b=cvQrNuhB3cKLUkZSShaXff1Ar7nzwYMlEEYyivwQ3Dl32KYPRNXqPxJu/s45IvpFuHqu8FpBqSCOp5SVBmpO8/RXYsvcZTPwxgg/H3eLAHNuwrWKchZwEiADcVvQ5Hsi/raRHgrycpIYRT/zFejIvcJwz24EEX3RHaOfrs0iCto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:51:38 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 14:51:38 +0000
Message-ID: <a6bafb47-844a-4f50-ad1d-79c2bca86371@amd.com>
Date: Mon, 24 Mar 2025 20:21:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
 <82cb169b-15b1-46f9-9d8e-4c9483de1c77@nvidia.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <82cb169b-15b1-46f9-9d8e-4c9483de1c77@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ac0c55-44d0-4b0e-2372-08dd6ae3619a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWl2aUhzdjJCN1o3bzQ2RFh6eTNsLy94R0dUdWpRWHZ4S09odkJ1ZmpuaUdY?=
 =?utf-8?B?NWZMVG1oY0hoV2F5OUVKbVI1RTlmcy95OEpTVEQvQ054VjVsRjcxeERxVVJO?=
 =?utf-8?B?T25PWHRJcllaeEFHNEY2cktwOWNYWTM3WHhJQTNnLzg2WmxhMXBTK0ZHT1Ew?=
 =?utf-8?B?aEk3L2hNeE9VVG5VZHoySGVtSTlDNFk2UGRneDVnK2IzYldyYmE2dlZEcGY5?=
 =?utf-8?B?QzBFcHEyRnFaSkJrSm9GQWROeXFlaUpnOE5IZFZTZWFiMVFYLzJZYkFkbGNv?=
 =?utf-8?B?dlhENHh0UW14MjR6RFNDekJTZnFHY2R2Q1FoK054VUZ1SXJGTFVzaWNtUkJt?=
 =?utf-8?B?S3ZOYlpDb29OTHRuTFpRcktnWk5OVmYzcXZRbHRQeElnSXNGcng4UTM1eEoz?=
 =?utf-8?B?MEZoTnRFQXR4akNHZ0JwL3FOaHo3bS9PTzRuUytsODFJSTJnbXU0akQ4bGth?=
 =?utf-8?B?RUdNSzV0d01sbXVkRkw5Smp4Y2FMQUZ2TUl0UWxuQ202aHIxeHFSbzJIUy9j?=
 =?utf-8?B?RVQyTG5URzc0aEZEdXVzb2thMGlwMTB6d0tSNlFnQzVYQVVINVNJWVFvTHhn?=
 =?utf-8?B?ZjRYUnppNk11RWJGRzh1U1NhcE40T2NsRVd0NTFDUUhjTDdvb25XWmdVVDBT?=
 =?utf-8?B?NHNRK2ltdEZwdlQ0aFk5bkpQMlBVcjJMaG9oYUxaekZtS2dBWXlicHNYdnE5?=
 =?utf-8?B?bmt5by9VTEZ2SjIrYUMxWkJOaXM3THlqaCs5ZkQrSmFNWHYvZDkzZG5kbWtp?=
 =?utf-8?B?eGxDa1Fnang4WEpReUp2Rjd0K3FtbmFMV2FpYjRVeVp6Szd0cE1hZUxBdjR1?=
 =?utf-8?B?TWpVbmMwMkREMURHUG1DRnFmNThZNUlvTVhOK1lNdTBLYjVJc0ExbUtYWmdJ?=
 =?utf-8?B?bnRxK29uTVdwOHlYc01iSENMUGNTdTZuVUxZbmp4c2xTc0YzdEV2ZVhaTVZq?=
 =?utf-8?B?L3BuYTkrMHFPck83T0tyU2sxb2hLTDV2VVUwejNkQ0hEZ1pZOTN5bTVMRHBu?=
 =?utf-8?B?b0hWbE15R0lGWU92OTRCNGdoNW9rZUt6R3BUbytsZWs5TW1xNWJJS05taDF4?=
 =?utf-8?B?ay81SnRTSU52c1lReEVaZEkxN0FGY1JJR09DSVBPN1V2eEUvUksvZ1BzbWcw?=
 =?utf-8?B?K0pyRDJRaW5hYlhCRU84MUNNc2FUd0FNbklSRG1LWTZzNnZrWnBlNi95aVhF?=
 =?utf-8?B?blhjWjE4L01nZTNOQXRUMTBOTjhsNzd4UGI0ZW5ZeWJYWHhMNzJDZzI5YTg2?=
 =?utf-8?B?VzZwM3FUVFhSZ2FWOElYMzRUUTU1NitraWY4Z3l1enJJQnRMQk9wNTY1VGRK?=
 =?utf-8?B?cDJEa2xtZDk0NjlXUk1VODZXUkxJODZFeU9RakU5dVZvMVFPcUJzNERFTElZ?=
 =?utf-8?B?OGlEb0lwelA3RDRHNU5xMlhnbFlDaXhicFlPaTdXZVNtekxnWVFyaEJRRVdT?=
 =?utf-8?B?ZTc2QVorcjB2MXFSblR2MVd2T2Z5Q0Nzak9LUklpeTViK0V1ZUdPSUFKd1Mw?=
 =?utf-8?B?cjBjVk5uTjVUVVpNRkJseHJEeDRzMEV6Z0lCTUdJeUZ4aVhGRm1lZHpMU0xO?=
 =?utf-8?B?L3lNNGIyRW94WmJVckJyVmovV1g5S0JZM2JsMGdSUk40TlE4VkFLQkdHemVi?=
 =?utf-8?B?TjRmZWNBa2EzdEYrUmVwYjNrYk1rS3RqVlZLRHg1M0xDd3U1bWgyR2lGZHdB?=
 =?utf-8?B?cmlVRXljMXFYenlsMU5QMVpuVWgwN2haYjY4ZkQzL3M1SnRpbHBHSzZRdTBT?=
 =?utf-8?B?cFNqZmlHREFPdmVTdHY4TjZiUWJodjA4M0xKUTJzMkpWWTl2RjRIMy9EUjlI?=
 =?utf-8?B?aXlUMFh4OVd0M1JWRHJMR1NRdlpuVng5YzdtME1MQUdVVFhLYTNOU2grMGNL?=
 =?utf-8?Q?7+mZF9gPBeFIz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVRacXorV0U0RUg4L21qL0xHejZ4V0d5QTNBR1k5VmNSU0p3SlBXaXFZUGlR?=
 =?utf-8?B?Zzd2dzBTWmt4QlVHaHI3dEcrcHUvWjVpRG9ERXBlMGpWVWxPTG9sOUg0Unla?=
 =?utf-8?B?cWpDM0JoQTVJV21rdG5VS01ENFFsV0tnanhFQjljc0g3VXZiRHg0WTlSQnMz?=
 =?utf-8?B?U3N3MWNwUFlNSC9RckduZnYraUxXbDZuRWhxWkk2UDRaZWhHWWxIOGc0Z2Fy?=
 =?utf-8?B?U2srRmluM2s4dTBNL3RYcmg5ZXNWc09lbWlvZkx5NkZZK1JmaXJCMFZYTExQ?=
 =?utf-8?B?S0tLM1hOUU9ibGcxRmFiSElhVDdFRmRVcCs3aWtHSUxYUTgwallpK0JxVnRK?=
 =?utf-8?B?dXlJRlZHRGY4Qk9wWFdWR1hxVVdQcXA1NDFpbVVUcW1UTlFQU2hVSjl4UEdN?=
 =?utf-8?B?UTE2Y3dUakkrOHlpc3NieXRwNkdPeHNZMnU0Q21JSUNZeVZyRy9HMTdid1NT?=
 =?utf-8?B?M0podHg5MkpnaG1UK2Y0SU5leVRmSi9zcUJtMzVJeE1YZHppeStUZXBIVndT?=
 =?utf-8?B?RzludWRhanZ1V0NSQWZjWWdtaTlqSHVUdkN2amlIcWdWdWY3T0dCdUlMdGRw?=
 =?utf-8?B?cHYvcjZJcnZTVFh4L0Fac1dFa2dQdTMxdWJiM3pPL3ZSUE5WeDQwV3RkUThl?=
 =?utf-8?B?MjNCeDN2Y21NT1c5ZVhQQ2UvUHMwR2ovcmVOYWE2ZEkyaW15QmhZSFdXdlor?=
 =?utf-8?B?NURXNWFQcFA2QWV1R2t3T3hWbmJjU2pNVzlyUW91citLRmlxbXI3NHAwQ1Vs?=
 =?utf-8?B?NW9LVUJVOVVCaVpmTFUwUGc3YVR1WVBrNU9CZkUrWndLdHo4LzUyU25tcGta?=
 =?utf-8?B?V1ZKbk14Z29Cd05lSnkzWFJVWlpVN0FiczV5ckpySUVKa3hldjJvbkFibzZu?=
 =?utf-8?B?M1hTUys4WnRiWFp0cytkS3dsbE44TGtsK081UUJYbGt1a0tBRk8xTlNvV2h2?=
 =?utf-8?B?OHUxZ1kwbmJTd1FSeUpiM2QrSEFaZ0x0YzZQNkZ3TEhLN0M5UHdvT2puU2hm?=
 =?utf-8?B?WUJZZ3NRb3FmNStQTGFpdE9rc3krQ1ZxL3paa3JjdlVUU201cUNUMTFxR0JU?=
 =?utf-8?B?dytkdGRxeTk0dFF0VFhJSmgrd3NFWmpPWnNZZ1R1UmpsQ1VZbGNqSWIwMGg5?=
 =?utf-8?B?VjlObDdkSEtJVm9JTVp4cGhCNk9lWU9yTTNXa2o4OXNUbUxlbWRqZzQwbFNa?=
 =?utf-8?B?QWw4czBVaSswcUQ1cUluSW5kUHZrUVBNaWl6Q1h6Y3pRZHdEUEJXUmVoOFdT?=
 =?utf-8?B?cW1PQVFxUnBCcjNhSHkrNHg4ZVVrcjJKb2tVRjlZOGNya2ZNVk5BeXBRd2JG?=
 =?utf-8?B?MG9KdDBFYmpUa0JLVnQxNWg1cEtrK1RlYUg1UmFrRVgxZG04S0ZTZk5jMzd2?=
 =?utf-8?B?QU5GcjZ3VFdWZ3FqZ3AySXgwMVpGSVJqNVhpSklHc1pqQVpOMjJiL3l4UUtY?=
 =?utf-8?B?TjlIYmtqTFhDQWl2c2NOTkgycmdoc0Qxc1c2VXJLSTlmL2VtWldoVkZjVTVL?=
 =?utf-8?B?cDlHVlNBNjEyWE9ldUE5RmxiRUx6OGNkUnJiZi9qZWZ1RWdYQXB6K2tiRWk4?=
 =?utf-8?B?aUMycktKc0V0RUNZY1ZjZlh6ck9LYjh0NmV4eng0REJ4dldUS3hmYysybVZu?=
 =?utf-8?B?c1pteDY4aVdUR3lZUHcvbWJpN1BwRVVyejU0eHVXdFBIMGd5QlRNTFF4c0l6?=
 =?utf-8?B?a2pobzBaWEhHSE1GbUdxZXpjR3BVbU9GQlRxQU1UOExwVmxMbXIvbVRWRkd1?=
 =?utf-8?B?V2JBTk83L3ptYjlTVkVUTEZJd0k5TW9RZ0xFVFNXMlVlRXFjVTRzeDZKRWxW?=
 =?utf-8?B?emhLamJGejlWb3NINlFQaDZJcVQxdElGSktOcG44UlNlc2NrQm9kSU5Jcisv?=
 =?utf-8?B?NWJpYlZSYktxK01HYm9KWVRHMWJzL0tLbXN2Q2pLNmlzbWVDcG9GaVNDUWVQ?=
 =?utf-8?B?YkF5UElVM1lmV0xReGFWRlFqQzBFV01xMzFxaE50czNvbkFuUVdzL1hzUnBJ?=
 =?utf-8?B?ak5COVo4dm1SL3FnZ09pcDNpSTgrSGJBdEhUN0JOY3UxYXZ0UG1WSmtvU2hR?=
 =?utf-8?B?T1ZQMnh2SUt1ekRtcVhNTXNLTTJkRUdJeHMwd1VpK0F2dnhVZ25ucUNTSW9v?=
 =?utf-8?Q?eCXcRTpUbBPPq1b9qmiQ1vouq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ac0c55-44d0-4b0e-2372-08dd6ae3619a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:51:38.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcKLo7ldn3uTT7ZCpY5aBv+mUNGSi21LJVE+FHglvNnNOwglXNRQQjVGIQx8kM4daeKQsk+fyrWAVlmvvIQ+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On 24-Mar-25 8:25 AM, Balbir Singh wrote:
> On 3/6/25 16:45, Bharata B Rao wrote:
>> migrate_misplaced_folio_prepare() can be called from a
>> context where VMA isn't available. Allow the migration
>> to work from such contexts too.
>>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> ---
>>   mm/migrate.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index fb19a18892c8..5b21856a0dd0 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2639,7 +2639,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>>   
>>   /*
>>    * Prepare for calling migrate_misplaced_folio() by isolating the folio if
>> - * permitted. Must be called with the PTL still held.
>> + * permitted. Must be called with the PTL still held if called with a non-NULL
>> + * vma.
>>    */
>>   int migrate_misplaced_folio_prepare(struct folio *folio,
>>   		struct vm_area_struct *vma, int node)
>> @@ -2656,7 +2657,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>>   		 * See folio_likely_mapped_shared() on possible imprecision
>>   		 * when we cannot easily detect if a folio is shared.
>>   		 */
>> -		if ((vma->vm_flags & VM_EXEC) &&
>> +		if (vma && (vma->vm_flags & VM_EXEC) &&
>>   		    folio_likely_mapped_shared(folio))
>>   			return -EACCES;
>>   
> 
> In the worst case, the absence of the vma would mean that we try to isolate
> and migrate a shared folio with executable pages. Are those a key target for the
> hot page migration?

I don't think they are a key target for hot page migration, but if 
shared executable pages (like shared library pages) have ended up in 
lower tier, it doesn't hurt to get them promoted to top tier, I would think.

Regards,
Bharata.

