Return-Path: <linux-kernel+bounces-526463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4471FA3FEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799A53B6502
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C22135D8;
	Fri, 21 Feb 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zIgy9BRg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB161F755B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163309; cv=fail; b=EIdnENzOhSeqm+Wo8Owaw40+hlD0kSO5CGeTIiw+JSl3f+R0RM50hmAh2uVfL9zHPBU0siJGpQ3R+20lWoWy2METmV4EGkru5tMXDBbA4rJ8aVjN2EZ6iVLy5JfJZz+ljLGouHGnkBuyWcdKxQBo46dNmA9k8QMg/EUdl1UmjX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163309; c=relaxed/simple;
	bh=nzVNKcmgQInfOKuPBApQBy9fYBarQkFSXkqSC3Yvz3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CaWl5WSPUq5rsWYWD7dMuHm3imU1Bm9+RuJVoje7D7dL4fCq8B2Z1Csvg/3OTJ17lr387U2ooIgvPEe47WQkBQmkJGgFUgTJ3fzsqX1UfwLGPHH+/5zPtQoHf9Bh2pnd99B8aG+RCxWbrxxGIekCyWY/FjEbvXvSc6iqUHRXS7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zIgy9BRg; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW3cqZrNDNXKU3OykpXHSOzuTg2Fgv3Si+6QvIRSYDiQ67xV5e+wlLla2LIo3acUJljD7enaGNcvu/CYR+n5hfOBpx23mI7hc0oijvnAUMTZbijD4M9sK8hPcV4g0m7P+M18M3FF+YbKKIoY6dbkOLO3n3lSNuI75hJH6p26LkyJ/5QZQdTpgaGV3NWog/rwFtcnCekhNlEZo2woIRpq4WHtT9KhNXxnX0cQTaiy+1RlR8P8O8Ku7XmuhnGVCBUbGxIjQwyY6l9KgOveAq5vMNCYhhm3tKG3YxFxfh8IhhcBx3hZOvMSJ4Be2AKdtn6OdIAfYxxgmkT3sCWCf5L0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85K9juKrxEfX+mcSrSy4pZtPdqvsQ3a7HeV5Y4M6MDY=;
 b=ATJT9HL/sG9n56ZWOMj4CsKqJuAI1zob0W6oWpA2/tdZnMO8CvIL26vw5CoJ/Fuu01LdNvrVcDvtLQLqyeZJraLUn1DMuxPQq3FpcfjziNi8fE0Kzmpot2+Ln2t6JVAqakNbtMIR8dq80Q7GDnBDTFkjLxbSY1/2F16Fin+ETrPMQKzKNToiuMJ5ZUNlMkq/XwNqE190zaQL6iZFxvweRIrkWb2FjvYfOGRwGyGlL63KmlhxdVPRiowORa4A1ZyuNgo8R2VD8Gmb7zqdKPb0VdPdaSIP+3ht/r0LwYV9AHXplbxMKTB1TKkc7MGHwynUtyghHklsFkZ7B71eeHqwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85K9juKrxEfX+mcSrSy4pZtPdqvsQ3a7HeV5Y4M6MDY=;
 b=zIgy9BRgkCpuocOUvxwtifKvXbqDw1+es85r/UgdtFxs9xmbPuMeZvlHgB/UQ8H22HRjwnAgeFV3edybBChGTX+0t0UOBYGCLVTwwIgLBXbN9VTnQmRGB6iNVBGQOC9xZoYEGjv9LOszJe0pSNbSdAF+dbg8X6eTfImnF5FCsIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 18:41:44 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 18:41:44 +0000
