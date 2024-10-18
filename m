Return-Path: <linux-kernel+bounces-371910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95029A4214
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AE41C2248D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172EA200C83;
	Fri, 18 Oct 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yh17YHDz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68792200BAF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264453; cv=fail; b=KdQpxDBqBmtqhNh9NAczgSZFvFb5c2QscZMgEUhGnZWVD59IUkEFJeoz8y2jHrIaWkanIMb2uRbo7eiITsF2evryqtB5kK5+V+U1DyBY0kZCUU4d2jh0movOUUpG/5tuzGv5mJCBmwLLq0DjgA7ZkT76VbrCSlWAedwfD/F1Z5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264453; c=relaxed/simple;
	bh=Dwa1KQlEubOf7z3otiZdYC3RAPD/A3pMW0SzD1d/nZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtiaAgyoXPEj8qnWY+G1q+/FpzQlQBzkTtWoc1juwJdH/3cKdlQUu8HR70VR/r2kmU9eYZ61Xc0POtib/ksbtr452zd1JTrZDMQ3n7hjxjYyuULQxgd7M4k/cKl762OIqShDR/DpI0MkD0BKEIvHMz8D62XTfKYmEksvoJ4FpC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yh17YHDz; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGutIhN8GiWTElmGDRkENOWXM5beu1YisG9BAJsDJeonqH7ZoOYL3nZRYKW4Vd4qcq13GPICBnBcSr2a3yyH9Wr119gV4drjHbh9uijvgYaTVaojKIHHcK5rBNRcWMZ2pXnM07zFWEjJdUCrfqgiCWkXifKnw72UlMS0FOhQ+ngTyMARb5pJXSctqI+LUca17imfIIlRFTbbwHC2iw8LbC09EvZPrVq7kBXZI+DJqPiRlnx8MgXKPfExDE63yzXb6fb82Ux/N65xfor+Sm0uA1WE6ExBogODTirfTzS4FgnnjzEBkoQg/ohMZF2k9i2pUpLQZ1RBn3vvlQTdZ0a6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzsfP73V7cF8wz6hm0D2aeIcpBJgCPP9IzHDqdnoPrk=;
 b=Fy7VYFeHJXLEutUfXgsBiA1LA458XdNWQiSfp+2UethIv3Zh7+DFYYLSsMcPVSfdbPVrHj3EthlffXgoPO54vZ6L+y8FzVwzKsph9SJOwcKbpsHJgvmhygawZWiS7l7VOegan91P78qyizghEtcXNHYbeq5bwiB3aU6kXXRZE80eNWvm6W8coGumJIaT/7Fa3SMuNnxLP4gduNFxqtvg35eXbwYJro+2xSvNaNMr+D/UH2Ouf+5g5P2YPPH4LgusEIKV1TyJf4PFfckPAmRanQY1r829CSlJ1wF0QP9u01VJgHiW0qcs+3JpNjJYAdMIGwBMftBYkXtt1E/GosOluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzsfP73V7cF8wz6hm0D2aeIcpBJgCPP9IzHDqdnoPrk=;
 b=Yh17YHDzUt5q0jcmdkPGEre4VXt6Gof8MgEiTvT/HRP41Pz6Mla+FfkNRdF9EKKGmVY1fqN9ZW1kJGWBcfNz11KsKS+w9+s1vvtCEMt5NVMf/PLshGSFpzN8nrWiVndtYMOP1bc000RqJL+uAvJUKHyPn83c2D0cKSrnwtBLGEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 18 Oct
 2024 15:14:07 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 15:14:07 +0000
