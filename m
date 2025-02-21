Return-Path: <linux-kernel+bounces-526263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB36A3FC28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01E07AA4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6B211473;
	Fri, 21 Feb 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fak7TRe4"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303B212D6E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156762; cv=fail; b=QCPn2xyujxsYob+0YcUAWp3aaPYS7hBUf/xjALJET/Xg2w17fm7BQRjg/o4JHehdrOI/VGRlXVjeeonTxpG38pr7TpWm3sVSWMYGnjuBKrVVA1qXTwPRz955NzxfuABIRpjV6IbueSH45mACNlaB0k7vivztIb60HbMzlUiP1ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156762; c=relaxed/simple;
	bh=IlKGcU+UYKdaafwVl+vYWgOkFXAz22KzVkWyTej87M4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkQ8yqsDznqePm/dakZNECpNkZbr5SAy8DeOGTiJQuTYpd/5AXobgEGqwnasKUGR6XY7MqRiXlcMiMCrKLVWa1icgHqOUOaZPPioCThMju71pOS0DzuXQFqytvyaC9DCBJqmXZd8h4Akg2dA63iYXDiPcwvFTz/R2meqRlUl8eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fak7TRe4; arc=fail smtp.client-ip=40.107.247.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBo/9N7lOsQ/793Xvt2U1WsGqwD7BB6VRqRM3Oa9/YATyNrQ1FEstcVaf/bmi1Nr5WUWpKMT7QuSF7pjWHU6HHa+8l6Cr296fbgVaLkBbdhqh3BRqxgoLfaomXyPWatVXdTQftUrRfuo2eC8X889tCnTkkVLar2VIrHxZz88oZYsQFKfpTinhGDx8kXiyCkAZ85YCDRzI0232YgPD64mFkvmYveHwvo9/0hXNIO4IK1qSIlo0uRe5MFO4L5fCOw+aNBvlaQnwS7mPz+mVF3yhpTYX8yFriNUzl8ss4vIKye9Qwb4pmt+NvMTKQBZMazJ9tGMyopwt1lF7s3y/uYjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcuzfjvffLIcRwQzIuA75Kttwgh4KIEN4MUjTnKwqeM=;
 b=U6na64IWeqT6J1K//wv4Wr80L10mAFDHTdtj3LQCTSn87Gm6o7CRwk6VLQ00rcO/u1QC579YxbWW21kOgC3nJN3oTP5IzoDj6GDPsqwpd5u7OEkcxgsUlvQ9e2q6NG8CxnJ7eSn2qhVduHxl+QeyUNHtU3iHt+rHzbP6oBbqJnn6Tyti/cjRUsl+bC8q7uz1SX9wK1ptkT7LkYNTGqKtWrMS5ulo9Vx7E6i6VnA5mdz7/jkv3tRIa8DHVXbLTcdj1ujPEAoZww2JWaD/bi4U2BaY5XlyXuxuWAD3IvQ1LD713u3nbQ6p9BS9+zQHgiIoGCK/i7DNSjySvyGafb4GbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcuzfjvffLIcRwQzIuA75Kttwgh4KIEN4MUjTnKwqeM=;
 b=fak7TRe4Wgo7Ym5Zu/2Udv6KPTFCDKmWAMdIaUU6he/Lbn3SVkczoEIK0EPVXnOxeQqLocIhJ25MQDfb3mrL4bVBKZFSM0dmbpSnCRsS9VRMZlqBBwu01CbGMPE7qYwuCdDbtpfXrcZ5OcYrK7wRlsyQSQp7JypKfksLMRwyEkDz4KqJCWZFqrPKxPBHt20IxcAGvhtZZYSc1KmNasfx+8YgLAvEL6AT7EC+qCygwqAjQ2EfbLVQxvyTjdc5sryESXgJ3xGiVBTZ3xktFSWVnRRqPW57zToq5y+xxOlDVEfSG8u9YdRDRv4xbqKmlUB1xftAoYLqY6VueRpvvgMQKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:52:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:52:38 +0000
Message-ID: <7d00d9cb-6860-446c-9eb2-a908c9f7b15c@siemens.com>
Date: Fri, 21 Feb 2025 17:52:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/gdb/linux/symbols.py: address changes to
 module_sect_attrs
