Return-Path: <linux-kernel+bounces-185878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F78CBC52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31121B216C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E207E0FB;
	Wed, 22 May 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjriuPmk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026B7C0B7
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364138; cv=none; b=EnPj2dosqrYKsRkt8Fesk2l+9lex+IVsfs1Wi8aUTexiNmUmFvrXb19h1fWrxyf7ZrM0mQewC5f5NwFMPFphJ6focgqna1AfjyVZclkURp+N8WYo4cTVJabxTO3DMB90yPX0PqmTm9tT4VOtfmsnb4+5LS2hvzRqAoZuGt9JbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364138; c=relaxed/simple;
	bh=ZulaAJosEsE4SXPulE9oF463+8VOyiF9FHt9hn1enaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3IrFuzni7hXZJHCHewi4xvcGiGdWOj0+wpL5nATtXQwLJkPeN/TRZe50F7ZnTbZAL8fCHo8KV+MQD+rQ4Ppg/yu/a8KLVdoHXHe9Eo7WPyIDUdpO3+3M6rIjituTQI7ej/B35viS0jYDybyp76hQUyKIz8G1Xv8hqV8BDm0C3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjriuPmk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716364136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=phV0a9Yi5QmyXuhVqbX1nibkB5NQY4qscA3tdGeagZo=;
	b=IjriuPmkJV5BEDpBC3a4l2kIhvKVLkOlEesnfpmg08Hejq07ouVzgeX4H5KFPtKFGIEgb0
	4h53TKVwCwCBuwTVLB951lCsODNpOArtsKAVlKPlp4aBnz7CIyss2O3QS5J1oVjsbAf0d0
	z/UeDmr1q33WZyCBKRuwD3+GwxhFiHM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-vkQLifxFPTGeTM7o8On25w-1; Wed, 22 May 2024 03:48:54 -0400
X-MC-Unique: vkQLifxFPTGeTM7o8On25w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354c00c01b0so2196635f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716364133; x=1716968933;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=phV0a9Yi5QmyXuhVqbX1nibkB5NQY4qscA3tdGeagZo=;
        b=XLSfkH93LRYzhwIoje0gAbAPjdM5vzgLjBOfY2/tIBKUG9vSjiepKkXJDvFWVY4yXO
         PUguASpgd1hXUojYZGszu+avmD2p4Bx5vKeevbKDk90nJDzlztyqez+iDrJQh8swrcBU
         sdLZu8XQgs8j2RY42dqJtNfwNpNQR6fsQxKO6p8SGYtb3DwA31Kxerbb5p/ln2uIo1Xi
         EzL4Q5RpwOpWxDIZuwFPEyqH8Yipf8rNvZ3Uuo7GVAgFatenOlBa7Wm5iYOW7FPaGmau
         kYpHnciFxMkyUeTYbU6m2iy5a2QNjOyzP9ZDe0rAXP/dP77NWUh1lV5VpuZwnei/t3md
         BxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXWjLxCVrOHu7NGT5RTnmqGGa6/OJAPwIVc7UMhOIis42KfWdEC5remgk/19Q/guKche5gEbS/i12eyyev78HoEXjYJ7Udu7RonIwx
X-Gm-Message-State: AOJu0YzBcSM+/ASqdVlcF+192od9ZWz8HSyRIKvV/tfiUzXj3PuvHvYs
	nagUf0JsPi3jZcJjm7rkisxLgC6+El+P5gSlJf6hvY4VNGdqxri+alElWvEkKjw4jzdtVW5+qo7
	TFQ8DM6IUfaRw4BQgz4lwvBYi1zDqFHLErRuY+YykXhnqbWjW+c5nAe/64T9/Hg==
X-Received: by 2002:a5d:69c7:0:b0:354:f16a:3b1a with SMTP id ffacd0b85a97d-354f16a3d80mr179823f8f.39.1716364133106;
        Wed, 22 May 2024 00:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/i8LxpSaeeGUAgY1y0rGEESeV3Xdj0J8pTf+jaNoxxM4TqxHTlKSWivb1a38H13XeqPDaeQ==
X-Received: by 2002:a5d:69c7:0:b0:354:f16a:3b1a with SMTP id ffacd0b85a97d-354f16a3d80mr179803f8f.39.1716364132604;
        Wed, 22 May 2024 00:48:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354df9b51f7sm622003f8f.59.2024.05.22.00.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 00:48:52 -0700 (PDT)
Message-ID: <a3d54407-87aa-4f59-adac-c9b79fe1ecef@redhat.com>
Date: Wed, 22 May 2024 09:48:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
To: Peter Xu <peterx@redhat.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com,
 nadav.amit@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
 <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
 <Zk0h0V8kvZRKu6F4@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zk0h0V8kvZRKu6F4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.05.24 00:36, Peter Xu wrote:
> On Wed, May 22, 2024 at 03:21:04AM +0500, Mikhail Gavrilov wrote:
>> On Wed, May 22, 2024 at 2:37 AM Peter Xu <peterx@redhat.com> wrote:
>>> Hmm I still cannot reproduce.  Weird.
>>>
>>> Would it be possible for you to identify which line in debug_vm_pgtable.c
>>> triggered that issue?
>>>
>>> I think it should be some set_pte_at() but I'm not sure, as there aren't a
>>> lot and all of them look benign so far.  It could be that I missed
>>> something important.
>>
>> I hope it's helps:
> 
> Thanks for offering this, it's just that it doesn't look coherent with what
> was reported for some reason.
> 
>>
>>> sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/(uname -r)/vmlinux debug_vm_pgtable+0x1c04
>> debug_vm_pgtable+0x1c04/0x3360:
>> native_ptep_get_and_clear at arch/x86/include/asm/pgtable_64.h:94
>> (inlined by) ptep_get_and_clear at arch/x86/include/asm/pgtable.h:1262
>> (inlined by) ptep_clear at include/linux/pgtable.h:509
> 
> This is a pte_clear(), and pte_clear() shouldn't even do the set() checks,
> and shouldn't stumble over what I added.
> 
> IOW, it doesn't match with the real stack dump previously:
> 
> [    5.581003]  ? __page_table_check_ptes_set+0x306/0x3c0
> [    5.581274]  ? __pfx___page_table_check_ptes_set+0x10/0x10
> [    5.581544]  ? __pfx_check_pgprot+0x10/0x10
> [    5.581806]  set_ptes.constprop.0+0x66/0xd0
> [    5.582072]  ? __pfx_set_ptes.constprop.0+0x10/0x10
> [    5.582333]  ? __pfx_pte_val+0x10/0x10
> [    5.582595]  debug_vm_pgtable+0x1c04/0x3360
> 

Staring at pte_clear_tests():

#ifndef CONFIG_RISCV
	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
#endif
	set_pte_at(args->mm, args->vaddr, args->ptep, pte);

So we set random PTE bits, probably setting the present, uffd and write 
bit at the same time. That doesn't make too much sense when we want to 
perform that such combinations cannot exist.

In pmd_clear_tests() and friends we use WRITE_ONCE() instead, so there 
we don't run into trouble.

-- 
Cheers,

David / dhildenb


