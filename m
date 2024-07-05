Return-Path: <linux-kernel+bounces-242306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835592867B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E0B2873D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433F146A63;
	Fri,  5 Jul 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McFvS1M8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34414659D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174463; cv=none; b=DaKwIm3v9BeXUkU22n49ccJIo8SLGJzkZBovde9yq6bvQrwYdJMVO4iwHxqwF9Ntm6eRHpZwHU33R60sJtRzi/HYGymfDoMh6HO59+JCBVzNXLqlDeaX1AUjgthrPq8ES46oTzrWdOFpniXbxywA33FxHwbaTe72mm3AvHYh1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174463; c=relaxed/simple;
	bh=P3G3ydRYpu02YdQz92pGLuPTM5aNlXhjwSGlNYlReSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJB6JVfAldPl8g9rYCXLzLlVIp4QVWJgtK+gR0BOW7g6VpDUIwDmP0GIrqKT79Uw/LQ2hfX7w7O5B6VFXRv4OkMpYb5IESdhCD4whw0Rn4YnjuhDGhapk2lyIji7bYm6PzKNh447V5mpspQeNwgH6MPgUSydRnwTKlVLV4fY3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=McFvS1M8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=66SEsZ3Y+YdmjAOiXUK8UPRFf6SUysBbZ0tEFkW2+Oc=;
	b=McFvS1M8b0DLO/+HB7M6iXoYOkBpl4XizXyPmc+Sq3qJwDLx4PxtUlKeDtN4vEZM1NQPmZ
	Srx44ZcSENCvaXoKKFOwXFk4h1WO8NsKTBb/2zO37xmaVyUjSJJht3Xt1zUTPVQ9wFvYKQ
	5B137oKEOXKAu6lwthg0UiPbdFTqygA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-YW5GjMbHO1a4rkrstB687Q-1; Fri, 05 Jul 2024 06:14:19 -0400
X-MC-Unique: YW5GjMbHO1a4rkrstB687Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-425739141c2so10980425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174458; x=1720779258;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66SEsZ3Y+YdmjAOiXUK8UPRFf6SUysBbZ0tEFkW2+Oc=;
        b=joqZ9p3sBLDeka0CCg/9IEiP6SiIY8KitF+7fk4QLDDpzECmTRTf74LtU6ArFPlBrz
         B2K3LpBr7K7QU1Cm66GLhgRKPdhUh2B+3eVNBX5zMJhw99l0ifhm4R+gJcJ9TthLsE1p
         S3oD3P79ivrmVkuEbDKS3oOZo41Ap6F/5yt+V/A2mHn3d9IDFhLGTydOZeH0kFa/JXYe
         ZpyovpXWd0GLJCmeJZBGh2JuSTHMVu1S8T0notfClsFgan1nvx8Us2enApWRJdifVBCt
         tUhaTJ5FTyL7XzevRYLrYDhBFizPWHAb/bYDsePksVrXTWQwcqBi5A9gcX1loRSY/67z
         KOsA==
X-Forwarded-Encrypted: i=1; AJvYcCVjDdQSPP9Wc3ARTc3EECYEyEnqJ1uVqYO++KE3fmhLtcXtx+/w/rQGQuebkhMGkMe/B6ybZ2JorGRs+68gIMkn8YF1hRQqrFwaWx/0
X-Gm-Message-State: AOJu0YyLI001OdBJ2+ORWJQfm76HpPO4+AxNzHjkpjkwXsAwpGrWCVbt
	JRg0rpA5Gew8bWeJmseX2ZGRDaj1lNJcSBPkjIKGHemoeyPq7Fg4uklnP7xsGOTkAV3NzmxQDO6
	LhlbCu0nW/LGO6H5Hh4+YkhegR2TXhrDpaAOqvMr0ZOWcdWqW0YO3tIS9SPsmiQ==
X-Received: by 2002:a05:600c:470e:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-4264a3e7a16mr32967405e9.21.1720174458570;
        Fri, 05 Jul 2024 03:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS9P+4VPsangZuGXQQyfG17BAtjT3oNKwGbT6Z9mVJH2NwP5/TCq7FLuzKdIZIZAnR58Qpwg==
X-Received: by 2002:a05:600c:470e:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-4264a3e7a16mr32967205e9.21.1720174458189;
        Fri, 05 Jul 2024 03:14:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4265476ce75sm8401445e9.1.2024.07.05.03.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 03:14:17 -0700 (PDT)
Message-ID: <3aef2bc6-c889-4a9a-b35d-f10ca8a5796a@redhat.com>
Date: Fri, 5 Jul 2024 12:14:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
To: Barry Song <21cnbao@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 dj456119@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, libang.li@antgroup.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
 <20240704012905.42971-2-ioworker0@gmail.com>
 <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com>
 <CAGsJ_4xX1cqKHU0eEsT=k0YDYKPs2m82bCkggdJyA1iwG4vXrg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xX1cqKHU0eEsT=k0YDYKPs2m82bCkggdJyA1iwG4vXrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.07.24 12:12, Barry Song wrote:
> On Fri, Jul 5, 2024 at 9:08 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>                i_mmap_unlock_read(mapping);
>>>    out:
>>>        xas_destroy(&xas);
>>> -     if (is_thp)
>>> +     if (order >= HPAGE_PMD_ORDER)
>>
>> We likely should be using "== HPAGE_PMD_ORDER" here, to be safe for the
>> future.
> 
> I feel this might need to be separate since all other places are using
> folio_test_pmd_mappable() ?

Likely, but as you are moving away from this ... this counter here does 
and will always only care about HPAGE_PMD_ORDER.

-- 
Cheers,

David / dhildenb


