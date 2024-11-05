Return-Path: <linux-kernel+bounces-397069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66F9BD65E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4559B1F25687
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31314215C6F;
	Tue,  5 Nov 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iXF8wyoB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D321314B;
	Tue,  5 Nov 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836704; cv=fail; b=G8dfVqXj/3xf7fV1ed2LVygdj5r+8Yvr7AU8TPTEW1ErXp8JQWuSrPwkLbCXJIbhcI0bUV7HcKgKkC/M9yW+Lk3hTaxPx5TmfCjb8OSnTsUnWK+zlXj98d0oRFlMOSYAtscPpRCHOz75fSzFeUHfWZpV0qwbSnMKIggBiLQO7iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836704; c=relaxed/simple;
	bh=KguuQTWVe8JYJDjOh/U2y7iOEoCT+PVR6rEC5pJ8P5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jKZPL+mUh/BkFAYK8Aa9n5l5SW9AWEk0lusW9Qal1Dh9D3GGeEv2g4tkQP3KMXOCERvxDaPoy5Hd4eG/4QeqGUuHIJb05bGGsJrXSxB3Sg1DrvisLDioBB9js9k3+HxLtNp6sZqzXt4gq6Usk+aiSCPS79q7yWfESokimNTkvLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iXF8wyoB; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqKcKS4bv/UtNN2/y3SmYZfGKg8rsCt5WHVGuLuz8hytPLSDyMMLV/fT/CQjDXPfiXRIiK7/8HmIDf/ULOwRCOxCEuUvzljxxjkBReJHAYl8J527x8zdPSBAFBtXAIIgTPxWP628AeBguzLMcQjP4dKqW6ADRTf6ALceE45hhi2SrGBVDudpOk4AaiMrwdSCYx64A+yZKW8aErknKH8bADpTjBbtt44QMrAUUbJGwHu6Ndk8pjFbBDszCWQbIbCRjDUdnUIIMYs37hm6HkuZYAljgiJP1OmPhT9Q+8iJlG9cWhspP1FWIJTyhuSh8u7OPoZVHNFIpwWrjCbIgyCiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4sV397K/qUnQQhKn5HYBXOahWtpXKqvQxbcxGwbWiI=;
 b=GhvA7UAOz2hp1wHxB8SDtoLnqzDiAxk+bVnIE1Ns7bC1jpk509QNOnMts1hqz06wSOIntJFf8Y9Gkchm2Sk2hoham8NzubHbr1ivwEcsI67Oq6rPmGMbBAABbSkwQVEjisKbenco4ty1jfE10+AuZY9XOKofOdhAnUGBEpCYuPsP5LZ2j+yxArzWQtXBVNcHar15sOEGjNLtGOfllfghWTUkCC7eeDu5cFkGihEmQhXIEzI7bdrqVFzi5DX52uEqsjLDosZR0QOlE10QhWvOyKV4+9R7K7KhMAyI+S7PiYn/Ymi9xo+hNt8vKu4/1vUCzdwUjwuwkXU+kgDsCVVtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4sV397K/qUnQQhKn5HYBXOahWtpXKqvQxbcxGwbWiI=;
 b=iXF8wyoBikNucR5ggRC82lm8zcUjXNvsSrOWvKkav/TwUoMGPyfYFuiMvbgroYXshJ+pS48iUYXSWChllmg6pouuSqS3y0LRQ5Kk9YiIr+8Bi1z5miamHVkKNwiOAsYLYoOJrqS6YfBbq+HxzCJ+Op0DWQ25bZEmjp4iI049w00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:58:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 19:58:19 +0000
