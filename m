Return-Path: <linux-kernel+bounces-333199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B104E97C54C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AF81F216AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF719581F;
	Thu, 19 Sep 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UeX5ED/j"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020138.outbound.protection.outlook.com [52.101.61.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5B71957E2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732168; cv=fail; b=TixfNpRvZiS/Vhu7QmZrZ2FQqtMD0FyXu5NSRfHeDeM2JBBWLg1vzWY4mDqvDuzviGgAAMgLlNlEUsz4eASj8k/JXQCtQZDP8ugehCXYiw7EynJ7QI5TZG/KoUiWKQYVP/5UNHVxGYZXrsf7QDH8KqpYcg3uoyi/AF2j6Tqy3LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732168; c=relaxed/simple;
	bh=SXpAuYoUP70fqEhc/BsJC2a5xTRb0JRhQyy/wqtdFEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBWv+vSoc48tISlTIlyLrYYjwreY3zuE4tyN8DUnEDEdYr6N3kVG1dtdQ6oyyHVpZ6eeSWAp9+xE8SZk+1sfu2Mhd/vu4s8thT96JcTRvVD5fL0n3gjvydgfD6Z1HmIWnicm5EijPATKRCA30iT4mANIEzJjaVShDQcuz6J/Itk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UeX5ED/j; arc=fail smtp.client-ip=52.101.61.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywTnUzF2lZmZ/zwxivLvDV7URLAxMF2zdCb0MlRdQa5Buj+HDf8kDLw5f1TbrlV26L3+rrIAgLHVtwbVrItuXdVKA4ty5NWpHsRfElwvsEwdRiD8apx2wIoGzeZgEU8qwDXn9cLRUeTtMAt38+YsHNTZOjcXF7q4qiO5Y0/2EZdrDBf/gkFswqydiay6Utp3TcIPrdpjmpIMvQVzVFCCe2WYWpzqn+tjuBjZhKBZt9ISt0RxnXjEch7p9W0fgUu0YjW7SJD9bkFyKJZv7zEyGWEOSXDk6a6GMVEXi8OBa/YNjM7OMQn6c5MqJCSeA0jSxAjlEmU44xuyyyw+uZEcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEj1yi8WLHHOgLOrPscFRNtt3trAmTCi8HqJ6Dv/EgI=;
 b=ZRUf7cMVxZqVgZbCm7SHu89hbM0370HBhH5WS85saArGB6bCS+lRxYoiYZBb4V+JagBgnvnDZrqYKJV9l1ky8zUvfYNLdDsFihIJ1yhpzZ8NtVdUUSRsoKR3IGQYjx2LsQbphnJDvCrpirChukkutzVRXU8nUOXgsllvoa8gl1D3GKUSVF0FW1Acql0o868ifWDgC3O6Tss9Y89VEFfWLqFZ5kyCzJZvZ7+6g2LglPBwfHP+IW5AmVppgewoCaDtP78Cyv5XeJDBfwDHBFRsgxzvXffUfIjxOOcVgpIhlWyYR7l/kriEx90NzCt3r2I14MWomtqcON03rtCfz3/IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEj1yi8WLHHOgLOrPscFRNtt3trAmTCi8HqJ6Dv/EgI=;
 b=UeX5ED/jFntf0O2yJrEoEAxhd1cs8u76qzOBYLdYhtm55PtjGsxnhSJmpN+2tspzqTSwQ1sRFIReWAYyWE8t2oh6eZC9FWbW0vYQyhPeZ+d0/7+zbs81vQIRfCVsrzcX7sWagDeuWt/y+WX5tWVXki6d9o1lhVDMa9wGoicRk6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MN0PR01MB7681.prod.exchangelabs.com (2603:10b6:208:378::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.23; Thu, 19 Sep 2024 07:49:22 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 07:49:22 +0000
Message-ID: <eb995fae-1436-49bf-917a-beab3ccb3761@os.amperecomputing.com>
Date: Thu, 19 Sep 2024 09:49:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH 1/2] hugetlb: arm64: add mte support
To: David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240913183404.3517556-1-yang@os.amperecomputing.com>
 <51dd74c3-5da9-4ea0-8298-3ac843c6a843@redhat.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <51dd74c3-5da9-4ea0-8298-3ac843c6a843@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0298.eurprd07.prod.outlook.com
 (2603:10a6:800:130::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MN0PR01MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f88861c-9dbb-450f-0bf9-08dcd87f9368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpoT282YndVT2V2UWlhOXFXV0tIcFZDeW9WbFB6VUUvUnBKY3RoMzFyV0dB?=
 =?utf-8?B?eVdIWmJyMlgxTnVjdGVBVzZVYXlzQzk4ME9aSW5Cb2dqQzBIdU1sbUVNcnBo?=
 =?utf-8?B?TnBVRzlpNlRwaVdWVXBDOUhOS3YyZ1BOcEZGUkFUN0FkenJNT2VNQzZqVHF3?=
 =?utf-8?B?T01wZFVEZmZTdk5uYTU4RUMvRlZidndZR1NvVnZMZ0Jaa2VBQVVOUDFDS0RV?=
 =?utf-8?B?MGdiS3BhVWpjYzZtOHlNNVZ3bkcwQmlYUDZLa20vK2FIaUFhUWROUXFGQ3ZT?=
 =?utf-8?B?Mm9FRDNJZGVGTnBWaWhqY2xGVUZZU2JMSEVwcW1jSDFVRXBxdHhiUGZjdHhh?=
 =?utf-8?B?Y3FqMk9QYU9vZE9zNHl2clExeXB5UnVOZHRQM0dhRktpT0NUQXl5V2VpeUpD?=
 =?utf-8?B?ZjZtcGREdHU2MXdpaUxZenE0SWZyMzZRSnhQK1cyT2pJWVV6MkZpbkxpY3lT?=
 =?utf-8?B?OE9oTHFRb09NcGdDc0Vsai9TZUZQS3hVOTZhNVh6OFV5dmNaZi9BaVB3SVBV?=
 =?utf-8?B?VWYzRG96UDFFc0wyVkFxdlRMSjhva01UU1M5bExmQ3pkc2JzdXdVU1hxN25j?=
 =?utf-8?B?emRkbG50TWhuY21lcGZtVVlqNUFQbFNHU3lPdXg3MnNHTEpTV2RWM2xPV1hV?=
 =?utf-8?B?cVVEbm0xeXljQ1dGaWdHNU80STcwUlFXSHozMjRzR3BiZTQ2V1FlVHV6ZzR2?=
 =?utf-8?B?WUxvNCtvcGw2a3NxUGlNajE0ZSsxL3JDQ09POUwxVmR0Kzl0RlM1VXdKdWNB?=
 =?utf-8?B?WkUvYkxMWjN2bUFQOGtzdkROMTZqeUtKdXB4eTRCem5iRDRqV2wvMWtidjBM?=
 =?utf-8?B?blNiS05HVENCQnR6dTdNc1BRVmVxKzJCU0ZZWmVJMGhUYnhnK1g3c3pGUGlW?=
 =?utf-8?B?ZGpuc0h2dTlnOGJjYjZ2UE1aTHJNNDFpYmF1UC9pUFh0Z0lDQnZDdnh0Z3VT?=
 =?utf-8?B?eWFHVFh6cHkvRWJYc1V6V0ZuazcyeXhIU1BDSUJUYm9mSTRSMUxZMWZDakJR?=
 =?utf-8?B?YTFjYUdIY01NeUN0SGc1RmNyZmdmNVlXelBvZEJqWTNLaTV4UXp0cGE2bmE4?=
 =?utf-8?B?U0pZZTBpS2ZjekFLRUdoekRuVVN0b1hrYTFxd0FNOXpNMm41MFc0Vkw5MllZ?=
 =?utf-8?B?bzVzS2RPRHNGbzMyUUhLVHNsdW83ZGNsN0pRTkkyWHpRWVZMa1ZJam1ORFdW?=
 =?utf-8?B?dDJ3Q28vQzljL1RqaWRGd1Y1K05tNHdrQ3ZidTQ3ZWpzNVlQdjFzTm5OSkZS?=
 =?utf-8?B?VW1XN1V1UGZ3U21xb3p3K3VvWkxVLzVTVGlHV05qYzhqc2hCNHhGTmtzQjNr?=
 =?utf-8?B?NGE4YVJjNzNWaUl4RmdyejRYeVVUbEwxWVNsNjJZbGNCY21RYnNsV1lNenVY?=
 =?utf-8?B?eWFxc3lVbEMvMko5Y3p4ZGxsTGFGMFcyS2FWUkpLb1Z0ZnNwWWdwRlhHMVc4?=
 =?utf-8?B?dkRhRkxtZFFlaUpzOG5NbkozVmNuYTVCQytESGRicnI1ZzA2aFJDRnJGMXVn?=
 =?utf-8?B?YXhjQWQzWDFHbXlOTjA4Q1k2aGo5QmhPMjV6OGdoNTJzbFZKYUwrZDBIZ1RT?=
 =?utf-8?B?a2RJbXZqdERCcE1wcktSWjRwR21mOENwdW5Nc09rOFFkYjhMNVJFV3R3d1d0?=
 =?utf-8?B?a1lqcmFSOGJ5S3pSRGFnWnYzMHNCN1NPUHlzaWdKc0RwMTYzVnFyeGdUd2No?=
 =?utf-8?B?c2xodFZzN0dZY2tVdE1Ea0wvd29lR3JPTjJnYkY2c2tGaW5CUWw0U3BDTW45?=
 =?utf-8?B?eGg2VnFsUDU5WHRjd1lBc1RhVjNCVEdnKzF2VDNtOExSSEFnMTVJQmpXMzlT?=
 =?utf-8?B?d3R4dHEwazA0eWpPWk5Zdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjcxSkdYR0d2NVFFdlZaSUxBRytFVXRoTFRpSDZBOUR2ZW9XTUJBRVRXNDNV?=
 =?utf-8?B?S2Jpc3Myc2NFNmxRU00xMG1TaDg5RnRpYllqTkwrNC9OVFRwQzdGOWJSZlVi?=
 =?utf-8?B?Zmd6NXpHTGljMkUyTkx6WDlLd3JINWx5OTg3ajFDVi9hLzl2bXgwRWhwS21k?=
 =?utf-8?B?NHowbm5tL1IxOGRILzBIeFRQYkQwV1dxakpqczlhMFZzMVlOVVlRc0wvV1dm?=
 =?utf-8?B?eG1ONlVVOHFxRFBBQVJkY2ZoT2FSazFwOXJqamVUMmhGRy9nWmRHbmFmSFpT?=
 =?utf-8?B?WTBFTlI1N3NndllmZ2hxbHJrRmhXVmRCaVllK3NWaGRxUkUrLzRoYXU5dTVu?=
 =?utf-8?B?dUhpV0FnSkwyd2tHQXphcGtJdTE4Tm1YMkEzVm93bHVNT2w3ZjNYV1FPK3VY?=
 =?utf-8?B?Ym56OCtNUm55WUZwN1RsOVpXeSsyYUMzU2gxQlJhSkhzMTh1VUVCTGZRSmdX?=
 =?utf-8?B?c08zYVpKb0JmWGd5UDgxKytIYnF4MEZhSlJTelVWY3pKNm9PckZNYVg5ZFla?=
 =?utf-8?B?cXNmMThZS25lTisxb0JIV3FnTXNzSlI4ZWhRbW5Pa2JveFdXM2ltMmdUQW9I?=
 =?utf-8?B?bUdydk9nZ3hGeFA4K3g2OHQzY09uNXMzWnBnWWF5YXY0Z2l5bFQyRTNlWFdk?=
 =?utf-8?B?MkJMOXNFZzZTb25uYzBENDlLSkFKZ2Q3dG50SEFOWDk5VWhmRkJHZFVLS0hj?=
 =?utf-8?B?Y2VzcEErdTcrWG5qOUJoMkdUK2dWOVIweGFLc08yUncwY2h1QTF0aDE1Y3NO?=
 =?utf-8?B?ekIxV1FvZDJ4T2JPRkFTaEJubjR0WFVsT2FzUVBjSWIxSVdpaXFTYXYzVmx4?=
 =?utf-8?B?UjVoL1hjZ3A0clE4ZmdsUG82djZrVTVkWDdrYVU1QldJVUk4OTFGU1Rrc2Jm?=
 =?utf-8?B?OGdjeW5YZS9jblRtRGN6Q1ZzUFlDb1V4RjF1Y2pMdjNNWjIwYWxSVVFoTWdl?=
 =?utf-8?B?Mm9MUENnQnN2d0ZTaU44cGZVdk5ZQmxSa3pTQTVtR3BHVzg5Q3M2MHovSEtM?=
 =?utf-8?B?ZWpVb09IdDFJa2NzUW9lQ2Z3eGZReEFjRVpWZzFjQmlGeWhXTDRKS2ltVW9y?=
 =?utf-8?B?anNPWWtqNzU4OGlkclpIMFVaUEFxanV4cFdLK08rVXM3M0F1TEhJVmdhV3h2?=
 =?utf-8?B?aHljSkJKdHBZdDJYN1A2dnlKU213Sk9kT0JPdjZBKy9XM1lIOWkraE9zN3hw?=
 =?utf-8?B?NjR4Mkdla1ExdWJBZEdSUXRDcElNbFR2SmF1cVpWenluOCt5MTh4SUYwYllB?=
 =?utf-8?B?SUxWVnFSUG1hYVFGRG1hY2pqV09NVUtQUnY5bHpFYk1KSis5alhsU2YzenJ4?=
 =?utf-8?B?T0FURUE0czEvcGV3NjhlaDdmSFFNbWlLc1ZqSlRxSkJNODVqRWtHZGFMblZU?=
 =?utf-8?B?aXVidlJEb2J0YnVxTFAzTmN3MVZpUVlVU29sODA3bHVpQ2RYVVFkUW5BSmF1?=
 =?utf-8?B?RUl0SVgvVWpEeFM5dC9CSUI0Y09GYmdLY1BGSVVScGs0cEgyZkNVSzgwWk5p?=
 =?utf-8?B?WUpMQ0FaaElhdVhTQzZxMXpQbEpNUzRUbDY5WjBYUFI2Y2VIM0srQ050VVJz?=
 =?utf-8?B?RFFBM2tDOUxpa2Q5U3Rna1BGSHA0MGE1VjlRcnp0dTRzaHRQYlhXL3lGemxx?=
 =?utf-8?B?YkVIeHQ4TGN1dkNJWkVHL1B6U0RZNGNrMFdjVDV0dk4ydVdDaXJCazcxNEZG?=
 =?utf-8?B?aHhyN00vWGdBNnZUd2tlQ2YxK08yWURnVW1CTzRhbnR2YTNRNWxYZWtrS2pM?=
 =?utf-8?B?WUhUdHVlaDdmNU5UMC94blkrblJtdXV6bm1LNE9HWmxQVVVHMWZZb2ZiR0d4?=
 =?utf-8?B?OUhMNE5XMHErWkhJQUI3UjlBV2x5bUdpKzRNamhJMkViWWNDdEFZaldhRkp5?=
 =?utf-8?B?QkpDL3hTbWhMOEtrSGg1NjhCQXAwQUZ4NFJGcHdzRFFDR1QyQ2VuK1BuV1pr?=
 =?utf-8?B?dkVMenlwczhDbDUwa2R1eFpMT3lNbGtYd3Bmdy93eGxIZHpPeDVWVmk1S3Bo?=
 =?utf-8?B?U0dBMEt3cWxYUDRMc0ZGSGdCcWRaQk1jemlBeHNiOXJuS2xZS04xeW1Oc0Ex?=
 =?utf-8?B?cnVIWEs4R0ViRlhMOVJDczQvbUplYXZKZGdONzdDZk1oSldhaUNsdlFTWTZG?=
 =?utf-8?B?Tkk4cExzV3UzcW5QU1I4cGxGbEJCMFVncjJoNFFWc0ppRGpkUllHV0RHNWxV?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f88861c-9dbb-450f-0bf9-08dcd87f9368
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 07:49:22.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zowfcnvhyon14hjJYS3NFQyUEkEGBPoyevAr5bwde2Z1tf15TXx3O0rpFySj9HM4mszyEwQZ33inWv0AV6tj8uS1y/iFgXI46ryKGk72Q6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7681



On 9/17/24 3:36 AM, David Hildenbrand wrote:
> On 13.09.24 20:34, Yang Shi wrote:
>> Enable MTE support for hugetlb.
>>
>> The MTE page flags will be set on the folio only.  When copying
>> hugetlb folio (for example, CoW), the tags for all subpages will be 
>> copied
>> when copying the first subpage.
>>
>> When freeing hugetlb folio, the MTE flags will be cleared.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h |  8 ++++
>>   arch/arm64/include/asm/mman.h    |  3 +-
>>   arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/hibernate.c    |  6 +++
>>   arch/arm64/kernel/mte.c          | 27 ++++++++++++-
>>   arch/arm64/kvm/guest.c           | 16 ++++++--
>>   arch/arm64/kvm/mmu.c             | 11 ++++++
>>   arch/arm64/mm/copypage.c         | 27 ++++++++++++-
>>   fs/hugetlbfs/inode.c             |  2 +-
>>   9 files changed, 159 insertions(+), 8 deletions(-)
>>
>> v5: * Indentation fix and renaming per Catalin.
>> v4: * Fixed the comment from David.
>> v3: * Fixed the build error when !CONFIG_ARM64_MTE.
>>      * Incorporated the comment from David to have hugetlb folio
>>        specific APIs for manipulating the page flags.
>>      * Don't assume the first page is the head page since huge page copy
>>        can start from any subpage.
>> v2: * Reimplemented the patch to fix the comments from Catalin.
>>      * Added test cases (patch #2) per Catalin.
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h 
>> b/arch/arm64/include/asm/hugetlb.h
>> index 293f880865e8..c6dff3e69539 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -11,6 +11,7 @@
>>   #define __ASM_HUGETLB_H
>>     #include <asm/cacheflush.h>
>> +#include <asm/mte.h>
>>   #include <asm/page.h>
>>     #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>> @@ -21,6 +22,13 @@ extern bool 
>> arch_hugetlb_migration_supported(struct hstate *h);
>>   static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>   {
>>       clear_bit(PG_dcache_clean, &folio->flags);
>> +
>> +#ifdef CONFIG_ARM64_MTE
>> +    if (system_supports_mte()) {
>> +        clear_bit(PG_mte_tagged, &folio->flags);
>> +        clear_bit(PG_mte_lock, &folio->flags);
>> +    }
>> +#endif
>>   }
>>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>>   diff --git a/arch/arm64/include/asm/mman.h 
>> b/arch/arm64/include/asm/mman.h
>> index 5966ee4a6154..304dfc499e68 100644
>> --- a/arch/arm64/include/asm/mman.h
>> +++ b/arch/arm64/include/asm/mman.h
>> @@ -28,7 +28,8 @@ static inline unsigned long 
>> arch_calc_vm_flag_bits(unsigned long flags)
>>        * backed by tags-capable memory. The vm_flags may be 
>> overridden by a
>>        * filesystem supporting MTE (RAM-based).
>>        */
>> -    if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>> +    if (system_supports_mte() &&
>> +        (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>>           return VM_MTE_ALLOWED;
>>         return 0;
>> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
>> index 0f84518632b4..03dc43636aba 100644
>> --- a/arch/arm64/include/asm/mte.h
>> +++ b/arch/arm64/include/asm/mte.h
>> @@ -41,6 +41,8 @@ void mte_free_tag_storage(char *storage);
>>     static inline void set_page_mte_tagged(struct page *page)
>>   {
>> +    VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>> +
>>       /*
>>        * Ensure that the tags written prior to this function are visible
>>        * before the page flags update.
>> @@ -51,6 +53,8 @@ static inline void set_page_mte_tagged(struct page 
>> *page)
>>     static inline bool page_mte_tagged(struct page *page)
>>   {
>> +    VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>> +
>>       bool ret = test_bit(PG_mte_tagged, &page->flags);
>>         /*
>> @@ -76,6 +80,8 @@ static inline bool page_mte_tagged(struct page *page)
>>    */
>>   static inline bool try_page_mte_tagging(struct page *page)
>>   {
>> +    VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>> +
>>       if (!test_and_set_bit(PG_mte_lock, &page->flags))
>>           return true;
>>   @@ -157,6 +163,67 @@ static inline int mte_ptrace_copy_tags(struct 
>> task_struct *child,
>>     #endif /* CONFIG_ARM64_MTE */
>>   +#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_ARM64_MTE)
>> +static inline void folio_set_hugetlb_mte_tagged(struct folio *folio)
>> +{
>> +    VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
>> +
>> +    /*
>> +     * Ensure that the tags written prior to this function are visible
>> +     * before the folio flags update.
>> +     */
>> +    smp_wmb();
>> +    set_bit(PG_mte_tagged, &folio->flags);
>> +
>> +}
>> +
>> +static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
>> +{
>> +    VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
>> +
>> +    bool ret = test_bit(PG_mte_tagged, &folio->flags);
>
> Nit: VM_WARN_ should come after "bool ret" ...
>
>> +
>> +    /*
>> +     * If the folio is tagged, ensure ordering with a likely subsequent
>> +     * read of the tags.
>> +     */
>> +    if (ret)
>> +        smp_rmb();
>> +    return ret;
>> +}
>> +
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks. Will fix the nit when I rebase the patch after the merge window.


