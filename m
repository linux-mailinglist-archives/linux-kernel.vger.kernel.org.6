Return-Path: <linux-kernel+bounces-270809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE901944587
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4582284096
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC181586C0;
	Thu,  1 Aug 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok/3keBP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070A157A5A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497730; cv=none; b=hOoUcPWd56fkdqGi7px+ccMQMjVq/cIuMBWgDxVQahto6j7JGMuUG3l3yO8cdxEqf1PuK9JO3eIa6Iv5uo7SEprL/ChZv2gpYF0ArNmIVRi/3IQuLIy+MYXRxUl4fSM62hPlBPeWfOBru5SVl6imI01c9mkOR02eyuMfr6c/cu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497730; c=relaxed/simple;
	bh=L4qWynQKychkT/51FJvyg+iSEFhc1FXxfAr6hqEBe+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwlqUrk0azv7LNeWQALAfl6ihw2d943rV8Pg2DN23O6cRzwqVWmHAuMmlUgmwTJoYwW4tzGFJ8Onihih9AMKWmfvNSKWrnIy09eEKTuh3nizbqVk3Tpndmso39o8syJyTObvyGF0wj8/+gY7r9OUoHyXZBh75jRwrnkTe8uuV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok/3keBP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722497727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1hYX0L6ZedJnEdtZfBvg3KBLdT3IMDSMx2Py5ZhR+5o=;
	b=Ok/3keBPpEVc2nbvBfpvjU2TajzZflFAGCUHREf+1brVUval9qKx9neafDAeHe08rcM3zq
	kM6QVFcsoNgICuIZDNQpXNcjyCRgWm/BKPpP5kRAFrybY2IgpOhN+jo88suTnr6ZgsFtub
	fI+fK41/oPvGFUqqZalr/wTh58x9hq0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-u1X79LucPxSRUZRGhuagWw-1; Thu, 01 Aug 2024 03:35:24 -0400
X-MC-Unique: u1X79LucPxSRUZRGhuagWw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52fcf2b5287so7138402e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 00:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497722; x=1723102522;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hYX0L6ZedJnEdtZfBvg3KBLdT3IMDSMx2Py5ZhR+5o=;
        b=qs6q5YK3+UfZgZAi654zyEIXKWbjNhUs3vFda9z+sb4ULuZJ8g+gK5kC8xG/WMWmMY
         zTIMJpnPmlf2HhFI+lKLfTcZPN8g4G089JbUvxdZ80IBDdn3uBhI23ssdfaoVU9dSzSK
         Wc/JtVNxfeXTfJSPReaoSdgxNYFGLxogCBxi5y4wkQkF6+a2ddb0Tju1GkxwOa9X1nA5
         YRjEx6wzJgSJqDQnlSvOe7r/slgXcLDwuM1OnXbkv/LZW4GzYDptFPScGyteGUfD7Alp
         9x4Ay40CXPK1W/glJX5idC6KJLlJIAefsf3v3nclrTqy9jYkCaGGR05RcNIja56oYV8k
         O8nw==
X-Gm-Message-State: AOJu0YzRVZXYfanRcp/mKA+gP0IMN//QkYt/RqIuS2mdj5NLLkN0XTfI
	GNl77ONHEbydUv7W3RceQPK+A5Y7FiKHhyvyz9cccLHB/8EB89o5jhy/BUI0gAuDIbo1YMCmlIa
	Pxry4JWoCrD4cDn87fjTsCLbuK3x5tVsMtSHv0eDfVnGBbPLOlETFFkQDQjrBZA==
X-Received: by 2002:a05:651c:1037:b0:2ef:18b7:4408 with SMTP id 38308e7fff4ca-2f1530e8ae8mr11328621fa.5.1722497722009;
        Thu, 01 Aug 2024 00:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX9rAQE8WF1+Fpjc4Z4kjegOzlas5pBC21l1Rd9Aor0bimSbLCGWJi3QQw6GOFDhKUY3rA6Q==
X-Received: by 2002:a05:651c:1037:b0:2ef:18b7:4408 with SMTP id 38308e7fff4ca-2f1530e8ae8mr11328361fa.5.1722497721372;
        Thu, 01 Aug 2024 00:35:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb226b0sm46636415e9.46.2024.08.01.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 00:35:20 -0700 (PDT)
Message-ID: <3898204d-83c7-4eb9-a4bc-90665b505704@redhat.com>
Date: Thu, 1 Aug 2024 09:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Michael Ellerman <mpe@ellerman.id.au>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20240731122103.382509-1-david@redhat.com> <ZqpQILQ7A_7qTvtq@x1n>
 <2b0131cf-d066-44ba-96d9-a611448cbaf9@redhat.com>
 <871q39ov7x.fsf@mail.lhotse>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <871q39ov7x.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> pte_alloc_one() ends up calling pte_fragment_alloc(mm, 0). But there we always
>> end up calling pagetable_alloc(, 0).
>>
>> And fragments are supposed to be <= a single page.
>>
>> Now I'm confused what's wrong here ... am I missing something obvious?
>>
>> CCing some powerpc folks. Is this some pte_t oddity?
> 
> It will be because PTRS_PER_PTE is not a compile time constant :(

Oh, sneaky! Thanks a bunch!

> 
>    $ git grep "define PTRS_PER_PTE" arch/powerpc/include/asm/book3s/64
>    arch/powerpc/include/asm/book3s/64/pgtable.h:#define PTRS_PER_PTE        (1 << PTE_INDEX_SIZE)
>    
>    $ git grep "define PTE_INDEX_SIZE" arch/powerpc/include/asm/book3s/64
>    arch/powerpc/include/asm/book3s/64/pgtable.h:#define PTE_INDEX_SIZE  __pte_index_size
>    
>    $ git grep __pte_index_size arch/powerpc/mm/pgtable_64.c
>    arch/powerpc/mm/pgtable_64.c:unsigned long __pte_index_size;
> 
> Which is because the pseries/powernv (book3s64) kernel supports either
> the HPT or Radix MMU at runtime, and they have different page table
> geometry.
> 
> If you change it to use MAX_PTRS_PER_PTE it should work (that's defined
> for all arches).

Yes, that should fly, thanks again!

-- 
Cheers,

David / dhildenb


