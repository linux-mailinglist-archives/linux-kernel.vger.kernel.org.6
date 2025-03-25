Return-Path: <linux-kernel+bounces-575237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA4A6FA30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472B616C3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42514256C6E;
	Tue, 25 Mar 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E8wAYQlp"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB82566DE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903817; cv=fail; b=Ntyw2067AjEKFYI+hCcjAoZPMdvARSswukQ6PSlhhuVv+C8UyFlJjvMunvAXAebjc45d8mzAU+lod48cw+iJaqRPMDQ1ttH/zwtKnu0e76RSvF9WUtURLM6UiaKFW0c4XUhuZb7DqofrgTLEFCM9ACQ3No5r3cTTAw3356EYefM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903817; c=relaxed/simple;
	bh=lwntRhOL8Uzac7RftXewZYxfo4hwuFaRTQkBht3ldtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgRrdJLFKmGtUfklgNX5r2I+RfMJ5qWKpoWJ1EslQPEqixn34b12ynmPdiIgBQ6Kvt1SP+QQoCAR+NKlBqirI7Zwlg4G+HVR/cUmxHZSRlwerUzCw37mcaamMFTN1vDiFqxGO1zg4R2Pj68aSd4dr3UIEFe6FeeDrtf5F7o1tE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E8wAYQlp; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NogWI5aflXY2v5KQOFPTrysqDW2InvneT93DwWpL22J+Ek4xEGkzISj49ukUa3oQp37zvsjBYVJ8mmIYszsJpc8zYCJPo3sZFXIp0sUQEJB8AwFEHalSf1SYBrdcYYzmFSmvJELLTz8TpYS1p3OxXXc1mENjTNSCorOMwpcE+oGkLBy1p+Gk4ngy6Dr/MbWzN4TDWWpj62dmGCZuFUFgUBty29VK/z6b5kuZTDLNpW/kLFo7K6zUGr+Xpo3KZnsjlXiV9ESB3HeqcN9JP7UM/NCQ5+JDnQ6M9fGGzGufbzcPviMiNMPFJW6mvzuMEzDSrJ61NUDv70KOq9/Eo4nPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA1I8agSP3myuOz8vRPR+eENC00wGUf0UtMFPZaYjgM=;
 b=d2sWmixx4qv6fP1y6derj6Eg0couWQnfWFeF7hoNXsF2l4Y7F5ph9sDyGSg+teCkFV4XClkFcF1Az7y04f9vhqgoQCmTMdScZeGMNZ9dZQ98OW+eQHFjqtqY/x03Peo7reCdx2pxZ3F/DPYKAsP1jbfjMN9bATsBbIjCMakbdr/fnJtzLkEzujKi6MfW4BeNIPxqE1kwijNcXdLOYWjLgU08iYm+pWhIDX/5kHft2DNIahipKvvVToUwIJRCBwOdEylThlkTEmryGfDqCmJk2Yicz9yzsy2w+rTMaB+Zs3IjzTlTGaCTxJPb/RULxtCudWAqK9Vhku8Zt4zfsgMhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA1I8agSP3myuOz8vRPR+eENC00wGUf0UtMFPZaYjgM=;
 b=E8wAYQlpxG9vLeoRTmjqJjG7R5ADD+o0M89GdZCh5qflZsgXplJw60aM2G3iM8ovqtuud/oZS+iITPRww8PAnSKmYM8TMNNpcvuwYjStuAjsQnHqvLiNVFix/IXClbF9b+8iIaQoCSCnFXj939K+3df/WqyWHuktGNxhPX/vS1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 11:56:53 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 11:56:52 +0000
Message-ID: <fc15a9e2-b771-4357-b724-2c3ce95d86a1@amd.com>
Date: Tue, 25 Mar 2025 17:26:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] mm: multi-gen LRU scanning for page promotion
To: Kinsey Ho <kinseyho@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: yuanchu@google.com, AneeshKumar.KizhakeVeetil@arm.com,
 Hasan.Maruf@amd.com, Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
 akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 k.shutemov@gmail.com, kbusch@meta.com, kmanaouil.dev@gmail.com,
 leesuyeon0506@gmail.com, leillc@google.com, liam.howlett@oracle.com,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
 riel@surriel.com, rientjes@google.com, rppt@kernel.org, shivankg@amd.com,
 shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz, weixugc@google.com,
 willy@infradead.org, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 dave@stgolabs.net
