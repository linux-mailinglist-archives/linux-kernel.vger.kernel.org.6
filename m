Return-Path: <linux-kernel+bounces-575100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DC2A6ED88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F1C1896499
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8D1F03CD;
	Tue, 25 Mar 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LydVNRug"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FD78F24
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898342; cv=fail; b=bNaWuMXkvjdKuLxaSdVsF2CPKQiWbfJPjYG2DGsjTxLgthyrjjqXnemCI0+15BaBQSf2lSAc51Tg75iKl82IZiSHzMXTIXZj1JuVc/7rnPb6jkT2ulx7NWH6mKD00+jexsbNny3pF54uD6ChlH4nGio1L+MqzK8otPZvMYDuIuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898342; c=relaxed/simple;
	bh=0x/BOgaSOeY7edJxK9JtJigohq8Mk4UYXuEz20lLVEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZUdcdx7w3AR29IcquTqxfROk0gMRZC+FgNDLGHYBcbt7yj44A953DpmGlJuHRXF+qQGLoEFAaWTmpJ9xQeZ9KdffKXBWVW6xsUTBxgOfYzXRdwKlQ1hWkvZ/CSO0nqCadbkQlcmCcBrrgMrEI9AzTLsyZH4Xzw6XRu9wGeU87s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LydVNRug; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCXiEEvLd+DQ+nglifvzriJKV6hmoeNeKQ2zJyyfwna3HP4VZTIFcoMHMF3hl8tax59FeXkfuGB4DwODbatmSfHy7guNLQVnnQkX9xnbyJyMdiSpvAWBrmv/uv3Sw4UUkPOEU/0OZCQZ+W9jkgi38ITNSKOZ3FVpsj+l9nd1WlUg+5SGPXbIR2QTGedmKqDn/sEQVs9o9I19g+riRT/3L3mfNnq5itfe6S+vXCsBOpyZsmN8aNJ1o7kq4pfAaYf5CR0ieCNLI4F3JZVOBxD7pRm5H6eJhQvvsitwLoQu1pOjridizrityR3nO3yvZ3OySE+0WlX97ulFckPKpScDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NeAQ3G/fMxTa2czmDme8REiptg0L67K/+GwwG4377I=;
 b=oVc7DIKVUiXyGYA6b1Lo6IMZYnflhv7OswCSfGpJNGFk9JJ/Zmetv4fg6oo4usRjc93mtKEdLGnTTmzcruKa9dfZfW77JbWlX1eux6GQ3f6VEjUHKSEMAPBViOISAsLJnPaTuPwTTNLOuzUY0Gk4/ill7qaAVwuZ6bmN1eEgwUuHeRDNisXwtSVT2szIEMlR+5nJSGVYE3DdF7XH/rg3nQ2quNde3pGQj3mPQeMuLA5+295a1EdaD3Fqhkza5T32E/ofnvGUPC6txo9C2ey9Sx2y13seLW7t0f84W5+yHfltusK2RVe7pWQyUmYV3IBpzgiCgFsBCqv6fGF5t63E3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NeAQ3G/fMxTa2czmDme8REiptg0L67K/+GwwG4377I=;
 b=LydVNRugwx9kaf3vKd6V7NocavQO2hnpeGabk07Yb0+E5SWYlLsIZ1M5z642aRPs72VDd4se+QsBpDvB961FrNvnHI8OIgF3pBK+/2wh3BffdqHM1ts/LIta+pHs3ZTODLKRnekwHD/SDx5Qo3A/RHQ/2HQPh2F5JlJJMTvL4Y4W9viDZC2aG7mDwFgL46Uy4EQYAfrE8HgAVjIz4iZD3hgjT3znTgrnlR+oHF23qYBYs+nEyUSlUfRsK1O0rSXpbJdre/UrKSAwSVdpSOkvflQNxK5UOQsNIzzwbbA+4MuIOHxP9/RU6L0fLbp4D+7OZHhscmM2p4fqMQCT4GlQiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 10:25:38 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Tue, 25 Mar 2025
 10:25:37 +0000
