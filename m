Return-Path: <linux-kernel+bounces-374810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D79A7084
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3940E1F21757
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8351E8852;
	Mon, 21 Oct 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bHND/ts5"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D025FEE4;
	Mon, 21 Oct 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530279; cv=fail; b=NkPGdyjVr9LnZQIijTxVFKMuYTsn9x/AVYE58KC4IubFGiapCzLPj2kmgWPC804DWt3/Y9iTeruHevqOuKU6biJH8bQuYVM/Frs3fSJURfaZrMZeBv+faTwfsGCrKLzLlRFagjwl5yVKLicvUCphvHLmbaIBfKgNLNwuHffL7ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530279; c=relaxed/simple;
	bh=t8KYRoPSZCVi/E/pRrUiCH9Kg9EICyDfeElpCp5R6Oc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ISEPuR73UbTubblsP2QiOEJqEBFoFI8vjR0tTGd6UXeMTyMp6lPGrMr5IrzHgj55Gmi+TI9YpNa9dhT6vjyP1Zg+ms5ZHEhsOkBd8lFplEnvZXfBFXLNefMow2UHAWN9XypzAcPf4ZyhOuG4tSRVj/DL7i+fEwNk7Pwf0ea1oI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bHND/ts5; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwQMP/tYWphKRD3G2L7bYHQXhHlRXOZ0E60TIPA4K3tXOGaKggh+IFUbDLswJwmFoqlSwqi5Ll92w8V1nhDXDYcC7R+2BstaDcYrvjas1Ipw9kUL1y/8XS0KZoJnCB3nfmWxqJ0aj1nUuUNvlv56K859PNrx81SGLx3nOjIeNGwhOWw5RsmNpkkY0sqogRBapt1Ft8PP8nforowmdl1cIGOy8pu90gmpRTPXfWAvDbbKtSpUKOfns9XOE2Qf+Arg3huDQAHwj3552DvDUvGOQ25ioubp43POp5UYoMqiW9iBR7mMbRGCSinmmWDVcOxTPg3XdhmwSh2IUfrMFUYaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0DfCTIn0pdGCWGbYpqMudyNxx/5fjcM0JcYoYkAuQQ=;
 b=MZIgD61ukLSpDPBCEyxYNonr/k1GXnVSLN7bCpv2/RvUhp2P4GFpDO8hlJUJPi+G7MGsE7H64J9ideCscIjwyVL91qCGlgiQEXnCAX/LaD2dlD48UFkvqswxwRCbKJuei+8kCaut0Gp53GfnMbG3nCnFolprc/m3g3DX+DuucPTX0WfmG/Zvh4Uqj6R/ks3Lc620xSvG5BUPJ7gJl+oPuuSDfEaSuRylkQ7vMLHPwtuFMf4hgZXCGo3U2Xq64XbIR3Qrzlf3iJIvALoY2fqmQsFjsVXYmrQMwh7JTP//KpEb0SIyJar3ZpRk/w2GHpkawPEvTXj9d+aXlM51ylcPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0DfCTIn0pdGCWGbYpqMudyNxx/5fjcM0JcYoYkAuQQ=;
 b=bHND/ts5QWcThgEM3VnutLRwuYObVv0W+MJJjzwbpMtTVtf2wduuAK55nXYb725KJnwMJIt2Yfoxs56eJ6REfrXRGCKn1SgIgWY+yhIHVFzFxe4iC3CjmqcnVZSYM5pkHbuI2r4V97VbJFpPUwTDh+qXZxsGOK9pYWnuNEOKKJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 17:04:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:04:33 +0000
