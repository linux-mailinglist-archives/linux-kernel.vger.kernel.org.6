Return-Path: <linux-kernel+bounces-290167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4186955036
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EB91C21518
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B11C37B6;
	Fri, 16 Aug 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4Hn31V8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A281C3796
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830304; cv=none; b=JmSXXnKCi0QRE2JWg0BDT/7D9zlDhzDb/Im6gUsfumNhpo2Z4JANGaj7uNe3Rv/oa6Jyx9hBSv6CX+KHmpikmmi8Np4sFFO9zr8I/4XBN98smFfZGeCJ42nBhsxZcJTUmHGzriaGFOvuU11rLw+reT6dWAa1XPHB5NwZpUYAYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830304; c=relaxed/simple;
	bh=5Q1HgjloIR0MpwBSSkUVVWkbj04/nU+bFDjCRNPuhA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LSUdguZxffByRpqdebhiIxnyHBAWvQhCg/9vbGCpLAJCjASV61BBeJHU6rVb5STxqJIVp40xhp1mshAk762+5XWVqskB1RODHWu2LcFFY5UTGEHABoAHUYzeaFko8Iv08C4bh2bwBgyvL7apVaikcj8HPUz6ghRXV1QpgamzlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4Hn31V8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19dd3so38283237b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723830302; x=1724435102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLqQ0W+kiaSmHiEqBrEtQ8fcmXJFfIb+9LXgj3vFom8=;
        b=B4Hn31V87GZQ/zp1/MHdTkicOLR7IZGJSCJkrKOj7/TzObmKcJ4pN6NoWKeYc+B5Zb
         butWqSxkfVPYHYAJTfjayFp93a69P5MMpBZJcbiNLJ2pOEg6j1qhq/uM0enFDwStlYcY
         R6Q6Z8mlufuitY/pnfNDZayp+4mRQTFePKl1ivPFWh0DtjtDig170CC9HPCT0WDyxwv8
         jHotshxkXQyOAeQ5or9+L7BbNIR+RBlrG3e7AZvTGX7wVDic9k6cud9Rkf1q0j5CRInJ
         Klz7bJKGoWW2Lm6w1JVY+vyqzuuHHEcYb+8FWV8+GZnBzLDWAdcnyAJyoWD4c0XDnZ1J
         Fy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830302; x=1724435102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLqQ0W+kiaSmHiEqBrEtQ8fcmXJFfIb+9LXgj3vFom8=;
        b=SWspOev9hhBESAZh4n8fdf08bJzFsf3iQyMQoQOLox7Ba32BSgFVVD1sCyaqqk93cf
         +sNhO04wktkq8fF5iXV59L13QZ/H6uHx9lsW84TqbvZMI2nnxqB8acbAb5xhf2YZs+3w
         Flx2YXjGZtClQfn53PHmuUY0BsZi0qbSsFrqlCVkYHfHn+O1diqhQvbTGVg3TjXEKTG9
         Ji3qXE35vuQGtq3lEKMiLHcpObTCi18/3G3q/mUvttXowT14tuwfWdQiAhR+EnCfs355
         gGWqjRfZ8WSevmmOjwNhOYEdw3Q8o3N/z8qTN/mbXZpbWQrOXk6N8PbRith08Qi13Ek+
         0wrw==
X-Forwarded-Encrypted: i=1; AJvYcCWhFoQJ+jWf5P+ZTscseU5mYYiCH0UQJbvh7m3rRiJx42RPMe187HpQCpCSChZWeDLEe7vzXOfxYpnA34Wqu7NzIAj27DDYrASMjWmV
X-Gm-Message-State: AOJu0YxyYuHa/ObkBvR//pQKW0nEIcvtJ7gzjYNIFDv9a21KjkaNjJ5r
	6nfI5fLLdyLfLPBV+5fdwN55siEo837glK4noiwkytlI+mfIPpGdny7B1hQo/a4jUKzuvGVHItt
	Cj/+cYAWqXVDYgG60B0pgjA==
