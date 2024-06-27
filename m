Return-Path: <linux-kernel+bounces-232872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3091AF53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608EC1C228DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1713E40C;
	Thu, 27 Jun 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QAKd06Vy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4B7484;
	Thu, 27 Jun 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514304; cv=fail; b=gx30JXTwf/g05L+EE/XRrsiNvBPWrkhYuNYiwzAthWTfm2LqI/3SgfNLg4R+74PUFNtk7F4z4e+jG4SJSD3QvbuRXM1yI0qPlzpc2Aa26pLFRg/Y1EJUIV8dstDnQgIQFFitqZYiLLixx6gfSUoDPC484qzP+MrH7w8/EtQFFD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514304; c=relaxed/simple;
	bh=ROSlesHZRLNpq1GT4hAUhGbpY7VDimtjV4YnpZiLEUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJFje3gd2xvd/Y83hM71iodDnWVbVrmsKzYrJtQ17DAVTzEGCIW8s4TZSX6YVsSWKAHubZtnfMtDL72/5pEfbzzqiJ5JUcaAUAmrYzigGtLPBBKrbRDo6GskEJ/OcQuuqMQ3TciL1/UgV5EtwD7kgj1ItUL9E7Le6MGhFbCGvOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QAKd06Vy; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djXtfSCjcAJ5Sq5gMkTuGmuveje29jy7kY1wx20pwIj9t1DhmO8E/wO3tLm2hp8sJp5gxyo/wfeV9y/5AwIr3ygqRaRtIRqlvpvEu2l9Njv210Hc6Ox1x8b7ypmQ9tSJ8zBl650cTbjPzpYk1MoKq6L4bxljS78KFQUt+WwbdkvWVMYtDmac3F+QvmJhMr1LwoJkTT+u0P6ac9vx0AUf0zx58HJLhPEO81J7XmKCXz/uF1pLRdJ7+KSw/VM40GCFFwef72ERPGijwONUjcXcqftNoRT88xus+gSj1lU3gEhEQEsKz+i8HSdpxxNlBJO6CQTuBEZAB9QpHcakKMBBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zUJxmLTZxFQih48PY8f5uV6leBZ8yVhvRhTe9dcilM=;
 b=lGxT87cBXNEcPnd20V6NtEmWDN1B9XOjvbSkb6s/fX8kIY4C5k70vr1zLDLdCoLBLq6MNlPH412Wb1ITQouts7gvExxM/eidUqewUtndXEXxokNf5/WpZFqpEhc1YddxUG5XVHFFWnz4OYWdWHk1ZmdFVNenUwUeEXKJ7tHc5aMSWx62VE4VK86SIv0HXFrrdfWNhGuyGgbS2gI07zgv6EtWUAXjjku3yV9fdoRMLa7PZcD7j23nn/tY1G9YkIRlaiWaQHNG/NxnxDkcVxlEmHUXIITrcGI6zZYM/kNg/SUVhZukukke7wJdi+sSmP+3mkwkChcTeMZBDbtGH8GLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zUJxmLTZxFQih48PY8f5uV6leBZ8yVhvRhTe9dcilM=;
 b=QAKd06VyyY3LZa9dtPAKo6SgBvsSzgc+Ai17WvhSPTqNEIvHkkXIMDHx7bPsj7aXy6Byvwg59n/+65eV4hxKoalMuxMOGOxmic46llPqSFbvXe5qlyZK50R2LEJU6OngsL5WUV1AxruyDq8Kq0b7kfOl6ivjSsAydC0KjqNUP/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 18:51:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 27 Jun 2024
 18:51:36 +0000
