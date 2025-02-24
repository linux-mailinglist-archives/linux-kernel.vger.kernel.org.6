Return-Path: <linux-kernel+bounces-529363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B5A42386
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ADE16E98F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0224397B;
	Mon, 24 Feb 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMIRKBHh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDC18A95E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407796; cv=none; b=i0WVzhPEHR5s5UX0icAVSbVbMzF2HEXxricv+DAG6wCHgxL3ucyOeVzlJxXWYn4/wb6WMDopJ2CFPFqQCj7JISozKFWlaOVJNT3oQooKRMWMP+yarWdOcQu5bn9Z26Y8Cq5y709ygbBG64ZVEoc36le7rdz3nS/ZQTBaskAw8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407796; c=relaxed/simple;
	bh=UwSwiJGZwSq+WhG8DJIpzDOvAXg+3MQPfE526y5E6XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4jGm0I8SRBM0FrqdUyYp3DBM1vh5H8N1KIPN3YifRAZ97cVYnZAILytqAgKaoHnD3fA68lW6u8uDgDevzSCQds1a4iyTOe7YDyFJMQke4v65LCqhYxp0WFgu1xBdtviyhkEnKe9nlUrgNzcrIU4fS7TSCSO4iOcr2e4bZ2xGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMIRKBHh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740407793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4a5Pge3ndAsxD91Ok8sjj4Yec0ykdk1cuFOtuh9yTlo=;
	b=EMIRKBHh9cX7g3Z83KehxvJJ0KWEAbUKVrQmZmq1A0l00Z35bAOu1iS0U29bkMAN+DpEVp
	LR2HnBIVZ8aYSsAXidCu7DIZ3UUi/BXEqBKn1YXpgfW3IELsch9BDgr7lRzm59lROBDWNp
	I55vde4GWWkKP1Cnq+uIPnK9mTxArJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-yLe_hzDGOLGbNW_C4kwroQ-1; Mon, 24 Feb 2025 09:36:32 -0500
X-MC-Unique: yLe_hzDGOLGbNW_C4kwroQ-1
X-Mimecast-MFC-AGG-ID: yLe_hzDGOLGbNW_C4kwroQ_1740407791
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394040fea1so22152915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407791; x=1741012591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4a5Pge3ndAsxD91Ok8sjj4Yec0ykdk1cuFOtuh9yTlo=;
        b=u3tiXPd55RW/PAHloCg88COwLYrIjGJ1tTXCd3Y0andpQSeE9f5Ar7YonNxJhUgA6g
         awtsgJDFejnc6XvRgZE5p8t5pT9ba4lx6JUtaHdG5kq7GuqSuMqxrd9X2HhMpA0fNyrQ
         9iS1iTmatRsFIh9AW8N+2V/a7DzE4SOrIeBDFVHduQjXQe5JP8vLgjKZI+wokjoQyOrv
         PPpd8EkgAtshfQk1sEZ5zZv7KEzkxzX8beL/7lLvXl4kkYEkQp8lgh4twVQxNaWMdk2k
         q6wLfN9xJlry9pcWNWz4mO945p1A+9cAXGDmcazQWnCF15qisusuQPlFsZ+RXiErOUUO
         8ViQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQSDtm8hPhNSU1rQ9ZHt9+j0FT7Avlxzgyar9H7/hhaymn6GxIyZ+I1gB9TQxPT8rfpRzUMZzp5nmvEng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4CG/jOHBoPmFg0zfhvqwHBZGEU0yorDlv85SrT7q7QHCf2CB
	QFm54LZZDQS7kkIEx3pnbVOJUryo+BZv/MCA11jJcY92gRSxHZs7/gprGSi7vu0AtwPdp3Ok/pa
	68wKu3EjPH+KnhUebjc89wINv/Iv7MvAgp3sq/PZHbFa2Os0IqXE/u0TtGTnLmw==
X-Gm-Gg: ASbGncvBcqpBrm1HKkp+SgL0odNN9gO31LN/7EhRD9YVlmkXxX94CGqK4a1/fGRQAWG
	5PCJO+ilk9P/D7IC7ro2s6TZjeq4UYxdaNO8pf0FeTGeXlUj7JN4o1hiRF0Gl//LaQCl0drJa5F
	TfuUHBKSX1333KgLxwG7eg1jmajeMFvbCmJzwzVIfV/5rLBofSHuYbgvlPrODFPZOSf3hBY2pza
	Uq+neLZ/kwgxRxg8CtNFqykVIpB+Bpba00OCnwc7pSbVsoaO8wxsl2dHoYUwq429a0K6dJi0/bg
	AEPfuQ/TEZ9OFpGaUUNdUCH9xa9l52HVG0vqu+r1+4mbOUdwMyZg28sOTA9kK6RivvcdcbbsZ9L
	0XLYhPPAEEcc2gyuQNLN9V2eEqgVGEgBN6yx7tGBn9G8=
X-Received: by 2002:a05:600c:1516:b0:439:5d00:e78f with SMTP id 5b1f17b1804b1-439a30d4c32mr143818745e9.11.1740407790784;
        Mon, 24 Feb 2025 06:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFGG4lEeSm6p0yFnCA/IQwyI272VMVV6NVwF1/1IUIoV6j97s6TFEZmg7Y5rX4hBQYsI/alA==
X-Received: by 2002:a05:600c:1516:b0:439:5d00:e78f with SMTP id 5b1f17b1804b1-439a30d4c32mr143818535e9.11.1740407790398;
        Mon, 24 Feb 2025 06:36:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0372124sm107073455e9.39.2025.02.24.06.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 06:36:29 -0800 (PST)
Message-ID: <d90ca138-7506-4d1c-b144-08b6099ee63c@redhat.com>
Date: Mon, 24 Feb 2025 15:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm, cma: fix 32-bit warning
To: Arnd Bergmann <arnd@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>,
 Frank van der Linden <fvdl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250224141120.1240534-1-arnd@kernel.org>
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
In-Reply-To: <20250224141120.1240534-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 15:07, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about certain always-true conditions, like this one on 32-bit
> builds:
> 
> mm/cma.c:420:13: error: result of comparison of constant 4294967296 with expression of type 'phys_addr_t' (aka 'unsigned int') is always true [-Werror,-Wtautological-constant-out-of-range-compare]
>    420 |                 if (start < SZ_4G)
>        |                     ~~~~~ ^ ~~~~~
> 

Hm, so in this case the whole loop is unnecessary.

In any case

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


