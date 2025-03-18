Return-Path: <linux-kernel+bounces-565981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BADFA671BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD2D3ACDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD62080EC;
	Tue, 18 Mar 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ieq5Urli"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615BEAC6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294751; cv=fail; b=dPaADKPoF+HVtKD8pZOWQEraB5huLgxrWgQq9g26/ugWnG5sXGzZWV/wCEQAKeyyaW4zq5PzC4a6TUOFIFqL0GvT8k4qhzDh+RfFKnQRm1RGOfrbtpzC8rOYhLWYAYGxvKmGNTTlNhGkwDnohTa9Siey4XBYyijFqlnldVeiZ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294751; c=relaxed/simple;
	bh=DVZ7OvZQepVlggy27oPH4F934uNwQjYoZhu5hyYJIyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ecB/qXILrndAAyATA12ozN+DnFa399hfZxx0/JPj9pINcY4rCYHOTGKRxxk1PjdvxGItRz11sySS3tY1MtlbSbOxwmrNKzoN7Ka+/rJoYRkWarzlEoD1tAMQfHrRrI/WxoChUtJ/CaYoPsdME2MjIcYvrAUphn1JmnNYKWKTNPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ieq5Urli; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un1W/6+4LM4uadYAFUX6kq08m+zrtn68chuYzrH0O0LePbuJhXO9givYNFWtfLFycfFGk9kX+uToem6JYbaXI/bv23xp6Jk5Z+fgidqcAAoSy6OjYppO84wF7KyQuBSpI0j0Z2XHSYkmqIiVKQ/i8xwU3dMvWScfXs3LetCfqfiKnqtXFJNVLL6gBdVXfv4znyam1TgesxQCKN6CNM58tnLuJVF7UfbS/pRtJagEE1adQaIcjciPuyGiYBI7+x5AEHY63NcU254pc7gavLopWcxA1K6P0yhLA1oAzvHjV14AyBNQT9WiBDOkic6Og83ACNKtbqJQDiyemWyqOMyiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rcej1GKRzGi4u50GoUtUJMedxCDnGi+2IPmkQwDfX4=;
 b=et/yLoMfduC/FG1ZWtJMxa9LctChIRkA20IFbMUpa6EpooQTexORiymr2avsv302ZxA1f2QkMZLXVN/S/PpJE3JjaSLBQqcpngfsVyrUy5r9rwtQduE0xlKmq7HZ4H2E9WQBOQ2A847S3RUzHa/MhtNaEVAX1y4Q9jLkU9iISBODqqw097LUWzrzMv3trk5t0I4r6sUhbsEvAIdoggT/+CgZk6oZOFPfzaHF4yQc5wv2LW9jxgxbEdXo/VRyN5727XxF/owu1EyppLT9D/4qHDSpRa6tdCU6U8AwJAXPQmTKn21Tz+tTuHuK0l2aFSU/DN/V6GLXwXp1UVgG/Cczgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rcej1GKRzGi4u50GoUtUJMedxCDnGi+2IPmkQwDfX4=;
 b=Ieq5Urli1sglQ8JQARCNav8++NakMkLGYAXDuYiZfqxYNmgV7aJ9lij7xe0HGPipGk86QKixwjrJJS3TsHu6fvFP3Ez2DDB8HKqlugsE5HyEbF0XzWAGCU5+ytIHA1O1vbSEVP2oTDanA5ZuXqYp7WZzfs/ZVjnYU3kROW/SaDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:45:47 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:45:46 +0000
Message-ID: <f9f9a61f-6798-42f4-a09e-dcdf54e0a649@amd.com>
Date: Tue, 18 Mar 2025 16:15:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot
 pages
To: SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, vbabka@suse.cz,
 weixugc@google.com, willy@infradead.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, dave@stgolabs.net, yuanchu@google.com, hyeonggon.yoo@sk.com,
 Harry Yoo <harry.yoo@oracle.com>
