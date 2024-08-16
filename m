Return-Path: <linux-kernel+bounces-289363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E80954550
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77CD1F224FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6BD13D890;
	Fri, 16 Aug 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wqew1i6N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1083CD4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800144; cv=none; b=umdpNTa7UrswDlQbUGAP4YBSpxzYo61h6rlxnIBnW2fHC+wgyG3a3FkhCbvkqlO4eEUrDaJ3dgcUILbODhxercTIy4lE69Jx8ndZl0PrBmRtCqhaIArBJtfb7lMdVUUubV3TnajW2hYHmgmD3Ns2JdfP3G6x4kbtjgoLXk8QSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800144; c=relaxed/simple;
	bh=IQJ03Nz43v4K4vXCa4qyRaXmWeLTNfKCB+EtsJYagvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5YoYh4s8seRxZXFYxsaXy0BueZfRjrNcJJDXFJSxyEPG+pJJ4hDWK6BhdvYCHhTecSWMXvSwNYPonUI8JOXSbhL8fftvEXsh/xWOzPOZ2k+hJy9EGFmX4P1hAz8U/QvtrUrwc1LTcAdYDjP4H7Jw868DznrV0gzgwd36+4VupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wqew1i6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723800141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M1nw3TI/x8xm8G5ToDEc03hFzXIhWW679Aa76Rk3KUA=;
	b=Wqew1i6NA8KDvldPVSdlPcsTVm4plPcgl3QXhZgiQipI/b6PUjJaU3F47yvIJaCH3fcBHp
	YfMhSoq93Ht274yRFNQkGWYOe/NthDxidcIFGlkN9yp0pDUhlDdaGusCyxzh+YYZlf1bls
	6FF0axjkw485MGli/UlMLqJMC1gdJv0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-FfTZqBqOOl2sj7g0jFAMyw-1; Fri, 16 Aug 2024 05:22:19 -0400
X-MC-Unique: FfTZqBqOOl2sj7g0jFAMyw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso12763335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800138; x=1724404938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M1nw3TI/x8xm8G5ToDEc03hFzXIhWW679Aa76Rk3KUA=;
        b=uyRxVDwWNrMtSqmrJdowbgKgBDKusGx4J+Yu4gA0Uom7FX6clsSsmyBFFcu2lxgkjS
         EOXIVf9HYw/rXTYddPZc0VqZUtQNf+79ihIECwUROI75RbuUsWE03daq/4HGh1Tnzy9o
         qIFR20fpQcDuuKj6H1iMWs3r0HftVK/m4Sn0UcUwFPiYAwE6tL0dhrbhvuPsSkGbt5bp
         zlLTD6l5ASZnfRMwSTM/WmELtAivalw7NHMwmzSsi2Bz1Dy3UQ+oumfZFQNQW5VFbpiY
         WZhQjQXMFp8qGrVHLfnfIUrDqN08OjJEJBVkQ8CxmtfA1IszqZ3h6zcLVHCNocxzGUqR
         8KhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZ4tv9QA+thdt9eMJNLJqiWxr9RJSEae8Ix9MeeWW3x8dPSYtffiN/ie3GJr6h4HyHXrFTT05ptZesjB9RMHEJnAMRH0DwO8Z10Bw
X-Gm-Message-State: AOJu0YzF9COGU8spyeFzlzKooilSyoeNpW3hiRLeDrpAD2qycJyh1+3g
	80Hr3Gh9ZzFVKtpA60om9P8kJAznUszFy/Byzvj/q6IUNlVsGfiKIwhuiegu+jC2A/nqGVZJuTJ
	kwU8ksobU/XFvf/NOV/txyl+R/0stAwHJ0v+eJtM79Y5lBMtd+H/hCTbr5tpNzQ==
X-Received: by 2002:a05:600c:3587:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-429ed7b8883mr15414245e9.18.1723800138025;
        Fri, 16 Aug 2024 02:22:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES7VluZXtLEQDwH6+FARixLjnpngjcVpPeq9bi09avGW2l9mXuFy0bHMVDdzJU44v4iQRgZw==
X-Received: by 2002:a05:600c:3587:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-429ed7b8883mr15413965e9.18.1723800137454;
        Fri, 16 Aug 2024 02:22:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded18468sm70216805e9.2.2024.08.16.02.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:22:17 -0700 (PDT)
Message-ID: <b0b39543-498d-4b08-a864-b05be45f617d@redhat.com>
Date: Fri, 16 Aug 2024 11:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in
 zap_page_range_single()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
 <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
 <42942b4d-153e-43e2-bfb1-43db49f87e50@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <42942b4d-153e-43e2-bfb1-43db49f87e50@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.24 05:58, Qi Zheng wrote:
> Hi David,
> 

Really sorry for the slow replies, I'm struggling with a mixture of 
public holidays, holiday and too many different discussions (well, and 
some stuff I have to finish myself).

