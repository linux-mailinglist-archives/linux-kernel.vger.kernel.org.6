Return-Path: <linux-kernel+bounces-527258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE3A408E6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A271173E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A114F9D6;
	Sat, 22 Feb 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pJ7XPNeU"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010005.outbound.protection.outlook.com [52.103.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3243C47B;
	Sat, 22 Feb 2025 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233866; cv=fail; b=qMoljLeaK/35OzpsqziTSq8ixh+s3w29ekyH/+eRnBzDr1Yq1wmGkrMGxgj7vovaT4Wkl/FUVyIiyg7jjEf8dWFh2iLdUR5JIV0jbxAnSsDRDCwtRoAYuhkdtzABL+r7JXRRwCTDb8qeqz7uZ15CrzkcrhugRMz6OtKxkOyhACI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233866; c=relaxed/simple;
	bh=3WlVXh0bEfY5yLqrEV/BcO4RMophuh7SwA7ST1/ebtQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VaNIRjUVKImN6PS1IM6yBdts5FL3UqDDOAsfZRfELUqGyEeUka9O1hy1eImsjq4dVkgqNeZ9i9nuQo5nYVupyhLarxqIyS+FFPEB+aq+V9VfYA/cDUktlwsCgaMyQGi9YH/zm7DClQ6KB/xoxrTYMdVH+mf6NISR3KeBGOyskRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pJ7XPNeU; arc=fail smtp.client-ip=52.103.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaCJyjgiSWuCplsKiFJON0WH7n39ucICUz5NQFhRnfXftZASOhBm8J57cv9v/k+ASRRDsUdtKGizmRSMDoBKtWA4Jh+Yg1TF5hbC0JCX4EOc0tzz1KmHV6gMxLpP6fNAf6XJuqxpNUc9Mn6uI5yqG65O1eMQoFR/batmmviWJB/fDh+fXSkQoTDUc0CMEHmP6YOxZ44rs8M4bsEEBP0U3lWgfsQm+HmVCF5iiSWN8JE5KJXDpSgL1E5pfdxstrhMUc+vwcv9MRcbU5StKoZvgjO+J7ApjRaj+ZyYRXRLl04DHe7Nhhl51xBL23OPZIgC/Fi+f5eshElkim1fNAGBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/yn6vE8K9IigGIAsnWowl2Q8oXiaq+o9Dsh6vbDmZM=;
 b=kOTIQRxDDsvgSBK2Ajiia2tX3iHmrgW7CjT5BA4wnoAnDHxaJnCHWzcP3Q7YO5OugRItVZ5ftPnDc69EeP6VxdiY+VlVxtK5FfYm9N+H1a+dqd/23YjkLmqEOb0PkQl7g5W1OsSOhjf8FYtnK86raZ5g0ETV+js1WOlQ0bbhv4jsX06DaANR9ZGYS6r/vH8omYQtoiADNTHM6UnAPL+2NnZ9cAQtNpBATlSABn8PMGPvPFV9tJtu6/cYPf8l77nf8JdY7P1/rZtTC3AqLfCtFq4PQqeH86H4jFJr2PrVZqVRmzy6wsATKTZon2Owd7toHAK/mMfMcHvAAs9k4wFPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/yn6vE8K9IigGIAsnWowl2Q8oXiaq+o9Dsh6vbDmZM=;
 b=pJ7XPNeU4fJ5pdbx7p3Paxokq5zH26duaPei7fha8bfV65shk/WeuYuo1hUPvUOA4pVslb4AjLOwyiNAJH1CI7J1oD8SgRnZ8S0BrXqjfXvRL2jol9JFY8HX2NCol1cElJDCmYK30XHXJ/3xo6DnlPOmFCQ569rR9+PFVcP+TP7AnuzMKA8WhigMYeacsRIO/EPO7MvnVpIHhp8p1mAq3NcHN4WVhmRbmld6/+BWxSqd4irWTdwvXr5qlZeGFhVd/0mN99ebNS0V1LOG0fqeNHv4XF4i3PzcpUL4J++mMjbsmwn3pUwFT3+50Qlu0NxXgAxbHwAfyTSd5z3KKIJMKw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYVPR01MB10687.jpnprd01.prod.outlook.com (2603:1096:400:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 14:17:38 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 14:17:38 +0000
Message-ID:
 <TYCPR01MB84379D3E0552FD990424173C98C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sat, 22 Feb 2025 22:17:34 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: dts: starfive: jh7110-common: increase mmc0
 max-frequency
To: maud_spierings@hotmail.com, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250222-fml13v01_emmc_speed-v2-0-3ffc5b1f5663@hotmail.com>
 <20250222-fml13v01_emmc_speed-v2-1-3ffc5b1f5663@hotmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20250222-fml13v01_emmc_speed-v2-1-3ffc5b1f5663@hotmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <ef4260ee-2a30-4a19-92b1-21153025f193@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYVPR01MB10687:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d81b58-58a5-408c-0f76-08dd534ba836
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|6090799003|461199028|7092599003|15080799006|10035399004|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWc0dE9Sc2hCR1pZUkdqUlJIT1kwc1d2UkwySGp3NnhGdEs2SXNIanM4RkVU?=
 =?utf-8?B?VXhqaTFFUEJRdCtYMkdHdXVXSzlDQUdtOFBPVjR4c2lpT0IxbzJnVDRpbmVE?=
 =?utf-8?B?dTV0RFgzc280ZGIrMS9jOVpsWVJKTExjd3BCYXdaME5SS1lZVHptUml3UnZk?=
 =?utf-8?B?U0pxZjdNZHJ6Qmx1dXBXQkp2UFFSOTFBbzNhK3ZBcFJCMyszNUtSNk5HYUpz?=
 =?utf-8?B?eCtOVFpJc2NodFN3bjdwTGdKZXpTVWoydkhheFkvYmk4S2lJT3gzaTBrcU1L?=
 =?utf-8?B?RWhETThUL2JzSHBwZXcxN0lTcHZjMUNHMExaK0Y5TXJ1eHh4aFVBU3owTzNj?=
 =?utf-8?B?TVNtdEJDUmlMUmdOMytESDhWVmpNMG9XYjVJQ05oQUlLbHp4RTR3T2FzWVFj?=
 =?utf-8?B?bWl0Q1MvNnJKdm44TVFncTBTT0RSNVBodDBvM1JkazlFMVRjcDZwamFIREFN?=
 =?utf-8?B?RVIvTG9ZaG5qK2luUjdrLy9IUkhZOUViR1R2c0ZSbXRWS0NFTmppY1duQmZV?=
 =?utf-8?B?Q3BqdUFGcTFBUjlGOWRrNG5UYVZrcnNFV2Mraml0MU9MMGZvYUYxL004TW1M?=
 =?utf-8?B?dHpiMHRHZjA3RDdNRkV6VTNWdm9TZy9lRnNNTXJvWlhVeUtMTnFubVZrdnNu?=
 =?utf-8?B?QnVMZlkraEQ3WWhncEd1aWEwN2xrWmdKdHJnakFLMC8vMlJIRE5PdFZJQmRa?=
 =?utf-8?B?WEhnT2t6N1hCMTdKUTM3SmhObkNCNW9YdXJhQ1djbWNOMXVyTWJsVmpYSUFu?=
 =?utf-8?B?c1VIUHBRWmVZeXlmUVRFeDU2TVUrTGFlbXBMQ2dSbUtKRVNPZGJrWnF3QU5M?=
 =?utf-8?B?ODBoeW13Z3dxakhVRFY4dkNzV1R6L2hhQkY5VnpGN1pDSDhva1JUeDU4QzZ1?=
 =?utf-8?B?dEkrSm1PUFZrYURRWSszM1orU0NCT0M5aHBZUVhjMDA3WlQzMzlkaW02OWRz?=
 =?utf-8?B?Q084N01JV3VHb2hpcVhWZVc5N2tFWXpMV3p0Zzl0cGp2bTNwdm1pejgvdmtX?=
 =?utf-8?B?ekt1dGVBV1lvTStueGYzMFBzUjNVREhUMDN1SzhsTjlFL3A1bHArb0xsT2dL?=
 =?utf-8?B?UmhXV3ZxMllLb2FiQ2hXY3VpSlhXZHBGTnJYN2k3SEwrSEE4TXVMUWRoM0Rx?=
 =?utf-8?B?VEw0NTB0Y25idFQ3WE1EWXRZeERIR1QvSXZsUWZMNHMrRmt2UGcrelM5WGVn?=
 =?utf-8?B?UytBZUhJZWJhTnNkS3BRZkJCODVjbW9MMWpxTWpFb3pMUERRMnFRNExhdEJm?=
 =?utf-8?B?OWhUNVdPa0g5YnBGRG15M1R2dVdEMk9oZnJDOWRoc1ViS3Y4TU90dzJBSXFq?=
 =?utf-8?B?dDR3Q2NybzR2WVE5NUdweThpMW5hQ0hNMy96WGZGOU5mWWlGanJyczIvMWFG?=
 =?utf-8?B?M2EwbnFLM2VLZFhTNGdGU091VVNaV05yazBqTGRkYTFZczV5SHZkMFFrVm9w?=
 =?utf-8?B?UmE0UVArdGpyS0NYekI0cmVmeUNuYld5emNGUFZ6blQ1OEtLdFNMd1d5dnI4?=
 =?utf-8?B?NWc0bnIvUW5VUitPZG5pUVB4bGV0bHJDeU9IMG05RjhpYnd6dXZSQWZmT3V5?=
 =?utf-8?Q?oOCks3ECMmB4694DCe7uRIXQkWEf98P2c74ktrhKiYGN+5?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OERHdG9lMkltNUgzRE1xNzdoOFVhUWJzQXpzTkN6L1YwOXo0QzJXU3VHMTVn?=
 =?utf-8?B?ayttUkowQUhrczNhcG5rWmFtZFEzOTFpM0hBTHp1bkJkTkM5bEdpSW80YWZM?=
 =?utf-8?B?NHkxeTlXWHlBQitObm1yWU1US0gxYTRUTXNYQVZGRVk5Z1NpQXJqcUZBVFJJ?=
 =?utf-8?B?clNFOWV1SFZoSUllZm8yNkI3WjJmd3ZmNTF3STFyd3dUN2F3VGdBVVRRYzdr?=
 =?utf-8?B?ZjZOUWpQZU5Ta21Kd3RnUU1IMHpaRVVkcHRsRUhKVE9BamtJbndNeWxBV05l?=
 =?utf-8?B?QkhkMTZJZlQ2ZUdXWld2cWUrU0NrR3VLRTArRzlGbEwvUDR5ZHp6N0dheGcr?=
 =?utf-8?B?NE9xK24zMno5czJsbmN3VkV5Z2szSi9CUHB2aHhMU0xxeWlVQUNHeHFwQTRJ?=
 =?utf-8?B?WC9pYmdFNFJscWV4NElpU0V1aXdiVDNlU2p6RXlXQVo4bk4vYXhhWVo4enpO?=
 =?utf-8?B?eWJoNkZ0U2pQOTgvN3dyZHEybTNFSk9KOC82U1REbmNpZDNKTHl4cFQ5WkJE?=
 =?utf-8?B?ZTM4cHNJaC9WOEhxSG05b2ZyaW9qSFlpZ09QbTU4THQyZ0NOUFN4NmVVdTZk?=
 =?utf-8?B?cGRkbGZPdnhNc2lGZWJZTi9ralZtSDk3SW9GRnZzcStSdE15NEdMcVkyWGtI?=
 =?utf-8?B?ZzZHMm5ia0ZXYXQyRVl5aUgwMndXOGtuc0QzU2dHM0N2TGVHeGRkUGs2enVH?=
 =?utf-8?B?dnVzUWYxbDVDVkorUGZ2bkRxZlUvMHhCYi9wY210aXNtekF0OGxKRE1GQ3VP?=
 =?utf-8?B?SVVrSyswZmlReWNKaTZHZytCaW42NmtwZHdMLzBMWmdWUS9xTmpmbUt4L1c4?=
 =?utf-8?B?SjdxTEhqSHllY3FiKzFHaE1YNXVjZmdRUThscitBbEhGb0F1N2ZPajJjSitN?=
 =?utf-8?B?S0JsNGJvYXRPWkV3VmY0NTZ2ZGo1cnBwdUVOWXZMSWhWOWxwdTZndi9JS3Ar?=
 =?utf-8?B?NWpIajVBeWQzYjJmR1NkK2J6cHMvNWUvSDMrRVlwK0VRQmhYRVArOGRVZnp3?=
 =?utf-8?B?blo0Z0RBYmQxRDhaYnBwVlNtWlNNU1VORGRsQ04zTk9tdExXdTlkUXBuczVs?=
 =?utf-8?B?Sk1KaVdzYXBiSHpXY1Z3Q3R6OCtWVWNPaHROc3RIR3p6OFFoOGdWcGhTbTlC?=
 =?utf-8?B?ODg5UXc3YXU2NkFVemJFcmxmS09WL0NsT3U5aUR0SFhUTWF6NXRHTWtCQmZD?=
 =?utf-8?B?UEJIWWRCdGlOU2d1M1lBSE9aU29UY1BxWTRUZ3pZZ3l4U1ZFVUh2WkQwdXdR?=
 =?utf-8?B?SWFKMU5zWXh0cXovVmtWK3VWRWpQck5wU0hQby9IQW1KQkxaeGpOdWVxMS9E?=
 =?utf-8?B?MjlOY0R6YlhQZlhqNmVWbXBMc0VKcjhKRElZc3VSSG15bDMzdUp0TmFVaVZ5?=
 =?utf-8?B?VW01MDJWTkt0MzQyV2g1cHNZM2ZITTcyS1hBUnYzTmErbkZydk01bWp5YXBt?=
 =?utf-8?B?aTUrU0ZrcjdibHlQQWpCUyswa1lvaURhemExS3pISnpwZDJQRXAvUm1SRStC?=
 =?utf-8?B?SEhPbkFFQlRGWm5neGtVSUhIdXVLUXZ6OXFKVHk0RnJIUzVKa0w0TEYyL0dB?=
 =?utf-8?B?TkkxaVZ1TVI4WE1Xc2FxUFRHUEpJa0tXTGpaNGw4M3NWUnBYZmNXdDgxQkk1?=
 =?utf-8?B?ZDNsaEQwTUNPYXVvNXRUYUxWN0JnS2dKTHdySFJCK2pkVEJweGZKWUJ2R2Q2?=
 =?utf-8?B?Qjh3Y2VmdHVVc2JGa0JIdG55Q3BJaEJhNUovSVoyZkFXSVBKQ2YvOGpyaVRD?=
 =?utf-8?Q?MyzuC48ojbCe3NivEI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d81b58-58a5-408c-0f76-08dd534ba836
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 14:17:36.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10687

Hi,

Let's continue our discussion here.

Will EMMC speed increase if we only apply patch 1?

Also, about your clock-rates modification in patch 2, I CCed William Qiu
so that we might get some more information about this.

Besides I've done a speed test with unlimitied clock-rates and an early
state of SOC clock driver on visionfive 2 when I was working on AXP15060
driver before: 
http://forum.rvspace.org/t/question-about-sd-card-speed/1741/21

Best regards,
Shengyu

在 2025/2/22 21:34, Maud Spierings via B4 Relay 写道:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> This sdio interface is capable of more than 100 MHz as already indicated
> by the cap_hs200-1_8v attribute. Increase the max-frequency to 200 MHz
> so users of this dtsi can increase their SDIO bus speed.
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index dd2eefc295e5c8b568a02104ec2189e66b378904..19ca8dc24617c2ad565a4a9b2d9af9bd9491f22e 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -258,7 +258,7 @@ &i2c6 {
>   };
>   
>   &mmc0 {
> -	max-frequency = <100000000>;
> +	max-frequency = <200000000>;
>   	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
>   	assigned-clock-rates = <50000000>;
>   	bus-width = <8>;
> 


