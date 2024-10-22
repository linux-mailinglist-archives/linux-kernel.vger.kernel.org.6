Return-Path: <linux-kernel+bounces-376479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47B9AB22F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3BD1C21751
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AA19D087;
	Tue, 22 Oct 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iliSUdCb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EB13B590
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611099; cv=none; b=C1X7nAlS+FjBo1+TrdAtgzfXbrnT8Okj8lJMuYAH/RnAiFXLdcAjpTX1trK+QgZCQHobqxLorea6X1QLobvtgB/64CPprW+ErT7Qj2yAabZDJ4pvpIj29BQIpol2BsnFeoj7Y92E3fbLi0hds9DDFOL2dAMWa7CgBLF1Fs6PTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611099; c=relaxed/simple;
	bh=D4BpZoH1r86trSi98WosWwvTvRMEJ/LPM0SiTl8VVIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLk+PV915f7T4xpP719su2j9rLghjvZDbBxAww+O2isqxx7wlcTFHjztY/oy5GQJm8WKeC+XLDkkShIb1WRk6NVnZ7XbxldrmvvQUsBdJqQ3n4Gp3mLof1SvxL8XgFTONcWAymb79vwblDHp8PvDkrVPydV5rX5DyrmZkV2MBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iliSUdCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729611097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7b+nqmrv5oJ2xIV5ntlowv32I+l6MVBCYQKdjO2iViA=;
	b=iliSUdCbNUF0L2mOZ6k6W91B76swSPD0pYEpI0lT9DBYj9sfbLY1AKT7AJzno+Qe37nGt2
	BtFADBu2y4EOYL/J39cdiemeP4hx5N71H7ovGJoQ0b0kT8HPyc3nJLdckyhRuaenD+N6qw
	I96ZDiHdjwMUvZ1so41WWTXNORrivKg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481--t9q7gzqNkO7HcVMT8Su4w-1; Tue, 22 Oct 2024 11:31:35 -0400
X-MC-Unique: -t9q7gzqNkO7HcVMT8Su4w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315cefda02so42658495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611094; x=1730215894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7b+nqmrv5oJ2xIV5ntlowv32I+l6MVBCYQKdjO2iViA=;
        b=nHhRZim/j3yy3MwGmq8UWXEX/SkMTzNx9vlNwhwbqkR6Ka92e9llyheJI24w31jIKc
         SYqkpttPxawB1FbZNUGjrORxn2pe+jFT66CPoWEBD560R+JBnhvVgr6GNZIF3c/aCV0I
         Ln2XEonN8SJn5lx4KPskCd5rmBmWvB0IDwv5NIdidVfibcaiQz3ZyxBEgAZcgJwyW7/1
         km2/JITUZze7o5nSqzP6qiZQIAiigs50/h+w2lVUUwZnUidiXs0m5w1+jHMcwO1Tpx1r
         0vv+KDYlIIbaTKQdlWwtR+jLjsNhO9xeUyjvQHETnYIQpeJAk4GknfcTUx7zMWwQRi3J
         wDZg==
X-Forwarded-Encrypted: i=1; AJvYcCW71nMBLXS4DrB5dmI+sggj4lwuMPb17Z6LdWhyGUequ7PN5FELQUqOzydf3Ub95J0yNbYUBXAsPl7uUCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHN47VtEmofjA8YfpKbT7xI4kVO8CVZj518QtI0n7xehz6ce3
	UWiuVLbytPYiOCy3StrqV+YTSfVmDqsdrgC/baAFADWUa1q+MMbVJy+/27mI0AfR7XriKBiODXX
	BY1dc1d+lXz/GLNVhGZ523H7rOoBWH4tiYtkO1vnjVcVinqtVXEeF/6pnVJGbKA==
X-Received: by 2002:a05:600c:1ca4:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-4317ca98076mr28482325e9.5.1729611094437;
        Tue, 22 Oct 2024 08:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBjwewfVnePxfxvVhUU23cGadMRceW2H02WpLl+xu8/c0vIb2RRhjhzDr54jH/naRPZF/ptg==
X-Received: by 2002:a05:600c:1ca4:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-4317ca98076mr28482035e9.5.1729611094013;
        Tue, 22 Oct 2024 08:31:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072? (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de. [2003:cb:c705:f700:352b:d857:b95d:9072])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4c7sm90254405e9.48.2024.10.22.08.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:31:33 -0700 (PDT)
