Return-Path: <linux-kernel+bounces-333226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A997C5A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3142628496A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA0198A32;
	Thu, 19 Sep 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEHYjqTW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D429A5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733613; cv=none; b=g5V3bqG9wevjSd6Q10TjWC6KFDk6EAW+YKNQC/WGArqbnZd3z/U6PBOdCZk+KHgEEymSKCcjWd0RjbVd5Z/ph01iS2H5ysfFvjS4xmv4gvqDnZ3QsTKzRYGMYai+TdgCxrWQvxtZYajq5GlCngvatWFyiDSnWLBGECdFq2rlkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733613; c=relaxed/simple;
	bh=DI6/qH1S5aikN63XgcXmTCl3V1nikksLdSm2YKnap84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlQ8b1mnHQdz2z05Nr+qxnpQ/GBolXLau9e3CBZ2zTT+M8r+hvCO/w0TQ/vKNaMtipieDtMkwG/ZIpzop36WUxbR9WBsLP9jspxh+Lm2yveHy+nYQ15ufXW5f6rrBLCjDglFAISRd9sOW4rR0A5YynKp9lBxXl0j3uMja9jt8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEHYjqTW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ju8uGUotL3MMnDPuqZc89VHrFfkdgofJnaEl6/OCg9c=;
	b=UEHYjqTWuc2Ew0+QGw4j0DEwTDR/rLftPEFaOPPMYh9g0ZqGKGZZIiB4hp6rN5MpRa+68l
	39161KssvMBy2mn9xlHSmjCSWqVDBbWMoNZ+0ESTZtaqONFr4iIrnUHibS9TOSEJUv8Z4m
	VPNGefMknJ/DpJiw4CW5V5uFHytjwd0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ShWRRos_OBef33u39Jq6Pg-1; Thu, 19 Sep 2024 04:13:28 -0400
X-MC-Unique: ShWRRos_OBef33u39Jq6Pg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb050acc3so2646775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733607; x=1727338407;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju8uGUotL3MMnDPuqZc89VHrFfkdgofJnaEl6/OCg9c=;
        b=rw/VWpYwJ6ShhxLCluMSyR3lcPLAY8BXko87/eqJpf/lrOBCzkAVHXyRUgiTzcp7ff
         hJoXfRLeYU3Y3rleB3SIGvf8f6n/o9p3V0kfd98sYcfZsMz5tHlItw3VkcqvmnSLKBSm
         YpP/rDbPGlY7KNR/WUsGIMMBHEJ3/O/qlMYI4/xijhPiPgxb54TekT1fEStfeQrjm5d6
         cazXbQbeA6BUq3bX2eLcXBY/6RiWEihE6vHP5sC8tSlDuckufTlc0ORF1rU6OQaFy6Ge
         h7Q6zNLGHduAOWfHgBV65/n19dykWI1QxyOp32/FZMpbdeWR2nehtBsSEAiTeI24brXw
         usVw==
X-Gm-Message-State: AOJu0YyUKNffB5roFTr5aiVNWF/vLkUCVOtccNvBEdk31HUnp61/DxZg
	hDGWhrE59l6J1jgLxyiziK8GDvpv3SIOH2L3T8msDcccFrK6ACqZ9Ddx7V8S1kjXd+02xFQ8xNI
	9EeFr2CHS7dixHXwgtV4Mhp0KYwe8M9KDNG4l6krYJp6ehQFtAgV27T9GDRV2VjECEh7V8+Ig
X-Received: by 2002:a05:600c:1e01:b0:42c:b7e1:a9c with SMTP id 5b1f17b1804b1-42e7440d3f6mr13092935e9.5.1726733607539;
        Thu, 19 Sep 2024 01:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLivpIBGl7jd65QmDUFhOCeeZ/YuorRqR4yDXWXEyGkPlp0fpbgnHUyRZG06WldlkzImZr3w==
X-Received: by 2002:a05:600c:1e01:b0:42c:b7e1:a9c with SMTP id 5b1f17b1804b1-42e7440d3f6mr13092795e9.5.1726733607187;
        Thu, 19 Sep 2024 01:13:27 -0700 (PDT)
Received: from [10.131.4.59] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754091desm15484215e9.8.2024.09.19.01.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:13:26 -0700 (PDT)
Message-ID: <e81d1f66-4ca7-4792-b505-581874c4c155@redhat.com>
Date: Thu, 19 Sep 2024 10:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dead code by symbols
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, kees@kernel.org
References: <ZugliLgw5VFb9yau@gallifrey>
 <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
 <ZupwWT5ZEHFmWIXz@infradead.org> <ZuqxpBRVSYIk1Hkm@gallifrey>
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
In-Reply-To: <ZuqxpBRVSYIk1Hkm@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.24 12:55, Dr. David Alan Gilbert wrote:
> * Christoph Hellwig (hch@infradead.org) wrote:
>> On Tue, Sep 17, 2024 at 01:39:35PM +0200, David Hildenbrand wrote:
>>>> Now, it does take some more guesswork, for example an unused function
>>>> which was added a couple of years back, might be something that's
>>>> there for consistency,
>>>
>>> I know people will find reasons to do something like that, but we really
>>> *shouldn't* be maintaining / dragging along dead code that nobody might ever
>>> use.
>>
>> There never is any reason to keep dead code around.
> 
> Yeh I mostly agree; and indeed I'll be sending many many patches to remove
> the bucket loads of dead code I find; but as I say, there's a really
> big variation from the dead-for-20 years, to relatively new, to
> functions that seem to make sense next to the file they're part of.
> So I'll get to those later, I'll get rid of the very dead ones first.

Makes sense to me. Thanks for doing that work, Dave!

-- 
Cheers,

David / dhildenb


