Return-Path: <linux-kernel+bounces-527277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6DAA4091E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89D270385B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0816FF44;
	Sat, 22 Feb 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FD6d/5IN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2033.outbound.protection.outlook.com [40.92.91.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119031474A0;
	Sat, 22 Feb 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234719; cv=fail; b=Z79A5qH+z6QRvSof6iU4mtX+Lv5mkUlIqHjSu3XdcwvREpTbRCHfEnuFXpl8Y0WG22MGe8ut4gYwTXnj8YsisjMCk773hWLHCxYt/wvNNmHd2VcORxbIkcHhamMZtcDVc4a6Nub56fbPyU2DhWaoECenX3OG/qI+FdITF4090Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234719; c=relaxed/simple;
	bh=fnh/9a74AP0poamv2z7Esi+W6A1+bIPu83EjyIRHTqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mwi+Jw0EvkExH+Ouo94J9IfLz8NssM1qu+npo9U1WT/awkP/bsexPEYe7rnsCmukD/1i4tb0Lbs/sLbk1Ruti+Zbt5MCEuyOptOejExBvbj+AkwKIIEKN14ZKqrAGy4UKH9/YE6BVgjaXd+iqTY576xDo4BfSOw00+ltZFHaf30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FD6d/5IN; arc=fail smtp.client-ip=40.92.91.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvvnA07zOsQV/ciJGQjL02XtgHk/2DyE55BbsX8LfURm+HmxxKiVevSonipupnlaD7GTNoTvP0lO4CEtaUJJpTu6OTP5LgrzC8FgxxFdn3lp4BKD/atydCJnEDZp9HSpXIpIVyCb3eYsFFtODraeEfP8w17xN0nMo10HwvJ3mqGD3qVFmdnJr0EUppjrFsoCUngi2TuxD0ABNF7zc/cU/nOdX8gUwqE9tYYvGPurqtC6mt6CVqTkQQ9YK7jknp2X7tdDTX9QC4A6YM6jLktLSoQw1wYWyNc1SeGGafNEmZBOFi6bHa4KwATkcQpM1JN04KFQkH3aQphhcCCzm8q3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb0dHhOEMCMoSTnCCmT1HISpX8WATd83gVJf5yHGMtw=;
 b=oVdwiluf+jmHMPSFvRe2ovU51G1ndmMM/rnlXiqKnRMHzaAab8gFrmDqAf98lJNGrh9GOPLovSth/Lm1VfKVmmXDo64cZ9HfkkW7UOZZpjene693r3y+Sa+oUzGrQIdtC4zjdmbY7xxzDbtUWQV9YZMnfcTvKym+3YH5ZjwGEdruYSgb8oZ/KmOX91x1qBw7z01vCytXR8hX0xWmfEq/U6NSUa7Ifn23rFUA3iqs8bofUCGsfIZM0khnOpd/S24QtsE/Zj+2V4ghXeZP4Xy5HmQPHwEFhx8wHXiIQnuFoZtPL1ElWKCQunum3/eHdJ2Q90cp2pPoOJDwDO0qFOcWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb0dHhOEMCMoSTnCCmT1HISpX8WATd83gVJf5yHGMtw=;
 b=FD6d/5INgEyYh0Yv2tf8v3Jv1vazvVcZMBiPrE6KGI4/Vmzfl8MB6a3TVVgQa2WwgP8tUAqHelE6C4BlYczdretxaBSA4mR0eINC11cYpInTHUM6zNjnTDLh3BE1rMG/JSXX5sCNkboRiC8k+6blhnBQvfHsyc1A99SYnREqqfnuO4nyKQLj07h5CHFAPef65/NVGa+yT6X7qyB6Dmhs0rCLJ5TToCedhWL9HbAf/bnal8jsI9Mr70tDhm2SMuvKWcb7Dw+oBvnYp6j1M2/g/Vk/rM06RECSVsCK6Vcstz1MssGYb+REPtGedkhK+PvnD5NLMiTetsBky9M5lmXP9w==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS4P189MB2136.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:51b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 14:31:55 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 14:31:55 +0000
Message-ID:
 <AM7P189MB100934B6F2EF4339243CB81AE3C62@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Sat, 22 Feb 2025 15:31:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: dts: starfive: jh7110-common: increase mmc0
 max-frequency
To: Shengyu Qu <wiagn233@outlook.com>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, william.qiu@starfivetech.com
References: <20250222-fml13v01_emmc_speed-v2-0-3ffc5b1f5663@hotmail.com>
 <20250222-fml13v01_emmc_speed-v2-1-3ffc5b1f5663@hotmail.com>
 <TYCPR01MB84379D3E0552FD990424173C98C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB8437AA5D22665A38D56B895698C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <TYCPR01MB8437AA5D22665A38D56B895698C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::24) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <cddfe571-c861-459d-83cb-4efa2addbcb9@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS4P189MB2136:EE_
