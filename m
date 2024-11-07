Return-Path: <linux-kernel+bounces-400581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B79C0F92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7B5B22BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1F217F3F;
	Thu,  7 Nov 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UbtSXgk7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0F1EC015
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010452; cv=fail; b=ItH10tqNbWCPwMwRGqb2Pqq1L9cmacW3C30QnSOhWm5hYTlt5YW0wVTqKM8K14Gpm5q+wA/h8K+afD/WJxjVhS+5Oo+O3P/ngRp29l1MxnDR5NgzTCzHk1H9Sgcig7fnyAktz3BbJuEmzw8QWy4n22ECXsaWWn+g0qi9wQp3gDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010452; c=relaxed/simple;
	bh=G1q7dkwrSlo+9dCj2uZvraa4zM8L2bufbC0h0DjHnCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V+3vCB02qNNlJ2B4EH+y+YmxUUVYzWc1YPeSYPdE8eJ2SJrzAHOvRvznYE/n5TIhQ93vfguwnE79uESjaqHRXtKAfAJvWgTTNNNX29b9Bs6PCwKIUtPgsbxE+YxbDkO8NUikW2rzDhKx5eYqH16tNb65BRZBeH7ZGnNZu2RRMyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UbtSXgk7; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8POdy19Byftwi0KD/+j6R/4e4Ii//JYjGsl24c9NUf6P6SuCwybdTMXrJh7ozu0hXgn0cP919g0UHS7gShlyE89IB1HP/EIz3221eRQXPXjSqNi99WBKypvkbjMN90kHBSmjMnm+W6HWnF5Gopt/3swSDv99q0ew7qob7SYDp78OEouj9zRBIBUrAHgEaW8hYBq/0VJ7sctNjvVVf1/eQ9ArdgKJ0+hdrcs5x1Gs2Vi/MW3c4QozOkfsCQPYAjchwyCVUf8kM/u/evMjEnZT5gpToKe3ZJe0Z49vqtyFQ2ppJ29XH+vqsQrSqOj0jGJkSw47iB5ygFNA6R9Cw5xNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3GyRhID5+EY4nve0e5LNJhCij9EopoVIdGAoCtwteU=;
 b=Fm9pCKbmV+GyQFsUGDYvjJ8pLfDULTTiDqu6Is1jyT2SIQCqeJO+NuiIFHzBxQ5lWE5bvSkWPrlMGpHjdEX2NHExqRw2a0xCOkZ3Qz6+Ff/lyR2IUf7oJOj3WGWfD1QEY6UCVBdNf+/DerwMYlLY1Hp+I7YCI2vfCvW5bd0/G3+yenyqEFS17tcmOWeXfj6xHGASiBFSYMUvOzswCPj+uTJXg+wM81tBlatRwK46Hv8TSRodcXWQGpexF3Th9fxCCMD7o6aVM00IMGLMxKograffw7sRQeB6ZB6n2Zw19jCKLjwgPb3Z7DA64e5VPNeXXYxrsfwnTn5yLzHGBohfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3GyRhID5+EY4nve0e5LNJhCij9EopoVIdGAoCtwteU=;
 b=UbtSXgk7mUO8/85Z1mHiGtLKvkgfWRE7QbHiA/Sf3E1KsigXBUeMpdpujzt9O2A6WUcUPJU9Bem/cHj49TvHjxBPBCAaL99jcsDeneUYOOI+VuafhtloZBV97lV/Mk1SHd3qD+Ah/qXV8TPYH1NtXkiDRTPtgj7GZ62buMclhfyBNJ8ELiUsEsr9jefJz4gzSh3ehSQHtaYiWxdfNjvJXAAJqSuKUzKqqF2OZhBSvSZn0F3GZg5bhqQb+qKrDfrdIFqeE4U/uqQWa8JlxeiYkIPHDYTQZURkPuYVcCJg/VKQQ3mgxzI4crb2MOuhP2z2qCSwbTGKOwrNOOGY3W5aug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 20:14:07 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 20:14:07 +0000
