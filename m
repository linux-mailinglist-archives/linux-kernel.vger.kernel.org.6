Return-Path: <linux-kernel+bounces-349809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4898FBC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AC81F22D08
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53191D5AC7;
	Fri,  4 Oct 2024 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kYhB7ddK"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEA1849;
	Fri,  4 Oct 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003124; cv=fail; b=JEcx6BXZaYXCIBPRJyrX33kr45PgWYi24K5+ZUtgEB1qRFFHe+0uz2nOhRLHEShGockRl/bfpVgrfJpnWrHlCJ6pdQMbj9sejKr5S0DnrNsul4zXFy1MGpKQfcUt6ScKJxm7Omxq9heDMzUnL+MZcf0bDehaIxxYWEcZ3QVFm8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003124; c=relaxed/simple;
	bh=wJLwoJZ4s7oRbk4uJNNBxD1zjiFjhcpakvwZx7UYev0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=porZHe74O7BxR5esUFQFra32HXucNjOWIv0x8lADlRgwuI72s7t0FFRBQfnPxySwRAfQM/sLkuJfhp1KfdaI9iTFy0IhP55C70pq7aoMGSgHrDUzY1qRqDVGqAJNoS2lQG8yxsbXxyFR1FgeU/xf3g9goCXPd6EbQrirnIwcwXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kYhB7ddK; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHAIRXH7bb0zTx58zD4HSUx/w9GOYB4nHHSwirpHktI9ZNSWa9uKGVsoU0EpOYDVT2ffH+062OF2QEUqz/igoLWYgsjN9DpnwDoZoIVgIdya9XBFxPZFmXXhyX8OZvP6FCCTr0UnYhMk56cA6fnk6j42PccjDrmo1ZVknCFTqiVwB0va92G1N50gQp7OvN3VNbLeUpkh0NUAYNhxX1IM0P8ogRdNhMTJt8x8fVRYRjdZLNBWouM9zvs+5gUvCgYWSU/5OY5kYY1weE2sDlDBMS6adCjmr+VOCYm2M3pJB2/9S8V38mnZx37PQXNau0eejU/T8/OxybWrA8K7KiUOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79Dglbq4xX+o5RPMKySKHW1WiWF6LE46a7AyfWVd1Ec=;
 b=GwCCqS6tdj+Qt2tFgXQOBU9NvnP80AhZM87Yhj1kt+y9JZgiDUx+kic63KCZpECqBd+ISjmBP1S1lj+sgNeMX9nXtldjaE/PsYOnEVTIwTS+Fma0EgEinDENQvPickYGPUiOm44YVtMjq1zzWF7wxNyx0tEwCb8mtkrxsjf3XD7SX1K9iOh0W/IH54s2QhIB8JcXVoWp7lTwwVnmJnwtB581bpaW/jG/mb6qfvnT6gN38I0/baM/8D3InDtkKV0TECuaNq6pLlHDr6oWeZiEuccx+a8z1IzE1E/NbtuYrHXmArMcTyZLSckKFaif3x42+HV9ji53Uh2v6m6tFNqunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79Dglbq4xX+o5RPMKySKHW1WiWF6LE46a7AyfWVd1Ec=;
 b=kYhB7ddKAe8inIv5GrdZEtBoIeqeKAVNCDzE/lboFvRQvPUV/b6MN4TjhSoMP2IdvWpyyhfqIsIwmTsOAG24z1FlQVe+M515A4ZORtkpkF3m1nPbfmibh58sKu60Kk9As2kCK12EQeYNs1DtMNRDmTNFPgloNykp3jWNidJhxeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 00:51:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 00:51:59 +0000
