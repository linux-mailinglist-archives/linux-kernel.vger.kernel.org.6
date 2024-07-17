Return-Path: <linux-kernel+bounces-255272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23698933E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B5AB214FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E3180A8E;
	Wed, 17 Jul 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9tHcOm+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7A17F37E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225764; cv=none; b=H8At6e2ykuiHmpPBBJbYeHnwlDRSioTj8EDVxi3JeSzvjDQtdmEkd7KEbkUDOdXIALkOn0m9aEmIibSqPcxKbIxAEnnsSyXZrkO90bFmD3aAecuIErc4ABEDp8Tqpm+uEZO3x+OoiCX6h/rdKP/agyb5t7M2QG1rLxOMX3F1FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225764; c=relaxed/simple;
	bh=JfpJi0JE8mH6o9/elp/w3y1cC0pWJXwePfqTNJHJ6EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRegWVRXpi0finoPXqqh6O4X1ftiqiv6jMgH+m4BAMXScT4dbs1hpa22Dilo0rLRXaDJFTKgqYEky3YTD+nSJOIne/h8FmejGVJZIdy0yNhCVnT+/LiBHiHN75o2jlSA0T6vGx+iG2YNXx2E0+i+RaWc3CIl7nb9U0DueZZZZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9tHcOm+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721225761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1We4FFZxPkq/cjsrPbwaJfITzcRFUwgnw9gMpKh3MRY=;
	b=G9tHcOm+cAvLr2VeJTh6xdJTfbom9IayWZh1+oXvC06/GI15eZQk8/Crxci6mnTEu/n4uq
	C6TR78Lre8yThWm1MH59Zt7WtowVByz/eNVXuzIdWFOBnpa2dsymFQmtdwvklBUvjCkzCp
	A3FsHEfjClIZr65qkyUoGh6gIqbFLEE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-yCLkmCOqMcWHBOhfXMUgYA-1; Wed, 17 Jul 2024 10:14:19 -0400
X-MC-Unique: yCLkmCOqMcWHBOhfXMUgYA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42668699453so64324595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721225658; x=1721830458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1We4FFZxPkq/cjsrPbwaJfITzcRFUwgnw9gMpKh3MRY=;
        b=V8fgQp+ikjajTgOHEC1KTmCrALKVtacpZcxoA3aJdqkctnRhe4uJv3Xavv+l1jhy0n
         AKxOfJIu2FERQ/cA8l2cUVINT0Ymn36Myv8JqOAuN0LamMtr68laCB48J5ru8EFoqahK
         8MSRjjdFUR6ODCfXxh0hghgM9MqFa+Vg2emtSCWvMkkyKrw4hT9CXS6OWOelYcPkR6BH
         U1z+OyKhq3+hc1Gy6edF7qZSBC+s9JkBDTXroYsT+qEaGSA7fvywNJ0d8cUt6MbmPDyd
         uSBf9J0x7JhA+jIN6iopf8e53I+0pZ6jCj3qRKCc/OBKjlOc9oKuqBGJBXRTmnS+pM6C
         EfDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+I+XYIbidH2gzttcCswVXXyMkEcWnaawCLfTNL2vQ/cn9RbxeRTc9BmRps7ZwkHrX3GXJkFeFZmycMV7QQraVu3J0Ns2FR0KnvPmg
X-Gm-Message-State: AOJu0YywwJP01AJg5j1tTJ8AlnEelzd1maJYZHBlVMJBi2ZqaUaPqehG
	Pa+CvFowYFWezBa19u+R0Lqzf5b4Q6K22fkeZPQmLGmGBkrZQr9zZFIcxHR8eZEHb+2srag2hNO
	AP2c/gjTqUu5hu28cbW2f3cSScoPWYR9xVAELkNze8Y7V7bOb5yCsG4DCWSRJvg==
X-Received: by 2002:a05:600c:3411:b0:427:9dae:2768 with SMTP id 5b1f17b1804b1-427c2d119d7mr16164725e9.38.1721225658044;
        Wed, 17 Jul 2024 07:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCmyJmzOHq0FoH7UwKtGCBpWohzbLIPYi//OqduCZVEF7/TYb6wl2QBePnw96kUmoEKma5sA==
