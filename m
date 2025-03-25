Return-Path: <linux-kernel+bounces-574770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F3A6E9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1C7A28CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37811F940A;
	Tue, 25 Mar 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HuUfRgn4"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B560A93D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884629; cv=fail; b=ARx+GU2PhQStnaMjb0wZQVMr3lvcSOMr5MKKIT8RAbYu3dlwwiTx3Wyt7+fFmMc6gqQhUEUZXch2+IYUkxjGYfV7utdR3OCEbF7be30h3zI4WxW6yphAp4ixnrswztSvgvMCvspfNbVzX3bZ9Hb1HVqq9T1iuP4ASnz3HqtbBzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884629; c=relaxed/simple;
	bh=ORl/ry7AdsuQqpbKyQ97a25xDDkGz6uvrLB4bI1dZ/4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xrv5TpYcA8nboCuk02EBGA/5d0oKEg7Nq4hzu8LGje7ZapZwC7tfV/GBM96c3zB1vAeAnHKyiF9RKO6ayk1aRvY823Zs+jylZKssf0M4HNIAFHmtW3qPcHhRgz7rgEjKtqo8NwBg1T0W34+ee9Iyb2sxPq36COPuoWK5QD+QXZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HuUfRgn4; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4QSBeMtEMd1qP+MzLW8UHgXDm8Ji0jxyCvMLUgW3LR2AlIVyoU76+UbUqE4pghRT2aunCXFOjz/GXjxAY67J80oc1XkE1dsFgr4I6JLb8vXgeiZCm5LKRzMVPSpDUX0GlOASaG6wQlm9rGgg69euMARKxlIt1iGAoIAu1Iy1c3p6vVjYQqgekHYS7BqggleoWG0Du+EVipCuohoWrbRLro2AMLBSR7gZP924EzvcsmihgakdIFCaZvkGQP3Xa/wxixsQdvnmHnLkyHF7R2QNUUnqZZolYsgolVHpSJ4JvnCM01dHLLqUx1ZLDbUy4KYy8kRBj/mwyvqmNY4I3C/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUf3DbxtkW4AfNIBCvVOsBt7qT7vfNz7XT6x2UG7/zU=;
 b=TcjOlyA+Cprh1FR1tTqEZTutb/xqeIimsRhzo9HJKtA9rhagTAaORwHOVEDrGUS6r6UJQNNTEUyJE+9EJb0iKNEsmHeAC4DrYPD60bZM19ge3FR3Ed7ZtAjBFjQMdSpUiV8W81YyRHS+PKHXq4A7U4ZWUAfqQrMsLHVPuHnLln+BpRMYK7oVWHplaUTRDLy0l1HwnGrlDpQkmjEF9ej7yjvcwgPGnJfPIWwQaZ4pGpKTEHxZMloOo01WzL+PsCqOxzCVN0izC9dvv6+urKNFaZzoAb9kNnJSpeNHY0FzFMVgFF82sscJ/lI5H/ZnwaVtzRjXgIZ6ULni+Xq443+fMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUf3DbxtkW4AfNIBCvVOsBt7qT7vfNz7XT6x2UG7/zU=;
 b=HuUfRgn4HJeliy5w89H4WjabtSZq4vAzTqKlBR5LYnSebSOdHjnYcMwSsYJY+3CBMdyfVs/Umskt4JUnR9R8tNvoNe9+220pjcjqwDqRUp/6Co90M29NfYvOslsoKX3bBMaai8sxGNk4Zn2SY4TtXKWKOzkTsosPthLUEIrnIHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:36:56 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:36:56 +0000
