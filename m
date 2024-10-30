Return-Path: <linux-kernel+bounces-388106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D694B9B5AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6318A1F2418A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD0192597;
	Wed, 30 Oct 2024 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxOsgA9f"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBE6125
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730262655; cv=fail; b=oNsBic9R5YaT7iTWl+x4spY6PIG9SHPg5gByBWPBxEip88dF9CE6eKOUQX5VbCOOkuXphANjhgqR1ZKc2Knk+uqwotmBCmGWVLMTr6xOyJeZVkZPJlfOQn2NEsyOwvak7bT1iYrstcjM8Tgm8VtRotQ0kF1g02P96GAtFIKqIsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730262655; c=relaxed/simple;
	bh=zbj10OG+mBnvj0gyd4QcZDfhkEdch1xG9jdUgWPbXtk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBJrGnurTMMQdFK/sBLOO9wJ8+2b6Prv3U0NOiwzCP5TYjUYZ+/Cf/ks0FtDKOLJCFsuVafux8jJOnUSSnBnd9MJ59hbTwAcrc0EN57XDC+J41ha1w3yUQtjnikJkYl3McXcwIq2DNn5yc4aRB4Oz4fKN+EF71vc9Z8cN3O6E2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxOsgA9f; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN+3I74yRn2Nv0sjr6U9MggZ1Jk48qUBinoDfW7A+OrhEjrVpgjB5VWhFGOx+DScexEkyusvpCTXS/W+y8TYD6j5N/ycXuSfhl4gW4fdaeLm54qgcI74PEUmEOJJTB8kVvPiPkgPgcj14YhXB2LUDzCuLIkLero6u5+XldkGImyWi7UOxSoQW2gILenvTLkuSuFKfCf2EHx/q/dp2/sts9n1Xl/aeQGRyw8gUMenEy4xx/7+ZYlNK6E4GMN74LCQZexU0YGBBYm6RpHO0WMi3gDMCOavUvCrpGYYR+kEDqnFuysscLwIya3ta5D1oS28U7fzEjbezAS/M/+ZA996MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALjElbYjGxOGCsF1x440FeWb/w7rctx8XrtvU8qRkQc=;
 b=l7oLFnqKJrzEZCgwXzFZ9ktNKCweYBah7UyZYkN1UtqAJU6CkWGxZkhHCmCR+hBAglJXFZiSVEjXTlndtxS+HsXI7svyvL90O6qjkbMjTBpqLxVHCDeyeJFVQa8ECH/4QIMJby83u5Urv6AVK0Ru7iTBxVvR4kGWKgxjy0vfGikVlsqApX1bKOpSYTvhRT5blgDLi/8Ws/TC8zHBJ5aCNJdqYAtilDHMkfXLBNTXv/dogOjIFYbroiQRp6kjqTFkZPTeoteIFmWOeXTSHG4xIl+iSmWRdNbZsawGtEnWn/Vgjfg3COlsHj/NZqf/DMCoOVL63L0stHxEegG5/QqVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALjElbYjGxOGCsF1x440FeWb/w7rctx8XrtvU8qRkQc=;
 b=YxOsgA9f9tVO61xAr7dwaL0XkLLxVKBWZFu/2bOCH9/kXMdNkmPQcZhAblHrPRxLg6GDYEx4EZ/PP3ua+gbiiiW6bl0YounosNkdgrnNs9UQFFIxXI1en55i9xT4szjcfigkhmkucG3gdy6nbTkBUT94sxzYDtllsJfuAnX4N65+VF6Y6+XF746sbY2iT+jpjijtTGYfaO1caiPjdiNno2wjeu5oZ9wMDubBXkfXGCcZrnuCJLcwy8oKn8HX5InAwmojyPqqM274oeKDwF2UKB5qWtAKU26d82Hyj3JRa2DIRE/muz2Amj00VBkzDbaXTMQuEB7yX4HEY8MTCB3jhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 04:30:44 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579%7]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 04:30:43 +0000