References: <20250324220301.1273038-1-kinseyho@google.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20250324220301.1273038-1-kinseyho@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: f477e128-7b59-4171-1fa6-08dd6b9421ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am05NnpFOC91dk1Xb0plb0FKK3lNa3l1S2hlUFI2NlRYeG56NnByRms2Z0tj?=
 =?utf-8?B?ZW4wV2xDR1ZJTE1vRjdiVEwvN0RRK1A1WVYyeG03bnY3NmlEY0I5VVlrWEhi?=
 =?utf-8?B?RkxrSGlYTjQ2dmxQU1Z3b2x6cG1FMmJFQUZ5WWYxR1lpM2Y1VjhnV0FMb2to?=
 =?utf-8?B?czV0VXBiblhGbXFLdkdodmNkQzBRUjc5ZEtQMERiekhNYjlIOXR0WlJHcWlB?=
 =?utf-8?B?RGt3YVIrazZwblM3RkJKOGZjRXYwWnRiKzdIMDFOREsrUWhDUllwV2RERmR0?=
 =?utf-8?B?dW5nMW9wd2ZGcFRLWkpUWFJDNURmV05WTWpRa1duZjBhOHZRZGNEcjNmTGFm?=
 =?utf-8?B?TWppcGRkVGpIN0VTZWhzS0xNdTZyd0FQUWpKQlRGVWpERVpNQ1d4b0U5eHVx?=
 =?utf-8?B?S1BVVkRFQjNGUXNJK3NLQ3Z5WlBvOWxpZzkzbTlNTFhyKzRKZzVPa0drNlRR?=
 =?utf-8?B?SzU5MU1YS0JVUmUwMDQ3ZTRrNHdaYjJkV2xnMXJmK2hsTWVCc3lyVHBGdWdS?=
 =?utf-8?B?TENDdFBWUWVNRGlSVU1IRURGUFpvYUNGOURFVkJJejhhVnBCT1VuMURpV3k0?=
 =?utf-8?B?LzVhT1VDQWtzN3hEck1wMXl6OWM3Q0UvTWpXM1pyTE1Rek02MUxrYTZsUmlC?=
 =?utf-8?B?QnIxaUpicWJwWmhodk92SXZDSkVjRTM2alIzekg0TnRDLytQTjdwWDY0N1Y0?=
 =?utf-8?B?cUcwZC9oellSdmhrSGg1bWFWbm5oS1AwTnRTYm56Wnlselp1RHNnM0V5Ungr?=
 =?utf-8?B?OFVhMXdTTS9NWDdPa0s0L2dIZ1ZPZGtQbFlWU1Erako1VkJnNUE0THJ1WHN5?=
 =?utf-8?B?Z0wvb29iRVB0RnNlV2p3RVVsRU01TkEvNVBrOG12dEFNMUdLV013UEdaQWQv?=
 =?utf-8?B?d1FtY0tGRGZ6azVNSmpncWVnUTBjSkdteHVWSFJNUVUycnBJb1RMS3lRTGpP?=
 =?utf-8?B?YUtDV0l1SFIrdnlndXJ1MXFnRklGKythY1NrOGJZMUl0Skw5S0JQRGdmSmt2?=
 =?utf-8?B?WEZDUjl5Y2RYbE1LOEdBVnRVenRhYVE1M2dzTkU0QWdGeWlRWjR5V1VLM0pW?=
 =?utf-8?B?OUdYRU16NjlrU2dpTVUxNGoyMkFXMm0zY3VYZnVmcEJtWlgxempXc3NtY1U2?=
 =?utf-8?B?Um1Ya3RXRDRnSnV4N29nTlRINUtQNGhqa2Z6ZVJOYmNBeGY0alJEdE9TMklI?=
 =?utf-8?B?N3FnRXZJWlYvak9ZUlZ5dThBRnMxOE8yWFc4SDdBNzBZWkRZQTVlYmR6QzVT?=
 =?utf-8?B?SWw1T0piTU03L01hcHVTRURHSFVRYzJna2l1VmJSL0ZVejVpcTlHRnl3clI1?=
 =?utf-8?B?MXoxMEJ3VDNuYU5QL2pyZU0yZ3hubU8yTmV2Q3RoWEJKdVVYMDgyWkdSdjZU?=
 =?utf-8?B?UElud0JSRTNZdnJnc1V6V245OHB3eG1HZUtHYXJyUTNBWFFzWUl3N0hXLzFx?=
 =?utf-8?B?L25kdlo1MDgreUQ3N05zdUpNdnNPN2JQclA4bEtNVTI2bTRaa1pqR01HWlFu?=
 =?utf-8?B?KzljbEV1c0NIbnM2dzBKanFyZDRsa1lWUFl2TnQ0RmszM3lEZzY5K3VRWHNX?=
 =?utf-8?B?TUV3emYzQzdrWE4zOGp0Zk9za3JsK2VVci80K0t0OUVJOHU0MmJ0a1lHTzVq?=
 =?utf-8?B?aGVDRXd0QjdFRWFTQ1Uzbko5YVlpamkxRXUwRnROeGlFTHJpTk51dEw1RWMw?=
 =?utf-8?B?b2JTelZiazBQdFpQcE40UStjZ1JnNnYxaGw5cjQ4M3I5NjdmZEhWVmRpOEY5?=
 =?utf-8?B?RUZXVGxHNlYxR1RQaWdtOVVXSSt6L2hIYkg2WkVsSHM4R1lVRmRudU5IM2gx?=
 =?utf-8?B?QjNuSjFwRzh3ZlBPK3ZFOTlvY291aXdYTDJSUnhIQTFGckdpWXFNbHllckdY?=
 =?utf-8?Q?HnKGMMjIqRL+U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnR1SVJwRlZBSFJ0MUV5NUorZGtlQllncTk0Y0xFeVhsM0FEWXVjaDdScHZI?=
 =?utf-8?B?OHMzMTRsVnR0NlllT1UxZXR6RFlCVkptbmtZVEJ1VlFZUGhtdk92VGk0b0hV?=
 =?utf-8?B?ckNpclRpMVFFenFIaEMyVmFiNWJQTE91blZFWWlCSlFVUndEZWNPQTdPRUNL?=
 =?utf-8?B?QWd4amFnQnhZcm1ndEltMXoyQnFJSFZCTjNvanVkS0c5TXQySk1FQk5aMjkv?=
 =?utf-8?B?WkkzWjZqaWZTYTNPWnM5SkNJcEp4ckkzbzh0ZXYvcTMyTGJtREpSbWNHcHVP?=
 =?utf-8?B?NXBqSnFzQURyWGpzRXZOemkrNkFabHVMRGdzWmtCWFVzYW1kakxuOVE5emlP?=
 =?utf-8?B?VS9uYjJQaTFIYi9WUFdyZHpUY0tkelFpVXlkTDRYNFNZZTdrQ2FKc1czZkZ1?=
 =?utf-8?B?TkliUlU2U1BtSVluUHM4YURqUmkwYUE5bzJ5ZndPSWIxZDU5QUhwVzNCUUJj?=
 =?utf-8?B?QUF6bHUvRWcvN2U4OFc0VW5UeGtEdVk4L2N1MFpQOEdUN1drbk5HOURoL1BC?=
 =?utf-8?B?TFh2OGhYSWZQR2lXcDhlQy9rN09DVzdxNTJ3Tk1Cb2dTTU9vbWZ0V3FUOEpn?=
 =?utf-8?B?NzRqV1RrWHY3Y1FjTWovdW0wVktsV2RrTjc0Mk1EakU2amtPKzYrdkRRMG1z?=
 =?utf-8?B?Zi9RQjlvajlNa05VUllmVWQxWFVsK1NqWTh0a3hzNzh2RHE3TVBTaTl1U2t5?=
 =?utf-8?B?Y2VTazV5SWtQOW9RZmtzM3BMNkN4UG0rZW94QmZJS1NxRytuWnJNeTJoV2l5?=
 =?utf-8?B?b21GRlhSZDdLbVRZeVV2bFovdVJ0UkwwYnA2SDN2QnE2TGJDcnRBMVdyV2t1?=
 =?utf-8?B?L3VQZ3pPc3ZrSldwblNOQmVORjlpR0VXQ1pwM0lZU0NpemVMREhxOWNjMXFy?=
 =?utf-8?B?L3ZONXFURjU2V21YdlZRZkM3akQ2VTh2WlJVOEo5WFVQUzk2b1VYSGpxVmVD?=
 =?utf-8?B?aHNndGtyazFIM29ydElhN3ZkeEdjd1NUOHFhNmtuQXByRnRWaFN6dlFGRUdR?=
 =?utf-8?B?bmd1Q29xSEMrcW1KNTJnL3B0NElFWTE4UW9ROG9najRSbFlabTRzZTZ5NlB1?=
 =?utf-8?B?Ni9OdDl4alVkMDlRK2JaeSs0MmJTcGpqT2tHWGUvcC9wSnA5b0hsOXhFWFNK?=
 =?utf-8?B?NnFOVFlzOTlCdm1XN2lDZTBvK20rN0dnRHlrVWo4MTVmamNaQTlqYmFDUlBv?=
 =?utf-8?B?OVZoQm1mUURGdWFCYTN0bG5FNTBqK3RGRnU3SjI5dEpYckx1djNxa3lMaGRk?=
 =?utf-8?B?UllzVWQ1ck8rQnovVHJrWHUyNEYrUmlyNlYwQ2xBYVVuVFhKYzNwcmlzbmlR?=
 =?utf-8?B?UDVKMUViMUZLYUJkNEpyVTBxSEtnRHpRS1J5cThlaHVVamR2bWhCMVd6TlhK?=
 =?utf-8?B?d25KUUxWeW85RG91c1MxUVJndDZLUE9XTlN2ZWlmaHFtYlFtZTRkU0I5YjhS?=
 =?utf-8?B?MlRrbmpRWDhVbTdLMC9ZWFo3UVBrOW5hMTlPSHJtNnlHVWpHaFlzbmp2Vnc4?=
 =?utf-8?B?aTV5UzRPdnhzVUd2NDljUXB6bTdPRXJ0ek5wVGtMQ0tBS2duVW1yYU1aRHN2?=
 =?utf-8?B?Nk53SnN2ZWZOeXN3NDN4aUJVUERIaGNTdXEvMU90NW9HMW5kekdFWkhQRmgy?=
 =?utf-8?B?Mkdxd29DNzVLN1d0WC9PbkVNTy9remx2NFI1TnBvVUJJR2oyaDZxOTIzNkIv?=
 =?utf-8?B?blNuOVFnc3piOG5lNFdYYnU1T3p1c2JsVXlWWU54UWNPUjBDZnhuSm9aclNs?=
 =?utf-8?B?RFkvU29uSWxqWCtvN2IzWm1jUHM5OFJnSmptdEFvUGtxNGtrdHpzTlJxYVJa?=
 =?utf-8?B?MlR6NUZWbTlOdE96N25lMHBjNUdzNjUzQ255VmprdFRGaStvR2dPOGp3NE9V?=
 =?utf-8?B?dlBZeFZmZ2IzNnZCVkdFNXhkdElZM0thTzRkQ2NpZDcwaG1oTVpFOWh2SWNo?=
 =?utf-8?B?K2w1SWNZMUx3UEJtc1lEZ1Bab3hZR29iZGlWdlZNM25qK3ZlTjNSbXhTRjdr?=
 =?utf-8?B?eGxBcktKWGIzbjBCR0dQbkh6OU53YzBLV1VtN2lDVVpmekhIWTZpSStRdVVm?=
 =?utf-8?B?dWViaHRhVjRFOEVGbTVrdCtCNzVBK1lnN3ZmQkZJTUI1clA3YVN4Lyt1RTFw?=
 =?utf-8?Q?AcSt6ZbANIsF72Ub1Eu9pm92d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f477e128-7b59-4171-1fa6-08dd6b9421ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 11:56:52.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0HTuhRzDIXKZnR/p7MgVJ3s3J/uVCPeTWtY0tU3VyqsDRvicdxTkisC2tI7u7MnwoEDJI14nyuKjLUZdeX1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

