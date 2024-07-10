Return-Path: <linux-kernel+bounces-246971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417092C979
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97709B21B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AD23776;
	Wed, 10 Jul 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sssbe07F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA88482C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584280; cv=none; b=rhbm1sVtfRxEB12jIY0d+n2bjBe9QbZliXr0B8h1ithsNDlxHk4HUZlTJZjRxiFcCtoFA0Z1IWzV94GDSdlXh1AFBUS0ad0OAk/U7fTFH6+eFTHR7JLDY/akhrNDQDiveHdMgRKFRSOH08da7FMQ3tU8qSt5JZhjS8rqTTEYLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584280; c=relaxed/simple;
	bh=drGFBqUeZ0OQaUV8OkJ+ZRoQas9J1h1gnNwX0RGakVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKnVSSNea3cSj4V3SE55C1EzAieaQtcbdB5sgp3poVK4SKwFqfYuilEcajbDUL6Lhi73ahyFyC317TVDIPr5gpsRaTrHhFlaQiKltR2RijrYLgFI75aeRwgOwpgVqJgZnTCofb1eP9V7Phat2p8bZKAYL8ei579FebMdguQCPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sssbe07F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720584277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RE7Ixx0Q34BPFkOJiQTbilowtXIyriXhevMq78qZbb0=;
	b=Sssbe07FjrMSLiL4bCoscnBc0oWdA8bW1TMYfQprIr/mjUhC6pIb8lJvwV1cLi6KX+HHzf
	9khwje5XzVCC3DX4atey7zchqX42kd5eCHfMjI1J8jm/HcKKrFXn/h19CiFDMbbCs9I+Ry
	rrpZg9tTqj+EdQyAqTcD1ZPwnPz4Q6Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-I_uDUeeTMNC-O75q2W08Dg-1; Wed, 10 Jul 2024 00:04:31 -0400
X-MC-Unique: I_uDUeeTMNC-O75q2W08Dg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7276dd142b4so301212a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 21:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584270; x=1721189070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE7Ixx0Q34BPFkOJiQTbilowtXIyriXhevMq78qZbb0=;
        b=mIK2waJ5NxUeSy3JnvRlQgeeU+Q6Uxr5OIdAnvjXrP9vCQq86EM3iSSkMjZ49+OSBF
         cxkizV5B14EijDU101Z2LlD+34O/6YtgmY3ryJ2JP0c8kshYfy1doYKU8hkgnwPRzrzj
         fMZvLBY8ZzCJnwcotwvdAUfn6u7Awl8IazXLudrCZLQLzpwul5IM0Xe9JV2UdvyZU3we
         k58xiTwY5UYkX5inpf7fLgO1CTVrGSh+emWjka93re5H44BvDiURlSTVSklyriXxLwpf
         EFI9+qSQfKeeebtAbrzgPFq/nXnzYxubZ/7eBQ4VM9pWp0aeeDHvg6P4b2GK2GH6T+4D
         CLuA==
X-Forwarded-Encrypted: i=1; AJvYcCVBN+g6hkHNQfCd7fuCItBCoDrn2Aihlp+E+dv/UWes1R5PBwaaV0fTGKoQyWrALZoS++ROqZZ6LCDWXw9hcADY3xz/ssq+/r9cyUX+
X-Gm-Message-State: AOJu0YwfrmsE+/ZMpdxn8R0BXOpVnIIGJnWVOadit+G4Ht80tVOw0jJu
	0MBnAF2MQkUQzEi8IGbnqgHyCyjgJ1En2Z4jw7TfuGyTx6QygVwaFFnJwAw2xV0O9zjyMVn+Txx
	wwgmW82HEWgU0srQJHwlse1onT2frauslbV6JeV00uNx0fO4T0W0B7LCvXisW/A==
X-Received: by 2002:a17:90b:1118:b0:2c2:4109:9466 with SMTP id 98e67ed59e1d1-2ca3a7c0d98mr5778107a91.8.1720584269993;
        Tue, 09 Jul 2024 21:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0krlCxnKAc7EE9J0n6iDLH9gCQWjxQNgwaQtlQ2TwdFonUzo8r/H5OLYOVVtLAAofsi9XBw==
X-Received: by 2002:a17:90b:1118:b0:2c2:4109:9466 with SMTP id 98e67ed59e1d1-2ca3a7c0d98mr5778084a91.8.1720584269477;
        Tue, 09 Jul 2024 21:04:29 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca353ccedasm2701287a91.57.2024.07.09.21.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 21:04:28 -0700 (PDT)
Message-ID: <9d77dc44-f61c-4e52-938f-c268daf0e169@redhat.com>
Date: Wed, 10 Jul 2024 06:04:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, justinjiang@vivo.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com, willy@infradead.org
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com>
 <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
 <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.24 06:02, Barry Song wrote:
