Return-Path: <linux-kernel+bounces-276328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467D94922D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7867B1C20A87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A5620011D;
	Tue,  6 Aug 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxqk4uOq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD981D47C5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952290; cv=none; b=gz8gbISlZeDXbjo5GywUsAVokweWK71Y07bdUCFO2ZAOjwKWcPXi36C3Rjpf7BxIrkzd5lnbbBsUjI6TGsmwo5xCy2ZncdJsObTqgOd4DXQBWZtQPsSYzezL9j+2OoS+FKFsArM2iFpmBwyxhhn47ybOaOOB1n5LDcJ6gOl1pmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952290; c=relaxed/simple;
	bh=rEBQTpBlU5qZsZdAhDM90yzdJFf0K91AKjalTus1ncA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oY67aesu9m0uoELnB44p6Cq9qf08FI/3zIrYaaTJNwQVvVBGMhyJWO9puZsp3U4WpmqyfhYY+YNpbQRtE3ngd7hdD+jE+e6diUVeoNmtnNqr/CDMjMXeiSmLu0mLbAmP7O+UmLAUC6xBZt8TAdijvfheew7/RNf3cLCq7rG/6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jxqk4uOq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722952287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TKxQXuHwcQJALgByJr3flxDLBtQkotXdNCYtFESS9F0=;
	b=Jxqk4uOqqZhGZXiL2aJ7gYkjiXjJaiOP9K5YLVjKMndsipp4aw19Slj6iSAuyPbr+coEjr
	WKwdCYBki/Ji+Y0bxpkNEfk4dL+cgpH/Zsi9Exmuu9zLj0u2TvId7wuTc2e/8qs7wO2L3u
	b4V/A/M2U9llxiSDdEKanoFPOb/pHwk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-wAqnX7PZNmuz_7KAcVdx4A-1; Tue, 06 Aug 2024 09:51:26 -0400
X-MC-Unique: wAqnX7PZNmuz_7KAcVdx4A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3679ab94cdbso378811f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952285; x=1723557085;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TKxQXuHwcQJALgByJr3flxDLBtQkotXdNCYtFESS9F0=;
        b=VqhxvskTs5EQu29VD7c88P6Rsk4CluSxMSIqaNWRtW0m25j98Q7KxTVpFrZK3QAKvC
         S2X9d3zHfvH09u2ZYdM/GDepE5BSUjs//rBH2D/+kSwdBCRPmAB5+wC60HUisQ27NLOe
         cMDTH4h3Ys1karv4SgBAoFX5jKXAkDvywFCMOacw/MmtSV95brpV18SkkJB3BHLnoM+6
         TRA2IcNPjNVB/zj21jnxwhf2RZ6nFy239jVS2uUxJKW17poUvL7PTXH/ImiNXaU9aNF6
         NilSN36XrKKgnYUXoquLsjXWGiTFFL6l5VbQJT+D3myINECMiSaPOISTw0gZAdtPAxph
         fMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDolv7K1XHYe9rN3fmnOHe4xi2mKC+zREINXW9nKcl5P3l1oXKF5/nqG4SjPA8UG5CvVgKi/g++Bc05gdYVOC/43x5VZojETu+j66H
X-Gm-Message-State: AOJu0Yz82I7hgTRmdNZlNCzTB/m4vfyfKQPu7+j8slAe1khsnBB3WMHe
	1h5pC8xGQwzjeWYuGqXlV54YCxwifGL7QjqCJbSNQGkIFKs65kMe/YN3q35uNkqcUXdAwKPY3P7
	VxKlFlaZmLNah4EBwpzOO34abGRM1SNLPDsCTPIiZScbiZZTwGUKwW+3JfN8MTg==
X-Received: by 2002:a5d:6ace:0:b0:367:9904:e6b9 with SMTP id ffacd0b85a97d-36bbc14f5ddmr7578825f8f.44.1722952284774;
        Tue, 06 Aug 2024 06:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHelcZaOAarnAunkGJ+91tlqo9Er1YHXmnpFNYHx9jhtZLMq3Wf5yH0Osq+mxeHAPytAVNyBQ==
X-Received: by 2002:a5d:6ace:0:b0:367:9904:e6b9 with SMTP id ffacd0b85a97d-36bbc14f5ddmr7578806f8f.44.1722952284287;
        Tue, 06 Aug 2024 06:51:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06fbfdsm12912183f8f.106.2024.08.06.06.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:51:23 -0700 (PDT)
Message-ID: <4cdd93ba-9019-4c12-a0e6-07b430980278@redhat.com>
Date: Tue, 6 Aug 2024 15:51:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] mm: guest_memfd: Add ability for mmap'ing pages
To: Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Patrick Roy <roypat@amazon.co.uk>, qperret@google.com,
 Ackerley Tng <ackerleytng@google.com>
Cc: linux-coco@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
References: <20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com>
 <20240805-guest-memfd-lib-v1-4-e5a29a4ff5d7@quicinc.com>
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
In-Reply-To: <20240805-guest-memfd-lib-v1-4-e5a29a4ff5d7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> -	if (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP) {
> +	if (!ops->accessible && (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)) {
>   		r = guest_memfd_folio_private(folio);
>   		if (r)
>   			goto out_err;
> @@ -107,6 +109,82 @@ struct folio *guest_memfd_grab_folio(struct file *file, pgoff_t index, u32 flags
>   }
>   EXPORT_SYMBOL_GPL(guest_memfd_grab_folio);
>   
> +int guest_memfd_make_inaccessible(struct file *file, struct folio *folio)
> +{
> +	unsigned long gmem_flags = (unsigned long)file->private_data;
> +	unsigned long i;
> +	int r;
> +
> +	unmap_mapping_folio(folio);
> +
> +	/**
> +	 * We can't use the refcount. It might be elevated due to
> +	 * guest/vcpu trying to access same folio as another vcpu
> +	 * or because userspace is trying to access folio for same reason

As discussed, that's insufficient. We really have to drive the refcount 
to 1 -- the single reference we expect.

What is the exact problem you are running into here? Who can just grab a 
reference and maybe do nasty things with it?

-- 
Cheers,

David / dhildenb


