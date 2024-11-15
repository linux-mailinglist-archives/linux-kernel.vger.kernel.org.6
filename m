Return-Path: <linux-kernel+bounces-411216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23D9CF4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96941F21935
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AC1D63D1;
	Fri, 15 Nov 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQwMDkDs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A79136338
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698585; cv=fail; b=RNy/leyDhGHv7XTOO8cY7CDcNO1n5tuP/LnIU6aqt73yK7ZzGYacTpns48vET5NlJQkgTvrljy/+bMi7U+9dvPZvnJZsbWwMiXSxRoDwjag4gS6JZTPVaOmAYznNl196RfpfjutfQjUAs1nSSOUDJWF1YRWxsdOjtTnw+A1Zsto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698585; c=relaxed/simple;
	bh=nRkkJUkEfGHc+7YBB/bOxwTqtjhe/IhTVkD6MlBobc4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gt04LROk/eUPL8AGaSFhOVIYs0484odHoXcf96bCcwfPeHk2x4YFkcwMgiWCxy9htnWjimP2wKx89ktlRI7Emrzs1TdqbXaE6IKlZoIqjuKaB/hw1Uttr40KSzAMVyJzBnPndHsZvOps7h5JUNzGDZOvtQNKCglIukIABibOUqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JQwMDkDs; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9Ce+xTOxNL/8gKZVSKtqkWIWOUsZ4JUioXF2+XeRU0G6i01JWkiJQstawA+riNG1djeNGyykzYe0t4/yJD07APWX/0c9AbHTyqYJzL1MxAbkZYkPRx9Ek8kpip7vOn4RwnewGL5lIbcOc4akproT3EmuKNMBO+TT6NZHne1yRbhP5ehfpSSEGUWs5TMbkYr61NH6Xl8J0yWGry09l+BtSdiuCGULW0HLCa8ZGRHxuNmlKlBuwgXQxZkBHTmTScPn/iC44WSNMKnwTLWe3c5eQjHOtj6GeqnlqRIGpSMAzRY13RsKKGTPLsiLYouMrp7y3mcEFQjz+7iS9h47mwR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr6bvroPDNsdBkRmDV70r7wA2BGY505Ihj0ex65NwhQ=;
 b=gJ9lBZKBRwEHLpLBcJvJw0GC7hstkNUL8XktpGOTNIxHwENJaLvk583fYGPCJn291xDAl4VRKf5oQUtW5iPv6cvmdvcG3DIhs6dOd1WfoMiajjkSQqWzU+KO1VzJj224QxPZZ0fXxHEq7XstVS1ZtFB7CPm0dRhBqZwZ3uSEOvwpk4EAOs8NKttnd60iHc6gLcn/veGZwJCaGDGLKLyHOSVLyGVyMjpurPoL+d4jvu/usvU3j7giKd2pWGbQ/pvjXHl7+BPcDkq+U36X6IT+HvQzrx+DsyGdcjb7d2sWkzTR5yYcGFvlNcUTUPZO67FZPJdYP9ZygpREj1ZS/tTEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr6bvroPDNsdBkRmDV70r7wA2BGY505Ihj0ex65NwhQ=;
 b=JQwMDkDs031LrxKVbB1YNyVavdor9hCNLqzR+sBKyLmbDWQigJ/0+dc0DSNrAKP+cunfUFUznlTXN9LmAytNc9Q1eNSSoC58crb+BDhubIZgE7zmUxJtTyqaC0nrfXj6p0F4hX3XMKoYjDopvWNUtkZI+S6O934zuq4P/TmwSF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 19:23:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 19:23:01 +0000
Message-ID: <52aed08a-8c39-2003-8521-2d886ca8daba@amd.com>
Date: Fri, 15 Nov 2024 13:22:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ardb@kernel.org,
 ashish.kalra@amd.com, tzimmermann@suse.de, bhelgaas@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com> <ZzeU_OXCAzMSOU1G@desktop>
 <b243110f-d233-0b62-864e-2b6181663d29@amd.com>