References: <20250316220034.38121-1-sj@kernel.org>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20250316220034.38121-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 6921dd1f-410d-4217-a750-08dd660a09ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enpiT1pGTjY4dC9NemlGQTVoZXpsWHpUOEJPZU9ncER1Mk5PUFdma1FxY2lF?=
 =?utf-8?B?Tzd4SDgvVmk0WjJ2STczbWFrcUJoWXpJaUphcGlEbUVxSCtUbnlsdkkyT1Rm?=
 =?utf-8?B?b2FoU3FSTW5ZNkptRGpKeFVSNjRpZGN1Sy9rd2U0ekE2bDJXUVlNT05SSGQv?=
 =?utf-8?B?cHI5c0dIZUdWMk1jUjNCVmF6S1JEQnRTSHAvSEZxTTVVOWQ0azB2SGd0U1J6?=
 =?utf-8?B?UDZDWXpUMFFFZnVtTU8rTXF3a1J2N0FTNDdmcTAvTEZzNjBZNDh2UnFEckpL?=
 =?utf-8?B?dy92N1lHbExxUFRRWmlXcUJ6YzBCY0NRUmtwSEMwcmJkSkM1OEtpMWVJTnNM?=
 =?utf-8?B?TFE0RkNWbjN0UkhIU3JXNWR4SjdEQVRlU0t5SWlsU0d5emNqSlQ0M25LbCs1?=
 =?utf-8?B?bU9mcGdTYXR6dnljeEcwTGtpTlVkdit6MmlPNEd1YjFmZzYxQ1hXS1hZWWUy?=
 =?utf-8?B?UExMclVvd1JIbTNhMTk1Z0wrbC81WUlNY0dYSFUvY1Iybi9rOThkUnRua2M4?=
 =?utf-8?B?blEwVVg5Y1VKdXl2NmovUmhER2ZKaDB0YmdXRWs2YzFDUTBsLzI0anJ2YXZ1?=
 =?utf-8?B?MFBCb3k2MkcyS3VNcjM3Zm1WV0g3U0NYU0FzcXZNZjBlTmdvSU0zemZoUXpq?=
 =?utf-8?B?Um1sOE82MmhJVWoxenEydEhCaXZianM2VzZ5TUtoUlFvOUwwRml5aW04WUIx?=
 =?utf-8?B?a25udzZHaVZyWDc2dHNYUEhSSitpOVU4QTRaMHZMT2NnSldvVDd6cUZ4NXgr?=
 =?utf-8?B?MHluWTYybFd4cGdad3dvS0JoYURJNlB2eTJBWGNsWTdxWWxqOGQwZEQyVGNH?=
 =?utf-8?B?REhVdHB2Q2xVNkJkQ29GNGxzWEt5Rm8zbXo4L1RlSG05Y21XREprZHJab3hC?=
 =?utf-8?B?WTZRLzRJZzRteWcySFFmNWZNYXgySS9YOE81VzRFYmt5Z0NtRGN4TEdjbkN4?=
 =?utf-8?B?ZTNHU0l3Vmpub1huVUV5dnY5SVhVa1hTTUxXTi9ZNWFEdlpvbEdtdlo5VU5j?=
 =?utf-8?B?YU0vMkRiR1ZCUGN6bThNQVBrU051Rk92TDB5aWNyK2hKN2tobWI5TGlUQjZ2?=
 =?utf-8?B?cGFUK2VORzk5ZDFERWVyMUNDVXZ3K2pnTTRvTkpmelAvZzlwbWlLZDdwQklr?=
 =?utf-8?B?WjZDdHdIWDdQR0lSQ1Z6cnRjTmIxZzZrWG1GbVlkQTBJVUpqaTJZSG1vclA5?=
 =?utf-8?B?VXpMQmFrQ0paL2FFOCt1ODBrZUlTUFhpNXM3Z04ySnRhcWR3WE9DVzlWZGhv?=
 =?utf-8?B?K2JlSVpKQ0N2ZEZIR0MzS2x3MFk4WmtPYnRORzlVanpHRE5RT2VrY3cybWFN?=
 =?utf-8?B?Z3JaZVVpd0tXL2h5V0owaFg0ei9xTFpLSGV6RFFQYUw4QzNWaFZSeEt1Wk5s?=
 =?utf-8?B?b0g1SGZKeGZRanRwUTZ5VnI2REYrazdtb2oxMTJRdU9LSzZ6U1hGWTFwbGxl?=
 =?utf-8?B?aElkUDA5SnFSRlF5bVJibFc2SlRwb3ViTXRTR2dsdklrUEQxYWFvK29heHRX?=
 =?utf-8?B?c2JIdStMTHRyNXFXWTFlTEYyTU5KdzFXdk1Nd290STlxSTJTWjhyRnNRbXpw?=
 =?utf-8?B?QVo5aUZ0REtmVVU3UDRpTkpXYjVPUG9MTFZGa0N6dmpieWthRnlOU294ZXRo?=
 =?utf-8?B?VkVXeTVzMGR4M3kyZHFIL1dER2poRVY4R2NhMU9kYTFab2dnTGYzMDJOT21T?=
 =?utf-8?B?QVRMUjBuNitUWEc0MGFac0RVZGoxeEtqeGE3T0FjOFFhUFRtWUw3V3B5cklR?=
 =?utf-8?B?OWJQU0VwcUxpMGxaRm00VjROcHdhMU9OMm5PamI5UGpMRFdDQmRTYnY0MGE3?=
 =?utf-8?B?MDNRMjlOektWVndBbkF3RUV3V0ExZ2h3c1M0WWlOOGNFYkRiU2poWmJ1emNW?=
 =?utf-8?Q?L49XueiHSHSFF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTlZMDR5cXZ3RFRqMFU2UWpIaEw0R3pUU3NBQ0NVNUZUNTh1bm90czBMVXJl?=
 =?utf-8?B?OXo2VzAzZUxJb09kOVVHTHJ0RFpENm9BRTlDRWhNTzlmTTVyYm9VbXkwakZl?=
 =?utf-8?B?RDNvOUNWdmIrczdlczRaMGhUS3A2eXFDTm14QTlHOTBiSXR2dGJWQVpsUXJS?=
 =?utf-8?B?QVBhRnZxQlcya2FJcExnN2EyME1QZWVnRWl0M21pcUp2MUg4SENPR0JJSG9v?=
 =?utf-8?B?OWhlMG42SEdHbXk3VmpDVUZHaTZBOHlmVjl0VUtqVC9RMklCeHdCTXAxbTdk?=
 =?utf-8?B?QWZBb1l3blNNWVRDNjBSOEJRdUFlR2FVZGxQakIraWNwODNxWDBrbENEOFRm?=
 =?utf-8?B?RDRBeWo4VHNDbHVVWUl4QlFROXgyLzVPajJLM3B3M3FlSWFva3U2emdQQTFi?=
 =?utf-8?B?WGVnVE51QW5IUDdpc1RyNVJULzhESkFyK3pSVTl1NUxobU0zZlloVnN5TFVG?=
 =?utf-8?B?bVlvcFM2TWo5YXlXbHBRWFJacmpuVS9UZmV0TEt1U0N5Zlp5dFg4a1BoV1A5?=
 =?utf-8?B?ejYzRDkraHdYcStPeFFBaUJXZjh6RVJzOHI3eVg3VG5kVkNIVldYbVhDaURS?=
 =?utf-8?B?WGZtOVZzY0JwWmlmajZFQWVGS0pFWkRKcyt5MG5aVUVHRTNKYVFqaVFXVmJ6?=
 =?utf-8?B?TXJyUDg4Kys1alJmeXRiZkpEMnBIUnBSY1NQM3NJMHNZcmdLWjZVRzBLc2M1?=
 =?utf-8?B?UWpmUHFzWVM1UjYwNWtwZ3lEbmR5dE1EdnZWRlY4aU54NDJkUUlScUhMaXR1?=
 =?utf-8?B?cDZwamE1WisvZVVSSFpFeUk2dXJFRDgrZ3VIVWprYnlRZU5NTEN5SDhaUVpk?=
 =?utf-8?B?aE5PNks1ZUdyajFhQXB0ZGMzTWlBQXNHS2tzU2taZTVCVlRBVGV6M0xMY0dW?=
 =?utf-8?B?WUpqNjl0QlBCVHM2R0NQSjd1Z0JOSzF2QXIwRm9PTkhHYzVRTXVWbitZMTBK?=
 =?utf-8?B?aUlXWW9HcHd5aGNmWC90VmNpUkhSVU5GR3R4N1VoUTRscFQ3UVlJVW1IWVZN?=
 =?utf-8?B?dVNBQ1A5WDB3cEU1OGtwY05ZV0F6bmxZYkg5cVJIc1MwaHVvOUthWk9uNUR4?=
 =?utf-8?B?NGg4R2dmVS9IUCtWOGl0cGZUTUtXVmN5bEhlS2dRWW1OQk5ablZZbmJUUGky?=
 =?utf-8?B?dElEQ2ZaUzU2WlpKek8vOWd1dU40Z0Q1c1lXSUFPWlJJZ0JqL1ZVUUI3bHZh?=
 =?utf-8?B?bnNFSWZXQ1JCVURWVzk2eE5qdEJRRVJ4MU9tMUNjZzhSK0NZVVZqZ1R5a0ls?=
 =?utf-8?B?djVvTm1HT3hwcEdwQnY3RHJ0U1dLakhtRWlDSHJ4VmRxMFJPUjBLMVZZc2Rj?=
 =?utf-8?B?RDk2NEZTbEh2MWg0ajNSZk50UmlTdThWWkhRUFFGb0tkYmZpSFgxNWozRHBJ?=
 =?utf-8?B?Ti9rV05PdXM0RkEzTVo5cE9ZM0JhQU1VSU1mRDdtdWlXVnBrR2FDWUE5bWVa?=
 =?utf-8?B?Vy9oRmpVc0pleGR2dnJUY1lXN0RWU3JlVlA0VTdMNTN0WFhwZVFVVVhtS0pU?=
 =?utf-8?B?YTZycVZtNzBlM3hCOHFKVE5wYmY5dU9OU013NHg1YW9NV1dZRW5IS2E0dXhi?=
 =?utf-8?B?UlBDcWRJRHAyYzA3SkJMN05Cc3Noc2plbHRIZkJrZzJCVVIzWnozaCtRSHB1?=
 =?utf-8?B?YzVESEZCNzIvY3VCNVRkc1NQc3dINFRXcFprTFpyb0xyVzFIWVZhczRWOXFm?=
 =?utf-8?B?aHZ6S1lDdjJ5UWlWSTZSeDR3eGJIWmpYVWdCT3hCK3ZZNHBxT1RBd1VFR2RE?=
 =?utf-8?B?WmZxa2dEcW51NE5IQW1KWU1HcEMyYlU5ZDMvUUNydWVicmhFY3lKNmlGZk1m?=
 =?utf-8?B?c1gweW9WeXp6QXQzRzJOa2F6WW9iMWhrdnpjbUVydE5kK2QwMVFUY2ltYWFT?=
 =?utf-8?B?VTc2ZXRrQkI3bWRqOVkrd0tkNjN0K0wrTzFTNzFiT2YzMWNKd2lQTUN4M1dO?=
 =?utf-8?B?ZGhXWm9DWmFBUXpwRTI2dS9Lelc4MUZ0WEJDOXdnd012dXBEL1dYRWN2TFEy?=
 =?utf-8?B?QnVxcGRyamxoaW9KWTBjYzhkRmpXZ0dqeDFpRDE1Y2JDMzNZbkFTVE9FUFZ3?=
 =?utf-8?B?cGRSWENheGc1azJlc2pkUkkzNUg4azVZRmI4NUFydklKZWswa0Z3d2RWOWww?=
 =?utf-8?Q?gZsOrZpPkELeVASpAb26tLqpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6921dd1f-410d-4217-a750-08dd660a09ea
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:45:46.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8iU4wCOSiHRpus6o60vzizDadoL9Mp108kqpVZHWOVHpXvfrGwklUwyk+HdT7sq/ic6T2tl3EY0plEKY+Swdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

