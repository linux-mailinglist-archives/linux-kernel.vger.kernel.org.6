Return-Path: <linux-kernel+bounces-289327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E8E9544EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C61F2851D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5713C801;
	Fri, 16 Aug 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzzk21XT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351C13AD3F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798680; cv=none; b=nBBEcQ+pH0SX+PgULNGiUCEhqVytj2qmZLecRuJSJLMN0xGgZEZyfiKlBheQFoF5UBURfW35r87grz0pwjSiV9QWG9tIa7qQ6O/CYhfIMeShtIQQauLsxT9LvGR9nndcjKGIrEjcg2dcXEFYB1S1czuQioSx5Ur4y/udrnTOJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798680; c=relaxed/simple;
	bh=5yfoNoxi/3g/q618ra3ypVMWHfWiO/F6l10xyvzy1kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4svlB+kCD7hRBq/Zqz+yA2uKI1kpPARCWDXQk7DSJTdjhdgCSDZqDFKDxugJuZsCUSmZgk2FlJ3kT5r8H0hd3/YSfgnU2nBN/btyV6gQVvMyCybZBhCf8kB0ZBwG87/nBmAFhgw2pXuRrDLPBYG5Wbt7OV/1BAntenz3iphlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kzzk21XT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723798677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3kPI6r1w4qQs31tMsarBNqKUKUjQAoblMFtYfPMJ9a8=;
	b=Kzzk21XT6/v8+iBFjDFASslbWH2D3lYStg4MSGiVV5Pp+QOPsA18ann9o3W1YAkWhkMPHt
	xgOX5xl1EfjavdAvqu3/yZYZ+p6HnVz9SufiOMGl7D+1aqWGX7gAvHgwqvfLcq2Us6vZKn
	SSH+0TVt8so4UGGBNcW+NTrOXklbdv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-ypFPXPkfPd6tO8G1qJ60-A-1; Fri, 16 Aug 2024 04:57:40 -0400
X-MC-Unique: ypFPXPkfPd6tO8G1qJ60-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3718eb22836so581931f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798659; x=1724403459;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3kPI6r1w4qQs31tMsarBNqKUKUjQAoblMFtYfPMJ9a8=;
        b=VMallnb0D5dfduVjN2PXDquIF5wZZyqAFML68MVTW++lfRRuh4UwR9IcponjTbSn7I
         gWSRnH3QdNpqH9H4wwtklmlYhLhKHY+cLE1sMk+hlvZux+5RcTkpReV5usv0fWTjVdYb
         tKBqJqlpaAawCOjuMtYMt3Ev8RffTqNQZjmbFAeRWRx8VvmKNhM/LXLkycJXFD5m+D+Y
         Aw5y+TJG0vhUcK/D7WlgiLsv/5XC3D2+GyWpCCv1o8gkZwAwIVLB/+PDQtBsEWzIXYoy
         qf01tme/09COQy84UaTLK7TyvpLegaQJuzpFTKaIZQOYKf7l+3RdVi8wCAwamZ4MeSZg
         DfXA==
X-Forwarded-Encrypted: i=1; AJvYcCVcCMD4k7sCivvdlsLdfxpjYUUulrgRr0T4Zq/Y3DuG7m4A6pNwOk0umtY74JegQS6d9mKVV+eRnHMgu5LNnuv5TVgBt/WQESXdJBLz
X-Gm-Message-State: AOJu0YynPcbQuyyZsQ2N1eGhPyuK+B+I5g5BtGkw0OBtz0tAwCBDETM8
	2lvyyIo7gwfwaMrQF2Cwvjte+33uoUqcNyRH7PVo5aNR41lhn4EQwoLX+BcXmGbB5yJOKQPwNO4
	W8gSfcVWtqSaMK90nWxS+WvVs2mnMklUMuiuW4JwrlVoZbOdN9sypeU9uL50Ehw==
X-Received: by 2002:adf:ce8e:0:b0:367:95e6:158a with SMTP id ffacd0b85a97d-371946db8bbmr1185487f8f.63.1723798659090;
        Fri, 16 Aug 2024 01:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtCXvPWHFOf3OHKw0wVaLF55Z+fjaN7H4hllFfLrVeIdxyqJKhSbCID4om543+9USnXxnkcw==
X-Received: by 2002:adf:ce8e:0:b0:367:95e6:158a with SMTP id ffacd0b85a97d-371946db8bbmr1185470f8f.63.1723798658567;
        Fri, 16 Aug 2024 01:57:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7ead3sm72048675e9.47.2024.08.16.01.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:57:38 -0700 (PDT)
Message-ID: <192dcb60-e274-4b2c-a626-608bee4dbe65@redhat.com>
Date: Fri, 16 Aug 2024 10:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
To: Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
References: <20240816020723.771196-1-ying.huang@intel.com>
 <20240815215302.5ed29b99e94a48aea49269ce@linux-foundation.org>
 <66bede74cb96f_1c18294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
In-Reply-To: <66bede74cb96f_1c18294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.24 07:07, Dan Williams wrote:
> [ add David ]
> 
> Andrew Morton wrote:
>> On Fri, 16 Aug 2024 10:07:23 +0800 Huang Ying <ying.huang@intel.com> wrote:
>>
>>> On a system with CXL memory installed, the resource tree (/proc/iomem)
>>> related to CXL memory looks like something as follows.
>>>
>>> 490000000-50fffffff : CXL Window 0
>>>    490000000-50fffffff : region0
>>>      490000000-50fffffff : dax0.0
>>>        490000000-50fffffff : System RAM (kmem)
>>>
>>> When the following command line is run to try writing some memory in
>>> CXL memory range,
>>>
>>>   $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>>>   dd: error writing '/dev/mem': Bad address
>>>   1+0 records in
>>>   0+0 records out
>>>   0 bytes copied, 0.0283507 s, 0.0 kB/s
>>>
>>> the command fails as expected.  However, the error code is wrong.  It
>>> should be "Operation not permitted" instead of "Bad address".  And,
>>> the following warning is reported in kernel log.
>>>
>>>   ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
>>>   WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d

But we should definitely fix the warning.

>>> ...
>>>
>>
>> Presumably we want to fix earlier kernels?  If so, are you able to
>> identify a suitable Fixes: target?  Possibly 974854ab0728 ("cxl/acpi:
>> Track CXL resources in iomem_resource")?
> 
> At least that commit, but I think this problem potentially goes back
> farther to:
> 
> c221c0b0308f device-dax: "Hotplug" persistent memory for use like normal RAM
> 
> ...because that started the era of "System RAM" as a non-top-level
> resource.
> 
> David did a bunch of work to fix this back in:
> 
> 97f61c8f44ec kernel/resource: make walk_system_ram_res() find all busy IORESOURCE_SYSTEM_RAM resources
> 
> ..but the fallout in region_intersects() was missed.

Sounds reasonable.

For virtio-mem we set IORESOURCE_SYSTEM_RAM|IORESOURCE_EXCLUSIVE on our 
(highest) parent resource (to make any /dev/mem access attempts of that 
memory fail). So the problem is likely specific to other
add_memory_driver_managed() users.

I have a faint recollection that at some point we had code that would 
set IORESOURCE_SYSTEM_RAM on parent resources up the tree, but either my 
memory is wrong or that code was ripped out long ago.

Fix idea is reasonable: check if anything in that range is 
IORESOURCE_SYSTEM_RAM.

-- 
Cheers,

David / dhildenb


