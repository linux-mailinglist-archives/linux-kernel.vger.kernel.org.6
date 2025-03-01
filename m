Return-Path: <linux-kernel+bounces-539719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E98A4A7C0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E34E3BA629
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F04C17A2F0;
	Sat,  1 Mar 2025 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZB+v+4Ok"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011038.outbound.protection.outlook.com [52.103.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1285C5E;
	Sat,  1 Mar 2025 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794319; cv=fail; b=ht5SJk93CLIJByXw0O2BkgcSiMyltn7+SNhwGtfE15nLaboFxG2elX6gukFElzyOmPAR5O2ZIhtFgkfovrzYEYzNu+aFc0Fcd1lR6dTMjaSSx+R5UdrtZQ8vGI4SGPgf6LnFnz0BP9Q44LOPd37o07N9AJCRXVtvsPxYCNLb960=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794319; c=relaxed/simple;
	bh=hdeKCfEI42cdHcKbpd334bYRQIlS78BUpKeq87FGAnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lmpTbkvK5B2DNpANbvn5dnfaDESS7WHFHmGa4g3cINCgwUTa/1+sZL/fKoAYeecEfQ9IKVyqoKl+Qwma9Qab1N3ata02MYqgJygtJYCntQn5twd0PSlMXeipbnAmggbWfbuYsPOftGZ4uTJw+yUNeo3Z4CIwW0Xmot+qKkG2b0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZB+v+4Ok; arc=fail smtp.client-ip=52.103.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctBNgsHlVkh6iOKDtnQWCGtrHmzfyzJbcXaR95LO8meaIPqu94sG+i5HiVSrtrmM06Ju1UhLwCnAv/t32fGbcLzy1FbHNctVZked6ekcFhfeM+mF4JKAk0unOuAOjf3Wk0qb3kNQiDV0TmoHWpDaCcnI3bta67pio+C9JE0yveJKzc+ndE/xoU818SjIxYRoEVqaz0iNukufiASSRqLJROFRk5PZ4rPQxRPXATa/btNsiavW0+CWdZE6VIlwgJnyAs+VmQa5tj97IBCnjQTMWxe2v2I5oEURmYLiupHgcGjl4Fp6+YFWXWE3Xxd2AIDQ93lv3WXjFsUIW+9/uybeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQmxoVjg+8/QMFEBFschOWaWX0CTsAVlSzF/CK/y9K0=;
 b=fpBbJDr2guX7VKTz5exSoenM6Ib+qGeKg8auePZC227AhGMCtGQKXzvjdNyg9wAHSRt6PM9KmNqcIBYXRgrbHHbBF+mAkIQYJA9WAsRWYBBL4A0bi84a04HI51XF1pcx/o5GSofbXAJWboBBbPw1vSqN2+moSbn0d6QzOTNYYKSMJnIpPuMI29wqmrgLzyviIBCx58npFtriZZxgDvfLK3yy7FuM6gIOSVXldpsb4fq03jLyEF7uMSLk71VzA2u0vHOvLItBjQF32ynpjddZn7hg9zwkCNRbi7F1hJeOGs6OaIwCw0SkjrVnJZbiFNXgXkLH0l9cfK9l4x5F4VLmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQmxoVjg+8/QMFEBFschOWaWX0CTsAVlSzF/CK/y9K0=;
 b=ZB+v+4OkbhNv/Sqc1wupjzxFdyzl5FPxZuRjqX/g8m2mWwaBf1zXa4LvCUJu4U28BhF/FZj8e4AAl6U+FCqy0J6vCIvptASxi5BJygXl5UNGsdkjTzRGJgE2igf9jSXhJ/feyhIa1dsMIkVcKDxGY4N1zlzFyVfDs4OkYg6Hir0aTX/ystAQPs/cMfChe6UXrzITSpizexBbRyLDrq0WXhRVJSXGrjZNkdzT5SgaPRj5TegBRaIk/lP6pekIr3v23dsphTy1vZ3mFiSwx73fOm38xOECX0sxkCHAdCS/0xFsYuxXzdLTNwxEk+cDCJf81hdyyfZlqn75IAkKlY3cYA==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by PN0PR01MB9098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:161::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Sat, 1 Mar
 2025 01:58:30 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8489.023; Sat, 1 Mar 2025
 01:58:29 +0000
