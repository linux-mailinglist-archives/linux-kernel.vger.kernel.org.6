Return-Path: <linux-kernel+bounces-564588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDFA657E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A143B5DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E01A0BF3;
	Mon, 17 Mar 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P/e6aWi2"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3514198E60
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228568; cv=fail; b=tMWbl/zGk5GCoMrc5o0KwGvKALHE8GBfQtvLenH1laz3ccFQBfL3JdmXs7tcMdT4AgufaU9HGjrjNrMgtavn318sqGo6wr/gUyjttkl9SOBtAysmAyhicmVhiNmfj4DMsLxIeh+lIZm9mVlbj3lvRScbt940wBwBR/7pQoHqiaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228568; c=relaxed/simple;
	bh=r4txw4iuAvo4NmfJdXIdnwb7LZrfVP+E6gekaLkRLL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uvf6uT8kslr5OZQWZpFvIKj3tvFkXKG2FY6ZcslzTawWvCggzSKHjMCSS8HKi4Y8lgqtujBrPd5/XD7UlaGPy55YVNPTBf9sBwjYS+cbn6bjOmknUYhjo5UuTVTJLNSsktLK2/blVygjofhaSDJ4Hfpm6+yOZG2p6IZSA57Omro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P/e6aWi2; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceyAHoLfffeBnKQzGna9l7nlICWcmSzPV2c8+auAwlvW/pJX6PmPu71gjPp51zu6i+RrtRNK9iVBWW6KB/R64nSd2w/tSwOKU2XZkhKJzkvedWISRQn8VCJvx7dKBDZTGWU57ONKBG/lGrgFQC0yBg1OmRB68d8jV+Jo7JUUJ+N0Kk3rb7hhV4C3vhFoGRq170yBxjdnQ1FTQn4uLSvTrDxngdduHW6TLzG//gy0Bh0JeVvKEz6tlfDLOEUo5XvMnztXQQEwDhvBMB/uR7bTnuReNBOWNPK54U8ytGIn75gdxean+UwwviwYp49r/BYituA6vn/SpQOKVke30L/B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdemhakiD4CB23LOFB71gkk+1pMf/9NTKPseKu8x9g0=;
 b=kgfGzEFZBWWplN+cu5xdPQrrb4UUoXPipJ7DQekjEi3H1AY8S2n6pP1QVV7dOb0KJ4OSlt5g/gltvuXqyIoNtwEjxaCTDQcYZlwl6EV/bKorTgMYpyBZ0pdTAcjLx69727l5o2ZFW1jW5TGBRO/ADgTyY42LpxgKj6rwxyrkrCZf93oPBz7cmj0GZ7Fa2dOMOyPRnNDANApQDqZtugTey+6bfmTi/P6ih0bHOpidhss7wIkyCmShwAowvz0Xc8QHWCTDoMn+MdVbk74HVN4AQtfqdzyOKuFA8UZludXl1aydI/w+j5In1yFugxda4asFr62MuO3bN+ACG8eyUVMFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdemhakiD4CB23LOFB71gkk+1pMf/9NTKPseKu8x9g0=;
 b=P/e6aWi2smCTMllDBWQY6KIHUIo++8YyvPRWFMPr+PplkP8Gp0uSM709bNSHD9TteP4H24aQmcaRFZJfPeUfJnPf+WW6pvhphhJ3y2Atsq2siRMn9w2R5mInoOHlZdqAwXJ9mpaJkYNENWwxWnBa0X97j2U+fFWgPXIME9yLMiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:22:43 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:22:42 +0000
