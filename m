Return-Path: <linux-kernel+bounces-381308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE839AFD76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACF01C22C59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1222B647;
	Fri, 25 Oct 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KSn/mueY"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194618C93E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846869; cv=fail; b=Y53lQfoelN5uSnPiCca8QXAhlNmPtJH0YAawfJA8G+HKjEJ4VFpkxBwGoq0VvTq1E7JWVyL/jFLf8LPN9traCi5yI+CmNMKC8I5Y0o8BbZU2aKxAdnEApDxqu0TYA0q/WP5EsUtc1w35qI6S+hO2kQ6dTWZhas4Qwot3miS/0oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846869; c=relaxed/simple;
	bh=fyspxfR74qrUhnPwMDwOTIFZKtYWUf25esaO7AY2Dms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l79z4UwGYK3I02f9BJH/jRTd9Q4bSLrNBZ+x1wJHbr3BkatBucCwVCDbQUvB0gOWlqDU5kur4Erl/psEaQPOa8jDHOpcOfU2z5gv7c6GmYfF/ao+RVq4JZl+BhkmnBIpgE8EF2fDdUMiUdPFW/WkV2h9fpA5ne3xFDS3D8KGwO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KSn/mueY; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mohwgmQx+h3IXGWyFFBX5EZEdbCu5a4f7Fuy3ea4Yob520CGE1ICAqZMFpepWDsDbhSvZu+CEzWR7FRB4fxLGAOSFdPyJhXsdA7d2rHYDxApCCW6M6X+7wQPB1I/w6+zuYSEb/BDsGQ70Gh/YQA93pwv0Y//HnhxeXZ85jixIpvDiwLdpEy/yh0JKkkxMGQ0DMnmraae6ktfym/zJA30FNb1TYIHPtzmg2MOo/fR2sE1y/GJA8fIRqKJ4LwH4X3x5zi4ho8kUeqP4C2qkS7ZoXoiAVSPylP8P/L79rVJKAVpQwYhf6BBlQPk4PlD2tzjzVpFmYDCrgWvYN8F0ttHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdnd2RjFv6lNL7kMFHQskXzU7vGjvSydtGAt6y0pe7M=;
 b=UFGiNAMTyKLzhIe8uHvdk7LqB0jW/FK+xUZChsdszj+w5CV3FX2doW6iocFnJQ+dZxluE19knZSCuEAEBbknFJeLyXU/HaZpGAaQjBabj7nqrzWuwVXQMoWbINrb2bwdbh1Z053Xm9S/ajtcTrYfk54iOD3LoBl9HNnPlZMa+den7iITs/dffvI78eEcXCizhzptzzpOOjJk1ctcRL/LXHJo6sDJ5ccEJUSXgBoWf6A0SONfmeSlUqKiz3/Fekl00kzoZrOTkjWuBJ+h7wWsfdCsqsLQS6qCFd7LC5m4upNcseD3+y5uNt910Jp/UrFEdd038UacjQcJY7HbE0yg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdnd2RjFv6lNL7kMFHQskXzU7vGjvSydtGAt6y0pe7M=;
 b=KSn/mueYnd6S3lzFGmklahvIYJ/r5MsvHaD/myR/ZsExoMUjKBpVQY/xbH3bNt0BkjC+t0GsqzsWJqs39BrtnEzlLn7Ref2JfwGccefBVQQhPxDEnsUDhReVAcUPHiAPmun4rW3VdDwMhuGHIxPmAb8t+eF0UkhrQKmrbQer42M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 09:00:59 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:00:59 +0000