Message-ID: <d5d7706c-0c12-46bf-9a4d-9bd80db2c83f@amd.com>
Date: Mon, 21 Oct 2024 12:04:28 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 25/25] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <c3c12e970a660c32088a447f9961826ec3a9fb24.1728495588.git.babu.moger@amd.com>
 <faf0b49e-b379-48d2-a14d-ad931bb46883@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <faf0b49e-b379-48d2-a14d-ad931bb46883@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0048.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3287535a-cf26-4b24-d205-08dcf1f26f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmZESG5pQmk5eGgxNzIvZnAzeEZOL1ljSTlCUlh0bGhFM2xRUDZUeEJLZGpJ?=
 =?utf-8?B?TVh6MlRqek5hdzdtdUxYN05Zci9RVi9DVUdKSVFaRVhOVTVaRUNSQi9UNkRE?=
 =?utf-8?B?NkpLREtqZFFkd2xBZXN1VUdud1RrVDhsMkpmTUFsUit3K1pLRWc4OUhCbjR4?=
 =?utf-8?B?YU5lWXJPSjBic1ZnN3hmaUUxMGZLV3NTT1JMbWpwblVFN1ROcWtRS3hrL04z?=
 =?utf-8?B?QW1TQmpOM2ovQU1lTk02a2p0aE1ESUJtQVdJZk95akw3dU45WW40Y29YalBM?=
 =?utf-8?B?SmFwUjZwN2s3Mi9XSkJ6UnYycUhFYm90UWtReVBBUVdyY0txZC96VmVuR2ds?=
 =?utf-8?B?MTU4RFdKVnl6Z09PZ0Vzc0hOYW1KTmYyUkZmbW5MdjA4Q2kvWGxIZkMvclIx?=
 =?utf-8?B?R0FoZ0ZCUEJScFNUK0crMHVLTEw4a3E5TXh6endiYWQzTUN3cWlWMHZhQ3Jm?=
 =?utf-8?B?c0VzZWxZaDlIRG1OeE90VzdxQXF4M3ZXczFxM2IvejMvOERjcGtVR1ZOQU9Y?=
 =?utf-8?B?RWJwZ3FxZVA2S2VuWk9VQW9iajZIOTdOQ05zZlp2WllNM0pKZ05sWUNISTdN?=
 =?utf-8?B?blhiSDRnMjBEVWszUitBVEIzaFNkZ0dhYy9jVklVM0VsTG45aFo4OFgwQUQ0?=
 =?utf-8?B?MWYyczhyenh1NzZSZmhrWHVXM1dNMngyeEJXR2IweWk1azc4RG54WStHMmlU?=
 =?utf-8?B?ZGhOMzBIMlRrQVRRbU0rcXI1NUlhdW5oUHQyZDJnQkdSU2VBOHlRc3VrU3NM?=
 =?utf-8?B?dTNmYTRYNFlqdEtRb2tkejZHWXI5SWRBaFg0L3FrM05tbE9MRVJSRnJVR1Iw?=
 =?utf-8?B?NXVnM2E1cmphT2x6K1JVUzZqTzBheW4rblZCSDcxMExFOVBBTTNEZFpUSXRs?=
 =?utf-8?B?NVE1Q1pHTkJpODIvek5JNzdET2ljby9ReUJoWmEzNzlqWWRVdlRFWVpJZFlz?=
 =?utf-8?B?QzJBVUpQVnhzWEx6cGNQald0VUk5RmwwUk1UeUJtRWFXbDhvWm1tMk9HVm1G?=
 =?utf-8?B?cXpsTit6K2xyY2FNSkx4SHhaKzEvUlFNRDNBZjFQQU1GQXpFQWtISU5Wdmph?=
 =?utf-8?B?Ukdta1kvb2ovQzZkaVJrWnJ0bEtnVnhhdVJHajBGMkl3NXppZGE3azNPakc2?=
 =?utf-8?B?YUVMdUdDNkpxRXVHNnN6L3NuWUVCOGY2R0hJSHBONGZqVStEcmtnM0VSY080?=
 =?utf-8?B?YlF4R1prM2NLQkl5R0QzaUpxSHlNWG1UdzlnNmphb2ttWHBJOW84bzRnUnlG?=
 =?utf-8?B?cDFSMEQrQ2hnMk10b1ZUek1aOUpOL3lQUGptbmczQ0ZIOUh0dHI3bWVyNXBK?=
 =?utf-8?B?OThXNGFyblBycDlUVHRSaHV0ellNYTI0L2t4RlhxZXZNR1JQRkdVelNmbUhH?=
 =?utf-8?B?WmVhU056YUtlYzZpa0o2L2dpREZZcGJsQTU5c0ZXN3U3djQzZlNaMjBNRE5w?=
 =?utf-8?B?TDlOZnMyanhNZ3k0ZENyUXFKUGhMRWdhOGxnV1RqczhUQVpiRjVWSC9OcHNa?=
 =?utf-8?B?UE1UaUdmbnh4K01KQXR5T2kwSlMyYlIzZ3VHckhaU3E0ckJabnJDdmNWR3Nq?=
 =?utf-8?B?b3c3NUU1dkI1Z2J0Y0VaOXJ5SjM5OTFEeGx3T0M0Z2VFWU5ubTBrNFdZVTlI?=
 =?utf-8?B?dmh3Rm9BejlwOTcvZllRN20vNENqc21jeEhxSkF1WklVbjNCM2RtSWhtdHQv?=
 =?utf-8?B?TmpUWHZyaWwrOWtkUXFReUlod3ZTKzVZdGF2VzBZVHg1M0Z2ZmIvUXlGUmxU?=
 =?utf-8?Q?gjlQemerj/Ur54Q4iBQ/nVi6VhA1Ltqd1TAis3O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkljeks3anQwV04rRkJ6VkJSQlNITmtralZlaXBCWkxsKzBZTzhXUTV5WUNt?=
 =?utf-8?B?R0lURk5pNVNYcW1scWlicDNISWgyZU1oR1FpZHgvTThLMUxPUkJDNjBqeEw1?=
 =?utf-8?B?U3J0dEo1bHpieWdrNnFaVVVKM0pQQkpTRlZDaElRaWtoSUJZTGlwNitoYWV5?=
 =?utf-8?B?Q3Y2OXNEWkpjVlpSS3JiV3EweFNKT2duMU9rTmlVcGZmZ2J5eDJrTGNyVFhG?=
 =?utf-8?B?MnNoRXVMMFovQSttc3lWTEo3VXpxTkF2WUFZY2RLQnZrNVkwM0FubWU3N0tY?=
 =?utf-8?B?cmZhVS9MOXlPaEdPL1dSaVNkci9NRUh5dnh3VlpaM0pLNWpQczJlUmI3dGtq?=
 =?utf-8?B?dmpmY2YvRjNldkg3ZUk1WDhQNW5DRmF6NUFlajlxczJ6SVc5Wm03RXVQQ1F3?=
 =?utf-8?B?U3lHSjJ2NklWOTNsaC9rSTl1VHcxMlJKZ2ZGcFRpRTJCajlIeDFhaGV6TUxT?=
 =?utf-8?B?Y1pJZS9hT2dpdkxlZktNRWt6N0VjY2pYdVQrVUREWHkzNUhwaFF4MzBLazhJ?=
 =?utf-8?B?Qzl6NHpHM3pSbnJPMGt2d1dzVHpVMTJ5WUtWWFBoVWNjTk8xOFpaeEdHTkdh?=
 =?utf-8?B?b05adGpuSldMNXVCSmZ3N1AzUngrR25tR1NGWTJMcXlQNHBzVCtHVzA0UlFC?=
 =?utf-8?B?b0djOEx0dERXUjBQdkxqWHM5ZmhmZnlGZEtKNGsrZytVK0d5SmFvai8xSmVo?=
 =?utf-8?B?NzUxcm1vQkxNb2FGTXEwS05kVmo1ajAyUm9WV3JOUytVZzhYQUR5a2xOKzlw?=
 =?utf-8?B?THEzR05YekY2VHlqcGpiKzFPcVhXTXRKaGJXZjB4Mlp2SFkyNW5Ca1hxWHR6?=
 =?utf-8?B?Ryt3QjBUTUpwdTJYdzJzc3hUMElwcTZaWWxTSERzeEVVY0hmSVVGRnJPbk4w?=
 =?utf-8?B?VlhvTTZwK3kyN1Qwc0VlY2VUSXZaaXd1M1VFeFlKanpRTG00ZTl1WjdjaEd5?=
 =?utf-8?B?VjB4Q1A4aHh2b1hxNjdGSit0K0dMZmFrTFgyQnEzcUZKSUpaTXQ2Y2hMUTJL?=
 =?utf-8?B?N0RXZkRxSjdrVnRpeWZDczBsdjVramFxN1Ivak0vdTlkRGVVTXBFN2d2Uklx?=
 =?utf-8?B?Z0loaDIyZG5oK1VHdGNQYUs2WEQzQWxCS3BNYzZNcGQ5K3dacGdHeVNrTGo4?=
 =?utf-8?B?TmdGZXZ2d2VHbVB3Q3FCUkQvODZPdVZ6VGJuVEUvWXdnK1NFQ2I4RW5jS1pW?=
 =?utf-8?B?U084cUxoKzhEbzhrcXl1bmxXR0pmZkRENTdnbWdra1ZPMEJJWkNZUGpTRlVU?=
 =?utf-8?B?RTIxOWNaVFpaU245czdXcTNYQmxDNEFwNjdoNEdJNkNwbDBaUXJldWRiTGpW?=
 =?utf-8?B?UFB3SWd2Y2diSm1MZE43Sm1PcW9iTXVBdDhZd0JsdFJic0FQZ0dKY2pJeGYy?=
 =?utf-8?B?VHVxNmlhZUZISlhJZzhRZmlSVnpUOGJZUVNXM3Z5NVZWdlVSU2x4L3hSQjJ1?=
 =?utf-8?B?MGd4TEtVVFpIWFdKOWt1YUtZc2FMdEYzdURENXJobkN1K2s5cUU4aXl0RW5i?=
 =?utf-8?B?VmxDOEtZRGwzcytBb0RqOCs4TG01UVUxR1FHWGRWbWI2dVk2U2EvZlh3K1I1?=
 =?utf-8?B?T2RmWTFUaGlnemQyVkFRMmppUmdQSmV0dVNGVVdMenNDWW9Cam45bUJWaERH?=
 =?utf-8?B?Sm1IOUhUQ3BkY3VDRVdCZXRLcTVlRXBxNUxzR0ZJejFJbU9EZjlYSWhGeDg2?=
 =?utf-8?B?NVR1T2ROS1Q0UVQ0QTFBUjV6RXRBZ3FYUWJnT2g4VjdrYWVZOFM5UVdkYmRa?=
 =?utf-8?B?OHJwdjR6d0RjejEvQlExbGZZUENHcFBwNEMvWm5jMlUvdkcwSUdhRU5DeklV?=
 =?utf-8?B?elJUVnZEY2NhWmJkS2VwNVc4WXNDRXpITTVIN3FoVytyZGtCV25nVWNMQlFq?=
 =?utf-8?B?VUlkTERSSmNvOGJQNmRrTkdyUVdpbDJldHRScWk4L1ZFa3l4Nk9IQWN6ZWo0?=
 =?utf-8?B?TjE4TXNDcnlyWTE5NHJvOWw0bTB4NHlvTW9xdU5yY0NnZCthZkNKenNOazF6?=
 =?utf-8?B?amN1cGJoczh5NXZ3bEh0R0RMWGM0MDVqTVY1TU1GejB5bW5VWU8rby83THZO?=
 =?utf-8?B?Y2Q1NTBkcEFlTzg5dUd0K3IrNU9WYUZTUTV0UXNoU0FBUkdINFc5dEMwZEpB?=
 =?utf-8?Q?ZXMY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3287535a-cf26-4b24-d205-08dcf1f26f74
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:04:33.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awq+8Tv5f+14GNM//1t6o2OMZUNPL/+Elg+9nx2dBMaq/0Ab2XxIPbo+riE//4ec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

