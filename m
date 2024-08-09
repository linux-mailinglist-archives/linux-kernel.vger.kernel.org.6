Return-Path: <linux-kernel+bounces-281138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C094D381
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D077E1F23BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C41946B1;
	Fri,  9 Aug 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FeULHz4z"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29848168DC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217468; cv=fail; b=by/wZRNCrgVbQrdf2FSvTIk3fI/CoCsCo3PfD2XNIPLIOMpCKFfsmFJC3Z5jJNewPd+5GJmcrH3wEhoMTQUl7K0XXXg11+moq5OCbvE4XLVIifTo9OHCAf0oJPPKkqatImJMkxCbun4qX79OgoxkoR6hGpLCN/QcsRmqHrlFHvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217468; c=relaxed/simple;
	bh=6gGJpN5el8P6GDBSsPa2kHBl2EYER8VpmUh0989gVfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlW0jpR22EplhLXClbIaC0Imuwsf824bxPaKyokJouLlvBN7wF+oxjDNV7JT4jp4qaUj+sNlZeY75wMQk9teZITcQZ9Ms8BzeRatzrFmmI8k62MrpWxsXb2DsJYKCVy+cTWryupXkfv04dYwfoWhH8YbDYbIZMJ1qwzcyYvQW3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FeULHz4z; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOr0sO22V2JC+MXtQNPTTTvz65SxhUfI2fBIkAxqFY+usp3Fs9fH4PaRoYsVRnb5ouOTRHoiomU2G9+mvWwPtYHLsLyFP8v/Fc71d/IRZ+JO7pPAc442p4eCmyCf4aKmLSk0PnyC48Xxa9Qe2Y9ge4t39CcywWgr41IuKTdcj0oSod2DIbeWhMRp5xtoHxesLrpuFXBALNeIvYItOLqp0bEeFyQCBujEEA1L9Zot2ZU8do9PZQC7A4+kIYA6sxbE58kpMifkg9V9wuZg9ptevA+mOn5qdjTXmFcIV+ZoUkECRfPknjeB6/bsDGkup+EyABj9f66TC/riznZqxmkYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj1lxUSQeaJpqJiKEdgUhHIZ9/V0xBzeqiBZK9guuZ8=;
 b=wVTVfpPk32Q6nzOvKMRtpFMfpawHb7+jou4IfkC4/Xf577+syq8cKMtFSeztjq+6rIFeLgscd8zVO77BNQBbyfFHMJxsDWgnAhOyeGPMRDLUFUG4EAJGZPGHcyAUcKWayGnq5Z04NHV6PEny3E0RBE3LdkgxiVzdhY48AhHlDJ3pbxZuEMrg4Fb4e+bATo+yFVIQJvR56tTQpTxaKR/1RmdS/KdSR29S5LYmOqldV9yioH4CiF1KF8d1oC62WS2kk4R7h+LPkPsIqlab7frqSC8iP69khYrOSydba9371AK7F7VYDuuXYe/l6x2xFl2eHdGbyRbltUooPoGzRh+A+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj1lxUSQeaJpqJiKEdgUhHIZ9/V0xBzeqiBZK9guuZ8=;
 b=FeULHz4z+5YDS/lHW2FBbBWPfoI0IfoVkUMlIon3UO3Mp0BzanmSaN8kDFLiWpDuJqC6Vs3ZBln/v5gWxBEmzn0V4Fjd+EB9JWqxekRlxE74iIbaJ7kWZCvx6rtd9/wZMd44d/csAbhZt/BF8oyGDdlJWSlD7IrXvaqYrb8eCFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Fri, 9 Aug
 2024 15:31:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 15:31:00 +0000
