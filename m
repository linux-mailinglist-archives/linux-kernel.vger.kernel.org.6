Return-Path: <linux-kernel+bounces-370924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D529A33CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B8928405D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6441714CF;
	Fri, 18 Oct 2024 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ogVE7/8W"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435220E32F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225746; cv=fail; b=SXGxvfacUsvVodYB+3Khdi6bykJU9iZrVfjb4+5ihxT9j34Tk4kYRu5XkkVltNOhC3VCROyOMVu5Z8Ovko+wJw2o38AgMi6Xsy6sYcFuguSkv5svZGnOY6nC/PjsGJis1a4prBkU4wHHeQZJGyWPdPMFFl1E/voiKsJViSSM1s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225746; c=relaxed/simple;
	bh=MIkp4aiemwvKtwVsadd8bXz0zSMVJ/2TRD1MmnGcunM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsFF9l2I76dzk5oapWNfAaS5XyLM8ervGdF/PM0Q7LuDR+Z/GWiOeB2taPghDWiYKda8Aq8j9R8fJEMBwBJnYfzqp/+eFFenkzO5VZeqPL5QyvPnONFW4cAwM7vhRiVZ8lxxTEej5YUaNQvEDo1rkb/apPVscvEAtEpX2Hmfo5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ogVE7/8W; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmmb1j2PqgsjI6FDT6aiT/O/w0EDmQzPR+TBK7cMz/uhnyaGcQooDxagvGDjis7XXmlEh/212hG0QWvjnDzHy/7VZKuW4SNHxce5AS1+U73Ef0iH4CyzFMChOvwjJ/YiZp3bvPmMEV3PDHgd/aHWPtoHnn85/QxvnTzNuRntWOeD9Vpx1pQace+up1Fhlzl1NkfgNTnXic/bKguMZQwzTM5uEwNy3c4MFvB7aolgTJvnjk+Oo6D7576/ThzWCdWFEzdeSMxAaf69J+M9VUC6eAK28lCOWm3I9qm49mpoOdqhPGlYgG86oNehg+aRLeFgcT7pNmSl/KtXmPtiSJNjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyCjMyPrwkx5NEFlGy0gWG+zSZ3tTWJFFlRJ6MK59JQ=;
 b=nPJCgdMSuvbgh+QZTgJnFpaAvcTYBoGGE7Yw1sSHaNzw1GvakvDcdanBkQm3+Tw83pCbORhUsPlgIOf2uGL3dYj9QhvnpeOKdCmFRTTHx6coHbgRS4vcjAILbd39VBW1iln0UCDC7L68Yd8jxqJnmT4om6HvupwhYwHpwfbNkVr2IpnNUNRN9zDkLfoM02prZhgjFdb//cuBMPjEF5rHtPdHm5yFmIdXXg3ZRVDUysxC8aD8t3o/nq6FEMLfIlxoatBakIMJ4yeH4/NNRcYeZlwF6fonUILMIcov6OYbWxgsyyUKeNPnhhBAvOgrW77+vAcqzCgMuAniS8MZin0I2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyCjMyPrwkx5NEFlGy0gWG+zSZ3tTWJFFlRJ6MK59JQ=;
 b=ogVE7/8Wee7eGYJim7UeTW2KPblaSqZ18q9GN98zEpbo/jYGmiETuyGHzC5M66WjuJtYa/LuPFul1JfyyH7fov+R0vdLxrkKZer1XIZGeZElXQrMAvXJigA9OtEROTvGGQMUGE5llbzIN4HJiJC7ZIYFaemkV8UxRF/9b3Vg9gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 04:29:02 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:29:02 +0000
