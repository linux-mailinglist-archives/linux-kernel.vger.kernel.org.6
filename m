Return-Path: <linux-kernel+bounces-197463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272A8D6B00
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF61F289271
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D91CF92;
	Fri, 31 May 2024 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wNN1w4pZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF82594
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188315; cv=fail; b=JEtLP6e/SP5Frhto+NMoeK1o/iaXfzyu7FXC2hjkaauWWc07tvwW8qoecPqZihANCdIqehgTzO/2xcV+gUyqYDuXOt0wbGkMl9dP/e3BoOnD+Bf3qIb3cqNeyLBOxItnPozlqCKHJcZLrb8c3NlYtb09GDV58g/cbtOMcJK8xfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188315; c=relaxed/simple;
	bh=mZef1cS4SuD/PnajOkBwSbh+ylucJbbbWJoHltQEDbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E28CD1VSRIw77mL0Gmcp22NkzJ4sHEZJaajy3wZuGjiFF5+deBm7Upyzi1XwP4+ejOjnkWvFGCD/x6JyOB1Muta4ZZUYbR1ZAR/smXssaLXFhHMUokC/+gsqa9bN0IT7AmQl0IuUz+Qqcc3zjhh/aoN7ks8GLMU3X7QoZkMwzbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wNN1w4pZ; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr83Exy7AW4PrVOv+FKqdbkwxSkdgkE5/oEKQt8tli6NcfxuO+IeH5p0elNz0/hfEf7d/IscraV3IDYkAGJqQwEHZnI6zEW3465A3Fs38vky5UfAIRO8+lAvlw7S5cybWM0io6N+zwL5L7eJQ48aOURYUeTcc7QJteR862aAaIHA1UVeemxOe1QW+/4P/+wBy/fXgcjiH22AEFSihrNDhrf/zXvbvo3SKVbm7zfL5nis0HSTxQONNmR3YJE/2KNmkE6kRw++JJwdg+8rygTTb5h64bfN2Akezy3dgHlNtWlgtrx2MTpuL1MUrCDm2IRk5Vyq0XeC9ZhXJ0whNFxjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ebP6/2EYW+eRxVVy0KaRJX9SPEbikUOY3wwOPpaNJY=;
 b=DVs6WbEYqzDP5HCDv3o4XaDtjJqRC9zikImUanrkGqJ7HqhL8Qu7eQGzSD0o7WxX+WTis5gWwSYT4vKFlpofH4OEh7l+qkXbFHsJ2UFOIX7WKH6QshZMujVPxyXh0vOqRNO6NyOgws/8bBEYJl0dTnu8rBspqtf1hGSOcL6X95tw1EhHFsPA20jf3osrI+FG7q+OHpTDWvt/sZYgeQnQ/GYFKx7tVdgIn/9LijPF+k49KwXKS4G+Cb6NJggI4dHMDt8dw2W4+u1DYaNEr+JzmWw4wrty9xe37cGxXFJgXcqGzIWg38Kn7mSKZZKEXYyiBYjmVlYs687GZi8iel7U0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ebP6/2EYW+eRxVVy0KaRJX9SPEbikUOY3wwOPpaNJY=;
 b=wNN1w4pZFk5Gg/Ks3G8xWI9DBt60d2Cs4+9xolTLPlhERpk5/umT52kblYmsabCtJpwxIx0GISxlx2mTT8uynJw+IJ+eZzFq69mw5vDzxHXMD1HiFXR0DOZRrY8Q2ZtBcMkuFo/9mL29YBe+AuDVbV2UkjsVoW3wpvHBMArMVns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Fri, 31 May
 2024 20:45:11 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 20:45:10 +0000
