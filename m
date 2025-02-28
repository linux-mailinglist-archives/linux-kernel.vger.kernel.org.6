Return-Path: <linux-kernel+bounces-539448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BCA4A45F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D88161B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7F1A5B80;
	Fri, 28 Feb 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fbX7dEtD"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1F23F36A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775385; cv=fail; b=keS/Qn5ERGPcDV/hG7BViL4tjdVGH1ugBgrXPkp4u0HT0CUeqHxS2NysVP1ooEOnZHu0apr/0Qz1p5F5O19OCOcqcip+jBURweGIFQ629jA5ba1/fSOIvuaz14t/V9aUUb2hh34Q8SxjVhu+A4ZnFb/4/MiqiFQ9XzN9b0rtpMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775385; c=relaxed/simple;
	bh=WrRQSfeKXQfMvyk4lcvA9cw1vRqvZvBzEsOY1v0j78c=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwLKlBripndq7nRSUJfC+NQh29rcAjq7dHSEHtpiLLIbQirNQdkvRdvKPge011NObMKg6DeEKv2GP9pRfHzT4C92dNgkjAVOzlyJlQ3VryIRlbgGA3WDX+L8xRS7iHo8Ga3VbLgrmBte8xufQJEQI94GQMFMx1uztv5iblm2F2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fbX7dEtD; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYAAJS55CwOzHK3ytykP4bqlYuxspCr8xGCm+550JjnMaMyyVbuvCGE7B66+j+VhySxXyYAj/5gwEMVwNG4qIRxBVXf6hhch3MgjqlATY/5pk0pprEPV3ASiWba6/xipGnj+be3S2RyrA7NOJ7NtEiewDqqpRhXqqm2uyZ2szrA+8hjVlSym/PrhFaRc0TsS50+WI2MC5nnsdSJYLCTY1UquuOnHXIJ2QKcgblc/BSrgRQSZra+AYW9qPqPgPewDN+wxnVYtz0Y5qp2WuOBR24cGerb/GP4Qvg9bcqcqA6To1ta13SPWa5t4fI8psrCakOwC8zs/OjH2Pt2wsAqjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKMwseS52GboXNIU0MKhh9Gi6JLsSWnGvqdNx+k5DSo=;
 b=AOR812TbVpI6T6O3nvq1H5pOscC/2qRuC0qRy1dInI7aA1vvUqo0BC8UzB/CPyJPOODu90EG3gXFXFngUU5ZSLN0+b/uE9bhisDoQzqvc7BXU8NBz1L+VcXonI2dymtLYfR5lKJOeLqpk5gIN8yiw7SQcgkPmm+5hJVve/bnpFQGEadZ1Xha/BDF53+0qHVCWKg6XkGOX9MkOqXlDk7oHIQDRi9f+zsSNutB4oYPDssyOA3pz7WtHuB5UrDoNtarqxLXLbJdCPf3r/UPxlWXKCHt6dnatwIQ8Xg5lsGZdyxFA/L4z5c6qf5RQ2wxV92OXflY4YraTPx6lZSNJahw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKMwseS52GboXNIU0MKhh9Gi6JLsSWnGvqdNx+k5DSo=;
 b=fbX7dEtDWu+qn0LzWfc4yXXUZrinDk/yfb9NR94z8PiJurexf8j/qM6huImD8499K9U5byukBPxmsT6apncgvUtr8HDH7hc5orZ1qscy+m1Yhncc1DVJWQVvXL3DfE2CtX7WA19eoe9IQPB4qjL7B5k9sosoMPNKaTinjkjl8nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 20:43:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 20:43:00 +0000
Message-ID: <ab0516f6-0fda-b03f-01c5-a64b9b5f04f5@amd.com>
Date: Fri, 28 Feb 2025 14:42:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
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
 <059ba03a-a892-6a68-6000-c7db3dd6cf9c@amd.com>
 <9086371cfe69760780d67ec279f69e91f65086a7.camel@surriel.com>
 <2731f073-d529-7870-6d25-ebd2e44cd10c@amd.com>
 <c6a38a1b6f27ae787dbfd99df225f464c274590e.camel@surriel.com>
 <75e45ec0-25da-45c5-827c-ee048c0ebd86@amd.com>
