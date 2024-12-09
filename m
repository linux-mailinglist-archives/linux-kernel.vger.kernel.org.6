Return-Path: <linux-kernel+bounces-437795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3389E98BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D9285A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5F1B0432;
	Mon,  9 Dec 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyrmPb42"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD761B0429
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754344; cv=none; b=Ar/4YTrM9k4++DVh4nWdHksuVQpS3owI2UY+qtuEwSnwXaeG1AZNktCWWiE3hQbeXCVfFniUDkdDoYcf2lFqqq8anjs/QQbGP9iG4+lIWlT+lNSmOGwJHOevzBUTf7RrS924EEghv+ulFSzT7FbFWj2k22jJd1xWMMFZiMgmZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754344; c=relaxed/simple;
	bh=oEGcBkivA0IfqX8k/qmLAmhLALoIKMHJoIhJfeE4EC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVDEovOUubwO0Crzd/Oq2KsesLZeQhA19xUsJvXZUurKYSrCfeu65adnqRDtikFX6/P++C0Pu64vqhuQYhwbhIKR0pK0hHNEpCqxh/6WKfPlvhGcnAm93YERvkDTfyMYL+SHVFEu0HPcinrdbocA5lBh7Lnt1R6bb+E2J5NQZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyrmPb42; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733754341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kLw5tvnzbSX5I+OeEjNvLyxLHEXMElsIpXi63FRkevQ=;
	b=KyrmPb42VMpFNYmRcoAB6lWFWjCy/dUj5Ko/zyQ+NDH1xE6u2wgNZpTAapJnRY2Jp7wLsS
	DaG6vK2YpINwEPVQKkLaF7AV3AZRZ2PIKWRKFxPRRH0RUG8jygzzSaj6dssAGO9KdGT+07
	d664phE3dd8rtoGDq283PuLUABFypG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-2VOqoclmMG-VlZumcvce2Q-1; Mon, 09 Dec 2024 09:25:39 -0500
X-MC-Unique: 2VOqoclmMG-VlZumcvce2Q-1
X-Mimecast-MFC-AGG-ID: 2VOqoclmMG-VlZumcvce2Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385f0829430so3000018f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754339; x=1734359139;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLw5tvnzbSX5I+OeEjNvLyxLHEXMElsIpXi63FRkevQ=;
        b=cJykiSQluQ4F35IIB9r75lrEv54qPmqCTBPOnm5dpZg1aDjj+98sgrLA5bwB3McZQB
         CvRA3nPzOY0LskUA/j2X2JBLfPWQP/VH9VQyocw7OOr4f2rtjJtwlOY5Tj7S08SJjzzu
         iaEtjJtoFsjsk1aEm8poGM2n5iQyg+o51OeK5t+ZL6+K/yH8tibuS9eQPIXBS+KPxtas
         H4QSWc6txYH5+dN6TfR9VWG+uZDTUBi0yKaQKlv0zEZG+1PkblYw/a0OMduZbRoc0hdt
         sn4gkjcfwGo15rthqpP1D4L6YmaZfoQjBqq4ag1EwHVUyxCIHvAJMaeXnO8lXjvLp0Uj
         3HFw==
X-Forwarded-Encrypted: i=1; AJvYcCVP2bcXvR7Ctsxvvnk7MS4zoGQLVDcqgaTXeG8DcGrZfP4Pg2w1dVUhndRsggs4vooUNNvoXef3S2kFLGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGj2jnSl+z4Zc0WmTkU0RBoZyioNuNw0vBaJk5T386LpJuidzc
	y2FurEfA6RZk0a6oU7JcXeD9k9959G0/finTUjzio1nKuIcQ7zaBXJnGaIyiOn78ULl7ul7FDtd
	pkf1IWW2PiBpAl62IMiVi6jnQOPDh6HHA+THvJSCqCScjJjmddadz66bbZa7ToQ==
