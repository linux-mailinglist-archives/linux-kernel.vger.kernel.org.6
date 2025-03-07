Return-Path: <linux-kernel+bounces-550319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED5A55DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AAB3A8B91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D79818A6AB;
	Fri,  7 Mar 2025 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="L5gtQwkT"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021111.outbound.protection.outlook.com [52.101.129.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAE322A;
	Fri,  7 Mar 2025 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315701; cv=fail; b=kXyNhU58DnfcV5p75WdO+pVAlXcRH9kXP3OqkP/AmqR4Bp6EhwNBDeMXhEBwDTKrGbqvKfj64bUt7zrYSUTRTpgDBUqppKVVyIeZsfcGenK/cMry4p86uscRk2bOwryA1H568KPA6yeazYU5sX8NtZnWegZds5KrZ/tLFsZ0G/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315701; c=relaxed/simple;
	bh=udCNzI2MRnZGhz3fs7ESUxCep3PmP/3URP3mu6TB2OI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nh2RGJQNZzgZYdjs3vusyg1DPLDQebHHeoAO9FJD8j9j1Qq79XFj47xFnn9peJY+OI9ywx+6qx8oFvpP8ioMnu3ESetAe/Xdc8+AH/pJ/R+ZKEOA3gfpVu1yjc9Evk38erq/5d1XK/6Dp63GS+p7jt+NOfVjTSa8WBxqeMKyniI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=L5gtQwkT; arc=fail smtp.client-ip=52.101.129.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhZAafRQ3gm7FP/+Z6xIRrepC5zYGWY39WzNI+pO/GJS6/4oul4Cp37iSjwMui5v0L9QVqSt9d3E/HFrbfZgb5YwP+b4GWu0kyMOENNxiq3+gGeR1+YIETyc/wUy43fqNdkXIwdu74fj58KA8pBb1rJTRN8zW6f/TZkiXkWuofPMo5E+sQOxbvTYfnoqzVpmGomvdF+olyS1QQ+nd8IIbhAeT6Db2mox0XNY72dFca6GsXl7L0kSXjPIRDvQ4OwG1/GXw5L3/oGgkHIdhelvnU8jj1iEsrEZNLJD/iOjixt8HXsLALhaTPXRlOWo2XAhBcUe0SO++C41DzAOpFULVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlzijiw5nh1PlQ7C3JgDaFh3UOzj9I0GGiXntbg1SaY=;
 b=n5pMRGRWLcfDTjnAM07/ZWVTsWJFJ3iCYNssKYh7flG66u6Q1R+DefsWYLz6lGmGSw7Tq3qMnNAozMpaF/toR2UxjYEexvkf25G8U4w1m1wXLjoVmcZSR4KkuV+9bBH578pW2SKSNFV3W2aGpoH7zx/HDKE4t9h+cT/x/yoRBbBX/dq/dNh4otwp5qBRhe4c4hcS3rzlJhSfcYvoEUl5DpOyY0V/Eko1MCQmObQaGyvjp7QXEYD+ZrMfWDkw14hzAxLbDR05qiU3IWJfWAdFHuiiZKM4XdEd60H0e+AD/kca/QveDtzG6Z2NsHq5IHOt6sZhpTAGErZ1/ARhdhT7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlzijiw5nh1PlQ7C3JgDaFh3UOzj9I0GGiXntbg1SaY=;
 b=L5gtQwkT40bGitRSiO4xjko/wYJbu68rl13IeRgN6LzOzkpH6yr0sapxN0CzIt6V35UXwB8fL16bxi7M+gwAxL68NxtdpIiCN/x3eMNZQGBcGY21JEJydV/ZbKxoLDSZK38JvPiz+nw8O2ky3r9UsepQPdjTGfxNr7xKQdl9v2MaTtQq5LDAQ0+6irZp00AvPoebroYo7tmeJFsbNwXgC8kAfz7Q1fFoUrAPhzN6W9O9KAUyf2JZa0p4ghefqHUQwKomxWQ2JVviGvWtSPHPNtW3tVP4pbmGcfO7EL5QecldcMFnOm/diqfY5VSnQxH33sttzEoI4KCKxQdT88s3ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by TYZPR03MB7954.apcprd03.prod.outlook.com (2603:1096:400:465::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 02:48:15 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 02:48:14 +0000
Message-ID: <26292ce9-7644-4a8f-8817-045cf6dd87b0@amlogic.com>
Date: Fri, 7 Mar 2025 10:48:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ASoC: meson: s4: Add s4 tocodec driver
To: Jerome Brunet <jbrunet@baylibre.com>,
 jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
 <20250228-audio_drvier-v3-5-dbfd30507e4c@amlogic.com>
 <1jfrjq5ews.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1jfrjq5ews.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|TYZPR03MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: e49ee605-6251-4d12-67d2-08dd5d2281ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejhTVGRZeS9EcWxacWdyMFR0ZHVlL0hmbEo5anJ6OU81SUpFZDNsUDN0QjBM?=
 =?utf-8?B?QlF1dXNJNS9GWVhCeTN1aHdSbllTTExVbjhpdWQ1Nm5qdFZXRWY1ZmpPOWty?=
 =?utf-8?B?aFVpcVgzSTdUb3pndWQ5ZC92MEJjNXk3Sm45ZVk5cFlxRW9Mcjl1WElraEhZ?=
 =?utf-8?B?cHcvTVcrRE5rbWV4amVkOUdEZHdBVE5VWVNJdDE5T2dPYlF2MnlURHVnVmRr?=
 =?utf-8?B?a0I5TUVYNklDTkxRUXEyMC80a0NySFJ6U2UxOXFOdDVPRnNkUWxtVytOa3Vt?=
 =?utf-8?B?V1hORis5TzdscEtxRU4xTlFjUUUxVmNtaStTa283amtRdjNUWVJTdS9VQm9r?=
 =?utf-8?B?KzA0NWpFTUhXL3h3QWpNRzU2alhybldPREZoNjdPV3FmOGk4TTR0dWhXZWp0?=
 =?utf-8?B?dUJEMkRVSS83REVMZzk0eEcwVzhFRkFKS1hVV0hTdzlreVFOcUhtdVQ0OXB4?=
 =?utf-8?B?cFNjU1M4Szg3Ui9rZW51cUprSTZnVUxocGppdnZqbUdNYmJXMjFIT3h1LzB2?=
 =?utf-8?B?RVdhcTFCdFFqdnNYbDk5WTNlN2pSU2JCbDEvTmtXVVJrRjlVVDZmZzl0NW5o?=
 =?utf-8?B?UEFkTGFxT0QybjlhcnF4M2ZHUU15MUFnaWFEVGUwb1RTM0ZVb2JhRm9BVW1T?=
 =?utf-8?B?bmF0b2NIZTJFa0NJRXBDVXVMU2VuMTd3eVBQY3RQZlE3TVdyWTBydWRyRWRD?=
 =?utf-8?B?Vmg3aDhUb3NUcGMyeTYzaHVQR1pPenZuaE5XanR4RE43UXRPUVNBYVlJRnQ5?=
 =?utf-8?B?aE41ekhCRUpZVXA3ekMzb2txeVo2WGFDa0llTm9iMkFlMXh6TDhCNkFKZzgx?=
 =?utf-8?B?WDA5VVBhOWxZdS91SEVhTFlwb1dlSzNWanJEYjMvcUxRQnVXNE9IeVBRai9o?=
 =?utf-8?B?NTZzYkdRNHpKa0ZoSHdXcG1YS0dkdFFCbXZobkQ2QWN4ckxhVno4WG11SHJR?=
 =?utf-8?B?UlE2ZGlvaDgybW9yQ2FXT3FmTjc5N0FiNVY3WHAvdEF3WU9Sc0VoOE1lc2M2?=
 =?utf-8?B?UWw5VVJRdEl4Sy80UjI4MlNSNFAvS2o4c3hDeVNyQ1dhbDh1enFhdnErNU9H?=
 =?utf-8?B?RHVSMFlsYmU2MzFZSGY4MDZmeG9rdDVES1NpcDNYM3JUV3prNU4zNlhJOHdH?=
 =?utf-8?B?d1U0NjYrTmVMQjdiaGNSWnd2OTQ2WVNJU3lVRlNUc1ZndkxyN1hqajgrTE9i?=
 =?utf-8?B?YW5Tb2tPWCticEg0OEh6YkxIeXdVcHkxMUo5U3ZRM3RyQUVTSDVsdzhUcHlk?=
 =?utf-8?B?WkROT1VpM1JJbEtXN1R1Ykp5NWNjZm1XZkpCQi9mcGZMYUMySThVdytteTV0?=
 =?utf-8?B?Sldkek5OcUNzQi9TcVhyVWJNWGc0TWlSRkhqcHE0NmdJSDdoUUEzOExrYmx0?=
 =?utf-8?B?SGVKdmh6NnN3Q1NQZXc2b09odFMrenZ0UDNiT1BYampQL1VGT2xFVUQ2M0Jw?=
 =?utf-8?B?Wjh2Y1gzRFovNlArN3M2bXdyc2dVZXFOUkNhem1xMWFoZ0QyazVnSElZeUhF?=
 =?utf-8?B?bzArOGFhZFRuSlI0NVVaNDk4bUk4ZHdEeU9YbG1wMVp1MHhvVDgxME5hcXVm?=
 =?utf-8?B?UzNNTWJYSXRYMEIvZTdvejZmZkhLTEFXcU1GY1lIb3hhZmFwcHZqblFRYkdo?=
 =?utf-8?B?KzVnN1kwRFNVNXF1ZTFYWlo1QlEzb0NuT0RGc0J2MXJsN0JvaU1weVJyV204?=
 =?utf-8?B?Q2ttQU1zVktpUDJBdVB3SVQ2MXFGZDhrTG54UGc2eTRVQ1J4RFk5aUNzbkpO?=
 =?utf-8?B?NFNmaTEyZUZ6WDF6MnFSK09mb3AvSjhRTkdRMmRrMFNhQXdMQnVGclp4SFB3?=
 =?utf-8?B?U2VXeFFub2Y0RFM3ODZUL0Q4Si9nbUhscVNLK2pUcmxGVmpham56YXlEN1Yx?=
 =?utf-8?Q?9uweGIAE/ZFHK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGNPT016dnJyNGtjOEh2djF3dUpzT1BjaDVZa3JaOWJqN2kzQTVJT2d6bUFz?=
 =?utf-8?B?WGEyTlNET1kyV0FQWENETUNnK0Jqck9qTTZyL1RmemRmcG50THZ0U0plQ1lG?=
 =?utf-8?B?eHZIcXFyL0xacjNQSW8yL3I5Rk5YaTFRY21QV3hzUlJ3ZUEyVGp3eE9iYzJq?=
 =?utf-8?B?N3EwaDVOYTRSS21UTktqS2E0UU1lREpMMFNlZ0x3NmpPWEpkTFdodzNSL0Jz?=
 =?utf-8?B?RDZYTHR3TW9KRWtGZnhIZjhoWGRkdHlEU0ZSMHpoOG5HOVFHbHBjbGxVMTBh?=
 =?utf-8?B?RC9zMG9KN1NZTXRjR1JpMzR1cXluY2JtQTN5bWRPRXhLQVVGRkQyL1dQVFdB?=
 =?utf-8?B?aGFsdGRmc2FFcktSQTh2REhpWDZLNWpSa29OejAxNG5Senh6cDc2U01FUFRr?=
 =?utf-8?B?cHIvb2dyZzZOWjhSNGFLbk54ZnFRc055dGNFK3NPbTNjMndtaDZCN1hXNnUy?=
 =?utf-8?B?VjR3V295SnJ6R2RUMGNBRnQ5SUtNVG5hWjNlK3hoL3l1enFCb0xKeFNCNnZi?=
 =?utf-8?B?eTJvaEliZmdVN0pzQk84Wng2Q2Z1a2VZVXpCcmcrdkZseENsaGZ5d2E2V3ZV?=
 =?utf-8?B?ZVJvMmhhN1hNZUJLOWo3YUNPWmFlN3ZKWk01a2VFQ2ZYbXVzdnZ6RThzOGxu?=
 =?utf-8?B?djdTZHcyM1YzcmJmZWE5anR1TzJOVXpwNDNUL0c1K3VXeVArY3MzWVZaUmFE?=
 =?utf-8?B?T0VyOHg3Z0FmeG4rZTBrY0ZUajNXT0NoT1QvRHhzUmIrS3BpQlpZcnpNQ0Fa?=
 =?utf-8?B?cmtXaXFpNWdGdEFPTWJTTnM1YSsyVWd2NnV4SzRGTy83WUxwMmx0TGxKbUMv?=
 =?utf-8?B?SHk3VThJb29lVmw5QW5iQm9ld1JQWXdxMXdLNUJhaVArUkY2NmI1RzJrNGlW?=
 =?utf-8?B?RWRxRlF2MGZuS0VMKzJiNVpOYmpWQjQ1dXlvcFpVc0lhRTIvbXZ5MkxiQ1E2?=
 =?utf-8?B?bmVvNlpxU1BQMjdzRSs2ZElHMHJFclBNWmVOQkhJeTZLZEJPakY0Ny9SYzJK?=
 =?utf-8?B?V3JjbVduem9sb0tMdHd2d3JRVzRoSVdQU3JuT3VsWTIybW5CTXpzMjhwZGhT?=
 =?utf-8?B?L2JoQzk0cjRlOUtqSGtDTmtuNnBjSlI4YjNQMmk0SkhHMnlaelNjQjdSTlRP?=
 =?utf-8?B?WjREYW5INE1iTjh2U0d3U1lNQTFnWEhGWUlFOVNQNEhkSi9zUzh0ejRKK2Rk?=
 =?utf-8?B?MEdHRjNIajg3b3RjcjZESDM2MGVtL3pLQXBHUitWSlhCOUF5TlcvQ0N3R1R4?=
 =?utf-8?B?cGpLVWhXbzJxZEVXMXRpVGtnNWcvdzNzZXV2VHR0TFBzWHJ2NjN5WmczZEpE?=
 =?utf-8?B?Q24vWlNhT0xUUDdTZ2JmTzFKYmFLRjVzNGxnb0NFR3BxRkNGODU4bjRFa29T?=
 =?utf-8?B?b1dVY2dxbVlDOElRa2Y4eHIrWjJWbk4rUEN6WnRsZmpNSWVjZitoR0R2bzJJ?=
 =?utf-8?B?SVVWa3VvTjhERTArdzZQeUVGWmEyK0NQSnVKL1FkbGtwa3UyR0g2TTVGSDhp?=
 =?utf-8?B?RldlZkJrczg1aFZjNW01NGF5eUUvZGFnT3ZvbG01NlJDSnRtMm0ra1hjWkpI?=
 =?utf-8?B?a3RrbmlPcVZUMWZLNm1adGVyNzVqSkhXMzlpTExnVUNiaDdSZE1rOGdreXdo?=
 =?utf-8?B?Mm5IcEwwd0ZCY0tia085aGswSlFyTnRkOTB1bUg4SVJKNHdwZUg1WmkrVEhQ?=
 =?utf-8?B?cXdZbzM1L1hSZVNJaG5vMjZsU0w4Ty9MODdpdWkxOERKMmxIT3Y1QkNnOEQy?=
 =?utf-8?B?UDM3UGdEOWJNVlozTUhleDhwamN0Y2lpYmd6OGlRV1FRYnRJMlFIMlQxaTRy?=
 =?utf-8?B?ZFJjUjMxb2hjaVF6aFhSbVhwZkNHeWljNHJGTWFLcE9EeW9EQi9oaFp3M0tT?=
 =?utf-8?B?alVvdGVqeC92aXkwZlUxeVJ4Umo3TUorem9oWW9kUlZiam8yUHd0MDBnZG9O?=
 =?utf-8?B?Q3EyU1hzUW95NzkzNE5ONEt2MHg2VUw2QTYwVUlwS0NzKzF3YVI5UkRuSXZl?=
 =?utf-8?B?MG82MmFBQW5lVDU5VUJKWjYwdXY3OTlwQkdjeWJRRXI3eG40dVJYa3lRV2Vz?=
 =?utf-8?B?SnpadUp2RVNoRkIrQzc0aUF6bWZWUDhuSUR5NUx1bWlkaFhaU1lyQVdTQ3dO?=
 =?utf-8?B?eWVlSFB6bVRUL2xBZ3JGN01obkF6cGlMY1dNR0lEcnlhUld4ZDllNWJqd0VI?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ee605-6251-4d12-67d2-08dd5d2281ee
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:48:14.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ6HXmWhrhlxHKNGwEP4gn2QlsglrpoTIDjmxZDgmqn1uDCiHCWUEfpc13wZmkNfwTNZCb5sd/JXn27+pPJZzKYqfvVUes8A2UZ1vRNYDnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7954


在 2025/3/6 23:58, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Fri 28 Feb 2025 at 16:04, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> S4 tocodec support 8 lane to input, It need to enable
>> bclk and mclk control bit when work
>>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   sound/soc/meson/g12a-toacodec.c | 51 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
>> index 531bb8707a3ec4c47814d6a0676d5c62c705da75..41eef9980059285275f0189a06469fc694775955 100644
>> --- a/sound/soc/meson/g12a-toacodec.c
>> +++ b/sound/soc/meson/g12a-toacodec.c
>> @@ -41,6 +41,9 @@
>>   #define  CTRL0_BCLK_SEL_LSB          4
>>   #define  CTRL0_MCLK_SEL                      GENMASK(2, 0)
>>
>> +#define CTRL0_BCLK_ENABLE_SHIFT              30
>> +#define CTRL0_MCLK_ENABLE_SHIFT              29
>> +
>>   #define TOACODEC_OUT_CHMAX           2
>>
>>   struct g12a_toacodec {
>> @@ -129,6 +132,10 @@ static const struct snd_kcontrol_new g12a_toacodec_out_enable =
>>        SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
>>                                    CTRL0_ENABLE_SHIFT, 1, 0);
>>
>> +static const struct snd_kcontrol_new s4_toacodec_clk_enable =
>> +     SOC_DAPM_DOUBLE("Switch", TOACODEC_CTRL0,
>> +                     CTRL0_BCLK_ENABLE_SHIFT, CTRL0_MCLK_ENABLE_SHIFT, 1, 0);
>> +
>>   static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
>>        SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
>>                         &g12a_toacodec_mux),
>> @@ -143,6 +150,15 @@ static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
>>                            &g12a_toacodec_out_enable),
>>   };
>>
>> +static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
>> +     SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
>> +                      &sm1_toacodec_mux),
>> +     SND_SOC_DAPM_SWITCH("OUT EN", SND_SOC_NOPM, 0, 0,
>> +                         &g12a_toacodec_out_enable),
>> +     SND_SOC_DAPM_SWITCH("CLK EN", SND_SOC_NOPM, 0, 0,
>> +                         &s4_toacodec_clk_enable),
> I don't see a reason for the user to control that.
>
> A user controls if the component is enable or not, and possibly select
> the lane ... but that's it
>
> You could have to flipped automatically which dapm when the component is
> powered, that would make a lot more sense.