Message-ID: <9ce26117-27eb-4f3e-8ac5-a37ea5d15802@amd.com>
Date: Fri, 25 Oct 2024 04:00:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: e3791140-af1d-404b-951a-08dcf4d38b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmhaR1VqRlQxcndjcGxGbm53cURsMUxkcndEQnlXTDZrK0x6OVdHaHpKL0hu?=
 =?utf-8?B?RHpZanVQMUZvMHJNWG84RjFJeHZEa0VEN1NENUVsMVlKR2Y4VTVVQnNML0JH?=
 =?utf-8?B?bWRmZk9zbDUxc3FyRHE4RXVzektFS1BBcEtpSGI4cVNIRmFkekdFU1orU0tn?=
 =?utf-8?B?c2F0bE9FOTNFVEtXSTJwMHQ3MjJhTzE2SnlVemRSWkZCM3dJTlJIaDBPbVl6?=
 =?utf-8?B?VXkzeUkwSThYY0JrcDFXZWRsUlo4VkdZV0RvUitvMmh2UEcrNzJZeUVtRVc0?=
 =?utf-8?B?RDA1RElZQlFaNURoVjRrTVBGbktWbWlIdjdwbVMzU2VvZHlJRGdkcmY3NlZS?=
 =?utf-8?B?ZGJSSC9nTnBqWGdNdEpmK3ByeTY5OWR2S3F4ZnBLYWZ4UUU5cC9SdXJYcXpG?=
 =?utf-8?B?Ny9zY3k4Yi90b0dOaVltZ1pxSHRHM0JQNVNNRU1TMVR3eU80K0wwcmVITGhN?=
 =?utf-8?B?VEVKeXZCQUNwRUF6V2pzQjNnbnJSdDhPdm9NSUFXdzJreXVlSmZwUU9EVnBY?=
 =?utf-8?B?YUhZYWRmR3A4MncvV3VZaGZQakh3bTU0VW5DcFdHeGRFTGhLODZnS1RsV01w?=
 =?utf-8?B?Mk5pSjJvbE1vVjVXYmNYbzhaK3lESnRFaGw0VkQ4d00xWWlPTTZ4RHFFQjc5?=
 =?utf-8?B?N0NWMU4wT2UwREJ0Z1puTHBpcGsyaGZ2TFZhdldGQ1dqeGZHb0QwelhUR0lO?=
 =?utf-8?B?eldhSkt5aEw4QXFKdE8wQ1Q0S0wxdTFQMS9ZTFczRUFXenhyVTd6VklIZEx6?=
 =?utf-8?B?RG5aRTFGb003RFlrUVZFYzlzc0VKWWgrMm12SC9YbTJORWNvbGN4aVhmbU1W?=
 =?utf-8?B?RDByS1B2VHh1ekJWOGVaZE91b3MvdGJuUnhlZkFBdGNkcHNqSzJrUkpZV3p0?=
 =?utf-8?B?ZXptT25McDJ4N0JJNW05WnBmVThjTUdOaUdEWkZNazNDeWpuS21JYldIL1BL?=
 =?utf-8?B?VGNvSml6cWd0TXVsazd5aXByUGs0cS84L1BHWGpocFN6MWpycjdZYndaY1BH?=
 =?utf-8?B?RWEwM0FwMUJtUk1zKzZYSlU4TjJsRnBGRG1CYzgxTTRUMDlqY2ZneU5kRGpT?=
 =?utf-8?B?T2xJWWg4RDJxSVRhaEU2bjZsZmlQUjdORVpVdUtCTk56aklKdlFIaWkzSGRU?=
 =?utf-8?B?R1ZoK0l4MHkzak5zOGhUZXR5U0xHT2UrdWRITWsrMHNXT29CSXdzUjR4b3hM?=
 =?utf-8?B?QUFyMnJOcTNyTW1aSTBDeHJzTHpDYmdoQnBkZkhYTG5URHUvUVZpTXZMcXB0?=
 =?utf-8?B?Sys4MHQ2VmxRNUtvaXpFS3dxL1c4L3k0QUEyWDh3WWJpVEhveWdCVGZwZHdP?=
 =?utf-8?B?NzRncFphL0ZoWjdiUEk0WmpEcTludG9CaVpDVzNMV1g1RkxmTHltU0kwc2JR?=
 =?utf-8?B?K000RXZRcFIwQW1oNCsxcFIrc3g1UWU3aUdrSDErL0xCbUxuWExGUjFGR04w?=
 =?utf-8?B?RU5GSEw5Z3JlQ2pOcUl3dVUvRVVwaThpbXVhL2pTV0RBbStZRWw2b1gwelVQ?=
 =?utf-8?B?OGF3eEtpWklvTFdtZTMyT0dlRmJ0dTRvZnVtQVdjZEd4OG81ejRITWZNWjUr?=
 =?utf-8?B?MEtmcmF3bm5qV1RlZGQ0Q0p3aTVrY2s5ejREa0Q0VkV0M3l3UEVwWmJUSnkz?=
 =?utf-8?B?cUl1YW9Ra1VZTzZuejBESjJQYWNNdENHeWdVMnJvZGFzM1RxVWdEaVdtdlRt?=
 =?utf-8?B?MDJCckU2TENvYXpLc2RBaGZXQkJqTmNnRnFNNTVCSlczc0oxeHZhSE81L3h4?=
 =?utf-8?Q?Z/CJ3rXj70cJB9FbMk+0gMEAUZ1JVCgiac1gs+X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHdtT3dXa1F0UlMwWDVBV2JBckpRMGtMam9memN4ZmVEQlRyU0hYY0F0WXo4?=
 =?utf-8?B?NTQwTEVPNXh3VGFTWllXR3RuenFJMG9zZEdSUDhzWXJYeHcySkdqUmJjWFBz?=
 =?utf-8?B?eS95ZVloVENlSHVOV2NwSFRDdktZbjcxU21aZ2laNWNyM2txbzljR0Q3eEVn?=
 =?utf-8?B?SUFRaE1RbWthbEx0NndvaTg2SVI3TWJtd3UvR2dxMWdGK3F2VlNDbVJPQWU0?=
 =?utf-8?B?dFZXU0NKcjNQV2NzcGJoaEtibktzb2ZFQk1PN2NZZnVuNEZYbThpUkxoa3JB?=
 =?utf-8?B?bkh0SVJyZ2VjdE9ac0hOenVDR05EcnJDb2RkOVdWTTNVYnVmTmJxQ3h2TWdJ?=
 =?utf-8?B?dElPRnVxdkNTendZTWVlQWtyVVRObGZGeTBVTjZXQVRFZGhuMFJUMUhJcVVH?=
 =?utf-8?B?bjN0cWpsYXZMaHVEWkxHOVJTSExJeko3Ym13c1JlWW44My82elN1ZU8wMnl2?=
 =?utf-8?B?WVdlVzNha0hETDNKR1NrZTZpdnhsUGVueDlCa2VFTFlTUnA1TzM3bnNZUkZu?=
 =?utf-8?B?Mjl3bkhaNFZpMXdDSDZVYmc3a2tjb0ltSm9xN2JPaXhLdWxqTnpYYjJlVS8v?=
 =?utf-8?B?SE91bFdISmVKSnl1RHI3Rkxick95V2phb0g2Z0NjdEkzQ2ZzSVl6ODFsQ2kx?=
 =?utf-8?B?Rm4xSXI1RHBwM3RCdDhWNm9Sb1puZUFaMTg4SGYweG1wNHlOMUJLa0dONzRh?=
 =?utf-8?B?TlNtaE5XQjBSSGZYNmsxYVdkeVJZaGZkVHY0YjZMYkxOeFdGaDhJYmdJa0N2?=
 =?utf-8?B?eElaMURDVzFCNWxiQURtZ2svMUhrd29lU29zM0lEQzUzb1AwNHhnOFp4YzVJ?=
 =?utf-8?B?LytQdmp1cXlWVi9QWWUrZ0pQTjVxSUhpazEwLzFCWnROazVKck9maHhiSm1Q?=
 =?utf-8?B?THB5VkVnb1BKdEFleFdQTks3RlgrQytqbWRuMTVBM1NsbUU5ZlU1eElWL0FM?=
 =?utf-8?B?T0tSaXZlc2dlTWxiWWMwclFpZ3duVWdVanYzVDNrVzhEMHJaWkJEWlJsdnVR?=
 =?utf-8?B?Z0F0R3FLaXRvZDkxY3JCU0ZheU1zdmtCSzNsMW1ISHcyYkVNa1ZLaC9Ybm1I?=
 =?utf-8?B?QmlmVjFpSUxqUzdLLzFqQW45R1FIa2R0VkdkbzJtYWtqdFdraXFJTDJFQUlS?=
 =?utf-8?B?VzJKaGs3MDlVN1NYUmRsb2EwNnRiZTliRnVwZTAybzBOMFdVVEpoNGhabkZq?=
 =?utf-8?B?VTBKM1pkWk5jMHFLK1k3aFZMM2pyUnhkVloxem10OWh2S1RlcGthVFVNY1lD?=
 =?utf-8?B?TjZhRWd0MTJsRnZBdjEwN29RWVlvZGN6cFFFcEpmL1dkbnpDZnFTNzIzUXBj?=
 =?utf-8?B?bzFybWhOVUxMUC9mRTFKYzFaY0RIRDVRT1VUYTZ2TTdhK2J4cW90WVBheEk1?=
 =?utf-8?B?cVliajVCY0xvbmxrcnI3cndIV0c1RlNWK3poY0NYZ296VGN4b2F1Sm8xdHdE?=
 =?utf-8?B?WUdWVm50eWViaTJDUFJhNXhLeGRCQXZGN0lIM2k5MjVQeHVOZ0QwR09ETnpy?=
 =?utf-8?B?UG1Cd1I2SlRiRlpPTU1qZ2g1U0k2ajVnTUNCVDlFZE5kZHdzcHo2L29MMmxX?=
 =?utf-8?B?MXRUZWhIajVFVjM2NWhhbnQvaXhodmNQYkw2YnlBak5zNEl6TmRNUXBVclZD?=
 =?utf-8?B?dTh5bnlVdy8rU1poYmNFekpwd1k3a29aZDJRb2UzblNOcGkrLzR3eUtEYzdC?=
 =?utf-8?B?SUdic081ODdGMVpzVTZ0T0ZweHZlNGl6SkZBQzRRdTNpTDhXNmZaNUs0N1Qy?=
 =?utf-8?B?ZHVyMDJQQTdyMUk4VzR1SnJnak1PUkFiaTY1aUd0dVMyM1dSK0xWai84SHN4?=
 =?utf-8?B?akNXTmdnYnR0QThiZjE0Uy9UclRHV2YrTGkrbHVvdHhnMFZSRC83UUpRU2VI?=
 =?utf-8?B?RFN2M2VqaHA4SUVUMHppTkk0bWk3bVgwV0dkSVA3THZBenhpemUvSkpyYUsw?=
 =?utf-8?B?cVE0MGZiM1BKZWNnWVNxTi82OEFBWXg3VUJheERUOVdPcm02YTUyK2FRTlI5?=
 =?utf-8?B?dlppdHhMUzVDcjBVakpMN3l3aVJhR01MRm5uU3pOajZORGs0TFpObThQTjlu?=
 =?utf-8?B?anJXakVpLytyZ09pUndWbjFEcFhsQXprcXkyRnV6T3JBelJHL3RVYk95QU5R?=
 =?utf-8?Q?dmFmCC70eVCsNVspi2HuT1Y+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3791140-af1d-404b-951a-08dcf4d38b1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:00:59.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkHXSUL6xrH4cgH/a1MmRCEkBtvIYbWzJcFejfZDYTL9WfS/pySrEzpHjoF6xzyKCau781vxH3AxtA1obs3mnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

