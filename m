Return-Path: <linux-kernel+bounces-351600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB45B99137D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893B12829CE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2591A28C;
	Sat,  5 Oct 2024 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0PRXzXp+"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E817C69;
	Sat,  5 Oct 2024 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087844; cv=fail; b=E79z3aqzKlpjka+xKmzBz6lxm56DbFSMyIsNWM89w8Tpq0DDwMO3/KQP0UqqzxCUEKavTRQaecob0l/tk8TJp34QvitMslHS45HZw0Wmwp4ARyz4iYnvRHyYveXFdU9DfqE8fiy3yEDbkanncJKyBvoUsuHD5j1Us1GHwfDrKm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087844; c=relaxed/simple;
	bh=Q0p79Ni2pkv3+XsPrMjJ9d/sZCuouVZ9g4r74D953Tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IqQ1IMWqZNq+xCRV5DxhWNaekh2EjCEvPs9zPfa1YRmEYnHNG6YCnL9NsVlV2WZyHqn/3Y0V1wihT+ZEWtavYENZuQuPw7RO5aelVnVPRohZigOTCo9uvTlL99aXWDgxU6HcP34YyZECb0I+yzlNweTuNGZU+e2KLosTRWqkSug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0PRXzXp+; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFTiqlgt7dfwwe3G7y6gQUQUK2BuO6lRb5PiwRb25qwy8l9Ts9ZSdgzw19Q8xY6WMLwwMNFmdmSgXqr5ZXtWlvUwstIZMFcMjyg+y7dm1i2kbt3MCS+HhTuTQh7I7WCIYyXQq3Jx5g8klLOsd4fSEIYNkEzXtnV/5wN1hQl6QQ/gl62Armj1iNkRFOf8SdtSfknDENhFFQURBqpvYtCzcZSoYvVMvzIrdzvqrWiqVRt+2y9v/U8gkD9BpYckdxAYrJ4awl41spclSAz2Ju+h4tfgE6tmsXsG1kVJi1nJVcKgnDDAWxQfctFmJFx9a71MUdvMdB8bgB8qHkAJd9OWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD/my/F38SIeCa1uPx+A9c9tXp5CVb0QKr+CPH1PXy0=;
 b=CdgRI/9HLfgoPni/zFouIBT2pC7WHkLLQDqLmINRatrK112KpPquG4tKHpfrx1nuk7fJTiXs9sHUy8r97LACOM/U+uLqt1ZyM8Yei8rRPd4idWWNcM86YbpyBCwoP8pW7hBYOB3hx3zd8nRIjEEERomAHnCjSfJivKW7dLhIGjHn0Hg4vLHyGNGvUwyUxElKb4ZJ1N7GSR+2GhsJN+Nt5cX5pQ/mKBOGkqzitRdZaFPbVgNcJdkxFVrea6tujV4tziC7tEwcTmAF8I71HgSE/TPLC+RszfYXoGLWhAUJuwK9VahMOJZAmZ2LLsOTz0vL4v6rfpB8o5A6HPl5wWry6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD/my/F38SIeCa1uPx+A9c9tXp5CVb0QKr+CPH1PXy0=;
 b=0PRXzXp+5JqcU6DS0CRvIiF19wE6bL7537N82wF9BTEIB7yA4RqGpWHa0EclyfKeixrb48OLp9Y09jdxFkZAeygI9qySn91KM+QITYzYw4vtbhSzIif3ypK3bHzvH2ARs0iCTTzSuoRYRP8yBYw4RZ1ojvsQJSkZkuOfKORSRSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 00:23:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.017; Sat, 5 Oct 2024
 00:23:59 +0000
