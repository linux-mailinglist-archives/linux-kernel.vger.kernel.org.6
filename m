Return-Path: <linux-kernel+bounces-218042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CED90B875
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F8BB26824
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794A18A94C;
	Mon, 17 Jun 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O/ic0JLc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D910A2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646636; cv=fail; b=dHXZ8k7MBRo+PMy4vfKYqO1Sw2GPIn4kglwjHV2JpqmoQZmAVDw3VUgWbuKLAhH6QnIyvXSvyUB5uiq/EFcVAK2QWRObqrthPhhmzVgfGfHJgalfd1X2pqlMSDuUqwS0ZYG7nxZBsdQeQTf2dmfm/zlyWoHWY1ZyjDJ4Xf2b+9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646636; c=relaxed/simple;
	bh=FycJEUjVLmHS6udqf2eZD0lfc7OMaVC1/v7GppC92QY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dub+3g2IyxERRJ7li2ZsH/4uGBrAMlFIfuHXf43Dwfj21qjRJxjqXIVVruw5uQvTlDQRUPPV6Oa6Necau6wn6J9Pe7BbONoX5/fWnGy/hWZH/v6cvH92z4Tx23nbnVlbpS6DWDY3M2djDRk4w1PS0qPqLok6x7iu/+hM+iQhK8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O/ic0JLc; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO7M8kQfcCGso9lG7muxKvoEjWeJ1e/wFbuMR6B8bCP1OZY45woe3+l8n5anZUtU3tfMZQ+KzAVnSgVQUXxo5CTaOY3/3v+j4ms8op3+6XVbhqJGWQd/Q+AifHaKyg0YcaBGEqRJpesVp9SjqC2E21Fc+zAkffpYwi9vc8yNHRq8ozCWZwic4yEoSWCg6dI7FaH2XgQ7lDuyB849UbOZ32oGC9tfRlFpoSzDlPeyoPbOjHpDRh06S9rAM1HkLRPauTihpJ+iO2FVfE9Ax8Ub06qRp2IM6IwGlTBKVVsibp0udTVchSZp6GtCevTneiXA4RQTpZSgay5UwuNvtq3vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7g7nSRyhMtSgVvSzBVCnDe8ChGJyUlm+OK38AZQDCk=;
 b=iLTg5l6O6daYvCQ/ADAhzdX+6Oqj8wj5tAoerh0po5P03vh/3x64oaU6odsg7QyT75ZMDQx/JyOuzIhHNC38Aq/x2ZvNG0gehfNP7Rd1OiK69e+g4y6e0zZW0RMLwNIcGFozrstey55YlAQGB9tf0iNKfuVBoKTRNEz7HKJBYFc8Z8dFMx5th6aQIwCmCdvjsVBJRfIO3G2IDG0n25exuvflSIFmSFzWZbY6Yk/QmWCzO5FsXVVi+Ry7yQBysEMA2C1FeDftv7+9ts4AeGIuSUvTwvLcy8Bs/UAHQW/uRpF1rj8jVxYWRp5AjTIzhYe08qStszeNELLxSmemxVVKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7g7nSRyhMtSgVvSzBVCnDe8ChGJyUlm+OK38AZQDCk=;
 b=O/ic0JLchzbhfCd2bVyKiPNVayCxPxBMNxcO8AatZ9VpAwx0fPFC9ZA1kc0FJJ2MpcK8Dp31r207V+xFJ8Xad2AKWzJWaSAE0iX8GlxtHiSGRSkXtMYHCVHgUGbuPbJ/EuRn+v+mWCkPM1Of1Hwxb8vfXegwzcF/5JuXz8SXukM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 17:50:30 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 17:50:30 +0000
Message-ID: <234bb23c-d295-76e5-a690-7ea68dc1118b@amd.com>
Date: Mon, 17 Jun 2024 12:50:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 04/13] x86/sev: Perform PVALIDATE using the SVSM when
 not at VMPL0
From: Tom Lendacky <thomas.lendacky@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
 <4c4017d8b94512d565de9ccb555b1a9f8983c69c.1717600736.git.thomas.lendacky@amd.com>
