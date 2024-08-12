Return-Path: <linux-kernel+bounces-282679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8B94E74E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76F81F224C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD71537D2;
	Mon, 12 Aug 2024 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRzrYY/v"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5C1547DF;
	Mon, 12 Aug 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446006; cv=fail; b=Z0OzPtLO32/apw99jZm6D+cNB/oV7uZxdYjh5zmFpNp1HXBf3eMmMUqcHOfWER2Ajxg/nFLkcH7+Wordzout2pZhKS90lReNt2bZpDVO7Z9q1jwdu0M0DyYmfKvdPfQB2qjriyMGfKHus3ihKoNCQRJTKJhTwsvLLyUw5Qx7xPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446006; c=relaxed/simple;
	bh=JzCIqpwKtbhQ7VRl5/a1NQjfqzz4iE5F2oshbssPjHM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XvYp1Exu5zYvci8PIA48xBeAwufnjYVHhR8rXN/IQyGK716og6wB0nlCKZaItrfV3k5Yccrang+okcjKvdvkuguReMCoBoCTD8Ax3p5ZGWRH5ce/7lt2fJFSexEAFigrMi9kcLc1kafLeUWlzFDLIbEIqjRX/6mXgrsBYCKeBuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRzrYY/v; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9TkUqLA8c6vBm4SqXrL/sRMivEiKDhOGXAhBIHydUld07BeJjGBecnnVvVyXrY/GC+N70wOVhTaq1nRL5vzDo/giJP5yK5ZQR6E4An5V3VHQcwTujh1tdRlQVTvQZBV6NcFDJzZg7acMtx+wkN9vwHCeSU/u8MbtzKQCYgUlNDeNu30sINrFqyFug1mNKRPRsXchdgFX+jRAM1QmvskQFl8af9F39+BAO+SgjQ7/C91xX1FM6s2ubMmUlAZm0sXBEbN/1uDC5/F7rgy2UmZQ5d05bRnLaT/b7isc3HxLr12TLJU7Cz13QjnRb/x7uR3Rv3JTjxD5CIgn0Me7+pGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WawxW78hWFEf+5P42IwA4XFoclES6qh70J3y1InDLU=;
 b=Mae1gSxaHU1lemn9wfhH1+Oy2wfH4sN0pT/JFcmIG4Ur0LvlaDIOMZ2NBBzmNl1HYtQ5E38yO0GghSYps6FcQp+yW/ZAQVzB+nCtCQXvbnwxpFy1tZPhzwncBhnHTHJ9+LXTyxG/KMZxypXkauh9TUiduxr1U+UDxAYQADVp9q6MOUsruQ3afngadbzu+0q0XHFDaMxYFl6ZGug+mknJxgROiXB0MkxpqQFu6fA2tN40+utKt+x2dXZKUHwgQh18oQfaztzqjS2lkUNAPLI7bwMr/Ss0puT3jwiwEfO70CdxvWaxL7cWLKtuIJ6i5OFJpUiI9lOGD5Y3Wjzshha3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WawxW78hWFEf+5P42IwA4XFoclES6qh70J3y1InDLU=;
 b=tRzrYY/vDwLWhGImzFBlyExL/WunaDgJd4JXfbExphNav7+Mi7h1qjx7M7FlTwwa4GcLF2BF+h5no381pCcqBCzkKf6z7D37dCJdEKqF/lm5g5KnIVMoLXMWfFNMzf1Ht6VdXVEb71PrOpqXt7BQ9J32uF+LxwFXxKhsFYLmSd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 07:00:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 07:00:00 +0000
Message-ID: <5c55212f-314c-4158-adec-87fab3a73771@amd.com>
Date: Mon, 12 Aug 2024 12:29:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] ASoC: SOF: amd: Fix for incorrect acp error satus
 register offset
