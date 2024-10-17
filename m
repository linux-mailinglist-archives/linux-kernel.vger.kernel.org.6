Return-Path: <linux-kernel+bounces-369463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242579A1D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E8B21AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159D1D3185;
	Thu, 17 Oct 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJVwJwQv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051D154454
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155243; cv=none; b=eVjhNwSW8uV8YoC1scV5x4Vxdc3pFUo/PuT72Q/8NOBkKDQ00agl3JH9nh2lb0bKZGQGCAgjktEfJK5qfKc9cpNMUUuAt9niOIb0DRKLmnRTVsKePDdU/gL1EPf+kSaoPuGzpUCP2kRPyIKV5ZAdNLIEnXR3niVP1xuLTLHHN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155243; c=relaxed/simple;
	bh=MVHtnlUWiueQAghNzxxjZf5Gxr1uysJuOix5xjnQHXQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RlmBmADeolaoXQaLpFpqvQBusUqxMRu0yv81g8vFUlkCvPHOQjF6rX42nuizwnIZZGO+ZARF3VEMFjR4Z2eNLwyGJ8TXf0Fctz1VhlVXpA1o3xpX6SNyis0P82jUP+zKMRcIewvKbGbB4tPvAqm2EFz63a8sPt8lrmp/HDndPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJVwJwQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729155239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RhHvad1LxaNZJ3rIkHXtXZ9pysxt/xOSqmMs4CSuxbU=;
	b=DJVwJwQvFRPDoMx1ZUkY/6YNhxVt4G08/BA21KyUl8fxyhH/Kt1tPt5X4ua1xwdfPIm4Ph
	aX9bVqPCHMN9Dx/h9V+9qjorYZNIZYqa482Tf3alpbLMi6Hf8FyQGxGdb+mDt2+bJYYROU
	b/uDU/UeFfzTgF5iH/jJwUhIFGyLvPI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-hmUPQOxNNxuhRhm5ytwnbQ-1; Thu, 17 Oct 2024 04:53:57 -0400
X-MC-Unique: hmUPQOxNNxuhRhm5ytwnbQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d537292d7so449749f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155236; x=1729760036;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RhHvad1LxaNZJ3rIkHXtXZ9pysxt/xOSqmMs4CSuxbU=;
        b=KZfbb5aNvQtLOsbS+QaseMAjrVHAFD4uej//I/xiIkRsW3WF5sMNzeHOo4KAkaD0Mm
         hP4rQkqZ7+7cSF/dIkB2PUciDAw2UZwqCIsAsETOAFAgIGpAsFsJ6DhSKYGDWvnG3ZjL
         xNU9ATHV18+7rWdpN5q7FC6wNiOSsiD0/AHmJBzCejoGSceV1kNCBgz45WAopjAAKBzR
         mluHu/iTtPZPQRPM6myF+csG0xyL1tYKWcZEaj1ZK4OQcFlJ2qcLZiiPv/imrYC5h1bw
         KlVKTmW+y4vBggT859zNQRoNE9vy9Xv2UO7u/bCPD+G5IrJ+PA4k28bvWrswcJ/OF1dS
         mY8A==
X-Gm-Message-State: AOJu0YzBgGLoWmA5LeY/zaaAFlZwmGqqjFskkV/QQsmm11MEgCzvT1sg
	Jkktc0U+XZYmMBPj5MT1rAONS3BrjMWxzoXgTGdyMGKIC1T+V1TKHWlMVIBkXkCNhPBRSZfmF7H
	ZJGEoS3awOvplp+qekJhweVZDTJPR93NQlfl367/qRCifd3Vmgyad0g7hVdIrHA==
X-Received: by 2002:a5d:448e:0:b0:37c:d1fb:82f4 with SMTP id ffacd0b85a97d-37d600d2fe3mr16330274f8f.36.1729155236163;
        Thu, 17 Oct 2024 01:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvHn0Vofr0WyvBEJ1HbH94rbq4bVzIkK3s886iKqHFHVP5aW+CDmGv8c5YWjjkE0+qmegO7A==
X-Received: by 2002:a5d:448e:0:b0:37c:d1fb:82f4 with SMTP id ffacd0b85a97d-37d600d2fe3mr16330255f8f.36.1729155235749;
        Thu, 17 Oct 2024 01:53:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87b5dsm6554293f8f.40.2024.10.17.01.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:53:55 -0700 (PDT)
Message-ID: <9a2232d6-74c4-426f-bfab-668c5c5ad143@redhat.com>
Date: Thu, 17 Oct 2024 10:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
From: David Hildenbrand <david@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.24 10:51, David Hildenbrand wrote:
> On 16.10.24 22:22, John Hubbard wrote:
>> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
>> family of functions, and requests "too many" pages, then the call will
>> erroneously leave pages pinned. This is visible in user space as an
>> actual memory leak.
>>
>> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
>> to exhaust memory.
>>
>> The root cause of the problem is this sequence, within
>> __gup_longterm_locked():
>>
>>       __get_user_pages_locked()
>>       rc = check_and_migrate_movable_pages()
>>
>> ...which gets retried in a loop. The loop error handling is incomplete,
>> clearly due to a somewhat unusual and complicated tri-state error API.
>> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
>> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
>> happily returns the error, while leaving the pages pinned.
>>
>> In the failed case, which is an app that requests (via a device driver)
>> 30720000000 bytes to be pinned, and then exits, I see this:
>>
>>       $ grep foll /proc/vmstat
>>           nr_foll_pin_acquired 7502048
>>           nr_foll_pin_released 2048
>>
>> And after applying this patch, it returns to balanced pins:
>>
>>       $ grep foll /proc/vmstat
>>           nr_foll_pin_acquired 7502048
>>           nr_foll_pin_released 7502048
>>
>> Fix this by unpinning the pages that __get_user_pages_locked() has
>> pinned, in such error cases.
>>
>> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Shigeru Yoshida <syoshida@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>    mm/gup.c | 11 +++++++++++
>>    1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a82890b46a36..24acf53c8294 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>    
>>    		/* FOLL_LONGTERM implies FOLL_PIN */
>>    		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
>> +
>> +		/*
>> +		 * The __get_user_pages_locked() call happens before we know
>> +		 * that whether it's possible to successfully complete the whole
>> +		 * operation. To compensate for this, if we get an unexpected
>> +		 * error (such as -ENOMEM) then we must unpin everything, before
>> +		 * erroring out.
>> +		 */
>> +		if (rc != -EAGAIN && rc != 0)
>> +			unpin_user_pages(pages, nr_pinned_pages);
>> +
>>    	} while (rc == -EAGAIN);
> 
> Wouldn't it be cleaner to simply have here after the loop (possibly even
> after the memalloc_pin_restore())
> 
> if (rc)
> 	unpin_user_pages(pages, nr_pinned_pages);
> 
> But maybe I am missing something.

And staring at memfd_pin_folios(), don't we have the same issue there if
check_and_migrate_movable_folios() fails?


diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..f79974d38608 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3708,12 +3708,10 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
                 ret = check_and_migrate_movable_folios(nr_folios, folios);
         } while (ret == -EAGAIN);
  
-       memalloc_pin_restore(flags);
-       return ret ? ret : nr_folios;
  err:
         memalloc_pin_restore(flags);
-       unpin_folios(folios, nr_folios);
-
-       return ret;
+       if (ret)
+               unpin_folios(folios, nr_folios);
+       return ret ? ret : nr_folios;
  }
  EXPORT_SYMBOL_GPL(memfd_pin_folios);


-- 
Cheers,

David / dhildenb


