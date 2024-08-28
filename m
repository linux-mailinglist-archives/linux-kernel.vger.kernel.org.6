Return-Path: <linux-kernel+bounces-304584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E300962223
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86312865EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764415B546;
	Wed, 28 Aug 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="4yUTY5Ph"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD315B0F4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833061; cv=fail; b=ptk/jgvoBxzLd32GdsOdbl8x7Au3Gx5fY9gB6elwTr6QEfSfHQ5oLxrGDLZK28w0jEK1uM+H4z5OkOxUv1V2ETItOEQ3UWQhLomCr9SFa7CbLB52LjIvz34bDadm3AWEaoqgOBFdVpIuLNQKk6mRfnHLg9cDIxLPPh/cChOvQ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833061; c=relaxed/simple;
	bh=BIDzsyjziHUZYdMZDbNo3QfFvnAOSV71rFgtN29IOUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nh57sovZPf99hB/fKaXiZzJHtabMBnz3bJIN0TSvt4NjA+uy+EKkjy7SPmVHcKuoBVnpArI+y73INDpv80UIjIisy8kbr2pDPgdy2BczeUP+WJ7OX9VrqWO+v9wrfTS1Zi4Q2yFiDsvonYRy/qsdF63p3QwmOo7055CY9cxLdig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=4yUTY5Ph reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKT7KLKNhpFelfXEO+4m/bbbj6iwAjkPn9rIETQcCMb1eeJhxk5rHIu/l6ev3gCmtVui/HpeJEygR3aoOTwCnzmL95RB9U+ZbMaFVQeKojxH1XboITF5FjSyCqb2vYRIFtMLjgytg5dbeTaK53mo3pvHqkbdwV73ZZ0oU5UVODFgaKDVEpdyPPrh7IXBUqgqMCyRLp+DdEQoBocRjaZA6x4m2qt1UqoJH1xWRe094fJZgJ958KQRLCOttHAGj0rpExuLiFAVUoIOUhlDsjxcqju4ev7f1hoiShe82sx8weZyagPk4k9TPeLOPtfpjgH8/3jldapa4HOTZy5TBAPiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIDzsyjziHUZYdMZDbNo3QfFvnAOSV71rFgtN29IOUA=;
 b=Er8b9S1CH3Yo69oeLeyZ+raFCXmnfPiEoNe1BQk2rQcDfU9MgQ96G8toqyYx1PBap5I8I7hhPt0Vz1XpZ9bS/4mkZFTcfGY8E/VgSRtXKqw941KR+99xVTqpa8W2snBkzTpybCzs3hWk8EycMpUqzu+0tkJRU/jGeIAx/U/TssepIQ4KgItDnn7ZtIu0EC9V0uztFcqbac6bxOMN7zaPp9clnqZZpGRaPkC61qLaoMq0BTrhb0jPBsRh8kcyeYGciFCk5bd/hyjw5+5yoYouVqejizpapVMiM5i6+1t+zaQL7hcNY2IaLmuAvuKouJKg0fI8OLx4c2vLtwlGHMTK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIDzsyjziHUZYdMZDbNo3QfFvnAOSV71rFgtN29IOUA=;
 b=4yUTY5PhTI1L3pjeZCQxt+h7RFpVs+bWxjTCVhFXWD0SYYj5xTlQpLO+o0n5qEZfKC5jCfsC+vm2UG8spujUE9pIDKHaylume0+9B5A9mqn/1tARa1mWk9TEr8+5VfvmKBgDX9rQ/2Qi+5MCv7hRAj2/C31aa78dPZgdzWuYTJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL3PR01MB7026.prod.exchangelabs.com (2603:10b6:208:359::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Wed, 28 Aug 2024 08:17:36 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 08:17:35 +0000
Message-ID: <b7dff445-2efe-4661-982d-cc71c915db84@amperemail.onmicrosoft.com>
Date: Wed, 28 Aug 2024 16:17:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: fix the bug in dl_task_of
To: Juri Lelli <juri.lelli@redhat.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, patches@amperecomputing.com, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 vineeth@bitbyteword.org, bristot@kernel.org, linux-kernel@vger.kernel.org
References: <20240826021115.9284-1-shijie@os.amperecomputing.com>
 <Zs3NHRmJ-g6zKl5x@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <Zs3NHRmJ-g6zKl5x@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL3PR01MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: a24cb620-1915-40f0-501e-08dcc739df1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LytQSlYycm1YWUJoRW5iMDhlSUZRUit6OXZMcFNTT1NHNVIxNlpyd1dhRlY5?=
 =?utf-8?B?N1BLZTcvL0I3VkFaYTNGQ0FtbG1FVitKemVtS3JGejFFdVJMb0drYXhJSHJo?=
 =?utf-8?B?NU1iOUExbzJWdWVaeURZMlZkbWtTN09tWEhhT0ZEaFczWE5OWHI4OXU3SEFU?=
 =?utf-8?B?R1ZGbURlUWxGdFZRdFY0YURuQUlCNGhaRzM2RG1JNktTMkpTZTY2Y1pudGdD?=
 =?utf-8?B?NjIyb3dlUElRRlRuVXhua0s1blRFOEp3TUhJS0dxZHVSYldSWlFCZDRHM21r?=
 =?utf-8?B?ZmpiVXhKU0JSb212cElhSDNBa05HbWIvSnhMM2ZSWGhaZUhzdlpVMHhHQlk5?=
 =?utf-8?B?d09VVmZ3ajFIaFpUOFRlY1B2TXBTSVM0WWlpTS8vc2RhdWRsendLTkwwUHY3?=
 =?utf-8?B?NnFkUHE3dnhKM2QzelB6Q1NPSGJPT282ZFZxaDc4TytGR3U5TXZScjZIaVg4?=
 =?utf-8?B?azFOeFQrVnY4TVQyQy9sdTlqYTZxdzRrblR6VnVzS2txOEg4M0ZJelBWS2hY?=
 =?utf-8?B?cHZENkV4WEpZekNiYWZzWTBjYi8xZEVrUkVRa1ZWanB4THp3UG9lOU5lSGdq?=
 =?utf-8?B?Q0huMnA4ZHV0WVF6RWFNeU1nZ1Jxb092bzhlektTeVY3eWJ6eWVTNDRYdW5H?=
 =?utf-8?B?YmQyZ2JUR2pROHE4RzFHbXROaldzY3FTcXRtMkk3dmNOellhMmJBeVRvMkV5?=
 =?utf-8?B?cWFKV1YxVUp3bFRrSWl3UzB6UGs3b1VIeFBTVGlkaGNjNUFXRVBpTzNqSDRQ?=
 =?utf-8?B?Vm1BajlTbzVDOHF0aHhQVFhhVTEzOWROdnlRWk8yNENQRlBOSzJNNG1PTlVY?=
 =?utf-8?B?ajZ2WUtSOE0rWmZ2ZndHZjFNNkdaUHJ3c3g5NnV0WTFBWFdkTUVzQ3NUSU50?=
 =?utf-8?B?dmVDSkdVVXJoK04rWUVaS1l5WlRHSEpIQUxzNXFTeG0rQWs4TUNJU1YzWk9G?=
 =?utf-8?B?OTI0MGwxZGtxU2tJcWZUM2U2OG10TlBhZS91cTJrSit2YjFYRkVlZmNpYU9j?=
 =?utf-8?B?TXpzcmxPMmROenNYWDBSeEpyVjRjSjBtbkRlWlphZU5rQytsSkJpVmgrdjJn?=
 =?utf-8?B?Z3hkSFlxeUlTb2RCdngzRFZCcitzQWk3Yk0ybE55SExMMkh1MDdNSFB2Z2I0?=
 =?utf-8?B?UjYzYzVZWk1xRWF6alFvRzVkOVltbTFGSmJ4UTNqTmQvU09HVkh6YWNNOUMr?=
 =?utf-8?B?bFZWTnM4WDlreTVNaVZ6QWFQdHg4T3Q4TEFhR1lUZEN5OUZPYzVzcXVFUXNF?=
 =?utf-8?B?MUhpMWIyUU9YRTZUWWRaV1RnaGFIdHBwTHlnSHpneGVkS2FFaGNON25oVlhw?=
 =?utf-8?B?akJyRlpKYmp5UWR4bHVucHRJYjB1MktMdkZmRVhNRmczTlRTRU1XSTQrQmZI?=
 =?utf-8?B?RWJ4RHl1dHVyeCtVaCs0SUViWkdMM3YzVVV2QTMybEQ4UTVWSVp1cjBSSUMx?=
 =?utf-8?B?TnhIM0crSjNFbDIwNy9oUDUyZ1E0YTFBdmdqajUvUmdVUzRmcjVjZStqckJu?=
 =?utf-8?B?UjZ5dnpvdzgxMk8vWDdXNjNrcnIzYUhveEhIUUVySzA3WkhrVER2OENVNlo3?=
 =?utf-8?B?Y0MyVXpOMWVUSjZuRUg3a1o0Sk5LbnhKOEplK1NEaGNhc01ZK1RzcTFONmp2?=
 =?utf-8?B?aEhMOFlhWXA0dzd3bG54QzB4QVBOMWlmTElVUU4yZmdCS2RBMThpdDY1VTlv?=
 =?utf-8?B?aE9hRG1PNnY1MU83aEhxSWNjUXEzeDBldTZYc3YxbW1KMVB4Ui96WEsrRjhp?=
 =?utf-8?B?ODl1dUFMeXAxbjBaVHlzZ2p3bnZyS1lVMUxGMHFZTi9LbFhjUXRFUEZmV3I1?=
 =?utf-8?B?MGVHYTNiaTYzdlBVWjV5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHFYcWZ5c1FZNWRmWXBQYVB6Z3l2QThuRmljMXFvei9kYS9PcDA1YkwxUmdv?=
 =?utf-8?B?T0Z2RWpUYXdLQ2NMaVlqM1FkUjRMNVNQZkwyTU5KNWtHZXFsSWt5Z0hITEJa?=
 =?utf-8?B?cVdjVHNJMUw5VzBkUk51NW00VG1XY3pQVnpaTFV4ck1QR2JiQVFGRVo5WUR0?=
 =?utf-8?B?Q2JyNFByWDRYNjZreFhJRE55ajM2MGMzOTBQZzZqakNPSlkwVDk3d2EzZ2R0?=
 =?utf-8?B?VmJmYTVjWjl4T25GY3IzZkhUSS85bU4wLzI2cHk4eUp2QmVUNmQ0WkpSSFMw?=
 =?utf-8?B?eGlKc09xTUU4MytCM1l3K1FEeWw4KzlyRnRZR2ZURFZmNWUxRzk4cER5OEdh?=
 =?utf-8?B?d1AzbTVjVlJNb21FNXhJNzVQZDFyaEcvdi9ueVNkaTFqd2h1Wi9oZHdlazZv?=
 =?utf-8?B?TDBrcFNUUkRqeDF5ZklmL3crQWVVaDJDMW9nT0pHNzZ5bWgxcVZmS2JXalhW?=
 =?utf-8?B?WFJwSXh3YmVuT1ltR2pOWVkva0IzSEY4ZjVNOFdRSVMvZU9SMkF1YmJLMytR?=
 =?utf-8?B?N1o4SWVNek1CWTY1NFVoZW5xUDJIdUVsTldpVHBIbHprL0xHbE5jMHBxWThH?=
 =?utf-8?B?UnlRRzVGdlRnblpOa21BMTR3Z2kwTTdYVS8vSFJGT1QvR2d6N0NucXBzbFd1?=
 =?utf-8?B?RDBKU3JDUGRnMTFmNDZORS9PeFlKZSs0cFNOaTFGVjl5RHVhQWtkUE1DTDN1?=
 =?utf-8?B?VWc5cHZ0a3NnN01LTEpKc1NzNmtmNzJkUTRycUVmektkdUkvMUk2U1RPVksz?=
 =?utf-8?B?ektWNjlCMm5JMGtoTkEwZ2kwTGNkQm96Z2VlYzVVVk96emtrbVVoNUNDVXNX?=
 =?utf-8?B?ak9PRjdRWXh0UmJpUUkxOEczT1k0eFFhVm50dXZzc3ZkU24yU0FmL3M2SkZ0?=
 =?utf-8?B?czBab1RpWm1HVzBQSlQ4RFR1SlBobE5LWmgwVFBCRzRTL3VBK0cyUWU3SGd6?=
 =?utf-8?B?NjRneG5ySVpyWDhLcVhsUmpUcjdQbU1xb1lSa09oTC9OTEN6d0pIOEdERjhM?=
 =?utf-8?B?T2pGbFZBNXQrSzl2YWFDTkkrbCtnQ0xxbmVZK1NkNDF3OXNvLzhFTWZST0E4?=
 =?utf-8?B?Q2xINnVDak83cVk2M0RSMG9xKzg3c3J0dUtuVDdmcWhmZktwcjJrU1MraEVv?=
 =?utf-8?B?QnJhemxTR2lxRHVTRTZRZGJ3MUoxWENNak9jQzFrSmlVSzJOZGpBb2xLelNk?=
 =?utf-8?B?dEtkU2FabndvVzBTdVE4WWxZU1ZYcHhmTWEzYzVNV3BJM09iSHZIUzN0WFpB?=
 =?utf-8?B?NWlYL1h1U3U0OVBIRVpOTUVkb01FdzRndlRYbXRBMW1Jd0R2OEN4aVZKZ3Fj?=
 =?utf-8?B?WHovSnovQVBtUTNiZnZsM1Z5VVRhVGFTTkZ0QjV6bi91NVJUWWIyckg2bHpJ?=
 =?utf-8?B?dFhzd0JEQmdnOHFWT09pYWhuL1NZaXl0N0tjUmVsRDl5WUVpbEFYVmFiZWh0?=
 =?utf-8?B?R084Q3VGNjQvTS9QaGhMRFhqY25sUnp0SncxNjBnWmpyMDhPanA1dEw4QW9T?=
 =?utf-8?B?Vk9YY1RjUkMzZitVci9NM0VnR2hkdFRmU29FeWJnWGFkdE9iMzhQb0YvYTkr?=
 =?utf-8?B?bkR3TWtEZGh1QTNyV0pFaG1hWmgyZzBsS2NGZU1oU3NHNjBQa1hjTmYwOFRH?=
 =?utf-8?B?ZUZlTTM2Rk9keUk2V1BRSUhWWUp1a1FwNkZJWEpZSnAxN1c2cFJnaENVSFhG?=
 =?utf-8?B?d2M5MHZMUHNkWStKUXhEQWxCY0c1QzJVQmRNa01PSTRKb1BLQ0EyazRhWW1p?=
 =?utf-8?B?eW5tNzB5VXh3YitPNkRpWjRVZlFPcGxnY2tYMFZYS2NseUk4b3V2VVJVODdk?=
 =?utf-8?B?MmdGb0lLTEdQd1NaTHlPaStEV1prOFdpeVExc2k4enJIRUVjWkl1QmZ2UElM?=
 =?utf-8?B?aUQyTHZEeFNRbDBXWkl5L2RWWG9TQkxadXJIUlhRNUxDUVRTbDJzajM1dWl1?=
 =?utf-8?B?NnAxZUZSVXBMWGZLVVJ4UENHWndoSElHakZIZmEvSkxYL1k2MXEvL0JmK0xm?=
 =?utf-8?B?QTJsL1VNMkpWb1Q0Y3F6WlFPTEhya1JDNVZyMGtSVjRMeFY2MTA3RHJkcURD?=
 =?utf-8?B?YXY3eW9scCtpVWlHU0tJcXBDQ3RBMVRsNFd4N1lkbGFYdy9MYmxqdEREcTZK?=
 =?utf-8?B?Zktic2JpdzBGN202NXBiTDNCVktYUTJ1SUNrRzJYUUpSa0dtZzlMczBBeTdl?=
 =?utf-8?Q?QiHVavUNO9WeAZh5AzDar7s=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24cb620-1915-40f0-501e-08dcc739df1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:17:35.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuOiaBbN9nYpXtPhP07glZyWTFIE01ifkUxXHmnq8aUfQ24YBTjYksuPruV4d+SL8gX8esTJ5CLwT+5q0FvQ5nUC/RrjDYoQlm8jdacDwh5KTok9v4i/f3G/PDpwmVHN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7026


On 2024/8/27 20:57, Juri Lelli wrote:
> AFAIU the fair task enqueue (the "real" one) eventually leading to this
> BUG has already had its own schedstats tracking dealt with and I don't
> think we need/want to track anything for the associated dl_server.
okay.
>
> Shouldn't we rather return early if update_stats_{wait_start,wait_end,
> enqueue_sleeper}_dl are called for a dl_server dl_se?

okay, I can add the "early return" in next version.


Thanks

Huang Shijie