Message-ID: <6514f004-c83b-422e-a31d-f9e1f399cb5f@amd.com>
Date: Tue, 5 Nov 2024 13:58:15 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 19/26] x86/resctrl: Add the interface to unassign a MBM
 counter
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <d27c3a15ccb11c6ba76794eba6cf7c013b0bb074.1730244116.git.babu.moger@amd.com>
 <CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com>
 <6fd12815-98eb-469f-8477-0de12af29aa2@amd.com>
 <CALPaoCgiHEaY_cDbCo=537JJ7mkYZDFFDs9heYvtQ80fXuuvWQ@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCgiHEaY_cDbCo=537JJ7mkYZDFFDs9heYvtQ80fXuuvWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: d882140d-e4ae-4f5d-220b-08dcfdd43225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnIxUUR6WkpJZXFUSG9HMXI3blMvaE9BNjlZaDRoRjdHbVZuYXhYSGk3by83?=
 =?utf-8?B?NHN3c1FsTHJEMHJZV05KcVdWNmVZejZhSXNiajFaSzI2Q0gzNmd2N0VXRGRi?=
 =?utf-8?B?WXBTRlhmSkRiSnNaRmNNUmUycEEvNkk2d215alEwOTFBRjk5SjBsUjkyb2lj?=
 =?utf-8?B?Z2Q0K3l1Umx5VmNyWEZUM0djNlp6UWsvOU45S2UrMllKckREQnozMGFPdFBQ?=
 =?utf-8?B?MFV2bHArZnczVlpLdEl6c1RueHB2dTJ4dWxtYnd5aUd0M1pENVd0WVBnOUd6?=
 =?utf-8?B?RVBVNXpld2Z0eXhMYVM0TzVNbkgvNmlxaVRKZndEOEV1OUY4UWhLSXoxcnZO?=
 =?utf-8?B?NVBEa2hsaVpTUTRDcjNtK0ZkUmhrM2RUWDFUMUFMZ2NQSzJycXFPZ2xoYUxB?=
 =?utf-8?B?QTJZOTBNSExBNmdoNlJ5NlF6bHp4eTZRamJpWlk0NmxuWXQrSnpKSE9CV002?=
 =?utf-8?B?bEFVamRGUGM1NEh6clN3M2E0WXJ5SEpoT3k4MC9aS3libzZmTDZTaVVJV3Rk?=
 =?utf-8?B?SGZVcVR5VWxJY1JLMVVYQUQ0QlVKeC9pVjk2QlcvUzB6cm4yOVlZTFJ5MHBL?=
 =?utf-8?B?d29rSDk1dGg0SWZjVUo1WmJwVmxyOVZETXZDYW5sMndrcStrb1lDZmtSWUZN?=
 =?utf-8?B?QVRQR3pvaHZJbmh5elg5Q09mZlJNUkw2OG13c3M2OURTZzJzWHBIVW8vUzJx?=
 =?utf-8?B?SGtMaW0wZFdQaSthU3YxS2MvY1JxS0kxc3FqV0drcjRjTXFyNTJQdlNDcTN4?=
 =?utf-8?B?ditJZ2w1SmxGQ3pYRGM0dDNxT2ZRMktHdlIzbTVwZ1ViclhYcldKMWRzMTdY?=
 =?utf-8?B?YWdKY2FrbDFyMFNxVEtzaHJ0MW9wOHozSFJHa1NWRXlqVHM5RFZ5MDg2M3Jl?=
 =?utf-8?B?aVpwUXNqMVFveEZyb09uT0NLSzRaZ3ZPNFZqU2QvTXM4MjNUbVFBWGs5SWJM?=
 =?utf-8?B?MUF2bTFQVWVzWFVscHJya2UyejNtcVdBR0lFMVIvMUV2UHlhN0t0bXJMRTYz?=
 =?utf-8?B?R1pncmwvcWp6ZlZreEM2Q29raXRmVGRRTXNnUGxZZG8xWFliWTdZMXJaSVlm?=
 =?utf-8?B?NUxmQmU0d0JvT01xMjhhdWRUN0dZbnhJNFg5RmpJMlJyZzhFMGJWaFBTcTNm?=
 =?utf-8?B?cUdtbHBLdXE4NStNSURRb1Y2ekdVemFWY1VmVXZzQ2RZdEFTcmczQmVScVRo?=
 =?utf-8?B?WUNZbWZTem5aZHJjT1ZUcWphWm1jMXpzeEIyM3JyYnV3Q0NGSFFTZVk5cmQ5?=
 =?utf-8?B?UUJsS3FYSGV3ZVhaWGgxc2J3aS9ndUJlNVRHbExvQ2FSY3dla0VZb0dkZXFi?=
 =?utf-8?B?NE9yOFJ4Y2RCempCcHZRR2pCNVNhTTgya3JDZm9OTUlVck1hSndxb3J1Z1VJ?=
 =?utf-8?B?dkhmT3JvMWxCdEsydlpJSnUzWmxiQUN6Q0hyOGxjTDBUanV4S1pKbGE5SGln?=
 =?utf-8?B?V2dQSnhYSDZuSndDMkcvWkU4ZGRjSUJMYXE1b3FteE0zTUFzaUM0K3dRbnlB?=
 =?utf-8?B?VTJXeDZ4NFhFVGhONyt4UjRVd3E3SnpvN1Y4S0svdldKRUV4TWo3UnhFQ3Nk?=
 =?utf-8?B?cjZxK1ZjY1JFUUppVTFLQlZ3UXFJMEhQMU96b1gyQ0xDZ1ZpTjN1MXo5L1Ju?=
 =?utf-8?B?SWU4VE41RnhYZWFDTFk3UlNqMS9XeXZWd2c2KzJLc2U1ZmdBYUFralB4VGln?=
 =?utf-8?B?U3oweFBSRFg2Q0F4MVlZb1c4RkVSam9ta2FwdW5uS0ttTE5WN21rZ2RqYml0?=
 =?utf-8?Q?xV2XlBm5gL8+UxU0Mc7DCof2t2t/7eDs/d3hyGx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVR1cE9EWUJ5WkpSNEtyMEhaUmlDT2daQTFCTm1jdEptMXZoY2gxbEVaZ1Jy?=
 =?utf-8?B?QzJqZUZ1c2F3RDdLZjVoK3dCS2NEanVyVFRzMUNxYy8vMFZHc1dQR2FJVFlr?=
 =?utf-8?B?OGFydGVFUFJzcGpPb2g2ZlB5SGFNbTE0aVk0MW96WWcrc3FENGdtYm1wdjFz?=
 =?utf-8?B?bU9ISmZXRjlvQ1FQcXh3dEtqODVNTzZVZS81VVV4dENxak5qTEd6TkdBeGVj?=
 =?utf-8?B?TVNEc1hYbmZFZE5zSVdMT21LcDRzcVQycUZNMTgyQnpBNVhNT0xBbGJLRkp6?=
 =?utf-8?B?UlBrdktXZFgvSlBnT08wYWdycDlDeFF3RGZwejk4aVN2M3NWWjd1TW5ydGs3?=
 =?utf-8?B?dWdlRGo3Y2hzQjBJUDdzVS9BeU9qWUlxbUs2WkdJbWlSYTVmdENGWlVrSStV?=
 =?utf-8?B?ZUpDTVc3dFhQWSt6ZWdYMC95ZktQYlFyNWZ1cmV2eEM5YVM3VDcxS2tEZ3g1?=
 =?utf-8?B?eG91bkMyVlVEdy9udnpwM1FjNDREQW03ZWh6dGlsbVVzK3NDSWRZcVFwait6?=
 =?utf-8?B?R2g5elBYV2RodnQrSnFLUS9ZYU0ydnVrVVJCL2ZkOWxlY3BYa0NwME5TMS9M?=
 =?utf-8?B?R1FaTGcrai8rNVBvSDVVc2JFRWhDc3hLZ2Z2b3g5ZzE1NHQ5a2I4RmNwSWFv?=
 =?utf-8?B?RmVUSkd6YXl3YkVGOEJxZE1mSHE1SlFsaHltQmF2d0pUS3VlTlkzdTF1aUp0?=
 =?utf-8?B?VitnOTU5MDJQWHlCQkd6azBEMTg2aFZ6aDByOWNVWWtCN2ZNRXc3eGY3ZWx1?=
 =?utf-8?B?cXBqejIvL1RIVmpPaXEvak12SFZPUzJNQlA3MUVZT0Nib3lCMXFtYURRNEpE?=
 =?utf-8?B?TUV3YjJ1OEo4Y2NEYndZanlsYUlXUTd5WEl3Nkk5cDlrRnFMcFdoL09NSktm?=
 =?utf-8?B?Vm5OSVFtK1kzSFFDK1hYMjZjeFBUTFlXLzU2RUhZTElTcXkzN0VxemNqdkpT?=
 =?utf-8?B?YWlFSFhkb1FjZ0QwNDdzYS9iVUtCanI2UDE0dlVWeFd1UFF6UUtOKzFmU3Bl?=
 =?utf-8?B?ampuQTBDWCtmVDlSb0JCeTI3dnFxL1gvd3ZKdU5VYUdRQU1mV3VocTkxTWhD?=
 =?utf-8?B?bkRsRWZucEl0KzRKenVjUUdUcSt3K3ZwNEVTbmVjdG1TWHpOVUNZcU52cFZu?=
 =?utf-8?B?aDBrTzVGbUpzZlBiS3d6R25oMWNkUjhLNjJMOEFkd2FFTDQ1UTlQUmpzUjVZ?=
 =?utf-8?B?YnZ0WnQ0ZXRqUzFQOXQzaW9GdnlxaS9GLzdQNHFJRTNqMVZFeGhpSUprVXkr?=
 =?utf-8?B?a2M3QW9uVVlRekZQR1JqcU50QUFCOHZHR2M4TkozRU9UZnFzeWhIYTl2Slg4?=
 =?utf-8?B?WCt4SGIrWlB0YUJJZ3FqVlBmYTFUSHBrV29Ka0huMXBSUWVPWXBDM0piY1pv?=
 =?utf-8?B?eWVWa0lVMTNxN205K3M0TUpqdjJPNDkvZGh3RUtYWkNsaHhOa05HUXFXSjdE?=
 =?utf-8?B?bDV5TFhGMnJsampjYTgxV3hYRTY3NTV3ODFIUVY4K0dKTFE5Y0UvdEVBbXBN?=
 =?utf-8?B?RVBoTzh4VWUzTlBSVi9ZaVJaemc2V3gyaGNTT2NrWWE0M0I3MmZlMlVHZSsx?=
 =?utf-8?B?YXVIbE0yeTZQekM1d1p3MllFWUxVc0FUajZzaXM0YnBYdi96OEMrb2p6RVdL?=
 =?utf-8?B?aXpIb1l5cXRrQVVsZnJOdU1xNnFOMzIvSnVMdDFjemZhQitKZnFhdThPRC94?=
 =?utf-8?B?Q0EwZy9WeW1UWEI5dkVhcEU1dEFXSGNwV3VPZ1Zya3ppaTBNcklNUHpiMktv?=
 =?utf-8?B?c3M1TUNycDV3UURVUzBJdU1wYzJ0SmI4MGxnODJnRVJVZkVicnE1RGVEL29i?=
 =?utf-8?B?Wjc3OWZ4VGNheXl4WHBFU1pXQ3Z4anN6VXI0K0YvNklnL090SXMvNnE4R3Az?=
 =?utf-8?B?aDVDYm5ueklPYmg5SUMrUWxTaXlMY1UwaXRqbG94Q3k1L2hSSTBBWW1IWWcy?=
 =?utf-8?B?VnBuWmdDMFROQVdiWFl6N1hkY0ttL0Rtbnp6ZTFGN1Fmb2xmcGFQVEp4MTZz?=
 =?utf-8?B?ZGNGLytDdFl1dW1RZHVXaHo5d0lGd1k3ZGYxNm4vNU9qT2hydndZTnhxMG9D?=
 =?utf-8?B?NnZHbWFFTDRla0hVdEdnczRqM0o2cUxGSnZlcDZzWjZHRVhKL1JXSldNakJa?=
 =?utf-8?Q?nfqc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d882140d-e4ae-4f5d-220b-08dcfdd43225
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:58:19.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iJDBrUGDNJPtrjkoClsReJhqJYmDFwLWCIhIIgS2Eo1GQT6NsOaOQ78YIGzu8pS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595

