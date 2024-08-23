Return-Path: <linux-kernel+bounces-298908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB295CD15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B991F21712
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FC186600;
	Fri, 23 Aug 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="E1b+okHv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="QJMzhjba"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85287185E4E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418005; cv=fail; b=FK75mSayiSlyNgBmODslyB6EhJ+9rlHAQ5aOgcHAxR6Ucc7WOZljR4Tdg9bCNDPHFI9DQgWzDWPRYBkSKiN9I83lcjm2EDB3bU+ScoQNXSbH63KBQLCJu/aoBRGqLi9Qs+mdh5SRnBjmQ7GSzh2dfxXszjz7OMm5MhZnAbVj0Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418005; c=relaxed/simple;
	bh=DDAZZCrLUwvG092AGlBuViDLywvdgox+xRJcsVoQKOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dYgxbg8HS9xNvsuv30kRyJMi+0YAjko68A5tK8oqVkUGNZlMFGl96UOw2nhGw3xyK+nhBoMvhDspdddtKfjqBihr+zv46zhghqF/jt8YqiQHYsTvgI0LRSKOJp0km6EXL4lXWW4nLcIrb4Ex8Sxt8NIFsTh/ylGFTKuG8lsXjgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=E1b+okHv; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=QJMzhjba reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id AA086755D5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724417682;
	bh=DDAZZCrLUwvG092AGlBuViDLywvdgox+xRJcsVoQKOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E1b+okHv+bU8rjuPaWY1EvouEft3b9uBOz3PC8t9YyPWhbtaRuIediWcMweaWo5mR
	 Qlg3EFZ+Bd7PhUsp40W+m7npFYYq5UMUGHEB7L3fYNAWRNkOtYskN/WN1vr0dPNdyE
	 VOaUNy7phYJJOgXjX32PUJG94NRerb/Nv2PNdxQI=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 59271752AB; Fri, 23 Aug 2024 14:54:42 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010004.outbound.protection.outlook.com
 [40.93.76.4]) by fx302.security-mail.net (Postfix) with ESMTPS id
 6ABB3753B4; Fri, 23 Aug 2024 14:54:41 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by MR1P264MB1569.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 12:54:39 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 12:54:39 +0000
X-Secumail-id: <1659d.66c88691.6904b.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqcWEzVKBgdIy2ZYyu0FPf5TtjtabI5r5AirATky5Rbu71ev3BALqrLX1RBjxqSE6i2y0Tqukr3FioncOlfAHlTyKGLUFBIMl6ZPzjinZ/Wyeapf6fVHVYsC61fBoeS2Pq6mv40SCrzqE9vH1L/Se/KCLxohoVW/Fp+2hWPYoUajf4KDqzLCV8bAs933NUABVYg7PxhnKs82BZ1xQM2gThc3M9G2kgjw9xy6xfvHGwvitwhd3k2hQxJpC5Or8fjjCXYVL05tafKy2DzpJz1WP/h4nl3+EoFbGn9BUG24yA4NTQEAb09yCE2QIwk6t8SZnyEwaPCETeM+bxdN4ITxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXOkzNMaxotzdJpqRfAGfiBmoUYYgvW5swRT5RNFz/M=;
 b=XCuXnn1hICjHpAh0qSV7ef9csPzOTnS4W2FOf3SIzJyL9QToCrJjt3ZX6ueBY7cP5mTrXUIlQGTnkjY0UIaOwLhkll/Q9xrDK3wZDyNV+UfpvFnOpasDaI7SotjKtcxgKcwX2mP5CL4NqjND8mCjSfT+fLpKXHDrx6zAvjIXhr+NSeLSh2aAjzUE0FgNp7S6sBC+OygTdzgddwWqzdIkGZEwqL5rHHoz2wfeVHdjUP2fqz1X76muf9/hN5FnBG8tbZYtMfYQyauCoxLZGhRlkRfLa87VzU73d3m6M542+rcuZmsIbw9lKhtFmVQeg3bN1zETuRRL5rOfuTNr4dApng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXOkzNMaxotzdJpqRfAGfiBmoUYYgvW5swRT5RNFz/M=;
 b=QJMzhjbaZL39fiFcoZqzaCnQhtUthkk3r3wscmlIOTbJatbjqFQnRJcJ9GUTCmEKwOwIuwcxK4cZ36Zb6cYr8/amE00lfMgyJPQrRqH0qkJWWF8hH1sSeYsiTaTNWljM9UqboAvcOH3iuXginyHwypGX7jvqqHEX3vM6SfGu7vfOs3cw8W5uwR269iFa5OMqQlqjrI76kt/AhGZe0DPFxDDR0LV7hbsqJ61FvVH9W9iJRfvs7PJHM6W3tFIEJqFYRwFyMAl16pfrmMXyyAbVm9i6R4eMESlLmSBNZKUyavYReeB/UllOXa10zR8Ai4A3wCAhS7TF1leHDb/UAHLqGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <f6d293a4-0261-4030-9e86-2f990ea49284@kalrayinc.com>
