Return-Path: <linux-kernel+bounces-349937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCB98FD95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621E71F23347
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1701F13210D;
	Fri,  4 Oct 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlgK0Qwq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005385260
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024942; cv=none; b=Fto1GnTOkZYPxro6BLxjUaET18VLGC+vEfszYloIJBmQHeH8nlU15U2qeUloRc8Zla7AfnPgZROlSIXJLUJP8UIJ8c9/NvBYmXlxUXQVTl/zyPu0KtTjYShaTma1dUddriqsUcxaDzZOUWS8qa6d617cXR+e7m9sx5RwNHkOrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024942; c=relaxed/simple;
	bh=q7o2gtlpEVASHHeeVwEYiWWRZirGk2x9V5M6y6RZYrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spnu8M1P7JLEpPHVsFbV2h9Nd5OQN7zneArHJ8eNFdCNSTxqDnwYF4JCww2Z1Nk5xnzJGPYH4P3dwYW6Fe4CsFcoviyY6SWVsTXWYTfwQbJ+MW4vheQ4tAjMYmpyCI8iU0kZnX8ahZQqZpV41hlxMJp81OuhRRmNkJFhf3I1jCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlgK0Qwq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bc2970df5so13567665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 23:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728024940; x=1728629740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7o2gtlpEVASHHeeVwEYiWWRZirGk2x9V5M6y6RZYrM=;
        b=wlgK0QwqQoYVRa4b7PEmgIf99shwzsdE9wf2JqDTpEcVlGlsEofaSrWMu3tsrsOn7B
         UMdGiu7/UDCjlreedCTFQMb5L9CiZnKUjbpinUgvowUgthSsS3ymMAsrOFfNiPzHNnrp
         vNdJAHUAdyQzQKMcRkj1/6+lYkPFW5DUrPgM62SVTg/xhWr8p2MUpg+InjpSv6jtEJKr
         k9IzaNa29vZbrU9tliKxm9HJeM3fS3RtSH9QJZEXkcMYKJNg3yyRt3hcNSqtoklamBcC
         dWteevXq3490nu7/x9qdpa3M65ITfRonm9H1q6goph3U8/aOgXNB22nQaru9tfpqVvZ2
         Pfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728024940; x=1728629740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7o2gtlpEVASHHeeVwEYiWWRZirGk2x9V5M6y6RZYrM=;
        b=oR4Xfgv+QVhZ5NzpiRax66n/MET7odsxmKPZ7GC2byTFTidggz2a1Z3yd1iQMeGXSc
         WjqOxWjJbIoz1iF/d75T8jLaYyqfwMD1W/wFaXr1f62q4JfJNZyuczKwgp07/MWkqa3u
         +uKsQ7ka4vr2jnByASpcleiEcrdi78LbuGRD09V4pXCfOA2GCMUZTO4K6+vfxVfZV3Sl
         wcK5EhjJOysAdbIKuiUZb3hmnGgNUBE6SHb+zXFNwVtDUYWBlqESHFFzzFrkLAF0OUUy
         WOHblA5LM4kg/lj1fvmzop68x7IzAHkewSK9jFaqr50k8Fji5Q2l+nIA7AyXoHlhfvqK
         kShQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRZq82NxGNLbEGQkbZzQ2zk7x/2cX2hkdxmELjjIBNcmXGp0zrlyNlGlCTQlrN4HsBkIqyhrYFOhu3UhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPIfnb9OBd62OQNEglEDjHWfQ+Lih/4jEsbvDJQcpAMtqPJb/
	NHFaxQsslqib7r+ciRvBcry5uBfnyWDbuel1bQF0qaKl8/V2NNdW6DiqVUS0mKI4X0skJLihKnw
	9SPKpuB38kfYWOE+R6aTCk/fHDGV70sBHiabd
X-Google-Smtp-Source: AGHT+IER5/6RPqS5sXqaB50mfC5zJHEF1jn+rq4VXuAuewfa+zz/1/ON7+EV2E3ZuD/AA7eQOpg5VU+3NhbqwVMdjp8=
X-Received: by 2002:a17:903:11c7:b0:20b:9f77:e8bd with SMTP id
 d9443c01a7336-20bfe04aca9mr24574365ad.36.1728024940031; Thu, 03 Oct 2024
 23:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927151438.2143936-1-snovitoll@gmail.com> <CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com>
 <CACzwLxhjvJ5WmgB-yxZt3x5YQss9dLhL7KoHra0T-E2jm=vEAQ@mail.gmail.com>
In-Reply-To: <CACzwLxhjvJ5WmgB-yxZt3x5YQss9dLhL7KoHra0T-E2jm=vEAQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 4 Oct 2024 08:55:03 +0200
Message-ID: <CANpmjNMBJJ4e8EGkfFB2LmtPNEtzx2K7xLhK8PXdRsO=KiAS0Q@mail.gmail.com>
Subject: Re: [PATCH] mm: instrument copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 at 18:40, Sabyrzhan Tasbolatov <snovitoll@gmail.com> wro=
te:
>
> On Wed, Oct 2, 2024 at 9:00=E2=80=AFPM Marco Elver <elver@google.com> wro=
te:
> >
> > On Fri, 27 Sept 2024 at 17:14, Sabyrzhan Tasbolatov <snovitoll@gmail.co=
m> wrote:
> > >
> > > Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault()
> > > with instrument_memcpy_before() for KASAN, KCSAN checks and
> > > instrument_memcpy_after() for KMSAN.
> >
> > There's a fundamental problem with instrumenting
> > copy_from_kernel_nofault() - it's meant to be a non-faulting helper,
> > i.e. if it attempts to read arbitrary kernel addresses, that's not a
> > problem because it won't fault and BUG. These may be used in places
> > that probe random memory, and KASAN may say that some memory is
> > invalid and generate a report - but in reality that's not a problem.
> >
> > In the Bugzilla bug, Andrey wrote:
> >
> > > KASAN should check both arguments of copy_from/to_kernel_nofault() fo=
r accessibility when both are fault-safe.
> >
> > I don't see this patch doing it, or at least it's not explained. By
> > looking at the code, I see that it does the instrument_memcpy_before()
> > right after pagefault_disable(), which tells me that KASAN or other
> > tools will complain if a page is not faulted in. These helpers are
> > meant to be usable like that - despite their inherent unsafety,
> > there's little that I see that KASAN can help with.
>
> Hello, thanks for the comment!
> instrument_memcpy_before() has been replaced with
> instrument_read() and instrument_write() in
> commit 9e3f2b1ecdd4("mm, kasan: proper instrument _kernel_nofault"),
> and there are KASAN, KCSAN checks.
>
> > What _might_ be useful, is detecting copying faulted-in but
> > uninitialized memory to user space. So I think the only
> > instrumentation we want to retain is KMSAN instrumentation for the
> > copy_from_kernel_nofault() helper, and only if no fault was
> > encountered.
> >
> > Instrumenting copy_to_kernel_nofault() may be helpful to catch memory
> > corruptions, but only if faulted-in memory was accessed.
>
> If we need to have KMSAN only instrumentation for
> copy_from_user_nofault(), then AFAIU, in mm/kasan/kasan_test.c

Did you mean s/copy_from_user_nofault/copy_from_kernel_nofault/?

> copy_from_to_kernel_nofault_oob() should have only
> copy_to_kernel_nofault() OOB kunit test to trigger KASAN.
> And copy_from_user_nofault() kunit test can be placed in mm/kmsan/kmsan_t=
est.c.

I think in the interest of reducing false positives, I'd proceed with
making copy_from_kernel_nofault() KMSAN only.

