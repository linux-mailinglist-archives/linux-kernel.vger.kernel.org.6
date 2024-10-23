Return-Path: <linux-kernel+bounces-377212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E59ABB54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D91F24615
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0845016;
	Wed, 23 Oct 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PymZmU4Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VxkD/YuL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C818F64
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649457; cv=fail; b=YcyAOFshSLAtiTpYpZ1snjIEOxmiNtQrHyVjSYoUEOBDiyn1otzsIRogndU2qkaediBoGkrhZJw1yXHmMoqw/fXJCydc0yispjxyzmZT3a+GY56xlK4me2mTQRZnWc98WMP3nbzXvPGxlZ+xIu3pqLxkZgCHm7aQDK2dSCSCxAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649457; c=relaxed/simple;
	bh=P7DS5YwItFUvOlaIEtnK+WtMDj98Qb+xU22KRCEUzK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLj9LiXuhPxiOgDx6Lyda9GZ4Hzs7R+ExM6wqV5v0KBdIOE2XtvWNb0zi8l4g1PmxFaLAMfQGf4FUgkiDnHP7629Kgftvq3yS05YCp/79xRnA0mUJG46GKkTPbHGhHgJ02+7oZzGNJsc6Z7Q3rZs5tK5QFsipInNtNr/5mNsdX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PymZmU4Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VxkD/YuL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLQZot000483;
	Wed, 23 Oct 2024 02:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sKRaTUqUyPOHs5naJXQEs7J0uZLLOhaLweUV+wHdP2E=; b=
	PymZmU4ZDlMP/GDTevhjeP3FcEf+1DibpOTjErAJCJKbfh4LgVqQk96ny7N4GbF3
	xi7IsQeRMCUaYMFs58mn5PZdTPLo/a5fzyyugMeWIGyUkdB3YzCYqumZavcsAy9x
	uEoaqaCXdncxvN+RlZsyEH1Eo4/7sFcZpf5c9/fzqXY30F/gleWiensjkH1bGWos
	ONU729kyFbNhBwKw3enMM7lum2+BtlTDK4A+2AEdcPgUcbBzM+A8TR0Jo4OSVdJ0
	EyusgruIZCA3n6G10QI+HNO1LDNTXiN5uC0sd4k7deejR2GBx/MNXvuHtWOmnWjQ
	ZYhBg95Q+ycFAgX3kB2I3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54574ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 02:10:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N12kAd025374;
	Wed, 23 Oct 2024 02:10:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh8wgyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 02:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw30PrlNILbQ/X0Mc0RjZiBc2aa2oVFe9wA4SK1BD5KrDfiJVL2H1BUB4PBtambm2AdGGqMRz2pGfSUNkxRHrfMnhdHf/0isA9VH0VEvf9CM4XBZmabT5AHWvXBPpnCEIEADgTQ9Kkxir2ls5brs4KWB1E196pmPLC8qwY/SLUhkVHCTol1xu2vLLrKOY9Rwrt5+5vkRbkR8dDFKTYHSM6zXy9HCOlrxWmnZmREQjzKeBSeQBv7PvRh/C9IghEofO1HNM0UskIXObYEMr2CLR9bK0niGS6aKSJ6ym97QQd74mO19TP+lZGWmgDzmZyXzafaedsQWQzRvY50/YjZ/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKRaTUqUyPOHs5naJXQEs7J0uZLLOhaLweUV+wHdP2E=;
 b=JpCcEjNTQJIrq5T/SAJ/vTdicjyPcVLGCaTIZpGJEumy2+TkY3m2usQjARjYvr6CLsmhrw5xDO0ij3rLCfuckkYgej9BOJhMQHhFRZiWFcr3LVoM6qD7jtGlyPsCPhI2JYuqKctxktXoXNGXUAPowHdbfU55iy3qzYd7AcbH0/IaDogWTDkyAWP6gboIWoDBuJ5M3sa/TImP93eGjcd4oOE8tnKsyAiJBjp5KDlzP4hI8dO+HfxCDWa8RgDydavPUTliGWoDGL4V2YPN4HUAbkaO65V6GivsvJmx8EcH+NI9Lo7YUmIqPpXFd2Q5axHQcH5xdOi8VRjDOFcZDJWcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKRaTUqUyPOHs5naJXQEs7J0uZLLOhaLweUV+wHdP2E=;
 b=VxkD/YuLvGpcOixutzGh1aRQK0BaEOPuNF9naQU25I0ZqfJHIRz6rtlKAz7w80U67xqUqD7RZ0CXH0RxyPIqjqER3f5b4ygj04Y1tgMLz1+EYOym2qWJuhcHLiv3SRGe7GlXsqkwLJ8w0TS2eGfMfrMBRA7DV9j9O4UEhuxbjtc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:10:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 02:10:21 +0000