Message-ID: <8640d12f-e4b4-5bd1-b772-6aae5e5ef972@amd.com>
Date: Fri, 9 Aug 2024 10:31:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2 3/8] mm: Accept memory in __alloc_pages_bulk().
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
 <20240809114854.3745464-4-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240809114854.3745464-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0204.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7268586b-9131-4961-bd88-08dcb88845ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0lCRnh4MVhnNEh3K3dEemxzRVNTK0ZvNzVjSDNiand2d01EUk9IbFBaVW14?=
 =?utf-8?B?SU1wSUxscEZDYnc5WkpOTXNaYnp3djRaUzcxZm9QbmlzSFlQWXNYT2Z4TE5z?=
 =?utf-8?B?K2l0ZDM0VjNBcG5iZnBWM3VYRkNxaTZ1R1NoZ2MxaUJESW5ZNVJLdkpSWTFa?=
 =?utf-8?B?U2Y4T2phQmw0U1dpMjA1TTZ2NXBRRmk2cXVTSGVrSExOcDlldzNzY05vQVg3?=
 =?utf-8?B?QnZIclh3NnRMbjVZNjRzT0RZeUt3azByK0dvQzhzbDNJM3Rzc1QwRnAydWha?=
 =?utf-8?B?YWdsWEtQZkIzZlJxODZLaHFpZDYwUGVlMktEM2g0RzJzZStzWVVVVEFvaEVi?=
 =?utf-8?B?cWVPNHdjWUJQOFRjUTI2TWRPYXVpdDNpVXdQeDFidStmWDR6OW5MV2JLcGI3?=
 =?utf-8?B?dTltOG83blJXbUFUZDFwY2x0djhrWHpTQ3pSdTJHMzRseXpCS2tPMXoxV0d4?=
 =?utf-8?B?N0NnQjhuRk5hYUVhZmlnL0pxUkpiLzVwQlQ5WlJwb29uVGhscTJNTUV0ZC81?=
 =?utf-8?B?TVBLUTI2NXNiRVNmSmJVS2xpSEx1NGNlQWNxa29vellQNk96cUNldElMVDlH?=
 =?utf-8?B?eVVwZklPKzBBRHkyMnZzNllRV0t2VEhWZWlkZjZOcmphcE9RUUNndzJCSWZj?=
 =?utf-8?B?eVowZmxKMjUzYm1WclphSjkwQk53b1Z5cUkvT21KUWgvNnlvbGtobjcwTWFV?=
 =?utf-8?B?L2lSMmprczFlQTRCVVNUZUFkdEJMaFc1bGRjZFMyV092T2x6ZTZxcW14T3NB?=
 =?utf-8?B?QnVuUzk0WTdzNHRwK0p2WDFDbWlSeTJpeGorNmR0aURyMTdaeVd2RWR2MC9Q?=
 =?utf-8?B?djBYK3p1cjlUL0FjSUxxSW0zb0wzM2twTWNoYlVVVTNaeDVDT1FRVVl1Qm85?=
 =?utf-8?B?RDBMUWVxV1Q0b05Vbmo2OWYyRmhnVnQrMDJMV0JidmE3dmRVRWxRTmNycytz?=
 =?utf-8?B?bng3d1B5d2tXVnpKTHpaSDBadXV4ZTRqaXdXUFZQblRaMGFWUit0VnpjMnFn?=
 =?utf-8?B?QXp6WlZPRzVFT2RpUWJpMTh2SDlXMXhFam4rTzgwMXZoQXBzVElmKzFjQjR0?=
 =?utf-8?B?M0NzK1FyejVBYUNENERmZ3g2TTA2UW5BOFU4TXE3ZlV5cTg3bzdSWFZpT25z?=
 =?utf-8?B?blE2MmxNVThNUzJvMExmemxQcTNaNFhpd3J4K3V4MUdEMlJ6Rng2V3lYdWxC?=
 =?utf-8?B?TjRpWnZYaGcyZVR1ZEx1MExOdUpRWkxIM0NibloySDdCQXN6d2JQQ2JMTWRx?=
 =?utf-8?B?NkNob0Vva05ObkkxcGxyL2ZnNWVXQVBmYW9nQ1UwZjE2eldPRmtrWXhKd2Zs?=
 =?utf-8?B?WWxuZTdmcjRqYzRaR0RuK0dobG55NGFPdjZFVjRDV0E2MGNQZkpheXh1K0Q0?=
 =?utf-8?B?VWZVaEFyK1BwTGNEVkNQNVZlem9XcFdnU2w0Q1M2T0J1RlgrOHlLeitOc1E3?=
 =?utf-8?B?QzdyR2NxOFJjaWhhblIvVGJCMDdSZzV3MzNHL1lFdytiN1gvd1E3RzEzTFZX?=
 =?utf-8?B?b3g5T25uSXg1Skh6WHBlOXpTbXBNR05mRXdzTzd5ZHo1WlpGY3lMT1RmdFQz?=
 =?utf-8?B?SXQ2ZmJXRkpNNDFYWVgvb3B6bnliaGViQ1c3RE5kQXBuSUw3MGZCY01wMGQz?=
 =?utf-8?B?d3ZLS1JaR2xCck1QcGVtL0ZOb001Wm1hdEgwcUY5a2dMcGdzQUFEWjFwZWRv?=
 =?utf-8?B?Rkx6aUNNNEIwNFlmZkhkbG9JTXVmTXltR0VhbW9sTnFaQTFXRUIxYzBnTEdR?=
 =?utf-8?B?VXdSa0hvend0UTlaNCt3ZE1VdzB2d1pNVWlXYXUxN1lKclp6VGpaTENjemhP?=
 =?utf-8?B?cm91eWVGUWo3SGpOdTlTUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFqa2tCVGJLakJ6bkVKQWtNVUgrMXVGZzQ1N2V2Y3ovZWc2UCtsOCt6Y2NW?=
 =?utf-8?B?dnE1MFBtVFlUcWwwU2tIRU12RXE1R2tUemFCaXlyWWZQbjhIdkJjRmNjajFV?=
 =?utf-8?B?bjBnVDhBVDdYbm45eWxXMmpjR2hGVkhxaUNKaVhJTDNTSm5VMm15YUhnWmxr?=
 =?utf-8?B?TDZ0NlhlTkZ2TlZUREFaaUEwa3ZkcFhoM2FOTlM4NWZPamNDV3dxN3pTUWQz?=
 =?utf-8?B?bXkxWFFmYWJIaDZ3b2RMeE9MUTlQeThSK3FKRHJ6Mml2a1BLV2laTnoyZHhM?=
 =?utf-8?B?ajFvdDhDSVRPOGFFUHExQi9kNEtvTDZUZzUrdCsvYzlzeTNpWkQ3dk85RGVE?=
 =?utf-8?B?dk5zclhFbzhVNDBVT01mZjducGNDNjNUZWNEaFk4Unl0WmNNS0JWWWU2YWw3?=
 =?utf-8?B?YUhQS3JRYW9Ka3dGR0NLQ3BicWp4R3BzZmNmTGMxQnpQYVNtdWVFcEdaVXdB?=
 =?utf-8?B?UmxzVks5Wjl5ajhkcTJxNE5WeXBNR21EMitjeHR6VDhwbWhoRU52cHpnWUpz?=
 =?utf-8?B?cGtsMkx3T3ZPbEF1MFV5WEpaVTdRMDFUb0pHWDVIdTc2R085dUhkS3pkQ3dC?=
 =?utf-8?B?NXk1NUJzbEgvU1FSS1dBTFFCaFFLVkhLRnJpdWt2SnlGdVg5cWZRQWJnMS94?=
 =?utf-8?B?cFozZkZiZzYrUzFMbHhYK2xiWklkSGJ6SGo0eFlNb2tXakIrMG5QY0xNNGN1?=
 =?utf-8?B?VzRoN2JjbkswZDlIaTRsWjl1ME1OSDkyQmNId1dCWTI1ZkVGK3VDWk5kNUN1?=
 =?utf-8?B?NmtNVmZEejBEcUJnZ0xtd0s1M01aQWMranJFR2RsaGhYRDBXZklxclVHSHow?=
 =?utf-8?B?WFNRUFgwWXZYQmdNeGs4VnFhSml3d3RldmhlSlNaZEI1c3hQeTgzK3NpY3Jn?=
 =?utf-8?B?MUwyQ0lKS2FHVHQvTldKN0Z6cmxkbURocHJQQzA4TUNKamxXeUxaU1VJbVlY?=
 =?utf-8?B?MWFOMjQxS0tsdHhPdTFiSEtaVHFSeHZ5ck5kdUdKVVFCZFJjWmpTTmN3a2Q4?=
 =?utf-8?B?OWlhYXhPTFUyT1g3bWNhRU4xcThMamQ3eHdEVXF6cGI4UGZ5ZjRtd0dCUjVO?=
 =?utf-8?B?RUtxZ1VzVHJBWFJ2ZnA4MVRiRExnZUpjZ052dWg2ZjJpTzVUb3pLZXgxbEc3?=
 =?utf-8?B?UlY1SW5OQWE5RTZ2WDBaWnVqYzhRLy9mMEdXNytHMmJXQnRNOFRDZnF1Wm9m?=
 =?utf-8?B?b0daOEJmalNweUJUMG5wUGhwRlhGM0dsS2NXK2s1aEw0Z0xSbVZKSzI3TWFR?=
 =?utf-8?B?R1A5eW1hVmFZN2c5UkkxL1FuY3lqR1VJYlplMVhZQW43dU14NUQ2QlVOUS9v?=
 =?utf-8?B?ZC9OcTB5ekx3YTBNRDg3cEtRNGwrelRkalF6c29mQmh6NnNOTHJjMzZ6UCtr?=
 =?utf-8?B?MDhROVVLZnNlNU5jcFZBdVFOdisxeG50b2tLY20zSnlSbXBDa1ZicmRHTXpE?=
 =?utf-8?B?UjNjd1dXUnhaaHhnbGM4b0Vva1phUXFhdldFYWxZOTlETDIxcWw3Z0xCT2hr?=
 =?utf-8?B?VGtpQWE1Mm4zRldib1VyNWV4a0ZPdHo1eUpHb0pZdDVBR1FqV0RTL1ZwTTB1?=
 =?utf-8?B?RnNacHRyWnJGeE5oUmpMc0VRYVBvdmt3TUtyYi9KZDBOOWdPVEdiRkIzemhz?=
 =?utf-8?B?RjZsZzd2VHJLVzR2K1BhaWhUQmlHNTVTOU1xUHhkQU5FRW0xTC9VQUo2cTB6?=
 =?utf-8?B?UmdZckVCZFEyMEx5UVJQYjhKSFZVT293U1Y2clFVVThyR0JDQis3ekw4TkZ1?=
 =?utf-8?B?RFlXRm8wQzFNQnBWWmJmWVBRakUyZ3k3MSt3KzluK0RUSUVCRDkzKzFKWUZK?=
 =?utf-8?B?TlFranV1K1hhYkxwWEZFbWJ6YVlIWGtobVppMlVTWWQ3R0h1ZjZiaHhRelAy?=
 =?utf-8?B?ZnZHK0FLcDRZL2dXTUpJd0lzNThlWjFPb0ZIcUNaelhjWHFKNmxUT1ltMG5j?=
 =?utf-8?B?QUNUU2R0cEFaOXN4WXNsVU9zeGJIM3p0Q3JZTlZMZU14YlFIM1QybytsdEZE?=
 =?utf-8?B?QTYrWnBBemhYaFh4bC9oeTM4Tjk2QnR2YjhQeG9RK0NZMC9ITFVYS3NoZEo4?=
 =?utf-8?B?Wng3Tll5aXZrY1JEbXp2UVBmemV5OTRvQ2k3OEZKZzMxcUNNQmkwR2x1MDBw?=
 =?utf-8?Q?Omi8iCZH7wDmsfDWd7WfQs9lw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268586b-9131-4961-bd88-08dcb88845ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:31:00.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG+fs0G5byKBszlFNVyf2yytiuUuds4wzkloGbF2RvURAn2a3GuHPzgdpX6sbR+wboJJjXSM1UCbxhfIyW0jNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

