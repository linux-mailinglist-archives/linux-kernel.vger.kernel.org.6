Return-Path: <linux-kernel+bounces-246969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD092C975
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEAD1F236EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078041C92;
	Wed, 10 Jul 2024 03:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPu3jHNx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA739FCE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583949; cv=none; b=CY/7gBUHZ2aBB3KMRBLjXgI1c19F5eCZqnpMijZYWYC01f0W71kYrRsQI/RtX40pZW3Bz3TY/sY2ZkKkHQKXQMmNvaWUmuiWqUkE3G2Sz4wfcui5y0t66IsDYDUGo1VO8VndRG2UNHZSUaphRxd8NNfxxCBbS9VOIzR4z/y6D14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583949; c=relaxed/simple;
	bh=jUZfmj9pRcbqF/5ikMGlIL6YKYLO7099pE/9CuVZUcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEFFb1vMcEgnQTVS25cxVwIIhL8SBlFadaS8c4UmSEAMfMLeE1Jzgp9GuDfZPdGKlzJu/14tE++zgELkVVuv0kmr9o2AEmq4pqqOP77vfVw4tMfuQbsfvl1KUYimHZ5yYDl1fhEtkeO6sFBEzKRX+oWes4FHhy2Om+K8yZPHne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPu3jHNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720583946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FCBqlDgl9VHTYnkicX0so35tgtDveFPDPkAWHQYmf/0=;
	b=fPu3jHNx/Bd0tN9w5Eylw6chcOxuMxBv4XkXQ9jLTAhClToZLXrRaFn7Sfbx7vZOpePYWv
	oHujIVXt5Z1w2+pSnUFYra0r3BLFT6ZCFyUdraiVsps+sK8DYm6Ke5NPamwrMVe+N0dkiC
	nkVp+y5eGHQIYO1ro+MHji1BPP00Nog=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-bu84jQYMPC2UcvNve9z5ow-1; Tue, 09 Jul 2024 23:59:04 -0400
X-MC-Unique: bu84jQYMPC2UcvNve9z5ow-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70af6961edfso4073693b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583943; x=1721188743;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCBqlDgl9VHTYnkicX0so35tgtDveFPDPkAWHQYmf/0=;
        b=XlWg6Qw+MR9Nhy7A0Tuzq5FicQHz9n+B6iP99dg1otKtN1rHUFLYcjYJ9BBtOBw8RQ
         +QOt9hGt4cJyNH6wGBzH9NZQ4wQlNoOSfokphmU+ySwVTQk0xSybP3bbaC+jVsN/53up
         LV9rxkqwQ4PPpefTtlYgLYqllAA7fHmGEVAb5m5yaqBI/nUUR3MaItnumIqfdrDET6WW
         MQquncOSZN3DDWoNzv2wLZuq8GEUCuXJN61+M9C7RIXP5ar1PsuM0ogZC6aG1ADB32Dn
         i5l/KVLZ5okW2f+gb4+00kbN9U9GG9Px6d9fogVzXFArI6RGP6SkG9cmv31P1hmbiBi6
         l0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVg68X5EpDbO+0tfTj4yrs1ARrqhO3kOod/xxCsL/ZECMYSnwDsH0BRs1vrIDt97Pr/sP3NU3FYD88S5kpryU15G/0d3SYK5n2c8KrD
X-Gm-Message-State: AOJu0YwehhotTOaHZ0+2tYAyiLJgPf/y1EdMj0hgsXEFR5tLbbZjQKf6
	3rzotI2e2ds3rPqgYrLMssfi8Yc6EIzjhGLBwggGHAHqx/NWh3ZtuhbzsOGAFuVA/iUMyeUzuGf
	sTWAzbm3dyBynsC9UKuouHgCt/7kTpLn/xh9ikluQRTvHjLk5Px99+xpAPxxY3g==
X-Received: by 2002:a05:6a21:918c:b0:1c0:defa:b68e with SMTP id adf61e73a8af0-1c2984ce0e7mr3689441637.39.1720583943530;
        Tue, 09 Jul 2024 20:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+WmChsw2kMnNV1Fky99vcI5Yo/GR8BmnMknPXKAx8NTttsHGVF2RDldwVYCl/YoQDSwl/ZQ==
