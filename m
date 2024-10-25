Return-Path: <linux-kernel+bounces-381556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DE9B00C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26997283BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE061D3633;
	Fri, 25 Oct 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NelvLmDm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8018F2F7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854242; cv=fail; b=SHNw3NouHy9kbB0wqA3UjUnSGpovvSblIEnIPTKkey8RB6Vh6fsaECcSASg1lr3ckf6JMb7AO141E6FE3Izcvs9yeYjB2rcohGR+F+r4iI/fPXH00FcMMrAOF8NEe0So3NjiAPAifgFvSlcK1+/x2t3DrMqqiNgTyeNYznoXkGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854242; c=relaxed/simple;
	bh=bvuknhECxeOuqqq5yCP+0UY9a+DHB7PdlaPu7ZjM3F4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RaYrLVNI9HDFHveMfI10lwpIJ4b/Up7F5fT64mGHOLOOc1QYUOjX2RViTtt3YegeGEGMkTv1Wyy51MR1RCRImZJxLo+MN5EK2nztQr9jlVIk7AP9tnpSIOBjX2XuNi/ZQwS5YNr9dEMkrv4SE0GUt6IrD+8j/RxzLfCI4WEZ3y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NelvLmDm; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNTaxcrhs6MrZz40dqgtuMUM48mwa6cWtP7jCWqSZnhCk8jLqAKmKoqxoANv4xfx5Gt7YultPWSvVZTvnXBWOoWuyBEAA978oqNQSC4N8MJrZlE96G/i2Glt9OhunmVx52ED4Ns+AZbbjzguCV/t40uKzvXmPG26StiHYN/2raD5vxmkwSIDjcaFb8XijLhBTOHq5CQMcJkpeZSJ0gqfD7CQsqVD1J967pywNQzFd/MWjZrKtQ1tZdthUnx3lKs1CVTXysmMbLPk3856oZDqmcFqh69I15aLArj7XmSLYyF9hXlrBF1DvQi3z2rgapecQq9+iEkGPCHNf6dH1NYomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+hZHMo8ZAGnlk3h1ape7HwkN0bBvpMGrsfaDnMWiSY=;
 b=Q3ZQCcF6QZHYZ/rAKFJUixEcnE/2epK0LnhlD9LJO8i1jkc8QUZ8uYVsUc59t96/MEzbeRMnns6BScgMtYnTOnvbHH3L/hklxN4cIkAFeo5xj5gdY4yEGGRjUj/TELjtHw2m1SVOSsGWXp9JDNdRnIUPksocl1rFW2sAUv772GFW6RRZYQfdec3LA1a2wZg4X8MOzLmFaPj+gtS6UgvUc8tC0M7RDPFpR2SvGWds62qPx9VM7qYNNYL8Ej7U0HnI672Z310nPxs27VHigKjx4qeM3wvLhaodBmWKWhRfrjYcSZHMG4/v5PFSE/l67HnlKLe/R1EmRFy9UxlEcrQZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+hZHMo8ZAGnlk3h1ape7HwkN0bBvpMGrsfaDnMWiSY=;
 b=NelvLmDmbc4UK2YseRWxs7D6kCoxx7LN18snOpEomEU1obakSs5X2dDdQdF08q9S6bf9zCt0mK2+Q7KuNXc8so6TjpqgXRuHcRHXUir23p8wHxHod9hjPmGqjHHjq9oTsvuAg2elAheU3a/4A6OqBB7odCUm1zHAn/9wanPvoDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 11:03:58 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 11:03:57 +0000