On 8/9/24 06:48, Kirill A. Shutemov wrote:
> Currently, the kernel only accepts memory in get_page_from_freelist(),
> but there is another path that directly takes pages from free lists -
> __alloc_page_bulk(). This function can consume all accepted memory and
> will resort to __alloc_pages_noprof() if necessary.
> 
> Conditionally accepted in __alloc_pages_bulk().
> 
> The same issue may arise due to deferred page initialization. Kick the
> deferred initialization machinery before abandoning the zone, as the
> kernel does in get_page_from_freelist().

Is the deferred page init issue an existing problem? In other words,
should it be a separate patch with a Fixes: tag so it can go back to
stable kernels?

Thanks,
Tom

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f7bb885aab07..ed62ecd6775f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4613,12 +4613,23 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  			goto failed;
>  		}
>  
> +		cond_accept_memory(zone, 0);
> +retry_this_zone:
>  		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
>  		if (zone_watermark_fast(zone, 0,  mark,
>  				zonelist_zone_idx(ac.preferred_zoneref),
>  				alloc_flags, gfp)) {
>  			break;
>  		}
> +
> +		if (cond_accept_memory(zone, 0))
> +			goto retry_this_zone;
> +
> +		/* Try again if zone has deferred pages */
> +		if (deferred_pages_enabled()) {
> +			if (_deferred_grow_zone(zone, 0))
> +				goto retry_this_zone;
> +		}
>  	}
>  
>  	/*