Message-ID: <038d0332-2146-4bda-adf6-03ef58dcc3b5@amd.com>
Date: Mon, 17 Mar 2025 21:52:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <20250313164430.bzkfyqmx6a5dj7d2@offworld>
 <b9965654-af90-42c9-8e4b-b29621d11ea7@amd.com>
 <Z9g6JIAPZof2eFbJ@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <Z9g6JIAPZof2eFbJ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 51071a6c-85ee-4de8-c099-08dd656ff195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjAzcERjYjJncndWTFhIUEZYN2xrM0FybUo1WitMeTdGSnZsRmIvSDJqTGhz?=
 =?utf-8?B?eklEMzRVY1pzUVIvYzVIa2s0Tnh3SEgwVktTQit5UEcxdlQ0R3lKVnloZWlV?=
 =?utf-8?B?azVmQ05OODl5U3JVeEVqOEZKTVRuVG9GaDFZbmVSQmpMc05vcE0rZHhMREFJ?=
 =?utf-8?B?alRCTk9LWGl2MXNEaTFLSWFHbHAvdXlZdWpmRENsc1lMSkJjUmsvaS9LV01I?=
 =?utf-8?B?SGk4REcvc3dKcHBOaTRsSStpKzRKek0yNEhXOGMwQVBnNTdsNHBXZ1I4THlE?=
 =?utf-8?B?WldBWEFOSVhhSmdWdUkwc0dGZHMxSThsckdWd3NMN3ZZT2hMbXZyRlUzbVdQ?=
 =?utf-8?B?REFCd0J5UmwwS3I3d0VOd3h5aGszMUEreDhHL0FnQlVrZjZuSFVhcUpUVkxO?=
 =?utf-8?B?VkRHaWFnTUZvSDF0dXNkYk5jVEwvR3lDSE1HYjYwRUNqeWZQRTNwM2tUT2dn?=
 =?utf-8?B?WERDTUlrUXhEbnVsa2dDa0draHcwMmQrYmlnZ1dnczRrNVlVODQ3ckV3dXZI?=
 =?utf-8?B?YS9acmdrak5CMDRjRVFnbHhNUmZnMzNTc3hjQUJxdyt5R2hTNFZZZXREalFJ?=
 =?utf-8?B?Y045cE1NUFRjUkRYTmd5UnZid2VMa25QUFBTT0RqT3RVb2RlY2lSQkkyZVkv?=
 =?utf-8?B?ZWQ0SWhuZStTSW1pbFkzMm9YRTRMVUprS1dBQ0ZXdmVOeDh3Mkw1UytwMEFD?=
 =?utf-8?B?MXRMK3JBMnJ0UlVVaXRUSTNuNHpHUXNlYUlPZHVaQVI1Q3ZHTUlZa1ozQnlC?=
 =?utf-8?B?TFQvTWtvV3JOQ1VBNFd4bTVTMUVvcGZHNlZrMHViaS9EN3RRc2VLSW1rRi9L?=
 =?utf-8?B?QnViMXhBdzNpR3VMNlRPeVlRZ0kyTUhJS3FueTN5dG1XSWEwOFMzSzBUMzlz?=
 =?utf-8?B?UU1UM1MxTmllSWRMZ3M3SFNsbThOd2xoNW12SThvalZ2YXNvVThlcGI3M094?=
 =?utf-8?B?REhqdUNFV0dObFhnbGlFWjcvM0ptNC9lazdxOGhEQzJWWm9hWndHY3RYaGdB?=
 =?utf-8?B?d2RzYUh3b0FoL0UxZ2pOSGRPQzRnVWFaOVdkWjVkcDJvQmxYZjh5UGQ5TFNl?=
 =?utf-8?B?aUZLSWVpcis4MXp4TWRXekQwdmk3ckZOTFp0Qnp4TmhRNHVtWFBpelZHa0lu?=
 =?utf-8?B?SEpvYmlSeGVJWVJwTEFIUEx5aksvK2lLUFJnQnZTMjBtK1Y4cnpjdEVUMnoz?=
 =?utf-8?B?NHhGU2UzZkUvUytpK2p3S1FhOStHZE4vM3lPanVmTUROQUh5N1ZPQUhIdEl2?=
 =?utf-8?B?QXdtQnlGSWJYTUE1N214RnhPY0hINndxT2p4NXo0NzU4VU9Wak5OT29TcFF6?=
 =?utf-8?B?eFpqZnk4U3VkMlo2NEpjTVBZTEQ3MWF4MjJjdnlWdTFyOUVOV1llWnhEUHJS?=
 =?utf-8?B?NDFwbDFjbGZFRk5VTWg2RTZaR1FKQ09zSnBsSmMxNkl5b0IrdzVYalMxREpU?=
 =?utf-8?B?YXVHQ1R3c1RDN3FpbGZMT3ZlK2swR1FBM083TkRTSGtFSEFVYjY5TDZzdDlJ?=
 =?utf-8?B?NjdxTmM3S25JcXJtd09waEpkeDZlQk5vNlBFTzR0SERTNkVxdGlneWQ4TzJG?=
 =?utf-8?B?NFR1Z0NveXhGdHBFenJMbTgwdUtmbXVuR1VIRStRcmFFQkpNUWYwM1VVSzV0?=
 =?utf-8?B?YWVTVHl1L1FySlJQNVVYdzBocmNyblZNa3laTS96T2JwL2R3ZmovWk9ZNDND?=
 =?utf-8?B?QkJpQnNIYVpzY3YyTG9oRjJ1MTRMR1RaNmZSODBTTVJjMi96WDdlbXo5d0lC?=
 =?utf-8?B?cnZsbERCbFloZVM3aWNGOHBrcExkbDhMdVBJcnRsNHQzUUcvZFdqR2JpRDZa?=
 =?utf-8?B?Z1VSOTRYR1NVZ21Mc3VoL3FnUFlhOFdhWDBGY1h5VGMzTlc5cEpjUThYT1Y5?=
 =?utf-8?Q?Q4bbXFib4o/di?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGx1SkFrN1puMXBZVHJUUzkvbHZ4STI5SXlwd2VySlp4NzNSQm5XOHZ1TnJ0?=
 =?utf-8?B?SjhlcWVWNHBCUFd5aGU0QkxjSTIrWk9oZWMxelZHeUh1R21ZUW9DWG91STc1?=
 =?utf-8?B?cGhlam1mME1rMzZxd1p1MlJkMURIYW1vY1V3YmZ2NitzcjZHaUoySWV2TXdh?=
 =?utf-8?B?YXIvSmljZnVENFEzRVVNYXZrakZwUWVQM3V4RXBjbnBWTVJYY21UWkRadGlu?=
 =?utf-8?B?SEt6NFp5N2NGbmdOc2ljN1c5RVRKckxkZjZqOXRNUVZwR0NJMkFWSzg0SkxS?=
 =?utf-8?B?bVh2Ukk0NG5HN2szQXZLRlR5WVJDUEtVME1vQnpvK1NtNk1ZaFNJSndJN0lO?=
 =?utf-8?B?QllJakQ3VnltVStwbWJTQkRtM0o2MjlleFdzVEw0d1Ixc0FKSG9lcjdDZFZi?=
 =?utf-8?B?cHM5NXpMcSt6T0hwMWdId3VhZU91dDFsVzEvWE9LUkhBQmkySjg1MUQrbm5R?=
 =?utf-8?B?QkJob251UnJ5SVNQaGl5SjlQM0x4ZzJOUUM1WnNZdGdxODVnSEhyRnJPeGN4?=
 =?utf-8?B?YVRhVVV5RGRNNHpGWGt2Zk1iQ08vNXNkY1VHUmpUTGs3bXkvSFZoZTNNRWRG?=
 =?utf-8?B?SWQ0Wmh5dEtyRVhqWEFHbXFHWVpCUC9SN3BMODV4V1BkTEwrd0o5UEZGNTZN?=
 =?utf-8?B?anZXamlFSkR0WlRQa1YxalZ0T0dGemlwR09rWVZRWlc3bmxOaEY5dCtIUHcx?=
 =?utf-8?B?NDlQbUZCVlRucHUzbEgzR3hydjBqeWxYWlp2ZXFpVjBTdE5JaG93aFcrNDc1?=
 =?utf-8?B?VE5uWXoyUktManlJY1ZYT0I0TUt1MnN6Z0RVYzZlR3QrM21XRnZFNklBYWQr?=
 =?utf-8?B?eE51VEpRMStFMEtvRlFaQXczelR3YkFEVmVuQVJ6S1NnOFlaeXdLVXIybEh1?=
 =?utf-8?B?VGJITURKWUV5S1JYQlNnd1VwNTUxaWVrWDgyd1NhanJZV0l2RHRPZFVISXNx?=
 =?utf-8?B?dk45Nk9qQ3JLMU03SzRFV0Vjd2x0R0ZtOHNNUXdSNVFLQlF6RUJQNGk4d2pv?=
 =?utf-8?B?SjFzSkxaaEhPaEpzQjF6MGp2MGg1TFdPWERxNjF2aHJ3YzZvdmJidW5IWEVj?=
 =?utf-8?B?TllEb1RrbmIrSFE1OUtiNjJYL3l0cmdiRnU4ZVA4QisvWlpGMjFaYkg0NWFM?=
 =?utf-8?B?ejdkVXArUVNCVHAxWFlDaUhjekZabVJBT004UnlkV1ZUMUJPeU9JaHQ5RERt?=
 =?utf-8?B?U1ovT1ZWZ0FVL3hKamhXQlB0SWhhVUlNVDNTejlyYW5HOXFVQjQzeDhFNDNo?=
 =?utf-8?B?S0JLWWRMU3lFZVdxTUlnTW8vUVBFQ1FxSklPNkRHVVByWk5TaExYMEROM3Z0?=
 =?utf-8?B?SVRpaU4wQmtDbjFmekdDZFdzWU5ZUnE2NUowVFhQWDZDWmVPei9KejJXbnZC?=
 =?utf-8?B?djNTTG5YK0NVS2xRZDR4T2p4MnNiS1ZSNnBCZEJyVVgxVW1YRGpGSTloY0RG?=
 =?utf-8?B?NjhvbTcyaTh2MUxDcUVUMGJhdlpab1FPL01GOVhud1BYVUZHd0srd2xBVXlQ?=
 =?utf-8?B?cG1la3FvamJtSFpXTzh6RjhndGF0RkNyWkV0VzhWbDJGK011UDhHYkFRLzNx?=
 =?utf-8?B?alBNLzFvS1YxRUZLK1lmekgzblphNXBoeCsrM1VVRW44dFhVb3c3dldUUEdu?=
 =?utf-8?B?cjZ0ZVRjbHYvNFpsTE9uV0dDaFJFUk00STZsT0UrOHo2UGIrVWJuMFZuYzJn?=
 =?utf-8?B?dXZub2hEcTBVdlNQdkRsc0ZnTTRELytTd3FMRkxRU3BMQS9QRmxIN3VkTW5j?=
 =?utf-8?B?SFp2ZWE5NVdaUGhNeUNMV3doUWVZUVBiMEZMZlAyYUVWemdMSzExK0trYTJ4?=
 =?utf-8?B?QXJUc0d0c3BjUFE0UC8wMVRoL29oVnV2cmFTcHpyNGJMdXliRG5rRnYvVU1i?=
 =?utf-8?B?MFVGS1J1MHgvY2xydUpOcGx1K2drK2thVXFkQzNXdklGNWE3djJKS0V0ZjY3?=
 =?utf-8?B?T1JsTTVSdDFycTNMZFFzVGNrcFdjK1lXd096TkJXbkorVnJJQXh5SHZYVDlX?=
 =?utf-8?B?b2hpTVRJQ0FYWVJDMTRsekdGNHpNZy9mNVpQZDk2SXhXTitDVlFWVHJJVUlM?=
 =?utf-8?B?VnNDRCtpeTdDMWludEdkdTdMTmVhVVZhZG5TOWdSQjZEVGZ3eU9iL1RxVWk2?=
 =?utf-8?Q?76ZaJzd1xj5kZ7qdxJte79tUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51071a6c-85ee-4de8-c099-08dd656ff195
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 16:22:42.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gbfkETC0UceNv0JaM+l9HddeiNQSKIJ47mzGmR4vBvLEyQ1iN7iMqDijfB9cEy8VTTni7Kp21rTCWwiq/ESFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934