Hi Reinette,

On 10/15/24 22:43, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Introduce the interface to assign MBM events in mbm_cntr_assign mode.
>>
>> Events can be enabled or disabled by writing to file
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> Format is similar to the list format with addition of opcode for the
>> assignment operation.
>>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Format for specific type of groups:
>>
>>  * Default CTRL_MON group:
>>          "//<domain_id><opcode><flags>"
>>
>>  * Non-default CTRL_MON group:
>>          "<CTRL_MON group>//<domain_id><opcode><flags>"
>>
>>  * Child MON group of default CTRL_MON group:
>>          "/<MON group>/<domain_id><opcode><flags>"
>>
>>  * Child MON group of non-default CTRL_MON group:
>>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Domain_id '*' will apply the flags on all the domains.
>>
>> Opcode can be one of the following:
>>
>>  = Update the assignment to match the flags
>>  + Assign a new MBM event without impacting existing assignments.
>>  - Unassign a MBM event from currently assigned events.
>>
>> Assignment flags can be one of the following:
>>  t  MBM total event
>>  l  MBM local event
>>  tl Both total and local MBM events
>>  _  None of the MBM events. Valid only with '=' opcode. This flag cannot
>>     be combined with other flags.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v8: Moved unassign as the first action during the assign modification.
>>     Assign none "_" takes priority. Cannot be mixed with other flags.
>>     Updated the documentation and .rst file format. htmldoc looks ok.
>>
>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>     Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>     Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>     Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>     Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>     Removed ABMC reference in FS code.
>>     Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>     Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>     Users have the liberty to pass the flags. Restricting it might be a problem later.
>>
>> v6: Added support assign all if domain id is '*'
>>     Fixed the allocation of counter id if it not assigned already.
>>
>> v5: Interface name changed from mbm_assign_control to mbm_control.
>>     Fixed opcode and flags combination.
>>     '=_" is valid.
>>     "-_" amd "+_" is not valid.
>>     Minor message update.
>>     Renamed the function with prefix - rdtgroup_.
>>     Corrected few documentation mistakes.
>>     Rebase related changes after SNC support.
>>
>> v4: Added domain specific assignments. Fixed the opcode parsing.
>>
>> v3: New patch.
>>     Addresses the feedback to provide the global assignment interface.
>>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
>> ---
>>  Documentation/arch/x86/resctrl.rst     | 115 +++++++++++-
>>  arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 233 ++++++++++++++++++++++++-
>>  3 files changed, 356 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index b85d3bc3e301..77bb0b095127 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -336,7 +336,8 @@ with the following files:
>>  	 t  MBM total event is assigned.
>>  	 l  MBM local event is assigned.
>>  	 tl Both total and local MBM events are assigned.
>> -	 _  None of the MBM events are assigned.
>> +	 _  None of the MBM events are assigned. Only works with opcode '=' for write
>> +	    and cannot be combined with other flags.
>>  
>>  	Examples:
>>  	::
>> @@ -354,6 +355,118 @@ with the following files:
>>  	There are four resctrl groups. All the groups have total and local MBM events
>>  	assigned on domain 0 and 1.
>>  
>> +	Assignment state can be updated by writing to the interface.
>> +
>> +	Format is similar to the list format with addition of opcode for the
>> +	assignment operation.
>> +
>> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +	Format for each type of groups:
>> +
>> +        * Default CTRL_MON group:
>> +                "//<domain_id><opcode><flags>"
>> +
>> +        * Non-default CTRL_MON group:
>> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of default CTRL_MON group:
>> +                "/<MON group>/<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of non-default CTRL_MON group:
>> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +	Domain_id '*' will apply the flags on all the domains.
>> +
>> +	Opcode can be one of the following:
>> +	::
>> +
>> +	 = Update the assignment to match the MBM event.
>> +	 + Assign a new MBM event without impacting existing assignments.
>> +	 - Unassign a MBM event from currently assigned events.
>> +
>> +	Examples:
>> +	Initial group status:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	To update the default group to assign only total MBM event on domain 0:
>> +	::
>> +
>> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
>> +	::
>> +
>> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> Please be consistent by always using "# cat", not sometimes "$ cat" as above.