Message-ID: <2435a1ed-d8dc-935b-9e96-b709d785a46a@amd.com>
Date: Fri, 21 Feb 2025 12:41:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12.1 04/16] x86/mm: get INVLPGB count max from CPUID
Content-Language: en-US
To: Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, jackmanb@google.com, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 Dave Hansen <dave.hansen@intel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
 <20250221005345.2156760-5-riel@surriel.com>
 <20250221015801.GHZ7fdqaGFEvsG6qW1@fat_crate.local>
 <20250221130322.1c87b284@fangorn>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250221130322.1c87b284@fangorn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 12961123-0cb3-4b5f-bbc4-08dd52a76375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUxiM3lCd2pVL0hBU3hSZWJoN2ZlMDlpdXF6WXlTWVVtUll0K1ZyeU9aS2Ni?=
 =?utf-8?B?N2dvbVdXaW10UHJPYm4rSC9ubTBLYXEwU2dPYzdjWHRzcEx2YWxkVzJjdkdQ?=
 =?utf-8?B?Z3c4ZkVDWjRVa3JNdzZoU0NaSVBRczMwa1dWTEtHUVdNWlBaMVBTMC9TWnpt?=
 =?utf-8?B?RFJoSVZodjlwcUJYeW1HTXNmaEx5TUMxRFJFTXRaTHZHMVJFUFlPQzlZcjM5?=
 =?utf-8?B?aTZ1clM0M1YxZk00RUxML1lMMTNEQ0x0TXYvZFFnUVRUQUNNMjVNYXpxSWtN?=
 =?utf-8?B?ZEFTeWdCeTc3a1lIeHpmL3VScUJxZlFCM0pIWmJ0angzQjN6d3VNcng1VFhQ?=
 =?utf-8?B?R3RmTDRNbDNtbDAxZkFUVkhib20xQlduZkdlTHVmWTlSeVJ6MEdDQjF1dEhk?=
 =?utf-8?B?M2dONkgrN0NTRmtLd3FpQitRbVJVRFpEYzhnYzFFRncvV3dBZ0Q3b2VjOUs0?=
 =?utf-8?B?aWwvSW5NVFBibFF6RXNBQWFBVnNDeGdFWnVjK3JaVlc4U0dQSUV6YTRuenBl?=
 =?utf-8?B?VlgvTnQzQ2lvaFAxTnlCakZXbWplQThRN2R5d2JQNEphVU9XalFEeUtmSGlF?=
 =?utf-8?B?SGNZRkZUNzEvdVhGSXlGVWtodVlLaGRlWmpLbE9sOW0yVlkzQ1FHaEJ2czVJ?=
 =?utf-8?B?YXByRzBTdTh4T2RwdXZzOS96d2FwSXZZTU5VOHpCQ255ckdiSldtczVLWXRU?=
 =?utf-8?B?U080TDZnOGVHQW8yeXI1UlpSQ0NkUDVQbXc4L2NRZUxlK0pFSlNhQlNWRy85?=
 =?utf-8?B?eC8xSzc0TEtCUUhmbkFCZm5PTG5HRVIzVFBFWFhUNmlMYXlWbCtwTEFZU0ln?=
 =?utf-8?B?SGloYjFRT0ZCK1Z5eDdCZVM5M0t6ZUNRdUlic1RvTk1pcFpRRXRORUxEYmY2?=
 =?utf-8?B?K1hOR3ZBWEEwWG0rUEhxSEpEdkZqZVM1VW5EZ291TVNuVnRPL3ZleUk5TXJP?=
 =?utf-8?B?S0pDRDN1aDZkV2Z2c2x0Y0F1MGl2L28wc3YzQnJNSEI4U1QvUHBRc3R2bXVl?=
 =?utf-8?B?S1dBOFIrTXJoSTN1OGpSSjdkS204eEl2Vzl4dHZzTjdJTDFVT1o5WUFveDd5?=
 =?utf-8?B?ZCsyYjVBRzNDbXBDMFMvWWxJdVRFK2U0VTRnWWFEazdFQnYwY2RZMldmcjZM?=
 =?utf-8?B?LzBuRVhYekt1cnFvRTZGbUJGNkdXdm9tYjc3ZlA1SkZ1K3RSQ0dmYUVwWndy?=
 =?utf-8?B?WTBDeE1ySEFNUG14dVVWS0ZQc2tSQ1ltS2REN0hRc3hMaFpxZkQ4MTE5aUp5?=
 =?utf-8?B?endNa2dFNlVUSHNUa05sbHUyTWtlUml6TDZORnV2SExEQ2lDQkxDYXNoSisy?=
 =?utf-8?B?Q1k0OWxKb0ZTWDh1QS9TSTUwMStneXB5ZDV0TnBVcUVGR05Ca2EyNmczcmcr?=
 =?utf-8?B?a2xmTTZwdGYyajVSbWs4MDRUR1dmQ2pjcEs5MVE3b2NySFI0L2VZOGp1ZkhY?=
 =?utf-8?B?eHJCUzJkQWd0aWFJalNJUFJueTd1VnBVS0t4KzZFSzJnbS9pQXRzZFpPUUlr?=
 =?utf-8?B?VEllWndQYXEwamNwNU1nclVDREJFdkZvdFlhTVh6U3J2Q1dDNlZIZFM0SkhS?=
 =?utf-8?B?aHk0LzZQdERpQkhBRll4NVZZcXJmTlJHdGt0SVJzOS8weU5nK1NHTXJtdzFV?=
 =?utf-8?B?em1oLzBRRWZXYVZLTXQ4bEowMFBJL1k0RUFWQzAzc2VDdHZKRzdCeThtVjRW?=
 =?utf-8?B?VnlaZ2Fvd1NSZ1NZU0JkbHVQUW5aU2xNcEh0bGJNYWxRdDNGNk9RdGVqcDA0?=
 =?utf-8?B?bnpjY3pmd1preFNwVHMwWHpSZjA1ZFpuZ1Y1Q2I2bndjZk9Qb2JaOXF5QU00?=
 =?utf-8?B?aEhHT0RWWTk5UC9hamhha3lhM1BRRVh5VysyUlBCSktDVGpUaTc0Wnl5UEdj?=
 =?utf-8?Q?muFBL12opZh72?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djhqbUJjRU5GTlZhV3VSOVR1VHBIaWh6Tkx2aTF6MmpRRTJuSEhGTllMc1lF?=
 =?utf-8?B?aC9iSHhQMGlMd3RNeVRtNkxNNXZGd1VVNW9KZWIwVHMyTUxvaEpnb25aendz?=
 =?utf-8?B?Wjl5OFl4RTdKSzFTbExIcFpnYjF4NGdEOVI1bWdpZ21PdzdsQ00rdmxCaEg0?=
 =?utf-8?B?aUpQaWp2RGVQa0FvQzhYeE1SVFZPTUdNSldNUlRyLzRtSENiV0tGQlJmcG9X?=
 =?utf-8?B?ejVNUWNyNitSVnI0eXp1TndrTHh5NStGY0t3dWZwVnRldk1CRmV5QU94aW80?=
 =?utf-8?B?RFZXWEJ5T0tiN1N4Q21rVVBnOVNVbjJEcURIRjdBdFFIcUg5ZnE2aDhkcDl5?=
 =?utf-8?B?Um1YTWoydEswcWhsQUpsWjVRbjRQTVZsM1pJOW1hUlFsS2pha3RRbU1YcmdP?=
 =?utf-8?B?VDB1V2RnOGl1R3Y3NnZoSk50cGJPYWFwQ0l5OC9lMU0xU2RaQmpoSGxsUzdX?=
 =?utf-8?B?K0lwamVwcjAvZGhVL1dWa3pBZGE2OUUxNER1WCtMaVB0ZnRaNEtiam5KeTFK?=
 =?utf-8?B?ckxPWU1ZNEh2NTFsL0h1cFQwSGxHMm1SdnY3Z09USS9OZ2ZIUmFIVUZodzJ5?=
 =?utf-8?B?MElGUFNZSDJ3Wmp0T1d4SU8xZ0ZmbHdRR292bGJQKzZzNkQ0VFhPRUtEYVJ0?=
 =?utf-8?B?Z1B4NU9xSzBCK1JWNUczZWhvdkNJNFZ5VjlySFcrcFdBRytXY29heklwZHpj?=
 =?utf-8?B?Uko2VHUwL1IwQUEzeDB2Wnl5dFArZHJZMjRNTGdBNGtDd2tKOU9mYUpCTzFS?=
 =?utf-8?B?ZUk0SEVBSmI1bW1DWW53WGlLd3MzVENyWnlXSGpicXZpOWpzMkZ0SmpSUVQ5?=
 =?utf-8?B?dnFndHFiTitWeVI2V0c3RmsrN3VrS0FhbytiRytXTWtrSFVIM1BzNURjQk9z?=
 =?utf-8?B?T2tBMCtTRVNpZGZwZU1RM2JpRFYyOVdnZ0hVTHBsM2hqUG9LNmhkUkFYbGd6?=
 =?utf-8?B?ODNxSjh0Q1lKV2M2ZVpMc1QrS3gvQ0ZWZncwb2dqM29oNkYxZDYvSmJjRnk5?=
 =?utf-8?B?U0dYT3kydnlXcnprRDhRVzhTaUlFKzJkZENML0hnTldaakd5Ykg3Q0R5SkpF?=
 =?utf-8?B?R01Cd2JjbDFXSno3STNjaGh4Y2h3c0ppL1NuYW4yYThoUmdsU0dRWjk5dlJs?=
 =?utf-8?B?RDdZb2RuWENVT0R4YVJWOW1KN1JxM2lrSXBzSW9qRGdlNlFTVmhsMjFQaWk5?=
 =?utf-8?B?enZNOC9OdzYwSjhoVG9nSi8zbHRzeElqbXFNSjVSdUVQcTFQcGNiQmYzU3I2?=
 =?utf-8?B?T3UzTGd1SExhZW92VnZtM3FaOWNBTHExai9XTElmV2gvSUZxM2hjSmtxTkYx?=
 =?utf-8?B?YUQySlpCN1ZORml6dFNnN0lJRmtzaWwvM3VQWFVKSHYySGt3bUpubWNtblZT?=
 =?utf-8?B?MWJxMFpheUpNVXBNdzlrN2FINHZkRzA5TmM5Zm1HNnJxYzNsRmdKbGpmWmRz?=
 =?utf-8?B?dyt1WitLbitaNms5VCtod3E3ZUs4aW5Kam8rcDlLZjF6aHhKVFRMREdTb2Vx?=
 =?utf-8?B?VXNyNkV6d2ExQWVVQ2xWZzJuRXhNc0lnaHd1NW5pU3NWRHZoK296Qm52T3dC?=
 =?utf-8?B?dmlDNklpUytSTWRFeUpZYU1QYU5oQnlZM1czWHBJSlJCTjE1Z2FlUUhFaGph?=
 =?utf-8?B?YzZULytORXJUU2tGK09vdTJ5dk1zakxSQkM3Y1lQNlAvTkNJeDFPMWZNenMv?=
 =?utf-8?B?bmxYdHF5OXptcFVicXFtaHFEMEoxOXU5a2dudlN1VUFMcGpyTHh0a2dhbll0?=
 =?utf-8?B?UGlXTUpvaDBNSTRzOGdHdXN4WWppMDFOeE9NRytiQTJ5ZzdRK2dkZllDeitM?=
 =?utf-8?B?bkYzR1VmUVJjSHV1KytGMkdubnNZVXhlaXk1RDhtcU1RU2tNN3JRMzQ0UU5q?=
 =?utf-8?B?NUpWMEtFeE1Pc2QxV3F4VG1BV3B4SmdxdThOQ3VRalhVdXBJNGN3VTA0Rmpy?=
 =?utf-8?B?OGlqcUFSQ3haK0oydUJOVjlOTHN1NTZFOTYvek1vRldFdm5yZHQ0dDIxUFlF?=
 =?utf-8?B?VVVSUllOYVkwZE1MWjNSaUFEaVhYbks3eURJazBhQ2NXRVQ1RVNsUThsdnND?=
 =?utf-8?B?QWlEM1hIaWlYRHA4L0hJdytHZUFVVXRIUFNVT255aHZYVnVweVRJSThUOGdW?=
 =?utf-8?Q?FX8jLUD/41yy5BZZKAqsYXHjM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12961123-0cb3-4b5f-bbc4-08dd52a76375
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:41:43.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tc3AigXMmmiaRzCtI0odgSno1wyGVuXs1hw5q6i1CvL3PGgDAggzSmdzEiD80Gwzlea0K8HlOWUYUxxlC4dmWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