Message-ID: <68e861f9-245d-4496-a72e-46fc57d19c62@amd.com>
Date: Thu, 27 Jun 2024 13:51:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 11/19] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
 <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1f116f-9726-45f1-40e6-08dc96da2b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWJaWW81U2JteFBVVUp0ZkIvd3NKem1MVGU1MVBLaGdqQkFkRjMrdVpxQUtN?=
 =?utf-8?B?aktINEtGUEVoSEMrOUlYN29lZnZEWWcxS1ZtQXE3dGRmL1EzZUc3ZzFPMDA0?=
 =?utf-8?B?eWJOeVNjbGpxVmdOWCsvV1FGRHJTVU9nbE9jcFliN0x6OFpPckR6eXhXamYy?=
 =?utf-8?B?U0VhNTdnRGM0ZGxpSUM4aU1yQ0pOc0x1b2FraWI2endOVkdOWitSUEhPNytp?=
 =?utf-8?B?VUZLNnQ4LytFN2NIRVJ5TGdidHdsMVM3UXo2bVNoaWpHbDlEMkFVRW11dktI?=
 =?utf-8?B?Smd3UGN5ZncyN0Fmd3pMbDZvZDdmY29zLzhSUWVwemRHWkhOaU5MV0tQcnUr?=
 =?utf-8?B?K01FWi81MEwxYWRyZ0RmSVNKbEZQbG9Yb3Ywa3ZrU0JDeWRKSC9zdy9yUDd5?=
 =?utf-8?B?Q2dMaUNtM0xnekRhWW05Q1FtN2ZJeWFRa2t0Q1h2U2taOEZSTDRUUVVoU1dU?=
 =?utf-8?B?MXBBK3Zrdjl3alJqamRUUmNERmJDMEJwR0IwTFdFNTcxUDgzNERtVzBLVVpW?=
 =?utf-8?B?TTR0OG44aC92RDlmRDJ1b28zamMyaFRkb05kTlk0eUM4NnVoOHJ3RitvY0Er?=
 =?utf-8?B?U3ZwUkE4RVdyemhwUWZmWDIzZ1oxdWxRQTkyODdXL2d6L0x4MnlXRHNxUWU1?=
 =?utf-8?B?Ym85UXJrQ2g5YmF4SzdKRDJDVGhWMXF5aTIvQ3l5c2dSZXo0QVZTUWFqc2Nn?=
 =?utf-8?B?OUx6MEZiVjBIRkw2RzR2b2ZNYnB4SnBoUmxVYjYrUERMb2RleTdlcUVKeUU2?=
 =?utf-8?B?WHpab241N3oyZzJSWTFBc2tQa1RxQk9mL2FNR2JKelMwWHNENUxuYnVXeHND?=
 =?utf-8?B?bndZRFFaZEN0Uk50NU1ZcStKUWdpT0EzMWw5YUs2YlU1cWY4d2dGcENNL2cw?=
 =?utf-8?B?UitSTUdZNyszUVZidFp0SHRjRy9rQzJ1Sk1HM3RTUmFueXdsOUhQSXlHZldr?=
 =?utf-8?B?RnZySW10ZitwQlhsTThXSVo1eHpwdUhrSlhNMURxaTkrVkdEbzIrSk53THJJ?=
 =?utf-8?B?WUsxTjNER3FEZ1ZxUitEUUIrbFVIQXFndlMrM09sbURSdlgvWWt4ZjRpSmtz?=
 =?utf-8?B?VzA4dmhRTDFFT3JSbWN6M3FrVUNtcTIxbVZ0NTlTUUdOT0Z6eGN3WUV3aUJo?=
 =?utf-8?B?RlhONFhhVzBRakJPMzhpeHNzYkRoUnNWcDYrK2VOU0FBQ21jYXNTZTFNMHJt?=
 =?utf-8?B?SFRHZmt3ZU1BaDE3SGhDb21ZSGN5dkZCT296UVk3TTFHbnE2aHRiMU9mdmFY?=
 =?utf-8?B?WU91QngzamliWndDUjBqQytldUJ5U3paWHdjdFlDdUwzY0hFRm00aWkzbDhN?=
 =?utf-8?B?S2QxWEd0cnRrOUlXZXBaemd5TDMvUjIwVGhCa29vamRqaGdvdDQyS2RBeU1X?=
 =?utf-8?B?MHArckhRbDNOdGx0c29Md2ZZb3VpTjNreSs5aVJGM2dmUXNlbVhnc2U5U0Vp?=
 =?utf-8?B?SVB5alZNV0svek9ocVE0aFpDUHpIZ3krQStUV0ZKOHhTNjNJWkNUT1VQSGpy?=
 =?utf-8?B?L0VvdVRnVmVEcXcrWTRaZUpmVC9UcjdyVzBvaUhWK05KTXBFVXFjdnoyWTRl?=
 =?utf-8?B?R3ByMGliN29EWmRyaERBMEdJL1h3L2RyejArZ2lDVFhNU2FFbVBjMFkxakFR?=
 =?utf-8?B?b0gwZE5iUW1OYndOb3QrWEo2MVFScGtseG1wYlhDVzU4UkluTXhuQ3lvYkNr?=
 =?utf-8?B?K0pGN2lCOVJDLzBsTzdHRnlENHg5M3ozSXd2V0haeUh2TjBtZk9kU3dKYVZh?=
 =?utf-8?B?ZEtCWHQ0RXFFcU1LdXU2SWV4MHNZd3BKQzlRb1BwVkRDYkNmUzVkcE51ekVF?=
 =?utf-8?B?dFBRb3FkcEErY3kzSjV5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXBqSWZaNGQycGl1N1FGWDAwK2FNMDdndHpjM3RGODUxM1NQUmpQbzQ3dmRv?=
 =?utf-8?B?U3N2RGM2eFdhLzRwMEZMNUZESFJ3NlJpWWROakVlV0llSWNUUUdFSUdJd1Bk?=
 =?utf-8?B?cyttVGVacCtrV2F0TGhCWkx0WXFFRk5kc0hNY1JWcFJaZk9RQlBuWEU5MTNJ?=
 =?utf-8?B?NmVLOHl5cWtzMm5wRHZVUk00YlgrM01Fd25PWDVaVElFT04vdUtwYWxKa3Ft?=
 =?utf-8?B?ZkR2UVNiVzR2c1VKb2swTXBHSTNOTU1aWUtyZXl5Kzl6WkVFSnhKaCs2cWRw?=
 =?utf-8?B?aEZQZWRJeHlHQ01ZRTR0L3c1TjBrSFZEYmVXSjJSa25ScTViOTVWeEVaQWto?=
 =?utf-8?B?QzhYcnJ5NmxSclBzYUVXZUI4R0hnQk9PcEtiYTdvVWQzdURiWnNiUkJNTmZG?=
 =?utf-8?B?emMxNXgweGtMWVUxV2h6blFnaUFvRjByWnk3Y0FDSjZYcXFRRkdiK0xWd1JJ?=
 =?utf-8?B?NVZCcHZwdnlrWWRGRlNaZ2RyYlhQMGtveU9wa0k5MjMyZmZqVGs1NTF2aFlU?=
 =?utf-8?B?YUtxZEMyM2tBeTlJdGcxdnNKZnQrQTdhUGdsbnZPMDI1Mks3WFFXeUpoSG9C?=
 =?utf-8?B?Rkc1bHpCTVI3Z2UyNXVIU2x4ME9waE9aalpCTERiQjRJVTNTTFhidTBnUkxS?=
 =?utf-8?B?RXZOYmVsOE1tVmpQc0VSeWV4elZLTkU5VGhkcElWKzJqR0FFeGFuQXV6eGow?=
 =?utf-8?B?cEphU3hBS1piYVpweHdQSUc4Q1ZZNW9OOElpb0hWeEFvMmF2djQzZkhHL24x?=
 =?utf-8?B?R1MrejZVa05va1hxMVRrQVZlSDRMUjhHcHlOanRDRVlBajFBYWJmS01jeWhH?=
 =?utf-8?B?UlJWQktGZmNXRGZZdXRJc2U2djVEZkNtM2poMGJXTXMySTJIK0dIaUpTd09s?=
 =?utf-8?B?YTJqU08ySHBZNitmK1pZY21FbjFQeFRGSHIxdGYrWkgwZUZzeEZxKytwVlBp?=
 =?utf-8?B?MnFiSHEzbHA2S2gvclNROVdveUtPRmpLczRKUnB6K0txTTV3Nm1TK3ZobEth?=
 =?utf-8?B?aWh5THZnRlF3NElMc3F3VDRZVEdJZU9OWmdEOG1lNklYZUxSUDR4NkRGd1Bm?=
 =?utf-8?B?SUhtbSsyQ20yVE55N0hld2tFMzZOczRYZzdudi9UaDhGczBZVHpKOGhzdjc2?=
 =?utf-8?B?ZkJEMDgxdGRpVVFLVUVtTlFoT29ndzZLQ05SaFpFODBvYUgvd2o3ak5Saks3?=
 =?utf-8?B?UjVyYjRpdWF1YWR3Qi9nYmMvU3ZGMTJ3MDRsTTZubXpIYXBNa1UxZ3R5c3hP?=
 =?utf-8?B?QjA5SjZjYWErYS8yS3Y0T1VRdGZZMWFKaXEvdkF3NVZrK05ybWlYcU1XTjNo?=
 =?utf-8?B?ZnVMRzRNdWhlS1hOaERpZTdhZjQ1VHpQVER4Y0tCVHJHS0h4OGFtbHFLNk5G?=
 =?utf-8?B?cklmV0tsQjdVYU9HREtqellMbXAzYXg2NTdOTlJCZlJreXVBY25Wc3JwRUQr?=
 =?utf-8?B?cXhlWnhZZkRmczFDZ2xvYUoyU0k4Z2tJUmEwZXI5VDFOSElOZVdES3lrZysx?=
 =?utf-8?B?QUlJbDVOazR3NXhzOFBkV1IxM1hobXFtMU9LbzFXQmQzWkhZdzhabTdad29J?=
 =?utf-8?B?emxMeE1aZFBwZVhVSm9BSEFOWXhETHMxWTh3a2ZLYlNuSkEwbFpqbGUzbGZB?=
 =?utf-8?B?Z1hycGg4ZzJOY3ZhN2Fza1BqVE50elJkd1cyUDg2bWg3eVRPZ0RBbzAxajNO?=
 =?utf-8?B?S3g2WU4zVDgrWlEyMmExM09UUVVuS0V6SjdQWEsvNU1rNFpWYUhuVFlPNzVO?=
 =?utf-8?B?a3NCeVV3dFMxRmVqZkJRZ1ErRnRpNkxhWEZvNExRaHRYdkxpTU8zNmprVkxQ?=
 =?utf-8?B?dVdYb2NWbjFkRERJZUMxL1A0cW9zeHo3SytRWjEyOXpUeUIzVE1WZ0RwZnkz?=
 =?utf-8?B?d1l2SVkzQ2U4NmF4WnNENEVCSFcwSDE1eWpweHcwMml5VElYSytWcEZ3bDA1?=
 =?utf-8?B?UUpvYnp2NnZqRUFuVWpwWlllT1ZBaHg5Wm9JbjUvNC82QWZvekhKd0VaeHRL?=
 =?utf-8?B?NVpkZzlIdk5uODNLSzNYOG9xbFg5elNJcnd4bmNPSWE2c0xSNndwT3MzYlBk?=
 =?utf-8?B?UWEvVW50VnVGcmdqNkFKeng0N2V5bmwvZVV4QmRBV2dYeWFHK3g5QVh5Wnpp?=
 =?utf-8?Q?ICxI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1f116f-9726-45f1-40e6-08dc96da2b88
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:51:36.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdIy97YLeSSTdPy3IyGQ3Y7FXyhn+qJCbb3FWVOCquOLI6yimdTo+fmkopKtgGqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

