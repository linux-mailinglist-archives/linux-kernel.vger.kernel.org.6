Return-Path: <linux-kernel+bounces-541211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F84A4B9FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6981162ADB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5E1F3D50;
	Mon,  3 Mar 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IThvrX53"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41801F3BB0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991976; cv=none; b=iyZNoZ370xTChiS95EIU8Wl5RHMyAqkbRO14gKg8FBkrJ0ts8zm8tNqXjm0F033oEoriKGTpfl8O2Bf2OUZUVUjbwk/9e2gjWpWsHkwy9O/ETi8pw3d55bBmvGI14MnKS9yx6OHnZb6zMq9K5kxF6DMLy1YYuZw11myrLURsaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991976; c=relaxed/simple;
	bh=QRmrnj+++rGjqFLqafrF9yanPhwbwa3cHIpxW9YQp/Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jZHp03vwwEIHn2VPmgxEV6aTPaG3pbLC0CPcUmrJvrt8hsWnAZcf+Ue90wjCJmjb19smeNOeOS9vqnWcV50eDhGr3U8C54NfqGujBD7XPqsmH1d8FgqugRLF1Ilr5RlN9c4de+3qNnIw5Fal/VogzFb4GzBkKn1pfhqF8gIxf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IThvrX53; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L2Teo9Rbchbz42+Q6lAs3ttlkWMO9/zXQmWUHGDFFeQ=;
	b=IThvrX53v9z6BQiUEvEJ+zq0+SX4kbr5qbAI3KmJYA7re5zpwWCjjkP0J9+J6P95fPKDDQ
	DpeGXXNnBNgqcppk9BjLOxSTlx2J61SzXR64/KsliAgyaH0rGB28jl9ej8n/7KPDW5gb7H
	nYb7V+BLbX6JP6QL7bOg4tcbZNDNBAc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-kCSvLChoMbGdyDNkOO9c-A-1; Mon, 03 Mar 2025 03:52:52 -0500
X-MC-Unique: kCSvLChoMbGdyDNkOO9c-A-1
X-Mimecast-MFC-AGG-ID: kCSvLChoMbGdyDNkOO9c-A_1740991971
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so21769905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991971; x=1741596771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L2Teo9Rbchbz42+Q6lAs3ttlkWMO9/zXQmWUHGDFFeQ=;
        b=hjJGGi+SvCNnPvbODMdfBvb+rjhvRGAD2vmfgDsC1NNzC1zBCFVyf5yBcMfb0FP2CH
         WFlywSmIRZNkcn/cYu+p5O9LREFFidXNUWoxgJqghu/SgpPZjgHdXm61pnktYUCuiKp1
         aoUBqkP3fwMLC/b0nyaGC13PN5TIKg01JySPQZW9ZS2HrVvFChfD/QFCMwOku5ncXl9N
         mGiAnEcxKuE454+Mzb9ABwhSKSJqDsSgF+rQjNfEjyFWoVocc57nDR+Suea+qGd3XSet
         a2Bn2Axh42hSlA5WrHvyoZvS2XnILEnPKIQun7C2ufZo8ERu2RLu8iAGstuyVF8+K7wg
         dYHg==
X-Forwarded-Encrypted: i=1; AJvYcCXDDJggG3wIjlp8wqoY843O25vzbqH9/I1gR6dYkYwt1AVli9fBB/O70AajrX34zPfZt2EPPrWJrSA0nck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKh5+vIlnl4gITX0yDUAyvqxdDOvXkMSRF7fN37Z557L/HMvU
	3eG8tEDAqVzC1dHJmgGWM+WIOqN2TQBekkHniN5VseTiKfJ2hpZpiLV5lZzx2TO+R7wE+d2pmX+
	hv0nXkuYBH2Xk75fZQB0AhxrTkeMIz2vP6THit5/NOjfUwCoXGzW6DCrmrvW8nw==
X-Gm-Gg: ASbGncsrypVFbFAvEvb7/Old+nCiHBgnFLLOV1IlnWEf0StJo78hVKv8Bi7Y/va7zAT
	REUamxdN446yyyW5fM0jFHwU/JUOrQRotLYfHHY08bjZkgCTRQxF2fT4x4gcydbcY7k12841Q0Z
	69nKxIUmxTQnq1RrVHcgEr4xrME6Vm0FHEPUuprDE3O8Wr7oZDWOYezu6PmsfxPTKSvTVgiJxhI
	sLFjNuktZn0V9kVKecTYrsJJ0tsPPoWhzoR5X2S89TMcM0fCcCFeELqSRi4Qg+2avxwfHYuCYea
	UoqcIK1OWF2s3jogNTXLCkIwd+G0A/qSwP/AHoOx+5jAN05Bol7kfCDC5LPJLWhdtaVnf1uYsO+
	Zh+My4RyMP9p+W40YS8T7jS1+N4alN+t65TaSPJfAgoQ=