In-Reply-To: <75e45ec0-25da-45c5-827c-ee048c0ebd86@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::12) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: d307d779-268b-4250-1b87-08dd58387da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2NlQjBEOEpRVVYxZ2xaSGVWK0RZby9zNldVMm5OaU11ekxMSW01YkpiSGla?=
 =?utf-8?B?OUxyYTVaT1Z3M3VUSVlMTWNGN09QbE5YWDk0STFpR211WjJ2UThEZzFJM3hN?=
 =?utf-8?B?azJ6dm11UHFPUGkvSS9JZ085aGhDbUFjdWYxQnhYU3FQRE9CRWl4T0NwQkQ1?=
 =?utf-8?B?cFdWOTNrNVdRazNPcFNJa3V3MVY3a05IOUplaUV0OEFLR2hKRExWcHdjbkJo?=
 =?utf-8?B?WGo5MTdqUlQrL0RGdFhxWGIwY0xNWmVob05OS3d1NUYwbVl2VmVKVjE4MVpM?=
 =?utf-8?B?ZnNTWTZUM3plek1Rd0xkUDF2UEtqQUwwdDhYMFp2bDhQekpOTzBrU1ZqVTdP?=
 =?utf-8?B?c0VneFdpaFBRUEJ0MGw4cmJiM1k3MzllNS9YcWVtVlR6bzM1VWVSc3M0WC9F?=
 =?utf-8?B?VmNmMUx0Q0V4ZGFwQVR4QWZvZjU2Y0VmL0ZRRzlhdmd5V1B5SDEvL1FsdVpi?=
 =?utf-8?B?UldGMGYzbjgxVWcxUW9QME9GUEEvN3RUcFJhT1VaUGNmc0xTRll3aW80Q3Yz?=
 =?utf-8?B?amJQUVAzTFlENGVBaktzb2tZUnY0VGhJbk5YcTFqc3kxQjR5cm45TDM5WElI?=
 =?utf-8?B?bllKWGE5RUJ5b1lWdEFCVFJreUtjL0xneVN5YVROL0ZZbnlEN3NHN0gzVXpF?=
 =?utf-8?B?YnhGeSs1NGhQSkV0YTlWeTRVL01YbE1pRFBvZC9XeUdYbURyVGc4bWtENTRa?=
 =?utf-8?B?RUNPZzY3S0ZEMzZBeW9kTktyWVU4eXdRNVcreHA0aHVhRlFwVHNSVUNON3RB?=
 =?utf-8?B?dHV0MDBzNE1Dek9PVHlHZlk2WE1ScGx2NzMvb29wZ0l3VE4wNGUweWRtR3JI?=
 =?utf-8?B?U1orUjgyS1hMdHgvT1d6NitWbTlUOFpXZ29hR1lJT1VnK3BUM2o5YmYwbGRK?=
 =?utf-8?B?V2hBMWpKOWFRN3F6VEtCNXZiRVVlcjArdlJoc2l5Y0Y5T0FYWURQbzhUdE5P?=
 =?utf-8?B?MCtPOFN2ZmVaQjJhM01uVGwvSERlQ2NSTm5MZ2wrdnNFTWFGcEVDc0pDdzNX?=
 =?utf-8?B?M2Q5VTFzVGV5ckFKTC9LemdhNnlFQ1g1MFl3M2VaM1pLYTIyTzBXRi9GNTY1?=
 =?utf-8?B?SVJjZTN1UURycmJTbU9PazB0dDlQcTh0REl3RU9McWNmUWhtQTlkME03NVB4?=
 =?utf-8?B?SzlxZzFSa1pESlROamxnZlNuWDM2STJJd05hVjYyNlRHdVNqUkgwQlpNUjhu?=
 =?utf-8?B?ZXUwREN1RnI5VXdGSjhvMllBeGl2L0ZRYUJvaE9NVUNjT3ZFb3g1S0FqQjV6?=
 =?utf-8?B?R1NMaUdnVDhxYStHNmJrcnhwZ05Wb1k0Z3dCQzRCNG0waytRZ093NTZjUnha?=
 =?utf-8?B?UWIrSkc0UlV1YThTSXFzYUVXMUVYY3lRcy9kUmFCK1VQS3FjNmNNV1JKendj?=
 =?utf-8?B?MEEra0QvWmZkNkt3ZEtSWTIrZDdxNWxoSGhvSTZrQ0tYWHA2ODRJMGZJVlVK?=
 =?utf-8?B?dHV0YmJ3cXBJMW1wd1B4ay9EMFo2UzZXRGlkdzZOLzVqNUdVbkZzOEVFaTZj?=
 =?utf-8?B?NTBVYzhOb3c3WUVDTTFpVy9zQktaTW84b1ZmaWlpYmV4bmxHNnhsNUNHaTVm?=
 =?utf-8?B?blkwZzZlaWRxUDNrUll2WjU0VldWUWd1QWEveEdvSUFhanpEMlRWcFlyaHlK?=
 =?utf-8?B?R1hPMFdRN1U5ZDNodGdWTDhac011ZTJVNjlJWGxuckJZamU4dk5ESFVmbjdS?=
 =?utf-8?B?Tm9VQ2kvVUNRQ29wK21STGx3SWkrbXRjTmVoTXlWQThza2pCQVJ6RnFZU2hC?=
 =?utf-8?B?YXlOVlBZMWRuTnlIVTYybUhHUk5rRGo2UE0ycm1HZXVEVFYvek5YUUlQbVNx?=
 =?utf-8?B?eVdnVWxWZkI0NHI1ZkN5ZzZuUllyZmFmVzE0TTZBc0ZYK2ZxWnBYZDVOajdt?=
 =?utf-8?Q?d/6XEZ5WLzL9U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1VpaEthemJmT0tGanRFTjhVYW51Tk14Uk5jdnpuR05Wam54N0wxSmZQeFVF?=
 =?utf-8?B?dXFFZGFtaFQzanJtb2kxVkFndks5WU04V1RwMVZ6OWQ0ejFhV1JQNis1SDFW?=
 =?utf-8?B?R1RxaWNONklwQjZGK0hqMzlUQUxKZ3pDazV3YzNFWDB4VHhpTWxucnFqY3VJ?=
 =?utf-8?B?RmJqVk4xSlUra1ZmeURBWEJicEZYdGRuY2JEVE9sTG5JUG9KWUEvVzBNVG52?=
 =?utf-8?B?S2VRREJTTEwxa1VJQWtFMEZjUVVBWTZrRjBlb1I2RG8yd2xlc2NWOUtocU9B?=
 =?utf-8?B?V1hzVFRaZkhXeC9Kb3pkNThqR0pyNXppdVJmSS9QWVhTUWN1aDlPOHFUbEpT?=
 =?utf-8?B?NCs5TVRhUDJWcDJDam1rd3hFb296anRtSy9iTWNZSVloWVhFNWhUSGs1Nm85?=
 =?utf-8?B?VitYYmU4em5iNUd0cnhpcXd6MnRML2pFZThrY2dIZmxZczhoK0pyWXlCQzlS?=
 =?utf-8?B?RElwNEZVdVBKdUU5Mm9wK3hyV1FqUWJjaUcvYkN5dDRvNDd6WVpSa3lTQTJl?=
 =?utf-8?B?dURqS2RseHFCMTh2N1pLdURLazJydEdoMFNCdnJRM2krZlRadzgycDJKd1gz?=
 =?utf-8?B?V1JNSGxDN2VteU0rcjgvTm5DT09qSW9DNVZyWUh5dzIrZVoybDBDU3BlNlVI?=
 =?utf-8?B?YkJVU0hLWXh0dEZwYy9tTXRnSlZxOGRqUXF6cjd0Q3l5QkM5RkVUejJ3Lysz?=
 =?utf-8?B?U0RZdjlvamtmM0hRSFA4M0VKb2tBa3NTbVJJM0RqdUNZL3U5RWw2QVo5VERU?=
 =?utf-8?B?VnMwUTF4RVUrZUZhaEM1ZmNadVNhNFRQNmdES0c5eEEwbzVIcDdwVnEvVFZp?=
 =?utf-8?B?a010SVhxMXMxSU4yTlZSTmY2clZiZDlCODNoUFlPUms4SVpuWU52RllLdDRy?=
 =?utf-8?B?b3NkeFdVWXhwcjQrS2tZWkxkOXcvSUMrYnFsRFQ1ejdKdHhMSUEvVTY0aDVC?=
 =?utf-8?B?NEFtNFB6YXpYeXhpRjVGRTYycmFibFhEUWNTamVKL1d1dTRHblVDVVpYL0RF?=
 =?utf-8?B?dWhtRFBiLy9uS0hEK1ZHbzhWZ0RxOU1ITytIYVFsa3FwVnBUMmViaTF1dHJs?=
 =?utf-8?B?SzFoaGhiYjNPRkNIZDF1K01LN3FDWVExYUx1bnA4Q296UVhoV2pMb2xtMkow?=
 =?utf-8?B?NmdJM2ROQjFMNVFkMUdEdTJlOFdtR3NVNGdEOHUxczI1RGRWemEwNU16Zzhl?=
 =?utf-8?B?T2p0Ujc1Z1QwSjJuSksxN3pLZmVMNjNuZDBuUU96WUNCV3F3aG41WmhCMHNt?=
 =?utf-8?B?dFRCTGZnVkRLR0Zncm5tc0h6SEpYK2o5dG55a0x1WmxjZnExenBJS2w0SW9q?=
 =?utf-8?B?d1hHR0d4b0lZRGkxTXoxS25oSEZYVnZIT0F4azIvdFJGeTlmY0pOSWZrREtu?=
 =?utf-8?B?dW1CWUVMSzRGcnRHTXk1a21pSC9mdjNSa0xmZk9oVi9vaFh1R0ErNHZ2NGxX?=
 =?utf-8?B?WnhIYzJkblVETTl0T2ZEei9YeTVqdmcvWVRtdTVRdHFudVRxQ0hIbE5mUC9z?=
 =?utf-8?B?WUZpUklzVEdiL1l4NFNjeXVaTTJZNVdqaU56R25wRmg5NStNaWVYQUlsKzJ2?=
 =?utf-8?B?bDI1YnVrTjNzSmdJNXI4ZnRieHpabG1HUzVlS2VFdGhaUFp2ZHBENlVPQ2Ey?=
 =?utf-8?B?Ukptbk8xUkRiay9NLzcxV2tzVUhtWnplU0VOYjFTczVTM2F5TEJLalhvdFQz?=
 =?utf-8?B?MFl3d2hrbHRsUTJDdzZieTUxWFRPWGh2WW4wbm9KQlo1b1N5OVVDai9XL0Ro?=
 =?utf-8?B?UUlvRHFXLzIwTjc0T293azNKWnlwY05UWng3N2lrOTc3anNKb1h4Zmk2OXlT?=
 =?utf-8?B?clh3VW9XTHErU3Jva2ZQSUFMa3FiV09YV28rQzBWWmVsSFJpenh6Rmx2UWdj?=
 =?utf-8?B?K0xuNDFZSCtDZ2piTklFUDFkcWxHQnNXa2hycEdtTVJBV0dqYVhqNk5NSno0?=
 =?utf-8?B?Q2x6dzBEWDVFcEtSMVNqQlIzSlhvdXBDRUcrZ3YwemM4KzFuWVlDK0ZYMDZq?=
 =?utf-8?B?eDRYZkozc0ZHWjAxMmpLNy9PMzRvQklPRWJZWVUwZFRLNHJxN2dVZUt0ZVpl?=
 =?utf-8?B?UHFkeVdGZlNoR3o3OFNpY1RKTHo3dU5SU3lLMmZDTlJlQ01yTklGSmRoVHdh?=
 =?utf-8?Q?YnMqg5f6mn0QQ0xzBy3VbK3xl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d307d779-268b-4250-1b87-08dd58387da8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 20:43:00.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/8LFx3MkjLCLK9C//ySh2gWm803JJdh2tpkSYxtuGHe5YAkTIBzNJiAvXdLT5rgp/DJmGghQoe7sObxm8Suig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467

