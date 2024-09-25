Return-Path: <linux-kernel+bounces-338100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC08A985356
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C4284FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5A156237;
	Wed, 25 Sep 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v6rGPC7q"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EF147C86;
	Wed, 25 Sep 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247563; cv=fail; b=N/iHBmrhrpsarYQmTMq9xzhve0JrZShYx9TQCQvv3uDId0AEVymOjpTbKDmy4KtUAEvCxqFEdubXLS/2eLgkylkBfoEnePcbOYQw7U77aZ8WU4YHhrefg2azksKV0oOSEfULMRNqaZitsZ+UWg+Po6HWv5DQZcJIKhcy9fuEHjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247563; c=relaxed/simple;
	bh=EwgKfIHrmc+dPE/NbU9bRKQ6XBJuqBBgmUZzd5F8Owg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGgh+DsQEfqSpQQDQ6GPpIlfClF3XD1QvOmFY8Z3YSB6mzkGjEe3M1sfDq0U4xid8YUUuCiqpBZIcnAdoifUa+D+dN3siXgqbwz/FyvFGuihZuTXxfWIRSmMO/jiy7I2YQHdXMo3EJFPwqxkWg2hjKGa0sLSWnywUc0mKyThqOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v6rGPC7q; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj7KaYB+RzEah12366q7dDrcJjpJ8wpno9aQVSagC7pN1O81HPWmTDKsGujnUjpFyl9JfyAbG7UgrJGPY/JD1ZusO+QjW/R+Ne7+4KStnhfWkKNEp3GUGoSXc57CpYqATt6sHLxhGPxB31oWBGFT7PzY521ExXXt/5ScTRo//FYMq8xi05KBuMK+vAUA/ABocCvwiy1SOu26YKr+cgXh5tkmtI3PGx4F9DW0i3jf/cMqs5xP6QcnDlU6AF26Kdw6sj96txgSGWgp4aE/OQRPlsEM4c8mYHkd6Oe7kM/8qW1tY1YFvGs2UKmfmRvzN3SdpGpmMlhpr2Pbq26OHU6wIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1E7pXJ4Um9Xs1JgRd0CvK7HX2aq6pPtJL3XyF9Ng9A=;
 b=xsjzutWxUswC9Hurw0inO7lNwx2wAWMEVVEBy4DV8KdTrjYpDFDZuncibiNYlLKflK/5zNs1mm50/dTzat5Xb4yVXHO52+vxEeGxDgsbDcf7dKgfdUzudykrGdcP3blZySUumHnRdklW8ZLhjJXgrzhfMiYMrB1Jc4Ikg//prqVUsbYNKaFyqMvTVNDSuWF+Fbb0ovPm3IRbKoy+MjRtfL8a5JoYo7nQA4ImPA1byXTjRKAf9pwocvJa75XSMsyD3DjLEyi8PYLOSdqHIpZzPmML0CooU1vhsuaCplFeEebPBFfXJB/43Y8yadChh6A1jcxXzP7E/L7OOeA0/mORtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1E7pXJ4Um9Xs1JgRd0CvK7HX2aq6pPtJL3XyF9Ng9A=;
 b=v6rGPC7qXr2QhkETlfXmZ3zDv8RYLkMdPB6F5YjJ7AM/zsh9JgSozJdGb3GKmeNK5DqwQE3/BuKp4AuACgWHYcE+pGj/7z9GdBCGHWZpRmMShSu3VcX4eIV/JWu72K12lP2nwH2qqBKMIDV0Yzjt9F8C82KQf448/RGW18yvvw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 06:59:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:59:17 +0000
Message-ID: <4da1353f-1209-43ba-930e-7b4f4a0cb2eb@amd.com>
Date: Wed, 25 Sep 2024 08:59:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: misc: onboard_usb_dev: introduce new config symbol
 for usb5744 SMBus support
To: Greg KH <gregkh@linuxfoundation.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: mka@chromium.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, wentong.wu@intel.com, oneukum@suse.com,
 javier.carrasco@wolfvision.net, matthias@kaehlcke.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, git@amd.com
