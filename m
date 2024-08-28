Return-Path: <linux-kernel+bounces-305461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F66962F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4C6B218F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F9A1A7074;
	Wed, 28 Aug 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DkOky9Vz"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020140.outbound.protection.outlook.com [52.101.56.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF51A4F38
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867881; cv=fail; b=sVv9nGGEEaNCNZl63Zo1Qz3xv2j5Vm94h7MfNaovvn1V5tMJCJh8PL8vSpM+3VjdUD0Lwp68hUniqQqhfHZP+RW2En2wyDLVtxjw7PR4Df7m8/e5y9YWs3pYRqbT/Bh87Y5e6RYqLkU/solqUYcH/MN3gwLdoSM0MFTozD35HD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867881; c=relaxed/simple;
	bh=BRfZSNb5dty2HBF7RB1TpYXmhR9JYlh0R/MC8Q5AqTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDFB/3G5KdlFq+DFSAon5JRZCT9p8A+s0ypPcAH9QnABDFwwbTl61AFF+4CGyaeJdrb4zm+W/4/FQsgV1j8TGvStVnqIlH3am2HA8dUTooA9Y4JNWzUT6Kzo100M0o/y7fiPlkqhqQuO0M9XHsZ3uChKzHZUVYJZXzmEGrbJv0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DkOky9Vz; arc=fail smtp.client-ip=52.101.56.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ1dWgM1lL0KPVbSQsnideALfHu/MdCQB2B02yYeW0q5sONOtF4lgBwteWUHCJ3HMT4xi35LaaO7Z9fCFveCTM3sm2lRJ4Dx33PSYk5x8003aXAIaIBFkKnjD9b6lumxn4jws0lsIylrtgRLhqsj5C2Te1MoYybOEOEHqqTylPXY6/I3jVRsGtVP5eg5yJlN17o7jlGrQHDWhsfN93TfY2z8/WnwZddCmIYbQvdT+fj7ocsbg00uNJD6acpG+CAPWzNifTMprm3Jh+yhGH0Mp/hn85BrwTYiIwcD3eZJq66WhAkIJgFp2xHokQzFKJioHpsInz+O3We36Huf80nYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzmDgw1fD47/geQhCP7dPsHpy7q09YlvvXTH6UUnQLw=;
 b=WqipmzOr9SODyhCsriv8PWYmLPyqbQavael+IGGTToZFB29EH3VLb2Tk9COXC9otxjqWpgzZRogBBtyMIdNwG1F6HfW+SC5nu2mRYKGlulrotyT8e5BE0IYsEKUuNDjs0yAzFp9VeE4CReDrcMiPk26SaTNxJ3algHwcsq2VfhEPMlYvvwxkhXNlGO47HKRei6pnhxPOLjf93tQRJUopLjeFlh5IsC0BD2qVLq50aPr4ziUeKO64s+u5I6/fKIFBpmKhFMAHHYtHM6neNUPRJv1uhXbhDteAXOOR4pYN4uqhePb+oxMkrmEkMeFNajRkR8YkftlY/1mbkn1J5O1XeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzmDgw1fD47/geQhCP7dPsHpy7q09YlvvXTH6UUnQLw=;
 b=DkOky9VzRlp4QeZnEqFvoPnwG45qPZTHD9xnQiFeMWVTPqpvNVkq5KGT8w03kdHUVtlt4G9M1rTw/gFvjGuaYZog1oohQ4Fn/bbLJf8LQCLrcMLARq3lVB3KJdyqRAxfmRr3L6yoAlYUU2IdGchEg4Kyhc0DPA/d/TcGGJfc9wQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO6PR01MB7433.prod.exchangelabs.com (2603:10b6:303:134::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Wed, 28 Aug 2024 17:57:56 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 17:57:56 +0000
Message-ID: <767b515f-1c90-4795-995e-b25baaf56266@os.amperecomputing.com>
Date: Wed, 28 Aug 2024 10:57:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/2] hugetlb: arm64: add mte support
To: catalin.marinas@arm.com, will@kernel.org, muchun.song@linux.dev,
 akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821184752.3535276-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20240821184752.3535276-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO6PR01MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: eac58fb1-f91a-4997-eb05-08dcc78af20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmpZdlJuTlFxVHdWNm1OYzdkNE5tNERnMGtiMTRxcXRvZzlMTjdwWmQ4N0Rl?=
 =?utf-8?B?K3BhUVNjY2RwMjhORDEyakVySTNOTTlWd1dEV2ljNjdGd2Nhcm13VzdHY3RH?=
 =?utf-8?B?WStFM0dHWE5hRWE0QzkxOVpmUWdLUHY3YndndG1wUTY2dGNqaHBGenFQR3Fj?=
 =?utf-8?B?VTVmOFVkVDFaYnoxTldaUGNVQm8xMDVzd0NOMDRWNnpQTmcxWTA5WFkrcDNI?=
 =?utf-8?B?U0lnN1ZCRWVyVFBSUmxORG9nOUZDMWdiYWJldnZYQzBzTjZVVUZHTWthWEM3?=
 =?utf-8?B?cHZnUzFaUGNXZHppWGQ4Y1V1MThhS1hyeFVLclFiMEt4R0NuRDJTa0tPRWZN?=
 =?utf-8?B?ZnZIYnF6SjBzTUxMS3J1ODJqREtmV3F6bmUvNUVSUnI5WTZhWEtLYm1ETXlx?=
 =?utf-8?B?NHJKSTlyY1B2RXN6L0NremlRckErL0ZOQnRBWDRpeWw3NjdwMTdlVnVDeDg2?=
 =?utf-8?B?azhMM25rL1d0QXNmb3ZFOEsxcGdRTlptYzY1S05XVUtwajJvcXhVbkhoOFln?=
 =?utf-8?B?dTRIbTF6eFFSVDFlNTZ4RUNYb1RXdlRBb1R5NWhVR01KdTRpYUVnSm1kWGJD?=
 =?utf-8?B?eGhPWHdFNjljR3Z4L2hMOUlkcDFSTjlLS1JZSHRnRDBQbTM3c1dHNzhzcFBr?=
 =?utf-8?B?WUF5S0lxRUJlUFgyN29xTWhLb2d0bVpxOXNaSEJXKzZhRjhJTStITjhLbUgw?=
 =?utf-8?B?WXl6cDhyejBuNHMwVjREbkVJYzl2L09tNmdqdzNnOU1jR1E3Sjhvcm1wOUdY?=
 =?utf-8?B?NnFaTWt5RXVQOFpSckFnZFQzSlZiVnhSZ0xnczJIU1YzMk1vSVhqbGhVbTRo?=
 =?utf-8?B?Z0pZVTFVRWg1SW85NjdlSWk1R1B4eEhDVmROZ0lYdDdwZERWWmtwM3BpWGxW?=
 =?utf-8?B?akFDVTkxeGRZYU5Sc29QTW9mN0toZkFhbDlxM3lOdm15b0NucHVleXNGWWxR?=
 =?utf-8?B?NVJ3QkxQSDFWbCtuOFlwL1JKdFJFSUk2SFdsU1J1NUUxKzlESThySjVTV041?=
 =?utf-8?B?VmdWd21rK24vY1pQb09GVWZVMnhoYm9RSm1icjhoSXFkeUtQS2d4TW1ES1Rt?=
 =?utf-8?B?SDFiWTZaMGJEZ2FtUmpxMWxEME01djlFQXZyaStHSmlnQ25QQWd6ZkZlSzl0?=
 =?utf-8?B?b0hqQXF0WFlDSytVdDZybnZlTlhLOFJ0WFFsYTMxcG90bk1aRVpyL0RrUmwz?=
 =?utf-8?B?d0lLOThFT0xucTBVSXZ6K1JyeHh0Nm1hclZwa0NWWkFyZ09TRlB5ODZrcHd2?=
 =?utf-8?B?dk1DNE5ZUTB6M0xVc1B2MW9tVkJma0x2SG5mUVEyL0ordkxWbDNrMHVmL2NQ?=
 =?utf-8?B?SlBZSVhVaWFFTklaWGMwL0VoOFBmQ2dueUxrU0F1K0sxZGEvQThxalZpc3pp?=
 =?utf-8?B?eTNUZ0w4RThmTHhMMFV6aHM1Z1g4QmVLTHVERDZMQXJyRU5DZHNMdkFCanNk?=
 =?utf-8?B?SFhXL3luaUVnR0NVdFJLZmRYUlA0ZUN6SGpPbS9JdmNUWTZadWtNcFdsYUJK?=
 =?utf-8?B?WTNBcGp4bmxLc2U3aHFIQTM1YUlLdTgvV3VCL3NybXEvVlo1UzRmbEpoemx1?=
 =?utf-8?B?L2NNSTZTd0drbzMwaEhWZCtrY3Z2OSttQ3gxSTNFL014Ymx4K1VQWnczT0pm?=
 =?utf-8?B?TGp5WUh2Z1RrTUFtR2RqbmRnSUZtT2hJSXI0d1cxb2luano2M21OU2ovU3c0?=
 =?utf-8?B?YzdPZWhBcGhQNi8yOVFJd2ZVZjdSSE5ZSE1pSEFGTE9oUThHTm84Nk9lSG56?=
 =?utf-8?B?dmZXckxhaFlJSG5GeW1nQ1RDV1F2blFVZHYvL2lvS0kreDhOTEM0eDJNb2hx?=
 =?utf-8?B?aXczcTBHZm5KQW9OTW4xQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGdyYlhMN2dhTnltRUFDWndEREZZVzNWL011RnV3bkVuOHVlZlluY2VFcEtL?=
 =?utf-8?B?dlZRbnkvc0FUYzhIb1c0enM2UWYzRDhmT1JxbDJXVklaVk5WcFBGUURsNVc4?=
 =?utf-8?B?MkFmOHAyWWhYKzlmY2xDRHlnWmpxbXY2MEQ2T3R5blpVYWdubVI4Q3dwcER4?=
 =?utf-8?B?L1ErT3RhZ2loK2h6cGpoTHg3MnBKUEVhOVgybE54dGZPNUpiWmZiZHJ3Z28w?=
 =?utf-8?B?cHB2NWh6RUh5WkIwUy9FSzNlVExFSGRmek9LVW9WYkE2OVdXVUhxbnlITFdC?=
 =?utf-8?B?bWVsRjlwY0NaTkJicll4M1l2R0xUdE5yanNGTk1mNE1sZmVQYmVpN3FIWmp4?=
 =?utf-8?B?Z1hmN1o4elp1b3dpNHVJd2hQRWxLVCtRZGdJVmJLMk8vZDk3Y1ZnenVrRDJS?=
 =?utf-8?B?T1hic0djQVZHWEMvdG5wT2hLNWJ6UlpsbDY5T1dFTWFUOGNCOHRHa3RIb3da?=
 =?utf-8?B?cFh2TkJQSmdzSGJuTVJ1REJSb0d3VjQrOFA4bnRnSDFnVCt6dDVqakV6TGRB?=
 =?utf-8?B?YXRMRVlJZ2lYeUkzcHFZdERXWWFnMmlHYUZSVitpSkczUXBwOERrNG5XUW93?=
 =?utf-8?B?a2VGTTd2MUZvN2lNaGhJeW90bEFRdnRoVHN0MkVNSXVNT2Y4aG1yWEVlbkFt?=
 =?utf-8?B?aUxNeDIzdk9FckQxSUFhLzhGNXNGRGN6bHJsTUZTOStQbFB4MjZOL2R5a1hm?=
 =?utf-8?B?OWVTMkRvMHN5bjRHTGlUK0pKdWlDank0cmF6ZjYvN3R5K3JiNWVRTzEvMFlY?=
 =?utf-8?B?aC9xdnVhQ0UwWnVYeGFIbEVyS2YrelE5MlMvMVdwYm9NRk9INlNhZmh0Wlkr?=
 =?utf-8?B?dWE1bDE0cDZjWXBKZG8xUUY0bEtoOVFmUGRtWGNPeUUyekVsN2JXWkVDS2ky?=
 =?utf-8?B?cFlJNklhbS9UMzNVV1kxRXBvWFZNdFI3WTRoeGYwTEdtajNoNysyRXUyT3Ir?=
 =?utf-8?B?SlVqQXgrZEZKbmd2a1U3VkI3UTJJWHJBbFFhR29TT201bWJBZ1VuSGRhQnZq?=
 =?utf-8?B?L29wY2J4TkNEUUhjT2FIUkI5eG14T3NLK25zK0VPS3NHVmxvMS9MbXpNeDBn?=
 =?utf-8?B?cWswQU96eUhSdU9HNmhCUjBDaUljdWgrclpQazRkUUFNY0NGYXp4Q2JxbUNl?=
 =?utf-8?B?RFVCeGp4cTdCVjBtSjhLblZDaXdYdGJmaEl2MGI1SlZOaERydUNibU5NeWpU?=
 =?utf-8?B?YlRCekpjMkZOYjhrelphNEhlM1N4Ui9vSncyVEVFUmxTRVpJc1ZxeGNuMnA4?=
 =?utf-8?B?d2h3eVpRR2VmQkQ0SVlrc2g5cU5weE5SSWpHb0Z4eGxUeWZBcGIvZGQ3bjlh?=
 =?utf-8?B?Mkwzd2FlZmlaVTRWeUUzdUIzRVNXeDZpZzUrOXFvUG12YzlYUUZlbk9PTVVX?=
 =?utf-8?B?MFpFQlUydGhsZmgwNEMzTTF3QU9nMTlROXg0aTR1VGxTeEhMai91cmdHVWZH?=
 =?utf-8?B?aTBDM0dZb25ZU1lQQklJL1NWbVpxeGNpSFI4ZUkxdlIvNjNqK2d2dlR4c29w?=
 =?utf-8?B?Z3pJckdjYlBWd3dWMzV6YjlpckRSWklvVjRBanBoMmxEc1FFZWdwa2c1YnpG?=
 =?utf-8?B?SXlMM2J5eXJZU1lGa2lNcXBjOUw0V1ZlaXdiN2o4Vi95enB0ekxtWGVZbmFm?=
 =?utf-8?B?eStOanB0YW14dU9UT0ZuelhFbGZVWjFjVUsxTDNSZGZBeWZpa3Avd0lLRzhX?=
 =?utf-8?B?S3RmVFNMR3RnakFOWDBEaFN3UFZRMUdxUGsyQlVxNVBIL1E4WGtUdDBoUmM0?=
 =?utf-8?B?TzVPQWlBSG14OFgyTEVxOXkrZi9tTUtVNWkyY2hKR3BudXdnSjdFb0Q1Qlc0?=
 =?utf-8?B?TjBmKzdiMS9RODlwUHk1SmIyckd3aGgyQzZ2NTR6Z3V3ODRFVFV1QkVvY0lC?=
 =?utf-8?B?WlJjTHV2aHIvdzBWRjZzWXBJc3pMcFZQb2ZPNW8rRUdLcW1SZmNVc01ZaUo0?=
 =?utf-8?B?RUtORG41cldadGdGbTFCNzRFQjdBSWx2YkVDd1dibWFZamJmcVNaanQrWElI?=
 =?utf-8?B?OVFreHRWbloyQmZqRGozaEJvTUduRk9KazBjaFYyUXhGRE1VclZoRUwrUDdJ?=
 =?utf-8?B?KzNGclQ4cmRaN2UzWXdaY1V4N1RhV1lZWmFmMnkxN2xQNkpGWm9vRUdaSmZX?=
 =?utf-8?B?MFNSMCtWK1U5U2JFaVBGMXZkOG1wWFZudVVmNXExSGhOTGo3SENjVDJnaW9M?=
 =?utf-8?Q?N17v/L5ROn4vTNyEKMxwTJU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac58fb1-f91a-4997-eb05-08dcc78af20e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:57:56.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvYZ1dtz2QMdk5Mz5C6hPp8RIVL3atFFvwWKPygbF1z+11bQbErTKSBv1hD/szLOMvy2VriOJ0iK7QFemt8K1BwA351/e+bsKgd3cY+BT34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7433