Message-ID: <5cd8e74d-b41b-4280-92d8-0a0c2d834ed8@amd.com>
Date: Fri, 25 Oct 2024 06:03:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] x86/sev: Map only the RMP table entries instead of
 the full RMP range
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <915e7d6b2de0c71d8cd9f8902b1ba3ef6ae563cb.1729708922.git.thomas.lendacky@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <915e7d6b2de0c71d8cd9f8902b1ba3ef6ae563cb.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::8) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5cf7f8-3262-4fc3-1367-08dcf4e4b7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0xJNUdJTE5lR3EyNlgrc0VoSW9pZ0tlam5JcHN5R1RlR0hVYzZZd1FlV0dB?=
 =?utf-8?B?dEp5N1lkcGdwdmdjdUt3dTU0K0VzWlc5STZ1WlhWNUhoUjM4aWpQdXpHcCt6?=
 =?utf-8?B?ZzlTVkVMeTNEY3E5WGJWZS9WeVBXelpnYmgrbEptVEVHZUd2MVVDaWVTWS9O?=
 =?utf-8?B?ZmJNbngrRGdoUDJWS1hscmMyWnpTUitwUW9LY09UcjdFM3NNVkxneC96WXdM?=
 =?utf-8?B?Rjg4STR1TEhHc2JHYzkyMnNybVBJRmlQQmUyV3pmSkR1ZnowTmhuclZsVlQw?=
 =?utf-8?B?YW1SckdkMms4eUF1NUZOS0UzK1dkdVBpU1ZKYzJLVitCZTBkaUdjNnNkTFBU?=
 =?utf-8?B?YmZ4S1oremJMQ2ZpaHhxbmJubFRpdjRKQ1ErNXc1L21EL3JBc1luWWF6SHho?=
 =?utf-8?B?YWNUbUtIVEJiUjNBYmNpMGF6MWxoZUprODdYZXR0dU4vV2l3QWhYZy8xdlNq?=
 =?utf-8?B?cytTQnZtVzVJUXFVcXZXV2tBcEJNUVkvK0oyRXB4UWlRL3hkeGM0UkdkUHZL?=
 =?utf-8?B?K1YzN21GRjRFeXREM3lMRk1URDJpWlVzYmh6WU9RUTVGQzdPdkQxcS81U0g4?=
 =?utf-8?B?M2lFQkpDZzdKOTZmODg4bWxDQlhlVGo2SElXZStHRFNjdGoySFlmZ3NYZ1ZE?=
 =?utf-8?B?Vi9Tclk3Z2FHdytHU0I5Z1pPWjBhbHMza1JodWtjYXZwcFRJWko3WTg2YmtJ?=
 =?utf-8?B?MHR3QkxTSGhMNXNoc2hXZ2FMbU5QR3o1NmgrNW4vMFd3cXVXNmt3R05DbDgz?=
 =?utf-8?B?bHlydUN3NDNpR01kaGw5SzNWUjJpTzExb2h6TUVQek1LeUhaWEpET3UwQ0ZB?=
 =?utf-8?B?YTNBVHZhRzFsSjliVDJJV3BHL1A4bGFURzlHMWFvZFoyZ1QyUDlQSUJGcUVt?=
 =?utf-8?B?NjFZZ3I4L21ieHVYL00zR3YzSzd5UHJ5Sm1nQk5EbkFuL0pvdW9OeTJlcEdM?=
 =?utf-8?B?NW5UVGZVSlVTZXZtYjFXVWxucjhVMUJJYnROR2E4eFJMTHVBcmg0V2pDUnU2?=
 =?utf-8?B?Um5INXllTjE3R0tOU29pZyt6aXA3ZXBIb2hPNnlRSlppQUxhckJTZEhoRHB0?=
 =?utf-8?B?MVhIRVd4RGRvQThqSkdYd0xxOElPZlBnMld1emVhckRhaUlob0txWTBCQ3NG?=
 =?utf-8?B?VW9wTmZXQlBHYW52ejl6RVAyNDM5eTdTR1A4RnRMak1QOFgvUExONmtucTNP?=
 =?utf-8?B?OThVVXBGVzh1VGtESC82M1lLR01RdlB1Q2RVMVd1a2tnSExxNkF2aWF6Ukcr?=
 =?utf-8?B?c2tsc2xNbnRFRUVnQ0RSekhsdjdJUHRjZ2JHaEhjQVBFaEpERDVtWms3Y2l4?=
 =?utf-8?B?TnFKRkdiMlFwcGxHNjE2cTRTbUoybHZodSs5TDlKcWpVY21XQ0ZwTzYzQktR?=
 =?utf-8?B?VmlWcjNyRG9RZElTcHk0NW9mUUI4alRzVEJ6bG1zSlB4SmZxKytkcU1tNDMx?=
 =?utf-8?B?S3ZUdWhmNVgzRUlIUWxLcW5KRktTRC9lMEgwTmFEd0JHekpYOElxek94ZzBi?=
 =?utf-8?B?bCtjOVRyVGYxbGV1MWVtdk42Q1kybFp0TVZlaHUrZzJobTcyZEVqMHArZ0lU?=
 =?utf-8?B?cVNFM1kwUkFQaWZtQzB3LzhqNmNwRi9nSEc1OVY2U0F4akF6M3VlRk0rVDhX?=
 =?utf-8?B?V2YvU01NUTN3SFVRR1Z5WnpQb0tHZlFQTUdDVXBIZ0grRE01TUVTc05nRTlE?=
 =?utf-8?B?eWtjdEVPbkhqOFFRcUZqa2E1L1cvVUFQeUYwV3ZXVy9jK3dCTit2Sng3RS9W?=
 =?utf-8?Q?WPB7XJejXrIlfx1Ky8Lc5fU4fgMtNK7SUqu1SLa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2VuUFNpaGMxdG1qNXVPSVNLUmJmelBGc3ZLeWhNQXkyVTVWWXhPRXVwQmNG?=
 =?utf-8?B?UFIzZTZzc1NKTEdyWE1oajFYemZyTkhCYzEwZFhjYlVRdDBBUGdmMUFFOHJ2?=
 =?utf-8?B?NUJRajQyek5aZGhNN05kVzFOZkhzTW9JNUdnZ0tPUXh5TkM5eU9QSUFadFdm?=
 =?utf-8?B?c0txN3MzYm5nVndVNFQwVk5QSk1GdXJlM2RHVFFpSHFmZlM5VFNoT2ZpQWRu?=
 =?utf-8?B?aVY4d0hrMElEK3ljQkw1WW5CV1NKZjFNbkZvVmVFZ2oybjRWVXVQNmR6N2FK?=
 =?utf-8?B?djlSRzh1alJzdGFmaTBFNUt3OVhnRlRILyt1bFRHSGwxcysvRGRTUWZ0bUF0?=
 =?utf-8?B?MEdqMzVjUFV5b1oxU3pvYU0yOE8rRTR0cndzVkp6ZHNuaVY0aENQSUd4VXdo?=
 =?utf-8?B?Vi9uRjVSbTFvWVExQnB6YjBzY2xDdkdVbFpyZVJMM0xsUHAzRjhaWlE2Mkor?=
 =?utf-8?B?WldzL3ZnVEpUS1NxWDlQWDAzV3JOb0JTK2ZxMXBXcDY2K1Nldnl6Q2NEK0t3?=
 =?utf-8?B?VEpGUkhiUFNXd1R1RlBFbmphMXNtdzM3bzVNT2dyMXJiWEVjTXhXUlN1QU13?=
 =?utf-8?B?R0ZvbnQ3WlFuUzRwR0p1K0RJUlhUNmN0U1FlYVJHMTNHNEM2ZGtwNDVmL1dR?=
 =?utf-8?B?K245dW9UVDBDbUJyTGcrK0ZpU0sxc1dMcFV5MEZwT2hMOVIrN3lLMCtEaHFy?=
 =?utf-8?B?bW1scHJuRHNVWUd2UjNnRS9ianJqa0RiRnlPL2VIS0M1MlVibkd1L2ticktL?=
 =?utf-8?B?ZDdQSGlxRHBwQlZmaVJDbVZMaFo1cGFHWFU1ekFnVkc1TFNwSUpjbDB1M0d1?=
 =?utf-8?B?WXdZc1lSd0pBWW9Zd3RVTk9qaVJ4RGVKNHZxOFNyNTZLS2YveDRkT0tDM1Vi?=
 =?utf-8?B?MjZUWmF2cXkzRGlaYjRrZDU2MjdtcjNsbVlBNkZEaXZZWWo2aW5sVWNCQ1cw?=
 =?utf-8?B?ZGNDOWgwMzlubHBGZ3dPdmU3UkJPOExPdkVuTkhEZUE1TW1XVm1HZDhpRmIw?=
 =?utf-8?B?OWRadS92NnIwdGdyUm1qdlVnWWM3dU9VMC90SmpyTjlaMVoxWkN6V25xc2VF?=
 =?utf-8?B?VHc2UHh2aE5VN013eVdSSmpOM0U3V0t1WDNKQVI5YVl2U3BZZ2hvcFhBMFpD?=
 =?utf-8?B?S0Y1TDY2Z1AvMy9Wd0FMZkJEYW9YbVE1NGxIRUJ0cXd2dUVobjZWbUgwcVcv?=
 =?utf-8?B?R05BdGJaUEhFUUJEZ3J4UnpuQTd0dDlERXFyQ1UvL2I3V3VNWkU1ckZhUHlN?=
 =?utf-8?B?b2VUUDM1TXlodjJRRnpoZ09LU3J6c0RqOXkyczU4TFh3YWpMcXdjckhKa1FU?=
 =?utf-8?B?Q2J1ZDlVWEpOL3BXNDhubDhLOG9NR0MzUDhqckYyNUFBUmo2R1lTc2pXWEkx?=
 =?utf-8?B?cndtVTExUWtnN3N0QWYxb29pZldLOE5CS1pRRFk3bkhBSW9sWmlhOEpBNDJP?=
 =?utf-8?B?cTJWOU9ycHI0ZlM3TGJSWVZRcVJOc3M3RkRUbk1pS3M0Y3BYaG9kb0RXRnoy?=
 =?utf-8?B?RXVEeXRWd3p3aHVvTWZHUWJ6RWJzZ2RPMENKZG9CWTFQNHBUM0RvUktzeTM1?=
 =?utf-8?B?cE5NSWlPSUtkcHdBKzB5NmJvTDhRZkVBUXdGenJoUEZ2d1pZOU5rY2F3YkJl?=
 =?utf-8?B?ZGdNTC85K0lkLzhxYXBEdU1HeFlZbURJZDM3T3o1a0tBd3cwMmMrSFdTL1l0?=
 =?utf-8?B?cWg1cWdkN01CaGZnd082VCtXQUoyM2NwbU5reDJ2dU1VQUZEUlloRVB3TmVR?=
 =?utf-8?B?SnBCVUNkaFZqYTd6TExpUFdHcldqTE1xZzljdnh1Mkc1SWYvTjhkbDIvMDZi?=
 =?utf-8?B?dW5TdUFsMm51Z3RBRmJIZUdhZzVCUU5URS9oMi9aNnhrZ3dQSnJKcjFUOXpG?=
 =?utf-8?B?NXNWRDgwNFRDWE0wU2s1dFI5SEhTRlZDS3J3MnBneU1xV2tBdm52bFZrdStZ?=
 =?utf-8?B?a2tHYkdGUEFPYm5yWHhlVDZxS211dTRMUVZXS1NsV1R2KzF0YytRMGl6OTN6?=
 =?utf-8?B?YkNEcStzWGV0Q1l6dVRrS1N6YnR6MTZVVEkwc1hEMmV2cXV1YU1yY0F1L3RK?=
 =?utf-8?B?Tzd2Y1lNWXFVYVpBbDJiRFJ0Rm1Tais2UXBJV3dPbHM3NmplRGV5U2pqa1BK?=
 =?utf-8?Q?HyjP0GC8P3XKUGBt6JIvjq4vP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5cf7f8-3262-4fc3-1367-08dcf4e4b7a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:03:56.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPlfjGw2nQ8NY6++A7ar1iJnE6uPFcU7Gbi2h9ODyn+9HmXmYve7DeqKbfMBCbAvdF/Xuvm7gfKWg7ZFE2zl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838