Message-ID: <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
Date: Tue, 22 Oct 2024 17:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
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
In-Reply-To: <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.10.24 05:41, Baolin Wang wrote:
> 
> 
> On 2024/10/21 21:34, Daniel Gomez wrote:
>> On Mon Oct 21, 2024 at 10:54 AM CEST, Kirill A. Shutemov wrote:
>>> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
>>>>> On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
>>>>>> + Kirill
>>>>>>
>>>>>> On 2024/10/16 22:06, Matthew Wilcox wrote:
>>>>>>> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
>>>>>>>> Considering that tmpfs already has the 'huge=' option to control the THP
>>>>>>>> allocation, it is necessary to maintain compatibility with the 'huge='
>>>>>>>> option, as well as considering the 'deny' and 'force' option controlled
>>>>>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>>
>>>>>>> No, it's not.  No other filesystem honours these settings.  tmpfs would
>>>>>>> not have had these settings if it were written today.  It should simply
>>>>>>> ignore them, the way that NFS ignores the "intr" mount option now that
>>>>>>> we have a better solution to the original problem.
>>>>>>>
>>>>>>> To reiterate my position:
>>>>>>>
>>>>>>>      - When using tmpfs as a filesystem, it should behave like other
>>>>>>>        filesystems.
>>>>>>>      - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it should
>>>>>>>        behave like anonymous memory.
>>>>>>
>>>>>> I do agree with your point to some extent, but the ‘huge=’ option has
>>>>>> existed for nearly 8 years, and the huge orders based on write size may not
>>>>>> achieve the performance of PMD-sized THP in some scenarios, such as when the
>>>>>> write length is consistently 4K. So, I am still concerned that ignoring the
>>>>>> 'huge' option could lead to compatibility issues.
>>>>>
>>>>> Yeah, I don't think we are there yet to ignore the mount option.
>>>>
>>>> OK.
>>>>
>>>>> Maybe we need to get a new generic interface to request the semantics
>>>>> tmpfs has with huge= on per-inode level on any fs. Like a set of FADV_*
>>>>> handles to make kernel allocate PMD-size folio on any allocation or on
>>>>> allocations within i_size. I think this behaviour is useful beyond tmpfs.
>>>>>
>>>>> Then huge= implementation for tmpfs can be re-defined to set these
>>>>> per-inode FADV_ flags by default. This way we can keep tmpfs compatible
>>>>> with current deployments and less special comparing to rest of
>>>>> filesystems on kernel side.
>>>>
>>>> I did a quick search, and I didn't find any other fs that require PMD-sized
>>>> huge pages, so I am not sure if FADV_* is useful for filesystems other than
>>>> tmpfs. Please correct me if I missed something.
>>>
>>> What do you mean by "require"? THPs are always opportunistic.
>>>
>>> IIUC, we don't have a way to hint kernel to use huge pages for a file on
>>> read from backing storage. Readahead is not always the right way.
>>>
>>>>> If huge= is not set, tmpfs would behave the same way as the rest of
>>>>> filesystems.
>>>>
>>>> So if 'huge=' is not set, tmpfs write()/fallocate() can still allocate large
>>>> folios based on the write size? If yes, that means it will change the
>>>> default huge behavior for tmpfs. Because previously having 'huge=' is not
>>>> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar to what I
>>>> mentioned:
>>>> "Another possible choice is to make the huge pages allocation based on write
>>>> size as the *default* behavior for tmpfs, ..."
>>>
>>> I am more worried about breaking existing users of huge pages. So changing
>>> behaviour of users who don't specify huge is okay to me.
>>
>> I think moving tmpfs to allocate large folios opportunistically by
>> default (as it was proposed initially) doesn't necessary conflict with
>> the default behaviour (huge=never). We just need to clarify that in
>> the documentation.
>>
>> However, and IIRC, one of the requests from Hugh was to have a way to
>> disable large folios which is something other FS do not have control
>> of as of today. Ryan sent a proposal to actually control that globally
>> but I think it didn't move forward. So, what are we missing to go back
>> to implement large folios in tmpfs in the default case, as any other fs
>> leveraging large folios?
> 
> IMHO, as I discussed with Kirill, we still need maintain compatibility
> with the 'huge=' mount option. This means that if 'huge=never' is set
> for tmpfs, huge page allocation will still be prohibited (which can
> address Hugh's request?). However, if 'huge=' is not set, we can
> allocate large folios based on the write size.

I consider allocating large folios in shmem/tmpfs on the write path less 
controversial than allocating them on the page fault path -- especially 
as long as we stay within the size to-be-written.

I think in RHEL THP on shmem/tmpfs are disabled as default (e.g., 
shmem_enabled=never). Maybe because of some rather undesired 
side-effects (maybe some are historical?): I recall issues with VMs with 
THP+ memory ballooning, as we cannot reclaim pages of folios if 
splitting fails). I assume most of these problematic use cases don't use 
tmpfs as an ordinary file system (write()/read()), but mmap() the whole 
thing.

Sadly, I don't find any information about shmem/tmpfs + THP in the RHEL 
documentation; most documentation is only concerned about anon THP. 
Which makes me conclude that they are not suggested as of now.

I see more issues with allocating them on the page fault path and not 
having a way to disable it -- compared to allocating them on the write() 
path.

Getting Hugh's opinion in this would be very valuable.

-- 
Cheers,

David / dhildenb


