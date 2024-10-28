Return-Path: <linux-kernel+bounces-385463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC39B377F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B6B1F22773
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEC61DEFEE;
	Mon, 28 Oct 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTUo85oB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F818BBB9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135846; cv=none; b=YeadaKPa0Et10GJyorpAdwLCDx3MNJBHfLJIfxnorTvp+3fUiyNm/224KHz2zT6uug+zu+FF2hHjRgjtvnivLbfOOthW/hNZXNeho+Ngnai6AdIu3lDKo1iaYmQ6BnpppCwBfkzIoEjXpQdOz1tJq6v21BBwl0ylhO//VsC0dNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135846; c=relaxed/simple;
	bh=HZp4JbMz6q7SftCV8br0AUJfs0AHpYn5r/NX7muImlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjbQnw2RhD/PeOHCfhWO7OlinJFaLoJ4RVJeatq5kzoP7G305I0oWx5XhtHmZMBmizBtMqq92YST+eL+7aN91mJLfnS+6FEUekYl6/DxUXVt+pglJdB6uy6NYOYS9XGoBNysR2zmXAUW7TDFEOOXfrT7GIciWXr8IU7caerH2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTUo85oB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730135843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gY8Y33c6fcW0rhZR0CHXhiBabLxqsumNGmb1Ea5rVos=;
	b=gTUo85oB10f4I84oEbJzBWlf02xOgEme9D7u0P/v+Ctts9LBTXsgFug7Rkss3Yb+WI7F7q
	UQVoShfbJoVJkSawo3K3VOcxJB/MfdYcmZ0RJRIbyfZ2R0GsmiAvXJ8xe5ZQe3AU0MCZgr
	rpRWdnSBaWzxx80p3SvSveoSEwi21ps=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-jHk9BNoZP-6UxObaTB3_vA-1; Mon, 28 Oct 2024 13:17:22 -0400
X-MC-Unique: jHk9BNoZP-6UxObaTB3_vA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539e91e12bbso3294145e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135840; x=1730740640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gY8Y33c6fcW0rhZR0CHXhiBabLxqsumNGmb1Ea5rVos=;
        b=dcUHSC4R+BXNA1+5nqL2zvAcbBDtJHxj2od50HiGY+GIAwEilL7x0JEKFhkDPN7H/y
         vjtozbNfNCwkwR6fNJ5LF4Yb5lG9LRd7S9zI6iSuf4//mjdeyQNZfNhvLgExZYx+XH/o
         f+FXilzLb4UF3qg9+VLhuxTdMm6zD7Ok3b30PrUhyN8NXxh+UBezJrTgFBeCglmkZ9Jk
         ulPLaUdqGuqiQdKnX8t1KXJFr3Bt3+r7g0vefnCfKqwFmElkAGb+iZUEgaKak4fQDBSb
         Sb2richkPek4QWK76BhJkVEzRpWZs+dwu9Z0vPIl/hHwdIyC7oCclO689N1YHIH0mMHs
         PJVw==
X-Forwarded-Encrypted: i=1; AJvYcCVI2ITMsOAh7a4/V5frU1OYOyFEK3GKv8VZ6+Y9+aNAAOrflD2+F73Z1X9zKy4gDs4KrjNo3Cm9O0v6X7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgQyhw3X2qv+j0k8cYxBHXDOo7zr5heTI16qhGjvby7gkZQXt
	DSd+FEEspNitlKJlHKKOrhj60sp06e4URKCqMR61NcVAn94J9d92MTH8hqwIaZ8hCkFxRS4FmPl
	qCy4l0CN0KvjGUjLZtKBNqDx4ZqYIYTYRn4LqbLyyaYnJsa0yBKd78odDmSUhyA==
X-Received: by 2002:a05:6512:3b28:b0:532:c197:393e with SMTP id 2adb3069b0e04-53b348c1724mr3495229e87.11.1730135840025;
        Mon, 28 Oct 2024 10:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSQJB7hVQSEKxJ50hlftFQPg+16mt7KExIl6lMymE+K09Kiq2xxnKJmjuY7pyKxo//sTq4qQ==
X-Received: by 2002:a05:6512:3b28:b0:532:c197:393e with SMTP id 2adb3069b0e04-53b348c1724mr3495208e87.11.1730135839576;
        Mon, 28 Oct 2024 10:17:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:3c00:70fc:90a8:2c65:79b4? (p200300cbc7223c0070fc90a82c6579b4.dip0.t-ipconnect.de. [2003:cb:c722:3c00:70fc:90a8:2c65:79b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430e2sm146646135e9.8.2024.10.28.10.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:17:19 -0700 (PDT)
Message-ID: <70f4f5b1-cee6-49a2-b375-3ef43bf19a0c@redhat.com>
Date: Mon, 28 Oct 2024 18:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Usama Arif <usamaarif642@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241027011959.9226-1-21cnbao@gmail.com>
 <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <CAKEwX=NH9ubWSgKyEJJ0sjxoYXhCV3r4VCJf7UZxHdVX5GDA=Q@mail.gmail.com>
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
In-Reply-To: <CAKEwX=NH9ubWSgKyEJJ0sjxoYXhCV3r4VCJf7UZxHdVX5GDA=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.10.24 17:34, Nhat Pham wrote:
> On Sun, Oct 27, 2024 at 7:32 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>>
>> agree it is better to have a separate counter for zeromap.
>> then it raises a question: what is the proper name for it :-)
>>
>> zeromap_swpin, zeromap_swpout seems too long? and zswpin
>> and zswpout have been used by zswap
> 
> Hmmmmm. How about zeroswpin? zeroswpout?

Is this kind of a "swpin_skip" / "swpout_skip" ? Because we optimized it 
out?

-- 
Cheers,

David / dhildenb


