Return-Path: <linux-kernel+bounces-540924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E48A4B679
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5E188ED9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB51C3314;
	Mon,  3 Mar 2025 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gGNfQkua"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06217190468
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972322; cv=fail; b=lNmj7QjDyJSKlFlVaHtUcOn9IF9AkZ96GGsf2yxvBIMfh2h7vb1Q+CoOAR8OTmNov0fyPKzmAdwcOh/G5WyHNZfDQDfYTrF6GudZVuDBt0rWA3xW5eUjgWjDSsjxyab7Dquerp/Rt9bWIIHOzE+KAL3iZawEga9WKGJqqkKw0Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972322; c=relaxed/simple;
	bh=N4l5R4LC3gWLbDiateoapV6YJKb62dcPX8uQGmWjyYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BARTZ8Pjl8iIDFooGjafgJQ770hODzJToYLCSKjdVjyrFyhA2MRqJXwgypASiC6U2Dhh0CMr4Lk0ysB2tGxwrZ1T5aGhd6CHR0svLqCVqD5h/092JzmmyEh0VVQvSCp0dyEPmhnDtCwA0vfoHn06IROGI5NLed2+/b+Sj4R4/HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gGNfQkua; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdYdEx1594/nnWNP2GQHxN/nAafN8pwzTm9dEFzEutjS6Rwx2ae7IVwrUcniu86Tjp/Wb4DCgU4MSUZ5s35Oi1hGC/XpG/yLwYsKrmB75ymLndMnQncp2kRifdwon7HaQkyQwhmM0YHaE0JPjGmE0NbuE9h2KejePTl4MolSs9cgg0Q3Y49bgZpHyLfYMHGuU9A0NNFjuYxXXbD4aJ/aUhx0lqWAdWXkCJp/Zp2C4W67jatkeKVU7jf4P+Cb22wewnuYwqSz3tPPwVCf96U/tYhoXSL5o3yusKv4WkoyeWDHnE7Mm8D8+iSnZ5+ctAAQMqqkjCKzCSYqRoRqIsGHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lz+A7caPwBxcFp01leWTbs9E+wrs5g9hpysR3NOMqc=;
 b=bPEZGmA4nDKidvmE/4ZR/PB8Kkcj+/BVnokZNqCi34fVmhJe72hyqGHp+3PgOSHwEOPJNLqnLXLLgP/QrUKgClNy6B4QHowAV1ZRwg5Qwxj6G98FANqyWYHPPGu2jVRuIEOhKcDCbMVqZOZbdDiUeEmxX/bZZ6D1B0239GPQf0X14zaXzJU6K7++hJ49xPTkD1MqAWNSyxVcUm+Di2DwVnfygvvnCPnwBpiCkCWGYCxh485eUDjBySc8TXU9fDxZz2yWoKRnnzl6rrsL0ph3uNGI3RXShICaqDKtjukEjXCWzxGotRKeDF8CO+C2sHkva0YeEDdapizdR/RXkcKKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lz+A7caPwBxcFp01leWTbs9E+wrs5g9hpysR3NOMqc=;
 b=gGNfQkuaVh+/tZorIRrN/1XIDP/hqf82McPcfnQ3W08uqhhs6BTxMx7YxeHlfFz0w0AN8O0a4+NQiWYj6t4OSKBYNBp3QhWIHsW+v4WgYEGPhpFr7tMPX1eiFRydOMEYTKoeP+X4Ce7O1JmkD0ydmkMFGMp0VUJEMWWXk6xJ2GE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Mon, 3 Mar
 2025 03:25:16 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:25:16 +0000
