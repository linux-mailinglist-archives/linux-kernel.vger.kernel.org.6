Return-Path: <linux-kernel+bounces-441039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB99F9EC887
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F1A18830A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F392210D8;
	Wed, 11 Dec 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uHwCpTNv"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FA2210C6;
	Wed, 11 Dec 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908258; cv=fail; b=OoXY1AcWDddxSTdKKYy9y8EaCBDqMsy0GJEwh/fLTRV6g9WhgxzbStswjrlP/mLGxwprALwqfntC/baLN2kGhgFOtwtmKlmak/+b+NZ7X7BcOzu2SNhE9K3K61j1n1TwqbaoQ7ai3DWWl80157JKLFZwph6PgkhFCPrkNAhZguQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908258; c=relaxed/simple;
	bh=u9KT1vBbWUYUJuQkGTAkj99FXhsqimNTnswq6ODFBw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RIG+m22yluufp5ltg5HFkBMpRxYsKC9L1wHWg55acad6MSUcKqumB/IMxCkLEA6nTv3BKqh0X8XDnT4AdiAaPz1GMJLWeAMqpY8fTijCjmueLizlT/CofnwovDre3nD3T9syFtvuD5aBKXcHNcX3gXBfAmMjUDuGkd8MsoRlSBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uHwCpTNv; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcRORNtDdgNc2M0AqUjVuNKLkcLKgrsnMztGcC5fPsjJoNTEahCRjZUsFM3SMZuc+VNKHXAswTxZjWsQzVRDWUidTGnPFNkmRnoBLsN3N8CqoAQHMKbPUR2TZN8neMCVhsJnGKAcOK6hZUfMj+i72lqjvMQ8xuPpbUdLuGZaf6zBJcca+BBP6cgiujJb09dUYMeX6O/1VtGWbjOYNGz/JjRtWz6Ha+HWtwGThaonrYtci1frlkRdtZewTtlm+qsSNNsPjkHPjV8ZVjgceNUIBucuypFnFWAiWZcolWYq57zf6DZ0fP5JQ0/WTLrE+44T/DTjeVW8M61CXFUppkTz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oExskSUZ5SIGtqaMjC7kaHnSD7llCngJOQkRlcmFQFQ=;
 b=xox80cEcgsAB9xJ3PNdUDxbRaXK4Kh4++IReTsEyuumhG3o1gtS2S9DVdK8w1xIjasVfZO4GgLSj2xBHm2/GiVNXf6grcPZRuBkXVZ+g/icank4W4apg3P5wX6dXKaPGoTi9nmZT6S5T9Sl4ypVzGqS+aUJRaspoYfuO2OHksDXjQxrwi0p6aLjiHHW+K/6n9/JeyHqAsXhJUwEmvXdEQ8cWiFHd0UcLMwogS3qN7FY9K3D3SVI7Ho9kYITGEtvagf1Fl/qze7dGyZP9dTwSjh3955wL6N1qgJOy00ovVDziTVzpv0e90ovbyokxapuZrTlXbII+wWbGUrxMdXso8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oExskSUZ5SIGtqaMjC7kaHnSD7llCngJOQkRlcmFQFQ=;
 b=uHwCpTNvXJ1RWI0KBhg8U6EdCSZhCGHf1H3CSk61FhVqJtYwA8rltv0txlkOxKfnGID/ae0/mdsqJ4MGJ01riJa+ZMNAku2WlecEWuOds1ni6K58jVdaD1VuOePZBUZUbhdSjG0xuJJNR26hl9KjPr5MILG1tvgMy7RX93jXg5xsDTPbYC9Az/SDhq3nEOlc0WsNW8iEY08ChwnVs5/HSs9K2ljC+7aKk3LP/xS1SyFmdaKm4YMRjN+tJ8VxDb8Ep3RhazdQ8H3uEyN0d5unIXY1riOPHOzHHyXb5YpM3o9Df3Hw9xpgBW55cT+bbSGR2KLxVGuaoADJPnHTAknJ2Q==
Received: from BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:13::10)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:10:48 +0000
Received: from BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d3b0:ebc1:c2d0:d13a]) by BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d3b0:ebc1:c2d0:d13a%6]) with mapi id 15.20.8207.010; Wed, 11 Dec 2024
 09:10:48 +0000
Message-ID:
 <BM1PR01MB4515A5E40E15BE6DA2C845F9FE3E2@BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 11 Dec 2024 17:10:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1733726057.git.unicorn_wang@outlook.com>
 <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
 <kdwwyx4digujlculbu4ivyiedqbmivuuddpfadpp7tup2gmvjv@6j53b4wqxbd7>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <kdwwyx4digujlculbu4ivyiedqbmivuuddpfadpp7tup2gmvjv@6j53b4wqxbd7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:13::10)
