Return-Path: <linux-kernel+bounces-372346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3A9A477A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82B41C22CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C356204940;
	Fri, 18 Oct 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKR7pIDk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC74817
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281552; cv=none; b=JKWCSy22GcSwS8Ngdlu+1Ioy66H8S65bX8sDu5QwIJX3RBcfvfFGRMP+Xx3CCY1MmFGNk1ZyIY8ZBG3nm2lJ/++9H4lnfVvwB6wmlYAEff/gpfeVYoEpwuqG23Z+k79A2/1RIwRJpPm8Gt563g7AMWAMCTAP5aLxhWaR/X3QKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281552; c=relaxed/simple;
	bh=hpDFp450DfcRgDoV8m9w9e7yYrUZeismdJsh166T44I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUDOQ1qC8l9/+8qB4VaQXOJekKXm6LGX5jWmXu1e9qGVS7eI8gL4TlEC/SGKk7OVrrw1ob+YgdTZoysfqtK7gueWLss/xw+R1hS5lBtNybDopYn866ied/5b92xuPYL9HE6LPlGbmNQ9N2/MYV7fDHkH5eiu10qNgtQcGGFABvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKR7pIDk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729281549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yIWx5rAtlYV9ME/Wl3a+Ac61PPsd2eNTIjoROcoLAxY=;
	b=KKR7pIDkACXXD6MZP5CoJwamSZ8T1pNpNCbmIFg193EutLxuobMnAiQ4y6DyBNiPrSXrkb
	to/QVluhAeRzqqSDc90yjSQi0BX3PxkYUa4gdBZH0sI/EtE0WAyruM58y/yOcko0bblvjh
	BEB9/+zvKPOhp2NVKeyYZCsoYXYm1wI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-W2CQcEoCMJSwKiRbAAd_5A-1; Fri, 18 Oct 2024 15:59:08 -0400
X-MC-Unique: W2CQcEoCMJSwKiRbAAd_5A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so10962895e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281547; x=1729886347;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIWx5rAtlYV9ME/Wl3a+Ac61PPsd2eNTIjoROcoLAxY=;
        b=sb+B+jN2LRENhYBr9ga5G50l2NLBPLAZFlIn75XtXhG7yxrpot7tqubi92U4Z1xLb6
         rtbY0+nsVG1utfkXZv0zC+sgG4fRMO8jHX2YXGzIDmI7ZPV10bQ8o2fpnnEOBBPhDJ1i
         P3hjjRluiKnP9CHVosowom78c7Flz5WG/afHNtUB1pslvM6nfXi1jYjw85jS3h6OJL+/
         XbCHbJcLHKLjMsHK49Dxcyl9+UJU504bejAhEeh2z85OGd8oMxLWJp1ou/jJtaSIWyVk
         dkBePac5oMiCaFsfLK6VHv65txBGc755YO+3cnrR8n2HVSH0SwlgGRs4ziWAnKTFHsfz
         VlLA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Z1U83QjuLeAW67f8WwbEk4gbZYvtgZ8UKeZk8CwhqI0evYqffK7eMSuog7HeHtoOcbNz1bC74loy/V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKew2vlZBBOXUGaFPxr8APWCzDRwY1/KmxF11Fhjat+wA4hI6
	Z9WVIesC+Dfe+pNSrEFJCiVueJqRtb1xRwyJVdo6sLFjaG9CdJ5h2PkYWJVpu9VPTb+nCHHI5qY
	YrtQDvBfQXaoqjnvS9mPi2jKRQkPWJPcOvW0aDbGeCuXTHKT0dkBuKWvfYiHz+g==
X-Received: by 2002:a05:6000:b45:b0:37d:47b3:7b86 with SMTP id ffacd0b85a97d-37eab6e4b77mr2520363f8f.44.1729281547098;
        Fri, 18 Oct 2024 12:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgZDJCtFrOUlaYYBqxBaEe63qGqkm5glFS1z/pNFJ9LP+nLq1MA80y9bEBSuZnI284nFHvwA==
X-Received: by 2002:a05:6000:b45:b0:37d:47b3:7b86 with SMTP id ffacd0b85a97d-37eab6e4b77mr2520338f8f.44.1729281546634;
        Fri, 18 Oct 2024 12:59:06 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23b63.dip0.t-ipconnect.de. [79.242.59.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027b89sm2676358f8f.16.2024.10.18.12.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 12:59:06 -0700 (PDT)
Message-ID: <39370a6a-b0d8-4591-89b5-05817dea9ce5@redhat.com>
Date: Fri, 18 Oct 2024 21:59:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Buddy allocator like folio split
To: Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
References: <20241008223748.555845-1-ziy@nvidia.com>
 <7ec81ff8-5645-42a1-a048-c8700aff07fa@redhat.com>
 <9A314663-43F1-49B5-9225-0E326A4DB315@nvidia.com>
 <CAHbLzkqDo7ADnwfvQsdKVqE18sUuz+98SVuk1nerW+vsE=nFSQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkqDo7ADnwfvQsdKVqE18sUuz+98SVuk1nerW+vsE=nFSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.10.24 21:44, Yang Shi wrote:
> On Fri, Oct 18, 2024 at 12:11 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 18 Oct 2024, at 14:42, David Hildenbrand wrote:
>>
>>> On 09.10.24 00:37, Zi Yan wrote:
>>>> Hi all,
>>>
>>> Hi!
>>>
>>>>
>>>> Matthew and I have discussed about a different way of splitting large
>>>> folios. Instead of split one folio uniformly into the same order smaller
>>>> ones, doing buddy allocator like split can reduce the total number of
>>>> resulting folios, the amount of memory needed for multi-index xarray
>>>> split, and keep more large folios after a split. In addition, both
>>>> Hugh[1] and Ryan[2] had similar suggestions before.
>>>>
>>>> The patch is an initial implementation. It passes simple order-9 to
>>>> lower order split tests for anonymous folios and pagecache folios.
>>>> There are still a lot of TODOs to make it upstream. But I would like to gather
>>>> feedbacks before that.
>>>
>>> Interesting, but I don't see any actual users besides the debug/test interface wired up.
>>
>> Right. I am working on it now, since two potential users, anon large folios
>> and truncate, might need more sophisticated implementation to fully take
>> advantage of this new split.
>>
>> For anon large folios, this might be open to debate, if only a subset of
>> orders are enabled, I assume folio_split() can only split to smaller
>> folios with the enabled orders. For example, to get one order-0 from
>> an order-9, and only order-4 (64KB on x86) is enabled, folio_split()
>> can only split the order-9 to 16 order-0s, 31 order-4s, unless we are
>> OK with anon large folios with not enabled orders appear in the system.
> 
> For anon large folios, deferred split may be a problem too. The
> deferred split is typically used to free the unmapped subpages by, for
> example, MADV_DONTNEED. But we don't know which subpages are unmapped
> without reading their _mapcount by iterating every subpages.

Yeah, and I am still hoping we can get rid of the _mapcounts.

If you know a folio is exclusive, at least synchronously during 
MADV_DONTNEED you know what you can try split. Deferred would require an 
rmap walk -- if it's really worth it.

-- 
Cheers,

David / dhildenb


