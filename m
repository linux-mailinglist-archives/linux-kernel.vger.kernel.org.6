Return-Path: <linux-kernel+bounces-438285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC049E9F63
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA4418833BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FFA1953A2;
	Mon,  9 Dec 2024 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A9flG/yQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF63155C96
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772231; cv=fail; b=hdg63wjRQsfqXw6He80G1o9ILtVEmYzGjE9r7wEDlshVWpQPXAL0MDSvv90ZRi2UdRJLY8BscB9UBfTK/SSBRmk8Y6jSqZj4wBN2kL3CP/Co5aqaYslv6ki92l9chATOJStShvO7ch6ehH51eNPXcK9Z1J1b7PesV1vHPaGLZx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772231; c=relaxed/simple;
	bh=UDSFpypeYfnOZ7pReMxDdWt3mui6bkjN3xCnII/9DlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kn7MpHnGr9cWenCz4Kve1JY1fAXIgwrRZ+2HWL9LDVJFVO7TUi6odDYthb9CmuQysaLg5wj0sCxIiGkBrP08KIeKxS01cZiEheAnHHQ8U4/9OXEIJ8zypZBoqq8SV09kXHl0uVfiXCLlpG9zToMRjkY2P4FPVRrMKuPuRqsHs/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A9flG/yQ; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4+UvIQPHNLqiUjgcNnWJg248dBbd3mkOBLh03NDfA1TXeu1Aw5Ph+5eF+t26kN12EPyZTBTHlySY/uqXyyx59K75acMhY7T67H9sG6wSmfOjbNcOuUt5b+zGzKBiRFsJQuK5Rjr0Estna1JQHOkINEUT/hl1fL6+jsTD3+8YSzy6dHKe4GOLRoJXGO6THyK6fIK5bIvp9zCutg5njO9jQfY9lcczRGR0RU4XnbveM1d66HJ5aAj+aC3VjUk/C0rX9JCarRfLDvYPsKmo1cxb1RFj0Tyu4i0Ih8nOobRPyv6qyAfXY0Jhxu/xUowJxf97Ye+W0wIiittiKugjSTJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HOQErs0Q5P+uhNuxFPpNKrp7bIMyktY8EjXRwiEc8Q=;
 b=XLgM0jtLh/bugflNVSE/VClOAQv57xDFzKuBmjVNAQIG5CIrftLMO8MwQMYgloeZYMhBKjUwXUeknK1YAZ37xxh5DxEJWuO+7QGsCXIudWmRiRY1jR7nXrDHG0STlBY+dHbo7Kyu+d2sXg4fo0Fu6Vnf2JvRfLWr3GsUrBaKON9jzHx0z6hCU9r5Z6sYdaxBT/F2yFH0hFsW5VWLYiid9dwwZ2AfwxUp/QtMffpTqd3ch0arFyU03oIMRRmNDrMK46RfLstEBHJsU4UmccwSwB3V1cOU3RpPEchMfU0nNHHNVQiCsJkKqqSPUaYkIpdFQvfK6qRj1fizezzZV0xR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HOQErs0Q5P+uhNuxFPpNKrp7bIMyktY8EjXRwiEc8Q=;
 b=A9flG/yQfxJ/dd+50aOGgDR/X94jKETUL2BCX/4eFx361ALSu2stHN1UL7LoHi2v+2N0byrZwps/+mH6krXNuxKMWCGa5Q7kpq5fiTQY+BA5Rh1LhSp24P1yd0rijyc26m3TaNZgBtYV/TjH5GNj+osuWCfAG+pDCirSYD+4AvhdnZnu4gFQGWqhq2WcK5JBipXgOcFW3yN1E1kC0WTww+13aMiVAsZqO6RR14n1apU9yFr3NXwtXSFRcCNME9/KAEgAr6KtEGJh3qkSCq7bXwH1RZI0w1rNKmCZ0DoQTLOlAkWX853dMJ2U2Y20Jhd28Xc4bDrO1MbyjLHdgXRbDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 19:23:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 19:23:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Date: Mon, 09 Dec 2024 14:23:44 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <37B7A92E-B58F-442D-8501-B07A507F0451@nvidia.com>