Sure.

> 
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to unassign
>> +	both local and total MBM events on domain 1:
>> +	::
>> +
>> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>> +			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
> 
> Missing "# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control"

Sure.

> 
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	To update the default group to add a local MBM event domain 0.
>> +	::
>> +
>> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all the
>> +	MBM events on all the domains.
>> +	::
>> +
>> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> Please be consistent with spacing "# cat" vs "#cat". This is very noticeable when
> viewing the formatted docs.

Sure.

> 
>> +	  non_default_ctrl_mon_grp//0=_;1=_;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index a6f40d3115f4..e8d6a430dc4a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -74,6 +74,16 @@
>>   */
>>  #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>>  
>> +/*
>> + * Assignment flags for mbm_cntr_assign feature
>> + */
>> +enum {
>> +	ASSIGN_NONE	= 0,
>> +	ASSIGN_TOTAL	= BIT(QOS_L3_MBM_TOTAL_EVENT_ID),
>> +	ASSIGN_LOCAL	= BIT(QOS_L3_MBM_LOCAL_EVENT_ID),
>> +	ASSIGN_INVALID,
>> +};
>> +
>>  /**
>>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>   *			        aren't marked nohz_full
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index cf92ceb0f05e..6095146e3ba4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1040,6 +1040,236 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int rdtgroup_str_to_mon_state(char *flag)
>> +{
>> +	int i, mon_state = ASSIGN_NONE;
>> +
>> +	for (i = 0; i < strlen(flag); i++) {
>> +		switch (*(flag + i)) {
>> +		case 't':
>> +			mon_state |= ASSIGN_TOTAL;
>> +			break;
>> +		case 'l':
>> +			mon_state |= ASSIGN_LOCAL;
>> +			break;
>> +		case '_':
>> +			return ASSIGN_NONE;
>> +		default:
>> +			return ASSIGN_INVALID;
>> +		}
>> +	}
>> +
>> +	return mon_state;
>> +}
>> +
>> +static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
>> +						  char *p_grp, char *c_grp)
>> +{
>> +	struct rdtgroup *rdtg, *crg;
>> +
>> +	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>> +		return &rdtgroup_default;
>> +	} else if (rtype == RDTCTRL_GROUP) {
>> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>> +			if (!strcmp(p_grp, rdtg->kn->name))
>> +				return rdtg;
>> +	} else if (rtype == RDTMON_GROUP) {
>> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +			if (!strcmp(p_grp, rdtg->kn->name)) {
>> +				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +						    mon.crdtgrp_list) {
>> +					if (!strcmp(c_grp, crg->kn->name))
>> +						return crg;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>> +				  enum rdt_group_type rtype,
>> +				  char *p_grp, char *c_grp, char *tok)
>> +{
>> +	int op, mon_state, assign_state, unassign_state;
>> +	char *dom_str, *id_str, *op_str;
>> +	struct rdt_mon_domain *d;
>> +	struct rdtgroup *rdtgrp;
>> +	unsigned long dom_id;
>> +	int ret, found = 0;
>> +
>> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
>> +
>> +	if (!rdtgrp) {
>> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +
>> +	op_str = strpbrk(dom_str, "=+-");
>> +
>> +	if (op_str) {
>> +		op = *op_str;
>> +	} else {
>> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	id_str = strsep(&dom_str, "=+-");
>> +
>> +	/* Check for domain id '*' which means all domains */
>> +	if (id_str && *id_str == '*') {
>> +		d = NULL;
>> +		goto check_state;
>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Verify if the dom_id is valid */
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +check_state:
>> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
>> +
>> +	if (mon_state == ASSIGN_INVALID) {
>> +		rdt_last_cmd_puts("Invalid assign flag\n");
>> +		goto out_fail;
>> +	}
>> +
>> +	assign_state = 0;
>> +	unassign_state = 0;
>> +
>> +	switch (op) {
>> +	case '+':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		assign_state = mon_state;
>> +		break;
>> +	case '-':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		unassign_state = mon_state;
>> +		break;
>> +	case '=':
>> +		assign_state = mon_state;
>> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_TOTAL) {
>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_LOCAL) {
>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_TOTAL) {
>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_LOCAL) {
>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	goto next;
>> +
>> +out_fail:
> 
> Is it possible to print a message to the command status to give some details about which
> request failed? I am wondering about a scenario where a user changes multiple domains of
> multiple groups, since the operation does not undo changes, it will fail without information
> to user space about which setting triggered the failure and which settings succeeded.
> This is similar to what is done when user attempts to move several tasks ... the error will
> indicate which task triggered failure so that user space knows what completed successfully.

Will add something like this on failure.

rdt_last_cmd_printf("Total event assign failed on domain %d\n", dom_id);


> 
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
>> +						 char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	char *token, *cmon_grp, *mon_grp;
>> +	enum rdt_group_type rtype;
>> +	int ret;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
> 
> Writing to last_cmd_status_buf here ...

Sure.

> 
>> +		mutex_unlock(&rdtgroup_mutex);
>> +		cpus_read_unlock();
>> +		return -EINVAL;
>> +	}
>> +
>> +	rdt_last_cmd_clear();
> 
> ... but initializing buffer here. 
> Sidenote: This was an issue before. If you receive comments about
> items in patches, please do check if those comments apply to other patches also.

Missed it.

> 
>> +
>> +	while ((token = strsep(&buf, "\n")) != NULL) {
>> +		if (strstr(token, "/")) {
>> +			/*
>> +			 * The write command follows the following format:
>> +			 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>> +			 * Extract the CTRL_MON group.
>> +			 */
>> +			cmon_grp = strsep(&token, "/");
>> +
>> +			/*
>> +			 * Extract the MON_GROUP.
>> +			 * strsep returns empty string for contiguous delimiters.
>> +			 * Empty mon_grp here means it is a RDTCTRL_GROUP.
>> +			 */
>> +			mon_grp = strsep(&token, "/");
>> +
>> +			if (*mon_grp == '\0')
>> +				rtype = RDTCTRL_GROUP;
>> +			else
>> +				rtype = RDTMON_GROUP;
>> +
>> +			ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
>> +			if (ret)
>> +				break;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>  
>>  /*
>> @@ -2328,9 +2558,10 @@ static struct rftype res_common_files[] = {
>>  	},
>>  	{
>>  		.name		= "mbm_assign_control",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_mbm_assign_control_show,
>> +		.write		= rdtgroup_mbm_assign_control_write,
>>  	},
>>  	{
>>  		.name		= "cpus_list",
> 
> On a high level this looks ok but this code needs to be more robust. This will parse
> data from user space that may include all kinds of input ... think malicious user or
> a buggy script. I am not able to test this code but I tried to work through what will
> happen under some wrong input and found some issues. For example, if user space provides
> input like '//\n' then rdtgroup_process_flags() will be called with token == NULL. This will
> result in rdtgroup_process_flags() returning "success", but fortunately do nothing, for
> this invalid input. A more severe example is with input like '//0=\n', from what I can tell
> this will result in rdtgroup_str_to_mon_state() called with dom_str==NULL that will treat
> this as ASSIGN_NONE and proceed as if user provided '//0=_'.
> This was just some scenarios with basic input that could be typos, no real stress tests.
> I stopped here though since I believe it is already clear this needs to be more robust.
> Please do test this interface by exercising it with invalid input and corner cases.

Agree.

But, tested the cases you mentioned above. It seems to handle as expected.

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;

#echo '//\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
bash: echo: write error: Invalid argument

# cat /sys/fs/resctrl/info/last_cmd_status
Missing operation =, +, - character


#echo '//0=\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
bash: echo: write error: Invalid argument

#cat /sys/fs/resctrl/info/last_cmd_status
Invalid assign flag

#echo '/0=\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
bash: echo: write error: Invalid argument
# cat /sys/fs/resctrl/info/last_cmd_status
Not a valid resctrl group


The assign state did not change.
#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;

Sure. will test some more combinations to be sure.
-- 
Thanks
Babu Moger

