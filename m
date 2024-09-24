Return-Path: <linux-kernel+bounces-337230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B830984749
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7F81F24EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF231A76DE;
	Tue, 24 Sep 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h0n//zMc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B611A7059;
	Tue, 24 Sep 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186841; cv=fail; b=mdKsiHFWFwW+gSkVwuWaASI2sPdrgf6i+fFW1D8+8IMzy6SAiPLvzwanePW855RAVWTM4GkvehXPiqdzFDWuO/EjAmfpVBkcdLTcZ8OVmk4iQ0jj0s90KAsrlax8E4IzmeIx0/AnGAx1HwtFL9OapkXD0n8pLK1EztzxF8zblko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186841; c=relaxed/simple;
	bh=1TFtMuBzHxICi5I+YbVY2gaOLEaBCM0p+QDgZ+AjFpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LQK9xe02JEnD8gAhQXMlACB9IhixwLrZy+autddS2IM4VoCfjrgx0KSsEDUQPxy4V90EiDCkRSP03o4aAp8pVdSWgrhIc/at2ZiD102EX9vY7i2wYgcgXTE2mt2Fgw0JTbmYzfV7M+FFrhPYMsdFoPjoXdQKOQjOK04AyhsJzrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h0n//zMc; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5pvZhUqCRMmjhpwec1KSBjEoh7i7C4L+kHLfs0zw9TaS7/OnCslzPVAEpjr48LFPuRUmtFfhJs7tuh/JgvYqpudu2EuZGHqUnenRb259ueoibLEBV2rRUDBZuhrWICtZzMxcU46MM/BtXVvwAeWca27XeBfPlRB+s8naCTsf0oRrW1LBOUeuBh8NYA2gcluA8Ub7CZwghC+xHj08J39fzHL8AZ2ESqZy0oWqm894BYUoY/vqjH03FJ36tcPDi3Ud+5gaXe0vqK20WxckYH4fElodSc932bgjbQd191U7rBTsq3cfv3P0iFSQm8GYRrW6L2E1HbxdXJ9pFYeuHCBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjBbuaQr5zt0SCWJ01EHY7Y767QAhL0hpaq8dnvLN0c=;
 b=JVG7D9Mn07ORab3pLU0MCYa0J5ND74VgGgfxPWQez6DNYHBAw3dpuPuj/SglAqq3gNDNAPrDOCOSnitrAkHzE5HntXrpoBn8aSvPXo6w/keKaQm7QCak4DVkfZUcvrbHgDunRwP767T7SgqZVCqMS5NpWsnkENCjvaLligxfcBJn3IyCQ509HHbY9BREcVyvK7rxNP2Cde2kHbeRSSFZgdb21bY6ED6nze92mCXlndBGrM0DDLVqu2A0Q+whPpj76QXZW3cDjgYhdTs7Grxi6rwLSjJn6sAeA8NgulloIAUMMfeaO08DQtn36AxtPFyX4vPuQ9ykQWjdV2w7GK7Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjBbuaQr5zt0SCWJ01EHY7Y767QAhL0hpaq8dnvLN0c=;
 b=h0n//zMcXFqwIs+jqB/f/JomCg41AcbQQ40M8pEvBlcarRSN/7o+B8/LPiHC7REy8h+4QMdSyX2m7iEYNwV5R5YR00IPTLrLFvejdds99TXzfgcg3HrnGOADqTTYkZh7LQl7n+IB0j7GtJIAk/LRRZfERrv3Ck2mv77Vg1JokgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 14:07:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:07:17 +0000
