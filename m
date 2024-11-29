Return-Path: <linux-kernel+bounces-425641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69D9DE844
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE425B21286
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0E1A073F;
	Fri, 29 Nov 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pyi30Ues"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090519F430
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732889403; cv=none; b=ZjwIjdT7Swzvys5XZ1DhhBAloVRMK6knf2IKkmyZkjmTuTTJyw+eaqSQG1C/ZIVzv5OjZqYpR0Ju2MKYUeZKekHL9pKPUisDFWIEcilIIimAix5AvsEbTFbxBi7N8z98JIzjgOAPBVedlAw7SkKu7Vt6oyZdn2TfAIsvg4lCTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732889403; c=relaxed/simple;
	bh=HRL522R3I71+L/rW4MnW8XEkM61aN0d7e3dNo3eJFyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ1r0qiiJniyuBaKGqSIPvB83nsk314umWJPX2ojCqbVNv8oAY9q8ih9AD+dVanIvDgCS9LewxlQRsdH2gK9HPPOHmFW01l5P0CyM6MZ8Lnd3sKUzhdn3JFuuz+90Zxno3A9nEU3FrLoRxuNsFBAKmct/t2YVNlGJ2YbpxHkd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pyi30Ues; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732889400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=njH6ITMLDrT/y3PcsLNgEd7N0AuL90BZyR6zad7+7is=;
	b=Pyi30Uesjty/9KaIytTzon/gMum1A07At6SsnnW8tVUDYrOfLhnf0HKDi8ZSJgXd7CERIY
	cvzLNUxObAJuD0ClweLvHNrU/EHlC6AcQFdWBagxqtj4g+aX3qLllB/MRoi6Zy55rAtkZQ
	HHKNhYZVzea+u/bRs1AC0Vcup2TKmyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-iVSDFRrGODKZsLWt3rEVeQ-1; Fri, 29 Nov 2024 09:09:59 -0500
X-MC-Unique: iVSDFRrGODKZsLWt3rEVeQ-1
X-Mimecast-MFC-AGG-ID: iVSDFRrGODKZsLWt3rEVeQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dcadffebso466015f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732889398; x=1733494198;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=njH6ITMLDrT/y3PcsLNgEd7N0AuL90BZyR6zad7+7is=;
        b=GCxqp/WMYNOVyTz9XgWpPxc2JXRUx3xdpWJQwrOF7D9G3j/6tSzm5+xyKwDZSSanyP
         gaNxxJubmFpOS4KitcSAcS6hpGx9KZq/7P4p6ccxQgJa+tMp8EDOtDVhBcQsosyHyD6u
         KBgtX1KAiaegNOISQ29UJru6b5YG9fwuWFKZIjNlcRLi3a2Ouwvknxj1H8Sc2BjDraNH
         zaDapfHtUZaGbbx0fHpoRgaYgBnjBsy0FTD6JDuhyZwugzU+akJjK19YuK7TeJL/DAVy
         tFB6CSlw6pHEJwywNX3AbDW4WZ5PPwfQA/dOvm3xr59/ChCm2gVzn2Y587efHd0mmlF1
         1uxA==
X-Forwarded-Encrypted: i=1; AJvYcCXSR3L5qgGqJq3wg60PKM6kNEnYkVpUeAMU8dxT/Mvga5nFU/ylr3N8AY20zXxjJmsi7GnROyrxPpD31bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFd3/oJF1lIHOVGLpAQXevrJuRmqJ3u5tuX4MDHof+D7RO2Um
	HQlpR2+vxZPeojDgDT33ceV7eWGfVYeYI2cfcYTLut4yCJUk6eKa38NY3FPowwQAfjcue0SzvR/
	4B8OOVx4g08rVMxYsMFcMTJ3C1R30yTPKOh14TsndphJWoO6CWodiNi2ciLN4wg==
X-Gm-Gg: ASbGncsYZpz219/a9vRv9vWSw0/8j7zIvrIql3+aUJLgQc017VrblOHqkQC0lfjSO9I
	w57WKQYFJ/JcFD1EiNQfqhujGwa2LTm+5DM6yryJTtPviSZWUgE+khONu6saMOMXqjqz9q1q0rK
	8LPTZgTHQfSTxsSdmDZIHa7nqN3D9zJfF1Wf1eQRyL3sUroNplAOssPKsF1X6eNPQHlNe6X3Pai
	SCXTsOiXLT2kOMMCh3vCET/4BvVCLFITipl7bIXF8V7VhlSNMUC2PIXCPZO+WjbdzsMmQShLUv5
	u3LLOZCitF5RpY6WgfcIEe7TYQxCB6DeM8PWUu47nhRpnHqtZvK11U7fV92hNTij5+AzqwW0Rhv
	CVg==
X-Received: by 2002:a05:6000:18ab:b0:382:5f5d:7a98 with SMTP id ffacd0b85a97d-385c6eb8dc5mr10591237f8f.10.1732889397348;
        Fri, 29 Nov 2024 06:09:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnuCVPZZtDTeUD6tNrQmri9NZh7hevsEibFOI614SEJQ9hM4kGRWvmmxUgmIxpuphlhSRklg==