> On 2024/8/6 22:40, David Hildenbrand wrote:
>> On 05.08.24 14:55, Qi Zheng wrote:
>>> Now in order to pursue high performance, applications mostly use some
>>> high-performance user-mode memory allocators, such as jemalloc or
>>> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
>>> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
>>> release page table memory, which may cause huge page table memory usage.
>>>
>>> The following are a memory usage snapshot of one process which actually
>>> happened on our server:
>>>
>>>           VIRT:  55t
>>>           RES:   590g
>>>           VmPTE: 110g
>>>
>>> In this case, most of the page table entries are empty. For such a PTE
>>> page where all entries are empty, we can actually free it back to the
>>> system for others to use.
>>>
>>> As a first step, this commit attempts to synchronously free the empty PTE
>>> pages in zap_page_range_single() (MADV_DONTNEED etc will invoke this). In
>>> order to reduce overhead, we only handle the cases with a high
>>> probability
>>> of generating empty PTE pages, and other cases will be filtered out, such
>>> as:
>>
>> It doesn't make particular sense during munmap() where we will just
>> remove the page tables manually directly afterwards. We should limit it
>> to the !munmap case -- in particular MADV_DONTNEED.
> 
> munmap directly calls unmap_single_vma() instead of
> zap_page_range_single(), so the munmap case has already been excluded
> here. On the other hand, if we try to reclaim in zap_pte_range(), we
> need to identify the munmap case.
> 
> Of course, we could just modify the MADV_DONTNEED case instead of all
> the callers of zap_page_range_single(), perhaps we could add a new
> parameter to identify the MADV_DONTNEED case?

See below, zap_details might come in handy.

> 
>>
>> To minimze the added overhead, I further suggest to only try reclaim
>> asynchronously if we know that likely all ptes will be none, that is,
> 
> asynchronously? What you probably mean to say is synchronously, right?
> 
>> when we just zapped *all* ptes of a PTE page table -- our range spans
>> the complete PTE page table.
>>
>> Just imagine someone zaps a single PTE, we really don't want to start
>> scanning page tables and involve an (rather expensive) walk_page_range
>> just to find out that there is still something mapped.
> 
> In the munmap path, we first execute unmap and then reclaim the page
> tables:
> 
> unmap_vmas
> free_pgtables
> 
> Therefore, I think doing something similar in zap_page_range_single()
> would be more consistent:
> 
> unmap_single_vma
> try_to_reclaim_pgtables
> 
> And I think that the main overhead should be in flushing TLB and freeing
> the pages. Of course, I will do some performance testing to see the
> actual impact.
> 
>>
>> Last but not least, would there be a way to avoid the walk_page_range()
>> and simply trigger it from zap_pte_range(), possibly still while holding
>> the PTE table lock?
> 
> I've tried doing it that way before, but ultimately I did not choose to
> do it that way because of the following reasons:

I think we really should avoid another page table walk if possible.

> 
> 1. need to identify the munmap case

We already have "struct zap_details". Maybe we can extend that to 
specify what our intention are (either where we come from or whether we 
want to try ripping out apge tables directly).

> 2. trying to record the count of pte_none() within the original
>      zap_pte_range() loop is not very convenient. The most convenient
>      approach is still to loop 512 times to scan the PTE page.

Right, the code might need some reshuffling. As we might temporary drop 
the PTL (break case), fully relying on everything being pte_none() 
doesn't always work.

We could either handle it in zap_pmd_range(), after we processed a full 
PMD range. zap_pmd_range() knows for sure whether the full PMD range was 
covered, even if multiple zap_pte_range() calls were required.

Or we could indicate to zap_pte_range() the original range. Or we could 
make zap_pte_range() simply handle the retrying itself, and not get 
called multiple times for a single PMD range.

So the key points are:

(a) zap_pmd_range() should know for sure whether the full range is
     covered by the zap.
(b) zap_pte_range() knows whether it left any entries being (IOW, it n
     never ran into the "!should_zap_folio" case)
(c) we know whether we temporarily had to drop the PTL and someone might
     have converted pte_none() to something else.

Teaching zap_pte_range() to handle a full within-PMD range itself sounds 
cleanest.

Then we can handle it fully in zap_pte_range():

(a) if we had to leave entries behind (!pte_none()), no need to try
     ripping out the page table.

(b) if we didn't have to drop the PTL, we can remove the page table
     without even re-verifying whether the entries are pte_none(). We
     know they are. If we had to drop the PTL, we have to re-verify at
    least the PTEs that were not zapped in the last iteration.


So there is the chance to avoid pte_none() checks completely, or minimze 
them if we had to drop the PTL.

Anything I am missing? Please let me know if anything is unclear.

Reworking the retry logic for zap_pte_range(), to be called for a single 
PMD only once is likely the first step.

> 3. still need to release the pte lock, and then re-acquire the pmd lock
>      and pte lock.

Yes, if try-locking the PMD fails.

-- 
Cheers,

David / dhildenb


