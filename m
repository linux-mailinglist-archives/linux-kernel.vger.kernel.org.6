Return-Path: <linux-kernel+bounces-565386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782CA66757
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884E9188DBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F13183CCA;
	Tue, 18 Mar 2025 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zAR+zJQN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10562114;
	Tue, 18 Mar 2025 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268639; cv=fail; b=ikvaTPJNdA2uT3acKbYK3VrDRjdszAAosR60yZDC0im0azZ84KmUv5phFVybgEtY8HR/7sEKZ7zulwG+pAc1+2oioO0qK13gIdPIchnRIB0OG3hrglLNP8srA7M41WlRJEnG/slS6UGPZKAsOUNQL6tuL1QcoMuC33qIXGuDJ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268639; c=relaxed/simple;
	bh=FywK9kAnc3pDvEhlGTloaL5sNCJwI9cwqMGeoQlaNzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C8fYkriCN09mWPZLeZL/+mmESzi5c6Hksa47/8NzyGnk8K2RoNf+Q9Ejf/Xn0htqP+eDKwU79msDgT6vekhM2B/y/hXfmS4Z2sWd+A1BAvw+DvY9Q/uSavKcy1v+a4EF73AuUfR9MIeYKhya0hFTxZ8sb7OqVBTNmhImieW+0aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zAR+zJQN; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQhz54rxkvgvLTDueQDGqo4I3JVwU0hBt4kGIOI4Vcu8ELEY7xeThizCmXwomDIQUig44PmM//2JeR19l23MA/p2iTEtLTOYLO2aKFY2iO/gEirv4fPEmyQ4JQjZui7e9PpwRASLNoBDQ5iiWIngGDqd5qYNnn1r0R9xRbDmNGeybV6q7TctxMGRDRFPtsWDb7W1IM6NRadfoOZhBCKCWFG7KMTvrA+/PEf8EK2/oDw9yCWw+Kqkis06P1mUY5Jrnmz/Gryloi0iDq0qMLWC5B69ZVH/D0mI+fK0mjd7v9SqrDNengTmEvfO8hDasdpTnsA9J0xvQm39srML5snSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TbfNm2IRf1LhQsaU1vyhY+Ugj4v9SBmvz7kw4+H/9k=;
 b=DYLxjppHKDUAcdzYceFkC7sjfXPH5uL0f7MYy1pxFqrkNGT997H+tfBs3z0GCE52fJ/iqV8QpQSC3A30ipd1xgxGxFRLizrjyUt1tNd0z4+7fgdcn9ova1eQYEnCuwKXiuD433zwelYmVzBL/k1t6hdoWM7MSsuvWXnT1m0mP2YVv6b9iPZdvsOgkPE7V0Z89DaapYWVhRoiHEZ0yW3v7BT+lYb6a/Bz6e7B2fH3IoKTdWEJeCFsmEcttGsbZIiZLPsJgqSwzDPq/Nslzu9rsDZ8bQ/DyNv7eebGHeooyxoIVQjtpIEGSeDOwjdPuggjxcNz/eNzS70+L8gEWlJ8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TbfNm2IRf1LhQsaU1vyhY+Ugj4v9SBmvz7kw4+H/9k=;
 b=zAR+zJQNPLCtFHCQ6s9NtN5uZPkbaE0CJDOsa7VTd1aokcK2WTEoCY0uVk1cin27n+ohD9RlXG642Zv442159nWVhSfjPoc6GsdxSr4MM8NbEG8qkQ8hfKDOfhAcYVIReaHRVRuMlGfmcD17eNAS3bDpvwJE1eu1rhVrUlw/qrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:30:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:30:33 +0000
Message-ID: <ebd72f1c-00fd-4cbd-8dd1-db723bf2ac0d@amd.com>
Date: Mon, 17 Mar 2025 22:30:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/8] platform/x86: asus-armoury: add screen
 auto-brightness toggle
