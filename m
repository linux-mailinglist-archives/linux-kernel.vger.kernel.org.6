Return-Path: <linux-kernel+bounces-519983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B7A3A45F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360AF3A3AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A826FA63;
	Tue, 18 Feb 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaQjf2oL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35374263F36
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899922; cv=none; b=OCIIgiNkb/dNXJn5kgOtRiug+VWUVEXEw9xrC4Bxu8kETut3GhBMZt/7672XQQuvOYKYmV1iCI0dieaqPX08bnoeUJVSu5JCSwa7P/zkUXmbMpom4KU6ntt+p1DxhldwSsCDTBhkzBoAq4UEOFMqHdXHnEFoY2iScJf/BaBCMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899922; c=relaxed/simple;
	bh=V94V+hX4hqsirUQz7oeUw3wf0C69qxMeM9OnPIoCnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byZYyLhoY1XA5o1bB1rSiIRcUTONpaCb77v6Bbvt3v4cdFfT9UVM/Hl0Ako4nPO2YfDjgXRryZ5cw/0y5JGO4laIuAzCNGIGlWZylsnbGa7YfVz7IGomB6BOABh6n1VinNL950q7Ay4rRuAnJd2Rl7b4eBQ9CqAJVPuQkoE4xuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaQjf2oL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739899920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k9xHqsqZZZLVC2Xvqig7d9EyE1//QtkdJtmVvzdVGVU=;
	b=TaQjf2oLTAvQni8vFQlc/T217nnHqYnXITL0zlwuXAB05h9fnd47cfZCCcd0qHtruDb/ZG
	KnjaCMY1aqFpWr7guEaimeMAdNzAksOYQTFb+W7Ji3xKGDpP+Gk2sJfmy5wbCrPNU77AHV
	0KGBLI31GmkUbwi9eXBqkDET9Nl4wug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-XesodWqIMOmGqzZH8ecwyw-1; Tue, 18 Feb 2025 12:31:56 -0500
X-MC-Unique: XesodWqIMOmGqzZH8ecwyw-1
X-Mimecast-MFC-AGG-ID: XesodWqIMOmGqzZH8ecwyw_1739899915
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so30203575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899915; x=1740504715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9xHqsqZZZLVC2Xvqig7d9EyE1//QtkdJtmVvzdVGVU=;
        b=DFPRIhwt96qVBXvTUKy+I7d+VQ1Cjvu+MocLHTIhr0M1UtxzEbBeBBkdI3GF49RWyU
         ObV/QqzDs3vjTqX8bUd93gQjyk6gk9b8WwogL1rEava/FezfkNN29KaZjYnzW4Vsokz2
         wjwzSnKkt9BZmeBuuUHoiwLe6wzkwv0Ot2xyhqp7WUVcuook7lGHsAN/KEd4dP4piE+S
         GuAM5ZCFR3aDHecR5TNkHoPU9YwE04bbx+n/AH/PonuNoQz4ijB4LnTGOuVUFaoWHmLj
         Nl0cFm9zT1Y2zwQ5iTdDnLXqEqN9QcPi4MoN3ji9cvHW9l5cUaowHz7oBKBSo94HIDuy
         tdGw==
X-Forwarded-Encrypted: i=1; AJvYcCXsSJQyECX1Yeq/2nxqMJ79WWo+EMLj0e4hOgezKkYcYCl4Vi4ues5nqjOpcoeDBwDu+XuoQlQL5tKG5So=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3fYBmT8Fz9Ddq1t7lMMfOxdQ3ITftTO7dbDFXhB1njbNfYrm
	5L1jLR1PpCGwwZWqU9cVCtPXukhI779qdBMZLp/LWzgSJO0MQP1zhUW/f2SseV0pqwiuS4G/LcM
	ztefskhl26vx6Ph0DlopCbipCUqpzzOzRNwP+3xMA7JFjTTa0T74yil4HJns69A==
X-Gm-Gg: ASbGncvgK5OZ3plY3DkNS2AXH2b7H3G6adEfyH4VJ9MhEurp8VJDpZ2m7n2cByUQU08
	bMAmUUR4KT5f8n0m0+Jtzm3rq4eT2S2nZEjV8TGW/r2PyRpfVBL6qTZuQ5QEzqXCKu73Jg9pfRE
	YrDYdwiyN4fOQiNpyDBylNrr3DHDfvLkEB2YJ/3Km/dDFU5Hs0cviICQqtypH7dcuAWoKJSb+WX
	sahz1vkyeUResj+RGxM8MdAqB3yh9A0sMuITRmD9DrN1L0DcPhRIJ9eeFjkksZFxQ5hdDU+GMyi
	tQprjf6y07amx4wLun9oHBbZvtGoDDCLdjKaHVkJURpl1ogWzYGoR1x4Wrobdqg0dKqAgp+Pssf
	oZdoO/pKNKEenzI1CP7IhnyN1C81Hz0TP
X-Received: by 2002:a05:600c:4688:b0:439:8ec2:a9dc with SMTP id 5b1f17b1804b1-4398ec2acb9mr61264875e9.31.1739899915588;
        Tue, 18 Feb 2025 09:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+4sIZ8F6YkIlbm3nUsGkjLl9lg6scQnHsjrcRbzy1cF83VaTT+hS4NLhKSLXXrGzpOjl0oA==
X-Received: by 2002:a05:600c:4688:b0:439:8ec2:a9dc with SMTP id 5b1f17b1804b1-4398ec2acb9mr61264435e9.31.1739899915210;
        Tue, 18 Feb 2025 09:31:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7df2sm15572642f8f.84.2025.02.18.09.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:31:54 -0800 (PST)
Message-ID: <ac7d3b7c-7b36-47d2-be59-c1b6e0fa2d38@redhat.com>
Date: Tue, 18 Feb 2025 18:31:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
 <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
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
In-Reply-To: <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> See mlock2();
>>
>> SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>> {
>> 	vm_flags_t vm_flags = VM_LOCKED;
>>
>> 	if (flags & ~MLOCK_ONFAULT)
>> 		return -EINVAL;
>>
>> 	if (flags & MLOCK_ONFAULT)
>> 		vm_flags |= VM_LOCKONFAULT;
>>
>> 	return do_mlock(start, len, vm_flags);
>> }
>>
>>
>> VM_LOCKONFAULT always as VM_LOCKED set as well.
> 
> OK cool, that makes sense.
> 
> As with much kernel stuff, I knew this in the past. Then I forgot. Then I knew
> again, then... :P if only somebody would write it down in a book...

And if there would be such a book in the makings, I would consider 
hurrying up and preordering it ;)

-- 
Cheers,

David / dhildenb