Message-ID: <16501a89-65f8-4750-9b99-f8fbcbfe5e3d@nvidia.com>
Date: Tue, 25 Mar 2025 21:25:33 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250324230712.4122-1-spasswolf@web.de>
 <634e77d7-4f3c-4d1a-8aa3-1978896f9bf2@amd.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <634e77d7-4f3c-4d1a-8aa3-1978896f9bf2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 153c5570-6e44-46e1-18d4-08dd6b8762c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2cyS3kxNE1UZXAyRVRjSjlEQ1BldWlZazBnZ3l4TDl3TCtQSFdxRUpMOHBP?=
 =?utf-8?B?MnBrUjN6cjhzcS9zUG5pLzQ0MG16WTN1bW9UVXlUUitIanhZLzcxS0hkblpt?=
 =?utf-8?B?NFY2Umo1LzJGOVFwUmJncWlUK09xdlhwRXNjQStyUWdua0pMM21JaC90SzJ6?=
 =?utf-8?B?aTdrcElVWTlrNFhPZ1kwMVJnOTljRU41MWs2U1BnMHpUL3Nld1pwS1dub1B2?=
 =?utf-8?B?LzVMZms1aG1GelhVMlRZVGd5RWpiM3RQUUhKVUhCaDRlbEdxTXk1aHBjRTdq?=
 =?utf-8?B?UldLNHppaGdGQWJQbEZHUHdmb1QydFo1OVZJd3pnYTRDbC9hK0tLeTV6NjRW?=
 =?utf-8?B?cUFDU3JqaGlsd1FUWDZzbFMrTnMxQnl5WmdqMWIxeWV6UTgycVBLVFd6L3dZ?=
 =?utf-8?B?S0hWUzl4YVZNQk9IcXhlV2YzZFN2dEl2SUNoOGtjYlhoRmdFZjFhc3hLYStV?=
 =?utf-8?B?WGJvWlpzSnN6OE1GelVHL2o1ZE9EMkRVZUlmVGRGQzlHTVQyT2pXQnRPS29Q?=
 =?utf-8?B?bFBnTnVPZVlULzdnaVlNRFV0RVE5eS9Zb2lGN0ZGWGJhY2xDdmR1UkRGT0Zr?=
 =?utf-8?B?c1VwZ2IzVHoxeHd4R2F0cUVCcFdzNkpPa3VnOTFnd0VzMUZqdW4vbXB5amhy?=
 =?utf-8?B?MzNCR3A2cXVidktzQWRTbWNmWGF3aUtvRXQvdnZoazFmblZiQS9JTm5uUXkx?=
 =?utf-8?B?ZXlzb1VQdEZiSkRvbkpMNU1PUjFFZ3hZQmN2YWJtL3pnUFB3SFVhY3IvY2tp?=
 =?utf-8?B?d2pCdzBkZ0JQcnpNbjJRRE5pTHlRbSs2V3FQSTh5S2pOTXdOT0d2ckxvUUw4?=
 =?utf-8?B?SjNCdWVEMzRSczhrM2FWVlFzaGtPd1NOM3ZqS3hnc3UxWnh1UmZtU3ZTSzhD?=
 =?utf-8?B?eUZVOVYxNjhqeFFnNnNZbHVieG9ldGJCaEZXTHgvZXRQNU9tS3lScHpBcEly?=
 =?utf-8?B?L3Z3b0dzRzBsSE5xZHVpbWt5Und1cjNqaENFc1FyR0lKZVV1MWp6SXNXNVli?=
 =?utf-8?B?YmZxTU1HUW0xMGpNbFpmR3A4ZlFZTCtoMWJCcDZieEpSbjVhN0hLd1JBQ0k4?=
 =?utf-8?B?WWNQRG0zajRkVFhPRmtBTTNxa09vOGhRVXBtU3Q0WHpHdWMzcEFSaGVhM0F1?=
 =?utf-8?B?VlExZGpTM0JrMlVvRXZZcml4N1MzVm1oTUI5Y3pBZHplOFpqcHg1NVFrUFQv?=
 =?utf-8?B?c3ZsVlZoYlE0dHZWQUlEN2xGVndsTEdEUXRmdHJxOVhKL3Nsd1crRXpXMksz?=
 =?utf-8?B?OFFYT2g3SjVOR1gyMlMwQmNoU0xCK0NVRVk5c3VmMUNaMk9OdU9oeVN2NFJS?=
 =?utf-8?B?MHBJQTBXSE1odTF2Y2VKeWJHQUVMb1BBWjJ5WDBHZ2RYRk1md0Z5UHN5VDI2?=
 =?utf-8?B?NlE2aUYrejFxdVYwYWF4dkNTdndkenNNNFpsbnQzbnE3dkJ2RFlFZ3RjVVdL?=
 =?utf-8?B?NTNrYmd1SjNobnRlOGdYL2h3bFdsUzBMVVJFOHVUbGZRdklKdkk5Y3A5WWtO?=
 =?utf-8?B?YjVNZnQyVTNMZDloajlWUTJoNFJ5V1ZaVmt4dTVGMXhrTm9TTGlhdlkwYkpu?=
 =?utf-8?B?Z3NxSjJqbTNIZHNGemZVUlBOS0poVFBSb3plMlpNbTdXUlk4MFBod0NXdVRx?=
 =?utf-8?B?d2p2WU5LU3lmaTdVTDMvRVFrM1dIbGNkdWJZZWtxKzNjU0RpOGo4M2JmTnkz?=
 =?utf-8?B?czFScWdYWVM5WStUaU04NGo0MThMTXVRVzgwNzk0aXFWT2ZxbGllOW1XY0Nm?=
 =?utf-8?B?SFhITCttanBhT084R2dpZ2tJMzd3aW1OeHA3TVVNNzcyUnozditCZS9vRnJz?=
 =?utf-8?B?VldGRzc4UGN0amQyQlV3Mlh5S052TnB1dVBDMUdTWjlWa2FZekRHMXVJZVZE?=
 =?utf-8?Q?Gl80S1wgy6ejX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2trS2hYdThaVFBITUY3dFdialh4WXJoVTQwZWk3WDB4Q2JnVjQ1OGl1WHRu?=
 =?utf-8?B?bmVEUFFNZHRiaWxGbzhObHJGYTFhazBkdnRCbHorbVVaNndiZkM5S0NpUHIr?=
 =?utf-8?B?ZFBQUkZ5THN3cWQxVTJ6TGIwZ1V6dmVGSWNZTDFWUkl4dGYrdW55VUFiZ096?=
 =?utf-8?B?bEw3V21CcEw3WXRiK05ZTlc1WlVQOS9hZWtyallpQTZVWG9iSThOaXdkY3oy?=
 =?utf-8?B?UFpZOG9waUpybUlJRk51Vm1wRmFvVXdwWWZ0dVV1d1RNVlQrNEhwM3J5ZGV2?=
 =?utf-8?B?c1VvenZyS1FBblRlRkhmSXVhc0cxb0xPdDRSK2kwbGhwaHFSc253SmkySWVH?=
 =?utf-8?B?TkZxb1ROU2JXYWdaKzhUdHFqSWxMVmE3bkhxMXNzZ2x0R2EydUUrWmVKYWg0?=
 =?utf-8?B?cE13Um9lY0RvWnRUU0tmNGdqeVpXMnRiOUNBQjk0M0Q3aVRQK05xd003aWUr?=
 =?utf-8?B?WDhOOUQwemt2K0tzaldhaW9TS1UrOHZwQ2ZVRlJFT3dCb2JGZXlubjhBSm9z?=
 =?utf-8?B?eU9hUW9ncVMySm5FZnVpaHVpK0FyTFg4Yk1DWVVLcEtKVGF2UDRsM1NONi8w?=
 =?utf-8?B?ZE85WThnT0JQMXpqbEZSWDVYc3c1Sk44b2JCY003MW9EVEd3clI3MUdOSVJK?=
 =?utf-8?B?eFBnVmIvekdmWDRmdnBNNW1HLzBpL1lRVVZGcXNZWVRmVHYwbXdlSDAwOVlh?=
 =?utf-8?B?MEp2L2pINUpjTHNvM2RBTTlrYkRma3Q0SE93UEk0WEpDS2VoZ3N0SGhUcUZ4?=
 =?utf-8?B?OHREQWR1NG4wNzJQdnNjUVlkSVpRRW9Wa1dFQjVtejh1MDlzU2lBdDdCT2dt?=
 =?utf-8?B?V1A0SWVKVXBwU2dIVFduODNZYm85OUxPRml1R21JSUlMM283dW4wTUI3Vnht?=
 =?utf-8?B?cGY5SUdJcC9GaUVtMC9HQmpWQzZqeXMrVm1QQjUvV3ZuQ2ZYYkZVZjl0TnF4?=
 =?utf-8?B?UURCMDQyUFkrU0FDc05maXh1ZVczTlJON2FNM2kxME84TGRyU1N5MXN1dUZF?=
 =?utf-8?B?bGpRb2Z4SnE4YmE2OFE1ZnZJYzdmblNyVHk4RlNWSmRKZE1MNDVIZWRyWDRU?=
 =?utf-8?B?UjYzN0JUa3FRL2NLYXBYbWhEc3o5T1dEbWhrODNaeFRvVFVRY0R1YWtrYTQ1?=
 =?utf-8?B?OUxEQkpJV05UUEZjeW5Xb2w0cWRZUHoyVHduNVdhYUZjaUo4V1R3ZysraXd3?=
 =?utf-8?B?eE8wRi9oeWtYcHQrVmZmK2ZTZ0hwdTRCMnhraTRtYmo0QnE0TUtPb2xJelJB?=
 =?utf-8?B?Q1lROU9yNGVVYzMzaFE4V2xaY1BsSGh6NXA1cUFTdllhcDdNOUpkWGI1S0E0?=
 =?utf-8?B?NXAzbUpQZzgvVmlraHQ2dHRWckxvM3llYW16RU5DMkRhbkhhd0lDRVBLREJK?=
 =?utf-8?B?NFdkenZzUVVCNVhtcEtFZEZ6MEI1T21hSEkvbE5sSTRCSnhWamk3T2ozKzc0?=
 =?utf-8?B?VDlYSjlOS3JuK0NVcFZTeXRGQ05veTV2blo5TE5lblhnemV3SnI4bzJBK1hm?=
 =?utf-8?B?L2xpMnhiamw2MFE5bEo5RUI2ZjROK3dMd29xeGhmS29yc2ZMc0dvRUJUQ1FW?=
 =?utf-8?B?M3AwZTFyVFlKVC9LUUFrYzVhVEtUQ2pvakpTTndwZE5qbGh5QjBoMWhVQWdL?=
 =?utf-8?B?WVlpWCswVHk4a2JSa1pTelkyNXZjUHYxeW1HZnovcUJIUFJnNVBCYlJoQjdw?=
 =?utf-8?B?Wk5EZmJTOVkreWd3LzlCQTNuc1BpckVtUGZjZ1RmTTdHVzFhcmhqdE5veUZ3?=
 =?utf-8?B?OEphVkdMdmJPU1dGZDVmWUZLR0RiNGJ3a1U3aEZvYVoxd0E0UkFadG5qcmg2?=
 =?utf-8?B?Mk0wYUZYOEJmV2F4eVg0QVFTbFNBb2Z4S3FQZ2xMemlJbnNqd0I1UlU3czFx?=
 =?utf-8?B?RGdPdXNwUlpnTFd4Q2ZkSUFWeVFtcG9RN25PdFl5WTVtdzZ3UFY5UnI5S0lt?=
 =?utf-8?B?YytBVTlpMEhpcDdmRUVZSHoraUZWb00xQk1IVUltRUxKKzgrNDZBb2Z4R3A2?=
 =?utf-8?B?SnZ3Z3lPMEsxQUhwdUlkTlEvWEhodFo2bU81WlJsSUhDZWVQK2JyMXY5dSth?=
 =?utf-8?B?Y2E4eFVqbjQ2SDJ2Q2xoNFV3aUd5aFpueEowZGtybW0vNFhJTi9TMCtRNW1F?=
 =?utf-8?Q?eizXQ1WAQj+gslKwd6VUhY9jQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153c5570-6e44-46e1-18d4-08dd6b8762c0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:25:37.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j872DHeyf/eN93c1OnmohkmV0KOx5Q4Lq5+SqAaUPGgbOnxlxDKU38t5ilrePcY0UqE5fXu8cMQE9jqW9Bynzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

On 3/25/25 19:36, Christian König wrote:
> Am 25.03.25 um 00:07 schrieb Bert Karwatzki:
>> Here's the dmesg from linux-next-6.14-rc7-next20250321 (CONFIG_PCI_P2PDMA not set)
>> The memory ranges of (afe00000000-affffffffff) or (3ffe00000000-3fffffffffff) are
>> mentioned in neither of them.
> 
> Ugh, next time either in two mails or as attachment please. I had to separate the logs manually again.
> 
> The BIOS programs multiple root PCIe resources:
> [    0.310962] [      T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
> [    0.310963] [      T1] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfcffffff window]
> [    0.310965] [      T1] pci_bus 0000:00: root bus resource [mem 0x1010000000-0xffffffffff window]
> 
> But by default all BARs end up in the 0xf0000000-0xfcffffff window and are so accessible to the iGPU.
> 
> So I don't see a reason why dma_addressing_limited() should return true.
> 

Because of

	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
			 dma_get_required_mask(dev))

IIRC, dma_get_required_mask is set to 46 bits (based on previous logs) for the iGPU

"[    3.965669] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0x3fffffffffff
[    3.965671] [    T328] dma_addressing_limited: returning true
[    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 1"

I am not sure why that is the case at the moment

Balbir

