Return-Path: <linux-kernel+bounces-256452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F66934EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78C6B235C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE27313F428;
	Thu, 18 Jul 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/ha02Zy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7A13DDDF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311383; cv=none; b=tYpLWA2j+k8h6uhNnSBrNgX+JFgwACNy/alPGxlwPYSiK+SEJNGUnN6kx7oc/YSb0N2ev4gC5tKRjNuiAbBy49cOA5WlkWHti1vGJTXf2BdpARwQ/pQhSkDA1YkI3L6ZyqQxCNCUft+W6cVSp+M2+vsAIoEn07SY8Pwl9/Bfz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311383; c=relaxed/simple;
	bh=gGr8x75UBtWhjqcQTU7wc3t7Q8+hrAtGsF5BoVM24qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn4/0oLY9HuWwbLLPxAIf4UpxTe6LvHMjFJXNDCcn/p/o+yUm0d/84gvkAAB6eyaZ2N9YnyQ35uY4E6HbjZbogGdvBJwFj9hr1qGk/gjo7/dB/bStuaMc1R7+B4CuBKWzS1WaPW6LOEO8beidVgyB1MbFMGFf88yMMU2PSqkzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/ha02Zy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721311380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+loZ0f68kYG8SkIIMusKvmVieDf8D0mD93JjQ1E2Ip4=;
	b=O/ha02ZypjjF9bnDP71j+T8OVfrN1j6G95xWOSMmg7aaGwcPVd21HcPRPhw2a9KqIXh8L+
	5z6iSyJQHdz+c3AmUhEvTw76r8Fl7zEHgs4nmXfu0C7Hl3LDRiHvZkHF9KTP+zaUIxw470
	xfKTXBwwaNsw1AF1e73JBuql9jFUd/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ekscChuPPrisUkdm-U3NDw-1; Thu, 18 Jul 2024 10:02:58 -0400
X-MC-Unique: ekscChuPPrisUkdm-U3NDw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42725ef39e2so2788665e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311377; x=1721916177;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+loZ0f68kYG8SkIIMusKvmVieDf8D0mD93JjQ1E2Ip4=;
        b=KORhF9qX5C58lvUxlyg9G2a5nug5gQtil8olEVpCb88emutwVHpfFIuifW8fX3+69f
         3e1g9NBSUgPPE9Ihifn6mV/pS8WDBzMsurrUoUVWrwheG2N8XgI1GiuEatLt8tiDMYwk
         dEcgNkPpUmmNBj0y2tuKbIvc2D4md/rukQNGGTWYXanAoGm3+BwajHtfmHsaftfBsFu7
         QehtMMOKHXudkaucMKWgG5J4+kCKJxGTRbQxJSMmpYKmIAQs2ySBrtKFa4khKxNUJPoa
         W0+bmRTi3ffwsqTwAv6etnTimkjOUwNRWdF0j7uPeD58VtBr9ma74ZXOQYXrOpj/Ure5
         O84A==
X-Forwarded-Encrypted: i=1; AJvYcCVSPnS06phM1yk2fEQC9WqXzuP4YKWAzupeq46/uKalodVm2txHrwpqR/Uv4JcMNYm8rDxjPHS7hHDdOASKD/G6K+xBb+qefQUwmP8+
X-Gm-Message-State: AOJu0YyQtTqV9FzFuqdOWNJUI7AQW9XlbcfkCnpBIn/J4Gu48do+BOxZ
	xH+nVYHnRWcLfwCMeckH1H4hEc0bGl/uT9Id0hpCz1fmxEF1QRdFF4XhDzwJDTWkFqu8su/ejgE
	tDcAK++jWbB4aPBZWww3QTESHTk4AtpS5P/ioLmgzgjyrk8GgJR/6AoLB2ILSXg==