Date: Thu, 7 Nov 2024 21:14:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy0fijpzYNA4qNCx@gpd3>
References: <20241107084805.120265-1-arighi@nvidia.com>
 <Zy0PWPaYHWsgh7Rp@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy0PWPaYHWsgh7Rp@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7393ac-1990-4f9c-a02b-08dcff68bb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEdxSlhUaXp6VCszVjl0WVp6aW5sUkY3MUtidExLTlprM0NXclBuVDFXSEk3?=
 =?utf-8?B?NkVvV3g5QTF1c0NlZUE2eHRmWFJKc0ZBYWVQU2VpQ2I3bDIrS1MxYjJlVkJ0?=
 =?utf-8?B?VkJaVzNkS3htVU5TeWJEcFNMQUpVa1ZWNk40ZGJkcVk4MjBvMnZzNmMxdDNR?=
 =?utf-8?B?Y1hXbythaTVPMG9HbGRvdFJJL2ExTG4wekdKY293YklhTTNZb0F4WDlnWWo2?=
 =?utf-8?B?T2xjaGFQalMrVEI3YzExQWs4bFpGTEZQSVprc21ScEY4YXFWS2JpV1Yydy9o?=
 =?utf-8?B?cDAwaGJwQisvUEE0YTl1akxzd0xuNkxOVWloL1RqUENjN210UHlTUDZVRElW?=
 =?utf-8?B?OU9pUnh2Q3VWbzZ2bi9HVWRJSkV5NnhCZUV4K0lYWk5SWlVHWVRiVUc1SlJu?=
 =?utf-8?B?KzBKWmp1VGR2cUx2RXU3VlBjczIxUVpOZnB3TWFGYlBkSDdjUHRqNTBzNVRq?=
 =?utf-8?B?TDluUlYzV1FEOTFPMkZzNUt5Y3E0eW9makROcFpMa3pEMWR2ZXc5czhpcy9Z?=
 =?utf-8?B?d0wxVWl0bzFXb0dIUE1yRisyT1ZLVldxblQzbVNCMVdFQ2tBbGszcGZMbWp0?=
 =?utf-8?B?NVJidys4a3g5NUxDd3hOMmsyZnM0RGlpL0IzdnA3Vm4vYXR5WlNQMVVaWExB?=
 =?utf-8?B?L3k1b1dVbDhSenJ5bnBoNmI0d0xzR1FRQzdScXpOc2tlL1NRVmN4eEZOWG5I?=
 =?utf-8?B?VWcrTWo3a2JxbXo1am02MnJlQXpmSFRtMllQaUVLNkdFaVIvUE41R3NxcXRZ?=
 =?utf-8?B?L2N2S3NUYll4SGF1R2hqNng5S1l3ZVc3cmYrci8wNlQvV3JZdlRrT29PSExv?=
 =?utf-8?B?anpGdCtQRkhadkVMZTc5dUwvWW9HbnY1ZVpmaWFPdG9uNkpHNFBJSDcyT1p5?=
 =?utf-8?B?QlJVd2dvblFtKzVhTUJMd2tWdzFYR0dqQk5mZUZoOVpyekt1V2hJV2dzMEhH?=
 =?utf-8?B?dXB2d1hMOXU0RG5Oa0lhbjk3RU1mRkkyRE9yMExQMzVRN3p2eG41dWF2RFlj?=
 =?utf-8?B?cSswZUZ5UVBSM2haQ1VINk52MmkyTlliUDBQQmxMZ3czY0Rtc1lWdGlzaTlo?=
 =?utf-8?B?Qlp5RWkwNWtKSGNyZ253UnQvRGFuYXp6dmNqL09aeTJTUmtJMzhLWExhcHcv?=
 =?utf-8?B?czI3VXh0VWg1d2wzUzd6d2x5cFFFMCtHbUcyZURUdEpsU1pPa09OVUN2RXVJ?=
 =?utf-8?B?SDlwL3RUQ3ZMUktZSjl0cTh4YS9wTXNEOGFUZnVyVUpwdzhVZzdDZUVsQVRN?=
 =?utf-8?B?dGNMc1dPNEZGVkswbGNDTTJWR1c1cEltZFJYU0pjTjl5eGIyc2J6T3pjL0Q5?=
 =?utf-8?B?NDRHZTlFVkY5UGdnTmNGSEZTVkhwemNJQXdTVFFHL0lLR2lyUldZbjk0YWlD?=
 =?utf-8?B?NmxpMkRqNjJnaFJrV3l0anQ4V0dScWpqbHRGcFViaXhMbGwrZ2I4UURpdWcw?=
 =?utf-8?B?NkhNVzF4Uk1nc1BDendKYnNxeUEwRk4vUm9GRXZrRmpCemNrVmZoNjMyeTdQ?=
 =?utf-8?B?VE5hcndVbGd2aUJjSC9BZ1Uvem1lc0wrUy9EYUxsZE9yZW9OYWEyQlZsVG9K?=
 =?utf-8?B?MUYyNXJpdXlmZGlJSlJac3RVcGpTOHF2WWtEQnNoRG90RUVpN0lORWMxUDFY?=
 =?utf-8?B?VEpGd3FTekk1aWtDb1JhU0xOd2NZODkzdGt0Vy9EWFhHVmVFamF0Q2NPY2Ez?=
 =?utf-8?B?S2xSRVZCRlBjYXhqV01uNE5CSi8zQUQxUWVDSkZ2anNyUzU1Z0U2SXc0dzVI?=
 =?utf-8?Q?aQHZFz8Mi1bus7SQuk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjAwNFNsY2ZRc2dyaUZkcURTVWRXQm51VUlnQ0FaQTVGNStJQUhQZmxFb2dw?=
 =?utf-8?B?a3RRZ2N1VWhvdDJORXowUUlEN0Z6Rm1WTkJINlBaY2F5SG5MVzZRYVBwaUc5?=
 =?utf-8?B?VzNKdzZKbGtnQ3MxNk5lV09LZ2ptdEUrUXBoWTdxVjRzOHRLbFlIcFcvTGlT?=
 =?utf-8?B?eHFWNVRxZFQvQkw1VjEzSnR6aDRnc2xrWnpWaFRqRUdpNERTcEVYVSt2Y1ZX?=
 =?utf-8?B?VDU0NGpmSVhweEVScDFzOGpia01wUEJ6NVNHN0g1MlZ3b2NtNVhaQ3BJaGFL?=
 =?utf-8?B?ZnRGbkhPQVZCUUl2LzNBSjZLUmpQRk8vS3lVSlk4Z3hhdGJQUFJUVWtwMDRG?=
 =?utf-8?B?bkxzM1RKbTZDaXQwNlRtMDhRZGMyNTlUNWg4bnUwa1pBZEFTVXk1YnFpNDAv?=
 =?utf-8?B?QlNzWW5LcUFHSGhNS2pXUGdTMmVqVUlEeDIrdkR6K25rZXh0Zk85MUptNExD?=
 =?utf-8?B?Nk0vbjJMbG5taWhyVEhxQmR3dEtaR1pUYU84RHdWNnJ5K3VBOHBEK29pM1N2?=
 =?utf-8?B?bzhYMzNCcEhLVCtWZW81YmY5WVFnOHlxNTNKSDFXRFM3bWN6TStkYmI0bHNN?=
 =?utf-8?B?TkxUNURQUGZmTGFKVnlobGxmaytVK0w0SG9HTlZzMDR6UTI2VVdIVVlSUTFK?=
 =?utf-8?B?SklOalYxYnVLOXNCY2RDY282d1d5UDUwblljWDA2Z0VKajZkY1JqTlRNUWFD?=
 =?utf-8?B?NE1zWTN4eWlGMk1mYU9yY0NDbXVFdTU4ek9abEFQYmlMbG42MWJFaUFCQ2JS?=
 =?utf-8?B?OG1UWmlwaG9NS0lDQ3pXRENxTHI2NEhYMTlsdkF3L1gweHlUaEd4bEloZ0Fw?=
 =?utf-8?B?aDE3aWhqY1dSeWlXUDI1RnY1WGR1RnVCU0FuelA1cGpiQVRzei9zbGYzRGFL?=
 =?utf-8?B?RHl2LytDTkVFMHFYR1hrME1SWUlFb1ArdVJ1MXhBZFNHWGVJKzBsWVFhTjMr?=
 =?utf-8?B?RWRpRVlmVFBsQk1CNmNOL1MxT2k1QUJrcjlVNHFZRmlUV1dXV0JhWkJ0bkpp?=
 =?utf-8?B?a29QWVhDNTZCdlRjWXBvWnFDRUNsNVpvTDllcGw5RVZ4WURzQ0liMTl5VEVq?=
 =?utf-8?B?U3BlWFdSdUZyc09OSGVDU3N1d0tZV2ZyVGY1MXlQck54aEdMTEtkdndXYTFM?=
 =?utf-8?B?YXdYSDZaSjdyRjFNS2RBTkIvc1R1dm9WbWk1YU5BdER2cnRBanRsa2szRHNX?=
 =?utf-8?B?bCs3OE5EbGhzbXJLRlp0VEY3VXlncVEwd1dkOHBDMTVQTURwUVNob2FzS3NR?=
 =?utf-8?B?LzZlVXlYWDZZbitwRFJwR3RrTEJJcWxOWThHRm1mQTJGWWwwblUyb2VHbVRI?=
 =?utf-8?B?WHZGNFEzbGlrS0s5cWlDeklrWGhZSXVxY1l2UDdaeTdaMHh3LzhjOUJ5aGhs?=
 =?utf-8?B?UDFGd1RoNE5ET28vRFZ2YUVIeUdHdk5ZdzlOVHc4UnNnNmhZbDVQKzVOdE1P?=
 =?utf-8?B?ZytKZHpsbWdMZHNpVWE0dFZPRGpRSzg3Q0F0MXIwa3pLbzY0RzNZaWhkNFQz?=
 =?utf-8?B?dTRzU1FKcWR2OVY4NmFCdlpnREtZWXBYdkExZWFRRTlDYUQ2VnA0M1ZjcHAx?=
 =?utf-8?B?UGRLMnhrNVoyL1czcVkwazlSQXpTZC8yeU1NQUsydDVSeGkzTmlVRE1zRkhT?=
 =?utf-8?B?UERDRnBnck9OTkhCV2R5SmhIWDBoZ05welh1SzlnWmFxRmU1aE9zbkd3a0Rk?=
 =?utf-8?B?VCtXYVQ4K2hIcEtnMjRLK3RJQU5Sa2t0d20yK2F0OFg2dHJqSUhocFUzeGxB?=
 =?utf-8?B?VktuWCtHVlNxNGRpUW1YSEE2cGx3TklhNmRxSVYzUngra1ZURlZad2N2U0xQ?=
 =?utf-8?B?c3JsN0N4SWFFbTA1QmdKUndwcHpHeTNUbWRlbFI2QXZEWE5tTXh0SDUxV2lL?=
 =?utf-8?B?ZXZXNVc0aTFET0lyZWlrTStJb1NmRk1YS3RmWEtjZTJEZkVxUFNSWGk2bjBX?=
 =?utf-8?B?MHphOUpWUjQ5c2lrZU1uNXJiWlY0NEhMeXRTSVpLaklqL1MweGVPUkhYMFdG?=
 =?utf-8?B?dFdHU0Rxb09GTHV3cSt0ckxsQlBzVm82RHNDeFZPRmhtWnczWkovajhYRlk4?=
 =?utf-8?B?aEdERXVYOXdYa2FTdWt1eURHVnhrK0pIbDZDU1hzWmFBbUZwY0UrZEhXVm8y?=
 =?utf-8?Q?f3r3z2/GUtkPKooFAm3xwi4A7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7393ac-1990-4f9c-a02b-08dcff68bb91
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:14:07.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaPGtk4OUZTfn55n+U8nhrCYrVC7QewSt4OOxF9i7enpMavy47RN6b7wsSeBOUhduBtuMhzJmgCRXVadgkUaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

