Return-Path: <linux-kernel+bounces-244007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA45929DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F102A1C22363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FAE3A1DC;
	Mon,  8 Jul 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXIb3aeK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E222616
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425419; cv=none; b=aE93lEVRA2WsExILfahWUB10c+JZSsGTnE8vL6cOiaZqNQISPYPsqBeVCzhh86PAUYANtySgG0H+TNY8q++A6mmfXgZX3jo96N460jBMCrgQdjhGeCFUI5REu7KOT7lw9RXjrvMRaCBvRC79eLVwdD/A/ZLIo1cCHzxmUE3dlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425419; c=relaxed/simple;
	bh=g+DneMY4Syqs4ib5avxVup93N3FOC6pQcvmduHoE2PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JC5gX3x2giCBoH9nrNsjYIR9B9lpI3i4bOW7PZAWdqdvHf+AyqkbtYsX0CiJ6x40jHni29sF/a2VROab0ptEwwTTHWv/sGeEiS3PK5aMy1yRXSQHCat1goiTF+24+sPBaIVYEhJShIz+O9lfGR6+TbJ+aGcB1R2pvL0ZnU7+Xt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXIb3aeK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P7UDcDhukCIjE6XPPyKqc3c1bo3guv4e9HYq+Y1TocI=;
	b=dXIb3aeKjDGdqQSIK4oDat2xC6CZg1Ds60iA6+SdUCJyEeEJ+BUPL847zbfU7ilX1P1FNK
	Ruc7ZlD2RQ3rSGD5ju+fX2xAUWmpH8Wm86Yuo9eYyXu7WZxkD1r7rUD1QSIk04nTkCWyXw
	30U/TDhIG1uiT+PVkAXo4Ast0wfXE1Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-FGdijK0CMnu9OqPWrTT__Q-1; Mon, 08 Jul 2024 03:56:55 -0400
X-MC-Unique: FGdijK0CMnu9OqPWrTT__Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b0dce2704so2821916a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425414; x=1721030214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7UDcDhukCIjE6XPPyKqc3c1bo3guv4e9HYq+Y1TocI=;
        b=rkiMwofobSAmiYUVB8mDTJ9aEF69sgceSCdZuhcOw80ETuiRfx5/Kp6IbPwpvYqGOJ
         hCGGzGZ5eA+J/if7E43/CHHtXxpgQYejiSNj0L3NY3DA/FzYOll2TNCSoCYhja4nQ0xy
         ymyCldMk7lMsSiCSZFwpvDuhb/yVPt8tLpKn+TRs41wrJDVFfH8h9wJoMJxR5TuBr2a6
         +7tejnGyvWcvmd9r9sizH+4ZQrLw0XloMp30U013k70DoVfnkqEkhk68K5i+K6LFNMCt
         DG2XkeJJm2+s3BG2uazDow57yH1RW24zyDDHNvsdPCruGFXiEUAPbGGJTfmzBTKthzDZ
         HJVw==
X-Forwarded-Encrypted: i=1; AJvYcCXMCLmrPpv3QZMyakDaxbbVLnQxY7iwtLjm9oyiiYQRJhyOqkaEAgEPoHf05yYe/eSGVNbls7TFIF+WNSDi/YKJ64RRjY6JxVZIzMu4
X-Gm-Message-State: AOJu0Yw3FTon0dOQQd6MFYO3V31Dx2NNjZzchNyvcAP+EDS9aVIHaEXN
	u5CoseMnsxUQ6npbGCmB7yfmn4FmDrVByLDzQEgl0ZVQAsCpuqJAb0p/EUBfXzsVPKKQJN/lM01
	+93nlv6ByyotARPL3OKhFF5akRUz2RyqTpouokxRmU3obkf0vMoolI4oTqEW+AA==
X-Received: by 2002:a05:6402:40d1:b0:58c:3af3:cb0a with SMTP id 4fb4d7f45d1cf-58e5a7e8646mr8360710a12.1.1720425413953;
        Mon, 08 Jul 2024 00:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLbfeeHCf6YTjePK3wWZC00uu/o3RjMFt3X0ObUkAous1koHNbqabHGWLN+EKwGc0tzeWb+Q==
X-Received: by 2002:a05:6402:40d1:b0:58c:3af3:cb0a with SMTP id 4fb4d7f45d1cf-58e5a7e8646mr8360695a12.1.1720425413565;
        Mon, 08 Jul 2024 00:56:53 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58dfd5aeda6sm5290033a12.78.2024.07.08.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 00:56:53 -0700 (PDT)
Message-ID: <2c3ebd1a-09d7-4521-9dea-684d38272a29@redhat.com>
Date: Mon, 8 Jul 2024 09:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] kernel/fork.c: get totalram_pages from memblock to
 calculate max_threads
To: Wei Yang <richard.weiyang@gmail.com>, rppt@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
 mjguzik@gmail.com, tandersen@netflix.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240708010010.32347-1-richard.weiyang@gmail.com>
 <20240708010010.32347-2-richard.weiyang@gmail.com>
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
In-Reply-To: <20240708010010.32347-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 03:00, Wei Yang wrote:
> Since we plan to move the accounting into __free_pages_core(),
> totalram_pages may not represent the total usable pages on system
> at this point when defer_init is enabled.
> 
> Instead we can get the total estimated pages from memblock directly.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>
> CC: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/fork.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99076dbe27d8..e80e889543f3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -44,6 +44,7 @@
>   #include <linux/fs.h>
>   #include <linux/mm.h>
>   #include <linux/mm_inline.h>
> +#include <linux/memblock.h>
>   #include <linux/nsproxy.h>
>   #include <linux/capability.h>
>   #include <linux/cpu.h>
> @@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
>   static void set_max_threads(unsigned int max_threads_suggested)
>   {
>   	u64 threads;
> -	unsigned long nr_pages = totalram_pages();
> +	unsigned long nr_pages = memblock_estimated_nr_pages();

Stale name

-- 
Cheers,

David / dhildenb


