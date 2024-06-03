Return-Path: <linux-kernel+bounces-199362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57928D8607
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B088281B62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EC1304B1;
	Mon,  3 Jun 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fclamVzZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA0133993
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428400; cv=none; b=J7eK/n13J80vt+29L6rppwb1u1FdwVN7nM5RxF91Dz5vQ+3shU3LzSrTVRqRqlESnXd7qBqoJ37BdnXWLhH/Am3SK4Ep5KOW+xFZlarLPyktvgLZq7Yegfrq82aSU1rT8MWeM7nf9neqywqubnxBJkHrZctcf2+Dvv7RbDOWnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428400; c=relaxed/simple;
	bh=rTOQfSThN4IuNZD6XPV64YyYKrICDrSSUFkw1vDzyMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kzq2fYP6hI5n5MdlO5c8AsyAu5ojFIdFW8dUm8eZ/jPQW/gPEmTT2DgIND2qH2oQLD3fhJBLcPVkk4ArsmXSy78RoaHyOi2eS3u4k81JcWX/i4npSiXAk3/1WiTzbwWv2aT1P2+IevfPU5ECry5nENQE9r+z4akwoeN1HRLyIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fclamVzZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717428397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR3gzbSbFprxB9YaC7VkGVWjaN6b8gn346fabhcrWew=;
	b=fclamVzZ2x+otbq3CySaP7ReQ7pl4oUYVYTa1NAMA82YbJnUHFo7Rcfvr0yy2+LyQbEScw
	wJKBO8E0XzLNRhROGe75hsFNDuW/ijDwzmbf50TAZZSCZM8TYI2pAzf77rMX8nXDfLRy4U
	F7Bbvho99fdCc9lpHCtvhYp6L0a4mE8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ILrfjTOcPb-o-NUjKuyJXg-1; Mon, 03 Jun 2024 11:26:35 -0400
X-MC-Unique: ILrfjTOcPb-o-NUjKuyJXg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4212976bcd2so27098525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717428394; x=1718033194;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WR3gzbSbFprxB9YaC7VkGVWjaN6b8gn346fabhcrWew=;
        b=VIcNcn/HdYBpNCggAJMIATlBzjZI5/unpCGkrRjvCDBuSUyNLR8ufo3DL1hTOIAWxv
         w9EdY42KJx7hxfGNNCa1tzj+0SGV5zublORoV8zoOj1Y0q4sEfSGI5n1lepcOo5owyJ2
         6xJlmN90tLGv1I5pdL4d9S/bEfJ/iNBgH8PTDThM2GUeXmPDbHR83KZLY4vpvTkEKD/z
         L2dSTyTU60JnRGugtFUkzvCyxH07RojElLBxlX8z1VNHROXp4I0sKx3sMq+2pPfHPetz
         gJTRdvEhxGazpZjmwlMQs6xHCqsu70KvLGcWLu2uYM749E3NOH2SwqdZjFww377yJi0a
         uSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUo2pCgRV0nIKaI029vThJ/j34fjCgxYcKrv6VnCcNFPA9bCpBBwsWYEh0+TJxUpFqAnrnqiOGkN7H5uS1RvvDtdqImSWdoTdfnJjOL
X-Gm-Message-State: AOJu0YyWKjOkU1Siz2laEFMVU1md/5d2mb03DmNvFGaLQZYCSdMJbzTN
	TrX41Msg8DERHre6U+Rru3KkWYvvL9BW1oR3DWDAF81WusuOzAoZneznQiQZ/m4g20nVoLRuwpe
	Z318dYXZDTh/03GMMA1EeSVsvgAT7G7gnTXQzrunEaGYeb4G1aDIsmGuTRwHQAQ==
X-Received: by 2002:a7b:c7c9:0:b0:41f:e720:eec9 with SMTP id 5b1f17b1804b1-4212e09d993mr75743295e9.25.1717428394359;
        Mon, 03 Jun 2024 08:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2HxabyCNApuJjaUF5MLd3eKYmYPMaSEviRmfbtP1bETiSwRdYTFJwMR9KHaKBa/nrZifPzw==
X-Received: by 2002:a7b:c7c9:0:b0:41f:e720:eec9 with SMTP id 5b1f17b1804b1-4212e09d993mr75743065e9.25.1717428393874;
        Mon, 03 Jun 2024 08:26:33 -0700 (PDT)
Received: from [172.20.10.8] (tmo-082-28.customers.d1-online.com. [80.187.82.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133227f8asm102626225e9.19.2024.06.03.08.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 08:26:33 -0700 (PDT)
Message-ID: <db8d4d78-a519-4642-a882-2a84f7a1366b@redhat.com>
Date: Mon, 3 Jun 2024 17:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using
 folio_pte_batch()
To: Matthew Wilcox <willy@infradead.org>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 ryan.roberts@arm.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 ziy@nvidia.com, fengwei.yin@intel.com, ying.huang@intel.com,
 libang.li@antgroup.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240603140745.83880-1-ioworker0@gmail.com>
 <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
 <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com>
 <Zl3axbhcljTg_X0C@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl3axbhcljTg_X0C@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 17:01, Matthew Wilcox wrote:
> On Mon, Jun 03, 2024 at 04:56:05PM +0200, David Hildenbrand wrote:
>> On 03.06.24 16:43, Matthew Wilcox wrote:
>>> On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
>>>> +++ b/mm/mlock.c
>>>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>>>>    static inline unsigned int folio_mlock_step(struct folio *folio,
>>>>    		pte_t *pte, unsigned long addr, unsigned long end)
>>>>    {
>>>> -	unsigned int count, i, nr = folio_nr_pages(folio);
>>>> -	unsigned long pfn = folio_pfn(folio);
>>>> +	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>> +	unsigned int count = (end - addr) >> PAGE_SHIFT;
>>>
>>> This is a pre-existing bug, but ... what happens if you're on a 64-bit
>>> system and you mlock() a range that is exactly 2^44 bytes?  Seems to me
>>> that count becomes 0.  Why not use an unsigned long here and avoid the
>>> problem entirely?
>>>
>>> folio_pte_batch() also needs to take an unsigned long max_nr in that
>>> case, because you aren't restricting it to folio_nr_pages().
>>
>> Yeah, likely we should also take a look at other folio_pte_batch() users
>> like copy_present_ptes() that pass the count as an int. Nothing should
>> really be broken, but we might not batch as much as we could, which is
>> unfortunate.
> 
> You did include:
> 
>          VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> 
> so at the least we have a userspace-triggerable warning.

Yes, and max_nr == 0 would likely not be healthy to the system.

But

For copy_pte_range(), zap_pte_range() and the madvise users, we should 
always have:
	next = pmd_addr_end(addr, end);

and use "next" as the actual "end" -- not the VMA end. So "end - addr" = 
"next - addr" should never exceed a single PMD size.


mlock_pte_range() is also called from walk_page_range(), which uses
	next = pmd_addr_end(addr, end);

So likely exceeding PMD size is not possible here and all is working as 
expected.

Will double check later.

-- 
Cheers,

David / dhildenb


