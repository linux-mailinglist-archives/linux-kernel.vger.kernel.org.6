Return-Path: <linux-kernel+bounces-175177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA08C1BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46ACD1C22621
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881F1EB44;
	Fri, 10 May 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LXHoabHY"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579761FB4;
	Fri, 10 May 2024 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300939; cv=fail; b=h9iOKX5HfC7l+QPFjhXKa0LoiFBsl9fc2Ag8ReGNZ2fjjfwRCsn4fkqJrH3o5Tt1k7OzjygRiY8t9Ay27eEfvB4RjKtBmZzN9mwZ0jIRFZWbJGDvQQS7Ol8Zon3cXfDkUG2Vt1++5DsR5hd8HRetoQbiEdOKljPXszP5CWkjOcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300939; c=relaxed/simple;
	bh=0ZB9yG8D8SuQFi37+CexdIjYFffmDxhrHYnUQFWoOsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lm+8uaK9MJLjwmbniaPZZC6GEcU9SHW4gJkQgQfK8xPFpC+eJiTdWHZmFE2QanURExhK+u9TZS9bJaM5mTrVY3Biul+1/8Yzvwd5AWeivP1V7nUhgSoqs5k5cQLiDNa0BsllG52sNIZ/BMCiNQd7lifvDhBwY583cqsSSS/A++w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LXHoabHY; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZFxVe8gMe6LWqAph5KMgz9Lnbxe7FfZzbCxwcT0ytsP+8E8CK1eW7oidYHuLyg64pJfgvS7NBiAPRo22XXeEOxpBlVn2xbmhvc9KcQnIvpdOX+UJY+XHtfEwxPP4lanqqKcVKCXI3vqmuD9rdxedllyTC1bb9jg/lVOd1AFsARI3EBTae83L5pbpDlk954QBQbL+J5uTnDHNgbXkZawLi6iE0ojQNIkjitorBTxH8N1Ic84BKJj9EUx2KcjLQwr8JgBvGgbiiPYlKhydm1UQ0NoqLDxJNb+zlhlLGmqTWBF2gJU+H0BBwkTSIgLN0Yt4jLUbRPP+R+7ChwchWbsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw+j0r1/4XVQjJ1rNjXxnDMaSOwMYkqs9XthiDeEPkY=;
 b=ZZK3j1+KOrA/VZbZABIKfM7NeWu6rTHKqIjKUZy5LWaPw6wsYWhyaEVKU1Y+duiiWoM+emeZFOA2GU31z3aj4Q2muxfXf46Tqv1Vpr9jCJt6qFfWYFmEdLwJ1UxP6v3vDKWjKNfiWqhpXK0VpXk3rELUd5t5bSwwza4Kmnkljwr0k2/U40qTk2/bBNLb0ISrPIvIqrjHUeaxdGJDwGs4XvsIXJCy+WNtgIQd1FaGVeHRs9XEE+f5FRBm/MRoh0ShXwUYw3O9vxANnk+TMEPtuGWJ+oaFzyKmNquIdib2u8F4s5qMWdLX4FmiVCIKOnIhLaByG6LbwwidTJ8hos6jZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw+j0r1/4XVQjJ1rNjXxnDMaSOwMYkqs9XthiDeEPkY=;
 b=LXHoabHYiUwYifVmcCHNHHCVxi38tSTrRztgfXP9hFC7jMO6QKl2UlQ6tay97KiX70938I0k9KYmiHEe/ZK4lpSMtYcLWwLPp4HjZwdHWL60+1/JTOYRhFLizyftS0/QIpd+vJBW2jBQ48zpguE3pF9ecgEz7H0oaVadXbt0a14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 00:28:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 00:28:48 +0000