Message-ID: <a29086f6-8b26-464c-acc4-b310f0bf8326@amd.com>
Date: Fri, 18 Oct 2024 09:58:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] x86/sev: Move the SNP probe routine out of the way
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <e5f2f8249a6fefefdf4930ad21c48a9a768f50af.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <e5f2f8249a6fefefdf4930ad21c48a9a768f50af.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6ced53-db1f-4e2b-06ba-08dcef2d6472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enJBVUcyVFJHVjFHNDBxd3hObHRUR0NFUzBEbHhqSXJ4Sk5xdjI2SVRJM2E1?=
 =?utf-8?B?MSsrVWpVNCtzTkhGbExsRERhbUNYR1RuaWVtb1Q1VFZ6WGdCMjJvVWhQQTc5?=
 =?utf-8?B?blNKZzBEczJOTCtNV1ZSUGZQZjc5Y1QwbXY2Z1o3by95L0lKTTl5b0tkaVBB?=
 =?utf-8?B?cS81ZitIaTJHamhiMTBpRGJ0dlZwQktGZVhXWGJ5UGRpZkd2ZURDMTFjYzZU?=
 =?utf-8?B?elpVMlExcVhJYUE2MFhyYlh4ZHdnb0thSVEyVWZXbGpVYjBDNmZLNWFPcThj?=
 =?utf-8?B?UEdLUzZkNTR4MHVhcHJXVi9hbTh0QjJKMUhPNlJvRkdxdHRvaXRlMi90UmZD?=
 =?utf-8?B?OFE1dzdiVVBKNlFHV3B6ZXpEdTllWk9qRWhYMEJMQ21HWDVYZU1mdENuNlpQ?=
 =?utf-8?B?c2lzVmhkSXQ0NjhPZHVBc1NxZTNUY0JZeFo5VEdWaVlkYSt1VXhqaXdvajlR?=
 =?utf-8?B?UEhvcFRaSjFNYUV4bkI1blZ5c0hXTHJwUWliemE4M2lod045NnIyWVkrUVU4?=
 =?utf-8?B?dFNrSjJ3cjNYa0FmQW9TaFV3ZWx1aHh1S2F2TVI0WGorRGc3aXNZb1hwYVBn?=
 =?utf-8?B?Qk9idkRDU0tZengyYzE5Tlh4OTBpNzV1blJDajBZbGZ6ZDZ4N3hsL3Q1SVY1?=
 =?utf-8?B?Sk1FVHhhblRHSUYzSUhBTlpBUENWa3B2L1VLeXJTL2pGUVlCVVpTSlN1cUtp?=
 =?utf-8?B?NU5MWGdGRS9pSGNscUFacHBYWXI2T3VzMmRpVG14amVnT3RHMzEwaDZGcnFq?=
 =?utf-8?B?U3pTbHhOUFZrRWJNbkRWbjBFUDZiYThVUTNnVUxjcTRSYXNPY0QyVHozbEtX?=
 =?utf-8?B?NW5PMlZqemNUZlYvMm4vaUswWVh1c01vd3NHUjhwU0h0TnBMbnIza3hTdTFJ?=
 =?utf-8?B?dGU0dFZuT3NLYVlXVzVodnoxVVlhUFFuUTdVZ3dFd2lrcllDRjduUkcrUWZo?=
 =?utf-8?B?em0yTXdYYkNyMWJ0cG9SbmlhNm4xMmZ2amxXT05UU3BGSVl2bTVBd2NvOHJZ?=
 =?utf-8?B?cWtpTkZnNUNVcytocWM4NGlaaitYcG1BOTUvcG02TDc3MTFJZTJ2ekN2VUhJ?=
 =?utf-8?B?dTB3aS9pYmFvT3Z3MDdYVTdtbTFRY3YwOCtWWlJrSkZhYVRJeGpGc3EvTnli?=
 =?utf-8?B?Qmd0RlZvM21nMkRUWUduSVE4TXdIQk0ram5sc2c2dnRlek1nV283UzBxaHB1?=
 =?utf-8?B?WVVhREIxcmhjNUw5eGlwdHdxVXVEZVoxL1IvN1p2YS90bEZkYjF5THJGWDRE?=
 =?utf-8?B?WTZ1NkRXZ0Z4elhKUVRFM3BWSEF3MngwNy9nUmRRWlNadFR2TU45dHh2UHQx?=
 =?utf-8?B?b3kvM2xiNHJ2YzdFaVYwTFBtRWE5V1FzcW9la0NuRGVGWEhNUStkMzhhaWk2?=
 =?utf-8?B?cGxPaFpqYytxK0E0RzFQNi9OUlVFNmtJcTR5L25VUS9BdGh4bzhLWFliTkFR?=
 =?utf-8?B?RXVTaVhtSkE5QzFNV2JkT3J4YlRUdW0wSUFDNUlJWGxsam5ML2krSVMzVmlT?=
 =?utf-8?B?Mmo0NzFUek9sL0I1Q3pLa3FyRjU3Vm9uTVgxWDFaWTdVTzRZTitpNzZaWXBN?=
 =?utf-8?B?TXJsd2NWL0RQWDVFbmFaRHV6RXA0ZW9CNmROV1FKa0U0ZUJZZG9BMXBDaUFq?=
 =?utf-8?B?SzZ2QjZ4eXRtbThxQWxXWTNXYldQOVZ4a2FGYkN1QkNkVUd1MWNzeEx6MnRx?=
 =?utf-8?B?RmZyTmxGdEJNZGhKVzdRaWZaRC80NGJ3TTZMRWRmMnNtZFVOVCtuVnh3amNB?=
 =?utf-8?Q?EXl31Drm61SupQOjpjK8eCJW4GYuKmsFR8uqJX3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UndMRVdGUmlmWEtKZjhKT2oramd2TU9PaG5jUU9ndFJnTldyRDVVMWlncS96?=
 =?utf-8?B?NVpZRGZCaFpRUFpiT3VkT1g5VzlnSWhjME04TzlQenV4Y2ZHT1VBdGh5Z21F?=
 =?utf-8?B?bHROUTBaSzNsOW5CUGgvdU83K1pOajBlaW00dEUxcUVqSnZSUzhER3N2M24z?=
 =?utf-8?B?dVhXQS9SYVJpQWw1aEd2b04xb1h1ODNvSnUwM0hmRDE0bDFXY1BzaFhOYVNy?=
 =?utf-8?B?WGpicVJGMFZGZ25yTk5UNXlUZlduV2FndWxnZ2ZINWIvZjZDY0E3amZGbFRm?=
 =?utf-8?B?MzlYNjY3MVpsRUZpVEIvQ0tORlZGYVhOak9OYlRlUm45eXByNHlMZGc2WEdX?=
 =?utf-8?B?cWJuTGhETVNITnhsYytJOHRkdWdjdjBISGNqcC9yQWFaMEFEcUZRbUtTZVpv?=
 =?utf-8?B?cUFDaTE4V1o3dHZ6QUtiTGVCWHlTZlM2cmtScjllSHdJUDV2R0tNb0hENW5h?=
 =?utf-8?B?MXpXZWhka3dIMDNPY0VKTEpmbWdpNnkvNjlEWFdJa2N2aHQzeE9kRUhJZGdw?=
 =?utf-8?B?bkZpeldOYUxRL3hwSFNqRW8zcDFmRGRNSDcxd3hXUk5lY1FrbUpvaXpwMEpw?=
 =?utf-8?B?ZG5lSkxhSDlYdFpadjNweTVhUkF4OWxwOE41SFp6WkJ3YllmSlpkR2QyNlYy?=
 =?utf-8?B?QkppUkc2aG5EU0doMnBlRUtob0JjMExiVDhzNnRtVGU5QVZqemczVFNwV3F0?=
 =?utf-8?B?ZVhicWYrQkNHYmhlWlZyS1NQbEF5WjlIdFJUOWdOYmJVWTd4eE1IcDVrcGNG?=
 =?utf-8?B?VUZuMi91Zyt0QmVBZXNBYWkxNFdGc3pZZEd2TzdoYUswTGNxalZIY3kxVHJT?=
 =?utf-8?B?TkJHWVBSdGR5cDU5ckF0QWVBY3JzNHA4bktoY25CdzFzZHB5Um4wM0dyM0dx?=
 =?utf-8?B?cWtZTmtjR2xOeVFobEJJOThCZzhaTUNGNGVnZURzS1ZoUlZqOHQwVkIxbnJZ?=
 =?utf-8?B?WjVVUEpiNHVVUHNIZXg3K2paQnBxbm1zcnVOeHhGNWpSdUNFTlFKMFcrQlYv?=
 =?utf-8?B?UDhNQWh1L3N1OWdRak1vY2h0QjNKVE9MTWVlcmNiUWo1OGZrbnUxK3k4cVps?=
 =?utf-8?B?SDd1emE1T0JFT3JOamNSOWNkOEoweng2SnlaNWFlUXc0anp5LzRvRHdTWHAv?=
 =?utf-8?B?MXF6Uk5VVkNtYU1DU1NPRjJNWm80SFVRTjdaM05icUlNUlRqT0tOZFhHNlor?=
 =?utf-8?B?OUFlRGhnWmV5dDd6dXBhL1RFK2hyYlZOQkhqaUNmMk96UXJPOEJHclZycDY3?=
 =?utf-8?B?WXY5YjhrRDQzVUxpcDBocEt0SUR1aWcveU9aMjFNUllwVERSbzZQU3FORmY2?=
 =?utf-8?B?N2NGeXFES0VnVkRvcHRVNlFkejJmcm9qY21UcWVERzd2VGZlNnVFMVQrUENL?=
 =?utf-8?B?MHlCenRMU0dkVm9DdGRvSHZJTTVlMkZHOXZjTEF1a1l3ZHFNMEpOK3o5bFpt?=
 =?utf-8?B?bnF0OEpIVHFlSEVGV2hTcFBzWUM1YUNsaFFKYmlwUlQ2cUVCNkxKRWhISEEw?=
 =?utf-8?B?L2h1cGUrN05CbkIxb0lmRGlMa3R4dEtaYWlWOE4yZmFZeEJzZ2tuNERscktG?=
 =?utf-8?B?czVRQm9UMS9kWnhpa1ExNlg1ekxKcEg2L3V3WDFOVEtJWGc0dHB2ekVmQ3l2?=
 =?utf-8?B?VDBjeTE5VFkrTDlaTEVZNzBROTJZeE9STGtXay9URysrVXhIV242Zmk3YW9M?=
 =?utf-8?B?bjJTL2lTR3pQNTZVOVJOVTBHRldiOURVajJueW1PeUFJcm5Ca1RUZnEzLzlu?=
 =?utf-8?B?cHlBUytLOUc2VEt5WGJ2UTAvc3pqMk56dTJqSllaYk4vWUVzZjVESmt4dFhl?=
 =?utf-8?B?Y0ZOUHB2TjFtbVBjU2lKbU9IaGJNd3c1SndOcm5JSjhLM0FudmI2N3pJamsx?=
 =?utf-8?B?U016UjM0cDBUTTRUcElncGUvNzViaExETzNyRXFFU3hMTVhsNGpIVzRnQmRH?=
 =?utf-8?B?ZXhEdXB5ampYazZUUmx5RmFJMjQxZUpVYklhcnM0ZENON1JZbnRUREY2TmQy?=
 =?utf-8?B?V0htaFhXZGQ5Qm9FdzJHR1YxLzhoNnpRVTUrVHdzVzg2MFZxUDVLZ3pXT3Zm?=
 =?utf-8?B?NTJFaHNDUkdkeXl3bWtMbDlWRGpuS25LYkw1b2xkZTIyRDlDc21iYnA0aVFn?=
 =?utf-8?Q?AynfJOEF+CBoqBGi6GfEMAW0q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6ced53-db1f-4e2b-06ba-08dcef2d6472
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:29:02.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olTw5Pll9IgzgbuYCRhmdOiVGkx6M8LgyGZ9qZ0P5SGAxu14Tyd2ydZZqTHe8w6RY1R4VmTN6XBx9dsH2K9E4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153



On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> To make patch review easier for the segmented RMP support, move the SNP
> probe function out from in between the initialization-related routines.
> 
> No functional change.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