X-Received: by 2002:a05:600c:3411:b0:427:9dae:2768 with SMTP id 5b1f17b1804b1-427c2d119d7mr16164435e9.38.1721225657598;
        Wed, 17 Jul 2024 07:14:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25a957sm205610285e9.13.2024.07.17.07.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:14:17 -0700 (PDT)
Message-ID: <2c6ec60e-1eff-417e-aed2-4554ea9a86eb@redhat.com>
Date: Wed, 17 Jul 2024 16:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Peter Xu <peterx@redhat.com>
Cc: David Wang <00107082@163.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, x86@kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
 Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <1182a459.1e35.190b0e61754.Coremail.00107082@163.com>
 <8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com> <ZpU6KsKuhzPqUpFF@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZpU6KsKuhzPqUpFF@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[catching up on mails]

>> indicates that file truncation seems to end up messing with a PFNMAP mapping
>> that has PAT set. That is ... weird. I would have thought that PFNMAP would
>> never really happen with file truncation.
>>
>> Does this only happen with an OOT driver, that seems to do weird truncate
>> stuff on files that have a PFNMAP mapping?
>>
>> [1]
>> https://lore.kernel.org/all/3879ee72-84de-4d2a-93a8-c0b3dc3f0a4c@redhat.com/
> 
> Ohhh.. I guess this will also stop working in VFIO, but I think it's fine
> for now because as Yan pointed out VFIO PCI doesn't register those regions
> now so VM_PAT is not yet set..

Interesting, I was assuming that VFIO might be relying on that.

> 
> And one thing I said wrong in the previous reply to Yan is, obviously
> memtype_check_insert() can work with >1 owners as long as the memtype
> matches.. and that's how fork() works where VM_PAT needs to be duplicated.
> But this whole thing is a bit confusing to me..  As I think it also means
> when fork the track_pfn_copy() will call memtype_kernel_map_sync one more
> time even if we're 100% sure the pgprot will be the same for the kernel
> mappings..

I consider the VM_PAT code quite ugly and I wish we could just get rid 
of it (especially, the automatic "entire VMA covered" handling thingy).

> 
> I wonder whether there's some way that untrack pfn framework doesn't need
> to rely on the pgtable to fetch the pfn, because VFIO MMIO region
> protection will also do that in the near future, AFAICT.  The pgprot part
> should be easy there to fetch: get_pat_info() should fallback to vma's
> pgprot if no mapping found; the only outlier should be CoW pages in
> reality.  The pfn is the real issue so far, so that either track_pfn_copy()
> or untrack_pfn() may need to know the pfn to untrack, even if it only has
> the vma information.

I had a prototype to store that information per VMA to avoid the page 
table lookup. VMA splitting was a bit "added complication", but I got it 
to work. (maybe I can still find it if there is demand)

The downside was having to consume more memory for all VMAs in the 
system simply (even if only 8 byte) because a handful of VMAs in the 
system could be VM_PAT. I decided that's not what we want. I managed to 
not consume memory in some configurations, but not in all, so I 
discarded that approach.

I did not explore storing that information in some auxiliary datastructure.

IMHO the whole VM_PAT model is weird:

1) mmap()
2) remap_pfn_range(): if it covers the whole VMA apply some magic
    reservation.
3) munmap(): we unmap *all* PFNs and, therefore, clean up VM_PAT

(VMA splitting make the whole model weirder, but it works, because we 
never merge these VMAs)

This model cannot properly work if we get partial page table zapping via 
truncation/MADV_DONTNEED or similar things after 2). And likely we also 
shouldn't be doing it that way. We should forbid any partial unmappings 
in that model, just like we already disallow MADV_DONTNEED as you note.

As you mention in your other comment, maybe relevant/all? caller should 
just manage the PAT side independently. So maybe we can move to a 
different model.


-- 
Cheers,

David / dhildenb


