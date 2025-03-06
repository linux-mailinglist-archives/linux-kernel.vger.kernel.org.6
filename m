Return-Path: <linux-kernel+bounces-548528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7CA5461D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A33B06F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039820967A;
	Thu,  6 Mar 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHCHDg7Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBD20967B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252796; cv=none; b=MGvKL877QvRFDE3i+7CEVqTxpW/rifPCTDyx6/TUNv/1QCc2SyaMnQJAeqS5R3Zo9ZXs7usmhKiSO4HfKHAjdcFFKfOJCtkVA6pvp9ps/shodGCJ05rxnNAbx1IZwg3eUQemRhp79NoNtMxIdTIG54kenpWAxGsUCF/2wh6fU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252796; c=relaxed/simple;
	bh=mf58Myv1K0m3ZaI7IqcyVzcArb/fIOAqAO4NCBEARQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIcPoP1u0WwfL8Uc9ol/pt6h5r532UNEfkGM4cBGLZFfenCC2Zc9SR6w6ZwGFx70vRAtK/JP/98bCSatatQiKHQXoJR8uWLy3wjihp+mbFt19OD0lBMldN6K3z1pb8LxkqFI4SUDS9TAeQ+g3j67/N7Ltt6gAHkAAmwRcH1+CXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHCHDg7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741252793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j4u9DLEhIx3HFuqYUpbNqKrefyTEPoTUC28xU5Dyl5E=;
	b=MHCHDg7QIDG4KShiRDE5f+eugQN2UUWxFkNgcuC6SbVKW7+ZiURSxzhY8AMb7qJ+H6W0W3
	uyFwAS39U/iSYYxjWPOHcKSwDFfqV+2KxGV2JbbTk4tA2lI7mo0X8UGdJ3ltxRz0Kezvty
	of9oxJloRDszRAEM9rwQXZc700Atves=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-c_0vvMdPO4-VYb17mS99qA-1; Thu, 06 Mar 2025 04:19:47 -0500
X-MC-Unique: c_0vvMdPO4-VYb17mS99qA-1
X-Mimecast-MFC-AGG-ID: c_0vvMdPO4-VYb17mS99qA_1741252786
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390e62ef5f6so164051f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252786; x=1741857586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4u9DLEhIx3HFuqYUpbNqKrefyTEPoTUC28xU5Dyl5E=;
        b=ZpI6uwhFDAX5/yVzvlbbD14uPjfXyb8e4zSn/ftVHElgr8UJNVioOzg/uesbx2IFZq
         1BFW/BdSaHgSGzGKBEq3BKj8CYwPy9UvC/P+Z3oQ0bmlOCvh1WawS/0jmt5l/IGje0e6
         0842cUDiuB8HdUvTbzc1DGM7w0AAO7DSjJLiTKMM06On0//u6/pJSZOl/2jLEnZ27yy0
         BfIB4BxSmfk9zvnP7SLXnT5wd6x40LtZGRIr9Piqdvb8kEEYGnJaDKtkFUDNxh3BhjBZ
         e7vij2KJF52dAgAFWUlzzBtvl8MpWE0SvNrUx8Pk1peowxo8UPm+HqAaEdjD3UYd4/fK
         utaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhs2h4+SFPt+VcFUv+TUHzFjgjA2T/s0fzGSAhpdmIJjU0Qb/WuJciglNDFdRKYkO4OLMsRFIBDE8JkTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBysIN89M95n0UlLOVVqRLaaQ9isYJfyPgwl0nwSeeCSqrtq1
	zSZ4wHRHU7N2sB4nevMZZJa3h0yFcCK4Wuq3vfjcZHsItVWoFI5bwFSlVdHcDKenUQs7ACk/t1j
	tucAl25NTaZXDsRk5WiqBE8ZlvhaWFBYKxaGYs2wC8yJ3VPTJ0vqw5oendQHPtw==
X-Gm-Gg: ASbGncsRLrhldJVm0v6fq2phMP5LMOmNEN4A4vTy3OI3JQY0Uy7lCzTopSj3YqgT5Z6
	+oVVoOVcCvWG7i5+XkRAhwimp22NfXQJEFcRC7gaU2NeEaBSJHnx5FXOhkSJNKNuaeVKg4EO5Of
	nyD5aUvtI4am3xVQ3cAMxw9+364vBglywD8SmBp1A+rcU68G0sJ40s90zzEj3aYhhXMIyZ+o5CF
	M/MoHdF8hFSTo8EPk8qUjM6o4/NsvzU7Xg5teCnRAdIN84j3GWqRfkf1qmutxLG9BsWvA7/97JQ
	2G/4f8B+IADIyrDQj4k3s8U/hO1YlTZO2bN8JP0Tw68eR2+qAJGsqxNrt8/p+MX2/XmBdreqlZ6
	UgBLlY6PgUdmL6tufLNIV4Z4n/TCOlb0+9+h1Xmp9F64=
