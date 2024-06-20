Return-Path: <linux-kernel+bounces-222865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB39108D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157A71C2162B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9231AF6A8;
	Thu, 20 Jun 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tZfAF0DV"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE01AC42B;
	Thu, 20 Jun 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894773; cv=fail; b=tWZx0SDZteVA4kHzWa5JpngZq8j2umvH5ALC6I1a+03zhEjYtJJgJgo39iVk9jfpIYA3hMHoBipIDGrN+T/H4paaVSSsfsRHXDIiNOi09OIQW00sSaPoiGEdlPt7rAbkYDhQZ02eH+qh0srTJp9wCpO/SDYnNsX0gy/IHrQssNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894773; c=relaxed/simple;
	bh=r62ymX3VKYeKq8k/J5zMF+mMRsBpYWTOsz8Zi2H2f2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjTBOoorVXSMFeeco2lzE7SgBsftXtMiVyJ1emoqROj9IneOqXfli8blKaPoN+VmoNG0tCdt/w8JEDAd/C128mFq+79xPo8MfL3fAn8Xt2aLh2hJrAm0e6gAGG0LX9azGiNNOtDJCSLx8gPFR3RlL9DgF0ndlPxHDuZ+2s1vQFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tZfAF0DV; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpykud8Oz481du75MR2POyp5GNZD/HlJgzkigLNRdG5TO5RvSaqOz+sW0DxJQEmEG3m1l6/5sYGlZHUZBeDqWfcsxPGS/ry1SCDrufQkeI/Zgst/f7derHT9H1Anog2AmKqDa6cPDT6ssT6LGqN5tuwe2kjOJJWWaCx078zcRG0tJXYjDHONlCi8gk8LztOBOevNSBWSscnwJ99xMsuVF8Xd3ThbrWO6V13Hd3mQFHtHkZlQtrMGyeZfgaqjF0Fblp4mYPIIZMRBREbQxogQG8Yr9GUGONap4ntEeVpgaDtM0xLV4XQYNyErIMviAAtnfO7dF53UfKVEyGPXL/o6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F3yC00/vdzvOMZjlpWohRlDbSztHj/V3iKiJbolCsI=;
 b=gIp0Gq2fK95HS0CU6v6AfZqq0Os3MGkg4A/Yb03fJHZ5e6xGyXz6S+yrYvkPSZwz/6g2mTWveplO7E0jP+ABdZvV0h6zYLiNEpn/7LqQ2XPljPqBMwhD5Fjgr29WByyrRxlt9nfvhWXLw4c6k739NZV4/GVP5N4vcOplpb3DvUZjXiVzjc+CfjqZJGYav2fUr1uLuUSivemyOy7RKcp3uIx1toapG131nzOdGv9q0FSQ4elufCLYB2+6tSUitbbodaOOqhmeyWlhABxc6KHSq4eT3ZS7SHOaCcCYNzTpc/A7C/2jVoHlh+0Jnw4wAgNEwuKONx0CJz80X9j5Xh4+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F3yC00/vdzvOMZjlpWohRlDbSztHj/V3iKiJbolCsI=;
 b=tZfAF0DVlt65M2wVBMXsUd9uIxuw9b2M+LzxDcLlRxcnDPEUgGbf+PNu+WJA7VCDagTTpUznnioRmakgFGU0EDmKyWMb0EaLaUBG66kgvJaRSIlc3GoQ5HB09JJMqaCx10qFVUP9YT/2LlXLKFnMoroQ3qnaPX3XEUYrHlFjMfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 14:46:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 14:46:09 +0000