X-Received: by 2002:a05:6000:18ab:b0:382:5f5d:7a98 with SMTP id ffacd0b85a97d-385c6eb8dc5mr10590571f8f.10.1732889392642;
        Fri, 29 Nov 2024 06:09:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68c1bsm4635756f8f.84.2024.11.29.06.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 06:09:51 -0800 (PST)
Message-ID: <f637de06-41de-44be-8e1f-6a5d429e0ec9@redhat.com>
Date: Fri, 29 Nov 2024 15:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
 <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
 <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
 <14895682-a013-419f-bee8-1476540ddedd@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <14895682-a013-419f-bee8-1476540ddedd@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> I just tested it and write() works fine, it uses uaccess afaict as part of the
>>> lib/iov_iter.c code:
>>>
>>> generic_perform_write()
>>> -> copy_folio_from_iter_atomic()
>>> -> copy_page_from_iter_atomic()
>>> -> __copy_from_iter()
>>> -> copy_from_user_iter()
>>> -> raw_copy_from_user()
>>> -> copy_user_generic()
>>> -> [uaccess asm]
>>>
>>
>> Ah yes. O_DIRECT is the problematic bit I suspect, which will use GUP.
>>
>> Ptrace access and friends should also no longer work on these pages, likely
>> that's tolerable.
> 
> Yeah Peter can interject if not, but I'd be _very_ surprised if anybody expects
> to be able to ptrace perf counter mappings in another process (it'd be kind of
> totally insane to do that anyway since it's a ring buffer that needs special
> handing anyway).

I think so as well. Disallowing GUP has some side effects, like not 
getting these pages included in a coredump etc ... at least I hope 
nobody uses O_DIRECT on them.

> 
>>
>>>>>
>>>>> If we can't do pfnmap, and we definitely can't do mixedmap (because it's
>>>>> basically entirely equivalent in every way to just faulting in the pages as
>>>>> before and requires the same hacks) then I will have to go back to the drawing
>>>>> board or somehow change the faulting code.
>>>>>
>>>>> This really sucks.
>>>>>
>>>>> I'm not quite sure I even understand why we don't allow GUP used _just for
>>>>> pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
>>>>> whatever mapped it will maintain the lifetime.
>>>>>
>>>>> What a mess...
>>>>
>>>> Because VM_PFNMAP is dangerous as hell. To get a feeling for that (and also why I
>>>> raised my refcounting comment earlier) just read recent:
>>>>
>>>> commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
>>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Date:   Wed Sep 11 17:11:23 2024 -0700
>>>>
>>>>       mm: avoid leaving partial pfn mappings around in error case
>>>>       As Jann points out, PFN mappings are special, because unlike normal
>>>>       memory mappings, there is no lifetime information associated with the
>>>>       mapping - it is just a raw mapping of PFNs with no reference counting of
>>>>       a 'struct page'.
>>>>
>>>
>>> I'm _very_ aware of this, having worked extensively on things around this kind
>>> of issue recently (was a little bit involved with the above one too :), and
>>> explicitly zap on error in this patch to ensure we leave no broken code paths.
>>>
>>> I agree it's horrible, but we need to have a way of mapping this memory without
>>> having to 'trick' the faulting mechanism to behave correctly.
>>
>> What's completely "surprising" to me is, if there is no page_mkwrite, but
>> the VMA is writable, then just map the PTE writable ...
> 
> I've had a number of surprises on this journey :)
> 
> To make sure I understand what you mean do you mean the whole:
> 
> do_wp_page()
> -> wp_page_shared()
> -> if (page_mkwrite) { ... } else { wp_page_reuse(); }
> -> wp_page_reuse()
> -> maybe_mkwrite() [hey VM_WRITE is set, so yes make writable!]
> 
> Path?

Yes. I can see how it might be relevant (mprotect(PROT_READ) + 
mprotect(READ|WRITE)), but it's a bit counter-intuitive ... to default 
to "writable".

[...]

>>
> 
> So overall - given all the above and the fact that the alternatives are _even
> worse_ (having to spuriously folio lock if that'll even work, totally
> unnecessary and semantically incorrect folio-fication or a complete rework of
> mapping) - while you might be sicked by this use of the VM_PFNMAP - are you ok
> with the patch, all things considered? :)

It hurts my eyes, and feels like a step into the wrong direction. But I 
don't really see how to do it differently right now.

Can we add a comment/TODO in there that using remap_pfn_range this to 
map a kernel allocation really is suboptimal and we should switch to 
something better once we figured the details out?


BTW, I think the whole reason vm_insert_pages() touches the mapcount is 
because we didn't really have a way to identify during unmap that we 
must not adjust it either. A page->type will be able to sort that out 
(while still allowing to refcount them for now).

Actually, the whole thing is on my todo list, because messing with the 
RMAP with vm_insert_pages() doesn't make any sense (whereby the refcount 
might!). See the TODO I added in __folio_rmap_sanity_checks().

-- 
Cheers,

David / dhildenb