References: <1727187551-3772897-1-git-send-email-radhey.shyam.pandey@amd.com>
 <2024092551-fiddle-flatterer-e643@gregkh>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2024092551-fiddle-flatterer-e643@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:802:2::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a1a539-13f2-4134-a31c-08dcdd2f924f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWl6MzN5WU5RY3Z4WFN1SnpxcHZJOGhhUXluRjQ5T3V6T2lQd2R5UEtYTlB4?=
 =?utf-8?B?blAvM2N1NW8rN29GL0cxU2xtdVltdXRUVHBsRlR4QUk3bW1MdXZUZ3JrVWtB?=
 =?utf-8?B?dERPTWh1a1Y0RVozTmIyd1Y0ai9Cdy9Wa1VLTUhWM25BbTlFcGN1WGVrbndk?=
 =?utf-8?B?bG5SN25ENFJEN05CaVpVYmpLY1JlOWdEZ2dRNHhlMkcvWitZN1ViMmxjKzMw?=
 =?utf-8?B?S3Y1b0xXWnJPT013K0l6dHExbjVZVUZFbWxOUEowVjZydVdFWjJ1M0thY3Rn?=
 =?utf-8?B?N2JpNWo1ZVJ2eUpna3pQc1FKRTNsb2FEU045aUFMaURIUWxvSU1nVDJ0TW1I?=
 =?utf-8?B?bmxhMEl1M2VBNEM3NUd1Znl3aDdiU0FKdWFkMGMzQ0kvWHZlc0l0SEhtbXlQ?=
 =?utf-8?B?QisrR2tualBxYis2WmpXNDdVNlR0ZjBZa0ErNVk5NWxMWk9BMlQwVnZPY0NT?=
 =?utf-8?B?akpLK1JtazZ3bWozQ3RuSVM5UUZWaldpQUNTZTI5YzFmM1krNTBVTm9CT1RG?=
 =?utf-8?B?RzdLaDIrQ1RZUUtSMjFLaTEwWGRESUwySVIvWDlIY1pqRnFVOW9NYlpMc2lu?=
 =?utf-8?B?U0FON1d1Mm5jTlpTRDNjUE5wMWhjRHBSblhhUGNrMzRta2ZDSitQTHBaaDc3?=
 =?utf-8?B?ZjlCN1c0K1JLMUJyVDVWR2RIUEdtN2RVdk9NbUVIMDdRcUMyaXFVRzc1ZGhY?=
 =?utf-8?B?MitmaGVBR1FrOXdyQm1FUzdaa1c5QTAyeGgvY0pmckFmbndKdFdJYThxR2tv?=
 =?utf-8?B?bno2R3JqeXFwNmFvSXdiZldRT3FacjhsckVsSFBoeDQvdW9Qd2JVcGpGZTBy?=
 =?utf-8?B?RGhnVWxFUlpJWkhJeml3U2FmUEd4QTZYQnNGcDVGWTgvSXRNM1RYOWtPSEZm?=
 =?utf-8?B?MFpVU1dOK1pUTE0xYTBYbjNTM1RpbktnREJMeVp5TEVFQmpLOVpCUGZ1YjJD?=
 =?utf-8?B?ZDBnN1I4UWdNMmJRbkVoRVpGVWFrdUppRVZmRGhVbW9nSFRWVThsZ1NMMVp2?=
 =?utf-8?B?a0dwZjlBWDMvV3BXSmlEMmFqUWpWUnc4L3VpZlp2c0x2MHAvUHFvYkV1MXVq?=
 =?utf-8?B?WjdUbERhL1B1V2Jyc0trOEl4dWdCM3FWZEd2WFJPTEVyaERpc293TXVCUTNx?=
 =?utf-8?B?MTB3c0N2ZjQ5eG8rMlpXUm1lUS80OVlZdy8vK0NXYjNyWWQwbW9zTXQwWjhv?=
 =?utf-8?B?UU1wVkJxdVBTSmF0VmJWaE91WXlXNC9INXQ1aS82TDVIL2FEUlExbTZOQUN4?=
 =?utf-8?B?dXhBWGwzZDRPRkFnd0VXWjA1YUtqWVZpNjkxRm54SjBYcmY2SjRLN012Nzhq?=
 =?utf-8?B?VnJkU1AxenZRM3hCRmlhVWFpVWZWUkI1UXRJWXJHMkx5QTdha3dnM2pLWjhq?=
 =?utf-8?B?RGZvaHlYcUJSQTZiZk9lVXZTWUdoOGZQK0M4MzhaOUM5b0d2a0pVWTZwQmpR?=
 =?utf-8?B?SXFHUjMvQXN1TDFIb0xrdmxiT1J3NjQ3eHJLN0FsYVY2VzF6T1dxWXpJOWFM?=
 =?utf-8?B?bXZRWjUzWnZTTXdHOUh1MDZ5MkhGZmxVWnhyV1FydUhXNCttQnZnTzFOZzhB?=
 =?utf-8?B?RVkveWF2TjVKaDdWYnZqN3NLTTU4L0JKOUtWazhpSzJPVFJSVmJwY0NvU1Zi?=
 =?utf-8?B?NzlFdW85bVduRFFIbUU1d3ZGY2tKY3l4VStlZWVJR3J6emdKSVBPUXluOSt5?=
 =?utf-8?B?SUVyVHc3aVI5Y2R1YW9odE92V2lQd01kdmswWi9wSWI4bCtJRjBLOHVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWwwM0k5RXc4ZnoxcWU0STBKSEFQcjk0YmlqTXYramZKNVpEemlIbm9ralZU?=
 =?utf-8?B?V1hLcEVvR29BWW5kUGhjRXMrZFpvZW5tU2M3SnhBRU9peG9FRWNvYzNMbHc4?=
 =?utf-8?B?NXRRRWE1M2w4K3J2ZFp5bmFsVW5Pc3ZaZm8vMnJZc0pBZVVOVkcrOHhtL1RN?=
 =?utf-8?B?VXZyRS9BSlFQRUhVSUNHNWlabldNcWcraGJ1ZFBZM3RmUGNuVzF1QlJkdlYr?=
 =?utf-8?B?YnoyRVEzakhOb1ZEaVRyRTBQV3FRSHBLWG1TWStYMEJPNDRmbUo1SDZpSjY4?=
 =?utf-8?B?VFNkbWQ1ajlseVNaeGJhR2I4S2E5cnVvNW9OOVFFVUw0c1B6ZW8rMHNROENp?=
 =?utf-8?B?eUFHZUFoQ2pSL3NGd0RQY2NLNFE3WUJwUmpUeS94aTl6aHFKM1hxK1h1NmNa?=
 =?utf-8?B?UmdXQXhsUDdkSitJVUZzU3diUExMSzRQOUVpMDk3TWltNWd0dHZoRHNmbkh6?=
 =?utf-8?B?Tk9vQUljYW5TQWV0S3ZkOVhrUGxiNWNqdkdKOC9kb1I5R2NKdlNYYzJmM1NY?=
 =?utf-8?B?My9oZ3RacmNFWWpUUm81QSsrRmhLZ0JrbWdhQ2YrRDBYS1lwbGhSbHlQMkNo?=
 =?utf-8?B?ZXY4TDlMVDVWQ0wxTG5oQzVtem9SMS9iZk5nd0M2RGJEeEN5dGRrMERia01x?=
 =?utf-8?B?QmYvUWRodUc0Z2d4RFJ2ZldoQlFVamwwWHlISnNvR1FZa3pNNUE1MjBaWGVZ?=
 =?utf-8?B?dHJLbnNPRHJzYWlNSWRQanY5d3pxa2tEQk1wN21UTmsxN3AzNWdZNWE0L3Bu?=
 =?utf-8?B?U0hDN3JFOEk1ampCSCt3aFE4NTBoVTd1RGtMemFXaGpHV3FqcVB5eEZOVU1v?=
 =?utf-8?B?QTY5cHIwYVBOUU55VkFtT0JqRERzQ1EwN1dLeVJoY0N6QURUV2plWkE3Tnky?=
 =?utf-8?B?bjlPZWxGSVhDS1p0MkJtTlIwamJ6Qjk3cXBXNTVTcnZTWm5LY0d6RjBTaGRI?=
 =?utf-8?B?L0ZlQWFlQWFLN0wvYVQvZFgyRnhmeVNkWUNieEN5YzJaakNjd3RSeW1ZTVFo?=
 =?utf-8?B?R29YUmQ5eW1kVUhoWE1EY3p2a2tVT2FhSlZsTVFrcjh1K2ErREdvdWE3SVRq?=
 =?utf-8?B?OTlPeXVPY1g4aDRBMmxZcVRhVXFWb1JscFZhbVV5b2o1US9VbXViYkR5bm9T?=
 =?utf-8?B?RzBVaUh4OTl6SEdIcU9Wd2hZMHp2WmpzZWl2c1NKSzV6akIvSmZxVlBuSi9u?=
 =?utf-8?B?cEt1Q0pOaFdiMGtHRkIvOEo1eWdCTEs3RkxFL2FKaUtkSldOcnRXUXNLblhT?=
 =?utf-8?B?ZysxRnQwcFF3Y2hyT25UY29pczNPOC81bHR0c3cwNXFUdjdaanZONWxzL2xJ?=
 =?utf-8?B?NnJxUlM3c2ZlUUtVN0RNNlJjYVgxZGx2ZW05RVhVK3FvNkloUEVZempuTnpE?=
 =?utf-8?B?UE9DbEF5TnpWb1pvc0N5L2lKeWNuWTN6YkNESytYZUpIWENrazYrZU1GbnEy?=
 =?utf-8?B?VlZmbFgzOUo4SC9Xd21jSm9YRWZ5SVJRNFVDZFdBY3g3b2hzZU1LNnRwV0ZL?=
 =?utf-8?B?NVVrM0JKbm9Oblh2UHVVOU9JNU9ySVMzbHpwaklQNWNSV25HcmdqbVB1RVNG?=
 =?utf-8?B?OEhGZEZxay9ibFpoL2tzcG8wSVQ5Znl3ajhzN2RuNjQySzdhZVJHY2E5UjFJ?=
 =?utf-8?B?YnU3YkE4RnA2aUQ4bDVtYkNIeFFKUTZCYzRnRmVmRDc3eVdOZHdJUDUwK2lr?=
 =?utf-8?B?a2ppbUNRTXp5MFk3WTlwOGo2STgyZHE1M1R3TEJnWU5lQm1TVHNOZFozek9j?=
 =?utf-8?B?V2xOVk5NcVFnT0xjRW1YNEtMV0Q2M0xWU0FHQWlZYUE4NlFPS08zR3lKcGox?=
 =?utf-8?B?dXo4ZWRVTWFjN014M0JLWTMrWDc0TUs2WStEbk5rU3M5cjFramsrd0doV0dr?=
 =?utf-8?B?dEI2eFRyeGwzeXUvQXIraTR0VWQrOCtxdTc1UkNKeE1UMWdxNUJZTTNOYVYx?=
 =?utf-8?B?djQ5ZHhiNlJrSUVDN0VZVFZqTWYzc29hRzFpOS93K1RRbHNYUUxIazBWUnA5?=
 =?utf-8?B?NHhRMVFyZTFWdll3YlpWTFFlUUdYeGQzVzFsR2lYd210ZG9xbkVYR0JHMFIw?=
 =?utf-8?B?TVIwTlJOZGpNanVMWWxtb1BPeFl3MXNiQTZrZDJEWnJGWUE2M0djREhOZlBp?=
 =?utf-8?Q?73lhzzWF11KpjzPdVG8WH5WKN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a1a539-13f2-4134-a31c-08dcdd2f924f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 06:59:17.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HSq3v0CWC60eLJAh24K92Aexbdw61TrjBF7AAOW+SBHNcrZ/g5J0QhZMGhAGVRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430



