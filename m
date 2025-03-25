Return-Path: <linux-kernel+bounces-575853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45733A7080E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C8D16BA88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526C25D1FA;
	Tue, 25 Mar 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RnvP8fAF"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D8207A0B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923409; cv=fail; b=EPAA4bnYt31cA7IIFIIr6Sf8nlYZ8SYuqnHQCKStUaMUK5ylgdPzHM/nq+6QY/Q112PnVPSL3BbLMMOeWzFiKV1Ij6i/DGdBhN7ss4k438RRGKpX3aegamhTTeop6vmWzmfiBtRQesphNKbjwbB6wbrhpFt91yCZB3F/JlxDd0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923409; c=relaxed/simple;
	bh=FCA8FU+RGtpIXbILIFk53CPD+9O7d0OjgedXco8pJ0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1RevuX1mLzTKgiajR1TKn/pVyiAJMPIP7iTgzL/GS7dYhTR1JAE3WaOotjXTawFlPoOmfGBYowlICuzrixrX+f1uEkgM0vfxYI1dMkW46pA8A+dCa1RJPCnXRRKSZNAofSPYXXR8h6cgtJRy8yWmgwz4oSTE31dlurzfef73NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RnvP8fAF; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWXuoPI/DRChfEbcFfpvXaeKnQn6rEQP8BKWkM/YwFKYQhc6S1iGzZ8z02n4DMQJolQB4MltaUEmN7uOsNHDVJW4XP/fOpH7hrtK1khaGjjn5WSg+P1sjn1pxtwr+5SqN8Tnoc4V51niy8ed33JfocTXVWvcGvuwJlg02rRjwcomFY8wwDVdgwB7FLKRkapO2UB/KYzNRNuNIyGVs2uhgOfoJ+b1J6DLXjnAWdu1UZyVlYsd4n4DD3QKzeb1bncKSDvJ+WAissp9klip+NYON3PRyxJWBnzS1LX/ClvbNVNQ9yoYB6me7+ZXA/lXsFMomWBFtV5O79QJajlPrxppvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/6NaxFJ130bMutk9cN+GsfUIkPaf8nMkV8ymjIHtaA=;
 b=XdyKtoZPR/CMRM4OHlO9KshMTuKpu04eOSabVRnCxL59pr2z3kOAKKVXb8GvGH60DiPi3b/LLUWgXum+0dMzCAACvU2tRklrdC8SrenFXuZP9e/nOLUcjvxn0fOn/JZYd2frKhHQ38MM3cy20lswMMBOeUf+Hb7+dcO6IsLA/JEjMafc0iLdGouDr4Mwugi69uQjl64gUrFS3drjj0ng2DxZ/Y/XxfR+8njWp+sLnwnoSGPIqri8cMEG6CdeIvoW4ro/NJaOgjWttUOeofJHURN9BDeAFXhNt1UUx+A8mj9LrvX+R5t2VV97ry19T9zcBR6ADENTqF5cUFQQwNUQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/6NaxFJ130bMutk9cN+GsfUIkPaf8nMkV8ymjIHtaA=;
 b=RnvP8fAFhRNJRAOc9A8vT3KRqT+9yHCcgyORSLrxVOM+0lp7/peWZM1VixbYk6XaMV9cAEXiJKyq+tfEfpjsA+/TH2tjEjypPy5Wr2G5s77e5LW0io/d5+ToLJjKJQ2cUxGfCYESlZ2jm2/t+/C8iBBu+ntZnpToO/a/nW0VxIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:23:24 +0000