Date: Tue, 22 Oct 2024 22:10:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v2 1/2] mm/mremap: Clean up vma_to_resize()
Message-ID: <k6s5l5ux44ioh7wwv5wqjiieufb7b67dmphxyrhbxqvxemlohx@rldpvyh4r5a5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Jeff Xu <jeffxu@chromium.org>
References: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
 <20241018174114.2871880-2-Liam.Howlett@oracle.com>
 <CAKbZUD3YLqWOyN7t8d9x3drJBJFSQw0O9dq7reY2p-gQ-wen5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKbZUD3YLqWOyN7t8d9x3drJBJFSQw0O9dq7reY2p-gQ-wen5Q@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0202.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: f4887906-38f7-4df2-cdf0-08dcf307d93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2NpWXBYei9TM2ZxM0JRQWg2ZXRwVXBMY2tDLzRkWlhnY2phRCs1N210UitN?=
 =?utf-8?B?WHdqTzEwbXpXbWJmSTlCMWZtUElncnlzOENHYkNXRE9kc21sQ0lLZTVmNk4v?=
 =?utf-8?B?YytzeXBHak9peXFVOFZXVjVhOTMzVmsvaTduZUtibmtUKzFUV3FySTFvOU8r?=
 =?utf-8?B?aGtHckFjZTJETC9sN0RNc0dncGFZQ0dQemU5U2tmTGlvdmRJb1dnWnJEMjVw?=
 =?utf-8?B?V21DTjhVN1VGT0pOVU1zaDNPWDVyZ2NIZnd2ZE1DRDllWmZwYm1MN3dlTWt0?=
 =?utf-8?B?ejBZUUpPTWo1WkZORUozclZQdHI1bi82Titsb3FXUk9YQU9lY0lMemxFTFNi?=
 =?utf-8?B?bCs2MWI1MXVBR25wR3RWb2FZOGdITW0xcnMwSGZ3ZTR6WHd0S1B3MWwvMHZ0?=
 =?utf-8?B?MUlRdVpOWmRHKzBiOGE4QkI0ZkpFVFh6VC95U2lkYnpmVkxsVDdjWEsxUVZU?=
 =?utf-8?B?eEZ0aVYyTzZTTnVuRVd4TEdYTDhEd0J6QmNOaFd5U1NoaVZhRFd2amZLc2Jp?=
 =?utf-8?B?cEhkbS9tbUZqL211TEd1UWdBT0dwTi93a2lweHpsbnlSTE5XTkltSTdaKzBk?=
 =?utf-8?B?cmRCenQrR3lqSFh5cjJVaFJITjRmOU5wYitIN2JUcGVZSkdTelFhY2tBV3JE?=
 =?utf-8?B?QUdoeXV4cThZRFZoWU9sVlJib0tvakgvUVBmcDVzSG5PbERuQmFSekNheW9G?=
 =?utf-8?B?eGREZTdXNmppcDlPa0J5M2Y1SVp5L0d3OWdTNUR4S0tnUXdsL1R0UnNXMWlr?=
 =?utf-8?B?K3RHMzV6bWoxSmhOSUN5YngvRzJMQXNlU0Z4RSt4MDk1TG55L0MrYkZhcnpy?=
 =?utf-8?B?SmpnME1keFduR1doSzJrK3pwMmIrU1pXOU1oTE5memI3eGVQeFdZMnJJemRp?=
 =?utf-8?B?TXdPTUN5Qll1dHFZblJhTDZIUzRRZ09HSm9nbVhsZnQ5Z1dUSW1LUkE2WHAx?=
 =?utf-8?B?ei9HaENTL2l0QVUyaGkzWk0yOTQ3U3JqVTR4Zk1SOE1UYzdvN05Vd0E5TjR4?=
 =?utf-8?B?SUxEY3RTQ2VaZ25Pd0l3c2Jaa3VMYzhSdTlZQ041Q1ZPbjVJTEduYzlOdGQ4?=
 =?utf-8?B?WVN2bEl3MW5qNklIMmFBbzdudGFaRFlENkNQU3Z4enJCKzFpYW53YytzbnJ0?=
 =?utf-8?B?Sjd1dm9laFp1cFlBaHV1WTJkbUNOQUcrZS9IQjFwYWFEamhHc3huaEFpOFE2?=
 =?utf-8?B?MmJFSGFJVDYzdnY1Rmh1alFTYVJTNWl2M3RncWxwRW1lcXpqNndkVG1YUHBa?=
 =?utf-8?B?dG42SmhlUXBWM01BVDlBL3NTdUlaSmN2ZFhuZnB5M1llVDMrcVdTREZCdzFS?=
 =?utf-8?B?emZ2WDBnVitZOUJkOER2VURIdjlZWXM0N1p0L21KWGtMZmtSSFFvanZrN3Va?=
 =?utf-8?B?SGtKZmdjOW1xalVLZ1ZqUE9uZ0RuMHg3Q0x4d0JEaEJuVmU1SU95b1FqOUNY?=
 =?utf-8?B?cDk1VlBmd0hTUHhYYjh1TVo4MDY5NGZocWI1bEprbXU0STNvRXRUTU1sN2h5?=
 =?utf-8?B?dE9TaWp4NlZ5VmVoVEJ5N1M3VWU0dU5Gdm1Ed3pueU9LUWhwaHRpSWpiVWha?=
 =?utf-8?B?OGJMcDZ6K3VRUnlNdjhJVDlJR293MDdNb21UUTdqc2plMnRRU3g2S1V6dGpv?=
 =?utf-8?B?dklFQUZZc0dXVHl4Y1BZVzJ2b09aZk5saUdnRUM3SGdxdlc4UFlhQjBXME8w?=
 =?utf-8?B?VVNBM0wvb3hqcGRrRXludVBBRlpOVmIxK2FOQlZkTG9OOTJ1amg2RUFmOVUv?=
 =?utf-8?Q?zCScHZEzVdIJiJmFP+SzXxHSTBVljkWmj7NxRkQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXhqcjN4VFEyNUl3QkVDaDhFN01jRnVYWmNNbnNpR2pyQnhMTTYrUXdFQjM2?=
 =?utf-8?B?SWNGdUxhblpiaStyYXhqTWYwcFBCMXZRUnF5c3RDdElLbW9TMWsxMTV6dXdN?=
 =?utf-8?B?ajNBM3RCcEFpQ2hPTytubDRxNmJPVmI3VjlkNCtqZlJ4TFo2N0NtRjRITUdB?=
 =?utf-8?B?ck05Y0tsQWk1akcxTHAyWE82b3Y3Rmh2QmFyeXVmQVlySEpCZ1ZUV0xUWUln?=
 =?utf-8?B?ZXZuNmlZZzlnalppSjUzR2dLQkxabFpHR3VVcG9RTTRhYzRXUTdmY25hN1dp?=
 =?utf-8?B?ZW9mVVErK1JtMUtZb3ZZMWd1VHFNelRrek9ZNkFMWjY3THBCZnI0OThZT09X?=
 =?utf-8?B?SG5tdFpGZS9RK0dzbUZnajRWamlxWUFKQm01VkdobzZBZllPMENKRGYwUWcv?=
 =?utf-8?B?NXRCR0Radm80SDVmY09ldmNTS1BHY1pPeWFYT2ZlWmVrVzRySkxNK052d3F4?=
 =?utf-8?B?d281emRJeDdtcmRoaGRrbHhoQ2JHMFRXeW9zQUYxMWdkZ1RNbWgxbmx3WjN5?=
 =?utf-8?B?MFZHRStUalNPSjhhLzM1Uzk4R0xnZkFBSzZNT1czTEI0L3UzYnhUQ1dEYnZt?=
 =?utf-8?B?TnNQU0FTWmNvV2RnajBFckhFVSs3K3RvMEErRmlzTFpReW8xc0g5dlNhWmVS?=
 =?utf-8?B?QjMvM2UzdFBscUgzTVhnbnN6RERKNHQ4YlNodFNQSi9oRUJqWE5FWVZhZngw?=
 =?utf-8?B?czZXSzJuQmo0RWxVY2YyRlRjWVZ4dzFqajJVQ2ZQR2lzK1grYzIzTjJFekZz?=
 =?utf-8?B?YjhqdVU5Z1JEcncwSC93cFJaeWM3OG5oOStBLzVtNzlxMlFML0QrZXo2eE03?=
 =?utf-8?B?R3ZZVHFzNmVkbTZBUXBjcnFVUk1CTC9BNm1kVzcrNDhXMFpFcVJsREpTemt2?=
 =?utf-8?B?WkJIZTZucnFWdElmdzlHTmxXUXJMTkhjc3hVMm9JajgzNDhraWdneWNDVkM3?=
 =?utf-8?B?VnkyNTdBUGRrbi83MGE4R0lJUkNpaUY0bmI1VzdRTVloSUdybEhDMXN0bmJ5?=
 =?utf-8?B?Q3hjTWRFc0pOdFh5aE9ORDIwT1hmaThWOHM2aVV4dFlEMGo3c1dZYWViYmhO?=
 =?utf-8?B?c0xuV29CenByczdiaXkxUDJSSzNKTldqQjJmTjhndkhyckszWTh2K0hCRHla?=
 =?utf-8?B?MzlRWndiT0pyQUJ5ZGJPbXlxMjd5blQ0MlZmdlF6ZWtpTWswRWl2MFQ3c3Jr?=
 =?utf-8?B?bUZFWkdOZnVBQXNIQnhGV1NrRGpDek5MSjVuQWlpREt2WWpKWTRmRVRNczhx?=
 =?utf-8?B?Z3BjYzBJNng1a0k2Q2dVbU9CTTBsWGtnNEdUemZRZVlKMC9POFhVUnh2MkhZ?=
 =?utf-8?B?Wmd0Sk8rK1JacE5QY3R0dEFZR0dGQUtBREtFa2dPTHU5NjBOWmUyUTRvbVg2?=
 =?utf-8?B?cFpOM0ExYWcxajFGL1J5YXozaVU0clFIc0VCRFNoZnl1RUROUHZnQm5CZ1hH?=
 =?utf-8?B?U2dka0tCR2RSY1lwS3gzYXdvUWF4OStucENKYU4vMlVYOGI1MnNkMUhJY1FN?=
 =?utf-8?B?bkpKL3IzWUM5QmdtOEhHWUQ0MUVQSGc3N3A5UDZTQU90OUVvc1BRZVZXZUtn?=
 =?utf-8?B?SUFFc3dwWmhtUkV4UXhVdElLbXBxNHh4T2JLMTBmZnFpYTRQNUJBaHdnbyt1?=
 =?utf-8?B?NmdNSC9hU1pWeFlVSllUUTdtcnBaVGMyckxrRThla3VEUFNoR3hOYWFTVzRY?=
 =?utf-8?B?Y2ZPQkkwWVhoTFkxeW8xSG93dGp2ekhtN3F0eHpsd2ZxMlh5VXVHMHo3ak9i?=
 =?utf-8?B?ekF2YUxZZnpvZWg5VDNjWHZLMXhxY1lMbkRsT1hYV0RoS0RvUEhXcCtNeWtZ?=
 =?utf-8?B?NWE2dUZZcXBDYUtxaVc2NmoycWlvSmFRNHB1WFhZMjMxR2NJd1ZSRDUwelJh?=
 =?utf-8?B?ai9jR2pZZWVVRGcyRFZhN3JocnFXbHZ6WHhZSXN1M2NiODZLMkRoMU1nNktr?=
 =?utf-8?B?QkllS1JVYzdSR09mY2tMSCtDSzJ2M1Jha3cvbkIrcWRCV053Si9kNW10ZEpP?=
 =?utf-8?B?OFlrc0drby9pWHVnNDRKYTBBRXJqSUtHK1gvakJ0TERqVVlUTkRPUEZnTzBN?=
 =?utf-8?B?UCs1aVllTFpiekJZTE1wSXBjaDJKcVNHZjBGbmh1TFo4SXFENTQvOWxuMXVz?=
 =?utf-8?Q?aELIYcaIu8/XC+nO3h7z046BH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JCNyVoatr5cuydcrl77Fo+Ob4Fo5t/ec21WDLLuPn8NOvmOyA2xm7UedjtYpA2Rvwh+nti89lIUGPswp6dOtELlN/tIyBgJjqQwzvBxYvRwNLs1Ex761vzhJZ3nbd5ei5K9KtfZf6dtGuAk6YazP5iG9K8tMjPDMgBNl7jszIyYAptAnlrE8AZRc0gdLGRgrqY8MWQ+bVh0TiW1wiHUzBa+l6hxxVOpxnOnN7Lfsvg9ywh86zhqdSUiNYcnNGnwYeSe92RUu7uLKrKFeQMTfnHVlkJbjVtwla2ke4c9wmyAIuZ6UGxmJKDA/kc/UA0XTslkLgYWebrICgOpYreexIMhKQpPECgSsf/A3vbddEBsPoRL86s5PwDQTNVt4gfFvbfw71Yb+ioPCSLT6cnaXdYwT0JJqzD1Fs7V0oQJApZRLiNndPyqsUehzC2Ei1Q2jKubR9vRaBS2OXhGV/OHGakZntGWfCjx6oLhzYpvNe8Sl4UMhi2e9vcgi5inMqK+JUuGXqc3YlxmvUCZPNF0d+3MXU6sU1/zE9mzlO7ooYbJtESjCNxO2Zx9zFnX+oNlGFNPgP7V2ekk86h656dHR3TnaJMcQJ0JHqYIkleHGKic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4887906-38f7-4df2-cdf0-08dcf307d93d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:10:21.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M3Fe5ktpIRVm7IyKZWdFHbngrdydWERwWKDnwOMKdtAMaeG4VYDA9lZPFPq8bQeLLBhWH6Rwr8jFKYUf2mPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_01,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=885 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230011
