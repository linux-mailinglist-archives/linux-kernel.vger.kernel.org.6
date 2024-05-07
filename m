Return-Path: <linux-kernel+bounces-171994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986288BEB94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743C1B21456
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581F16D9C7;
	Tue,  7 May 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cbk1Tso9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D216D9A3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107082; cv=none; b=vFexelx+TyrBewaaWnDCLNPjm4lQe9usys9xemECvLpdGhTky8pRqfsQUCSuPayZanuClMJrNO5ILGPfvKhqFE+/gtazeCtX/EFVdl1r7AOV1FxaqVFZehkRbfPUNAG8QygisUT0m0bVZosgMdu8HP0G56tKh/XI1sNUo7weC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107082; c=relaxed/simple;
	bh=iA0XMFPyZHcXcwBfRaZuoG0BlMDSyoTBhbp18UE8vWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWSihqVlDNBLryVmNhiXHwXfo2NLNd+Mb6Ezj1iLdCPWZ6c9zmDueHx+TSsnvXPsQIOZuMBoZ3arMXU1fhzpQ33sIatUWpHxjiK6bK4mK4uVdNRdGopC/jvigc3fXlCX2mgq9xZzlajSTRRYz7xZWx3MHcevk0sMDM0CLBRjYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cbk1Tso9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715107079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dByjWaf8mzPMt0+yCIuC+Vh6WT0q2RmuMIu0cTN5Lo4=;
	b=Cbk1Tso9QHaTtr7b35Nm3UVrkGyf/8RGWJQ5hi5aKGo3oAqBsXszMg31zo8mnkx51lt4or
	jDf2hssGFqbu5wOxgsSdiCdD9j3PHAw8mt5SW85yM8FMIaVE/Eh1EJQeYSURWV3Za+OOlq
	1/ZD0pfbVYQR+NH+VrpBdidcip1ByBE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-GzbRuGs4OmCtZISREVg-ug-1; Tue, 07 May 2024 14:37:58 -0400
X-MC-Unique: GzbRuGs4OmCtZISREVg-ug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d99cc6c3dso2107365f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715107077; x=1715711877;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dByjWaf8mzPMt0+yCIuC+Vh6WT0q2RmuMIu0cTN5Lo4=;
        b=jUjM6E+qVQ/TnjXZbUX8cFUS8Xi2h4zQvmCwVLPsHOoIH2upnvrdGG9/t7E7wGrQdy
         Hc1wvyfOoiG/4fmmqUimvfBMkXVzfviI/y67J35tuJJoogJ/t9MmZogHGJI2SH7LNZss
         5s+tI0uGgs63kXEQSP6EE9vabFV63Pb5cJ5vfv9gEW1wZjWCKsXWKC3gEg5qQ3LuXAXf
         KRse0+/Y1N0sWAQuSqo/4ezyFCBtzEniQWUt1lajfKND+CYuobAWCVfzn1djcz//s6DJ
         Wi45otSYg/8LNI72fLB3+012CxqAiOsOFWVmV070AYEeZQNYhuAllL3P/BUtGap5wG8U
         wZWA==
X-Forwarded-Encrypted: i=1; AJvYcCW9/5tSSfMchcFOZLzp/X7jcQEbRYFn1VsqYwwRqXUCWvJQLVPdf3DUkFkE4VIfPmpFm6EZF63iIKsqhdo2QPiBkm6s99wXdUM0aXBb
X-Gm-Message-State: AOJu0YyAsEYGr33XPyx+WSZmYLwnhycwnDtzj2bdOsK36KE66Xs6S/vm
	9V969ml/6D4WBRm1x53jsrOVqMbQO9wd1wZMXxf0baXjL7gPcbgukxo6jC87/I+oyGwIjRy0nbF
	oiFCJtTyhzlEibGCObdrmS6E6ppIARXmzEod3q+MH4CwVIBL1yC4n00GuBp+USw==
X-Received: by 2002:adf:fb07:0:b0:343:ef64:e0fd with SMTP id ffacd0b85a97d-34fcb2b47damr417503f8f.52.1715107077056;
        Tue, 07 May 2024 11:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGDtOsF1Bfynr+PIaRF8blpTX8UglX76GcZ2uhsd5D7K1V+iZLMz0Ndvk1is+asuAJVabLLQ==