X-MS-Office365-Filtering-Correlation-Id: f63f037d-6fb9-4734-39a4-08dd534da7ed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799006|5072599009|461199028|6090799003|440099028|3412199025|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHNEVk4yNTVKOTczaEhUaVprMUFRekNhM2xWeHdvVkR0bzZGcHJFdlNrLzJr?=
 =?utf-8?B?bHAweFVINTFSTE1CV2FNQnZwSmdRblI2OHN2dEY0NmZOUHVtbm9iUHBEZ2Fx?=
 =?utf-8?B?OVpmeXQyMTY1VVNZUUpEemE3dFN0aDBDcUVTUVBJc1Y2aE4yUW9FZ0hIWG5C?=
 =?utf-8?B?em00bHg0SCtOMkwrOWFyWXd2L056Wlg1UXBaWDJyRXVSTmNzbzlTbW9SQlB3?=
 =?utf-8?B?Q2ZEMDVTTVNCenpEWTZJOU1oQTdTaFRWeFA4U3hkWGJmTmVtRGpHcnhKSXZy?=
 =?utf-8?B?cllOODFvTjVpS1F4NU02REMya2tiamlxaGtVRlpJV0dpc083Q1JMUE1sU2Zv?=
 =?utf-8?B?NU1VbnNBSzk4c2Z6dHBsdEdrRXVlb0s5Wk5iTi85VzhXL3BvYm1DSERMYzU1?=
 =?utf-8?B?eUhRS1QxRE1tUjRKQUloYmpnZXBiUzVnQU1mNHQ3c0ovMkpkeUFaVEMyMDZS?=
 =?utf-8?B?WmNRZGkvV0RTSTcycnBRdjZiRS80T3hFamFDMU05ZXZjUVFlWFFJeWtZZlVW?=
 =?utf-8?B?UjU0TEpJenE3ZE8vdGxiajI1UUZXTndOY0E3UW13TGMvUmd5ZVdaeDFyQWlk?=
 =?utf-8?B?RURjam5aT3RwNTArMEFJT3d5L1FOWHFhMUxUcXgwajhxOTFjZGk0UVNJOWdi?=
 =?utf-8?B?WlI3c054cnhtckNYWVAvN2svYm8zeWlRN3JrcUtkUjd3NFZkNkNyZlQ0MW9Q?=
 =?utf-8?B?eHJQOHJsR2FZUHp0aHlWVHpITzBIZkVzOHN6WEE1YUZrNEdNbGRmVDFMYWov?=
 =?utf-8?B?bFVRQWhLZ0pHNE9RR0s0aUNPbWtpbTJZZ1RPTmo0VGM2eWIzSjU0QldrUEhP?=
 =?utf-8?B?QStFRTF5N3dZMG1iTkdVOWtwc0xVbFlPZ3lLSWpRWDRVeGs3dFQxTFBQVzhs?=
 =?utf-8?B?UDZocG1zaFFFbXJnN09BbTJQODVFaHYzYldhWlg0Z1NNR1lwUjFTdWp0SkRF?=
 =?utf-8?B?eWJ6MjQ3bXQ1ZEUvRjdLM1VtTGx5UUE4Y2xtLzlDSWY5SXVjbU1LMEtsVHRL?=
 =?utf-8?B?VFIrWkR1Q3hSQjE3eENuU290MkJjbDFiSTYyNlRSYXQ2bmlPSHVTeE5sWEVZ?=
 =?utf-8?B?TS9vWGdBaElKQ2NxWTFvM0RLQThKWG5YQmdYK28rdmkrV3dVRG5kWGtmekZD?=
 =?utf-8?B?bU5XWmZySE5sY21RWGRQTDAzZFoxZlRLZTlNVlBMNERvdjBpc25JMEg0dkt5?=
 =?utf-8?B?N1JGMWJoSVVBTGRlWG9PM3hMOHlDY2s5RnBmenlRR29VS2J3ZmJrY0hZUXpQ?=
 =?utf-8?B?UldoeDAvMEw2S0pRWU9JRzJvZmp2MXg0UUJ0dXBJUEFwdFVIZ1dJRkE1TTg4?=
 =?utf-8?B?MW9TRGkrS3NqMm5YUk5sM0JHQmRicTI1aE54aEtVR3J2VC9iRFZUN1QreUpt?=
 =?utf-8?B?cytOdURhOFBIVnZlUC9JcEJUS29Mb1ErWUVwYVZ6blNSemtqOTMrQXNDZzV0?=
 =?utf-8?B?NlcvalYrRU9tM1VPWFo5WHg4ZERvZ0RkQjlwNGNPUWhwZS83ZjFKMTBTWkVr?=
 =?utf-8?Q?xfgXVc+UBdRC+bGPsGSCkZX+QYH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wkx6aDdWbkJkYWJEMGlHZkJ1NW9FUUtPb21PRXhTMzMvUG5COGpRM0x1eXlY?=
 =?utf-8?B?ZGMyOVpBRHNleUk1cmh0NUM0RnJmTU03cFhRYXFQOUs4azRVTUIzd01zSHU1?=
 =?utf-8?B?aXVIREI5WkZKa1lZTEdWdmVPOUhrTi9rbHhNZlJtbHR5NmFIbGtveWtrYk1t?=
 =?utf-8?B?cC9QY3ZuZnM5VStKUERROW1GaDR3SGN6UDBXMk1BUXBPRXJYYnFVa1U0ZDBG?=
 =?utf-8?B?RlJtUVRpSHpzRGR1Z09YNEVVdzZwTU01TkdGZXo5NllaRUpzU3JqZzJnUXVj?=
 =?utf-8?B?MHFadDJiM2dWcGN1Umg3akI0bGcwY0psTm4rdjlxdlVSaGhrV1BWSXRGMWg1?=
 =?utf-8?B?MlBhNy9lMXMvSllsa3BOV1dSUlN3bkhQMUNtQ2pJS09sSlBBNU1BRmE1cG5U?=
 =?utf-8?B?YXFBU1drUVo2bHBZanpoNXIxbFhtRWNwSjQvTmxaOU9ha3hGcnlqOWJZak9s?=
 =?utf-8?B?V2s2VEZqc3dCeDYxQjNYbmtRZmZkb0Y1MlcwMmxlWUROTVJ0VlB0ODNpdmRJ?=
 =?utf-8?B?V2NSUTJCdnlrSklFVW5pVUlIaHh1NVFmNmtORWlITHdOSlFpSSt2eEFHM3FT?=
 =?utf-8?B?am0vSVIrWmRkOGl0TS9sUExzLzdtRlN4Y3NCMW9DNVREZGNiRi9Qa2l1QmFo?=
 =?utf-8?B?MU1xOEs0U0JyM3dya0QrVHpYbGU3WVJZUUE4QWhKbGFiN3pqc3NRMm1Gdyta?=
 =?utf-8?B?WnNYUWRUVU0rVnhUeW5kUzhhSjY0dmxBRjhlZ29OelIrTDh1ZEgyRFlVQXNV?=
 =?utf-8?B?dGdXVm01bndRWGFCZkE4SUNiL3EydFB3Q2VjUnlGdkFoWDlzN1l5RzN2VWZX?=
 =?utf-8?B?czEvODl3dWxGQmFaQlNnMzZ1STZmUVhVTHlxUCt4ZVFLYkZwQ0dOU2JGMEV1?=
 =?utf-8?B?SlJmaGxXekNmaW9MMzFZdEIxQkQ4YzE1MS8yQVlQNFhFcTRTVHc2SGRjMUk1?=
 =?utf-8?B?UnVLa09xMXRIVitJdWh3QUR2Tlh1ZG14SUNwWGRXTVVvc3pSSnVSV0JMYVVI?=
 =?utf-8?B?dFFtN1hpK0NJYWVsMUlWMWsxaVkybmpaRmxUQ0hqN01WSzBEVlQvNjRyUFMw?=
 =?utf-8?B?VGw4WVgzQ3NGbHFpUm9HVStIQjlpYTRSSkJnQmdxUHlIMThRZ1FVV3NtOHpi?=
 =?utf-8?B?RFdaSm5vczR3TEc1dmlBNEN5UkVtS3RvTkhkalZhcXdJSVVRYUhhcS9qR3Fn?=
 =?utf-8?B?Y2ZJOGE3SVRpVDVYTkE4UU50eklCR3BrR01NWFo1RUN6MmcwdVZWQjA5d3li?=
 =?utf-8?B?R3lWUlZtR01zMTFpRDQxR0RWaFNuVk56cC91WXR1VytFVk9CRzg4TnRRVVF0?=
 =?utf-8?B?THgzUVgxSDJ2V0c2YmhBMlZHRjlHdkJ6NjJUY2N4U2duL3VmczdQL212anVY?=
 =?utf-8?B?QlVuU3VkTEhxeEcwejJ3T2s0YStmNGJ4MElVUEZXQXd4azdPK0tpY0grZEJH?=
 =?utf-8?B?NzJiblRPTlNuZGtSSzRZd0pIeFhjR2J5SEg2TWtpOG1COXF4Wk1OTFlzWlA0?=
 =?utf-8?B?NVBrL090Z3J2bkQyT1JCWDdYSzV6ZGpiRnlqSUwwSHdEUktZLzBDTTZWalRs?=
 =?utf-8?B?RGRWRityQVlpV0dPeUUwdUJraTVXNGZQRllGeU1PTUVlZ2wrZm93VklwZnlm?=
 =?utf-8?B?ZXY1VWw3NHVqVWl2ZGNBc2x4VXJiTGllYXBKU25SOTFLbGY1VjQyaXVzNjBS?=
 =?utf-8?B?Ri9vMjdKbWZNbmxub3hSdnk4aWwrdDh6a3F1ZlVTSUhQNVJMTG9LT3BsZkpW?=
 =?utf-8?Q?4OTOy33JvLxiNw/+3aLHH6TwEjAkB+7PZ5ItkpG?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f63f037d-6fb9-4734-39a4-08dd534da7ed
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 14:31:55.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2136


