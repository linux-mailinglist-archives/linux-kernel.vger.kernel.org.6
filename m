Return-Path: <linux-kernel+bounces-410842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783A9CEDB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20F7B278A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D111D432F;
	Fri, 15 Nov 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipwxKahj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEC1CEACD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682462; cv=none; b=Rq79owXTXy7GZeBM8U7jDARBpiBtC/jRR8DJIeWx/Kg6ZlckR+BtJ+a6lo5+KLYbtBHO7CKlZ8bnpeFha1TMNknRKvoy1MKJr3129Azes5brAgoHb4n+MH6yp8fZGLsqrU0Y/VkbEKq9Fn9MDL6gbj1nI4GFrVM6OkkVFNmr2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682462; c=relaxed/simple;
	bh=jhzXl8CARwQhGyRra5aVLKMCynxgA6DcsBLovlSSSwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMgMjmLo0oWah0IrePNmJWLMNUpiD+pZajKKrT5cNnMqfI1cIVHUyoePKntexxl0YASg6yc8P7ntlG8vhsNE6zpGXPON2LlAZd0BOpU/uCcWGHsZ3pGx/8EdIj+P4CDeFjv+zCy19rxswbUO4glPT4DEztbf+OLRFo0eDHbBCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipwxKahj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731682459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6yRAlct5Ie4AXcDhMKUTrBUjBKagW6pPNc67NhL0Qw8=;
	b=ipwxKahj/HUj4zb2lZ2MB1dHDyryxAZY0hm8qgU04NrClG+vJyv2hvXN/aUVzDFcXESmWM
	lXuVvL1e2q4IGJMXq5VLecURbUP2MkC2KQ8IofT1+daQookLtaxiw9HEsZXlgdcKjsrcTa
	aHpku9IG/BI0bCRgS+ZDcUx1SJXB8ZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-qqONR0eOPKqZTvSEJ31WCw-1; Fri, 15 Nov 2024 09:54:18 -0500
X-MC-Unique: qqONR0eOPKqZTvSEJ31WCw-1
X-Mimecast-MFC-AGG-ID: qqONR0eOPKqZTvSEJ31WCw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d59ad50f3so920549f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682457; x=1732287257;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6yRAlct5Ie4AXcDhMKUTrBUjBKagW6pPNc67NhL0Qw8=;
        b=ZW2vx+RF3Tbm7ImuBQtM5QDt/i5Tlqp2EO8HEvZRcqjVtoOc+FbdkyK0r8mDmclBZE
         bU2wRibJbkSPp2pMveFzD/alKMC8OdF+hsJ1uv9/VPT/FEV6rwQUofBaShvc26/+9sDy
         wCwiG0PVVPEMZ1LBY24NWFQFE1QXnFs44qONgl+Fj/UY4IgaF9Dlb1i0/o3IsURYdxd9
         5om6DV+sAmI9buDXUgcX+bDZkEDQo1xZzuBVIFvQww+kw9W491ca1TteB0b8NHVkJmnK
         FlHlrRbgYwp7or87v+cd33BHtvzNtxcHwSpgC5OEOVEzIgSoGrvsZNVsLYB5nCmdS9t6
         uD0A==
X-Forwarded-Encrypted: i=1; AJvYcCVgdAMtXWrstvOSrozg8KeVO/kKgGMguD/Ng8A7+8mxfCvvdrDhWhWBZhGtdGoMi30nPEffKRdpFd663/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGntrdgwXv2dMs5hYJzv8GcJpn6YfvcgY4INUCpmKuT4LvvKT
	nk8r1W7y0rLL9iFTbBbXpI25S4wi2d0DSQOawud0DfRBFXvj/gf6qM0a2QuM8v9ORZbMgk9F0Ob
	nHk6JE70fCjPfkNhJDA7/U5Z8YAwkcDgnQMBGhxN1lSHBHP5k3Panj4ohoOJu2A==
X-Received: by 2002:a05:6000:2a4:b0:381:f0cf:bf68 with SMTP id ffacd0b85a97d-38225aa4b5cmr2455371f8f.50.1731682456734;
        Fri, 15 Nov 2024 06:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwVQXfBp9s3LW2y8A+h7YW57BzkAxSkNteXB2Q7/esdSA3usxj8EY1FCBfXjOguiva5IAaZA==
X-Received: by 2002:a05:6000:2a4:b0:381:f0cf:bf68 with SMTP id ffacd0b85a97d-38225aa4b5cmr2455336f8f.50.1731682456237;
        Fri, 15 Nov 2024 06:54:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3e65sm4532783f8f.13.2024.11.15.06.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:54:15 -0800 (PST)
Message-ID: <d6dfe598-f7c2-4c3d-b7a3-71b1e928cb04@redhat.com>
Date: Fri, 15 Nov 2024 15:54:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: shmem: add a kernel command line to change the
 default huge policy for tmpfs
To: Daniel Gomez <da.gomez@samsung.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <64091a3d5a8c5edb0461fae203cfcf6f302a19ce.1731397290.git.baolin.wang@linux.alibaba.com>
 <CGME20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4@eucas1p2.samsung.com>
 <D5MT3TF12PO7.1A65Y7SMUHI7N@samsung.com>
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
In-Reply-To: <D5MT3TF12PO7.1A65Y7SMUHI7N@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.24 15:02, Daniel Gomez wrote:
> On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
>> Now the tmpfs can allow to allocate any sized large folios, and the default
>> huge policy is still 'never'. Thus adding a new command line to change
>> the default huge policy will be helpful to use the large folios for tmpfs,
>> which is similar to the 'transparent_hugepage_shmem' cmdline for shmem.
> 
> 
> I think it would be good to include a summary of why tmpfs is not
> enabling large folios by default as the other fs. David has been
> pretty good at repeating the reasons over and over and it would be very
> valuable to have them included here.

Yes. We also discussed in v4 the idea of having a Kconfig option to just 
change the default policy to "always". We could mention that here as well.

-- 
Cheers,

David / dhildenb