Date: Fri, 23 Aug 2024 14:54:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 22/37] irqchip: Add kvx-core-intc core interrupt
 controller driver
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>, Vincent
 Chardon <vincent.chardon@elsys-design.com>, Jules Maselbas
 <jmaselbas@zdiv.net>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-23-ysionneau@kalrayinc.com>
 <79eaca59-9ec3-424b-a2db-d27af72722d3@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <79eaca59-9ec3-424b-a2db-d27af72722d3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0452.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::23) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|MR1P264MB1569:EE_
X-MS-Office365-Filtering-Correlation-Id: 724ae01d-71ea-42c6-5add-08dcc372bff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: o01ZllFZvSGald0VfI+T01xhaY2gIV5c9U992w8QupEYJrcw4js9bm0sI7LES3CRx81dICFtXuc8YpbSWEk/MiDTZXFII5Kv5XCelId+z8GG+Po1O7sf2OhK5bgAhtdNRd+gjzhOkqCQxqrUorG2Kc0wxPF0nYyVAhmieHzOC0WGGVfpzYFma0TKbdJpzH2QnSF0GjJK4Wr02ljhEOPhvEsYwGk04SIityQknbC9UJLZD8mhTbFReuUv3C84HeVj26GuTyg0vd0/bkD33tUcPS2aX5I2vXEmBoOwXFmtoSkjuTaYJ0HIhaVdqHkqsGTkZRHHGWnuU+uByQot6px5gwYEPrKlC4zf0peeUVN4oOnKeaHpcjvhdWD2YQBd3zYMjDZ21DNnrqxhyL7FAuznyI9ZwUZQQdu0Wd/kLHC9+zrncMel13R+qinMLF9n5AF+uTfg0u2EtT+9Zx9nA2WrLeq4mUG1AwAwIKBMR+KfZ2Xagi+ZrGIVfsfC/URXJ/uAmOSfvbyHfI6wQxqFT1WzoP820gxh0WTB2LUP9AvoFM8QKQGzOiQTrDF9UgkkPcyyZBcaIThZS3GptFPigEFYhsrr8xysb9jMz555eznxpxs482YaO5riF410PudRvDDH2rs9OF7XyvBNJb90GpsBvnK3HRbj75GSIHUt77ea90Hd5gflqfVSqrYIL3J7X1mzM4uUcKiD8VRU9GKpmVMbyBeIKW7UjTJnHhQFr4QpMux+84UIYjvJXmxWIxbFaaEtwu1XhXeQdsalzH2A6bMihjujU0fN8GEL7KGpe+QrVqCbdo3vGL/5bG53Q0GNIYPv/oqKwUzH7uPsxsnvmQ7bhSlnnyN1H5sMWZrioD9bOOm/GVW34al/XK6pS0BrS4h9k4ESNn0pswf3aLD4ABKB+cFjNeYsvPPp3LiKrHEYDFqWfiEoyHR8ZjoNCb9hFyDEKkw
 dM/u36Bq6eGTprbI4zNJdgVHshFkpIse0yBl1/gXc0AXmOWzRDKGXpZsTNVahK2oRvgESWjmFmlxROeYpSl20JnMA2BOyUIUSagvEMVvV7zRYz1ob2o61Z6+vTvBsrBKs/iXvJd0WCGPACZmNhNdlDE1yFrzaPAwtOzQGXDd9PG11g4qK9QX0c4d0SQ8KHfB4u97qMKCyYaWQavr1jL9nvGPOrufROnbr0r7h3lWB5aKG1VgLq2jf0HmYIG7tac3VZ3TTiqrPW4glT+BwPJc59C0W1XPnCGlSFiCpZmYct6DXauvTxux3aZS2UePaNB7bxpyzlt3zkXwowKYykVwI5r6jPYlk78mrm7oHEutWB+S0Al9rVeWKRfDcZYzN8R7SCCXVWMKujiGquGbW9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BVFJGRCQw9yMewL8oLJkNu0jfypfCbLHWpEinDTMHNPceT5LMghSCWiZ6PI2UI0dHYVXn8a/p9MRaMwmihAmPTxB7MHhd0PGq+G6rtBEsFBoahIUhs+VEKdny19bF/uVSols8Xw6bM0xD9wkHCOQkQysvK63Nd2uQURlu69F+hk6tBj/4jqK/2VSDXeQDjtzUzrEk2J7h61+EwQ4O1SRitkW1VEweKjZKQ6UfNbw+eqLGAyjGDRX+TQ7bHoMOGFtMsNl/m6APXAw6FJA0y7ErUZUDakEaUaTGbwQyWzvySdI80J4mdGLk4Po5YWe5iRENikRSQfj2QI17smvQgoWMkV8CHsHp7yvl5QpqCpTXz7/hYbqfbNL/ulUKtM6xa3KnW95xYtPzw8kkwUZnpyJsTIeMhUx+9LfHSW0yp9FW8dk2NSZ/EyCJSU4vUMR0KymSpJa/6oMUEpbU1QA/G1DtrLKNgL1nM9zhZMNURiEMzJaW+sQS/iYUD9aOCW07z4d7y5wapB3V2aJy2JTDVbP/oTPMYTupqa9bDN362zIPuYVh6+3qgw9MiP3nFPdiHZS2m2qyPPVrtndzfUt2FGnC3QfSs+OjWSJep5QAx6dxmM+ERAz7fYX+550t9Jx0xtuhVvJtxwmh8Zgs/52XBXENRkJXCNEp763k0z8tHhmfZ5dVcIem4kc2eessVQR8GEtX9sjauSwY3ox5Fhycy6b0/rPerH/EZH577JtE2MIw+qNW5LEIovh/HhSv3oP8/0oJaZOk3fc9mFpFOBmfAZ+FIWfaaimMl82WRDXCKhDVvp6QVOFkHlGfh+WyXZP+i/Lmn4AQSX6MOEYdwgXZ3Sr5rZ2KgJtc5gEAZWtIYsAbGmY0EpvHqGNPPLQsY5mo5JA3vVilgmRdDj0UQWCdW9hFOvSiUdbGqyB30iJUhZKJcCKhYYilORKVPDMbCVjVqhv
 hxwp5bSvo7J76ozWHQqzdrzNK50uhT+BrHHlnCRU8LqzdZpoc5Yq2wutjgpmmuhQOw+S7HM67lpHinH4aBD0gLr3GJM51O+R0qEFZAohbywN7uSR6eq/egM2VQp+dfLvcuugX+b2E6fpL3fZY/Ptw/xi+CCfGPOuwFCHgt3zqmJI1gi3fCffkHcWUMw3i+Ik6Wl2hjZpsli5+wkwWhaNqIBrtFymP6Ez8RgDsFhvsyU8TvuCd5OpZo8hd5lNGY+6XdwQyk2dl8pG9XejzhiKtu1jqYAIHWwJm2x7zdzuRG6DGYaL1ZbXUFbxeoxI3pLOZSim/GhXGa/ZHMVBD0iJQxFM7HFHXvCLFP4sBaXxddEGKJmdNJ1UBr+vhsjFndpSurKsc52HsnBW6+/DVsai8oAaZ+nWFtWtlXv/eU/+oVZrY35RkO+ehvOOjBKAW3TfHeBxZI+LlR27QdsR4n/c3KZDvd5jMQq2O2ZgTByH3VPMxXDglWSJOVw/wmG+KBTAQnGiKIFd50dELJdp23IETOMOe6q+H7JwuYBsuUlWFmsIBxgiUfSRo46RF/uL5XjjcTg1YtOTre+CbnUpUDyFBN/DKJW9xEcrBs3PapUtFOOftq394+D/N6K24hn8cr4fqrFem3XVn1AuQoH/aus5Y4BIW89YwOrEXSGgLXiMPTs8zShHY/Gl+9c10htm5mgC879DRnj/F757DRO5VRnXmA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724ae01d-71ea-42c6-5add-08dcc372bff9
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:54:39.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+RTKa+bBwJN6mVjD1drUEACt3fMvV61bbCmwZAPITLvMzdSnVOqoeq4IoKn6DQrfEDx/AxwEHdlkoOHQHIC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1569
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 14:32, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> Each kvx core includes a hardware interrupt controller (core INTC)
>> with the following features:
>>  - 32 independent interrupt sources
>>  - 4-bit priotity level
>>  - Individual interrupt enable bit
>>  - Interrupt status bit displaying the pending interrupts
>>  - Priority management between the 32 interrupts
>
> ...
>
>> +
>> +static int __init
>> +kvx_init_core_intc(struct device_node *intc, struct device_node *parent)
>> +{
>> +	uint32_t core_nr_irqs;
>> +	unsigned long cpuid;
>> +	int ret;
>> +
>> +	ret = kvx_of_parent_cpuid(intc, &cpuid);
>> +	if (ret)
>> +		panic("core intc has no CPU parent\n");
>> +
>> +	if (smp_processor_id() != cpuid) {
>> +		fwnode_dev_initialized(of_fwnode_handle(intc), true);
>> +		return 0;
>> +	}
>> +
>> +	if (of_property_read_u32(intc, "kalray,intc-nr-irqs", &core_nr_irqs))
> There is no such property. Stop adding fake properties to your code.

Ack, I will replace this with a CORE_INTC_MAX_IRQ_NUM define

-- 

Yann






