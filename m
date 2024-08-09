Return-Path: <linux-kernel+bounces-281310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24994D562
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24BD1F21BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8245A4D5;
	Fri,  9 Aug 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbZxEJkJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2AF482E9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224345; cv=none; b=n++Wuje8ec2Ko75DSt+EFChB0CiDKtGDR24J9xygbxazzk/lL2qG0tRFD1aaBHK+HTJ8tBIVS+gMPJ6+lwm7IYqvN1UyZFPl3dwitCJMQZBBbnBtApkDxn9k3Lfc/G7CMYxvcGfi0Pd0WyJt5HWpYVA/HWSskzeQYwt+W0vLpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224345; c=relaxed/simple;
	bh=agzMDZhMtbxjTYc5+CDPbrma9eRxatZdCqxrBmeyFUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB/hwEze6tAvKUUzhe6CvbWjJwxxbsimRzs5i44FJWh6sTmtorc32AI0EoDhZ/O0u08fskWCPvOfDo8In4NgC0lPcLbGTJPqWrAtK7VVEII3RIhIVzbh0MpqRhxIb9+MmmizyKmvw+62/ePwc7MtN/YIxfjDKb2xHYuhufrM7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbZxEJkJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723224342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u4wjcaS0nOJw/BDeSInCZohj2LY/TXzLpPqdNfFIyns=;
	b=XbZxEJkJqNjnKs7AKSyULd2MnKApEm8CFJA2X6KAEN9dhMF0MRPKhr0nM1bm0z0WssF2YN
	jZ13zPyJgJAopQFKN/91KItr7Np7wM7EVAfHgYTYM6t/q24ouxmqmcyqMCEss4opj/i2EX
	JeDvj+4diIrb9dhXhy15xq7A+bw5EnI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-gLOMVAr7Pniwz2BA1VcQ3A-1; Fri, 09 Aug 2024 13:25:41 -0400
X-MC-Unique: gLOMVAr7Pniwz2BA1VcQ3A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-530e1f3ed95so2401449e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224340; x=1723829140;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u4wjcaS0nOJw/BDeSInCZohj2LY/TXzLpPqdNfFIyns=;
        b=V6P8Z1ZRoGi74dMeyBvdu6cUNLJfwi5wS090V6H1pxbzJKxpeYxCjeqHl9Q/POX3Dn
         RBbiQiw2aK2eYXQWBbawM6bhFMOWS1RDCJWi3dx4woAMhPQz6dSdSm+9S2tIlinbvLy+
         zRSJKp4PC3Y4gTBu3vuy51GyzX57QCnasJvg2T7MpSfib8J2gsA2r6z+bRW5ftgupcle
         xnfGhaOBylCrcMYyZZDFv8Clw4DgHokKqBcIIxEAdcpncNcFxnP3iBpehk8uJt5RkGrX
         5AZzrd65u3WPZ6ZU2GWEAtqxwh6DzIM5t2vHvuqaqjy/wKHr1Ye4LfKYK5tYYQPbNeF/
         GH+g==
X-Forwarded-Encrypted: i=1; AJvYcCV12o5f68hK45vr4L930DQJ6mutfpv7Bz0ToScGk8v5UVutCVeAq8szAV4QTucy2txZTG1j+ovCK0rFgWPUc41RzQIpBE5VaTihpQze
X-Gm-Message-State: AOJu0YxiPzLUYY1rW1jRv9XfDM1dYW1XTdaBRksNv2pgG79Gmzt4q34B
	cilVjEvUs7woCJyHfNT4aTk8nEGTxy754nCDBKvt7c/vxBdvns2gWVsrW/ZyS7HxrdpTXhpD+zO
	yUMtz7ZFAOtwy2hnznCDwvanP0O9T+XXIYHsw2p8ztOMOzCrK7awXqpVFWh0HBA==
X-Received: by 2002:a05:6512:2253:b0:52d:8f80:6444 with SMTP id 2adb3069b0e04-530ee9ec50dmr1632723e87.32.1723224339572;
        Fri, 09 Aug 2024 10:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNPbtkVWPX9gsyx6+P4sEzTboDQnnV/JoBOPf2QvhGRXHO26n++v13Udxw08CkqWqgv9ADcA==