Message-ID: <ff53d70a-7d59-4f0d-aad0-03628f9d8b67@amd.com>
Date: Tue, 25 Mar 2025 12:06:39 +0530
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
 ziy@nvidia.com, Jonathan.Cameron@huawei.com, alok.rathore@samsung.com,
 kinseyho@google.com, yuanchu@google.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319230015.bewglxf3hrf2mx3f@offworld>
 <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
 <d0aedf71-047b-4ee4-9175-a67708a389de@amd.com>
 <20250321203555.4n6byk6vmnkmpewi@offworld>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250321203555.4n6byk6vmnkmpewi@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: f5de744f-aa18-4072-b4fd-08dd6b676faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFhNY2YrbzlGbVFacUU0V0w3dW5vNUtVUnFocjM2UkRYOG5ha0RubW4vUWhZ?=
 =?utf-8?B?TGhkQWdIZWtMUEM2MXg3MFF5dm40NzRMYVJjd3lsVmtsUm1RdnZTLzRQa3pZ?=
 =?utf-8?B?bEFJWVY1bVBzajJnNktKc0lOaXNQUVRMeE1HcWpSWkdhVDYxL09QcTJqR1Zt?=
 =?utf-8?B?VElRUUNMNnBRbEpBalpkZ2FhQ2gzbUpndjZmWVhyaVRxTGN3VEJZekIwaHB6?=
 =?utf-8?B?Y2ZRbEs0WnY2MlJKejBCalRXS0M5cWVRN0hrc2F1M1gyN2ZUVnJQUzdZaHlK?=
 =?utf-8?B?TUhpdkl3Rk8wanltRU9QcmFsbHBXZUhFWExIU3pDUGpMbjVGMDM2UzdPZTdF?=
 =?utf-8?B?bzQ0Zzk4cFpiSzhzbE04RXNyQ0xwY3JMcEJzaWpMYytlVW56UGVSTWUvcTNh?=
 =?utf-8?B?VWlicm5xVnIvUTk4cUJZeE5xck80RUFHdzVvdVFJU090T1JkVjUvVUxTc2pn?=
 =?utf-8?B?V0NtUGpUcmlxc0hyOHg3S1BMRlY3R1VzN0YrY3prMlF2QnBKUzNUWnhRYWJ0?=
 =?utf-8?B?OGhZYzFoOHZ2SDVFRFdQK0djUWxCQWNlWHJUblpnVitGUWUyTENrMVpRTWZK?=
 =?utf-8?B?RThRTHdtUHo3eHdod3hkaU1tWnJ6N2ZtUXJZM1V4K3JUYWxVMDFLOXhpOWo1?=
 =?utf-8?B?NWNDcEJBQzg4NmZwZEpjV1o3bWtyZDFLOUQ3aWRpdGFvR2IzaXhQMzh2emlW?=
 =?utf-8?B?ZDVscGJjTFRaYUN5STB1RkQvczNFOUNhRmpRTmpHZ2Z4T1dzRU82UjVhZC9P?=
 =?utf-8?B?Zk9sZm1Lb3p3ZDhGK0RJK0E4azRLMldxWFRhVmIzd1p2U2QyZjJYRlpGVUQ0?=
 =?utf-8?B?TjY5TWgrWnV5NkdnVDhkUTU4MWUxTWlSSTRhL3l0SGFuWGhLZ2o1TkdKNDRz?=
 =?utf-8?B?dGFGbGU5VVVqQmVSZ2lJMWlwd29GeTYzRGJzZ3dISXlkU1EzM1pRcFhLcWtI?=
 =?utf-8?B?dTJha2RFSTMrenZ0RFhROHpYdHNPbThsUmwrY00vK2FtaXE5R0lHc25EbDV2?=
 =?utf-8?B?MGN4bGtIVUZsbFI4UmFMS056VTNTZU9MbUYrREJyYjYzRTF6czA2Mjd5eTJR?=
 =?utf-8?B?T2wzOEZXcCtFR1M2NERGV2RCWUZNMUFPbWRjRzIwTUVaeUNIU0gxbU9ST3Ar?=
 =?utf-8?B?allGOFNOQVQ2ZzJoYXc3dHp0RGp2Vzh0azBhMGx4TC95NTZJcGdseTJERmlF?=
 =?utf-8?B?bUh4SmxqRXN6RkEzQlo0SHMxbEQvWGI3R1NXdWNkS0VBdy9GVXRVSnRUejZM?=
 =?utf-8?B?Vm5lUlU2NUNqd0N4eGpubW94VHF4eDk5cTJIaWFRa2xCSCtJUWMyblFaRU5r?=
 =?utf-8?B?RnF5aG1lRVNKcGxBaTNUWmowMnpsZU42ME0yejYzL0g5ZzdEYll5QW50eWg5?=
 =?utf-8?B?WmtWOWl1bEtwemx1N3A2SVRCVUlCemF5ZnlPb25obkREcDBkanN4ZFZCS2cv?=
 =?utf-8?B?YUIxbHljbWJoZW9wYmhOV1ROUHJsV3BzTVJSUkxXUmhrSS9OcWs2a2VNL1ly?=
 =?utf-8?B?N0s3eWUwNVRsOWRueW1pSmZnelJGNWg1SWVpU3N2c0diemJGV2k5S2F1dXNR?=
 =?utf-8?B?Q2FYMlgzakFaSjA1R3VqNGZ0L2kvZjYreG1VbDdVbHlhdmFOUlJTVTZ6elUz?=
 =?utf-8?B?bVFBR1NDb3lJN0QxSitnOXlDNHVZQ1JLWXpmN25jWUtld0lVNjRpakNrVHo2?=
 =?utf-8?B?ZDdLWWdNRXFZcHZKSElBNGxvdHcrWnhnTVFUSjRvYXVSS3R0K0l3ZWs3UHlU?=
 =?utf-8?B?ZmwrUkMrRnExdHBXOU13OVFjVEs1TFpHcGJQL080T1RDalU2V1hDVlJzclVX?=
 =?utf-8?B?dnFnRS95dzVMTkpobXV5WTVhYjdnQ0pHL3FjN1pNbHRZKzhobEVjNEFtbCsx?=
 =?utf-8?B?SjNVTnRYMWk1Slc2SEJaRUI3dzYyS1RveEtXY1lmQldxZ280d1RuZjloUkp3?=
 =?utf-8?Q?jQRs3/krx/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWN3d05rVDQ2WGYyRXVDeE5WdEtNNS80aFJJWWwzUFBOemtHWkpLUlpuZ0Jm?=
 =?utf-8?B?YU9HUkYxZUJ4VThTSXMxZGxEZzluSjgweUtzZXZlUW1nTTZ3ckRpMWFaS2Rq?=
 =?utf-8?B?Nk44b2Z6My83STBUNm5zSG5ZSXZLdEJQOW0wSndXanh6MjBVRVJ5Qkt3S0RJ?=
 =?utf-8?B?NXIyeG42cldjcjlPUXZUQ1VsQ3VabUhlV0dPWDBKL21XaU5tcDlHejR2OEVR?=
 =?utf-8?B?ZVVIOTBDeW43RlN3bEY3dHZwc2puRTZaNm83cG42Umt1ci9ZZ1RhOW9oc1li?=
 =?utf-8?B?U0ZyZHR6cUdtbHp6bmI0STBzRENZOTM2SXo1Y0U3dExPVWprMGtsdHFRRlMr?=
 =?utf-8?B?clVuejR4b0UzRWlqSUdZZllBTWNKTkcvcHN4USs4ZDRDSUNOSHNZYTZiS0xP?=
 =?utf-8?B?eVRPTXZlRXlFS3FvM1lncjk5ajZIRTVqamd6cEFWMkM2cnhHSDc5cDQ5RWd4?=
 =?utf-8?B?RFRGeXVGYllMZk5aMGlDdFg1NjZNa3VjTTBNQjRxaW9IeFR1ZU9ac3lCNTRK?=
 =?utf-8?B?QldnWWNPbGxpODFSbzJUUVVRUDk3b3ZPMXhlODRTdFZjbzlBTHNuZld2ZFFl?=
 =?utf-8?B?Q3V0bDJCbXorbTJ2aVB2RU5CZ1BiUWUzRWNySTQrUmpnR1oxTlJUVlY0UVhE?=
 =?utf-8?B?Y3I3b0xwcHBTdVozOG9DM3E2Q1hvRW11N0xMWmtqdHFiYVVuVmVmUzF4N0FO?=
 =?utf-8?B?aEtyeC8zZmVFaEpiY2FEUEZOWXNTV1NzR296alNXd2UxRlNndm9aaXVYQld5?=
 =?utf-8?B?RVdWMFp3ZU9XN0hCSmI4Y3VmU09RUlp4TTZab3NiL2lyZVBILzcxZ3UrT0hX?=
 =?utf-8?B?bG5WYmJNREg1MlEyMUZ1SDBFVWNKUEV6am1XU1AwYmo2cVRrVDJOSzd6Qkxn?=
 =?utf-8?B?WlpHNzdOMm55N3dTRHBwRzlTZVNNTlJQanBxL1ViWUJmeGRjN2EyRUN5SjhW?=
 =?utf-8?B?UWJQN2s4akw4ZDVuallhZjltRFhkdWx1OEZIT2p4bWpzRG85amdsZ0s3elM1?=
 =?utf-8?B?YXNRVEZuUTlTeXNSUG1uVSttSytZSGtPU2lhcG5ZU2l0V3hWc3VwaDYreEhL?=
 =?utf-8?B?V05yUm5oNXRyQWdveTRkU3RpdjlIdTBJMXdDZ1lBbm9xdnlTQ2dnc3FWcm12?=
 =?utf-8?B?Z0haU2h4YlhjT2kvMmRNM0FDUWN4UEF4Z2RIdE8xVU03aUtuM1ZJYVVxdXdZ?=
 =?utf-8?B?czYxcUNHR3BRQVFKdFRmSUwwb2FJbkZkc2M0V0FQMGgvam1nbW5HNFltWitG?=
 =?utf-8?B?ZXhubXA2T3pYSWhQYzZPZ3d3MzQxVXRKZGRmZzNETWhPWnVWT0loSmE3YmtC?=
 =?utf-8?B?UCt6aG01cUhIYWFNRkdJNnFpZFl4bG5oT2J0bnpGNEI4VTRmc0RVZDlLeHNV?=
 =?utf-8?B?L3VsWjVmcWY1Tmwzekx6M2dEblJMWWp4SjErVFE0TmZxYmM1TnhsQnBJL0Y0?=
 =?utf-8?B?VzR3TThZNnRiWmFqQlRWVWV4b1pxKy9GbTZJd00yT2o4cVBvMjZZdGxEd2dT?=
 =?utf-8?B?MjlBbXVvdndTMGQ3dUsyWkZ3RVl4YjNaWHZ0bHF5bkZING5vN1VKUEVXZ1BQ?=
 =?utf-8?B?VzNPbGljL0VaL0ZjeGQ4dGVjdUd5N0w0dGMrNi9WekxQT2JKTU1XWjgwdU1U?=
 =?utf-8?B?NiszWGNrLzl6Zng0V0xLNmN0ZldPamxoR283ekVmRkJLR0M1U2lDNjBDUW8x?=
 =?utf-8?B?dkt4YmdCVGJWRG15ZE9rZjJWUnJYT1BidG5Gek1aUk1VeWtRcGNPK0d1Yk9p?=
 =?utf-8?B?L3Z6UTBjS0pmcTVBbkcvek9KNklRTWJSUnVWVko0U1ZnV0xKTzFUaHNtSVBT?=
 =?utf-8?B?QUI3MURNQkI0b1JaMmV0S2dISEUvRVZBZjBqbWdpNWJjVWloQVgxMmdMeVR4?=
 =?utf-8?B?QzRZV3plMTF6SHE3S2xpU2s4U28rTmtPcWNCcFY0MlhBTS9rQXZScnFqNmFZ?=
 =?utf-8?B?dDdHTGFLVFVJd3U2ekxWRnh6MTFpVjBuUjhIS1FoKzB6bWlqNkR2TzVPWGtE?=
 =?utf-8?B?dGVYcmZvY3d0Y0ZyZlFMSHdkSzBrZjZXTkJzWVVPN2ZHRFc2ODdDNHRtS0U5?=
 =?utf-8?B?Y0dHNWQyZ0hiZ0RKeW9WcU81NWlsRHVFazRIbktPc2F4WWNwODFpK3FDLzJl?=
 =?utf-8?Q?OfuOY2/OfeVFA7wwHbxNa2+Uk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5de744f-aa18-4072-b4fd-08dd6b676faa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:36:56.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erEHhBCcoS+Ys3VNuXOPFFoA+u8hVTR9JrM1dFoAe5DIiHYjoHrVi86dAa65sU80GhDEfdYtoKymuGm4IsHVMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

