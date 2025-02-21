Return-Path: <linux-kernel+bounces-525515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33FAA3F0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E2F19C7CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6302046A1;
	Fri, 21 Feb 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="W9Mv/+OP"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023088.outbound.protection.outlook.com [40.107.44.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A37205AB5;
	Fri, 21 Feb 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130834; cv=fail; b=aE5mk7NDdh9CHkfxE9qBsvc9tDHkehShb3qVor8h1f7YKz4lkj0TDJ+9tHg7Uz9liBjVGujAz3eB/CdoFWvek84nT9u6kGieQoqre4U7F/I5Z+c2TFa1U4T3YSGSr9myE34W8SLXc4B2+vY4pU4kDZpMw5bDx6hn1ACtQ18hriI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130834; c=relaxed/simple;
	bh=3e2zcJhUOTR8zRD+msc1WUy1X2KUwUYvd+oCrivrE8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BnD+rpZKrodBaBqG8NoPbEzMIfgNlGC3c9zZomxrwT4hAs+S7zg/UV4cxVrd3d7KPNpTx2XAuBjj4ejWTGjVK6GB4rHAy4mTiu7TjV1TZ/QXR2qhIs6ngkH7jgkiyMvdHj2YRBHFaH6P4822ifGxisaeWUAqyh37xkIYdZBnmrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=W9Mv/+OP; arc=fail smtp.client-ip=40.107.44.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaWDyHkL+nCM4xOe11IFxupurLLFEGOT5yFx8S4jdHhlMur6dAXbDQtXLtmiY2ZNIRaYAuUADv5VBe3j4/dI+Dhj6B4nxBbkTZD1k5aO6KMIVAwTzEaWgSlpU7QaoM0JBfteLU14m0wQSXPAiJ4ieAguTUDzcsyRnekKaX6SFOIGhkTb/KPscjZ4bxyyl0JNNhGpxWTaaPAfePlmvQMrCvHHLLapew/4AM/5cedKJ223atOgVeQ2ZmRH1t5oswVWqM5zxtzrlg8ggWpNaMv0dErcneXTGKY81K7X7QAEr88jXGLELxOavsp8yVc57JCO0vbzykR/tdX9mImk1Pe90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQAPw4SByxmMbBnoDHXnZIZX6wPBaivWyI4xpUlqPE8=;
 b=o/rOhbqRA3DDWU2RhrZ4wvTdByCQ6MlFTFbZOgcZxx2aHqoqJX/LhgSoIvArtE0Ck3cfQiThSmOlZiGm0Ql6c+mFUFkFAa10B8ojg+eTQ5gBa8k18iNeIlynNT9ze5XIZkn5Lysn4wOyj3sHisMbgzSGaucD3ohhSy65JbGPNB6pVJSLmU02rexw5DNNconlV7GGyAftzUlEQMrzs5T3jUOo9YSvkWDJ6DZ9VhUKSZygjbqxdMuYx9jvKroIPNzPXmrwdHUgA4uyP3+2LomNVHDj70oGTlVmOuJxoM1kRD9iEMFWH4KMbeDeFUND/DLFPqhD/ynI2Lr8HgTCDi41Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQAPw4SByxmMbBnoDHXnZIZX6wPBaivWyI4xpUlqPE8=;
 b=W9Mv/+OPvn1uQdlzj4Ck3Pt7+4Dfjao6bnvQLl1tTkdzWksLXOjVckuLodNApz6dCkuhyrLJVj8Z4j0J1n3PWJvCp2QWt8F28ZuviZ2AR7cX7Xy6zt/0vXtXPl+Gc2oZGNZp2YwYvUNSBCo+/M1yzmA6YUbddYD0tXmLcBes9+wOIOWnRzCt3lUrcezi/FbDYsGjWzMyyW3NHmgJ5t/dxToyRx8i3wDB2dR4nxx5StLeCfgPVHGQpices4j1yeGxYmEHqfkDHIdce29CnOtNqjLyJOEElExGOu5liJrOL2K6rzzXeXj4V9NMTwRJh+m4pWmUvm+GhGXGB2PKTdLiug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB8830.apcprd03.prod.outlook.com (2603:1096:101:255::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:40:26 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 09:40:26 +0000
Message-ID: <9fc22e48-01e9-4eb9-88de-34cea7ed2238@amlogic.com>
Date: Fri, 21 Feb 2025 17:40:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] irqchip: Add support for Amlogic A4 and A5 SoCs
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
 <20250219-irqchip-gpio-a4-a5-v1-2-3c8e44ae42df@amlogic.com>
 <87o6yvhdiu.ffs@tglx>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <87o6yvhdiu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c82019-1b44-4f23-cb93-08dd525bc527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWZjaDJxUXpJbHF4RmxhWlBnSFFZK3l4K0wwbGRQT2pmVWxYLzkvNEZTekJi?=
 =?utf-8?B?d3pvd0tqTHhYVjZaakxISG1ZWTVuZ0M5ak5FVXFFQzhkZkFOL1FOU2hDS2tn?=
 =?utf-8?B?SFV0M1FESklyYVcyV2tXZ1RmMWtsRzlPTEF4OVl2OU5VME9RTW5JTk83aGtP?=
 =?utf-8?B?bXE1ZWhMZVBUSitQWWtsUjVqRTBncmUxWU9LYSs3SlFNUUlEL08rMjJTVEhw?=
 =?utf-8?B?bDJSNWxRL3U0cWR4OUN5QzlXdzNVbWNPUFBjNTAwOVRpSGczSGVrMUh6NHRN?=
 =?utf-8?B?ZVZXbDBTc2V6Y3N4WWRHZkw5UUd4TThhTEdEazgyR3RmK25uUFk3T0dOOWgr?=
 =?utf-8?B?NWJieSt6UG5abzYwMHA5anNnaEU0OVVudml1a0FaZTBWL1lEOERYV1hEWVdY?=
 =?utf-8?B?NXdpR0NJS2ZqblFMclVjQzZOSGd0OHN0aXJ1Q2FOcFVKWEJaQ1dPVk04UUs0?=
 =?utf-8?B?cE9rOU54U1R1bnk5WVB0cFdnVkdxUFVZNzl4cjZkWUJpTmRRZFdTYWF2NFh4?=
 =?utf-8?B?M1pSc2R3Y3NDQzNSajR3blpRNEZmTWo2MUg3dnMyd2VDUFhoYlJObHR4OFRo?=
 =?utf-8?B?UHEzVmJKUll5VGUvVmQ3NzRnL0pLZWVWU1U2Qms4M0xmZGpCeXNQZEVubHVp?=
 =?utf-8?B?LzZmNDhZMlJPZHRkQXplL2pGL2dxRHVSa3puRnlzeUZ1aUkxMnN5Q3ZabEF2?=
 =?utf-8?B?RmNmd3hmSzRlQUpCNmkyaVk1OXdsNjNidGtCRTBhNHA0TVJXNmxJZXFPMUk1?=
 =?utf-8?B?NG5VcCsxNWhWY3duVzEvUVhzbWNtNHFpSFRmSWRkMWEzU05OOWc4Tml2Z0xV?=
 =?utf-8?B?WHhTYjVPSU41S05QZ1ZwNmVTYnZ1TkdrSDJ5c3FQUUMvOThWS25JRGJvbGtJ?=
 =?utf-8?B?ZFh5ZVE4MHl6ZWRrczE4QUoySHFzejRweFhabDRlb3dOR0V2cldsZEpQVFZF?=
 =?utf-8?B?aTc3Q2pnTTBZU3dOcmZLMUJ3N0ZQQXkzN25RUVRRYTg2R3l5a25xVTJDVVkw?=
 =?utf-8?B?Nlk1ekJBQmtyK2FkeWV2eDR0Z2dUa3pZdWIyY21vTW5nR0xzcnA5TUg4WTEr?=
 =?utf-8?B?ZWxRdE9OVUxIUkVQWDZBSWs1NUZ6OEo1bHJENWxoSEt0VkQ1dnRUWWxUOUIv?=
 =?utf-8?B?SXdUWC8weFg4blg0bXE3Vk9zOCtOR0FLN1gvbjNvSnR6bHRkdkFJTnp1VC9s?=
 =?utf-8?B?dVYzNkRxN3lCdlFXZzc1NnV2TFR2NW1wQzM4TndPcUpFbFlIYk5vdUxaTkZR?=
 =?utf-8?B?eDJ5WWh2aXFrajdhdmxqNGwyQ2x2ZWdZZ0RaNjhsWjQ5bnF5eklIVDNuVTBL?=
 =?utf-8?B?d0hpWnBTZ0QwdnJMbnBkejZBeUhjOVhDK1ZaNFhaQTVBek5FNTZZNDNwSXdm?=
 =?utf-8?B?RjBSR25hWU1MR2VXQVc5dit2UjRlTFg5MGVPaVM0ME9GVGpNUitxSkpyYnUw?=
 =?utf-8?B?a0lsNCsyU2o0R0xtN01YOHh0VzRDT0NyOHVSaGMvZFhXVXQ0ZVliTk1zb3ZB?=
 =?utf-8?B?QlZGL0JyMFhVYVBtQTl2dDNsbmJWQ3UyYktBNkFJNTh1eEdsMjVxNElWd0lV?=
 =?utf-8?B?d1V1eGlDRkVKT1pXbGQ0RjB2bXUwcHE0N0pVVjB6WERWZTgva0JUNmhuVThz?=
 =?utf-8?B?TnBGd0xjVDlacEdCUXcxOHVadnkwczJac2Nna2NwSHhxblVJUHFBVE5RbUJP?=
 =?utf-8?B?VlRjNC9McW5qclJIN2k1bXVWRlFJTm1rTnBzMVJpb2J6MkFpQlNnak1GRE13?=
 =?utf-8?B?RWlaVTJ1Z1pEZHVuRHNwb1JiZE5ONnk1bjZ3eTZJdk5iR0g4dExXSTdob3ps?=
 =?utf-8?B?MVdEVm4zZkx1MnNobUlFQ0F5QUNEa3VQWmE3MTJyT2J6L0oxT3NTVWFmQysv?=
 =?utf-8?B?U0pJZ2tFRTkza25uLzEwbUszZlpaTTg1eE4walJMUG5vRGowZjVvWThRZU4v?=
 =?utf-8?Q?qf0tztsIR3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnYvemROZDJyOHhtR3pvd0o4elVMOVVpekVsR2xUYzk2QjNkWE5oZlAvcHpr?=
 =?utf-8?B?amxLWUU2T1JEU0c4ZXdYN0JRMlZ2Wk1FaUxhTklITVVoeXpKTGp2eDNsTTdw?=
 =?utf-8?B?ajk5VnpEK1RJc2orSzlZMVJiRlMwVjFMSjhCc0JMRDEzQTlybUl4QlkrcVNG?=
 =?utf-8?B?ZWhmUXk1TWRoQzlWaStoSFJqZUw2bTZxZ25yUk0wSE9tTzJ2bHV0Nk9xd29n?=
 =?utf-8?B?aE1teWJ5QzN4WW1qTjZFaUNCOXF3VkVsakx6ZjlIalNBTnNWdkEwcVBzYjFW?=
 =?utf-8?B?ZTFuS3NVZnVrNENkbVpmYUU3Zk1mTXlidlRpdWxzQTh6SWtpeHYxQjBRVlQ0?=
 =?utf-8?B?YzNheW1TVGZRSkhJMjhUM0NaZzhvUDFyUWR5anFla0txcVJ3bTBhT1ZqT0ox?=
 =?utf-8?B?SCttQllJQXhUcWgyS3lIZVdMdzMreWN2VEc2Ym5JdDhaQlZKMGk4ekNzckx1?=
 =?utf-8?B?UXA4U2NqcTBDS2xqTzhOMzRFQUUyUVUzWlBSc2tSQnV2aEdsZ2FqL3lGZ3VN?=
 =?utf-8?B?a3ZWL1I1amlVbVRiY2VVRGs4OGhaUU1pakdNSUMwcFRkWjE4cHJtaUxOUnZC?=
 =?utf-8?B?NGYwdmsvU2JZa3E3eStQNTlWc0VobXZ0dkE0eG9jeGo5akhac05id1FrS2FO?=
 =?utf-8?B?ZHFmZUpYbWNJd2dwTHdadWdXWEFCWmd2K0NIazgzekpIZTN3ckw2NHZBNkxW?=
 =?utf-8?B?OGpibjErMjF2Y3FqSHJBQ2pSMmdZa20rWk5aQzVucVhUL0NZalMyTEd2d0oz?=
 =?utf-8?B?MTRRNEJhK01GQ1VIRURTRGdyYmpPWnplak5wci9GNWQxb2QxcDIrUDVrd3hO?=
 =?utf-8?B?eHo1SGJqN1pHSWFjTTVZNFpMS1I0aHRqV0N1NWpnblNaT29xSkhXU09MZTVP?=
 =?utf-8?B?VGtaZldaK21ON1JMeTNPU2dwZmF3NWxsbXRFWDRjeWx0Q05nUTFzUjh0eU5D?=
 =?utf-8?B?SVZrV0lOdDV2WWEwRU05N3B1Vk5vaXNrSnYwTElOSzNsRVNyMy9qMThCN1Nj?=
 =?utf-8?B?UjlRTUZKUXRLSHBsQTJoSHkySFFaNjNPWVJuUk05NXU5b2FvaVVnZ0Vudi81?=
 =?utf-8?B?ODhrOU9vWmoyUEVDNkdxRW44T3JKdE9rMENtSzJsUnpXczFiNUs4WDNkak1N?=
 =?utf-8?B?Um9CZnNLeUxJOGMvSHpUNFkraXk1K282dmxLRDJINjB0NzFnUDg5dnJFRmdG?=
 =?utf-8?B?blZla1djS3AvQTJ0WXppRzh1WjR5MXhuT2hwZnA3ajVJUWxoVmpCQzEzdlZ4?=
 =?utf-8?B?ZHJpWVpPMGZIc09PUURsZDN2VkVWdm0zUWMzbitib1RLNm44T3dtbllvWDZv?=
 =?utf-8?B?UDcySGhLejZ2L0YxVi8xb2NlQXpHNUdMVDFrR2lSQ0VybFhTVi95T205ZUFw?=
 =?utf-8?B?VGNjZWxRUjBGMUxQbzRPS0MyV0hFeGV3WFQySEduOVkzbnZmRXZ3eUZ2ZDgw?=
 =?utf-8?B?ZWVEZEwxb3RPdkFNeEhVU3FZUENxcVQwcnl4dGgrWTNPQXQ0RzRwdVNIc3pv?=
 =?utf-8?B?NGF4MTRJTGZpcm42RFNkK0RWVFlCR3BSTEhlc3dNVGxGajdqdXBaTVBaZm82?=
 =?utf-8?B?TGZCUGROZjgzWE5FYXN0QmM4VGFDRFp2clJPTGNJdDBob3A5YmlMeXkyQU8z?=
 =?utf-8?B?RU9vbVo5YlV4dU93QS9xZmdEeW9XUzRjUG03OG1oWFRtaDcydzhvMUlDYmNp?=
 =?utf-8?B?R2FBS2dUMVh0L1F3SFdHejgzbENLL3oxbnlIcFo1RE03WlNUNWswUjhoZkVn?=
 =?utf-8?B?TUxhdmtibXk3aWVFbjA4djBydW1WU1o3ckJnQmRIWW9aeENqVGhrOE1DUG13?=
 =?utf-8?B?TFRHellVTHpURG1tdUN6N0FVQldtQTJmbjlzVWJrcklKekdHamdqd3ZzUUZm?=
 =?utf-8?B?akZEVWNhV2pGM3hlY09pSEpscnFPYjJEOVFMMm0rNUZ4VGRBS3Z4d0huNVJz?=
 =?utf-8?B?cmZORHQvem1qd2VFM0JlbFlJY0pzcnVQRGl3b2d4V3ljeEgzazVHazdpOEdI?=
 =?utf-8?B?WDgwa2dQWDd1NmczVms1UnJZZ1NFeFNUanVCOWY1bmVScG5xQXV1ZHc2RFdh?=
 =?utf-8?B?S3JoSStyanU5THB3dnQ1bldlTVVGTDJKQ1JZaXdaOWJ5bnNtRE9FcmFhM2tv?=
 =?utf-8?B?OG5pUE9DNHRMVkxRdURHb2lRVXQvNW13QWFwRWkyV1gwMmdXV2czUnN0dkQz?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c82019-1b44-4f23-cb93-08dd525bc527
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:40:26.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfi7basrSWfLi6W31FfAF8NkbPOMUvyz0nj7AGAYTGvg+Chl46xA1j9rZmjaduNp/9LsGUaYClJD1mkuPdoUmqO146VNfEmbwOCI8duGEu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8830

Hi Thomas,
    Thank you for your advice.

On 2025/2/21 17:07, Thomas Gleixner wrote:
> [You don't often get email from tglx@linutronix.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On Wed, Feb 19 2025 at 15:29, Xianwei Zhao via wrote:
>>
>> +static int meson_ao_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
>> +                                   unsigned int type, u32 *channel_hwirq)
>> +{
>> +     u32 val = 0;
>> +     unsigned int idx;
>> +
>> +     idx = meson_gpio_irq_get_channel_idx(ctl, channel_hwirq);
>> +
>> +     type &= IRQ_TYPE_SENSE_MASK;
>> +
>> +     meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_AO, BIT(idx), 0);
>> +
>> +     if (type == IRQ_TYPE_EDGE_BOTH) {
>> +             val |= BIT(ctl->params->edge_both_offset + (idx));
>> +             meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_AO,
>> +                                        BIT(ctl->params->edge_both_offset + (idx)), val);
>> +             return 0;
>> +     }
>> +
>> +     if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
>> +             val |= BIT(ctl->params->pol_low_offset + idx);
>> +
>> +     if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
>> +             val |= BIT(ctl->params->edge_single_offset + idx);
>> +
>> +     meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
>> +                                BIT(idx) | BIT(12 + idx), val);
>> +
>> +     return 0;
>> +};
> 
> This function is a full copy of meson_s4_gpio_irq_set_type() with the
> only difference of:
> 
>             s/REG_EDGE_POL_S4/REG_EDGE_POL_AO/
> 
> Can you please stick that register offset into the parameter structure
> and use the function for both variants?
> 
> Thanks,
> 

Will do.

>          tglx

