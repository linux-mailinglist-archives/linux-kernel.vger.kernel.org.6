Return-Path: <linux-kernel+bounces-447422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27379F3200
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BC21884C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9A205AA1;
	Mon, 16 Dec 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JjgMSo8T"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0913DBA0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357214; cv=none; b=JGlRvPI6TLsDzlREoS/X0E10rpXI3qwXAla/DUNdsbOonsMspn1YewqgQXTUwAg3B3YWTw0LUHLRjDWTGkUnmbOAaohdKavgwORId4U3JnLYaXzxN+cvE1csH6itgtG99k/RYY8oH9JepbdWsn9OG1ee1Hv2plAHwl+v2KrUBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357214; c=relaxed/simple;
	bh=WkY6cDC1QoZ27Av2RSpe3GudAoVlMWZLoLjO5zdPx3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2a/gzcu4tMlLMsseSRzkoM/5Jhc2irPEXSXW1gLWjWfV8VOQXylbbqtXyHXpeJSDPmW2vgxgo/wHUTP8QiuGxzLE3gv/ssC0LRUaYxAm0cJFnSDy3Jfnnj77uDvsootxwuQ7XxHlRrJPxCagzz/soXtsKByfIjoTVbDW871Sr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JjgMSo8T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb95317so37439575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734357211; x=1734962011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6zMvmG2+uzmRRZ61sFLQ9H0rO9rbqdQZ5p/tJY9Hns=;
        b=JjgMSo8TBquKg9wWywNFmI8+2S8MwuY4NKBo2ymmbQTqs7+hgyynIW+4AhUAfRjJxQ
         cfJMzOIL43S+zzb3XFUKdwb6K/sYICpqyXLjH5gPwBN76fc59b29YYM7AgEjNKL7GbA8
         xJO/walsezNvJeAdueBkX0hEr+Tq2cKhpzCQGqbYMGsSueT4wg5HdbCxAlNdxhOEjTmL
         mhUSlP4v1KOiZJuFTTVzOHuFad85YZcVElLNJOWgKDwqU5WTkxNey1lv7ziCLWbFLGUs
         HTLHxJsuleZjLvkiETIiDPp6gmFagyZSvrpP3RR5wihKehFL4c88MLm89oVQ6Nb7Pp0L
         t1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734357212; x=1734962012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6zMvmG2+uzmRRZ61sFLQ9H0rO9rbqdQZ5p/tJY9Hns=;
        b=kzRFGqnMvZ4UrbiXJ4cVjJRxEa6uwX1GzjOP9PIEcD+k2Ln47IHIcAj5B8Xn03aW3p
         3kQtktgYD2PIYj61uOtLx6KKWIQiJ5jSjgp5BCVl6TD1PPTWzn07e/rYnznctZ3XY4Vm
         hLbiQLcrIa7t7RIqtrkK+/xNcc7KwebIQTN/EjqkalmDw6j8G9RuSsvfN5D0FfuEFe5H
         rqXZEQqOTxYYePXKCRaIylQJwChsQjEBu280Fz0qWp3oPhG7S5aN3BsYbKVOnPMK/tkF
         9XJeYc7K+0OJqxBDXbnsD8bcxj4uRDzQpEdY68bNM+doxmixrKFRCbAzM/dMP/xAgbVk
         By+g==
X-Forwarded-Encrypted: i=1; AJvYcCW7yLr/gJp40VzP01frRymCu1i7d0E85GPdmvWADqT+yFtXjLsSfLmq6SB8DMBQfEcHZhk92Eid1icWl+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrslFcb0HOThQaKfE81Wg+FWS7+Ey6AZVyqXC2WrEQjdSfgnHU
	HPcSJ8VF71xELReLG30Gg2qui+MTa4iX2BeDFV4zGS5a75odm6kDIXJ11WuD/so=
X-Gm-Gg: ASbGnctAfB4t6Lksr86Qsc7dOM6pPJbnLUFBr0mD2qRRN6/AWmhw1xB5cFfT3CGKOrf
	luxPz8k4Wap53lxPtPk5VNCY9q3VKz6Bfq8lcv91sDVkWU0WmiIosVdzWnVKu6oGQMguK6dC76s
	Ubw1ldmTpp3zDsfL3igKsKuJML010kcCTJjgFyaLeevOSdkTWU6cpugUrW8TcYYnr8/1e6bmoQv
	v5hu4dONE0PQqdxCQbRolCeBMUN8wBGdH32IWy6lqFzjsvnWYA0Q65LQ0BUnOxi/xkAwesrDa5+
	O62iObuXaQom3q+YE47as8wO0wfVmUIG3esUkRLk3YZc1tKhIu0K1QY=
