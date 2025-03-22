Return-Path: <linux-kernel+bounces-572179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8EA6C7BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E4C16F948
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08F1607B4;
	Sat, 22 Mar 2025 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzZPKFl7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CB2C80
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742621612; cv=none; b=GgwSz8GSkReKS9qudyTrEq87+HSTFWlrraowrWho2ClPefNIBRJcP5ZCpVDFnyU08l4eVDoTGsbgmHRnFI946Q4zgBan47TM3j6Plg75Aqv0D/s/XgjYFdEnvyQnPrH4qOMtC4LaXQbL3urpsJ7JeVSTcfv1OZg9Wt4NkZkBozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742621612; c=relaxed/simple;
	bh=PLopHPuziS+X0AoABbov2bgxiwm+qflk0mjsYXUOZ+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SW5IxL/1GUdvKvBebT0pvXx/pTIeer2ID2A6RD9lGiHak3PACa+e1GNUtJTwdOWJD4tgYSMcW3BfreZWWpIjTSK6k8FmPOD7Vbn1Zg35dls6n8vvcFjFkDegK9HtxCZupswn7mjlULo74P5oCmblOYie4luSkkcX3X3g0PZ/56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzZPKFl7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742621607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HWmdMpX/hMPdlePv/yUsN8A0VAs32x9HD6YaEuznchs=;
	b=NzZPKFl7pA6MTtCIS684Cj7b181jgVcb3NvpL7Q5Rw+ooSSx2Uc6zDujYzpG/vO9NwpAIN
	24eH/liWrsOKPvVrdRREpaeUwZ1M53Bua7NT91tjSSFPuE6CLiiLzaDdlWuhzkkdM8Wzx3
	wRr7ylOy+4u5CcZZbfqNE2j7YP0caUU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-OzLHRxs-MT23kbT2gWR2vw-1; Sat, 22 Mar 2025 01:33:26 -0400
X-MC-Unique: OzLHRxs-MT23kbT2gWR2vw-1
X-Mimecast-MFC-AGG-ID: OzLHRxs-MT23kbT2gWR2vw_1742621605
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39130f02631so1121950f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742621605; x=1743226405;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HWmdMpX/hMPdlePv/yUsN8A0VAs32x9HD6YaEuznchs=;
        b=YLhsbhuOKBqpakD/R/H+/m2R9FgnUFLKccovTwEk3Ogq7Ljptp0LEyjmlxwhSlIve7
         JbLgraxx/vpthqFIJG9M7kL79ZHsHVRpQ7RYNoaHbnJwfUW+1FwotzL3BYBKF+1OTjVn
         vD5eakIakLyZTRGyQVYG1wVfAi43VQ4/r4JY10X5N+1lMna4kOAHcB7W6wmoxSh5pygu
         +nEo55BZAvyRBsaY/6lkL3lopke0qt7PxSRLumIAhXxjjfmIKmN+OUElXiy3auA6zpGx
         gwgD22XSO+IpauBxjp2qpPeKNAEZwlKDW9yWdZ3yRke8gOO9B4ow+5inlHO4nkT9E+zY
         uoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX44iwkFrzBbwbr3yqxnCMvmtb2LVqRfReMu79eMkk0y9L6RKHROnr50eLM1vAsBoTFiDzZdNV7z03QcLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkclQFCgejJf5pMNTJtdny8SfGnU6Ngi7QFw3O4sDD3H1hj2NE
	hgaQYJ4WAV9ZCPfFWVNeRDpgrlmvv4PtY01P0nMKkfTA/uAe7aRqbzDRtCUf+utPQstBHIXAyR9
	zvCbD9hzVizjuCqzY5RqUkWi7bh0RxDajboWt1+PzFHUDnKfw+2ay+fbsAvH91Q==
X-Gm-Gg: ASbGnctKswJp8isTSNL8pN/G38f2BAuy7oyVEh8b7aTODOljI2XffNHvS2f7dicwfcB
	aCdNqpsFuvoQOZZaG71reMD18sWB9e6aXfhCk/Thuoe/FRKBppWwsc4DucHsAFDl/bW/J/wv/UJ
	UscFfGu8JLE0JWotCQBzM/S7VHEpqqh4R/xP3Yfk1BHyiYMJ9hJy2k31n5bzgiwrb0tpeFVTiH+
	EpJviHNn6CqJfm17EkDLHjXciXHArWhX86fq6EyVGDRsJ5ogfvlThL7e5zOz8AAtWJOP2+MKHcR
	KtmiBj1+BTzKxs8=
