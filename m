Return-Path: <linux-kernel+bounces-276582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69204949597
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7931C212F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3443BB30;
	Tue,  6 Aug 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLn4BTML"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED92BAE5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961946; cv=none; b=pvTBQYiN3OawiyMbENl/Tcf3DKGZrixlk/GbbB4fI73daAHRTP4caGDMlQWOlhoDfLzqcRL3tFEtmkj9JdJExffbIneEn9f5fVkUUi3g7RaL7DXDoNykSwIXrbBbvwCZmuYLgpqXer14pwj4i24psL3D2d5IQqRscgUW6t5Wwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961946; c=relaxed/simple;
	bh=BUBNUNsnNzDbQHTnIJEYOaxgpNpqtYGmBbEAYvA94T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgnSJ1fOo8DdCrNzcIV0h2RTmPjSGmTgZhp+kMlosmazwk/PPKPmO/u50j/arfSvOpHsV4WslmzjkTzlfLlLxqnGwuQKdDCB/dTpdIshlqMCV+IiCJTHnRoUbD8gTx50QIWlFU+o86W4XpHjxZ9S0lQxLj3GI2r+sbx/3GaKmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLn4BTML; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722961942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oxnEgvMxeUyY0UmIGfmdIEh/CRjSbpkFLi3oxJz10Qw=;
	b=iLn4BTML0/IKP+MDwAimXOrSGLnywQoi9/PagkcJioCbca+glNNKLUWmCjVIhpDRYiS73Y
	DBEVIq0jxZrxjRPmfXI2sEQGZcDNwTjp+LhaZlWBO2dQSPzittc9pOxk7iSS8V0GpwVA7P
	qEqSFirL/i5/OvdOwl9MWJL0idx6Bs0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-gB-TJeI2Nue2Pa85Loz-aw-1; Tue, 06 Aug 2024 12:32:15 -0400
X-MC-Unique: gB-TJeI2Nue2Pa85Loz-aw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36bb2047c21so534623f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961933; x=1723566733;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oxnEgvMxeUyY0UmIGfmdIEh/CRjSbpkFLi3oxJz10Qw=;
        b=e+4MhnupMInlRR9UGcoT6+pirlQ/7qach3VXKgXu6gRWkfEjTX9lUfUAzNtfVkKjn1
         Z+4fm+cA3bCBy3B5Zb8pynLxg1V/RT+/bn9VqwdqE6zmV4Capb4qVf67u19/kud5f9A7
         lIyQ+cdyG9eRbsaHfO/ZOexPZe+Bj4ha2Fua1//5wvzql5L5lnydqw/OiIrxJIVCBbkp
         CyxeisISaNi3yLq6DuHgQk6oA9ZYqoh9MrL+aH0xH169Oc7/EiloskZGoBrOV6DSPM9g
         ii9BUOZJ6Tqh4E6RaZwf9jYu4kYesRy/V2GQaDgBC1Nhg3JuVGAiNe5TXY6IvAYJoKJq
         g8TA==
X-Forwarded-Encrypted: i=1; AJvYcCUHh+5WuPW+Mx2aAw3meIAczZZwqpYEtjp0zla4a6ayMtUwFTEzgOUH/ABW+vwvlIPDidUmsXBl4c/3mHBf6hdYgwy3FtACMiloDrTq
X-Gm-Message-State: AOJu0YwphRiSH/J5xjBeEM8TlIjAftouTNz2Jqo7TM/u/tthmSfyu5Lx
	msw0U6/I1R1c8aKLPBss32lxedHgqZlotr4dcT3rD3GPpOkgXdxRVxA4Cq/kGP/csb/bDLIUjKp
	fkf9dZmlqAm4iejEGrz0tXaBGJbfhoeYKQgUegQPFCwsr6TAPYMZFo3jvVmTC0A==
X-Received: by 2002:a5d:6c62:0:b0:369:cbd0:61ff with SMTP id ffacd0b85a97d-36bbc0c4fadmr14415250f8f.9.1722961933190;
        Tue, 06 Aug 2024 09:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQxvNbyf2inRdjFcizT7Se4zbWSkDp2Jj3apl69BhbFZNVFpkaWzyTErDQpS/96pxAysz4A==
X-Received: by 2002:a5d:6c62:0:b0:369:cbd0:61ff with SMTP id ffacd0b85a97d-36bbc0c4fadmr14415204f8f.9.1722961932633;
        Tue, 06 Aug 2024 09:32:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc4csm13583582f8f.3.2024.08.06.09.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:32:12 -0700 (PDT)
Message-ID: <a149ee8e-e53a-4978-b5af-dbf43c99cf7b@redhat.com>
Date: Tue, 6 Aug 2024 18:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Matthew Wilcox <willy@infradead.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Oscar Salvador <osalvador@suse.de>, Mel Gorman
 <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huang Ying <ying.huang@intel.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Hugh Dickins <hughd@google.com>, x86@kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Alex Thorlton <athorlton@sgi.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-3-peterx@redhat.com>
 <added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com> <Zq-Y3qs5_PZW04bt@x1n>
 <054324a3-bc77-426f-a751-06700aad394e@redhat.com> <ZrJO0aLVaeRoo8eo@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZrJO0aLVaeRoo8eo@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 18:26, Peter Xu wrote:
> On Tue, Aug 06, 2024 at 03:02:00PM +0200, David Hildenbrand wrote:
>>> Right.
>>>
>>> I don't have a reason to change numa_pte_updates semantics yet so far, but
>>> here there's the problem where numa_huge_pte_updates can be ambiguous when
>>> there is even PUD involved.
>>>
>>> In general, I don't know how I should treat this counter in PUD path even
>>> if NUMA isn't involved in dax yet; it can be soon involved if we move on
>>> with using this same path for hugetlb, or when 1G thp can be possible (with
>>> Yu Zhao's TAO?).
>>
>> We shouldn't bother about it in the PUD path at all I think. Especially as
>> long as NUMA hinting doesn't apply to any of what we would handle on the PUD
>> path :)
> 
> Hmm, I just noticed that hugetlb was never involved.. but then how about a
> potential 1G THP?  Do you mean 1G THP will not be accounted in numa
> balancing too even in the future?

My best guess is that you would want a separate counter for that. The 
old one was just badly named ...

72403b4a0fbd even spells out "NUMA huge PMD updates".


"NUMA huge PMD updates were the number of THP  updates which in 
combination can be used to calculate how many ptes were updated from 
userspace."

... which doesn't make sense if you don't know how "huge" the huge 
actually was. :)

> 
> The motivation I had this patch in this series is I want to be clear on how
> I should treat this counter in pud path if it won't go.  And when people
> compare the two paths we'll need to be clear why there's such difference if
> I ignore it in pud path.
> 
> Per my current read on this counter, it might be an overkill to do that at
> all, and it might be simpler we drop it now.

Fine with me. But I would send that out separately, not buried in this 
series. The we might actually get Mel to review (was he CCed?).

Up to you!

-- 
Cheers,

David / dhildenb


