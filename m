Return-Path: <linux-kernel+bounces-201881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9038FC488
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38291F2246C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDF1922EA;
	Wed,  5 Jun 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KocPyFfI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244371922D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572424; cv=none; b=pMLBDeb2jJgjzu7BP6Kj+YUtO6YA49V82RnWlKOR37R5WV6AV0Txsu+ruumGjds1hiaDu9C1gkaXJYBPhZJd1zbCWtr9+awEzvRL82hNA/mJH5K26o34xndcw6TNBH/Fl8mgv+i0b7q4LyMDE5aT1m6xWNgkcABNC9gm3Bx7JRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572424; c=relaxed/simple;
	bh=y7LlKvGCiauiAyPXS1LvPO6cl7kVvdUsS8fofe0gjfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o7dYQrWsEkpw5Ex34WlDQCtakzCmUQ814fpkbCIxfoiGXt8hsYQRpRsdaYpUDFDKixITkb2zB6d4Lve8dSLbGQ2rH2DbEMFAXELc6x2V964SxKfdWN1olZG9XvHiaHp4sD+OmPNzn25GdCcipq7wXpxDOCZBBQVeSfPgdMcA0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KocPyFfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717572421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TA3mj1PxiAshfBH76l4D+f7N+ffZj+zjGUHLmudFEWI=;
	b=KocPyFfIdXO9XfJ3nQyf4qbNwo5AT5+Equ0Dkjc+1S6f/JK9dmBMXhSMwSK9NmG9lfEls2
	GnpdFFRnEdWk/ATajETitcccSHiacIC62HFhmqKrLYcdmvELxc3jUAlyBvrdh0hIX/KSo1
	h+GUIDHVvHc0NwhiYWexxL7/Tw92xDs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-GpzgHjcbO7mYaLoKR7i1mg-1; Wed, 05 Jun 2024 03:26:57 -0400
X-MC-Unique: GpzgHjcbO7mYaLoKR7i1mg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2eaa570a238so29975801fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717572416; x=1718177216;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA3mj1PxiAshfBH76l4D+f7N+ffZj+zjGUHLmudFEWI=;
        b=mUoFv+N1fwA4Cs/HHrLafnsdGKMU1jDGOLoYF/pKV8YTO8Rt2QWkuyBKF5W9nP8ckW
         moLgVO6pqM2vzJ2orqu9/au57IYH3A5FB60QOlz6PwGEX2lhtUHvSq36IVQ3/dNZ2poJ
         jTJ4SB2SGhIcHf3O50kXuJcUkw7MVTUTPcJBA1ZMzop69AFpAQmgoo2uoAUZ/cQhPWvf
         gSeHsblJ3PjMukaV7ucVgAjPC/kjFRhtvkj1uDOajlhi7vFuBPYO/8MTruDI7Neld3vY
         iCI+q6Y8jJ/UbAXUK2XgLgSrSwFuTDXJ9dZLRu03vA7UCefA29bL++wsxdBBb8PV8fEY
         UrLg==
X-Forwarded-Encrypted: i=1; AJvYcCUdXMzizRRkQGnYK8LcL4FNMje7Q2LX+KfWkCKxi+8sjFyTbgz4SeXYweaNWblKfbwoDITPyS7ofemvLkIjZFIqMBDdbBV1aVrKVM3E
X-Gm-Message-State: AOJu0YzhYH5GTdsb3KNii1m9W7Ywc8uWEUldwD8JsmvlXWDZYQil5Iz+
	lAKrwL1lUm/n9oMfXCLJ6upwF/HqT9+tt7+WP+/nm1RYG5bDspSJFqod6K8icdTx5oUB7vVB6Nv
	LA6larM4HCnZB8qaxxZ5kS75M56AlLWvArGPK4qgjfGwoi6TdXEs2w9GXkD2qhQ==
X-Received: by 2002:a05:6512:2253:b0:523:9515:4b74 with SMTP id 2adb3069b0e04-52bab4ca5e9mr1570950e87.14.1717572415769;
        Wed, 05 Jun 2024 00:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHksmRHMQM8/qXMreGd2ECbq6RVzLzjeQA2e1/BdnSGG7JwVLdyWHb+QAHpXeyeGPI1SlZPJw==
X-Received: by 2002:a05:6512:2253:b0:523:9515:4b74 with SMTP id 2adb3069b0e04-52bab4ca5e9mr1570917e87.14.1717572415293;
        Wed, 05 Jun 2024 00:26:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f084eaddsm482823666b.89.2024.06.05.00.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:26:54 -0700 (PDT)
Message-ID: <59921e08-d0f1-4bc8-acee-368a978286a4@redhat.com>
Date: Wed, 5 Jun 2024 09:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-2-alexs@kernel.org>
 <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
 <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
 <7c6ae2a3-8ec3-4c9b-81c3-125f6973f0f3@redhat.com>
 <d059e397-beea-43dc-8c58-d7833b1d8bd4@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d059e397-beea-43dc-8c58-d7833b1d8bd4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 15:02, Alex Shi wrote:
> 
> 
> On 6/4/24 6:45 PM, David Hildenbrand wrote:
>> On 04.06.24 12:26, Alex Shi wrote:
>>>
>>>
>>> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>>>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>>
>>>>> We can put off the flush action util a merging is realy coming. That
>>>>> could reduce some unmerge page flushing.
>>>>> BTW, flushing only do at arm, mips and few other archs.
>>>>>
>>>>
>>>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>>>
>>>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>>>
>>>
>>> Hi David,
>>>
>>> Thanks a lot for comments!
>>>
>>> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
>>>
>>
>> Yes, but you would get more wrong checksums, resulting in more unnecessary pages_identical() checks.
>>
>> That is missing from the description, and why we want to change that behavior.
>>
>> What's the net win?
>>
>>> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?
>>
>> "I didn't see the guarantee for other writer from any other place" can you rephrase your comment?
>>
>> If you mean "the process could modify that page concurrently", then you are right. But that's different than "the process modified the page in the past and we are reading stale content because we missed a flush".
> 
> 
> Maybe moving the flush before checksum could relief some worries. :)
> But still no one knows what flush really help, since if page content only syncs to memory by the flush, the kernel or process can't be work with current code.

Please explain to me why we care about moving the flushs at all :)

If they are NOP on most architectures either way, why not simply leave 
them there and call it a day?

-- 
Cheers,

David / dhildenb


