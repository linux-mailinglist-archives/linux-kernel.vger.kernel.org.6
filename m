Return-Path: <linux-kernel+bounces-305608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5296311E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC28D1C22B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828A1AC426;
	Wed, 28 Aug 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i4LYZClB"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9191ABED1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874212; cv=fail; b=IP4nyUygWKmCLXNWr7orHiINem636AonuhWtQGasXmiLmt6Jak6qJ0RJ2rVyU3ra9vLp0SyaZ4ujUquu0NKxJrvl8XcpKbo30wLr6R/CFY7dEWW2nV07zMN3sxGssBEm9VqQZZF5h83Fm56AhfKjBy82CZv+Tmdce1zQCV+91z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874212; c=relaxed/simple;
	bh=jRxrCKE9r58icW3LiOGzCymiUW1q4XO2jwPKgFYG7GQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rRRU9KZ7yyE1C+HxPzn/5CWo0mTWljKMjE6KN7n19l/IYAcHx6f9+bCBcf/nOEVLWOVYED8WcfIkLSpSsAM7nIPyQWYTB9glc9ULK4Mehs7Toximgx5fKTdwj/ezhnS+c9xfN1kTLz7UsyDwwSOFZaWFt0EUkpWyAcL8ZWL94qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i4LYZClB; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFSgkkDnzIrYgcbxjZfDZ1eFL3UFQWxPUPe9bGzaq6x/rA5SMyi/b/zwS9cZTj7+Iek9a1/tplInuuMUmLTh6LyTgFkgZrqk1W8TL0SQO60trW9qbq2O+i73C9hTnU4F8BszSG+kuqvH3T1A9U/ZHgpoSwWN9bBQ96qN9CgjoqPculHVd/JKu/OF94kOKEeaO2+nmVdz4cudCvQbbJQC+E2HMgOgUsoyJbkcUEJfx6da+fdOR/YfA2zB83UNLPgTtg5QedYKN9WAoQoP57+0hEDgfBRsiXAPzRPSjrzywa1aHBADKS+vB3hGVQI3FR0TiRUmqPEugtdWTjwYzIixtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TH8cHGXEYR73Y7z9Kvekytt8/zvHWmgWTutGULM/EM=;
 b=P0qmmgewAkuDDfzaV8AbJvab2wQruCnDPzxy22HMXYC9Xh77dLHjQeGXe1+YhF0/5IvVlQ4VEZ75XTZcTiD+vhHHBdwA1g8veJBaMYgHcLAUdLZIRJ4cyiXH8toRMcnP7+El+elZ1O60JAW124Yr2E5ogyCFQDcjf4Y7HpSrry3C62b6eqqRFE7kpqS0YICuVclfscpsf+YDONHG54sfXr80+UarEbuXltkRPRxMWCLEmgImu7oU58fOvSXCgWXxdCrDXvDQpD6C8FsGngSfEg/XoR21G/T+IWXZjjmKV8sLAFetB64e9IOWL1IpouOuQh2fFVpOIZ+dGdz838Zw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TH8cHGXEYR73Y7z9Kvekytt8/zvHWmgWTutGULM/EM=;
 b=i4LYZClBkRsuEdt/5tGABYOZNMrV5vXfgL68AWI9W9DPlT1+3TE6cj4NqrkiQLPhI8DbLgCuM2W69MXgHG8RzQOASVWKBznhBWhq/u5cIPEl/Et+YHrc4bpEvdNVCUyO2jvnkyhtZGNCW+T0mpadzXFrO7yDXmRys+X35LXaPj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 19:43:27 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 19:43:27 +0000
