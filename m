Return-Path: <linux-kernel+bounces-361520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6979099A938
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA9DB236FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8AD19F11E;
	Fri, 11 Oct 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZKHk5NkL"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5265198A30;
	Fri, 11 Oct 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665721; cv=fail; b=TMLBmjRdIDGf4IQ4XZEVAFb7iGlrA57Ts1FbCxHgKtX8PKv3drVg9wyEvrKyFnK+NOXxRiTy17G3iy8DjE7HukhN5ZOIo25H/lah1iOHjomxRNUi0SZEx/NEbT8NWBVTjqztZAj12q0SIukaXKQMNE9wxR8SDNvxCr0hBfPC+PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665721; c=relaxed/simple;
	bh=d9nuI8vUeIgLEitElp/mBR7GfNy6YgTZkQTuWRwuQ0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LcjQsy3WaOPWSTKRtkHEm3sF4s89OVBA3ZMZ/f8dcL2RxbuI0vvfQlZU0RTZWfkvicS9D8Cvvq1j4+1oT2J13uPtWugPasmbr5tHHnPW/zIZFMp5vm2OzmwaMTG/1HkMzJWalGhgerB4iliJrNwQyTLvb/pQWHdmOi7ZudkPaAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZKHk5NkL; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouRBHio17d4PEHNGwX5X7/EL4f2zAXeqqtjAUFeQovXCZ5jguVTU6I/EEh57derQ4hEfdcngGG9fGc1ElMBoFph/R8cx9qsMHgEY9aazRVXIPZSNCpSfTOp7UVe8n00JPCz5na+XfTrTiN5bCX8A6+XtO5853CuWsie8nXg/EhisJbddOSHaRdA5CGDUv+Stae0a2erIBLmAtJGC/Btpp/aV4EMsmBFksgv6/reBQ1G2xHeydQEWX8pdIbE4FICf+dtjB9VQ8Xm5/NlN4m3AHEXRL19l5DO2k8qG2pnVtnVg692OgxT2aLH2SoCFQhYHzlpzAg6fTBg7k/bVFfM8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsY1vshF9ZmNKzMGPtZanEzCwUNOU/hIHIf5RsGAWEw=;
 b=SaaJoW0oM8ZyN/EbwRic4RpiKGqtOEMHfb4E4iAwgMblO8x638RJWF3qF+FjXyGQkehHY8fy8yeUPzxVkoH7P5tUJ/XWYYVUHL3/wXzQ7LdFX3hJIsBQDuTS5dQUVgxdahv6hGMQ5w/SNVNKMc+Q7/j3doPSu1OxQVWO3VNDZ5+lZcBhdLGgwPuvZ9AcXouZZS+nPPGz/ddtDDDO1lVZ7dBt8YCEAOrviKpppJgz2lsopcgDXGQwFaKhjeW4Ku/S4Epp0borJt2CrpF5rrckVM5hBa2kyu0w6JMC98bTpZg6RX65NqP94zFh2/U+TLVXsJXAmaSnPaDWOtTtoVs62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsY1vshF9ZmNKzMGPtZanEzCwUNOU/hIHIf5RsGAWEw=;
 b=ZKHk5NkLGXveUbXpZ6FGqBc1/MOSyaE37N0bmJNgHbIEuSOssg8lewkWl689JJxMpjTX2GG7VimGPRSeO0lFgSMMd2HUiwXod+t2Yq0zUVxVBuvckY8QJq5mqJGIhMRm80NkI9X5uXcEdPsQ8f2ws5EnQB6nD0azLzk4wHojjIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.20; Fri, 11 Oct 2024 16:55:17 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 16:55:17 +0000
