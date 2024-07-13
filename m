Return-Path: <linux-kernel+bounces-251278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491249302EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A530FB224C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A4C13C;
	Sat, 13 Jul 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu0AMrg5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8242B802
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720832938; cv=none; b=fDj8U3JO7XPpOxMRXZfB1DTyEG9BdtDQfHtxlEz/dabTw9zZBdiE7UXETVoZ9yWeDi3GPRmBagEKe9v1WENUzAjHBGr5YJ8Qkh/KDtAwTC3NywuFHC7OWfYLZk3CvgkQ5qc0UQZoJZo3I6EIO27yss8WcLBTiVrmGKI791JbwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720832938; c=relaxed/simple;
	bh=vymcOzfkp+e8M4vMHjDtx9NJryu+f5ZRgMjb3ffSU/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXMde3XzpHYCak1Ja4H3DZejMpC2yFTHndQtYcV1N6v7sv3KCcVyOl5z3QGD2H+n/4Fnj2P6IV+6Rvm3NaZC45IDhUV9p2z5ay3ZK3LPG8QctG4Zm2gjnE4VQs4xhyYd0auJ/Pl5HQj0kOy+CP5eeskp9XgLaMzw/tp097I64bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lu0AMrg5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720832935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8hgY2LXUckGLUahLQvB6QT3LwtMnlKKwQsSz2J7Za6U=;
	b=Lu0AMrg55CxWQNBnIeFBYPNaqx61Fey6fZPzoosRttw9t2UuqfvI2BZVRtU7eEx9qtNIel
	1SO1wdQ+RAcOjk9717/p3S4NfIRP3mn+NNPIHIU/7gL5YcTDn324GA/kb4j/aFLk9CcS7K
	eCWG9xbBA9tAZRMOq0DkxZjJRSbuXik=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-ApbkrlM5MMKaPetMVnTRLg-1; Fri, 12 Jul 2024 21:08:53 -0400
X-MC-Unique: ApbkrlM5MMKaPetMVnTRLg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70af7dc9780so2028139b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720832933; x=1721437733;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8hgY2LXUckGLUahLQvB6QT3LwtMnlKKwQsSz2J7Za6U=;
        b=c94cOPONcSs+djdZymDAVPQZLqzHbxwsBCVOodMXGZMltVOAE/a1MFwEW+3hCQal3e
         sciGe9lU1GPRRZRrjdZO/4nbIN09e4vWzf9E+BEr1RPIm/2uZ4lEgpVjbZvEzDE38dGG
         6fnTxD+qg9Ht0qHp1TXKkyA1VQEMZnnzMoiYnX9SPWOWyn77O1UyFN07QAnYZUiPvw6l
         40U2/plnTtvJATndzVQZe50WNcDWHy/dSBhex5EeSdC9+D3153RI5Ax2gwCxwU53E/st
         bWJou5K10P0iREz4QVpv/ttZUL4v3v6cqg/heQ3cL5i1Kf/PWh87H/6IqxS0SF7uIZe9
         6Viw==
X-Forwarded-Encrypted: i=1; AJvYcCUioTKJX6neU+5UUEtsGeDWwDLD8rfDr3LlxcGJo9GS04CHwjUMKImU+xq/w64ibwMo/BcX0CRynszsj7zU6HjGNI67OGEgHF7e8OiK
X-Gm-Message-State: AOJu0Yy9VkmH+llxaQW6gHizPme9wfI21XsLuBkpv9iSoYqDF9r6TT3T
	MDihf81ckjKV3BaElJ6F3CeHfIdhNJ3IIofJ2WlScUclilcnD2NqYhd6XdcKqVreTusexBpw6oG
	JFFZxL5j/uFycz4azhWqDIj44xbXVRcfmhUHDNSmg/013jDtu5C2sImDECzTi5g==
X-Received: by 2002:a05:6a00:4b51:b0:706:3d61:4b21 with SMTP id d2e1a72fcca58-70b6cae4c6amr6293790b3a.3.1720832932798;
        Fri, 12 Jul 2024 18:08:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa2cumK9ibyG97YOlpEN8kL079eVttDRnz0SscxZBj5CpAVCC9P68ouCFgnidIdRQ8q2ieVQ==
