Return-Path: <linux-kernel+bounces-337234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D5984757
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03CC1F2581A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2E1AAE17;
	Tue, 24 Sep 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh+9JvWw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6151AAE16
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186986; cv=none; b=DIJHD4+JXiAxV0GpV7Veg3MgPEH0j77QK7/vbocnC4jbWE2jP0EM6pMoW81mDTqE50ZcPOtO458w341EQTZtIsjlHTjqiq4UwtcFBBRc59nJ2Cf3kTbjDlkX2Iy6bwMY1FYwZQxMET+s1cnniB/nYlXAsONbuBTLmyW0H44b+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186986; c=relaxed/simple;
	bh=UTlEcYePs5Ui6AW/0MA9t1tGC1sOWBXq5wGZY8QXJLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilBAlxxMwWYXK2p+i1hpnL1wM8z96/Jf2F6IAin2fIGPh28jjyStgLpir1Xjr0i8ZpplaU8vgYofb2AmJ4BxKQaqRFbHroxwSe7dAGRYc5nZvPU4vVq4wRUa2qhCwF9BkYLB/8qOForwpL9ySQSUrq13zg4MVOrdOXd/+LL2hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eh+9JvWw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727186983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KrZH+B1ofaYLMWpc1paGyv1Xahql732tMdxzbmsVAJk=;
	b=Eh+9JvWwxvHzFKlHOXaOijodtpYZdbqSEqcfmVRbM0Hqdugu4ptg1THBm3gB+ahQYEtNKw
	zYD4qGfdYVt8bdj+u3jcmYtC4PdK7cJt6Uko5GVzTFUS55Sn/702QcV6GWGS4M7xaiCCWm
	MqocAAellv28e8eSgzS4XMJGDxlveLU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Mbww95AYPBaMJu4_KC_IIw-1; Tue, 24 Sep 2024 10:09:42 -0400
X-MC-Unique: Mbww95AYPBaMJu4_KC_IIw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c518ae847dso102752466d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186982; x=1727791782;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrZH+B1ofaYLMWpc1paGyv1Xahql732tMdxzbmsVAJk=;
        b=HTySiSs7NTiYtoF6JYjXD+g9fbo1Vn0oh4bailMvpuXbjRjS+Ie1MVFApVprN6z+Wd
         XZ20/ZIMOBJcwmE4FVVWezAg/W2c4s7tcsaYnxnRjvyPECsS9LUn55u9rt7wCzpqlkPP
         Igr6+lDESguqrmbKWmP5U70cxD6floOAftH9HyVSEhBNQ8dbgsgRAzs5W9neN8z+Cwyg
         P7glIy1R9ZyHSiWTIzU3Tjbr6OYUbWoinfcItRpRhs6EdTwWcEjXc+ar9RIzSDbLuwQI
         puItmYvQV//cQFLj2UNa3aeuYrC0HVn8rf7yzVffOwql83PYidW/th7JO5RIqwFnSA94
         aqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+z7dIdt+6GtRrpWbpi1vkPc385Yy9JW+1gvpRqNSHRpKBycRGZrWj57vPJaLvEcXHw0XE00DidSH3+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/b82Nv6YynldI6/fliPXEVz7jL9d8+1Pi/qbcoS/a7EugHz4
	Gq/TDxG0pQDrhS2fvaaCe8gnokTH6ALNJ7ujDmjzCPQ31x/GvhZe0V7uOYiR52w7S9kOB+Regop
	eDx+493smPyOxozK6jk37ZCJA1wm8LrTSoJFTvs6JyfiULPGPDJSToc46tYbweJSnNHkElSY0
X-Received: by 2002:a05:6214:3201:b0:6c5:540c:82b0 with SMTP id 6a1803df08f44-6c7bd46ca96mr234626426d6.4.1727186982053;
        Tue, 24 Sep 2024 07:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgdYrqhNM7zbX//kVqb7CIeppgFQ1D2M2Fpx6ezdfRUM3/pICCFyPp40f/R+UO3UQ1QpUE6Q==
X-Received: by 2002:a05:6214:3201:b0:6c5:540c:82b0 with SMTP id 6a1803df08f44-6c7bd46ca96mr234626066d6.4.1727186981661;
        Tue, 24 Sep 2024 07:09:41 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4e1c5fsm6768746d6.64.2024.09.24.07.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:09:41 -0700 (PDT)
Message-ID: <65959acc-c59b-4aca-8ab4-5d0603d22110@redhat.com>
Date: Tue, 24 Sep 2024 16:09:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: Guenter Roeck <linux@roeck-us.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240923235617.1584056-1-linux@roeck-us.net>
 <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com>
 <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
 <bf98fa37-461f-47ce-8d4c-bcb69f225a9c@roeck-us.net>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bf98fa37-461f-47ce-8d4c-bcb69f225a9c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.09.24 16:04, Guenter Roeck wrote:
> On 9/24/24 00:48, Geert Uytterhoeven wrote:
>> Hi David,
>>
>> On Tue, Sep 24, 2024 at 9:34 AM David Hildenbrand <david@redhat.com> wrote:
>>> On 24.09.24 01:56, Guenter Roeck wrote:
>>>> v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the
>>>>        existence of NR_CPUS, define NR_CPUS for m68k.
>>>
>>> Okay, looks like we're cleaning up CONFIG_NR_CPUS for good.
>>>
>>> I'm back from conference travel tomorrow; I'll then throw in the following
>>> into cross compilers and fixup any other arch that needs attention:
>>>
>>>
>>> diff --git a/include/linux/threads.h b/include/linux/threads.h
>>> index 1674a471b0b4..e31715e6746b 100644
>>> --- a/include/linux/threads.h
>>> +++ b/include/linux/threads.h
>>> @@ -13,8 +13,7 @@
>>>      * bit of memory.  Use nr_cpu_ids instead of this except for static bitmaps.
>>>      */
>>>     #ifndef CONFIG_NR_CPUS
>>> -/* FIXME: This should be fixed in the arch's Kconfig */
>>> -#define CONFIG_NR_CPUS 1
>>> +#error "CONFIG_NR_CPUS not defined"
>>>     #endif
>>>
>>>     /* Places which use this should consider cpumask_var_t. */
>>
>> This is gonna trigger on almost all architectures if CONFIG_SMP=n.
>>
> 
> Guess that means that my patch won't work either. Any better ideas ?

As discussed,

diff --git a/mm/Kconfig b/mm/Kconfig
index 09aebca1cae3..4c9f5ea13271 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -595,6 +595,7 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  config SPLIT_PTE_PTLOCKS
         def_bool y
         depends on MMU
+       depends on SMP
         depends on NR_CPUS >= 4
         depends on !ARM || CPU_CACHE_VIPT
         depends on !PARISC || PA20


Might work for the time being.


-- 
Cheers,

David / dhildenb