X-Microsoft-Original-Message-ID:
 <4d0fd4ff-d88d-4d20-8fd5-cff3ca46f03a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4515:EE_|MA0PR01MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee1bc3f-6c94-480f-5562-08dd19c3b3de
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|19110799003|8060799006|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blFyUnF2czRPVHRyTEtGRVRENW9UUlRjQTNoTG94WHhnbjNCV084STJET3B1?=
 =?utf-8?B?U214VHJHUithRTV2NTJpTm11OTZGVi8yY3duMFpyeVg3dmUzdGRDbVJDZ2Rh?=
 =?utf-8?B?UXJwMHNua1A0QjY5SWxlWldGaktDdHBkeTI5WmVGN2xhY2o5dkkrSHVhSGR1?=
 =?utf-8?B?dktBcEZ2VVFuWTVpdEg2cWs3S3ptWGJXMkZWd0V0VEJpWDZOaXBsNzBwcmJT?=
 =?utf-8?B?NnBSTVdSN3pBSitIOEpHRHF6WmJIUUQwQjc5ZnU0dGNFVGw0SU5lSUt6SThB?=
 =?utf-8?B?cmh1R0xSUEJWckw1ekxLN1RHNjhGOGY5OHJ2dGtCdHZvQ0RHdjZQME4rT0My?=
 =?utf-8?B?UkxNeVZxVWJ3RjFVV0hoU21xdVJNODN4RUQ4QWtMWEV5UVJMYXhrekVaeUo0?=
 =?utf-8?B?UUNxeFc3aGp0K3ZCd29hVHoySlNtVldvRmFaemt4MFRqR2pTZlM0ZFpSNGUx?=
 =?utf-8?B?bkVxajZISzBlbTBqV3B0QzFBY1YvSnpsK3MyZFZMZm8vZ1Z3MXl2b0dKS2ls?=
 =?utf-8?B?SlEwTHZDQ3E5YjZDVldxRW1HdEtDSkVTNStoVHFOMkZQNmovWGY4YVU0Mjdp?=
 =?utf-8?B?T09XSE9mUy9iZ0gzRjdnM2lxRW1PNWlNSkxoNUFOV0pYZnFteVhpeEEwaVNh?=
 =?utf-8?B?RmZZYjJscW90NE9TaERnMnpQa0VNdWZiT0dnWmJrc0hpdHVyeHRFczBrTmFY?=
 =?utf-8?B?Z0pkU0JIb2Raa0xDajMvTlRWdUszZzk1ZlZTRlVKZXJIaTV6amI4RWhNSXBQ?=
 =?utf-8?B?UVZmaGV2QlNUSld1d0hFVURCNklHVis2b1FaK0pxU3RVa0hTcjFSUW80NnhZ?=
 =?utf-8?B?M1BPeGxUa056b3NFQXV0K2NCdzFGU01uUHUydExONXl6MHIwaktaVDRtL1R0?=
 =?utf-8?B?SjBsb3Y2VDIxeTBsM3RxZVB0clYzVGFGc1hxRS9qWUdlZENXZ2NvWktubW5K?=
 =?utf-8?B?ZGhHclhGZU5Ebmw3a2pGdmZqNE5BcWhZYTdPVWM1dDE0ampLSlluanVsdk9I?=
 =?utf-8?B?ellYWlNxSndsOG9vM2s2OGg5MzFqWU42eGo4UVZaN3JmOW8rWElvMWlQa1Mx?=
 =?utf-8?B?anlQbFF1dVVOaU1sVkxHNGk2QnNHR01iQzFPOS8zRm5hUWxjUHB3VFhMRFFn?=
 =?utf-8?B?NEJhU2w3TXJXWi9UZFRya3grSnArcXJrRmhPZ1pMN1FZN2cxVDlIc3pySjhT?=
 =?utf-8?B?THpoL1g5a20vMk96Rk9kS0JHNnJWSVBZL1NaaENlRmN4dHVrSUtLUGVGUTNp?=
 =?utf-8?B?TVJIN0V2a3MycXN3S3Q0WUhzNC9ERGNjb0Y1TWprWDN3QkVmK2JoN1NpOFE4?=
 =?utf-8?B?REVScFRyL09QeS9wMG1aejJBQ3Z5eHJLUmRNZFR6VjRkekluTlcvTGNjcExu?=
 =?utf-8?B?bFJMZ04rWXdXOWUyMEorVUdSbXNBY0YyTkZGeTNmdnh4MUlHSG9XV3lIYklx?=
 =?utf-8?Q?TTdwuFgW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVaakE3YmRzazVJczZoVHFUNENkTVVuY1VweVRDNnhZYktDcnE5emFWUFhx?=
 =?utf-8?B?WkU3aTNjemFKcWNKS2srNHJTdDZBL1A3TmFrWm9RWW1tckFNcVRpdmlsbS8v?=
 =?utf-8?B?cWozSzVYc3paTkJxWWZoY21kUC9oSU8wdHpnK0sza3NNTi95QVFSa0lHT0wr?=
 =?utf-8?B?T2ZmVEl3Q24zRmNvM0xsT0RZT252ekxrbXM5K3lsMTJxeXJPbVYxbkhzNzJW?=
 =?utf-8?B?V3ZHVFhlR0hwWWdENmU2SmVySVBIMU8yNmJMVDlTN3UzMFB5dmVSRFRacTU4?=
 =?utf-8?B?MThMaGpDaUNLNHdiQnJKQk4rcnhIMVMvVUFuLyswQ2JJZS8zcXlWOFpPUjBt?=
 =?utf-8?B?SlJDOVJEZWY1MmxCY25XUlBoVUg3MnR6Z1NWcGVxOFpWMDZ6ZE9UN3E0NHIr?=
 =?utf-8?B?bUVzSGdybkV5cTV0QmxXTmlIak9rYTg2T0dxaStldVpUVXA4b01iV0tOZFE2?=
 =?utf-8?B?ZXJuTkh3WTcweHZEeEZtVTJJVldHZmZ6Tys1YXlBdXZ4clQ0cnR5Z2JlZHBM?=
 =?utf-8?B?MUk2amd0bkdUcVo5R0ZmTWxMY0ZjM2NRL1RMQWE2U0NDZk1PUVYxU0lXZU5I?=
 =?utf-8?B?dWhEOHg2NXNDMHpBVHBGNE9wR0tzNFQvTTRXaEtQSHFtZFJncUJGSEtOMXpu?=
 =?utf-8?B?Y1k5NGd0eDV1Y3VucktXeUhZNEZZZGJyTkVNTEdMSE01elBoQSt3YmorR2My?=
 =?utf-8?B?S0lkRTViNDE1UWpPdlIyeUUrcU1PR1JySGdmZ0ZmTk0rc1BGd0lGNFlYS3ZS?=
 =?utf-8?B?dkxjZVBpUzlGc0Q4dy91czUwYVMzQUxHTTJXMENnL2xhSXMyWlh1NWI2U0hL?=
 =?utf-8?B?YTBQSkFTQzcwOGN5RFpaUnhkc0JQc3FtWEpQWFRhclh0cVZSMndWM0ltWktu?=
 =?utf-8?B?T3d5OWRlalNLRnJnbmt4R2dmSW5odUtqb2xVMmJYbXlISWNxdWdYTjNFRWlM?=
 =?utf-8?B?REZhS25vMjVvRko5RFBncUErYzNSOHJzeXlqV0xwbFNRcnZzYjJ4NEZDcjI2?=
 =?utf-8?B?NTFPK05vdmVoZU1Uc29LRGZGbWMvMlFyUGtCNWZndnFpNnFhQWFTanFLNmEz?=
 =?utf-8?B?ckdIcnRvVjMzdmE4Q1pnSzh5RmZGelhZaDdhaGVkU1ZhQUVMVWFEcWg1VlJt?=
 =?utf-8?B?dGpBdkVvZy93RkJZTCs1UXJEK2k4T0ZhQy9iRWZwTDA5Rk9KcDFOOStuTE5q?=
 =?utf-8?B?QUVPU3pwZzZhTlRZTlYxTGVpKzl2WmVZa0pxOXpYdnVYYUlBVXcwZUMrd1lq?=
 =?utf-8?B?UUVNcmVNSlBEcitlYmt6MkpncGJFVHBTTllRVEd1Mll2NVlXZUVOZ2o0YkZi?=
 =?utf-8?B?NkJlaHhOc2tPbEQxQkZxL2lnZTFaRzJ6ZjZONzhLMGFLOGZyS3JyK2c5QUdo?=
 =?utf-8?B?cnFCSUNNZTY1NmxFd0g4Tm02Z0hlMmRQNGlJTHJzbVRLRU9oenpPeEozZVIv?=
 =?utf-8?B?WHpqK2tlRFBQOGJzcFhuRmtFV1J4Z1pzSnJzaHM1d3EzWXdSVldPYlk4TE81?=
 =?utf-8?B?djZFZkdHVnZmWHlyUUNzT3JkaFNYZUgxOG5ndnZnNU44UHlmc0pKaFUvOFNi?=
 =?utf-8?B?ZnRQdmZ2Vmh4bVhmbE84Q21nZmlFYTFUU09WdUdYZU9pZVRPcTdOZlhQcVVG?=
 =?utf-8?B?ZEtJSGhsOEptUmlGOGZvd21MNFZUamdralFYRWduZG9pSkEwTTh2ZWhCeW5p?=
 =?utf-8?Q?hNJkyYzPVM+O9JbtrpXY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee1bc3f-6c94-480f-5562-08dd19c3b3de
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:10:48.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106


