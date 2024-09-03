Return-Path: <linux-kernel+bounces-312107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C896925F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E829DB22697
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9E19F132;
	Tue,  3 Sep 2024 03:39:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310863207
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334774; cv=none; b=HOg5cijERaNxfCKbAU1I7Smwpmt2Zv/4MJxeSnZVAOk5zKgOk5ig6GDenb4FKp7wGuhHkq7E4M0iY+Nv+ixVfP721xdlrq4X9+LXGHCDMWxxG5tWwO/UqsiFxdGp8uQ7dktKelshwdvDuUC+zwTGcAbgN2tH4Z//QwYKJdQ6wTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334774; c=relaxed/simple;
	bh=zTjV92VcB6QRbQ8Z25TZUZjGs5F1ZBsb0En0ML3sJ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GGgeukztIvJKBwGPDEOtUI4+3yLo22wlwiK4nZVl012DbDVCyE1+HRMH5UITO3YumCz3oVNyu8QLgVwLzpvTwZpOB8FOqAHc3MTTdEgHMDTOzv3908sWBhiU9t6cZm5ic0HcPIvUYEFBdwbPnuZAdJ8Q6QyMgykY2fx/9j8BcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WyWT52GFvz69Lt;
	Tue,  3 Sep 2024 11:34:33 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6085A1800D2;
	Tue,  3 Sep 2024 11:39:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 11:39:28 +0800
Message-ID: <e333684b-6833-fb62-2c6e-480f14333f8a@huawei.com>
Date: Tue, 3 Sep 2024 11:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] printk: Use the BITS_PER_LONG macro
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, <pmladek@suse.com>,
	<rostedt@goodmis.org>, <senozhatsky@chromium.org>,
	<linux-kernel@vger.kernel.org>
References: <20240902110903.2686082-1-ruanjinjie@huawei.com>
 <87y14auulz.fsf@jogness.linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87y14auulz.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/2 20:07, John Ogness wrote:
> On 2024-09-02, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
>> variable, replace it with BITS_PER_LONG macro to make it simpler.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  kernel/printk/printk_ringbuffer.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
>> index bd2a892deac1..7433fe477e08 100644
>> --- a/kernel/printk/printk_ringbuffer.h
>> +++ b/kernel/printk/printk_ringbuffer.h
>> @@ -122,7 +122,7 @@ enum desc_state {
>>  
>>  #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
>>  #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
>> -#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
>> +#define DESC_SV_BITS		BITS_PER_LONG
> 
> We should also add:
> 
> #include <linux/bits.h>

maybe  #include <asm/bitsperlong.h> ?

> 
> John Ogness

