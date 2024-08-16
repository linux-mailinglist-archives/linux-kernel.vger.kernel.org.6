Return-Path: <linux-kernel+bounces-289400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 480069545D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A697FB25D06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC913DDAD;
	Fri, 16 Aug 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="By+vusDh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1814037F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800640; cv=none; b=FjXUs9FzgrxgHwbhHiVAuWPlYxzHyDMsHC9WkWQtsgktbX2iPTmc2LtA4kt38ypvQ7svv64ufcvER+Lq3mbPbzegWG/5Aqxh3ETQdbofcOqT1ceIr4ecNVrHR6rJzb3D5hmoGH5MTFboks9nQIArThMPi8AiYHqyiqSclo27yus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800640; c=relaxed/simple;
	bh=zAvYJi4EOcO2R6w8XjqmZ2Wck4aV8xG3tZQAZsJwtFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB5YC52V4V0FSTW1neH4pjJ0/kVCHIoh/Dra2MpyIemkstug0+HZQGhqgyuZ74AQVeQ3fI4riqwOj2TXwOnTD766UCdkKmnjdmnyg+p4y58DQyOwzWfbSWL8GL9Pc8mpLrl7tlYkVFGlgJzdsyL64h1RL4N4S2ZNaRDmALeBtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=By+vusDh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723800637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NLb4Q7+UUOa/CsKSq8OSgFkms0X+cbk9M5Qrb4SXhVI=;
	b=By+vusDhIl8u28ibYmYAB4JdcQoJsnzfJh7JHEyBKQrrfxXsm7tKBl+VaCTlkpxw9oKCsL
	d1KktOMcgjg23K0ioCFj8MJjM3WDcKMUCxyh0ucIacz6kYdBGlU+fywvUYDq475zJwfALg
	WfvKXLX9Yuw6MXgljZ26Gs7GBBoEZOw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-eVhgs-tYMpqc-rMLrSx2Fg-1; Fri, 16 Aug 2024 05:30:36 -0400
X-MC-Unique: eVhgs-tYMpqc-rMLrSx2Fg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3718eb22836so595372f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800635; x=1724405435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NLb4Q7+UUOa/CsKSq8OSgFkms0X+cbk9M5Qrb4SXhVI=;
        b=mFUzi3wz4436emAjbp1tV322O5nqJ0u3nng1gts3SjWtwBXCmIoeN8wdVl+KjxvZQK
         FEdBXuT9BLZGdxlvMBimDztAufQjk5+JhdtHiDhsvAGx+IWyAkuGG9UkH7BNXLYnFsAB
         3Nnymk/0zFCmKXodtNjebsHa2xYsPydsDGp4QxFC2nKb5dqcf6KltJwUilWXYpnhpSbD
         eNXqofiIAzWgsgML1W9GEKLclO51eWij9aCqNbEcfSQiyzaoejI5hzZc4sgZllq5JgK1
         d/rU3lswTFmVK8ZXem/IH2r0OuYA7wNSnxEIhUeAXfLmNIGzFAXPayy5+4deSuhp1d04
         ONhA==
X-Forwarded-Encrypted: i=1; AJvYcCUbe88ZPY5SY2yus8pb6No2tc390UhtVZzHIlkhdYtE3GOXbVL4D+vB18GXRQVOTQ5qbz2CpyOB4pqZuQiC28izM2WSbfch7npQuaod
X-Gm-Message-State: AOJu0YxRVHZqKGCcYMlh45xTBjfGPerevUGps3bA21chKMpuINDrWLxl
	re0C0B10K5Pk1eeuVwZSEahKxw4SXGzqiWaWaGTJiFBGF1uK0PuWgyjDcqN35ZlAu36Ah0XVTN+
	Tg0Kjwc7IaZB4Xc9wc3mLBOgxUX3ZZmaBoK+CSqRi6Ud+gqfNp7VWk+DUFfQ0+w==