Message-ID: <c514416e-4320-3826-21dd-7e79ebc83351@amd.com>
Date: Thu, 3 Oct 2024 19:51:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
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
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
 <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
 <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: f8af633e-3522-41a8-345d-08dce40ec09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUlkajI3YVVPMzJQQ25SU0V0aHJPMkVXTFhFMi9vT0JyTk9aWExJVitGQldr?=
 =?utf-8?B?VkQ2djR3dlc4YmlPcTVrOTArbTVReUcvWFdDZnZIWW9UZUJaMzhiZGJJQXhC?=
 =?utf-8?B?WEpXdmhNS0xkOGRuWVdFcitMRUE2OTdqamlYK0ptWVR2U0gxaWYxdjFuMVg0?=
 =?utf-8?B?Mi9POE5sYlFLV0RxMVVOMTRHRHVpQmVMMDVnSFVJRXk2UFBjOUN3MWcyaTM0?=
 =?utf-8?B?dldCc0JCYUYzMkd3L2RBTVBXK053M1BzRGh6dUdEbG9GVW5ibUFiSHNmbVVj?=
 =?utf-8?B?RFIrUXA1LzRqUERvcnpiS0xsS2t1bTIxbWk0eHlCYy80NHZTU2VzNnJ4Yk16?=
 =?utf-8?B?VVBZbFh4ZVl0R29LNUJyNTR6UWlvN0xOem5XdVNiT0dWT0FWdkJkZksxNFc3?=
 =?utf-8?B?R21CTUJRUTZDWXhWZWtmaWVTNUF2ZUFydmZXUkxlckZCd3grV3B0QlYza3dV?=
 =?utf-8?B?YXNnRUVvU2xDNGxvdE1tYWszSDY1UWtCcVU2bDdLQTJqSjVkeUw4dkFaOWNa?=
 =?utf-8?B?TElnbGxvN002SkwrUmpRUTNNOHVxNUxqTGJyUU1BZkE5VHQ2d09wWjVRN3ZF?=
 =?utf-8?B?RE5jdGczTzhzb1BrZ2hlbU9wMkd1N3lCVTRIalU1MHBpbWF0UitkbHNuMWpj?=
 =?utf-8?B?ZmswODZEOE9EY0picTNRMGttMFdOR0tHcnh2bUxvcUJLdVdURGk1OUJaY0lq?=
 =?utf-8?B?cXNWYW9qSk1BeFIvUmc5dHRiYUxrMDd2WTFDZUVURGJTV0RTcW1nTUJPS2dR?=
 =?utf-8?B?S0c5eEV3TDlZTnV4RGEzWHh3d1A1SEFrZXJUVXFMMmxIWkpVT3pRR2RFSW1Z?=
 =?utf-8?B?eEZsa3RySitEK2pYUkU1YlNtKzl2ZTc1RkVySDlXKzU1aEVyWjBXditjT0xr?=
 =?utf-8?B?cUhybkYyK0duQlZ6SGdNUWRFdEQrZFNOUUtieWJZeHdsOWFkeC9vaHBTUko0?=
 =?utf-8?B?T25KVmxkdEpoR3NCeHJIak1sM1ZEWHNDSjVPaitlUUQ5Y0xzQm9sTlVNWnB6?=
 =?utf-8?B?NkZSM3cweWZkWkRuQ1JhakRMQm50bVJkMTVlWFlTZEdaUzNiaktKQ21jL1Ew?=
 =?utf-8?B?NXNTVVlxYlBqVlAzSFA4YjBKcGk1U05GQUdxbC9FdEdtMTdKRzZxSDNjYW9h?=
 =?utf-8?B?WUJqR2h4Y1pRV0VKRmo0RWVmMFBUclRTK3BnNkxlYzJsMXhteUx5dHhvQkYz?=
 =?utf-8?B?R1ZXcXNVWlQxOElRcDczZXhVTE1ab1hibVZQZ0VLVVllenZUcWZtNk9yNVp2?=
 =?utf-8?B?RnZVdUVxN2I5bUsrVDlPWEk1NndLNTdIL2FZOVB2N3BmM3hPV2luTXpOVHcz?=
 =?utf-8?B?bFBHY3BXelRtdzJ3YXorYXMxMUVZM0oxamFIaFNqTGE2YW4ybmhWUWdrNmgv?=
 =?utf-8?B?eTdjZE1HanJaSVFocDA1Z2FDYS8yM0tMRXJHbnhKeDFMVUFQZlFmSEdMcEdO?=
 =?utf-8?B?MmdwdWljNVlPNlp3dTFwRDdOTnh4WHlxbXV2REhLNzZqMytrckVGQzBwUmUz?=
 =?utf-8?B?bVVDTzVNdm1EQSthQU5obnRMZ3FDdmlUeUx5RHVFa1prTmsrU2w1bFlFVFRo?=
 =?utf-8?B?OUNDRzhyZkVoRnJIdDJjSEZ4eExRLzMwTEI4dU10bnd5N1J4Z3FHVHE4U0lj?=
 =?utf-8?B?NUh2UXMySmYxa1c3NnJZRGwzQjJIUlRJR1B4Q3cxd0ZucE8vTVMwS2h3aWtZ?=
 =?utf-8?B?MEU4aUJtR3ozelBMRmVkRkY3eUFhN2NhSkFxM3pLd3RTZUtNenRPVnJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnd0ZzFualVyNWk3ZnRrM0RNSWxFOVAvM0NrbWhNZUhhdzF1NE52NkwrTDFr?=
 =?utf-8?B?RTNreHE3Mmh4ZFhsS3FGTnBnOHBpanQ0MHkxTnNRKytWLy8xd01Qc2RMWTR4?=
 =?utf-8?B?U3RFc2Vub0tjeTJocnV5SXpxSXhXZDR5UUM5Y2pNSzExaE50ZkI5aHdKcEk4?=
 =?utf-8?B?UmpNTmxFUEc5UFVQREJ0Rk10TW1EWE5MVHZpR3NDVUJyMzJmVU5ubVVTdFow?=
 =?utf-8?B?VWhCUWlXUE5LNDI2REg1VVhJdG9pT05mckJCV2NFUTdZYUF4cG5mWUdHODZV?=
 =?utf-8?B?b1B5Uk8vaCtydUJLcU1TSXl6c1dYQk5KcElzQklxZUV3UDAzaGxqU0NnK2Rt?=
 =?utf-8?B?WjJ5Vjg4SGZ5UXNkdUdJYUFleUxvQzd6YXRsNld4ZjE0WkJ5WW4zdVJnVEgy?=
 =?utf-8?B?dmRDRW9zQWZyVFBSeG9IVnFiQWFvdmxtNE1pTXhZWGdNQm5DMFJJdzVOYURV?=
 =?utf-8?B?M0FyUHl6eWNEemZKMEtuZEJKaXE1cjhDeEcyL1VLTm9PaXVya2F4TFdWMnVR?=
 =?utf-8?B?SVpIZndpd2h0TjFJMHRoUnR4akVVRis2TWJSVHQyaTFaalNLUmRNaUhMaGZo?=
 =?utf-8?B?MDRETXlpRWdlSFhJak9lNEROSkZVTXpHemxTayt5M0pYSU9tMm00WjZJOE5l?=
 =?utf-8?B?QkxVaCtiN0NFM3Y3dE0yd01FM1hSSW5lVC9Rc1FCcjFkZjRGbk5FNU01SDJt?=
 =?utf-8?B?OE1qUThnNlIzMXVRdi8waWxyeHRKdzRIWEx5N05IMkRFWDQ5cm5uSnBVK0Ir?=
 =?utf-8?B?UTJiQnZ0bVRna2hCbDNyT1F3Ty9IdnZETnViQVFtSnhncmI3dm9ocDVmcUN4?=
 =?utf-8?B?ajA2QkpJcXlWa3ZyL1FEZ0tVVjBUYS9kYXV6SlRhK1IyeTVxM2o0RkxyQ1M2?=
 =?utf-8?B?UHpRMmgxMC8yMUYzc3BpNWt3dlIyR2FqbjNqMGJHVW53N0hmM004NzFLakZC?=
 =?utf-8?B?bHNSbTlmK1hic2Z2VVQvZTNNdndYaW5uYkcraDgzeHQwWmRIU05VcXFZRzRx?=
 =?utf-8?B?bWQ4N1RWYUVVUW0wSDZjbUs1VVBOVVFjbCtjK1hCZ3pMSzJjWjk0c1gydGpR?=
 =?utf-8?B?d3FPMUh3TlFxMURKT20yMXo5QnNXUGpnbUovTkhqTGtTVmg2L2gwamtNOUxm?=
 =?utf-8?B?K1R2SHJVUVgxL0J6OVdYbndyQ1JnM2ZrcXpYZE1mS29WcmRtSWJXMVczcEdw?=
 =?utf-8?B?ck5aclFvVW9YUFRKVmRMMGlQME9uU2pDd1A0emNhbFhQc0xFcU40RFA5aDBE?=
 =?utf-8?B?R0g2ZHEyK2hLOTcySkgrVVBDN2lLUGcxL04vUzljSXo2cDFWb1RKMkUvUEtp?=
 =?utf-8?B?cjNYaG1wWXpyT0VRYUZwSUFVcVBmZm5CY3l2bUpqR2Jtdlk3UVhsWWxsUk9Z?=
 =?utf-8?B?R1VaVmMxdjdRekVLYkcyU3k4aEd4enZWcCt1WlJHanlvMmE1a0dWQVN0Z0t2?=
 =?utf-8?B?TWsrOTVReXBVVENWMTJaekhPZVBhUll2VnJoS0JWVDY3a05SR2lUbWI1UUsw?=
 =?utf-8?B?TG1zZkFJc1dXeDQ0ZEFXSVJZWFZVRU1OWEZEb3VNaC94aTBCZUIwdUZ2SW0z?=
 =?utf-8?B?NlNOTjFpMjgwMlVIM0FEdTNhYUc2ZVBPMWlUV0ZZM2k2TmZPMkhXTk9WSVRH?=
 =?utf-8?B?TDg1d3M4S1dvRTl4TWRnbk9XR0M1QTdrTXJwS0g4MlQ4S0ZwZEE5MEpaWTlt?=
 =?utf-8?B?ditXdE1ySGVVOWNURWVRcDQ4KzQwZkJQbTYrUHVqVlBUNm5WR3JXZUdHdUVO?=
 =?utf-8?B?SitXSTR2Y0N6RVBrb1UxNFNMNDBKb1FQcHBHS1pIRDlBZG1SZGNrSE5LT2xC?=
 =?utf-8?B?WjdGckV6Rjd5T2Q3NlFXVXpkeFRBeXVWR3k4NVQvUnZqaFkvaUVyVzljbFBW?=
 =?utf-8?B?VlJjTStIWFVqeGdZQTZHNDZ0VldhQVNaM2txVzVJblNoSi9oN3J5L25aTWNm?=
 =?utf-8?B?MDIrNHJBV2dna21FOE9Fd0orRUFOU0Q4WWs3bU84OERKZ05VcjF5dG5rR3BM?=
 =?utf-8?B?cXp0QjlMa1g5OFBYazc3OFNUUkRZTmRkdzgzakJ4YUdlRzFnZTJBbjdoc09B?=
 =?utf-8?B?c1BJT1ZhcHVnWTNqcDRPaVJXNGtkd2VMTGVXRHFRWFJDUGtHdmpkRnkrUGJq?=
 =?utf-8?Q?cQ6o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8af633e-3522-41a8-345d-08dce40ec09e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 00:51:59.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtN7Awt4v/dYU2zdwpyLWpLpxyUJA25CYywpJ53IRa9SMX2VJn2T7z4Cy/dI8YW6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