Message-ID: <39d8602d-e4e2-4b27-9e94-e30afce96a64@amd.com>
Date: Tue, 24 Sep 2024 09:07:11 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 15/24] x86/resctrl: Implement resctrl_arch_assign_cntr
 to assign a counter with ABMC
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <2796f9514d9763d40dffbbfe651541d28bd4d995.1725488488.git.babu.moger@amd.com>
 <710c3d2c-ef18-4534-982c-a62761a09f96@intel.com>
 <666aa4ae-141f-4625-909a-d905e8f1c66d@amd.com>
 <d6f2b7e1-21f1-4698-8c56-cb8e46374688@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d6f2b7e1-21f1-4698-8c56-cb8e46374688@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f604e22-c493-4116-7d87-08dcdca232b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFhUUldKL2pzSFV4VWZqMmFpUFRhZmQyNVlGMGVGT0JHbnFqMHNJcWpxZnEv?=
 =?utf-8?B?eDBNTnpNODhDekRDbFNyeVFJd2szWmpaNjkvU1VFOG9ndTF1UWRSZWlaMG84?=
 =?utf-8?B?dzh1eHplQWNudVNRZ05xY0UrcU5uaE5TSi9hVlVFRERNbUdnUGd1Z1BmOGc1?=
 =?utf-8?B?cDJiRXlVSlRsM2RLMGp1cCtabklTQkhpb0tLOGpabXltVFBwdVViTXdYeVlr?=
 =?utf-8?B?Zk1CdVRsb3VkSnk4YjVkQ3J0ZlpuZ0JTYis1cTZDZnNtTzdFaCsydzR3SkRL?=
 =?utf-8?B?SzNUdkEwTUlKWk0xUkNzWjUrcFBtdTVaMlRQbCttL2hDM3AxUFFWMHdtNElR?=
 =?utf-8?B?N3dyMnEwdWhNWW4zSHdMbCtWaUk1bE5JRDBaVERjVGE4TC93WVcvVlZGWTlw?=
 =?utf-8?B?Z2M4akpMQ0VRUGFQOGVDUnRRRitvc2s1MDZFNjI2bEJya3M2UnI5Ym8zY0c5?=
 =?utf-8?B?Z0Q3dG00SG4yMkN0SXR3Zld0Yzd1M1FUUXUxN3JyZEM0clBwSGk2SHZKbmFJ?=
 =?utf-8?B?TGZzaUVsMldXRklaeVRXemtOVDB5ODN6NEtWQ1hmWjFtZ0VLOFBndkNMTzl3?=
 =?utf-8?B?aytGOU1PcGZiSHF3V1Rab0NGRVQ3dU9HSllSMkowR2U0aThpeGVlempMcWZu?=
 =?utf-8?B?QStMUTBCOFU1cmh4YmdpY2hQdW9zdHJtU1lmVzVLZ3UvaFJ1T0ZjZjlTNGY2?=
 =?utf-8?B?dlNxYURMYnhxVDdGekpCYk53Q1plMlV0WEQ3eGZIalNPNUlSVEJJSVMzVHlX?=
 =?utf-8?B?R1BPMDUwOGtDL1R2OURscklmNFNwM2YvQjFvQmFYZk1PZXliWTZWZkVXSHdR?=
 =?utf-8?B?Mm9IdzhxRnpSSzltWFhIY2NyODN5d2t5bUNrMjhLZEg4QjR5SndhcElOQkdI?=
 =?utf-8?B?SUNGVlJrbGJrc0JUN0RTVXBCQSs2UkFuMm1CWWJkcTR1M0ZtS2t5MVNrdlA5?=
 =?utf-8?B?SGx5ejRUbUxEemxGU2hMd1RPRkpTcDROYnlDTVQzRlpGZXU0VDZRVnl5RDlm?=
 =?utf-8?B?THFNUlgrSXI0UDR5WktpRnRvcWh4YS84M3hZelhtT0dzbnZudU5ZVmhVU3R3?=
 =?utf-8?B?Y0Z0SUYzWGU4Qml2N3RlYUtBRTNmUjlDSllNcjBMZldoczMxa1cvcDR1UVBQ?=
 =?utf-8?B?L3NGNlFJdStlWGpGSGdXWEdZd3ZJcEJQZkkzVDJBRXU5TTVvMGhsWDcrN1pt?=
 =?utf-8?B?VWFTNWJHNkpMMzBmYU5za0c2Vm9YMGprM0VDRkp6aTNFb0FqRFB3WndUQUdX?=
 =?utf-8?B?ZTRuaDQ2K3o0MmF4WHRyQS9KZ0xLOVRUZ1lXMDlzbnRpVHBBcUxXUnYzekJH?=
 =?utf-8?B?bktnL0Q2WGNEdnFlc0x0bmRPdlkvODZQb2x0NSs4Sm9ZNVZ5MCtYOHp1REdh?=
 =?utf-8?B?cHo3Y0pERjhPeWxSUEdvSTdpd2IzM2JuWmRGMlNkZmEzckNPQWVnU2M0ZG0z?=
 =?utf-8?B?Mm9vZ1dFN2U3TWxqOWVzYWpoSzZlUlQxczRhRml2bm5LNUtXT0RYMytIUDR6?=
 =?utf-8?B?WTlLUjJSbHdDSEM1SWEwTTd5b0l0Ni9HV2VmYzBnaXFlVFVJaUZJQjBxWGdy?=
 =?utf-8?B?cEV4ZUVnV1J2T0hwWUNqZ1hPMFEzUkQ0ZEdHdWFJRjZ1MXVxM3FRekZ2VFVZ?=
 =?utf-8?B?a1RqeWNKTTV1eXVSeUFCeUY3WWdjNm02ZWlvc2IvZVRBTVBqRXpqUUx2d09M?=
 =?utf-8?B?Z0xjNWl0TEhvUXpVTUZDalg1Nnh4L005R1E1RUlHTUcxVmd0OEw4eHFZT0hI?=
 =?utf-8?B?Ym1GbU8xSnV4MVRUV2N1M08xbUsyZnN0VHUxbzc2QVpML016NUgyRDhBcDBh?=
 =?utf-8?B?bmNaVDUvLzFHQk9vbDQrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDNYMmFJN0FCcVNuL1liZjNoZEc5SGdNUWJOUTNHdlBTaHFac3BrOE5KQ2Qw?=
 =?utf-8?B?VDFkazBobWlaZnBWb3ppdk53TlZ3TnA4cmhhOGFnYXh0Nkp0Q0czZ3IwMUYr?=
 =?utf-8?B?Z3BEcURSNmVBOWFhbDc2SFdHaEpLelNrNlNibVAxVzAxZTRFWlBjMGxiM0Ez?=
 =?utf-8?B?NzdXbGdsOGdlOTkyMUZLeGZDclhMd09sSFR6eFU3Zm5nUk4wQ3ZlVHlUbUZR?=
 =?utf-8?B?Q21xOHNUeVFYK2t1dk9HeVRuZnI0d3hocXl1STFjbDZEcHgzNnBESEFqcUcr?=
 =?utf-8?B?SU1sQ3M1QnB0eW1jazFSNHI1ZjQ3YkFJcHlWVTFtaVNYUkFNb1hzcWZiQnZI?=
 =?utf-8?B?YVpTdEtvbTNveUo2WS9waVNrS0ZuMENNbkNiOXRmaEhMTGFsZC9XdFphOEtC?=
 =?utf-8?B?NmE5dXg2M2tpMkJReXEzTFRIR21RdE16WFBybCt3OVJtcFZGRUNJWHZqSlBa?=
 =?utf-8?B?bmlaMEtxTE5ZMzZnOEYwb09iSVdMWGplVjlYdEl1bTVKSy9oR042ZytmODFy?=
 =?utf-8?B?MlNHRWJwZnV6bC93WkRHUThKelVmbDlCY2YyNW1uNUFhWFZ0UGdLQUIxREc3?=
 =?utf-8?B?dk1BM0o0VjdXK3U2YWZaanRlelUzR0Zza1JRcmg3akdsMXR4d1o5M1p2RTlQ?=
 =?utf-8?B?a0J6SlJxUzJyM1Azb3AvZGt1WEtxeWVtV0t2NWEvelg0WnVHSTM5N1lXTmdC?=
 =?utf-8?B?TkNmNE5YNktab3JvekZKSjdta3RHYWt6WHBkTkN5TWU1U3pjVVdoTEJia083?=
 =?utf-8?B?cXduNDRtUnhpek9nQVFRdXRYeU5zaUttVjBaTGVUVjJWcDk0WGF0b1hiZm5i?=
 =?utf-8?B?YTlXSDRubm56VkhONFFHWGF5SHRpTU5pUzh2TmV5Q1NtcWxZd0dVckoySTRs?=
 =?utf-8?B?WXlpVGdPSytaM3g3Ti9iZS9xdlJQYjR0cEczSW95MWNkcFZzbS9BeFplY29U?=
 =?utf-8?B?RjRHTlk5SWwySnArVWphTGFKSFJRTmRsUm5nV3dZaCtuVFJtN3FtRVF1ZnY4?=
 =?utf-8?B?bzhDZXJVOXJsN1pZT2d5Q20zRllRd2lYUStOS1RRL0dHUFNZNnBUaVVIWmk2?=
 =?utf-8?B?UVVrcGJLYUVBSU5zMnhWMmRiQkptREhLZEZFWlhHNlg4cUozaGZiZWJ5Yjla?=
 =?utf-8?B?ai9DWnRZVG5RZmdFc1hDOVc3RG9lS3dHRnRIMGZrVXJaSU93NVNKZHFkdjd3?=
 =?utf-8?B?SUhFRnB1QzNabVhCSGpjMG5RZS83SUhCWm0yNUtXL1ZwMlpXVUJ0Z1hpQU8z?=
 =?utf-8?B?L1M5NFRPSWhPQlFCSnkzK2pndWtid3NBR29TSnV2YlpwTUt6MHhNU0wydmgx?=
 =?utf-8?B?QXR1cXFvclV5V25HallSTDBsRDRQNG95SG9xcGNacW5lL0c3QS9EK0pKQ1la?=
 =?utf-8?B?cTdhcUhBalRQam5lN1hvNFpXR1ZMd0ltY3pHVUNjUmdPL0pZc0Z0cENWMmNK?=
 =?utf-8?B?WGFLcDZLdHFOdnY1Umt4dkJPaVVGbGNaRFBmY2pkUlBTSVNqRzk5T3AxNlMx?=
 =?utf-8?B?cDZaUkVzQk1CcnphZzlESmNpd0ZJczhnOFMxYnlwd1FJMi9rYnNzeGRyVG9N?=
 =?utf-8?B?RVpYNnI2MndLbjBGNUNiWUY5K1Y3dTR6bGxrSXEwbnpQSG9yUEhpMkovM0VT?=
 =?utf-8?B?Z3d2dnRzZGt2U2p5M0lycFUxNTFQaFNnQXlYOTQrYkpBNDlMYmFVR01Jdm40?=
 =?utf-8?B?Q3FsaHhySW1oRUgrNzFqT2UwaWc1RWE2L0ZKNW5jY2p2YkV5NHdGZEZXZ0Q1?=
 =?utf-8?B?WDBaNXlkaGRHNEtrNDByK0hTQm5TODNVQmVCeFhqajJxZEdGWEFNcFdOT0xI?=
 =?utf-8?B?V1J1TDRCemNPbEI0QU1XQnJRR3JTU0pieXdsRUVsYXRBYjNIVjQ5Y3FybCtH?=
 =?utf-8?B?YlVLdzN4b3dLb1pvSjF4clBTdHJTTGpSdjlYc2RCVUNiOENRcUViK3lqbEZW?=
 =?utf-8?B?RkZCd0xBUkp6b2liMk5TbUp4MC8xRWNtcE1vT1EzT1I2dTZudHVCai83Rmtw?=
 =?utf-8?B?cFA5SzRtbFdGY3dWRld3RlNzUVJTTGludmdTMGtiUlpzNmJweFBuRWpLQ0Yr?=
 =?utf-8?B?S3VHbkgwNzZDOFlaak9ZaW1xeXE1WTU2Uk4vYXZkTjFXVE5zK2JpTG1ydzlh?=
 =?utf-8?Q?kYs8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f604e22-c493-4116-7d87-08dcdca232b9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:07:17.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OQbfAzL/+swxSOzwLKe6jUL8FKT25mDDAQ2CYnL1yYTS5IA+chszXAfyjaB3VCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445