, 
On 10/23/2024 1:41 PM, Tom Lendacky wrote:
> The RMPREAD instruction returns an architecture defined format of an
> RMP entry. This is the preferred method for examining RMP entries.
> 
> In preparation for using the RMPREAD instruction, convert the existing
> code that directly accesses the RMP to map the raw RMP information into
> the architecture defined format.
> 
> RMPREAD output returns a status bit for the 2MB region status. If the
> input page address is 2MB aligned and any other pages within the 2MB
> region are assigned, then 2MB region status will be set to 1. Otherwise,
> the 2MB region status will be set to 0. For systems that do not support
> RMPREAD, calculating this value would require looping over all of the RMP
> table entries within that range until one is found with the assigned bit
> set. Since this bit is not defined in the current format, and so not used
> today, do not incur the overhead associated with calculating it.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 121 +++++++++++++++++++++++++++++-----------
>  1 file changed, 87 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 0ce17766c0e5..4d095affdb4d 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -30,6 +30,22 @@
>  #include <asm/cmdline.h>
>  #include <asm/iommu.h>
>  
> +/*
> + * The RMP entry format as returned by the RMPREAD instruction.
> + */
> +struct rmpread {
> +	u64 gpa;
> +	u8  assigned		:1,
> +	    rsvd1		:7;
> +	u8  pagesize		:1,
> +	    hpage_region_status	:1,
> +	    rsvd2		:6;
> +	u8  immutable		:1,
> +	    rsvd3		:7;
> +	u8  rsvd4;
> +	u32 asid;
> +} __packed;
> +
>  /*
>   * The RMP entry format is not architectural. The format is defined in PPR
>   * Family 19h Model 01h, Rev B1 processor.
> @@ -270,48 +286,77 @@ static int __init snp_rmptable_init(void)
>   */
>  device_initcall(snp_rmptable_init);
>  
> -static struct rmpentry *get_rmpentry(u64 pfn)
> +static struct rmpentry *__get_rmpentry(u64 pfn)
>  {
> -	if (WARN_ON_ONCE(pfn > rmptable_max_pfn))
> -		return ERR_PTR(-EFAULT);
> -
> -	return &rmptable[pfn];
> -}
> -
> -static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
> -{
> -	struct rmpentry *large_entry, *entry;
> -
> -	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +	if (!rmptable)
>  		return ERR_PTR(-ENODEV);
>  
> -	entry = get_rmpentry(pfn);
> -	if (IS_ERR(entry))
> -		return entry;
> +	if (unlikely(pfn > rmptable_max_pfn))

rmptable_max_pfn is initialized in patch#5, shouldn't this patch be moved after patch #5 ?

> +		return ERR_PTR(-EFAULT);
> +
> +	return rmptable + pfn;

Again, rmptable is initialized/setup in patch#5, similarly shouldn't this patch be moved
after patch #5 ?

Thanks,
Ashish

> +}
> +
> +static int get_rmpentry(u64 pfn, struct rmpread *entry)
> +{
> +	struct rmpentry *e;
> +
> +	e = __get_rmpentry(pfn);
> +	if (IS_ERR(e))
> +		return PTR_ERR(e);
> +
> +	/*
> +	 * Map the RMP table entry onto the RMPREAD output format.
> +	 * The 2MB region status indicator (hpage_region_status field) is not
> +	 * calculated, since the overhead could be significant and the field
> +	 * is not used.
> +	 */
> +	memset(entry, 0, sizeof(*entry));
> +	entry->gpa       = e->gpa << PAGE_SHIFT;
> +	entry->asid      = e->asid;
> +	entry->assigned  = e->assigned;
> +	entry->pagesize  = e->pagesize;
> +	entry->immutable = e->immutable;
> +
> +	return 0;
> +}
> +
> +static int __snp_lookup_rmpentry(u64 pfn, struct rmpread *entry, int *level)
> +{
> +	struct rmpread large_entry;
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return -ENODEV;
> +
> +	ret = get_rmpentry(pfn, entry);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
>  	 * RMP entry or a special large RMP entry that is authoritative for a
>  	 * whole 2M area.
>  	 */
> -	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
> -	if (IS_ERR(large_entry))
> -		return large_entry;
> +	ret = get_rmpentry(pfn & PFN_PMD_MASK, &large_entry);
> +	if (ret)
> +		return ret;
>  
> -	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
> +	*level = RMP_TO_PG_LEVEL(large_entry.pagesize);
>  
> -	return entry;
> +	return 0;
>  }
>  
>  int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level)
>  {
> -	struct rmpentry *e;
> +	struct rmpread rmpread;
> +	int ret;
>  
> -	e = __snp_lookup_rmpentry(pfn, level);
> -	if (IS_ERR(e))
> -		return PTR_ERR(e);
> +	ret = __snp_lookup_rmpentry(pfn, &rmpread, level);
> +	if (ret)
> +		return ret;
>  
> -	*assigned = !!e->assigned;
> +	*assigned = !!rmpread.assigned;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
> @@ -324,18 +369,26 @@ EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
>   */
>  static void dump_rmpentry(u64 pfn)
>  {
> -	u64 pfn_i, pfn_end;
> +	struct rmpread rmpread;
>  	struct rmpentry *e;
> -	int level;
> +	u64 pfn_i, pfn_end;
> +	int level, ret;
>  
> -	e = __snp_lookup_rmpentry(pfn, &level);
> -	if (IS_ERR(e)) {
> -		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
> -		       pfn, PTR_ERR(e));
> +	ret = __snp_lookup_rmpentry(pfn, &rmpread, &level);
> +	if (ret) {
> +		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
> +		       pfn, ret);
>  		return;
>  	}
>  
> -	if (e->assigned) {
> +	if (rmpread.assigned) {
> +		e = __get_rmpentry(pfn);
> +		if (IS_ERR(e)) {
> +			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
> +			       pfn, PTR_ERR(e));
> +			return;
> +		}
> +
>  		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
>  			pfn, e->lo, e->hi);
>  		return;
> @@ -356,9 +409,9 @@ static void dump_rmpentry(u64 pfn)
>  		pfn, pfn_i, pfn_end);
>  
>  	while (pfn_i < pfn_end) {
> -		e = __snp_lookup_rmpentry(pfn_i, &level);
> +		e = __get_rmpentry(pfn_i);
>  		if (IS_ERR(e)) {
> -			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
> +			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
>  			       PTR_ERR(e), pfn_i);
>  			pfn_i++;
>  			continue;