In-Reply-To: <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-2-david@redhat.com>
 <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:208:23d::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 158449c1-f8d9-428d-efdf-08dd18870018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uit2OE5Td1RscWNpc0NJQjVoc2doTFNKa1gzc1F0UXNNL3cxMjR3WVVrcDB5?=
 =?utf-8?B?ZjZuVUR1NUt0UDBFSVBLbjU5Zytya3pRVlphNjI1Sy9hRW5aSTB3ckhTUFVV?=
 =?utf-8?B?aUxNRTROWmtrSFVlRC9UQ2xhZUhyOFpLT2JaYW1YQWRIYm9WNHE2dVdBeHlr?=
 =?utf-8?B?ZW9ZdWdYdU1ENU9NQXpreS9TMGJhWmNXQlQ0MHZNZW16dmJxUzRySERFQTd4?=
 =?utf-8?B?WFhXaGt2bDlIK0RiNTFzY3RncWpzd000ZVR6NFk0WnJlZHNCQ1hoM2o1cGlW?=
 =?utf-8?B?SUxzOEtQYUVkOGQ4RDFTeEZWZzV1aHhYVDNENWRkNHhreXcvRFAwSXo0NHZ1?=
 =?utf-8?B?dWtRSXczc2hYajZvczR2OHpmSUVRdlpJVTNlZ2R1Y1ZQLy9kZWtWNGJucXdG?=
 =?utf-8?B?VEtybEk5bjkvcTU1L01obUxsNEJMa1NEMHk1UHl6eG53TzRxOGwvZ2NJTkdS?=
 =?utf-8?B?aUlITkowdkNhamR2eUg5ZTZmQlI0S0wyUzJjVTNBWGhOT2RUK3pRei9wb0Fi?=
 =?utf-8?B?b1U2Q1h3c0N6eDNNQkZuU0RXdmt2endRTFRjSGl3ZlhSRytoSGs2eWN2eG5H?=
 =?utf-8?B?NjFFV2FnaXhuK05vQXpOb09YSVNNQmZKenozcGdybklpa0xmbGtza3IrNDNw?=
 =?utf-8?B?RXJndVlWUVAxRk0rM25YMm10Nk13dEdhOCtWUGFFRmtsemdhMUI0K1lQdFoy?=
 =?utf-8?B?SCtaWjNha3hEeWQ3MnZrNVB2Wk5GbmpBMml6dDNBMWZOMm1udHVsZUxUSmh4?=
 =?utf-8?B?b215RGo3TCtEbHhjQVlOaVFtZ3BqYWdLQXNCSk1LU0xrYlhLbVNtNmZOdkkr?=
 =?utf-8?B?S2FqNTdCcXl4N1hjUjlRckpZSnNUdHJjUEpVTEs3SHl0VU9WN2x5VU9RV2Nz?=
 =?utf-8?B?Nlo0a3hFZm1ZUVlqSU42a2huMDZFbCtNclduMFgxZy9UUk5vYXRibGtrcmdt?=
 =?utf-8?B?Zkd3ZE9wY3BQbjlMekFFZnQvZm0xWFFJVFRacm81SFQ4dE1ObHRzNnNsbzRX?=
 =?utf-8?B?OWFWbVdIOGhUWmFoY0hXZWRON2FlOVRYSGNCTEI4cjc5Sk1wN1EwSFpwWDJQ?=
 =?utf-8?B?dTJDcUo3U3FLUDRkMW5VTlFUNGJWcTM2MlNvYnZBQld1SmU5cnJJYURHcGto?=
 =?utf-8?B?YzB2d1FOWERNTkRvV3NkRm1rL3N2Z3lYZ0JDZGhmWG5WUVIwS3QzajFER3Vu?=
 =?utf-8?B?YVQza0ZQSDdnVVMvNjlZUW9DM1oremw5YmVwRUJkK3RSTGFYNmFNbEVoVjNr?=
 =?utf-8?B?bVdNdUowOG1XdTNWUjZ2UmRzZHMwcVBrRHB3RHBYbG43VVJRVVZ6ZXdHck1p?=
 =?utf-8?B?UkRva2gwWHZic0h4dXVWaVRuUDlIOGxmVUdGV0JZUzl3aGhGOWxSMkgzWU5q?=
 =?utf-8?B?cHZNM3Frajk5Rlc3bWowMWhUcVRoYXVXd2poaEs0Ti9GSXpwZmRmQmtqL1Vt?=
 =?utf-8?B?aVcvR1kwR1NsRUd0M2c2cHVjUFdSeFpMYjFhblVRQmpFRmdMemNDQkptdmNs?=
 =?utf-8?B?cWQvcW45R1dzWVVVU3RrTWYvelhrVFF4T2xhN01YQUxsdEFhWWtDVG5LTi9v?=
 =?utf-8?B?cUVPd0VGeFdxOFIwZDBGMjNiLzdORlVvb2xzYUVFQnZ2NENTcm5QTTZhTGlL?=
 =?utf-8?B?YlJyYlFlNXU1YTBtY2xtQU5DVCtxVWloaTVGSFoyUDJZNlIxbzdFcUo1K043?=
 =?utf-8?B?M3p2WlJ4TlFJaUpNTXljVXNRYmpPaWlWYk9UTCtWVEt5WU5sZ1YwZkc0dG9S?=
 =?utf-8?B?aVNON2JCYXJwd0Y2NDg3TkpIOENwcjdITWlzUzVVOXB0OHdLbm5ZMU1WM2x5?=
 =?utf-8?B?VXd6bE81V1l0amd3Njg4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emFOR3Z5ckJtVWlzMVJWa2VqeExYN3pVcTJwLzVBT2YxOWVyZy9JNWNZajFn?=
 =?utf-8?B?ZmkyM1BZRElIQTJrZzlFSHVncXVYNzVXMFRKd3JDNUIxRkdBOTZ0YlN3Zmt5?=
 =?utf-8?B?RG9mZitMK1dVdDNtR3BMbmFWOGJNdXVCMTREU3dQUWJ0cTR0bGlCeThCQ1Rx?=
 =?utf-8?B?WGlxaHBYTExqWVBWd2gxeUorU2t3S0l5Z3JDKzIwc0J5eWJ5TmEweGZMYkJm?=
 =?utf-8?B?WmhUWGZ4RVRUZGdBNnI1dXdGODhsVVRCVVNkQkRJUHRJRUFqVmdqcTVBajly?=
 =?utf-8?B?WXJuUk5PVnAwWlorNUFYZkd1WmRtQzZyWms5ZG9mMnRXYXM4ekRBQTNCMmpM?=
 =?utf-8?B?U1pjTWVhQjVxWFU2ZS9Ibi80VnVVRVUwazdHOWNienM1RlRsKzVEUkhtTVRv?=
 =?utf-8?B?bFhuM3Bxalc3ODVuVUNzT0FYSzM3Q0xOSXBkeUF3U0JJT3p6Qm9zRHVCL2RP?=
 =?utf-8?B?L0tBeTRnSFBOalRDWG0wVXJWUkY2WWJDSUV4VFdUL21lS3pnYlpVck1OM2c0?=
 =?utf-8?B?M0dIV0hTYnFFdDF3dXBmNm0zbjBFRlFTTTVPV1ZyU2h5UWtHVHlBcWZsMXlj?=
 =?utf-8?B?OW5oTllhL3M5MXJ6ZzhtdDZaTnZWTnlYQzVSdkRvTzk2Q0xlMnZBK2VrZFpJ?=
 =?utf-8?B?Q1BrcE51RUNoOWpzOUxyM3NWUFNkTms5VzIyMjdZaFU4VHFVRnF2aDV4NmVG?=
 =?utf-8?B?STd1ZlhnbVlyUGR6Y3hiNUF2MGJhd3ROQW9Bd1g0MkRwSkFhZGFod3ZNaHFU?=
 =?utf-8?B?NnVpZ2VFdHI1UGYvTm1TVEJNZnZoL1NtMEVtOHgxRURKV054YjF2TnhaRzVW?=
 =?utf-8?B?Mnk1eEszRGRvRDhMdm44NHFZcDhMakZOY2hZMU11MnpkM05kZ09nU0R4L2hR?=
 =?utf-8?B?UjNtTEtycUxpajluM1kzTFNtVHkvNXlyVWl5cE80T29HZ1BkOGRmSDJ2YTNu?=
 =?utf-8?B?MFhvUCtJblUvRnhRTkVNNGd6R3JobVdnbWxjeEhDclVVeThEK21MQjJvSGkx?=
 =?utf-8?B?U1VXV09jdUdFaGg2Q2hkd3k5Y2IxMHZjYSs2UnZrUld3UjVwTVNOSUY1NDE2?=
 =?utf-8?B?VVM1YjUyNDVaaEdVTE1zOWxTOFZEY1NaRmMxVXBzSUJOeThMb0dVdGovSFl6?=
 =?utf-8?B?Q0ltZkN5WlJlNHliWTlGN21XczBBa20zZVllbTZXVXNyMkV0d1dmaEFvMmNH?=
 =?utf-8?B?dlZTdmNZbkt3dTQyZWdGSXpIMUt5TExjdnI2NmpuVXY2VnZOb0VaU0hOdUhq?=
 =?utf-8?B?U29oQS9rcjZoRUEzZ2ZaV3BDZXBEeWxPR0NVQnRVeHNBdm1ta2ZnLzJPeHR2?=
 =?utf-8?B?VkxadjNRTitseXZOUzlZY2dwK2RreksyMVNCNmdCWEVjRUdSRHB4Zm85ZFdX?=
 =?utf-8?B?TGt6UnZxVm8vL0NybDlTTlo4a0h2SVdxWXdCVVdRVTBDeDczNnUreDFJTmZZ?=
 =?utf-8?B?RHBHTXB1eVpzR2VydEF3dHRNZVVhSFlJMGdYWHRRMGlobTdlb1FzR2gvck4w?=
 =?utf-8?B?dTJGZ0NMMU1hd08wd2R1R1pVMVVrQnpXMmcvWG01aDZUWFltTUJuRHI5a0pL?=
 =?utf-8?B?b0ZwWSs1aXJlNzloOVYvNFpQb1grNHVRdEM4dEFkc1hTSXJ1M3ZiNCtZcTBm?=
 =?utf-8?B?Vk9INUYyaWh0QTlwL3hEcmZZVStXZ01TUHU0VE95dFhEZyttRW9xZXcyR3ZP?=
 =?utf-8?B?YzkwaXg1QmhqeFZsalBWemZZT1pWNC9UOWFsZXpBNG1VV0JqZmhWQS9MN1Jt?=
 =?utf-8?B?WjhBWnliK0dZQUM3UVpqbGkvUW5lVEIycFBjcng5Z0RVZnhpaElqTzc4UVY1?=
 =?utf-8?B?elZQTngxNDJmdVZXSkZXMkhvcTFtQ0dXTXFTOHczNEFlOUV5bGw3d0dMMU9o?=
 =?utf-8?B?VW5pOHoxZldKN0ZVcVE3OG9PMk90M2lZVFhKcVBDb2RqSnNXa1BLLyttWHo5?=
 =?utf-8?B?cU53VHpkZjhSdWpUNU9acVc2YzViWURkdDV1TTk5clFMRUt2alhMSEdYR1ZJ?=
 =?utf-8?B?KzM2dmN6a3ZUaXh6ZEhkc0RZUFE0d2NCT1VGemJwV2pvbjNzNjE5aEltUU5G?=
 =?utf-8?B?ckZqOGFteDcxSHhHZmtITjJZbDJBSGdxTWZuLzBmMUxWRk5NeDIzVUtTSWpz?=
 =?utf-8?Q?7P42MMhJc9eUl3TnPSfVAG4Uy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158449c1-f8d9-428d-efdf-08dd18870018
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:23:45.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /utdFt+g5TNoIQKR3ZZegPdgHcYS7hwbh6bEERNNec4jCXny+xDXgnYSC7Ywxu21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430

