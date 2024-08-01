Return-Path: <linux-kernel+bounces-270734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C1944493
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ECE2811BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A33158219;
	Thu,  1 Aug 2024 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uwnku9qR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E2157A55
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494200; cv=none; b=BGEXTSeJrBI+L1NnlltC62GKZIa696+eu5XVUd6AVG1Tzsgs4kQ1yqnB49i36E7xF+tueMMuwheoDJDp46PubjYPS8QdPg1A7tuEN6okpP/uw7DfwYMENG71fQ9IntP4is/ziCn/ILrctN49zimB4/vOk05pQknZgB1f/VVMJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494200; c=relaxed/simple;
	bh=RPeYw82iI2yi4hCIhCEySoLskBW6g5ofsGyj6THEYuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAdVwipS7q1BB8X3SuB1yYNYj6a+cUBJPss1L7RdVsHGoCV0n58Ie1/FO2ENil74AT1UqCZdYeN0qnIuByyYfm7VuLUTx7C48ZypmqjZiDIFO3a8nwlccF+pKrqJk2LeDUYicDxy7BLDhDtQgm9k4eTrZpV0+qk8W06aObm8Q/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uwnku9qR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722494197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cb/totuq+JgGG0BzVAs7Wb+RYqNKxWlie6oJKLYe5lo=;
	b=Uwnku9qRMlGlhHiqBdMveWm10+hxvoH3DeVUAhShd0PeFZRMaTX7oA/1Tl8T7me2VNhLLs
	yrJNjViiAE7GrzxG6oly1H+1TorWBOcsE4WLfiRh/xCmxOgigpzb652ERZ4Vd65rwHYOxg
	lEEC9t/JAbKFxNtDv17H+/6NkdgfRps=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-JAPDDZgyOS6U6qA4uV2Wcg-1; Thu, 01 Aug 2024 02:36:36 -0400
X-MC-Unique: JAPDDZgyOS6U6qA4uV2Wcg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3687f4f9fecso4337404f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494195; x=1723098995;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cb/totuq+JgGG0BzVAs7Wb+RYqNKxWlie6oJKLYe5lo=;
        b=o3Q/myEs4g3/BKPirw8fKNiaYniXHEQ8POzRBNvp9lQNlC44elgB53itdrXMKfc2C8
         bHSkNzh+vH07j9RBmV4LUDuWWzvAAS6ZxXZefmv6fCat9t1OkgOyV0EVtY2VPhURg7pc
         LEG2Td5zVnw1cl+atZVuRer1pOIUvLr2DELck8WWdwh0Z6aM5HZx1ZhrxoGPJMuMRxJq
         g4YAnggW19UKzdjMubDQCYleyhoh42BgkwPXuMWXcTht8uSrlrV/+8hoopvh+KT2w5Pe
         bHbAUzHxFnyQ3YXRKcYQZsK0d+Ph6Zto/jov6j+Tbe5w4em466GAK3rOFedTkfkVShNL
         NuXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsp7YDvVToHLb+aGEmztjgOpxyAZ4UiOzBnql+3MYuPwg9PItB+a7qvqdt4nLzM3NtAzx+3G6g1VcADcp87HowsACBOkWMV8WoBpaA
X-Gm-Message-State: AOJu0YwYsATq+Xk1fZIbttMHz2J/laF9GGpIYl8lUf70PG7ee62Fl0bG
	9kcuPh+VnTBZ9uf6EVNcZXrmiiFk2XXhw5WLqSpLUQzs8Tr6qPmjm5/QPNdzFlLZv9BK4Xrnmr8
	Frv6XXZ6ZraxfFTpR4jBv9Ro23MiRsb8z1rus0D/1ivPlzeU63RQnmZDQ9P2wig==
X-Received: by 2002:adf:e992:0:b0:367:dc45:55ab with SMTP id ffacd0b85a97d-36baade518bmr1452514f8f.25.1722494195232;
        Wed, 31 Jul 2024 23:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpxdLRTotVTjaWrDhucSBtKH5+dM+6yFVHA+rrdGMckWavDs9lo1Fs30CGNFwjyA3K7VXLvw==
X-Received: by 2002:adf:e992:0:b0:367:dc45:55ab with SMTP id ffacd0b85a97d-36baade518bmr1452484f8f.25.1722494194697;
        Wed, 31 Jul 2024 23:36:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d95c7sm18524076f8f.37.2024.07.31.23.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 23:36:34 -0700 (PDT)
Message-ID: <58025293-c70f-4377-b8be-39994136af83@redhat.com>
Date: Thu, 1 Aug 2024 08:36:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
 <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
 <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
 <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
 <4b9a9546-e97b-4210-979b-262d8cf37ba0@redhat.com>
 <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
 <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
 <204af83b-57ec-40d0-98c0-038bfeb393a3@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <204af83b-57ec-40d0-98c0-038bfeb393a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> I just added a bunch of quick printfs to QEMU and ran a precopy+postcopy live migration. Looks like my assumption was right:
>>
>> On the destination:
>>
>> Writing received pages during precopy # ram_load_precopy()
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Writing received pages during precopy
>> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
>> Discarding pages # loadvm_postcopy_ram_handle_discard()
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Registering UFFD # postcopy_ram_incoming_setup()
>>
> 
> Thanks for this, yes it makes sense after you mentioned postcopy_ram_incoming_setup.
> postcopy_ram_incoming_setup happens in the Listen phase, which is after the discard phase, so I was able to follow in code in qemu the same sequence of events that the above prints show.


I just added another printf to postcopy_ram_supported_by_host(), where 
we temporarily do a UFFDIO_REGISTER on some test area.

Sensing UFFD support # postcopy_ram_supported_by_host()
Sensing UFFD support
Writing received pages during precopy # ram_load_precopy()
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
Discarding pages # loadvm_postcopy_ram_handle_discard()
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Registering UFFD # postcopy_ram_incoming_setup()

We could think about using this "ever user uffd" to avoid the shared 
zeropage in most processes.

Of course, there might be other applications where that wouldn't work, 
but I think this behavior (write to area before enabling uffd) might be 
fairly QEMU specific already.

Avoiding the shared zeropage has the benefit that a later write fault 
won't have to do a TLB flush and can simply install a fresh anon page.

>>
>> Let me know if you need more information.
>>
>>> Thanks for pointing to mm_forbids_zeropage. Incorporating that into the code, and if I am (hopefully :)) right about qemu and kernel above, then I believe the right code should be:
>>
>> I'm afraid you are not right about the qemu code :)
>>
> 
> Yes, and also didn't consider MADV_DONTNEED! Thanks for explaining both of these things clearly. Its clear that pte_clear won't work in this case.
> 
> We don't need to clear_pte, just use zero_page for all cases. The original series from Alex did tlb flush, but looking further at the code, thats not needed. try_to_migrate() flushes tlb and installs migration entries which are not ‘present’ so will never be tlb cached. remove_migration_ptes() restores page pointers so tlb flushing is not needed. When using zeropage, we don't need make a distinction if uffd is used or not. i.e. we can just do below:
> 
> 	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))

It's worth noting that on s390x, MMs that forbid the zeropage also have 
THPs disabled. So we shouldn't really run into that that often (of 
course, it's subject to change in the future, so we better have this 
check here).

> 		return false;
> 
> 	newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
> 					pvmw->vma->vm_page_prot));
> 
> 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);

We're replacing a present page by another present page without doing a 
TLB flush in between. I *think* this should be fine because the new 
present page is R/O and cannot possibly be written to.

-- 
Cheers,

David / dhildenb