Message-ID: <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
Date: Tue, 29 Oct 2024 21:30:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 David Hildenbrand <david@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZyG0VKUpFttPF30f@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To DM8PR12MB5462.namprd12.prod.outlook.com
 (2603:10b6:8:24::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: b2797fe4-4967-4207-b3d6-08dcf89b9e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFV2ZStWbDllTXRCNWpTOXdoN29HWWNLS2lEb3FVRXVhS1huci8zNlpPeWRE?=
 =?utf-8?B?RmRubkcvQ2lGaHJOZm9IV0xLTE55T3cwUXZKRk9xeVhVVzNpcWprSER6WWdj?=
 =?utf-8?B?djFtWC9ZYnRWRitKV3FNU0p2VWFGUXl1bjRMUDlydzA3THZ3L1JqbDMzTWpL?=
 =?utf-8?B?d0F2bnF5U2J5UytsTTNvZlRRR0ptZGEzU2d0NExON2JQd051MUk4UUVKSmJm?=
 =?utf-8?B?VnVIc3Brd3ZRN2gwMFJEdDlGMFdaQS9DSkdFS2ZiODh3MFpTalN6M2oyTEJv?=
 =?utf-8?B?TElQbWt5ZGFGRFhNZjNCNE9sTTczYjZ6NmovNVNON01ReXFwOTJSbkRJT1Fx?=
 =?utf-8?B?SnNrZUdYTkVoWURYTXB6NnZaMzdmbThyMFdoUE9hOTNwTVlxQTM1Wk0ybVRt?=
 =?utf-8?B?RUtDYXZTYXhDdnFKazlNREhnRmd3ajc5MlUyWlpkbjgrR1ZRTDROc256T0R3?=
 =?utf-8?B?Rk1nU2d0QkFNWlBxYW1ZWHRXa1VWc1lScmg5MlI0bkE0TnF2VGlYMlloek1N?=
 =?utf-8?B?VkgxdENwUHhXRFNBbkg1b3RXdm4zdERRR0NQUkJmRkIzdWpzeFNjR2RPZkZs?=
 =?utf-8?B?Vlc1Y3VJLzY3WWduWXpBTDMyYW5jVm5ubGVFUXRzdzhwZjFCdWUrMGVkNGhM?=
 =?utf-8?B?WWZoOUhvQ2FVYW55MUIzQW9qVW1wZTZxVVdGZ2FZZENGVTVCcHl2d3NVUFo5?=
 =?utf-8?B?T1AvKzJNMDFISG9rc3dIbUN2TXBOU3kyWjdOS1l3OUJadFBISlRpSDVvUFBC?=
 =?utf-8?B?dUFPMGpxOUpmalZGckhMU1ducUVoSXVWMERBYVdjdnpOcU4xVFVhaCt5V2J3?=
 =?utf-8?B?amVLNzJuS2JmUXFyOFdIcHhyQnFQZjFsNFZOV3o3MjFraW4xc1ljUG1SbEFn?=
 =?utf-8?B?eUd3STFpZ2twMmVxenFuZnVXc1hyM0xDQXY0RGlETTVDSSt2aVZ5S05lcTkx?=
 =?utf-8?B?Zk9nZU1nSnV5Sy8vWmk5SDB0WkdpVXhYT21KcGVIbk9Ld01VNXFYS3lvajdh?=
 =?utf-8?B?d09YWmtwakxGb0dsWDkwd2Q2T3h4MWl2ZC9ibnR3V3ZoMjVQVEwzWE9UL09U?=
 =?utf-8?B?eGhKalgzMXRieEJ3WEdSU0QyY3RtSlJiSXREek1Oc0JRdWFFNG13RVV5Zy9q?=
 =?utf-8?B?S2kzSTJjdE5BcmVDWFN0a290WW40dTJpTkxQQkJHeVR3N0pWanBzTzRlbHhG?=
 =?utf-8?B?aWk1NmVwNjdLcGlzNnZmRVRYdWlnNDJydkFyNTgwTFA5bGRxL2l5c1A4c0x2?=
 =?utf-8?B?QjQxMjNjNjBmVHBDKzRuY0ViMit5cHRSb250ZlcvM01OMVFzQll5SUVzeUVk?=
 =?utf-8?B?Vld3bEs2cVBvai9QREJRSTdXU1lFTEFmSHVaVHNtUHJMODhnaFptMEpZMHNO?=
 =?utf-8?B?cUJ2N1pibUdqVk9DVTN6UzFpZ250bDFBeUpGcnRjaW8rZW9kTSt2OHU4cGhy?=
 =?utf-8?B?eVVuUU5MZFV2TVRYYkFYZmVTV2ZjZjNzdjRycFRDRGhHdWVHZ3k1aEZFUUxZ?=
 =?utf-8?B?UHRrN3hGTTN0Q0ZldVlVMzh4MThpdFVCaVZKelRiSDVWV3ZhM2M1MzlVZlBw?=
 =?utf-8?B?REZzMzV4M1dFdCszdUhtcHpldW5GdG1BSHN5cGdNY0NWalpWNldCQWJWdHQ3?=
 =?utf-8?B?YWNiNGt1OVhWcGZJNTlnZ0pka2NkOUNFdHZvdFJUQVduR3BCMGYvczBCWUVL?=
 =?utf-8?B?Z0FFZWdPOXVLQXE5Ny9VSE5kQmQxc0Z5NWNTaXJRbXhyVVdKeGY5L2JDSXJw?=
 =?utf-8?Q?QBh0C2kF2QllMJ26uA4wwlvMJKmXt07J1Eg/1f4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3JjclFzcW5jcWg1Yi83ZlVJUUI5R3o3WHVJb3pJdXlmZHNWT0VDS1F0SlVD?=
 =?utf-8?B?djg4T2VOTzVLZ0dQd0JFWmRvc2lEWlJvb3NyVDhIRFoyby9IVDQwRDAxQ3RW?=
 =?utf-8?B?dUpKN0I5WUd2S09jVlJKL011VFExMC9hZGtmZXJSaXlvRUt5ODI4RVVrMGRQ?=
 =?utf-8?B?V3Vxb1ErVFg3VERPbWJZWnhsYXFKcWFpOExIaWR2b2JGTFJraHppWW5WTzQv?=
 =?utf-8?B?MzdDamtnay9iak9pRTFWQ2lCNGY3RHovOE5Eamt6eWxPdTV6enFTR1IzYzJU?=
 =?utf-8?B?MURGTlZXKzZLaWpXclBGS3M2VEttT2ZtOHZmd1hKT1BWTzk3NXNmMnZMaFFT?=
 =?utf-8?B?SW9tT1g1UW02MTdLM20zRjdmTzJxb3ZSY214ZUtML3MweU5ueStRemxvUDRY?=
 =?utf-8?B?eTdGN3ZrcWdkYWlaK0crN3JuQTZDdG1xSWpaSDRiMHpkZ0NZUXlIc1hCNjNV?=
 =?utf-8?B?OW9KQWI3cVc2VnBjcDVLMEZ4bDBnRngyM1RmTWRBcmpNd3JobGJ4V2NzOWt4?=
 =?utf-8?B?M0ViaFVjMDRLNUgweVB4T25FMHA2d2RmNGJpTTkyVkVZVTArK1JnNnlZclJx?=
 =?utf-8?B?Y0M5QjdWeGE4RnJiTXJRZjQvejZ0dElHcUY2MzF5VGRHZjg2WDdiUitYZ2xL?=
 =?utf-8?B?YWFFcy9WK01YWTRnUFJ5UVhhZzlqSTVvdTFpdTBYb0dLSU5ZdGN1eUVvZjJs?=
 =?utf-8?B?RlhKbk9tUGthYzdRdkNNZHpVczZXbGsxNHN6Rjllb3JvR2c4T2hTYmZOcENI?=
 =?utf-8?B?SFM4WkpWTU5TZExobU5maGwrY2JrK210cWUxcGJLN29TYXMzK2I5RnJjczBQ?=
 =?utf-8?B?d0xVNDliUzFpamRTcHBvZU1jMnE4dTlTdWY4RXpxLy82MHYxQlNEeFZjT0Fv?=
 =?utf-8?B?UTZtdDNwcG9vUXVzTHdIS1lrR2dsSy9TZm9pWG1SZVlmeWlWcDhwL3pLZjVm?=
 =?utf-8?B?azlMc1grdzNmRU1VVHlUVWtRc1NvRWZxYWdQdi9RVG13VmxxU05PQTY1YUQx?=
 =?utf-8?B?ME5rTFcza2diWVhSODJyNExNM1d0bE1LOXVLRkNjZ2w0eGlSSUpzcWpFem9t?=
 =?utf-8?B?VjJXOVBPVjVoNUVEZGFIUld2RUsxM3pWUkFPMEVONzRMYWVSRkZXZE5takx5?=
 =?utf-8?B?ZXQ4QnFtUFVTZ2dBdDNHSzcyY2tqRHpNYS9Wck1IR3YyQ0F3a1pxMmxCVEN0?=
 =?utf-8?B?MUt6WU5yVE5FbVN1M2hnNlBxeUVTNHB3dEFnRmxXYkNtcjVzaVZ1NmhNWVhp?=
 =?utf-8?B?S0VCOUV2Slhsd0IxUWV1cmNWKzU1ZnRTNkxEYTRiQ3QyMHFaWDBSMFhpYVcr?=
 =?utf-8?B?Tm02eGdsUU0zV0tDR0gwbXJPbmFhb3lTNHl6TmhnUkZBRUNKZ0JOVzhXT3hR?=
 =?utf-8?B?M01MUHJZZ1hBT0lLTWdPQlBaTjJOM3laRGpPTzV0b0JLZEN1R1JHdVhjUUJz?=
 =?utf-8?B?azQzYm1IZ2w1UE45eklkUEtUZm93cFhockJBS2pZWVFWWUtGcFYvWUxLbmVK?=
 =?utf-8?B?R3ZuZnRiQk9lS285NVJQcTJ2K0htZnF3Z1BXL2ppRDF5VWhMM2tqaTNVVjNM?=
 =?utf-8?B?UlNsSVd5TzFrNVU1T1h4dm55RDRwcHdkV1lTeHlNbWw5TXF6SFM0Q2tGK2FN?=
 =?utf-8?B?dmhBazM5U01Pb3pSc2l3OHRhSEtyY0tTK1hmU2dMOUNkWDlhY3gxUDdVR1gx?=
 =?utf-8?B?cjJ0akhJdnFNMk5LWDlhN0Q0dWViS1FNKzVWS0JyNGdqdld1OGlVa0RucCtL?=
 =?utf-8?B?cnVvYmErb3FjZnQ3L1dhcnFRdXVnUWVESE5rajc5YXZTcFhhQlhDeEhhVGNs?=
 =?utf-8?B?SW50UldJVnlwaHFwS3dGRzhOaS85WGN5SHZPY1JOYTV0N3cxenRZMGxGaWJJ?=
 =?utf-8?B?SmFzemFsNTlNOE43U002RWFzbkozMU94TENtbnoySGE4YTAwUnBOL0w1Z0Zk?=
 =?utf-8?B?aVZ3eUNsd0JlL1djdFZnTEh6S2tpZHNGNVFHd01SMFdodEpSVExXQlVDbExN?=
 =?utf-8?B?Wk81bWhBOFVFbE81dU0xZ01QcFFwQlJWcVp4dlRhcHlBKzBHYi9UTllxU0ti?=
 =?utf-8?B?dVpTQURqeFdZby82Z0sxc3hweWlyRzROd3kvUTkzRTZkb0ZFandZRjlQU093?=
 =?utf-8?B?Vys0SkZOK1h3Y1lwM25BdHdSbnhkQ052RHFmdjNJRlFwWXpaaElkdWV0NVRF?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2797fe4-4967-4207-b3d6-08dcf89b9e07
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:30:43.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYCUwzThFC6yFA5V0l9Qs5VrW9odzPO1jcJ5xNvQLlDqVvnzH5jB5ZPAcXlwvQEaJ0HOO5jFSAhQLV6wQRxgaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691

On 10/29/24 9:21 PM, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 08:01:16PM -0700, John Hubbard wrote:
>> A user-visible consequence has now appeared: user space can no longer
>> pin more than 2GB of memory anymore on x86_64. That's because, on a 4KB
>> PAGE_SIZE system, when user space tries to (indirectly, via a device
>> driver that calls pin_user_pages()) pin 2GB, this requires an allocation
>> of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
>> kmalloc().
> 
> Do you have a report whee someone tries to pin that much memor in a
> single call?  What driver is this?  Because it seems like a not very
> smart thing to do.
> 

I do, yes. And what happens is that when you use GPUs, drivers like
to pin system memory, and then point the GPU page tables to that
memory. For older GPUs that don't support replayable page faults,
that's required.

So this behavior has been around forever.

The customer was qualifying their software and noticed that before
Linux 6.10, they could allocate >2GB, and with 6.11, they could
not.

Whether it is "wise" for user space to allocate that much at once
is a reasonable question, but at least one place is (or was!) doing
it.


thanks,
-- 
John Hubbard


