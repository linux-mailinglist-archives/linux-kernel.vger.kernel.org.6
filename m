Return-Path: <linux-kernel+bounces-237361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7BA91EFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08D71C22044
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC0F12EBE1;
	Tue,  2 Jul 2024 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFIadokw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD312DDAF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903758; cv=none; b=CdwlaPHlYTcvAUJNGry40SxRJ7GZRnI8EWcZVyUOkLhWRhDQVF684meLY0OuPgc2XpU3jIpvFmDPzqvNNGGqQQ6DsZIZc21wk12dqoT2bbX8Ck8YQ9NH5yJg3CZ0icE89GclU3VTbgjrw6kXg40mw/VNEZ9morzUzEqUlL72tFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903758; c=relaxed/simple;
	bh=pSNL1QxyyEtv5LeggAYb4QWF7tdvz+3KSh7gICTiBTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUL7Q7H/JEhqq6SZ/idPJwEH2oyDSOLuX/MP9ArWXtNnrYQMB5ADRq0/HG6OMtbKZAHZkfCLT42x+v5lgJIZxFppIzuXJ8ph1cPOMfL554G0AdlXIeWEWHA92Djp5USkJfQKkbcSzFYymmyxzc4x6hXkyf8uAgoRYKaUZIxosBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFIadokw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719903756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w6H6KldB+vAF9DWJ0/8UYNcMuFFOFyvRSKFwot9rznE=;
	b=RFIadokw7kgXgXLseCpRxA0dgkeEw460LTsqXPc5vDSVRYXEF4XiyjMsYGMsN+jGtyrU/R
	bc6WTXKl9JI/m5OPpWAis1zzvbpLLCrkQ7f9yg4+hysurHsvNRndBk0Bigb1D2r6rn5XFV
	haVjPw/oi9pYtmlK/6PseLoEW53jqpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-4HS2_hxAPCSkmfKNz_mRDg-1; Tue, 02 Jul 2024 03:02:34 -0400
X-MC-Unique: 4HS2_hxAPCSkmfKNz_mRDg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4258675a531so9144285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903753; x=1720508553;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6H6KldB+vAF9DWJ0/8UYNcMuFFOFyvRSKFwot9rznE=;
        b=UzJH+H6EWLdbmh+30pbvQM+2tkMIAmDG5RZiK0vaQvHGd99bbnNd1SpiMKZ2IHj7UZ
         49UR2U0cI2Iylr2AZXBDALptyvwNy9bvpvejsVMNUIHjc7ryut7jhgUN2dW2scSWaZ02
         A4bFPDYbBvMNaGA/ndr8rCr91sCAI/mG8smrpPJEEZQFqYKGpsJGBu8L+DF16RNB1CL1
         aomCpM/IzlH0KTJAM4P/CNrW9Kybk909w7H6BsBkIQJa0hCglS8w3LUq8oizDLdwWKPQ
         M4r9wABBP7J038dtcOkn1r+GS0NyK62iIX6KApXRSyNqsTpZRGc7U7byRPruDUXkv3Xm
         n5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXmnIA9XP8jGsn3NaA4VB3CwgZFNYGo6iOuDb9Z0btK4v5uMAGhUEUQRHqu/JQ+ORtCjIaxteA340QGICovN9yRUkGkNU9bMzD97w3j
X-Gm-Message-State: AOJu0YwaKhevFPFCiKMIw9bofI2I9Ti48R3ZufDv8Rxhn0Z0ReGi60/Z
	mhtWW9BRCIuF5VzIYpCmUrtJ6qoDgKHhcXf9F+r2TsvqGxDZkoeQql1TL6UT3D1caup2myDbLSs
	2QOOVQB5zNqLMmCfJYavPnbST0hDIDGMBpDZtsrYAgi6s6c3Mj9oSnSnFqFGTXA==
X-Received: by 2002:a05:600c:2d8c:b0:424:a66e:63ba with SMTP id 5b1f17b1804b1-4257a03484cmr44774945e9.39.1719903753458;
        Tue, 02 Jul 2024 00:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmKaCJKqX5k3VoqMG1fwsxEAMIEJnBBUXJ7aPNOeK5rTX3OxFAX94y6LWYv+rqAIv7PRezjg==
X-Received: by 2002:a05:600c:2d8c:b0:424:a66e:63ba with SMTP id 5b1f17b1804b1-4257a03484cmr44774775e9.39.1719903753053;
        Tue, 02 Jul 2024 00:02:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b063569sm186044345e9.21.2024.07.02.00.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:02:32 -0700 (PDT)
Message-ID: <69998ace-77d9-44df-8820-d584dfab7199@redhat.com>
Date: Tue, 2 Jul 2024 09:02:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] kernel/fork.c: get totalram_pages from memblock to
 calculate max_threads
To: Andrew Morton <akpm@linux-foundation.org>,
 Wei Yang <richard.weiyang@gmail.com>
Cc: brauner@kernel.org, oleg@redhat.com, mjguzik@gmail.com,
 tandersen@netflix.com, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@kernel.org>
References: <20240701013410.17260-1-richard.weiyang@gmail.com>
 <20240701212611.a0a977160c892818a7057615@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240701212611.a0a977160c892818a7057615@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 06:26, Andrew Morton wrote:
> On Mon,  1 Jul 2024 01:34:09 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
> 
>> Since we plan to move the accounting into __free_pages_core(),
>> totalram_pages may not represent the total usable pages on system
>> at this point when defer_init is enabled.
> 
> Yes, things like totalram_pages() are very old, and were a good idea at the
> time, but things moved on.
> 
>> Instead we can get the total usable pages from memblock directly.
>>
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -44,6 +44,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/mm.h>
>>   #include <linux/mm_inline.h>
>> +#include <linux/memblock.h>
>>   #include <linux/nsproxy.h>
>>   #include <linux/capability.h>
>>   #include <linux/cpu.h>
>> @@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
>>   static void set_max_threads(unsigned int max_threads_suggested)
>>   {
>>   	u64 threads;
>> -	unsigned long nr_pages = totalram_pages();
>> +	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
> 
> The result of this subtraction has meaning.  Even if it is only used
> once, I suspect it should be in a standalone function which has
> documentation which describes that meaning.  Having fork.c make an
> open-coded poke into memblock internals seems wrong, no?

I was just about the comment the same thing:

I'm starting to wonder if we should have a helper like

memblock_estimated_nr_pages()

or sth like that that abstracts this?

-- 
Cheers,

David / dhildenb