On 2/21/25 12:03, Rik van Riel wrote:
> On Fri, 21 Feb 2025 02:58:01 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> 
>> CPU_SUP_AMD selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD which
>> selects X86_BROADCAST_TLB_FLUSH which depends on CPU_SUP_AMD...
>>
>> You need to make up your mind in which way the dependency should be. Certainly
>> not circular.
> 
> I've attached the new version below:
> 
> ---8<---
> 
> From 8da3d9f792427e434900a45e6d6391b28cf834d1 Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@surriel.com>
> Date: Thu, 20 Feb 2025 21:25:08 -0500
> Subject: [PATCH 04/16] x86/mm: get INVLPGB count max from CPUID
> 
> The CPU advertises the maximum number of pages that can be shot down
> with one INVLPGB instruction in the CPUID data.
> 
> Save that information for later use.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> ---
>  arch/x86/Kconfig.cpu               | 5 +++++
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/tlbflush.h    | 3 +++
>  arch/x86/kernel/cpu/common.c       | 3 +++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 2a7279d80460..c371b94aa5d7 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
>  	  This lets you choose what x86 vendor support code your kernel
>  	  will include.
>  
> +config X86_BROADCAST_TLB_FLUSH
> +	def_bool y
> +	depends on 64BIT

I think what you really want is:

	depends on CPU_SUP_AMD && 64BIT