X-Received: by 2002:a05:6512:2253:b0:52d:8f80:6444 with SMTP id 2adb3069b0e04-530ee9ec50dmr1632693e87.32.1723224338872;
        Fri, 09 Aug 2024 10:25:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437b0sm854325966b.114.2024.08.09.10.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 10:25:38 -0700 (PDT)
Message-ID: <d9d1b682-cf3c-4808-ba50-56c75a406dae@redhat.com>
Date: Fri, 9 Aug 2024 19:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] mm/pagewalk: Check pfnmap early for
 folio_walk_start()
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-7-peterx@redhat.com>
 <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com> <ZrZJqd8FBLU_GqFH@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZrZJqd8FBLU_GqFH@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 18:54, Peter Xu wrote:
> On Fri, Aug 09, 2024 at 06:20:06PM +0200, David Hildenbrand wrote:
>> On 09.08.24 18:08, Peter Xu wrote:
>>> Pfnmaps can always be identified with special bits in the ptes/pmds/puds.
>>> However that's unnecessary if the vma is stable, and when it's mapped under
>>> VM_PFNMAP | VM_IO.
>>>
>>> Instead of adding similar checks in all the levels for huge pfnmaps, let
>>> folio_walk_start() fail even earlier for these mappings.  It's also
>>> something gup-slow already does, so make them match.
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    mm/pagewalk.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>>> index cd79fb3b89e5..fd3965efe773 100644
>>> --- a/mm/pagewalk.c
>>> +++ b/mm/pagewalk.c
>>> @@ -727,6 +727,11 @@ struct folio *folio_walk_start(struct folio_walk *fw,
>>>    	p4d_t *p4dp;
>>>    	mmap_assert_locked(vma->vm_mm);
>>> +
>>> +	/* It has no folio backing the mappings at all.. */
>>> +	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
>>> +		return NULL;
>>> +
>>
>> That is in general not what we want, and we still have some places that
>> wrongly hard-code that behavior.
>>
>> In a MAP_PRIVATE mapping you might have anon pages that we can happily walk.
>>
>> vm_normal_page() / vm_normal_page_pmd() [and as commented as a TODO,
>> vm_normal_page_pud()] should be able to identify PFN maps and reject them,
>> no?
> 
> Yep, I think we can also rely on special bit.
> 
> When I was working on this whole series I must confess I am already
> confused on the real users of MAP_PRIVATE pfnmaps.  E.g. we probably don't
> need either PFNMAP for either mprotect/fork/... at least for our use case,
> then VM_PRIVATE is even one step further.

Yes, it's rather a corner case indeed.
> 
> Here I chose to follow gup-slow, and I suppose you meant that's also wrong?

I assume just nobody really noticed, just like nobody noticed that 
walk_page_test() skips VM_PFNMAP (but not VM_IO :) ).

Your process memory stats will likely miss anon folios on COW PFNMAP 
mappings ... in the rare cases where they exist (e.g., mmap() of /dev/mem).

> If so, would it make sense we keep them aligned as of now, and change them
> altogether?  Or do you think we should just rely on the special bits?

GUP already refuses to work on a lot of other stuff, so likely not a 
good use of time unless somebody complains.

But yes, long-term we should make all code either respect that it could 
happen (and bury less awkward checks in page table walkers) or rip 
support for MAP_PRIVATE PFNMAP out completely.

> 
> And, just curious: is there any use case you're aware of that can benefit
> from caring PRIVATE pfnmaps yet so far, especially in this path?

In general MAP_PRIVATE pfnmaps is not really useful on things like MMIO.

There was a discussion (in VM_PAT) some time ago whether we could remove 
MAP_PRIVATE PFNMAPs completely [1]. At least some users still use COW 
mappings on /dev/mem, although not many (and they might not actually 
write to these areas).

I'm happy if someone wants to try ripping that out, I'm not brave enough :)

[1] 
https://lkml.kernel.org/r/1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com

> 
> As far as I read, none of folio_walk_start() users so far should even
> stumble on top of a pfnmap, share or private.  But that's a fairly quick
> glimps only.

do_pages_stat()->do_pages_stat_array() should be able to trigger it, if 
you pass "nodes=NULL" to move_pages().

Maybe s390x could be tricked into it, but likely as you say, most code 
shouldn't trigger it. The function itself should be handling it 
correctly as of today, though.

-- 
Cheers,

David / dhildenb