To: Antonio Quartulli <antonio@mandelbit.com>, kbingham@kernel.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
References: <8e16609a-7e19-4d4a-951f-58c8bd012086@siemens.com>
 <20250221130304.5882-1-antonio@mandelbit.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250221130304.5882-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e47a899-c7a2-47cb-2a02-08dd529825e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFVXRXB5OVExT1cvVFhDUDAwNUFDRHJmTm9kaWx2VUlyMVh2UXNLeUJzUVp6?=
 =?utf-8?B?bzRuOW8rSldJQXEzYjdRMnlIcG9ZQlhoc2pibUZ1SVJ2Y0hJalNKdlEwS2JB?=
 =?utf-8?B?R2ZGazk0ZWpvbW5INjI5T3Q1d0FIUDJyQWxXYVI2MUNMZWYzY3U1QTF6b00y?=
 =?utf-8?B?cHdYcjhUTE04UGg5dmhrc0ZGS3pPV0V0OVUyUFVJeG1DTXJOK3JJbHpaY1RV?=
 =?utf-8?B?T1llQlFYeVh0T3hueDNNcDE2VWdDSFZaRGlGa0h3a0Q4K1pGWFlpdFNLZkRO?=
 =?utf-8?B?aWVMcTR3MTd5S0Ixa0tQTnZINU83ak1XY3A1VVlFS3BvU2Q0aFlKcThsNVNu?=
 =?utf-8?B?d3BxVU9RYlh0c3FRbHlkSklTL3FJeUsxSnkwVDdubFdTRHN1Rm1iOTZsYmVs?=
 =?utf-8?B?RWUxejYyWUwrM0k0SkY2Y0F5NWs0WWZQNHFrZkRHVzFodTJEWFNpenEwQjhM?=
 =?utf-8?B?SW44Y2lJOEhnSTVMbjllalE3QjVXd2NpbHNZd0wva09iU3l1Vy8yMXBpMkNk?=
 =?utf-8?B?Q3o0MnR5ZDNnL3E3c0hlSDQxWjJDQVpDcGlEckU0VmdQcFIyM0s3K0Z6c1VW?=
 =?utf-8?B?OGRtZnVMYWFrSHN5Nm9QSVRja0xkTXpkVzcxSGtGcTFybnVzU1N4L29DUUtG?=
 =?utf-8?B?akxyaHh0TFhXWDdZQktuU0tjTFV6SHhJSDNlaHNyZXo1emY5U215andaTXV5?=
 =?utf-8?B?dkFXOWRJWTFQUGFrVTBrdVlMOGtuaWJvUnhCcHF1c25Zd1YrTHpZaEh5M1da?=
 =?utf-8?B?MmxHbXM2QkFQWXJnQ2JJNmhhS1JJS0VZSHRuR0VxdWNBeVZoVkFQTEgxbUhC?=
 =?utf-8?B?bmdVT0l2ZGlCemM3UDRnZXZZd2dIcDdDRy92T2NuZ2Z2eHE0VzJQKzloQmhs?=
 =?utf-8?B?bGd4dHhwRmZxZ1l3L1gwWlRLYmU1K1Z0SGVkTkMraU9DWlcvVnNuQmJMQmF2?=
 =?utf-8?B?UWN3dFRHMDBicjVTSitva1RaQUgrMmtyeExQK09jeXNjNUEwWUNzN28vUnps?=
 =?utf-8?B?bExTYWJRQ3NRamdTL0RGdm4rakVkWXR1MUdOek1uQ3ZmUVRhNlk2UzdMVE5v?=
 =?utf-8?B?a2QzODNGbW5JYlIvbjVoYlFoKzIvYkphTE1hVjh3WWcvcmxtbUk0djl1aGRn?=
 =?utf-8?B?Q3AyK2hlWWs4WllnSXJ4VWhMY1owb1Irai82TFZRNWxkVjY0cHNaSGtkSk91?=
 =?utf-8?B?ekE2RStqS0NxaHJGcWxyZ2FodkY1cnZ5RWF1YWRreFA3ZDcxYVhURVVvUkJ3?=
 =?utf-8?B?ZEl2aWNMS0tpcWhKN2ErOHhENkhIZUd3YTJsdmM1Z09aTi9OOUh3NElWdGRU?=
 =?utf-8?B?c3B5blM1dUJpYjBKQnVKSURzcHhrb1JIQTdrd3RyWiszelRSUXBUODN3bEwv?=
 =?utf-8?B?eFNBQ0dpTURpa1dQdnhQeFhxK2FFdzN3a082TEtEOGZxdW8wanpKell1bnJ1?=
 =?utf-8?B?SUNOSWs2TzgyTkJTUU54NzNzL1hUNU9xbUcyZ2JiM1JNUmtzbWpzdXBGcFZy?=
 =?utf-8?B?b2QxU0N1eXZoK0czZTFFaUlWdTJwNDNaemw0VzZJUUZIb1dTZnhadWpIalNp?=
 =?utf-8?B?K29ZRXZwM3JyMmpIajZZV00xOGZzbWwyU2dUU1hCYWZMbGZ4a1hhMm85SjNa?=
 =?utf-8?B?R3FHS25zZCt0Q3VRZFpkQWVkbWxiekR0N3BTR0t3QkhQNmlTQ3BxSUVnSVRD?=
 =?utf-8?B?RTExSlhSS21qUDhGTGlFbmV1SHk2UFAvZHlhaVBET0EremQ0bmZJNk52eEJ6?=
 =?utf-8?B?NkdhdGJveVEvZnhiVm54cXVXU0FCamFmeXlDbG5ocmwybnd1Skpma2F3cUY5?=
 =?utf-8?B?N1RvaUR1WWxONDgwNC9XRDVHTllSTUtIcVlmWDVTNFFrMGMwaXcwR0lnYUho?=
 =?utf-8?Q?LixF2NiraVGo+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVliVCtUcUF6ZEJTYkZQNWNqWWtsRjdBdFltT1VTU3lEajFlL1FscFVoTCt1?=
 =?utf-8?B?d2lUbjBCTC9ncnQ5bWJZUmtRaUhWcjNZTFArcjJkQ2FoMFRUMktndVVwNXM5?=
 =?utf-8?B?NEhNTFlKUGVUV1k5MklHeE40RTAyK0VsVVZQYVVCSnliZUxZUDlZTy93VTBx?=
 =?utf-8?B?bUw4THZUdVZzejhUQXAwYWRVUWtFODBXb29vUjgrdFBhSDExRnlDTndkRllH?=
 =?utf-8?B?ZUhwTzIzZktRVU5idWpEcjMrbG5FMVVGL2hob3lDNHIvcmxsdUJFMkhYcG9D?=
 =?utf-8?B?djJyREVUbzVZbGEremE5U1VQaU9wTUcrNk9lMkhTMU13ekd1L21aeHM0clgx?=
 =?utf-8?B?UFl2T1A5WkF4RnBBVmRRL0Nqek55emFJOFVmU01vNjgzWEFCb3k5emgrMDJ3?=
 =?utf-8?B?Vjk2MHoxRWd5V1FBN1NoQW01VzRWYjJ5cVdHM3F5bC9TbURFR3JaU3F4VEk2?=
 =?utf-8?B?Zks3VklOUmdyVXlMUmNaN0wvVUM0WU1FSVBLNWljQ2pTbnZMaFhuOWFKOFZX?=
 =?utf-8?B?RW5vR1Nod1Fia3BTRlEwZWZ5eno0ZEt5Y0tscXdJMmtPM2dPdCt2SW9CYUtU?=
 =?utf-8?B?WmhWWnA3djJ6WHlvb3hzSzBPSE8yaFVobVNIMmEyVUlvT3BxMXdKSkE5NzJW?=
 =?utf-8?B?QUpZelFyS21INVFIMXhGdnhueng2ZkdkZHZWV2pvaDUxNlFQakxYelQ3cEE4?=
 =?utf-8?B?UDRuL2loZFJjdFdCZFMvYnlVdzhFVDdoc2kyc3VySy9HZDNLOHRpNnRvSVgw?=
 =?utf-8?B?bUI2dWtTU1IyQkE0RTlQM0tocElWSUNtL0tVZ2wrbXU0ci9SOWtDck1uM0N5?=
 =?utf-8?B?aFpsc2QybXA1YmlJdmFhcDd3czhzTjY0L3VNdUthMHpMMlp4dlo4bldUeGtI?=
 =?utf-8?B?Zm9lN1VPVGJMTUI5RFpRdnZ1amE2MHNlOHVuMUxTVjJDUUVuRjBxcGc0MjBn?=
 =?utf-8?B?UXJmN3NCM3dYNnRlRkJwYVp3MTVJRWVqbFRXUVh1Q095NU82SkcvNm93K3o3?=
 =?utf-8?B?NmNqZjQ4V2RLMUxWRDhmT0M2TXRUamZTNWxjamxVMEQyRzdReUlaR1pIMzB4?=
 =?utf-8?B?V01OSlJ0ZkZlamYxTW5oL0phSGRLZWdMdHppcHRNNXRCMEZXWXN6Q0ttR1ZD?=
 =?utf-8?B?S0tjTU9zaWNXYXhSQ3RLM1hzVFEyR203ZFI3YWRabXhIdEJnY0U3YlFURXhM?=
 =?utf-8?B?bXRoM2N1RTY3KzhwZVNVTnBYbkYwTTVHaEtQbXI5RUt6aWFXS0l1NEkweFYr?=
 =?utf-8?B?TVZGSzFPbTFDU0hmK0cvclkxb3pRM0VsWDNST2VmR245bHVJUHlNWUlsN1pz?=
 =?utf-8?B?bWE1b2VMbnp1QlJuU0lIMVU5OFZaMjVoam5vRFV1UXRxbGNrV2tLMlhTQ0lN?=
 =?utf-8?B?L3RsbUpZbWREQTZzVzZPTmFBOHJoVS81UFdhZGt0SlZnaFRodTJsczNPYUNR?=
 =?utf-8?B?MHJvSm5yNzFZZFVpMHJlTm9CeGZsWU5RVE9ZcmpWdmw5NmVnWHEzdmNSQmN4?=
 =?utf-8?B?aTBObERNQm9TUU8wZ243SkZFY2QxMVlrZFVRVDNPc1JLd1VnWEhmUFFlTzhm?=
 =?utf-8?B?N1phNG9KUjlMU1h1bi9SbnFYUnNTWjR1TVZZSkhqQlNva2Q2bndJcVNINEgx?=
 =?utf-8?B?OVB4WWd6dm9CS0xtUzYzYlM4cmxtN1hnL01QNUM3MlhsY09SMEc3QzdLU3NL?=
 =?utf-8?B?VmZ4YUxoNnByS3JLdHJRR0FxMFFYWVJyQi9LR2tPdjhxWExmcm9DT3p5MmlH?=
 =?utf-8?B?T0t1K0VWUjVPOUhteGY5V2xDTWExWmZrRC9rem1IWUp0RmMxOUpuZk1SUXpC?=
 =?utf-8?B?Zkd4TkJRWWFjKzFSYkVXWThoekJBNmFLd1pPSFFhSFR3VUZMUmxxNW91UU9J?=
 =?utf-8?B?MStiUmplNXA4SFh3VU94SjcwVkhMdHAwaDNweHVOOXpnU3g5cmxKMzJkOG9N?=
 =?utf-8?B?a250bzNMRmhUdDdIUVVEUEZ5K1pzVERCMkJoSEVYMlVBbEk0b0htMUYzOUEw?=
 =?utf-8?B?amRGQ3hSNThvYVl5bW5EMjZiSUhMYis4UkNVbVZRbTJDQUpTWnlNMmdzVm9T?=
 =?utf-8?B?ZjVQQU80RElzWG02RVE5Q29mYldpUXg2TEREbHAyUXZaZDY3Vmw2VXdGWklP?=
 =?utf-8?B?WEVSZ3lSTUFuK2ZQc2xhUGdBb0FYSnZjN1EyNHhzVzltaUgwN1BLWi9OQkVj?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e47a899-c7a2-47cb-2a02-08dd529825e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:52:38.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BRa2loZkkNAqNN1qBKxnWfNoTW3DG4EGYfy30qFCctaMpwnBFDWdv8kDKfVobFv1v735QhTvIo9iP5nYFYFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5748