And then delete the select X86_BROADCAST_TLB_FLUSH below.

Otherwise, won't it be y even if CPU_SUP_AMD isn't y?

Thanks,
Tom

> +
>  config CPU_SUP_INTEL
>  	default y
>  	bool "Support Intel processors" if PROCESSOR_SELECT
> @@ -431,6 +435,7 @@ config CPU_SUP_CYRIX_32
>  config CPU_SUP_AMD
>  	default y
>  	bool "Support AMD processors" if PROCESSOR_SELECT
> +	select X86_BROADCAST_TLB_FLUSH
>  	help
>  	  This enables detection, tunings and quirks for AMD processors
>  
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 508c0dad116b..b5c66b7465ba 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -338,6 +338,7 @@
>  #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
>  #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
>  #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
> +#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instruction supported. */
>  #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
>  #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
>  #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 3da645139748..09463a2fb05f 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -183,6 +183,9 @@ static inline void cr4_init_shadow(void)
>  extern unsigned long mmu_cr4_features;
>  extern u32 *trampoline_cr4_features;
>  
> +/* How many pages can we invalidate with one INVLPGB. */
> +extern u16 invlpgb_count_max;
> +
>  extern void initialize_tlbstate_and_flush(void);
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 7cce91b19fb2..742bdb0c4846 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -95,6 +95,8 @@ EXPORT_SYMBOL(__num_cores_per_package);
>  unsigned int __num_threads_per_package __ro_after_init = 1;
>  EXPORT_SYMBOL(__num_threads_per_package);
>  
> +u16 invlpgb_count_max __ro_after_init;
> +
>  static struct ppin_info {
>  	int	feature;
>  	int	msr_ppin_ctl;
> @@ -1030,6 +1032,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  	if (c->extended_cpuid_level >= 0x80000008) {
>  		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
>  		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> +		invlpgb_count_max = (edx & 0xffff) + 1;
>  	}
>  
>  	if (c->extended_cpuid_level >= 0x8000000a)