Content-Language: en-US
In-Reply-To: <4c4017d8b94512d565de9ccb555b1a9f8983c69c.1717600736.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:806:120::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 277bbb90-8531-471f-e71a-08dc8ef5faac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N08xcCtDQlYycHRPSWlsM2FNcWgycU85RkRtWXlCMEp0SEtYN2NvL1IzbmVv?=
 =?utf-8?B?SFh1akJkK0tKNW5FTndCN0VSS0lyQjFNQUZyL05NNXlabCsvVCttTVFPZVgv?=
 =?utf-8?B?bE5ZUlN3aFZuVFN4U0w3VTFCdmhsdzUvZG5SWE1pcG9lRklxN2Q4cGExTHFM?=
 =?utf-8?B?ajVmbkNxZFpZOVhlbWRQNGkyYUJzejlQYUJmRUZlaUx1TFEvRWE2MjczWDdl?=
 =?utf-8?B?T3hZL3hYelVOSUZycG0wQ2Q0R0c2c1llUVlPbGQ1S2RzTWY4ZXNMbk9uYlNs?=
 =?utf-8?B?VUs4WTlCS0F0Q2hYV091QkFMaHNpSEw5V2hsWUYrTS93TmUxWnQvSDJWTFBY?=
 =?utf-8?B?TDNSMnFldkZNdXdJTnp0a256ZC90emEzNXZIL2tlMnp1ZG1rVnd4bVFEaGpm?=
 =?utf-8?B?YTdkNktYQmhpc21LQjlweEROSG42ZkpTOFlidnhLTDNva0tRSmZ2cWYreFE5?=
 =?utf-8?B?Z1NWV0VtbkVyemh1UkEvZ1ZtbzBjNi9mc2I3V25iYm1ycEE1cFRnMVpDM2Jy?=
 =?utf-8?B?R3FVaGlmWXUwSEFBRWV5WTN6YjlTQThURWp2VlZVMlJMTk9BYlJwUzRLNklj?=
 =?utf-8?B?WHhMdEpORjEyNlI1QUY2cmY1RmJSY0szRERmbGt1YVd6YnFaYVlVb2puUWcy?=
 =?utf-8?B?NVRzRkRIaVdwWEw0bEdKV0hjSzJjMmNpNnpSMWtGV3lhcHRHUlNXVHV5R3dM?=
 =?utf-8?B?RnF5SFl4MnpMdVZNL0xCclhvQW1icHRoZldvSjR5YTRLS1phZXFxT0hCR0l5?=
 =?utf-8?B?eWpHcnE5N3NyaXUrZEtkT3N5ZmhpZHo2cCtTRzQzcTZSbGRNUjN5ZERCTVdv?=
 =?utf-8?B?YlhyNTBOVXUxWExjcEZ2a0ppM29ySW91WnJVbDJJbis2bUlOVHRobXQzVGJU?=
 =?utf-8?B?TUVFbENPT21zeHVsS21hcFJXSUl6bXJxOGxHZW1OZjR3OUhPVnVSckVQaVky?=
 =?utf-8?B?dDIvK0RZSEpybDQyOTNkRHlPMUtaK29GcVlxN0ZaT1FTSXNXSnRNd01ya2pn?=
 =?utf-8?B?SEIyUzBFQUY5R2hDcjl6Z0x2ZWI2ZFFDSzAwZVBGVVV4UlRWczd2Mnh5SmpU?=
 =?utf-8?B?UlJsQ0RzdDF5VHg3dHpETGp3cHRpOXEwOEdpaSthUUZMS1JyNFd6MndjU2p5?=
 =?utf-8?B?T3JObkFqWkNtcjkxQ1FMcUR4R25kV2hEOGV0NG9mV3RHSklDSDdhaEk1VXgz?=
 =?utf-8?B?N05oWE91L0ZnRXFhQ1FHWVFqbURIbjFjVzFiQ2tMVlhCMkhDZTlTSXF4V1l5?=
 =?utf-8?B?YVJFbkhRMWxZcGp3K2cyWjFMN2hiUzRlZ3dmdlNoWDY5N3Q0eEQyNWdqRzZM?=
 =?utf-8?B?TWFoV0MyRCtEckR4cjRjUjdHQTFjWFBBK3ZHcURuQzJ6M0tpK2VmUGlSQlA3?=
 =?utf-8?B?NVVFdUxrdGRqSXQ5ditJM1ZoTVdEVHFlai9qUEdBVmtlREhXTjJOWUU3bEk2?=
 =?utf-8?B?RC9kSCtuK0M4R2hPVTM5NWU5d0NaSzA5NWJJbGpTNE8yN2l2dmJERFZ0aXVE?=
 =?utf-8?B?YVlPVTZFRU1FbmJkRWpRMnBKZnRPdVo3MnFHbElSOTRZa3ZFc0lzbmRaMXFU?=
 =?utf-8?B?K3ZFdGhWODhyemhJRHBMUU5xMW9LTWJWWERIRmZ1NXVtcVJ2K09IN003bXlw?=
 =?utf-8?B?NzNMYitHdFpneVBlaVV5bHRzZ1R5OUpkZnRTNk5lYjFadFlnbm94OG52Vzl1?=
 =?utf-8?B?NkJ1Z1FEU2h4UVRET1F6YmZGM29sUENlbU9NcU1pUUJ1a2dsaHUwWlhONklw?=
 =?utf-8?Q?sBvg5Vtss97q8LjhYCMneNAbWKsi9rPxhSwnmIi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2xubTN4QkhSeVZtTTVIWVFnb1VRKzJwWXdGQnJUejh5c0NZRzZodGRwRDhI?=
 =?utf-8?B?cGZnSUUxRE5McGplN3hnSkM2RmhFcUxVdnR4TVhYczF4a1N2b0drcjZuUzcx?=
 =?utf-8?B?c1BobUFZaGs5cUhCZVhpNGt5cUZzUHh1MFVZNzdjZktLcVpSR0VaRXpjR0t4?=
 =?utf-8?B?eFRvdzBtUEFWTjlDNGEzQjZHQ1JkQUd3clpvVVF2ZWpiVTBGYlc3R3VPQ3ky?=
 =?utf-8?B?L0JDeGpoUlZkbHc5eFFWNFZYVm13a25hYlpRSEgwRVVVWWtBTU1Wa1EyMjhI?=
 =?utf-8?B?Q0Mza0lHRGU5aC9qSjdvdXg3a0xDeng1YVFxUk1OQVhqU1lMRVhJWlZ5NThK?=
 =?utf-8?B?dlFSUjY2L1NyaW1GTHhrbW8xNjBLSkdsSktYNUw0VlE0ZnMxeS9CTHowNkJS?=
 =?utf-8?B?dWFCM1FhU3U5RHJ4M3lDQVpLUDBqNWlwamszd1dvL2V3WVlmaXVyU3RQSUxX?=
 =?utf-8?B?V3N3dGExWUlaUVptVXZQc3NNZ1F6ekxTTHA2TXZUZ0dlUXZhNWsxS0owL2tE?=
 =?utf-8?B?OTdCZEp0aldaTndpdkFHSjZMZ1NRbDBUamlpcE1iYW1VVFV2eVZ6THpyZnNl?=
 =?utf-8?B?bGcwQkhDeEpySURLQjJqdTlkcU15ejNWTW5ZUmVJOFJqVWhyb0wvMUQ4dkNl?=
 =?utf-8?B?L21ra3hmNzF5bnJBQmUyUC9Dd0dWS0huTmRPVmVMUUVEN1FWOVA0b1V1eWpy?=
 =?utf-8?B?dWlzSEdSRC94TXVVYWZiSUZXd3FWNnZSWGgzeUExS20vajFIMlRBV0RzUUNZ?=
 =?utf-8?B?dXhPdW83OHR5amFyVnFNYXVxRjV0clkyTGxhNjZqZjVyZmZDdzdDNjJaUE90?=
 =?utf-8?B?MG9MWmNsMlZ5eFU1VWc2WUhTdmxySGdLZG1SL25qdGxMcC9kV1dwVXdreUVp?=
 =?utf-8?B?c0owSWNWVVNxblMvZGg4YmZobDdUeGl2RUs0Umo5T2ZJbjZvR080RXBjMEtC?=
 =?utf-8?B?QzVNaHIyd1RVZ25Jak9oWGNxKzdCUlVTd0drdmE3TGJNc0dqR3VteGhpMnF5?=
 =?utf-8?B?SEsrc2xoMW51Tkp2WEtYQTE3bmNhUjNvRDhqc096U2x3WUxTQnllc2c1b3Vz?=
 =?utf-8?B?d0RnZnVndU9xT25icTIrNGJ6R0s4VHBxUUNzUVVIaExTenV3a2hYb09haG4z?=
 =?utf-8?B?b0VoYytGN3NGVEtJWFNqeVFvL1BOREVMTFZEZTVqWlFDc3pyZTBGTEpaT0Nv?=
 =?utf-8?B?VFhxbld3bDJyZU9reTBYRHhWOVJDWVcxT1pDa21FNG43QkVhYUpZcHJVV1l1?=
 =?utf-8?B?ekZuV1gxM0E3SnZjNWNDV3czaElla2RMVWFzanNIdjNIWW54ak9Xa2xsdUkv?=
 =?utf-8?B?c0hRMVF2MFhLalc0VmxoRi83aVFGVHNKcHVjeWljWnNQVVJBZGg0dWNub3BL?=
 =?utf-8?B?OHNiVUh5cDQ1ZGg5enRlbGllaFRFY1I1TEtJYm51anFOWExRSEVsb2RnVmlS?=
 =?utf-8?B?bkFhK1J3S3FlMTh4WFRmZmpSVTVGUTNZYU52czJlV0N3V2EwbGxzL3o4WjN3?=
 =?utf-8?B?NFVDcm5ielVPWXNFdmJlTlJXTHB1WU1kY3RVTzFaTmIwUlhoeTZSNzh6TnpU?=
 =?utf-8?B?aHlmNzJqY1htd1ozeUlUTlhJbm5wWUh6aVowK1RIMFdGbkZDT0FEMzFtdjVn?=
 =?utf-8?B?VHF3VVAvcG5QbFRNTHZwVjhyOUluZ2kvY1lZckJKOGRuZGY4dFFVdzdld2ww?=
 =?utf-8?B?YlFzM1JYVjBuaFBrUVlaVzNCTHUrWWJkQTRUQnFKQ1lrS0gzZnNHQ1VPbmNO?=
 =?utf-8?B?ZU4ramUxRkMwYjN6b3JQMWVzT3FUd3NBOWU1aXJDeTRZSkJhcVUyZWNZS0dP?=
 =?utf-8?B?b3FmT05TUTJLdzBMc3NDZnVydS85RmJrUG56Q0tJNlQwRWN3cGt6eERXN1R6?=
 =?utf-8?B?bWIvdFU2YTBKMkxwMjJRbUNSdTBKN3ZNRDVTblVmYTZsWEppVEpkTmpmcTIw?=
 =?utf-8?B?bElobVFOMDFBUW1vK3o2eWpMQTROZ3YveVdTYzArS3JKenhWZ1Q0MDI0d3M3?=
 =?utf-8?B?MmQ3U05rL3RmQ3VyZFBPSXZtRkEyQzFadXFlMXJ5d3dTMHYyQXhPekg4RnNL?=
 =?utf-8?B?Y2pzdVRpWnd2M1UraCtNU2srOVY3TFllK1c2UStJVy9hU0VadFo1T0NYTHdh?=
 =?utf-8?Q?pRqpcPHGCjbagRX3vO6JANKQs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277bbb90-8531-471f-e71a-08dc8ef5faac
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 17:50:30.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkUvqwVN46jNAHd9yEo0a2e2QrDP70CxiA/SMiffAuUqj77uDPHb5YHDW3PGx4dPKnd/kW+uETfZsgmr861cJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

