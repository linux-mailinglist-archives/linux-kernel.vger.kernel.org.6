Return-Path: <linux-kernel+bounces-196594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553D8D5E70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04C9287AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835BC1C6AF;
	Fri, 31 May 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD/DsO3w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEFF824BF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148138; cv=none; b=t+eMoEYuH4at3sqq9PJ0zYbd4BdM04AHJ/P8uDdLYsueu3feAN7pcDuxjkdveucbt8aUJ5UH95tTvUyQml/JB4Y426egH9b/+1LRM3vvoYRxuJhb1BQxVdPlJlwM+58GvOoJIaiaYjBDC8sH1z+qHNfqseJXpKiQPvTxrD6MNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148138; c=relaxed/simple;
	bh=7B/u2ZKhGakyLewQmnMHbUf+sSb8UIrsRPVVGsWC6HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKyCgh1vks7XHcpoLhCnRXcR6HAyok+mXcwot7MMe7lKKWLnop7ri2Mx23Nvjggp/BjTWykJ5J2tVAcmRYbW/XU3thkhAgTlVjGIBSN0Yexy4nsO2Laj6h2evYfuJVp6D6R3uNRHpfj71yAO4dbFFtf/oC+8d8DEyVnYBVQ5yQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gD/DsO3w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717148135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ucz3Dh2FOpA5zju+wtucCdXXyMcRFxrPJbVSOUgJG6k=;
	b=gD/DsO3wnhipP6cM3XBpbelJZR9tofL/gpXacKv6yKSa69EpLTky0307zkxoZqRc6jl+bs
	43q9NYtd/Wd2zszV/BOItP7M6TEirwFbq/SXW0b7c9GktlKPkJSNL4LymZBvX2zsZ20mjz
	HNVsq8BMk1Uw8Zog5d+yuzyVkd/rnoA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-mA7kUEwHP5CFVSZhH21BdA-1; Fri, 31 May 2024 05:35:34 -0400
X-MC-Unique: mA7kUEwHP5CFVSZhH21BdA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcb9dcc3bso1040265f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717148133; x=1717752933;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ucz3Dh2FOpA5zju+wtucCdXXyMcRFxrPJbVSOUgJG6k=;
        b=HvXEzgQDo4OReBi9rtkMUAGufd64/8hRwRlSCH85S4IJ2TkOWVq4w/1gdhGQCcRi0b
         ZnbeBTc79CLWCbpnC/NYrqgVpYLVxSwkZiPbwstWJ0d/5CMfmkvPhBN/pMq+TQqBfUeH
         wHKZ/lO0IlHYsBfvKTiaMiyqlksn+u+0qf/LFZQxrptXVpkr+n3ZRGzx5am1z0uuxQXL
         AertS5zhkcWJ27r/dI00CROlElsnZHLTGGfUvjApoX2WuxL+G1m1+VRQOlgcq8neo/s/
         r4rT+BwqJo0gcbHAd3GpBxw4ufmWItMrYV277y6D7s1fvc5RLtivEqjww+XYE/JehKN+
         YEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzI6UIxhJz8VqqliSU+iLzUy8RLlS1FM5CoUNE60joRjOp8OKeBAEdzCpXFGsr7RsdzMPsX8JeIlbpnx90+Dyf7CNJVlH77JCna5ZG
X-Gm-Message-State: AOJu0YyuJ7jeZeS6+TaXO5uf+Calc366KV2keOhh6/XY4ZJ2+ZnZr3Ku
	+AHzhCtU+7bnPJp9dMBqONWVFKon8Oj10tkgV/4XocKq3iQpmFG9IAJc6BtdGw04yP8CsU6BILg
	DjQrw+XgHQY2SeH5LBZ0o97nw4Gnu/H+uM36T1FrM7R2xI1lO430XXDbp2+tiIA==
X-Received: by 2002:adf:e6c4:0:b0:357:d26a:4f2a with SMTP id ffacd0b85a97d-35e0f2898acmr858585f8f.33.1717148132917;
        Fri, 31 May 2024 02:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElSE8NlDvLiyelLu57GiCt902E3OZLLBYvIvRgWKbZGwTelsvmjjo/OAhdGMUxGUde6NdYkw==
