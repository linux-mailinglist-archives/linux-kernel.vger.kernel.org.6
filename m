Return-Path: <linux-kernel+bounces-334213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE197D40B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798AF1C215D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945524B4A;
	Fri, 20 Sep 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3l7KGk3"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903541BC49
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827389; cv=fail; b=VM6YlZrAXhWo0NJiSPdBNn2cn9/9wxeXIc0HmIN7z5kns6HnvaE/ilSCzjnZKHuNP6KDqK9NiByzTOI2yeiK6ajwIykn1KciQORJbkZOv7Jty5ui0c5qOgo/Eo8J4ajLlgm1JO1NhvDvMpDYP2BBBDnZfgy/W13T6xxRfYAYG4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827389; c=relaxed/simple;
	bh=rswKvHpVa/JMCPVaJQKMJ4MhXnP1+WwXQfqBa8Hf6wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YbqvTMuASmDBnizzwTMiWbH5hyLpqW74TEpr7d3ruBP4Zg8/bx+tWwgDA3UaF6hQZIfEE40QqEPgfTFnbfSqrzDRHR5oAq6acX9cas9JLQFOJLDO4Bkz0Ee3JPl5AYAS3GsA21T4vU+eVOJ2o06gGbFzDSklKGaSGvu8n58EtCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3l7KGk3; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQnTohw/sUC60bZ+52Q69g2Cqw1LI6xhq0lqQO/Zo3nhH7WJiKNn/viBM+1MSjuG4OzgyjpQVJXCaJbfv2pyiFNSYOwEuwpxjb/ywY7r223E7NQTW9Tr0fQyWeCrxhTtvUG0OK15hMc0lln7+zdub9MmkLCzluZXkiWgHCmHnIeMrgFe6v4i5ZygZSlNwINBGSyXHmMFuo/GaVh8H+arLY0tnPL36ZuB9wc7EIReWXum1gR3iS/u9/FiLwRwKoE75Fm2WXHp+ZVfNoftwFE4YcrLXsJ33X+XwdyLCbFm1iZaDvAShlX+rqm9rlWN9bwQGAVsV2fkUwYvKRmod+OJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk7fegzQWjJrLABVxeCGxccbHtWyb9bNS/ZhtuiDJso=;
 b=GBhRigIOJcHhoSZv8PFAVG5Hr+VI1jbFzzhJd0WmmVD/FFE+XgX29t7j9/hvrXaCdK+8Y7HK8te78xCgFwCrzZdx4QSK627OOkoyDEYYScMo0YL0+nM4MxRV/ZjgE/08Vu/O4MtvZMRRYb7lJhHJh08Z6ul5aQIICfgpgp5x3H7sSm1xR/1oon5BTt7XW3UKqmEfgGAlcCI5DGl3Ms/sWnlqUvogvd/fiJlplbquv/FezZxclUbI9wMzR56UUIM9VJPnxXMJoWQvIDGgo/+N3DfsuSGSv2i7MySSNHRz9lv4vKrhhX/UA5ctn6oTSDYQtDE4SxDqB9Md0GjB1glApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk7fegzQWjJrLABVxeCGxccbHtWyb9bNS/ZhtuiDJso=;
 b=p3l7KGk3+Z5+N8wf2hZGfFvlTQHdasLWD+LOh0/MKtC+LIXBK+srJmgddp+1sO0moohbFQM/vsRst6iuJgHiatqqYnihr6IXfSfds8x6qitS8nVMD8TVzZFCNV8PGgjTph8jdzeUVaqFdXihG6DFKnrkke4To9s4IejER4fjIwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 10:16:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 10:16:24 +0000