X-Received: by 2002:a05:600c:1c9f:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-43ba6188e94mr94869015e9.0.1740991971264;
        Mon, 03 Mar 2025 00:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlTwiOKza9n0r0V0jJ5URyFDI8eh36wv7IjAnT7iFLb3kZ3OtN1WSRH/ph1nyV3LFOLXmlUQ==
X-Received: by 2002:a05:600c:1c9f:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-43ba6188e94mr94868805e9.0.1740991970936;
        Mon, 03 Mar 2025 00:52:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b8d6bc3fcsm122643735e9.0.2025.03.03.00.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:52:50 -0800 (PST)
Message-ID: <a9e21c14-d390-4119-ad93-b23e6ccbac15@redhat.com>
Date: Mon, 3 Mar 2025 09:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] mm: Fix lazy mmu docs and usage
From: David Hildenbrand <david@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-2-ryan.roberts@arm.com>
 <5418a661-dbd0-46e9-8ef7-b1c5a34acce3@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5418a661-dbd0-46e9-8ef7-b1c5a34acce3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 09:49, David Hildenbrand wrote:
> On 02.03.25 15:55, Ryan Roberts wrote:
>> The docs, implementations and use of arch_[enter|leave]_lazy_mmu_mode()
>> is a bit of a mess (to put it politely). There are a number of issues
>> related to nesting of lazy mmu regions and confusion over whether the
>> task, when in a lazy mmu region, is preemptible or not. Fix all the
>> issues relating to the core-mm. Follow up commits will fix the
>> arch-specific implementations. 3 arches implement lazy mmu; powerpc,
>> sparc and x86.
>>
>> When arch_[enter|leave]_lazy_mmu_mode() was first introduced by commit
>> 6606c3e0da53 ("[PATCH] paravirt: lazy mmu mode hooks.patch"), it was
>> expected that lazy mmu regions would never nest and that the appropriate
>> page table lock(s) would be held while in the region, thus ensuring the
>> region is non-preemptible. Additionally lazy mmu regions were only used
>> during manipulation of user mappings.
>>
>> Commit 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy
>> updates") started invoking the lazy mmu mode in apply_to_pte_range(),
>> which is used for both user and kernel mappings. For kernel mappings the
>> region is no longer protected by any lock so there is no longer any
>> guarantee about non-preemptibility. Additionally, for RT configs, the
>> holding the PTL only implies no CPU migration, it doesn't prevent
>> preemption.
>>
>> Commit bcc6cc832573 ("mm: add default definition of set_ptes()") added
>> arch_[enter|leave]_lazy_mmu_mode() to the default implementation of
>> set_ptes(), used by x86. So after this commit, lazy mmu regions can be
>> nested. Additionally commit 1a10a44dfc1d ("sparc64: implement the new
>> page table range API") and commit 9fee28baa601 ("powerpc: implement the
>> new page table range API") did the same for the sparc and powerpc
>> set_ptes() overrides.
>>
>> powerpc couldn't deal with preemption so avoids it in commit
>> b9ef323ea168 ("powerpc/64s: Disable preemption in hash lazy mmu mode"),
>> which explicitly disables preemption for the whole region in its
>> implementation. x86 can support preemption (or at least it could until
>> it tried to add support nesting; more on this below). Sparc looks to be
>> totally broken in the face of preemption, as far as I can tell.
>>
>> powewrpc can't deal with nesting, so avoids it in commit 47b8def9358c
>> ("powerpc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes"),
>> which removes the lazy mmu calls from its implementation of set_ptes().
>> x86 attempted to support nesting in commit 49147beb0ccb ("x86/xen: allow
>> nesting of same lazy mode") but as far as I can tell, this breaks its
>> support for preemption.
>>
>> In short, it's all a mess; the semantics for
>> arch_[enter|leave]_lazy_mmu_mode() are not clearly defined and as a
>> result the implementations all have different expectations, sticking
>> plasters and bugs.
>>
>> arm64 is aiming to start using these hooks, so let's clean everything up
>> before adding an arm64 implementation. Update the documentation to state
>> that lazy mmu regions can never be nested, must not be called in
>> interrupt context and preemption may or may not be enabled for the
>> duration of the region.
>>
>> Additionally, update the way arch_[enter|leave]_lazy_mmu_mode() is
>> called in pagemap_scan_pmd_entry() to follow the normal pattern of
>> holding the ptl for user space mappings. As a result the scope is
>> reduced to only the pte table, but that's where most of the performance
>> win is. While I believe there wasn't technically a bug here, the
>> original scope made it easier to accidentally nest or, worse,
>> accidentally call something like kmap() which would expect an immediate
>> mode pte modification but it would end up deferred.
>>
>> arch-specific fixes to conform to the new spec will proceed this one.
>>
>> These issues were spotted by code review and I have no evidence of
>> issues being reported in the wild.
>>
> 
> All looking good to me!
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

... but I do wonder if the set_ptes change should be split from the 
pagemap change.

-- 
Cheers,

David / dhildenb