On 6/5/24 10:18, Tom Lendacky wrote:
> The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
> be present when running at VMPL1 or a lower privilege level.
> 
> When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
> memory validation instead of issuing the PVALIDATE instruction directly.
> 
> The validation of a single 4K page is now explicitly identified as such
> in the function name, pvalidate_4k_page(). The pvalidate_pages() function
> is used for validating 1 or more pages at either 4K or 2M in size. Each
> function, however, determines whether it can issue the PVALIDATE directly
> or whether the SVSM needs to be invoked.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/x86/boot/compressed/sev.c |  45 +++++-
>   arch/x86/include/asm/sev.h     |  26 ++++
>   arch/x86/kernel/sev-shared.c   | 250 +++++++++++++++++++++++++++++++--
>   arch/x86/kernel/sev.c          |  30 ++--
>   4 files changed, 325 insertions(+), 26 deletions(-)

Small fix on top of this patch for SVSM PVALIDATE support.

Thanks,
Tom

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b889be32ef9c..7933c1203b63 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1360,15 +1360,12 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
  	return pfn;
  }
  
-static void svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc,
-					struct svsm_pvalidate_call *pc)
+static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int desc_entry,
+				       struct svsm_pvalidate_call *pc)
  {
  	struct svsm_pvalidate_entry *pe;
-	unsigned int desc_entry;
  	struct psc_entry *e;
  
-	desc_entry = desc->hdr.cur_entry;
-
  	/* Nothing in the CA yet */
  	pc->num_entries = 0;
  	pc->cur_index   = 0;
@@ -1391,7 +1388,7 @@ static void svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc,
  			break;
  	}
  
-	desc->hdr.cur_entry = desc_entry;
+	return desc_entry;
  }
  
  static void svsm_pval_pages(struct snp_psc_desc *desc)
@@ -1427,8 +1424,8 @@ static void svsm_pval_pages(struct snp_psc_desc *desc)
  	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
  	call.rcx = pc_pa;
  
-	while (desc->hdr.cur_entry <= desc->hdr.end_entry) {
-		svsm_build_ca_from_psc_desc(desc, pc);
+	for (i = 0; i <= desc->hdr.end_entry;) {
+		i = svsm_build_ca_from_psc_desc(desc, i, pc);
  
  		do {
  			ret = svsm_perform_call_protocol(&call);

> 