Hi SJ,

Thanks for your detailed points and this surely sets up a good context 
for discussion in LSFMM.

Please see my replies to a few of your questions below:

On 17-Mar-25 3:30 AM, SeongJae Park wrote:
>>
>> Currently I have added AMD IBS driver as one source that provides
>> page access information as an example. This driver feeds info to
>> kpromoted in this RFC patchset. More sources were discussed in a
>> similar context here at [1].
> 
> I was imagining how I would be able to do this with DAMON via operations set
> layer interface.  And I find thee current interface is not very optimized for
> AMD IBS like sources that catches the access on the line.  That is, in a way,
> we could say AMD IBS like primitives as push-oriented, while page tables'
> accessed bits information are pull-oriented.  DAMON operations set layer
> interface is easier to be used in pull-oriented case.  I don't think it cannot
> be used for push-oriented case, but definitely the interface would better to be
> more optimized for the use case.
> 
> I'm curious if you also tried doing this by extending DAMON, and if some hidden
> problems you found.

I remember discussing this with you during DAMON BoF in one of the 
earlier LPC events, but I didn't get to try it. Guess now is the time :-)

I see the challenge with the current DAMON interfaces to integrate IBS 
provided access info. If you check my IBS driver, I store the incoming 
access info from IBS into per-cpu buffers before pushing them on to the 
subsystem that act on them. I would think pull-based DAMON interfaces 
can consume those buffered samples rather than IBS pushing samples into 
DAMON. But I am yet to get clarity on how to honor the region based 
sampling that is inherent to DAMON's functioning. May be only using 
samples that are of interest to the region being tracked could be one way.

