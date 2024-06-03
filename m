Return-Path: <linux-kernel+bounces-199183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139A8D837C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCF71C246C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BE12C491;
	Mon,  3 Jun 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="359Uva2S"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70D12C528
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420025; cv=fail; b=Tq7mUfC25ybseXlKwy9q/jMpAzRzY0mkF+tqa+Pyz5siVOrSlGYiO+Mdm4nTwl38JhJfr2u2ELIrLA4A7WGPZv/rBjMe6zPjAduHFunIVcmbYRiaxIvbBYVz+WIuvjsWIRsBp0juWisfPeovOImGgroD/aClTof3YDULgkkElQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420025; c=relaxed/simple;
	bh=zZz+0qfucC3nmXbva/Uio85a91kFwbaaJgUYbpskoiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9x2tMiC0Sau26G8NjvoJT6wP/MMVm+PACKfvh+m28V4Z50kfN7rpJO5r5g05q/llwQlaobq8BW37wfhja0jC0O3pNp2OYVZ9m0U21sbjQuuzYv0B0xr45r54WyRwxBWf82wqGXo9sJOalziEUPN6kIXnjOVDDVcqeqkkLtYEk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=359Uva2S; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5de58JP0Z607J58SZllKw40mKNdI+ejL9/gGQc+hW9pUfLoHmpBU3UUi3vJQbx+FmsvdC50GNTXGiyXEvpk1ihLtkcMBFLGEaT/ErzY6ulcCPbP4dwTlmvc/5GL3vB3W0Ft3I/1sn7AZrRZJVEua0OQZS7gnw5ICU1iCQC9kQtuhqQheReLRYb5QZg2jUZtCpNlYoyfnj/ym6QOX5OxZV+j0BQ+bzATwybLAqVQgxLNU+PksaadmVGGCOsSSUgUAn2ncpClMk/wWm4jHtsBNglcjdEX+LKhog4yTxpA6KCaVMy18u8PIsJumKY97ZYgowqBYxPrcvKLG+R/WZw+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZz+0qfucC3nmXbva/Uio85a91kFwbaaJgUYbpskoiQ=;
 b=edPCB0gYJHub/zIZ3nnK/pDY/DMKPRXe5YhWoyLcSttIGSMDZXCj+/Xy4SaLfR/jEVEUJSf9n6WpCkrNwDE+w5dZv/g4YC/5TNjLk3XYT7YZLWAkQ7IcdYYX/QH2YSdyFDsOQNPSz9lV1NxdcIUoHphUZ9N62R7r30JDoc/r1+30imyGBzBiZz6Fy1zJCquhsLSWROCM/q4LMM5QCn72XvZ/bOcvNp215Zp+A4FkmbZqV3DcSwoYknQpQzbOvmOSu41blY8cHyFrC0xAY8Y/Cru6kV4/aeVy0m6kL6n8N7l+QAoZTWE8/2JHeGAUQ+UXHopgIsL+sPCqQs/Ez1CG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZz+0qfucC3nmXbva/Uio85a91kFwbaaJgUYbpskoiQ=;
 b=359Uva2SL6NePRwfeXePMrZGYzU3yvbDaAD3opW/s9/VucXQse2pOovc9HhH/BqCcsEiqhkI75bIGfP65O95COzIxyXmglQ1VCUWZsgRGRrVLjoP+wXHs+drQv1LFSz/Ptze5YPDvrsMmCOyx1O9DxyEWwGSzFgaeB7Wb8uxX/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 13:07:01 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:07:01 +0000
