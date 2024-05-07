Return-Path: <linux-kernel+bounces-170537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101378BD8D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985D21F23E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F961876;
	Tue,  7 May 2024 01:16:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68842110A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044574; cv=none; b=a5SkMVlSVUVSbF9pNlN/Ky9M1XtBqyrAZyV0LobxqRcYMZOmqAb4f8OlVatgV3U//S/USnaOuZpRSGuhFV/YDhbiDKFg9ll/tV042OKygGedfFytxX09I6agNGiBE83IJ5Ejzb94iDBicmf0fZI98TW6kJdmuU0PXAPqplmKbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044574; c=relaxed/simple;
	bh=0NLuhG0ZDhEPB66NrG5+IpAgYJnuXOYTJ2EM8WwxC9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MdZWLgYwmZLyamd0fh/IsKmUPdQB/RSav/EsqwYS+CvkzxTchxjpFROZWL5bxgkoc67vxxPKlQz7lOlryRAeJTArM5bFZVprx+tDeZ7MA4D1r0B/Cp9yFtHH9uCKRNog2H2isC6SG9uoXFG9L2kQ58TYPfCg4HpccM/d1AnyCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYKxv5lqhzXnp8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:12:19 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 640F214038F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:16:08 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 09:16:07 +0800
Message-ID: <a75c2818-11eb-3f78-1699-94a5b10ef232@huawei.com>
Date: Tue, 7 May 2024 09:16:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] genirq: Simplify the check for __irq_get_desc_lock()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240506125057.307586-1-ruanjinjie@huawei.com>
 <87seyurfk7.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87seyurfk7.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/5/7 1:55, Thomas Gleixner wrote:
> On Mon, May 06 2024 at 20:50, Jinjie Ruan wrote:
> 
>> If it set "_IRQ_DESC_PERCPU" in "check" but the desc is not percpu, or if
>> the desc is percpu but it not set "_IRQ_DESC_PERCPU" in "check", it both
>> return NULL, so simplify the check in __irq_get_desc_lock() with "!=".
> 
> What is exactly simplified here?
> 
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  kernel/irq/irqdesc.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index 88ac3652fcf2..6c52deb134b9 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -882,11 +882,7 @@ __irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
>>  
>>  	if (desc) {
>>  		if (check & _IRQ_DESC_CHECK) {
>> -			if ((check & _IRQ_DESC_PERCPU) &&
>> -			    !irq_settings_is_per_cpu_devid(desc))
>> -				return NULL;
>> -
>> -			if (!(check & _IRQ_DESC_PERCPU) &&
>> +			if (!!(check & _IRQ_DESC_PERCPU) !=
>>  			    irq_settings_is_per_cpu_devid(desc))
>>  				return NULL;
> 
> The existing code is readable and obvious. This is not.

Thank you for your review. The existing code is indeed clear, but it
seems that both judgments are checking whether the percpu flags are
consistent.

> 
> Thanks,
> 
>         tglx