Message-ID: <e13df309-457a-41fa-9406-22476f9f4e72@amd.com>
Date: Wed, 28 Aug 2024 14:43:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
 <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
 <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>
 <npjx2z3adipvsxngnsoj6hsgk7rxta6ojdomm4tcd42maakuuz@rij273zia5ek>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <npjx2z3adipvsxngnsoj6hsgk7rxta6ojdomm4tcd42maakuuz@rij273zia5ek>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:806:121::7) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a2b1b3-193e-4a1f-1e8f-08dcc799afac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1E1cmU0YlhscEF4K1hsVEtpUmozTERmbFE4UFcybk1mVFFRNElpVm5LWml2?=
 =?utf-8?B?QkpFMVlWNllVNlNxSStGQ1hCZXd2MW1xUCtQZTNHU2hPbFF5cGwrUEdXbTky?=
 =?utf-8?B?YlF5NVVHckxwaDdsTDRtQjNpS3JibUJFQmc0TFNkUEtjSk4yV3Q1blAzb1Fy?=
 =?utf-8?B?KzYzTDRKL044ZzdkWlp0QS9DRDJYQmRGTlJ4SXY1NFl6NytKRlVUNjU1ZUY4?=
 =?utf-8?B?Z05ITnhnRVgrbUQ0ZGVueC9WQlNsSFNyOFc2ZEhPcFFSWUFBZ3REZG1PdXU3?=
 =?utf-8?B?VTlwR3lYTUdPcHZnNUNpeEJYZFhHbi8zOGltdVpWS2lyWHo5UFpXZVJiallI?=
 =?utf-8?B?cW8wdVo3S3dTbU54em9lMUFhSSswVTFZYjhDQ3Z6czlxbnFEMjFnZTJuWlhK?=
 =?utf-8?B?WHhiV3RmSUNTemZpWDFBOTczTUxWa2ZqVitwSW0yZ1NvV1lzdjc1ME1xSVg4?=
 =?utf-8?B?TEo4QXVnVG5WWjhoYlhPWTJ2THM0QS9kZDd0bEpacll6MXFkUUllanAvQXNj?=
 =?utf-8?B?RkV3b2JpVDRGYTkrRWx0RUk1N2pSNnVUSGlHRnY0dlZGR3VLcE1LV3J2Q1Fz?=
 =?utf-8?B?NHphUVBBdUtVNS9JUSsrcGhQWUZUUTdnbW8rMFFCUFJ3SkVxclBuY1JKQVd1?=
 =?utf-8?B?NXBjK21URXNpOVVkckxPT0hGbkNGMW9VRmZQSnc5dWx5SnFXUklkMGZjbklq?=
 =?utf-8?B?MlgwaktUZFpuaXR6d0Q4UHNXdjVOd0V3eFpBcW9sVzN0cFFVcjhuY0c3Qm1v?=
 =?utf-8?B?SFFDOWFpQVc1RkJiL3ZPeERZRUZ5WkhuQWtiSmR4VW1xbzZXMlE5T24vaGhY?=
 =?utf-8?B?TWxtd1diNmQwMlZGWFo3ZDEwd1VSMUk2UDN3eWE3SFJ4aEh4eWRxM1FUbUw4?=
 =?utf-8?B?NEp3MGlhUTFHenZ0Y3p1TFZHbGdsanVENG1pcnFCNTkwUlBxK3ExaFdkNU1M?=
 =?utf-8?B?Kzg5aUlwc290TVIxYmMrQ2VwSm5rQ2l0b1A5QVgxNnpWR1NqTnhxVlJwbVlI?=
 =?utf-8?B?TFIzYXloeHQxTTFZVzlKQ1pxSVdWaGJiL2lsUUxJRmd1UGFjbmZlMnFaYm1a?=
 =?utf-8?B?Y3VWRFFlVXhBekNyTHI5bVdNdFMrVE9WL0dDV1h6Qk00c2FIckx3UGZCV3FJ?=
 =?utf-8?B?QXpYcDdWR1p4Nnk5ODYxdHo3TFhxV1VMRENINExSRnM5K0JwYThTVll4N0hI?=
 =?utf-8?B?bUpiM1MyRytsTDJhVXBXMzBkVnpGNWpGMFhlR2ZXbUVnKzVBVmtBVFRqWXlC?=
 =?utf-8?B?SWZjNHU2VTBtWkJaem9nMmVrVnpDUTEvd0l3WmY3ZTRXNlVldERjeEtZQytF?=
 =?utf-8?B?bEJUKzNwb21NNnJ3TEZSWnRPSzZCRExiTGRuL0pxZ0hNcWV6U2hubGtidlBz?=
 =?utf-8?B?Vm1GMzMrQnROTnBaY2xVMXpzRkE4RUUyQllGMkkzeGUvdTVyQXF6bE9kNkVE?=
 =?utf-8?B?QVhRczVoYmVDNkNWMURnSHFiMnUxYjRhcCtMUnV3QXd4SzZxTmlQRTV3R01W?=
 =?utf-8?B?aXRGQ1h5dU51ZExWVk5LQkFtSVMzc21XZGdiZ2hwZFlydEdyZDNyUjRjU0ho?=
 =?utf-8?B?Zkdpc0FBSlVHdldEUUI3bmNpdW1EOGYwcnRzYVNsZlNQc3R3ZE0xdmtTV0JC?=
 =?utf-8?B?UnRTelludGpxcEFjSWdtOFMwekxUK0RGN0JFdGROZW5aWXpFZWRzSVJ6VUND?=
 =?utf-8?B?Wk5KZnZOTVRHbmZxMHVhYWg2TXYydzNYZGFMaFpMUnB3dXhpQTdYbEptRzdM?=
 =?utf-8?Q?S7qNMlo9vmKt++dmi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhyQzFDMjlHTDVKU0dtZklCVlBhNEZPWFh6MmVJNi9vN0xhejAzb2xveDdp?=
 =?utf-8?B?Z1lrek9zQTBtVVNTMVNaRFpPVENVbzJDd2VXbzdDRDVjYXhNeE5aTmRTaWRt?=
 =?utf-8?B?a0dEZDNZb1h4Mlh2QmpSQ1BxOCtzUG04MTNoZmw1UEJ0VTd3VC9wWGlKUEhr?=
 =?utf-8?B?aTRlLzUzZzRIeURtTlNIa1k3eEM3bzBPMWptK0kyNi9SUU90ZjQ2eUdad3Nw?=
 =?utf-8?B?U0hJbGNXNUVFZ2NpRWk3M1BsQ2JYUGpzWmpYM2RKbC94L3ViR090SmRZTDhy?=
 =?utf-8?B?aDZxb1dzV2lwZ1JGYnUvcDk3bE81NnJzWm5UL0JWbXNpaWRLRUlzL2dsT3pE?=
 =?utf-8?B?c1B1Vk1JSkhyamoxOFVwNmVvT0Frb3Zubkd2MnZHSlV2VnFsVStsa29EdkZH?=
 =?utf-8?B?eUpLTTgrTUgvd3k0Y1Q0V0ZJK1JmRVc3K3hNcVJSeUQwMnZPbmdaUHk5ZFVU?=
 =?utf-8?B?M3NlTVFSdGhaQmJVR0VZY1puRUNLcVY5MGNCOCtJbkxzQ3VZTzc4Tkk2ZEhG?=
 =?utf-8?B?TStmbk54d096QzZJaGxUdkNwNzlTT2RJcVFUL2Y0TkQ4NGk5cnBwZGhFeFNG?=
 =?utf-8?B?MHJvS01QSysrZ2tvRWg3OFJxVFZtNUYxMDdTV2tnTTFFTTFWa0xpVE9RY2Zp?=
 =?utf-8?B?WHN5MDdaNFkvaVZWRTErcmhjRGxzczFhY3N2a3lpRmh2UTlxb1B1Y2ZhWHcr?=
 =?utf-8?B?TENEZm5TMVFjSFNKVlNWQ0hodGRvSjVibkllN2ZUYlBqdUZXZjhHcFUrOXNs?=
 =?utf-8?B?aDRFT3Q1K2F3SGdlUlk5cDlsTGo0WGpIcFhsYjkwN0lTWXdFazl4dW1JQ0JS?=
 =?utf-8?B?ZHVoMmVKUFpiVDY0NElnVHVxMlNlNHZJSndEcFV1bGMxVDluYUx0ZUx0WjQx?=
 =?utf-8?B?dXlIcjRwc0hTeXJCL3Z0MUtCaGQyZGFLZzNwWGtRQm9rRll4QnQ3YmNWTXh5?=
 =?utf-8?B?N05lT1RjTC9NcndRMmI3UVBSMi9kUlhHREFBVDV5MG9nN0RXQU9VT3NKcU5R?=
 =?utf-8?B?MXpZbnUwQjd0WWYvZEpCdkVaQUpuc2d5cEhuWlRsM25lT2pSNXgydFd0a2Ns?=
 =?utf-8?B?TTBkUUJaREUvOVE3THYwSmZDNmJZMzM0enhTRkVyV01oUHVGa0VZN1FERVd5?=
 =?utf-8?B?d1p6dlFEV1NBNGtia3hkeXdtYzRqUndmamNxTlFsY3lyR1hjNHhkOEpqbGtq?=
 =?utf-8?B?MVl6NTlSaXVSSmVBa0pDUVhiQnJ2N2dhdVpqTldMV0hTTHV0a1FwVVlndEVu?=
 =?utf-8?B?UHFrdjlDdFdad0lyNWd5cXp3TkoxOEhkQkg1VXd6eGlTZVREeUxjdERuZlpq?=
 =?utf-8?B?Ykc0N3RnMy9laHpEYVJnWFMvSDUvbGQ2Y0UzdTRtN1FpbWhOMFl0VU1ZT0hU?=
 =?utf-8?B?Um9ad2pvQndBSjNFczgvZ25ZbWVMVUxpQ0FyUHU2OFgwQVFLS0FZdnhJcGRs?=
 =?utf-8?B?ekNtSDNZN09CeXlZVi9tMC9XcnRTY2dqSUhERVk3TzJPQm9UT0ZIT01raVlK?=
 =?utf-8?B?aEhKcEZvdWNZT0IvNERWOXBzaG1jMko3aSsvYnpxM0JFa3gwa1ZxSG5ZK2V6?=
 =?utf-8?B?Ymo4Vm9pR1JBUlQ5V2ZTbjIzdGVtMmZOZW9kbDFqWml2ZjIyNC8wdE5CbTNo?=
 =?utf-8?B?VjZhWU5mVWFHRmRwSVUveXVHRURmeE1HOWUyVzRLc1RneEx6VU4wRFY0b1o3?=
 =?utf-8?B?Tld0TjViOVFFUmpDU0JteWJneUVFbjRyUldPejlScjVRS3RBY1BzRUthL1R5?=
 =?utf-8?B?WWs0M0pYT0RrbGFHTVhsZVVZcEJPK282ZUFFYkZld09xMW85UnVRVTRFcXo3?=
 =?utf-8?B?T0tvM2pxZDYvSHo3T1Njd2dpcXM3RVhkYXJPUENXWmxEOWlSZnhrZ3JKRXEr?=
 =?utf-8?B?OU1RRmxUNDc4N1hKVlA2TExjUkFBWkdBUGEzd1JQWUdNRGR4cmRoWmlWM0p1?=
 =?utf-8?B?RVBueUFSWDNiUXN2eGEwMGdiTFcwNXFPbjJUeElHVlRyMkJ4UFNidlRUVURZ?=
 =?utf-8?B?cGw2MVVYRFRpa1ZPcVczQ1JSalYvaHdHdjc0QU11Mmo4ZndOTGdZL0pvV2tr?=
 =?utf-8?B?L2tEM2RobVg1VnkyanR5aS9JMVFKY0MvTmtpcEtUWEZSZVJXajdpZnZEdzNC?=
 =?utf-8?Q?N2kxnntWOiOCY7GDBkWmw40id?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a2b1b3-193e-4a1f-1e8f-08dcc799afac
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:43:27.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlIcYZkmfACQKGl6ErlmE5PAhu1XImjc1qCnf94qyuw2+Rr1Oj1zT0JeLH3JGWD7cGwU9jRpeWgsuDzTEyP7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

