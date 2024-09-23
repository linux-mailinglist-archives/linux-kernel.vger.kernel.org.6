Return-Path: <linux-kernel+bounces-336063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A797EEB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46BF1F22546
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA419CC1E;
	Mon, 23 Sep 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsBeQPTI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EA19C578
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107088; cv=none; b=LnpGq8OmTpb1kTwEcGGxC0OdeXzQoWgawUHVvnCynCnnEqvN5vshLGyBt04P8bf5NeckrO6VCDmQ1TS1YlB1m28n3lyrVxvuMNxW0eopaj4U+tYs1z65jhMfaKVxjXet3R9hRSjWMxn070eA3Tw1ZSGxYokHrvk0kCAZdve8Zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107088; c=relaxed/simple;
	bh=iPUshicHD/q9U1d/CVixxRJXoVLwjD9QCWmjl4SYn88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqMim7+BJQN3/H8xa08bj34s0hCZL1xVWJTr/OyDWZhCmQOgPL4JqEbEjHWwpvxuJ4qD5a4x/UYsidwiwov/TJywBKfwT0u4lM6VZaGRVo7ivERSeP2rHjZxQIaXZLkRsRYoGjHs6S9ICigtWCjvsbYS5EPK7iHKc4Q7RoQvF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsBeQPTI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727107085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IQW6jYo1TmEyBClA+qYPmkjul1GxgALcX+WvqrvOp4I=;
	b=KsBeQPTIxyXYLVlFGTrfkV5XXUwRmdP8ubTPozP3jyS9AOB61bpXhQSexNYKsQMmpJ56/o
	oIMjYQXvmMZWfcyrNADtViZqbIbxTfMyf9AndKgRf4wh7PJYmUw5Aeetc0zeC6/Ul5II67
	RJZZZYxC19xe1hVmFPkFrhbmdEibdOQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-50-YXKNFO4-LQMwKuGI6_A-1; Mon, 23 Sep 2024 11:58:04 -0400
X-MC-Unique: 50-YXKNFO4-LQMwKuGI6_A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8d1095442cso321813366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107083; x=1727711883;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQW6jYo1TmEyBClA+qYPmkjul1GxgALcX+WvqrvOp4I=;
        b=VDXIcSrVouHSw/fi6LG57mpW+MMoDOXMwTt3s/MdjsDI6h6o5byc0kH5F0JeFNnBeF
         0UmZwRSpPNyKb8vRmyB/KMDDsIHqlBLZ2hAyMulwNvX9d+fDDuY025hhzt7BqkUH2p08
         YmdZ0xXp4epjEGek2siD7/WPVGpdEl19nv6jrn+zBdpUQG8VtfHu0usuOZiSje2+fi+s
         QjM6VKC/IetLtyowvcP/cAgMknXHFfLP41kJwr+AyufIv5Hx2ZyaWjQYNbUL/8GMQytj
         LQkGFBF6ZDmuFCbjH53ITKQd1E+uGvOHPQB1HnECmYz1evSpr5gUubOfPyTVZ4cydTNV
         cgzA==
X-Forwarded-Encrypted: i=1; AJvYcCVZbYKoW0laDI4rH9AEDkV303kfqpF1O9BN8muBRS0UCPEG+3tMJJ75Pm5wJj0TUrRsz1Guj0m6Yvf/SL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRYegnTZdxLU/4AjSU6P7VAA8I6rOZcR4wNary31JnHSyEFCXb
	oy0uVovg4hWfX4/sQPaDkipiSE0bxNkPiyyZHX5QppGPqt9dQRESjgowPQl+K54yS575ZBG7mk3
	mrew+OU3hf3OQ0GMgOJwS++qf7QXQrrQsrQGqpZZZLc1itFMQarU/74cGiQouOg==
X-Received: by 2002:a17:907:ea0:b0:a8d:2ab2:c99e with SMTP id a640c23a62f3a-a90d517ba30mr1166123466b.55.1727107083290;
        Mon, 23 Sep 2024 08:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBYM6QH5uM4//ce/JZhDdTXvgUZQmlWuoAMw7bbi4DwT1sJpJIrPB+Bh1jNV9WmFmzCdIUaA==
X-Received: by 2002:a17:907:ea0:b0:a8d:2ab2:c99e with SMTP id a640c23a62f3a-a90d517ba30mr1166120866b.55.1727107082892;
        Mon, 23 Sep 2024 08:58:02 -0700 (PDT)
Received: from [10.5.48.152] (90-181-218-29.rco.o2.cz. [90.181.218.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90c39cbceesm632353066b.132.2024.09.23.08.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:58:02 -0700 (PDT)
Message-ID: <de614197-d4b6-4442-b064-8a9cda1dd414@redhat.com>
Date: Mon, 23 Sep 2024 17:58:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: shmem: fix khugepaged activation policy for shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9b9c6cbc4499bf44c6455367fd9e0f6036525680.1726978977.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <9b9c6cbc4499bf44c6455367fd9e0f6036525680.1726978977.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.24 06:32, Baolin Wang wrote:
> Shmem has a separate interface (different from anonymous pages) to control
> huge page allocation, that means shmem THP can be enabled while anonymous
> THP is disabled. However, in this case, khugepaged will not start to collapse
> shmem THP, which is unreasonable.
> 
> To fix this issue, we should call start_stop_khugepaged() to activate or
> deactivate the khugepaged thread when setting shmem mTHP interfaces.
> Moreover, add a new helper shmem_hpage_pmd_enabled() to help to check
> whether shmem THP is enabled, which will determine if khugepaged should
> be activated.
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Looks reasonable, thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


