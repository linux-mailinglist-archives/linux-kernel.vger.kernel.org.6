Return-Path: <linux-kernel+bounces-360881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA999A0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0861C21FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F58210C06;
	Fri, 11 Oct 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIuL0WjC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72721018F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641517; cv=none; b=IYBxqniwEQyaVaR9JNwdryC4hWmoD1CDOPBEiJNKB4aP+hOhkahzR8lE5mLB4w2oE28zjKNIR18+JLXFAEcI0SMQw9U8ETOaJZQxf2Iqk24X1jsqsrasJBigNXmotvODKuJTbYPqB9MjAk5mz3M9UA30hYwHIw4GT9vpbKIhPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641517; c=relaxed/simple;
	bh=ApeBFa8rx0MOT6HYf0CcdIfIMWA5PuroE3Fplj4otrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNd6AvNrn8FIBHRumHZjUUSvpbVUcScNRjHgloMRvFfTGiSv8vAe13SY4CYyvVclC799AcQrMqZJpusAwWFfXiGlsZWCvoQ3FInKD37vVtGNvgMLF+/8nrWDkuzTXwKFByomfuoO7hYEVD63Wb2dBs9hiavgSzkXnJmKhsSAUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIuL0WjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728641514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T/9Bd+JTmvXU+t1kkqAUzIT464JgdmkUmKNMVlFbH7Q=;
	b=JIuL0WjCHcArrq8g2u+jDtqHrK5oysy6einpSR8NnaKQqd63olvlN1wTV7OtgZaEWpNyN8
	JrrPBodffl3djjH7z2hWVRVhVPVhdD+3vzR6AeC6/U0+M41ebDXA1NE+IjmChB2VS5+/Tv
	ugdz3B1zdfmyPWqQm51vVXCP/0gVngs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Kv3Pzg3fOS-AtLGJj5NM1w-1; Fri, 11 Oct 2024 06:11:53 -0400
X-MC-Unique: Kv3Pzg3fOS-AtLGJj5NM1w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42f8ceb8783so13300765e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641512; x=1729246312;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/9Bd+JTmvXU+t1kkqAUzIT464JgdmkUmKNMVlFbH7Q=;
        b=TuspwLOuH0HT3rCO3o75PEPwIv4b3D33hspoOrEhN6qjPf32U6TVBfONgMQzszJA61
         AH4mG/vx0uiXBSelGl88xXkWGQk7Flwxitro3Dm2fWKBZszpdxzT9ZFgJ8cth7QvR82e
         4OaPuKGY99f1UweeYa7OK318hu7hWhz16SGaJh7moBC1uMBzBGQZp0H+3Zn0ls2McLlW
         8ibEk0GIFtEeM75iOM25zZ7QMXXE9YH05M7T2q2s+tgCkZaSQBDfIDNLMY7atiTbiV8R
         kr/h9//Eb6ZOmMQ/ddcqPVWCBg+EJyq9OjSSCmieidGy54QUFj0rV2a2nWYmPB4EFQ2r
         PGkg==
X-Forwarded-Encrypted: i=1; AJvYcCUpvw+pC/81+UqLto1gJGr9zHXUBWv3OJlGZhq9tw7aqiBfuGpTT84DV5frvDxdDFQFFOZrI0gFbT9kzhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzYoTw/DfVUYCvVsk9/BiPTsRRQ+NxkGsilqnF4mxDZ3hx6a4
	Mfs+7L7bnGzTeNRc/x+otkzteSWBKDdTI3KvsTHS+jSF7bYAgE1UQrMWWZ1+H9U0qgTDoeGPDEg
	g59UO3BdO/4T/8F5Wb80brvlsyPuAR3uFqlnp9LTMhi6zFL8d5yXh9oHZmiEqzw==
X-Received: by 2002:a05:600c:1911:b0:42c:cd7c:a196 with SMTP id 5b1f17b1804b1-4311deebdd6mr18876085e9.17.1728641512348;
        Fri, 11 Oct 2024 03:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnvaatSzEirG3sFA16OzDmEUSXnaQ1B+rG29Do2CjTp8164vOjb4C2e+oqhz0K8LoxenTHCw==
X-Received: by 2002:a05:600c:1911:b0:42c:cd7c:a196 with SMTP id 5b1f17b1804b1-4311deebdd6mr18875805e9.17.1728641511882;
        Fri, 11 Oct 2024 03:11:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b? (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de. [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6ce001sm3549032f8f.47.2024.10.11.03.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:11:51 -0700 (PDT)
Message-ID: <bc1358e8-438a-4385-8bde-8e6a785f6eeb@redhat.com>
Date: Fri, 11 Oct 2024 12:11:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] linux-next test error: kernel BUG in
 folio_add_new_anon_rmap
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+619c487ed60780dab217@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-next@vger.kernel.org, sfr@canb.auug.org.au,
 syzkaller-bugs@googlegroups.com
References: <6704d667.050a0220.1e4d62.0082.GAE@google.com>
 <5e42fd02-1470-4e4e-892b-edefd32fbc5a@redhat.com>
 <CANp29Y5VG=yj1yFgQ+Co_1E+On_F8147s727ynKyuJXoaRQG3w@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <CANp29Y5VG=yj1yFgQ+Co_1E+On_F8147s727ynKyuJXoaRQG3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.10.24 12:05, Aleksandr Nogikh wrote:
> Hi David,
> 
> On Tue, Oct 8, 2024 at 3:11 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.10.24 08:51, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
> < ... >
>>>
>>
>> #syz fix: mm-add-pageanonnotksm-fix
> 
> Just curious: this is not the commit title that will be preserved when
> the commit reaches the torvalds tree, right?

No, the fixup patch is currently in mm-unstable and will be squashed 
into the responsible commit once Andrew moves it to mm-stable. So 
neither commit ID nor subject are final.

> 
> Syzbot uses commit titles to track which fuzzed kernel trees have
> received each bug fix, so in this case the bot will become very
> confused. If the final title is known, it's better to use that in the
> syz fix command.

That's unfortunate, but that's the way linux-next works :/

-- 
Cheers,

David / dhildenb


