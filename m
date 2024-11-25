Return-Path: <linux-kernel+bounces-421680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B49D8E76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EC0280F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22E1CB31D;
	Mon, 25 Nov 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3UaRCR/"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8317F4F6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573407; cv=none; b=Bk/zAbKj+K4/J0v8j3X4weSBu1dqZhDWIz+LXc4TkSSNBe5gnXh4KMQlIV7cxgAhEt3ST7+RxVkZjXNQxoHplBNAT3lAPnW4in+sXHIjpM5yr+4EwKL4gB/uO+7b/R0IUJc8K5M0mfuFTFEfgjPlduCZQsTBNpT6KjHwCFH/hvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573407; c=relaxed/simple;
	bh=atfV4Dmd5P2/nrEuQPiLgC2zGDowbchaOZ/HeHMgibc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGCuAvAY8sQkSLJPVD3vSgjw8avtwoZjbfQWNCIHu6c3UgTDUkgWZIHB1atWDv98pIri4W+TqhJGWZCTbwgWP3XRkx6XcJv94W3AzYdEE2mkXk0dgV5MWBtGlwlVcSpu34RGXnZQECXVItOhVObcBJfHPDLY2ps1W9D0SAcw4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e3UaRCR/; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85b09db4824so498566241.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732573405; x=1733178205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPfWzthEWoH2qXCJl59i7kJGHDW2eEE8lyzCKgg7LSc=;
        b=e3UaRCR/M3umbpeLSryt2aVM526MgEKwMcGo+3dkHXXxIv4rvbyab0XE1R9uluLQpt
         UOxIhEGOgvVREC1V0oDEunG51+gr3R1JJmqqhKLES2XZBJ/ohGnCwPdYWY6WxATlFI5A
         RF3p+zKUeQ2Zkz/4BNDrop4+tx03ZAcfQR+lhbKL0j1lPU9v7K++Yjqrl38OIXxqLZvD
         v9NgnbrHrizSDGZASx9d3e7VS+eN6Rcjf9oYm0LHiVkzBGBjwWHz7wMPLdMkYJLXNnF4
         xkCF7lvEerYuB4Kh+Ovztx1hfVHPXsWYZbCLvB0Kh9j+fpLpRxug8oWKELoUCp5xNDE5
         2UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732573405; x=1733178205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPfWzthEWoH2qXCJl59i7kJGHDW2eEE8lyzCKgg7LSc=;
        b=VdCGcV4dQcfqgT61/Tv1u4a+8FT4gnOlq2GBkc6t+X/bkwMdW99q+BC+7WB972VM0E
         VxfVZJslrNMjCGSZYd31bRlD1ecK5K1HYbfOGYH6Gw5PqKG2aOBnl4pbt8lq4chGuEtT
         5bUzh/sZ7thQTkCykXLo6Fqpq0cyJg2BJphEjnCv9HI1ZQMfuCvTVx1qvrnQ92IdpXPb
         aURsEO0eJ27IHyz3Fl4lVf4XOCooNDi77lYGyR7fsc8n1P2GV6rWDn1L2HxiH70luJsu
         fbKuYzyBPIEsuQ/5j9wrYo1Y9gGbVqZF/1IxMTT9pDtqrONmP/9zhJkh3gBMg0fFAdhX
         1h9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJP5JCAURbvfYYSosutaL3R0Apekgh8Zin69KsZIskuTOIF0OXjr8qaQAOFeJmZt9Pkkh3zA6SHCALFL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vw8Yv6wzF+zkBvHnnHDpBPApMe1ToLroZ+dFkisg+V2z7xS7
	x3A0PAfVKSprKn+HXuMlBeaMDYtPio5rX9rTfP4QVAwAF3yq1did03mNRjpw9FufQk6H4YRSxem
	G5IyFfdHSn/Z6ElS4guUvyBP/NZJ5NjkM8wCz
