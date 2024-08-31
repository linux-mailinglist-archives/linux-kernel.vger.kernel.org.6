Return-Path: <linux-kernel+bounces-309798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C144967089
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622751C21BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA6176AD0;
	Sat, 31 Aug 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu7TbfOd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC516F8E5
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097469; cv=none; b=AQCKs7mVa/Zbxv+9M0+9qcGb9cv+f1xNLHcDckIriZUrqHannXaJg8i+bDa1oYSgKg3Rt0Ne0XDesD19h/y2CpdcqLJ5VZ1xFDzUVF6ONztJjiXT4b23JqN0advqvPByfl/LprgTUoFf3T3C/lxrXUk8j29OoqXXMjjV6K4lVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097469; c=relaxed/simple;
	bh=nK0daTjiOGCV4p4ZR7O3iEA3sM1fb1/kzQrrU9Bndc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ2s5VqTLWl8TeECOGUNGG9Yoakw+U88jeVdYUSqsRahD8qZdpAyvzJdWnr96//XokpWM1/4E5W1t322DP0CN+EV7/nUmLgnveCgN7Mu2mmIH1mWEie4uqSa4a7B02/tohAHKyImtLKy6qt/YP9Pg4VMRL7EoQwbgTBqbf4V7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu7TbfOd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725097466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8dEiNuXmNo5+/mkuwRvfGN9u4M0g1araWfOkqPWZ2M=;
	b=Pu7TbfOdm9ffxhtCUnEz7xxNTgiSzXNQfzk+BHkQTYkIQ01WsrE6vLLrotTtoaX3JmzXn/
	24TXR7wJhCrDNrxhjTFO8WUiXdTYeJi+vVqOuDzI6HxWrA/6o4/GSd2WAgs6ZF8Pig+sVM
	yaGZimoOPRlD/pOTzv84NmGI0n8n1zs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-07nUgyVVOEu8mOLvoumVMA-1; Sat, 31 Aug 2024 05:44:24 -0400
X-MC-Unique: 07nUgyVVOEu8mOLvoumVMA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374beb23f35so349745f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725097463; x=1725702263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8dEiNuXmNo5+/mkuwRvfGN9u4M0g1araWfOkqPWZ2M=;
        b=gCeUPXuy9Pp3Qqdj/QfnCARmCY3xeRUlo3BRifwG3x4lLQnxdGIuqb87lAeLkq354P
         NRC2Y/oz7WI25VFxolSWVp8Yhlby40KuFRigbp1sf8sCRBgmtUTdh73AIa2PkM+dGIgS
         AG/9QuK2A0WLw4p383Wf/dnr5nWNeSGcbUjQKGVgYlxtmsGCTy4spqBTvUIPJrEgBXdz
         5RzHICHdLOaL5bb4W98GqKbja9xhvegP9yow29lTQgw9JouBkSNaiB8PgdrbVyG7/Gwn
         40Tbisi/Wix7csyicliMQYD6oLufF4+KW15fjVBIfuc5R4ANAKtom/WYWNUhTuAiANeU
         3Ing==
X-Gm-Message-State: AOJu0Yycj0p0Wf87gJam37RB3nypS8R+9LxzsJ6S43LnmOMTNCbXSVqn
	aRqBCNbFU+edLIAbUkSJkognaD17OeE5sJJq3ealE4IlC7IpHzy26us/dHLKDZphbPdJ9Ns7yPH
	0Q+lF5JSB3HWf1EONiWU/Nez6txTiz3Z2ZuxN/Q8SqhmK5DhJjoCOuTIMRhbLHg==
X-Received: by 2002:adf:9d87:0:b0:368:5bb4:169b with SMTP id ffacd0b85a97d-374bed94fe5mr1077122f8f.4.1725097463418;
        Sat, 31 Aug 2024 02:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYTIgwv6FmdEiuVO4554wwgQ/z6OySRIxE96WnCplzESjxdwLiZqgPsiPb+Dp4IpjlsvVj0w==
X-Received: by 2002:adf:9d87:0:b0:368:5bb4:169b with SMTP id ffacd0b85a97d-374bed94fe5mr1077089f8f.4.1725097462437;
        Sat, 31 Aug 2024 02:44:22 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6ee6.dip0.t-ipconnect.de. [91.12.110.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee7475dsm6068281f8f.27.2024.08.31.02.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 02:44:21 -0700 (PDT)
Message-ID: <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
Date: Sat, 31 Aug 2024 11:44:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <20240831092339.66085-1-21cnbao@gmail.com>
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
In-Reply-To: <20240831092339.66085-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.08.24 11:23, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> On a physical phone, it's sometimes observed that deferred_split
> mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhua
> indicates that the majority of these originate from the typical fork
> scenario.
> When the child process either execs or exits, the parent process should
> ideally be able to reuse the entire mTHP. However, the current kernel
> lacks this capability and instead places the mTHP into split_deferred,
> performing a CoW (Copy-on-Write) on just a single subpage of the mTHP.
> 
>   main()
>   {
>   #define SIZE 1024 * 1024UL
>           void *p = malloc(SIZE);
>           memset(p, 0x11, SIZE);
>           if (fork() == 0)
>                   exec(....);
>          /*
>   	 * this will trigger cow one subpage from
>   	 * mTHP and put mTHP into split_deferred
>   	 * list
>   	 */
>   	*(int *)(p + 10) = 10;
>   	printf("done\n");
>   	while(1);
>   }
> 
> This leads to two significant issues:
> 
> * Memory Waste: Before the mTHP is fully split by the shrinker,
> it wastes memory. In extreme cases, such as with a 64KB mTHP,
> the memory usage could be 64KB + 60KB until the last subpage
> is written, at which point the mTHP is freed.
> 
> * Fragmentation and Performance Loss: It destroys large folios
> (negating the performance benefits of CONT-PTE) and fragments memory.
> 
> To address this, we should aim to reuse the entire mTHP in such cases.
> 
> Hi David,
> 
> I’ve renamed wp_page_reuse() to wp_folio_reuse() and added an
> entirely_reuse argument because I’m not sure if there are still cases
> where we reuse a subpage within an mTHP. For now, I’m setting
> entirely_reuse to true only for the newly supported case, while all
> other cases still get false. Please let me know if this is incorrect—if
> we don’t reuse subpages at all, we could remove the argument.

See [1] I sent out this week, that is able to reuse even without 
scanning page tables. If we find the the folio is exclusive we could try 
processing surrounding PTEs that map the same folio.

[1] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.com

-- 
Cheers,

David / dhildenb