X-Received: by 2002:a05:6000:18a7:b0:399:737f:4de3 with SMTP id ffacd0b85a97d-3997f90e474mr5283690f8f.29.1742621604944;
        Fri, 21 Mar 2025 22:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5l9t4bWV0jPyg6hOm2PfZ8ON80UGGgGyVx0tEZ6svjJJ4mSLC1SB/0vAs3jl4gWa04YuqA==
X-Received: by 2002:a05:6000:18a7:b0:399:737f:4de3 with SMTP id ffacd0b85a97d-3997f90e474mr5283670f8f.29.1742621604557;
        Fri, 21 Mar 2025 22:33:24 -0700 (PDT)
Received: from [10.239.241.125] ([88.128.92.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a5b66sm4147685f8f.40.2025.03.21.22.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 22:33:24 -0700 (PDT)
Message-ID: <182bf1ce-1b67-4243-854b-4d0c26aae563@redhat.com>
Date: Sat, 22 Mar 2025 06:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via
 MREMAP_RELOCATE_ANON
To: Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
 <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.03.25 01:14, Jann Horn wrote:
> On Fri, Mar 21, 2025 at 10:54 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 0865387531ed..bb67562a0114 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
> [...]
>> +/*
>> + * If the folio mapped at the specified pte entry can have its index and mapping
>> + * relocated, then do so.
>> + *
>> + * Returns the number of pages we have traversed, or 0 if the operation failed.
>> + */
>> +static unsigned long relocate_anon(struct pagetable_move_control *pmc,
>> +               unsigned long old_addr, unsigned long new_addr, pte_t pte,
>> +               bool undo)
>> +{
>> +       struct page *page;
>> +       struct folio *folio;
>> +       struct vm_area_struct *old, *new;
>> +       pgoff_t new_index;
>> +       unsigned long ret = 1;
>> +
>> +       old = pmc->old;
>> +       new = pmc->new;
>> +
>> +       /* Ensure we have truly got an anon folio. */
>> +       page = vm_normal_page(old, old_addr, pte);
>> +       if (!page)
>> +               return ret;
>> +       folio = page_folio(page);
>> +       folio_lock(folio);
>> +
>> +       /* no-op. */
>> +       if (!folio_test_anon(folio) || folio_test_ksm(folio))
>> +               goto out;
>> +
>> +       /*
>> +        * This should not happen as we explicitly disallow this, but check
>> +        * anyway.
>> +        */
>> +       if (folio_test_large(folio)) {
>> +               ret = 0;
>> +               goto out;
>> +       }
> 
> Do I understand correctly that you assume here that the page is
> exclusively mapped? Maybe we could at least
> WARN_ON(folio_mapcount(folio) != 1) or something like that?
> 
> (I was also wondering if the PageAnonExclusive bit is somehow
> relevant, but we should probably not look at or touch that here,
> unless we want to think about cases where we _used to_ have a child
> from which the page may have been GUP'd...)

UFFDIO_MOVE implements something similar. Right now we keep it simple:

	if (folio_test_large(src_folio) ||
	    folio_maybe_dma_pinned(src_folio) ||
	    !PageAnonExclusive(&src_folio->page)) {
		err = -EBUSY;
		goto out;
	}

Whereby we

a) Make sure we cover all PTEs (-> small folio, single PTE). Large 
PTE-mapped folios are split.

b) Make sure there are no GUP pins (maybe not required here?)

c) The folio is exclusive to this process


In general, things I can reason about with confidence are:

a)  As alternative to PageAnonExclusive(), we can check 
folio_mapcount()==1 under the folio lock for small folios / PMD-mapped 
folios. As you (Jann) say, there might be unexpected references on the 
folio from other processes.

b) For large (pte-mapped) folios, we could try batching multiple PTEs 
(folio_pte_batch() etc.). We'd be processing all mappings with 
folio_lock + folio_mapcount() == #PTEs.

c)  In -next, there is now be the option to use folio lock + 
folio_maybe_mapped_shared() == false. But it doesn't tell you into how 
many VMAs a large folio is mapped into.

In the following case:

[       folio     ]
[ VMA#1 ] [ VMA#2 ]

c) would not tell you if you are fine modifying the folio when moving VMA#2.


-- 
Cheers,

David / dhildenb