X-Gm-Gg: ASbGncsj3t/xJvvHDKfjZLHzdtBkvw4N3icyPFbfmI9OEAXsbKxXAYWBH4/FMwW9whJ
	jnZbXwlnaOj13aoTBGJnk/PI9cEqnq+tTVu0qfjzxBF2cYMOwDI9ta46bP8aj1Pr0
X-Google-Smtp-Source: AGHT+IGqMzc1OyPSWSlieeYBzujX5tl4Y0054LB+eF4R09ye8ciu10JBJUzb6hqH9f2pJ7Sfaoe8ukBDGJNLm5dZMcY=
X-Received: by 2002:a05:6102:161f:b0:4af:19c3:61c1 with SMTP id
 ada2fe7eead31-4af19c36469mr6481868137.27.1732573404437; Mon, 25 Nov 2024
 14:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107202033.2721681-1-yuzhao@google.com> <20241125152203.GA954@willie-the-truck>
In-Reply-To: <20241125152203.GA954@willie-the-truck>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 25 Nov 2024 15:22:47 -0700
Message-ID: <CAOUHufYUMYcf=uF7=2zj-PsGXePCDdsRHJGa8t-e-k9VUvYyQQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/arm64: re-enable HVO
To: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 8:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Yu Zhao,
>
> On Thu, Nov 07, 2024 at 01:20:27PM -0700, Yu Zhao wrote:
> > HVO was disabled by commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
> > HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the following reason:
> >
> >   This is deemed UNPREDICTABLE by the Arm architecture without a
> >   break-before-make sequence (make the PTE invalid, TLBI, write the
> >   new valid PTE). However, such sequence is not possible since the
> >   vmemmap may be concurrently accessed by the kernel.
> >
> > This series presents one of the previously discussed approaches to
> > re-enable HugeTLB Vmemmap Optimization (HVO) on arm64.
>
> Before jumping into the new mechanisms here, I'd really like to
> understand how the current code is intended to work in the relatively
> simple case where the vmemmap is page-mapped to start with (i.e. when we
> don't need to worry about block-splitting).
>
> In that case, who are the concurrent users of the vmemmap that we need
> to worry about?

Any speculative PFN walkers who either only read `struct page[]` or
attempt to increment page->_refcount if it's not zero.

> Is it solely speculative references via
> page_ref_add_unless() or are there others?

page_ref_add_unless() needs to be successful before writes can follow;
speculative reads are always allowed.

> Looking at page_ref_add_unless(), what serialises that against
> __hugetlb_vmemmap_restore_folio()? I see there's a synchronize_rcu()
> call in the latter, but what prevents an RCU reader coming in
> immediately after that?

In page_ref_add_unless(), the condtion `!page_is_fake_head(page) &&
page_ref_count(page)` returns false before a PTE becomes RO.

For HVO, i.e., a PTE being switched from RW to RO, page_ref_count() is
frozen (remains zero), followed by synchronize_rcu(). After the
switch, page_is_fake_head() is true and it appears before
page_ref_count() is unfrozen (become non-zero), so the condition
remains false.

For de-HVO, i.e., a PTE being switched from RO to RW, page_ref_count()
again is frozen, followed by synchronize_rcu(). Only this time
page_is_fake_head() is false after the switch, and again it appears
before page_ref_count() is unfrozen. To answer your question, readers
coming in immediately after that won't be able to see non-zero
page_ref_count() before it sees page_is_fake_head() being false. IOW,
regarding whether it is RW, the condition can be false negative but
never false positive.

> Even if we resolve the BBM issues, we still need to get the
> synchronisation right so that we don't e.g. attempt a cmpxchg() to a
> read-only mapping, as the CAS instruction requires write permission on
> arm64 even if the comparison ultimately fails.

Correct. This applies to x86 as well, i.e., CAS on RO memory crashes
the kernel, even if CAS would fail otherwise.

> So please help me to understand the basics of HVO before we get bogged
> down by the block-splitting on arm64.

Gladly. Please let me know if anything from the core MM side is unclear.