On 25-Mar-25 3:32 AM, Kinsey Ho wrote:
> This patch series introduces a software-based approach to identify
> hot pages for promotion in tiered memory systems, particularly those
> leveraging CXL-attached memory, by utilizing the Multi-Generational
> LRU (MGLRU) framework. This method is designed to complement
> hardware-based hotness detection mechanisms like Intel PMU sampling, AMD
> IBS, or dedicated CXL memory monitoring units, providing a more
> comprehensive view of page access patterns, similar to kmmscand [1].
> 
> We propose to utilize MGLRU's existing infrastructure to provide hot
> page information. A key benefit here is the reuse of the MGLRU page
> table walk code, thus avoiding the overhead and duplication of effort
> involved in implementing a separate page table scanning mechanism. The
> working set reporting proposal [2] also reuses MGLRU's infrastructure,
> but focuses on cold page detection. It provides its own aging daemon,
> which could additionally provide hot page information by integrating
> this proof-of-concept.
> 
> This series relies on kpromoted [3] as the migration engine to implement
> the promotion policies. This is just an early proof-of-concept RFC
> posted now in the context of LSFMM.

Thanks for your patchset. I haven't looked at the patches in detail yet, 
but gave it a quick try with the micro-benchmark that I have been using.

The below numbers can be compared with the base numbers that I have 
posted here 
(https://lore.kernel.org/linux-mm/20250325081832.209140-1-bharata@amd.com/). 
Test 2 in the above link is the one I tried with this patchset.

kernel.numa_balancing = 0
demotion=true
cpufreq governor=performance

Benchmark run configuration:
Compute-node            = 1
Memory-node             = 2
Memory-size             = 206158430208
Hot-region-size         = 1073741824
Nr-hot-regions          = 192
Access pattern          = random
Access granularity      = 4096
Delay b/n accesses      = 0
Load/store ratio        = 50l50s
THP used                = no
Nr accesses             = 25769803776
Nr repetitions          = 512

Benchmark completed in 605983205.0 us

numa_hit 63621437
numa_miss 2721737
numa_foreign 2721737
numa_interleave 0
numa_local 48243292
numa_other 18099882
pgpromote_success 0
pgpromote_candidate 0
pgdemote_kswapd 15409682
pgdemote_direct 0
pgdemote_khugepaged 0
numa_pte_updates 0
numa_huge_pte_updates 0
numa_hint_faults 0
numa_hint_faults_local 0
numa_pages_migrated 19596
pgmigrate_success 15429278
pgmigrate_fail 256

kpromoted_recorded_accesses 27647687
kpromoted_recorded_hwhints 0
kpromoted_recorded_pgtscans 27647687
kpromoted_record_toptier 0
kpromoted_record_added 17184209
kpromoted_record_exists 10463478
kpromoted_mig_right_node 0
kpromoted_mig_non_lru 404308
kpromoted_mig_cold_old 6417567
kpromoted_mig_cold_not_accessed 10342825
kpromoted_mig_promoted 19509
kpromoted_mig_dropped 17164700

When I try to get the same benchmark numbers for kpromoted driven by 
kmmscand, kpromoted gets overwhelmed with the amount of data that 
kmmdscand provides while no such issues with the amount of accesses 
reported by this patchset.

As I have mentioned earlier, the hot page categorization heuristics is 
simplistic in kpromoted and may not have been able to promote more pages 
than what it has for this benchmark.

Regards,
Bharata.





