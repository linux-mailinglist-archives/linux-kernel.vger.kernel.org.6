Return-Path: <linux-kernel+bounces-510885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA57A32334
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD681888D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17582066FA;
	Wed, 12 Feb 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wdoau4g1"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488E2B9BC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354829; cv=fail; b=IkOtjO2xrSoQcfdhsG87VpYIsRqE5OhvDK8E81ZUy+6TtBmIaroDOAj//pzMnI7CzWi89GSCvc8D+A5vJ9C3x5p9pZTiqCYgvY52vPtf0wPwaVkqBC11OKmjb5+kZfxRVaFttejj5B+htUxnyniFAusjdJwvf5pRFn7+D71EYHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354829; c=relaxed/simple;
	bh=a2aztKW1tMfX2PEINNDMVoHgc1EdS1j9uiu3MejmqgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OXkN7P+5KZOFmIDzsaXmqHkbD0ycfcBw47JLfJgihaCWJ1fmhDpkT2RADnDJv31rzQwrkmFtkPz4lgFhGwHCSusnKtUjGhrbCrl6x1enwM+jCB97QK9soiJVsQYZidbdVxQ2f19q7uRDEOWvm/epU996X4D0doskTIALLxUk7xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wdoau4g1; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rsd0SfvJnihy2DjCYh6GiNoX8A3wbA/oOAbIaVbMVCE2cnGDkDnkA+x3QeJyUzWJdDkFQ1zO1S8iLdMiIQsFHHRJjWBch4LEGw8u1JYEgWXnMFNdVBTX4WvL10c3z87s2XxqKyYHe2C2/DfztMaj+mEkXP32/idC3G3ajG6ncoEp1mZeKF0BrvSVJP8rMYOIMWRgN3RlCi0hGLGMaoDkyB95GTR8xQOBkZvT9jLCiS+PdrOxDSzmN3k7rcLJH5psqHUW+valvTvSel4pcKYi+XqQC+1nQm3y8rBEMS8PuJrjZHs8a8wH9GRmtonWUotZasFFbZY9IK7OOD3Tozix8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDOFgIvfLPkz6anHQmNAK0vJlP4le6KM7YTAEYl8SHc=;
 b=ZFjPy8f5nlMXuzZxraUmW4oMqGpC3vsK3oFLirSDHwxLltNW1dHux3iN2FMUqbVywC0sbX9pZuOmgvGH7JYSxJ8P5GbO6frrXAFHDVOfIMZZab/me6SJaPoJXN3d/NbX4giHxxswbXPcMkhFO+SmnKDyC/SM/lUJZU1K84tfST4Ss52p+cb4XcYJpY8kWEFSe/InYdyeUE2AqzdDVfbLEpsWZ/YJ1wmBvxF8GmQNuWaq5WKnjWhQwU9XwvCa514PgcH76TN2+heqAr3Anh/pKNtYsQ4zpbrLKaKfJNY4505S4g1zlINQIL8jARSPSmfHyOLypNiX50TWp1ZbIC0b+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDOFgIvfLPkz6anHQmNAK0vJlP4le6KM7YTAEYl8SHc=;
 b=Wdoau4g1iRAwIVSzyUoSu8sFq/DItEAZxcK2KKRgJSBq9FqgKb8wzTedIivLKJqfzWsvmnOI4i2XwWMo3iE7b0aY73wp+v9/O+PTRtT1sTeoUleM9wqyKwxcEmyV/VJPKm0h5+NhwcHqhvjNS9SGVtzIDhdy3uawdPHTtEPf+O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 10:07:04 +0000
