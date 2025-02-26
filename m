Return-Path: <linux-kernel+bounces-532795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49164A4524E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9A16AB43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CD19CD19;
	Wed, 26 Feb 2025 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QPo3Fy8S"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F319CD13;
	Wed, 26 Feb 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533878; cv=fail; b=tpitEiJSBzBrWhqHB8SX3tMPzWwJWzPkIvJJDZcmGYZHETnZ7S7zfJNTg+zsu7BNh2Zc7/0QfLgjft5x3RnRdI183N5nGChheyAKjD6O8BoeyEMyNEhHGDRJCH2Y+Gh79X7dSDDBo1NKwiFhoyEHV6kmoVQFpfNBPTDxAdEUItk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533878; c=relaxed/simple;
	bh=X9HGG8WgwQYnAWPPTRaBo3lH+YLfCOgSIN0udk0czMA=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BvYWP5wCdFbzyjPCoZU4KJE61gnYvwRIwPYbbjrde2D1WFPPWKNjHikTVMIXkNcpuwIKatSVH3gvfxiie5+I3yIF6ws8KyiesQSFNBPbSX7aOlPXIJfzia3vqUf3rA6hTTPrJi7dVp3Kh+g88qLxRL3tO4GfhRBSXgMX9DqB/lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QPo3Fy8S; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSriPkdoFTLqRhF11dTFBexNKUxKE/PqlygJQoOn2OnzS76o2kb9Sd8RhUUGMVrTLN83QNYRLHHSEv7uQXzqY95M+BZTJGbE/geUwvTSo25pACXReM5IGkXM0tuCglpHGXWw3jCZ7/b/oOus7b3JVv0YvA8vR30WRl/dBuTBrpIpZRlKDgtJC/0QjS9bX0vpMTiGIY0nDGHktovdfwy4It7bw2nKFa13vG/L/IgZcB1GJNc7Y9U0f4X5CHpB4NMQerHmnnljCkbkqgxVMz/MUdZ7dJGot8SeUj8PEOLVXO7u6Unmh+WRkv8/pjfMb3Rjy1mWdSRPJlaU6SDpUHTdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzJbVxPlLpBTcT8McYPh4VK0OyiMypzwPa9D4Jd58gU=;
 b=O6A+EEaE/47DttIEp9s0FS2tJsXUCZBUmV8GzTF1yMk3GkiK9ULqitSJVYJCYROIwYzWPjx7/DR0CFd8p7IDTtMdGy2nUR7JQBSP8wTmmPsS/FF0VXl+GWOeq7afO8mw8rkjn7EYo7eXAjBjquD+VGEavJL1zGCHOi+OaVxHFSW1olLEXlnXb71/Xc+sRWMNJPj9h09EVp5sxpdFJRFIjM6s+HYqYBU3MekkD+sbT7ySp/2+jfFzsPALCsjJlcWZ/h2DgJC4yQ3q/pbRFH2zjtfMW0528VT1aiTccrUIa54AMhnrIfDCcZ1HmAXa07ow8IeZf+JpA5IX4MCDfCeqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzJbVxPlLpBTcT8McYPh4VK0OyiMypzwPa9D4Jd58gU=;
 b=QPo3Fy8SioP9X+duajz+4vMweN0vx977tY1XuAQhGQWZ9ijyK0czAvHUzzfoEuPQr7pTFmndhAxwtCkbrVRKrTAK5qp1cWpFjmeFy4deq85yOVfdSQkH/bidBH8TQM0RwAcrCuENp9PibNq95hTqF1/w23D8jlsabY77eOOGwEK+/Xjmk3Kigwx2XoP9qqLQi/dUZnv1bM5saTjxpa1RwJA9YKa1C4Xm8Wav2nruODCxpEpxlbTYZPQXR5ERFpOhTJD11GNl5mGpQx+Lw8i3ChuMC4g+kxvJjWzxl2FcThGm7tj7ykeDezl720m+yYyv2pKtJgCSIlvbJU8k+iukRA==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by PN3PR01MB7336.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 01:37:48 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 01:37:48 +0000
