Return-Path: <linux-kernel+bounces-316253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26396CD13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE5D1C21FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7E143C7E;
	Thu,  5 Sep 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Vam77Mbt"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC45156F28
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505838; cv=fail; b=aMmhBLEu9BFyckRZZ67VI4yyQU/y530gWYEK0fOxQ5ig1qhk3h387yq/JeRHL1YZoNxOEDtY2C8neMgkWycmK+HSezBUpAP0bVKBrqBoFqTPmmx/TfHy6Rbe161vhkUlZt21NRR1dAsgmmdMB3yyawAePHyTKKEJnIJwLQ+WlL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505838; c=relaxed/simple;
	bh=E1L+0h5/HI9pbi1xjEq8G1Ef/8jKQ2N7hq8ARs/Ao8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cF2XXO+K7Q2LHf9FWdX6SAr4/Y0z0c6LgQRVA9llqD7POohZxAPOP40vL0P77iLi84GG162XW8YM1mwOxKRJ51q4RARZMn+SoDVMyt1BJrLNWEdfIPrFhSRtwW2/0jquHI6UM5+cw3c8iYoyHVkVc0SIp2NT/CiPABShd7YJa8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Vam77Mbt; arc=fail smtp.client-ip=40.107.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUeYjCYq81cal1ITJKFzYSL6eqJxoekp0Gjium+cDWnM8fb3Vc+PUk3rNWQFNgG3/MltZNh+jzFJ//CbcWKAi+jbuXqfkszinIIEmVhJw2Aq1U4UO8oxRNHUKBErwjPNG6tOcVWAwSYRlORjH0WoPdhTETw4h/Hi42myMBiF5etyl39uM5xcm6E7wcCHWvrh5miVI2IznMkFpW9fN1DhwS6J/hfaTlsTZsG100vcaC8JMSvo5tIKLHx2wH00d0flJw6m+YG+oWf02iH7WHVFv3bSc1YXVzqwJnjvrYkPdTVzFtu1N9Fm9k6yRtm5aj10xTt7+BITNR3uoc4OaBss3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Atpkqjr+8Jx7JFGMaxfIFNy8YwBWcI0bAP8cRl7lEyw=;
 b=Bvnf4c8vufueCBhBoR+ggAl+NIMr48p/BqPrJX2rZ/SMwEnKFqJOMevl29QP/n9Bmc6m6Nsa+CIbCyEZL7AGrs0/opaBvhLjPWODY/LFPN2rmL7Hh3mkGqXGwKycraKIfSu8ml0fHjMi8ezar5A0B3MbcjVgpGX4mSywhh7tJcFqK/AXKSMY+6DzGgpNCplx5bKq1swV/tqd/l8eiJsMx2UF71hXYXZ2I80z0rQyCYgRZNzKPiITXJqTg4OfWDJIosTGCJpxG5xQEkapBvaR7y5RZoAgTBGY8sxR6hEkb6N+d1UWopsOg3tlfDG8B7b5AsqbzZi4i3GDrYr9s8zh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atpkqjr+8Jx7JFGMaxfIFNy8YwBWcI0bAP8cRl7lEyw=;
 b=Vam77MbttDl0raALx4TnKHG8YJKscbCkUBtUSPTQsqziXZt4LvCIIyTkfVZe0umI/Uge0IhP3Qhj4YDxwDxNqkbauEF4tfmriPgrXz4ooirgul0fjNWfqZVpmg47EzTHUaeM3FRiAjw9+aIkUCZTmAPtS1CLzzQ6ARn3fqUUH6kFu/XCF7q5kERVDvY5iyjSf9bKII9GLq1Re/ds7KWH6P/lmsefAJC7dN6ntWNojN7H5dpQmKIo9ij/nyr3FKP4y44IlYRAVCKXWGDl8yKSwIEPbB3FmzYaRXUuzmcstiG0/jbByi4N9f6wFuwvOboB7z36+sw/EiUKFE3JyOFchQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SI2PR06MB5044.apcprd06.prod.outlook.com (2603:1096:4:1a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 03:10:31 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:10:31 +0000
Message-ID: <33aa6156-3558-4182-997d-93b959c26e38@vivo.com>
Date: Thu, 5 Sep 2024 11:10:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Skip the reserved bootmem for compaction
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, vbabka@suse.cz,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Rong Qianfeng <rongqianfeng@vivo.com>
References: <20240902122445.11805-1-rongqianfeng@vivo.com>
 <5fmd2poyeas2pomho2io5zgmqd26vnxd77czmlhqn5tapy4fv4@5tdcqamzgyj5>
 <d1939f2a-24a2-48a7-9c64-5acdd7c5d478@vivo.com> <Zth-40Vzyh8zeDSu@kernel.org>
From: Rong Qianfeng <11065417@vivo.com>
In-Reply-To: <Zth-40Vzyh8zeDSu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SI2PR06MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b1998c-8721-4c9a-86f6-08dccd584d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3NOZTR3UDZBMUR5dkgzbXdtR29pMlZwd1RCeTNGRGU0d3BBYnlHN0Fhd0lV?=
 =?utf-8?B?M3YwQUhGczVSYlpZMDhBTlkwQXUzbGk4RXFHcFdVRGwxb0pRUmhLRDFpbndk?=
 =?utf-8?B?NVpiVHNjOEFnenUraGpKZW03alFVSjhqa1hUQXRwUnIzWUNHTVJkcWhIeC9B?=
 =?utf-8?B?WlVwMC94NitKbnZVMTREQ0Qzbk15M2RZdzNmVmthNHM1U1VmNDlKMWVSdnVt?=
 =?utf-8?B?cGxFT2RBM0phV1drZk5EMzdGMTc3SlNkYXl5dG5MMjg3WnBCNlpFS3lUSjI5?=
 =?utf-8?B?Ym44WlhzTFFiUkYwaGE3T0ZvS0p3ZzNKM1JPYjRtdFZRaWZHSHA5ckowZU1o?=
 =?utf-8?B?Ym9EVFkxWGFyMXA3UDNDT1hXZzJSM1o3aDJIc0xIeXBYczYvR2Z6blZWcGhU?=
 =?utf-8?B?WWRJYWtUTUtqbzR1b2I3bnRYN3M4dzl4ZE9pSUREckxBU3JCQ2JxdU1tYW8w?=
 =?utf-8?B?NUw2aHQxbU9zQURSd1dKZG9LUzRQaDdDc3FIbzZkY00wN2NFM0w0LzgyZ1Ev?=
 =?utf-8?B?c2g0T3JuK2FtNnVrbWVOVE4wYzhCRVRzbEFFZGRmeVJrSWJodkRDbzd5S3BG?=
 =?utf-8?B?L2VYSDBPSWlPYUlLai9qb2syTTZoZGNha1Baa1RPdURpYTI5OW91UVYyNzJu?=
 =?utf-8?B?NXV3TVhGNDliWGxmS0ZsSHcxcEU5V2Nvcms3ZlZybjYyaml4djh4ZENueU5L?=
 =?utf-8?B?VWtqaThEdk14VFprRjR3Q2ZBbVByNk9md3FKVTg0V0lDTXZzMEdSTnNxYXp5?=
 =?utf-8?B?YTZXVCtKSXFYa1dyZ3F1Z2pSZkZYS21uMkRoK21ySGpUWkQrRFNaT1hsdWIx?=
 =?utf-8?B?aVJQNGhnM0JZaEI0OXhYK2tDS3ZPeDEza2ZHMzFzR0VUN0JDeDhJdHlxVHMr?=
 =?utf-8?B?S05wcW53NkliTnM5NkZEUnZCQzFBY0Z4NzBWNVl2cFErR0xHWXd3MGcwamQr?=
 =?utf-8?B?NURBL1RyQW45dTg4NlJiT2JWaVZ5aVBUZmVNR0pWaGNlaGJOenJKczYwTXpU?=
 =?utf-8?B?Zkk2aUFwdlUzc3Rpd1IvK0pydld5ZFBMM2ZmTS9tMENCY0RTdE45VGt1WGFI?=
 =?utf-8?B?Z3ZMREZFc21rMk82SXlWa3ByNXhJblozN1pYYkhSUEFXb1BHcDY0N1ROUmdn?=
 =?utf-8?B?UG5adTdaUWZRRnNCajRVb3RBR0ljRE9rOUtEbmVuQkxrMEJ4MEVWbUFlWTJX?=
 =?utf-8?B?THdmSWc0SzIydzU0R3NNTWk1OTI3M08xVFBxVHAyMGZQQ3hyZU1TR1YrQUR5?=
 =?utf-8?B?VTFqM1oyOGxSdkN0cnh3bndaQmpYNFd2RUtSamVEVkJpS1NBcjdCbjZrd01B?=
 =?utf-8?B?eFloWi9lVmxsMTJTUExqU2lma0VuWGtwN2JtN2xDQlNCMWNrQ0VXZmoxRUUw?=
 =?utf-8?B?TFdpWjFtQTE5ZHlGUVg5NDR1a0Z4T2FzcjRoLytIaUV4ZVBEZWllMms0Njgz?=
 =?utf-8?B?ajRHb00zQUVOaFhyL2J3TEltbXV6Rkp2UGlOWVB6MXc2MWM4WFZWQWwzRjhY?=
 =?utf-8?B?MVlleDNEbkFJMnU3OWgvY1NzOWpXelFyZmdNeC9idGRwK1pnVXlvaDVPNGRW?=
 =?utf-8?B?eG8xV3Y3MmZtT1V4bjEzSTU5RVdyeE9mQzNJaVNPTmVSdmc2ai90Z0ZyemJI?=
 =?utf-8?B?eWhkSFNUTlRaL2ovUEZMZ1dnbi9UTThwNFNDL0VGalArY0d3ODVGR2JsU0JG?=
 =?utf-8?B?Q2RxNk4zUkErb202T1UzQ3NIcy9FRVJ0SkFPc0k5UXpwcnB2eUk3QkZWeGVN?=
 =?utf-8?B?YWhzQ3d6dlJyWjRRN282cEdGcTM0bzV6a1cwdUNNemZrb1h5NFUwK055eStY?=
 =?utf-8?B?VGRKbGQxb0J5UzhoVEdYUkNtY04zV1dDYnY5Tk9sNmpjR29NcTM3dndoaHhx?=
 =?utf-8?B?SzhmL3V1SEFSR2JGYW1vMkJ5YUg2UHl6QTUxY3ZKYVoyYk9BZ2JNTzA2b1dj?=
 =?utf-8?Q?A7AdCKO3N6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1lrdThqK0taUHhIeTNsRmJkeC8vNWM3RHBra2NodjdWQWNHc3VhYUdVU1JO?=
 =?utf-8?B?QngxTHA1MDFRL083RVZPTXRJNll0YzlWb3hmNkFQdmhPR2tiWXFZbU9US2Rv?=
 =?utf-8?B?Mm9aMUhScDFCMHAyMTVVNjBkY2cxOE1kQmlHbU02L1ZZTktrZi9PbnFXSFRw?=
 =?utf-8?B?Vkl3MUIvazg2WjRnRjFTUXRhbld2Zmc3OTh5eGhMRTZZUXYzUHhmeGxHa24r?=
 =?utf-8?B?bzNHUTlsUFRUYjBUSytZSzVuR29KY0RlZkJLVjZDTzczekN2RFZyUVBTZWh5?=
 =?utf-8?B?ZGg5SU9YRTFENVBic2pXeDcrS2NBbzhTdHhJUkpTbU1qOGhRYVl1YTdkb3Vn?=
 =?utf-8?B?Wmt5OXRLRHlvblN1eFhtaEF4aVY1Njlxbkdmd3ZSNFMwQnRJUkJaSUoyeERu?=
 =?utf-8?B?WXJJVnJYNVJyejZRcjdCTGFZRk41MEg2SGloc1VkWjEyNU81RC9Jd093UGhM?=
 =?utf-8?B?UHVySGVFcTd3YzI1NTNIOXcrZVErRms5U3NGSW9yam80NkxHK21hYkxReFBw?=
 =?utf-8?B?ZzFpc1ZyN01jMlVQVkVER2NobkhwSTdZcXV5QWNqa0RUWDNrMVF4Z0JzdmE4?=
 =?utf-8?B?ckdlSDc1NG9QTER5Z3BPMFpYL2I0dVVoK3Q1RzFpSkVnT28wc1ZHNnRjVmtT?=
 =?utf-8?B?R05FajBjKzNhRi82d3RvaHNCRWhMaGVVRE5zcmJQL1VFa3RrMXpEUFNlc2xw?=
 =?utf-8?B?VHU3Zllld0t2VGl4Nk5rWXBqTU4wZUh3b0pndTkyRmN4bTFCYjJzSEhYeWMz?=
 =?utf-8?B?QzliTkdrUmQ0L2tHTlZSU2RhYlFxNUxUN3loUlBVbUFCVCtYTTBRbWNrQ0Mx?=
 =?utf-8?B?bGQyNGVNVlYzT0dGL3hzS0krb3duaSt2ajVHbUZjdHpLN0ZJU3R5TXpIcld0?=
 =?utf-8?B?OEFCdm1nUDBld3lST0svK0dmTENYaTZwWXZUTWhkZ01Jb05pSExIcXowamdC?=
 =?utf-8?B?WURzTFBqVjZYVG9ncUJoL2t0dSt6TE50bHBlN09NSE9PQkE1UGtxaXlidGVP?=
 =?utf-8?B?VFFNNDhHcWNJTlhXdkRaS3NvOXByN1JBbnFGd2k0RVRoWCtYZWtpSkdPYlpP?=
 =?utf-8?B?clhtU3BVZlhJSkhjY0dPVWprdEFSY2V2bTdaWTM3cE80UWRNYlJOMkI2Rnhz?=
 =?utf-8?B?S2Uwdko3YmpTRzEwb0V3S1gyc2phbU1RYnlaM0pONFU1UjJ4Rk14U1p2OWZo?=
 =?utf-8?B?Z25ES3BXakwwUHpiVU5qdWpmcFRFTkxSNW5RQ3RjSnA4TDZRRHh3U283NHJY?=
 =?utf-8?B?K1Izd0Y4ZFlKaGNqTmUwY0QySUl4d252M2VtY1R2MDdKSUVzQjl3WW1TV3Bk?=
 =?utf-8?B?UVhhNzFCS1FPK3M5NlZ6TUp4UFRTQjJsQ0ZvanhxNHMrdndlcm5RbE5COUpv?=
 =?utf-8?B?UEpsRUFKK0JOWEpCYnFFaHBqSUs2UEg0UEhSQS8yOExQdENpeWNiY0RIa0JI?=
 =?utf-8?B?OGdZQ3JJeUxjOVR3WWVkSVdMaUh3T254V0YzdVR2ZjJkcCtzVXpNSVZhMWJy?=
 =?utf-8?B?UXZ6K2hLSzhsS0RRZ3ZHWjN2R3I2MnlSNGxxbnNJSm9OaWs0WUtvckVuNTY5?=
 =?utf-8?B?bmFscVNsbDBGT3VRWGhlYXk4UFBOMjVNQXJoT0R4UFVlVFpjbVlZZ2hlQ1JS?=
 =?utf-8?B?SnB6WVRqc3lySWVPS0U2SnQwZlBrK2d1ZVZpY0pjOS95UHZPTyt2MDc3N0gw?=
 =?utf-8?B?YjBZeERFOHo4VkVHc3V0blFXSTZuRDU4YXhDaUlMcHRKbHptQXFrczNueUFw?=
 =?utf-8?B?d0RlT2RmSzBKTEMweVpoY01VTWFlWkZJRHNienAwM1RlNEhtUEdqV3BPSE9x?=
 =?utf-8?B?RnRnVmVkRWRkajd6NGtiT3BTQlRRRkZaYzdNUmQ3Y2xJeDFsNzhPN0lnbXQ5?=
 =?utf-8?B?bitPa3hXeVZIWEt4WkRNdjRmMmh6dlpKSEIvQy9tcVBKS2ZVaXUxZDNmTUxW?=
 =?utf-8?B?V0xvTnFjalNuRDhYbWhnYWxxeDE2NDhVSzJYNHZ4dE9OVW84K29nZ0ZYM1JE?=
 =?utf-8?B?b3JLMXh2dnBUaFhDTEdJMXhNTnE3Y1FMb1hkT3BwY29DUHEwYXhCRjFvUzBG?=
 =?utf-8?B?dXBkeGVzZGpJK1JudWpwMjA5ZC9pVEF2VWFYejR2d3JnVnZCUHJaWUIwcW9m?=
 =?utf-8?Q?ZNqGMXz8PEUfFw8aswZORmBGH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b1998c-8721-4c9a-86f6-08dccd584d17
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:10:31.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvJnmrp+IQSqL/f7ULTqK4FGlkv1kwvrHH7HkSaEw0iQx936QmYb5hXWl+UrY8k7M66OiEyTu/kv42XSM/WI8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5044

Hi Mike,

在 2024/9/4 23:38, Mike Rapoport 写道:
> On Wed, Sep 04, 2024 at 07:59:37PM +0800, Rong Qianfeng wrote:
>> Hi Mel,
>>
>> 在 2024/9/4 19:13, Mel Gorman 写道:
>>> On Mon, Sep 02, 2024 at 08:24:43PM +0800, Rong Qianfeng wrote:
>>>> Reserved pages are basically non-lru pages. This kind of memory can't be
>>>> used as migration sources and targets, skip it can bring some performance
>>>> benefits.
>>>>
>>>> Because some drivers may also use PG_reserved, we just set PB_migrate_skip
>>>> for those clustered reserved bootmem during memory initialization.
>>>>
>>>> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
>>> I'm not convinced the savings due to skipping a few pages during the scan
>>> would justify the additional code. There would have to be a large number
>>> of reserved pages scattered throughout the zone to make a difference and
>>> even that situation would be a big surprise. I'm not even sure this can be
>>> explicitly tested unless you artifically create reserved pages throughout the
>>> zone, which would not be convincing, or know if a driver that exhibits such
>>> behaviour in which case my first question is -- what is that driver doing?!?
>> Thanks for taking the time to reply.
>>
>> At first I thought that there was not much PageReserved pages, but when I
>> looked at the memory initialization code, I found that no-map pages were
>> also marked as PageReserved.  On mobile platforms, there is a lot of no-map
>> pages (for example, ARM64 MT6991 no-map pages has 1065MB).  These
>> pages are usually used by various hardware subsystems such as modem.  So
>> I think it makes sense to skip these pages.
>>
>>
>> //no-map and  reserved memory marked as PageReserved
>> static void __init memmap_init_reserved_pages(void)
>> {
>> ...
>>      for_each_mem_region(region) {
>> ...
>>          if (memblock_is_nomap(region))
>>              reserve_bootmem_region(start, end, nid);  //for no-map memory
> If nomap regions are a problem won't that be simpler to make all pageblocks
> of a nomap region PB_migrate_skip here and leave other reserved pages
> alone?

Sorry, maybe my explanation confused you. I didn't mean to say that the 
root of
the problem comes from the no-map region. I just gave a special example. 
There
may be a lot of reserved pages on some machines, because in DTS, you can use
the "no-map" attribute to specify a piece of memory as a no-map region, and
you can also use "reusable" and "shared-dma-pool" to specify a piece of 
memory
as a reserved region.

Sorry again, "ARM64 MT6991 no-map pages has 1065MB" I counted it wrongly.
1065MB includes the memory occupied by struct page, kernel code, kernel 
data,
etc. (these are actually reserved memory). Let's use ARM64 MT6991 16GB RAM
device as an example. The actual no-map memory is about 700MB, and the
reserved memory is about 1GB.

>
>>          memblock_set_node(start, end, &memblock.reserved, nid);
>>      }
>>
>>      for_each_reserved_mem_region(region) {
>>          if (!memblock_is_reserved_noinit(region)) {
>> ...
>>              reserve_bootmem_region(start, end, nid); //for reserved memory
>>          }
>>      }
>>
>> }
>>
>> Best Regards,
>> Qianfeng

