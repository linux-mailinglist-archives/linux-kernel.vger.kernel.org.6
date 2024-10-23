Return-Path: <linux-kernel+bounces-377763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478169AC664
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716C8B23669
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92BC199384;
	Wed, 23 Oct 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Haf5lojF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CC145323
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675639; cv=none; b=kY3GVHACmIl74GQqrfqPkfJc2c84/0bmQsuK2f7X40DEii2B7Tn9qmdEhrZGKMr5WCBpUmGMdFQXNWzvma6jlCjkCLv7wz+Qznbdvj5/GiVgeM87SyaTIewNoZssgCyLMRKUzUFUas4wez0XVKByppwKCTKvVpFT1LmdDS2BBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675639; c=relaxed/simple;
	bh=nZN3XLep18LTbYLIPkntcRYi1ZlE0oGebeg42o2kJbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8RYp4MBnz4QuOoAgg9jHlWnetsZs4YTkE8vSGDMKzXM1uDlWz9dw21IMl6DE0Q8rQRKjKWSvBVK1wiW9/cLgkL0THGHjeLBVaeKYyiSz0HqpTinXxGC1+YUh626sMMq9V/NmZfP6ifc4ZzaCMOrfjGBLxHfFc0xx0pUfJkWCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Haf5lojF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729675635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hp7NN43drKxOcUqs3YKHkX22H+SxnLe9eJ1yDYlWCYg=;
	b=Haf5lojFPB6ktZJQSsPlWeIeDaK/CYGC+PWgj/iBbLa364I5gfngJc5YfRmrklgJbewXQG
	3baj03+eBeIKipIjUvsouWZfMzz0hweDhtYolaDLOkOp/0QnJJhfEK5SwBKAbHouz+5RuC
	FIMNd531WStLJZgIuucWZ34tAJ61B9Y=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669--Z-aVRYeO8qLM9F2Z4gaRQ-1; Wed, 23 Oct 2024 05:27:14 -0400
X-MC-Unique: -Z-aVRYeO8qLM9F2Z4gaRQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ec1a590fso5230750e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675633; x=1730280433;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hp7NN43drKxOcUqs3YKHkX22H+SxnLe9eJ1yDYlWCYg=;
        b=iD+cP0pg8OIlYWcFd9J2Ker8lXggNEa0JRKnsNRZGEds086KhQps56+F2fYrz4T7/a
         dpuhvIyUO59P0b9gJYhWB3XGJ2sHDjrZ4zSS2Of8njb8rbvHnjB4qON/SakYWdTyLfhu
         4BE3EPpfS0vgk1WVh7hYGaq/3cVsFvn1En0r4kwymkUp+2Nji1xZxFdsL9uCxm6eqksv
         mOsuveuMCauiWK6tMHgC7sVLTojbk8kS4XBan8NvAQmd6CZM8WxBYMcCeQcdmfNz1GMo
         ohh50NFw3l4GwBetZwBJWEl8Mv1M8RtlTsH8Xpr5s4f3pUdRtk8evJXslyhcvfeyoBAl
         38vg==
X-Forwarded-Encrypted: i=1; AJvYcCVL3v23UiFcUDUqSXEdd9MVegbWt0+429P7XY9RhPAalCAa3/M6dG4vGqhjbL7z1CviNA22wVM34rqzuq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiYLZbP001yjQjGymJyPk4qk92dZ8oQKg+MSCpJZ8LwAVWr49
	4UIUNVlSZJuMmB0re4Gn+ZBByRhDscXLEM7MLmfLx+AlgszlqmWG2GHmyW/i40FOQj8d35pLAwR
	RWa8KAKHNpDhXp5fH0vztOp9hFZbkqZr6fsqDcxvVlyIlMinVM2NSvYipCP1+uA==
X-Received: by 2002:a05:6512:6c8:b0:539:f696:777c with SMTP id 2adb3069b0e04-53b1a354760mr895894e87.29.1729675632558;
        Wed, 23 Oct 2024 02:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmoTrugrJphaUs5POzDA5rMtIJRFKg66Kun8XTJWOLCMIfb6u0howTpzCf5owuoIKYBz66fQ==
X-Received: by 2002:a05:6512:6c8:b0:539:f696:777c with SMTP id 2adb3069b0e04-53b1a354760mr895869e87.29.1729675632040;
        Wed, 23 Oct 2024 02:27:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd69ebsm11057965e9.1.2024.10.23.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:27:11 -0700 (PDT)