Message-ID: <fd86431f-d373-4ec8-9089-09eea843fae0@amd.com>
Date: Mon, 3 Mar 2025 08:55:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] perf: Make perf_pmu_unregister() usable
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, lucas.demarchi@intel.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241104133909.669111662@infradead.org>
 <Z8NnVdo8wB-YcrAs@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z8NnVdo8wB-YcrAs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a8e371-768a-40f2-8afd-08dd5a030411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkFoTE11b1VyUFpIbG5jQThvYlpUU0wxRnpxTzljbmVDSnVYSm4rUjRFMTQx?=
 =?utf-8?B?RVZ2bzNvL010NmFMbGNpZUdiZWJkcEt3YUFXb0xoZmJPUlJ1d0VoTzZFYVc0?=
 =?utf-8?B?L05UTXM0MWpXMVQ0K3dPeHpQVWJhbEpXaDVJTXJ3ek1jckM0MTZnOVkzdU9I?=
 =?utf-8?B?WThROUxOaVlUVDNKd0dNcHYxUTdpbjdVT3lmZ2pGcXJ4M29rL0lwMGc5bkdm?=
 =?utf-8?B?bEFRQ0JMbG5vcm1Mei9XNzFJaDBsZTFVOVg1V29yeGpCNC94aGFDdGEzWGpW?=
 =?utf-8?B?TnM3eDR4MTRmM01aY3pqRXpYZ21zbEFIS1RieEorZWhYMGVGWlZHUkRyYlBx?=
 =?utf-8?B?QmkzT1JRalFvcDQ3YThuNzVPOFdPS0w2UFlzbUR5QUt3dzNJbnV1OEQzaWlw?=
 =?utf-8?B?V0oyWktZYXFxYTFJYTN6TlpWVk8zRC9sTjFrdktsTk5iT1JUWmdBa0JIZ3J0?=
 =?utf-8?B?UnU0VlRGRTlSNE9zbGx6RlNLb09wM0gzOUZ4cXNpS2MxWWYwbUhja0xSck9T?=
 =?utf-8?B?d2o3NTlHMWhSTkkzMjZQTVlmRlhuWDdGVm1tZURBZkd3TEVZM3JVMGp0S0t1?=
 =?utf-8?B?TkZDYWRYc25TQ00ydmVwZGo1WkxpUTMzY0xsU1ZpZ3JjWGFidmJXYnMrQ0Qy?=
 =?utf-8?B?dFphT3ZWSGF6My9wczZ0SXVHbk43OHA5NEEyelhxVlNueEVpcll3OCtaMndh?=
 =?utf-8?B?eDhlNk9EbjJZZStqcVFlZ1A2TUlQdFNLT09sYmhWQnB1RWtXNEtaNWhXdFBn?=
 =?utf-8?B?S2tWRHdVdHdHUWdjRUd1SkxweUd3WDhNMTlnSGVia28wS0RyYUdCRlpiUW5Z?=
 =?utf-8?B?OFY5MWlUMGd2eE0vdG5VTVJZbHFaV1loWmpJdW5lSCt6UnpOSEhpUThOdnJZ?=
 =?utf-8?B?bFhlVkxSMS8vWGxpT2c4MmptTnl6N1QvekhYbE1QdlFHSU1rdWorUVJVeW9Y?=
 =?utf-8?B?Z1JVVzNwUlhlUVY3VUxFQlBsdlZ3KzIvSGtTSVc1V25nTU5XN1VMelp1ZjNa?=
 =?utf-8?B?UnhMRnlwUnBEUThmakxsSVlNaUxsWWlIT2tUZkMzMU9oeDl4Smh3aEp0QWVp?=
 =?utf-8?B?cVUwVmRvRURaZDArYWlNaExOZEZiOUNGaHREdDI1Z1lkQTFZbEtGcFBiZWlw?=
 =?utf-8?B?NjNXTm5vb2phdU04OEJwa1ZiLzVobzBUNnA3dDhzVGszb2ErcGRCUmRNY0lY?=
 =?utf-8?B?YzlyWGY2dTI3ZzR4Z2FmeUs2ell1SGxieVZHS0lyeDBYVXh6YnZueGlQRXIr?=
 =?utf-8?B?TDUxR1VHOEcrbnBVQ29aYmRxbDFIY0ZUTDNNdmRrYUMrb3gyVnAvTXBMUVpC?=
 =?utf-8?B?QXNEOVJ1cVowNnB5dTZseXNORkUvWnR0Z05pd2hTSURKc2V4QnlaVWVqazlp?=
 =?utf-8?B?S0ExTCtxWnZGU2ppUlJndUlOc0V1UllYang5L05uYnRtY2dQVjhIU2FBczly?=
 =?utf-8?B?bnNLSUoyenRwUzAraWJNdVlWWnM0a25ORXBXNlNMbk91eE5DZjRQQ2ZQQVpI?=
 =?utf-8?B?UFYvNW1vYzVXMW44aFVVU2g3M3lld0ZJVEk3ZHNsYi9uM05Nd1Y5VzZVTzh2?=
 =?utf-8?B?dCtjb1k5amYrNjJkRjkvcDFnb2Ruc0VuR3FUS2puUSt1Rmt4enRwNEVOUGx6?=
 =?utf-8?B?VlNRQzhWT0VwSVVBRGthMG8wYWQxZ1p3Q05mWE9wSGVpbTZ1UU15aEhPbml1?=
 =?utf-8?B?OUxBLzZBQ0tRRFdPZmJOK2c3amhUbFlSV2RsV2M2UHh3aGk2a3Z6aXNGWHl2?=
 =?utf-8?B?NlNGVEV6NG85MzZkL21rV3NEZi9yRmliRkVIWUlTV3hvRWN2RFJGU1FQenBq?=
 =?utf-8?B?TmZIdmRlNE5odVZzc045N2VuS0VvOXJpbjNBMEFXUDRuM21YaEplZ1FmWExv?=
 =?utf-8?Q?gE0VsEyC+J/GP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnF4a0dPT0cyUTE5N2NncHY1eldEQ2ZBS0pVN2tPaGJCalFhdnJjY093V3hN?=
 =?utf-8?B?cDIyZi9ZSGpBZWZlN1BTWlo4TmdNU1ovSHhNYzlYNGdVbjgrRFVCSEMwcnlm?=
 =?utf-8?B?TUt2SnJNekpid3g0ditMbWRoNVhqNStheHlaaitIaWJFVkZOc2dyLzJRWm5q?=
 =?utf-8?B?MW8wMjVvZTY1UEV0NjUyaWIyc0N2bTZqYXFjZTZjaTFrUTc0WUUyRk9xU2RS?=
 =?utf-8?B?TG04cTR2SnpodTJIMHhVbmxmNEhkY0dWeGQ5VWNINGpibHFQT1JyVVo3NWdz?=
 =?utf-8?B?Nyt1ZzBrU3NybVE3Ky95VFFVc3JKTmdUMWtNZG85REVVKzN4TFp2TzR4YnNt?=
 =?utf-8?B?Ukd6N3M0WWZXbjVnZ09sdGRCU09sZjN5NUdUZVBVVmN4SzAvVDVkWmgrcHg3?=
 =?utf-8?B?RzB5dCtMWUZIaTJ0bXdSTm9Xa1VYVlJNandlaloxZVFzaHBUV3ZPVjFWWlRy?=
 =?utf-8?B?aG1waU53Tk9kcXZDYUNDck9rU2psbnhXV2pORnFaYzgvK2EySlBVNC90UUty?=
 =?utf-8?B?YlY4STBUZ1FvN1ZEd2hMVHZpcFdLQ3RXZGVHcmUwSTNMbWtSUEQyTXVLa1ht?=
 =?utf-8?B?NWJCT1U5QnYxSHRiTEpweVVwK25mTzVRVGQvVTdqUmFTZzR6Zjd6Z0xXbHJF?=
 =?utf-8?B?QWM5dDcwRlBGRkZWME1NZkxUUlAwR3JsYyt4Wm5kZWZteXNvMjhTbDRsNURa?=
 =?utf-8?B?c2xLZ2hlN2RBU1creUdHZE1aWllZUlI0d2tRdTliU2ZaTkZCRmNBazNSb2VG?=
 =?utf-8?B?bnhKT1BTMTN0Szc2ODdvblpFMHQ0S2UxNDZ0T1pjWk0zYTMwWEs2ZUdqTkdJ?=
 =?utf-8?B?ZzlOUUNQS2J2b0hOckxkanBxUk1MSElWWUFzaklyNnhna1ZVZFlFeW9LY2ZU?=
 =?utf-8?B?ajhKNkdwVzBQaWxLOEt6am95WDc1OFcvY2l4UkxhZkFrdkwvQm5FdXJnQXZR?=
 =?utf-8?B?Nm96MDVka2R2N1AzQXVTbkpYODVTbE1RSUFQK3N4dTg5RThNYjNaMXptZVJr?=
 =?utf-8?B?YUtrbG9KQWlMa290Qk84MU85dlg5bHUvVFlBNk9VanBKczgyZCtRRlYyS3h4?=
 =?utf-8?B?Sjk2QmhRZWo5T0poQmpobFMvSjlKeUZUemVRQk04MHRleUN5am0wR0gxK3JS?=
 =?utf-8?B?emxxalF5ckZHZWtXSTBVSnBKcUxXM0ZGL3RNTlB4MUtMQ25KOEliSEhLWmh6?=
 =?utf-8?B?UXJXVDVlbjRRM1hmQTJrcEpwdCtPRVoxYTFYTktLdVV2ZlJRSmRLbTFnQjNL?=
 =?utf-8?B?SXdaK2JhOUZZYXBUeUZ3RjBORitySExaUVZnWWxBcmREVnNnQTRLVmNTbFdG?=
 =?utf-8?B?Um5ZU0p3eXdKanh2ZlVnK0g2a2xlWVUyNmg4amVWZThHM2dCaElYS0dMWHMv?=
 =?utf-8?B?ZWx2aS9rSEwyRnNPTnhNbjBrSm11dXFsMUI0eVZnaHFLWk5VTzJUZlRlMmRx?=
 =?utf-8?B?NnhOUXR4anlNNm43QmpMZnYxN0tGMWY3N3o4OEpzN2NETUNyOWFCWjI0U0dz?=
 =?utf-8?B?M25YcWlSSit4OXpHMVAvSHgrZzgrN1VsNlBUU3NRZUpnR3Zybm9sRnk4Wkll?=
 =?utf-8?B?ckdsQmJZWUo0b2x0cUFWaTZqRE1XQ1YrekNoaXhJTDFuQ3lqcTBqd2IwTytp?=
 =?utf-8?B?T1Y3Qy9QOXdreEd6NUlrcVZxd0lpeGVuNHdGNlQ1bVZHakt0cnBKZDhZSVRm?=
 =?utf-8?B?Y2xoV1VTUmdNckxUdDIyVlpqbjYxZ0gvWUZ1Y1gxaTdqVU1nZjNBRWx0R0N6?=
 =?utf-8?B?RFQ4R3pTVHFqUVp4eUxjM254M3c1Z3RNaEJUZVlkSzJPdXhCNGt0ZTN1d2dp?=
 =?utf-8?B?TVhjbXQxS3pNZVdXeGJhTWIyTmhEVmdFczJiRGpuQXN4c0U3enkzNmJwSnEr?=
 =?utf-8?B?VVNIMTM5WVQxNUd6SERXTTdlMUtjbHIyc0pyQ3VIUjRnbHc4aURtN2VkanJQ?=
 =?utf-8?B?bUprNnUvSUNZRXd1SW4zWnowWjVhV20xamplSTQzYzh1dUs3cjFKUmlPaTBt?=
 =?utf-8?B?OHdBb1dMTlZIRUhxYnJpdXN5Vm5BN1dxTDUvODMyUkxLOHJSUVQ4QjFmcm5Y?=
 =?utf-8?B?WTR1czdPOFovZm5EcnlRY2V4NkZXaEh0SUYxY01wMy9vZU5sUkJENFBEdHJL?=
 =?utf-8?Q?E2YuvMo3CyLJJCz1kf9kM26ta?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a8e371-768a-40f2-8afd-08dd5a030411
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 03:25:16.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14Iubhd/hMAxgrFADeKmgo79aZtFZ5Sp7TYR7OKc+SKo6sbnnpA+EBPtBbeHsUwih64zII1va1NwtTAiTdUGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

Hi Ingo,

>> Lucas convinced me that perf_pmu_unregister() is a trainwreck; after
>> considering a few options I was like, how hard could it be..
>>
>> So find here a few patches that clean things up in preparation and then a final
>> patch that makes unregistering a PMU work by introducing a new event state
>> (REVOKED) and ensuring that any event in such a state will never get to using
>> it's PMU methods ever again.
> 
> So it looks like this series first got lost in the usual end-of-year 
> fog of holidays, then it has become somewhat bitrotten due to other 
> perf changes interacting and creating conflicts. I cannot find these 
> patches in queue.git anymore, other than the somewhat stale 4+ months 
> old perf/pmu-unregister branch from October 2024.

Peter posted V2:
https://lore.kernel.org/r/20250205102120.531585416@infradead.org

Same was pushed in Peter's queue repo (2025-02-03):
https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/pmu-unregister

Thanks,
Ravi