+kinseyho and yuanchu

On 3/22/2025 2:05 AM, Davidlohr Bueso wrote:
> On Fri, 21 Mar 2025, Raghavendra K T wrote:
> 
>>> But a longer running/ more memory workload may make more difference.
>>> I will comeback with that number.
>>
>>                 base NUMAB=2   Patched NUMAB=0
>>                 time in sec    time in sec
>> ===================================================
>> 8G:              134.33 (0.19)   119.88 ( 0.25)
>> 16G:             292.24 (0.60)   325.06 (11.11)
>> 32G:             585.06 (0.24)   546.15 ( 0.50)
>> 64G:            1278.98 (0.27)  1221.41 ( 1.54)
>>
>> We can see that numbers have not changed much between NUMAB=1 NUMAB=0 in
>> patched case.
> 
> Thanks. Since this might vary across workloads, another important metric
> here is numa hit/misses statistics.

Hello David, sorry for coming back late.

Yes I did collect some of the other stats along with this (posting for
8GB only). I did not se much difference in total numa_hit. But there are 
differences in in numa_local etc.. (not pasted here)

#grep -A2 completed  abench_cxl_6.14.0-rc6-kmmscand+_8G.log 
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log
abench_cxl_6.14.0-rc6-kmmscand+_8G.log:Benchmark completed in 
120292376.0 us, Total thread execution time 7490922681.0 us
abench_cxl_6.14.0-rc6-kmmscand+_8G.log-numa_hit 6376927
abench_cxl_6.14.0-rc6-kmmscand+_8G.log-numa_miss 0
--
abench_cxl_6.14.0-rc6-kmmscand+_8G.log:Benchmark completed in 
119583939.0 us, Total thread execution time 7461705291.0 us
abench_cxl_6.14.0-rc6-kmmscand+_8G.log-numa_hit 6373409
abench_cxl_6.14.0-rc6-kmmscand+_8G.log-numa_miss 0
--
abench_cxl_6.14.0-rc6-kmmscand+_8G.log:Benchmark completed in 
119784117.0 us, Total thread execution time 7482710944.0 us
abench_cxl_6.14.0-rc6-kmmscand+_8G.log-numa_hit 6378384
abench_cxl_6.14.0-rc6-kmmscand+_8G.log-numa_miss 0
--
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log:Benchmark completed in 
134481344.0 us, Total thread execution time 8409840511.0 us
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log-numa_hit 6303300
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log-numa_miss 0
--
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log:Benchmark completed in 
133967260.0 us, Total thread execution time 8352886349.0 us
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log-numa_hit 6304063
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log-numa_miss 0
--
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log:Benchmark completed in 
134554911.0 us, Total thread execution time 8444951713.0 us
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log-numa_hit 6302506
abench_cxl_6.14.0-rc6-cxlfix+_numab2_8G.log-numa_miss 0

