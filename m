Return-Path: <linux-kernel+bounces-197723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29AE8D6E77
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F0F1C249AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD712E78;
	Sat,  1 Jun 2024 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO0BYUNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43812BA53
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222953; cv=none; b=auzHSfJZtjvcynVFWCYvWR6h6faMTS0KAc3tYVjhYVKM1v8MvGB0E0fQAswsZ9quaSyhhOgkRWDkc+d16SwPo30yuXRSg77UTdkBOPJsxuQmFqP/F8azUPbdxa+UNpnH1dAHZQsbc1XbcNtRyVIMSPGAEFjsSpSscp7cZlTM2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222953; c=relaxed/simple;
	bh=9R0GwhLMUtDLNu11sHRuqL9wVIgpXOud9USldFRHMZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3omejoIJcFbTmh+QTu+5HcpXnt5RXtVPeMcAeXyKa5gTf/mi9RRgk6LywqPZIbhboKZUWoekFhZmMZNRUDu8nuZuybiDJlbLHZNlVZiBynsZ/vegQICDDhupN+bIy21jt5wH6xrRFpId3oWszhPICj4qyV0vC5DoOQu174g0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gO0BYUNv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717222949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eiYnCvpjwIKcLljPRoGCKOH7KaPQrgqBq24D873qOM0=;
	b=gO0BYUNvrt9/4vLGlbHCrzqqYrM92YY/zddTFKdpdKEBI6a7SwVH0/mTIfri+N4RfytEPs
	Y6U+ikWG2HK67mDMXOo3vgib4A47277edeOjJjpwgntlg6RQRjxGS8j/EHvuUkngReAKvM
	8LylU6Svj1wrSmGKN0NRHa7A07Ei0bw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-7wSyERcWM0-lW379p_3PhQ-1; Sat, 01 Jun 2024 02:22:27 -0400
X-MC-Unique: 7wSyERcWM0-lW379p_3PhQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e4b4e0260so324903f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717222944; x=1717827744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eiYnCvpjwIKcLljPRoGCKOH7KaPQrgqBq24D873qOM0=;
        b=OCGCpBkzWjfYNEzu2LI/wJmTDGR49QbvbwRz8r8nDSX8HbQHmv68DdxoWlEOu4azMK
         5n5/UV0h/8GCdxwOcWKwwJ2EkaIv5frVbuzWtJ22W7CymJf18YRaKzPtz4L4Le+vpuLc
         q4i4pVnFPLYhrg1sPokBnmQifxq4R0OsVXCSm8H5bE6wi00GGRA7iRUhsddw2gZnIQOq
         9ulYoZb2/oWns8KjJlCGiRo0uljsoIMOUxFOV2o4Fvg/eVNx5VjD0IscwcNJcx+i42/3
         HphmcxRkpx+Z7Aq28cLfgBamrcjQFbgVEYj7vFXVGrvLmkdUCfj+QJ3mLTPwV4UZ6xJD
         c7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRW8nc9gf4bOrkltH7RlhzWlZFKwGb5XPQHl0s8FCKLAZ2YGz4iDXZiYRqTDID6RbQVcgecbFCXgfow41tMl4AWMRr234YAc7/c8Y
X-Gm-Message-State: AOJu0YwifgrpD87FVQCBc7/8GPE9aEz6UTPYnpUJHqNP7H5tz+P18TGW
	vYWEcxyZdtit2X94Pp3LOGI/+no3J78lPOkNpHVCY5ct8uTdWrzWlvGYNAJ8h6dUXNyGixp5CeF
	ZsYghw/E3RfSFX1k8eogtlppizzHEOLzGQQqnkP2pkgEV0MNmK8HRCedoorUjJA==
X-Received: by 2002:a5d:6d05:0:b0:35a:62e3:7103 with SMTP id ffacd0b85a97d-35e0f25521fmr4327231f8f.2.1717222943763;
        Fri, 31 May 2024 23:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaOZFW6+LxVmLGXLmLET3wO4/zBB4fe1NK7hEUUUH8rESWKPiVrmjbp6JPB0vZQPESSGUAGQ==