Hi Reinette,

On 9/23/24 17:29, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/23/24 2:03 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/19/24 12:13, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> In subject, please use "()" for a function.
>>
>> Sure.
>>
>>>
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>> +/*
>>>> + * Send an IPI to the domain to assign the counter to RMID, event pair.
>>>> + */
>>>> +int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>> +			     u32 cntr_id, bool assign)
>>>
>>> Looking ahead this is also called when config of existing assigned counter is
>>> changed. Should this thus perhaps be resctrl_arch_config_cntr()? 
>>
>> We have a matching resctrl_arch_assign_cntr() and
>> resctrl_arch_unassign_cntr() pair.
> 
> hmmm ... resctrl_arch_unassign_cntr() does not exist in this version of the series.

My bad. Confused with different versions.

Sure. Will change it resctrl_arch_config_cntr().


> 
>>
>> If we change resctrl_arch_config_cntr() then we need to change
>> resctrl_arch_unassign_cntr to resctrl_arch_unconfig_cntr().
>>
>> Should we change both?
>>
>>
>>>
>>>> +{
>>>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>>>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>>>> +	struct arch_mbm_state *arch_mbm;
>>>> +
>>>> +	abmc_cfg.split.cfg_en = 1;
>>>
>>> Just to confirm ... a counter remains "configured" from the hardware side whether it
>>> is assigned from resctrl perspective or not? It seems to me that once a counter is
>>> "unassigned" from resctrl perspective it needs no more context about that
>>> counter, yet it remains configured from hardware side?
>>
>> That is correct.
>> When unassigned, we are setting cntr_en = 0, so there is no counting. But
>> in hardware perspective it is still configured.
> 
> I think I misunderstood the "configured in hardware" to equate to "assigned by
> OS" when in fact it is just a bit to indicate when hardware makes changes
> requested by MSR write.
> 

That is correct. Hardware makes the changes only when cfg_en = 1.
Otherwise writing the MSR has no effect.
-- 
Thanks
Babu Moger

