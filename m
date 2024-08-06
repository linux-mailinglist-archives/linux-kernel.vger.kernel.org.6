Return-Path: <linux-kernel+bounces-276677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D49496EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9087F1F22B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047B3C08A;
	Tue,  6 Aug 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlV6Z25h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F84C62E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965614; cv=none; b=EtwOBqxbrYF2NWlcSj2D7qRu1tKVe/m3GfRNblMxYKIEQ/2SRpzEVrqyFBqYhWZWnngsKFiWxmieQLQihcDRghVw3sz1D4d6nMzmZKgDdUm/mAyKemNPWspLxevp79iRJItVV+Etyfv9Z9hqQE99hBbkvJeP3TzBQzwqRPXcACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965614; c=relaxed/simple;
	bh=igBpS5vyWwiwQFlNKwn9lyenSzHvfI4E796NnVh5GmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOkzNkuLbH62HiECVuZ4pqFy6rBBldwvcNnZd01G1PmZLD1HtjctjrOADNvb3OzpppkLHt0Lih64kYdCroYcFFVOqDS5C0+n0n6giy2/hgDAXP34R6tvK0nn1rVewe8KX6dhbqVyhqonchSBr4W5gt/W18+RFCbRTXcm/IgKOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlV6Z25h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722965612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7UovTrD2vHU//3dvjmfhrfPl8GsfurbJVXz4VqoRTEc=;
	b=ZlV6Z25hKwGCwfP/brsZr/Ml7E8wFrklIOBTQhb4cVI6L5QI2Im4q67/MwQp+nC4+W7flJ
	JOJzXOnH9LlE4urxSSchSeLJTjEdWdVct4Jk4OQqh0tCwXq2giEqmH11JHf5H774j229lp
	aorT7o7p06dE+VvGhYBgMBBkIzaDh70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-7eyXNf-IMiiJ-DEcvMdj-w-1; Tue, 06 Aug 2024 13:33:29 -0400
X-MC-Unique: 7eyXNf-IMiiJ-DEcvMdj-w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42820c29a76so6344285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965608; x=1723570408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7UovTrD2vHU//3dvjmfhrfPl8GsfurbJVXz4VqoRTEc=;
        b=M9JmcYVkv4mZRESfAk3PLgpWQuEzCoVOxnGZ7qZyIfzwT3el3p9kdjDssP4Gmb6G+x
         ed0dInFoomvXxs54H++CAKOXQMvCZcr5KtpoF5n/TCVlAPkE3FpYuTt547kY0Q+pa9qv
         SAmaGR4ILMYd6CetNUmLhtTaFtfWBNKGzjmqEX8Bz2JfLNACleO4mFcoVZI6ejem9dEV
         RAxsd+i8mi6e+Su94l8yxI8S9VIvN65Bm86Kr0Sy4i1m9lMBM34AFYh+dfybtooJ/Z1d
         L+eohpWKOO7Nh2zuqxyz0hX2i2Nqn9lRha9LYaOkNVvOhdRNq9RSpo3fS+Ia1LNjmUPR
         0RiA==
X-Forwarded-Encrypted: i=1; AJvYcCUtcFGXW1eX2KguYs8ThlL0yq1RqHFAr+mueGLg4JGg+2xJvVDwBYkKYPN47tWidy83SPEaRwjNDXqIW3YI3PoCWnpUIhyjM184z3R7
X-Gm-Message-State: AOJu0YxkIqtso7vjdbqXPDPt1A8y5c9THw7ykAuw+ePzLEqkXaRX5mMX
	o80lTHbPP7lipfwtRgspf5BJUAnWnHy2r0tXnUY8KYgabjJzKVcNgfBwCz0BCXxva32m+ArhNYe
	RXOnSPqfd2yydglbVTbNrxNhQE+XqdIsL+f2wdnyeQ+DiHqjDXhIQhZO1CfGGkA==
X-Received: by 2002:a05:600c:4ed1:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-428e6af1d48mr104807685e9.4.1722965608527;
        Tue, 06 Aug 2024 10:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9E00DIAlQ8wlLL29W4NHbwvoiZN3ZRNb7aM4MLyJ+1vnZp5zxh/KOhK3Vm2gNj1uvzTH77Q==
X-Received: by 2002:a05:600c:4ed1:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-428e6af1d48mr104807445e9.4.1722965607957;
        Tue, 06 Aug 2024 10:33:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb98109sm249324525e9.39.2024.08.06.10.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:33:27 -0700 (PDT)
Message-ID: <907d1de9-7a38-4b6a-ba1f-eafa1b4c2783@redhat.com>
Date: Tue, 6 Aug 2024 19:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
 <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
 <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
 <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
 <4b9a9546-e97b-4210-979b-262d8cf37ba0@redhat.com>
 <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
 <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
 <204af83b-57ec-40d0-98c0-038bfeb393a3@gmail.com>
 <58025293-c70f-4377-b8be-39994136af83@redhat.com>
 <20240806172830.GD322282@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240806172830.GD322282@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 19:28, Johannes Weiner wrote:
> On Thu, Aug 01, 2024 at 08:36:32AM +0200, David Hildenbrand wrote:
>> I just added another printf to postcopy_ram_supported_by_host(), where
>> we temporarily do a UFFDIO_REGISTER on some test area.
>>
>> Sensing UFFD support # postcopy_ram_supported_by_host()
>> Sensing UFFD support
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
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Discarding pages
>> Registering UFFD # postcopy_ram_incoming_setup()
>>
>> We could think about using this "ever user uffd" to avoid the shared
>> zeropage in most processes.
>>
>> Of course, there might be other applications where that wouldn't work,
>> but I think this behavior (write to area before enabling uffd) might be
>> fairly QEMU specific already.
> 
> It makes me a bit uneasy to hardcode this into the kernel. It's fairly
> specific to qemu/criu, and won't protect usecases that behave slightly
> differently.
> 
> It would also give userfaultfd users that aren't susceptible to this
> particular scenario a different code path.

True, but let's be honest, it's not like there are a million userfaultfd 
users out there :)

Anyhow ...

> 
>> Avoiding the shared zeropage has the benefit that a later write fault
>> won't have to do a TLB flush and can simply install a fresh anon page.
> 
> That's true - although if that happens frequently, it's something we
> might want to tune the shrinker for anyway. If subpages do get used
> later, we probably shouldn't have split the THP to begin with.
> 
> IMO the safest bet would be to use the zero page unconditionally.
> 

... I don't disagree. It also smells more like an optimization on top, 
if ever.

>>> 		return false;
>>>
>>> 	newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
>>> 					pvmw->vma->vm_page_prot));
>>>
>>> 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>
>> We're replacing a present page by another present page without doing a
>> TLB flush in between. I *think* this should be fine because the new
>> present page is R/O and cannot possibly be written to.
> 
> It's safe because it's replacing a migration entry. The TLB was
> flushed when that was installed, and since the migration pte is not
> marked present it couldn't have re-established a TLB entry.

Oh, right, we're dealing with a migration entry.

-- 
Cheers,

David / dhildenb