Message-ID: <343960a8-b364-44b1-aebf-ebb7fe0a1466@amd.com>
Date: Thu, 20 Jun 2024 09:46:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 16/19] x86/resctrl: Enable ABMC by default on resctrl
 mount
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <74f014062885d707701873527c1b12268603a525.1716552602.git.babu.moger@amd.com>
 <b722c5da-812c-4ccb-ae7b-e7bc9c9de50f@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b722c5da-812c-4ccb-ae7b-e7bc9c9de50f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: cca11425-d5d0-499b-9828-08dc9137b8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnROS0JqZ0hkU3h3RW9KS3dJdThxc1lrbWhLb0xhUkpnMFVUVGMrZ3ZpNUxT?=
 =?utf-8?B?UWZqdHh0OGxGMG00RmV1NlBLM24wdkk1WVpOZXoyZWMyT0tVK1ZqQVF5bTBQ?=
 =?utf-8?B?bEl6cXJzaTBVSmlRcUlucTI1cFZaalhIZDZ3LzVJajhIYWNVRDdWRmhFcGZp?=
 =?utf-8?B?akVRSzE3U3QvQ1NZYmlrckx2UWp1czZHemIwNDg0Z0JtTkNkTGx0WVFXdEhD?=
 =?utf-8?B?bU5kdm5nQUxxZUJoR3ZVdkNjWDUzUkRrVE9tUkJKeHRGRXJNc0ZLcHJuUmdm?=
 =?utf-8?B?V3RnNHRPQmZhQSt3Q05qc1Fva3dMbm5rUXhWNlowM2VpYkFtN1pCcHFPSnJ4?=
 =?utf-8?B?Q3VJc2NMck9CZEZ3VHl3aW8zNjlJMTQ5b1I2WlNUcnA2bjFYWEpUNmdQV2VH?=
 =?utf-8?B?U2pQMW1tdHd6VEpHaE1uM29kYTVSZW1LU2RvYXl4K2o3MjBsZVdYNFFtYllC?=
 =?utf-8?B?NXdTWlkzTU1mVDNDOVkxREJDcm5mUUhTcDMrQVJtdFBPM3poZWNyc3VadzJ1?=
 =?utf-8?B?RERtQ2daV1FYVkZwTUxkeVZBeVNtSnBRM0lodExiVktmaUxuajExNmpGeVlO?=
 =?utf-8?B?dnVWZGhMMUh2OXkxOVJHdkFOZllxUFIrS3RXWlp6aFdja0V6QXM1WXFQd1E3?=
 =?utf-8?B?eXp5MmVHWmYrbjMxSVZkNVBjUXU0RUVsWWx0aXBHUGQ3ajVTcnZqWXFnMGJj?=
 =?utf-8?B?anBMajdxb3BBUEdUdzhOZXM4aDdBUGtxTzViVlBaUFVqRkR4bXdxb1BiMXVP?=
 =?utf-8?B?eEtuNEx1YVRESWlVZG56Mmx2dWxmcFRJS1hSS0tMQVNQZzVzNC9qd01hbUxW?=
 =?utf-8?B?VGUxdkJIU2t4N3VlZlIrc01zVWRhbCtNMmpxY2tMejRPbW9jV2ZoRFZPNmhB?=
 =?utf-8?B?cnZDV2l6Rjl2UXFReUVKY0svdTJUWWdxcFh4Uy9HYUYwa2ZoQkV4enhqQVhK?=
 =?utf-8?B?Y2kxUm5hU3lDTmthLytHS1BCN1M1dWlFbjVDQ1BOWGJWbUhmZVZmeWo3YzVy?=
 =?utf-8?B?K0xNSVMxc0ViM0hTenNVMG9oZjV0WlpxRjBqdU1UMWJJeU9nU1hraHJqd052?=
 =?utf-8?B?K1oybDRZZHo2WC9rRkcxb3JtRUllaUZ6MXRLNHFMeXduTGl4VFpHU2FrZ21V?=
 =?utf-8?B?ZDgyQUFKbUFUdkVtUDRsYmtPWFA4ZXZ6NytOYTdzem80NWY0MlNDenRERGw4?=
 =?utf-8?B?MVJ2aUJwSno3VXVOYUw5Um1lR2hzU2VPQ01ydmFxdTNtdDJtdERROGlUVDlx?=
 =?utf-8?B?aHRvNzdCVG1JaGR5QUd4NVV3cldIUGd0bXljZ3ROd0pnd2VyWmhNSE01S1NG?=
 =?utf-8?B?ekFJcjdrOG5teGYwaTNSU3hwdkY2SGNqcm1kU0RSUlpmUFdqWFBiV0h4anBo?=
 =?utf-8?B?bW80N1J0c1dhWjJCMTFjRC9MSnVSaTdab2R6ZEdwRUtuMzdXNXdqY0lLQmdw?=
 =?utf-8?B?aEx6NVd4cXRucUZ5WWppWG02MktJWHdKZEk0UWhuN2pqamU5d3dJRVQ4V3lG?=
 =?utf-8?B?VGMrU0c3WWdSR1BrTzZxQlhTVFF1cUdCeXBORm1Kclk2WTRKbnhkT1E4Z3VE?=
 =?utf-8?B?VXZTK1hjU21WWWlFZVg3WitNS0REZ2sybXVWZldvdDJVY2pCM1RwbzVHcGdG?=
 =?utf-8?B?aE1WdGNnaFdMSGkxZk9XZlV6QXE1Y3ZvMHQvNXJaNEhpWjg1TmhkS3JSU1hS?=
 =?utf-8?B?NTVicWVjaFh2R2Z6WjhldFcrMXRvWlkvUVFmd01LMW1ZU1hkd3RyUXBxeHhJ?=
 =?utf-8?Q?N3fbk7r1K/D3sLF9uffYcfrpqJY4f1y5mODnYRp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1zNG1OM1YwQmV5ek13d0xTMCtFVFY5akpDb0xGSHpuSUM5SHNTakRtMHZL?=
 =?utf-8?B?cEdMdzQrNHBSMWtwMHZUdzg0OEtzYk9rVFpCTVRDdEhHdFpUYkVlSUJzd1pK?=
 =?utf-8?B?MkgrcHVGV0xnTEVQcmdGeGRIekk4TVBnci9UMXFzWGVJNnRKTDIvc0JVTXB0?=
 =?utf-8?B?VUk4ejZmL3BzNXNFbXNWWGdiRmVBdlVyTjBsTTJ5Uk9oaHNrT1ZhVjI3blFJ?=
 =?utf-8?B?eWRUdFlEVkd3OUNLZVUrYW11SjV2UkkxaFlVTEhpSDd4TjZKK0Rialc2Mmln?=
 =?utf-8?B?UHB2Q3I1L2VkUzMrbk5oZDdvK203SitDRXhlY2dPQmtsTVZvRVRyZnp2WGJv?=
 =?utf-8?B?SS9GQzFkYTlhMk9zblo1Y2NrVzYyY3RnT0RZaFo5UjloaHZBWWh5cDl6MVdq?=
 =?utf-8?B?TDBMdkQzR3hEaWdvTjNZWnVnemRuSUc0Sk9OUHBtVCt2RUh0TDV4OHExWVBz?=
 =?utf-8?B?NkpLTzF5VlcwZVBRUy96aHlmRWtVcVZGS0VTVFFHb1ZZa0pXMzVZa3MxcmVo?=
 =?utf-8?B?U3A3emxZOUh5MUx6bHpnRGxENjh5M1Ztd0JKc2Y2eG81RllYdDBQTHhRL1Rh?=
 =?utf-8?B?RXF1UUl3RTBRUlJXY0FEQlhXellla1RYU2txZys2cDN6WTdodlZBZ2ZQZDlu?=
 =?utf-8?B?WDdRejQxc3lXK29uVTRCNUxFakJVWDEwYzJENnl2ZjR3NWFEeklSSThJcWdR?=
 =?utf-8?B?RC8rUzV1TmRJTjVRV3BsblRhMndxaWw4WWZUNnp3ekR4V0hCcnpqTmdVSS84?=
 =?utf-8?B?SER6dlBpTDVNbTNVSUR6ZC9PaGFJRnVENGRqODRQQmE2bTgxdEQvK094UjAy?=
 =?utf-8?B?aU5KdGk1TWYyVThOcGN4V2k2Y0RYbjVmdzRTSnM3eGxFbUpwOXZOaDk5T3NN?=
 =?utf-8?B?ZGVkd0dzZzRLRFFvNzk2NEQwVkdKZWs0c1k0N09mYjZhcG1oM3kzUms5RzNo?=
 =?utf-8?B?QUYzS1Y4R09PMldoRDRsYzIzdEZIOXRuNnkySjRucUJyYkphd2dZcWdPc1ZV?=
 =?utf-8?B?cXpNTGZnVC81RHpKWXhiVU00b2lMc2NRdEdvU3pCQURsQW9WRnNxemRHM2V5?=
 =?utf-8?B?UFZUVjRwUm8zY25GZTZuRFdVdjc0WXFicEo0QjdnWTFDMDRDWTl5WDhmcElS?=
 =?utf-8?B?bk5NQ01WWnAzeXRSZ0o2R1JTenZGbkNySlRSUmRFWlRMb3N0WUdVT0UvUm5p?=
 =?utf-8?B?anY1K2o1NnVYM2pNWUFsRU9zNjVBRG1RbUpPeDhBUGxXYUd5S0pBcTl4aURF?=
 =?utf-8?B?WUNqNDdOUE9oQkMxYlVvQk5Rc0Myb0NpK3VUVWRUV0RHSllmWUZhM2dFRDdi?=
 =?utf-8?B?MDBuTVlSRFJ0cGp3THpkMDkycHlOcCtzNndSRXgzYVZ4QjdWVURWcXhZV0pW?=
 =?utf-8?B?RFBzc0hYZXYvNEQ3K3BuOFRYc3NZcStpRmRTQWE0M3g5QUswUjc4TzdOSzFR?=
 =?utf-8?B?ZkU1UE9ZUStKaytVcVFUWFZrVW5qV2tZU2I2eGNxc0lGaHFZaVhxdmdIdjdB?=
 =?utf-8?B?NVRrWUV1a3h0NjB5ZC80eUNNTXdtcTA1MmZ2cWl2b1g0WDBhN2JPZnRndDZw?=
 =?utf-8?B?emVHVUF5NCtpLzJaOVR6Z0FnMk9nRkpkUTYrU3loeHpZRzRLMWsrRjJQaU1m?=
 =?utf-8?B?c1VaYjA3VEN4MS9tRUZmbFNaNFUwTWQvNVdQMDIyazhTUWc1b3I4WlB5Q0xM?=
 =?utf-8?B?MVRaNmZYQ01iK0FiaDIvUjVBWkM2MGovRStzd1RRM3FkRWI0Q3dTc0dNS3g2?=
 =?utf-8?B?U2JOTXZuMW90Y2xJaHRoZ1loN245TldCZTNZcmU2ZDdWTjVsM2xtZXlRMUFH?=
 =?utf-8?B?emd4Z2xCOHpPeVFuQTI0aU94UytmZUc2dWIxcUhZaEpZRk8yUFRLbm5iS1M3?=
 =?utf-8?B?a1V2OTFWcjdiakNmS3hDTWxXRVhqbHZrR0kvYmJPTFFFbGVLczV4dStCLzha?=
 =?utf-8?B?TUlYSGxzYldZTC9jL1lueUpqOUtkT0ExQzMyM1M4TjA1c29VczkrVVozSDFp?=
 =?utf-8?B?NG5UUUxJSU9HV0FlVVZWQU1yUjc4b0t1ZjVCTGZESVU5anBTcEREUldXR3BM?=
 =?utf-8?B?aXNwUnhEK29BYU1tbW9DZkY4Zi9SYkUrbFJYSnFidFQ4UVNpLzlEZm9xS2N5?=
 =?utf-8?Q?mvPc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca11425-d5d0-499b-9828-08dc9137b8ac
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:46:08.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnhNcc6d+VdLuvc2yjle26eRtvOFpmUPjGt5mfI/lf3ou77TiN34fMuL/rylIUPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