X-Received: by 2002:a05:6a00:4b51:b0:706:3d61:4b21 with SMTP id d2e1a72fcca58-70b6cae4c6amr6293763b3a.3.1720832932353;
        Fri, 12 Jul 2024 18:08:52 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9965sm157529b3a.199.2024.07.12.18.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 18:08:52 -0700 (PDT)
Message-ID: <756c359e-bb8f-481e-a33f-163c729afa31@redhat.com>
Date: Sat, 13 Jul 2024 03:08:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
To: Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com>
 <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
 <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.07.24 14:22, Lance Yang wrote:
> On Fri, Jul 12, 2024 at 11:00 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/7/11 15:29, Ryan Roberts wrote:
>>> Expose 3 new mTHP stats for file (pagecache) folio allocations:
>>>
>>>     /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
>>>     /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback
>>>     /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback_charge
>>>
>>> This will provide some insight on the sizes of large folios being
>>> allocated for file-backed memory, and how often allocation is failing.
>>>
>>> All non-order-0 (and most order-0) folio allocations are currently done
>>> through filemap_alloc_folio(), and folios are charged in a subsequent
>>> call to filemap_add_folio(). So count file_fallback when allocation
>>> fails in filemap_alloc_folio() and count file_alloc or
>>> file_fallback_charge in filemap_add_folio(), based on whether charging
>>> succeeded or not. There are some users of filemap_add_folio() that
>>> allocate their own order-0 folio by other means, so we would not count
>>> an allocation failure in this case, but we also don't care about order-0
>>> allocations. This approach feels like it should be good enough and
>>> doesn't require any (impractically large) refactoring.
>>>
>>> The existing mTHP stats interface is reused to provide consistency to
>>> users. And because we are reusing the same interface, we can reuse the
>>> same infrastructure on the kernel side. The one small wrinkle is that
>>> the set of folio sizes supported by the pagecache are not identical to
>>> those supported by anon and shmem; pagecache supports order-1, unlike
>>> anon and shmem, and the max pagecache order may be less than PMD-size
>>> (see arm64 with 64K base pages), again unlike anon and shmem. So we now
>>> create a hugepages-*kB directory for the union of the sizes supported by
>>> all 3 memory types and populate it with the relevant stats and controls.
>>
>> Personally, I like the idea that can help analyze the allocation of
>> large folios for the page cache.
>>
>> However, I have a slight concern about the consistency of the interface.
>>
>> For 64K, the fields layout:
>> ├── hugepages-64kB
>> │   ├── enabled
>> │   ├── shmem_enabled
>> │   └── stats
>> │       ├── anon_fault_alloc
>> │       ├── anon_fault_fallback
>> │       ├── anon_fault_fallback_charge
>> │       ├── file_alloc
>> │       ├── file_fallback
>> │       ├── file_fallback_charge
>> │       ├── shmem_alloc
>> │       ├── shmem_fallback
>> │       ├── shmem_fallback_charge
>> │       ├── split
>> │       ├── split_deferred
>> │       ├── split_failed
>> │       ├── swpout
>> │       └── swpout_fallback
>>
>> But for 8K (for pagecache), you removed some fields (of course, I
>> understand why they are not supported).
>>
>> ├── hugepages-8kB
>> │   └── stats
>> │       ├── file_alloc
>> │       ├── file_fallback
>> │       └── file_fallback_charge
>>
>> This might not be user-friendly for some user-space parsing tools, as
>> they lack certain fields for the same pattern interfaces. Of course,
>> this might not be an issue if we have clear documentation describing the
>> differences here:)
>>
>> Another possible approach is to maintain the same field layout to keep
>> consistent, but prohibit writing to the fields that are not supported by
>> the pagecache, and any stats read from them would be 0.
> 
> I agree that maintaining a uniform field layout, especially at the stats
> level, might be necessary ;)
> 
> Keeping a consistent interface could future-proof the design. It allows
> for the possibility that features not currently supported for 8kB pages
> might be enabled in the future.

I'll just note that, with shmem/file effectively being disabled for 
order > 11, we'll also have entries there that are effectively unused.

Good question how we want to deal with that (stats are easy, but what 
about when we enable something? Maybe we should document that "enabled" 
is only effective when supported).

Hmmmmm

-- 
Cheers,

David / dhildenb


