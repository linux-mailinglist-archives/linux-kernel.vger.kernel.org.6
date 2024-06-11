Return-Path: <linux-kernel+bounces-209241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB59902F71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C94CB21916
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476516FF29;
	Tue, 11 Jun 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHDr8GxJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65216F90D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079267; cv=none; b=OER4jgwewNh5pRikJLFK0NQXyB7Hp5lbaG//3i5LN41WXajtIcE3zWN5sD4PkMlnP3P9Bg76jUs80UmqSkCPZj39Ak0PCt2lDVrIKim9zMlM4VOPP2auDhKabcdhG3FtasuJ7QSMohkEfZ82g+ZPpXoCu209h0iV+lDcAP3nZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079267; c=relaxed/simple;
	bh=aeEhIS1avSYmIOf0SxJ0/PHZgUl1AA2rrwylTjSMvB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI118y7h+bYfU9lzJBHObWxEqSz+Rl8JdZw0e+8N+AIBrbdx8rtfFo3rK7MR42JiFvM8sJHNLqzzukbvxVPsiJz7UamO/1JLNRDOtT2rrszA2fpQ619dUBuO7RpTirJV4R2pHWr2IV/EbWajV22x9v16q0yDYiv2HP0kJ2qef+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHDr8GxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718079264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1a8FseTl06wVgP6A7MAh41W7oTDkozR9kmXYeqUqGQ=;
	b=KHDr8GxJbJEdVSQ+Vjs2C/Vy/nSQLjjMAfwNSb75EdJmcGsH6Xixsz8eH0wFh+fNsGRI67
	cD5IIABXx6szUNRF3IbfRzDNKYgzXSzZN5vS4H7ewDbihpmHzdwCSVNc2Ik+QdAhI4Kcze
	83jYyW0rCq0aKaMN8wdN6J9uQC3ykQ8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-RFYZPsAWMPezvcdTF5hIMQ-1; Tue, 11 Jun 2024 00:14:22 -0400
X-MC-Unique: RFYZPsAWMPezvcdTF5hIMQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebd982d244so20238511fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079261; x=1718684061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1a8FseTl06wVgP6A7MAh41W7oTDkozR9kmXYeqUqGQ=;
        b=fF7rDD11ThpzKV92f0vbdCcxCBNeBNu1rhjf50FcBFyPM6MXkqDFTImNbQ2nSSxRgi
         /d8KqTv/XGXpIbg55OT1SbF05/nU/1wTRhqb+21x4g3z2Uq2EAQvmNZ10tipkPp2vg3O
         4v7vibiYITU9kG/NS8GNtId5igmrBAttOe+CeWZCeeJ3dUySPnPxKgfT737y3576sruD
         HJvq5bt76HRfoQwSss9EHxAi90jn6caM7u6e+3aKaukUW0mKxce/v1YiwNEyzGxyofuW
         vT3uPPyjSau3TrC4gJkY+qNjEoQ2wE3FQ0rVA6bT3UDxeirrY7OMp65qOkQ8j0czBXNs
         Jq4w==
X-Forwarded-Encrypted: i=1; AJvYcCV1o+SLNiBilbvq4TpTfCg1tWZaMxbFL81R/zHU6bxhE6rpjH+aQ+L5LwsCy/AyG4N3P2Q/OqRskfDGX7L3gYhEFtNs0kiAZlpG48CL
X-Gm-Message-State: AOJu0YxymSDloQTTssK8symqxmNPqtZaXzqe5sTGCRQ3P6hVml+Lm00R
	w7qmcIEhwXQE/Hwx2fEstDAg7nygF8p9T+SOAlY1KNhTZ7aG8LlgQnH2WrAqsUy9PusXnus4o4H
	o54zXj3O5TrJTKPfmQj7/wZbANRLH+kfqEUDrkIQmqaZDlBW37+ofEG8EeetU
X-Received: by 2002:a2e:984c:0:b0:2eb:dec1:6276 with SMTP id 38308e7fff4ca-2ebdec164f1mr36099211fa.0.1718079260767;
        Mon, 10 Jun 2024 21:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF18U05dfo0rZSYfNFu7sSh3sPoBIH4illqphSfrkMLiBcV/ScEVjN611SrAd51tjNmzYwCRA==
X-Received: by 2002:a2e:984c:0:b0:2eb:dec1:6276 with SMTP id 38308e7fff4ca-2ebdec164f1mr36099151fa.0.1718079260393;
        Mon, 10 Jun 2024 21:14:20 -0700 (PDT)
Received: from [192.168.1.86] (85-23-17-83.bb.dnainternet.fi. [85.23.17.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eaeaff2a05sm15898821fa.45.2024.06.10.21.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 21:14:19 -0700 (PDT)
Message-ID: <811778e4-6af4-563a-757e-83fec207e79f@redhat.com>
Date: Tue, 11 Jun 2024 07:14:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large
 folios
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <2821278f-bc94-c147-d0fe-8cc52dbdccb1@redhat.com>
 <CAJD7tkYepf6z1Q7HiSRAc7-S9OwYCphx=9NcyHxtW0YrkFv0sQ@mail.gmail.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <CAJD7tkYepf6z1Q7HiSRAc7-S9OwYCphx=9NcyHxtW0YrkFv0sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/10/24 20:35, Yosry Ahmed wrote:
> On Fri, Jun 7, 2024 at 9:08 PM Mika Penttilä <mpenttil@redhat.com> wrote:
>> On 6/8/24 05:36, Yosry Ahmed wrote:
>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>> index b9b35ef86d9be..ebb878d3e7865 100644
>>> --- a/mm/zswap.c
>>> +++ b/mm/zswap.c
>>> @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
>>>
>>>       VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>>
>>> +     /*
>>> +      * Large folios should not be swapped in while zswap is being used, as
>>> +      * they are not properly handled. Zswap does not properly load large
>>> +      * folios, and a large folio may only be partially in zswap.
>>> +      *
>>> +      * If any of the subpages are in zswap, reading from disk would result
>>> +      * in data corruption, so return true without marking the folio uptodate
>>> +      * so that an IO error is emitted (e.g. do_swap_page() will sigfault).
>>> +      *
>>> +      * Otherwise, return false and read the folio from disk.
>>> +      */
>>> +     if (folio_test_large(folio)) {
>>> +             if (xa_find(tree, &offset,
>>> +                         offset + folio_nr_pages(folio) - 1, XA_PRESENT)) {
>>> +                     WARN_ON_ONCE(1);
>>> +                     return true;
>>> +             }
>> How does that work? Should it be xa_find_after() to not always find
>> current entry?
> By "current entry" I believe you mean the entry corresponding to
> "offset" (i.e. the first subpage of the folio). At this point, we
> haven't checked if that offset has a corresponding entry in zswap or
> not. It may be on disk, or zwap may be disabled.

Okay you test if there's any matching offset in zswap for the folio.


>> And does it still mean those subsequent entries map to same folio?
> If I understand correctly, a folio in the swapcache has contiguous
> swap offsets for its subpages. So I am assuming that the large folio
> swapin case will adhere to that (i.e. we only swapin a large folio if
> the swap offsets are contiguous). Did I misunderstand something here?

Yes I think that is fair assumption for now. But also saw your v3 which
doesn't depend on this.


>
>>
>> --Mika
>>
>>