On 9/25/24 08:33, Greg KH wrote:
> On Tue, Sep 24, 2024 at 07:49:11PM +0530, Radhey Shyam Pandey wrote:
>> Introduce new kernel config symbol for Microchip usb5744 SMBus programming
>> support. Since usb5744 i2c initialization routine uses i2c SMBus APIs these
>> APIs should only be invoked when kernel has I2C support. This new kernel
>> config describes the dependency on I2C kernel support and fix the below
>> build issues when USB_ONBOARD_DEV=y and CONFIG_I2C=m.
>>
>> riscv64-linux-ld: drivers/usb/misc/onboard_usb_dev.o:
>> undefined reference to `i2c_find_device_by_fwnode'
>> drivers/usb/misc/onboard_usb_dev.c:408:(.text+0xb24): undefined
>> reference to `i2c_smbus_write_block_data'
>> <snip>
>>
>> Parsing of the i2c-bus bus handle is not put under usb5744 kernel config
>> check as the intention is to report an error when DT is configured for
>> usb5744 SMBus support and kernel has USB_ONBOARD_DEV_USB5744 disabled.
>>
>> Fixes: 6782311d04df ("usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support")
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> Suggested-by: Matthias Kaehlcke <matthias@kaehlcke.net>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202409140539.3Axwv38m-lkp@intel.com/
>> ---
>>   drivers/usb/misc/Kconfig           | 11 +++++++++++
>>   drivers/usb/misc/onboard_usb_dev.c |  6 ++++--
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
>> index 50b86d531701..29976a93f122 100644
>> --- a/drivers/usb/misc/Kconfig
>> +++ b/drivers/usb/misc/Kconfig
>> @@ -331,3 +331,14 @@ config USB_ONBOARD_DEV
>>   	  this config will enable the driver and it will automatically
>>   	  match the state of the USB subsystem. If this driver is a
>>   	  module it will be called onboard_usb_dev.
>> +
>> +config USB_ONBOARD_DEV_USB5744
>> +	bool "Onboard USB Microchip usb5744 hub with SMBus support"
>> +	depends on (USB_ONBOARD_DEV && I2C=y) || (USB_ONBOARD_DEV=m && I2C=m)
>> +	default y
> 
> "default y" is if you can not boot without this option enabled for all
> Linux systems.  I doubt that is the case here :(

Intention is to have it enabled when USB_ONBOARD_DEV is enabled with all other 
conditions. In our case where our HW guys started to use this usb hub with 
usb-sd convertor where rootfs is on it. Without usb hub initialization via i2c 
we are not able to boot our system.

Thanks,
Michal

