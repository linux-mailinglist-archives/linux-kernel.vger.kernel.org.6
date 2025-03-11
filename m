Return-Path: <linux-kernel+bounces-556885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F1A5CFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66AE176951
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325F264617;
	Tue, 11 Mar 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsrbvN3A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEA1EDA27
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722504; cv=none; b=u0qIPa9VfmdtfMoTVxavLvQOzu7d9IbcRI8BIBCjHSboZrFESBvw+8EzrfKzVDsry+fAfiLJvqp8YdOhg024KAa9eSMq776ZI+UjsShhQhsZtNjDM/x5BTCEG20cLS1d363OMMhE2iJ+tBuuGDLCLIpxTg22O5DHG7WgnldhQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722504; c=relaxed/simple;
	bh=V8wGKSuG/67heF+aQk9MTGAzM0HmHSAIK9jMHT/3trc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfQWMFpIu1e3rxsiDxB9Ecj18bGkFDAWuvfvmkqMmpoXTS3Gi1f4sLk0SEmXFp9X6B2HxlrOuXVFWXS9fWYgXoEsPHJouCuszVwHUtvwcAsJmAr+uIemyIpCfXIcpf0Wl8mHCzZLZA5chMEQXb8aQcMIEDuoIFy0JNafnzp93Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsrbvN3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741722501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bq/Cwq4gBqnqnmgfvCPLaJV5Ooqfni9+hYzA5Bx/ZoM=;
	b=SsrbvN3ACwpEczaYFeJHYXzIppA3eoL2a2oOXm+cXfRrqSczS1ZJWO2YV5RaH8FRKTgRbi
	pNQkpHYV0mMKN4uVwppcP2Cut2eE6DdWn142+ET0JRJS2GaXlx8FlDmtW7yoiSMsr11XzV
	sWLVDIX/yqrUUANw77nmisi6XC9m4xY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-qEZz_-IiOeiswk_YJajwig-1; Tue, 11 Mar 2025 15:48:20 -0400
X-MC-Unique: qEZz_-IiOeiswk_YJajwig-1
X-Mimecast-MFC-AGG-ID: qEZz_-IiOeiswk_YJajwig_1741722499
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131851046so2036884f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722499; x=1742327299;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bq/Cwq4gBqnqnmgfvCPLaJV5Ooqfni9+hYzA5Bx/ZoM=;
        b=n0FpfKTkKy6H8wM4nDMp5v4gbrmxgmmsERU14S/vGRu6j97nuAJG/q0WKffDcuLmIf
         4tfN6IwNn5Wj80CHn6N0OtAT8g3OVggVBsqnQWsx3yQdxYcf+8J+LlWtZpCYpF3hpO06
         RJ18oJ0ssTwNb6IqLy8cSEcWkESGKDGYntKgLufW6i4kN1mbhhxNJFyXENqemvZ6wuKL
         yUMzZYsvZNic/6vYUu6K8XdH91p+TcElDZtSkhuTj3PMBr4ThQaVbjD0PWQqRN2YLvfC
         cGFA+RppGX/Ou9btHsd9RtrtPteT/IHrhxf+j5cmiSO0mR5suUq7eWmuAvBxSKgXHC+m
         mYBA==
X-Forwarded-Encrypted: i=1; AJvYcCW5KjXesvJfC5xKFTvgsAF1H1EcbdAND1rVZcjKTBHGPtZA5/GKsL0HYdqG7UFDVGEpMYtlJ7mJWQmQ/lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitXq90GcYybc3nAQot8L9DykHtVke03mSpHZUGyqFcl2MTfts
	by4rZ06TDbxP7504yQDKebDQcCcl0+sbP7FB7h1C/IPz4nQOjKFjIrUKmzRAh+NgYHU5haio5m7
	icQggK7UbwVjx8vZpsORrs6OlaWo8kMf9zydqr8f4Fyi7ikjYIKTojZ0yVyUSdA==
X-Gm-Gg: ASbGncurW9Y34S4gear1w8SkJZSItVYUlTED1xxD6cKPZfbEq/DAc6z28yIw9qoMfNj
	F55r8BfUWYIjgyu/OCJT8LGn97BSUy7HpYas8c55BXNRnWld21dIWFlIgvG9cisA/4H5U0kwuOb
	Ea1uqMqewv/2cKuqIEIDoukr5MQwZvlErZJ7LA7wAFogNVoXwozqB8hT3v0sSHyypLRTfodyvO9
	mP1DbYixMVCALmOAgI95Kbuyr6zHxeGJ5Wg+JNc1xlmP8wB0mdA2Hqhq6K7I913qfPQNlFZX3Mx
	1dMBS1BRaIjIMqn/qHD8wFNBxLuQXd90rc8iGjwHE/rf
X-Received: by 2002:a05:6000:4718:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-39132d29464mr18979172f8f.21.1741722499287;
        Tue, 11 Mar 2025 12:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXbw7q00lvP1bt0vHZTQDKUmkfV+45HTfk6x4dlKMXo5cKKnUnNZxgtX90v/yy4e+O8qbDeQ==
X-Received: by 2002:a05:6000:4718:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-39132d29464mr18979163f8f.21.1741722498927;
        Tue, 11 Mar 2025 12:48:18 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23d1d.dip0.t-ipconnect.de. [79.242.61.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01ebddsm19391570f8f.60.2025.03.11.12.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:48:18 -0700 (PDT)
Message-ID: <caaa80e9-16e6-4abb-b198-967c37aeb46f@redhat.com>
Date: Tue, 11 Mar 2025 20:48:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow: Fix the incorrect error handling
To: Cyan Yang <cyan.yang@sifive.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311023730.56658-1-cyan.yang@sifive.com>
 <4a068856-328f-48ae-9b1c-0ec7d65dde6b@redhat.com> <Z9ASoTIastiD7utL@cyan-mbp>
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
In-Reply-To: <Z9ASoTIastiD7utL@cyan-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 11:38, Cyan Yang wrote:
> On Tue, Mar 11, 2025 at 10:19:32AM +0100, David Hildenbrand wrote:
>> On 11.03.25 03:37, Cyan Yang wrote:
>>> There are two error handlings did not check the correct return value.
>>> This patch will fix them.
>>>
>>> Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
>>> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
>>> ---
>>>    tools/testing/selftests/mm/cow.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>>> index 9446673645eb..16fcadc090a4 100644
>>> --- a/tools/testing/selftests/mm/cow.c
>>> +++ b/tools/testing/selftests/mm/cow.c
>>> @@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>>>    		mremap_size = thpsize / 2;
>>>    		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
>>>    				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> -		if (mem == MAP_FAILED) {
>>> +		if (mremap_mem == MAP_FAILED) {
>>>    			ksft_test_result_fail("mmap() failed\n");
>>>    			goto munmap;
>>>    		}
>>
>> Yes, that check is wrong.
>>
>>>    		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
>>>    			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
>>> -		if (tmp != mremap_mem) {
>>> +		if (tmp == MAP_FAILED) {
>>>    			ksft_test_result_fail("mremap() failed\n");
>>>    			goto munmap;
>>>    		}
>>
>> As Dev says, this one is just fine. Leave it as it is.
>>
> 
> Thank you for the review.
> 
> I agree with you and Dev this is just fine. The reason I prefer to modify it is
> - usually caller checks the return value directly and "tmp == mremap_mem"
> should be determined by "mremap".
> 
> If you still prefer to leave it as it is, I will send out the v2 to remove it.

Yes, leave it as is. This does not belong in this fix for a real error 
checking problem. Thanks!

-- 
Cheers,

David / dhildenb


