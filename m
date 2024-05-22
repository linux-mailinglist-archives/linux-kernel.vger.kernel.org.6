Return-Path: <linux-kernel+bounces-186691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CF8CC7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF271F21914
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135D1465A2;
	Wed, 22 May 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnvQtoVZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34831422AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409563; cv=none; b=Ox7hYLqE2cNp5GDTkTOPdo0QyZBbz0TljyjIAWXzTqFrlZ+UZlhPz69a5bVau25NaGzyeTw4iPHPEUHmKfL0EkHzbdN5fZpo87/pO6XC+7HAa2ZCtW3EpzyyPBqlsn6WM6m6RIBYmmJ97WRBbq2GJwhH/bzRNC+jtvhjB60Qi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409563; c=relaxed/simple;
	bh=45T5zC6PAKnjG7hPcemv+Gvo024WV3JjthrTyv4RFf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHLdXRjYgmPJuMNKRXl8JFQz6RdTvWAbx+Rd/Vs1e1XVTsI9SwoW1GdYJQr5an4K/T4Q4C/zl3aezBWuSd4WqY9Fy5v90t4Y8V/k1cv6aiDoH0IUsT8r8IuRVmqk5BsKyieXrA09lgDz3nHtxFdCvigY6J0lhfVY8TUYEyWAjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnvQtoVZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716409560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gZALvGdcjSpjvohHOcQVL4xUs9hI4UVrL4ZOmtKsjao=;
	b=RnvQtoVZ2ckfVwLLZlk+MHYWZ7OPBIR8ce9Eb9mGotRpYAvRwxfJWWQdD5DVOEQ5CKFNxq
	P6rDcUx061NSMNn0+fOeDKeFbm7T3NnYQVqmV8zNG5BwTp/sK8aTVq65ihBm4Tz8UDSkW1
	h41hEfi1vBm/FoE+copNIgBMClCB7QM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-swst-oTYPMO6aOvjv7UEIg-1; Wed, 22 May 2024 16:25:59 -0400
X-MC-Unique: swst-oTYPMO6aOvjv7UEIg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34db1830d7cso798224f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716409558; x=1717014358;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gZALvGdcjSpjvohHOcQVL4xUs9hI4UVrL4ZOmtKsjao=;
        b=ng4oCKHC6cNZK1gQs1H+0ld/7ugB2vupp51r+2h2GUEzc1NmCc3Tszn7zXfiBXLsuN
         zu9E8XcZLmE0sPgCmooiOvPJuL4LsMAuOpvmFRSRZoGjNWZ4qhqGAeSAA8o2Db6YaMhr
         wefHewVJfcZMzAz7x+MGlqdbiUUJnEJJmXPTOWjqsGG6zrznxDVe1qyN4ns1yxwoyxWP
         vVBjrTCa6ij0n0RgoBEcG/jmLKqtA8WeEV4MUckSg1XR1rAMflMK33ENiFCWAHWOOKLj
         hDsH2/fNgW6UizUKTLkE70lGT3gV0kqJ+VwFImWqpce6VFf/2g2n35YdLCTttn18Gtq8
         6psg==
X-Forwarded-Encrypted: i=1; AJvYcCViXkT587I2UDf1xMPoSSqbzafzMyurmh74kbn4eCOSnMGdkyyNSiIaALW/Og1YVaDOsbM1OT5JPCWWb6ceFHBvzWNHMRa/T+uiwa5w
X-Gm-Message-State: AOJu0YzOO3bgJ82npj5p8QKOK63KhqlGZQ4oBwhEEwQzJlrldzNXPuC4
	oG1/FpQ2Dtu7DR1/LTg7Ztx8TkFQoTGEvutWHUw6KTv/qief9ztgjg8Xf0vkgL1Pz+JYVJMqfDK
	z69St3De8Jfz8EbbYcWxhlKynT7EKWbuTAldL4GJLBs9ttlHDGfuAbnoUPgKIUA==
X-Received: by 2002:a5d:46d0:0:b0:34e:3d3a:e144 with SMTP id ffacd0b85a97d-354f74ff762mr239232f8f.2.1716409558050;
        Wed, 22 May 2024 13:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfrGKCogoOqka0H47iN5AlSMonGlSalasIrh9d5HYGuYjbAAYbcl7DYG3ogzwS4hxPtAMhJw==
X-Received: by 2002:a5d:46d0:0:b0:34e:3d3a:e144 with SMTP id ffacd0b85a97d-354f74ff762mr239220f8f.2.1716409557566;
        Wed, 22 May 2024 13:25:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77easm34985826f8f.53.2024.05.22.13.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 13:25:57 -0700 (PDT)
Message-ID: <ff978ce9-bd22-4ee2-ba14-6dd8ee0b05dd@redhat.com>
Date: Wed, 22 May 2024 22:25:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
To: Peter Xu <peterx@redhat.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com,
 nadav.amit@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
 <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
 <Zk0h0V8kvZRKu6F4@x1n> <a3d54407-87aa-4f59-adac-c9b79fe1ecef@redhat.com>
 <Zk4MsGxhP5x5aURG@x1n> <03faa624-1685-4a21-81fc-cc9e8b760e97@redhat.com>
 <Zk4Y9tU7pOzU0lw1@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zk4Y9tU7pOzU0lw1@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.05.24 18:10, Peter Xu wrote:
