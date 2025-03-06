Return-Path: <linux-kernel+bounces-548656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4BA547AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78589188BD4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96A2045BD;
	Thu,  6 Mar 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/OUDcRZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276520011D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256633; cv=none; b=ZNrCYLhWUAv0K7qygdAbVukKkemXpk0t857XdUgt93+0WuQF5xTf+hfWVVdxCApiqdf6PpDk6hqlSJhYMwnNZsWG5otsrAApkV1/l63uyN5dERgMfS8yFCSDnEonabekrdmzmG0LVRP0DIOznfrVVh9UEJQ1/gHIr04JguzClPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256633; c=relaxed/simple;
	bh=j+Rx427sErw5e7XRoSkAgNBdWS17qNHBwXls0pAiPC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gs4Dp1Cbw32R0E7Gx+v8lW8QhGh5yxJD6DfCe7FjRyv3YDNbChCmhFEDQo5n5/IfhWXwTLWVFcSAl0im+1nR9gntPMS3RNFMGNX+CAM3xBHl1XPH4xvz5oJwZYkt9R20UM3yrd0adWLQzbbp9nCB6SsR+8VOI3/dKSl26xBm3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/OUDcRZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741256630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ePG7U3aar3vY5ktuUAGH2EdVtVOLwbBJOXDd+7DUuto=;
	b=I/OUDcRZVe6mEZjkeqmVaPdHwqbDKLwrI+D4+2I7+JlrAnsgHyXT0WARiBcbt1z3wi99pZ
	6oLbUyBMpqycDIV0MolqWIgDOLcNlFiYYO4eL8Fy3ADZAXVtd44nJKGLYK0Nq1tvY4qOsN
	17w7fGue6BpyRbzqb+WbESfFPFB2izc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-xr0aSlGAMjyutRffWn8YkQ-1; Thu, 06 Mar 2025 05:23:34 -0500
X-MC-Unique: xr0aSlGAMjyutRffWn8YkQ-1
X-Mimecast-MFC-AGG-ID: xr0aSlGAMjyutRffWn8YkQ_1741256613
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d5f6689so225109f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256613; x=1741861413;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePG7U3aar3vY5ktuUAGH2EdVtVOLwbBJOXDd+7DUuto=;
        b=iVAu2Dd7rWoPFpypWdraohsWroMLsaxJxzjCMiX6wC83cj2BCIivRb+sdpLo03e3m/
         VvU6sJG+fCf9Y6j+UPwvd8nWrGFj9b6opleZlDAnUao0j4lXkDq3hnqANvBzWVYVexkB
         orDWQApatkkcubBBptPvfYwYU3+sdC6ExxJNH69II55uPiMM10oWd9wvlRFVvniA0PtE
         X7JRfTcSnUuidByIQiKfC2sNEqP1WhDiMmaXYRHn5EXkZFi6RsSKHQWaGnXMfS+8uQjt
         4sicTWmEHqnr4tk13GuvBji2/tBXIlEQrUj8iHwoEZtyczY4U/CnO9YWwXri7vo498uy
         78sA==
X-Gm-Message-State: AOJu0YyCmx0wU7o56iDerBNnJ7ZK41Ofp2WM+jw7McYs1kRXR/B6wFN/
	pv1rL8Le9X7SJECaJpHoWOCBpwHu1tjQySUANF/t/GDBOwfFRSCkq8Fyyjy5xsMvbxnqDD0j3Qw
	eoCr0RotgIFngY1zdoNNTwRjvh86KGKo+ESc3uL0aqiwtm4wlyht7VPm6SBkr+g==
X-Gm-Gg: ASbGncugRv5Kq5LzADM4XlJjphUAL8CH4nipYEOlDsQixU6p3D/lowKBZmDQM/kfpim
	bb2xwvLseGq5nnbqyO0sSqCz0LmTcXe9oVXCnE2td6qPdF97MEeeAoSKaITi1OwGP5+whfA8jnS
	5QOhY+0r/0DFfSoflu10rIPfoR8uGJp0rr/ef8qwtsnxIFyLcPqh0fzZtgVu50dOlgU2cjOrX7h
	wRJjb06MAElc8ANwIF+g28H0YKBJQRV9s051C4wAryUFetjpPJKrY5VywyEvSi3zituWjrCkkSd
	ZhVmAovJPrWLl/LzyicpGVT/c4i/BPurtR2mxWORVe2fc4rGRE2rnSPMsTOba/8+c/IX3OGB7h3
	vabcGWXRsb5JFtE5Vv3Twnk0k453+po+OEYNm0ooqsw4=
X-Received: by 2002:a5d:6da7:0:b0:38f:2766:759f with SMTP id ffacd0b85a97d-3911f7a8406mr5682444f8f.41.1741256613178;
        Thu, 06 Mar 2025 02:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEocobemWznRTQwuqIfwXuQoFw5IRLgHoYcd/Sn4/ZqtXJzxOan6u8q9zJOyXNihXoLVxnD9Q==
X-Received: by 2002:a5d:6da7:0:b0:38f:2766:759f with SMTP id ffacd0b85a97d-3911f7a8406mr5682424f8f.41.1741256612835;
        Thu, 06 Mar 2025 02:23:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102b62sm1546653f8f.84.2025.03.06.02.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:23:32 -0800 (PST)
Message-ID: <c60e60a2-07ed-4692-8952-c125c34122f8@redhat.com>
Date: Thu, 6 Mar 2025 11:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] KVM: s390: pv: fix race when making a page secure
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, borntraeger@de.ibm.com, nrb@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, schlameuss@linux.ibm.com,
 hca@linux.ibm.com
References: <20250304182304.178746-1-imbrenda@linux.ibm.com>
 <20250304182304.178746-2-imbrenda@linux.ibm.com>
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
In-Reply-To: <20250304182304.178746-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   /**
> - * make_folio_secure() - make a folio secure
> + * __make_folio_secure() - make a folio secure
>    * @folio: the folio to make secure
>    * @uvcb: the uvcb that describes the UVC to be used
>    *
> @@ -243,14 +276,13 @@ static int expected_folio_refs(struct folio *folio)
>    *         -EINVAL if the UVC failed for other reasons.
>    *
>    * Context: The caller must hold exactly one extra reference on the folio
> - *          (it's the same logic as split_folio())
> + *          (it's the same logic as split_folio()), and the folio must be
> + *          locked.
>    */
> -int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
> +static int __make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)

One more nit: -EBUSY can no longer be returned from his function, so you 
might just remove it from the doc above.


While chasing a very weird folio split bug that seems to result in late 
validation issues (:/), I was wondering if __gmap_destroy_page could 
similarly be problematic.

We're now no longer holding the PTL while performing the operation.

(not that that would explain the issue I am chasing, because 
gmap_destroy_page() is never called in my setup)

-- 
Cheers,

David / dhildenb


