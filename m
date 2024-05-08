Return-Path: <linux-kernel+bounces-173883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEFB8C0731
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD93D1C212C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3814132C1A;
	Wed,  8 May 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o23Q05VJ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64D132817
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206180; cv=fail; b=LSEFUI9zVnAP/KTJssPdnqaNQ88oAIczYj4TkTN3I0IJpnNv606MmkgY4rj6otaqEwDOmojSP2N/I49FlyYOndnC30kla4RJo70fpTKzv7v6FknpPwRjUhc8bPLbQungXsVCfFCZSbEgvq7oG/qlxcBCI6744cJu9mMvMECpnvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206180; c=relaxed/simple;
	bh=BwUbFzJPwZcYOMehIKoSTcvYbT5o/YmGKIRFK53gIOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/3+ttFntYhM8ukQ7qC0cvQ/u1hIwdeA75ROhD9ybwre5cn8uZ6j3rpedPdKAsUZUbbcZ3B28RiJMUgEhhJHEKhYT8VRKa6AnpuvC2vD+Hk0knDTwJHllfODZUamWnfKPzF9O2gycRwZZuShrtKlU/0s0O6yvpHRMl9MqNReJfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o23Q05VJ; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdLYFLcZHWb6VDhXU/q2NoE9CjspNjOiorcR0A0O4ZFkqFzD+IQLboOMNOLdL5kdC8MuaRZ5u9c2fynJAlzwpyEzxL3qeJu12zrVaHZKU7P7RHMeeEfArzb4tfUlNI6hU1iFntshfNnKBg1ILzFREO1Sn4nLdyf0PvCKxynW206IR9Dmzbws9hibhmnMWDAPnFQVjfcOZyxchW493JOJsItFdwmn5/libT1Raiib/BCm6gUUbtZzYIV+1uxWxHz6S6FAt9FReY9U8XIGmG6+zZPGuUrXj3Gz7braHrUV7wdJ3MK1HDsLsEV+0rL5t5+ZUic1WqYaksb7YELBYx+RgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouYEgjOB6D8eqCGcyFxQFJR5oIXBcKNAYl+gjxX2omM=;
 b=kBWiFrSme+v819fLsQ0z94TAPS8OtwTzOPU79XGnOqve7Ddzzobvb106Oo94bhtinezJpvBWVzy5ApzbvcWeGIjXhC37eTCT727tV4+1S9/CBIt1CNVIypDUbqvVXwVhdxdLLIC4r7GuFhDUhzf5aET3za6wOq908P8BG7ak/8MU0XiH5iKhl6sv+EkMzfsBY7zCDRXCwUmsfY3yvDCurdbqo0WdUVfpdrwE06z0LG/iWMXXg2F+oxXGnOQBgAS87kh8Br0ZLyNlwE9gW0i77LqcmpEKGw6UdMe/az4kIzZwUJkUxES/NU5+uAMfxCZyxess5nz2TCtVTVQe4S6tkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouYEgjOB6D8eqCGcyFxQFJR5oIXBcKNAYl+gjxX2omM=;
 b=o23Q05VJGOWdrEppHmUFsKCvzvdOGRdJzOZFfN/o6SlPRzPmLRfveVOMEC+uI7HgaJUHacVqYfIIobvaB+RcHF66BciWF6ha9OXoSaJ6hcpNDSC0DLf4l3WIkE5e4aQhBN+PUt7VLi6qU9FlQAHYX4Z8ySR5JInzT66QXm2G0OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 22:09:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 22:09:35 +0000
