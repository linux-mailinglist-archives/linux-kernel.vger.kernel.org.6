Return-Path: <linux-kernel+bounces-305290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830A962C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FC91C20A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F51A255D;
	Wed, 28 Aug 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO9trt9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507117C223
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859121; cv=none; b=IfZGIIT2Na+zl7r7H2XlCvrwDRFNbef8dzL/CGh1AG2YOgMflV5k9no6pxpmzpbPZjsaUQ+E5Aq1EhCc5dc2w01myNIj+/aZPdiS1QImlMN7ys4zuV6+Xd2+9S1GGpLx4E+roCA1ceIIW/3KjF6OyIjAQrMD4QS1NNyDKL1sPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859121; c=relaxed/simple;
	bh=cghE+f372lAxAmhazy+b9N6LXvy27JUnSd5DypYyOj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxZktSrpaBYypabqzP3hDuBcI4TLZTpWB5H5rtnj5+n4M0fqa3/inX5Y2DvXcD0OeZU116a97b8eg2QSQ2lOCxeUqYoUD9D555+OCjCLICBi0k8D8fPk/RpdiVCLFPzJKapHIcadncRVAI0P8TN0pw5jLAtX9zyBdj1O75nzQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO9trt9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724859118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a7t+GJr97EOxs8Z5xnxc5LoGdSJWBISe/+/VEH88G9A=;
	b=WO9trt9uDozqLDGCqcULxdOJIdLa9W/CxH40LobG7o0CtBYolcNXHwFnfQTUktd62oVomP
	Ts9ozPnuq5USkjclYihjHkzjHpYdcpa+sb7NgcG9sBJo6mwdanZymSYfY07hf6PIoMs0Om
	joxlUA5Gt9dGIDiS3RfEqSNLUVHyvy8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-6TNH2N7xMuOLLohtDoTIYQ-1; Wed, 28 Aug 2024 11:31:56 -0400
X-MC-Unique: 6TNH2N7xMuOLLohtDoTIYQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3718ce3f6bdso5065768f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859115; x=1725463915;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7t+GJr97EOxs8Z5xnxc5LoGdSJWBISe/+/VEH88G9A=;
        b=npmhy3PnnROwvF7NU1XvNIQDdB/naMBOM6Gj/0W5hPYOtGh85RiAKiZqqlxgDXSQQ8
         gXqxP/tuzM3CQHG23f3wvd3dK0S6Mom7Qt1ZbTzYJ5//0VCzDYLSbK70VMjBG5i7ML/h
         q1tsk1dG4/qSVatDj9noimRD4FaZ3WRbvtvxg0cYucpM84M19FAOhvnvYh3UAfV3goBt
         WQf75r1XC+v2YPFXN+y5eSZbGde92l8nYzDBD6i1Sx9CBBwPRdfwOuDav19wUuCppPPI
         bqrg9xsJs8S4fPedr+AJuuth1s0VUrbzhubV6adMMibYW3geyRmWweTswU169nFJwjul
         kGvg==
X-Forwarded-Encrypted: i=1; AJvYcCUK0CUlW7hdnAw0KmVVZs8GAH862E1MU0u3HA6RkgunxmyQ9CqOJhxAo+4s7hy1ibbPgrYqwM5BslwtEyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8xjRQrDjOYE9lWGY0XhNjedbBiqqKP/Qk/Abm4QaYKG9twpw
	JLWFWGZ4OH7g89Pdi5oWoVL65DwrTNTa8JdT8LEr/bKyWClqbPdUfM6unHoxAclnsHh1uT4pa+l
	rKsBvq1tCOkyr3YjaczQZh/Ru3WGbvf7bFqf4BN2iYvY7UxJwJ2OU53KNWxnbtQ==
X-Received: by 2002:adf:a458:0:b0:368:7943:8b1f with SMTP id ffacd0b85a97d-373118c8a0fmr13450066f8f.43.1724859115029;
        Wed, 28 Aug 2024 08:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnKvH/I43gd6WSEZerf5YHGvpr5FI/L9/NXPKbC53cPdMtG6fH5U5Bf1pxSxGEY0t2dZLbaw==
X-Received: by 2002:adf:a458:0:b0:368:7943:8b1f with SMTP id ffacd0b85a97d-373118c8a0fmr13450011f8f.43.1724859114132;
        Wed, 28 Aug 2024 08:31:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a? (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de. [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749b22da7dsm94393f8f.7.2024.08.28.08.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 08:31:53 -0700 (PDT)
Message-ID: <93850b27-d063-4783-b940-8aef8d5abe1e@redhat.com>
Date: Wed, 28 Aug 2024 17:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] mm: Allow THP orders for PFNMAPs
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-5-peterx@redhat.com>
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
In-Reply-To: <20240826204353.2228736-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.24 22:43, Peter Xu wrote:
> This enables PFNMAPs to be mapped at either pmd/pud layers.  Generalize the
> dax case into vma_is_special_huge() so as to cover both.  Meanwhile, rename
> the macro to THP_ORDERS_ALL_SPECIAL.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