On 17-Mar-25 8:35 PM, Gregory Price wrote:
> On Mon, Mar 17, 2025 at 09:09:18AM +0530, Bharata B Rao wrote:
>> On 13-Mar-25 10:14 PM, Davidlohr Bueso wrote:
>>> On Thu, 06 Mar 2025, Bharata B Rao wrote:
>>>
>>>> +static int page_should_be_promoted(struct page_hotness_info *phi)
>>>> +{
>>>> +    struct page *page = pfn_to_online_page(phi->pfn);
>>>> +    unsigned long now = jiffies;
>>>> +    struct folio *folio;
>>>> +
>>>> +    if (!page || is_zone_device_page(page))
>>>> +        return false;
>>>> +
>>>> +    folio = page_folio(page);
>>>> +    if (!folio_test_lru(folio)) {
>>>> +        count_vm_event(KPROMOTED_MIG_NON_LRU);
>>>> +        return false;
>>>> +    }
>>>> +    if (folio_nid(folio) == phi->hot_node) {
>>>> +        count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
>>>> +        return false;
>>>> +    }
>>>
>>> How about using the LRU age itself:
>>
>> Sounds like a good check for page hotness.
>>
>>>
>>> if (folio_test_active())
>>>      return true;
>>
>> But the numbers I obtained with this check added, didn't really hit this
>> condition all that much. I was running a multi-threaded application that
>> allocates enough memory such that the allocation spills over from DRAM node
>> to the CXL node. Threads keep touching the memory pages in random order.
>>
> 
> Is demotion enabled by any chance?

Yes, I thought enabling demotion is required to create enough room in 
the toptier to handle promotion.

> 
> i.e. are you sure it's actually allocating from CXL and not demoting
> cold stuff to CXL?

But then I realized that spill over was caused by demotion rather than 
initial allocation even when I used MPOL_BIND | MPOL_F_NUMA_BALANCING 
policy with both toptier and CXL node in the nodemask.

> 
>> kpromoted_recorded_accesses 960620 /* Number of recorded accesses */
>> kpromoted_recorded_hwhints 960620  /* Nr accesses via HW hints, IBS in this
>> case */
>> kpromoted_recorded_pgtscans 0
>> kpromoted_record_toptier 638006 /* Nr toptier accesses */
>> kpromoted_record_added 321234 /* Nr (CXL) accesses that are tracked */
>> kpromoted_record_exists 1380
>> kpromoted_mig_right_node 0
>> kpromoted_mig_non_lru 226
>> kpromoted_mig_lru_active 47 /* Number of accesses considered for promotion
>> as determined by folio_test_active() check */

However disabling demotion has no impact on this number (and hence the 
folio_test_active() check)

Regards,
Bharata.