Hi Peter,

On 11/5/24 04:35, Peter Newman wrote:
> Hi Babu,
> 
> On Mon, Nov 4, 2024 at 7:21 PM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 11/4/24 08:16, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Wed, Oct 30, 2024 at 12:25 AM Babu Moger <babu.moger@amd.com> wrote:
>>>>
>>>> The mbm_cntr_assign mode provides a limited number of hardware counters
>>>> that can be assigned to an RMID, event pair to monitor bandwidth while
>>>> assigned. If all counters are in use, the kernel will show an error
>>>> message: "Out of MBM assignable counters" when a new assignment is
>>>> requested. To make space for a new assignment, users must unassign an
>>>> already assigned counter.
>>>>
>>>> Introduce an interface that allows for the unassignment of counter IDs
>>>> from both the group and the domain. Additionally, ensure that the global
>>>> counter is released if it is no longer assigned to any domains.
>>>
>>> This seems unnecessarily restrictive. What's wrong with monitoring
>>> different groups in different domains?
>>
>> Yes. User can monitor different groups in different domains. But, they
>> will have to use different global counter for each group.
> 
> What is a global counter anyways? It sounds like an artifact of an
> earlier revision. This concept does not sound intuitive to the user.


# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
32

This is a global counter. We have totally 32 hardware counters.

