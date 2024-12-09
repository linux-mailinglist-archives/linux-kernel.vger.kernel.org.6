Return-Path: <linux-kernel+bounces-437770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732BF9E9873
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114C2165760
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0E1B0404;
	Mon,  9 Dec 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsOnXV5Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A01ACED6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753375; cv=none; b=bNtsieynjRhnDVvPGYVt1A8slSh+/ZQnVqZGr01i4T7JWPkpy9ZiMz94WFSMyapVJQSCRUgpzXIReiGWdWw7KWifCMTFRITXLbbEdGdl2QyWdn67iOOPyQuOyLu/XY9l8rQ6+ewHCHg3KwfLDPC5tTAwQHFPMReVjln+4sf3N4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753375; c=relaxed/simple;
	bh=Eq936Swdlr5Vr1n07W4JNUwWLNLtCfsVXHG+NkcZmHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfKHn05XFDDcczDRr2NhS0RdH3tb7Kk+IrjrV2lyMEeFujGjn0MxtTiqEliDzsTMh5CmW6FBBDi7ky64MQc5Ge/zg2e0kHaDULkBpXRXfGQQGiXpvDx84wAOd+InAz09Zhw0JjtvvCQIGCZegBiuyMbiKQJXAAIQ96Y3pne5jMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsOnXV5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733753372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VzXlnJmnU2ebKwGEDRcz+rluvkiTABj4LkxuPLkA8m4=;
	b=fsOnXV5QlBEVEbsTpron+jllrpMhUTyQgVdKRQlw69bHib/2Ck1zg+yss+yWzK0tkPYCne
	ak0UKrvoDp4VKigTtczIF4SZw++JJ1m6genMn4fHhs50YsQo5kHCFm434Na7CemUm+kCzs
	rjmlaXlvEwF6BzkAgqKWAF8ryOexaM0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-am1aBS_cMhGc32XIcsnKIw-1; Mon, 09 Dec 2024 09:09:30 -0500
X-MC-Unique: am1aBS_cMhGc32XIcsnKIw-1
X-Mimecast-MFC-AGG-ID: am1aBS_cMhGc32XIcsnKIw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d735965bso2532865f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753369; x=1734358169;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzXlnJmnU2ebKwGEDRcz+rluvkiTABj4LkxuPLkA8m4=;
        b=CIqNiIBv+S+fmjcqCM9JC/U+F3VSDiqBvxRHSAmMa87j5j5bkzR/CI3edZN20FSJoG
         yQRzuf81NKWpTIyNLkFVovaBEoQwS2w3aSbAynegsoitsx7lutqn7YM8v9rWV87A5WdC
         vAMyHBpZV+DoBjFqgx2eJohd4+rAqR7RKCwaG3TOcjfi+UhqiTOL1k4vsjB58sdX70sq
         isbD244Yxr05M+0KIYY7ZigAIwVwRukhVN+to7efP8zappIMl4tqQ4xbQ+PSCuUXSyOL
         RlXN5yV8rrPA/3FswycK3Fpt/1Wt367tvXPGxOe4eodc+x5hf0jf/GWiok8Pm46VnDJ2
         1Nwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqnSpBteQTiIx5QWs2l4a/ewfYoliG4oGKRvOEHD+ulOcsCFoICI8k6+x/C5cYxBVhi75OcGdlPwqqt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytjj2f0kA5B1B3lcr57+fYN3oxnbKRpjf7yvCWPPeW4iz5ESQh
	5c2YgRqov5Sm1js0mtQFZrVI9oSaOgTt8Y7ah3Rx6J98bxWrd2xQxJrqkj3NEAsIqj8ejSpguEv
	/WwrkjVeYRMRWzN+06Eq0qLMmy7jDsiiPhxz4RWON/vQX3wez24GKlOa1URup+A==
X-Gm-Gg: ASbGnctPLhJb1hu7rJC+iRg4upzMIaFH4Eoe9bL0GQnRINnQPzeVD4+i2sZALC8i/0R
	x5sq+tp5SRd7D/pZpkd9plIaJ0sgWR2Is9SY7lR3CP6AZV68LbJH8sEUUtRfrmvF9krxMnpMljQ
	Wuuaiw0SyyYmQbCi8DmTVPlsHIhJNWl9jScm3Iv3DkpujZuHPUyOSnKBLIRJhHjy952mRQ1f5IE
	UBM57/LtPuUg5TA8VFTUIuCgRW+yqrg6VwuvEc0kSiW4srYemhBWhYirWCwSTn3Av88UxReSxyQ
	VAzf6aUU
X-Received: by 2002:a5d:59a3:0:b0:386:37bb:ddc1 with SMTP id ffacd0b85a97d-386454000a2mr469223f8f.56.1733753368797;
        Mon, 09 Dec 2024 06:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfqlyef2yHZQ5JszG4Mf7UJmBMAbr4tqCENKW0Q01hLnN5BIAWJlHvR77ORs51kEsFs1dr8A==