Received: from SJ0PR12MB6966.namprd12.prod.outlook.com
 ([fe80::6688:276b:7e47:17d5]) by SJ0PR12MB6966.namprd12.prod.outlook.com
 ([fe80::6688:276b:7e47:17d5%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 10:07:04 +0000
Message-ID: <d6774c69-7513-4c76-974e-65d564e94a48@amd.com>
Date: Wed, 12 Feb 2025 15:36:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [FIX PATCH] mm: pcp: fix pcp->free_count reduction on page
 allocation
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Nikhil Dhama <nikhil.dhama@amd.com>
Cc: akpm@linux-foundation.org, bharata@amd.com, huang.ying.caritas@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@techsingularity.net, raghavendra.kodsarathimmappa@amd.com
References: <20250128203118.578a46182beea6a82dcd0b1d@linux-foundation.org>
 <20250212050403.17504-1-nikhil.dhama@amd.com>
 <871pw33695.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Nikhil Dhama <nikdhama@amd.com>
In-Reply-To: <871pw33695.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To SJ0PR12MB6966.namprd12.prod.outlook.com
 (2603:10b6:a03:449::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6966:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ba2b73-d6e7-44b8-a6ae-08dd4b4cfff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUNoTy9Gd3VFQ1JkTC8yVHNtZklDQ0VsY3ZKYnZnd2ZjTlplN0t5amFCZ1c2?=
 =?utf-8?B?SGlSaDhGajRkbVFxMTlwS2ZHRWp2TGZSNm92S3ByallTcDRUMmZ0Wk96cm5R?=
 =?utf-8?B?M0J1UFJiTzk2SkNVVUUrVzkzbjQ0c25EUUNqejBjVmRQNzYreS9TRWZmLy85?=
 =?utf-8?B?S3pSdXFOTzdUdVhCMzRXRlRsb1JQL3g2Z0VSM1NGR0V3V0EwcXQvSU1Pcnlh?=
 =?utf-8?B?R2VWT3ZVbk5OYzZuc3ZySDl5VFdLYUxJZjZKS1pKbFlBdXNGQ2dnbGZETGMv?=
 =?utf-8?B?a24rQ0Jsa3FYRXorQVpzbHFVcWkvZlFXaDBLQnR2RDVBajN2NXQ3U0lRZXN3?=
 =?utf-8?B?VzdmUDRTOWRNR2hZSndWbklRdU5WK1NzZkFhZzBvbWVGdVZmOTZFWnpvN3Zp?=
 =?utf-8?B?ZXdBTFpObUxzVkVKNkRJbVA3bGZoZ3BlZW9Xcmx2MFcvUTltT3ZsbXNTVXFv?=
 =?utf-8?B?RG10U1JWY2pFZ1ZvWldoUXJsMmNPY2UwOWlNNHB5eDlrQzR4aHRRbWpDWGZL?=
 =?utf-8?B?ajZsRDVxekJDSnIyUEwyUDFsbDdwcVByRmxmUTZwSWJEMVV3L2s5L1ZXUXht?=
 =?utf-8?B?RGpnYW5WVnlHR0dRdGkxcXJMRk9vVnJoWk1uaXhZQldNUk05QVg1alZZY0Jn?=
 =?utf-8?B?OWE5d2ZtUVkxekhmVFhDekZpK3RobXpwVWFPK2JUb2NkdHFPam9tL0V2RDhj?=
 =?utf-8?B?WGd3SUZXVHgvTDVhUWhpQmZTZkhuQkR1cENZRFpJOEpnT3R1SkIwZmdFM1Ur?=
 =?utf-8?B?bisva2VENUxHUG92MktGb0c5L2I5ZWN5ZVQzZXNPeTJDYnFpdWR5V1lGaGNw?=
 =?utf-8?B?Y2J0UldvT0pJY3BTZHR2Z0JTdkgvVUJ6TXRiWkFnWDV2b0QxWWh3Z3Rjc2FL?=
 =?utf-8?B?K0pVSFFYTlJaV01WcUQvUjJxTjlYNHZFSXJUUll3azJyd204RU5jZ1U3alpu?=
 =?utf-8?B?UDE1WlJUdzV6OVBwNVZzZjJXYUdzVnpsMkh3NWpkMGN1WnFhVFQxR0QvQVY4?=
 =?utf-8?B?OWNIYXFESmhac0twajNqd2JjL2VTZVp2YlZCL25Qd1FBTjJJUFFIVXd2M0cv?=
 =?utf-8?B?SzQrcThuend6UzhLMUtTTEU4eUJvaWhYZ3JUcXlUMGd2YzZBVkFHazZJSU5M?=
 =?utf-8?B?UUE2ZEN4MzZ5d3FhY1B4VEZOczIxSUowQkRwVFV4UTR5RldPZ2hrSzZ4RFUy?=
 =?utf-8?B?eXJ5VEg3ekxOQjZQbHQzQ3M2MnFhWkJXQ3JsUUF4TjA4Z1Z6SVN2MTkxL3c0?=
 =?utf-8?B?MHM4SkMxNk1RM3B0dzVyZmFmcWVXT0VyeHBReWJrV2RvcC9jWDhnT2RKazQ3?=
 =?utf-8?B?UzJDTi9tckRPZzNRamo3VWd4Nk4zM0NmaTdxQVN2SVhFMkRrTnZDbmUrOVd0?=
 =?utf-8?B?YUNNeWtnSnpldUh5eXpJLzBqZ2lLWXNzTkUrdm12ODBybUQvYVBhTHlkL1g4?=
 =?utf-8?B?bkNYdmNHVnpWMllsRzlSTjhRcU9wemNBbkNPZnVmTm12ZHBsN0hKV2JRWTFx?=
 =?utf-8?B?c2tOODVxdzZlWUVpYklEUE1BdldFdGliUjJmNWtoSmE0MXhGWHc0V0FObno1?=
 =?utf-8?B?WDJJZjVYV0NuWG9DVFdIRlJ4dllFVkRwaUk5TUU5MnMrclQvK0V0ZFVuSk8v?=
 =?utf-8?B?OVUwSkdBM2ozUysxaTVkcFVFNXlSZDdZdCs5dmZITE84WWt6WVBuOS9FMkxu?=
 =?utf-8?B?TDJIdzN3VVJkdy9WcFJiYVBjSlRpN1hYRmEwdWE5Vjcxak44RnYvVnNNcURm?=
 =?utf-8?B?Wllzdi9TUXdiU3M4NmZRZGZPakdlTE4xbFVIQWFpazhlTStHTk1aaHpDNFQ3?=
 =?utf-8?B?SzBDNFlXZjI3R2dYU2liREpKc2s5Y3pOTThNbnVRRGE2amE2aEUrSUxIaHE3?=
 =?utf-8?Q?irdDjCSfR0W+9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6966.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uko1cXU0aHF5U2hlK2d0VWJoRlU5NGNlSHkrWlNGK1RzUGRyT3NxdXhiM1FW?=
 =?utf-8?B?OFZvR2N4VDJuZmtxMkp4SHhEMmhkSGJsejRheUMwaEhvS1NCMmtQcitWWkNs?=
 =?utf-8?B?K282R0tPeTVGYmxZM2U2bGR2VEE2c3U5RE5nYW9makUyY2NaM1QwRnlrYUd1?=
 =?utf-8?B?bjgyS2Z6aGlUaDJNaThYZEhBcGlnblRselRRMm1pZURhbUx5NmRkYTl2K2s3?=
 =?utf-8?B?eWpEc0dYVklCZmpBaHk0NytMeGtzdEpFUWFIVThCTVJSNXZmNC9qRWlTclB1?=
 =?utf-8?B?YUtCSXI5Y0dIUVBSNlUycHIxeGZPbFBHdFJFRUp4ZkUrdm9INXpGNHYyY3h6?=
 =?utf-8?B?TG54citOOXlQT3k5eXc5SkkwckxtWGFMRHltU0FWNmVCTThlbElscHBtazZz?=
 =?utf-8?B?Mm1mVTl6SEhBRTdTREp5ZERTQkxJVnNaMXBxc25jaUI5K29LRHhBeWpYYlJW?=
 =?utf-8?B?OVFKTjFnWE4yVU5xUUdCMjZ2N0ZkOFpmdldQRnJCTkhjVmxPSFRRS29vTURm?=
 =?utf-8?B?VUVRdm5mYXBQZVdSWFhOUXZXY2lzUEhkNjFiQmtZMUZDZUZYQVN0U3FlWEZK?=
 =?utf-8?B?YlR1c2k4c2lCQnJBamZwTjJpR0krR0g4NkwvRFRudjJGbXFMekRGTi9GaW5J?=
 =?utf-8?B?WlRUUHowd0gwVlRqa2JPdGpDK2lPeUFaMWxKYkVPOUt0dk9SV0JrbXBRTHgv?=
 =?utf-8?B?THMrSEJQY2FrT2RlWTc5VS9NMjJ5dVZ4RHhyYjJUZ3lQcFQxOE1acnZ3WTVr?=
 =?utf-8?B?ekxaSkVyMUt6aUVnOTBtRGNRNU5HN3hDMTBESDBCeURmVTZmaTlsVllReTlE?=
 =?utf-8?B?SHk3dnI4TVZ0dkFNUk4zdWY4dWVTbUZ5VlR3Tmx2WUFpdXJ0a3ovMEJJK25q?=
 =?utf-8?B?WG9VMDFyVmc2RlFwc3FpVmR6Y0hET3I1V3RkN3pucjIrN0UvVGJsRTlTRlFw?=
 =?utf-8?B?bUhob0F0V2t5dVlEYjdTMVZQOFpRNWl1UGtEZVNocUFhclFlejViUGEzWGJt?=
 =?utf-8?B?NmI3NkEyRGV0SURKcVFaU1lRMUVxalVDTlVDSFNobGNVWUx2NHVpT3ZRSzJk?=
 =?utf-8?B?TnpkM0NtengxU0pqbk9OU2owcXB1eHVFSlhnVWRIbkYzYTJEWU5GOW5XQ05t?=
 =?utf-8?B?Q2lXeTRsa2Q1VXFJY29QUmNJaTNFREV5ODgwQThsSWwrK3prWXZ4Nlo2ZVBk?=
 =?utf-8?B?dDdjdG9Jd0IzZ0VvbUl4YkhpU2tQMlJRWHpLdmc0MnRJY3VWOXpZZGZJY1Ru?=
 =?utf-8?B?bFhoMGlMRStVNTNUdSt2L0dRQndHUW5udi9YN1g4dkcvSVY3VnpKajZ6WHlD?=
 =?utf-8?B?V1BmWXJ2RGp4TjRlZ1MrMmpwL1orYnVmNlR4VXNtM2wxSlZ0WDMrQTUvY0R6?=
 =?utf-8?B?a2k2WW9QQWU2aTZsV29EREhRcmNlazNlWWF0Vk5JZDVCSDlLb3ZyZU1RQ1FW?=
 =?utf-8?B?UTMyN3Jsa0RNNjhoUlVaTVpnWmwvYVIvMi81eUVyTlFEOVE0VTl0YkZvczR3?=
 =?utf-8?B?a3R3ZjlsSlV0OWppZ1NXeXJXdG5jdlFoSEIxNWl5ems5Q21jSmRyb3dHb0Q2?=
 =?utf-8?B?NlRVa1VTZGNYTG5GYW02YWV1UER1ZlRBdlhjRHdRUElsRGszbWdWKzZldmR3?=
 =?utf-8?B?Z2RJTmd6V3BmWmFpS25DRjdQSDlmMkJaeUpDVFJoQ0NjK3o5TXlEYnZ6ckxE?=
 =?utf-8?B?SkkrSzlLdWkrRVhuMC92YWpjREh4bS91M21waEx5VE9FUTBKaEthaUhsNStk?=
 =?utf-8?B?b1VFK3B0SWdpdTBGcnM5M0dZQ09WbVV5R3JxbmRpTG42Q3NjWVlEOE1sVkpm?=
 =?utf-8?B?MENEdjg3aU43ZkFVenpuOEVTNFpJUnEwVXRFeDNuWk5DZnhpUHlkZTJpelFv?=
 =?utf-8?B?d091YjQ1QzM2YXpkSnBzbEhRQVd5QTRPcDJLdVhtMTkrSVhmWGxHcWZlem1F?=
 =?utf-8?B?MXArN0JxZVp4ajlZMHRtN2RUdnJDcnM0d1hJQnJ2Q3p0amF3bWE3RFVmVHRO?=
 =?utf-8?B?TkxReEZFRytSaFFSdTZyaXpoZEljcmUvWjBmMXU3K3g2SnA1TGk0NUttTXVi?=
 =?utf-8?B?bVh0Uzd3ajNIcDdXdERNR0hHOW1OSVMxMkhmQ3pWZDdNbDVrSmt5MXFjVWRJ?=
 =?utf-8?Q?+M482GZl57DwXlT7Ox0HGFVzF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ba2b73-d6e7-44b8-a6ae-08dd4b4cfff0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6966.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 10:07:04.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqbUn8gZiXwadcdYX+Uq/A4+P5Utmw0BxdcwJT5T1uizm7rxB6lc/K+MrN5mEw5s6nYYY2ljPkhMYJYcitzV0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868



On 2/12/2025 2:10 PM, Huang, Ying wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Nikhil Dhama <nikhil.dhama@amd.com> writes:
>
>> On 1/29/2025 10:01 AM, Andrew Morton wrote:
>>> On Wed, 15 Jan 2025 19:19:02 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>>>
>>>> Andrew Morton <akpm@linux-foundation.org> writes:
>>>>
>>>>> On Tue, 7 Jan 2025 14:47:24 +0530 Nikhil Dhama <nikhil.dhama@amd.com> wrote:
>>>>>
>>>>>> In current PCP auto-tuning desgin, free_count was introduced to track
>>>>>> the consecutive page freeing with a counter, This counter is incremented
>>>>>> by the exact amount of pages that are freed, but reduced by half on
>>>>>> allocation. This is causing a 2-node iperf3 client to server's network
>>>>>> bandwidth to drop by 30% if we scale number of client-server pairs from 32
>>>>>> (where we achieved peak network bandwidth) to 64.
>>>>>>
>>>>>> To fix this issue, on allocation, reduce free_count by the exact number
>>>>>> of pages that are allocated instead of halving it.
>>>>> The present division by two appears to be somewhat randomly chosen.
>>>>> And as far as I can tell, this patch proposes replacing that with
>>>>> another somewhat random adjustment.
>>>>>
>>>>> What's the actual design here?  What are we attempting to do and why,
>>>>> and why is the proposed design superior to the present one?
>>>> Cc Mel for the original design.
>>>>
>>>> IIUC, pcp->free_count is used to identify the consecutive, pure, large
>>>> number of page freeing pattern.  For that pattern, larger batch will be
>>>> used to free pages from PCP to buddy to improve the performance.  Mixed
>>>> free/allocation pattern should not make pcp->free_count large, even if
>>>> the number of the pages freed is much larger than that of the pages
>>>> allocated in the long run.  So, pcp->free_count decreases rapidly for
>>>> the page allocation.
>>>>
>>>> Hi, Mel, please correct me if my understanding isn't correct.
>>>>
>>> hm, no Mel.
>>>
>>> Nikhil, please do continue to work on this - it seems that there will
>>> be a significant benefit to retuning this.
>>
>> Hi Andrew,
>>
>> I have analyzed the performance of different memory-sensitive workloads for these
>> two different ways to decrement pcp->free_count. I compared the score amongst
>> v6.6 mainline, v6.7 mainline and v6.7 with our patch.
>>
>> For all the benchmarks, I used a 2-socket AMD server with 382 logical CPUs.
>>
>> Results I got are as follows:
>> All scores are normalized with respect to v6.6 (base).
>>
>>
>> For all the benchmarks below (iperf3, lmbench3 unix, netperf, redis, gups, xsbench),
>> a higher score is better.
>>
>>                      iperf3    lmbench3 Unix       1-node netperf       2-node netperf
>>                                    (AF_UNIX)   (SCTP_STREAM_MANY)   (SCTP_STREAM_MANY)
>>                     -------   --------------   ------------------   ------------------
>> v6.6 (base)            100              100                  100                  100
>> v6.7                    69            113.2                   99                98.59
>> v6.7 with my patch     100            112.1                100.3               101.16
>>
>>
>>                    redis standard    redis core    redis L3 Heavy    Gups    xsbench
>>                    --------------    ----------    --------------    ----    -------
>> v6.6 (base)                  100           100              100      100        100
>> v6.7                       99.45        101.66            99.47      100      98.14
>> v6.7 with my patch         99.76        101.12            99.75      100      99.56
>>
>>
>> and for graph500, hashjoin, pagerank and Kbuild, a lower score is better.
>>
>>                       graph500     hashjoin      hashjoin    pagerank     Kbuild
>>                                 (THP always)   (THP never)
>>                      ---------  ------------   -----------   --------     ------
>> v6.6 (base)              100           100           100         100        100
>> v6.7                  101.08         101.3         101.9         100       98.8
>> v6.7 with my patch     99.73           100        101.66         100       99.6
>>
>> from these result I can conclude that this patch is performing better
>> or as good as base v6.7 on almost all of these workloads.
> Sorry, this change doesn't make sense to me.
>
> For example, if a large size process exits on a CPU, pcp->free_count
> will increase on this CPU.  This is good, because the process can free
> pages quicker during exiting with the larger batching.  However, after
> that, pcp->free_count may be kept large for a long duration unless a
> large number of page allocation (without large number of page freeing)
> are done on the CPU.  So, the page freeing parameter may be influenced
> by some unrelated workload for long time.  That doesn't sound good.
>
> In effect, the larger pcp->free_count will increase page freeing batch
> size.  That will improve the page freeing throughput but hurt page
> freeing latency.  Please check the page freeing latency too.  If larger
> batch number helps performance without regressions, just increase batch
> number directly instead of playing with pcp->free_count.

Okay I will check the page freeing latency too. and Will check if larger
batch number helps.

> And, do you run network related workloads on one machine?  If so, please
> try to run them on two machines instead, with clients and servers run on
> different machines.  At least, please use different sockets for clients
> and servers.  Because larger pcp->free_count will make it easier to
> trigger free_high heuristics.  If that is the case, please try to
> optimize free_high heuristics directly too.

I ran iperf3 and 2-node netperf on two machines, clients and servers 
running
on different machines. And I ran 1-node netperf on one (2-socket) machine
with clients and servers running on different sockets.

