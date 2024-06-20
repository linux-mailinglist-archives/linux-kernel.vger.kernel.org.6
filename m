Return-Path: <linux-kernel+bounces-223096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EED910D98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7711C21B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223F1B29CD;
	Thu, 20 Jun 2024 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7UWdsEn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0561B3743
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902327; cv=none; b=jJ8ThTJUptjff4p6StprtzZ5KYJdA4soryy2hnaj+U13T2MYGfaUt9Y4au6rNBk3UcuVsvwDZHqynb6zyrydDtI7idw+urCllT0fYXViO2IYB1tyjyMN3odSl63A1mjuYJgDp397Z39WL4lllDdZM3GlCDdqmDE9lPl1OalSrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902327; c=relaxed/simple;
	bh=V9G1TuLObH+hBuA1XVHFOx9/aQg59AkUqLikVHdJ4js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wdg/YTzNQhAtwfGIkG69sTjG5+biGYDfLRy3yMYN/gQlhRUld0oXM/DX+QRY04SY38vea8Jl5ZAHrBxE8NqyZT0MyRjMv7hRc5q8W5VP1BlIYfQ7VBtIxtAPWK14KKqPGWs1tdPo9MqL+KHsLFnSR4F5xpINyDA/s2hduqRWlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7UWdsEn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718902324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wmT/TfqWZIcOIEydAuy+1NX1w0tpwKPG8r51Xm9pXoo=;
	b=g7UWdsEnIQCTw73kHR5Mib433D6r3nMLYvXCTzwF9bBe1EVFbj2oxrVHVJXgterau/ZXEs
	08LPsIqabfUzVw2KsPD5uqq1HFmsuU/KsYwjDWuyMkmamsEwpeEEL/11npEn4Uu2aLBTvg
	viLSLz0+2r4tpqWCAcOnFAMbeAgdOcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-KdW3CWfgPnKgAiq4ptPhEQ-1; Thu, 20 Jun 2024 12:52:03 -0400
X-MC-Unique: KdW3CWfgPnKgAiq4ptPhEQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-423034c6119so7664535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902320; x=1719507120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmT/TfqWZIcOIEydAuy+1NX1w0tpwKPG8r51Xm9pXoo=;
        b=gmbkCKbhCZ+tBoCzCvDa1TFHLXa27chveZ/VcjEEsgmTzfbjYnVZVu4SlljeRbzL+k
         Ovtx+qkHC+WHpHOAXQZcBtx4AaQYMIKhGV5nHiDBqpS6hhp2Xhu+SVaXNxGjtkZzstGr
         95KmZEwUI1kfQRPkZXvjVhFtRwHhe+FS+qw6TJkiwzcL+YQM849kbpY179+kUfPmdsaI
         A7SR32Bp/lB2HkdyDGWviNGyyk8KuC1i3cldVpOIWTVaXdFajz9INWDIZ8lHzcxEnPjz
         xwIwWWxVz8kP3oOVBYl6rrpk56aQIV81duBqTBbHslbManz+XqF4cVY+vzjRcTsOEjmp
         Aa5A==
X-Forwarded-Encrypted: i=1; AJvYcCWd/P1/lJprjRERNyDjJuCAMed4p83NLwT+wPLKheB6Q4HWawpidCZUjgBXwx2WXXma/w4jGzhl9IVvdm5DBYj754y5t/szCNULRls/
X-Gm-Message-State: AOJu0YzgP33Bc4N42rSU9fhUEuN8yEeub4SD3K/Ipob3Ne0Mz4HIMNgO
	yRaNLWZseUmz5adfZW5SAhQW3dPt0sbOAlzbeJ3IPBESBKlbrPNjk/b1bkvwZVRFkkIrpY2vt15
	9RwNjijyrK+TBNDduXhkHm5Jhq6zEdB7lc3F70CPP3uoK7XOTenQ9UwgfOWk1GA==
X-Received: by 2002:a7b:cc13:0:b0:424:784c:b13b with SMTP id 5b1f17b1804b1-424784cb209mr34286525e9.13.1718902320395;
        Thu, 20 Jun 2024 09:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkU9eW+awitjJjD5GfqBhhuJt0IBeYp1kZXJAiUgDhww7y86Wx3yzlGriaKMbYnwqURbX5rg==
X-Received: by 2002:a7b:cc13:0:b0:424:784c:b13b with SMTP id 5b1f17b1804b1-424784cb209mr34286355e9.13.1718902319937;
        Thu, 20 Jun 2024 09:51:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b634asm32104925e9.1.2024.06.20.09.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 09:51:59 -0700 (PDT)