X-Google-Smtp-Source: AGHT+IHyRpxS8I8LTVX58lZkgV3hcqjzdArgXBTP/oGtQrcmkoT7Zay0fgtIbzpJHrkn13s78Z6EGA==
X-Received: by 2002:a17:902:f546:b0:212:5786:7bbe with SMTP id d9443c01a7336-218929caae0mr162490085ad.24.1734357211700;
        Mon, 16 Dec 2024 05:53:31 -0800 (PST)
Received: from ?IPV6:2409:8a28:f4f:a9a4:7c29:e1c0:98b3:5c62? ([2409:8a28:f4f:a9a4:7c29:e1c0:98b3:5c62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63896sm42806225ad.223.2024.12.16.05.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 05:53:31 -0800 (PST)
Message-ID: <9c6a4e46-7f98-4809-b4bb-fa83a4461474@bytedance.com>
Date: Mon, 16 Dec 2024 21:53:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
 <20241216120313.GE12500@noisy.programming.kicks-ass.net>
 <20241216120526.GF12500@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241216120526.GF12500@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/16 20:05, Peter Zijlstra wrote:
> On Mon, Dec 16, 2024 at 01:03:13PM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 16, 2024 at 01:00:43PM +0100, Peter Zijlstra wrote:
>>> On Sat, Dec 14, 2024 at 05:02:57PM +0800, Qi Zheng wrote:
>>>
>>>> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
>>>> index c73b89811a264..3e002dea6278f 100644
>>>> --- a/arch/s390/mm/pgalloc.c
>>>> +++ b/arch/s390/mm/pgalloc.c
>>>> @@ -193,13 +193,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>>>>   	pagetable_dtor_free(ptdesc);
>>>>   }
>>>>   
>>>> -void __tlb_remove_table(void *table)
>>>> -{
>>>> -	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>>>> -
>>>> -	pagetable_dtor_free(ptdesc);
>>>> -}
>>>> -
>>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>   static void pte_free_now(struct rcu_head *head)
>>>>   {
>>>
>>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>>> index 709830274b756..939a813023d7e 100644
>>>> --- a/include/asm-generic/tlb.h
>>>> +++ b/include/asm-generic/tlb.h
>>>
>>>>   #define MAX_TABLE_BATCH		\
>>>>   	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
>>>>   
>>>> +#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
>>>> +static inline void __tlb_remove_table(void *_table)
>>>> +{
>>>> +	struct ptdesc *ptdesc = (struct ptdesc *)_table;
>>>> +
>>>> +	pagetable_dtor(ptdesc);
>>>> +	pagetable_free(ptdesc);
>>>> +}
>>>> +#endif
>>>
>>>
>>> Spot the fail...
>>>
>>> That said, all this ptdesc stuff is another giant trainwreck. Let me
>>> clean that up for you.
>>>
>>> ---
>>
>>> -static inline void __tlb_remove_table(void *_table)
>>> +static inline void __tlb_remove_table(void *table)
>>>   {
>>> -	struct ptdesc *ptdesc = (struct ptdesc *)_table;
>>> +	struct ptdesc *ptdesc = page_to_ptdesc(table);
>>>   
>>>   	pagetable_dtor(ptdesc);
>>>   	pagetable_free(ptdesc);
>>
>> And now observe that __tlb_remove_table() is identical to
>> asm-generic/pgalloc.h pte_free(), pmd_free(), __pud_free() and
>> __p4d_free().
>>
>> And I'm sure we don't need 5 copies of this :-), wdyt?
> 
> Argh, nearly, it has the whole page vs virt nonsense still going on.
> Bah.

Yes, maybe it can be unified into struct page parameter, which seems
to be more convenient for conversion:

static inline void pagtable_dtor_free(struct mm_struct *mm, void *table)
{
	struct ptdesc *ptdesc = page_to_ptdesc(table);

	pagetable_dtor(ptdesc);
	pagetable_free(ptdesc);
}



