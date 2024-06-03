Return-Path: <linux-kernel+bounces-199378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D478D8642
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2941A1C2182E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B0131182;
	Mon,  3 Jun 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QByKCFCG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84F12E1FF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429372; cv=none; b=UchFxt82UKSmgTWzdnRniQUhMH9M0TpX63KvIP+ZlmfXw0x+yWOyvX3JsyNRrauX4glqGsohr/8p3h0Xqi4fVEAka97eH2IIivVhXRFuYE13/B5zr5DXZTK7bhrEHn/ys/buyvU8Ys4d5utLGjPOYfYobAd87hbd/gYlDQVvykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429372; c=relaxed/simple;
	bh=bBOEzXVXHgOQePBrBeC0KZN6fQ20TA+slzGDDMQu7AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5zIs3bsjpUO4QqkcbONwSXEL0XqUiIphQkfqJwgR/AAOiNKyWww7lH5PfEktRYLJ4o1HgkBUX4qWH2PzGO/icZdh5DOTvNqmxTIA2LZR/x7f2TJ8BtODG8aBOXXAxiuloJ82y0T7t4SbquQVCo+h9Myffy00kNEp2lNEDiapIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QByKCFCG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717429369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JlFg7uy6aRqdZ9PHzh1ezbeR2Vu35L0P/Y5WFAQh38w=;
	b=QByKCFCGkdcmpkdqdIVj9BJWrOr8W+xqovOYzS6ZnHrL+7+cNjXJVXaSv3GSybm5yBiy1q
	IhKSOm1QWu1q8QyV8PM0URuekJtN8QBR1Uky/HsN6sQXBKSuhAvbLzwycbEyR0998hE41A
	xZCbg4Z29fFmWfPjEjq80uwSuFvYhWs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-g5nmRJHlPIuXA95D8RIbZQ-1; Mon, 03 Jun 2024 11:42:48 -0400
X-MC-Unique: g5nmRJHlPIuXA95D8RIbZQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dcb90989eso2891796f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429367; x=1718034167;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JlFg7uy6aRqdZ9PHzh1ezbeR2Vu35L0P/Y5WFAQh38w=;
        b=H9+ZkqnIXrbO8jWmT42LKDtkFOQx6EAlNT1OxNxrHPcTjaU6rLONKKhgCMXAHJS3OX
         FfWFv5FVOnkNt9DXU9DDsXmkZ0m0puuvhfFpAqtZPOrxWPQ/RbOwfyb3aSN6c5lRhn2+
         jNnGU+p/uLwm9iBNRkeB9ZdI0Q93G81es4Bat8BPEuwRHd5arpIe/rqaA/vZSaB8OYXr
         VObMjDtlH+GbqYXrf+fD3zZIFXTbYMuEXD+gjiNZegEJWvQCwk+tWKoytAmnsfT9/+nZ
         vYZfTxA0ViTaY3oq1KBHQDZwQFPnb0hqG2mnd3sVoFnqiMP1vg+qTnUz9OiYHbZ/LjS2
         F/Og==
X-Forwarded-Encrypted: i=1; AJvYcCWzlfslCca95sLUUWxmkGcHF8QhFwbHQx3G2OTHkNkgmDpuUv65GIMbwb6o8ottX5hTvsnRDlEjmUgwQhkwTf+PtypecPCjiK528D3K
X-Gm-Message-State: AOJu0YxEnD3E5ld1oTr8S6jh+UxvoxeNJPKqfmH0mG7APJg8sKxAi74d
	iebXVQSe3ycqW0cdJSgEX0SkzQhM6i3p54RBrdu7SlYgE3I+r4Q6eiBoaGuSrU9Z3hG0+1DzOja
	Z0R2Gy2xOQLkSPm8u3t8zVqi34xj2HAfs7D4/sivhkXygfjBJcObdHNj7R5B+iQ==
X-Received: by 2002:adf:e9d1:0:b0:355:3dc:1f26 with SMTP id ffacd0b85a97d-35e0f289290mr7250177f8f.37.1717429366981;
        Mon, 03 Jun 2024 08:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/6lsDBuTW+rzYFuK9rkdDT0Y/FN0eTrgZha0XrJfSWQK1wUmWWcbepXjnRcWrNhV4g/WXtw==
X-Received: by 2002:adf:e9d1:0:b0:355:3dc:1f26 with SMTP id ffacd0b85a97d-35e0f289290mr7250160f8f.37.1717429366485;
        Mon, 03 Jun 2024 08:42:46 -0700 (PDT)
