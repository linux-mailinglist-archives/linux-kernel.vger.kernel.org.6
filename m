Return-Path: <linux-kernel+bounces-233123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E037891B27E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AAD1C21F65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728D1A2C1F;
	Thu, 27 Jun 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvTYHFgj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144911CA9F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719529538; cv=none; b=THbLIn0UFCH5DTyJjjD6sxSM0Odvv+XUT4Jb4F2F/rU/W0K/E0DeytMa0XBj2JjDAG1k736D8h18y/jw3yjpAdejEAmw/ihwK2CVEusBIr3XxPXEcnzbHrKhVmvGVlaJVKj+6qjnpRNAsmp1nxv2Jp+QHimNKddNIk5RjQx973s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719529538; c=relaxed/simple;
	bh=QrTJczM+9v1nnIrzsNFJeX7BQwwEuwrIjLO+Nhcgtmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQSZ9OQu0ufUoRwf+4LOJAfEEzknVXQ4xw51AJS/4eX+K0FUI+P3L7f1muzbej9o+kdUoGLvnQMDLZ2ydQZka6j1QYXJ1VNMWdxn4uKpkEwMXerKjgX1YeVDpf5qQelbktgo4p8OMUilg8NLYGEWnxfbJ/sQ675Fnuf4xS58w04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvTYHFgj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4255f915611so11285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719529534; x=1720134334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR8a5VdpRyFEdAy/+Mk2F6C0FlXuH9wIEADA1ZqHe7o=;
        b=EvTYHFgj4zc2nEait5SzUiFsQ0FJPTCp8QW3bDS4NDSxydDruNAYW6dG5ZRgHnABj+
         LX+uAY7JunMMA3Djce4YbwmcapNycV8VYpujuXE102CQx1O8GgM/IQ0ag8gPM4YuXtT2
         cglbkL7mBgctGkEUL0Y72YH17RSs4+5PTV8xhTJjK/Y2Xs6qk75DwLAmkQ77g/2X/YlC
         nkMLB/RTL8OXm9ILduT6DoG2hRz1kbFasVnIAqRN8Pu/hQsGVWOQ8NZL8VqefsyDOpEw
         H1hNnkEKbuywrd64Db0M/W1SLFags796GKR1+qOEgOJGQ6mVr3Hof9yKI7fzP25Q6zWh
         ssTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719529534; x=1720134334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR8a5VdpRyFEdAy/+Mk2F6C0FlXuH9wIEADA1ZqHe7o=;
        b=cJDTubpDHYnJOstUEjzinvd/RxvFrNk9eJ0A1am7cAZzIORB9EzN+nCMY9bv40qqKN
         zXKShHabErL8fCvAxAh2YhWm92eDZu4O1j0MLSp82CtWDGDozjxwge7gpkb1k4PC1Dh+
         8jX2hnsydA5+kXiNPRMux3E6VrlarcW8HzqTPoL3tQZZodcssDwsnaIraa20g0YqslPT
         f08rOp4wUX+FDtF7e/WRPCEIyfiYC6GVtlXpaEiPMdNjv8/JB7EG07WkxvKAmjwvNT1f
         UeDjHGo0hh4uYzh6lcTCY6ksakclPTWJF9OF1NTmUPPWpqhlFdqsXiVmNcCJInpaseD4
         ENYA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7j/19XW0UkjEWT+i7NJisUcC8aRUAdAsOOnTMuoFCJlAuRbeGhyE6Er9HXSiXQW8KWjmXHQ8SpH+tR3nPkJ7WphU8vjhKOkTZJJa
X-Gm-Message-State: AOJu0Yycv/hdm3oBKKAKnBpVatpO5iRjHsEZuvxjxGSGufyaMQS1qylK
	frjwk5gEvVlgTR7dC2mc/N6NIbdCFdtkD1OWnrI8pwkPpIbU9MhXKAkG9+05yBLmF+Gpy27ZSBG
	kgs6pmkf4BNy51cmAVRRB650BdF7LeO6eNHCS
X-Google-Smtp-Source: AGHT+IGIsOUEs4fzUsr6RJzov3tmLjjYLbl4yKDJt58g+5N6N/uFgB7LyjAXKkZkp446078Wh4je+/gZx2psYlFXpNg=
X-Received: by 2002:a05:600c:5113:b0:421:6c54:3a8 with SMTP id
 5b1f17b1804b1-4256c2a9e25mr338085e9.7.1719529534313; Thu, 27 Jun 2024
 16:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627222705.2974207-1-yuzhao@google.com> <20240627154721.69aea29609984bd5422afc97@linux-foundation.org>
In-Reply-To: <20240627154721.69aea29609984bd5422afc97@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 27 Jun 2024 17:04:58 -0600
Message-ID: <CAOUHufb4O7oCsGcH5VcSoAw5cUiwYjGCfvLBHPZgo-G=HtiLVw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: fix race with
 speculative PFN walkers
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Frank van der Linden <fvdl@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:47=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 27 Jun 2024 16:27:05 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > While investigating HVO for THPs [1], it turns out that speculative
> > PFN walkers like compaction can race with vmemmap modifications, e.g.,
> >
> >   CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
> >   -------------------------------  ------------------------------
> >   Allocates an LRU folio page1
> >                                    Sees page1
> >   Frees page1
> >
> >   Allocates a hugeTLB folio page2
> >   (page1 being a tail of page2)
> >
> >   Updates vmemmap mapping page1
> >                                    get_page_unless_zero(page1)
> >
> > Even though page1->_refcount is zero after HVO, get_page_unless_zero()
> > can still try to modify this read-only field, resulting in a crash.
>
> Ah.  So we should backport this into earlier kernels, yes?
>
> Are we able to identify a Fixes: for this?  Looks difficult.
>
> This seems quite hard to trigger.  Do any particular userspace actions
> invoke the race?

Yes, *very* hard to trigger:
1. Most hugeTLB use cases I know of are static, i.e., reserved at boot
time, because allocating at runtime is not reliable at all.
2. On top of that, someone has to be very unlucky to get tripped over
above, because the race window is so small -- I wasn't able to trigger
it with a stress testing that does nothing but that (with THPs
though).

So I don't think it's worth cc'ing stable, unless Muchun recommends.