X-Received: by 2002:adf:e6c4:0:b0:357:d26a:4f2a with SMTP id ffacd0b85a97d-35e0f2898acmr858564f8f.33.1717148132364;
        Fri, 31 May 2024 02:35:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062ec29sm1423778f8f.81.2024.05.31.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 02:35:31 -0700 (PDT)
Message-ID: <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
Date: Fri, 31 May 2024 11:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.05.24 04:04, Baolin Wang wrote:
> Anonymous pages have already been supported for multi-size (mTHP) allocation
> through commit 19eaf44954df, that can allow THP to be configured through the
> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
> 
> However, the anonymous shmem will ignore the anonymous mTHP rule configured
> through the sysfs interface, and can only use the PMD-mapped THP, that is not
> reasonable. Many implement anonymous page sharing through mmap(MAP_SHARED |
> MAP_ANONYMOUS), especially in database usage scenarios, therefore, users expect
> to apply an unified mTHP strategy for anonymous pages, also including the
> anonymous shared pages, in order to enjoy the benefits of mTHP. For example,
> lower latency than PMD-mapped THP, smaller memory bloat than PMD-mapped THP,
> contiguous PTEs on ARM architecture to reduce TLB miss etc.
> 
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have all the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option. By default all sizes will be set to "never"
> except PMD size, which is set to "inherit". This ensures backward compatibility
> with the anonymous shmem enabled of the top level, meanwhile also allows
> independent control of anonymous shmem enabled for each mTHP.
> 
> Use the page fault latency tool to measure the performance of 1G anonymous shmem
> with 32 threads on my machine environment with: ARM64 Architecture, 32 cores,
> 125G memory:
> base: mm-unstable
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.04s        3.10s         83516.416                  2669684.890
> 
> mm-unstable + patchset, anon shmem mTHP disabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.02s        3.14s         82936.359                  2630746.027
> 
> mm-unstable + patchset, anon shmem 64K mTHP enabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.08s        0.31s         678630.231                 17082522.495
> 
>  From the data above, it is observed that the patchset has a minimal impact when
> mTHP is not enabled (some fluctuations observed during testing). When enabling 64K
> mTHP, there is a significant improvement of the page fault latency.

Let me summarize the takeaway from the bi-weekly MM meeting as I 
understood it, that includes Hugh's feedback on per-block tracking vs. mTHP:

(1) Per-block tracking

Per-block tracking is currently considered unwarranted complexity in 
shmem.c. We should try to get it done without that. For any test cases 
that fail, we should consider if they are actually valid for shmem.

To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+freeing
is not possible at fallcoate() time, detecting zeropages later and
retrying to split+free might be an option, without per-block tracking.

(2) mTHP controls

As a default, we should not be using large folios / mTHP for any shmem, 
just like we did with THP via shmem_enabled. This is what this series 
currently does, and is aprt of the whole mTHP user-space interface design.

Further, the mTHP controls should control all of shmem, not only 
"anonymous shmem".

Also, we should properly fallback within the configured sizes, and not 
jump "over" configured sizes. Unless there is a good reason.

(3) khugepaged

khugepaged needs to handle larger folios properly as well. Until fixed, 
using smaller THP sizes as fallback might prohibit collapsing a 
PMD-sized THP later. But really, khugepaged needs to be fixed to handle 
that.

(4) force/disable

These settings are rather testing artifacts from the old ages. We should 
not add them to the per-size toggles. We might "inherit" it from the 
global one, though.

"within_size" might have value, and especially for consistency, we 
should have them per size.



So, this series only tackles anonymous shmem, which is a good starting 
point. Ideally, we'd get support for other shmem (especially during 
fault time) soon afterwards, because we won't be adding separate toggles 
for that from the interface POV, and having inconsistent behavior 
between kernel versions would be a bit unfortunate.


@Baolin, this series likely does not consider (4) yet. And I suggest we 
have to take a lot of the "anonymous thp" terminology out of this 
series, especially when it comes to documentation.

@Daniel, Pankaj, what are your plans regarding that? It would be great 
if we could get an understanding on the next steps on !anon shmem.

-- 
Cheers,

David / dhildenb