Message-ID: <90ee763e-e059-12a4-d7c3-9a710a1c5db4@amd.com>
Date: Fri, 31 May 2024 15:45:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1713439632.git.kai.huang@intel.com>
 <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
 <1ca2c140-8ab5-46a6-a26e-6840d7ba051c@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1ca2c140-8ab5-46a6-a26e-6840d7ba051c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:806:130::19) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 961e87fd-5622-442a-3042-08dc81b29077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJ0OHJUdlErRUZQRS9Nc2NYRlppVmM2aEs5ZFpGRkEwTkJtSnJtMFBjTkZT?=
 =?utf-8?B?UzVQcXduKzJoVVJSdmsxZ0xtVnEzU3RxWEhxd2k5bEdtaGFEZ2ZzdFR0R2or?=
 =?utf-8?B?WXgvK2Z1ZUZQbVQrTi9oQzRjTDJTQVlWRnBGdWQyd25XeGhlalNNaE1NN1JE?=
 =?utf-8?B?b0w0a0Ezc1VyVmMzV2Z3VVFjazJGNUlDcEo5Vjc4Wm5nS2ZUemw1T3NjTWRl?=
 =?utf-8?B?ZnJ0dTNGcTRjNVNNOUdEUWpiQkpxOEFCa1F0OVFqUjFmN2IxN1RWdWtOL1My?=
 =?utf-8?B?SXB1WGdsVkhPYVcwdWlIQm9xUjAwWVB0RENoaDRDNXl4Um9oMU5ucmFEVXdT?=
 =?utf-8?B?Vk9qaWhQRERXcjFuVkxBUXlsTS81eHhiWTVleTl6NCtaNHdGRlVFZXB2NVJw?=
 =?utf-8?B?bGR2bFZSbmNkK1ZYTy9HWmNPOXQvKzhrYVRlSCt0ci80TTZsRWx1RzE2VWtW?=
 =?utf-8?B?Y0pqTXg1ckR6RnBmV1dqTUpoa2w4UlpQZW5kbkdtT1VpakNNdGtTajE3YXFJ?=
 =?utf-8?B?YXlxTVI2blFQRVMvd2svSEFKV0V0bGpYRDVYMVFkeEJrQUNBMyt3S0NJQ2pl?=
 =?utf-8?B?OE1tZjZUMWxNTjdIRlRaVkhua0ZkbHBybGUwcVpQazVYdVJzOUI4c2JWeFVX?=
 =?utf-8?B?Z2FkNVV2TXI3cmlYRHhoZEsxMXF5NFlRaWNSV2F2MEtoUmdaejA3YmYvbGZ4?=
 =?utf-8?B?RTZWUXIvaERGSG5Od3JVNzhFanV4SnlnS2M2TFBpdEVBODRaUkZsd1ZKR3lt?=
 =?utf-8?B?SVhkaXViMzV6cm1yMWxUOXJKajR2RXBlMGJQTGRMVTl2LzFNRVdJVG1YbE1J?=
 =?utf-8?B?WVpQUnZuaXF1b2ZoNHB4NytpOTdpWWpFVTRXd0JQN0xvSS9pYWZBZE1xb1Jk?=
 =?utf-8?B?V2twbm4zL3AyeDNhaTJXaXVCdWVmbDQyZURLeUxvbXVZVjl6U1JTbGZuMDhR?=
 =?utf-8?B?eVJJLzFQY09MUnNVMzUrU0V0eUVXSWJCVmduOHJIb0hJUGZERzFkZm9mRXdL?=
 =?utf-8?B?V016VlJNWEJEUm1oMVFSblA1dVFxcUFObWZmRmdqQmRVQ1RKZllzeHo1eS9I?=
 =?utf-8?B?SCtwZzJxN3paWmFxVkVRclFMQklkRzJ4TGlkd2FOZytuTlhLYlhMeTJwaWNU?=
 =?utf-8?B?NHk3TXkwaVJVRDJheFFPdUZWaVdXLzAwZno2YmxvVHN1NlZRUDZjQm5NbExS?=
 =?utf-8?B?UEJKSEhvQlFrZGNPUUxyeUZEcUliK2M0WnBGUVdPdXJ3RFUzR0kxaW5hZHov?=
 =?utf-8?B?bkt2TG8vSUZ6NFFVTUNNRFRlT3ZWTGdyUjRtR1A3VUVzTCtLbW1pcWFNbVpG?=
 =?utf-8?B?bDBUa0RHeGxwbTA0SGk4ZC9SUDFBNTlnWHN3R2hDaVM0VkNGZ2RZTmxsZlJ2?=
 =?utf-8?B?MmgzZEVIZFdwWktjQnVNVWQ3MC8xMTZYTVU4OXJTYUpmbHhtdHpYMzlUVzZh?=
 =?utf-8?B?QkxONlRxbkhueUJkeFNMdVhqZ3pxSlEzK0tSdWwwdzlETnNCd0UwTkRBSFJh?=
 =?utf-8?B?SGY2SUxQQyt4NFh6eTlBQnJEYjNncnpIT2N3OTJFbVRmamROQ3ZxZllTelFz?=
 =?utf-8?B?Uyt6bno1SkRpS0RzTjBRaDRuL3RwWmJ4Zllza0VaMk1NQ28wYkFFdURjaW5I?=
 =?utf-8?B?VmxTVkZDZUxwbXhrRHNhbVRzWWcwdUp2SldtNHoyRHlQbnZCUjRnZVlFSUd0?=
 =?utf-8?B?cjJUNzdMSDB3TjlYU01hZ05LU0U1ME5hRmY1WW5XYnNQZFFuNGxWd1R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG9QZmpLcFpsRi9TRkJpQkpNY1RqZEcvNmIzSG9vbXoyby9YNFY2MFYyTlB2?=
 =?utf-8?B?K3ZBTDg5TzBCN1J6a1JocUoweStrQ2o3eXVTK2NGUzJFdnpPNDA2N291Tkw0?=
 =?utf-8?B?R05OTHMrZkppcSt0T1FDVWFQNU45SmR6TEZpb1NPN1ZoNFlTcmZEancrRDRD?=
 =?utf-8?B?V2lMMHpjb3Jhd1pyY3pFVUVkUzJjRmtNNVlZZlc4RkVyWlc1YnRFYzIxYjVx?=
 =?utf-8?B?anMxb1Btc01lYk9uZkw5UXRHVWVsL1FrZlppeHlwcFN0dXArSGM1WEV3dm9R?=
 =?utf-8?B?eWhqOUtLTEVMSERTcG55MU54Mm9nWU11dUNlR3lLaDJ0d0pGR2VWV2tXQ2JM?=
 =?utf-8?B?bXdodGRmc2NCWTRueGYzUXlGQTRVMkxsSEVZbjZIRU16QmZxMFcvWFlFdXJC?=
 =?utf-8?B?WlJZWlZXb0pQTXJjclE0STBlQjRKbFpjdllnc2pWWUQ1Vkd3aXl4d0FlUjJz?=
 =?utf-8?B?R2V2UzNIYk5OS1NFN1ZEeWJOckZpRE5FT2hXeEErdFFKaTlBdUZqRTlPMThV?=
 =?utf-8?B?YlNwa1RkV0Rib0QwRFVad1paZ294YmZYNlE0ZStEd2I1aldCdVNVYzdwZ2Fr?=
 =?utf-8?B?TUF6OVA2bUlVblB2MmxSMk1OY1E3K0xWSENUQWdienhINGV6KzY2ZVgvQXJL?=
 =?utf-8?B?SDJuYW9GbWxRdjJ4M0dkUnczMXMybCs1b0QrVVpjdmRFTGcrL3c3VEdvMStM?=
 =?utf-8?B?LytUWEhlOFh1cHJYdEd0U1ZnVXlacEhIanZNcFFINklQVGRzclhLeFBNaHFS?=
 =?utf-8?B?bTdENjZ5L3ppcFlKcWdLeG4vVlpPMzk0enpsQk9SWHhvTkpFZ291Ly9CRHpJ?=
 =?utf-8?B?UDBWTDkwbVFVenIyNkd5VEM5VTBGU0NEMEdMbDJKdUc5OXJXSUpzci84OHUy?=
 =?utf-8?B?cm1zYkF6QVZaQmtuOWVTUGhwaWVTd3NRT3RORWNOOE5vQmkvaXVBWEg1anRG?=
 =?utf-8?B?eVQ3cTE4ay9kN0xFZEx1WE5nRTdta0tXZkx2RHNDY01YOGdyVFRYdTE0M3N2?=
 =?utf-8?B?dE92ZFhaczQvWHk0TGt3bGJXeHBQYk1UR0MvTUFPQVZ1aytyUEFNSmNzKytU?=
 =?utf-8?B?VldKcWgwRkVKdDYyL2NqY1VhSGUwa0JhditTbnVQZzlTN2lIKzJ1SkpuZzJa?=
 =?utf-8?B?eUVrYlppTkZmTnBmRkJpNjZiaC9xZFNENW9TOG1lNUo5a1pmclVMSmkvNGVZ?=
 =?utf-8?B?YTViaCt1bmR6TzZGR3d2cFVLaFlCWDlVZ0w3LzBLYkpuM0hwME1mdkRrMFZ5?=
 =?utf-8?B?MVpsNm9vUWs1dWVrdTVQMGlUSU90dGNLOVQvOUtlaWMyaWluSkNHalZMaGpw?=
 =?utf-8?B?M3BrTFhRMXJVcUR1MGVNcjluSklxVm9tR01jWlN0bTR0c1hTWkE2aThEUzFa?=
 =?utf-8?B?eGJSaVlmN2t3V1dSOVBkZXlVMlRWRWxxL1dlRzhMTm0yaFJRZ2o2bHh4ZE9v?=
 =?utf-8?B?d1BreExTQnBtYXpNUnRadVMxQUFpanRHdmk5S0pIcHhDN3BUN002R2xXanBV?=
 =?utf-8?B?eHRJcXZLMFFmU084UVQwU0pjVmdsc2ZPV3FqRi9USTIzQ0tMSmJTY3M1YVRY?=
 =?utf-8?B?bWpDWEs0V0ppL0RHV3pFRXZYZmVwc2lpbE5lOW5pQWxiNGlROUc2RzAwUHNu?=
 =?utf-8?B?cUxIL09FV1VmV3hRdURCcTJwTU1tbDJ5aTRJclRlanRlQmZXQzJmUFZlTWNj?=
 =?utf-8?B?NXpBSCtjVERDNUM3VFg3Z1pWVnFscjAvLzJEek4zUk5GMG90a1pTVWFuQWxL?=
 =?utf-8?B?QUlTaGxPUVIwWStvZVhwU3FDTXRsbHVFcFNQQjhtNTlNNjJzSXFsSXZyOU9o?=
 =?utf-8?B?QU5COTFKeVpYZDg4RDBQK0UydjNGRkVtYzVNZGxLbmhwNzU4VXZkZlJRQmxQ?=
 =?utf-8?B?NHZvK3FuUCtuY0MxRHFucnAveFZHRXZPdmtDbGlxWGJHY3BFQzhteEV1bVZi?=
 =?utf-8?B?aUZGMG0ybjZxUHV1UHN3bC9YOTFWQWsxQWk0bmxiMnYrbFJ6eGV2S1AwSkd4?=
 =?utf-8?B?aExsQWxad0FIMVhiSHNJM1hhTlBsNkpaVHRzZHBkK084U3RWWjZ6Qm5BZ2VB?=
 =?utf-8?B?Vjkxcjg2aDJwWDNwM2JLTDFrZDJENloyejRNK0VxSzg0V3Y0WmdMckFNMC9v?=
 =?utf-8?Q?yGSX1QeUVlEuD3JPoq0NDy8f2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961e87fd-5622-442a-3042-08dc81b29077
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 20:45:10.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwXUKh/YA5jXgY9/SuCDsY4Xu9/ygiwFPo6DN2zP42IUQHVotztF6kRxbx0PqJUSYGH4/uiqmAL2g08dGiwzbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761