On 21.02.25 14:03, Antonio Quartulli wrote:
> When loading symbols from kernel modules we used to iterate
> from 0 to module_sect_attrs::nsections, in order to
> retrieve their name and address.
> 
> However module_sect_attrs::nsections has been removed from
> the struct by a previous commit.
> 
> Re-arrange the iteration by accessing all items in
> module_sect_attrs::grp::bin_attrs[] until NULL is found
> (it's a NULL terminated array).
> 
> At the same time the symbol address cannot be extracted
> from module_sect_attrs::attrs[]::address anymore because
> it has also been deleted. Fetch it from
> module_sect_attrs::grp::bin_attrs[]::private as described
> in 4b2c11e4aaf7.
> 
> Fixes: d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")
> Fixes: 4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>  scripts/gdb/linux/symbols.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f6c1b063775a..610a3dd3c7b4 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -15,6 +15,7 @@ import gdb
>  import os
>  import re
>  
> +from itertools import count
>  from linux import modules, utils, constants
>  
>  
> @@ -95,10 +96,14 @@ lx-symbols command."""
>          except gdb.error:
>              return str(module_addr)
>  
> -        attrs = sect_attrs['attrs']
> -        section_name_to_address = {
> -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> -            for n in range(int(sect_attrs['nsections']))}
> +        section_name_to_address = {}
> +        for i in count():
> +            # this is a NULL terminated array
> +            if sect_attrs['grp']['bin_attrs'][i] == 0x0:
> +                break
> +
> +            attr = sect_attrs['grp']['bin_attrs'][i].dereference()
> +            section_name_to_address[attr['attr']['name']] = attr['private']

You dropped that .string() from the name - I don't remember the details
anymore but we have it all around when picking up strings from C
structures. Was there a particular reason to do that?

>  
>          textaddr = section_name_to_address.get(".text", module_addr)
>          args = []

Thanks for picking up this task so quickly!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