X-Received: by 2002:adf:fb07:0:b0:343:ef64:e0fd with SMTP id ffacd0b85a97d-34fcb2b47damr417487f8f.52.1715107076579;
        Tue, 07 May 2024 11:37:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:b500:3f9d:130d:ea00:afc7? (p200300cbc744b5003f9d130dea00afc7.dip0.t-ipconnect.de. [2003:cb:c744:b500:3f9d:130d:ea00:afc7])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5412000000b00346bda84bf9sm13530476wrv.78.2024.05.07.11.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 11:37:56 -0700 (PDT)
Message-ID: <42a18f08-99a5-4bb0-8a1d-771549cac046@redhat.com>
Date: Tue, 7 May 2024 20:37:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] mm: rmap: abstract updating per-node and
 per-memcg stats
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240506211333.346605-1-yosryahmed@google.com>
 <1a408ed1-7e81-457e-a205-db274b4d6b78@redhat.com>
 <CAJD7tkam8BvLvOrw_FfgZ8XOsfdu-Hv2oCv_s+LAMcGvd44hTA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkam8BvLvOrw_FfgZ8XOsfdu-Hv2oCv_s+LAMcGvd44hTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.05.24 17:54, Yosry Ahmed wrote:
> On Tue, May 7, 2024 at 1:52 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.05.24 23:13, Yosry Ahmed wrote:
>>> A lot of intricacies go into updating the stats when adding or removing
>>> mappings: which stat index to use and which function. Abstract this away
>>> into a new static helper in rmap.c, __folio_mod_stat().
>>>
>>> This adds an unnecessary call to folio_test_anon() in
>>> __folio_add_anon_rmap() and __folio_add_file_rmap(). However, the folio
>>> struct should already be in the cache at this point, so it shouldn't
>>> cause any noticeable overhead.
>>
>> Depending on the inlining, we might have more branches that could be avoided
>> (especially in folio_add_new_anon_rmap()).
>>
>> [the rmap code is more performance-sensitive and relevant than you might think]
> 
> I thought about making the helper __always_inline. Would that be better?

Let's leave it like that. I might do some actual measurements to see if 
it makes a difference at all.


>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>> ---
>>>
>>> This applies on top of "mm: do not update memcg stats for
>>> NR_{FILE/SHMEM}_PMDMAPPED":
>>> https://lore.kernel.org/lkml/20240506192924.271999-1-yosryahmed@google.com/
>>>
>>> David, I was on the fence about adding a Suggested-by here. You did
>>> suggest adding a helper, but the one with the extra folio_test_anon()
>>> was my idea and I didn't want to blame it on you. So I'll leave this up
>>> to you :)
>>
>> :) fair enough! It's a clear improvement to readability.
>>
>> [...]
>>>
>>> -     if (nr_pmdmapped) {
>>> -             /* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
>>> -             if (folio_test_anon(folio))
>>> -                     __lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
>>> -             else
>>> -                     __mod_node_page_state(pgdat,
>>> -                                     folio_test_swapbacked(folio) ?
>>> -                                     NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED,
>>> -                                     -nr_pmdmapped);
>>> -     }
>>>        if (nr) {
>>> -             idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
>>> -             __lruvec_stat_mod_folio(folio, idx, -nr);
>>> -
>>
>>
>> We can now even do:
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 9ed995da4709..7a147195e512 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1555,18 +1555,17 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>                   break;
>>           }
>>
>> -       if (nr) {
>> -               /*
>> -                * Queue anon large folio for deferred split if at least one
>> -                * page of the folio is unmapped and at least one page
>> -                * is still mapped.
>> -                *
>> -                * Check partially_mapped first to ensure it is a large folio.
>> -                */
>> -               if (folio_test_anon(folio) && partially_mapped &&
>> -                   list_empty(&folio->_deferred_list))
>> -                       deferred_split_folio(folio);
>> -       }
>> +       /*
>> +        * Queue anon large folio for deferred split if at least one
>> +        * page of the folio is unmapped and at least one page
>> +        * is still mapped.
>> +        *
>> +        * Check partially_mapped first to ensure it is a large folio.
>> +        */
>> +       if (folio_test_anon(folio) && partially_mapped &&
>> +           list_empty(&folio->_deferred_list))
>> +               deferred_split_folio(folio);
>> +
> 
> Dumb question: why is it okay to remove the 'if (nr)' condition here?
> It seems to me by looking at the code in case RMAP_LEVEL_PMD that it
> is possible for partially_mapped to be true while nr == 0.

Not a dumb question at all, and I cannot immediately tell if we might 
have to move the "nr" check to the RMAP_LEVEL_PMD case (I feel like 
we're good, but will have to double check). So let's keep it as is for 
now and I'll perform that change separately.

Thanks!

-- 
Cheers,

David / dhildenb


