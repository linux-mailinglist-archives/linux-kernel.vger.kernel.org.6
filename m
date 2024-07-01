Return-Path: <linux-kernel+bounces-236140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859991DDF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DFE1C22594
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8391143C4E;
	Mon,  1 Jul 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="FY3kV6Bg"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5B142624;
	Mon,  1 Jul 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833516; cv=fail; b=Ipq/Madysi8T/bfIJQpWbtUdyiojh4CVJKcmVVHGExvnZQUTaTbyv4to9GBIX2JBl72kM4s+0h3N8J3GC9gpuYJTuYB3n1OLGIpgW04A2IZp6Ns3B750y18DUU0TW2aHTjoEsni+MZX/9DDH9UhcLK5XjXQ9AJoU/nBQsg8OMu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833516; c=relaxed/simple;
	bh=JwikA3w84goCO6CXS6W0D03ykBrZPLHLgNfkEqZNB+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NFBtiiJL2/udg+wLgpeljlAPvISkq5hfqOHVNM2XYFOF2oVCkPYWmZ9BNrfjPAq04pwJtackibk/qsckGoZUrC/DPlkWdzFMupMo/bxU5OJBP/gfgmYEc/BQba/6sM2GE+W2g7DS1ym1shBE2mzg+qsa00hnChrmPXeYer1nu4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=FY3kV6Bg; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtBg9g1uL0o7K/kW249DIqy7nJ1GW4m2PMzhdMK4d5c0YOKf7KwniYGaWX481qpEup9IZk1G1mxkAU8K8Shl2rd5cZ507Rk6MMk6idqZpPJE8aKRFc9Hr9O5FqbWKt/W9BOoqcrFO0sXn+5HN4MBPNrUPrKvABhZBtMJBflU/tdWuPO9mXGE5qZIqUast8OfiNl1tIx8gD7AMMt3y9rSxVn/+YrT26MYDIntF4c8ce1f/qrgUnymtmulUEOLXwU/6K0KH5iXsLxSpAzuLhCHZRFjWl4TpDivI33WYDOpDXSRoQGoTTQD0IyOG1nf2zDjD8x4GAEzeIYwNLYF+Yqkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC3QV/QUbrPO9a4yIV1hbhMmF3lSi/B/YQ71K44tRcg=;
 b=l1VBHk3iCGfwZKujArnz4Of2/BRXNrTuVY2Qw3ycD7fNxKc97Lzt+uExUhFriR8aIkbfwQpIddYJPsYUCgYd2ZsVxPyy1pcTVV2xiDMTSBZKevP+cfJQ79BWi+cXuMeXsi0k9BcW2Pt0k3bjejhmA+DCiAilB1zBlyp1mrNEMipED19OJ8OX2zpbNUXwOodnBriY8doDy6c3tiQ77Jinz5GbB05hVdd6dJA7/R1VcbHGCfD9YnewfXMBzTuG5mSJox7vzjvtj9b7RkenwfD4n7S1eSEIOD7vNu3MQLHVZ7ri/y+Ew/1YFB+wi362c4+BvHlRak8/C0Rqk90cRn57AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC3QV/QUbrPO9a4yIV1hbhMmF3lSi/B/YQ71K44tRcg=;
 b=FY3kV6BgjF9OFDzf6o4GDrasPk/Xo3KL0L7VI3P/WJsEicUWvdwkz5RKU3TOVusOi5KYUd1vRNuFdnAe60DPmaJBEpH21H7Tv0/Z5CCbTtjhbA5uwETh9QS+rgB4VWGoWj1vPvqLnJdmt5IQSQVFRcV0P1d1m18qHNWES3hOTJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10267.eurprd04.prod.outlook.com (2603:10a6:800:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:31:47 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:31:47 +0000
Message-ID: <339e3355-d6cb-4327-be49-e2721f1a592d@cherry.de>
Date: Mon, 1 Jul 2024 13:31:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hwmon: (amc2821) Use BIT() and GENMASK()
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-8-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-8-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ea2ff1-7694-43a9-a17b-08dc99c16497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlZ5UmRRSXV6R1FIVjRzOWl2WVN4WVNuc1hmOTZMU3lPZHk4a1Ntdld5elZm?=
 =?utf-8?B?Ynh4bjhKRzBScThXbWlyQWlmNG9PYVpBVzE2OThPR0NSNGZSSk1JTWtkVHo0?=
 =?utf-8?B?OXd1T3FPUi9rVnVRaG5POU5JdVZEMGVUcFJtQUo5OGt6cTNvNmhJeXExWmtZ?=
 =?utf-8?B?ejRxWk5vQVVxZjNqa29LWk5JeWY2STJjR0hJSlRzK2FsYXlKelJFSDBqeUlM?=
 =?utf-8?B?cEhYUGFQWXRzeUpXblRlNjNnZ0NtTytnSjBsbkhrajl5TnlnZlhjeVliZG82?=
 =?utf-8?B?ckJUaDh6Y1hLOWtzcStzeVVndXgrQWRDNGhUNnMvUkkvbUNGRU5VaDRFRjVR?=
 =?utf-8?B?N3d6S3Fhck5yNEtobVV5Y3ZlS0dWQzhRTitEcFVqcHN4V2Y2cUV4enloa1Vk?=
 =?utf-8?B?OFpsQ3EwMjhQYTY3SjdkZWpWeUZ3OTQzem9PT3dZTE5sV0MrWm50MU9TMDVz?=
 =?utf-8?B?Ynp6c0JnNmlqZ2lLdGpCMmx3NTRzckRWa055anZHZWRVU041VTA1bU9VRFhO?=
 =?utf-8?B?UVR4SXVWZGJac1Jmd2xRMTN3N0prcGZRRjRqV1NjTkVkZGU0QmZvdXdsNGx2?=
 =?utf-8?B?bFJEQ2FHSHVZWmozajBGa2NST2prRi9jb1F3RVpmM2VHcFVuZXR6Z283VlNL?=
 =?utf-8?B?TThWaUhNNHRtK0trTlBhVUg5SUlGRGppNUkwOWJwbVFYZ1hEN0lHQ0h5bzhM?=
 =?utf-8?B?U1c2Q0xkVEh3YnBnakszWURYZDl5MXR5L01nRmdlY25UWFlqSWhWNTlXdmEz?=
 =?utf-8?B?Q2ZDa1pMS01GbWRCeFBUdU13c0Q0dDdMQThldDNxNFlzZGVsRkdFQ3hFYkcr?=
 =?utf-8?B?MXZ3OXR5MUhuaFZ1dG9vazVVRE1pc2ErMHRwdnpvaWUwSkd1OWlPQlgxL2RV?=
 =?utf-8?B?aWlBT1pLMXJ5TTcvSlZMZlFjU2FBS0VQTkF6ZlVmbWlQLy81aElrdDJTWEQ3?=
 =?utf-8?B?Q3dJTUR5TnJuQVcwTm9kYkU0WERrYzNMRnRFdFFDZUNsNHViSVd3cUdwVHR6?=
 =?utf-8?B?SzFVK3VnVmo3eEhtVUozWFI5eFdYNWxBNjVuc2I4WTBrODUwOGc4NXNsanVB?=
 =?utf-8?B?T2ZYSEw4UW1ManpZYkN1d2hQbTFtRmZGWCtJQXQyVi9aRFRocHZsN1oySEpE?=
 =?utf-8?B?RmxhTWlsaDZiUlZZc3loMEkyY0cvZTZkOGMzUGNZanRSNW5oWWd3Ym9pUDMr?=
 =?utf-8?B?b1htaldwRGszRW9aTmNZVmRLMnJlSWlhT2dkS3ptdmtIOFJjUXBOdndEbnBD?=
 =?utf-8?B?KzVKZzdneDdIZFkyRjA2c3phVExmdkowS3hBWUhBbkRHc2NDTXRzRXl5dnNV?=
 =?utf-8?B?NmdVNlI0TlRMK1J3a0FoUU4xa2FuUHhaWnlDNWVNeVgrb2RMSkdzV2hPcGMx?=
 =?utf-8?B?ZzRGMTRmVVBHU1dLOWRDR0RSTU15WVF6eUM2YWh5cFcwRmRxMGdrM1ZoV3F2?=
 =?utf-8?B?NCt3L3YwRStVa1FvaHc1V2ZqdFhpS2xjWWtYWmZZdDRpbTFKVjIyaHRmY2dO?=
 =?utf-8?B?S2k5bkVENG42QnkwWVBYbmhKSjJ4a1VST21yRFVzeTNHTTRRODFGRlFNTWpR?=
 =?utf-8?B?WGpTMVloS2l6NXM2WG95NVBmVUxVZ2oraVB4YzVrM2RsTjJ6OGtlbEdjYmtw?=
 =?utf-8?B?ZEM5VlFrMVdmb2llZXBaMTlWNkVJTm12ajM0V0h0UWloYUFZK09wUmxsRkw1?=
 =?utf-8?B?aFFOZ2dwbENCa2hUQWhxZGZlYWJhWFZaZHZRWXFNL2dtS2hXRC85YldNTU5o?=
 =?utf-8?B?V0kyc3hFOUs0VHZFTUtHcDJHNE4zVlhGZDdsTWw1RUdhRk02SGJLYUxGanpP?=
 =?utf-8?B?SldNc2hxWnlkZlRuZjVqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlhKRXZhdUJydEJPUVZSSFpxZEgwUTBZK0VNK0JwaDBGMk1HOVpvTkQrRkh4?=
 =?utf-8?B?djNHZDJvaGhBaTJJVHdDNDJ5ZjIwQjlUbTg5NE82Q2plN1NUb2ZZSnNEWWRG?=
 =?utf-8?B?eTlXR09yUFhnMjRGdkxwb0s5UHY3SEQxZm50VGhYckM1ZkpiZXNldE0yRjA5?=
 =?utf-8?B?WUpwbXdsRitrSkFadFEwV05QbVpxSnFCU3lsa0trd1NkWXFaaVhsZFNwQjRj?=
 =?utf-8?B?YndOdm1abFFqalJmWjZ3TFZlRnhZSk12Q05sdEJOSFBSdzBLTnJHWEwwcVVL?=
 =?utf-8?B?OVV1VjYyQ3FlcWhrSmhURit4NVBMRG5ta3hrbnRlWm4rSitOYTZZL00xQlRV?=
 =?utf-8?B?UVNjYU95d0FHQUFkOFB5N094SDBISkh3b3NNZi9pVmRzS2hwQmhsdkVHUFps?=
 =?utf-8?B?WFpBSFN4RHhmSndHTjIvNitZSVViWXJCS0xCTHFEMDZuYndjREI1azZ5aXp2?=
 =?utf-8?B?QjZLSlprUkJYSFlpUkdIYnhpNzh2ckNoNHN4MjZzU1d2M2FTblZnWitRZnFM?=
 =?utf-8?B?Z05Gd2dsV2lpUEhWMHlHZjBmdFoxd3BEUkFteGY1MG5LQkdHNEJ5a0JKZUh4?=
 =?utf-8?B?ZEtvZnQ4NjRNTnFZTnBNY21FazZZekVONHdWV2t6ZUJzbzdIcHpGNng4ZjFC?=
 =?utf-8?B?TmUrbW1oOHBnV2RKa3RreTVUdzMrbUo1N21BdG9HRmtmcVB2TFlZMmJaZ2pE?=
 =?utf-8?B?Rm9QV09DclgvZzdoYVkzOUdJZjR3a3ZsY3ltSDczcHpoaWZjY1RuWS8yZE85?=
 =?utf-8?B?eERuVlYzankyVGdsYTVKRUZsVzh2bFA4Y2hTdGJIUmJ6aGdmWktJMCtYYkZr?=
 =?utf-8?B?WklxSEJmZ0g4V3VDQXRRd3lNcW1vV3VLWUFxV3hwQkN1bTZ4dFhyb3VtL0VM?=
 =?utf-8?B?ek5mcmN4dmJJeVU0SE9kWDBzMFZSeWZ4MURBL3BtWlNCMmVGT2swR3hJWTZK?=
 =?utf-8?B?VWNXdjMwM2RGTyswRjVKTUI3YWYvbEwrekpSVyt5MVNHeEpUOHc1VVd6RUJq?=
 =?utf-8?B?OGh4YzNPUnpoc25uS1k1dzd2cjhFZ0F4NkZKQVp1UHorWEQ5YXh5VTh2MjRp?=
 =?utf-8?B?dTFsdHE0L3hVVTNtVlBjMGFYTENGRUFzMlkvOVliNUZZbHRrQXQwWmR1bSs3?=
 =?utf-8?B?WklFTHFVNFdRdWtuQUJmWEhaWUNLdTA1OVovS2FzUUsyekVSbW11c1VKQ3Yr?=
 =?utf-8?B?cVRSaTAzMTVPZVdmT3MvQWo1VkQrb3BFWmJrd3RrZUNpSk04RDQxckxDN2xF?=
 =?utf-8?B?cUMzSncwREszazlrekM0SlJXWE1aWEtlUE9jM01Ma0gzajRjMnZkbVZGYTIv?=
 =?utf-8?B?Z2Z5SXVyNmhEc1doS3JsNkF0YlVGOWVzZ2tOQ0hXWnRDV0xzUHR5eUpjSWw5?=
 =?utf-8?B?bS92ZDdEcFZmVFRoam1RbnM4WVVPeHkydjFTOXBqUnJFc3ZTZnNNN0w1Q0hj?=
 =?utf-8?B?OXZ4dnl5R2ZrOTB1cWppSWh0WDhMTnNlSnRSdFBMNk5MNjB4UjVmRUZlTlVm?=
 =?utf-8?B?UEF0NnNsT0p0anV2UnBCbDNuVTczT1dXVUs4ZE44eGw3WEJ4L3o2NG9saG0v?=
 =?utf-8?B?TW14NXYzWmFSTm8yT3loT1FkK0hHT2RLZjM2VlpQSDNRa3ZUZ0FIbDNvL0tG?=
 =?utf-8?B?S0lEdEFrbnZxVERFK1BsQk1FUWt2VUZ4eXhZN3NtRVZoeGtmdlp3MjVZUGhj?=
 =?utf-8?B?WXFoZkNEMUtwaDlsVHVjUjhqZ3ZNZW9FQ0NjbFkrUDJteGMwVDB3RWMzMFYz?=
 =?utf-8?B?RzB0S1dQNVd2Z1hScG1NMHIyT3ptRWJ5VHVLa0xscWNBNVg0TWs3eDRZVDMv?=
 =?utf-8?B?Qk1JWTl0V0dwbXNmMWRteWlyVFlLY3VRdmdTbitKaS9DK0tQMEJsaldSMG9B?=
 =?utf-8?B?UGhUK1VTOXpRbmY1UGhVZU1uOWFXR01ralJIalcwUmRsSENDclEvU3BBQVhL?=
 =?utf-8?B?U3dia1FyY0NBVFpka3BDaElVdzRHb1VWdzdMVGNFNTREa0NlSGJhZ3ZOZ3lQ?=
 =?utf-8?B?YjN0K0JPaFo5OC9rMUxnMWlXZ1YydVpKK3FCVWk4VmpLSDZuQm9BeVpiVmIy?=
 =?utf-8?B?c2V4cEs4RmlKSU5xa0dpSDF6c2NyTWFzcFpXQlBBd3RBSnhya3F0Nmtaa2hY?=
 =?utf-8?B?M0NJM2NSTks3UUlyOGVGNEtVckN2c2FNSDV6SUR1akpWM2hha294YnA3RVVO?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ea2ff1-7694-43a9-a17b-08dc99c16497
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:31:47.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKoxRGugK8occXzuTBxZP9xBQp2SuhCcs+4oyXdUKmUcX/SV1jhCZNAIykiXGS0FB7dnsfzglq1gt3tVq99witr/gJb5LULs8zupXSmvW/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10267

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> Use BIT() and GENMASK() for bit and mask definitions
> to help distinguish bit and mask definitions from other
> defines and to make the code easier to read.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/amc6821.c | 71 +++++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 03ce2e3ffd86..042e2044de7b 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -8,6 +8,7 @@
>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>    */
>   
> +#include <linux/bits.h>
>   #include <linux/err.h>
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
> @@ -68,46 +69,46 @@ enum chips { amc6821 };
>   #define AMC6821_REG_TACH_SETTINGL	0x1e
>   #define AMC6821_REG_TACH_SETTINGH	0x1f
>   
> -#define AMC6821_CONF1_START		0x01
> -#define AMC6821_CONF1_FAN_INT_EN	0x02
> -#define AMC6821_CONF1_FANIE		0x04
> -#define AMC6821_CONF1_PWMINV		0x08
> -#define AMC6821_CONF1_FAN_FAULT_EN	0x10
> -#define AMC6821_CONF1_FDRC0		0x20
> -#define AMC6821_CONF1_FDRC1		0x40
> -#define AMC6821_CONF1_THERMOVIE		0x80
> +#define AMC6821_CONF1_START		BIT(0)
> +#define AMC6821_CONF1_FAN_INT_EN	BIT(1)
> +#define AMC6821_CONF1_FANIE		BIT(2)
> +#define AMC6821_CONF1_PWMINV		BIT(3)
> +#define AMC6821_CONF1_FAN_FAULT_EN	BIT(4)
> +#define AMC6821_CONF1_FDRC0		BIT(5)
> +#define AMC6821_CONF1_FDRC1		BIT(7)

Should be BIT(6) here if I'm not mistaken.

The rest looks fine to me. We could also start to use FIELD_GET, 
FIELD_PREP, ... instead of manually shifting and masking in-code.

Cheers,
Quentin