X-Received: by 2002:a05:600c:3d8e:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-427c2cb560bmr34294235e9.18.1721311377277;
        Thu, 18 Jul 2024 07:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK0NZZYcSH7GsGsuzC8RiS4wccHHzwEwUFVEThO1xOI2pK2E8CzHoc18ZBbYPcyJL8pOaUfw==
X-Received: by 2002:a05:600c:3d8e:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-427c2cb560bmr34294065e9.18.1721311376843;
        Thu, 18 Jul 2024 07:02:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1825asm14728955e9.15.2024.07.18.07.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:02:56 -0700 (PDT)
Message-ID: <ad628e27-6a8f-471e-b3d1-3ea77a97e090@redhat.com>
Date: Thu, 18 Jul 2024 16:02:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Li Zhijian <lizhijian@fujitsu.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Yasunori Gotou <y-goto@fujitsu.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 Lucas Stach <l.stach@pengutronix.de>
References: <20240716073929.843277-1-lizhijian@fujitsu.com>
 <6f2151a9-da23-4917-b985-8de6b0852e37@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6f2151a9-da23-4917-b985-8de6b0852e37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.24 13:16, Vlastimil Babka (SUSE) wrote:
> On 7/16/24 9:39 AM, Li Zhijian wrote:
>> It's expected that no page should be left in pcp_list after calling
>> zone_pcp_disable() in offline_pages(). Previously, it's observed that
>> offline_pages() gets stuck [1] due to some pages remaining in pcp_list.
>>
>> Cause:
>> There is a race condition between drain_pages_zone() and __rmqueue_pcplist()
>> involving the pcp->count variable. See below scenario:
>>
>>           CPU0                              CPU1
>>      ----------------                    ---------------
>>                                        spin_lock(&pcp->lock);
>>                                        __rmqueue_pcplist() {
>> zone_pcp_disable() {
>>                                          /* list is empty */
>>                                          if (list_empty(list)) {
>>                                            /* add pages to pcp_list */
>>                                            alloced = rmqueue_bulk()
>>    mutex_lock(&pcp_batch_high_lock)
>>    ...
>>    __drain_all_pages() {
>>      drain_pages_zone() {
>>        /* read pcp->count, it's 0 here */
>>        count = READ_ONCE(pcp->count)
>>        /* 0 means nothing to drain */
>>                                            /* update pcp->count */
>>                                            pcp->count += alloced << order;
>>        ...
>>                                        ...
>>                                        spin_unlock(&pcp->lock);
>>
>> In this case, after calling zone_pcp_disable() though, there are still some
>> pages in pcp_list. And these pages in pcp_list are neither movable nor
>> isolated, offline_pages() gets stuck as a result.
>>
>> Solution:
>> Expand the scope of the pcp->lock to also protect pcp->count in
>> drain_pages_zone(), ensuring no pages are left in the pcp list.
>>
>> [1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>>   mm/page_alloc.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9ecf99190ea2..1780df31d5f5 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2323,16 +2323,17 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>>   static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>>   {
>>   	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>> -	int count = READ_ONCE(pcp->count);
>> +	int count;
>>   
>> +	spin_lock(&pcp->lock);
>> +	count = pcp->count;
>>   	while (count) {
>>   		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
>>   		count -= to_drain;
>>   
>> -		spin_lock(&pcp->lock);
>>   		free_pcppages_bulk(zone, to_drain, pcp, 0);
>> -		spin_unlock(&pcp->lock);
>>   	}
>> +	spin_unlock(&pcp->lock);
> 
> This way seems to be partially going against the purpose of 55f77df7d715
> ("mm: page_alloc: control latency caused by zone PCP draining") - the zone
> lock hold time will still be limited by the batch, but not the pcp lock
> time. It should still be possible to relock between the iterations? To
> prevent the race I think the main part is determining pcp->count under the
> lock, but release/retake should still be ok if the pcp->count is reread
> after relocking.

Agreed, had the smame thing in mind when skimming over this patch.

@Li, with this patch the problems you have been seeing are fully 
resolved, correct?

-- 
Cheers,

David / dhildenb