On 2024/12/9 17:34, Krzysztof Kozlowski wrote:
> On Mon, Dec 09, 2024 at 03:12:00PM +0800, Chen Wang wrote:
>> +static void sg2042_msi_irq_ack(struct irq_data *d)
>> +{
>> +	struct sg2042_msi_data *data  = irq_data_get_irq_chip_data(d);
>> +	int bit_off = d->hwirq - data->irq_first;
>> +
>> +	writel(1 << bit_off, (unsigned int *)data->reg_clr);
>> +
>> +	irq_chip_ack_parent(d);
>> +}
>> +
>> +static void sg2042_msi_irq_compose_msi_msg(struct irq_data *data,
>> +					   struct msi_msg *msg)
>> +{
>> +	struct sg2042_msi_data *priv = irq_data_get_irq_chip_data(data);
>> +
>> +	msg->address_hi = upper_32_bits(priv->doorbell_addr);
>> +	msg->address_lo = lower_32_bits(priv->doorbell_addr);
>> +	msg->data = 1 << (data->hwirq - priv->irq_first);
>> +
>> +	pr_debug("%s hwirq[%ld]: address_hi[%#x], address_lo[%#x], data[%#x]\n",
>> +		 __func__, data->hwirq, msg->address_hi, msg->address_lo, msg->data);
> Don't print addresses, it is useless - it will be a constant.
Ok.
>
>> +}
>> +
>> +static struct irq_chip sg2042_msi_middle_irq_chip = {
>> +	.name			= "SG2042 MSI",
>> +	.irq_ack		= sg2042_msi_irq_ack,
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= irq_chip_unmask_parent,
>> +#ifdef CONFIG_SMP
>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +#endif
>> +	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
>> +};
> ...
>
>> +static int sg2042_msi_probe(struct platform_device *pdev)
>> +{
>> +	struct of_phandle_args args = {};
>> +	struct sg2042_msi_data *data;
>> +	int ret;
>> +
>> +	data = devm_kzalloc(&pdev->dev, sizeof(struct sg2042_msi_data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
>> +	if (IS_ERR(data->reg_clr)) {
>> +		dev_err(&pdev->dev, "Failed to map clear register\n");
>> +		return PTR_ERR(data->reg_clr);
>> +	}
>> +
>> +	if (of_property_read_u64(pdev->dev.of_node, "sophgo,msi-doorbell-addr",
>> +				 &data->doorbell_addr)) {
>> +		dev_err(&pdev->dev, "Unable to parse MSI doorbell addr\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = of_parse_phandle_with_args(pdev->dev.of_node, "msi-ranges",
>> +					 "#interrupt-cells", 0, &args);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to parse MSI vec base\n");
>> +		return ret;
>> +	}
> You leak the phandle. You leak much more, btw...
I will double-check, thanks.
>
>> +	data->irq_first = (u32)args.args[0];
>> +
>> +	ret = of_property_read_u32_index(pdev->dev.of_node, "msi-ranges",
>> +					 args.args_count + 1, &data->num_irqs);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Unable to parse MSI vec number\n");
>> +		return ret;
>> +	}
>> +
>> +	if (data->irq_first < SG2042_VECTOR_MIN ||
>> +	    (data->irq_first + data->num_irqs - 1) > SG2042_VECTOR_MAX) {
>> +		dev_err(&pdev->dev, "msi-ranges is incorrect!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_init(&data->msi_map_lock);
>> +
>> +	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);
> This also leaks during removal.
Got, thanks.
>
>> +	if (!data->msi_map)
>> +		return -ENOMEM;
>> +
>> +	ret = sg2042_msi_init_domains(data, pdev->dev.of_node);
>> +	if (ret)
>> +		bitmap_free(data->msi_map);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id sg2042_msi_of_match[] = {
>> +	{ .compatible	= "sophgo,sg2042-msi" },
>> +	{}
>> +};
>> +
>> +static struct platform_driver sg2042_msi_driver = {
>> +	.driver = {
>> +		.name		= "sg2042-msi",
>> +		.of_match_table	= of_match_ptr(sg2042_msi_of_match),
> Drop of_match_ptr(), unnecessary and might lead to warnings even if this
> is not a module.

Got, I will remove it, thanks.


>
> Best regards,
> Krzysztof
>