X-Gm-Gg: ASbGncvNrbhlcVhtej09cFUMPAqO4QQ/jlrrvXBSz4I1sxtGIwuyqIPfTahv09uLjHc
	dJZdSpvyky/lHjj5xhkSrqBiJasSZityYszao4gqE7Tb8u94m9NYSxO2g6Cqjb2jCcWHJ2FL5E6
	0T8Jsb+8fMbGp3DIA26Dpu2zUlwMjOFErS0UxFOBu1whm7diMc5+je8kjaOYBODDCK0xsVHQy2d
	DThFb8mDUa+UzpIHIysImGZRvqZvDYI60XzfEpmDyg8akVhPgDdnmfzcVVsbVAxeNQLlQh0qSzD
	KW4dqnFZ
X-Received: by 2002:a5d:64e2:0:b0:385:dc88:8214 with SMTP id ffacd0b85a97d-386453f95f3mr671122f8f.43.1733754338687;
        Mon, 09 Dec 2024 06:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEVLhrH3e0OEsFmMpUwPuALWHB8faQY6cnY5UCNgNrvnV38JNxW+iufBcaGniTFIpOa+Ps4w==
X-Received: by 2002:a5d:64e2:0:b0:385:dc88:8214 with SMTP id ffacd0b85a97d-386453f95f3mr671083f8f.43.1733754338279;
        Mon, 09 Dec 2024 06:25:38 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637072adasm7453948f8f.81.2024.12.09.06.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:25:37 -0800 (PST)
Message-ID: <557ba39e-960c-48d9-a59d-5756fc8b5679@redhat.com>
Date: Mon, 9 Dec 2024 15:25:37 +0100
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
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.12.24 15:11, Lorenzo Stoakes wrote:
> On Mon, Dec 09, 2024 at 03:00:08PM +0100, David Hildenbrand wrote:
>> On 09.12.24 14:25, Vlastimil Babka wrote:
>>> On 12/9/24 10:16, David Hildenbrand wrote:
>>>> On 06.12.24 20:16, Lorenzo Stoakes wrote:
>>>>> There are a number of means of interacting with VMA operations within mm,
>>>>> and we have on occasion not been made aware of impactful changes due to
>>>>> these sitting in different files, most recently in [0].
>>>>>
>>>>> Correct this by bringing all VMA operations under the same section in
>>>>> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
>>>>> with VMA as there needn't be two entries as they amount to the same thing.
>>>>>
>>>>> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
>>>>>
>>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> ---
>>>>>     MAINTAINERS | 19 +++++++------------
>>>>>     1 file changed, 7 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 1e930c7a58b1..95db20c26f5f 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -15060,18 +15060,6 @@ F:	tools/mm/
>>>>>     F:	tools/testing/selftests/mm/
>>>>>     N:	include/linux/page[-_]*
>>>>>
>>>>> -MEMORY MAPPING
>>>>> -M:	Andrew Morton <akpm@linux-foundation.org>
>>>>> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>>>>> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> -R:	Vlastimil Babka <vbabka@suse.cz>
>>>>> -R:	Jann Horn <jannh@google.com>
>>>>> -L:	linux-mm@kvack.org
>>>>> -S:	Maintained
>>>>> -W:	http://www.linux-mm.org
>>>>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>> -F:	mm/mmap.c
>>>>> -
>>>>>     MEMORY TECHNOLOGY DEVICES (MTD)
>>>>>     M:	Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>     M:	Richard Weinberger <richard@nod.at>
>>>>> @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
>>>>>     S:	Maintained
>>>>>     W:	https://www.linux-mm.org
>>>>>     T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>> +F:	mm/madvise.c
>>>>> +F:	mm/mlock.c
>>>>> +F:	mm/mmap.c
>>>>> +F:	mm/mprotect.c
>>>>> +F:	mm/mremap.c
>>>>> +F:	mm/mseal.c
>>>>> +F:	mm/msync.c
>>>>
>>>> Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that
>>>> the real "magic" they perform is in page table handling and not
>>>> primarily VMA handling (yes, both do VMA changes, but they are the
>>>> "easy" part ;) ).
>>>
>>> I'd think that moving vma files into MEMORY MAPPING (and not the other way)
>>> would result in a better overal name, that would be a better fit for the
>>> newly added files too?
>>
>> Maybe. I think vma.c should likely have a different set of maintainers than
>> madvise.c and mprotect.c. (again, the magic is in page table modifications)
> 
> The bulk of the logic in mremap.c is related to page tables so by this
> logic then, that is out too, right?

IMHO, yes.

-- 
Cheers,

David / dhildenb