On 5/22/24 21:49, Huang, Kai wrote:
> On 18/04/2024 11:48 pm, Kai Huang wrote:
>> TL;DR:
>>
>> Change to do unconditional WBINVD in stop_this_cpu() for bare metal
>> to cover kexec support for both AMD SME and Intel TDX, despite there
>> _was_ some issue preventing from doing so but now has it got fixed.
>>
>> Long version:
>>
>> Both AMD SME and Intel TDX can leave caches in an incoherent state due
>> to memory encryption, which can lead to silent memory corruption during
>> kexec.  To address this issue, it is necessary to flush the caches
>> before jumping to the second kernel.
>>
>> Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
>> is supported by hardware.  To support TDX, instead of adding one more
>> vendor-specific check, it is proposed to perform unconditional WBINVD.
>> Kexec() is a slow path, and the additional WBINVD is acceptable for the
>> sake of simplicity and maintainability.
>>
> 
> Hi Tom,
> 
> May I ask how does SME work with kdump in crash_kexec().  Looking at the 
> code, AFAICT the crash_kexec() path doesn't use stop_this_cpu() to stop 
> all other cpus.  Instead, kdump_nmi_shootdown_cpus() is called to send NMI 
> to remote cpus and crash_nmi_callback() is invoked to stop them.
> 
> But the crash_nmi_callback() doesn't invoke WBINVD for SME AFAICT.  It 
> does call the kdump_nmi_callback() callback where a WBINVD is performed 
> for the SNP host:
> 
> void kdump_sev_callback(void)
> {
>          /*
>           * Do wbinvd() on remote CPUs when SNP is enabled in order to
>           * safely do SNP_SHUTDOWN on the local CPU.
>           */
>          if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>                  wbinvd();
> }
> 
> So if I read correctly, what's the reason the WBINVD is skipped for SME in 
> case of crash_kexec()?

The system is rebooted after a crash and doesn't continue directly on into 
a new kernel.

Thanks,
Tom

