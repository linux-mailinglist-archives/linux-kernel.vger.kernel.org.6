Return-Path: <linux-kernel+bounces-441041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A999EC892
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D10280A60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7E1FF1CF;
	Wed, 11 Dec 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ulHck9af"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C371FF1C0;
	Wed, 11 Dec 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908386; cv=fail; b=jM6/qOoisnBHQVQpZk3239Uaksmv72UB2yMRSvHiwIQeFVhV5HSOtB90XAL5mX+4bIiFJuuemp5Ahn6pyv9t/IVQG5hy1y61XkFtKqFhPpE3xe6eu9cl8okqToKwyrbrPKs2LvXGHeSUAoeK5cpPY2Tgx2SgPjYDfRP2se/572M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908386; c=relaxed/simple;
	bh=17n20eAV4WVbQOCyrpTJNtZA0SS8nq8WbRaf09qKWSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrGSw+g2rfiFKG4N3RdhCC58YlDuqpkFgrRs1+Uw/90NOu4BKdYBe+yeWODW9F84osJQaP1Km8nLFBN1QNeLa6JTjgKd4NXiy+7GM3tXOX3soPJHJxeNFWxqk8TUl6XxNlUEjyFhzvymwe5LmoycUZi0fPmwgj0u0NffXpB8FGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ulHck9af; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcr6tv872OG8vsmaRjelEoS4AK3Oi5rbLAoWmY1vHXhm5d15QNdSEGXhrNGS6Dk228+8xd+CnlYCoW6Lz5IBEM/SpjKhDRqaeafhEu+30lqZY77qzyepmCIiVcIFlelCgb6enOE/I9ijW7Z3NNH9mNMFaoOv1JK6YAkwDXHYFxZHPlaeyKtbPhXvmwChikOxTGV8MSxeX3JVnGxJwit3mPIbEwG2iS/AjWhTK+DiTbABaxe3OYzlBru3SN1GcOdoMLnOEjB1WsdK2owrEfr1SNRxddeoPbsLU9MGg2I27XFN9yZ148NdUF9tAmnQ5ya05heMFazBvYxsLMmqiaHYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94yjCMc/HLrNPm01UQ+5i2Ca593wYwxfzuCgLUa8Fjk=;
 b=h0lIUzuLSLeGugnVPqpR+LT390eXpDA9ds2CS6u18Na0pVKsJigAm9EauJdhxlWBUs4K1VdgOjwEfhikUKkDRz/T20SE3wqFMTkSQRCDsLvTcUGN53s9P9OLfBgDCK8EQnBA2XEUccrNYxqUl37WpHLfMO+rUen4ggII5ZglIhMoLu6feUXT4GiWu+22lFE3qe85rss5Z2aNCE8lnImgtl8dymTAM2VlV252XM/klZJ6w+im8NGRFtbUGjL8y7VbPe/8VepMUtbDinxiuYXstIETrFU651GmpJz8IOZypjf8AMWi837jvxQapuzul1vVn3Ya0anBSVCCVH1Q7FtTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94yjCMc/HLrNPm01UQ+5i2Ca593wYwxfzuCgLUa8Fjk=;
 b=ulHck9afoT8KVqSLiXd4gI+mP75BlpDdlTG8ozHmhMpJ7Z7UiFFukkM3KrZHl2vqptJhcnKEchIIuzJN3185komfF60bhFRq1gBZ6UtUJ7pFPpktjvYStN65UAImSe1Ekw245QueJUZsgUj0CYH3fQb+wAvG3erFpGPK1y4gLVXYTmc+UcCM8yZvOSz+T6IJ675L7qDNWkmxdN6MK33HVACMeN5nmTNmO4P1nOxf+FEtpnlx59RnhSr5bR9c8GdtPeTg3MzT+C5iAGDvlyWUp4IQbu7rATzxU1qMvKTl67PcF6mM4kGBOWgk2dMLN6akws0b4q6+7j9aPZVcf6VnGg==
Received: from BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:13::10)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:12:56 +0000
Received: from BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d3b0:ebc1:c2d0:d13a]) by BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d3b0:ebc1:c2d0:d13a%6]) with mapi id 15.20.8207.010; Wed, 11 Dec 2024
 09:12:56 +0000
Message-ID:
 <BM1PR01MB45155030455EF60357397291FE3E2@BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 11 Dec 2024 17:12:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Samuel Holland <samuel.holland@sifive.com>,
 Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1733726057.git.unicorn_wang@outlook.com>
 <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
 <51757598-18c5-4b44-b11a-54db07384131@sifive.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <51757598-18c5-4b44-b11a-54db07384131@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:13::10)
