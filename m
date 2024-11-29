Return-Path: <linux-kernel+bounces-425407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A83B9DC1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3221650C4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB771865E1;
	Fri, 29 Nov 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvhyI59F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2B189BB0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873559; cv=none; b=bGAMRQuUyMokFb9nk/QEMLzy01i5dXwdJAw83jbOHcEKCgb46qufeFdUDNqCKtYQNXxGibRh59TUdE0XfcHJrtHKDMyngBNk8lk7eChNBIDhJfI9yZFZ24IMxShAb0UGXgp+2syABFoDk8gE8AQCgP6+OJhn4Z2ymDSuYWjsTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873559; c=relaxed/simple;
	bh=+eJ2DdjjN5mt0tkgk6GNqw7jOnWFeq05qFBaxOy7G/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3QVoxdu2Q/sOZ8qFA8NmGiaFyEpleaBOdLZB/lkEoiB0M4rwMPluEoBW+p/5CGrwu0Z+4fC355wo/tLmYpZoH17ykDHfnlHayvVFTwp4WNryEGghzjjQzPtkTKtzmzNpQbz0VpJf9LepaMitLPxyOiLHFrV8PmbCBS37J2eOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvhyI59F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732873556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CMh10fMtJjOTCsMaQYRHEwEDpOIse91ya0q2XctgVE=;
	b=WvhyI59FaD+Wu6Ro+ZE6ZkcDhFYbpftJeSk6bmjaE9vHOjZ+y4PXJWUvyxDTMudS3WOBQb
	4MAU9KpNMdCCgsz4uGXuTrsD5Ukvlb5oBb4Jz51aPs3MCXHWy8D4N6ahjSBEx59yPXs141
	QuoQqgMNWjB0F0vACk2l6p1jKi5yq50=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Z7C2J_RXP4KK1CzSgteteQ-1; Fri, 29 Nov 2024 04:45:54 -0500
X-MC-Unique: Z7C2J_RXP4KK1CzSgteteQ-1
X-Mimecast-MFC-AGG-ID: Z7C2J_RXP4KK1CzSgteteQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso15116135e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732873553; x=1733478353;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CMh10fMtJjOTCsMaQYRHEwEDpOIse91ya0q2XctgVE=;
        b=WAUuQalpkAeQUQ7ZP9MePmuZt71IcbXQ8+am3dSxX59UFAJIYhFaEhC6yB7HXBMNFy
         zGl0dqkt87d0IFkdGLHsQhnLIM7cs3rFcm/O3hiNHW5Oa6LDYQb8VQKhLD1r9nPop/cl
         btVGrCjlbi7ngQiICObxxhbovrd+BJzpRL81Qk8rW5T+mIDZgF7RhOLYySVuwf23iGXz
         pM59qjPu/AXhJ0wBkQTvqXofq/iFGke6bBWCF0nW4TI5hlGvStziO/GTloeDjxi/aXay
         DzXGlzXU4Mtg+h57s1qlxldfmucJXoz8A6yu5IY7vU6ckaB/V8w6rWNLhUHdJL+to1Ph
         6o0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2nzzZx051Ga80SSp7qfBw/1rMsLtaz25Xqjv6InYE+GVDiZ3mvDdiZHPpJFmtzQWR93jTUKHLzwMdODk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLCZPZDb/LqJsrrfixawECWTZSZaktG9wvK+62OuDv9h3+FFS
	Y3i+urmcUFtEE60SDzmwPhG2mFyIi6ZcnCuqNScWdqrqSZmg/zQDqB0xMZJ/LXNff10Vj3j0ePG
	+NDTYWdKUYMOtYj3BVIZKOuDufiFdllCUjPIddnRlvN8F7Ou/chnCR8eklYmpJA==
X-Gm-Gg: ASbGncuDNSwvxNx6XlyLRJT/BsqMHm1VDWbU0xAzHJ32Jze8yBncYaw7JPQXV5a3jYD
	uKVrcrFncT3L9V7jI6iVJVgYQYjp+jdP+aQUAQmF5coeX767TddUz62xE3JTJeElDCdufuDCHmf
	jRsJSv9j4++4wI4o5Bdyr6hTq+x7Yrju62du81ZPLSpRm9KREzVw6Sl8Y0fqTJsC7r1BdfKbbBX
	jilFmBkY7Y3DpO5sTohNix8ycvQ1lZkXnmsko6In+2uTtDVp4rzA/o9uxcgHBNFEMcDGx8kGPrk
	heHYXFshsfwTbRBkaJH5sX14xhTJXrbDfzazSY165KW96DjEYK1oVJgBKfNlMy6/G5V8AbvRFuF
	e3w==
X-Received: by 2002:a5d:6dad:0:b0:382:3959:f429 with SMTP id ffacd0b85a97d-385c6ccaeafmr11080916f8f.5.1732873553026;
        Fri, 29 Nov 2024 01:45:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8JzoC9JMCXdm9jg9jlWlCFCVipya1jw/IPEEUtYi2V4iKWDyzIpXQTPW0hPwUOsoHg7n9mg==
X-Received: by 2002:a5d:6dad:0:b0:382:3959:f429 with SMTP id ffacd0b85a97d-385c6ccaeafmr11080883f8f.5.1732873552709;
        Fri, 29 Nov 2024 01:45:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f326a9sm47722075e9.35.2024.11.29.01.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 01:45:52 -0800 (PST)
Message-ID: <e08c88bf-8aa0-4b18-9d8a-77f1a60436e7@redhat.com>
Date: Fri, 29 Nov 2024 10:45:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [madvise] 2f406263e3: stress-ng.mremap.ops_per_sec
 6.7% regression
To: kernel test robot <oliver.sang@intel.com>,
 Yin Fengwei <fengwei.yin@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>, Vishal Moola <vishal.moola@gmail.com>,
 Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org
References: <202411291513.ad55672a-lkp@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
In-Reply-To: <202411291513.ad55672a-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 08:49, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 6.7% regression of stress-ng.mremap.ops_per_sec on:
> 
> 
> commit: 2f406263e3e954aa24c1248edcfa9be0c1bb30fa ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [still regression on fix commit cc864ebba5f612ce2960e7e09322a193e8fda0d7]
> 
> testcase: stress-ng
> config: x86_64-rhel-8.3
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	test: mremap
> 	cpufreq_governor: performance

A MADV_COLD / MADV_PAGEOUT patch for large folios / THP affecting a 
stress-ng mremap test (where propably no THP are used)?

Sounds unlikely ... ;)

-- 
Cheers,

David / dhildenb