On 10/23/2024 1:41 PM, Tom Lendacky wrote:
> In preparation for support of a segmented RMP table, map only the RMP
> table entries. The RMP bookkeeping area is only ever accessed when
> first enabling SNP and does not need to remain mapped. To accomplish
> this, split the initialization of the RMP bookkeeping area and the
> initialization of the RMP entry area. The RMP bookkeeping area will be
> mapped only while it is being initialized.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index d0fca9bb2e12..dd256e76e443 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -168,6 +168,23 @@ void __init snp_fixup_e820_tables(void)
>  	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>  }
>  
> +static bool __init init_rmptable_bookkeeping(void)
> +{
> +	void *bk;
> +
> +	bk = memremap(probed_rmp_base, RMPTABLE_CPU_BOOKKEEPING_SZ, MEMREMAP_WB);
> +	if (!bk) {
> +		pr_err("Failed to map RMP bookkeeping area\n");
> +		return false;
> +	}
> +
> +	memset(bk, 0, RMPTABLE_CPU_BOOKKEEPING_SZ);
> +
> +	memunmap(bk);
> +
> +	return true;
> +}
> +
>  /*
>   * Do the necessary preparations which are verified by the firmware as
>   * described in the SNP_INIT_EX firmware command description in the SNP
> @@ -205,12 +222,17 @@ static int __init snp_rmptable_init(void)
>  		goto nosnp;
>  	}
>  
> -	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
> +	/* Map only the RMP entries */
> +	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
> +				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
> +				  MEMREMAP_WB);
>  	if (!rmptable_start) {
>  		pr_err("Failed to map RMP table\n");
>  		goto nosnp;
>  	}
>  
> +	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> +
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -219,7 +241,14 @@ static int __init snp_rmptable_init(void)
>  	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>  		goto skip_enable;
>  
> -	memset(rmptable_start, 0, probed_rmp_size);
> +	/* Zero out the RMP bookkeeping area */
> +	if (!init_rmptable_bookkeeping()) {
> +		memunmap(rmptable_start);
> +		goto nosnp;
> +	}
> +
> +	/* Zero out the RMP entries */
> +	memset(rmptable_start, 0, rmptable_size);
>  
>  	/* Flush the caches to ensure that data is written before SNP is enabled. */
>  	wbinvd_on_all_cpus();
> @@ -230,9 +259,6 @@ static int __init snp_rmptable_init(void)
>  	on_each_cpu(snp_enable, NULL, 1);
>  
>  skip_enable:
> -	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
> -	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> -
>  	rmptable = (struct rmpentry *)rmptable_start;
>  	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
>  

Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>

Thanks,
Ashish