Message-ID: <23e2c13f-7ff9-4336-97ae-088ec4401edf@amd.com>
Date: Wed, 8 May 2024 17:09:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
To: Thomas Gleixner <tglx@linutronix.de>, Lyude Paul <lyude@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
 <87h6f8nfg7.ffs@tglx>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87h6f8nfg7.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 436ef5dc-4ab3-4394-4e3d-08dc6fab8b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck5CaHk0V0R5aHYrNjhMOEdDam95ek1zcndnMTdOT3NpRG4xT2N3TC9NZ0dV?=
 =?utf-8?B?UFdtdWlPa0R0VStNY1FyY3hXZlNWTXRDekJaUGoxYitaTDNLLytiVnRBWUMy?=
 =?utf-8?B?RFdveEhhVFJCY2lEQitDUlZwRWtDdzBlb3pUMGQraEkreG1Ja0NTZmFLRWFw?=
 =?utf-8?B?WDc0clE1Ti9BTVdvSE1PN2FRZnFxSWhGNVAzbFlkNnNPVGFhVmoyYVhMeThF?=
 =?utf-8?B?VzlRVS9Rd2NoK3E4Z3RNaEVkTjgzaXhvWnFWdUdRS2pRMjAzN0tzTlNiZ1R6?=
 =?utf-8?B?VWUrTHFCdEdVeHhVdHFxQjVGUFVMdjBTeXo5MmNXV0VlSXk0TG9wRHNQZUYz?=
 =?utf-8?B?RmZBd2RVNFpwekM3NURvaWFLVmtYaGVlMFo0MmlpckZ5OENEMWtiZUgwYjl4?=
 =?utf-8?B?THlUUERoNzhuTWtZZElodDVNN1FqamVjb1RmNkJtbHdKRStpNGl1bDc3N09U?=
 =?utf-8?B?Uzl2TkRMWS91Z2dNSytwRzI0OWJiREw5S0pKcmJ1VmlhQjlqNng0bUFXWWt3?=
 =?utf-8?B?Y1FNZVRaVUMwbzNkNllhOWpvcHF1UXlYVEJ0R2hUTG9pdTlhNVM5VFBNM250?=
 =?utf-8?B?aXB0ZmlWT1ZTcW54WEM1dm12ZE9BVXZsZHNkTjNYYWJER1B1V0l5TldodHBB?=
 =?utf-8?B?UXNBOTFVd05KMkUrdVp5NUVFVmMvU010cU5xM3R3M0dMRjBEd2ZlSEkvV0xG?=
 =?utf-8?B?UDMvK1hYdGUvdzFVc2h1dmZZSXFaY3pCKzlMMUZ2MjVxbmtRSFBuVjBVWkN5?=
 =?utf-8?B?WHgrS3Z2aXVsKzRzQjBUOGhlUlpmRDBJKzdRQUpNajBwSkdHNlJWMnV2YWVu?=
 =?utf-8?B?OUhhaVkwUHc1L2JES1IyckZ0UEI5azNBVEhFdHFrUTJlVEk3SER4c3pFdzJU?=
 =?utf-8?B?OHRacmVzWUxhWmNEakp5aGUvSVJYSGxCWjJ0dndRR1NzZHNMa3NmZ0xGbEdL?=
 =?utf-8?B?RWVyaDc4SUZJdDhwcXBzd2FDcDJtOEI0aGhtK2dpVisxcUNqR2VpYmNhSXR4?=
 =?utf-8?B?djlkUXl1WFp6MHBFUDVoUlg1SHJaWEVCZHpiVWRHWTNhSW5ibjNjaDllZVlE?=
 =?utf-8?B?ekNDd0hLT0lFSVVzNGIwMVJnNy9mS2pmYzBCay9penAzZFJUZWRKVzdRS21k?=
 =?utf-8?B?ZmZ4VHBncHVUa0xNRU1YTkpncVZMcm9lMUZreklTYXZ5ZmJYRmJ2aGMzbkRV?=
 =?utf-8?B?cnZBeEFSc3V6Z1FlRkJDUjZSZmVaUUJvVkQ1R1NmUDBxSmhocW9KV3B5SlZs?=
 =?utf-8?B?RFFhN3h4MExPQ29GUXVQS3BDazR3TFY3aVRQcVdYdGdxc3RFbmdJQm1yTXhl?=
 =?utf-8?B?ZmRsVVFvUkJqYWU5bVhvRFhWb0xvZm5rd0RFb3lKSEJHOXk4UnJEWDVDeXZT?=
 =?utf-8?B?dExPQ1ZzcDNpM0R6OWhZY3hOV1hibCt0SjdUTlcvcUhJZXdzTGpnYW9XeTFl?=
 =?utf-8?B?U0VFYkFGN0tjbjNVQzVBRmtDVlV4NDdXMU5RQytDL09GbFNnbUZRS1ZFeFB0?=
 =?utf-8?B?ZHR1VG9hU1FQMTZPbXFqdTFHZ1RzcEdxNmRFQS9EV0lTSUorZFpyUmJaWW8w?=
 =?utf-8?B?cnoybVByYXE3S3ZIS2Zad3ZGby8xNFRqL2lHMGFrNDNYYVZ2YjhYNkU0NTRj?=
 =?utf-8?B?dHpMZ2crWmJBcFVIL2NpWWJXUGNJUkMxVE16aXk5Y0Roc3hWOFNxcldOTWxx?=
 =?utf-8?B?SlBtcExScGxNLzZHMFNhMmwxWjhlOE90TVVBRU5jWEg4TlhEZ055VWp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGIrMk5zNDlaR0Yvd1UzdkJZUWRQWC9VVmlkRlEvc3I5SkxabGdJRDRQdHhZ?=
 =?utf-8?B?RmlnTEJ5T2VoY2ZFb0RNS25XZEFwZ3RqdVE2V1owWXlRRE43MXBVbHNmdENa?=
 =?utf-8?B?OVB6Snh4MWg2b0N4Z0E4amZzT1VKM2pETEFONURpbGw1LzNSUWVQSU1hRXRF?=
 =?utf-8?B?TGsrUW5OMjFGVExYSnpRM1pHU3hiV3l3aEp6NGZaUUpTNVl0U2Q1T1dDUGJp?=
 =?utf-8?B?UU1uelMyMmxuNG1RQkw0eHdMdzlmdGhSUGlpeHBSb1RtNXJGRURsS0VER0FX?=
 =?utf-8?B?cUZwUkdnTDB4UTE4NE9sdm90LytCMkZVNzUwVTFRNXpOTkVHVG5INXBEdjZC?=
 =?utf-8?B?Lzl0LzZyNzdaQWNjMWkxSkRUUjJGVnptczlTMC8wSzFZNlJVdWlmL3pSQkM5?=
 =?utf-8?B?S2xwdkx3RCtmV3VDdXNDVzFST084ZWRXcE1XemR6V1FsaGpvdTlGUlBrK1lC?=
 =?utf-8?B?ODRqT0R2OCtkK2srSFhtdWhRL3laaEpydU9qdElMRjRWdktzS0JjSEh3Tnli?=
 =?utf-8?B?QU1BVzA0aktxOHR6Skk4R3cvRkkra1JXZkY1VmlGc1R6RDc0SjJ4VnE3SUNu?=
 =?utf-8?B?MXdiVklkZ2R6WVRLU0QrMjhjWkt3eDNlSUhlNlBGM1A5ZE1id2RueThwdnJv?=
 =?utf-8?B?aytrL1BtMkJNb3R5MFBlZ3pGL2hiVU5vRUpoMjBSdW9aV1RRRGtUQUtPSzg2?=
 =?utf-8?B?aE9QQVcwMVUvcUFqdDBJNXFpVmZpaDBmNjM3TnpWbkllclJmcGR4R05EVFJE?=
 =?utf-8?B?SXFVa1dhTVROZy9HNEZ2T1JFZTNxMXV1SGdOSGRDZXdoeFNucGhydy9vY3hx?=
 =?utf-8?B?RzVGUUtpY1dRdWZNRGlRMjdaRmlJZmQ4YjUzNG8yWmtZSExvOUJJNW16cjlx?=
 =?utf-8?B?emlSd05lT2JCcWNrZjNUY3lmbFg0eU9waTNoN3lpT1ZQUnRVbzY1R25MSzhG?=
 =?utf-8?B?UGhUdHg2K0VwcGdUZ0N4bXBWU0FvbVhjQnd0MVpIRnRJREZodHErTk5pamdv?=
 =?utf-8?B?bUNXMTRha3JrdnJmU2JhWkxtQkVZZXFnOUp4ZFhaRmViMUt3c21VQnJHVzNC?=
 =?utf-8?B?QnlCNU42MEIvRys0RjZzcHpZaWNGKzR2aXk2cEtQUFhNYUtYV3pEQ1lyQmRm?=
 =?utf-8?B?Nm1aS29sSFh2bnFodXZHY1llOWo2R3luNnFBTkhPMzRRZldiUS9uOFVISnlu?=
 =?utf-8?B?citja3k0d0NIaHBibFFKMDh1Tng5UUppMmp2dGFhdnYva0pyVGJsR25rRTYw?=
 =?utf-8?B?SmdzUWNZcUUxTk9GdG5hb0JuaHNQRFJTZHhVUmYvaVIrSzl0UXZ0aTY5TnhX?=
 =?utf-8?B?bUhrVGFTOE4vL0p5emUyL2RiVEpMMHRYR1lTZE96SXI0eE5pU2JhVDRGWmhw?=
 =?utf-8?B?TGV6Ym41N2JpN2lzUWl0MkJBandyR0VqQVNGTUo5VnpYTXNoUHVqVXJrWkxM?=
 =?utf-8?B?aW1yekxUaWRTOUhBVHpDdzFtRzd5aGFaZmhodXg2K0FQdTlYUmtXdHBuZDV1?=
 =?utf-8?B?ME9oS29pcG5EamcyRi83UDFVMUFTOXF1RG8rLy82RmZZeDhOamc3MnAxM0xN?=
 =?utf-8?B?bTNwdmlHZXJrQ0JGM1hMNVY5SXlseUExOVhUUHZVQ01JS1krWE9CclZ1L2No?=
 =?utf-8?B?SGJuckFNT3JiSEtaSVN5a2wzaVM4TEFsS1B2Y2FmZUIyZmVUL0JrT3d2cmhB?=
 =?utf-8?B?VHFYaDc1YTRBK1pDVjdoZnhZeUpCTVVQWkNMdzRsT0JFTXhXWTViN2ZOVWVz?=
 =?utf-8?B?YnpwSWM1UmpqS24rT1pTbHdNcjhLblJnNmJiUEpuZThxZ25xMGFYcHFJb3pT?=
 =?utf-8?B?amZzSVlUWXVXNFBlTEZxZTFjMCs3T2trZzZEQUpDQWE2ZGZYMC9ocGRqKzNl?=
 =?utf-8?B?amFDUWtScGEyTDR2ZGVob2w0SHdaVU90SWRzQ0hFM2kyR3gydUlhUW91eHhJ?=
 =?utf-8?B?R2ErVUg1R0hNMWh3cmxlVEh5NVpZUjRLWmFaQyt2dHg4T3RWSXA1c3YyS2JB?=
 =?utf-8?B?WUd6cHhSb1VhczUyRlgxVG5ESkJOc2VoajM2QnJnWlY4aW9jUjkvS3JtWmxv?=
 =?utf-8?B?RHd0aGM4TWh5MG1QQ3l6UmNwTDNWRjhUM2FqUW9JS1REVE9NN2p1VFhSZWpW?=
 =?utf-8?Q?R7htJjEjMeiEW9F/O5dEwkX6f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436ef5dc-4ab3-4394-4e3d-08dc6fab8b96
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 22:09:35.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfaUf7HA5sw+QIU4c9CfqrQ3uoOVTLMexz4gaUjaoO2qFRrZw0Qwz8/jv3XJc6sCAMKPWfbFb5uHwdQw9upDAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660