Message-ID: <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
Date: Fri, 20 Sep 2024 12:16:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
To: Dipendra Khadka <kdipendra88@gmail.com>, Felix.Kuehling@amd.com,
 alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240920090959.30755-1-kdipendra88@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240920090959.30755-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b08b25-71d8-4e10-def0-08dcd95d4813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzFKL0JtaFlIc21KbDV4bkJUeGZPT2w0MTJITUtpV2xIMjVBWk50d1kvNnh1?=
 =?utf-8?B?cUJqNnZwTUkxTjIzN1BDNnEyN3RxMU5KdDUxUHpabk9ZdnZjV00vcVhxd0FM?=
 =?utf-8?B?TGthVno3WGRzOTVZaEpmMCtENWVLM2hwVWh6TUJZcWVaQ09EbG1wMVVTU0Zs?=
 =?utf-8?B?Tmk1dElWRWJSbVlIL3RPYzVrMy9Ja0JOSU9jVG1ML0VGMnBUY3dtMlZTblZZ?=
 =?utf-8?B?SjlqQU9UTmxMaWhVTXFwdHpvRVRHcFJDeXZ2UkZCQlRNenFSOHB3TDhmSGVS?=
 =?utf-8?B?UnRoU1Z0QWtXQnlidHVKVFlSVnNGUnNGUExuVitqZkI5ZFNLK0lhbnpIMWNB?=
 =?utf-8?B?cWNhUWlTQVFZTlVFbFQ2RW4yMFRGRmRSQ0dmNjU5UFAwRHk5S0VleHVGM3kz?=
 =?utf-8?B?ODhOVW9hejZQdXdianF1UUlDZnJycGJGVlVNUS9EbUQxemxYWEJicmtBa21K?=
 =?utf-8?B?L0Rpa0MweFlhWmFUS3g4QldLNVZIUVlpY0dQRTgyVDg5dXVhQUZJN2Q2Umt1?=
 =?utf-8?B?ZmwrSnFYU3Yvb0RCT1RhNlF1aGdNVlF2OFI1M0FYYXRVQllZUy93K1p5L3Q5?=
 =?utf-8?B?dU41VWtycDB6V25hNVV6OHpNeW9oSElLOGpFVTBjamszVU5hRDZYdGFQTHYz?=
 =?utf-8?B?OGpPUU9YVVhQNXg5TEhzcWVYRHBGOVRWL0IyajYyVm1tMWtScGwxWjBKbVNV?=
 =?utf-8?B?QjBaSWZzdnpGY3J5ZVU5K2lJR0ZOQzgyOFAzcE5OQjkveFRBSjNTRTh2RVRB?=
 =?utf-8?B?VWRubHI2UFFqck9zWUVWc0ljT2ZNei84S2EwclRUajdJVzlISlBtb2VaTWhS?=
 =?utf-8?B?LzR2RDBwbUdPc01xeDZXVUJUS2xtVDhrSmpwcVFwbytNb3JnWGU5UUhWbnIz?=
 =?utf-8?B?VWpqNFRGODlqTTJ6S3l5UGFOQlBQUExXMkE3azZ4dWU0bXpTL1lzcVo0cTB5?=
 =?utf-8?B?bFZQY0x2ODcrUkdDRDBXS2dTOEdQT09tdHcxTVhDU0ZtZVU3OHZqWDlySjhj?=
 =?utf-8?B?L0d0ajc2MGFHTDErSis0TU5Wby9rOTFpbUdTMWNscGVpdEhVTzc4TXB1Q2Vl?=
 =?utf-8?B?QWs4NHRHS3gvTitVVHJ3anBhM2o4a1VXdU1uYzgxTCtWalhaVWNhTmlHYkNG?=
 =?utf-8?B?Umd3WklWZ3o2R3BlckRSbnlyMkx5QVdybi8xWXdrYjU2SE1SNVFuYlk2VkVr?=
 =?utf-8?B?YTlWTUpyYmQzNFpRaHlDV1MrS2krN29Ub2NTZEIvMTdJTDhZM255TmxISFR5?=
 =?utf-8?B?ZkZBWnpnalczZ09pYU1ic1k5RjVmZDg4OTBmM0M3NndNelBacThNWVlXWllM?=
 =?utf-8?B?UHgzbWpFdjNuQWg4Y2lkam9IRnl2L1RQZkJvS05CVFJEaURYa1Rrcm1VY0li?=
 =?utf-8?B?UlRFTVo5OUNKK2lZVTlJV1V5ZXg5ZFF2aXMxM1YrbWZGRmExTEQzZFdSNVlY?=
 =?utf-8?B?NHkvVmFXVVpHbWoxRDlWYzNJWnFPZXBCeXRvMXU2Z0xhUlhYSVFTUWlVM256?=
 =?utf-8?B?OEUzUjNMZ0xGZExPaHh6SEFXS0Q1TGw3eHVKRkY4b3JOR2sraVJ2VzI3MmJO?=
 =?utf-8?B?U0JJWFJOYmd5TDI1ZmFoVzJnQmRmeVZuWEZXekZUMTFvY3pQcVFzVHdSdjB6?=
 =?utf-8?B?VERUc1pVRE0wYXNJKzdidnZ5SmJ2cHpPaTFpQldSWTZNZWtPYXd0WFVvbGF1?=
 =?utf-8?B?Mmt0WjdBWDU3bWZLTTVSTGpoYWx0dVJRYjVzZG81dDNwcEVxM2tGV2tVeEM4?=
 =?utf-8?B?QmFJbEVmcTZ4Y1ZsZXk5QzZRNTZwd08rb3lyWTNwOTRqSGZEK2gyOUhzZ2RV?=
 =?utf-8?B?WFkyMVdEMFhRbkZvMTB3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHp3dnM4Ri9FMzhNbmM4cTBKbmIza1dRWmdqY3owZzFXZVAzdkhJN0Fsbmhi?=
 =?utf-8?B?YkEvK0pGNndlYTNub0F3blJXVmdqRzBVTFlPaEhrN2NLdisyRXViYk5IRkND?=
 =?utf-8?B?dEkvbk0rNm1FRmQ3aUJ3MmljZHJ0Y2VWbXBvZGNjQWcyNTRqSWVPTEFqUUhJ?=
 =?utf-8?B?ajgveVpKTXZHWXFXK0dXMmhLOEhCZzNFbXJObGRVcG1lNEhLUDZMSXhsRVhP?=
 =?utf-8?B?cmEzU05Pbk9kQzA1citXNGxrZHU3RHNscktkT1NDaUplbnpFcE1VQWxCMVk0?=
 =?utf-8?B?YmcwVjE4a2Z0S3NUWXhzQ1RhalZXVStLei9GRHZ0MWljWS9uSnQwTFg5ZlJl?=
 =?utf-8?B?MjdTSm5aandwb3RTY1gvYlVMN1N0eWtPdkhpWnV4OWdINUZwZC91TkdIL2xU?=
 =?utf-8?B?dnV4NllQVk1tRDdzdVN4czVrMi9lbEFhTGFPYnhQN25QOTJCK2hoQ3cvOFBy?=
 =?utf-8?B?RDRrdFFSL0pMT3R4MHRJTE9oaVU2ZmRNTU5xSSs2cEQrYTlmY2h6U0pWcloy?=
 =?utf-8?B?ZUFxeUcwNzVjc2hjU3VuTTI2ODdzQ2tqNXNXdEdlNlpqVHRrK05McXFkNjZw?=
 =?utf-8?B?ZFpiMDI4a0JDa0lqTjZndjZtbUJSRnJnTGd1T3dGdDYyMjhUUXFORGZ1UkZF?=
 =?utf-8?B?MGtoaVNlRGc2UXRZWTJRbFV5bmFSK0w5a3g4Wlp4VkYyTFZQN2NjZG5yTlVE?=
 =?utf-8?B?V3FBZzBUa3BQZEc0WEx3eFBLeVY2ZklBTUJ2MDNiNmRLT1R1c05vdTdvNU5Q?=
 =?utf-8?B?RE1GQlFSa2pwVTBNc1ExNWRYUWJGZ201OXFNVVlmRlBpWUttRU9PVWRmRXJj?=
 =?utf-8?B?a2k0enRUWWl1Zm0veFZXWDBnQklRSUdWdElDK3NLSk1DL0lWSittdUVUNkVa?=
 =?utf-8?B?aGhhdTJneTNPK3ZrU2s1WjJ3UENTZmV3TUtvR2Nmam0zNTFlMVg4TmpsQXpY?=
 =?utf-8?B?ZWhPTEhucS92WWdxZ2N2S3hqbkVhOVR2M29KckE0SjlzSWhGQWk0a3N0eEwy?=
 =?utf-8?B?NGkyZU5RSGF5WXNYbkwydVZydXpCdDhtdHdIM1Z0aE01STlFLzVCVEUxTWND?=
 =?utf-8?B?TktIeUhQSGp5dHhJeE5IMVEreHhOUk1xN3F6RkJwNEJxUGtoRDBpd2M2TXpW?=
 =?utf-8?B?VUlTTU1RcCs5Z3E3bHdjZ29TYjVQRXdYYWFHeTRIUi9HTkFkbXBzREkyelgz?=
 =?utf-8?B?ZFU5cTFkT3pSd1ZXSURtMi9WT3ZrZHV5T2N6d1JGdm4xejA2RjVyY0Vrc01U?=
 =?utf-8?B?QkpkM29LallVRkVhUEp3dE0yVTVJc1o0dFpKb083OXBac3R2MEFhQlUxZytB?=
 =?utf-8?B?RXZyc09WRUx4Q3FJOExXNGM2RTl2YkdKRWI3Skk3a2hYa0cwUEtPMGRSNTBC?=
 =?utf-8?B?ZFoxTUN3VDhmRWhjaWwxQXVTYnpadmlnRTNUd2lDWW5tSEg3aTB6MjRZbXdS?=
 =?utf-8?B?cU1vSWw5UTZ5emlUMXJHdms2Y2ZVT0RKMUFJdnlNeVZyMXZLTmpJTlF0Rk5p?=
 =?utf-8?B?eE11cVo4WElJWEwrbmJJNjN1MWMrR00rSEQ1YmVNOGRISkpFVHZSaWo3aTBL?=
 =?utf-8?B?M2h6UlhVUEZ6alQwYXdXMWM5MGw4WDdzUElPT2xCWjR6TTN0cWZDeU5paVcx?=
 =?utf-8?B?Ym5ScmllN0VHQlliZmFIaG1tRUs3eW1mZWtob1dnV3RDNHMwY1F4ZExrL3pD?=
 =?utf-8?B?alM5WU1QdnFqdkQyQjJ1eWpybGNRczZkWEorR3BCMUNTcFdTcSs5Vk53S1Q3?=
 =?utf-8?B?NGhRRXZDWXozeTVTMER0ODBkdHN5TVFCNVp1VW52S0pWMDY4T3hlRDUveTVK?=
 =?utf-8?B?OXNSSFRxUWE3UWswa3FOTCs1TlozZnp1dDFUaFY4YkJsM0xPUC9qa1Q3N1Fy?=
 =?utf-8?B?K0ZvdFdZRytIQTc3eCsrN1B4ZktQRTVzYWZwQ1dVd3NxUXpiTjRkTnBDQWtG?=
 =?utf-8?B?OG4xVUVIWHVlMUQrTlM2aVpZYXdPZ2lXRzJaZXdNV0FwbnBxZjVoVWVBU2xY?=
 =?utf-8?B?YnhqQ0lLR1N2WXFDeHlEbW8yL0FXMUYySndnbFozakM0V09heFdlY3FyblRX?=
 =?utf-8?B?VXZLVHc5NjRwL001Z2lDMU0xNysreGNLM3RiZkFNV2IrUlNFdnhLaWtGTmsw?=
 =?utf-8?Q?s2FA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b08b25-71d8-4e10-def0-08dcd95d4813
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 10:16:24.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9EzaTtVKBf7JNw11k+F/cuDQ5c48EGLmSLjkYt0rILJvfWCDxRRLC6Ks6Ut/m/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
> '''
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null pointer dereference: fence [nullPointer]
>   return fence->timeline_name;
>          ^
> '''
>
> The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
> or f->ops != &amdkfd_fence_ops.Hence, check has been added .
> If fence is null , then null is returned.

Well NAK, completely nonsense. Calling the function with a NULL fence is 
illegal.

Regards,
Christian.

>
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 1ef758ac5076..2313babcc944 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>   {
>   	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>   
> +	if (!fence)
> +		return NULL;
> +
>   	return fence->timeline_name;
>   }
>   