X-Received: by 2002:a5d:6d05:0:b0:35a:62e3:7103 with SMTP id ffacd0b85a97d-35e0f25521fmr4327216f8f.2.1717222943250;
        Fri, 31 May 2024 23:22:23 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6b24.dip0.t-ipconnect.de. [91.12.107.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127062f0dsm74640675e9.17.2024.05.31.23.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 23:22:22 -0700 (PDT)
Message-ID: <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com>
Date: Sat, 1 Jun 2024 08:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
To: Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Rik van Riel <riel@surriel.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
 linux-mm@kvack.org
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
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
In-Reply-To: <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.06.24 02:59, Yang Shi wrote:
> On Fri, May 31, 2024 at 5:01 PM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Fri, May 31, 2024 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Fri, May 31, 2024 at 07:46:41PM +0200, David Hildenbrand wrote:
>>>> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
>>>>
>>>> Is called (mm-unstable) from:
>>>>
>>>> (1) gup_fast function, here IRQs are disable
>>>> (2) gup_hugepte(), possibly problematic
>>>> (3) memfd_pin_folios(), possibly problematic
>>>> (4) __get_user_pages(), likely problematic
>>>>
>>>> (1) should be fine.
>>>>
>>>> (2) is possibly problematic on the !fast path. If so, due to commit
>>>>      a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Peter.
>>>>
>>>> (3) is possibly wrong. CCing Vivek.
>>>>
>>>> (4) is what we hit here
>>>
>>> I guess it was overlooked because try_grab_folio() didn't have any comment
>>> or implication on RCU or IRQ internal helpers being used, hence a bit
>>> confusing.  E.g. it has different context requirement on try_grab_page(),
>>> even though they look like sister functions.  It might be helpful to have a
>>> better name, something like try_grab_folio_rcu() in this case.
>>>
>>> Btw, none of above cases (2-4) have real bug, but we're looking at some way
>>> to avoid triggering the sanity check, am I right?  I hope besides the host
>>> splash I didn't overlook any other side effect this issue would cause, and
>>> the splash IIUC should so far be benign, as either gup slow (2,4) or the
>>> newly added memfd_pin_folios() (3) look like to have the refcount stablized
>>> anyway.
>>>
>>> Yang's patch in the other email looks sane to me, just that then we'll add
>>> quite some code just to avoid this sanity check in paths 2-4 which seems
>>> like an slight overkill.
>>>
>>> One thing I'm thinking is whether folio_ref_try_add_rcu() can get rid of
>>> its RCU limitation. It boils down to whether we can use atomic_add_unless()
>>> on TINY_RCU / UP setup too?  I mean, we do plenty of similar things
>>> (get_page_unless_zero, etc.) in generic code and I don't understand why
>>> here we need to treat folio_ref_try_add_rcu() specially.
>>>
>>> IOW, the assertions here we added:
>>>
>>>          VM_BUG_ON(!in_atomic() && !irqs_disabled());
>>>
>>> Is because we need atomicity of below sequences:
>>>
>>>          VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
>>>          folio_ref_add(folio, count);
>>>
>>> But atomic ops avoids it.
>>
>> Yeah, I didn't think of why atomic can't do it either. But is it
>> written in this way because we want to catch the refcount == 0 case
>> since it means a severe bug? Did we miss something?
> 
> Thought more about it and disassembled the code. IIUC, this is an
> optimization for non-SMP kernel. When in rcu critical section or irq
> is disabled, we just need an atomic add instruction.
> folio_ref_add_unless() would yield more instructions, including branch
> instruction. But I'm wondering how useful it would be nowadays. Is it
> really worth the complexity? AFAIK, for example, ARM64 has not
> supported non-SMP kernel for years.
> 
> My patch actually replaced all folio_ref_add_unless() to
> folio_ref_add() for slow paths, so it is supposed to run faster, but
> we are already in slow path, it may be not measurable at all. So
> having more simple and readable code may outweigh the potential slight
> performance gain in this case?

Yes, we don't want to use atomic RMW that return values where we can use 
atomic RMW that don't return values. The former is slower and implies a 
memory barrier, that can be optimized out on some arcitectures (arm64 IIRC)

We should clean that up here, and make it clearer that the old function 
is only for grabbing a folio if it can be freed concurrently -- GUP-fast.

-- 
Cheers,

David / dhildenb