Message-ID: <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
Date: Mon, 3 Jun 2024 08:06:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:5:74::34) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de18f8e-e8db-4b14-d3ea-08dc83ce0e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnRoTzJDMWdCUzA2d3FxaE43VzNjZjhlYlh5bHNOUllPaXFEYTVuWFhsbWg4?=
 =?utf-8?B?Z0VGS2tERk94c2VmczdrMlpydmFxb3A2VFMyN1htMW5paU41SHNKRTEzQzc0?=
 =?utf-8?B?cjI2M3ZSNU85THFvdXEvcWljL0V5N05UUGRuVzdndVBzK2VJazNWd2t0ZmZ1?=
 =?utf-8?B?Wk1LM0dDVi94QmhZWm5pKzRLVDdnNVpUVVZIdkJkVjdlL0ltc1VYZFpNbzVu?=
 =?utf-8?B?L0FJcVA4WFljN0FsZVFydUdENWg3R0sxMDcxOXo5dUxRb0x0TFl5M3pzUmNh?=
 =?utf-8?B?eHUwV2d3ZzBHNlBMVUw1L0JiUmoxRTB5WnFhMjNHanNlOTJzLzNBSDR1VTkz?=
 =?utf-8?B?VkZaVnMxWkFOdXBWVFJxR25XOHBWZG9CVzhBeDVkRjR6K01oZ0xocWE5MFdi?=
 =?utf-8?B?UVRIZTRDbVE2M1l1a1EvbC9Ua0Y4WTc2WVhBb1dnSWowMXpqTDkrMHUyQ2dv?=
 =?utf-8?B?ZmxtYWhhOElvdmk2MmQ2NTBHWEZiMU96bVJvZXl6aXFXaW5HTytvNisyUVQ5?=
 =?utf-8?B?Q25CRmtnalJ5Sy9Yb25OR0YrWUFpQXF2Wk5tZVZqdlRYMkd0aU1ET0c4VG9m?=
 =?utf-8?B?ZldLSmVTc2lHUG9PU2NuYUtuQ0dLaEdXVDZmYXJkZFlzNVkzN0VFQXRzZWZH?=
 =?utf-8?B?bmxjVE9zQ0cwam9ubHNZK2VoRnU0aEMyU0Y4c01XZ1lkM25ObmVkSi94T0py?=
 =?utf-8?B?UHRhNlFubFFVZWhjTHpTWUxoQjFzby9yZlBya2N4S0Z4Vng4ZjM0ZXJkOW9S?=
 =?utf-8?B?RUZqWXkrODd2OGlNRWFaODRDVkVRVkhvdkZqQ0ZKT3VUOHQ1cHM2RGJCU2Jr?=
 =?utf-8?B?SUo3OVUxdlVxNU9IZGpxNVFkRUgyNzZ2Y3lnTlJYVUFRVWdNUGVQZWNWdytw?=
 =?utf-8?B?L3J3UUhsWm45TjQrc05sWk1FOUJ0clA3bmtjZTZnKzFGaW1QOG9XQTR0TlBt?=
 =?utf-8?B?eXRxaE11UnhwWHRTamk0cTdjY1NWUDU3THUrcDRRWTJXTUVXekRidW9uVldB?=
 =?utf-8?B?cHBPYkI4RDZURUpITlZFWnppY0JCU1NjL1A3Sk9IcEcwLytCdzZFWlIwSUp4?=
 =?utf-8?B?TFR5R3o2S0xoVzRSQkp5cDA4T0IyeTNhUkRZdWdhaWQrUHZWNmFPSncxdGJ3?=
 =?utf-8?B?cmR3VmlKNEwwak9JSlFoeEx5bWZWclhNbG9Gb25vYXllQ1YxSVFCOGVpbDM4?=
 =?utf-8?B?L2pPWWtQbUFSUm91RHZMd2oxYjE0ZlZKeDVFMmdBa0F0WXNmNGZ3NWxqQlNo?=
 =?utf-8?B?QUNoYUJNdElpWjIxWjBlZVN5dmd2MmRGUXliZ1NqQnhod0R6OUhjS3NOZUtx?=
 =?utf-8?B?VzVPOXgxbnI3a3BhZHlqYVZZRjdkWlBGTGFYRWNTZlRSUy9ITm8wLzI0YzR4?=
 =?utf-8?B?L2Q5UFFnNEh1ekJkT1EvQmpPVWQrdnZiZXZIbnNkMkNnR1h6RUl0NGJsOHA3?=
 =?utf-8?B?TGVlcmx2L2x4eExDZ0M3Rkh0c1U1RldvY3ArQUVMRVhaY1g4TGFzVWpnNW5E?=
 =?utf-8?B?Y05yR0lvUkVRVThWTzhUVllXTk1xa0UwamIyTHNGNmRjRjdDQ3E3RUtQZGo1?=
 =?utf-8?B?b1UvUkF5L0hzR0M3OUcrdG1wY09yS3JnUUUwQXJuV0M1aWZLLy8xSmdDVGVw?=
 =?utf-8?B?Vkpidmk4aEp1ekVFQXFJVzU1UXpMaXFHNFNZeDhSU3Z1aVRFdlo5NHlCaWhD?=
 =?utf-8?B?SUZTL3lidFVhNXRVREtDM1RqWVdVVlkrbkJvQmtrSWMvclZpUWV6Q1hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlFqUFNCNWd5a0JZN2Fnb3poRjlXdzdCVy9ZMmhUeWE1MUZZMjQwN2puWEZE?=
 =?utf-8?B?aU9pNmI3d1JLb0VWN0hhank2U0wwaVc1NlhCNENFa2tBUEhHS29JTG1QSEFE?=
 =?utf-8?B?aFRNelJleDl3ZnFuU0xhK1gwazRZT3kwOXhWRjRNdHEvMVNKdG1SNUh0cDhn?=
 =?utf-8?B?QXFtWTF5cWhzc0t0cE1UeFkrNC8zT1JvamRuSG1WeWVpY2F5eTcwZW0xZXhD?=
 =?utf-8?B?RytsNjJlVXlYK2w2MVVzeENoeVEzOXhIR245QTJpczlhNEtWS056OGhrdWlq?=
 =?utf-8?B?SkNtVEZHbmluZE9LZUhCYmZTby9rSXRUdUZxaW9QWnNWM1g3c0xzODQ0TjQw?=
 =?utf-8?B?VHdUMUE2SXZocllaaXZ0SzF4QWVqSWtuUzNGTjU3Y3ZEY1Iwd0JyOHBiMW9o?=
 =?utf-8?B?RXJpL1hmWlJZdzV2U3dTTC9SeGRiSkY2VGVKSjc5WTlBeVFIMDhLZ05RU2d2?=
 =?utf-8?B?L0lwbVRVWTF4K0VtQmVaNXZFSXd6aU1mQnE4cUlWMTR2TG1IbTN3K1lJVnE4?=
 =?utf-8?B?NFJ3eVFKdGdIWlF4NjFldHc4S0ZDNWpmTTVWZGRkVFF6a2V5dzlHLzc3MDF3?=
 =?utf-8?B?clk1SThZbGxQbTN2WmFkcStwc0FVaWIvWWxrcnE5TkJ2MUFBTXhHNzhrTWFn?=
 =?utf-8?B?YW9sT05nSnJZeW4yTmxHYkNsZkFUZTRydHpkbXFYRzlZem83dG5DTHpZZ3Ex?=
 =?utf-8?B?Z0g2czE0NVQyVnFOUkFyVDR1aGFXM1dnbkhJWHA5SXh2Ylk5bGhicGx2VWFN?=
 =?utf-8?B?YlY4TmIxbEhkbkJxL25FdWxyK2wwZUZzVTJyelc0TTJYRjNzc3VXRWdDRXRG?=
 =?utf-8?B?aXpoaVJockR0WXI3cHFoa0d1M0hrUFpOS2k0WjBBOHViL2kxbGpUTXlvTFRq?=
 =?utf-8?B?MkRyREVtRGtYM1I1WWpaaCtnVE9UMjlySTV6UEJFOE5YMU5aL1NKMWhucmtY?=
 =?utf-8?B?UWlLVlZaVWNKUmhiR2M5NDBJMmNBelI0VUVIdm8wMCtjYk9kMTV0RElFTUYx?=
 =?utf-8?B?ZytiR3FnTTNEVXk0ekd2L0lwd2lRUWdNTDFVWlFCQnRDRmUvUWhZVHhuOWVX?=
 =?utf-8?B?TWQ3cE9ERVFPalU5RlhYRytvcm5OajJFaHBXR0dvcU81SXo3Y1ZaM2dNbWtt?=
 =?utf-8?B?UUtMUDlvN2Q4VFhjSVpwQ1VpcGE1SHJUMzdEQ0RHaGVuQTQyNXIwbVFRcmlv?=
 =?utf-8?B?Ry9RRUhEeFJSeGh3RG0wU0ZiMG0ycWZwSkM2dDhOR3E2SzUza0pWM25YdDh3?=
 =?utf-8?B?OGMwVDVjaFVrRFFuVzFhcG5PY2hQQ3RjMzFTb3Awc2NpWHVFUzFucnFEVUpl?=
 =?utf-8?B?Y01XS3FsbERUY2RPMEdWQUFwK3hTQ0lWdHBhcmVtSXVtZFRxcmIvVVY1NjFp?=
 =?utf-8?B?WHViaXl3OHBnelJyeDBVaG5zY1NJNUpaL2o1azNSWjRqVlgvY3NVUm9VMlhU?=
 =?utf-8?B?a2N2a2pIYWxsZ3RZaVZSSWdIOTRWSlE3QldpY0FCQkkyaXFSUmJjZk9aelpq?=
 =?utf-8?B?SElnWU1pSTBObVdTSGxJTm1Pa3R0b3QyOGIyUXBHemViMjk4M3Y2ZVNtY3JH?=
 =?utf-8?B?QVZUMStCMnRtRTVmb1dRNFpuWXBQMmNOWkw1dDl6WEZwTkg3eTJrZVNNMTFV?=
 =?utf-8?B?bUhCdk1IWmowYWRvQmpUS3QrUTRSVWpSUHRqNW8zdk1aOSthWXZreGV2TzBu?=
 =?utf-8?B?alI5U2haL3ZuaVpnL0d4dnlpWi9FaHhWZXVmQnRVbGF4QXl5bWY1LzFnT3Na?=
 =?utf-8?B?NmU3MlpyQmJIWmZ5TmxpM1FoUGZSN21BMHFFc09tajhnVXEvOFMyZHBvT1BE?=
 =?utf-8?B?bnNwUGhObG41RlB1bVFFQ0Nqci91WjgvbnRleVcwN25HRjNQRmVEcUVoeDds?=
 =?utf-8?B?TW1uL0ZhQXJ0T20yTHBlcnZmeGE3T2hwcytHNlpKeDlGc2V1SkROdFlkV1Na?=
 =?utf-8?B?WWZDcG5EU2hkN2hTRGdMZkI4MzZMMmtTdmxiRTRrak1KTWpXYkJlc3B0L0V0?=
 =?utf-8?B?MkZwTm1LTGxNQTZmTmlyZHdETUEvYzFia1B4dkM3WEZ0TkUxL3FhdXV2dzBs?=
 =?utf-8?B?dXNlSVFZK3ZGN2ZEM3NhMWlTVGxkU1Y3NmZ2K2lTSXVObnc2T0JtVWE1a0Zz?=
 =?utf-8?Q?HgIsAtWPrmj96SPAUtp7cMyqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de18f8e-e8db-4b14-d3ea-08dc83ce0e84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:07:01.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaOIGH8srzmzEn8UcX3eNYrL2S4y9sk/v5hFRfcLeHCpJnaX5KaCwcS071N++V4yA6BdzCOyWY+njREDapCYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

On 6/3/2024 3:56 AM, Borislav Petkov wrote

>> EFI memory map and due to early allocation it uses memblock allocation.
>>
>> Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
>> in case of a kexec-ed kernel boot.
>>
>> This function kexec_enter_virtual_mode() installs the new EFI memory map by
>> calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
>> in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
>>
>> Subsequently, when memblock is freed later in boot flow, this remapped
>> efi_memmap will have random corruption (similar to a use-after-free scenario).
>>
>> The corrupted EFI memory map is then passed to the next kexec-ed kernel
>> which causes a panic when trying to use the corrupted EFI memory map.
> This sounds fishy: memblock allocated memory is not freed later in the
> boot - it remains reserved. Only free memory is freed from memblock to
> the buddy allocator.
>
> Or is the problem that memblock-allocated memory cannot be memremapped
> because *raisins*?

This is what seems to be happening:

efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
EFI memory map and due to early allocation it uses memblock allocation.

And later efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
in case of a kexec-ed kernel boot.

This function kexec_enter_virtual_mode() installs the new EFI memory map by
calling efi_memmap_init_late() which does memremap() on memblock-allocated memory.

Thanks, Ashish

>
> Mike?
>

