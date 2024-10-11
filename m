Return-Path: <linux-kernel+bounces-360430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DC999ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F43F28220C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9091F4FA2;
	Fri, 11 Oct 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rEcKCQe3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE8125D6;
	Fri, 11 Oct 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728615972; cv=fail; b=spJw79E0rD6ornXTslr47q9iBmtMLmf2095xYf2GUT9PRj5exaOTFayeVuFrx8qnFja7aTanAAL3pbEltGZPazBiksNdQkShDQk3yEoP8XAuYpHdF/KUMU3XmB/CdkVEYqrGcsY+leZJg7C/N+LkUBZZh21gwdDCtR0pHUk6pNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728615972; c=relaxed/simple;
	bh=i0AAU4GcBJCkrqIQADYV/Gz8rA0riYqdZyShg78OO1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nss+p0ZmKa+/QGg006bZXGbxTFRDOn4XWELURue2wEJVTa0qaYVHh/Jg05yvczg17ykLsxSRP7iSYOf0vX2+jYmNYawFu7KSmyw3I9IAVlQXNb7WAlOCUQ4doGcN6wGAWeJQDEQZIBapie2psIyk3l/3cd42yqD36DTlyVf+gbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rEcKCQe3; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFDIBVv9lht6LtSOTzDDqnJEjwUeVw6zfirBVFRnO8eEg0pTVAZmN0PIEb4qEr4wZq2nS5YH3iSiV4Lgtg024xvMgbuC3TOBIvbCGGFE5YgeENWVPGiSwRoCkyh4qyLacJchfTHBafhzBUucWcp0pSCuDHIeqYnms1ijDMpFrlFImee4YYPokHAJlizwUtabf+vzm5cpv7UukpI43uPk7qeRP/SZkuxZOG6ecdckchzbKOIJJ0AVk8WPCUrWdyeRN8mbGM6VqnwkMCNjXyNOAD+VCYWkCrFQyhZKFWPsTy8SHx8+q3YZ/LOaBW/CI/fshk+9FqKbG8cmjeO0BbOl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7MbwuDXYZcvdgPmuwi9HcHzgBrCFwqTnwlgVlyARr4=;
 b=t8kq9qGko4JH/KP13SzMhk+saCuNsguNPftHI51BVyCj6Y6+u0WU40NfMR7n6mG6WuSN0f7od8gOFDALpPlpMMeyPMw+ISZFhb+Gp2sCUOlNipdRK8uYXHsrEkDUALYiQezsw+qZ+gRK7APDDvO25y8CZmKpWCHbw3JaaBUeVacorwVg5ZWZWrJ4luPLi4R4SV5AOlVwB5xt4z/4JWwawnSOQb88icDwqBWiVxCk7Kg3iD7x+nKWK6BH2w5V6BcmZcVP0uXyrqaMc11B0pcosGR7KpiRStng1dEyC5Al23Mf+3XZm4VGipIkreR0Y6UkaAZCxDOo6TmZpaR53iFJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7MbwuDXYZcvdgPmuwi9HcHzgBrCFwqTnwlgVlyARr4=;
 b=rEcKCQe3GEfthCfl6aIAoAAQ1mUXrO2UiGvAoqVv/vG8iDv9nKcEbIckVtxs7uKfiOm/Gh6kHLK0/N+zkUTityhUCwol9bCl1+4ip2Hbbdo2O8zE1vrrZ1V7LyLqbRvpmmvExWvbQY0tN+h6u70Hspwa+qN+eSx676V9Dsd0IrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 03:06:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 03:06:06 +0000
