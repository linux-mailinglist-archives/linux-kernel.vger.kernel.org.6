Return-Path: <linux-kernel+bounces-203709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09D8FDF54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8EF28419F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7C13AD15;
	Thu,  6 Jun 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPgfjJR4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE719D890
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657927; cv=none; b=jDW4TXTFBAdTRRdvdDC1ybYEMH+16HaSt/wbH2p/YmiRgh7J7AkPZ1EXkAVtTYB6RE93TV0kerLtAC1E4cqWzvNEo+2Bgyn96y15NP/dwCrE7WaJLPIceAPDWbRAzLBiwd25M4+FmI+Vxp3/ktO6kjkabFL9qCTAAaYcdCw6oKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657927; c=relaxed/simple;
	bh=I5z9eaoBPAQEt/E5LaNJHWfoNQ7SKNQ3Hz1xby94dbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hlu/B6jv01c26aHHeHVldyVcp1zTUB9ZMHdvNaNyHpxPlIO6izIVDV3mFKid/BiKNlwkonIX0pep+v0z4uyF4dDe7h9o0PTqWFadgsKRALi8yBZTZ20gZUMZkzcwbzMidLxkRvWUAbCSr08C3glCXMZN5Q2/3HtMRbicNw4Lp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPgfjJR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717657924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iwLpS2SsEzwig9uWKOT4tLyOu5yK5atqxXHep5Y87M0=;
	b=UPgfjJR4hXSWg1tZh2yh6k4Re6RxA/EPgqoFACAr7OdmpfqMLy0GUn+UnyoaFruSRG9x5z
	W0XJ6v5un8q1IEv+YQfmJsPh0vfKOivKbeYsaFJr2myE1lL3dPGS+j0CRsIP3JGmgFXX4m
	AhewxhviCAUxOu5z65KHNbSQpNuu+fQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-DBo3UW9FOQ6HeRRcPQAZOg-1; Thu, 06 Jun 2024 03:12:02 -0400
X-MC-Unique: DBo3UW9FOQ6HeRRcPQAZOg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b9b364784so472561e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717657921; x=1718262721;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwLpS2SsEzwig9uWKOT4tLyOu5yK5atqxXHep5Y87M0=;
        b=UtDMC91jxRTr1Vx40hz0bXWRZ1foftwLq8GJcYfWvYGbDm6pDwoQCNPjuRzKT4r53T
         ro7MsnBO7RXPsmghEzVq09NFF8zXPFqA2s7H3ODchgLbzT4INmc9T/vHbRmHRkRjqvej
         BIxdhZTPm6jX+K4321LbmYYrT10G5eu6WwYat08l4oA9ryLX/b9Lm9j1977DapYkskkS
         ttjZR1TU01zbwOB9gnOjtLuDrvDVcN9oPq6rLyBI+t5nxG5Pg8lmmrvRxI6L4pjaAX5e
         hF8ficv2zfnO253Wq8ejE++xOtLQBbHoUgb/DYXhwpPj1doXFh8R1AqQY/DVjeoXHpxx
         b01w==
X-Forwarded-Encrypted: i=1; AJvYcCVFCqNXAdz7sd9NStkt6oUSsX3GlrfOGmkZnDyU9rFBT+25gNTeNuU+wEA4DQsea7dSKInQmpvVcyEgJ5iA9ED1h3bRcOf5tSrHYxKe
X-Gm-Message-State: AOJu0YxYtaRimb/2aO+cHUV1tWqVaCITMhCRiikY0pnBjsLarLvA33Yr
	dMWZ61pWxnAqGaXDa5niKjo7hbdPUT5eDbkV9qV3flcVOzTBVEZP0OSIlLGyye8xXjTl12CUTTg
	oYy2g62DMsNxgkKEXyiNe/UAIVahm9GXvE609ZuscolzufkQuQAAC+gnG8i3HR8lkc+HUaA==
X-Received: by 2002:ac2:5331:0:b0:51b:6296:8d1a with SMTP id 2adb3069b0e04-52bab4d48admr2896954e87.29.1717657921393;
        Thu, 06 Jun 2024 00:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzwmEjG/5UkR3xB1KTDFFcCQ8+SZmZ/JwPMN/8Ko0j5gHwhkjXlCvoRUDwLih5HBkUyOEwvQ==
X-Received: by 2002:ac2:5331:0:b0:51b:6296:8d1a with SMTP id 2adb3069b0e04-52bab4d48admr2896942e87.29.1717657920964;
        Thu, 06 Jun 2024 00:12:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f6c0sm44711195e9.46.2024.06.06.00.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 00:12:00 -0700 (PDT)
Message-ID: <6c1fdc0a-98dd-47b5-933e-e2f6a91bc31f@redhat.com>
Date: Thu, 6 Jun 2024 09:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: Matthew Wilcox <willy@infradead.org>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 aarcange@redhat.com, chrisw@sous-sol.org, hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <Zl_g7qmXAJDy4vKu@casper.infradead.org>
 <5bb3bbf6-6a22-449f-96f1-b9476357f284@gmail.com>
 <8a614d01-191e-45d1-b6b6-c36ec0bd9e5a@redhat.com>
 <ZmDUpryUaVraNF6m@casper.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmDUpryUaVraNF6m@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 23:12, Matthew Wilcox wrote:
> On Wed, Jun 05, 2024 at 09:47:10AM +0200, David Hildenbrand wrote:
>> On 05.06.24 08:14, Alex Shi wrote:
>>>
>>>
>>> On 6/5/24 11:52 AM, Matthew Wilcox wrote:
>>>> On Tue, Jun 04, 2024 at 12:24:44PM +0800, alexs@kernel.org wrote:
>>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>>
>>>>> When a folio isn't fit for KSM, the subpages are unlikely to be good,
>>>>> So let's skip the rest page checking to save some actions.
>>>>
>>>> Why would you say that is true?  We have plenty of evidence that
>>>> userspace allocators can allocate large folios, then use only the first
>>>> few bytes, leaving many tail pages full of zeroes.
>>>
>>> Um, that do need tail pages...
>>> Is there some way to use more folio in ksm?
>>
>> My take, and Willy can correct me if I am wrong:
>>
>> "struct page" is not going to away any time soon, but it might shrink at
>> some point.
>>
>> That is, we can use the "struct page" pointer to point at a page frame, and
>> use "struct folio" to lookup/manage the metadata.
> 
> Right.
> 
>> That is, use "struct page" when accessing the actual memory content
>> (checksum, testing for identical content), but use the folio part when
>> looking up metadata (folio_test_anon() etc). In the future we might want to
>> replace the "struct page" pointer by an index into the folio, but that
>> doesn't have to happen right now.
> 
> My current thinking is that folio->pfn is how we know where the memory
> described by the folio is.  Using an index would be memmap[folio->pfn +
> index] which isn't terribly expensive, but we may as well pass around the
> (folio, page) pair and save the reference to memmap.

Right, as soon as the folio does not overlay the head page it's going to 
be a bit different.

A (folio,page) pair, like we use in the RMAP code, is likely the best 
option for now and gives us sufficient flexibility for the future design.

-- 
Cheers,

David / dhildenb