X-Google-Smtp-Source: AGHT+IEi4/I6TDzoHhlZG83qsUH/gsU5TYse1nTv7CQbUM47gB6I7o2YM+wF22moMbfN4T1ecnVRfVCm4hd5c3ZkMQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:688d:b0:699:d8dc:668d with
 SMTP id 00721157ae682-6b1bb2899d5mr1670697b3.5.1723830302029; Fri, 16 Aug
 2024 10:45:02 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:45:00 +0000
In-Reply-To: <aa3b5be8-2c8a-4fe8-8676-a40a9886c715@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com>
 <20240805-guest-memfd-lib-v1-4-e5a29a4ff5d7@quicinc.com> <4cdd93ba-9019-4c12-a0e6-07b430980278@redhat.com>
 <CA+EHjTxNNinn7EzV_o1X1d0kwhEwrbj_O7H8WgDtEy2CwURZFQ@mail.gmail.com> <aa3b5be8-2c8a-4fe8-8676-a40a9886c715@redhat.com>
Message-ID: <diqzjzggmkf7.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH RFC 4/4] mm: guest_memfd: Add ability for mmap'ing pages
From: Ackerley Tng <ackerleytng@google.com>
To: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Patrick Roy <roypat@amazon.co.uk>, qperret@google.com, linux-coco@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"


David Hildenbrand <david@redhat.com> writes:

> On 15.08.24 09:24, Fuad Tabba wrote:
>> Hi David,
>
> Hi!
>
>> 
>> On Tue, 6 Aug 2024 at 14:51, David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>
>>>> -     if (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP) {
>>>> +     if (!ops->accessible && (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)) {
>>>>                r = guest_memfd_folio_private(folio);
>>>>                if (r)
>>>>                        goto out_err;
>>>> @@ -107,6 +109,82 @@ struct folio *guest_memfd_grab_folio(struct file *file, pgoff_t index, u32 flags
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(guest_memfd_grab_folio);
>>>>
>>>> +int guest_memfd_make_inaccessible(struct file *file, struct folio *folio)
>>>> +{
>>>> +     unsigned long gmem_flags = (unsigned long)file->private_data;
>>>> +     unsigned long i;
>>>> +     int r;
>>>> +
>>>> +     unmap_mapping_folio(folio);
>>>> +
>>>> +     /**
>>>> +      * We can't use the refcount. It might be elevated due to
>>>> +      * guest/vcpu trying to access same folio as another vcpu
>>>> +      * or because userspace is trying to access folio for same reason
>>>
>>> As discussed, that's insufficient. We really have to drive the refcount
>>> to 1 -- the single reference we expect.
>>>
>>> What is the exact problem you are running into here? Who can just grab a
>>> reference and maybe do nasty things with it?
>> 
>> I was wondering, why do we need to check the refcount? Isn't it enough
>> to check for page_mapped() || page_maybe_dma_pinned(), while holding
>> the folio lock?

Thank you Fuad for asking!

>
> (folio_mapped() + folio_maybe_dma_pinned())
>
> Not everything goes trough FOLL_PIN. vmsplice() is an example, or just 
> some very simple read/write through /proc/pid/mem. Further, some 
> O_DIRECT implementations still don't use FOLL_PIN.
>
> So if you see an additional folio reference, as soon as you mapped that 
> thing to user space, you have to assume that it could be someone 
> reading/writing that memory in possibly sane context. (vmsplice() should 
> be using FOLL_PIN|FOLL_LONGTERM, but that's a longer discussion)
>

Thanks David for the clarification, this example is very helpful!

IIUC folio_lock() isn't a prerequisite for taking a refcount on the
folio.

Even if we are able to figure out a "safe" refcount, and check that the
current refcount == "safe" refcount before removing from direct map,
what's stopping some other part of the kernel from taking a refcount
just after the check happens and causing trouble with the folio's
removal from direct map?

> (noting that also folio_maybe_dma_pinned() can have false positives in 
> some cases due to speculative references or *many* references).

Are false positives (speculative references) okay since it's better to
be safe than remove from direct map prematurely?

>
> -- 
> Cheers,
>
> David / dhildenb