On 9 Dec 2024, at 14:01, Vlastimil Babka wrote:

> On 12/6/24 10:59, David Hildenbrand wrote:
>> Let's special-case for the common scenarios that:
>>
>> (a) We are freeing pages <= pageblock_order
>> (b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
>>     (especially, no mixture of isolated and non-isolated pageblocks)
>
> Well in many of those cases we could also just adjust the pageblocks... But
> perhaps they indeed shouldn't differ in the first place, unless there's an
> isolation attempt.
>
>> When we encounter a > MAX_PAGE_ORDER page, it can only come from
>> alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.
>>
>> When we encounter a >pageblock_order <= MAX_PAGE_ORDER page,
>> check whether all pageblocks match, and if so (common case), don't
>> split them up just for the buddy to merge them back.
>>
>> This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
>> for example during system startups, memory onlining, or when isolating
>> consecutive pageblocks via alloc_contig_range()/memory offlining, that
>> we don't unnecessarily split up what we'll immediately merge again,
>> because the migratetypes match.
>>
>> Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
>> clearer what's happening, and handle in it only natural buddy orders,
>> not the alloc_contig_range(__GFP_COMP) special case: handle that in
>> free_one_page() only.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz
>
> Hm but noticed something:
>
>> +static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
>> +		unsigned long pfn, int order, fpi_t fpi_flags)
>> +{
>> +	const unsigned long end_pfn = pfn + (1 << order);
>> +	int mt = get_pfnblock_migratetype(page, pfn);
>> +
>> +	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
>>  	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>  	/* Caller removed page from freelist, buddy info cleared! */
>>  	VM_WARN_ON_ONCE(PageBuddy(page));
>>
>> -	if (order > pageblock_order)
>> -		order = pageblock_order;
>> -
>> -	while (pfn != end) {
>> -		int mt = get_pfnblock_migratetype(page, pfn);
>> +	/*
>> +	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
>> +	 * pages that cover pageblocks with different migratetypes; for example
>> +	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
>> +	 * case, fallback to freeing individual pageblocks so they get put
>> +	 * onto the right lists.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
>> +	    likely(order <= pageblock_order) ||
>> +	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
>> +		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
>> +		return;
>> +	}
>>
>> -		__free_one_page(page, pfn, zone, order, mt, fpi);
>> -		pfn += 1 << order;
>> +	while (pfn != end_pfn) {
>> +		mt = get_pfnblock_migratetype(page, pfn);
>> +		__free_one_page(page, pfn, zone, pageblock_order, mt, fpi_flags);
>> +		pfn += pageblock_nr_pages;
>>  		page = pfn_to_page(pfn);
>
> This predates your patch, but seems potentially dangerous to attempt
> pfn_to_page(end_pfn) with SPARSEMEM and no vmemmap and the end_pfn perhaps
> being just outside of the valid range? Should we change that?
>
> But seems this code was initially introduced as part of Johannes'
> migratetype hygiene series.

It starts as split_free_page() from commit b2c9e2fbba32 ("mm: make
alloc_contig_range work at pageblock granularity”), but harmless since
it is only used to split a buddy page. Then commit fd919a85cd55 ("mm:
page_isolation: prepare for hygienic freelists") refactored it, which
should be fine, since it is still used for the same purpose in page
isolation. Then commit e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
used it for gigantic hugetlb.

For SPARSEMEM && !SPARSEMEM_VMEMMAP, PFNs are contiguous, vmemmap might not
be. The code above using pfn in the loop might be fine. And since order
is provided, unless the caller is providing a falsely large order, pfn
should be valid. Or am I missing anything?

Best Regards,
Yan, Zi