X-Microsoft-Original-Message-ID:
 <9b045c28-7e08-49ed-abcc-0a54eb53fe2b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4515:EE_|MA0PR01MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3072dff6-4ed5-4e24-df01-08dd19c3fffa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|19110799003|8060799006|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWtpRmFoUlhvK1pTcStIcWhRcGFpNDFTVzFhK1VyYloreDRPOWdtVndMTjE1?=
 =?utf-8?B?UTRZcUJnT213TkZFRlB2ZlQ0SllzRk9NcVBCK3FqYTh6a3VBcWtrbDhLUlp3?=
 =?utf-8?B?dmsxSW9JejNXNW1xcnk3M0hoTG5yUE05WUR4NGdCLzFGT0tnN1lTVHNZNWhO?=
 =?utf-8?B?V21EeFZmY1pUL2VvQ0lJMXcwNnZkZms5dHlPejNySWdvbEJxV0VIUVduWWYy?=
 =?utf-8?B?RkdRVWw5cm9CUEprRUpMSHYzVkNOT1FuaUJ4QWRxR0R0QUZlQVlSTlFGM2NJ?=
 =?utf-8?B?cUl2YzBDUEpTVkY3QVpUNjl5eU44MTV0MjAxRUpVOUtneVdqK2wzUmIvek5h?=
 =?utf-8?B?YWJpSkZMWlFiUnAyWkZtdUYvMGFHNUxIOHVINUVhQ3htNDlneDlRUFFxZm9p?=
 =?utf-8?B?NTh3dHpMMEpnTE5GT0U0TVVtbmNXWWdPa3hhMGdBNWRxTFVMVmFZRS9pM1k0?=
 =?utf-8?B?a0d0ZU5DcURwSmh4ZS9Ub3ZRbTJ5SDBKK1lzRFdIZEE3UWVtRXQ3TFc5Q3gx?=
 =?utf-8?B?M1FpUWJJRE1oaDJTV2o3ZWxRNUk2WHdiaWdGbE9hVkF6cVIyYmdrVUdtUndj?=
 =?utf-8?B?cGdFYncyRDdEQmVFbTFHaGEyVXUyTVRhQzFNa0tTOHFJNFlsQVhWWFg1eUpX?=
 =?utf-8?B?YzdMbnhmVWF0K0tVWEY1aVQ5WWprS1gwY3BWeGJiYVdsbVBxTFNKa2RxZUxt?=
 =?utf-8?B?dnpEcGZrNS9ZNVdRUS96cEYxNXVJWDVTMk9YeFZVdUgvbGtQY1REYUM3Y3kv?=
 =?utf-8?B?aTNvQmJGbDNQVDhjRWJBdkVFRkFWL3NWYm1NVlBCdS81Rmk5QnRKTmhFeC9Y?=
 =?utf-8?B?Wk1tZUM5TUF5WklHVUlBSlU4K0c3UFRFTHBYTENpWW0wNUhad2hJN2Y2RUZ5?=
 =?utf-8?B?UHV4b2dtNGZjRUFwNXIxQVhvZ2ZHWWZ2Sy84OHlDQW9iaUE4TEhPSU5DSk0x?=
 =?utf-8?B?ak9IclNXRGNHcEpZS3VDNUhJVzREdDdvdUxnNitrM3VxZTN0N1lnOVVsTlNR?=
 =?utf-8?B?aGRoWEw3QTRRaXV5bElsdFN1VlVzcVhjWXY5ZUJraTI3NTZqNTNQS3QrSXpK?=
 =?utf-8?B?alJra001WU56eEpDQ1B1UHlSMXhIQ1BrRjV6c25CSWxKU0FJNHlKTHJMUEdE?=
 =?utf-8?B?VjdhN3dIVlJWS1FaVjZ6dmxibFhzL1p6MHhkVmtrTTE2dXRUSUJhWFNiUUtp?=
 =?utf-8?B?d3Iyd285d0FSV1VjKzA1T3Y3cklKeWhIbWRwZXQrQVh6WjN6TWpRSzd1UWU5?=
 =?utf-8?B?NzUxU1g3ajB2ZG1VUlk3bWNuRDJqY2FiTDFiNmgwNW8rM01ZY0h1UnBZdWRJ?=
 =?utf-8?B?aS9hZ1RwWms1aVY3SEVqOCtJYU1JZUR3cEUxRWppQXd1YWhWWi9NNHMvSVpV?=
 =?utf-8?B?UmMvL05kTjBsZUdBYzRkMzR4SFFDb1R6TWFtYm1qMlhuL3g0SlRFRkh6K3Fw?=
 =?utf-8?Q?SY2xxLKk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhkYkJ2ZTczRUd6elBCRHZSMjRuTmRJM1JQbXY3MjJ6aTMwZmFtWTF4eG05?=
 =?utf-8?B?Zk9LcDZPcURtYnVLU2lLYjFEVytCaG9Sd1BQcDRDUWd5Wm5tMnE1WmMvMjZp?=
 =?utf-8?B?UERibFJVVXJXVVRJTlNma0FjQXYvVWNYZjF2bWdHUzhuQnNTeWFXcVlncEsy?=
 =?utf-8?B?UHU4T01KS3A5NEFEOEVlS0RYY1NlZWpwa29sbmExSHNZR29DVU1UcHNqSFpR?=
 =?utf-8?B?TUdUSmhDeUVIa0hoeHpGZ3VPZWUwVC90L3RqRUpKZHhiNzFtWURLRytSc3dD?=
 =?utf-8?B?dXNGc29wVms4WVdrU3pUbG4yN1pXbERzUTd5VitFM0N1L0Z5T2thNFQxSGk5?=
 =?utf-8?B?SjlnaGQ4QkhmdlBjVFZjcnRsTUQwRkJzeGIxY0dVTkZNbWR3SEJXLytCcUEv?=
 =?utf-8?B?TUdlM1dJcEZ0TjZUQWtjVHJFT3lIZFQ1ZU1leTVkMnVCRHUySlhTbWtTVC9M?=
 =?utf-8?B?b3BsNm50OURlNGZVcTNjY1ZmWWRpNGJXSCtQTDRhQ2RLMVRvVkdEMlU4YVE2?=
 =?utf-8?B?bHNvajFqT0lkOHlUUjVoeFFNSzVlL3NlQWR2MElCT0x4d1FHRUpOVkdmaVdv?=
 =?utf-8?B?ZnZSaHdLVWp0bjgwdEg5RzFMYXYrVTg1cC8rc09tRG0vM1c0anEvNkdqTGtC?=
 =?utf-8?B?cFc1TnBLWkovOGVYamJGV3NCYzN2NVJsb2F3cWl3NXhWS2JDeU51bkdXVXBG?=
 =?utf-8?B?RUI1b3ZoVlVQbXU5R3d0QVZsZkdYM0lnNHlOanRQVmxzQXRadHpjMG1vYTdv?=
 =?utf-8?B?Y0FqR050YjVqYjBjeXJvcjFLcWVsTk5TNUtLbHYrQ3QxdFJZZHdvby9XVE9F?=
 =?utf-8?B?SlN5T0pNSFZJaXd0TXZ2dzNBOThKWVpmaG50S3FzaWh2VXErTGdSRlV4S3hS?=
 =?utf-8?B?OWhXRUttUkRLM3luQnlMbjJ0RUttajRaUDB2cktYamZPeU0zNXZCNGtOb2xv?=
 =?utf-8?B?dzluZDRXM0gvR2orWkhTeUh6TFo0Y1RXUGtYUmlNNW9oKzlRaDVGdzVKdEpH?=
 =?utf-8?B?K29lQ1JoUE5BWm1UZkR4cEg4QXBNK2swQWdiYXZTc2IvZWp6L0grL2lGdzFj?=
 =?utf-8?B?K1ltQnVkcC9tais1b0dienV6ZkJVeXBDVTY4dG1GOTNra1k5QVMzMVBodG1L?=
 =?utf-8?B?dVk1UjdHWThSREF5ekllUEhGUlNibzRGbHJ0elFFODQrWmMrd3hiODVCa3pQ?=
 =?utf-8?B?eUJsK0xsTnc0UmtYakF0eE8zMExIcWRjamVLdXhKRGloSkhHaG52YktXaHlK?=
 =?utf-8?B?SzF0eW5lNGE4UjR3QlhXMFMwV2gwNitUbXlTZnJqQ0ttbFc2T1huZnlBOGFD?=
 =?utf-8?B?dTE4a2hsMlYxNDJhN1BqejB3RmV5b0w1S0FSa1dJN1NLdFZmSTA5TWQzaGpW?=
 =?utf-8?B?c1JrcERXM1grbUVwaUNJM0NzTGgwWVREcG9ZdVVCTlQ2SUFsRUM5ZE1qSUZu?=
 =?utf-8?B?eExLTTBqRnl4ZnhxVzVtYnFOdEV5SnZHa0doUVRXZURQdXZLb0VUc3dlLzRm?=
 =?utf-8?B?cE1MVlJlajc5MUlsaFB0Z01rYWUrOE1VaDErWGtZVC9iMFBSM2ZjVUx6MWds?=
 =?utf-8?B?eGUvaDlDdWZMUDRuVzRQTnBoTE5NWXRROGFYWDhldXJjM29ZallJd0owckNx?=
 =?utf-8?B?WmI0ZWUxa240ZnFFWnJreGZvRTVBYTc0WUsvSFVOY0pGVkczOWQ5ZGxnM1Ny?=
 =?utf-8?Q?eh17S05nq6cy5WlKXqj6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3072dff6-4ed5-4e24-df01-08dd19c3fffa
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:12:56.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106


On 2024/12/11 7:13, Samuel Holland wrote:
> On 2024-12-09 1:12 AM, Chen Wang wrote:
[......]
>> +
>> +static int sg2042_msi_allocate_hwirq(struct sg2042_msi_data *priv, int num_req)
>> +{
>> +	int first;
>> +
>> +	guard(mutex)(&priv->msi_map_lock);
>> +	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
>> +					get_count_order(num_req));
>> +	return first >= 0 ? priv->irq_first + first : -ENOSPC;
> How does this work? The irqdomain is instantiated with size == priv->num_irqs,
> so hwirqs must be less than priv->num_irqs. It also quite simplifies the code
> for hwirq be a number between 0 and priv->num_irqs. You only need to apply the
> offset when allocating the parent IRQ:
>
> 	fwspec.param[0] = priv->irq_first + hwirq;

I will double check, seems this need to be improved.

Thanks,

Chen

[......]