Received: from ?IPV6:2a01:599:908:c963:af9b:c64c:dfd8:5999? ([2a01:599:908:c963:af9b:c64c:dfd8:5999])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062fe2csm9018817f8f.69.2024.06.03.08.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 08:42:45 -0700 (PDT)
Message-ID: <8da12503-839d-459f-a2fa-4abd6d21935d@redhat.com>
Date: Mon, 3 Jun 2024 17:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
To: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, kernel test robot
 <oliver.sang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Rik van Riel
 <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
 linux-mm@kvack.org
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <ZlpcRnuZUEYJJ0JA@x1n>
 <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
 <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
 <0edfcfed-e8c4-4c46-bbce-528c07084792@redhat.com> <Zl3cakfiRsPQDb8q@x1n>
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
In-Reply-To: <Zl3cakfiRsPQDb8q@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.06.24 17:08, Peter Xu wrote:
> On Sat, Jun 01, 2024 at 08:22:21AM +0200, David Hildenbrand wrote:
>> On 01.06.24 02:59, Yang Shi wrote:
>>> On Fri, May 31, 2024 at 5:01 PM Yang Shi <shy828301@gmail.com> wrote:
>>>>
>>>> On Fri, May 31, 2024 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Fri, May 31, 2024 at 07:46:41PM +0200, David Hildenbrand wrote:
>>>>>> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
>>>>>>
>>>>>> Is called (mm-unstable) from:
>>>>>>
>>>>>> (1) gup_fast function, here IRQs are disable
>>>>>> (2) gup_hugepte(), possibly problematic
>>>>>> (3) memfd_pin_folios(), possibly problematic
>>>>>> (4) __get_user_pages(), likely problematic
>>>>>>
>>>>>> (1) should be fine.
>>>>>>
>>>>>> (2) is possibly problematic on the !fast path. If so, due to commit
>>>>>>       a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Peter.
>>>>>>
>>>>>> (3) is possibly wrong. CCing Vivek.
>>>>>>
>>>>>> (4) is what we hit here
>>>>>
>>>>> I guess it was overlooked because try_grab_folio() didn't have any comment
>>>>> or implication on RCU or IRQ internal helpers being used, hence a bit
>>>>> confusing.  E.g. it has different context requirement on try_grab_page(),
>>>>> even though they look like sister functions.  It might be helpful to have a
>>>>> better name, something like try_grab_folio_rcu() in this case.
>>>>>
>>>>> Btw, none of above cases (2-4) have real bug, but we're looking at some way
>>>>> to avoid triggering the sanity check, am I right?  I hope besides the host
>>>>> splash I didn't overlook any other side effect this issue would cause, and
>>>>> the splash IIUC should so far be benign, as either gup slow (2,4) or the
>>>>> newly added memfd_pin_folios() (3) look like to have the refcount stablized
>>>>> anyway.
>>>>>
>>>>> Yang's patch in the other email looks sane to me, just that then we'll add
>>>>> quite some code just to avoid this sanity check in paths 2-4 which seems
>>>>> like an slight overkill.
>>>>>
>>>>> One thing I'm thinking is whether folio_ref_try_add_rcu() can get rid of
>>>>> its RCU limitation. It boils down to whether we can use atomic_add_unless()
>>>>> on TINY_RCU / UP setup too?  I mean, we do plenty of similar things
>>>>> (get_page_unless_zero, etc.) in generic code and I don't understand why
>>>>> here we need to treat folio_ref_try_add_rcu() specially.
>>>>>
>>>>> IOW, the assertions here we added:
>>>>>
>>>>>           VM_BUG_ON(!in_atomic() && !irqs_disabled());
>>>>>
>>>>> Is because we need atomicity of below sequences:
>>>>>
>>>>>           VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
>>>>>           folio_ref_add(folio, count);
>>>>>
>>>>> But atomic ops avoids it.
>>>>
>>>> Yeah, I didn't think of why atomic can't do it either. But is it
>>>> written in this way because we want to catch the refcount == 0 case
>>>> since it means a severe bug? Did we miss something?
>>>
>>> Thought more about it and disassembled the code. IIUC, this is an
>>> optimization for non-SMP kernel. When in rcu critical section or irq
>>> is disabled, we just need an atomic add instruction.
>>> folio_ref_add_unless() would yield more instructions, including branch
>>> instruction. But I'm wondering how useful it would be nowadays. Is it
>>> really worth the complexity? AFAIK, for example, ARM64 has not
>>> supported non-SMP kernel for years.
>>>
>>> My patch actually replaced all folio_ref_add_unless() to
>>> folio_ref_add() for slow paths, so it is supposed to run faster, but
>>> we are already in slow path, it may be not measurable at all. So
>>> having more simple and readable code may outweigh the potential slight
>>> performance gain in this case?
>>
>> Yes, we don't want to use atomic RMW that return values where we can use
>> atomic RMW that don't return values. The former is slower and implies a
>> memory barrier, that can be optimized out on some arcitectures (arm64 IIRC)
>>
>> We should clean that up here, and make it clearer that the old function is
>> only for grabbing a folio if it can be freed concurrently -- GUP-fast.
> 
> Note again that this only affects TINY_RCU, which mostly implies
> !PREEMPTION and UP.  It's a matter of whether we prefer adding these bunch
> of code to optimize that.
> 
> Also we didn't yet measure that in a real workload and see how that
> "unless" plays when buried in other paths, but then we'll need a special
> kernel build first, and again I'm not sure whether it'll be worthwhile.

try_get_folio() is all about grabbing a folio that might get freed 
concurrently. That's why it calls folio_ref_try_add_rcu() and does 
complicated stuff.

On !CONFIG_TINY_RCU, it performs a folio_ref_add_unless(). That's 
essentially a atomic_add_unless(), which in the worst case ends up being 
a cmpxchg loop.


Stating that we should be using try_get_folio() in paths where we are 
sure the folio refcount is not 0 is the same as using folio_try_get() 
where folio_get() would be sufficient.

The VM_BUG_ON in folio_ref_try_add_rcu() really tells us here that we 
are using a function in the wrong context, although in our case, it is 
safe to use (there is now BUG). Which is true, because we know we have a 
folio reference and can simply use a simple folio_ref_add().

Again, just like we have folio_get() and folio_try_get(), we should 
distinguish in GUP whether we are adding more reference to a folio (and 
effectively do what folio_get() would), or whether we are actually 
grabbing a folio that could be freed concurrently (what folio_try_get() 
would do).

-- 
Cheers,

David / dhildenb