Message-ID: <65ad7f42-c3a0-c587-c1c0-d76dda3bc455@amd.com>
Date: Fri, 4 Oct 2024 19:23:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
 <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
 <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
 <3b6a8ec9-5e4f-e4ff-cd01-96ecc366565a@amd.com>
 <4c212746-6d61-44aa-abc6-2d2155ee538f@intel.com>
 <1f7addbf-51e3-7f24-ad64-b8a6d9c5e0ba@amd.com>
 <fd138377-3a69-4749-b32c-f7bc3783a611@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <fd138377-3a69-4749-b32c-f7bc3783a611@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 919e36d5-1af1-4706-0f29-08dce4d40141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElFRUc5SjNIN1lic1VTdExuODVCTUNsTGhoVkRHYkNld2FaOFdSU1F4TStn?=
 =?utf-8?B?MGdXT3NLYk1Cem5qQXp3WU9sOXpSZC94cnlEc2E1M1ZxTkhyZzdCSG1ZYVJK?=
 =?utf-8?B?Wk02N3BLblZIdmwxRi9MWFJQMWxsai9nVnRCUEc4eTd6M1dPRHJ1OFpWRWli?=
 =?utf-8?B?TFQ0WWs5M3ovQzlweEdzUW5lbUYyYTRrM2VHREhIclJWQlF5MjZrUThXUWwx?=
 =?utf-8?B?ZHNNZ09CT29PRXhuUjBac3gvK1QwTDI0U1kzQXZMRnB2eEdobFdXOHQzOStU?=
 =?utf-8?B?MitTZWl6bXo5dll2NHd2cTNuSlZTZGlnWUF2ZHZwMGRCZjQ4M0ZSelc0Y2dY?=
 =?utf-8?B?dDU0aWZBb0VxQTM1TnpKYjVwYkZHM3gwTUFSRHhtaG5RMXJlU2NoTUFMc0Q4?=
 =?utf-8?B?dnFWUWprcWZCUmZTdWhXSEt1ZFU3UXhsQ05BOVplUVFTSHp2YTVhUFdkVTBE?=
 =?utf-8?B?WkdJUVB4bG5NMjJEaXE5U08yTG91ak45b1IyNWx3VFZIdm95bkcrc01oS1JP?=
 =?utf-8?B?SzBBcXRNNEhNbVJYb3pJVW1PZkFMbXFOQWlNclpBSlZXTEp1djVFblNyYUY5?=
 =?utf-8?B?QjFmbjJVdU5WWGk5M2NyemtCaDBZdE1uNExtMjBrTU0rVklHWDhtb0hwTFBJ?=
 =?utf-8?B?dXcrSGkweFcxZlZxNXB0N211ZktWSUg3aVBQR0E4Ym1sUG03Q2tzTVNyZ05a?=
 =?utf-8?B?QllMaEVmZkY1NjJ2QnRPajRyUTQ3UEdqbjNVOXFCcG90OW9MbzBGeWVaaTg0?=
 =?utf-8?B?Rjh5RnJmZ0ZnaHpSdmtaWk9sQk5UMi9PRnJGR3VQRldoMnhObVBFd29oVFZL?=
 =?utf-8?B?M0gzRVZtRmlkWWlybEs0ZUN1RG8xQW16SEcwLzhJMmJuRkZYTW1kM0wxVE1U?=
 =?utf-8?B?a3NHcUQ4NDV6WS8rTnczWXlNREtnd1FaWUd6MlhubEVnUjY2dzRScFVMd3RL?=
 =?utf-8?B?RzN6RGNKY0JRSkVvMFZjdzZMWGdhMGRFODFxSTluV1dZS1gwNkppZTN3Vk91?=
 =?utf-8?B?bXY5bXVzWnI0RUlDZmVNQTZGajd4RlZiZXRUZFNRalVnWHNOU2V0L2xTcnlw?=
 =?utf-8?B?emF3SmtCR1ZVM1MwZEsreHExeXVtbHQ3czA2OGloQy8xTmtSTytWNUpGMHBJ?=
 =?utf-8?B?Q2g5WkhwUHRHL3ppRG5Iak0rY3NCOFliL3pJZmp6ZHdXOFZqejNYR1NCOGFK?=
 =?utf-8?B?VXlGdkFhUW9BUk1OdzRwaWVERWlxKzQ2N2wxN1lyUHRDQzR6b1crVFdIUm9v?=
 =?utf-8?B?VmdxMUpVbFI5akR0ODNZMHdJeXdqZ3FTYXBJMGtBeXVGME1TNDFFVFA2UzlJ?=
 =?utf-8?B?VFczeE1lYlNMRVg0MGdmaEcrMHhqalR0cDkwSzJ4RHRRMjd2bzhjaGRzOGlU?=
 =?utf-8?B?WXJoWmdoVGVwbXRJNklweW95dXVJQ1VHaFZQZS9mYmh3T0phNDBYeHA0V0hL?=
 =?utf-8?B?UldYcG1IaGtqT01yQkJyU3IyakVNSkRnWUszcFdxVXBSL1RFam14K3pqbjhS?=
 =?utf-8?B?MkpNOU5mYVFwanBFaHJmdkFRYkdBSjVpcGpWb1NoRVdneVR4dzJrVG9NeVVr?=
 =?utf-8?B?OExVT3ZQdCtuMGphYmczVXJ3SElZcWJ1amNQZHRWSWo4bGpQWTNUYVR6d0d4?=
 =?utf-8?B?SFFZUVRUT1lVdE9jMk55STBsY2R5N24xYnh1VnlsSDJSdGFTby9kQWJYV3ZL?=
 =?utf-8?B?U2sxdEw5ZXowZVRFNWRsbkZYR2ZmWEt4Vnoxdjc3b3BBcHFZYjU5Q1J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T055alFmQzZhOXZZY3RYekR4ZDR5Rjh4OXhBT2w4SjB1eXh5ZHVzQ1luczJq?=
 =?utf-8?B?dU9YekZubHM0eUZlTVR4bklCMkUzZEhUWUNvRy9JOUhncHRCR083OFlzYmQx?=
 =?utf-8?B?RWwySTV5MFVGU1FuOHo1SDlCaFZaMW9YNFcxWGUxM3FPd3d3TmVGY3ZmNE5H?=
 =?utf-8?B?aGtYOTJJOVZWQkVpOFB4Nk1DNzVqUDRQbHo2WVFLSFkvSjdLbTVjaC84c2kz?=
 =?utf-8?B?dnNpOHJxSUY3V0hRdHhEL1lrbWcrb2JHQUN4VFVyUDUrYmJudHg0S2VHRWkx?=
 =?utf-8?B?WEY2N3dkQWZ2T203Wmt0dlJ4MXJXSThlZVl3UGFuNkQwTkRjQ1ByQ2w5YmZB?=
 =?utf-8?B?bWFOMElHbkNTYjRvUUFkK09leHROZ09ONmlDQVhGWXhvRkdRTkNZZllJN25o?=
 =?utf-8?B?NFFxakVnVU1sR0kxRjF0MXpsRjR4Q2JoV25uNTRRbkRDMm45dllFbmFuZkVG?=
 =?utf-8?B?RG45Qy94S1BUd2U1dzBCMHAzT3dxTHFSQ3R0cVJHTHI5amVDa1VabXhYZ1B1?=
 =?utf-8?B?TmU5NTdmcUJGRHk4aXZGbWdjUUsvTmZxeEtvbStpQTFIbGcyR0ZPbUh6dlRZ?=
 =?utf-8?B?TFY1L0V3dHNLaVIreUJZZS9hTFJ4TExCeDI3OTdPMlJ1OERMRkVBS3RyakZM?=
 =?utf-8?B?NFZnUlNkUWpCT1pCYXdLcGtGcUVKVW51bzFYS3VxejcyY1NkRjgvejR2Mlly?=
 =?utf-8?B?UFMxMm8rNjl5SFEydjRhMDFneWJMTnc0UkQ0U1hJYXJCQmhyR2t3anBXUWdy?=
 =?utf-8?B?YzV5MnhhbXBlSkJoV3RZZUQ2MnVoZlU0NzRQY1RrZDRaZ0tWQUZVWnQrTm1W?=
 =?utf-8?B?NTM1YUc3OGFvTXhXc1d4ZldHaXo3dkJiTXpmSWpIZkRZZVQyMmpCNytaZUVN?=
 =?utf-8?B?WVJHMXJLeEs5ZWZhajQ3ekVpYnRZZ3c3SkVobzNHOU1VVDRhQi9ETFBTZ21i?=
 =?utf-8?B?Z1ZtWStEUFdaZlBkOUtkcEJndlpuc3RCZ0xVUWhsQTZqMG9IOWRhalh4L0Vo?=
 =?utf-8?B?cFVncVF0YXZPc0tHV085VlZldEJlZTFJa2dITy9lNGdVM2pubVZrRFN0ekxz?=
 =?utf-8?B?NmpNdGtVSG1BcE5hd1pXNXNVZ3dnb2hvSFQxRmNJQ3VDQ3F3WEpEK0laZndD?=
 =?utf-8?B?SDFsMm5iL0x3NkVyeXNvYXpEOEpkZi9mRGd4TElLaTFWbFJpOHFWTWQ0Sy9n?=
 =?utf-8?B?YnN6djQxOWZwdWJBRHROQWgvY2NPZm9LdlB1L0N3NXhXNFhwR0xnaFR5aW9D?=
 =?utf-8?B?cVI1SjloSXBtZWg4UjZiWnhEdmZxUTdpbjdML3d3MjF6MElLV1lwRW91QW5Y?=
 =?utf-8?B?VVU0U0dvaDNLUjVaemw2R2hhNlh5akVQSHVjdzZxdFZJeXJrM1RpNWp5Y3F3?=
 =?utf-8?B?Q2FrOEFqMTlCVFZGY2hTTE9TbG0zdTFhc0k4QWMxZVEvNFZYclA4djVoM3A2?=
 =?utf-8?B?MWFzZTl3MTJiL1gyeGFFR3lJVmVKaFNGUC9abzBVd2tRODZqSVRvU3Nwd2Rk?=
 =?utf-8?B?TFJPVUdadDVoTmd0KzQyR3p0K1pOZEErekg4ejZnWnBZUjhxSDBZaWtrbFk1?=
 =?utf-8?B?aS9sd3lDWFNQbUgzWjFzTy9qK1dJL2YwbHhkaGtpenVRR1JxNWdoRTA4QXhU?=
 =?utf-8?B?MzNUc0ljZzllVC9qWVpoT25VcjNkTlFua0s5eE9YU1VsTm9oVUt4RVREMzRX?=
 =?utf-8?B?eElTZEUwcWcxeEdqRk0zc2puNUYvT3d2azkyc2haeExmalp3UUFqV2Q2c1pz?=
 =?utf-8?B?azBicWJtMnZTYUE3Z2FOdkRFZ3M4WTRncDZvcUVjUTRHRmY0MVNuOGdCeUZk?=
 =?utf-8?B?OWdxNDRTS0NpRklwa00vUkdZY3lZWmRtYXNtK1k0cG0vTUJwcng1VUZsUkF4?=
 =?utf-8?B?ZjhtdWszeHpZRFdlUlQrWkkxdlEyZjFoZkZxUllmVVQ5WUxtU3lVa2ZjaEh3?=
 =?utf-8?B?NjVseTJ4a2JERDlkWnhHVjFsNnZYbmIxSDBoZk1KWE9ka2Zadlo5UERMSndE?=
 =?utf-8?B?L0FiMDl1enlrZ1RrTVFEMXROM3o1UzFWcFIwNmY1NFQvOE41TzZUcmdhRmN2?=
 =?utf-8?B?U3BXMmlDOGVOVVBGbTB0T3VqUStJaEtuTDhvVHZ2bWFncTNaUzRJOUcwZngr?=
 =?utf-8?B?VTBvQWFEK3lFM1Z0OW8xQmRZa1MveVNqNmNsS21wRGdoOFMwNlRjUzAwK0gx?=
 =?utf-8?Q?WveoVFZyv2Qvs3L8A4zIew/amRaAu1v6ZwmyMjwwnjz6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919e36d5-1af1-4706-0f29-08dce4d40141
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 00:23:58.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyPSuMc5vg+61wi85gF3a0975IERzYjNR/H9ET6zbtbNwWe6CSZhdW/Rz+MR98kj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