Hi Reinette,

On 6/13/24 20:43, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured to track specific
>> events. The event configuration is domain specific. ABMC (Assignable
>> Bandwidth Monitoring Counters) feature needs event configuration
>> information to assign hardware counter to an RMID. Event configurations
>> are not stored in resctrl but instead always read from or written to
>> hardware directly when prompted by user space.
>>
>> Read the event configuration from the hardware during the domain
>> initialization. Save the configuration information in the rdt_hw_domain,
>> so it can be used for counter assignment.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Read the configuration information from the hardware to initialize.
>>      Added few commit messages.
>>      Fixed the tab spaces.
>>
>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>
>> v2: No changes.
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++++++++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index ec93f6a50308..856c46d12177 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -542,6 +542,8 @@ static void domain_add_cpu(int cpu, struct
>> rdt_resource *r)
>>           return;
>>       }
>>   +    arch_domain_mbm_evt_config(hw_dom);
>> +
>>       list_add_tail_rcu(&d->list, add_pos);
>>         err = resctrl_online_domain(r, d);
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 5e7e76cd512f..60a1ca0a11a7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -373,6 +373,8 @@ struct arch_mbm_state {
>>    * @ctrl_val:    array of cache or mem ctrl values (indexed by CLOSID)
>>    * @arch_mbm_total:    arch private state for MBM total bandwidth
>>    * @arch_mbm_local:    arch private state for MBM local bandwidth
>> + * @mbm_total_cfg:    MBM total bandwidth configuration
>> + * @mbm_local_cfg:    MBM local bandwidth configuration
>>    *
>>    * Members of this structure are accessed via helpers that provide
>> abstraction.
>>    */
>> @@ -381,6 +383,8 @@ struct rdt_hw_domain {
>>       u32                *ctrl_val;
>>       struct arch_mbm_state        *arch_mbm_total;
>>       struct arch_mbm_state        *arch_mbm_local;
>> +    u32                mbm_total_cfg;
>> +    u32                mbm_local_cfg;
>>   };
> 
> Similar to the abmc_enabled member of rdt_hw_resource, these new
> members of rdt_hw_domain are architecture specific and should never be
> touched directly by resctrl fs code, for example, from mbm_config_show().

Need some clarification here.

I am thinking you want to introduce architecture specific routines to get
and set mbm_total_config/mbm_local_config for the domain.
Something like this.

+int arch_get_mbm_evt_cfg(struct rdt_domain *d, enum resctrl_event_id eventid)
+{
+       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+       switch (eventid) {
+       case QOS_L3_OCCUP_EVENT_ID:
+               break;
+       case QOS_L3_MBM_TOTAL_EVENT_ID:
+               return hw_dom->mbm_total_cfg;
+       case QOS_L3_MBM_LOCAL_EVENT_ID:
+               return hw_dom->mbm_local_cfg;
+       }
+
+       /* Never expect to get here */
+       WARN_ON_ONCE(1);
+
+       return -1;
+}
+
+void arch_set_mbm_evt_cfg(struct rdt_domain *d,
+                         enum resctrl_event_id eventid, u32 val)
+{
+       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+       switch (eventid) {
+       case QOS_L3_OCCUP_EVENT_ID:
+               break;
+       case QOS_L3_MBM_TOTAL_EVENT_ID:
+               hw_dom->mbm_total_cfg = val;
+               break;
+       case QOS_L3_MBM_LOCAL_EVENT_ID:
+               hw_dom->mbm_local_cfg = val;
+       }
+
+       return;
+}
+

I have added the functions in rdtgroup.c and prototypes in internal.h.
This will be called in mbm)config_show() and mbm_config_write_domain()

Did I understand this correctly?

Thanks
Babu