Message-ID:
 <PN0PR01MB103937D1C23820E0FC43BEA33FECF2@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 1 Mar 2025 09:58:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
To: Conor Dooley <conor@kernel.org>, Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@outlook.com>,
 Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
 <20250228-factual-rage-0e1e1e48b009@spud>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250228-factual-rage-0e1e1e48b009@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <9a7bc5ea-5448-4970-be58-40705e183c45@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|PN0PR01MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c1a7c7-1035-46f2-2b65-08dd58648fc9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799003|8060799006|15080799006|7092599003|461199028|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akV3QTFZUFVCK1ExanhFTkp0amRRK25qMERxQ0pDdTRrMU9ZQ2E2TExsWDQ1?=
 =?utf-8?B?SmhjYjVaVS9rVldSL0JjdUVGdVF5VStzMW9keERKSHV1SjJwWHdhaVRTWlds?=
 =?utf-8?B?M1d5dWdUNVY4c0puTkEwU3pvZndib3RPR1NyeWdWR3VZZDhxcWxEN0VRZ29P?=
 =?utf-8?B?a0J0Z1k0Q3VYeWpwcW9BcjhvOWlOYWtESjVFd2l0Qk5ndmxSajhIbGdmVDhF?=
 =?utf-8?B?VXFDNTQ5TEp5TmdnZThPeUpjQXJZZjJZdnhMaDRMay9JU2JEandQS2Q3M2FM?=
 =?utf-8?B?NENERDQ1K2h6T3diSnNyZU5CWUErUkpSSUd5UjIxTUFZWG93SmJNcnhtMjJC?=
 =?utf-8?B?Uzg5QUM1dHZoM3hLc2s5bHYxS0QwWWJ0aWh4MmZoNk4xK1BjZGoxVHVLQmE2?=
 =?utf-8?B?TjFrQlFkckU3dW9CZlN3Q1BPTndzM1NSTCs4K3RGaDIyTk5SVDFrcXpNMHhj?=
 =?utf-8?B?STlwbjlkRzBiTU1tSlZha3ZNY1R3V2hubHp6VWdNYm1CaWhLcXVZVFEwcG1z?=
 =?utf-8?B?d2FJY1NCemNoSzJwWGNKd05KVXhPc2VWbHUvaHVuRjVYMUozTzNMcGFkZ0Q4?=
 =?utf-8?B?dTVDcUMyUGhRWklMdHhpcWoyOHlBRnFVbGFHbktzNFMwQTB6QVQxbUJjV1RD?=
 =?utf-8?B?azlEeE5ieDJXQzhsV3FBMmp2RDhqK1B3MnBxTGpmTFZSTTJCSnRlRzZqTkl0?=
 =?utf-8?B?Wkw4cnl6Ky9LdnE0NGVsdWVmMWVIOTZNLzNFSUJOL1lLZ2R4U2p6QUxRSXZI?=
 =?utf-8?B?TzJDRGFEN1BKZ1J5cktZSHdqR3VRVjZBR3kxNmpuWFdXZUhYTHJjbzBqOFZh?=
 =?utf-8?B?aE51VDNMMWJLcEc0a1NtTUUrMVFQeDRualZmWjBFMHNYOUJ4TG9iSkJtTm10?=
 =?utf-8?B?Z0xmeHRSd1BJOFFqTlMrVjJnbmJEakhJa1BwVnBucXBEZVJJSmpMdTBiZ2ZX?=
 =?utf-8?B?a3h6cFl1czdNK3NZUEhHT1F5SE9PZHlhb2YvVFJZT2RHK3B1YTMyMHZMUVNm?=
 =?utf-8?B?bSs4ZERlcWlqa1B5d0szSFdQcldUZEFJc2pyc2FHcUt5WVhkRnhoN3VlUW5a?=
 =?utf-8?B?VEtHRGNnSUR1NXpmbHVkVlBnU21rYXM5aHlKdEp5eE5jRmFLZkl1SUIzbWRD?=
 =?utf-8?B?TTdub0ZxNVNxZG4zSjdmdFduZXNhb3Z1VDZXNzgyRHQvUElwQ1FPU3d1eGNV?=
 =?utf-8?B?TWJkU0Vvc0hHdmNvaFpzVDA1KzJXRW1nT0RIOGFQb0RwdVZXUnM0bG1tNkxB?=
 =?utf-8?B?ak9aYWRjckZnOWJPbnJpVi9XSnB2V3NuN1JlMlZwdWlMRDNpY1pJVlFFZlBW?=
 =?utf-8?B?NElTMnV3SjB0UGNoMG5Tb0V6YjBiU1dyU01KWVBoZlVsc1FuNzMrV0RsY1Ar?=
 =?utf-8?B?Q3V0RzlST1J0S1lBRGhjRmlUSi9kNi9EV0xHSmJBckRoNXZidWx5VExEdnc5?=
 =?utf-8?B?T3kwVldKbnltN1NKVVZzUkhWSC96TDFDcTN3V3ZVbit4RExFWW9FQTNMUFVH?=
 =?utf-8?B?L3Nsb2t6ekdMaS9aNC9QSm5haWNlekJmOUtYY2MyRFdLQ2NIZkgrblFocVRk?=
 =?utf-8?B?cld5N2s2cmlxNjNoYXZKWldmRnVLZ2s0WU5Ma1VORXNaazFkdmNKb1hTL2VN?=
 =?utf-8?B?YmNFbW9IVHlwR1NudXRYZnlkemhNbXNnM1BmS3JOdCs0eDhzK0p3QmJJQXg3?=
 =?utf-8?B?NnkxM3VJbWZkWS8vaUlFNGZvODd6YTdhSEVhL0RzNzhkNmtBcFcxZjl3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE9Jemh1SFZvK2w4a0hzRDlEYnRtckJqSTJjSTVQQlY0VHV5WWhoV2FYZGdG?=
 =?utf-8?B?WnlQZVJaMzNFc0JSdlJIMnhIN2hYL2ozNUkzQk9kR05MbUNjU0VDYnIxaS83?=
 =?utf-8?B?VmhoNE5lRDVRZ2UwOUNyRnZVT0grWXFyTU51U3BCcFZxYjdvMEpFYWJ3NGps?=
 =?utf-8?B?enFtdkQvbEk1TjUzZy84YnArdU5RNEhSNm80Q1p3Wkd1N0Z6cW9TdkVBc3lk?=
 =?utf-8?B?SVU3VVNzT1JEV1hYYnhCT0kyT1hzMG9aR1BlNHg0c2pYUENZeUkxRytKNXpI?=
 =?utf-8?B?Rkk5eEZDSFhDRGpDNW02bmFjMzVUc0hxSnhlQ3lVaExaOWZRYmdHMDFmakdn?=
 =?utf-8?B?MlIrVDVtMTE0STY2RE5ta3dhdFBRMHBka2loZnVUSFhNbW9NcUU1STh3Z2Jh?=
 =?utf-8?B?ckNaYy9iT2RIQ0hHOGRIbjArSm9ocTN0RTlwZkZzY1ZERUZ1amFCMkw5YVY1?=
 =?utf-8?B?bzIrRTF1dW1VZnRKc1phV0lzMHVRYS9ISnRLNGtTL0JvS1k5NFhKRS9ua3Nn?=
 =?utf-8?B?UlVqT1BnaUFOdmEwczEvdS9JdUtXcUVURGlxYlNtWWxoQndDOFRUYzN1L24y?=
 =?utf-8?B?TCtxQW5ndGo5VXV0NzluUXo1M055SEhzeXh1OHNFRkZEWDI2OGxDdnhYdVNW?=
 =?utf-8?B?UUVxbzhnWFY5bU5qdFAxVmlaVWpVMHROV2REUmVSUnN5YzVhV3RSYW5LTW5k?=
 =?utf-8?B?Y05VM0RaV1BzbWtSSGlKa1A2UHhNZnM1a1JzKzZtQ1JtblFFanltYzl2VS9a?=
 =?utf-8?B?aUxaU044MHByU2F0U0xwZ2t4Wlc3OGF2cG5CZ3h0ZFp2WC9teFhHY24wZ3pH?=
 =?utf-8?B?V0ozQ1N2bFRWNFpwVVpDem1qYlV0RXZud1FSUHdkMGt5dEFFdEcvSVdaNUZh?=
 =?utf-8?B?TzI1RzhScVA2SHV6d2FZN25RWllZVTZNbXR5NTlSRzk2QVgzb002N00rY1U0?=
 =?utf-8?B?WmdJOEp0RWNMdFdXZUp6dDVVZ1RCZU4wNWdhb0I4QktBQlBCOHZUTk85ZzRu?=
 =?utf-8?B?bHRSbXVVc2w1d2pVNysybXI0d25LdVJCazV1UHdNWFpvMlk2UmxCeFBWNUxi?=
 =?utf-8?B?aFBTdXdYN3V5NUkraFFMOXBlS3VnV2RlWFZVSEZKUUFVQ1pIRERrRnZ1Mlhn?=
 =?utf-8?B?OHFFZEFTYVJKa3MyRmVBS1NXM3hidFhlRWJ4a0VQYmJwZEVLMFRWQVZoTW9T?=
 =?utf-8?B?Q3VzZlJWVXcxSTl0VFIzTVFEWFpVZTJsOEs4cDlVa0d1UUVNVS9yQU1YYjhS?=
 =?utf-8?B?bm51RXN1ejhuMERmOVVYSUNZdUpWWDd6b1RXNVlxeUZDMVlQcHRxN3lqa0RD?=
 =?utf-8?B?eHlMcFh2SW1JdGlOWFhRN0ZGRFdBajhEaVF0azY0VG1MZ29PQTArakNTVEgz?=
 =?utf-8?B?M1UvYUxXK0lsbzhTVHVLNGd5alZDSjROTklSWWUwR2s5ZnFLVmRHa2N6aFZy?=
 =?utf-8?B?MkR3L1lkczdwMzdhVGoveXZTOEgyRXBQU09iSGR0WWVnZHcvL2JrWTBHUURL?=
 =?utf-8?B?TWRKRmtHMWFYL1c5ZzNJa0FaU3JvVk5SaHpYU1FPRzh3Y1AwTm42MHZkb3l2?=
 =?utf-8?B?UW5HZUYzM29LQXZVMHFSY1FGQk9KSUFacHFQTXpkM3dOL0I5dGR5ZTQvZUR0?=
 =?utf-8?B?RG4zbmxSRFJCdmdYYmZkeGtjZkZWTzlCNnRaY3dWVTRTSStwWnNLbTNHRmV0?=
 =?utf-8?B?dHh6OEo2WnJ4ZmZWWUliMFFtdUdvbDNrbThqcTIvQmV5YzR4c2pRd0VzK2Zq?=
 =?utf-8?Q?jMT/ByEUYmEcrvJZHOcpxXNHPJIFT+Z68wWwVO9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c1a7c7-1035-46f2-2b65-08dd58648fc9
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:58:29.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9098


On 2025/3/1 2:22, Conor Dooley wrote:
[......]
>> +
>> +		spi0: spi@7040004000 {
>> +			compatible = "snps,dw-apb-ssi";
> I thought were were dropping the use of "snps,dw-abp-ssi" in isolation,
> and starting to require soc-specific compatibles now.
>
> Rob, Krzysztof?
I'm also very interested to know why we can't just use 
"snps,dw-abp-ssi", maybe I missed some discussion ...
I googled examples of soc-specific defined in the code, and it doesn't 
seem to be much, only arch/mips/boot/dts/mscc/ocelot.dtsi and 
arch/riscv/boot/dts/thead/th1520.dtsi.
Specially, I looked at the commits for th1520 and saw this 
https://lore.kernel.org/linux-riscv/20240703-garbage-explicit-bd95f8deb716@wendy/. 
It tells if the fallback works identically, then the specific compatible 
is not needed.

This makes me more confused :)

Regards,

Chen