Hi,Jerome

Thank you for your suggestion. Can we design it as a supply widget for 
tocodec bclk and mclk control?

when dapm poweron, and supply widget power on, Users do not have to 
operate additional Kcontrols

>
>> +};
>> +
>>   static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
>>                                         struct snd_pcm_hw_params *params,
>>                                         struct snd_soc_dai *dai)
>> @@ -228,6 +244,15 @@ static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
>>        { "OUT Capture", NULL, "OUT EN" },
>>   };
>>
>> +static const struct snd_soc_dapm_route s4_toacodec_routes[] = {
>> +     { "SRC", "I2S A", "IN A Playback" },
>> +     { "SRC", "I2S B", "IN B Playback" },
>> +     { "SRC", "I2S C", "IN C Playback" },
>> +     { "OUT EN", "Switch", "SRC" },
>> +     { "CLK EN", "Switch", "OUT EN" },
>> +     { "OUT Capture", NULL, "CLK EN" },
>> +};
>> +
>>   static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
>>        SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
>>   };
>> @@ -236,6 +261,10 @@ static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
>>        SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
>>   };
>>
>> +static const struct snd_kcontrol_new s4_toacodec_controls[] = {
>> +     SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 7, 0),
>> +};
>> +
>>   static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
>>        .probe                  = g12a_toacodec_component_probe,
>>        .controls               = g12a_toacodec_controls,
>> @@ -258,6 +287,17 @@ static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
>>        .endianness             = 1,
>>   };
>>
>> +static const struct snd_soc_component_driver s4_toacodec_component_drv = {
>> +     .probe                  = sm1_toacodec_component_probe,
>> +     .controls               = s4_toacodec_controls,
>> +     .num_controls           = ARRAY_SIZE(s4_toacodec_controls),
>> +     .dapm_widgets           = s4_toacodec_widgets,
>> +     .num_dapm_widgets       = ARRAY_SIZE(s4_toacodec_widgets),
>> +     .dapm_routes            = s4_toacodec_routes,
>> +     .num_dapm_routes        = ARRAY_SIZE(s4_toacodec_routes),
>> +     .endianness             = 1,
>> +};
>> +
>>   static const struct regmap_config g12a_toacodec_regmap_cfg = {
>>        .reg_bits       = 32,
>>        .val_bits       = 32,
>> @@ -278,6 +318,13 @@ static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
>>        .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>>   };
>>
>> +static const struct g12a_toacodec_match_data s4_toacodec_match_data = {
>> +     .component_drv  = &s4_toacodec_component_drv,
>> +     .field_dat_sel  = REG_FIELD(TOACODEC_CTRL0, 19, 20),
>> +     .field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 12, 14),
>> +     .field_bclk_sel = REG_FIELD(TOACODEC_CTRL0, 4, 6),
>> +};
>> +
>>   static const struct of_device_id g12a_toacodec_of_match[] = {
>>        {
>>                .compatible = "amlogic,g12a-toacodec",
>> @@ -287,6 +334,10 @@ static const struct of_device_id g12a_toacodec_of_match[] = {
>>                .compatible = "amlogic,sm1-toacodec",
>>                .data = &sm1_toacodec_match_data,
>>        },
>> +     {
>> +             .compatible = "amlogic,s4-toacodec",
>> +             .data = &s4_toacodec_match_data,
>> +     },
>>        {}
>>   };
>>   MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
> --
> Jerome