X-Received: by 2002:a5d:59a3:0:b0:386:37bb:ddc1 with SMTP id ffacd0b85a97d-386454000a2mr469190f8f.56.1733753368315;
        Mon, 09 Dec 2024 06:09:28 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd42sm192472705e9.38.2024.12.09.06.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:09:27 -0800 (PST)
Message-ID: <c53c8f59-1e5d-40d5-97df-7200c21c43fe@redhat.com>
Date: Mon, 9 Dec 2024 15:09:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <d9df6f73-9e6c-4f8b-b2c0-5534725d1b18@lucifer.local>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d9df6f73-9e6c-4f8b-b2c0-5534725d1b18@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.12.24 11:06, Lorenzo Stoakes wrote:
> On Mon, Dec 09, 2024 at 10:16:21AM +0100, David Hildenbrand wrote:
>> On 06.12.24 20:16, Lorenzo Stoakes wrote:
>>> There are a number of means of interacting with VMA operations within mm,
>>> and we have on occasion not been made aware of impactful changes due to
>>> these sitting in different files, most recently in [0].
>>>
>>> Correct this by bringing all VMA operations under the same section in
>>> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
>>> with VMA as there needn't be two entries as they amount to the same thing.
>>>
>>> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    MAINTAINERS | 19 +++++++------------
>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1e930c7a58b1..95db20c26f5f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15060,18 +15060,6 @@ F:	tools/mm/
>>>    F:	tools/testing/selftests/mm/
>>>    N:	include/linux/page[-_]*
>>>
>>> -MEMORY MAPPING
>>> -M:	Andrew Morton <akpm@linux-foundation.org>
>>> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>>> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> -R:	Vlastimil Babka <vbabka@suse.cz>
>>> -R:	Jann Horn <jannh@google.com>
>>> -L:	linux-mm@kvack.org
>>> -S:	Maintained
>>> -W:	http://www.linux-mm.org
>>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>> -F:	mm/mmap.c
>>> -
>>>    MEMORY TECHNOLOGY DEVICES (MTD)
>>>    M:	Miquel Raynal <miquel.raynal@bootlin.com>
>>>    M:	Richard Weinberger <richard@nod.at>
>>> @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
>>>    S:	Maintained
>>>    W:	https://www.linux-mm.org
>>>    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>> +F:	mm/madvise.c
>>> +F:	mm/mlock.c
>>> +F:	mm/mmap.c
>>> +F:	mm/mprotect.c
>>> +F:	mm/mremap.c
>>> +F:	mm/mseal.c
>>> +F:	mm/msync.c
>>
>> Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that the
>> real "magic" they perform is in page table handling and not primarily VMA
>> handling (yes, both do VMA changes, but they are the "easy" part ;) ).
> 
> And large parts of the VMA logic interface with page tables, see - the entire
> 6.12 cycle - around recent changes in mmap() MAP_FIXED - which... the VMA
> maintainers fixed :)
> 
> And then there were the issues around VMA and mm locking relating to page
> table work which... oh right yeah we had to fix again... :>)
> 
> I mean you can make this argument about probably all of these files (mremap
> has -tons- of page table-specific stuff), and then we get back to not being
> notified about key changes that interface with memory mapping/VMA which we
> end up having to deal with anyway.
> 
> A lot of the reason we have 'magic' in these files anyway is because we
> don't have a decent generic page table handler. Not sure I'd actually use
> the word 'magic' for that though.
> 
> I am planning to make significant changes to mprotect/mlock soon, which
> have some terribly duplicated horrible handling logic, and both are key
> considerations in VMA logic as a whole.
> 
> Anyway, as far as I'm concerned page table manipulation after the point of
> faulting is completely within the purvue of VMA manipulation and a side
> product of it.
> 
> However, can concede mm/madvise.c if you feel strongly about that as that's
> a bit blurry, but of course contains a whole bunch of VMA and... page table
> manipulation :) I mean it still to me seems very pertinent.
> 

And then we have mprotect.c being heavily used by uffd-wp and NUMA 
hinting, which don't perform any VMA modification.

That's why I don't think the change proposed here is really the right step.

 >>>> They have much more in common with memory.c, which I wouldn't want 
to see in
>> here either. Hm.
> 
> No, memory.c is really dedicated to fault handling. This is really
> different from manipulating page tables in specific cases in my opinion.

And fork and such stuff. And if you look into huge_memory.c, we actually 
moved all of the THP logic for mprotect()/madvise()/... in there.

Not sure if something similar should have been done for memory.c, or if 
the THP stuff should actually also have gone into the respective files.

To me it sounds wrong to have VMA maintainers maintain a lot of the code 
in these files code because these files somehow modify VMAs, sorry.

-- 
Cheers,

David / dhildenb


