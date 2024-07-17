Return-Path: <linux-kernel+bounces-255024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518C933AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B2D1F22F78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831A15820F;
	Wed, 17 Jul 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLt9ecHn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DB315BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210632; cv=none; b=KTZy/qO4uz9QogQezD8RHIfA19om5mF//UffycftxEhFunoDcJG42bWlR3KGKNTeSRtWZaZ49NYixEMvBOZGtUdYngEyrA9aI7kML7nkC3AuvRC07SRBnd/p7hMJFqHyikY26EUD4feWM6MdmXNGnTtlNGbH5vkHhjGjS0mSQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210632; c=relaxed/simple;
	bh=UodqeB12eeeiHqXQlkvY6ATrrkNDJjSWfwqp/+Uk8tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr5P6klg/pumSMOdOP98dinXr/HKI3IvWBi2js0PDwZMUJa0mcI/DNgEJ0qipfJZwqA6azfukEgQyV0GWgkYsWijGfVEBuz+UWNMN8ToT7dUTmBuI0qkGhYREUJ2bk2GqnDmnDB4lRoRqyOi+Po6sO4E4GnFDBvTu/mTd9Dr+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLt9ecHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721210629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xXanHD8OKTJ1908/7wn5TIPf6PlsnQD7FE1TpuZeYig=;
	b=OLt9ecHnKUToyHP1fghus/adE0Dlerw79Av5ocpO5z+uWggwlv9i/b6Uq98PVK+Icfhv2G
	2V94W9z5fei4v9l/eUkX7XhpB7UBkKxnP4c73I4He6DrSyAivpJNNiUHNnJe82CTN/iQGC
	5F6ZBeZUyUS/3/zAVkcCXFGJx8Yj/qk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-z5se77LBPxG5h8xhxFKL2A-1; Wed, 17 Jul 2024 06:03:47 -0400
X-MC-Unique: z5se77LBPxG5h8xhxFKL2A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-368255eab46so317540f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210626; x=1721815426;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xXanHD8OKTJ1908/7wn5TIPf6PlsnQD7FE1TpuZeYig=;
        b=wiQrXj1xTqk6Zp/PMQ0fXhqar0WG7O3mZpgKrVlDru6qIFsUHWuZFAWBcL/r++rCV3
         oo6cRGMXsa1H8kahMLgUWUd3DiKW5GP5M0Xx49fv/XwVZjhW6QUwPly7g2rxFOm1+pA/
         EQiaX19a+1Sf3zDtOh6Re9emAjHYi1olHtTwKGszj7KkV5B+cSVPh20An4SBu+09EP6J
         ZEDHUawjMzJ1KUNCLX9dQP93PVRsYlJxvU0ljZwKZkR3PrTWaQzVSTtcJ0O5z4s3GSdl
         lSbHtx2sHVViIc1a+mkvw+A3Fbxl/fsM5PRyPFROQMmCXVh4d9ITDEFm/ETiGhfpD/XI
         4OtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXru9gxVuktOfsz0nykMKNv7tTTKC0saRCJd+dO8dAGctivBsFEnBXOPiv/xViw65lYlkDdlXNbvW7RobgTp266xmeP0AkhnFdudo5O
X-Gm-Message-State: AOJu0YxnVzV7mMbHHtJGvTuMm9ZTGI8PJ/BFRT26HubBlHiP4siqbVkt
	OayPwkxF0ZoYrWmY3E79PuSWrjUk9JBJPZiLD11eqJrwyNGx4ka3PQE5En2qLc3g5sJD7oRW4pD
	D+XM9WfiwvAAQi1/lv3jZo1qJrr3Sb7Q1KMoYgjiY1ZwktqfcC2Piotuji/C5zw==
X-Received: by 2002:adf:b181:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-3683562807bmr792133f8f.3.1721210626306;
        Wed, 17 Jul 2024 03:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZMaMM/YNczX0cw9wpIxopyWrWItHYZSbxrXody/MrV4kGfsyyakbkWtBBdGKIBbweLzWbA==
X-Received: by 2002:adf:b181:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-3683562807bmr792108f8f.3.1721210625787;
        Wed, 17 Jul 2024 03:03:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf3bdsm11219746f8f.30.2024.07.17.03.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 03:03:45 -0700 (PDT)
Message-ID: <cdee4c58-49aa-4746-a6cc-8ef833f2322e@redhat.com>
Date: Wed, 17 Jul 2024 12:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com>
 <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
 <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
 <756c359e-bb8f-481e-a33f-163c729afa31@redhat.com>
 <8c32a2fc-252d-406b-9fec-ce5bab0829df@arm.com>
 <a8441245-ae35-443f-9aea-325007492741@arm.com>
 <5c58d9ea-8490-4ae6-b7bf-be816dab3356@redhat.com>
 <f03deb7c-9a67-4096-9d33-32b357b52152@arm.com>
 <9052f430-2c5a-4d9d-b54c-bd093b797702@redhat.com>
 <f84bd34d-ac64-4e2f-90c0-d637c00b5055@arm.com>
 <5472faf5-1fbe-4a89-a17e-83716fc00b5a@redhat.com>
 <dca879ca-e430-4759-b992-4f763344319c@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dca879ca-e430-4759-b992-4f763344319c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>>
>>>>> But today, controls and stats are exposed for:
>>>>>
>>>>>      anon:
>>>>>        min order: 2
>>>>>        max order: PMD_ORDER
>>>>>      anon-shmem:
>>>>>        min order: 2
>>>>>        max order: PMD_ORDER
>>>>>      tmpfs-shmem:
>>>>>        min order: PMD_ORDER
>>>>>        max order: PMD_ORDER
>>>>>      file:
>>>>>        min order: Nothing yet (this patch proposes 1)
>>>>>        max order: Nothing yet (this patch proposes MAX_PAGECACHE_ORDER)
>>>>>
>>>>> So I think there is definitely a bug for shmem where the minimum order control
>>>>> should be order-1 but its currently order-2.
>>>>
>>>> Maybe, did not play with that yet. Likely order-1 will work. (although probably
>>>> of questionable use :) )
>>>
>>> You might have to expand on why its of "questionable use". I'd assume it has the
>>> same amount of value as using order-1 for regular page cache pages? i.e. half
>>> the number of objects to manage for the same amount of memory.
>>
>> order-1 was recently added for the pagecache to get some device setups running
>> (IIRC, where we cannot use order-0, because device blocksize > PAGE_SIZE).
>>
>> You might be right about "half the number of objects", but likely just going for
>> order-2, order-3, order-4 ... for shmem might be even better. And simply falling
>> back to order-0 when you cannot get the larger orders.
> 
> Sure, but then you're into the territory of baking in policy. Remember that
> originally I was only interested in 64K but the concensus was to expose all the
> sizes. Same argument applies to 8K; expose it and let others decide policy.

I don't disagree. The point I'm trying to make is that there was so far 
there was no strong evidence that it is really required. Support for the 
pagecache had a different motivation for these special devices.

But again, I agree that we should just make it consistent and allow for 
it. :)

-- 
Cheers,

David / dhildenb


