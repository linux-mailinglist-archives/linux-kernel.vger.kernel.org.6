Return-Path: <linux-kernel+bounces-349981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C786A98FE2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B475281B67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731F2209F;
	Fri,  4 Oct 2024 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFzNe8Uo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A841C62
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028545; cv=none; b=SQS9Q7WEsWWg/2X3znlgxqMSOfhK7+dmZRNIZKcGAWHldAhzp6SEnFhS8/M9k+achVOf6uFX8y1n0DTyyI0HPnsL2k2Kv1I/7Dni2txeEi1++xG1hr4TCweyuG/8YC6pU6xipAjMWVQr08I0cLy71e8YzJUQLSLCxRFlI13NRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028545; c=relaxed/simple;
	bh=G+cZn765wenKWCbw2dYF6ZkOoxbY44RcWsuONAq5fyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lx4nBx2W+u/hLbDi+eIbBWE5FvjXpsBmTIbZaP5KhnQEwecnE5gUh8hSnOpP8st1x1PoQ066nejVXsNahjzaxo1z/A3/GE7A9G0JY+2T6funARcviEcMpyedEJZvSS9HgIb30kcG6Ia283h/l4UhdqPzQtZSaoTBZw8kqUP9DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFzNe8Uo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728028542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lXI+QFEymJCgMCwjjBqS06bwqXvLF6EyWgcZxRtmTRs=;
	b=RFzNe8UoLDyW8ql7T2ddmMLhTkoBmRQdGmcBjvmAJJNjUTN6VcfeTO6r79J/EVLOzi+Rej
	LUjyxrVwAfxIrlq0lANTLjPv8a+vcxTZJNlT/Lt7jorbVwAJGdc5vUkU+zw+KHqP+apWDL
	Ur9/M31msWV9KVGLAWaEpxr7gINkIfM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-vv5NXSWsMOigBF7VwlBzSg-1; Fri, 04 Oct 2024 03:55:40 -0400
X-MC-Unique: vv5NXSWsMOigBF7VwlBzSg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso13628255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028539; x=1728633339;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXI+QFEymJCgMCwjjBqS06bwqXvLF6EyWgcZxRtmTRs=;
        b=VNF08F0FRd2P9pKL23PdnhCVnqwGnZXQ0Rg91Tp4/pAWay/ID5eL9fhWdoNKzKzW3/
         BNStuols2CfE4bbo81wpEYbiWmi76QBBI+qQRs4Yl9uluuOptEMp75bzxAA9PJ5A8uex
         m/KrQuTMByxgvI0g7JUnmzkRqlIe9Q+7CrFzRyHwWjNpH8CY8L7/X2RRe/1xKmM26opo
         5SpRwhJrMz0HPOM+VAgkMNOV7e7qyzjP78mqWPeawFY7ZomNlDcFIYDfN+ojORt03A4b
         YYTpoCtuiUpqmbmiIJLhPp47thbl6k7ZuZbRhWS1ndAUio3iG/CDL93U4GtkO2vxwSA6
         ezVA==
X-Forwarded-Encrypted: i=1; AJvYcCWK3qLSoasbbxgXSUaa8L/+MCgZWaVqIFlV7m1KI+yF8M2NfFtIRhPJrpg/5uoVJfPn2KRVcoV8j/q95Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP93+g9IypZPNTQr1zt8baoYndSV2+eeqpzNbLL2TM9IKYyTwz
	phgTXzCcN4c7jwnC5GC+1Tgd/gYo+JgO8SKNN0yn0z/1Utt+ROqCdiW7FUOAyv7MpiE3dTH1WqI
	j3bs/WDZs+XNh4M4elxS2kjgR/4BXn7dWk6YU2yIw67BPyWdmKT79Lvsag++8kA==
X-Received: by 2002:a05:600c:34cc:b0:42c:d74b:eb26 with SMTP id 5b1f17b1804b1-42f85ab86admr12884605e9.21.1728028539522;
        Fri, 04 Oct 2024 00:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHluAvPJdcoOT86RK7BCrUYkmmA4FsnqxFsAT2HM4iLM0p3p4z+cqWiSNeMNGIhg45SZ25bYw==
X-Received: by 2002:a05:600c:34cc:b0:42c:d74b:eb26 with SMTP id 5b1f17b1804b1-42f85ab86admr12884355e9.21.1728028539092;
        Fri, 04 Oct 2024 00:55:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:d00:a1ab:bff4:268f:d7c5? (p200300cbc7140d00a1abbff4268fd7c5.dip0.t-ipconnect.de. [2003:cb:c714:d00:a1ab:bff4:268f:d7c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b2b5dasm9067685e9.38.2024.10.04.00.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:55:38 -0700 (PDT)
Message-ID: <841de51d-1a93-4a1f-8096-5876a6695a7e@redhat.com>
Date: Fri, 4 Oct 2024 09:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: Move set_pxd_safe() helpers from generic to
 platform
To: Dave Hansen <dave.hansen@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, paul.walmsley@sifive.com,
 dave.hansen@linux.intel.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ryan Roberts <ryan.roberts@arm.com>, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241003044842.246016-1-anshuman.khandual@arm.com>
 <773d1ac3-51df-4467-9e85-9a3746398dce@intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <773d1ac3-51df-4467-9e85-9a3746398dce@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.10.24 16:09, Dave Hansen wrote:
> On 10/2/24 21:48, Anshuman Khandual wrote:
>> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
>> platforms, do not need to be in the common memory code. Otherwise they just
>> unnecessarily make the common API more complicated. This moves the helpers
>> from common code to platform instead.
> 
> I looked into the x86 side a bit.  I'm pretty sure we can just remove
> the _safe variants.  All they do is spew warnings that don't seem to be
> doing any good.  They're not really safer in any meaningful way.

Yes, one reason I am happy that we are removing them from core code :)

> 
> I've got a series cooked up to zap them, but I need to get some eyeballs
> on it.

Feel free to CC me. If you're busy, let me know and I might have someone 
to tackle this.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