> On Wed, Jul 10, 2024 at 3:59 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 10.07.24 05:32, Barry Song wrote:
>>> On Wed, Jul 10, 2024 at 9:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>
>>>> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>>
>>>>> The releasing process of the non-shared anonymous folio mapped solely by
>>>>> an exiting process may go through two flows: 1) the anonymous folio is
>>>>> firstly is swaped-out into swapspace and transformed into a swp_entry
>>>>> in shrink_folio_list; 2) then the swp_entry is released in the process
>>>>> exiting flow. This will result in the high cpu load of releasing a
>>>>> non-shared anonymous folio mapped solely by an exiting process.
>>>>>
>>>>> When the low system memory and the exiting process exist at the same
>>>>> time, it will be likely to happen, because the non-shared anonymous
>>>>> folio mapped solely by an exiting process may be reclaimed by
>>>>> shrink_folio_list.
>>>>>
>>>>> This patch is that shrink skips the non-shared anonymous folio solely
>>>>> mapped by an exting process and this folio is only released directly in
>>>>> the process exiting flow, which will save swap-out time and alleviate
>>>>> the load of the process exiting.
>>>>
>>>> It would be helpful to provide some before-and-after runtime
>>>> measurements, please.  It's a performance optimization so please let's
>>>> see what effect it has.
>>>
>>> Hi Andrew,
>>>
>>> This was something I was curious about too, so I created a small test program
>>> that allocates and continuously writes to 256MB of memory. Using QEMU, I set
>>> up a small machine with only 300MB of RAM to trigger kswapd.
>>>
>>> qemu-system-aarch64 -M virt,gic-version=3,mte=off -nographic \
>>>    -smp cpus=4 -cpu max \
>>>    -m 300M -kernel arch/arm64/boot/Image
>>>
>>> The test program will be randomly terminated by its subprocess to trigger
>>> the use case of this patch.
>>>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <unistd.h>
>>> #include <string.h>
>>> #include <sys/types.h>
>>> #include <sys/wait.h>
>>> #include <time.h>
>>> #include <signal.h>
>>>
>>> #define MEMORY_SIZE (256 * 1024 * 1024)
>>>
>>> unsigned char *memory;
>>>
>>> void allocate_and_write_memory()
>>> {
>>>       memory = (unsigned char *)malloc(MEMORY_SIZE);
>>>       if (memory == NULL) {
>>>           perror("malloc");
>>>           exit(EXIT_FAILURE);
>>>       }
>>>
>>>       while (1)
>>>           memset(memory, 0x11, MEMORY_SIZE);
>>> }
>>>
>>> int main()
>>> {
>>>       pid_t pid;
>>>       srand(time(NULL));
>>>
>>>       pid = fork();
>>>
>>>       if (pid < 0) {
>>>           perror("fork");
>>>           exit(EXIT_FAILURE);
>>>       }
>>>
>>>       if (pid == 0) {
>>>           int delay = (rand() % 10000) + 10000;
>>>           usleep(delay * 1000);
>>>
>>>        /* kill parent when it is busy on swapping */
>>>           kill(getppid(), SIGKILL);
>>>           _exit(0);
>>>       } else {
>>>           allocate_and_write_memory();
>>>
>>>           wait(NULL);
>>>
>>>           free(memory);
>>>       }
>>>
>>>       return 0;
>>> }
>>>
>>> I tracked the number of folios that could be redundantly
>>> swapped out by adding a simple counter as shown below:
>>>
>>> @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *folio,
>>>                       check_stable_address_space(vma->vm_mm)) &&
>>>                       folio_test_swapbacked(folio) &&
>>>                       !folio_likely_mapped_shared(folio)) {
>>> +                       static long i, size;
>>> +                       size += folio_size(folio);
>>> +                       pr_err("index: %d skipped folio:%lx total size:%d\n", i++, (unsigned long)folio, size);
>>>                           pra->referenced = -1;
>>>                           page_vma_mapped_walk_done(&pvmw);
>>>                           return false;
>>>
>>>
>>> This is what I have observed:
>>>
>>> / # /home/barry/develop/linux/skip_swap_out_test
>>> [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:65536
>>> [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:131072
>>> [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:196608
>>> [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:262144
>>> [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:327680
>>> [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:393216
>>> ...
>>> [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:97230848
>>> [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:97296384
>>> [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:97300480
>>>
>>> I observed that this patch effectively skipped 6114 folios (either 4KB or 64KB
>>> mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 bytes) during
>>> the process exit.
>>>
>>> Despite the numerous mistakes Zhiguo made in sending this patch, it is still
>>> quite valuable. Please consider pulling his v9 into the mm tree for testing.
>>
>> BTW, we dropped the folio_test_anon() check, but what about shmem? They
>> also do __folio_set_swapbacked()?
> 
> my point is that the purpose is skipping redundant swap-out, if shmem is single
> mapped, they could be also skipped.

But they won't get necessarily *freed* when unmapping them. They might 
just continue living in tmpfs? where some other process might just map 
them later?

IMHO, there is a big difference here between anon and shmem. (well, 
anon_shmem would actually be different :) )

-- 
Cheers,

David / dhildenb


