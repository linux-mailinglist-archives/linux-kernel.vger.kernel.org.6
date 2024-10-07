Return-Path: <linux-kernel+bounces-354084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EA993786
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5171F2208B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8781DE3AF;
	Mon,  7 Oct 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaRC00KJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A291D61AC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330079; cv=none; b=PTNgJNMrcvFAfHxVypT8rJ182LTurZhKgmpdCDLU64j6LXHAwlS8EaJqoa8RvySGaEOU0BInHxj4p7R5UmNDnpN20eIKCx82lFgIbDcaMewyR9Fwunr+nJz9n1jrPUMFeUTjsmS5upAjAXQsNdoURaxZrwuBtj98GbVJg2KgUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330079; c=relaxed/simple;
	bh=l4qgu21TDpIVf5RmLYztfSkEyHX1zxQqQY6/d54rH2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOaQgsjMWEwJBlnlSG59hsjz3Li1Dysf1kdVPopbRVl6DFeIrXhKmwPfMqpCUSK3dARWHAqjYoc/HovhJ8tNK4YssTWqs23pn32g+ELFndT0ZfzWgBS6Ev3JRu1r3EGR7F1dJmMXvlk7bX9Xh9WaN3zJIholYfZOD002JITxe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaRC00KJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728330077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+xcGynd5JkBoXB5FACyPd3wDpRk5muXFwJHf5s4pVck=;
	b=SaRC00KJ4SeEGN7iH2VFpK68Vz527bk4Oak0L3+6+5bCmFZDELmIV6PvWnRNrvY29I4Ae6
	uuIg4msEEvzruPpmTZiVaW8bj4Hf22jhOEFfbU0fndECYnrveCkSGUEuFUh3ZfDOWXzny8
	MQTouDjA/0qFOY5grNNCmjmfNWdTsaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Z37d9Iw7ObO2VaeUlP63Gg-1; Mon, 07 Oct 2024 15:41:15 -0400
X-MC-Unique: Z37d9Iw7ObO2VaeUlP63Gg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so39936185e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 12:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330074; x=1728934874;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xcGynd5JkBoXB5FACyPd3wDpRk5muXFwJHf5s4pVck=;
        b=LYNHsgl8G9/FCF74hQvhMGk1wAwSVJbm1oSWe/1EoAMD0VWSygVpLBZ9KfBSiO4O4c
         JvGqCwpddvARFC7AY8rwMM4+IGotm0EmirJDuQ3itNBFB7atzxMcrngUBZs3UA8TkNZq
         2Y5vzdpjd7RPumj0pHcF9r0j9MuivXgyFln/yL6bkivws6nJcxAxyY0G3xZJxPoslv7b
         TiBb8F/3cg9LNlKnacR41T1nsTRwqUyAoId0jZhKA8QS+Rt/Czc5fsdVA5UMuKaJ+UMl
         nm4l/rR8NPvRlLHzYcKvCQWd8o5S34y7betHEpRZf+BNdzqxSPCJcIm4OryHfssfpiMQ
         vbIw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZd0bfk8k1t+KPyekzPQZv0aHW0Zm1xWDbVVpBv2VlXFvdVUNd9TF0Gf71tJD5aYjp9LwB7GpB8qq04Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YydN07SljUZPzMOQWGLNv6CqWqZduJDTTywPSClPlBLlqZjlQDS
	oimr2ey3x7X4FAkstmxVnTODO86YHMtqZ+7jmo0QYUgY1wfC8LEdu8AelyOp/7yF0l9iz86Rwu8
	nEx3X28kiouVJJfk65e7WfpmckeVGAhS+oSa+SPIboGhkUlx5y9ITfj/LQCJX9Q==
X-Received: by 2002:a05:600c:4e89:b0:42c:b750:19d8 with SMTP id 5b1f17b1804b1-42f85a700ecmr92758115e9.4.1728330074402;
        Mon, 07 Oct 2024 12:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8zo2mSVfQ1Nm/9d6px71R6YDbe4Yuoj9cUkop7VORdBVs/38YdJInvN7ISyoTbg8oUpLdPw==
X-Received: by 2002:a05:600c:4e89:b0:42c:b750:19d8 with SMTP id 5b1f17b1804b1-42f85a700ecmr92757905e9.4.1728330073998;
        Mon, 07 Oct 2024 12:41:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34? (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de. [2003:cb:c725:8700:77c7:bde:9446:8d34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed957asm84732725e9.44.2024.10.07.12.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 12:41:12 -0700 (PDT)
Message-ID: <d080442f-be33-474b-9c4a-bdb57d14cd2c@redhat.com>
Date: Mon, 7 Oct 2024 21:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
 viro@zeniv.linux.org.uk, khalid@kernel.org, andreyknvl@gmail.com,
 dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
 ebiederm@xmission.com, catalin.marinas@arm.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <nst3wauaphvvnkseuatqknxfhtu5ewf7zqmoskim5kt52wf2mi@sasls2f6r22i>
 <d56b1326-74e3-4782-a5c7-0451f08cf10b@oracle.com>
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
In-Reply-To: <d56b1326-74e3-4782-a5c7-0451f08cf10b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.24 21:23, Anthony Yznaga wrote:
> 
> On 10/7/24 2:01 AM, Kirill A. Shutemov wrote:
>> On Tue, Sep 03, 2024 at 04:22:31PM -0700, Anthony Yznaga wrote:
>>> This patch series implements a mechanism that allows userspace
>>> processes to opt into sharing PTEs. It adds a new in-memory
>>> filesystem - msharefs. A file created on msharefs represents a
>>> shared region where all processes mapping that region will map
>>> objects within it with shared PTEs. When the file is created,
>>> a new host mm struct is created to hold the shared page tables
>>> and vmas for objects later mapped into the shared region. This
>>> host mm struct is associated with the file and not with a task.
>> Taskless mm_struct can be problematic. Like, we don't have access to it's
>> counters because it is not represented in /proc. For instance, there's no
>> way to check its smaps.
> 
> Definitely needs exposure in /proc. One of the things I'm looking into
> is the feasibility of showing the mappings in maps/smaps/etc..
> 
> 
>>
>> Also, I *think* it is immune to oom-killer because oom-killer looks for a
>> victim task, not mm.
>> I hope it is not an intended feature :P
> 
> oom-killer would have to kill all sharers of an mshare region before the
> mshare region itself could be freed, but I'm not sure that oom-killer
> would be the one to free the region. An mshare region is essentially a
> shared memory object not unlike a tmpfs or hugetlb file. I think some
> higher level intelligence would have to be involved to release it if
> appropriate when under oom conditions.


I thought we discussed that at LSF/MM last year and the conclusion was 
that a process is needed (OOM kill, cgroup handling, ...), and it must 
remain running. Once it stops running, we can force-unmap all pages etc.

Did you look at the summary/(recording if available) of that, or am I 
remembering things wrongly or was there actually such a discussion?

I know, it's problematic that this feature switched owners, ...


-- 
Cheers,

David / dhildenb


