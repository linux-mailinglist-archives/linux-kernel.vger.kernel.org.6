Return-Path: <linux-kernel+bounces-285147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7E9509D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AC4280C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00291A2579;
	Tue, 13 Aug 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcPeNyLZ"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919391DDD1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565177; cv=none; b=D0DRm00J3nM66ECax0+IQ4iCNR5WRQLwAUTuovupruZZmbWsYfQScmQt7rXX595kqEQE3Gh0W6xvmd8GUIQPtgsAhmGKJXW2KyWxiCvyJgxytQfhZwgrLDgQMoxsTQYNSSIDzKnvHG517kFRYJKnSpxMpNS4D4J7FNWy0F+oo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565177; c=relaxed/simple;
	bh=2aKDjXMzkzZwy+w6/tkYsoHzsVEy5hXUwzS2g5555oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sytjV/wkAXssfg6vLLpGxP6xUdydHarM5yP/ynrQKnSpaTh8EnP3z34MVIymzPM+k5xEei7ciyKygcj83H2qqTSP1D8G7PfEvji+Nx4g84NOQd66oZ3rgJHSQG2VYJY4b2EARP6CK6yRl7ZuHZUeIq7srYtkwsjNvg8Q1u2PCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcPeNyLZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65fe1239f12so43565427b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723565174; x=1724169974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3nOqROZS7f0NGTQPLW29HPt15nh8yqYVB7M2yR1RNM=;
        b=hcPeNyLZtXMUFI8j1L3mO55uW0erKcFZSbsf4ljj6qfXKu7eqNoaFhA3px9Fij/RiH
         S4Eloc4GpRm5OyRLm4qdo1mEhPnZmo4rrL5YHA9r4MUdF0SQik86YRVxdmnB5FgjSGFT
         HDfJrq6Ns5m8+kr1SbYBD5+WH4h7IX1oU73bLn8xG4qKG5Fvh7abr5z9utM1R/5IzZoA
         7Adv5Bx+DZmcwg2VVarNAbhIfEzkI5Pbp0yqS2bxCKTYC+Qpzc/xYPLQar6bbJyE86Fk
         GZbXrdXcv7RssnWYz2P611IhvnYDfGcrtrBrhiKLec27ZNX7Xa9JDyIR5dwGpkUtHHfX
         tsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565174; x=1724169974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3nOqROZS7f0NGTQPLW29HPt15nh8yqYVB7M2yR1RNM=;
        b=AM3V/kpuyzmwI96YmE83Omlr6rmARtKWGJxSvzi5UoSqG/tFmOAzLEQ+YYgQqREOWt
         qAbGffmuTR6cPb1gYJ9KdL1yUNIAMa7FCmypV4amOuPElI7CKmKZzHjjfSrja9/ZWlXE
         3xXwP0FeqtlZXwjXLxMVMVVo07zr4SixfyJjWtJWr10569OaKcOi8C6+4Z0QJklsrSnn
         /9cSEu2qWK98v4DQ3gnwIR5Ra9s67C8TBrITsssf3P8nlxDWya+i+9nNbt69msn82CcH
         qveBBxtB4yxByD4u6OyZzWc4KYs25SoP936ayY6i413WD7nJu/XCMHARd9Oot+74kcNt
         laDA==
X-Forwarded-Encrypted: i=1; AJvYcCWjLjrKcHDom1ttvhWnce0ddOmcf/muUzyeH8sjR4ccfVJFZ1RiXYfOMkLJ7dXbkHDcIpNKRFwiLV2peRtQ8ZF9Z9Uw1CsyvYxzthaO
X-Gm-Message-State: AOJu0Ywd5TBHiIbGCND9yozW3xWIHAifkFn0ZiiYbAiiRnUpKRzMTJ6j
	LYSkdy4q2byEwKJLoSAEE7ywzwYmn+pQGISdw/6YD9+Ze7/R2NHxvj8phE1Kp2/HQmwFv5K8jPE
	1PIU+Tr+JTdzLVc6PL7oAUVUawU0SjSQ51RA2
X-Google-Smtp-Source: AGHT+IHMiOhzYAxqia21srgICMd3bpU5d8vj06kU3XcprkI21PIrBAy/i3gJkmKJKshgio8q/XkY77UHu8DFNnuWNYY=
X-Received: by 2002:a05:690c:250b:b0:651:6888:9fee with SMTP id
 00721157ae682-6a9726719d7mr43641887b3.18.1723565174221; Tue, 13 Aug 2024
 09:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813150758.855881-1-surenb@google.com> <20240813150758.855881-2-surenb@google.com>
 <be75dbc3-3137-44a2-af45-5454728c98a2@redhat.com>
In-Reply-To: <be75dbc3-3137-44a2-af45-5454728c98a2@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 09:06:00 -0700
Message-ID: <CAJuCfpHSp9Jt02qiJATj3H0=oBSUmF3JW_w5w7TNQJ6Vk9gVXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alloc_tag: mark pages reserved during CMA
 activation as not tagged
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.08.24 17:07, Suren Baghdasaryan wrote:
> > During CMA activation, pages in CMA area are prepared and then freed
> > without being allocated. This triggers warnings when memory allocation
> > debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> > by marking these pages not tagged before freeing them.
> >
> > Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages =
as empty")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org # v6.10
> > ---
> > Changes since v2 [1]:
> > - Add and use clear_page_tag_ref helper, per David Hildenbrand
> >
> > https://lore.kernel.org/all/20240812192428.151825-1-surenb@google.com/
> >
> >   mm/mm_init.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 907c46b0773f..13c4060bb01a 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2245,6 +2245,8 @@ void __init init_cma_reserved_pageblock(struct pa=
ge *page)
> >
> >       set_pageblock_migratetype(page, MIGRATE_CMA);
> >       set_page_refcounted(page);
> > +     /* pages were reserved and not allocated */
> > +     clear_page_tag_ref(page);
> >       __free_pages(page, pageblock_order);
> >
> >       adjust_managed_page_count(page, pageblock_nr_pages);
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