Hello Kirill,

On 8/28/2024 1:21 AM, Kirill A. Shutemov wrote:
> On Tue, Aug 27, 2024 at 05:15:56PM -0500, Kalra, Ashish wrote:
>> Hello Kirill,
>>
>> On 8/26/2024 10:52 AM, Tom Lendacky wrote:
>>> On 8/26/24 07:25, Kirill A. Shutemov wrote:
>>>> On Sat, Aug 24, 2024 at 11:29:39PM +0100, Maciej W. Rozycki wrote:
>>>>> On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:
>>>>>
>>>>>> This issue causes real problems:
>>>>>>
>>>>>> 1. If the kernel is compiled with EISA support, it will attempt to probe
>>>>>>    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
>>>>>>    The kernel treats this read as MMIO and accesses this memory via
>>>>>>    shared mapping as we do for MMIO.
>>>>>>
>>>>>>    KVM converts memory to shared upon such access.
>>>>>>
>>>>>> 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
>>>>>>    table (see mpparse_find_mptable()). However, this is not MMIO and it
>>>>>>    is accessed via private mapping.
>>>>>>
>>>>>>    This will cause a crash if the memory is not private.
>>>>>>
>>>>>> During normal boot, the kernel scans for SMP information before probing
>>>>>> for EISA, and it boots fine. However, the memory becomes shared and causes
>>>>>> issues on kexec when the second kernel attempts to scan for SMP information.
>>>>>  ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
>>>>> `mpparse_find_mptable', complementing changes such as commit f7750a795687 
>>>>> ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
>>>>> mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
>>>>> MPF and MPC data").  Both just access BIOS memory.
>>>>>
>>>>>  Can you please try and verify if my proposed change at: 
>>>>> <https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
>>>>> has fixed the problem for you?
>>>> I like the direction your patch took. I hate sprinkling
>>>> X86_FEATURE_TDX_GUEST checks over the kernel.
>>>>
>>>> Unfortunately, it is not enough to fix the issue. memremap() in this case
>>>> will still boil down to ioremap() that would set shared bit:
>>>>
>>>> memremap()
>>>>   arch_memremap_wb()
>>>>     ioremap_cache()
>>>>       __ioremap_caller(.encrytped = false)
>>>>
>>>> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
>>>> case. See the patch below.
>>>>
>>>> It seems to be working fine on TDX, but I am not sure about SEV.
>>>>
>>>> Tom, any comments?
>>> I haven't dug through the code that thoroughly, but I don't think making
>>> arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
>>> data, e.g. setup data, is unencrypted and needs to be mapped shared.
>>>
>>> Let me add @Ashish to the thread and have him investigate this since he
>>> has been working on the kexec support under SNP. Can someone provide the
>>> specific kernel options that need to be in place?
>> As Tom asked for, please provide the specific kernel options to test
>> with this configuration.
> It is not about testing a specific configuration. The question is if it
> safe for memremap() to map all WB memory as encrypted by default.
>
> Looks like it is safe for TDX, but I am not sure about SME/SEV.

For SEV it may make sense, but for SME we don't want memremap() to map all WB memory as encrypted by default.

>
> Maybe we want a specific flag to make memremap() map WB memory as
> decrypted/shared. Make everything encrypted by default seems like a sane
> default.

What are MEMREMAP_ENC, MEMREMAP_DEC flags being used for currently ?

Thanks, Ashish