Message-ID: <7820cd89-f25a-4934-9597-d53e861d6e92@amd.com>
Date: Fri, 18 Oct 2024 10:14:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
 <20241018124118.GCZxJXbvAIcEak1gue@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241018124118.GCZxJXbvAIcEak1gue@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af3b231-eae8-450e-cc3a-08dcef8782e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGJtRVkvWXczKyt4NzdFRUMzaFZ1VGZqOUlWVXMwOHRkWVl3cUU1ek9zQ0k3?=
 =?utf-8?B?b05HRHM3NmNDZTdTSEJ3anRZS0htczRCbkpUQWc4ZWw2TFQrczZLKzFFVEpm?=
 =?utf-8?B?N1lsTGFZL2pCMERyc2pVb2syTDRSbUtjTUFVcDBVRUxCTlhBcFR4djN6TU9I?=
 =?utf-8?B?bkJweVhwdWV2SmxXc24rWFI4a085Y3FPS0Q0aVgxR3ZKVlg3TmlwV1lZUllU?=
 =?utf-8?B?dHNYbnVKNDdyOUN0bkZWMEc1L1pZR2djUmc5eEtxQWVRZW1oZi9GbFlZRlBD?=
 =?utf-8?B?NkwyTUZuQktzSnBUWXNJYjl1VTZRck1kSit6Z3h0RGNGUjZ5WG9JbHphYUlm?=
 =?utf-8?B?cjNiVDd5UnhKY3JUdXg3K1RGNVBycldZQWE3NXdwZmNwdlYweDc2QUdsUHhN?=
 =?utf-8?B?aVJHWTd5c1ZGWVF0aDJTNzlsMzMrM25XbHhRbDludkpoby9pUUx5UUJvTWhY?=
 =?utf-8?B?TzlYZ1oydVVlK3RJa1FMMGZVemdkZmhleEk3bkhVSDNKYzZMNElWTjFKTjhL?=
 =?utf-8?B?NHlIZjZvTkdXMkdGc2R3ajR3N09QMlJFRzJnc3RmQnF4ZnJ4WmVSQnFNWE5D?=
 =?utf-8?B?ejJEVVN1K0lDdUl3SGF0aWtUVzJ6eWZDQjdjeFdiR2dMU05WcnVaMTBadVlh?=
 =?utf-8?B?Tk5hSStjOEhQbk1rTnVRNTgwZGEvejFKSkxVelUzc0JHbHZvcUhSS1RvTk94?=
 =?utf-8?B?VHlvblY5aGJFMEIxNEphaitKdDZlNmN5TmFnczAzQkZDbkF4YW5kMExXRVBK?=
 =?utf-8?B?TWt0K3hvZ3FxMGU4b1lxQnJkRlB4SXdrc3dpUUxTcEQxVnNwamxNT2pxS3Ro?=
 =?utf-8?B?NGJVRkJaVVdGOS8rVWdmOERyR1pwWmxmNVQ0dmExRlJVZG1iYlZrMDJSNU5G?=
 =?utf-8?B?R3M0anhPRjMxMGMwL0tVQkZUSG8zS2FyVi83Y2VteVpRUk1XQmNlazdkSXBD?=
 =?utf-8?B?dFlGSXdkK2g0YlVzRUh2SHJFdjJXZ1BsMnJvU25lL0JuZGpoTlRlQ3dROFp4?=
 =?utf-8?B?YWlrOGJrNDBISW9VOEhRZ0pZbEpTS2ZOdnlCVFo1TmZzY3lpVm4yTENWM0hs?=
 =?utf-8?B?aStlU0dlT2FSMEI4Uk1IYWtMbk1teFBRZXBvcVFHL24rRTY0R1A5ckE3VXdU?=
 =?utf-8?B?SUZvV3hpcDNaTUZXRVZnK1psNVVTaWNIWkpsOXlXcHVlSVpxczUzN3R1Z09Q?=
 =?utf-8?B?dE4rN3NwLzU2MlkxT0VZd3B5MXd6T3hmbHFlZkVsbDFtbkVkSEd6cGZvS1FI?=
 =?utf-8?B?WmNyS2NabnFkZitUbVJqQmp1UTU0RkJWeGpWV3M0dmVhdzQ1MmY1ZmhnZ3Vi?=
 =?utf-8?B?VmpEdmgvSGhxV3VUcFBsOFh0aVBnNXdpM0E1TVF2SmVUVGo2ZTZmR1REK1k1?=
 =?utf-8?B?TysrRldqUUFkbzYyOGxxMVFXRU5GV2NHc2F3TlJ4Y1JWWnhmWEtITVI2aHoy?=
 =?utf-8?B?UFFpbExjWVE5WndjV2tIYjhqWGg3d0lTUXZDdlorTmxjL3NUa09PdHlCSzdz?=
 =?utf-8?B?Yk5hSndUNThONEFXRXRGUlQxNkNKSXN5Vi85ZVl4dlhOaUFsWFhZVGFoY09S?=
 =?utf-8?B?VHJLN0FqR2JZRXkwSHVRcVFQcVV1SEtSamcxU0RTSVYvWWZDbmtzMFhIVnFs?=
 =?utf-8?B?TFhkbUVWWm9odzRKbzVaR0NQUlFxTEpsNHVuV2FSTFhLbEcvUDE2Z21uMjF0?=
 =?utf-8?B?bzdNL1pKbjBJa2g5d2hhQm1PSldGVUZMeXE3Q0ZpS295b1ZKMGRtMkdpUUly?=
 =?utf-8?Q?12S/Jx5mE5yzJ+w4uXBE4WFSR6HESzVe3Gnm+do?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHB2ZUNmSk13R2pCL1pXRHBTemJhZE40SWtIclpUYlhQQnErUDVaRmV4U2RV?=
 =?utf-8?B?VGhwaW1GY3RrNVA0NUNBckZnMUkyWVhnQTNycE84c2tYSGlhSmtWdXAzVnVm?=
 =?utf-8?B?cUcyeHluczRBMWVWMEsyejQwMHoyTzNXUzJWVEk1TDY4TnVDWlZKSFo5ZHNk?=
 =?utf-8?B?Zm9yZDVJcDQ0QXgyVE53bHZnYUI3TUs2c3UvdGE3NFkrd0NsQUV2MVVtVXhl?=
 =?utf-8?B?amRxSjNsRVNHY0R0T1h2ZlRGTG9HZldzZWEzMXlaeGVQQlFsVm5VdUt6dVl3?=
 =?utf-8?B?K2kraTNiMkVhUXFGQnltL0hJR0d0Skhpby9rbXZGNzBZZVFpa1BwUWk5dTM1?=
 =?utf-8?B?eXpKNFhLNFAvWG9IU21zTUxIUlYyQVFzVFZDL1NoZXdoaGJPQ1lQeHIybWkx?=
 =?utf-8?B?TnJRZkhXYU5rNW5xK01KVXMrWEpCR1dUbXdvSEVnSzRUNEZ2RGlCUFdGeHNH?=
 =?utf-8?B?S0g3UkJiZVU2NEs5eVUrUC9jeTdjb2FZNVdsd1N2cFlibnJEZGNLb1ROOXlZ?=
 =?utf-8?B?WGtLVWJQdytCTkdENmN3ditGQnJpZG5EUXI4d3FSMnpuNFdQVFJXNGZZWUhP?=
 =?utf-8?B?WFJjTGFUeWNLcUtwKzRmb1VmY0tPOGt3VzFoeFdZZDI2dno1MVN1RllaRzZP?=
 =?utf-8?B?UEVlWWRMdWNVNHFGYzJRaXN3SnZaOFhCY2dOZUJOVGZPSWxxelNGLzd0emdY?=
 =?utf-8?B?RHdiZEZWcXVSclBGWnZsQ28vcURtTUFyTzJMMTV0bS9DREVhTGJvNlZlbUJn?=
 =?utf-8?B?amRHRHQ5NWlCWjNvcHBpRUw4VlVQamh2Qis1UXltRDBYRVk3ZTh5bXl2Skpa?=
 =?utf-8?B?bkErMDJoMEJlUXZ4dkYzazlVNFQrbS92Ylk0S0JFSURCVTNLQ1VkV1lkOFIv?=
 =?utf-8?B?ZTdjaUkyTG94MUlhclRadG5laVhmTVhvaXM1SWhySk5vM05jUzNjZEVPb3Bj?=
 =?utf-8?B?ekhCOU56T1VLWkdVM1lZOUt2emRkaE5DTXFFcC9BY25vS3ZLRE8vWXMwZjMr?=
 =?utf-8?B?V25OaWNld2hLdU1PTnBUTVRVQ05mMnovNTNXdEhYd1lnVlZjM2gzOWlZaWtu?=
 =?utf-8?B?TWRXY1B6eDkzUzhBcGVRdTY0aENnSWNZY0xIRDRHZjduQkVBWHpZcGs3SXph?=
 =?utf-8?B?MzFCUE9PdWdUK0F4TmZFK2tXejYvRmVnMmpLVitTWXRsbjRSRkVBQmFPNG1i?=
 =?utf-8?B?TDRXRmU0Z3dDb2VoODFwNVYveWp3ZkhzaXRHU1ZoSytMcTRWeUFsV1RLVkYr?=
 =?utf-8?B?OTNmbmtWblNjZjFxY29rdi90eUFjZzBJVmg0U3N0Q3h4R1piNy9SMytldk5R?=
 =?utf-8?B?ZjZmWU5sb1pQQmUxbzZWZWU1NUdlUnFySHZFdTdiVHNBb2NPRjhoZ0wxZENu?=
 =?utf-8?B?TDNXcTc5Y01hYWM5dGxFRHo4d1d1S2tMVm1rejI5T2xXUzJYUEtlWWZHUmEr?=
 =?utf-8?B?RWhWdzJnK3VOODdQNDdjTWFHeHhBc1NSOHliaUovNjJQbDJVOXFXUlhtRlNx?=
 =?utf-8?B?U0tDMVpjK1o4bEtlMXBYQlJndC9zUE1JYjh3YXdCWUFDSHQyT2YvQzY1cXg0?=
 =?utf-8?B?bUlPU2k3UmhLcnp6amRLMUlLdzQ5N3ZuZ0lnUTdZdFl3RHY0M3NxU0w4bGVt?=
 =?utf-8?B?VVNCNE5CS00wMk5yTXU1VFhwd0JWQno0SEloQitMbXZIb2YwZGE3SDZCNmRH?=
 =?utf-8?B?aUttc3pzS1JyeHoxTENneDNCZkhjcS9BR0xMOGZIYmlwd0lFVzRxRlhCcllB?=
 =?utf-8?B?OEh5K3h2dG1XemRwTFJFNHV0MEc2dmNPZ05vazczYzI0ajIyVkV5Q3FlNmdM?=
 =?utf-8?B?eGwyZmhaRE5TcVdzRUIzT2NGN1VTWGdBTDRwdUtKdUF3YTg4cnNUcFJtdGp1?=
 =?utf-8?B?bGRNSWhSdjhUaDIzY3FoVGpUb3J0ZkFqRlF4VzBFdGswVTdVODAzQVRBU1dO?=
 =?utf-8?B?WTdUSjFNNlRWSElPa1NydmZ0amFNR2ZXREhPRS9NZlZQMnZ4UWxJVWIxdWxn?=
 =?utf-8?B?WVV2RGM0WTB4OS9tai94SFFSeGVaOWliT05XSXk2MGRpTHF4SmxqNDlqU2RU?=
 =?utf-8?B?cGlyLy8zeWVkbmZ1VVpwVHp3TXpJWEE5RFZ1MzBTd041a3I3TmNXNjgzM3pV?=
 =?utf-8?Q?HYYovYsca9xRKeT55vOdS4Qaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af3b231-eae8-450e-cc3a-08dcef8782e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:14:07.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOFlAVsUh//5UPCld4GINHDNlzwfXxynmiIdTuevC/Yw+NYxP0yCX8ROqMWwUhiB3rT+qG013HMzm2lCn1uKcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255