Hi Reinette,

On 6/13/24 20:50, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> Enable ABMC by default when feature is supported.
> 
> Why enable/disable it on every mount/unmount cycle though? Why not just
> enable it at the beginning and only change if requested by user?

I think we can do that. This needs to be done at __init
rdt_get_mon_l3_config(). Will let you if i see any issues with that.

> 
>>
>> Counters are assigned automatically on group creation. If the counters
>> are exhausted, report the warnings and continue. It is not required to
>> fail group creation for assignment failures. Users will have the option
>> to modify the assignments.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Few name changes based on the upstream discussion.
>>      Commit message update.
>>
>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>      ABMC feature by default if the feature is available.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 69 ++++++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5ea1e58c7201..f452b6d9bb99 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2756,6 +2756,7 @@ static void rdt_disable_ctx(void)
>>   {
>>       resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>>       resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
>> +    resctrl_abmc_disable(RDT_RESOURCE_L3);
>>       set_mba_sc(false);
>>         resctrl_debug = false;
>> @@ -2786,6 +2787,8 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>       if (ctx->enable_debug)
>>           resctrl_debug = true;
>>   +    resctrl_abmc_enable(RDT_RESOURCE_L3);
>> +
>>       return 0;
>>     out_cdpl3:
>> @@ -2882,6 +2885,41 @@ static void schemata_list_destroy(void)
>>       }
>>   }
>>   +static int resctrl_assign_events(struct rdtgroup *rdtgrp)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    int ret = 0;
>> +
>> +    if (!hw_res->abmc_enabled)
>> +        return 0;
> 
> resctrl fs should not be peeking in arch structure