X-Received: by 2002:a05:6a21:918c:b0:1c0:defa:b68e with SMTP id adf61e73a8af0-1c2984ce0e7mr3689435637.39.1720583943109;
        Tue, 09 Jul 2024 20:59:03 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac0841sm23425215ad.211.2024.07.09.20.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 20:59:02 -0700 (PDT)
Message-ID: <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
Date: Wed, 10 Jul 2024 05:59:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org
Cc: baohua@kernel.org, justinjiang@vivo.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com, willy@infradead.org
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240710033212.36497-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.24 05:32, Barry Song wrote:
> On Wed, Jul 10, 2024 at 9:23 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>
>>> The releasing process of the non-shared anonymous folio mapped solely by
>>> an exiting process may go through two flows: 1) the anonymous folio is
>>> firstly is swaped-out into swapspace and transformed into a swp_entry
>>> in shrink_folio_list; 2) then the swp_entry is released in the process
>>> exiting flow. This will result in the high cpu load of releasing a
>>> non-shared anonymous folio mapped solely by an exiting process.
>>>
>>> When the low system memory and the exiting process exist at the same
>>> time, it will be likely to happen, because the non-shared anonymous
>>> folio mapped solely by an exiting process may be reclaimed by
>>> shrink_folio_list.
>>>
>>> This patch is that shrink skips the non-shared anonymous folio solely
>>> mapped by an exting process and this folio is only released directly in
>>> the process exiting flow, which will save swap-out time and alleviate
>>> the load of the process exiting.
>>
>> It would be helpful to provide some before-and-after runtime
>> measurements, please.  It's a performance optimization so please let's
>> see what effect it has.
> 
> Hi Andrew,
> 
> This was something I was curious about too, so I created a small test program
> that allocates and continuously writes to 256MB of memory. Using QEMU, I set
> up a small machine with only 300MB of RAM to trigger kswapd.
> 
> qemu-system-aarch64 -M virt,gic-version=3,mte=off -nographic \
>   -smp cpus=4 -cpu max \
>   -m 300M -kernel arch/arm64/boot/Image
>   
> The test program will be randomly terminated by its subprocess to trigger
> the use case of this patch.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <signal.h>
> 
> #define MEMORY_SIZE (256 * 1024 * 1024)
> 
> unsigned char *memory;
> 
> void allocate_and_write_memory()
> {
>      memory = (unsigned char *)malloc(MEMORY_SIZE);
>      if (memory == NULL) {
>          perror("malloc");
>          exit(EXIT_FAILURE);
>      }
> 
>      while (1)
>          memset(memory, 0x11, MEMORY_SIZE);
> }
> 
> int main()
> {
>      pid_t pid;
>      srand(time(NULL));
> 
>      pid = fork();
> 
>      if (pid < 0) {
>          perror("fork");
>          exit(EXIT_FAILURE);
>      }
> 
>      if (pid == 0) {
>          int delay = (rand() % 10000) + 10000;
>          usleep(delay * 1000);
> 
> 	/* kill parent when it is busy on swapping */
>          kill(getppid(), SIGKILL);
>          _exit(0);
>      } else {
>          allocate_and_write_memory();
> 
>          wait(NULL);
> 
>          free(memory);
>      }
> 
>      return 0;
> }
> 
> I tracked the number of folios that could be redundantly
> swapped out by adding a simple counter as shown below:
> 
> @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *folio,
>                      check_stable_address_space(vma->vm_mm)) &&
>                      folio_test_swapbacked(folio) &&
>                      !folio_likely_mapped_shared(folio)) {
> +                       static long i, size;
> +                       size += folio_size(folio);
> +                       pr_err("index: %d skipped folio:%lx total size:%d\n", i++, (unsigned long)folio, size);
>                          pra->referenced = -1;
>                          page_vma_mapped_walk_done(&pvmw);
>                          return false;
> 
> 
> This is what I have observed:
> 
> / # /home/barry/develop/linux/skip_swap_out_test
> [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:65536
> [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:131072
> [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:196608
> [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:262144
> [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:327680
> [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:393216
> ...
> [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:97230848
> [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:97296384
> [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:97300480
> 
> I observed that this patch effectively skipped 6114 folios (either 4KB or 64KB
> mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 bytes) during
> the process exit.
> 
> Despite the numerous mistakes Zhiguo made in sending this patch, it is still
> quite valuable. Please consider pulling his v9 into the mm tree for testing.

BTW, we dropped the folio_test_anon() check, but what about shmem? They 
also do __folio_set_swapbacked()?

-- 
Cheers,

David / dhildenb