Message-ID:
 <PN0PR01MB9166295EEDDDD734F00BF4A1FEC22@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 26 Feb 2025 09:37:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Inochi Amaoto <inochiama@gmail.com>
References: <cover.1740116190.git.unicorn_wang@outlook.com>
 <f438742bdf7bf3ef8a65e1d88ad57fd1ac66273f.1740116190.git.unicorn_wang@outlook.com>
 <nmr5qzvxxw7psymykjsaivmamt3icj6jqx6qmneofsnp33faf5@p7z6kqumfljn>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <nmr5qzvxxw7psymykjsaivmamt3icj6jqx6qmneofsnp33faf5@p7z6kqumfljn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <2307e934-5a6f-4a10-bad9-cecd57f16a60@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|PN3PR01MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ac348e-5137-4458-e2a9-08dd56062ca9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6090799003|5072599009|7092599003|461199028|19110799003|8060799006|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHZPSVlzeUpXZFpQRzF2WlJtb1JnR09id0l5TzZOaWxwcVBmQ3BOZlB3bFox?=
 =?utf-8?B?cFVadXc3b2wwaCtRb2c3ZmFPT3IrNmFPRUtaSmZsVTZEUXpPK0hUQ2dOSEdT?=
 =?utf-8?B?SkhQV29LdUZoeTZnTklUWTFMRFREQWV2NXpBenpNenNHYlA5cVZHaFBSdkMr?=
 =?utf-8?B?WGI4Ri90Nkx1MWEzUWo3RmRRU0ptRGVZbXR4UHhBZngzR2pQdXd2ZmZZTm1K?=
 =?utf-8?B?RTZIWmE4RkVMbUptNitwZVN4Tm5LTGU3bTduT2c1Qi9JVngrMllNRlhMd2Ja?=
 =?utf-8?B?aVdUT2UxL2NTWFFCbEJMd2VRQTk0bnR5UENha0R3dnZhUVFBUU9ETjBBeDBW?=
 =?utf-8?B?d2NrQmQ3WDVyaVV4T2R1QWs3U2tiWmpuNXFOWEVRMTV6YjZyQkhRaGdKeXlt?=
 =?utf-8?B?SkFGNUZYb3BaZW1CZWp3ZExuK2NBSWdwcnRzcDRrNjY1NzFhMHg3dWI0Wml6?=
 =?utf-8?B?L0diSy84ejlwSGFYdzRndHVQd09oWC82VVlNSFlMMWdGbjBLUXQrNWJJekJm?=
 =?utf-8?B?aG5Dbm9nSmcvaWZja0N4T1c3eDNzeXUvNVIvZjJmVVd4MTQ1U0xXNjcvK2ZE?=
 =?utf-8?B?L2VFZkd4cFRvSEk3aXo0aUN0eUdyM0kyWHA5N3Y0TjBPQ29QODRoS1pGY1Jq?=
 =?utf-8?B?QjRKT1FLRU9DdUdHbjlyWXhtVmFHUjJWVmVQdVB2RlBOVXExNlVOTGZ1Q3JV?=
 =?utf-8?B?Mjh3ZWhXR2Rma1lJZDNlVXFXSVpsdmREOHNHdWJzUHRQV3FJcFc4UndYanBx?=
 =?utf-8?B?VEZSZXNsazdZNmJYNTY1YXJaYk96RjZBZ3J3SEtsZVI1UDM1UkI2aFhra2tz?=
 =?utf-8?B?V2FVR1BSYWVwSk8yUHdFRzVQKzU3VTJERlp6NzRNTXpZVTMrL2hzKzZxVlJv?=
 =?utf-8?B?eVNVY3Z1aDlCT3lwUTFPN0ZHU2tzZWZuV2NqcE42TENtNGkvME4zTWFDUnA2?=
 =?utf-8?B?ZUZvUVRGbnpJdnpaTjNCTlFZL2Z1akpVTmdobDJvQld6L0JjWE1CNjNCeDJE?=
 =?utf-8?B?ZW1remR6c0lwN2czdWQ3N2RKUXJpaXRZV2h3dHhKNzdFUGxnWGJ3MXNCalk4?=
 =?utf-8?B?dU5GUlcyNWtIZlUwZE9Cc01LUU9yM2xMTEU4d29TWUY5U2FOS1U2YjF6OVA0?=
 =?utf-8?B?KzRyTzhGeXYyeWtGMkZJWGZaMTQ2aXp3WlpNU09BZG4vZlE1MzhHUkNNK3gr?=
 =?utf-8?B?S3lqK3JWYlZxa3U5d0VmK0NGTXcwc2xpbWJMZXE3eStMRWxWVWg3bWR6VFhQ?=
 =?utf-8?B?VWxMS0N1czNTZXlYelVxeHBVNVNoN1VRb1BYcGo4THZDWFBXakpzTlluYkpV?=
 =?utf-8?B?L0RUYzMvY3ZUVDNWNi9KK1pRNGw4SzhZSXRVVk5jWUpsc1E1THRHV2JkVkcr?=
 =?utf-8?B?M285VGlNNlUwTUNrYkxTVzU4R3V6cnhWTGNVWEM2cXdSajJkTy9lUDIwdUdM?=
 =?utf-8?B?TUNKUWEwa3hZTmI0K203OFMzb1hwcXg2RzRRVW5VWDVucUNGZm1hN25MbnZL?=
 =?utf-8?B?TVRmR1Brdkt3NGpVemk0SkIvcGhlZW55MHp5MmZ4TEhaVnRsNXBaV0dQaGQr?=
 =?utf-8?B?ckcxQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTVldzM1YjZxSXJIVnpvWWZNQUxUekpNWXRaRThyenJBZGUrSmdPY2RjOUVB?=
 =?utf-8?B?RW1sUEFTUUgxUkhVVjBLQkluV05zU2ZrTU5IZTZJam8yb3FIL2tMekRzbjJp?=
 =?utf-8?B?cXlMaVpNMVhlcFk4NmhvSGRWRDQxU0pGdVNpOVk3R3VWZVl1cktZLzVwVGU4?=
 =?utf-8?B?V3JyZlZBVVFSV3o4SjVjT1N0TWN2Ryt1MDk5dUNleXdZeWZxaVdXRHBFeVJy?=
 =?utf-8?B?eDRkbUVDc3YydVNnYkNGNHBGdjJvY25QMnMrVGdCVzJYRTd4Y2ZZbmtiOGp1?=
 =?utf-8?B?Mk0vSmNzT29vL1p1WTNVSjF3NnBOOGFwdjlPdXlIUUorL0ZPWHo3d01aNmtS?=
 =?utf-8?B?OCtoVysvY0F3RmhRMDA2UC83UlZKRmE4b1pZZFQ2dEtvMUl0VU5zL2VoVTlU?=
 =?utf-8?B?MFlmbzRMemMzRTJPcDJjTm0vUXAyM2hhWitYOU9wV1VnSlhBSytQNHpCdFcz?=
 =?utf-8?B?dlBXOGNJOVVXeGRjM3NBY2IrbEFBYzZhL0xVdGFURVloN041YTBKS2RkS2xI?=
 =?utf-8?B?N1YwTkFWUHNkUVRGTzJaLzBTL1Y5RXR3QlVXczJhdE1GU1lpR0YxRDBDakpL?=
 =?utf-8?B?RjdZRituWk5GQi94UWdhZXdLSGw4NGpQbE5ISHBTZ09yUXpMRndMWGU4dnBP?=
 =?utf-8?B?SUtNUnc5TXJkakx1SzJrSW4zYTk2eXprRStkQnpVUjVGL1VwaDZZcjQ2dTVy?=
 =?utf-8?B?L1lrcTBTQlNybEE3VGxBZkhDZGFYK3l3Qmxmbk9BZkh0dFE1WXdiZlgrSElO?=
 =?utf-8?B?TTFmdmZrczVQWk9mQWE1MFQvVWRTSGc1VTdXdXkwcHRmKzlpaTZ3elZ4clRM?=
 =?utf-8?B?dFJ6ZStxeWVQM0ZoTFQ2UEpyaGpTZldrbURGU3RCLzhmTTNzTEdPNWF3QkVC?=
 =?utf-8?B?eWVwRXVieFRmV3dMNnM4WHJ6RStnWjgrcnhFSmFZWE8zb0R6Y2Y3OGVmZmty?=
 =?utf-8?B?RTNqZHB2Vmg5dnhhTTlndkZXYWNmZHNlQjRMdEF4RVRGRTFEaE5DMmZML3dK?=
 =?utf-8?B?c3loeVVJVE9hRi8wSy9DZHpHNWZRN2JnQjZiQ2pBMmowOVhWY2x2aVZOUWFm?=
 =?utf-8?B?MjRtK25jaE90TjJXWHA5TkJDSnY2eHVmWlNoZUMxU1VTV3lzMlRBb3d2eFQw?=
 =?utf-8?B?a05wY2dvYVQyZnRrM2l3UW9RYzJYRE9DMk5PRFgwN1laa2srLzZWbVpmV3Nx?=
 =?utf-8?B?clVsdTRQcVdEemdqSi9EUHArTFNYTE44TG5Day9YVVR0eUJNWHJ1bE1tQ2M4?=
 =?utf-8?B?emtCTyt6aU85TnZrNDNuRlViVUNRRHArNlFKRDAraFU0b2VybXFqMEJQaWdm?=
 =?utf-8?B?S2p3ODE0L1ZYOS8wdjZUcEdhaCtzWmVndFV2bUo1OE5tVHg1QmZCcG01RUJ1?=
 =?utf-8?B?eGJGRnpKUXgvNDZHUVFhZ25UaysydjY5TTByUmEyc1E1TDhQWlBJTHJUaG9h?=
 =?utf-8?B?VmE5YVhXMDhma1dHazV5MU1LWm5mZDErc2xBaDg2MTZCN21vOXZ4RkNNNDRL?=
 =?utf-8?B?Wmk5eTNNZTRxRlJmSTB6KzlEVlZVRllTWVZDU2NDWlpuRzhOSlNvTkVaVFBj?=
 =?utf-8?B?YlorcVdYRTBQejlIR0xTanNsYWkyUVp3VVpaNmdNYVA4NDBpdkVuUVYwUjli?=
 =?utf-8?B?ZEFxMVg4NkdzZVVDbFJscHYzekdYODZZOURvbEVCWWJGZW5OOEJPZTJSREsy?=
 =?utf-8?B?eGR3OGxoT1crNWYrWkxha1cveXpZWkpxb3h2elErUXQzNFdsVDVmQ050eUJW?=
 =?utf-8?Q?87+QwtsMPjT+ZaLauK1mGo1xSFHUwUsrr55O1oY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac348e-5137-4458-e2a9-08dd56062ca9
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:37:48.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7336


On 2025/2/21 14:35, Inochi Amaoto wrote:
[......]
>> +static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
>> +				   struct device *dev)
>> +{
>> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>> +	struct irq_domain *plic_domain, *middle_domain;
>> +	struct fwnode_handle *plic_node;
>> +
>> +	plic_node = fwnode_find_reference(fwnode, "msi-ranges", 0);
>> +	if (IS_ERR(plic_node)) {
>> +		pr_err("Failed to find the PLIC node!\n");
>> +		return PTR_ERR(plic_node);
>> +	}
> I think plic_node is just the args.fwnode in the sg2042_msi_probe.
> Just reuse it. No need to parse this again.
>
> Otherwise, It looks good to me. With this fix:
>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Thanks, I will fix this.

Regards,

Chen

[......]