On 2/22/25 3:19 PM, Shengyu Qu wrote:
> Sry I forgot to cc actually.
>
> 在 2025/2/22 22:17, Shengyu Qu 写道:
>> Hi,
>>
>> Let's continue our discussion here.
>>
>> Will EMMC speed increase if we only apply patch 1?
no the speed is further limited by the assigned-clock-rates.
>>
>> Also, about your clock-rates modification in patch 2, I CCed William Qiu
>> so that we might get some more information about this.
thanks!
>>
>> Besides I've done a speed test with unlimitied clock-rates and an early
>> state of SOC clock driver on visionfive 2 when I was working on AXP15060
>> driver before: http://forum.rvspace.org/t/question-about-sd-card- 
>> speed/1741/21
I believe that looks close to the speeds I was getting when testing, 
been while
>>
>> Best regards,
>> Shengyu
>>
>> 在 2025/2/22 21:34, Maud Spierings via B4 Relay 写道:
>>> From: Maud Spierings <maud_spierings@hotmail.com>
>>>
>>> This sdio interface is capable of more than 100 MHz as already 
>>> indicated
>>> by the cap_hs200-1_8v attribute. Increase the max-frequency to 200 MHz
>>> so users of this dtsi can increase their SDIO bus speed.
>>>
>>> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
>>> ---
>>>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/ 
>>> riscv/boot/dts/starfive/jh7110-common.dtsi
>>> index 
>>> dd2eefc295e5c8b568a02104ec2189e66b378904..19ca8dc24617c2ad565a4a9b2d9af9bd9491f22e 
>>> 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>> @@ -258,7 +258,7 @@ &i2c6 {
>>>   };
>>>   &mmc0 {
>>> -    max-frequency = <100000000>;
>>> +    max-frequency = <200000000>;
>>>       assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
>>>       assigned-clock-rates = <50000000>;
>>>       bus-width = <8>;
>>>
>>
>