Message-ID: <1cdf6a43-9599-4e34-8f70-29ed16295a60@redhat.com>
Date: Thu, 20 Jun 2024 18:51:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for shmem
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song
 <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 willy@infradead.org, wangkefeng.wang@huawei.com, chrisl@kernel.org,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
 <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
 <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
 <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
 <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com>
 <2a358ff4-4219-4262-9225-d9aab14445f6@redhat.com>
 <f302f177-44e6-b74d-f140-b3bdf734b4b1@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f302f177-44e6-b74d-f140-b3bdf734b4b1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 18:27, Hugh Dickins wrote:
> On Thu, 20 Jun 2024, David Hildenbrand wrote:
> 
>>>
>>> (I do have doubts about Barry's: the "_new" in folio_add_new_anon_rmap()
>>> was all about optimizing a known-exclusive case, so it surprises me
>>> to see it being extended to non-exclusive; and I worry over how its
>>> atomic_set(&page->_mapcount, 0)s can be safe when non-exclusive (but
>>> I've never caught up with David's exclusive changes, I'm out of date).
>>
>> We discussed that a while ago: if we wouldn't be holding the folio lock in the
>> "folio == swapcache" at that point (which we do for both do_swap_page() and
>> unuse_pte()) things would already be pretty broken.
> 
> You're thinking of the non-atomic-ness of atomic_set(): I agree that
> the folio lock makes that safe (against other adds; but not against
> concurrent removes, which could never occur with the old "_new" usage).
> 
> But what I'm worried about is the 0 in atomic_set(&page->_mapcount, 0):
> once the folio lock has been dropped, another non-exclusive add could
> come in and set _mapcount again to 0 instead of to 1 (mapcount 1 when
> it should be 2)?

That would mean that we have someone checking folio_test_anon() before 
doing the folio_add_new*, and *not* performing that check under folio 
lock such that we can race with another folio_add_new*() call. (or not 
checking for folio_test_anon() at all, which would be similarly broken)

When thinking about this in the past I concluded that such code would be 
inherently racy and wrong already and the existing VM_WARN_ON_FOLIO() 
would have revealed that race.

Whoever calls folio_add_new*() either (a) just allocated that thing and 
can be sure that nobody else does something concurrently -- no need for 
the folio lock; or (b) calls it only when !folio_test_anon(), and 
synchronizes against any other possible races using the folio lock.

swapin code falls into category (b), everything else we have in the tree 
into category (a).

So far my thinking :)

> 
>>
>> That's I added a while ago:
>>
>> if (unlikely(!folio_test_anon(folio))) {
>> 	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>> 	/*
>> 	 * For a PTE-mapped large folio, we only know that the single
>> 	 * PTE is exclusive. Further, __folio_set_anon() might not get
>> 	 * folio->index right when not given the address of the head
>> 	 * page.
>> 	 */
>> 	...
>>
>> We should probably move that VM_WARN_ON_FOLIO() to folio_add_new_anon_rmap()
>> and document that it's required in the non-exclusive case.
>>
>>>
>>> But even if those are wrong, I'd expect them to tend towards a mapped
>>> page becoming unreclaimable, then "Bad page map" when munmapped,
>>> not to any of the double-free symptoms I've actually seen.)
>>
>> What's the first known-good commit?
> 
> I cannot answer that with any certainty: we're on the shifting sands
> of next and mm-unstable, and the bug itself is looking rather like
> something which gets amplified or masked by other changes - witness
> my confident arrival at Barry's series as introducing the badness,
> only for a longer run then to contradict that conclusion.
> 
> There was no sign of a problem in a 20-hour run of the same load on
> rc3-based next-2024-06-13 (plus my posted fixes); there has been no
> sign of this problem on 6.10-rc1, rc2, rc3 (but I've not tried rc4
> itself, mm.git needing the more urgent attention). mm-everything-
> 2024-06-15 (minus Chris's mTHP swap) did not show this problem, but
> did show filemap_get_folio() hang. mm-everything-2024-06-18 (minus
> Baolin's mTHP shmem swap) is where I'm hunting it.

Good, as long as we suspect only something  very recent is affected.

There was this report against rc3 upstream:

https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/

It's only been observed once, and who knows what's happening in that NFS 
setup. I suspected NUMA hinting code, but I am not sure if that really 
explains the issue ...

-- 
Cheers,

David / dhildenb