On 2/28/25 09:02, Tom Lendacky wrote:
> On 2/27/25 19:13, Rik van Riel wrote:
>> On Wed, 2025-02-26 at 12:12 -0600, Tom Lendacky wrote:
>>>
>>> As long as you keep the ASID value in EDX[15:0] as 0, then you won't
>>> #GP. ASID 0 is the host/hypervisor. An ASID > 0 belongs to a guest.
>>>
>> I've been spending some time reading the KVM code,
>> and I don't think invlpgb would be currently useful
>> with KVM.
>>
>> From reading pre_svm_run(), new_asid(), and svm_vcpu_run(),
>> it looks like the ASID number used might be different for
>> each VCPU, assigned on a per (physical host) CPU basis.
>>
>> It would take some surgery to change that around.
>>
>> Some googling around also suggests that the ASID address
>> space is even more limited than the PCID address space :(
> 
> Right, to support using INVLPGB in guests you need a global ASID, which is
> an ASID that doesn't change over the VMs lifetime and is used on all
> vCPUs. Global ASIDs are only available and used today with SEV guests. At
> that point you would not intercept the instruction and, based on APM vol
> 3, the ASID value is replaced with the guest ASID value.
> 
> "A guest that executes a legal INVLPGB that is not intercepted will have
> the requested ASID field replaced by the current ASID and the valid ASID
> bit set before doing the broadcast invalidation."
> 
> So I'm in the process of verifying that issuing INVLPLG in a guest with
> the ASID valid bit set and an ASID value of 0 (EDX[15:0]) won't #GP, but
> will just replace the specified ASID value with the guest ASID value in
> hardware.

I verified that when (a non-intercepted) INVLPGB is issued in a guest,
hardware will set the ASID valid bit and use the guest ASID value
(regardless of the value specified in EDX[15:0]) before doing the
broadcast invalidation.

So the implementation of setting the ASID-valid bit and specifying ASID 0
is not incompatible in the guest.

Thanks,
Tom

> 
> For non-SEV guests, INVLPGB would need to be intercepted and somehow
> emulated or just not advertised to the guest so that the IPI path is used.
> 
> Thanks,
> Tom
> 
>>