This is tracked by the bitmap mbm_cntr_free_map.


> 
>>
>> Here is an example.
>>
>> #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> groupA//0=t;1=_;
>> groupB//0=_;1=l;
>>
>> Group A - counter 0 (Assigned to total event in Domain 0)
>> Group B - counter 1 (Assigned to local event in Domain 1)
>>
>> We allocate two different counters here.  Now we are left with 30 counters
>> (max 32).
>>
>>
>> This is similar to CLOSID management we follow in resctrl. This is not a
>> new restriction,
> 
> It is a restriction in a new feature that resembles a restriction in
> an existing feature.
> 
> I don't see what function the global allocator serves now that there
> is already a per-domain allocator. My best guess is that it avoids the
> case of an mbm_assign_control write that succeeds in some domains but
> fails in others.
> 
> I admit I said earlier that I was only planning to allocate globally,
> but now that I'm evaluating how to make resctrl's monitoring
> functionality scale on large systems, I'm being forced to reconsider.
> 
> As long as this is only a limitation I can fix later, I don't see it
> as an obstacle. There would just need to be better documentation of
> what sort of internal data structures the user needs to visualize in
> order to use this feature successfully.


We have totally 32 global counters. That means we can assign up to 32 events.

Assigning events requires sending an IPI to write the MSR
(MSR_IA32_L3_QOS_ABMC_CFG) on every domain affected.

So, we wanted another bitmap to track if status of the assignment on each
domain. This is tracked by mbm_cntr_map. This bit is updated when we send
the IPI on that domain.

I dont consider this as a limitation. This helps to avoid sending
unnecessary IPIs to all the domains when user wants to assign an event.
This is kind of improvement I would say.

We still have the option to applying the assignment to all the domains by
setting "*" for the domain.

-- 
Thanks
Babu Moger