On Thu, Nov 07, 2024 at 09:04:56AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> Some nits below:
> 
> On Thu, Nov 07, 2024 at 09:48:03AM +0100, Andrea Righi wrote:
> > +static bool llc_and_numa_mismatch(void)
> > +{
> ...
> > +     for_each_online_cpu(cpu) {
> > +             sd = cpu_rq(cpu)->sd;
> > +
> > +             while (sd) {
> 
> This can be for_each_domain(cpu, sd).

Oh that's nicer, thanks!

> 
> > +                     bool is_llc = sd->flags & SD_SHARE_LLC;
> > +                     bool is_numa = sd->flags & SD_NUMA;
> > +
> > +                     if (is_llc != is_numa)
> > +                             return true;
> > +
> > +                     sd = sd->parent;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /*
> >   * Initialize topology-aware scheduling.
> >   *
> >   * Detect if the system has multiple LLC or multiple NUMA domains and enable
> >   * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
> >   * selection policy.
> > + *
> > + * Assumption: under normal circumstances we can assume that each CPU belongs
> > + * to a single NUMA domain and a single LLC domain.
> > + *
> > + * However, in complex or highly specialized systems (e.g., multi-socket,
> > + * chiplet-based, or virtualized systems), the relationship between NUMA and
> > + * LLC domains can become more intricate, though each CPU is still considered
> > + * to belong to a single NUMA and LLC domain in the kernel's internal
> > + * representation.
> > + *
> > + * Another assumption is that each LLC domain is always fully contained within
> > + * a single NUMA domain. In reality, in chiplet-based or virtualized systems,
> > + * LLC domains may logically span multiple NUMA nodes. However, the kernel’s
> 
> Are there any actual systems that have a single LLC spanning multiple NUMA
> nodes? I think it'd be sufficient to state that the kernel assumes that a
> CPU belongs to a single LLC and a single LLC belongs to a single socket.

I've searched quite a bit, but haven't found any architecture that
explicitly shows an LLC shared across different NUMA nodes. While there
are technologies that enable L3 cache coherency / communication between
multiple CCDs (such as AMD's Infinity Fabric in EPYC processors or
Intel's UPI in some Xeon models), these are not technically LLCs
spanning multiple NUMA nodes.

So, I think it's fine to just state that the kernel is assuming the
hierarchy CPU -> single LLC -> single NUMA.

I'll apply these changes and send a v3, thanks!

-Andrea

> 
> Otherwise, looks great to me.
> 
> Thanks.
> 
> --
> tejun

