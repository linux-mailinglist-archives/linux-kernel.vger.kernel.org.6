Return-Path: <linux-kernel+bounces-402614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD19C29AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A5D1C21BC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E943C463;
	Sat,  9 Nov 2024 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jb0dZEXA"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAD15D1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731122147; cv=none; b=OAs+mY591rCjKZxvZd5BzVzUUEb5/wuuTw/fZ6Xmq4ERimFeriRP9gNQckR6jQPo5A0C17id9PCjCs6w3NPKWnByyW8837JrcKhnNyqvNIM1oS7ssvNJeSdyS2XU1DXrH7EcxQmprh0DmfY9hNZyvkfWh/m3hrYrsPmfqnqY6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731122147; c=relaxed/simple;
	bh=a6qNzLUYzxhXHLEVN4bdteRfH7o+ZITOgK1ZZhQyCWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDQCf01P7gytfE3n18lxvq66j4HPGZgBgvp8h9v9YD/XRHF0hQK7Fhb0fm/vmB7OxEz4RoaWnMzO7bnBqUiO+7X0UNV7iIwDRrQqHRALG6OFGuvTTi2jAP9r4/MdddnuQzc2yZgNzAH8CEFuS3u52qFBPUUCHnJ2b3eRpbhTi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jb0dZEXA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1727167a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 19:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731122145; x=1731726945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSGEji7l7SmehnMI3kxciLW3xRBpDOGyd1qw5jIicSQ=;
        b=jb0dZEXANJKE988PmOc1O78WzpsEwOuwuEa6quRLD65Y4P57wvFIKrCOoftEhI+Hln
         eeU7dggj+A/6kvFt2S2+9PPMx820zZsU43NAS8/rUDOMHJBLhTTaKFOldhLE/BpzEgpF
         2GycJ0UC1Od43lTf1xmZauMz+0w67xo8mCOAmsgkFGMLUg4p1hFgTcyc0GKMd4UuiIjA
         K/wvQxq6u1ON3jAwwSl4CfaiVWjaWDPcIK6JNt0I2MmOVX7lP/34DqNdtehT/78nHa4M
         QjBx9Wh6e4HgLs+FPyKQo9fUH2RqJIkGL7NmzERbIGMcShIDt/SgYtArC+/8kprZyUhn
         dbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731122145; x=1731726945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSGEji7l7SmehnMI3kxciLW3xRBpDOGyd1qw5jIicSQ=;
        b=jZyNZiiyXbKltyVpZ8ou1gFDOYA8+L9WLhHnI9i/9xEAm22pfm73+cOXHEZftiEQV+
         5UyRwUDuKWQ7pSLRrDz1vzfaKrFfBA/fCDB2JCA7OaRhvmiTMOFMXIiyxT9qD1tcNX3e
         6p5kM72t0GvbfSzmsvM75hujY+cdSDt5SfuVADmy3UezTyghNfkg6Y2H9QWVgeg5pXRa
         k9atL0YGJsd8Cw8Ae57r2SilX1BjC67YMnxRFOminj0xgQ4dHNOIfJ+U+gCJ7P4v+NTs
         /NLze+heCy67TaUDHCIZh1HRjgPH0Yq+uEBieYZsnxazEbLGpitCdvxTjVwU/+4OiCB9
         EPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAvmIfIkuUHNMtJ/waVti9GQJPBgMf1XYFOouScliQotMw/onsHnrED3fKHbBczpwkwD53ovi5+/m1IMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9OY/ctxH5UT7C23iLKKwjJlSLXWaeQU7LMF1bfJsMTBJzwia
	3qXo5S9BfXErTfNrQvgxRYSlVR2wRGz1tiaKIucINPyLACxk+vHWvPHyoLToV/4=
X-Google-Smtp-Source: AGHT+IHewqQX1y783Zo1DQ66/f5ROspqJrxlgDdx7FIUCqBqePVfL85uQIJdZi5d2waa2kd5jC9C0Q==
X-Received: by 2002:a17:90b:1807:b0:2e2:cd79:ec06 with SMTP id 98e67ed59e1d1-2e9b16955c6mr7853571a91.10.1731122145591;
        Fri, 08 Nov 2024 19:15:45 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a55bf2asm6415790a91.31.2024.11.08.19.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 19:15:45 -0800 (PST)
Message-ID: <0a27f4c7-fb1a-4fb9-b563-813e0d26fc55@bytedance.com>
Date: Sat, 9 Nov 2024 11:14:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] x86: mm: free page table pages by RCU instead of
 semi RCU
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c45cf245592ad4ccc86429f71500d3fc378ac4a4.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0XhKnr3uVODu+iihRi4XwLupy=YX8BHa==1Y-ZvrmKjg@mail.gmail.com>
 <e308363a-0c1e-421f-a35e-5bb750992554@bytedance.com>
 <CAG48ez1xdvsyABAzaBmcmHWwLHzgyb4ORnNE5OG-As5Mq2=MgQ@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez1xdvsyABAzaBmcmHWwLHzgyb4ORnNE5OG-As5Mq2=MgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/9 04:09, Jann Horn wrote:
> On Fri, Nov 8, 2024 at 8:38 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2024/11/8 06:39, Jann Horn wrote:
>>> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>> free_pte
>>>     pte_free_tlb
>>>       __pte_free_tlb
>>>         ___pte_free_tlb
>>>           paravirt_tlb_remove_table
>>>             tlb_remove_table [!CONFIG_PARAVIRT, Xen PV, Hyper-V, KVM]
>>>               [no-free-memory slowpath:]
>>>                 tlb_table_invalidate
>>>                 tlb_remove_table_one
>>>                   tlb_remove_table_sync_one [does IPI for GUP-fast]
>>
>>                     ^
>>                     It seems that this step can be ommitted when
>>                     CONFIG_PT_RECLAIM is enabled, because GUP-fast will
>>                     disable IRQ, which can also serve as the RCU critical
>>                     section.
> 
> Yeah, I think so too.

Will remove this step in the next version.

> 
>>>> +#ifdef CONFIG_PT_RECLAIM
>>>> +static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
>>>> +{
>>>> +       struct page *page;
>>>> +
>>>> +       page = container_of(head, struct page, rcu_head);
>>>> +       free_page_and_swap_cache(page);
>>>> +}
>>>
>>> Why free_page_and_swap_cache()? Page tables shouldn't have swap cache,
>>> so I think something like put_page() would do the job.
>>
>> Ah, I just did the same thing as __tlb_remove_table(). But I also
>> have the same doubt as you, why does __tlb_remove_table() need to
>> call free_page_and_swap_cache() instead of put_page().
> 
> I think commit 9e52fc2b50de3a1c08b44f94c610fbe998c0031a probably just
> copy-pasted it from a more generic page freeing path...

I guess so. Will use put_page() instead of free_page_and_swap_cache()
in the next version. But for __tlb_remove_table(), I prefer to send
a separate patch to modify.

Thanks!