Hi Reinette,

On 10/4/2024 4:09 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/4/24 12:36 PM, Moger, Babu wrote:
>> On 10/4/2024 11:52 AM, Reinette Chatre wrote:
>>> On 10/4/24 9:38 AM, Moger, Babu wrote:
>>>> On 10/3/2024 9:17 PM, Reinette Chatre wrote:
>>>>> On 10/3/24 6:11 PM, Moger, Babu wrote:
>>>>>> On 10/2/2024 1:19 PM, Reinette Chatre wrote:
>>>>>>> On 9/27/24 10:47 AM, Moger, Babu wrote:
>>>>>>>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>>>>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>>>>>
>>>>>>>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>>>>>>>          Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>>>>>>>          Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>>>>>>>          Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>>>>>>>          Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>>>>>>>          Removed ABMC reference in FS code.
>>>>>>>>>>          Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>>>>>>>          Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>>>>>>>          Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>>>>>>>
>>>>>>>>> Could you please give an example of what problem may be encountered later? An assignment
>>>>>>>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>>>>>>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>>>>>>>
>>>>>>>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>>>>>>>
>>>>>>>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
>>>>>>>
>>>>>>> The last sentence is not clear to me. Could you please elaborate what
>>>>>>> you mean with "are assigned earlier this action"?
>>>>>>>
>>>>>>
>>>>>> I think I confused you here. "domain=_lt" is equivalent to "domain=lt".  My reasoning is handling all the combination in the code adds code complexity and leave it the user what he wants to do.
>>>>>
>>>>> hmmm ... and how about "domain=lt_"? Do you think this should also be equivalent to
>>>>> "domain=lt" or perhaps an expectation that counters should be assigned to the two events
>>>>> and then immediately unassigned?
>>>>
>>>> Yes. "domain=lt_" should be "domain=lt".
>>>>
>>>>>
>>>>> Giving user such flexibility may be interpreted as the assignment seen as acting
>>>>> sequentially through the flags provided. Ideally the interface should behave in
>>>>> a predictable way if the goal is to provide flexibility to the user.
>>>>>
>>>>
>>>> My only concern is adding the check now and reverting it back later.
>>>> Basically process the flags sequentially and don't differentiate between the flags. I feel it fits the predictable behavior. No?
>>>
>>> This is the point I was trying to make. If flags are processed sequentially then it would be
>>> predictable behavior and if that is documented expectation then that should be ok. The problem
>>> that I want to highlight is that if predictable sequential processing is the goal then
>>> "domain=_lt" cannot be interpreted the same as "domain="lt_". When flags in "domain=lt_"
>>> are processed sequentially then final state should be "domain=_", no?
>>
>> Yes. that is correct.
>>>
>>> If sequential processing is done then "domain=_lt" means "unassign all counters followed
>>> by assign of counter to local MBM monitoring, followed by assign of counter to total MBM
>>> monitoring". Similarly, "domain=lt_" means "assign a counter to local MBM monitoring, then
>>> assign a counter to total MBM monitoring, then unassign all counters".
>>
>> Yes. That is correct.
>>>
>>> If this sequential processing is the goal then the implementation would still need to be
>>> adapted. Consider, for example, "domain=lt" ... with sequential processing the user
>>> indicates/expects that "local MBM monitoring" has priority if there is only one counter
>>> available, but the current implementation does not process it sequentially and would end up
>>> assigning counter to "total MBM monitoring" first.
>>
>> Sure. Lets accommodate the sequential processing. Process the  flags
>> in the order it is provided. I need to make few changes to
>> rdtgroup_process_flags() to address it. Hopefully, it can be done
>> without much complexity. Thanks
> 
> I doubt that the implementation would be complex but it may take some effort for it
> to be efficient ... taking actions that involve changing kernel and HW state for each
> flag as it is encountered vs. parsing all flags and changing kernel and HW state once.
> 
> The risk is that a simple request like "domain=lt" may take twice as long when
> doing sequential processing. When users provide flags like "domain=_lt" to take advantage
> of sequential processing then there may be an argument like "user gets what is being asked
> for" when things are slower, but I am not sure the same can be true for a user
> that just wants to run "domain=lt".
> 
> To me it seems simpler to require that "_" always appears by itself and that

Ok. Lets go with this approach treating "_" as a special and cannot be 
combined with other flags. Seems simple to implement.

> any flags set by the user using "=" are combined during parsing so that they can be
> acted on in a single flow. If indeed users want to do something sequentially
> like "unassign all flags and then assign local MBM" then instead of "domain=_l"
> I think "domain=_;domain=l" could be used?

Yes. It can be done.
thanks
Babu Moger