Message-ID: <7df1961f-f120-3914-ef23-9e466cda6248@amd.com>
Date: Fri, 11 Oct 2024 11:55:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Dhaval Giani <dhaval.giani@amd.com>
References: <20241010121455.15795-1-papaluri@amd.com>
 <20241010121455.15795-2-papaluri@amd.com>
 <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
 <f8a3a683-0cdd-d1bb-1904-521ce5a96dac@amd.com>
 <20241011164825.GEZwlW2XggpAMsZ3P9@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241011164825.GEZwlW2XggpAMsZ3P9@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 80784136-7527-4262-13d3-08dcea157be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhOaU9La0laWVFtUXZZSVFhTVEyWlJzUTlNaTAxL2gzenU3cCsvekRxVHR0?=
 =?utf-8?B?bnNadnVvUGxjMEwzbXBZd2FGVXFEbGxuaFVzNDhhdzlhOTNpZWpOQnR2QnBu?=
 =?utf-8?B?MU1kZU9iWFg3d2YvbVBaamJITDVuc0RUSEJtOVVNSHYwcW1ud09GWDk1UnZz?=
 =?utf-8?B?VkpYc2pvR21lM3k1emVPTDYzL3MzRHBYV0IxcmNIajdETjVKNWxvUVlWd2F3?=
 =?utf-8?B?b3IwZXBCTFR6NGVXOUQwQW9pbUI0NWZWUThzM1hqdWx4VWJaWEp2WmZZRkw5?=
 =?utf-8?B?b1pUV01DdVNoK2ZmMmNVLzZ5RVdZckJ0Y0gwSjFDTHNlaGJhQmxpeko4S0Jy?=
 =?utf-8?B?K0s1MHMzRGw4RDFBbWNjYmxrNnliVHhVNGdzM3E1eC8vNmJCZXM0ckN5V1hQ?=
 =?utf-8?B?ZXNMNlZHa0tnQSt3bjdJM3FsK3ZldlI1Q0RHbDRRUHJzREpWUUlsMEtXVTVu?=
 =?utf-8?B?OGtqVVp4OFlLSlVTTHRURDBuNDJ4OHhqdTY5cmpyNmpnUiswYU9QeTlLYnR1?=
 =?utf-8?B?RmkvekhxMWd0ZW1PUEdGMTBLTS95TElZN2pBaW5EcmlKRkdVeUNsMlJmajgw?=
 =?utf-8?B?ekQzTEFuZTd0ajJjVTBabFFpS20zMElMcVhxSGRJa1FIRGlibHUxbUVxb0xi?=
 =?utf-8?B?bWhrbDEwbTNERGxvcEMzWWI1ZjFwa2dja2h3a2wvZXNtc3RueUI0alN6Umlp?=
 =?utf-8?B?cXcwcU5GZ3A2WktoL3R1cVBHV2d6ajl2bGk5dlk4SWtraUQwUVlMY1pZdjY5?=
 =?utf-8?B?MTZSRURMNE9mN3RvSS83dUdqdmNWWUdXTUNXZ0NlNlY0SmxkK1pnd01MbWVU?=
 =?utf-8?B?NE4rZVZOYmlNYVB0bWVUc2dZdlFYOUJVYjAyc09PM2VYTjdJQkM4eDJ1ZUw0?=
 =?utf-8?B?SVptdEJaWERvVTkvaDZGSm5XT3JYSnQ1ODBWQ1JJckhiVDRybFZGNzhFNW9x?=
 =?utf-8?B?THNvbzJPc3pzQkJ4dVJZTFJRaXBDM0pEeWR0amtCV215WDhoOXVHdm1QYVVx?=
 =?utf-8?B?c1VVdFJuYm0zL2JmYVpReVdVZUJZWkM0NHZYcUJUWkVHckdYb2wwSlZ5YTNr?=
 =?utf-8?B?WVhTVUdscFkrU05KMktKL0VDTU1vOFdzV01NZnZwTGQyMHlGZ0lPVngzUkV0?=
 =?utf-8?B?TURZb0J3eUhuTktjakx0WDR4Q3Y3SEx1UWNJdFVhamJrOW5UM1FqYlRXUFdH?=
 =?utf-8?B?MGRoeTY3TlBVUk9ySHBrSjJZK2F6S3Y1ekZkL2szT09Vdk5jQ0RiQXhEajFu?=
 =?utf-8?B?QWNYZU9yN2VSK3pVSVp5Y0tlS0Y2NzVUOVRmR2RicWNvRmVKcmJzTnRUUzdN?=
 =?utf-8?B?RFNqM3VZemY5bTMyTjVJdkdUUWJLeFdHbVlZY1NYeDBvb25XKzUxZTN3cmdx?=
 =?utf-8?B?bzFtYnAyZmh5bzUrU294NmZtR0FUNFVCbVFtMlIxSFB2aTBLVlF2YkhDY0xT?=
 =?utf-8?B?ZVFTamw4YTJxYVVqQUJaQXNuZi9BR1R3ellMcXEzNzN5cGg5eDNjbXB1OHFP?=
 =?utf-8?B?TUkzVnpaVkFYSWdoaFpxRWxQVGo1cmpXQzV4WFM2aFMwaFRyQ3dJM2V4YUdt?=
 =?utf-8?B?UCtVNGZMQkZrTk15bm5SZ2xnRk9iRDNuWHVYSFQ1VEU4azM4SzU3L09xWTRB?=
 =?utf-8?B?a1lyclFYNUptSmdkWHc5NnU3a1JDaFlua2VPcDliTGJ0eURBRXJJVzloZzg0?=
 =?utf-8?B?dUY0L1AxMCsvQ1FWNVZwVlBOL05kT3dRS1BzUXZuZm5pd3hCeWNvdzZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1RKbXpRazNoWEFTOGRsdG1EZ0JsVVZIN3QrNzFLYXhnczFrWk1zVlQ5anBE?=
 =?utf-8?B?WU5GM1JtOHBUV1MwaGJ4Y0oza1paSVRxV1UyaFkyc3gzUXNwcm1xSGlrT3NI?=
 =?utf-8?B?Y0hpVjhQemJxVzhkZzhFamtkbUFTQVhWTHR1Q3RiRC9EMEhDdXl3OU9HbnVC?=
 =?utf-8?B?Q0xJSThDclVQWkJIZ0s2ekJ1ejhQbGdSS2t6Q3UvN1J6bzlkZFJ5VzZDUnhY?=
 =?utf-8?B?UDd6U0xTS2FQc0J5ZkE3SCtyMEhUQ2pnWWhYRlF6aWNXbi9BUU9aQWkxaEVu?=
 =?utf-8?B?bmRhb2N4bVphQnNyNTJiY1JOV3NGcUpvSkk1T2UreGtYOGgwdUlTSlZPdmRU?=
 =?utf-8?B?WDhhTGdOYUxTVTMwSTQ4dGVtVmt3U0d6TGdqN3d0NHE1YzZBdm1pZWQ5Skkx?=
 =?utf-8?B?SU1PU3dFQVBXR01BcVFXZSttWWk2N0VXZ2tKcnZMSmxla3puWjh2YjVkQzBM?=
 =?utf-8?B?MTVMUnF0cWt4bTNWWCtYRVQ2RkNPaXpCNlNBSCtObmFnUlRXUHVyaEhQK2JJ?=
 =?utf-8?B?dXpmV3Jld1ljNGVLRG9TN0dtd0FUbzN4MTJFeEZQbS84RUtuNXBzb3pHTm9v?=
 =?utf-8?B?OUkzelJhNjdtM3F4Ykw2TmtLT3lHOFRtS3drbFpkcWRQTGo2ZzJOS3lKZzJH?=
 =?utf-8?B?ckt4MHdRT041WFAzaHB3TGtnM1BGUVlzS0NUdHZGMlByS2VEak1ESnRuNkZB?=
 =?utf-8?B?Mmh4Y3hvekNlSUE0aVJLbk5TZ2xMMXV4S3VaNTJjQWVFWkJna3hZdkxPbHFJ?=
 =?utf-8?B?MWYyeU9DQUhuVlg4MlRIWVcxL2d0UkRKOEJrRzdRRXhBdEZCZERNNThqMkl3?=
 =?utf-8?B?aXhVa25laFNWQXZobkNMYVUrRjVJMVU5dWRyUVRkcFFKUU0xY3gyWmZZek5q?=
 =?utf-8?B?dWtKN1Z3NjhFc1UvSUpDZFNXcDN4ZkROZVdCbTNJNDJ4Z3orOHpZSXBSSXhr?=
 =?utf-8?B?ak5NcVMvK2g2WmgvQ0VSM216Q01jQVJSSndxQUE3M1lWUElIZjI3RmZqVFlk?=
 =?utf-8?B?S0xVVGhyd2QxamlDOTBqazhNenUzT05FR1h1MGlsdGhsenp4dEZjL2tZK01a?=
 =?utf-8?B?cHdtSGFpc0pSMEpNWWY1S2RoNFJnRHdwMmFYb283SThFSEtxTGR4N2psZkta?=
 =?utf-8?B?UGttQ1EwSmtlSjY3QWlJS21sMjBFdkhjVysrSzkyNG9Gb2tIemF4b2greDZJ?=
 =?utf-8?B?eWs5ZTJrODNueWljMjV3djlqUkdqRDZ1OFdRRzE4MWxYeEwxUC9HeU1rWXda?=
 =?utf-8?B?dzZMTE1YSmc3a2FzaUJXeGtoWTNzclZvbU5NNVQzbWFqaHBCK1JZNFlvb0dG?=
 =?utf-8?B?aWh6MmoxY093RHZPdDBTelkveFdXbUpVZXV0c2twVUxjcm5Dd2gwREhqSU8v?=
 =?utf-8?B?M1ArTTNvNkJjNFlaUWlkT29hTGlqVFZOZ1pnL2xJUVR6TmxHc3gySmNpRkp1?=
 =?utf-8?B?TXBXZDVMTGRUNEN0R0lKNG5GMVhrRytWdHJ5TXl5aGZmcURuMGpLdlVsbnUw?=
 =?utf-8?B?MlhNUEQzQ0lWbmk1MStzRnUyNWRpTFpCSEtYUVI1TTkzT1VFYW51S3dpRFRW?=
 =?utf-8?B?aUF6WUROazV2aUM4czlxVW5HSkZhQWpHaDErQlFrR3B3RWhqbXZ5Nnk2eHpv?=
 =?utf-8?B?MVkxM0xwWU1RVk5WTkIxdHl6RTRNTURPTGJHcmxHVzBrL2U3NFJqNUFodXhK?=
 =?utf-8?B?SlByVTNOTC9TTmVGTUZpVDVRVXArKzVHbDdIOG00N3UxMDhCYVhoL2VhdmZs?=
 =?utf-8?B?em9heGx0eDFuMUVXVkkreHlKSU9ISG51Z0IzemNqdDE4TDhScytSQ05WUzRx?=
 =?utf-8?B?dUhVRERBN0JaU0FxbXJMUmY0UlpVcmU3NUhKb2I0S3RxcmMydXB2ZEJqQzRJ?=
 =?utf-8?B?RFovQXNkNk81b3F1QS94cUs5OFhFeXU3VFBxN1JLNFp6TEhoeGI0b0d6dzZ0?=
 =?utf-8?B?WHBMUkgzejZtR3hKREVyY1phUFdUVWNOSEhjY3dQLzhta0QwbUxsaURFd1Vo?=
 =?utf-8?B?Z1FXSlV2YjQzdU5uWGMzM3g1NUpvMFhKUjg1UDBkemhlVENPRnJuMTBHb0M2?=
 =?utf-8?B?YmpYT1d1MUYzMmFQWmRoWm5SbGc1TTlzdlJQRFpiWDlmMUtLUndIK3hrODQ4?=
 =?utf-8?Q?bKX+EbNpz6Dxux1tdhCyzR0Fj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80784136-7527-4262-13d3-08dcea157be2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 16:55:17.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcrY3tRDXeN3y3eNIQoQ5e71cbuaOo2eIf9uiRxR9l1+mACxXGPMTj6FtmfW0slwtJrhGGRfKm1K3Z66B+BQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413

On 10/11/24 11:48, Borislav Petkov wrote:
> On Fri, Oct 11, 2024 at 11:35:40AM -0500, Tom Lendacky wrote:
>> But the patch includes the new file, so how can that be?
> 
> Ah, wrong error, sorry.
> 
> This is his error:
> 
> arch/x86/virt/svm/cmdline.c:15:27: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘__read_mostly’
>    15 | struct sev_config sev_cfg __read_mostly;
>       |                           ^~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:229: arch/x86/virt/svm/cmdline.o] Error 1
> make[4]: *** [scripts/Makefile.build:478: arch/x86/virt/svm] Error 2
> make[3]: *** [scripts/Makefile.build:478: arch/x86/virt] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:478: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1936: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

Ah, that makes more sense. Looks like he's missing the include for
linux/cache.h

Thanks,
Tom

> 