On 8/21/24 11:47 AM, Yang Shi wrote:
> Enable MTE support for hugetlb.
>
> The MTE page flags will be set on the head page only.  When copying
> hugetlb folio, the tags for all tail pages will be copied when copying
> head page.
>
> When freeing hugetlb folio, the MTE flags will be cleared.
>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/include/asm/hugetlb.h | 11 ++++++++++-
>   arch/arm64/include/asm/mman.h    |  3 ++-
>   arch/arm64/kernel/hibernate.c    |  7 +++++++
>   arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
>   arch/arm64/kvm/guest.c           | 16 +++++++++++++---
>   arch/arm64/kvm/mmu.c             | 11 +++++++++++
>   arch/arm64/mm/copypage.c         | 25 +++++++++++++++++++++++--
>   fs/hugetlbfs/inode.c             |  2 +-
>   8 files changed, 90 insertions(+), 10 deletions(-)
>
> v2: * Reimplemented the patch to fix the comments from Catalin.
>      * Added test cases (patch #2) per Catalin.

Ping... Is there any comment on this version?

Thanks,
Yang

>
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 293f880865e8..00a1f75d40ee 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -11,6 +11,7 @@
>   #define __ASM_HUGETLB_H
>   
>   #include <asm/cacheflush.h>
> +#include <asm/mte.h>
>   #include <asm/page.h>
>   
>   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> @@ -20,7 +21,15 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
>   
>   static inline void arch_clear_hugetlb_flags(struct folio *folio)
>   {
> -	clear_bit(PG_dcache_clean, &folio->flags);
> +	const unsigned long clear_flags = BIT(PG_dcache_clean) |
> +		BIT(PG_mte_tagged) | BIT(PG_mte_lock);
> +
> +	if (!system_supports_mte()) {
> +		clear_bit(PG_dcache_clean, &folio->flags);
> +		return;
> +	}
> +
> +	folio->flags &= ~clear_flags;
>   }
>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>   
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..304dfc499e68 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>   	 * backed by tags-capable memory. The vm_flags may be overridden by a
>   	 * filesystem supporting MTE (RAM-based).
>   	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>   		return VM_MTE_ALLOWED;
>   
>   	return 0;
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 02870beb271e..722e76f29141 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
>   		max_zone_pfn = zone_end_pfn(zone);
>   		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
>   			struct page *page = pfn_to_online_page(pfn);
> +			struct folio *folio;
>   
>   			if (!page)
>   				continue;
>   
> +			folio = page_folio(page);
> +
> +			if (folio_test_hugetlb(folio) &&
> +			    !page_mte_tagged(&folio->page))
> +				continue;
> +
>   			if (!page_mte_tagged(page))
>   				continue;
>   
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 6174671be7c1..b21f706018f7 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -38,7 +38,22 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>   void mte_sync_tags(pte_t pte, unsigned int nr_pages)
>   {
>   	struct page *page = pte_page(pte);
> -	unsigned int i;
> +	struct folio *folio = page_folio(page);
> +	unsigned long i;
> +
> +	if (folio_test_hugetlb(folio)) {
> +		unsigned long nr = folio_nr_pages(folio);
> +		/* Hugetlb MTE flags are set for head page only */
> +		if (try_page_mte_tagging(&folio->page)) {
> +			for (i = 0; i < nr; i++, page++)
> +				mte_clear_page_tags(page_address(page));
> +			set_page_mte_tagged(&folio->page);
> +		}
> +
> +		smp_wmb();
> +
> +		return;
> +	}
>   
>   	/* if PG_mte_tagged is set, tags have already been initialised */
>   	for (i = 0; i < nr_pages; i++, page++) {
> @@ -410,6 +425,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>   		void *maddr;
>   		struct page *page = get_user_page_vma_remote(mm, addr,
>   							     gup_flags, &vma);
> +		struct folio *folio;
>   
>   		if (IS_ERR(page)) {
>   			err = PTR_ERR(page);
> @@ -428,7 +444,12 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>   			put_page(page);
>   			break;
>   		}
> -		WARN_ON_ONCE(!page_mte_tagged(page));
> +
> +		folio = page_folio(page);
> +		if (folio_test_hugetlb(folio))
> +			WARN_ON_ONCE(!page_mte_tagged(&folio->page));
> +		else
> +			WARN_ON_ONCE(!page_mte_tagged(page));
>   
>   		/* limit access to the end of the page */
>   		offset = offset_in_page(addr);
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 11098eb7eb44..77e181d96e97 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -1050,6 +1050,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>   		void *maddr;
>   		unsigned long num_tags;
>   		struct page *page;
> +		struct folio *folio;
>   
>   		if (is_error_noslot_pfn(pfn)) {
>   			ret = -EFAULT;
> @@ -1062,10 +1063,13 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>   			ret = -EFAULT;
>   			goto out;
>   		}
> +		folio = page_folio(page);
>   		maddr = page_address(page);
>   
>   		if (!write) {
> -			if (page_mte_tagged(page))
> +			if (page_mte_tagged(page) ||
> +			    (folio_test_hugetlb(folio) &&
> +			     page_mte_tagged(&folio->page)))
>   				num_tags = mte_copy_tags_to_user(tags, maddr,
>   							MTE_GRANULES_PER_PAGE);
>   			else
> @@ -1079,14 +1083,20 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>   			 * __set_ptes() in the VMM but still overriding the
>   			 * tags, hence ignoring the return value.
>   			 */
> -			try_page_mte_tagging(page);
> +			if (folio_test_hugetlb(folio))
> +				try_page_mte_tagging(&folio->page);
> +			else
> +				try_page_mte_tagging(page);
>   			num_tags = mte_copy_tags_from_user(maddr, tags,
>   							MTE_GRANULES_PER_PAGE);
>   
>   			/* uaccess failed, don't leave stale tags */
>   			if (num_tags != MTE_GRANULES_PER_PAGE)
>   				mte_clear_page_tags(maddr);
> -			set_page_mte_tagged(page);
> +			if (folio_test_hugetlb(folio))
> +				set_page_mte_tagged(&folio->page);
> +			else
> +				set_page_mte_tagged(page);
>   
>   			kvm_release_pfn_dirty(pfn);
>   		}
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 6981b1bc0946..1fa51ac4e3f4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1401,10 +1401,21 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
>   {
>   	unsigned long i, nr_pages = size >> PAGE_SHIFT;
>   	struct page *page = pfn_to_page(pfn);
> +	struct folio *folio = page_folio(page);
>   
>   	if (!kvm_has_mte(kvm))
>   		return;
>   
> +	if (folio_test_hugetlb(folio)) {
> +		/* Hugetlb has MTE flags set on head page only */
> +		if (try_page_mte_tagging(&folio->page)) {
> +			for (i = 0; i < nr_pages; i++, page++)
> +				mte_clear_page_tags(page_address(page));
> +			set_page_mte_tagged(&folio->page);
> +		}
> +		return;
> +	}
> +
>   	for (i = 0; i < nr_pages; i++, page++) {
>   		if (try_page_mte_tagging(page)) {
>   			mte_clear_page_tags(page_address(page));
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index a7bb20055ce0..0f3b07d4a5cf 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -18,6 +18,9 @@ void copy_highpage(struct page *to, struct page *from)
>   {
>   	void *kto = page_address(to);
>   	void *kfrom = page_address(from);
> +	struct folio *src = page_folio(from);
> +	struct folio *dst = page_folio(to);
> +	unsigned int i, nr_pages;
>   
>   	copy_page(kto, kfrom);
>   
> @@ -27,8 +30,26 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (system_supports_mte() && page_mte_tagged(from)) {
>   		/* It's a new page, shouldn't have been tagged yet */
>   		WARN_ON_ONCE(!try_page_mte_tagging(to));
> -		mte_copy_page_tags(kto, kfrom);
> -		set_page_mte_tagged(to);
> +
> +		/* Populate tags for all subpages if hugetlb */
> +		if (folio_test_hugetlb(src)) {
> +			/*
> +			 * MTE page flag is just set on the head page of
> +			 * hugetlb. If from has MTE flag set, it must be the
> +			 * head page.
> +			 */
> +			VM_BUG_ON(!PageHead(from));
> +			nr_pages = folio_nr_pages(src);
> +			for (i = 0; i < nr_pages; i++, to++, from++) {
> +				kto = page_address(to);
> +				kfrom = page_address(from);
> +				mte_copy_page_tags(kto, kfrom);
> +			}
> +			set_page_mte_tagged(&dst->page);
> +		} else {
> +			mte_copy_page_tags(kto, kfrom);
> +			set_page_mte_tagged(to);
> +		}
>   	}
>   }
>   EXPORT_SYMBOL(copy_highpage);
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9f6cff356796..f944e8e7126b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>   	 * way when do_mmap unwinds (may be important on powerpc
>   	 * and ia64).
>   	 */
> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>   	vma->vm_ops = &hugetlb_vm_ops;
>   
>   	ret = seal_check_write(info->seals, vma);