On 5/8/2024 16:47, Thomas Gleixner wrote:
> Mario!
> 
> On Thu, May 02 2024 at 05:33, Mario Limonciello wrote:
>> On 4/25/2024 16:42, Thomas Gleixner wrote:
>>> Right, that's what we saw with the debug patch. The ACPI/MADT table
>>> is clearly bonkers. The effect of it is that it pretends that the system
>>> has 16 possible CPUs:
>>>
>>>       [    0.089381] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
>>>
>>> Which in turn changes the sizing of the per CPU data and affects some
>>> other details which depend on the number of possible CPUs.
>>
>> At least this aspect of this I suspect is caused by commit
>> fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c.
>>
>> If you try reverting that I expect the "hotplug CPUs" disappear.
> 
> That does not solve anything.
> 
> The topology core already rejects those CPUs and accounts only for 8,
> which in turn causes the boot to fail as also demonstrated by limiting
> the number of possible CPUs to 8.
> 
> There is some other problem with this broken BIOS/ACPI.

Something very commonly done in BIOSes on AMD systems is that the FADT 
has "entries" for the maximum number of CPUs that can be present.  For 
example if the system can support up to 12 cores and you buy an 8 core 
vs 12 core the BIOS will have the same number of entries (probably 24 
considering SMT) either way.  In the case of 8 cores only 16 would end 
up populated.

Looking at Lyude's logs that system is from before ACPI 6.3 was even 
introduced so that's why I was suggesting that reverting that commit 
might help at least the kernel claiming that it saw a number of hotplug 
CPUs.

But yes, I agree it probably won't help the overall issue that started 
this thread.