> 
> fyi I have also been trying this series to get some numbers as well, but
> noticed overnight things went south (so no chance before LSFMM):
>

This issue looks to be different. Could you please let me know any ways
to reproduce?

I had tested perf bench numa mem, did not find anything.

The issue I know of currently is:

kmmscand:
  for_each_mm
     for_each_vma
         scan_vma and get accessed_folo_list
         add to migration_list() // does not check for duplicate

kmmmigrated:
   for_each_folio in migration_list
        migrate_misplaced_folio()

there is also
   cleanup_migration_list() in mm teardown

migration_list is protected by single lock, and kmmscand is too
aggressive and can potentially bombard with migration_list (practical
workload may generate lesser pages though). That results in non-fatal
  softlockup that will be fixed with mmslot as I noted somewhere.

But now main challenge to solve in kmmscand is, it generates:
t1-> migration_list1 (of recently accessed folios)
t2-> migration_list2

How do I get the union of migration_list1 and migration_list2 so that
instead of migrating on first access, we can get a hotter page to
promote.

I had few solutions in mind: (That I wanted to get opinion / suggestion
from exerts during LSFMM)

1. Reusing DAMON VA scanning. scanning params are controlled in KMMSCAND 
(current heuristics)


2. Can we use LRU information to filter access list (LRU active/ folio 
is in (n-1) generation?)
  (I do see Kinseyho just posted LRU based approach)

3. Can we split the address range to 2MB to monitor? PMD level access 
monitoring.

4. Any possible ways of using bloom-filters for list1,list2

- Raghu

[snip...]