X-Proofpoint-ORIG-GUID: 9aguvgZEoyz2g6k5BfqYsD3j7vcLcpOU
X-Proofpoint-GUID: 9aguvgZEoyz2g6k5BfqYsD3j7vcLcpOU

* Pedro Falcato <pedro.falcato@gmail.com> [241022 18:08]:
> On Fri, Oct 18, 2024 at 6:41=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > vma_to_resize() is used in two locations to find and validate the vma
> > for the mremap location.  One of the two locations already has the vma,
> > which is then re-found to validate the same vma.
> >
> > This code can be simplified by moving the vma_lookup() from
> > vma_to_resize() to mremap_to() and changing the return type to an int
> > error.
> >
> > Since the function now just validates the vma, the function is renamed
> > to resize_is_valid() to better reflect what it is doing.
>=20
> Small nit: Could we pick a stable naming scheme?
> I understand the kernel has historically had plenty of ways to name
> functions, including
> do_stuff
> is_stuff
> stuff_do
> stuff_is
>=20
> I thought we were starting to converge into vma_/vmi_/vms_ :(
> I would personally prefer vma_resize_is_valid/vma_resize_valid (even
> if it's a static function, so it doesn't matter _too_ much).
> Anyway, enough bikeshedding...

Right.  Usually the vma_/vmi_/vms_ stuff indicates the first argument to
the functions exposed to other files.  Yes, vma_ would work here, and I
don't really mind that it's static and has the vma_ name.

I'd suggest relocating it to vma.c or vma.h, but then we'd have to put
mremap in the name and that would be rather long - I don't think we do
anything like this elsewhere.

>=20
> >
> > This commit also adds documentation about the function.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Reviewed-by: Pedro Falcato <pedro.falcato@gmail.com>

Thanks!

>=20
> This patch made me realize there's a couple of small improvements we
> can still do (maybe with a vmi) to clean up and speed up mremap (at
> least!). I'll look into those if I find some time.

Agreed.  If you do get to doing more clean up, I'd be fine with a rename
of this function.

Regards,
Liam