> On Wed, May 22, 2024 at 05:34:21PM +0200, David Hildenbrand wrote:
>> On 22.05.24 17:18, Peter Xu wrote:
>>> On Wed, May 22, 2024 at 09:48:51AM +0200, David Hildenbrand wrote:
>>>> On 22.05.24 00:36, Peter Xu wrote:
>>>>> On Wed, May 22, 2024 at 03:21:04AM +0500, Mikhail Gavrilov wrote:
>>>>>> On Wed, May 22, 2024 at 2:37 AM Peter Xu <peterx@redhat.com> wrote:
>>>>>>> Hmm I still cannot reproduce.  Weird.
>>>>>>>
>>>>>>> Would it be possible for you to identify which line in debug_vm_pgtable.c
>>>>>>> triggered that issue?
>>>>>>>
>>>>>>> I think it should be some set_pte_at() but I'm not sure, as there aren't a
>>>>>>> lot and all of them look benign so far.  It could be that I missed
>>>>>>> something important.
>>>>>>
>>>>>> I hope it's helps:
>>>>>
>>>>> Thanks for offering this, it's just that it doesn't look coherent with what
>>>>> was reported for some reason.
>>>>>
>>>>>>
>>>>>>> sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/(uname -r)/vmlinux debug_vm_pgtable+0x1c04
>>>>>> debug_vm_pgtable+0x1c04/0x3360:
>>>>>> native_ptep_get_and_clear at arch/x86/include/asm/pgtable_64.h:94
>>>>>> (inlined by) ptep_get_and_clear at arch/x86/include/asm/pgtable.h:1262
>>>>>> (inlined by) ptep_clear at include/linux/pgtable.h:509
>>>>>
>>>>> This is a pte_clear(), and pte_clear() shouldn't even do the set() checks,
>>>>> and shouldn't stumble over what I added.
>>>>>
>>>>> IOW, it doesn't match with the real stack dump previously:
>>>>>
>>>>> [    5.581003]  ? __page_table_check_ptes_set+0x306/0x3c0
>>>>> [    5.581274]  ? __pfx___page_table_check_ptes_set+0x10/0x10
>>>>> [    5.581544]  ? __pfx_check_pgprot+0x10/0x10
>>>>> [    5.581806]  set_ptes.constprop.0+0x66/0xd0
>>>>> [    5.582072]  ? __pfx_set_ptes.constprop.0+0x10/0x10
>>>>> [    5.582333]  ? __pfx_pte_val+0x10/0x10
>>>>> [    5.582595]  debug_vm_pgtable+0x1c04/0x3360
>>>>>
>>>>
>>>> Staring at pte_clear_tests():
>>>>
>>>> #ifndef CONFIG_RISCV
>>>> 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>>>> #endif
>>>> 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>>>>
>>>> So we set random PTE bits, probably setting the present, uffd and write bit
>>>> at the same time. That doesn't make too much sense when we want to perform
>>>> that such combinations cannot exist.
>>>
>>> Here the issue is I don't think it should set W bit anyway, as we init
>>> page_prot to be RWX but !shared:
>>>
>>> 	args->page_prot          = vm_get_page_prot(VM_ACCESS_FLAGS);
>>>
>>> On x86_64 (Mikhail's system) it should have W bit cleared afaict, meanwhile
>>> the RANDOM_ORVALUE won't touch bit W due to S390_SKIP_MASK (which contains
>>> bit W / bit 1, which is another "accident"..).  Then even if with that it
>>> should not trigger..  I think that's also why I cannot reproduce this
>>> problem locally.
>>
>> Why oh why are skip mask applied independently of the architecture.
>>
>> While _PAGE_RW should indeed be masked out by RANDOM_ORVALUE.
>>
>> But with shadow stacks we consider a PTE writable (see
>> pte_write()->pte_shstk()) if
>> (1) X86_FEATURE_SHSTK is enabled
>> (2) _PAGE_RW is clear
>> (3) _PAGE_DIRTY is set
>>
>> _PAGE_DIRTY is bit 6.
>>
>> Likely your CPU does not support shadow stacks.
> 
> Good point.  My host has it, but I tested in the VM which doesn't.  I
> suppose we can wait and double check whether Mikhail should see the issue
> went away with that patch provided.
> 
> In this case, instead of keep fiddling with random bits to apply and
> further work on top of per-arch random bits, I'd hope we can simply drop
> that random mechanism as I don't think it'll be pxx_none() now.  I attached
> a patch I plan to post. Does it look reasonable?

I doubt that randomness ever helped in finding a BUG. Clearing is just 
too simple ... but I might just be wrong :)

I'd vote for removing that, this will likely not be the last issue we 
run into once we add more sanity checks during set_pte_at().

-- 
Cheers,

David / dhildenb