On 10/18/24 07:41, Borislav Petkov wrote:
> On Mon, Sep 30, 2024 at 10:22:10AM -0500, Tom Lendacky wrote:
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 103a2dd6e81d..73d4f422829a 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
>>  {
>>  	struct rmpentry_raw *e;
>>  
>> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
>> +		int ret;
>> +
>> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
>> +			     : "=a" (ret)
>> +			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
>> +			     : "memory", "cc");
>> +
>> +		return ret;
>> +	}
> 
> I think this should be:
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 73d9295dd013..5500c5d64cba 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -303,12 +303,11 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
>  	struct rmpentry_raw *e;
>  
>  	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
> -		int ret;
> +		int ret = pfn << PAGE_SHIFT;
>  
>  		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
> -			     : "=a" (ret)
> -			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
> -			     : "memory", "cc");
> +			     : "+a" (ret), "+c" (entry)
> +			     :: "memory", "cc");
>  
>  		return ret;
>  	}
> 
> because "The RCX register provides the effective address of a 16-byte data
> structure into which the RMP state is written."
> 
> So your %rcx is both an input and an output operand and you need to do the "+"
> thing here too for that.

I don't think so. RCX does not change on output, the contents that RCX
points to changes, but the register value does not so the "+" is not
correct. The instruction doesn't take a memory location as part of
operands (like a MOV instruction could), which is why the "memory" clobber
is specified.

> 
> Same for %rax.

For RAX, yes, if I set "ret" to the input value then I can use "+"
specification. But the way it's coded now is also correct.

Thanks,
Tom

> 