Received: from SA1PR12MB6972.namprd12.prod.outlook.com
 ([fe80::3c13:8c61:5e18:9f5d]) by SA1PR12MB6972.namprd12.prod.outlook.com
 ([fe80::3c13:8c61:5e18:9f5d%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 17:23:24 +0000
Message-ID: <21d55e78-de3e-4a95-acef-5fdc144f3a9a@amd.com>
Date: Tue, 25 Mar 2025 22:53:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -V2] mm: pcp: scale batch to reduce number of high order
 pcp flushes on deallocation
To: Raghavendra K T <raghavendra.kt@amd.com>,
 Nikhil Dhama <nikhil.dhama@amd.com>, akpm@linux-foundation.org,
 ying.huang@linux.alibaba.com
Cc: Ying Huang <huang.ying.caritas@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Bharata B Rao <bharata@amd.com>,
 Raghavendra <raghavendra.kodsarathimmappa@amd.com>
References: <871pw33695.fsf@DESKTOP-5N7EMDA>
 <20250319081432.18130-1-nikhil.dhama@amd.com>
 <4c40bf22-292c-4a3a-bd32-4461c2d4f7d9@amd.com>
Content-Language: en-US
From: Nikhil Dhama <nikdhama@amd.com>
In-Reply-To: <4c40bf22-292c-4a3a-bd32-4461c2d4f7d9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::53) To SA1PR12MB6972.namprd12.prod.outlook.com
 (2603:10b6:806:24f::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6972:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5c3f0e-034c-4440-3226-08dd6bc1bf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHd1K1B1ZFFucUJyWk9UakVDQVBOMGM2MExsMXI2V1lyVWJjREVyY3ZhYmw3?=
 =?utf-8?B?T3BNSm9SV0kwbUZ1R3lPTHJmK3llVXNDbVU4VUhVemVia0Mwa0N3UUs0ejRI?=
 =?utf-8?B?K2taWCtEYzlERFR6a1NHQjNlNVRPMUpqVVdIb25UcVdqd1FoSFd1OEg5ZzBx?=
 =?utf-8?B?REoyZFkzaGFvZmE4ODBneXRCNVBpM3dXM2lGUzN1RVc5R2VrS2hPVGo0V3ZB?=
 =?utf-8?B?eGJNSDBucUdlV2dFM3dFOVR6MzlJdjhEWmdOcStMbU1zL3VSS2NzUEx3UWs1?=
 =?utf-8?B?RnJKZmJuZjdjS1Uyc1hoWFp2QmNndm1kMDcwUTJqclNKY1NHTTNYM2FEbisw?=
 =?utf-8?B?NU5BcTgxTEdiZVFwOFpTNHZwQTROaGNGZFd4anJiVzF6R0RNMlZkd3pDZ3Qw?=
 =?utf-8?B?NlIwYzFVT2ZEMFRKcnF6S0V5YVFPbGN1RUdBRlJscFdlWTNCTnZnNmUrYjdw?=
 =?utf-8?B?bzJJKzN6WlU2NjRpclR1RDExb3ZiV2NqWkh0cnZMMlRmV3pUSkI5MHorTXpq?=
 =?utf-8?B?Wmxpd2NURllSdW4rU0hNTnk1SE5YQ2pEdkI3Wkkwd0RGNklrcEJ6dVZYZEpV?=
 =?utf-8?B?RVFRV2NVOXZwdGZ6d0VzeUl5amtoWGlOSkFpZG5vU1lkU0U4bzFKYlF0NTl6?=
 =?utf-8?B?bXJlL0ZCcUVwUXJMSWNtdVNzSjV3SUNYdllGWkl2Skt6Z29rMHhnaE94bjVw?=
 =?utf-8?B?U1FqeEl5UGRreG1XMElXRTlWbitVdVYxMS9IZTZrUEsyMGRvbTdMSmZKeWtL?=
 =?utf-8?B?L3c2MnFma08vYVlEdE10V0o1VDY2NnhkWHhDQkwwUHZMU29PK0lxM0hnVzkz?=
 =?utf-8?B?WFBmajRwMm0xY2hkaFE3YklqYVl6d3Erc1F3RjVzVXNqNmdSVHlUeHJrRTU4?=
 =?utf-8?B?TDVUVDhuNjlLNlFqdWxaeWR6b1I1UVFLUmh5NXpYNE9Ya2tBVWxJSjBrY2Zv?=
 =?utf-8?B?OTRGbFk1aE0wM3lxMGZzOGFKSERjZytBenhIZDdsTmR1eEhTU2Y2djJkUXhT?=
 =?utf-8?B?Z2MzYjhJQVZlcTZoVjFsNWowMENSZFBNSVkwSFN2dk9BR2hCUzhZL0QyeVow?=
 =?utf-8?B?S3dvNUtpQnFUMG5rU0VLQXRoVlR3QkxheHUvaTE4RjFhTkpGVXAyQ25NRnB0?=
 =?utf-8?B?c24rL2xCcThjclN0d01NMVQ1aDYzTDR1dStSdGgweEFJZ2FtUEcvT3hYQ29M?=
 =?utf-8?B?S3d3U1lzclYwbVFmeTkvbGNGLzY1OTZpZDlDMThJdWhkSElBVDU2aGlDVWp2?=
 =?utf-8?B?TW8zbWpHZkpXOG1Ga3VrU2cvUC9nT2JtUzgrMnRmTkhUUlhWci9za3ZIM2h4?=
 =?utf-8?B?YjJGc3kwQ0c3dmVXQlV4S0ZJZDJZWkY4MTZod3dvdm5XMVpOc1d4QmZmOUo2?=
 =?utf-8?B?ek9HUS80dyt4OVJ4MXJid1FyRm15THE1M0UrZkt4WStNaVl5SUpRNmlUM3M4?=
 =?utf-8?B?TzNGdUxzc2h0SlE2Skg2WHRRL1NoMU1yZXlTeEhuUlhEdTdCcUh6aVJ1d3c3?=
 =?utf-8?B?YnhTaWxSdTVETmwzZFFOOFNBcHRBbXF4YlY0bGhwOHhpcEVUZW5UVDhoQ0RD?=
 =?utf-8?B?MXN3V0NQRkk3eWR0YjVIQ1pwaXdWbUlHT0FBUmVpenA1UGdzL1pxczFKNkcw?=
 =?utf-8?B?VGNUZEJTTjJNU1dNSFJKUW5heHhhR3pEZ2IrdmpFMmN6VE0zM0ZVcnhkVE9t?=
 =?utf-8?B?Qi9DUnBXTTduNXhPK1NkeU1hM01uVlU2OVhPeVhyWDVYd0RhRHFYbWc0RDh6?=
 =?utf-8?B?dkRVTEpPcExrQkdsbHpLaW5GUU9GM1hDbUVtcVlod08vcll2NXpXVDBJM2h1?=
 =?utf-8?B?N2puYitlWm43SURmYTdLSi9MTlliclUxYUFkLzVHV2JDVE84Z2w4T0h6eEN1?=
 =?utf-8?Q?WjmYM897ePptb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6972.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WER0WGRFdTRYZnVuVWFFV3U2bE90QTZRUVdMUGFvMWJDS1dMc3JPZHNBbVYx?=
 =?utf-8?B?SDFMUmh2d0wzY1dTeVJqNTdOcStYQWlIa1hyRk42b3JrcjlmR3BEOWZnL29q?=
 =?utf-8?B?dmdraWhiQ3dFTG1idkwzZ1FibWtZZm1LNEgybEsvbDMwditFTzhZT1Era2E1?=
 =?utf-8?B?UXpkWXhqRGd5ZytZdkxHSGpDdmxXMDl1c01pREpKVXJ1RCtFdlVVV0dvVGlk?=
 =?utf-8?B?ZkEySVhPaEtsQ3FOaHZsT0RjWWtuVno1d3NpMThseGF3STFZcXNhZFBwWXlL?=
 =?utf-8?B?cmRCZVpEVCtRQXBJaVRmbzFOYVlwSUo0akl5Z28rUGZ2RVFXRjhJdzdmNjFt?=
 =?utf-8?B?UExzTE9HL21jejMrcHNaUWJGeGp4dnF5dUxrZWpycVVHQWlKK3VHeTRuNnRp?=
 =?utf-8?B?MkNMa2Jzak5iUXhyOTJZWGxqMzB3cHlSRUtLYUo4bVB0YitRMFZpSVordkxX?=
 =?utf-8?B?UGtVbmxKejZjTVJlZ2dGbDhQSEZQY2NKNjBLbEZHaE1pYTJsK0ZHQW53Zlgx?=
 =?utf-8?B?T0hvZmJRU0ZzeVMrenJzSk95SkNvVjZHU3NiTTZSbHc1UWcyc2dCSEltTUxX?=
 =?utf-8?B?Mk9USSsvWnBuZFFrbTBIUG5LMzUrc2dWTDdFN2xZZ1IvQ2Z6enhNdUl4VzA3?=
 =?utf-8?B?dkZYY0RGaUxjU2tmZWFZOWFrVXROZDFXTVJPcUdwcTFBbUhuSVNqdXhJelRC?=
 =?utf-8?B?TG5BWERycmlDVnpwWlEzRkJOMmE2STU1aGtmV3FDZGpmcVZQRDRJaFY1RXBF?=
 =?utf-8?B?L1lSK1luUVNZaFRKcmtVWEdGK1FFajRpcWhON1lubzhNL0xmaEVwUVlxZlAr?=
 =?utf-8?B?ZGxBN2crZ3dydUV5QVhIVzRzYXpjYjdlM1VId3pSN214YWhQWE9zYmZxQTZF?=
 =?utf-8?B?ZndNaGNTeGw3YVhoK3g5VkNaeDY0K3htejFHUW5rQXlRcXYxY0F0REdROG5m?=
 =?utf-8?B?YjEyTUNxUWVwNVJlNktoeHJvYkk4eWg2a2JteUJkVmV4d1pDb0lRczQraG5K?=
 =?utf-8?B?Ny9sZlFFTmIvMkRrSEJkcmdHb0Y1SlBreG5qTEx3MWtzOEdxRVlHdC9USDVM?=
 =?utf-8?B?K0tJV29iZjMwY2Vod1B2dmR2ZDJmUENLZmtpWE83NjRCay92cithL2dLd2lh?=
 =?utf-8?B?SUI3YUZNL01vSm03RGlXVU5obUdLWHZDemp3VExSRVVSNnl3bEdCcG1ETVdq?=
 =?utf-8?B?SFk0UUtudXFPLytSbTJBaThJWkJxRWZGTmNmQVdRNnAzTWN4Z0MzTFdLZzQv?=
 =?utf-8?B?UEtGNkJBeGdad1ZrbkdFOWFmdFRxZ3p5V2YvTHkwRFVoVFZqd0JmYTBVTDht?=
 =?utf-8?B?UWJvcVVoQkRMWDNzYmFnODNRM0Fhb0hlRTFrc1YxdlBybzNra1A4SUtxbWVK?=
 =?utf-8?B?a1o1MTZ0U2dxS0x1Zzh2NVc5am1vbFhOSmo5cUdmV3dwM0xtZGNwbTNvVjZN?=
 =?utf-8?B?VHF1Zlp6VG1GWm5JUUxKcWp2Y1daelY0WG45SGNlZWtBV2ZOQmJ1Y3hHZVNr?=
 =?utf-8?B?aWw5M1g3akMrZnhmbHU5RkE0QzhLV2k1cEZYS3M3ZEJsNkpNR3d5MXZjeVZk?=
 =?utf-8?B?NnNGazVKMGt6cDZpY0lKOVhnbm5nbFVDdi9SWlBpWEtlOVZRVWJsNWVzczV5?=
 =?utf-8?B?dUdLSm5ENUFtSFBvSlZGN1hyT3d2MFVUVkVUZm1ka2lPYXoxd1p6Qi9MUVl6?=
 =?utf-8?B?T1Z1MTdSMGlVcDlvbG9oRXJPRlo1aGp5aEJialFGc3pJNEhtRURYcjdtYk5G?=
 =?utf-8?B?QkI2aWRuN3BpK1lNNW1UY2Q0WE8rNkpYdXU3ZjdXUkE1RE5IYlh3b1FXTzdr?=
 =?utf-8?B?TEJMVkJuTys1R3A4YzhCWDB1amRmYnNzN3owMUNKNEZjaXRtZXU2K3pyM0cw?=
 =?utf-8?B?dTlBNWRUVHBJcHF4WnRLRVBpVlRHUmF4NHJ5VTZGS1dNS2M0elRNU2pORFY3?=
 =?utf-8?B?aGEyMVBXL3h3d2N1MFRHYlEvMjhiODZEdGVDQ0RBdjF3Y0tXbVRoZW1HRHd2?=
 =?utf-8?B?RDRRMnVaeTM3YUJSYzZ4dXN6T0xPZ3dHak5UTzVaS28rcjRJb3dRQjVzMkJq?=
 =?utf-8?B?MTZXM2dmb1V2ZHJjRDAyRkpZdjBKZ1Z4a3ZoSi9nSW5XUU91aGxDR2lNcE1F?=
 =?utf-8?Q?3KeOZjSFNRXf+NTTPG3Gjwv0p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5c3f0e-034c-4440-3226-08dd6bc1bf9a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:23:24.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFZXXv7XX8vBmuD2u1kqTkc0dHJRbzN/m9V/C9gfMSyC1FH7sXOfjD117R9mW9SdJKZ844mhuuDFl5wpkzstOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976


On 3/25/2025 1:30 PM, Raghavendra K T wrote:
> On 3/19/2025 1:44 PM, Nikhil Dhama wrote:
> [...]
>>> And, do you run network related workloads on one machine?  If so, 
>>> please
>>> try to run them on two machines instead, with clients and servers 
>>> run on
>>> different machines.  At least, please use different sockets for clients
>>> and servers.  Because larger pcp->free_count will make it easier to
>>> trigger free_high heuristics.  If that is the case, please try to
>>> optimize free_high heuristics directly too.
>>
>> I agree with Ying Huang, the above change is not the best possible 
>> fix for
>> the issue. On futher analysis I figured that root cause of the issue is
>> the frequent pcp high order flushes. During a 20sec iperf3 run
>> I observed on avg 5 pcp high order flushes in kernel v6.6, whereas, in
>> v6.7, I observed about 170 pcp high order flushes.
>> Tracing pcp->free_count, I figured with the patch v1 (patch I suggested
>> earlier) free_count is going into negatives which reduces the number of
>> times free_high heuristics is triggered hence reducing the high order
>> flushes.
>>
>> As Ying Huang Suggested, it helps the performance on increasing the 
>> batch size
>> for free_high heuristics. I tried different scaling factors to find best
>> suitable batch value for free_high heuristics,
>>
>>
>>             score    # free_high
>> -----------        -----    -----------
>> v6.6 (base)        100         4
>> v6.12 (batch*1)         69          170
>> batch*2             69          150
>> batch*4             74          101
>> batch*5            100           53
>> batch*6            100           36
>> batch*8            100        3
>>    scaling batch for free_high heuristics with a factor of 5 restores 
>> the
>> performance.
>
> Hello Nikhil,
>
> Thanks for looking further on this. But from design standpoint,
> how a batch-size of 5 is helping here is not clear (Andrew's original
> question).
>
> Any case can you post the patch-set in a new email so that the below
> patch is not lost in discussion thread?

Hi Raghavendra,

Thanks, I have posted the patch-set in a new email
link: 
https://lore.kernel.org/linux-mm/20250325171915.14384-1-nikhil.dhama@amd.com/ 

with a better explanation on  how scaling batch is helping here.

Thanks,
Nikhil