Message-ID: <a1acb975-c29e-4c90-b7a9-5f50478ab946@amd.com>
Date: Fri, 11 Oct 2024 08:35:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drm/amdgpu: Fix off by one in
 current_memory_partition_show()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <f3cf409f-2b04-444f-88f0-9b4cfe290667@stanley.mountain>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f3cf409f-2b04-444f-88f0-9b4cfe290667@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c38b589-0d6c-435e-fac4-08dce9a1a5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHo2eGdrWmo1V1NBZU5QdHdDNFQyWHczM0o5dytUUVBoY0ZwVmR5eE1MSzl3?=
 =?utf-8?B?OEthRm9wd210UFNpaUJrQVQ3TDVnMmh2K3hNckdiOTJtc1o2SzJsVDNNRTVJ?=
 =?utf-8?B?THh3bXppODZvekh5bmtRYm02cmpLUmhrUEtXTm92cGpGbXVXYUlEQUxvWVU5?=
 =?utf-8?B?QTlHSGxRVENRWWlGRy9zK2VZU2VYUUx0RG9QZEhRV1lWdHY0Q1FiUDhPTTZq?=
 =?utf-8?B?VGNwNlEzQTEzQVlJd3hjWk1UNXhlS2p1WDJUVEFuZHp3aitLb1BucjV2SDVk?=
 =?utf-8?B?TUk5TXRwT2h0TkoyMDFBTDlwWi9kTnd5Wk1NTDB2QlJwNTdGcGRQZGhDbGsv?=
 =?utf-8?B?NXM5QXhONlFFQXl0SlJPekZqSW9LUWdudFhSVkZiRlUwSVJ2NWRxS2tia3pB?=
 =?utf-8?B?RndZWkRCYnk2a2RhbWpNMEV5UlYyT0VKOGttYmtHYU5RRFhJeDFhM0x0cnhF?=
 =?utf-8?B?YmhteS9FM01TcEh0a3RMRTd0YzZzUVMwN21xL0tlRjhmNTRmTEdkVW5MblJw?=
 =?utf-8?B?ZHFOalQwL3BneTlUbzRDa3ZnQ2NVUFdkNTZMbUhQOTZOZUt6dFRCb1VETU5I?=
 =?utf-8?B?TnFQSnhWZ1RoL05VRURGREtHNTNwaUc1SW9pb1JDSVFHSkNqNksxcVc3Qis5?=
 =?utf-8?B?bWNLMzVnYTF4TDVZRmJDVE5xM2o1Z3M0ZjBvN0xpV3IzM0FjandFRWNLZmY5?=
 =?utf-8?B?U0VVZTJIbVFpNnF5YzR0LzFZZUJOem8yT2c3UXo2Q25nSkRHM1kwN3lhL0pk?=
 =?utf-8?B?Q3VuNXJxaE1VWG5RT2hrUE1LdXE5WnhqQVIyLzhBMXFIb01xY1IyMjhtZjZa?=
 =?utf-8?B?eXFoRmZYZFRpOXZ0Tm1hVkJNeDhCTXE5bXJ2Y3JMeDhuSDNvV20wVVI1NmxS?=
 =?utf-8?B?TGN4S01ncE51UDJQQ3BidU8ycjNvRko1RktPSWh6NUJ3NHR4RVhjbDI4YlBB?=
 =?utf-8?B?NmdDZDRDWUFVRHRCNHRMWktYSnFCK29zWU5zd0hya0NETFhGellzQTJIZFZq?=
 =?utf-8?B?Mmd2Q1IrNFU4UFA5dVlKcG9pSEJSOW8yVEpOT1hGYkx0NzB4OE9sZGxMYnk2?=
 =?utf-8?B?Q3JxMkpqTWJRcm83ckpvS1RPSlcwUlZOeWdkcStsa1gwSUF3a2tqVUZZVGRI?=
 =?utf-8?B?dnAxdkJ0Szh2aTRGWU5qc2N6Qk1uRGl0WVZYYnFRYkhrOTJlZUQwaTNheXc2?=
 =?utf-8?B?N1kwSW4xeVJ3TEhhM2JndU1nMWJLSjI5aHU3OVlwL0lscjhZNzV5RmhXNzZm?=
 =?utf-8?B?M0IxdjJPWnBXdDJWQXlCQ3BXSGc4R3RyTGhac3lncUFZQ0k2UlQ3ZUxlYklL?=
 =?utf-8?B?YlplZUV6cGJxbWJBYW5Cb1IwYTZldHVNdS9QcHpNYndza3ZsaEJyNXcwUGdu?=
 =?utf-8?B?TWJ3emFkbnRyYnRYWGQwT1lNUVF4ZWZYUFlBT1NZNUVtb0JLYjRTcUhuR1dj?=
 =?utf-8?B?NlRmSVJwUno0UVZEekNjbjJmbHROdEUwQmsvU0VPUy9qZ1c2QVBxMVpsZ0Z0?=
 =?utf-8?B?YWV0NW1PZ3greXRvRkpkbUFDTlRndWVnYlo4NTdPM3JVeDhMQ2NMZU0vRjh1?=
 =?utf-8?B?ZzhmdHR2aFhGZnVGbHZEVWViblEra2lPdjNraVRRMTNsdDAza3ZGdTdVclNn?=
 =?utf-8?B?RWIyM0hnaks4NXUyT0FWT2lDWjZKRkd6RU94QkcwY2I3dXlQK3NUUEYvYmc5?=
 =?utf-8?B?QXZHU3JWcmkzeTl2UFdEdTBrditGYmxFbkpHTDBUT1Yzd2xLMkZnNmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M21pS3MwNEZyYk45SUhxS0I0MXd4Smp0Z3BkTnJVaXpGeVpWR0xKVkpkUWlo?=
 =?utf-8?B?cEpvbVdGSTltMWNXZW9LV2NHWEs1aE96YWF6Ym95d2o1c1VRVEdFS3dqWHAv?=
 =?utf-8?B?RHB4VStoYzNQYjNwYWZ4T0NReDkvQkluMVNEdVFSMFVNb1VxUWZXMmU4b0gx?=
 =?utf-8?B?eHFrNmc0TXVXMDZoYWx5ampHS0xQKzBGSUZDR2ZqaUQvRDBiaUpMMFAzRUg5?=
 =?utf-8?B?REZXSnZ0K3o4M1RzT08zVDNjb0NrcnhPbDdRQUNvbVU0WVJHVWtPTjkwcDQ1?=
 =?utf-8?B?YmhnMklqTzdDd0tZc3BGWm5YaWFiMzhYZUtSNm9GejMyTjQvd095UU80THhn?=
 =?utf-8?B?Q3dWV2lBUTgyQXZuYTlRbkpMUWx2R1h0a1RvaXNCUDNiZ0VRbkpBdXg2WWJK?=
 =?utf-8?B?eHJJSFdVOG9TbTVKdVhBTU43cFFiL210SXlYQmpsYWJTUDQxYkp6V05GallQ?=
 =?utf-8?B?SEpoQjNIS2k4SllDSTBlRU0xcGFhVDhUbUEraEN2d2JTOXJiaDFBa0dnZTI5?=
 =?utf-8?B?N25VNm5mMDVtNytOSDFMMGJxU3RWbmhBSzRwK2tkbTJOVlh5dnFsbXlDV0NK?=
 =?utf-8?B?bDFOYmZJeWlQZ2hKMm1Yb2l2WDhYVERJNFF1OXVzUVBBYXczb0NLU0lwaU82?=
 =?utf-8?B?UFZJd1hCU0tTVWxMQW81TysybWJBOTh3MmZkOEhOZStDZUR2SWd0RVJSa25I?=
 =?utf-8?B?dHZ5QUwrcG1jajIrMnQ5cnU5Nk9nM1diMTI0M1NMZ3ZQK2hIejQ0TWh4S0xR?=
 =?utf-8?B?WWpqcThnT1djanVSNHJwRlFPMWhrdnZZZ0ZlbkxiYzYydU1QZG8xalhDaTdj?=
 =?utf-8?B?Y2toSTQ2Z2VYcStUbi9qRkkvYmFVVkNWUnlQSUxJaWUrUGh5ZnlHUFlqMmFr?=
 =?utf-8?B?NFYwTG9SWmtZZXNmelFBZzA1OFExU2U5Y0xJVzBya1hBcmlNMGQzTnlBMURO?=
 =?utf-8?B?STJHdEZ0d2YwdjA3RkFYZGdaaHZ0OVFidGxQSkdIOXBJbDdkelNDK3JiSklG?=
 =?utf-8?B?Y3ZJVWpmOXdIUWE3WmFGN3djaE16eC80dHc2dWt2WUs0bDY5UXh6bmVHd25W?=
 =?utf-8?B?TGFaWk84UENrY2dLMXAxenhaQVdnaWJhcVdTQWwzWkhBU2JYNHVEejljMUFv?=
 =?utf-8?B?eG1mUWZhRTlPK0FyVnU0ZXBVVHhEUTJJbVBsekJrZ2REVkVDNTBJRG15aHZR?=
 =?utf-8?B?Rkd1ZGMxYU5nYUpkOWpaeisrMXlLdi9HRm9BMUZwRCtzTFlkUlplRUttb1lR?=
 =?utf-8?B?UGozVGNSNm5tcllUMnExRHJDYitveDlVQlF4R1hKV3MrNDhzUnJCQ1hIY1ph?=
 =?utf-8?B?ZTNrdUM0MmZCODdjTUhyNmwyNWQvclMrRnhXQlA1NGdWZFpXdWFjdXpFLytE?=
 =?utf-8?B?NlBTUVJTcjJldHl2RW53YXIyUlNWbXlUcHdEbzFyQjdlZWlwdmd3aXRKZGRY?=
 =?utf-8?B?ODdOUGF2OVkxTDlPYzRHcnNBSHZ4UU93ejFrV2VURE1JaVcrZTdNWkNuN0Ri?=
 =?utf-8?B?M05QcDQ4NEx3d3pCbFQxWWVDcnJralhERTl6eGZDRmgwZTZEaThta3hZVGdL?=
 =?utf-8?B?UGo4T1AyM040VzJuN2UvZ3ZpeE9hTnVYR1ZZemtScElnQVFKeExPWlJKbjFt?=
 =?utf-8?B?c2hLTCt5YWpkbnQvbUcwaExXZTFYVUJJc1NMS3o5NUFUcXZ6VkQrcjNlRDhz?=
 =?utf-8?B?YmFYM1lQNmExS3N4dXl6ZXQvdHl4YnpWRTNjMDM3SE9kS1h3VVZPT010VzdK?=
 =?utf-8?B?bjFpN0NWc2d2bEpiV2l5b0VRZEhLOTluSUNXMXFZWUNRT2FuanpVSUJWS0Jm?=
 =?utf-8?B?aUUxWGJyRDBLbEoyV3RTRUowQ1liQnhvR2JlN2RieEFZbkQ2NjQyZTF0SVBH?=
 =?utf-8?B?bHhTVVpPZFZiNEF6RzlKc0l6VUZINlJONHFHRE9QR0JUUitlWGhudzlxU3BM?=
 =?utf-8?B?VkFsTTY0VlNmTzRzRlc1R1VDamsrNTNac0J2YXNubHo5akhpWHlseTJVSWti?=
 =?utf-8?B?YXdDWFhUczJ2SGNrL05oWWRCV05UaGFDOVlPQWppY045czhuVzAzMU1QTEN6?=
 =?utf-8?B?MTQyVkIrZ20wc0Y1aU1UVDBqVWxkdm14SStNQy9MUHNDaHBlTjVoSW9MUWsz?=
 =?utf-8?Q?XFUHuaHtODOvVpIDta8BmXVdi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c38b589-0d6c-435e-fac4-08dce9a1a5d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 03:06:06.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kKhqBUVO7KJUcfjzZlvqdyxxRjiqRfsfX/PLGhX0u5DQMPzeOLIYUI+DrH+Br4y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564



On 10/11/2024 12:05 AM, Dan Carpenter wrote:
> The >= ARRAY_SIZE() should be > ARRAY_SIZE() to prevent an out of
> bounds read.
> 
> Fixes: 012be6f22c01 ("drm/amdgpu: Add sysfs interfaces for NPS mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ddf716d27f3a..75c9291ac3eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1199,7 +1199,7 @@ static ssize_t current_memory_partition_show(
>  	enum amdgpu_memory_partition mode;
>  
>  	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
> -	if ((mode > ARRAY_SIZE(nps_desc)) ||
> +	if ((mode >= ARRAY_SIZE(nps_desc)) ||
>  	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
>  		return sysfs_emit(buf, "UNKNOWN\n");
>  