In-Reply-To: <b243110f-d233-0b62-864e-2b6181663d29@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:806:24::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 725d44c7-14c9-43cc-19c4-08dd05aaeb70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXQyUEFNRTRTNEdLQ3R5aGVzaldONFdjL3ltMVVXbVh1YmRZc1BKWWxMYVBz?=
 =?utf-8?B?SThKaUxDSzJDS0llam9uUlA4V3dYM1F6ZjhtY21jUDhtRGFzQ2hHVnhPWnRZ?=
 =?utf-8?B?MzN6azh3S2Q4SVVGQlBGLzlCY0xwUmRKb3lCTUdWeUJURnA0eGNnUm01MHUz?=
 =?utf-8?B?eGVlUEdCc1lzVkJ0dXM1ZlBxQzQ1ckhjSDFmZEZLNHlhcXJiVnNZckNyRUZV?=
 =?utf-8?B?NVlkUG5hbGxGVWVlMUEyWnJtYnp4VTBRdlNHMit5NVNPZ1dSbDE3b1dTKzlJ?=
 =?utf-8?B?WWNEZ3RXRlRLY3V2MXJJZ2JqU3hGdERaMnFhQXRrNURpaXpZZ2k0N0JETDIv?=
 =?utf-8?B?eUIwWlBWY21ZOEJpUU5Xa0hZeTZCRCtjWGFseURpY1d1ZVhKSm9hbjd5WXNT?=
 =?utf-8?B?UWV0M2EyaWVPT1NhSjN3OXdWeUp0aG9TQjJEYUYwMmMwQjlmSUFsamMyWnlM?=
 =?utf-8?B?UzU2ZE5NbUlBUjlQdkh0c1dIT2F2Yld3SWU1LzRnUnlvUXZCcjlxUi9DMXky?=
 =?utf-8?B?UUNoZzNjNEFEMmgxQWNqcXRKTzhpOWM1K2NKUnJoZ1F2R3pMbjN5bTUzaFdD?=
 =?utf-8?B?SHU4R2phMHYvSS9OdlhGSGxuaDJJdmpxRmdzeXpQNHlVN0sxMndvMFphNnZB?=
 =?utf-8?B?TzZwZzJyK29HWGF3TElyZlVkUWVJMjlyS2tyOVpWaTZlWWhxWlZLU3RieDRU?=
 =?utf-8?B?SHdlQ2NyRnF1VE95UnE1QUF4U3Z3TzhaR2hPTnZOTEJsM1NkY0pxV3dPbUI0?=
 =?utf-8?B?MHRFenBSWkcwQnZIZ2h0UHhhSEF0VVZ1RTY0dm5UNlJSaHNqNjNYN3dtQkFk?=
 =?utf-8?B?QVcvdTZmTVgycDVobTZhelR6Lys5WDQyWlJzZkE0YzBiaFRtbGpCVHRyTHpY?=
 =?utf-8?B?MTY2bFFnWGdmMDhwMHd2cDhGV1dDemgyT203dXNtSzVBUjRyOWpqVHpGUjBN?=
 =?utf-8?B?ZVNJK3ZSWHJET0xFK2ZQaEg1MGNJaEkvUWhZYnBIUHp0WVIxekc1YjVqZ3JI?=
 =?utf-8?B?c1FVQkJIRjhlZGZNa3psZ0tNdlptQ2w2dlJjNkk1dzl3YWFNQU16d21wdjM2?=
 =?utf-8?B?eitYOUg3THFzVnYzZzJFZWtKWmFGLzhoRXRUdG5BK3AzbitFZlFCSEwvVG43?=
 =?utf-8?B?dkVCLzd5aUQ5b0FtSGZlZURvb3pPS2lOdDlOWGVNUFV4d2g2aFpNS1d3YWtT?=
 =?utf-8?B?QmF2bUFqckhKTm1hUWNyVk5Jc1ZBaittbHZDREd3NmhkKzl1SzZxMzJSZlUw?=
 =?utf-8?B?cjEzUStGSHZhTGRIeE40cy9tcE1aVVprSUVTT2VTRHBFbGZlVXdPNmtPbkN0?=
 =?utf-8?B?dUxjMlBHOW1KcjlCZTdYdlJLQTl1YldxNUdETjU3M2R1MnYxRE14eTFSY090?=
 =?utf-8?B?ak9HMWdod3dQSXVpNWFOSU9ORklBNDZtZ0libEtFblpXTW5pME1hR2xOWkEx?=
 =?utf-8?B?dGhKbHIzNmE1bzFkNC9LRDZ2UU91ajkrWlE1ZHVtSk5Wd3FRZGdsVWhaeTFt?=
 =?utf-8?B?M1RBNk45bEdickp1K2I4L1Jzd1pmYVNrZUhhdGdxRzZsRHM2anJKZ0dRZlQv?=
 =?utf-8?B?ekVuMlA5NklEalhuS3pnUEVaeksrZDZBLzNrTzFsQ0xiaDZoQlo3R3l1QXVJ?=
 =?utf-8?B?MnNETUU4STBKbUs0NkZxM3hLQWJMaGZtSkx2K0pQalpmb3hlV0xXTEtqRm9R?=
 =?utf-8?B?L1Byb0twY0FabDFVbm9wdEdlcDhxcjIrbWpMUDhKYTFEUnpMN3V6R1lxbHRl?=
 =?utf-8?Q?KxBmfXnYvsw0WXIA2VYbJqLpEt9moRaEvXXNKrP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDViVlZpbGk2SysyZlRGWE1qLzVUZDFhNjFQT21HNFMrUjRGZW5XRGZTbmo4?=
 =?utf-8?B?VmpTK0xhb0lnb1RidEl4N25pTy9UWmFQSHkwME5lNXhINWZzdDZjRUtGZlZU?=
 =?utf-8?B?aWp4dHdSSmVzV0ErSU9VTVhkZFNlbDZDWm9CeGZhOTV0MkQ1TUp4bzlib2Jm?=
 =?utf-8?B?RFVUQUYxRXdlbEdnYjdlQ3RFZjlQYXd4OEZ5ZC91MzBCM0h2Q0RDQjAyTzkr?=
 =?utf-8?B?bnEzQkF2ZVU0dUw2blZxQXdOcTMrMGFZeTQ5dHRlelVqZEZJNk51L1FQZjl3?=
 =?utf-8?B?WnRuMnd2SHBncnRmMFhYdkIrU0R4TDc5N25xTFN0andiRjJMN09qaEFXbTVl?=
 =?utf-8?B?TmxHVW9kL0hSVzRGUmFuNWppekliZ3lvZngzU240WFJ2ZFU2OXpuYm9KbEZM?=
 =?utf-8?B?cHZuRWJkZERMalV5TjIyZ0kzeWoxRncxeUpDeGJ6TVl3SjJ3bWc1WGsrekF0?=
 =?utf-8?B?WVJWZER1Q3dyNmo1VW1WNjZ2c1JwS1Q1WDZrOWpBMW9SenlqRXViSFl4SHRN?=
 =?utf-8?B?ZVNTOVRiV1BrN1VGWUZNa3hGczhyRm9QNURqK29Gc21BaXdOblZyK2RMNkNG?=
 =?utf-8?B?TElKUWtHNEVJdlhLQ0lMd1dGZHVRdW1TSnJGSzNVcWhKUHNLdmV2Kzl5aWZj?=
 =?utf-8?B?eFVDdjg2cmFNN0dLUVdMSlJRYXBaSGFPWVZjVFNNUUZJajd0ditEYjVpeitH?=
 =?utf-8?B?bGNZT0ZmRERRd2Y1ME9jY1E5TnlOTndPSnRtM0dxVXZlUFc2c3FhN3Y3ZDlN?=
 =?utf-8?B?aVorT3NVeDd3TVNRUlAyNTBVaE05TEV6ZE14TlJ2QzEvd083b2Q1aTJTL0Vk?=
 =?utf-8?B?elplcEJyRHhCNzQzd0kwVENsbXJ6dHJhb3F0Nmt3a1AveEJUa29pRHNpVnhF?=
 =?utf-8?B?L2FPQ2ZYZDM0VHFWdjFjTlZzNE1aRkZlU1VobDd0SGZlQ3hnOENUL1kxOUVt?=
 =?utf-8?B?ZnMwNlN1cHFQSFVlckRTaG9kcmNXTkNab0ExelV2Yk9SdXBQYTNtemVMVm1P?=
 =?utf-8?B?eWdYTkxUNVZ3NUErUE0ralAvcGg1bk9QMzFwLzFUSXpCcFEvZ0t6RnpUMVlp?=
 =?utf-8?B?Sm95WmEwWksvMm1tTXRYU2UzQmJuU0Z2bE14cHlGVXRsKzJBU3NzWDJ2R2pu?=
 =?utf-8?B?UjkxcUtoa0I1aTRHUHl6L0J4SEU2aXd1S25oQS9aWjhRejBsQ0VvR05vQlZ5?=
 =?utf-8?B?VWRmOGVURkNUVG1FcU14MzkvYmJCZ1VEMWJZZE5TeDFJZWlIOVVVVU50LzFF?=
 =?utf-8?B?ME5GOGI5bkJGYm9aZndwMXhDYXBpSGd3WUlleXNPelpyZWVJaWxPTVZJR1Vn?=
 =?utf-8?B?ZjhEc2lVVnpUQXM0Tkp4Z2ttSXVaRCtsYXhxd0xFL1N3V3R4WG52ZWZHWW9l?=
 =?utf-8?B?aDdXbmx4YVk0cHNPeG1XRWxxTlRjN0tSYk1DLzFOQTQ4ZTAweHg2c0hST1BX?=
 =?utf-8?B?UmxOZnVmbGYyUmVWd2U1cEp1OHIwUEs3NG44b3RXVmdETDRyeEVtWTQ3K1c1?=
 =?utf-8?B?a2hDTHB1Wnhnd28xV2NwSFdMaVlvVDdVZFJ5TExKeUI5MUFZMHNTTG03WmlY?=
 =?utf-8?B?RWdMd2h5YWxxZXR1VGRrbHpwRWNGNURUU2xyQW9WQUpMOWFzMnFNM2JXQ1B1?=
 =?utf-8?B?YTdySm04ZjNOY2J2NFVycGkzQlg0ajhzMXZNUXhiSXZYU0dmV29kNEZnRE9n?=
 =?utf-8?B?N29EOGwrK1N4eU1jTDYweDVwK1p2R3RBajVQVC9jVVM0NWVKTmtJYU0weEc3?=
 =?utf-8?B?N09PdmE5cGpSTjdGRlBPS0JnUEdiY25OdFNpYi80QlEra1pDRjNmS0ZwTXJU?=
 =?utf-8?B?VGNLTVNIbWE1WVV2S1d0b0JKU1pDYVBJVVpBaGRUei9vWm0yUkpqWHMrZWxI?=
 =?utf-8?B?N1paaXd0TDNEYkhRUWJqYzNSdHp1ekVTRUJqeTZMWDlmRWhKejcrNjlEUmxr?=
 =?utf-8?B?a09hS2hxWVNlenhjOUhYVUZWOEtuR1hidU83dkZXeWtHKzdIRFFUdVlDWmRq?=
 =?utf-8?B?MjRaMDRIUnBqUmhPL0Y4dm82UG5raXFYZkZubFZ1emhHL1p6NDZaalhrYjNy?=
 =?utf-8?B?ckdpb1pIUXZtTW44UFNNUDBFT041Sm4yM1YzN2M0em1IZlZtdUZ0Ujg1akdW?=
 =?utf-8?Q?RTPdTtGw0JSrRdoLtEspprBPU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725d44c7-14c9-43cc-19c4-08dd05aaeb70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:23:01.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yl1q+mKgE47KYZ3r8WaXIMHApLNYiJQT50j6taVjLSZR1Dr2clXZmMjBZbJjrIfVAMUn0vh2YbWX+x6ZGX+JPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

On 11/15/24 13:20, Tom Lendacky wrote:
> On 11/15/24 12:37, Ragavendra B.N. wrote:
>> On Fri, Nov 15, 2024 at 12:01:03PM +0100, Ingo Molnar wrote:
>>>
>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>>>
>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
>>>> it was not initialized.
>>>>
>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>>>
>>> This 'Fixes' tag looks bogus.
>>>
>>> Thanks,
>>>
>>> 	Ingo
>> Please feel free to suggest the valid tag as the file was renamed and I am not able to fetch the correct commit id.
>> git log --oneline arch/x86/coco/sev/shared.c
>> f50cd034d24d (HEAD -> 1594023) arch:x86:coco:sev: Initialize ctxt variable
>> 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 
> A quick git annotate arch/x86/coco/sev/shared.c shows that function was
> created with:
> 
> 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")

Also, the subject line should be:

	x86/sev: Initialize ctxt variable

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> --
>> Thanks,
>> Ragavendra

