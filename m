Return-Path: <linux-kernel+bounces-287797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E25952CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923111F22632
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E21BC9F1;
	Thu, 15 Aug 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/bTL0B4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552E189B9B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717605; cv=none; b=V1bRM+fCofYcdk/z8YqRoxj2hTyxn103sMf1L2HvXvhRiQCkqrD7sgVw2WQ4Va4JSh/RenouZClQ8ofgxmcgFjwRser53FV/fnyB6kccNhNKdGb4t6uKMrPSMwgHTl4q+ioGtAKifhdq8ZH6lQQhny06D/nGbPa6/DPi3Qgc1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717605; c=relaxed/simple;
	bh=mhjJFLRMb6dT50ID1vGNARplzqgySHMty31Z4vYmZis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FA8bUer7dNi/9M1sVRt92V5+AYAIouGEnoeCpZlnX0/pVvC3dt7jXdA06qWT6o7JdaoBZTO4bJGSJ9ITpbmqtcNn+Fx1ty9WrOoFFzxg1l/yTA7BME0e2C1hiTID3FaNHGRBZGsXMuYoG3/VJ/KPUzPNglaiBeK0uPjdlyi/Y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/bTL0B4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723717602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UjgqDmjHQjGy0NlycEWk6Xii++ilUVQ2YfrX1Qn0afQ=;
	b=a/bTL0B4V60050FFePljImtbXPCr+ggslRlvCGDc6oIgnkvn/0z5/QhXZBzIPik+Buq1o0
	xG8Kf78vPo0xZg7gPfvW5odyAIa6i1SrWADsXiI0xrzMZyecKeLnZuuXJLlH/JgSSc7HZZ
	8fCRHx1b/drjVRLm1Fy8HfSvK0uDad0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-ERMINiWoP0K0itIKTqqpiQ-1; Thu, 15 Aug 2024 06:26:41 -0400
X-MC-Unique: ERMINiWoP0K0itIKTqqpiQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-429e937ed39so3004765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717600; x=1724322400;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UjgqDmjHQjGy0NlycEWk6Xii++ilUVQ2YfrX1Qn0afQ=;
        b=s8pWHCZZn0tolXzBGQ8UxsbbWR31EjuZYmEzb372r3XmGLvsifkOPVVdRdQJYnJwM9
         CxMIu/lv94sqr7ZRse8NBEsvbp5YniGYqpRQhqRkJr2E6zNlBw67mpuvNPZjPCO15Hk0
         cmLYMiaHBoS28hqezAYmqz8BeRoVtLvIrqFzC9MpetUlM8kcKsZ2BUS5c24OjtzmZTnR
         PDdon4NAwAcbKH1EjqGHOZ3I63Mx7CUhvCd3YtGxeVJTIkrDQwiCEhtgN8yXf8hmpjJU
         WHi43u9QKZ0SixdRdyZoH1jxpqjZN7ErZwaxftOE3nDO49qMautQhv9Y0xmi4fIRsI8R
         lnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNLzVNe1Guvp9+W4wVrh9N0SmEWfTb1CkImutCEs2undA8wMwrvEQFmgvSJz0kvFR0YdMK1zdGmlrEzhwrkZIOw2Ht1wJdZ9h+lcc8
X-Gm-Message-State: AOJu0YwcUm4m+VbB/CZv7X2mjPMPWlvBF1p4ro4yakic/GI1BUSTMNBe
	DJll8uVLnADE9CseEYf6MCwSQSPGYRmnRBHriE229WWMaKAuObmUCWQ48lKzIWq1gPZGyiBZOdI
	YztF3R2NnAqUD/dLXsc4rfKmh+InI3NOapg+WUsMjJps7dxSvis3C90GW8+8K2A==
X-Received: by 2002:a05:600c:354b:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-429dd260171mr42399325e9.27.1723717599926;
        Thu, 15 Aug 2024 03:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Kwy0jjRo3DEmgpacSzyWFZaRkaLE0CXZhm38D5h5NaOhy9dlCteuFe2EH3rtpT7lQgqVOg==
X-Received: by 2002:a05:600c:354b:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-429dd260171mr42399165e9.27.1723717599474;
        Thu, 15 Aug 2024 03:26:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6d00:aebb:127d:2c1a:7f3a? (p200300cbc7176d00aebb127d2c1a7f3a.dip0.t-ipconnect.de. [2003:cb:c717:6d00:aebb:127d:2c1a:7f3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded292f8sm44073745e9.14.2024.08.15.03.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:26:39 -0700 (PDT)
Message-ID: <6e23c705-3d67-419b-b085-f19f5101124c@redhat.com>
Date: Thu, 15 Aug 2024 12:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com,
 v-songbaohua@oppo.com
References: <ca3aaa3f-f018-46e4-aad1-c6a4fb8c7f11@redhat.com>
 <20240814085409.124466-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240814085409.124466-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> +static inline int get_order_from_str(const char *size_str)
>>> +{
>>> +     unsigned long size;
>>> +     char *endptr;
>>> +     int order;
>>> +
>>> +     size = memparse(size_str, &endptr);
>>
>> Do we have to also test if is_power_of_2(), and refuse if not? For
>> example, what if someone would pass 3K, would the existing check catch it?
> 
> no, the existing check can't catch it.
> 
> I passed thp_anon=15K-64K:always, then I got 16K enabled:
> 
> / # cat /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
> [always] inherit madvise never
> 

Okay, so we should document then that start/end of the range must be 
valid THP sizes.

> I can actually check that by:
> 
> static inline int get_order_from_str(const char *size_str)
> {
> 	unsigned long size;
> 	char *endptr;
> 	int order;
> 
> 	size = memparse(size_str, &endptr);
> 
> 	if (!is_power_of_2(size >> PAGE_SHIFT))

No need for the shift.

if (!is_power_of_2(size))

Is likely even more correct if someone would manage to pass something 
stupid like

16385 (16K + 1)

> 		goto err;
> 	order = get_order(size);
> 	if ((1 << order) & ~THP_ORDERS_ALL_ANON)
> 		goto err;
> 
> 	return order;
> err:
> 	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
> 	return -EINVAL;
> }
> 
>>
>>> +     order = fls(size >> PAGE_SHIFT) - 1;
>>
>> Is this a fancy way of writing
>>
>> order = log2(size >> PAGE_SHIFT);
>>
>> ? :)
> 
> I think ilog2 is implemented by fls ?

Yes, so we should have used that instead. But get_order()
is even better.

> 
>>
>> Anyhow, if get_order() wraps that, all good.
> 
> I guess it doesn't check power of 2?
> 
>>
>>> +     if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
>>> +             pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
>>> +                     size_str, order);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     return order;
>>> +}
>>
>> Apart from that, nothing jumped at me.
> 
> Please take a look at the new get_order_from_str() before I
> send v5 :-)

Besides the shift for is_power_of_2(), LGTM, thanks!

-- 
Cheers,

David / dhildenb