Message-ID: <686af2dc-40dd-9a95-d967-2d8fdaaff197@amd.com>
Date: Thu, 9 May 2024 19:28:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 10/17] x86/resctrl: Add data structures for ABMC
 assignment
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <c3103dd30bc07070380a01922f66208759afe837.1711674410.git.babu.moger@amd.com>
 <3149b62a-b9a4-49c6-a757-5a0e36df62df@intel.com>
 <b367a6ba-3ff1-4173-bf71-cd7a04bf9882@amd.com>
 <89d9996e-3414-43f9-82f6-0260a4f49285@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <89d9996e-3414-43f9-82f6-0260a4f49285@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0133.namprd11.prod.outlook.com
 (2603:10b6:806:131::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a660f64-7fd2-48e7-31ec-08dc708828bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anlneUtBTklWeEovUDB6ZVRJRUd6MDNocFowYUMyZUpISlRNT2NHQWs3b1N0?=
 =?utf-8?B?cFErU0ZCWTZub3lJVDFybGhkMmlzK1N6NXNrY1hQZG96YVl4eGJSMG03UmRS?=
 =?utf-8?B?ZVBBNUR3RTd0VjVHa3NwUTRqNndDdC80NXJvRDY4MFA3MVdTd1I1bWpWTm9X?=
 =?utf-8?B?Y0RQVVhEV1l3MXhMN21ZSXNXQ2NNYWhmR2VvamZFa3B6WjJTMUFpUjhNbXZT?=
 =?utf-8?B?djRvdnA3OTNVRkdVQUExNXB4SmlHZ2JxVWNBNVY1QjJDVjJVM1BoUE1IZDVo?=
 =?utf-8?B?eXFEaGdXOUZLaVVtdU50S1FoNE9QdEsvMnBpLzJvQVJFVlVvKzJsc1ljaGJ1?=
 =?utf-8?B?ZkVndlhsbXJtSklyZm5Jd1FFeWlhWVZ3SkI5S1o2RWlVNkU2MnFOamVRbm8x?=
 =?utf-8?B?V1dpcmNjQzdBL3dDdmM0b2J3bXMwSG43alBZejhqM2tlckhGbjRLeHkzR1NT?=
 =?utf-8?B?L2VVcTd2dlN4V0x1UVFDZ2lCUzc4OXFUSzlJbS9Xem5wakYyNmkrNFptYzd3?=
 =?utf-8?B?WDlhUTlDN1lhcm5uNjR4WDdTQkJmSm1YdVFGZGVESkoxcVBqaUpwaE4xcXVy?=
 =?utf-8?B?T0RTNk1NTzFqdWd1dzZJUXViakRBdEFEVTh0b3haeEI5ZFllUXk3OEl5Zm5B?=
 =?utf-8?B?dlBSUW9WS25nZGVQcnBkaWs5SFQvZ0lHVWo2Q0E0ZldrNWN1NUxBZ0dnZnI4?=
 =?utf-8?B?Nmcxb1RCUmFqSTNuYUZzdlNxbEc1T0QwVjV3TXJ3a1Q0SVlsdjI0ekhqVDJT?=
 =?utf-8?B?QTk2dENLQTdtUitiZG9Dd0pFd1BGTm91TlFjWkR2UFd6WVVadFpNSnM3aERB?=
 =?utf-8?B?U24vZFhvOEJpcTVGejVHbE1rTGM4NjN0MVczUDdqMndxNzVoSzBuZkpXN1Qr?=
 =?utf-8?B?K3hVWHZNcnVrbHZTWkwxd3FaZ0JPMGErdUhFakFFSlZyTVVZSlEweDNUUklF?=
 =?utf-8?B?ZzQyNDdwbVpsRjh1RTN0UnppTXIyMlBrcTcxVmtWWXMvcUhyTTI2N0hJSW5T?=
 =?utf-8?B?WHl6MkxScnBodHN1OWpGQnd0V0RzZ3pTdXN6aDl1djQ4UmloWEZiL3o4OUgr?=
 =?utf-8?B?TERIejZ0WHIyb2RJd2ZqU0l2Ly8xSEZLSHdIQzNWMm52eldLNGVPbXR6Ukgy?=
 =?utf-8?B?Mzd0UEFFTlBZcjNLYkF2SzNhdUFPNmliM2VJVGJDS3ZQRDltT0xVQ0JKRUwz?=
 =?utf-8?B?bmRtSUR5T2JIZjk2UzE5S1p1T0F3T1U0dXJOamVTcGRDais0VURLNk5NS3hn?=
 =?utf-8?B?UkkxVTJTOG1nbG0wdUwvZXNKaG1ndXM1Znd5VnVKTmJnbm9Tb0FDRXlleTJp?=
 =?utf-8?B?MkdCYkxnc2lNaStLeFpqSW0wRUh1RGNZcTY3cTIzSS9aSWhoVzNEcVJVM2do?=
 =?utf-8?B?RDBiRlArYTBTV2xvNTduMXY4OGVmalZWYnlPRUtDcFBoSHM1dDFWa3ZEVFlJ?=
 =?utf-8?B?SWRGMDNvZzVHdlo5dlUrTjB5dlp3RW9wbGhKd2FLM2NkM09ieVpLdk9yQzdr?=
 =?utf-8?B?UjVFWDAzU0hFV2N4ZmUvemd6aWFER3grN0JTRzM1Y3M5Z21wMW5EZktBb09x?=
 =?utf-8?B?aW1ycUc4QnR5SllZRGlSaUpndU9rcWlleHFVMk56VE1rS1NUc3A1MFliTWJU?=
 =?utf-8?Q?gTVOEbIPFdXYgDv2CQYC53VhqMi5fNEkDZT1UxinnBYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGhRdlRjZ0VDbHVkR3c0Zy9zd0RmUSsvSU5lTVpvL1dVM0hHT3NHdDczOHhL?=
 =?utf-8?B?R2YwSEdJd0k0dG9xU0hjWFZ5anhXcU9NZWZKUlM1NUVHWStacVA3LzJoVExo?=
 =?utf-8?B?dDE0aUJYTmtWbVJia3NmMFhDajFGNEFRckVuMkpGV0FPTks4SVExeVlLV20z?=
 =?utf-8?B?dTg4NEhxSWZUazRJa3FBMDhwRUk4WWdWYTNiZ0Fla3k3aVRIUk1XTkdjVnA3?=
 =?utf-8?B?ckpRTlhIK3k0RUhEYnNoUVhTN0hxNjZONHFMcUdUaFRWUXpBekhVSDg2enJF?=
 =?utf-8?B?VzQ5ZnNnR2xpVjRGNUZlZnB2U2x2QU40djdXTC85SVp5eDdrSmtja3d1dUpN?=
 =?utf-8?B?VUhLVG16UlFuN1J1NUdCcXJ2OTAvTWhadVppSWgzWDA0UDcyNDhoSmhBelNz?=
 =?utf-8?B?NDI5ell5cEx2eDVjdkFzZkdWeVJFbWVlQTVBQm81VkROKzNPZzBqdWswNTh6?=
 =?utf-8?B?SnFvN0NIMzVLdGd5R0ZHdEpDS1BYR3BWK1liYmEvZkFYbktkZmpWTWlKQlJU?=
 =?utf-8?B?ZHVjSWhQaURiM2FOQlNaampQZCswdkJWdlZBVUpZSEw2c1pLRktYSTVOcitk?=
 =?utf-8?B?dEQyb25OaUZjcmtQaElTR0xCOEprSklibGhVTjRwTktMY09CcUV5d0drbWtT?=
 =?utf-8?B?NE5xeUhrU2RyVlNiVVhXQW9Ea0NZbFRCWDZadisxeVBZTkRJN0VxWDhzYmVn?=
 =?utf-8?B?V3NrNFZmZy9acFhma3BQOTZnazR4SmlScUt0VWRwdzVnWFM3UE1CRnVXQnl2?=
 =?utf-8?B?dkxKYmFxSGtlWUd5QmhiSjZmVXRWVkZjNlJIcDBtR2VOR2hTYmx3SSs0bkg1?=
 =?utf-8?B?aWJPNGx1NDhhdFpKR3hWdTIxVDN5K3VPWncrZzU5VlM0cWlvK3N4Q2lhYk8x?=
 =?utf-8?B?S1VzSU9pOWkrU01nUG1UWjRUWFdZWmRROUxVdGVoUnFqUFVrK054Qk1ONTg2?=
 =?utf-8?B?aWxZeDdCaFdKWVhJaGVEVHBGSUJwMXZuc29ocHJwUk45MjdZdXZJVnVLN1dt?=
 =?utf-8?B?L1FlYjVGOWpmN2hpOTJjcDI4cjR5MFlwQ05MOXhxcy9oU0U2bkdTandEUTd6?=
 =?utf-8?B?VzJpTXp3ZXhIdVJZb2FpeU5vVUJUTmhkNElNQWxLaXpwdlBwYndLMmVmbWRB?=
 =?utf-8?B?UFlsODhOcVM1OCtYV2VTUEhHU2Naa1ZNMmJiYmN0aHUrQ1lJbDBMVlhrWTZk?=
 =?utf-8?B?MnlYS2dhWXFzTnp1ckczL0xDZjFuWUZyWGFrVC9hd1lOWmVXeEw2bkRvejhq?=
 =?utf-8?B?U1FvbDRNVXFXSFdXVmxiZndER0hWaGxFaFk4MW9VaGVabTVtaGlFLzJob1dp?=
 =?utf-8?B?TGx5ckhxdUxpWUNXVGhadkdrSWd2SVg0d1BUWms2SjltWTFIY3ZhcVp5TzVn?=
 =?utf-8?B?THZLUFd0ZWJYek9BdzJBYUFZSEZOZS93MWdhdVl0YmoyK2Jla0c5TGNhbWtZ?=
 =?utf-8?B?UmtIZlJHbnh4RUc5N3h5RGhiWEttcHdWaUlOellWM3F4V3JYL0xmNzZGRjRL?=
 =?utf-8?B?a0swZ244SVZvMHZEdFU5N0RMSzBvUGpMVVRpNFgxYTJ3K29SNmtxZVpXM0Zw?=
 =?utf-8?B?eSszcDBrVWpuRzVDeFlScmxmZjJvUlFRVExSbnYrdkk3WU5yVGYwMXNuWDhL?=
 =?utf-8?B?MXl3WGlOSXNadWgxMWU4dm4zYW1BdThrN2JjREgweWgxR1hZNndZT3ZobEVB?=
 =?utf-8?B?UnErV3RCSTR5b0hoNEppL2ViYjM3SUxYdjAzN2NCUnBSWFhFU01UWjhOcjVt?=
 =?utf-8?B?ZUM4UkczWTllWUQ5dHY1VU82UFNhamNvdi9SZmI2cGpBYmRUWkZhOC9Ma1RF?=
 =?utf-8?B?OGRhNE9oT3NFbkNuWHBORzFMZ09pdlhzZlNBcmhVaXJmK2tIUlVqVGpQS1Ro?=
 =?utf-8?B?WUQ4bFNKWUw2dWZqbnpNL01SMkFpSUJTV2pZbUt3NjZIcmpYakZSUGo0Mmht?=
 =?utf-8?B?UFJkMHlVZmU4RVQzVjB1SmI4bEVUdXdpUFhtdGFMSzJVWXdOcjFqeUZoNSty?=
 =?utf-8?B?TkM5T2xaS1JxSHdZQ1ZucXJ6NEhBTjBjRUx0b2lpV1JtelJwUHg3YnNYcGVu?=
 =?utf-8?B?Z0xER25rVXJ6VmtONFVlaE1jM09yeWJUMUdSZnV4K2l6b1pHMmVPcmYyUTF6?=
 =?utf-8?Q?5WvQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a660f64-7fd2-48e7-31ec-08dc708828bb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 00:28:48.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83HJZTwxadigbc4Gmmpo7Zyg/L7PqVbRJqlaOeukHjLrbeUM3T5+BtmB4jvWxM5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Hi Reinette,

On 5/7/2024 6:06 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/7/2024 1:40 PM, Moger, Babu wrote:
>> On 5/3/24 18:32, Reinette Chatre wrote:
>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>> ABMC (Bandwidth Monitoring Event Configuration) counters can be configured
>>>> by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
>>>> configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
>>>> while specifying the Bandwidth Source, Bandwidth Types, and Counter
>>>> Identifier. Add the MSR definition and individual field definitions.
>>>>
>>>> MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.
>>>>
>>>> ==========================================================================
>>>> Bits 	Mnemonic	Description		Access Type   Reset Value
>>>> ==========================================================================
>>>> 63 	CfgEn 		Configuration Enable 	R/W 		0
>>>>
>>>> 62 	CtrEn 		Counter Enable 		R/W 		0
>>>>
>>>> 61:53 	– 		Reserved 		MBZ 		0
>>>>
>>>> 52:48 	CtrID 		Counter Identifier	R/W		0
>>>>
>>>> 47 	IsCOS		BwSrc field is a COS	R/W		0
>>>> 			(not an RMID)
>>>>
>>>> 46:44 	–		Reserved		MBZ		0
>>>>
>>>> 43:32	BwSrc		Bandwidth Source	R/W		0
>>>> 			(RMID or COS)
>>>>
>>>> 31:0	BwType		Bandwidth types to	R/W		0
>>>> 			track for this counter
>>>> ==========================================================================
>>>>
>>>> The feature details are documentd in the APM listed below [1].
> 
> documentd -> documented

Sure.
> 
>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>>> Monitoring (ABMC).
>>>
>>> This changelog is purely a summary of the hardware architecture. I have not come
>>> across a clear explanation on how this architecture is intended to be supported
>>> by resctrl. When would resctrl need/want to set particular fields? What is
>>> the mapping to resctrl?
>>
>> Something like this in the changelog?
>>
>> ABMC feature provides an option to assign(or pin) an RMID to the
>> hardware counter and monitor the bandwidth for a longer duration.
> 
> Regarding "a longer duration":
> https://lore.kernel.org/lkml/b5e68d85-4bf2-4e55-a9c1-b39cb7d94db6@intel.com/

Sure. Will take care of this.
> 
>>
>> Hardware counters can be configured by writing to L3_QOS_ABMC_CFG MSR.
>> Configuration is done by setting the CfgEn field while specifying the
>> Bandwidth Source(RMID or CLOS), Bandwidth Types, and Counter Identifier.
>>
>> Add the configuration register definition.
> 
> This still looks to me like a cryptic description of the hardware architecture.
> Could you please spell out to me how the above answers each of my questions?

Will try to elaborate this in next revision.
Thanks
- Babu Moger