X-Received: by 2002:a5d:64ae:0:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3911f72ff44mr5895155f8f.2.1741252786099;
        Thu, 06 Mar 2025 01:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgHNDlyxd7gScP5sRIupjVHZHV0IbVTS8wDNRrqJlrNF8ED9HuMeKDsApwMXgdi6IQFHmMpw==
X-Received: by 2002:a5d:64ae:0:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3911f72ff44mr5895129f8f.2.1741252785657;
        Thu, 06 Mar 2025 01:19:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm1425864f8f.33.2025.03.06.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:19:45 -0800 (PST)
Message-ID: <4a9f102a-60db-475a-a933-975edb2fb1dd@redhat.com>
Date: Thu, 6 Mar 2025 10:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
To: Zi Yan <ziy@nvidia.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
 <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
 <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 22:08, Zi Yan wrote:
> On 5 Mar 2025, at 15:50, Hugh Dickins wrote:
> 
>> On Wed, 5 Mar 2025, Zi Yan wrote:
>>> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
>>>>
>>>> I think (might be wrong, I'm in a rush) my mods are all to this
>>>> "add two new (not yet used) functions for folio_split()" patch:
>>>> please merge them in if you agree.
>>>>
>>>> 1. From source inspection, it looks like a folio_set_order() was missed.
>>>
>>> Actually no. folio_set_order(folio, new_order) is called multiple times
>>> in the for loop above. It is duplicated but not missing.
>>
>> I was about to disagree with you, when at last I saw that, yes,
>> it is doing that on "folio" at the time of setting up "new_folio".
>>
>> That is confusing: in all other respects, that loop is reading folio
>> to set up new_folio.  Do you have a reason for doing it there?
> 
> No. I agree your fix is better. Just point out folio_set_order() should
> not trigger a bug.
> 
>>
>> The transient "nested folio" situation is anomalous either way.
>> I'd certainly prefer it to be done at the point where you
>> ClearPageCompound when !new_order; but if you think there's an issue
>> with racing isolate_migratepages_block() or something like that, which
>> your current placement handles better, then please add a line of comment
>> both where you do it and where I expected to find it - thanks.
> 
> Sure. I will use your patch unless I find some racing issue.
> 
>>
>> (Historically, there was quite a lot of difficulty in getting the order
>> of events in __split_huge_page_tail() to be safe: I wonder whether we
>> shall see a crop of new weird bugs from these changes. I note that your
>> loops advance forwards, whereas the old ones went backwards: but I don't
>> have anything to say you're wrong.  I think it's mainly a matter of how
>> the first tail or two gets handled: which might be why you want to
>> folio_set_order(folio, new_order) at the earliest opportunity.)
> 
> I am worried about that too. In addition, in __split_huge_page_tail(),
> page refcount is restored right after new tail folio split is done,
> whereas I needed to delay them until all new after-split folios
> are done, since non-uniform split is iterative and only the after-split
> folios NOT containing the split_at page will be released. These
> folios are locked and frozen after __split_folio_to_order() like
> the original folio. Maybe because there are more such locked frozen
> folios than before?

What's the general concern here?

A frozen folio cannot be referenced and consequently not trusted. For 
example, if we want to speculatively lookup a folio in the pagecache and 
find it to be frozen, we'll have to spin (retry) until we find a folio 
that is unfrozen.

While a folio has a refcount of 0, there are no guarantees. It could 
change its size, it could be freed + reallocated (changed mapping etc) ...

So whoever wants to grab a speculative reference -- using 
folio_try_get() -- must re-verify folio properties after grabbing the 
speculative reference succeeded. Including whether it is small/large, 
number of pages, mapping, ...

The important part is to unfreeze a folio only once it was fully 
prepared (e.g., order set, compound pages links to head set up etc).

I am not sure if the sequence in which you process folios during a split 
matters here when doing a split: only that, whatever new folio  is 
unfrozen, is properly initialized.

-- 
Cheers,

David / dhildenb


