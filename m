Return-Path: <linux-kernel+bounces-534534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDCA4682E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA793AD931
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF9225760;
	Wed, 26 Feb 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ATzEWfec"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAA224B15
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591390; cv=fail; b=jNF81SAQtYHuVFKK9krA2GC5OLkZ6RiqA0qwGsFhSLe/KZioV1ByPpFlTA2MYHBsHbsyVq2wB/p5tGsroookmQrqVmgqUuIlSxmkh7sCT+9S4pSN/bOw3otdKuR+53m0HSaXpWSdoBuViZbKZMAORepCPpIJ1CHW8+Q6hhAQDI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591390; c=relaxed/simple;
	bh=ciPIqMqH/UsKjqWnyg+yS6hXCsOEf+/2gl7NAhgoov0=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=H7KSnwO+kZ9lLWJWVDRfidYVY5Xa9So2qJwsxQggvV53XXcrxsr2S5Cor/FGugF8Xu5RSajDTtQbFFogYXccFX3N0LFILywzUaqgurL0TNTk/ElZ+qi5cv8rXZZQjnvQQve5wJ0J/Ilj+nd1Ke9to2Gf7aQcp0JhvHozPynAFME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ATzEWfec; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywnc6O5K57c78Z+66mGQugzgCtG1lGQ48eIk1VZI3+o4qP4IO7bkxD7l6+UXCD5peCd2yTi9WHtrVjR/GhYq7b16+FX5nnEAQKQ7gTt1vBvQu9dQQ3HjCSjtzAJ89uBdQyrz1BMDyIP9/9eDfo2IUmyD9osBOeuObmYbADkaAOOIHHFQbtijLdcinEPRu68ByjKALaZIU8N1CuQmaJIMXVd0CiwbqnxM0tqKi7GaFRGQFoCwYr2pnyH7mw1k0nX8TezwunswC6UyQCQSQB1WLcisZZnWS4gh2WFhZ10tifrjZXN34SwpIV2lG5/P3N1OpFDyEAhc6Zo4SDukQppLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFE4mHTsC8iIqelL7FYsHSSRGHC5RJJAlTFSya4VjyQ=;
 b=Gng1QhO2LWuSkNjvRKwPyrfuI0TFsque0+m717BQWdUfLsSle+ppNwHjclFNtuxbbmSYOLPMz95osCrc/iMAqXcm3GDeEe1YAInSd97CucnAt8pcuavV1GqM+XjTxMS5a6m0if5o8b1LKScIP6fQu5kw24+baCr8aKpnYBKMKv/gwaXhmRAAxe3FrlJOm2Tureg122+Lg2bOroDbUMB8XbiSlseavvKWBk/5amfzGvvKKT1JNmE08i3Ack2+tl/YjWzkJT+GgVxgw7SaI1laS1/jazTXmcHuNgvy3LLP2btv80VGRIQ8n1cz6CaXtkmWezyY8VEZIgt91Qzm5LAt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFE4mHTsC8iIqelL7FYsHSSRGHC5RJJAlTFSya4VjyQ=;
 b=ATzEWfecO7Deukdb+zWtAAORZlK61tuNLUNNE6ja29sqQ5jlpzpb1YFIrBFRfoZfr4L8GhRQZuVgbmOwIt3mnl6MPfkrphrq8VHXfCio2CJC6DTlCTvdPHFXBa/NmDUgsDPcsaJBbqkOpDYoFQtJl892kpZaE2iap7eOx9b5Qlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:36:26 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 17:36:26 +0000
Message-ID: <059ba03a-a892-6a68-6000-c7db3dd6cf9c@amd.com>
Date: Wed, 26 Feb 2025 11:36:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, jackmanb@google.com, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 mingo@kernel.org
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-7-riel@surriel.com>
 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
 <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
 <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com>
 <297b28e9ef9f4cd983ae2e3dd4cf1fce8b74d0f1.camel@surriel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
