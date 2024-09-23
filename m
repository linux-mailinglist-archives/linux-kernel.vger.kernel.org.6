Return-Path: <linux-kernel+bounces-333221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06CC97C587
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C077B1C236DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16C13B787;
	Thu, 19 Sep 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imzFfkGq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64236134
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733061; cv=none; b=J4wbnny+rgxiGQ94dJTKPeUrCFGlJSTCp97eHDHkNyN7nLdr9bTrtBChNjzZjaSoQztU6m9gC+MXNJ0A2oMlGKaXcnSNf/LOUpbPr2E2/44SDpfdV/M8a8GM3CQzRAVYk6JIlPRbelbt3NMYPf/aAurtmEcvfIubOQO7S209cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733061; c=relaxed/simple;
	bh=uTxeqM0duEMWgF6Y0tzXiT8PF46ua58stWVZOnsdt2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0E6wiMXT4rJnIv35UlUJ2KwySDE3at1zaF4RZqeGnStXb9K1XtO8qn0HwadnYJz1PBBOMfdDR1fI6aJ+f7jMa6Jh1t9ZqJ9rShr+yrBer9TXWldOAw01ssp7Sk23Hn9IvSszxMEi5ph2gFM0Ajylu1tSQqW4yiP1VK5btOiVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imzFfkGq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4DpbblgkcMhjIC/ykM3FWmmeoOS60M6M8pYscao/Qy0=;
	b=imzFfkGqEV3ldztVqeTLGPR+S4chl55iBdLUQepRT6o9qlIps7SWi+kx40mxjmAuf0B/T3
	IrZx8K1zJewEY8cvMunJ6NFW2adl+XixcM+3FNdvQ9vvIEw2S7q/b1UbJmJvdJWC0M5Jk4
	sKp0LZLF2hYZcYOfiiFShfOzd+0KONM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-OX2aQoiNPi-z4m1ZDmA83Q-1; Thu, 19 Sep 2024 04:04:18 -0400
X-MC-Unique: OX2aQoiNPi-z4m1ZDmA83Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b385b146so233205f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733057; x=1727337857;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DpbblgkcMhjIC/ykM3FWmmeoOS60M6M8pYscao/Qy0=;
        b=SPl089ZhyqhPVdBj78Zogc1jt4ciy0qLidYnL7XT7VmnpiOnTTdehuArkZ9BAankOr
         h3I8cjARvz1zhyvXw9f6MGNzSj+bx8B6vFWaIYcFmsxm1uqcE9L+D9bL3ORFou9fnNPf
         IaU9RtINRh7wpGPzT+Cp1UzzorJAuFJ4ADy5xkxQidhp3NSgBsYdcvYI3EJqBt7O/YVs
         BsPTu26zqdaYhuxrHyM9U4QKloT8NR06lnRoapxa5NG6fw0WogL8cLGR38UMFwP4uQSj
         T6Epp+07qPRHEiN1prxRM1/Fna+SpKckuXXuUeKyqFOdG0bQETDIlodGJ0ESmHBcN/dn
         ptUA==
X-Forwarded-Encrypted: i=1; AJvYcCWxRT7rek51OkILpIRygkTsblnfdUrTw9voYnsDhoXBWosVUwjGlMWafSnXPdHcqxB0R//vDBwdEYMFaYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdF6WcJziOqo5vit4Gnx4rVYaxi9Wr6wTK5xxsE/OrQHqsRTyn
	pne6B+58q6sono3iVAgc/EHE/Nh1s4nxmibkkniZuJqh+ep8aSsfaQNkyl2ZuNXr/mS+BUxxxht
	6h9Mw9t811mTe3FgKh6Cszmj8dHBFL9CdPE9MBUBBXkwV9ngX/ZreLESaCOFgXw==
X-Received: by 2002:a5d:6551:0:b0:374:c64d:5379 with SMTP id ffacd0b85a97d-378c2d11728mr15031503f8f.27.1726733056746;
        Thu, 19 Sep 2024 01:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpAW3slwiy8Fov5De5bLtSVCBtgmykkdHrllakA5LjpSHlNOVMufE1znkiHOWKOyJCqq4r5w==
X-Received: by 2002:a5d:6551:0:b0:374:c64d:5379 with SMTP id ffacd0b85a97d-378c2d11728mr15031486f8f.27.1726733056259;
        Thu, 19 Sep 2024 01:04:16 -0700 (PDT)
Received: from [10.131.4.59] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62bfsm14404103f8f.51.2024.09.19.01.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:04:14 -0700 (PDT)
Message-ID: <d32136d4-94ab-432a-89ae-5f41935404ff@redhat.com>
Date: Thu, 19 Sep 2024 10:04:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] mm: Use ptep_get() for accessing PTE entries
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-4-anshuman.khandual@arm.com>
 <f9a7ebb4-3d7c-403e-b818-29a6a3b12adc@redhat.com>
 <8cafe140-35cf-4e9d-8218-dfbfc156ca69@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8cafe140-35cf-4e9d-8218-dfbfc156ca69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.09.24 08:32, Anshuman Khandual wrote:
> 
> 
> On 9/17/24 15:58, David Hildenbrand wrote:
>> On 17.09.24 09:31, Anshuman Khandual wrote:
>>> Convert PTE accesses via ptep_get() helper that defaults as READ_ONCE() but
>>> also provides the platform an opportunity to override when required. This
>>> stores read page table entry value in a local variable which can be used in
>>> multiple instances there after. This helps in avoiding multiple memory load
>>> operations as well possible race conditions.
>>>
>>
>> Please make it clearer in the subject+description that this really only involves set_pte_safe().
> 
> I will update the commit message with some thing like this.
> 
> mm: Use ptep_get() in set_pte_safe()
> 
> This converts PTE accesses in set_pte_safe() via ptep_get() helper which
> defaults as READ_ONCE() but also provides the platform an opportunity to
> override when required. This stores read page table entry value in a local
> variable which can be used in multiple instances there after. This helps
> in avoiding multiple memory load operations as well as some possible race
> conditions.
> 
>>
>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    include/linux/pgtable.h | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 2a6a3cccfc36..547eeae8c43f 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -1060,7 +1060,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>>>     */
>>>    #define set_pte_safe(ptep, pte) \
>>>    ({ \
>>> -    WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>>> +    pte_t __old = ptep_get(ptep); \
>>> +    WARN_ON_ONCE(pte_present(__old) && !pte_same(__old, pte)); \
>>>        set_pte(ptep, pte); \
>>>    })
>>>    
>>
>> I don't think this is necessary. PTE present cannot flip concurrently, that's the whole reason of the "safe" part after all.
> 
> Which is not necessary ? Converting de-references to ptep_get() OR caching
> the page table read value in a local variable ? ptep_get() conversion also
> serves the purpose providing an opportunity for platform to override.

Which arch override are you thinking of where this change here would 
make a real difference? Would it even make a difference with cont-pte on 
arm?

> 
>>
>> Can we just move these weird set_pte/pmd_safe() stuff to x86 init code and be done with it? Then it's also clear *where* it is getting used and for which reason.
>>
> set_pte/pmd_safe() can be moved to x86 platform - as that is currently the
> sole user for these helpers. But because set_pgd_safe() gets used in riscv
> platform, just wondering would it be worth moving only the pte/pmd helpers
> but not the pgd one ?

My take would be just to move them where they are used, and possibly 
even inlining them.

The point is that it's absolutely underdocumented what "_safe" is 
supposed to be here, and I don't really see the reason to have this in 
common code (making the common API more complicated).

-- 
Cheers,

David / dhildenb