Hi Reinette,

On 10/2/2024 1:20 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/27/24 9:22 AM, Moger, Babu wrote:
>> Hi Reinitte,
>>
>> On 9/19/2024 12:45 PM, Reinette Chatre wrote:
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
> 
> ...
> 
>>>> +}
>>>> +
>>>>    static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>>                         struct seq_file *s, void *v)
>>>>    {
>>>> @@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>>>        return 0;
>>>>    }
>>>>    +static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
>>>> +                       struct rdt_mon_domain *d, u32 evtid)
>>>> +{
>>>> +    struct rdt_mon_domain *dom;
>>>> +    struct rdtgroup *rdtg;
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>>> +        return ret;
>>>> +
>>>> +    list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>>> +        struct rdtgroup *crg;
>>>> +
>>>> +        list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>> +            if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
>>>> +                ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
>>>> +                if (ret)
>>>> +                    goto out_done;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
>>>> +            list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>> +                if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
>>>> +                    ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
>>>> +                    if (ret)
>>>> +                        goto out_done;
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +out_done:
>>>> +    return ret;
>>>> +}
>>>>      static void mbm_config_write_domain(struct rdt_resource *r,
>>>>                        struct rdt_mon_domain *d, u32 evtid, u32 val)
>>>>    {
>>>>        struct mon_config_info mon_info = {0};
>>>>        u32 config_val;
>>>> +    int ret;
>>>>          /*
>>>>         * Check the current config value first. If both are the same then
>>>> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>>>>                      resctrl_arch_event_config_set,
>>>>                      &mon_info, 1);
>>>>    +    /*
>>>> +     * Counter assignments needs to be updated to match the event
>>>> +     * configuration.
>>>> +     */
>>>> +    ret = resctrl_mbm_event_update_assign(r, d, evtid);
>>>> +    if (ret)
>>>> +        rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
>>>> +
>>>
>>> This does not look right. This function _just_ returned from an IPI on appropriate CPU and then
>>> starts flow to do _another_ IPI to run code that could have just been run during previous IPI.
>>> The whole flow to call rdgroup_assign_cntr() also seems like an obfuscated way to call resctrl_arch_assign_cntr()
>>> to just reconfigure the counter (not actually assign it).
>>> Could it perhaps call some resctrl fs code via single IPI that in turn calls the appropriate arch code to set the new
>>> mon event config and re-configures the counter?
>>>
>>
>> I think we can simplify this. We dont have to go thru all the rdtgroups to figure out if the counter is assigned or not.
>>
>> I can move the code inside mon_config_write() after the call mbm_config_write_domain().
> 
> mbm_config_write_domain() already does an IPI so if I understand correctly this will still
> result in a second IPI that seems unnecessary to me. Why can the reconfigure not be done
> with a single IPI?

I think we can try updating the counter configuration in the same IPI. 
Let me try that.

> 
>>
>> Using the domain bitmap we can figure out which of the counters are assigned in the domain. I can use the hardware help to update the assignment for each counter.  This has to be done via IPI.
>> Something like this.
>>
>> static void rdtgroup_abmc_dom_cfg(void *info)
>> {
>>      union l3_qos_abmc_cfg *abmc_cfg = info;
>>          u32 val = abmc_cfg->bw_type;
>>
>>          /* Get the counter configuration */
>>      wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>      rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>
> 
> This is not clear to me. I expected MSR_IA32_L3_QOS_ABMC_DSC
> to return the bw_type that was just written to
> MSR_IA32_L3_QOS_ABMC_CFG.
> 
> It is also not clear to me how these registers can be
> used without a valid counter ID. I seem to miss
> the context of this call.

Event configuration changes are domain specific. We have the domain data 
structure and we have the bitmap(mbm_cntr_map) in rdt_mon_domain. This 
bitmap tells us which of the counters in the domain are configured. So, 
we can get the  counter id from this bitmap. Using the counter id, we 
can query the hardware to get the current configuration by this sequence.

/* Get the counter configuration */
for (i=0; i< r->mon.num_mbm_cntrs; i++) {
  if (test_bit(i, d->mbm_cntr_map)) {
    abmc_cfg->cntr_id = i;
    abmc_cfg.split.cfg_en = 0;
    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);

    /* Reading L3_QOS_ABMC_DSC returns the configuration of the
     * counter id specified in L3_QOS_ABMC_CFG.cntr_id with RMID(bw_src)
     * and event configuration(bw_type)  Get the counter configuration
     */
    rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);

  /*
   * We know the new bandwidth to be updated.
   * Update the counter by writing to QOS_ABMC_CFG with the new 
configuration
   */

   if (abmc_cfg->bw_type != val) {
       abmc_cfg->bw_type = val;
       abmc_cfg.split.cfg_en = 1;
       wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
      }
  }
}

Hope this helps. I need to pass few information to IPI to make this 
work. Let me know if this is not clear. I will code this tomorrow then 
it will be much more clear.


> 
>>          /* update the counter configuration */
>>          if (abmc_cfg->bw_type != val) {
>>              abmc_cfg->bw_type = val;
>>              abmc_cfg.split.cfg_en = 1;
>>              wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>          }
>> }
>>
>>
> 
> Reinette
> 

-- 
- Babu Moger