> 
>>
>> This is just an early attempt to check what it takes to maintain
>> a single source of page hotness info and also separate hot page
>> detection mechanisms from the promotion mechanism. There are too
>> many open ends right now and I have listed a few of them below.
>>
>> - The API that is provided to register memory access expects
>>    the PFN, NID and time of access at the minimum. This is
>>    described more in patch 2/4. This API currently can be called
>>    only from contexts that allow sleeping and hence this rules
>>    out using it from PTE scanning paths. The API needs to be
>>    more flexible with respect to this.
>> - Some sources like PTE A bit scanning can't provide the precise
>>    time of access or the NID that is accessing the page. The latter
>>    has been an open problem to which I haven't come across a good
>>    and acceptable solution.
> 
> Agree.  PTE A bit scanning could be useful in many cases, but not every case.
> There was an RFC patchset[7] that extends DAMON for NID.  I'm planning to do
> that again using DAMON operations layer interface.  My current plan is to
> implement the prototype using prot_none page faults, and later extend for AMD
> IBS like h/w features.  Hopefully I will share a prototype or at least more
> detailed idea on LSFMMBPF 2025.
> 
>> - The way the hot page information is maintained is pretty
>>    primitive right now. Ideally we would like to store hotness info
>>    in such a way that it should be easily possible to lookup say N
>>    most hot pages.
> 
> DAMON provides a feature for lookup of N most hotpages, namely DAMOS quotas'
> access pattern based regions prioritization[5].
> 
>> - If PTE A bit scanners are considered as hotness sources, we will
>>    be bombarded with accesses. Do we want to accomodate all those
>>    accesses or just go with hotness info for fixed number of pages
>>    (possibly as a ratio of lower tier memory capacity)?
> 
> I understand you're saying about memory space overhead.  Correct me if I'm
> wrong, please.

Correct and also the overhead of managing so much data. What I see is 
that if I start pushing all the access info obtained from LRU pgtable 
scanning, kpromoted would end up spending a lot of time in operations 
like lookup, walking the list of hot pages etc.

So may be it would be better to do some sort of early processing and/or 
filtering at the hotness source level itself before letting 
kpromoted-like subsystems to do further tracking and action.

> 
> Isn't same issue exists for current implementation of the sampling frequency is
> high, and/or aggregation window is long?
> 
> To me, hence, this looks like not a problem of the information source, but how
> to maintain the information.  Current implementation maintains it per page, so
> I think the problem is inherent.

Well yes, but we the goal could be do better than NUMAB=2 which does 
per-page level tracking.

> 
> DAMON maintains the information in region abstraction that can save multiple
> pages with one data structure.  The maximum number of regions can be set by
> users, so the space overhead can be controlled.

The granularity of tracking - per-page vs range/region is a topic of 
discussion I suppose.

Regards,
Bharata.

