Return-Path: <linux-kernel+bounces-513935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F133A3506A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC317164D89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC102661BE;
	Thu, 13 Feb 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ve1rAFA6"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020091.outbound.protection.outlook.com [52.101.51.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73423A9AC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481539; cv=fail; b=kSCYMVQk/61q5EQvivqRY2NDHmg6iyG6k9JTZttlAhOQb095BB9eVeGHZe07azQIx0I5Od/NXzGRlHp1e1gGRpg9KLqgi/k6/PvyaNCDKBjq5xtB+X7yV5jmQe9dI3UwI74SknWLgemARiRvmiN43cwY5sdruLhMQqmirmIPRLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481539; c=relaxed/simple;
	bh=0Alrn8/e8Q7Wo2qxSESTwYXPCjErjpd0Fuzs6Y7jgak=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlRuQs1H1ovRMV4Q/aHzSW/ka5DEgRlx1/XekMw72h8FQN/9XlcLtiZ/L+xqWK9qBL26nobms/RNF1YQ4YpXR9qoewWQuufZ+IoXwOvzWm1y7fpKfRUIdrONVQ1T9GA6Nx4IuOGN01Nlq5iHGA9QuqdrEiht1M2yQw26Q5KhYLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ve1rAFA6; arc=fail smtp.client-ip=52.101.51.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F231v80tPKbY3+P8rI0KlGM0OqUAG1hPDyrDQOwSeGWy5pune1bi8CpnKxYozC3udsDjQ5k7kBTqybELWy4D/fRb3fRJf2P5B5cdo5MqtrntwX4n1A0yQSjoivxxXmY63GDj2F9cRxqcN0ccwtVVp03LJcLAssE1W9/P7ch7q1NaDwhP19OO2FX8fX2OxBra13DCm5LuqgBBlwFmAoh0bgRu8t8DqqEUpqJt464Kwu3rc3P01+ty9/TKyogRC3VuNsOUOvTjmXitvsZCbPcBusz2BIqpa6Q0Nl7miSGdsK1nqGfLaWo7ac9XMT9bueKkvHrgmyeA7xeucPKEVnrndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXD++q8H+FBTksX7rcqvgN3JVWN9nPpt4nPcSTIlum8=;
 b=Qe1v2FPRvLbdA4aZFJ7sGWkh/eM8ehepUcgm4PAGmlThwXUw++w7evAfmi24yZaytRBYfMPOCue1FPsgJ1NkQ2jjXh8i8YiLsjzCjg36PBno3AT2sKGzSXvirXx5dw81HQY+Z941yOUPS5VZSmtrOHPPOsWjxat4CLX5v9oT57TKPaz0FT0Ir34ChruhlZizu3YWLZrFlsYIHGJsMztpoFhkmhIVLpPy9vSoZ+fMukHA3/aYSi42WdwEJu/dunJIzHgX0NNFsQW6mHxbOYpZ7/Y312YcaFZEm2VeiONjfchIUGDtC7dFBW0LUhp6uoUC+jlNmWJ8/sJLg2EJhxt9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXD++q8H+FBTksX7rcqvgN3JVWN9nPpt4nPcSTIlum8=;
 b=ve1rAFA6JtKXaGVt2LLpI3Ijd+7GmkQuZ8LeNWZ2cPIUNdUrxP27YDh+pCNIRiH6vKVHysoZw5AjB3FIm+p6EMqj/efyHh9HsRmc/8qsMQrqy7GxOPKJMQEyGpa4tXRO/QmosZvNOX1F/vd5PCfMqAJlPG2dATuYzgRBAaEGVug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6310.prod.exchangelabs.com (2603:10b6:510:9::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.8; Thu, 13 Feb 2025 21:18:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.004; Thu, 13 Feb 2025
 21:18:54 +0000
Message-ID: <be09705e-2f85-47e0-b632-f2fdb32e54ba@os.amperecomputing.com>
Date: Thu, 13 Feb 2025 13:18:51 -0800
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [v2 PATCH 2/2] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <20250103011822.1257189-3-yang@os.amperecomputing.com>
 <caf29133-a24f-47e4-ba38-d1f99e998d27@arm.com>
Content-Language: en-US
In-Reply-To: <caf29133-a24f-47e4-ba38-d1f99e998d27@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: c27464a4-7d8c-41d2-1fc0-08dd4c740513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG84N3MyS01URC9DdHZUbzZOSmNRaFlvZlRtcytCOTI3S1Fqa3VYN2pVUkZi?=
 =?utf-8?B?Ylh4eUYrdTFsMXRBaG1SVUhBYWxOZWpKMmZybDdJSXNiMk1OSXZ2b2h6Ym5V?=
 =?utf-8?B?a29FNjNJenNYRkx3blo3TjdDYlhjUDNtdnEvTXl6RVZJZDFNUWZSOGp6RXhw?=
 =?utf-8?B?aWlLdUJxSzNiVmdySlh1SnRScSs3V0tPVDVXOFFMdE95TVJxajZCaFhiUll2?=
 =?utf-8?B?NkMxbUwrbGRLMjhVLzVhVGFrVWpRRCt5WThBYXZpb1BYTUxhdHZMaUJqTUda?=
 =?utf-8?B?d0VOMkxiTG5DU2QvYTBrSVBTb0xVaGxPZWdaSVpkU3FzT25COWxlTVJlTE54?=
 =?utf-8?B?Y1lLcVZkdjBpcm81Njg3Qng3UnhmdkExV3BELzhNZkF1MEFmb0NpTEpVSFA3?=
 =?utf-8?B?ZG1mcjJqN2JTbG9BVHZibzNGTFVXd3dRQStlbkJYQjRXdDZEK3duK2pFTE40?=
 =?utf-8?B?cVQ4dWxHay96d0swMHVTM2VhSWl4eHA0U2NwZTh5N1ZDM0t0V0EvbTRUMkdL?=
 =?utf-8?B?YVEvSDA4U2ZNb1gzK3pTMnRXSVozZGRZRnI0aWpKVmpoakgxd3ZoZlMrSGcz?=
 =?utf-8?B?aDJLaVhVT05qdkVSbXQwYW01Y1piaDBsYjFpTVR2K3JQRGwreFRKeHU1NzVo?=
 =?utf-8?B?NUYrdjErS3VjdWozSTVNVlhXYVM2TWNlMnFpa0VmajJqaDZYRzFpbmFDMHVs?=
 =?utf-8?B?VllidnJjaElmVGsyci9OcnRtWG1JRm4yY0pDR1I2cVB0Q1FUMnlKZW55dlZx?=
 =?utf-8?B?UDhlandpTkFuTDhYMDNkNjBYRHlxRytFUmtOcjdjRnN3VnR2RFFpdUV3S1kz?=
 =?utf-8?B?QzM1S3A5MXM3aGcxOFEwcUV5NVZxK2xHTzhWaVBjOWNBYXp3TzZvNHdmMDVh?=
 =?utf-8?B?M2JKeFNibUJ1Z1l2bk9FNFpZbHBOd1pUdnE0Sk8xWXI2Yjl4cWlwRTlmTFNZ?=
 =?utf-8?B?UXNVV0JSWG9LaCt4ZTdjUWduNTFCaS96eTF2ZnpUZFdxTjN4TGlXK3BjYW90?=
 =?utf-8?B?ejJ2cmY5SkpCN3hyMHZCaDJRdy9DdHpDV1JieUovWGs5VDIrMEhhVkREQjBv?=
 =?utf-8?B?eHI2R3d6QkhWTEF4OTR5UDlTajlWaUZ3YXVpd3IvR0FrK2JkeVVITVdna3BB?=
 =?utf-8?B?QUZKWEx2VmdaYUlXTjdXbFdGcVZzRUJZaWdPY0JHK3ZDcXZtTzV0MUhFeVhz?=
 =?utf-8?B?SzMvc1F5Y2VhVXpwbUlmdVRnTkdvYTlxKyt1TFRYNDJRUW5yd201SDlzMVho?=
 =?utf-8?B?QjVNMCtzcmZLaitzNW9SNE41eHRDclZGRmtCdTdTcm1hNVZzclpFb0RZOEtP?=
 =?utf-8?B?c2cyUXkwVlEvdkM4SDVCSWFmZlhvcG1sMG1YRE1CSCtlYjRPeCtsRU1CbEpD?=
 =?utf-8?B?ZXFnUWI0V3pkaEZYWTZ5Qkxva2FBQk53VDc2RDM0bkk3bDltS0tMQXNtMGVN?=
 =?utf-8?B?bytnOFg3Z0l5QldzamxkU3pwT0xFVTRacktlMVozTGRhQXJ6VHUvaGZkeUx3?=
 =?utf-8?B?NHNOSUJTaURxbDV0N0dCRnM5NVpFUmVmNExVT25yMlhzdnJaU25lTXgzVUc0?=
 =?utf-8?B?RDZLOFZYUGdBT2pkSnhHM1UrV2tMZklONGhRVmNYejFHVE1hVGFWS3dWYUtx?=
 =?utf-8?B?S2hVdVlNYmsxOGxhdDBqY09ybHhsR2o5RWduWUhCZ1dmaVROVXptUEg1Nmh0?=
 =?utf-8?B?M1JkVUpiUllxRVJWODNoMkhicUg0VVducHUzY3lBTHVUV2FvM09EYWF6dWor?=
 =?utf-8?B?T3pKQU1ydGErOEQxbEw1Kzc1R3VkdG8rQnIreE80THpjai9YUEgzWElqaXZi?=
 =?utf-8?B?bFlEMk1rc1JZQm9mTDhmODBxQ2ZvcHRUZmhrTW1Ga2VhQVFQRHg2UkJoZUdT?=
 =?utf-8?Q?ueg2S7Bkoensm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YStNZHlac2daeHhHVExBcDZ6ZDVZVGpPWnNwK1cwNFFycEZucWJhMlN3aVRJ?=
 =?utf-8?B?RUwrc1VIMDJ5TTAxOG9ZdjVsNisrangwVGxzZVdrb0ZpemdCcm0zWGdsQVUr?=
 =?utf-8?B?Z25Hb0UrdzFKRVcvV1FvMXk5Y0duTnNPRVJuakRHWDNxN1lDa3VSQWxKNGZF?=
 =?utf-8?B?aVBuOTJmMlVDRHVhcEl0dGtLN1FUWjRzaWhRSjhUazdpNDNNb016SUhnTnNs?=
 =?utf-8?B?Q0hGc1VTWHV4eFpSMWUwb1liUjFjR0ZoellPNUJEdmN6eFRpL3BlQzhSMndv?=
 =?utf-8?B?S0dyZHYyOVZqcUpmQ0crMHFlMW9mL0ErN01TU2RhNjRTeXVvakdVMmlacUR0?=
 =?utf-8?B?RTRiTWZJeExJQ2R6ZTRpUnhBZWdGdnNKMTZDcHBwYi90MFNSLytCOGUwbWpH?=
 =?utf-8?B?eWE5Nzk4UDdhY0cvZGZ6eHM0ZWVOdUJxL2tKR1Z6VkVONG9HSWJwamd4WTBu?=
 =?utf-8?B?TkVnVWxaaHdDRHNndUpXZkVsMW5Pbnl3R3FVVXZ0QUpTZWo3bXFzeTdFRFlq?=
 =?utf-8?B?aGlzRWFvSVhMOTJhUkY0aSt2L3FsR081aHJWQXNyL2FTOXU1L0k0ZVh6YnFw?=
 =?utf-8?B?TC9PTW9xa1djNXJGSEJRZkdSMVNURmxEZkhNRlM0bjBRMVdTZ0VrcHNTdDMz?=
 =?utf-8?B?eG1IdmF4TGhZaWdMV0twR0UwS1A4QmRyTEJmalFGaDVNd2M3Tk1Ueng5dFRz?=
 =?utf-8?B?ZFRndHg0Tk9QdEo1U3daSDdlTVhCeW05dnc2QTUxNGZTVUg1TDBaazZDUjRh?=
 =?utf-8?B?SjNrNDZpSUpKUmtvUVk3dGRHQ0U1UVNlaXdhaFg2cFRZZFlPdVIzZEI3eTE1?=
 =?utf-8?B?amZmY2RQY3R4QTV1RzlyL2NZdUs0Qis3MWl1UmZneCtQcjNwWjFTdnhjNzcx?=
 =?utf-8?B?bFgrcmJtT3lFam9Nem4reTNFbDBFeGtPdDVRbmZHbnl5OCtRbUVSNUlOWTU1?=
 =?utf-8?B?cFp5UG54Z051a3k2OXVmcGd4aURHVk1OQTFsaS8vMVRwQjFxN2l4L3NhWTh1?=
 =?utf-8?B?Q3E3a0RLVUpWdjFWY3A2ZmFMdnFxRkhjSk5JWVZLSE91ZDR2cVhIZFhoc2VK?=
 =?utf-8?B?V2dQQnEwK3FjZnNkdFVPaytrNmkxY1dKaE51S1FCTzhqWVlIZzFaYjJUeDhq?=
 =?utf-8?B?VUhIY21pQnpBakMyRzZjUUdwVkZjd280ZXZsMVI0T0pEZEZjb2pmNnNqTGRy?=
 =?utf-8?B?OWVQSGxZUHAxUjZDaVBhUjZOQ0g1WWUrYm5UR3ZhRXlmQWtTYWNFR3pJOW85?=
 =?utf-8?B?TjZheGJLc2F1cW1BUm1rUjZwM3R4ZUpLeEFtSVF6Z3QwMG1IV0swdGhDT3Vz?=
 =?utf-8?B?TG85LzVqTnhvRHo0T1BHRlJYdzFtbHZOWE16VjlxZXR0SkxwMlFpWm15ZHpE?=
 =?utf-8?B?YnJRNU11N0JYYThjbmZLakczNXA2YXIwVHh2MDlFbkg2aE1VY1lsY2tTWUMv?=
 =?utf-8?B?b1RXQlk1VENjR2txcHpieHhrYUI3WlJGWWFwZlFRWG1JVGhDNlJveDJWdUlm?=
 =?utf-8?B?ZEp6SWV2S0xlWDBKL3JuZTcxQ2Voc1k1UDBMMzVJdThwT3I4dGdsVkJ4Rzlm?=
 =?utf-8?B?TmFhYTJ1N25FRGtpRnpMQU5Hc0NQNUNVd21Cc2o4d0xlQ0JHS0lEeGE1Yzh5?=
 =?utf-8?B?WnNyY1pEYmdVYUpvQmFBTzdwYzZxdjBsREx0UFllZXR4MXlFblExWUVHdmxR?=
 =?utf-8?B?cHdlbFMyTnFaWCtyZVZ1dFIzcXlubGIvMi93aFcxa2FFMktSSituZDB5MlJT?=
 =?utf-8?B?cnBoUzZqUS9RanlYRUtrUUV6Q0VnN29NSUJxZWYyaHFKUlQyUVRpd1VabGFN?=
 =?utf-8?B?S2hKOHh5WUdhd0EzMmpxNWwvQVllTkdlTjlSOENOK0dSbjVxZFM1NDBkZGd5?=
 =?utf-8?B?b3FjWjU5MXU2WnNYeGt5K2RJRkhjbVFrbVB2Y0dvaktIVlppYllua2RGUmo2?=
 =?utf-8?B?TXpGL2dWclVXaXExM08yMjBJTUN1YS9aY1dxUGJhYmJOK0lvdXNTODBuUTE2?=
 =?utf-8?B?K1BQSDBkYnp6aDRBR3Y5MnU2NVFKeXNMd3RKSHorOTlEZTlRdXB2TmpXK2lZ?=
 =?utf-8?B?S1JnMWVLN1JxR2FDNHJBZmdXa0VLZ0RVYU9NUnBxMmZjVTZSMzZKWUN3dFhS?=
 =?utf-8?B?eTg2K2M1UEdSTDgzNEs4MmkwVFVHOHZ2UWlycEFUeFhXbml1eTJSL2p2c1Zx?=
 =?utf-8?Q?IopNg2tFdVFyqALZjY85MrI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27464a4-7d8c-41d2-1fc0-08dd4c740513
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:18:54.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5erPdx9tb42xcApfYO0nqQGDDLGcshy0Q3UtK+B9ssmyoXHof6JGMlPfXmKjX3Y7+RqGDz/3jA8eSWwcrm3khTeqQwoukSukovysAF9unAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6310




On 2/11/25 4:58 AM, Ryan Roberts wrote:
> On 03/01/2025 01:17, Yang Shi wrote:
>> When rodata=full is specified, kernel linear mapping has to be mapped at
>> PTE level since large page table can't be split due to break-before-make
>> rule on ARM64.
>>
>> This resulted in a couple of problems:
>>    - performance degradation
>>    - more TLB pressure
>>    - memory waste for kernel page table
>>
>> With FEAT_BBM level 2 support, splitting large block page table to
>> smaller ones doesn't need to make the page table entry invalid anymore.
>> This allows kernel split large block mapping on the fly.
>>
>> Add kernel page table split support and use large block mapping by
>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>> changing permissions for kernel linear mapping, the page table will be
>> split to PTE level.
>>
>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>> mapping PTE-mapped when rodata=full.
>>
>> With this we saw significant performance boost with some benchmarks and
>> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
>> 256GB memory.
>>
>> * Memory use after boot
>> Before:
>> MemTotal:       258988984 kB
>> MemFree:        254821700 kB
>>
>> After:
>> MemTotal:       259505132 kB
>> MemFree:        255410264 kB
>>
>> Around 500MB more memory are free to use.  The larger the machine, the
>> more memory saved.
>>
>> * Memcached
>> We saw performance degradation when running Memcached benchmark with
>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>> latency is reduced by around 9.6%.
>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>> MPKI is reduced by 28.5%.
>>
>> The benchmark data is now on par with rodata=on too.
>>
>> * Disk encryption (dm-crypt) benchmark
>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>> encryption (by dm-crypt).
>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>      --name=iops-test-job --eta-newline=1 --size 100G
>>
>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>> number of good case is around 90% more than the best number of bad case).
>> The bandwidth is increased and the avg clat is reduced proportionally.
>>
>> * Sequential file read
>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>> The bandwidth is increased by 150%.
>>
>> Keep using PTE mapping when pagealloc debug is enabled.  It is not worth
>> the complexity.
>>
>> Kfence can be converted to use page block mapping later.
>>
>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h |   7 +-
>>   arch/arm64/mm/mmu.c              |  32 +++++-
>>   arch/arm64/mm/pageattr.c         | 173 +++++++++++++++++++++++++++++--
>>   3 files changed, 203 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 6986345b537a..2927f59ae9e2 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -749,7 +749,7 @@ static inline bool in_swapper_pgdir(void *addr)
>>   	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
>>   }
>>   
>> -static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>> +static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
>>   {
>>   #ifdef __PAGETABLE_PMD_FOLDED
>>   	if (in_swapper_pgdir(pmdp)) {
>> @@ -759,6 +759,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>   #endif /* __PAGETABLE_PMD_FOLDED */
>>   
>>   	WRITE_ONCE(*pmdp, pmd);
>> +}
>> +
>> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>> +{
>> +	__set_pmd_nosync(pmdp, pmd);
> I have a series at [1] which enables batching/deferring these barriers. I reckon
> it would be udeful to ultimately apply that same technique for painting the
> linear map if/when that series goes upstream. The benefit is that we wouldn't
> need to expose the _nosync helpers. But that's something to cleanup later. This
> looks fine for now.

Thanks.

>>   
>>   	if (pmd_valid(pmd)) {
>>   		dsb(ishst);
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e2739b69e11b..65b5b1ba48a7 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -620,6 +620,19 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>>   
>>   #endif /* CONFIG_KFENCE */
>>   
>> +static inline bool force_pte_mapping(void)
>> +{
>> +	/*
>> +	 * Can't use cpufeature API to determine whether BBM level 2
>> +	 * is supported or not since cpufeature have not been
>> +	 * finalized yet.
>> +	 */
> I think assuming the system has BMML2 just because the boot CPU has it is going
> to be problematic. I think you are going to continue to need to initially paint
> the linear map with ptes then later, once the system cap is finalized, repaint
> with blocks.

Please see the response for patch 1. We may be able to split it instead 
of collapse it.

>> +	return (rodata_full && !bbmlv2_available()) ||
>> +		debug_pagealloc_enabled() ||
>> +		arm64_kfence_can_set_direct_map() ||
>> +		is_realm_world();
>> +}
> Previously the decision was determined by:
>
> bool can_set_direct_map(void)
> {
> 	/*
> 	 * rodata_full, DEBUG_PAGEALLOC and a Realm guest all require linear
> 	 * map to be mapped at page granularity, so that it is possible to
> 	 * protect/unprotect single pages.
> 	 *
> 	 * KFENCE pool requires page-granular mapping if initialized late.
> 	 *
> 	 * Realms need to make pages shared/protected at page granularity.
> 	 */
> 	return rodata_full || debug_pagealloc_enabled() ||
> 		arm64_kfence_can_set_direct_map() || is_realm_world();
> }
>
> But now that you can safely split block mappings to page mappings when needed
> doesn't that cover some of these requirements? So perhaps you can do block
> mappings even when some (all?) of these things are active?

I did look into some of them. I don't know too much about realm, so I 
can't tell.

But pagealloc will change kernel direct map to invalid when freeing page 
so it is called quite often. The pagealloc debug is typically not 
enabled for production.

Kfence will change it to invalid when allocating kfence object 
(typically when allocating slab), but kfence typically allocates and 
maps its pool very early on ARM64 and the pool is separate from direct 
map and mapped at PTE level. So IMHO I don't see to much value support 
large block mapping for them for now.

>> +
>>   static void __init map_mem(pgd_t *pgdp)
>>   {
>>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>> @@ -645,9 +658,21 @@ static void __init map_mem(pgd_t *pgdp)
>>   
>>   	early_kfence_pool = arm64_kfence_alloc_pool();
>>   
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping())
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>> +	/*
>> +	 * With FEAT_BBM level 2 we can split large block mapping without
>> +	 * making it invalid.  So kernel linear mapping can be mapped with
>> +	 * large block instead of PTE level.
>> +	 *
>> +	 * Need to break cont for CONT_MAPPINGS when changing permission,
>> +	 * and need to inspect the adjacent page table entries to make
>> +	 * them cont again later.  It sounds not worth the complexity.
> I'm not sure I follow the argument? As far as I can tell, you only ever split
> mappings. You never collapse. So I don't think it's too complex to check for
> CONT bits and if set, clear the CONT bit from the block? That's a safe operation
> with BBML2. It means you need to iterate over the ptes which you don't currently
> do, but you only need to check a 1 PTE in every CONT_PTES.

Sorry for the confusion. Yes, I don't collapse. It seems I overthought 
this case, I thought I need to clear CONT bit for all PTEs in the block 
(for example, 16 PTEs). But it seems I just need to clear one PTE.

>> +	 */
>> +	if (rodata_full)
>> +		flags |= NO_CONT_MAPPINGS;
>> +
>>   	/*
>>   	 * Take care not to create a writable alias for the
>>   	 * read-only text and rodata sections of the kernel image.
>> @@ -1342,9 +1367,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>   
>>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>   
>> -	if (can_set_direct_map())
>> +	if (force_pte_mapping())
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>> +	if (rodata_full)
>> +		flags |= NO_CONT_MAPPINGS;
>> +
>>   	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>   			     size, params->pgprot, __pgd_pgtable_alloc,
>>   			     flags);
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 39fd1f7ff02a..ba2360ecb030 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -49,6 +49,145 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
>>   	return 0;
>>   }
>>   
>> +static int __split_linear_mapping_pmd(pud_t *pudp,
>> +				      unsigned long vaddr, unsigned long end)
> nit: are the double really underscores needed?

No, not really.

>> +{
>> +	pmd_t *pmdp;
>> +	unsigned long next;
>> +
>> +	pmdp = pmd_offset(pudp, vaddr);
>> +
>> +	do {
>> +		next = pmd_addr_end(vaddr, end);
>> +
>> +		if (pmd_leaf(pmdp_get(pmdp))) {
>> +			struct page *pte_page;
>> +			unsigned long pfn = pmd_pfn(pmdp_get(pmdp));
>> +			pgprot_t prot = pmd_pgprot(pmdp_get(pmdp));
>> +			pte_t *ptep_new;
>> +			int i;
>> +
>> +			pte_page = alloc_page(GFP_KERNEL);
>> +			if (!pte_page)
>> +				return -ENOMEM;
>> +
>> +			prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
>> +			ptep_new = (pte_t *)page_address(pte_page);
>> +			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
>> +				__set_pte_nosync(ptep_new,
>> +						 pfn_pte(pfn + i, prot));
>> +
>> +			dsb(ishst);
>> +			isb();
>> +
>> +			set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page),
>> +				__pgprot(PMD_TYPE_TABLE)));
> All the same comments that I made below for __split_linear_mapping_pud() apply here.

Sure

>> +		}
>> +	} while (pmdp++, vaddr = next, vaddr != end);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __split_linear_mapping_pud(p4d_t *p4dp,
>> +				      unsigned long vaddr, unsigned long end)
>> +{
>> +	pud_t *pudp;
>> +	unsigned long next;
>> +	int ret;
>> +
>> +	pudp = pud_offset(p4dp, vaddr);
>> +
>> +	do {
>> +		next = pud_addr_end(vaddr, end);
>> +
>> +		if (pud_leaf(pudp_get(pudp))) {
> Just do the pudp_get() once and cache the result. It's implemented by
> READ_ONCE() so your 3 invocations are actually doing 3 separate loads.

Sure

>> +			struct page *pmd_page;
>> +			unsigned long pfn = pud_pfn(pudp_get(pudp));
>> +			pgprot_t prot = pud_pgprot(pudp_get(pudp));
>> +			pmd_t *pmdp_new;
>> +			int i;
>> +			unsigned int step;
>> +
>> +			pmd_page = alloc_page(GFP_KERNEL);
>> +			if (!pmd_page)
>> +				return -ENOMEM;
> Is this really how we allocate pgtable pages for kernel space? For user space we
> have quite a lot of machinery for this.

The userspace page table allocation does something extra, for example,
     - initialize ptlock
     - set folio type
     - update NR_PGTABLE counter

We don't need them for kernel direct map page table, so just took the 
most straightforward way. However, __get_free_page(GFP_PGTABLE_KERNEL) 
may be better than alloc_page(GFP_KERNEL). It is used by memory hotplug.

>> +
>> +			pmdp_new = (pmd_t *)page_address(pmd_page);
>> +			for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new) {
>> +				step = (i * PMD_SIZE) >> PAGE_SHIFT;
> Suggest hoisting this out of the loop, then just increment pfn by step every
> iteration.

Yeah, sure

>> +				__set_pmd_nosync(pmdp_new,
>> +						 pfn_pmd(pfn + step, prot));
>> +			}
>> +
>> +			dsb(ishst);
>> +			isb();
> I'm not convinced by the need for this isb(). The dsb ensures that the table is
> visible to the table walker; that's needed. The isb() present in set_pmd() and
> friends to remove any "cached" speculative invalid translation marker from the
> pipeline, if I understand things correctly. I don't think we need to solve that
> problem here because you weren't working on a live table. The isb() in set_pud()
> is sufficient, I think.

I see, we just need one isb() when the table becomes reachable. Will 
remove it and the isb() in __split_linear_mapping_pmd().

>> +
>> +			set_pud(pudp, pfn_pud(page_to_pfn(pmd_page),
>> +				__pgprot(PUD_TYPE_TABLE)));
>> +		}
>> +
>> +		ret = __split_linear_mapping_pmd(pudp, vaddr, next);
>> +		if (ret)
>> +			return ret;
>> +	} while (pudp++, vaddr = next, vaddr != end);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __split_linear_mapping_p4d(pgd_t *pgdp,
>> +				      unsigned long vaddr, unsigned long end)
>> +{
>> +	p4d_t *p4dp;
>> +	unsigned long next;
>> +	int ret;
>> +
>> +	p4dp = p4d_offset(pgdp, vaddr);
>> +
>> +	do {
>> +		next = p4d_addr_end(vaddr, end);
>> +
>> +		ret = __split_linear_mapping_pud(p4dp, vaddr, next);
>> +		if (ret)
>> +			return ret;
> nit: personally I would make this break. Then have single "return ret", like you
> have for __split_linear_mapping_pgd(). Then all levels follow the same template.

Sure

>> +	} while (p4dp++, vaddr = next, vaddr != end);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __split_linear_mapping_pgd(pgd_t *pgdp,
>> +				      unsigned long vaddr,
>> +				      unsigned long end)
>> +{> +	unsigned long next;
>> +	int ret = 0;
>> +
>> +	mmap_write_lock(&init_mm);
> nit: I think the locking would be more natural in split_linear_mapping().

OK

>> +
>> +	do {
>> +		next = pgd_addr_end(vaddr, end);
>> +		ret = __split_linear_mapping_p4d(pgdp, vaddr, next);
>> +		if (ret)
>> +			break;
>> +	} while (pgdp++, vaddr = next, vaddr != end);
>> +
>> +	mmap_write_unlock(&init_mm);
>> +
>> +	return ret;
>> +}
>> +
>> +static int split_linear_mapping(unsigned long start, unsigned long end)
> As far as I can tell, you only ever split the linear mapping. You never collapse
> it. In that case, won't it just degrade to pte-mappings over time? I suspect you
> should aim to detect collapse opportunities.

In theory there may be kernel linear mapping fragmentation problem, for 
example, huge number of modules are loaded, but I've never heard of 
anyone reported this as a real issue. And AFAICT, no architecture 
supports this for now.

>> +{
>> +	int ret;
>> +
>> +	if (!system_supports_bbmlv2())
>> +		return 0;
>> +
>> +	ret = __split_linear_mapping_pgd(pgd_offset_k(start), start, end);
> nit: personally I would put pgd_offset_k() into __split_linear_mapping_pgd() so
> that it takes the exact same form as the other levels. Or mege
> __split_linear_mapping_pgd() into split_linear_mapping().

OK, I will clean it up

>> +	flush_tlb_kernel_range(start, end);
>> +
>> +	return ret;
>> +}
>> +
>>   /*
>>    * This function assumes that the range is mapped with PAGE_SIZE pages.
>>    */
>> @@ -80,8 +219,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long start = addr;
>>   	unsigned long size = PAGE_SIZE * numpages;
>>   	unsigned long end = start + size;
>> +	unsigned long l_start;
>>   	struct vm_struct *area;
>> -	int i;
>> +	int i, ret;
>>   
>>   	if (!PAGE_ALIGNED(addr)) {
>>   		start &= PAGE_MASK;
>> @@ -118,7 +258,12 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>   		for (i = 0; i < area->nr_pages; i++) {
>> -			__change_memory_common((u64)page_address(area->pages[i]),
>> +			l_start = (u64)page_address(area->pages[i]);
>> +			ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>> +			if (WARN_ON_ONCE(ret))
>> +				return ret;
>> +
>> +			__change_memory_common(l_start,
>>   					       PAGE_SIZE, set_mask, clear_mask);
>>   		}
>>   	}
>> @@ -174,6 +319,9 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
> set_memory_valid() actually calls __change_memory_common() directly (so it
> bypassed the split logic in change_memory_common()). Is it possible that it gets
> called for a non-split region? I guess you'll need to handle that case too?

The set_memopry_valid() is called in the below places:
     - kfence: it requires map at PTE level regardless of 
kfence_early_init or not
     - pagealloc debug: it requires map at PTE level too
     - execmem ROX cache: it seems like only x86 supports this right now

I don't think we are going to support large block mapping for direct map 
for pagealloc debug and kfence as I said above. We need make 
set_memory_valid() split page table when execmem ROX supported is added 
for arm64. But we don't need do it right now.

Thanks,
Yang

> Thanks,
> Ryan
>
>>   
>>   int set_direct_map_invalid_noflush(struct page *page)
>>   {
>> +	unsigned long l_start;
>> +	int ret;
>> +
>>   	struct page_change_data data = {
>>   		.set_mask = __pgprot(0),
>>   		.clear_mask = __pgprot(PTE_VALID),
>> @@ -182,13 +330,21 @@ int set_direct_map_invalid_noflush(struct page *page)
>>   	if (!can_set_direct_map())
>>   		return 0;
>>   
>> +	l_start = (unsigned long)page_address(page);
>> +	ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>> +	if (WARN_ON_ONCE(ret))
>> +		return ret;
>> +
>>   	return apply_to_page_range(&init_mm,
>> -				   (unsigned long)page_address(page),
>> -				   PAGE_SIZE, change_page_range, &data);
>> +				   l_start, PAGE_SIZE, change_page_range,
>> +				   &data);
>>   }
>>   
>>   int set_direct_map_default_noflush(struct page *page)
>>   {
>> +	unsigned long l_start;
>> +	int ret;
>> +
>>   	struct page_change_data data = {
>>   		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
>>   		.clear_mask = __pgprot(PTE_RDONLY),
>> @@ -197,9 +353,14 @@ int set_direct_map_default_noflush(struct page *page)
>>   	if (!can_set_direct_map())
>>   		return 0;
>>   
>> +	l_start = (unsigned long)page_address(page);
>> +	ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>> +	if (WARN_ON_ONCE(ret))
>> +		return ret;
>> +
>>   	return apply_to_page_range(&init_mm,
>> -				   (unsigned long)page_address(page),
>> -				   PAGE_SIZE, change_page_range, &data);
>> +				   l_start, PAGE_SIZE, change_page_range,
>> +				   &data);
>>   }
>>   
>>   static int __set_memory_enc_dec(unsigned long addr,


