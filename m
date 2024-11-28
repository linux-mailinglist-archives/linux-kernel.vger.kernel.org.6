Return-Path: <linux-kernel+bounces-424106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11C9DB0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964271650C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B71B808;
	Thu, 28 Nov 2024 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UePI794Y"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020093.outbound.protection.outlook.com [52.101.46.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A517753
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732756903; cv=fail; b=hAehDfVVlfQ/+LVJw/0vqFyf2AtrEOqTZE64wS3n3a3FInhfOy32bCLUwpjTuxX6gS6p7derDyNCZbb+7yF9PJHE4ifPq4fA58C3sZpTwnnTiFBIUr6FgEFxBGrjjZWfEo0/FTWpaZzWDohXPdCMJkJyTJjIqhsOCloRBM+Z9TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732756903; c=relaxed/simple;
	bh=CM5zcPAfeHdE/pt+ONpHZIrNn3JWy7SW7xksau3qfo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OU1JIeOH2pI0dr3YWKNYUcMbuTRHt/TqJkrg0V7+ybaOMt0IJDMkxQu7LUgJT9SbVwLnaCz39L8fzdsbaBp5we3J1g7/u1txw0D36Q4xXD1sFRudTn0z5w9yItFt8YEdwrKJs/4tbht9aT3xXixacQbxGAh4YRAA8btz11OVveg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UePI794Y; arc=fail smtp.client-ip=52.101.46.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC/jsBNH8gkl5PoWmDRO6LIRDJtdmVgDWv1LnKWmPg5vm5xWsnuNwCxZKo0HvHDJxSMBujs9JH4H87of3kXarSvXiz7dV3fSnGBVB0elqpeJcLLsLdbHqCINq9frUEPOhgb+I38NhFoDP5zFvpMpQwfevlcluAad//NRHJnEiC1bIM6z9BOHD5nxRD7otMIYFeGqsjv9wM1f7HBquWF9mDyIeyi4iu0g5UCZhWUkB+SOnP5x6/QK6ylbuWbwBB72Hs739MYeAu+FCUysBrd9IhE1E5tDWcVRdSi+sewacSoAc4al9l7D/FVMQik/kkXa8MJ/b49Bk40kqCYIAUs7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxNgOK5WLoQBRf8knyWyPVJiV+zk8KTyCgMuTWX4XWY=;
 b=hABDzD6TkeSma14uzF6btpUgJekOtzGH7wYcKUZM5rAND/bEqxHG14yD0K1KsB1JWOOKsgdVU1RoIUnKh8/3L/eaZICPCaMgE2k2gzErelb/Zp5CBzS/ShTdPLboBE+cBiotvPzuo7L39oKamYYd7MScGSzcXpYjC7wyMD3mAAmOsmrSd3jKcpY1w3boY6dYt5fbyEUZt2h0kvJkcCLkOtEpX1disrqBn9ACJgI+zOJ24B88AMzVlq7xuoZJzbiShJO/efeJKxUVKqd9fK8+SiHJnYSje4JOhD8rQ7csmhii3hFP73m3iftz64/VRdk7K7IfUcf1GRXcVivlQw1jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxNgOK5WLoQBRf8knyWyPVJiV+zk8KTyCgMuTWX4XWY=;
 b=UePI794YW9VXgKywfMRdc+uf6jI6Zp2VJoYTmYrjquh2o1oIrjNL3CUNTWBo4fBVaJLi04ANGLSt0Zh5+YqHQn0dH6muiGSmPC1MMy4pdjdf8LYp0M9URONn7L7VsqiaGLGNThSQ5WkdSusLZ0O30FHDIStgQHRxlL6M2dAdz1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA0PR01MB6108.prod.exchangelabs.com (2603:10b6:806:e3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Thu, 28 Nov 2024 01:21:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 01:21:38 +0000
Message-ID: <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
Date: Wed, 27 Nov 2024 17:21:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z0dhc-DtVsvufv-E@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA0PR01MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: aaba4f8c-faab-45fd-f834-08dd0f4b01b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGlVd3N4bk5SYVlvSFhTRUpyUWxPQm05R1BPTjFTTStBRys0eDlGYm5FaEtH?=
 =?utf-8?B?Yi81aG1VQlFmdGFhNTB2U1h6YmZFSDV2cSt1Uit2b0FnTU54UWpEUG1oT3or?=
 =?utf-8?B?MnJOTWhwNDVXQ0hFQnU3d1JGcldRdklyYjRHQVhORXl5ZVZualVkakFib0ZT?=
 =?utf-8?B?RnZGM3F4bmZBMVJKMWJFYjdwaXBCV3VFcWhWMW1tWHQ1R0NJYmFZSStaNkk1?=
 =?utf-8?B?RWlBc3kwUFFhc1R0N29LMFlTNkhZbHpBakNuTjlYWXMyc25sMTREWkVyM2Uw?=
 =?utf-8?B?ODZOMDd5VWMvK3F5YVU2NDV6MG14YXNXMDc0bFIrMWNUMWFuOUFiRHRqWkI3?=
 =?utf-8?B?bmR5c2VGaFZHNW5naHI3QXlUby9zMThnZmFlZzJOSGlaQmUzcnBrcUtVNTlO?=
 =?utf-8?B?bHRCZVFXbFRYM0gxTk56aURHbFFUNDdEM1RmMlVFdHdOZVNtL1N5MVVGZjRv?=
 =?utf-8?B?ZE94ckh6Z1JTWkUyVUkwT3QrQlk1Z05Ka3hLWWdqTWZEWlJFOVRzNCtFL2xR?=
 =?utf-8?B?Q2dxbHVKREtsSzJ0dkh6ZmdnZDNyWUl4WVBXNFppa2hJazY2bHpBZ3MyT0lG?=
 =?utf-8?B?d2NtQ3ZsNUgyamFNMUhkdkxZNHd1UldpcW9VVmU0ZlBHUHh3b05jR04yK2ZS?=
 =?utf-8?B?VVhOUHpwWk8xY1Y1UXE1QWpoS1FHTWozRXQreDdCRk14TEhBN25NbEFjYUVY?=
 =?utf-8?B?NENQa0ZtMkVaMTE1UklQZHE4VkNsZGk3V2hZWmFOd3ZZSFp3SlZhQmpVQ2lI?=
 =?utf-8?B?U1VJZ3NPWEZWWTVLOEtCTG9QUm94NWVFWkpYZEc1WkNFZXBhUHpVcnc1UjYz?=
 =?utf-8?B?VWdXdkk5bHpEaDVhd09GKzlIeS9XY293MGYxOFVuNHFHZTZWODBob1J2NkZl?=
 =?utf-8?B?aWtLd0RacEVHMW54Z1pJV2pqY3R2WkNPT1QrTlo1ZU5DTFlOV3VlQzlEdmFm?=
 =?utf-8?B?QWNqSmY0RGlyMDhYeUVRalNRY3VmaW10UHVGamdRZ3UxakFpcGRiclkxcEVG?=
 =?utf-8?B?akVjOTAweVFhSjB4ZytBQ0pkYnBETEpaWE9MbXY2R0JtSjVwM25ObUw0cC80?=
 =?utf-8?B?eG9memdYVjlFQlJoK1FzWDBhVGYvSUEvejQwN2FNQXprVXVHTTFOTTBFL1RE?=
 =?utf-8?B?dGNyK1VFSXBnaEM4RmM3dUtES1Vic2FIcmNPelhUSXZzRkJSblBKdkxwTld3?=
 =?utf-8?B?RW5Fb2hkM01CNEc3TEptWVdlQzUyenJzck4rVW9TV1lIRXg0STFBQUJuam1i?=
 =?utf-8?B?Ykd5VWxONW5BRG5FVVVaQlRMQ2ZyTUMvenlCYzF6YkhSRks3aCt1bWpCMzl0?=
 =?utf-8?B?TkFBN0ZDc2lOeEQ1Vytpc292d2RINFdoa1Z1VThoUkJISmRTSFp4VlJxUEVN?=
 =?utf-8?B?MjF6VFBHeUExeUVuellJRzJld0dFZFErcjNVNWRIMkxoWCttQ0huUHRNNUdp?=
 =?utf-8?B?RUx6eG5lbmNkYWx3UHluVTE4QTUzT2FQZGw4ZkJnM2JFM0Q1OG5BZ2NSVFRj?=
 =?utf-8?B?Z2JsRmJzRzlJMGNTL1g4STY5Sm9oVlZhdHV4VmRYNkRjYm1IaDZzWkdIaEp5?=
 =?utf-8?B?WGpObWo0TmFEYy9haUdMb0p5RlZEQnpPbXBVNGo2WnBVOERJSUJib1E4QVdU?=
 =?utf-8?B?WkFzNCtKNlBwWG1LODZYdjVpRDlZT1FmbERQc2N0NmtROUs5MEpVR3F1ZVZh?=
 =?utf-8?B?d0V2emtTbStvMmF5ZkNoUExjNDBObVBMRS8xTnB0SlNZV3lnL3Y4U3JGLzNk?=
 =?utf-8?B?dlRHbFRRZ1ZTc1Y2cTRtL0ZveXJwSFFDMS9zTy9oUkI4TXdLUTdyQTlWeVZY?=
 =?utf-8?B?TE1JaktVKy9kbmd0MndyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNsbHNnTXorOWJGcm9ON0hGaC81MVpUTjUxeVY1bXd4dU90WXBEbGJPU1Bt?=
 =?utf-8?B?dktlaGhRVG9VRTZjdStPOFBpa0dxUTg4bmJwbHl0cWZnVERtclpzTy9vVmxa?=
 =?utf-8?B?Vm8rZWt1UWxoeDBBRzlNeVdpRGZ0bEphODQ1OVd1RWRWdXhVbWRseDQ5b1l2?=
 =?utf-8?B?MnJGVE1IWGhvM2NwUjQyb0FRL2dMK1JsdGxiZkxWMnJkOWhnUW96L0ZGbG13?=
 =?utf-8?B?SWFUVUIrenp4VGN5OHNGM3pHbWlqSHRLYTQvQVlUOW03UlFqS0krNVUzTW1S?=
 =?utf-8?B?RW0xMG9lanU5cHBzMTNJekFZZEZqSjJlWGZycm1wVkVlbG9meDhqUVRDTzhx?=
 =?utf-8?B?bU1OZHkrd0FYZ1pUTXJZNGo3WEh4TGVFZ05SMjIzZ3NQbXM1ODYzc2Z6Z0hz?=
 =?utf-8?B?VC8zQ2tRRmM5eTNQOWhyaWRxWTFlSVZLWUtkbE15cmNCY0RtbWtBN05tQ3ZQ?=
 =?utf-8?B?WVJUUFl3enZvNFBUcEJKZkpiMGdrWmNMWWJNWjVDdUMyQnVwYndjVHAzRkdD?=
 =?utf-8?B?eXF3dUJmWUlmRFcvUHM4MFdMeWJWM2F0UytlYlovbGVycW9aTGlBcmlpdklx?=
 =?utf-8?B?Rm13MS9DbTM3U0hYTkhjUGxHZjhtaUJ2NFJJYU5ueWRWbHd6bWN5Y3pWMjZi?=
 =?utf-8?B?ejZEdVhKd2dPUDBZWHBvOEIrbE9xV2o3VStsVm1wbnBzQlJ6Q2ZrRHBkV2JK?=
 =?utf-8?B?NGtUWnBYQThrb3EwNENyYmU1bE1xaHZBbnk3Yko3WXRTQndEZDNrM3E2K0ty?=
 =?utf-8?B?UkVJcTByUlR4UjJBZTk2RGhBdzB4RHlaNzF1alRNZmZ5V3R4ckhGWjhUb2Zs?=
 =?utf-8?B?RWw1dkZwQU1nQzZZQXE4YTZ2QjlMc1RkS0d2b25Zeng1MUdHTjhqc3c2Ym9T?=
 =?utf-8?B?d0M0SGp5ZlRIS21PaUlZdExMcE5kNzdTQ2FOR0cwSHN1dVY2VWR5L1BHNm1S?=
 =?utf-8?B?TDEycThMOEtLZFZabXFwZzRzNEx4NVVVT0tSMjJjazJzNmNUUVdtNGZUaW1n?=
 =?utf-8?B?djBUTkNLSVhkVEYwU2hRc0dBeXZRVVFmcUNITzFLZG13andoYnpkL1pxWnBW?=
 =?utf-8?B?cVNkbkJlVDRpMEhSN0YzTTNDODJEWitGU1hZMVZBeTJhV1dQVEVGOFQyS0Q1?=
 =?utf-8?B?T0xaMVppWUhrYkhuTXorN1haQld5MHdGL013N2p1M3dQKzlnOUhLcUdWYWRn?=
 =?utf-8?B?dituWDJKekJROFZlWmdJWlBrbEZCdjEvaWVoVEFTemMwaEkwMGovTkZOcEM5?=
 =?utf-8?B?OXB2d0ZnNndhNEloRk1qazZmTExQQmt0dmhqTDVoZEwzcEpmMlNrSG1qMUxS?=
 =?utf-8?B?Z0ZSTXRackJ4UjBvM3BrRlBCTWRjSkVza00vVkpwN3kxemZZWkx5WlhPaUJ3?=
 =?utf-8?B?cE1vQzVhc05ZYVU1VlFscWwxeXFQN3BqQ0FhazEwMFozN1pnbEtBQVROb3Ju?=
 =?utf-8?B?ZmM4S1VSNW9SQ3h6NFhDSUJDc1FneitCVWhQcEtIQlAxL3dHajFUV2pOUW5P?=
 =?utf-8?B?cU5YR3JPWVpDRHFGNlh4UzIyTzBMeW9lY2htL0lpVzVCMTRCSmw0Z1YvTENj?=
 =?utf-8?B?ZWE1MFVvOTBMbVVLL2IvdVh4bnF3U3RzQVppaDZvQm9oN2oweWFaY0xEaFhk?=
 =?utf-8?B?VnZITWtja2hwbm9iU1c3UkZ6dy9wYUdBNlY5dHBoZjB4QXUzdkcvaVBVMnZ5?=
 =?utf-8?B?dnEvc1dwcEJhcUJtZytMbktLSFVTNE84dDFBZHNCOG4vRERZMmdNWm9xNXNZ?=
 =?utf-8?B?T1RVRy9NTFQzWWhCVFplVjNxL3BQdGhrbTRpbXFtY3JhN2cxemNraUdjeVNN?=
 =?utf-8?B?OGJwamE2RVdXRnovOTBCZG55OUY3V2ZuamJEa2pJZ09ZVVprWHgxTHp4aWF4?=
 =?utf-8?B?VFRFK25NeWdEN3JPTXVGanZKNWZIWW9ocXEyRVlabm1kMDdYbzVScEJCK1JP?=
 =?utf-8?B?UHV5Ym5KdHN5YlNGQXJNTDRKbkE3THJmajNMWGJPdGFrVm8xd1NMUi9wM2NI?=
 =?utf-8?B?REE4RjJWM1RvUVZzSXZCUUxpNk5kTEg0MHd5M0JhZ1JSUVpBQWJDbnJ6Q29k?=
 =?utf-8?B?R2xJWU1tWEF6eGxDK3JsMHUxYmF2bkhGMDAyVDZVcDJITTN2Y04xcWNWbDNa?=
 =?utf-8?B?L1lRYXNuWUd3eXljSklNMWJYdENLWThEUW1nNm40b2NSZ2loV1I0cHZ5RFRa?=
 =?utf-8?Q?4CeJ2zNeJZSdzqvoQZqBl7o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaba4f8c-faab-45fd-f834-08dd0f4b01b4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 01:21:38.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNdv2CzSl6FDzHXLHL0U1+VrRfnNbF5yzRaCSqBBNAozLuydWe+Aj4UPSNksL8WNn+PpLbh5KyqlfE4J8s3JkeLzIvFS4W/cLWxeDR+3JhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6108

>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>> index 87b3f1a25535..ef303a2262c5 100644
>> --- a/arch/arm64/mm/copypage.c
>> +++ b/arch/arm64/mm/copypage.c
>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page *from)
>>    	if (!system_supports_mte())
>>    		return;
>> -	if (folio_test_hugetlb(src) &&
>> -	    folio_test_hugetlb_mte_tagged(src)) {
>> -		if (!folio_try_hugetlb_mte_tagging(dst))
>> +	if (folio_test_hugetlb(src)) {
>> +		if (!folio_test_hugetlb_mte_tagged(src) ||
>> +		    !folio_try_hugetlb_mte_tagging(dst))
>>    			return;
>>    		/*
> I wonder why we had a 'return' here originally rather than a
> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
> issue with the hunk below? Destination should be a new folio and not
> tagged yet:

Yes, I did see problem. Because we copy tags for all sub pages then set 
folio mte tagged when copying the data for the first subpage. The 
warning will be triggered when we copy the second subpage.

>
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 87b3f1a25535..cc7dfbea1304 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -30,11 +30,12 @@ void copy_highpage(struct page *to, struct page *from)
>   	if (!system_supports_mte())
>   		return;
>
> -	if (folio_test_hugetlb(src) &&
> -	    folio_test_hugetlb_mte_tagged(src)) {
> -		if (!folio_try_hugetlb_mte_tagging(dst))
> +	if (folio_test_hugetlb(src)) {
> +		if (!folio_test_hugetlb_mte_tagged(src))
>   			return;
>
> +		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
> +
>   		/*
>   		 * Populate tags for all subpages.
>   		 *
>


