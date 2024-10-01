Return-Path: <linux-kernel+bounces-346586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388ED98C63C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D1B212FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E51CDA09;
	Tue,  1 Oct 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q/PM9Be4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2110.outbound.protection.outlook.com [40.107.93.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9B1CBEB8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812091; cv=fail; b=crzFbBkg65Cubk6Z2rC3AqVePIJGvA/mE9KusR7T3aRxNvteDGf8ViSQQt+vHg3Ik4va+DAeCc0uy0rtC4kBURz0uQljZP8au1WFFYsXhW2Phv6Kp+hq+zXmjQ5A0HgXmCm1auqiGbJ1Ka4lHMPLt5dA5nY+9+wLoXbLQulDCqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812091; c=relaxed/simple;
	bh=LJBLpbsfgNjkCtyXcq1wQcQ7woF1DmRDCG1c0BuQ62s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MH3itIm20UTraxyiZhph/tl21z7OfJwZ+Jn5cSUVl7gsgm6SDLBhj4J1faouOIjoehX9kTx4+Vtfftjm5e3mu2tIOdn4hyM4D8gMHCiPQc+w684RPpX0sFaJBfjEJXgny9h6PlbP/KnGVFmSy6oNn1YkCRiZLZ0arRYL4NQxp4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q/PM9Be4; arc=fail smtp.client-ip=40.107.93.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3US0DdOQ/ZPM+J/3Smn+Ij0Izp82MXN2I9U0v0I0WWZF7QLOkHf83es/J84nmdfOTfe6AZpMsKktPjy+K2arfcf3c3K/v56CsLpOfhQsXcQeTRrq6O7wzYpQNBxJxUOGSW+zJqfphhnMDNh3aH8xAghdYW1jYzsnYCaf/b2HnF1QlKVlGS1cxl9lIqu0MTwairJO5P/CRFFZQoA5E62hi4XHl2U+CNRm9GU7NnsLMzJkyLYCXgZgOfakxy8/aeV5p8/tBxpq9/WIG8PzqNI+sr6UJCzWJWyn/gMHQJhCYX4NFuNzoe6rTata5EkbPP6G+PMycPVaFNrf5qHaAi8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkxOCKElOI3w7mNzMbUy3Fq589s4Utye/PiPTFGjqz8=;
 b=bhvui9S13QyvBIB4skbB0YorBv3WwK8z5yStweJzo0Fh/aNVyGHmuhj3Fwg2Z5EnHWwSLx9e9iiLMx04phamWrB4VPZEvDML3sXYgap0XZWWrnBJXIWQqFyXRQv31PQ1Os/SsfY6fTGVEb5QnqOobrrysVXuzxMdZCI431ChdA7efF6GtwpJKOQrB0p8Blwd+wrTGC7sm0EsZdf8IzMUNlQhslwlSzv/PRBr97j+QR+Uk0xNNsCXIf1SY10vF+KpD2diQcNfdwCSoTlk26Dtaxv6NtfbVpsTNN7TvWd0ByXqIGc0GrbBXhH19GS/8eqeiiKQok+BhQU/7I8hnUHSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkxOCKElOI3w7mNzMbUy3Fq589s4Utye/PiPTFGjqz8=;
 b=Q/PM9Be4c8wmIbn+6zo4w2pqMi/3BXKg93ACA6Wx7VGxqF9JudzIZdLYiFXMVaP29xf4UytDeazqC5cTxFQbSnJpIPX61+QO7RzRm3/VO64FEZ9d5+B5UwBK0mD5X8XF+4XROhjp8afZf0I31OO3fklQebaR8BmXBOVTsa2DoKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH3PR01MB8575.prod.exchangelabs.com (2603:10b6:610:168::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Tue, 1 Oct 2024 19:48:04 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 19:48:04 +0000
Message-ID: <742bd6d6-9d25-4f8c-9574-3d39a91c89cb@os.amperecomputing.com>
Date: Tue, 1 Oct 2024 12:48:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@ziepe.ca, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <ZvxNo8ZWeyBOBU8b@Asurada-Nvidia>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZvxNo8ZWeyBOBU8b@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:b0::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH3PR01MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 624b91fc-7b8f-4c62-61c3-08dce251f6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qzc3KzlaSi8rS04zenBEWktGdnZtMHFBT1orM01NaGVGa1htNG5HNGluUzh4?=
 =?utf-8?B?aXVGaE5VS05hNnBLSTdjSGVHdk5NUzd0Y2FhVlBHRnBFVStWVFIvd3pQdFV5?=
 =?utf-8?B?SFhiSFZFc2oyRjNsYUpDY2tJQ0liOW9obU84Ny9EYnRraDJ3a1BxL1dNdDAw?=
 =?utf-8?B?WGg2bUNTS3QzbU1UREthdDB1Wjk3VlJCSE03MSsyZmZhczFZOUQrL3V0RHcw?=
 =?utf-8?B?dWI1dFh1SnczOXp6anhRaitVZGZhcUJCUGs3QWhwYWdOT1NSb1pSWkVuekRC?=
 =?utf-8?B?TW05cDVzQlZtWHQrMW0zUVBoTGttejJVQTJmMkg4dlcvMWtXS2NFTUNsaUt6?=
 =?utf-8?B?NUxWRDR6ck9KQ1VlSmtCdDFqMG5DVTJOMFJaZUdQNnNnVmJxSThYUHk2SDcw?=
 =?utf-8?B?T0xMR1QxWmE2MFhaMkRzQ2tFWi92S0RIV2Q2ajlGbm9Eam5BYnpkM2RSTVFM?=
 =?utf-8?B?UTAyMzJuVXpJRW5nS0F3d09hdFA3NFY3bENYWWhQWFJoMDA2VGxCZTJIZDYx?=
 =?utf-8?B?cTVLcVcyQlI1WWc3UU5LSE4vK0xNOHRsM3RSd2tpWnhHN0RUdjRpS2dpL2VZ?=
 =?utf-8?B?YUUvYmZZZTdGZWg2c29qdlZ5Z1BvbFpPOUI1YXBIVGJpR1pTQTc1SE1UVFJz?=
 =?utf-8?B?R0g1VG83dnJnbHZ6SmFDWlJscXVCZHFCNjVQTzB2RVZmZTM3YWEyUVJ6d09u?=
 =?utf-8?B?eWlpUTdLU0xPQndTV2FKWlVpc2ZYeFZQNFJmcHhBaHZQdHd5UDBJQmVJK1JL?=
 =?utf-8?B?RW04UFVZVlV4eE9RaGtLQmxRVnk2Y0VPYmVrQUMvOS9ZZ2ppL3BsamxJaHh6?=
 =?utf-8?B?Zi9jdUVLNWNyTG5ZTk9FVG40V253QjVTSWx0YnFQREdOeTNZdnBsN3FGM25a?=
 =?utf-8?B?TXlvVVlBK0cvS3ZnblJXWDN4SHhodGp2aFpqc3hTQXBDeXYrM3NJUExMeFlj?=
 =?utf-8?B?ZlBKVE9rYWw5MFgvUVo3a3M1WkY5bVEvYUtpUTRkS0sySkJaMlpuMEpGTXdP?=
 =?utf-8?B?bEQwbGJhNXZNamswMDVLVjdNenVWTWtKTU5oOVBiem8weCtUeEI1QXBaeENn?=
 =?utf-8?B?dzRtUUJneDhhRzFCd0ZYRHNkUHdtR0xVTjNGSkcxNGR5ZC9iQ1ZOWnFWbFRh?=
 =?utf-8?B?M3k5T0pRT0tZMEdMUFhWT0VsejM3Nnh0UDdSWnpuTWliYk53YjJVd243VlVs?=
 =?utf-8?B?a2pud1phMU5IV3BZWjhCRUQxUjlSVm9zSGZLbkhER0VqbklCakV3QjMrWHpU?=
 =?utf-8?B?d25pQ1lneXBTdnFJK2E0WUhzekVXbE1RN1FFeWwxVi9jRjl6YTEwY0VlVm9v?=
 =?utf-8?B?Ni9wOU00cDBFQVlBa2czN2hZTk5JMlFTaEhYUVJrRndJS2R0UkMrTldBYXZ3?=
 =?utf-8?B?SlhwNjlTaTBocVRVM2FkMEtWRW5oNFlXNHZRamZjamQxdTFVUzJ5b25TQ2pz?=
 =?utf-8?B?bUtJTnV6SEk0b0E0MjY4b2tUU3RqSzJzemVtWXNDMk92aEkxQ1grSG5vWVN0?=
 =?utf-8?B?Q1Bhc1dBekptT0cyNE1BVTZkU2FYWGxZcFVEZFF2QzcvL3B0Z1kwVFVwYml2?=
 =?utf-8?B?SHlITFJUMWYwdFVQbk9md1NCRmovSzFxN2pGZDFrY0Z2bFA3ZkdlR01xd0Mw?=
 =?utf-8?B?c3N5N3JjZHUrdnZtQi8vMzFQZ29CeVdjQSswUUNXZjdaWEhHa2x0alhLK1Zz?=
 =?utf-8?B?R0pTRE1JcVZRMzBTclFFRHRTRDYzbFpZbm9nR09zS1RFT0RBUlJRYmdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhrRjBvbnYrVGxxNStaRGNDOWpFbXRFbDc3MDVwVlZiOUxOWFovMStlYVBU?=
 =?utf-8?B?T3FHM0xuMldYeVV0SGN4U1ZJczhZSDU0RGkrZktEWkpwa2laaDBJUDVVRFgw?=
 =?utf-8?B?TGFuNkgwTkFiTVl2RzhBK2YxVXA2SStheTlON0VXSGFvYWt3c1JUQ2tWck51?=
 =?utf-8?B?bG55ZzcvL0t1ZnFZWGZGVWttaDV5aXNkUndNZmNwSy9xM1E3MkRlVzlERlJz?=
 =?utf-8?B?OE1CSmlwLzRXRXlweS9QNDRoZjZPalB1azBjNkMyYXliRWdodjIwUm1Zd1g3?=
 =?utf-8?B?ODI5dVpuNFhqMjNLL2g0L241cG9tQXNDZ2dPblJ5ODUvOGJ6TGQ3Y21KYmVt?=
 =?utf-8?B?UVQ1VU5IZXlmcVFPcGF3ejNyVHgzREFPWjdWb3AzWGxvcXlyaDJRNEFvNFh1?=
 =?utf-8?B?dzBiOFQzK2MzTC9OZG9uV2J0MUxHdWwyT0l1SVJnczdiVFZ3MHhnTEtTd1Np?=
 =?utf-8?B?MnVMR1c3Q0dLcTY1ZXhUZWJCSWV0S05ZeXFzc2cvWHUxUXViSkZObERsbEJu?=
 =?utf-8?B?OWRlOU41RTRGQlZHdlIzNkwvaXlPelhhNlpPS052VTlKbUVMRFlCWlZobkFP?=
 =?utf-8?B?Wi9VMzQxRm5kM0lJdXZVZ1Q4VTc0YXJaSi9zOFFnZzZpMUVCRndTT0F5WHls?=
 =?utf-8?B?QzdaZFdmRm1adWtzR2EzSHU0b0pSdmJja3hzOGdCRC9HMGYwME5nSUVKcUgw?=
 =?utf-8?B?TUd5M3EyWmx4RXkzV1FmTjVxY01lTVhxbVVSRzlqeHZnRFpkbUFsczdic0ZT?=
 =?utf-8?B?dFk0ekNLL2lKUCtZZkRQbElxSHRVUlErNlpaUnVhSlJCYUc1REo0L3hmM282?=
 =?utf-8?B?VFNFa2hMcHBTVXo2UWhXNEVEQzIwSTBoK2lKeHZ5TDIxcndmQlI1M0s4d1ox?=
 =?utf-8?B?Q1dTaXVQaldEQXcvZlQ2bEpIcmY4ZEZOTlRCL0t4MU9NY3hnT0JUckNudGdj?=
 =?utf-8?B?Y2F4cjUrM2hYRWZJVEsxYUNGUGZ4M21LWVI1SEtLdDZGaDIwcEVCTmFHZ2R4?=
 =?utf-8?B?SmxkMkd6L2RqRW9LTHJRR0p3d3lneGFkZUhYK2p2NzdiZjZOVVpDSVIyVUpG?=
 =?utf-8?B?NXdjYU9xQUtjSVNCb1l2YlRhdWV5V09DcWhUM2t1TDBJYUZJei9PRmlEWUNT?=
 =?utf-8?B?cnp1a29BK0VQMG1JNFZtYmxZbEhyUUE0SU1pVHRvWEc0Sk5obk5iUEZjQktp?=
 =?utf-8?B?dXQ2WXVvazdGWm42N1lJbWxSOTE0aWRkUHl2eHlKODlOUnl0eUxtdkVYMW16?=
 =?utf-8?B?QW1WWGZxQU4xOElpUVZVRUZjaFpmbitRNmVGdVZNU1hUS0F2akV1TnlNUmdi?=
 =?utf-8?B?L0ZnTCtpc2UvMWg0TkpxUEg2QTFKZkJkdVRROWdSQmpacmVUb05KZ0orOEdC?=
 =?utf-8?B?VXpSKzV6ZGVnRkxOTmJRYnZOanM0R0s5VS91c2F6Y2J3UEwrdDltWlFTSy9q?=
 =?utf-8?B?MVVFYTBEYUlxSUxwUkVZazNrODBqL25qM2E2L1FoVldCOCtNcnZJTG1KL3Fw?=
 =?utf-8?B?VytIY3JXbVNXS1RLVTJ4cEh0TGZtaEg3QWFwZTFPWjBDRVpmUDhYRWRZZzhW?=
 =?utf-8?B?Tm5la3BhUDZGakUrR2xtUm01eTAwNzVHb3hYdzFvcmtlU2xrYzJncDlxNE5T?=
 =?utf-8?B?S2ZUMlJhcFVLeG1jUEltb1IyTi9SMlJVVGtIWUJ2T0NYV25LVTRtYXp0SGFw?=
 =?utf-8?B?d0U5dlRuS0F4UWFiamVMUXZTT1Vwd1BqdEpzMHhWbndwWXdvenovQUhhQlB0?=
 =?utf-8?B?aXBhS2NMdTJQVlVZaU9rN2F0c1hKSGlDL2RNamNYdG8zSVNUZGFFaXdHT2pj?=
 =?utf-8?B?MHJzbmZDZkpjMUFSd2RUdWpjUktzK1FJU2hHRTlpMmJMbGpkZmVidC9UaDBp?=
 =?utf-8?B?MWxBL2ZzSzg1dU9xYWxNZ1IxM2lMSkJ5elh4K0c1M3VZa2syNlphZU0yclZy?=
 =?utf-8?B?L2hTVGdLbndiUnllMXZ4bVdicVNJY0l5QVlnMVNIQjY5d0w4QmU4RnUxN0Ev?=
 =?utf-8?B?SjdPN2U1OFhkOXRkam05ZjBMejRhcUIwZy83eWdmRGZEQ3dUK1hKN054N0d3?=
 =?utf-8?B?RTY0am5jbi9MK0VOZ3ZBK0JXNll5cDdGSFNLUjAzVmd4cHUxS1o4bXlJcURL?=
 =?utf-8?B?SXc1bFVnNlF6RmtwU1UyeElSWHhnb2xaUHpMV3k3M1NWUkdXNUhVaWxTUVhn?=
 =?utf-8?Q?L81ow2NCUVfspp4VKdxw/8s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b91fc-7b8f-4c62-61c3-08dce251f6e5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:48:04.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhYHCufu10Afz+QPMjAXRz5QorjTbwDuX7To0GXND14pReZ1+fOeFpxeKYa/Zi5CFtvlbPODDdxXNR/KPYR8vG1WY8pKnY66wA4V/vd2C8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8575



On 10/1/24 12:29 PM, Nicolin Chen wrote:
> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>> On 10/1/24 11:27 AM, Nicolin Chen wrote:
>>> On Tue, Oct 01, 2024 at 11:03:46AM -0700, Yang Shi wrote:
>>>> Using 64 bit immediate when doing shift can solve the problem.  The
>>>> disssembly after the fix looks like:
>>> [...]
>>>
>>>>           unsigned int last_sid_idx =
>>>> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>>>> +               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
>>> Could a 32-bit build be a corner case where UL is no longer a
>>> "64 bit" stated in the commit message?
>> It shouldn't. Because smmu v3 depends on ARM64.
>>
>> config ARM_SMMU_V3
>>          tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>>          depends on ARM64
> ARM64 can have aarch32 support. I am not sure if ARM64 running a
> 32-bit OS can be a case though, (and not confined to AmpereOne).

I don't think ARM64 runs 32-bit kernel, at least for newer kernel.

>
>>> Then, can ssid_bits/s1cdmax be a concern similarly?
>> IIUC, ssid_bits is determined by IDR1_SSIDSIZE. It is GENMASK(10, 6). So
>> it shouldn't be 32. IDR1_SIDSIZE is GENMASK(5, 0).
> Rechecked the RM. Yea, max sid can be 32 but max ssid is 20 at
> this moment, so we should be safe.
>
> Thanks
> Nicolin


