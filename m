Return-Path: <linux-kernel+bounces-203769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282988FE044
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5E61F26AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034B13B598;
	Thu,  6 Jun 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cK5IsBIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF829CE7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660604; cv=none; b=V0qo8JF9COu+aetjjbljt+Cxovg1tEjdqPtf29bK7Wfmig7ufRZ8s7qqvzIBztskxm9QU/IFlr9E8AJMRjGz0CvmivLSEheGNM+c4nEZjat1lTgpy2HouCAvTROAuYD7cnrvf7x6e3jSMYbhV0poIa4scCtxfHuSba+XyFABPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660604; c=relaxed/simple;
	bh=dV3kwawE/kfLJB+LYdxL1FWQU0MFeBUHH8U/xvmZmUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3jVUZPlWf9a+Z5vr4xbbfbXAer0O174EtOXy+fD+GYpGBWdBqX4n8yqO+CUonQJll40e5CewBAC5EUxaA1UmLf+0rlJMsRHsIJ6GXf7+7nLgUw3+Qr28/yqsg2Z2j9IBbw8Pf0+eOxgOeTaMOYt56kCEJY27QQMc1ECiRhesH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cK5IsBIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717660601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rxuGaMa3iEou3xAKxypqJ8B8Fj8/s+85QxHLocgvst0=;
	b=cK5IsBITNwVC0iq2ayAzgJ7wo0+yhxMqJ23O6guiPnXr96WGjk9LmDLXYohMzac1Mw3SCn
	hrfkKFNr8AeDmoyBVvBTfDNOFN6n1NlRfj+qg/9lXy0a6nbp8dScbauFJj85tB1adcCGBT
	NarabG9wCBxRavfsIDRYUs8BSXEA0BA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-yHJGu_WaOtCMXYyCJXGKvw-1; Thu, 06 Jun 2024 03:56:38 -0400
X-MC-Unique: yHJGu_WaOtCMXYyCJXGKvw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42108822a8eso9025795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660597; x=1718265397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxuGaMa3iEou3xAKxypqJ8B8Fj8/s+85QxHLocgvst0=;
        b=v4fgfJ45a18BOifTxPRMtvFR5IIveh38Gzzy+QSYztsxMH3xFfBQQ5o/Bpj1ZcON6d
         3Znb5bVB6KalEYfw6ls8WizuorqXf7YyGoIHW60UvuMw1OrzN4XXlKw9GSGNlb6wFbKU
         N5aZMoOJFDcp7Stcd/947QoSziabNsvaXyhxxwePJHhY1btP0IjwjcyN0dPvsG2R1kv1
         lORFXhqAOzueLcIcS3F0x+gJH6lTqesiEmJosBvmu5JDtGI/oSNbH8dIaY3FzK6jhSgY
         rJbtB96XVk9cltVmmPNCGjKXjVDIAAyA7u6NbmGNWrarvSw+J+aUumAh8PcXgWo3P3ko
         eMkw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ni7UW9WmUPfpa6s0p7jKflljZJghOxwGy7Y8KaEvCE5bPK7USqLxi/aDV7B8MGPIz18cR2brjv04vS+yubHqkwjnkVx1Nn+x7m36
X-Gm-Message-State: AOJu0YyYYobm77hUNF1K3ztPE7KxiZC4pY4gV/cNLLOVRhYO8RlnPS3K
	kHt40yss2NqHjBD3NOPDobJF78hvj3lgudYzXP37DnGbRipQ+OaRJnW+nCK5MCm8EwrU+s2AKi6
	iMvBuYVFarjwLYBM0TtX8igeYZTaOMU7eqb6rNlLVdrS5uUhPA0/VnsnzH0wPrA==
X-Received: by 2002:a05:6000:154c:b0:357:398a:b94f with SMTP id ffacd0b85a97d-35ef0da7fcfmr1734277f8f.26.1717660597748;
        Thu, 06 Jun 2024 00:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTYvjFvw7OyUtdlL0ayqtVWVUSXcPDrSa+0/rmsAeZ6ATMntdxTI8S76GyuSkQgub9I5FWNA==
X-Received: by 2002:a05:6000:154c:b0:357:398a:b94f with SMTP id ffacd0b85a97d-35ef0da7fcfmr1734249f8f.26.1717660597210;
        Thu, 06 Jun 2024 00:56:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29090sm845523f8f.5.2024.06.06.00.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:56:36 -0700 (PDT)
Message-ID: <3a368e38-a4cb-413e-a6d9-41c6b3dbd5ae@redhat.com>
Date: Thu, 6 Jun 2024 09:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
 <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
 <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> Some random thoughts about some folio_test_lru() users:
>>
>> mm/khugepaged.c: skips pages if !folio_test_lru(), but would fail skip
>> it either way if there is the unexpected reference from the LRU batch!
>>
>> mm/compaction.c: skips pages if !folio_test_lru(), but would fail skip
>> it either way if there is the unexpected reference from the LRU batch!
>>
>> mm/memory.c: would love to identify this case and to a lru_add_drain()
>> to free up that reference.
>>
>> mm/huge_memory.c: splitting with the additional reference will fail
>> already. Maybe we'd want to drain the LRU batch.
> 
> Agree.
> 
>>
>> mm/madvise.c: skips pages if !folio_test_lru(). I wonder what happens if
>> we have the same page twice in an LRU batch with different target goals ...
> 
> IIUC, LRU batch can ignore this folio since it's LRU flag is cleared by
> folio_isolate_lru(), then will call folios_put() to frop the reference.
> 

I think what's interesting to highlight in the current design is that a 
folio might end up in multiple LRU batches, and whatever the result will 
be is determined by the sequence of them getting flushed. Doesn't sound 
quite right but maybe there was a reason for it (which could just have 
been "simpler implementation").

> 
>> Some other users (there are not that many that don't use it for sanity
>> checks though) might likely be a bit different.

There are also some PageLRU checks, but not that many.

> 
> mm/page_isolation.c: fail to set pageblock migratetype to isolate if
> !folio_test_lru(), then alloc_contig_range_noprof() can be failed. But
> the original code could set pageblock migratetype to isolate, then
> calling drain_all_pages() in alloc_contig_range_noprof() to drop
> reference of the LRU batch.
> 
> mm/vmscan.c: will call lru_add_drain() before calling
> isolate_lru_folios(), so seems no impact.

lru_add_drain() will only drain the local CPU. So if the folio would be 
stuck on another CPU's LRU batch, right now we could isolate it. When 
processing that LRU batch while the folio is still isolated, it would 
currently simply skip the operation.

So right now we can call isolate_lru_folios() even if the folio is stuck 
on another CPU's LRU batch.

We cannot really reclaim the folio as long is it is in another CPU's LRU 
batch, though (unexpected reference).

> 
> BTW, we also need to look at the usage of folio_isolate_lru().

Yes.

> 
> It doesn’t seem to have major obstacles, but there are many details to
> analyze :)

Yes, we're only scratching the surface.

Having a way to identify "this folio is very likely some CPU's LRU 
batch"  could end up being quite valuable, because likely we don't want 
to blindly drain the LRU simply because there is some unexpected 
reference on a folio [as we would in this patch].

-- 
Cheers,

David / dhildenb