To: Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20250316230724.100165-1-luke@ljones.dev>
 <20250316230724.100165-7-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250316230724.100165-7-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: 230cef9b-0bf5-4334-270f-08dd65cd3dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1U0NTFEY3A5d3U0M3NEbDE3OGhpV0FsVjN3eXZ1MkN0cktQc0h0Z2pDT1Fj?=
 =?utf-8?B?TE9uVkRiMVJ0UnN6OGhLYlRScVRJQXdSNmRoZXZ0TUdkZmk3WWZuTmVaMjAw?=
 =?utf-8?B?SDBNTEQ2L0hvRXZURkx0d2NEeUx5UGxGZllGdmd3TWR3UlROWXZ2THZXcUNv?=
 =?utf-8?B?aENza2paZGVlb1ExSFBXUUNHM2pnS3RVVVFmc2tsYkh4R01pbFZhUVFteEVt?=
 =?utf-8?B?YmljZDR3M1dhcW9ueGpwZkNnR0hoRmpOMER3SmMwV0FuTXJNUlRFSGd3Y3p2?=
 =?utf-8?B?UXBSMlp3c2hsdzVDRUpRT1FzdEt5UFE5bUZ1VUZ1ODBNbnZqc0c5TnRReDJL?=
 =?utf-8?B?ZlNYZDRMRU8xMGZScDZ3V0Q4MDM4dXRzcGdadGpDSm1WWnpwckt6b3I4cVRN?=
 =?utf-8?B?Mkc1dWtUdm1HTVZZTFJzc3U5V2k4UXUweUw4NUdDbSs3WklndkhKdVMySkh4?=
 =?utf-8?B?Rk0vbXhNNzNUMHIzYUJIbytLUjRualV5UjFyMlhvelU3dWRBa3lGVkxVd1Nv?=
 =?utf-8?B?bzZCKzNJb1hWWlJteHQ3SmRTMW1Za2NDRlFBOUFFMkxuSGx1OHZ4c1hiNXN5?=
 =?utf-8?B?QUUzR2U1eHFZalR6Njg5MUtmOUd1UmxXaFZuUWFzamR3ZE1aZ1dFVmMvMjNR?=
 =?utf-8?B?OHo5VE11RnJId0psUzFhUWErcjFhYitXZmppcEF6ZUxDTm9lRk55K2NhZklv?=
 =?utf-8?B?UEVJZmZRcFp6Z3UxeVBjbWhEUzRCT05NL1B5WGhWS0FVMGx4cHVRV1ZzQUJq?=
 =?utf-8?B?bkRFZm1yZWR2STNCQmJmQTNjZDNRUks5WmhSblhxT0ZTTndZczZWYmtZN3BV?=
 =?utf-8?B?N0IwbDVpczg4dXQzcE9qNkh0SzR4M3QvZVphdmwyby82TjhJVXhkSkJSQkRT?=
 =?utf-8?B?OE96bmtUT25ob0pwVlJFaVNVSksrQy9GallMdWI0R1V0V1hUdjdXL1c5amsr?=
 =?utf-8?B?TmhmQjluZGx4aDNXQXRmZHgyc0IrS3d4YTNYaU9memo4YVNqdEs0TnlJVXFS?=
 =?utf-8?B?S2NLb1NRQ2JhM0VkVlRRRWdlN1ZFYThmanMyVTI2WWdEeXFnQjFEL1hwNGZv?=
 =?utf-8?B?WkVZWFVpZlZabmdOekRjT290UnBFUDRTQmNwMWRhSjBOUkZKRGZ2M3J6T0lS?=
 =?utf-8?B?MXBxbHdGNS9ESHE2SGFLREJQT1RTS3Zva3pLd2pNNngzMkhJZFZjSmRQVnF0?=
 =?utf-8?B?cW8reitOUWNDdnFHVnNFYjM1cnFCcHMzVEhxSnloQkJHMW5uN25DWFlJTHhZ?=
 =?utf-8?B?Mng5UWxTdWVzSmEzYTY0YmpMVmV3YXg2VlBadEhZTElDanZwL2FLd0lOS0ZV?=
 =?utf-8?B?NEc5MkRjeUtXOWE4bUZUaWlKMS9KUHA1TWxtOCt1dXpKcUFUdE4rN25oak5q?=
 =?utf-8?B?clZvSUFjenNWYnozV3BneTZ5bDJJdExobHM2b1ZZVmFzWFhVblNOTmF3Vzh6?=
 =?utf-8?B?ak44OXpvbmNTb05XZlYwTHdiV3FqNzN0Z0ozV1gya09VZkFGUFJxcjRTUnZ0?=
 =?utf-8?B?bnNTaVA0MDBOY2ZoUndKSmxJNU81MnM0eU9qOE1jSmJMbzVtYW9ma2xRb1hY?=
 =?utf-8?B?K2ZCVG5XMlZFeGFTQUFKMExMeWN2UlExRVlXdkpXSjdMYnBndE16VTV2UWFw?=
 =?utf-8?B?cHdkKzQ5L0NGbzhsdGdTcTJrSDFYY2poekdJeWhJeXpKNks1ancxNE1RUWMx?=
 =?utf-8?B?OXBURG9ObkpjcTloMjBqNGtzd0VxbE1BOEZyNnNIck16Qkd2bXlhRysxejlT?=
 =?utf-8?B?VlhYR2Z4Ny9PRGtGWHp5bkFKTUdXVHFuZVErYW1lQmdQYUpjVEdtMUlibm51?=
 =?utf-8?B?azdjVEhRUTA1cG52SGhDMmdjRkpXZG0vT0JJU3VUYnZnMjY1RVNNUFhzVytw?=
 =?utf-8?Q?m7C+mNizKw+v1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlM4UHlLc1g0blBFMjJjeEhwaTlLVDlZZlZhUHZVUEt5dUEvb21QUk1GRkZP?=
 =?utf-8?B?NDZpTVdNVXlDSTJFeGFRUFhHNkExYTFYR0xVTWhYQ3QzUnN5c2lVdnBkTGdj?=
 =?utf-8?B?MG1kcm1MbWl1SEtvZ2pjWEhGS0RFSitxNkkzQWRHZDlUeDhrQVNBcHdkamdj?=
 =?utf-8?B?cWJnQzJDVnJMejdJbHExM29WOFlEbnBoY1VyQTN6YldvcStmOTh3L3MzL2gx?=
 =?utf-8?B?ZkNQVHVQb3poVVFISU1JNUgxM3MwN1hEVTlMRE9rNnRVSmk3eTAyZHZ4WlRT?=
 =?utf-8?B?OTd3WDNsc1FFTDR5cEV1RFBldWZZTzRvZFhJMFQ2emNLcUFCWlEycmVkUGtp?=
 =?utf-8?B?UXJ6dzNpUm5jUDFDbFlLQnovcC80L242Z0JJRHBYQ1AwM0d4alo2WDB2aWEv?=
 =?utf-8?B?d2xrcHJHZnNOcEIya3EzRFA3MlJydkxBSEpaMGoxcWE2a0hOZDgvOXlyNnFz?=
 =?utf-8?B?NXZ4bHJETm4vc0YxMDRlZU1kam5GUXMxR1R3bGdmRjR0NDhjWnRxamJKeHJK?=
 =?utf-8?B?QXdOYzNjK0FTWjZJTDd5d2IrM1d3c0JkeFZ5a1FyVnpFRVpPRGkxajdWY2pR?=
 =?utf-8?B?cnB2bmZ4cHpTWHk3MW5nRnRpSHlJTXlwekRIR2toZFZQa0ljMDlOT0lkTnJ3?=
 =?utf-8?B?WGtTSjNoK3QzRWh3aHZ2WGh5ZURxc0VZaFdpblkrMnJYMzBPazUwdVhNWHQv?=
 =?utf-8?B?UXlWS2poREgwckdrNURyRnEvSUhXK21uenZKL0hPd01JdFplZkhLamxkcE5E?=
 =?utf-8?B?dERRZ3o3RVBJc0xSWWIxNTlBYWhJcUJObXluaE9IRUlFWHdHU3RSNWRLdXV1?=
 =?utf-8?B?aklndTBaOER1ZHc3S0Q0ZUtScStJUEVOQytDbVkzckhwWTRBK3FSTytXYitI?=
 =?utf-8?B?OEpXQXYxMDBSYUU1L2ZEYUF2Z0NPcFRGck5ESzRxb3V4UDZSSFRBRzBydW5Q?=
 =?utf-8?B?alF1d3F2M2lWNTB6aCtFM2NRVTc0ODNCRXhvcm9nYm1vbEVOeVBPVGVwQlh6?=
 =?utf-8?B?MTdKRUN6LzZWeDAzRVdLMzAxZGlXN1hodFBZNHh6TVYyQlZOWEV4MTZWRjU1?=
 =?utf-8?B?WnMybU5uVWIyMlUxTVp2ZDlJcEU3cStPZVpUV29Cc2dzVlhYTVN5TlAvRE53?=
 =?utf-8?B?UEoyMUpMRUtyejU4akoxSEwrNUQ1aWl3TFNrZkRMNnNZcE5kbHhJM0RlU3hO?=
 =?utf-8?B?cStsR29uUVhvNnMzUURRT2RWRGEvN2FvbERNYnBsenZJaUszaURYMjV1akMv?=
 =?utf-8?B?UXg2YzdCQUliNzZRMTdhSlp4TVpOR1MxaHIrZG9HU1dTTFc1dUdIbmh3UVo2?=
 =?utf-8?B?TTRCRnpuaFRCeVRJYWZ3NlgzRFZsd3ljanVZdEZIN0duOVo3TmtsOWN0NTBs?=
 =?utf-8?B?VUVLc0E0cmxMRWhFMk01QTZSS0xnbGlPNFcySUxoWTAvMHpDVzFLMnZPTWY0?=
 =?utf-8?B?YkI1ZEZpcFpONklxUFZiRHBVeUtrTFNmV3QvQnlRekxwQzN2bVBXMy92Y1Ba?=
 =?utf-8?B?cGIzSmFQem11aTUzVk94NGJmQjVlQXNzeGV0TDlKSXJzanhNOFhxVkNRdWlu?=
 =?utf-8?B?dnNlWmdMdjJLbmFCWjlrdDRNU3VkTnpHYjJXZzJ3QTNvWkF0UWVLNTR1aVZE?=
 =?utf-8?B?cGNaYmp1Z0owVUpiVlZLRVpaU3R4Z0hpS1pNR1BYWSt0eitCczBwZ3gxR1Js?=
 =?utf-8?B?dGtSYXJtQTF1c1R0a2FTWUgrK1RUc0Urb0Y1Mml0QlI2V2ZtRG1ZaGxxTzRN?=
 =?utf-8?B?Y0dwZHBPcHEyL2s1YXA4dTFaYUUyRGt0aE5zMC9DZEtHVTVuMlJlUWpzQkVt?=
 =?utf-8?B?OTlUQXJ6NG5aNks2QUg3THkxNHdacXJQN1VkYk40WlRaMUNCSlljVHBRd1hz?=
 =?utf-8?B?dkttU3d4MU84dm9QdFQxZFJvQm04dXNaYjlnNU1WSHVkUWxPbWUwOUxBTUlv?=
 =?utf-8?B?V1I2T2Rnd09BaHJtT3V4ZFpQRXRyeXQvbWlRL29NMVNYSFFVMDdlclQ0K215?=
 =?utf-8?B?QUpsT1FaYXJHbTkxbWZaOU51YmxzU2Iya1krS2U1Nzlib3k2Q2hrYlY3LzBJ?=
 =?utf-8?B?ZjlSTzhKbmwxS3N1LzBKTVgveXUzc2NXa3E0V05XYU5NQ2JkM2JDQzdORTdq?=
 =?utf-8?Q?8KqYk2vZvq4eGAzZS7SGvNNIs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230cef9b-0bf5-4334-270f-08dd65cd3dad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 03:30:33.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjzofUIxryXE0HtkfsoTjXhylQyz33qUuY8nW0nu+vaZEo93Fp5GRPCzSOx2IZiBgJP9N5YtJ+kKHj6s87CabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479

On 3/16/2025 18:07, Luke Jones wrote:
> Add screen_auto_brightness toggle supported on some laptops.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/asus-armoury.c        | 3 +++
>   include/linux/platform_data/x86/asus-wmi.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 6f0686fd5a4b..591805f46725 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -752,6 +752,9 @@ ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
>   		   "Set the panel refresh overdrive");
>   ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
>   		   "Set the panel HD mode to UHD<0> or FHD<1>");
> +ATTR_GROUP_BOOL_RW(screen_auto_brightness, "screen_auto_brightness",
> +		   ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS,
> +		   "Set the panel brightness to Off<0> or On<1>");
>   ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
>   		   "Show the eGPU connection status");
>   
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index e735f35b423c..92fea0710ada 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -83,6 +83,7 @@
>   #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
>   #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
>   #define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
> +#define ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS	0x0005002A
>   
>   /* Storage */
>   #define ASUS_WMI_DEVID_CARDREADER	0x00080013