Sure.

> 
>> +
>> +    if (is_mbm_total_enabled())
>> +        ret = resctrl_grp_assign(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +    if (!ret && is_mbm_local_enabled())
>> +        ret = resctrl_grp_assign(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
> 
> This function needs a comment about why it is ok to return with error and
> partial changes.

Sure.

> 
>> +    return ret;
>> +}
>> +
>> +static int resctrl_unassign_events(struct rdtgroup *rdtgrp)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    int ret = 0;
>> +
>> +    if (!hw_res->abmc_enabled)
>> +        return 0;
>> +
>> +    if (is_mbm_total_enabled())
>> +        ret = resctrl_grp_unassign(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +    if (!ret && is_mbm_local_enabled())
>> +        ret = resctrl_grp_unassign(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +    return ret;
>> +}
>> +
>>   static int rdt_get_tree(struct fs_context *fc)
>>   {
>>       struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> @@ -2941,6 +2979,14 @@ static int rdt_get_tree(struct fs_context *fc)
>>           if (ret < 0)
>>               goto out_mongrp;
>>           rdtgroup_default.mon.mon_data_kn = kn_mondata;
>> +
>> +        /*
>> +         * Assign the monitor counters if it is available. If it fails,
>> +         * report the warnings and continue. It is not nessaccery to
>> +         * fail here.
>> +         */
> 
> nessaccery -> necessary

Sure.
> 
> Please elaborate why it is not necessary to fail.

Sure.

> 
> 
>> +        if (resctrl_assign_events(&rdtgroup_default) < 0)
>> +            rdt_last_cmd_puts("Monitor assignment failed\n");
> 
> How will user know that there is a warning? This does not return an error
> so nothing will prompt user to check the status file. Perhaps add a comment
> in the docs to help users at least know that this exists. Another helpful

Sure. Will add text about this in the documentation.

> thing will be to have the counter return "Unassigned" if it has not been
> assigned
> since users familiar with old interface may see "Unavailable" without
> knowing that user action is required to get a working event.

Not so sure about interpreting hardware reported error.

> 
>>       }
>>         ret = rdt_pseudo_lock_init();
>> @@ -3214,6 +3260,8 @@ static void rdt_kill_sb(struct super_block *sb)
>>       cpus_read_lock();
>>       mutex_lock(&rdtgroup_mutex);
>>   +    resctrl_unassign_events(&rdtgroup_default);
>> +
>>       rdt_disable_ctx();
>>         /*Put everything back to default values. */
>> @@ -3752,6 +3800,14 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
>> *parent_kn,
>>           goto out_unlock;
>>       }
>>   +    /*
>> +     * Assign the monitor counters if it is available. If it fails,
>> +     * report the warnings and continue. It is not nessaccery to
>> +     * fail here.
>> +     */
> 
> Fix copy&paste here and below.

Sure.

> 
>> +    if (resctrl_assign_events(rdtgrp) < 0)
>> +        rdt_last_cmd_puts("Monitor assignment failed\n");
>> +
>>       kernfs_activate(rdtgrp->kn);
>>         /*
>> @@ -3796,6 +3852,14 @@ static int rdtgroup_mkdir_ctrl_mon(struct
>> kernfs_node *parent_kn,
>>       if (ret)
>>           goto out_closid_free;
>>   +    /*
>> +     * Assign the monitor counters if it is available. If it fails,
>> +     * report the warnings and continue. It is not nessaccery to
>> +     * fail here.
>> +     */
>> +    if (resctrl_assign_events(rdtgrp) < 0)
>> +        rdt_last_cmd_puts("Monitor assignment failed\n");
>> +
>>       kernfs_activate(rdtgrp->kn);
>>         ret = rdtgroup_init_alloc(rdtgrp);
>> @@ -3891,6 +3955,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup
>> *rdtgrp, cpumask_var_t tmpmask)
>>       update_closid_rmid(tmpmask, NULL);
>>         rdtgrp->flags = RDT_DELETED;
>> +
>> +    resctrl_unassign_events(rdtgrp);
>> +
>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>         /*
>> @@ -3937,6 +4004,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup
>> *rdtgrp, cpumask_var_t tmpmask)
>>       cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>       update_closid_rmid(tmpmask, NULL);
>>   +    resctrl_unassign_events(rdtgrp);
>> +
>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>       closid_free(rdtgrp->closid);
>>   
> 
> Reinette
> 

-- 
Thanks
Babu Moger