Content-Language: en-US
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 3109384a-3083-4ead-509f-08dcba9c6208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjdEeVVKenU2V2xJa3ZKKzh3L2Nzbkk0VHlnQjZSdjNsYXgyOG1GN3FTTGY0?=
 =?utf-8?B?NFM5WkxxVHdRNVludjdXNWp0TCtYSDFUa1R6MCt0ZGVXZUE1UVZVblMwc25B?=
 =?utf-8?B?M0RXR2NyaVhhSllYeTRNcG1PdzRHLzBsN1VnQ2NkdnVUZVpXY3pXaWt1b3pQ?=
 =?utf-8?B?ZEcvYk5EZ1NFaytjWW5kbGxkVllTY2wzVzEwY3RXdGlTWU5wQ0dOcTlnSWtX?=
 =?utf-8?B?WFRUSkpUbjJEcjJIaWxuSzArU0h4OTJGbGFKckNTeVBxZ0pWTXRWazA0b2hF?=
 =?utf-8?B?UXJYWS83WG14R0dTS09wc015TGFTb1BDRGNsTjMzYStndVRIZjNDd25XNlpm?=
 =?utf-8?B?ekZWUjRpTXRiK2FGWmhjWWJqVzM0Zm5NUmlDQ2lLR0kvZzNPNVFQQnRmbHBW?=
 =?utf-8?B?RSs1V0FUWHhoVnMzMHJraDR2dE9LODkzVTlVZW1FcURyT3gxallYWDZ6NktF?=
 =?utf-8?B?RW4wZ2VpcFFRL1hFMzJsNlRJS2V3ejJLaDdhWmQzMWUwM2RPOHRxeTlJOW8r?=
 =?utf-8?B?K2NRVGlDaHBLN0pWY29QalliSkxVVzdaR2ltY01lUGJYQ292OGQ1Wm43dFZ6?=
 =?utf-8?B?ZUpJVUhCUCtIZXRSSFBBZ0JLZFJ2WTdkYkVLVkJISWdieGxLaTdOeGJ1V0lB?=
 =?utf-8?B?NzJYWEM3cEVvR21DRjhhdVV3MTUxdFB2a2lDRVRpeWJCZ0l1VTJ3Z212ek1N?=
 =?utf-8?B?M1I1VlpVUDg0WldVYnVjWXozdUJIeGdpRHRuV2ZOUTUyUFkrc0RoQzNuOVhI?=
 =?utf-8?B?RStRbmVZZ3ZhNW9lNTR4WWVZc0tQV0dPV2I1S0JvZTVzODdJM3o2dkVMQnlU?=
 =?utf-8?B?cDBWSkwwOUI2Z2ZFdGljMVpBYktSMGYrTkpqMkJYN1VTWHNvNGx1K042Ykl5?=
 =?utf-8?B?dlZMUjA3OFE5OTNsVEY3ZEd4T3ozN1J5aWl3eVh0anZnWWM3UHArWUhPU2Z5?=
 =?utf-8?B?eVgxRDhMbURLZGhPT1dRdWtWbS9WcGJHQ05KTDhvVUIycEFlaEtueHJnVElV?=
 =?utf-8?B?STJFWlZ4QVRwbUoyVkhZNzhDeXMxb0xlb29TSElRaDZQdGRmTmtqQ1VPL3VR?=
 =?utf-8?B?ZlRMWUxOQ3pSazZVUWJ4eFYzK0RzQ0F4U21KdTVLZmUvYmcxUzgrUXBMajAy?=
 =?utf-8?B?NS9nV0plYVpYYWJ2NUFRWWFadjNBWU9tMzZIa1VTWmU3Qmk5UzR1ZVFwTmtK?=
 =?utf-8?B?Rzl3bU8yS3lGMmx1K2M5TzVyc013Mng2VlczaHNCMWFxL1hQWE5ZQ21WV21U?=
 =?utf-8?B?ZVVhU3MvelU1K1U1cjFIV3RXa0tVNGlBZzM1bXF6Qi9SNGdKZThGL2FvTTZV?=
 =?utf-8?B?V0Eyc2I4Qnk3SzdrMTVGVjRmdFhzclRvaWRPVXVBdkR3YkVZOHRrbVBJb2Nw?=
 =?utf-8?B?UFpOSnF0bDRLbEwzVHZOaXB6VVhjSnlNbnF6WmNlMG01T05xZ0dWdWRWcWZZ?=
 =?utf-8?B?OG5NVzZPZm1VcHY1S1BJS3Q0SXdPbGNiUFpQL2x5czR5RzdSYnpGR2h4VEk3?=
 =?utf-8?B?eVE4dWdJa2tNbDNPNm9yN2tNdldDazBPYW9WYWUwNVd4VEpCMk5HYlFFL2FD?=
 =?utf-8?B?U203OE5PRXJmaHo0Qi9MY2RsNEllMkJZTXZGSVEvRVNlTWZoWFNMUHFpOThu?=
 =?utf-8?B?UmJ0OEVHTHhKaFdIRjRLODQvK0Ezcnp6ZGpnWVFZWnhNK1dsQW9nSHgraDVL?=
 =?utf-8?B?a1RZQTliWitaTGVVa0F5aWpkcFJnamQ4NnNPSTZRNVpwamNnTngwbi9kVU0z?=
 =?utf-8?Q?XteABOND4tEwcCqjqmLdqe0Fz8Ji3jV6jo1HkMU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUY0djBlWUlGRDArbm01LzNJaU9pYlBRRHVsRVMvTWJydzByV0Mya2cwUWJO?=
 =?utf-8?B?MnBzQVhNY3VMaHIyaGVzeGc1MjlvRzd5YVRIaURENWx5SGJZZjRmeDc0VUND?=
 =?utf-8?B?a1R5SitvL1E4WHFXanhydWl4N1lqYkRkUCs0cVJ1YUZBejNqSkZaQjZYWlJP?=
 =?utf-8?B?WTllSmc0emFwWjlnWDVPbCtWY2dWVDBxVVUvMS9nWjRqdXdiZTBCSDNSWjFz?=
 =?utf-8?B?R29Kam43WlJzbUVEakMxei9mVm83NnhsZUg2TnFFU1o1bjZVRlM4b1FDSlMx?=
 =?utf-8?B?QUNEM25QRUJxeXN1NVg5eDFYaFhEdXlMRGZQTnIrNXBNdVZZNzBOR2hGM2Nm?=
 =?utf-8?B?QlJhYzB2VXJKRGhoVFNWaVVRTGdDaTArbHlNUXM4TW1wSjlxYTZoYVFmS3hH?=
 =?utf-8?B?TUFCemdMTk1LT05YVWxXR0FKMUxlL2ZucVUxR1FoZXRpcFhTZGx2V2MrTnZy?=
 =?utf-8?B?dlYxcExvZmZLdS9LSS9Za3N1L2JDN0dxcWs3UHVlWU93clhRVjNjbktNSHl3?=
 =?utf-8?B?TEVuSUdDN2NaTWRmREpWT09aWk12TmljYzh6TXVEWVdQL05USG1jZjl3QUh0?=
 =?utf-8?B?M1YvMHpUZm9wV1BnSHJ0ZHMxUzJEaGV0SVRreG1kRXRVeExwcGdpK0h3ajNE?=
 =?utf-8?B?WlpBUnVTRytYdE1DK0I0dTNwV1JlOFRBRkhsakMraHYweFhuZEMzaWJCeDBT?=
 =?utf-8?B?V2pJS3I0dHoybG1iaVJLZmdVbGtCODhmR3NEb1Q2b09IV21TN2FxL3E0c3JT?=
 =?utf-8?B?b0R4cjhlNExLS00rKzdoK3dwNVQ5VG1TdTYxWDRVenhML3ZPazAxdG9qL3lI?=
 =?utf-8?B?OFlySFhJOUtpRW0zVUxTQWVIZUFFZzZRanNtREFUREx6dFoxWEpVcFdPQjN4?=
 =?utf-8?B?TDRCSXRiaUhXUXJDWm45RXdqd09ZNTRGRW9yZ1RqVFZaK05VR3ZVVERjVVcv?=
 =?utf-8?B?M2FuVUozbWpKL0wzMjFROVl4QmNZVUNucFpBeTkrSGpyU1dQYkEwWFY1dzFa?=
 =?utf-8?B?NzJMLzJYZ1JTYU9odzQvUk9jRlBHVnpKRFhCYTVNSmg0YVVBRXNiVHBuNTky?=
 =?utf-8?B?ZG5uaDIwZ3hiZi9kVFdlZWdyL1EvcnVSdGU2Y3NPKzNheFA1L0lsYjYxSEwx?=
 =?utf-8?B?eGRDTVBZVXNLaXZGYTBacXNxRFZpM1ExbE5QZDAzbU5hNERSSFgxNW9tTStJ?=
 =?utf-8?B?Uk1YS20rbHVGRTFHbVljR09kaHZWNDNtanp0WEZwcGlhalJFZkg0Z0JNaGJi?=
 =?utf-8?B?aEtZbUpXcGxBRkh0dzM1eVpSRzVSeEE3OGJTVE41TnhzMm0vaE5DYlMwOEY4?=
 =?utf-8?B?THNSSitXazduU0t2d2xNVXpTank2Yll1NGpzTWxScG1COUtlZEpveC9Wc294?=
 =?utf-8?B?UnhtRENBOEtOSEhLNFpOejQzT1lNWC9xWC92V2Iza0RLanpUN1k0WVVGUlhk?=
 =?utf-8?B?VERDeXZLbWcvWnVIOFh0MDZRb2NQd0xaT2cvbDUvY01NZGpSMytCZTBHOVVy?=
 =?utf-8?B?S3hxMmorMlpvR1hKa3Q1NVZjdElheGlYeHYzbDJWSzM1ZitrNFdGd0J6VnhG?=
 =?utf-8?B?d0Vub3o0OXlOV0FlUHI0YlQ0Kzk3U1pnQjVubTRBR2d5NERDTjR0MDFnV3hv?=
 =?utf-8?B?RkpEcnFDZWRGdkNOTERCMG9jNFp4b2V4QlRXaXljYkVERmZiNGJhVy9qbFk2?=
 =?utf-8?B?VkxQOUFMSENYTVZSN0M4cmRhZVQwaXRoU1N1V1BBaGpLY1BhbldGbldCaWtE?=
 =?utf-8?B?UURNNzhETDVtU1I5LzgzaTFRODFDUE9nUUtueWFwWnB5US9nalJlMjJtbnNj?=
 =?utf-8?B?bW9uR2Z5ZFpaaTJYTGhXRllSd3lGeUUxQUNSNm1VN2VzTkJydDBxOGNYY0hX?=
 =?utf-8?B?Y01UWHUxbWM1ZEs4QkZNdEM2dlc4VWN3aTQ2ZlVIWWYydTUwMUZERlJMQ3BJ?=
 =?utf-8?B?djdoWUtWcjJyb2tpcDlycUtmSWc0RERHTFZBWHN0SnU1Qi9mQ0t0Q1N6YTBo?=
 =?utf-8?B?bHYwOGd4WlBsRm5OQkVIOGhKYnNBd2plRTlMUlVIUDZtemczc1VkY3ZlNHZt?=
 =?utf-8?B?U2w3REdXNzdJN2poR2R2OTBwdUMyM1dzbUlVMk1FbkZqTFlIOHg5VG9IOWFy?=
 =?utf-8?Q?/5yHRvE/OKbIiHO7WMPZiZl5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3109384a-3083-4ead-509f-08dcba9c6208
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 07:00:00.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzZcpFkRPJiBk+sXBdfaN6vsLIxyLM8dpnWQEhi0oNbOJTmG/ukn9Mzvc8x2emN8FQbHWsdAm0LjvdZagDAZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