In-Reply-To: <297b28e9ef9f4cd983ae2e3dd4cf1fce8b74d0f1.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: f3211b4d-f72c-4877-2ce2-08dd568c184d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkFvdzNBekNxdmdCQU5ZRTkxb2JQdktIZXB5ckRHU0QySHgzS0EySnE4R05t?=
 =?utf-8?B?YTh6ZWNuUXdxcEViaHoxZVJYMFpjRUdKRlNTVFR1MVhCbElTOVNqbWhwU0dU?=
 =?utf-8?B?OVFSQUZaVWxPb3RHL0Q1OWZkWGZTM1NmeitYSUhkWmpOd2lBdzNncHVaWmYv?=
 =?utf-8?B?dndrUFlTOHVlUFFGSTRxK2Vvam5TMGxzMGtRdDNYdDR1NEpjbWdNbTVPbjFL?=
 =?utf-8?B?ekN0cXlaSk9xK2FPVHBLSkFqVmhoZ09iOFVHS0RZNXl1MmtGVUxjSlV4RUdm?=
 =?utf-8?B?QU56a09lQTBVOFhzRmVQWTkzcmpEeDExNVJxNit5WmpFdkg3Zkp2bm5LSHZq?=
 =?utf-8?B?YisxcVVweUlQUmVzUGNFc3cvY0dURE5BUjlFekl6eXFFSnpLZGlMVytKRlA4?=
 =?utf-8?B?K0pTSDVPNzVyeGc5TDhrNmpFNVRnQW9pazdYc0JueVoyUW1pdlFvMHk2dDc5?=
 =?utf-8?B?disxU2owME93d3J2a010b1FrOTdXZGNWaGUwYlE4MFhNWkVQWXF5UGJNbnJk?=
 =?utf-8?B?N0hDRlU0ck9BVGEzQ2xCNC9lWnNBazE4NmZFQU5zMXg0UVpPUUhpY25VM3Fy?=
 =?utf-8?B?dVkwOEJlUkEvdWNFVzN3SGJ6cE5jc0RkTmdPNEl1V3lMQ29qV1BEVVhCMDRC?=
 =?utf-8?B?Z1JiQ3FxeXM3UG55T2R4aHYvZk1BOFJWQVEybkJEQy9FMWgzWGZEcmF4d2Vu?=
 =?utf-8?B?eE16RWZyMFJwZHdySm85SENuZ0hHZlpFaDRrWS9WdTl2aVJRaGY3S3ZPQWRj?=
 =?utf-8?B?d2MwZU5DNzhHQ1VvWVhETEdYTU4wZTR4VnFpSnVRL2FIajVmSlNxeVJ3Qmhz?=
 =?utf-8?B?aUlRVjhNWUN5Y3JQSE1EOTd4WkQyNkJkclRYeHJhczYvMGFvUllSMFJWS1Vw?=
 =?utf-8?B?MTRVUTRjN1NieCtuUmFXek5UNnNkUkFFOWEwN0dLblQ4K2tGanhtVTB3eE9M?=
 =?utf-8?B?dXM5cDZrV2ZwWHAyREhkVWhYNXZtNERweFZadjgzcmZObzVBU2NBcXJ2SUFx?=
 =?utf-8?B?K3FnY1p0d0l1d1BOSHliSUxpQVd2aE8rVy9wTXpIbEVxTDYvazJieExTbk90?=
 =?utf-8?B?ZjhHVWN3RUZ1c2NWMlBzREgvMGdNd1BNMEpOdXpZUWVScFc0Z3g3OVIyaFJy?=
 =?utf-8?B?dHorTzB4ejNpNjQ4d3VLakp1TEtXOUY2b1E0LzBKUy9aUjJNb1pBemZGNzlx?=
 =?utf-8?B?cDQwZzlERWkvV2ZKV3Axd3U2M2Izcy9NRTNEUzRuUGhKSnhHUXRNSGo5YWQz?=
 =?utf-8?B?aS8xakFVb014NmhCQzFmakJza3Y3aVR3VEYxdWRldWpVTDFlV2JQS0dYTCtl?=
 =?utf-8?B?OTcyRFVESGMySmVscXVnaEJ4M3pEazJIb0VaSVRhQUZVUlBnbDJEZGxoSkVr?=
 =?utf-8?B?ZFR0cUdrVkZXV0YvRE9xMmNiWnB2U2ZEUEFCTmV5dVVxUFJqSFJ2WG83TDR6?=
 =?utf-8?B?eHZnUk9uVDQ1WWhteEdKNmxkd0FOWEJGcUdLNExTN0Y4L3kxNzg5TmJHODY1?=
 =?utf-8?B?YlVOUGpaZEpLNkJDTzQwODhnTWxnaWZVaVFjT2ZRMERjWDM5SzBvdVc4eFhF?=
 =?utf-8?B?ajhvQkpSbU9GMFdDa2pDN0NUUEh4L1BGTndQSS9QcFB5TUpxa1Y0OVlXbzdt?=
 =?utf-8?B?QmdCVjBXWTNPRVpSSFI5YnBlcWVBbnIvVHpZbVBWWDBkMFNlRWtVdk15bWtX?=
 =?utf-8?B?enhrbDR3endWLzdpK0d1TnhCbG9pYWpsM0J1aFFnNXROL3VCWnhmeUpRNG1p?=
 =?utf-8?B?akM2V05WSXVZS0dyejgwSUt6R29NSkZxN25BeU1pMUlrM1NOdjYyWkpoUzlt?=
 =?utf-8?B?WUVXRU51N2wvdGwwZjZDQTlUa2IzbXVrYkVHZC9rZVEwbHk5UFZNM3NVUmhi?=
 =?utf-8?Q?qNbIhK9iT6Ukm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDRKUmVXRVBZUCtEcXg2MVNBUzh2Q3BRYm1kU3V3WjZ5RXlHU0lKV1o1NzBl?=
 =?utf-8?B?TVZTZkZiYlQvZllGbGZabUM5SzdxQmo0b1cwaGppcVJQRGplWmsxUTZvU1Uv?=
 =?utf-8?B?ZXNheFB2aGZpbmN3emdpT25HZjdIb1pIR0pQTkxLMzZGb0NEa0ZIOFdLdVhP?=
 =?utf-8?B?Z0NBNitrMUdtc1Z2WlI2U3REbUxkQWJVcGVyQXFqcU1FZjh5aEM0a1pyV3BQ?=
 =?utf-8?B?SGhWczRGOHdvUlBxek1KZTdBelZkN0YwZFNxYUJFdGtZbERNaHVRYWt1dkF5?=
 =?utf-8?B?V1duK0xzL0pHZ0RKN0huSjd0elRUU0I4d0NSUmNsZXZTQnA1Tm9ScWNjM2pn?=
 =?utf-8?B?ZHBGa2RHRmtFbmc2NHNlQlg0TW5JcityVWhkR09LTk1xUEM3NFQyK2FSdUtp?=
 =?utf-8?B?WDM0eGZpSVU4dCtMZmJIL0pzai9pazBmWDVPZmRGZytjc1VuNGVNM1NRUjZl?=
 =?utf-8?B?MG9DRFhZU1VuZWxNWVhQNGJ6Q2hmanZLY2JtYzFJVE1aMFcwRUFhU3o4UW1N?=
 =?utf-8?B?Z2F1SVFId2hRTnJiSzRlWG0yZE0wWXp3dTFxeTNrS0FVYkhmOUdCMkFPNTFO?=
 =?utf-8?B?TTdlM1c0TTJQZ0xGQ1B1YW5JUFlORkdUeDV3eDV6aVhnalE3YnU3bXJOZkh5?=
 =?utf-8?B?NUR6U25kQjNlZm56S2dSaGRvVzBCYWtyZDRVblZhYVRCRFBwb25TUVFkOTNj?=
 =?utf-8?B?UGp5MThsNDdOK2F3ajdYcVdEMC9pcFYxWmJSeVhyVml1cmVUaEVSTEhZZGd2?=
 =?utf-8?B?RXpuTGxsejJFZ1Z1SGRabURwK1JaTzNmK3RJZHVjN1BEWVRmRThaR2dnK2xY?=
 =?utf-8?B?MWZMUUZkZE5VSndlZW5QQXNHSE1FSlE2eHJway9QRzRVR2lhWFprd3I4UGFo?=
 =?utf-8?B?VzV1VjllbDkvQzRFcFo0aTV5Q0FUbnJhTlJ5RFBBVFhiRVFWaU9TRlN0bEY4?=
 =?utf-8?B?UHpnOVdFdUF3WnAwOXZDS3BxZ1QwNzFlQXJ2ZTVlblF4dEtMNlFRb2RldHRG?=
 =?utf-8?B?Vkx6UStyeFRvZVZlUWRhSDViQWN3a2FDWEhGVHVNeTVUUTlWRkhnQUFZOXpK?=
 =?utf-8?B?Vks0WW9aUkZGTjI0Ym9FaTdRTzlPQWpTR1N4UFExOS9naklZeXgrWm5lNG1p?=
 =?utf-8?B?bU1qYTNBQ3pzeUhVcXlXWTZHOFlTRDZGQ0tGcmVhbHBpS3BGNi83VFU3OC9n?=
 =?utf-8?B?Z2plRUhSTEFlWllLd1JCNVpMdXl3SXdqVGp4RmxyUWVPUlpCbTd2dXBoa0lo?=
 =?utf-8?B?OUhjNi9IUDVZTTlNVW82NUx0UURnSTBmclFTUlNROVJuREJmVmg3MjFMdjhZ?=
 =?utf-8?B?TEhMOXM2NmNTc2ROSHVUUTBGUnVib1JLVDJCUm8vREExKzdBLzBaZENDQ21Q?=
 =?utf-8?B?bXBYM28wOGdlaUVTYlF4QS9mM1ppQ1lja0JVREc4aXNDOVBLMlRESUFsVGw1?=
 =?utf-8?B?eXY2c0Y2NEtrNUZzNXBsKzZyb3pBVnRMQi9GSjlMVlYzNGtnanJ4bUp4NEdZ?=
 =?utf-8?B?aGJXRHV1TzFPWEdKMms3YXMrODVwWWQxY24yOXUrbDViWEJxb29pYUVsTGMx?=
 =?utf-8?B?cS9zMWVKc2Y5dS9xUWh4Z0hVWGVTTnJZZ095YmFhZ2RMcHR5S09CZmtzVXBi?=
 =?utf-8?B?K3I1bEdqTjhzUnBlamo2d0IxcUJCeXJMVUR6QXlqUVFwdlFCNTRKQWVET0VD?=
 =?utf-8?B?eEpubklER2ZWOEJ0NUtITHQvVXMvdWdFQmw4WlF4bjdMSmJkLytLbDdIQ1JE?=
 =?utf-8?B?OHVNdWtYbHNFZTFDSGxrU05Ec1hicjNXUzhpUSsycFk2bjVnQktMbk1ZNEJ5?=
 =?utf-8?B?bmtFY2d5K0U1N0F3VEV1V2pLOU9LeEVURk13MDU2SE9pOXdMRWt6RkFnQUxa?=
 =?utf-8?B?cHhwRTlWTEdpTG9oemMweUlldE84K3B0L05zY3hkWDEzQzQzSEZ5enZIOUtu?=
 =?utf-8?B?Z2xNYmNFMk81OW5PQlQrNG16SXovQWp4b0drQnVHbW9DNm9NQTdMS1NhSSt1?=
 =?utf-8?B?eDJuSWMzcUpldFVzcFkydkpyMXRYYVo5UHJWNFVpdjdEeTlLYkZUckNZZVpU?=
 =?utf-8?B?YlRLYXVEYW16cG5Kb3dhTHh0UFNJWUIwQi9ERWFGRUN5ZnJ2dkJNY3ZpOElR?=
 =?utf-8?Q?mkrdBPQoWZ8HbgKFOH13l94Hf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3211b4d-f72c-4877-2ce2-08dd568c184d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:36:26.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKFrC+FkSw+Ul5cs5QplKKVpnQSKxFujMtY9wFtEq+uz4Xbwbl4xCx69NYNNow9h0CtT131/MCmGaUbm0fk8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

On 2/26/25 11:02, Rik van Riel wrote:
> On Wed, 2025-02-26 at 11:00 -0600, Tom Lendacky wrote:
>> On 2/25/25 15:03, Borislav Petkov wrote:
>>> On Tue, Feb 25, 2025 at 09:38:03PM +0100, Borislav Petkov wrote:
>>>> On Tue, Feb 25, 2025 at 02:17:20PM -0500, Rik van Riel wrote:
>>>>> Who do we need to ask to confirm that reading?
>>>>
>>>> Lemme figure it out.
>>>
>>> Confirmed - that really is the case.
>>
>> Hmmm... since this is for host/hypervisor TLB handling, this makes me
>> think that we should always be setting the ASID valid bit with 0 for
>> the
>> ASID value in EDX[15:0] on all INVLPGB instructions in this series.
>> Otherwise we will also be flushing any guest ASID TLB entries that
>> match
>> the conditions, when that isn't intended.
> 
> The ASID is always zero in this series.
> 
> We only ever use the PCID for address space identification.

Right, but the ASID valid bit is not set, so the flushing may match more
than just host/hypervisor TLB entries.

Thanks,
Tom

> 