X-Received: by 2002:adf:eec8:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-37194327f7fmr1308280f8f.14.1723800634959;
        Fri, 16 Aug 2024 02:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7LF7FBgLdDjtQXE+pjEBdNPJzctLaH9IaGtweDy/jM8u0K+4cxS2jdLK6kv15WIvpFzxFdA==
X-Received: by 2002:adf:eec8:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-37194327f7fmr1308255f8f.14.1723800634420;
        Fri, 16 Aug 2024 02:30:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a05sm3206277f8f.26.2024.08.16.02.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:30:34 -0700 (PDT)
Message-ID: <81080764-7c94-463f-80d3-e3b2968ddf5f@redhat.com>
Date: Fri, 16 Aug 2024 11:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] mm/pagewalk: Check pfnmap early for
 folio_walk_start()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Oscar Salvador <osalvador@suse.de>, Axel Rasmussen
 <axelrasmussen@google.com>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Will Deacon <will@kernel.org>, Gavin Shan
 <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-7-peterx@redhat.com>
 <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com> <ZrZJqd8FBLU_GqFH@x1n>
 <d9d1b682-cf3c-4808-ba50-56c75a406dae@redhat.com>
 <20240814130525.GH2032816@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240814130525.GH2032816@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.24 15:05, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 07:25:36PM +0200, David Hildenbrand wrote:
> 
>>>> That is in general not what we want, and we still have some places that
>>>> wrongly hard-code that behavior.
>>>>
>>>> In a MAP_PRIVATE mapping you might have anon pages that we can happily walk.
>>>>
>>>> vm_normal_page() / vm_normal_page_pmd() [and as commented as a TODO,
>>>> vm_normal_page_pud()] should be able to identify PFN maps and reject them,
>>>> no?
>>>
>>> Yep, I think we can also rely on special bit.
> 
> It is more than just relying on the special bit..
> 
> VM_PFNMAP/VM_MIXEDMAP should really only be used inside
> vm_normal_page() because thay are, effectively, support for a limited
> emulation of the special bit on arches that don't have them. There are
> a bunch of weird rules that are used to try and make that work
> properly that have to be followed.
> 
> On arches with the sepcial bit they should possibly never be checked
> since the special bit does everything you need.
> 
> Arguably any place reading those flags out side of vm_normal_page/etc
> is suspect.

IIUC, your opinion matches mine: VM_PFNMAP/VM_MIXEDMAP and 
pte_special()/... usage should be limited to 
vm_normal_page/vm_normal_page_pmd/ ... of course, GUP-fast is special 
(one of the reason for "pte_special()" and friends after all).

> 
>>> Here I chose to follow gup-slow, and I suppose you meant that's also wrong?
>>
>> I assume just nobody really noticed, just like nobody noticed that
>> walk_page_test() skips VM_PFNMAP (but not VM_IO :) ).
> 
> Like here..
> 
>>> And, just curious: is there any use case you're aware of that can benefit
>>> from caring PRIVATE pfnmaps yet so far, especially in this path?
>>
>> In general MAP_PRIVATE pfnmaps is not really useful on things like MMIO.
>>
>> There was a discussion (in VM_PAT) some time ago whether we could remove
>> MAP_PRIVATE PFNMAPs completely [1]. At least some users still use COW
>> mappings on /dev/mem, although not many (and they might not actually write
>> to these areas).
> 
> I've squashed many bugs where kernel drivers don't demand userspace
> use MAP_SHARED when asking for a PFNMAP, and of course userspace has
> gained the wrong flags too. I don't know if anyone needs this, but it
> has crept wrongly into the API.
> 
> Maybe an interesting place to start is a warning printk about using an
> obsolete feature and see where things go from there??

Maybe we should start with some way to pr_warn_ONCE() whenever we get a 
COW/unshare-fault in such a MAP_PRIVATE mapping, and essentially 
populate the fresh anon folio.

Then we don't only know who mmaps() something like that, but who 
actually relies on getting anon folios in there.

-- 
Cheers,

David / dhildenb