Message-ID: <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
Date: Wed, 23 Oct 2024 11:27:10 +0200
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
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.10.24 10:04, Baolin Wang wrote:
> 
> 
> On 2024/10/22 23:31, David Hildenbrand wrote:
>> On 22.10.24 05:41, Baolin Wang wrote:
>>>
>>>
>>> On 2024/10/21 21:34, Daniel Gomez wrote:
>>>> On Mon Oct 21, 2024 at 10:54 AM CEST, Kirill A. Shutemov wrote:
>>>>> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
>>>>>>> On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
>>>>>>>> + Kirill
>>>>>>>>
>>>>>>>> On 2024/10/16 22:06, Matthew Wilcox wrote:
>>>>>>>>> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
>>>>>>>>>> Considering that tmpfs already has the 'huge=' option to
>>>>>>>>>> control the THP
>>>>>>>>>> allocation, it is necessary to maintain compatibility with the
>>>>>>>>>> 'huge='
>>>>>>>>>> option, as well as considering the 'deny' and 'force' option
>>>>>>>>>> controlled
>>>>>>>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>>>>
>>>>>>>>> No, it's not.  No other filesystem honours these settings.
>>>>>>>>> tmpfs would
>>>>>>>>> not have had these settings if it were written today.  It should
>>>>>>>>> simply
>>>>>>>>> ignore them, the way that NFS ignores the "intr" mount option
>>>>>>>>> now that
>>>>>>>>> we have a better solution to the original problem.
>>>>>>>>>
>>>>>>>>> To reiterate my position:
>>>>>>>>>
>>>>>>>>>       - When using tmpfs as a filesystem, it should behave like
>>>>>>>>> other
>>>>>>>>>         filesystems.
>>>>>>>>>       - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED,
>>>>>>>>> it should
>>>>>>>>>         behave like anonymous memory.
>>>>>>>>
>>>>>>>> I do agree with your point to some extent, but the ‘huge=’ option
>>>>>>>> has
>>>>>>>> existed for nearly 8 years, and the huge orders based on write
>>>>>>>> size may not
>>>>>>>> achieve the performance of PMD-sized THP in some scenarios, such
>>>>>>>> as when the
>>>>>>>> write length is consistently 4K. So, I am still concerned that
>>>>>>>> ignoring the
>>>>>>>> 'huge' option could lead to compatibility issues.
>>>>>>>
>>>>>>> Yeah, I don't think we are there yet to ignore the mount option.
>>>>>>
>>>>>> OK.
>>>>>>
>>>>>>> Maybe we need to get a new generic interface to request the semantics
>>>>>>> tmpfs has with huge= on per-inode level on any fs. Like a set of
>>>>>>> FADV_*
>>>>>>> handles to make kernel allocate PMD-size folio on any allocation
>>>>>>> or on
>>>>>>> allocations within i_size. I think this behaviour is useful beyond
>>>>>>> tmpfs.
>>>>>>>
>>>>>>> Then huge= implementation for tmpfs can be re-defined to set these
>>>>>>> per-inode FADV_ flags by default. This way we can keep tmpfs
>>>>>>> compatible
>>>>>>> with current deployments and less special comparing to rest of
>>>>>>> filesystems on kernel side.
>>>>>>
>>>>>> I did a quick search, and I didn't find any other fs that require
>>>>>> PMD-sized
>>>>>> huge pages, so I am not sure if FADV_* is useful for filesystems
>>>>>> other than
>>>>>> tmpfs. Please correct me if I missed something.
>>>>>
>>>>> What do you mean by "require"? THPs are always opportunistic.
>>>>>
>>>>> IIUC, we don't have a way to hint kernel to use huge pages for a
>>>>> file on
>>>>> read from backing storage. Readahead is not always the right way.
>>>>>
>>>>>>> If huge= is not set, tmpfs would behave the same way as the rest of
>>>>>>> filesystems.
>>>>>>
>>>>>> So if 'huge=' is not set, tmpfs write()/fallocate() can still
>>>>>> allocate large
>>>>>> folios based on the write size? If yes, that means it will change the
>>>>>> default huge behavior for tmpfs. Because previously having 'huge='
>>>>>> is not
>>>>>> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar
>>>>>> to what I
>>>>>> mentioned:
>>>>>> "Another possible choice is to make the huge pages allocation based
>>>>>> on write
>>>>>> size as the *default* behavior for tmpfs, ..."
>>>>>
>>>>> I am more worried about breaking existing users of huge pages. So
>>>>> changing
>>>>> behaviour of users who don't specify huge is okay to me.
>>>>
>>>> I think moving tmpfs to allocate large folios opportunistically by
>>>> default (as it was proposed initially) doesn't necessary conflict with
>>>> the default behaviour (huge=never). We just need to clarify that in
>>>> the documentation.
>>>>
>>>> However, and IIRC, one of the requests from Hugh was to have a way to
>>>> disable large folios which is something other FS do not have control
>>>> of as of today. Ryan sent a proposal to actually control that globally
>>>> but I think it didn't move forward. So, what are we missing to go back
>>>> to implement large folios in tmpfs in the default case, as any other fs
>>>> leveraging large folios?
>>>
>>> IMHO, as I discussed with Kirill, we still need maintain compatibility
>>> with the 'huge=' mount option. This means that if 'huge=never' is set
>>> for tmpfs, huge page allocation will still be prohibited (which can
>>> address Hugh's request?). However, if 'huge=' is not set, we can
>>> allocate large folios based on the write size.
>>
>> I consider allocating large folios in shmem/tmpfs on the write path less
>> controversial than allocating them on the page fault path -- especially
>> as long as we stay within the size to-be-written.
>>
>> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g.,
>> shmem_enabled=never). Maybe because of some rather undesired
>> side-effects (maybe some are historical?): I recall issues with VMs with
>> THP+ memory ballooning, as we cannot reclaim pages of folios if
>> splitting fails). I assume most of these problematic use cases don't use
>> tmpfs as an ordinary file system (write()/read()), but mmap() the whole
>> thing.
>>
>> Sadly, I don't find any information about shmem/tmpfs + THP in the RHEL
>> documentation; most documentation is only concerned about anon THP.
>> Which makes me conclude that they are not suggested as of now.
>>
>> I see more issues with allocating them on the page fault path and not
>> having a way to disable it -- compared to allocating them on the write()
>> path.
> 
> I may not understand your issues. IIUC, you can disable allocating huge
> pages on the page fault path by using the 'huge=never' mount option or
> setting shmem_enabled=deny. No?

That's what I am saying: if there is some way to disable it that will 
keep working, great.

-- 
Cheers,

David / dhildenb


