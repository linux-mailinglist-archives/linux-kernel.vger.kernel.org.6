Return-Path: <linux-kernel+bounces-201899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8B8FC4EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC715B24996
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9518F2C4;
	Wed,  5 Jun 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRNbz3E1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503818C33A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573638; cv=none; b=NYqb6Jw+XZv9lzPQ+vxOZcUBvGnCmeWelnkUDwTK8+Gza13WG1jvVwBOho/kdum9Is5laA0mrOJxSWzn2lTr0SyFef3xTXjc8apIlW7y/72r8C0Tq1UhQ9innn9MUJ9bQlgU8Hvz6QiC0R0b2KrCW2a9853Ti/2viDnyo63Ix0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573638; c=relaxed/simple;
	bh=m4NVfVxoshkfn9v6LGSs1QzxCl3juqSPRFVJVhsYNPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIDB3Exk3JBct1VxA/Z+njM1gF/nysJqF5v/uwmxuUnG/t0sRTVsRqW3ixiaks93BVKgTlwJLP9n7iGVXRnF4S4JZ9XrB+w5HDE/PRZGr1gW5R0Assc/OfWOb6YYBsb1zedvXL5U6Vr+F0p22f/ZRig4L3n451LjwZmHYnpfmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRNbz3E1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717573635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PpPer5HDsHQEuYFwEstuKaB5aiI/RjnExa6+wFQamo8=;
	b=BRNbz3E1SEkPFskV7xftNMzBw+F46nA4Cq5ue4qokkSwMFi/eNdw2nKsJFyDVBb+Q7bXUl
	MhrkGL5HK/UTkiba2FDSHLI2e1wLoDLd6OSsOYEh90ARrhS0HutOQo23AY6aNYr6pXae0L
	PI6ChodwBlqXcXzIbNpegBk20nD6pTs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ksPh3QelMEWd0eX0IW11jA-1; Wed, 05 Jun 2024 03:47:13 -0400
X-MC-Unique: ksPh3QelMEWd0eX0IW11jA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42158c90cafso1712795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573633; x=1718178433;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpPer5HDsHQEuYFwEstuKaB5aiI/RjnExa6+wFQamo8=;
        b=Gpef3jEmuJY9wTqHT+eDCMPSZ7DWgMfP0XX7G9KX8XTy1g0I9nLuwl7TaniBs/IMRk
         UdAMcpAZclOuctqO/COfIVVqbqWigkw3NRl6uKP0V/ZLy+dzNhwyaWt+MpvWbx3mGwbn
         TLPbWv8hyKoVUJ2QgruH73JEmd/vk58BCK9HS01nhqM3K6EwofBh3IHiw0zFPFzWkB5p
         Tzdae0AOE1cjdyanrCkgzWPdy8cVlIFV+R86afW8xXbY3y7gbjU7VdC9jaEMBCPWngMV
         Khb48FYIUTKsysc2XuWSDAkxpzXgiGHVQwUPxPXLpMJcqi/D3xnRmMmWId5LeJWbPuOa
         1CcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQezCVManAL5q7Vuo766BDkAVsuDCTZ41euArUQdz0DZlVgz1z7CpYh6afQ5WZ0uJfbZVjUHVNb0pY3VcZH7YdirrZflBur54fHwOK
X-Gm-Message-State: AOJu0Yw1sh9PJPZmoXDi8J2W4Kg5FqKXyOTj2VTjgnM2JpFFdJHPgKPk
	W37BoBfALEbUf2UiWlrzkAkVQ7TW1W5dnpR80NY09RWo2n6EUXXO9R59qE1cS8nV4fplHZM9d6p
	C/uRO9KNChF+JdLYBhzzBmeIp0uIQsCQjDqnuVbktaD7x5RGBGdz1OIJqKAMsxQ==
X-Received: by 2002:a05:600c:4928:b0:421:1f6f:3e15 with SMTP id 5b1f17b1804b1-421562e9506mr13100965e9.16.1717573632789;
        Wed, 05 Jun 2024 00:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHpaCM44skKTGZ3djOclrWxKM7oM/OanykiAjTZmoCoWqjlod1zN2vRu0MXgPuT+hYNSuCkQ==
X-Received: by 2002:a05:600c:4928:b0:421:1f6f:3e15 with SMTP id 5b1f17b1804b1-421562e9506mr13100695e9.16.1717573632337;
        Wed, 05 Jun 2024 00:47:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158141104sm10487915e9.48.2024.06.05.00.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:47:11 -0700 (PDT)
Message-ID: <8a614d01-191e-45d1-b6b6-c36ec0bd9e5a@redhat.com>
Date: Wed, 5 Jun 2024 09:47:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: Alex Shi <seakeel@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 alexs@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 aarcange@redhat.com, chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <Zl_g7qmXAJDy4vKu@casper.infradead.org>
 <5bb3bbf6-6a22-449f-96f1-b9476357f284@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5bb3bbf6-6a22-449f-96f1-b9476357f284@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 08:14, Alex Shi wrote:
> 
> 
> On 6/5/24 11:52 AM, Matthew Wilcox wrote:
>> On Tue, Jun 04, 2024 at 12:24:44PM +0800, alexs@kernel.org wrote:
>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>
>>> When a folio isn't fit for KSM, the subpages are unlikely to be good,
>>> So let's skip the rest page checking to save some actions.
>>
>> Why would you say that is true?  We have plenty of evidence that
>> userspace allocators can allocate large folios, then use only the first
>> few bytes, leaving many tail pages full of zeroes.
> 
> Um, that do need tail pages...
> Is there some way to use more folio in ksm?

My take, and Willy can correct me if I am wrong:

"struct page" is not going to away any time soon, but it might shrink at 
some point.

That is, we can use the "struct page" pointer to point at a page frame, 
and use "struct folio" to lookup/manage the metadata.

That is, use "struct page" when accessing the actual memory content 
(checksum, testing for identical content), but use the folio part when 
looking up metadata (folio_test_anon() etc). In the future we might want 
to replace the "struct page" pointer by an index into the folio, but 
that doesn't have to happen right now.

For KSM, that would mean that you have a folio+page (late folio+index) 
pair when possibly dealing with large folios, but you can use a folio 
without a page when dealing with KSM folios, that are always small.

-- 
Cheers,

David / dhildenb