On 07/08/24 10:43, Vijendar Mukunda wrote:
> Adding 'dsp_intr_base' to ACP error status register offset in irq handler
> points to wrong register offset. ACP error status register offset got
> changed from ACP 6.0 onwards. Add 'acp_error_stat' descriptor field and
> update the value based on the ACP variant.

Please ignore this patch series. Will split out fixes and refactoring
patches (which has patch dependencies) and will send it
separately.
>
> Fixes: 0e44572a28a4 ("ASoC: SOF: amd: Add helper callbacks for ACP's DMA configuration")
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/sof/amd/acp-dsp-offset.h | 3 ++-
>  sound/soc/sof/amd/acp.c            | 5 +++--
>  sound/soc/sof/amd/acp.h            | 1 +
>  sound/soc/sof/amd/pci-acp63.c      | 1 +
>  sound/soc/sof/amd/pci-rmb.c        | 1 +
>  sound/soc/sof/amd/pci-rn.c         | 1 +
>  6 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
> index 59afbe2e0f42..66968efda869 100644
> --- a/sound/soc/sof/amd/acp-dsp-offset.h
> +++ b/sound/soc/sof/amd/acp-dsp-offset.h
> @@ -76,7 +76,8 @@
>  #define DSP_SW_INTR_CNTL_OFFSET			0x0
>  #define DSP_SW_INTR_STAT_OFFSET			0x4
>  #define DSP_SW_INTR_TRIG_OFFSET			0x8
> -#define ACP_ERROR_STATUS			0x18C4
> +#define ACP3X_ERROR_STATUS			0x18C4
> +#define ACP6X_ERROR_STATUS			0x1A4C
>  #define ACP3X_AXI2DAGB_SEM_0			0x1880
>  #define ACP5X_AXI2DAGB_SEM_0			0x1884
>  #define ACP6X_AXI2DAGB_SEM_0			0x1874
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index 7b122656efd1..d0b7d1c54248 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -92,6 +92,7 @@ static int config_dma_channel(struct acp_dev_data *adata, unsigned int ch,
>  			      unsigned int idx, unsigned int dscr_count)
>  {
>  	struct snd_sof_dev *sdev = adata->dev;
> +	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
>  	unsigned int val, status;
>  	int ret;
>  
> @@ -102,7 +103,7 @@ static int config_dma_channel(struct acp_dev_data *adata, unsigned int ch,
>  					    val & (1 << ch), ACP_REG_POLL_INTERVAL,
>  					    ACP_REG_POLL_TIMEOUT_US);
>  	if (ret < 0) {
> -		status = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_ERROR_STATUS);
> +		status = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->acp_error_stat);
>  		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_DMA_ERR_STS_0 + ch * sizeof(u32));
>  
>  		dev_err(sdev->dev, "ACP_DMA_ERR_STS :0x%x ACP_ERROR_STATUS :0x%x\n", val, status);
> @@ -404,7 +405,7 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
>  		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
>  		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_SW0_I2S_ERROR_REASON, 0);
>  		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_SW1_I2S_ERROR_REASON, 0);
> -		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_ERROR_STATUS, 0);
> +		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_error_stat, 0);
>  		irq_flag = 1;
>  	}
>  
> diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
> index ec9170b3f068..6ac853ff6093 100644
> --- a/sound/soc/sof/amd/acp.h
> +++ b/sound/soc/sof/amd/acp.h
> @@ -203,6 +203,7 @@ struct sof_amd_acp_desc {
>  	u32 probe_reg_offset;
>  	u32 reg_start_addr;
>  	u32 reg_end_addr;
> +	u32 acp_error_stat;
>  	u32 sdw_max_link_count;
>  	u64 sdw_acpi_dev_addr;
>  };
> diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
> index 54d42f83ce9e..c3da70549995 100644
> --- a/sound/soc/sof/amd/pci-acp63.c
> +++ b/sound/soc/sof/amd/pci-acp63.c
> @@ -35,6 +35,7 @@ static const struct sof_amd_acp_desc acp63_chip_info = {
>  	.ext_intr_cntl = ACP6X_EXTERNAL_INTR_CNTL,
>  	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
>  	.ext_intr_stat1	= ACP6X_EXT_INTR_STAT1,
> +	.acp_error_stat = ACP6X_ERROR_STATUS,
>  	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
>  	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
>  	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
> diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
> index 4bc30951f8b0..194b7ff37e9e 100644
> --- a/sound/soc/sof/amd/pci-rmb.c
> +++ b/sound/soc/sof/amd/pci-rmb.c
> @@ -33,6 +33,7 @@ static const struct sof_amd_acp_desc rembrandt_chip_info = {
>  	.pgfsm_base	= ACP6X_PGFSM_BASE,
>  	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
>  	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
> +	.acp_error_stat = ACP6X_ERROR_STATUS,
>  	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
>  	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
>  	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
> diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
> index e08875bdfa8b..bff2d979ea6a 100644
> --- a/sound/soc/sof/amd/pci-rn.c
> +++ b/sound/soc/sof/amd/pci-rn.c
> @@ -33,6 +33,7 @@ static const struct sof_amd_acp_desc renoir_chip_info = {
>  	.pgfsm_base	= ACP3X_PGFSM_BASE,
>  	.ext_intr_stat	= ACP3X_EXT_INTR_STAT,
>  	.dsp_intr_base	= ACP3X_DSP_SW_INTR_BASE,
> +	.acp_error_stat = ACP3X_ERROR_STATUS,
>  	.sram_pte_offset = ACP3X_SRAM_PTE_OFFSET,
>  	.hw_semaphore_offset = ACP3X_AXI2DAGB_SEM_0,
>  	.acp_clkmux_sel	= ACP3X_CLKMUX_SEL,


