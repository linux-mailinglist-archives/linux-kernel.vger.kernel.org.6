Return-Path: <linux-kernel+bounces-347982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3D98E10B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD1D281C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B61D0E26;
	Wed,  2 Oct 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFwywgxT"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944101D0E08
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887214; cv=none; b=cT9Lypn+rNfRUwe0tvL6jGdhg10FnJkYRcBNnsFeujJjMCuro2h71y8RLcF9XmCnu2F0ckZ27WKGNGctfmgT+sRAtpE24sDh/d4g/yMveVhCg65vrNLXnuRPdlPgRPlddGo/WOOybQcOBhpqzojYKhnTxEgsPX7EjaGHnc/TG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887214; c=relaxed/simple;
	bh=mEJ9sw0RlLcSKlNYuworVZf2xoq4a+/ryAd7fEzrc+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8JVga1+rOjiZSnh7F4rub28X8XlW5fElmJL8fsvy/0ez9SJrdklphYlDDALN1sdwsnhldgsCygpFqUHYkFrXLWFcPS4TyuXlbMt1uxaqTn7cnkf70jKsmobT8/qVW8P6AiJNusgdoMQM3sgPiimKplQyaf/hv5dznknCoMWQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFwywgxT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c88e6926e5so4633198a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727887211; x=1728492011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atucTbQvnUu3RiHgioj3nleKoWYLpTdzHHtrixvOPdM=;
        b=iFwywgxTlpqC+gMkuYk0dhhBelufh/fMC0qxDpOggTgVPx5hELunfnuTwAd9m0krMP
         eVr8qWUZq/Ezojj+DhVnwKJ3X6qOiAsH5jZUNdCMffceapgfEcZ/YzqquM5TUVyzzGtv
         zBb/kGzLpKVNhB3CP9xbDAj1oo+EkCDkOibXoR/fblJTorMvMufUGblSTz5ZL3zrnizT
         +ND9M74N/Vct+IPjr/WEIkQR8vNWDR7HPqi0a7In1ENZne8R4lFJzqnJusslwK3ORWED
         5qZt+iGWHeDW2Gatz+otetdYIqmMLXcMU8+SK6vrdmKcxNqu13g9Qpgevbgl91+K+MlX
         6FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727887211; x=1728492011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atucTbQvnUu3RiHgioj3nleKoWYLpTdzHHtrixvOPdM=;
        b=ovRy90qMtJO+Zthd5Zw8y49CtXK6vTQ1+vV48fknHl8vCqh90MS/P7eDHt952Awlhn
         cltNRm8Ly8E9+EC6B258jHwJSTpRdMZHWadK08Y6UalMK8SrOO0U0T4x03SqpDB+CeZ4
         cgHFzyWlSozHHUI/JKskESNcheoSSXKLc+vFou3fmyHnXZrZJjE5wypZHM65SMVhagJI
         vgiU2yDJuEm7M938s9j+uezQI1PoXwpkrxe4/uCVvs57Qh8YKDIECiqXkhtINFezzdwc
         UI1B+BvVxZrSoRmpJ9P43BFF4YcoOy7brWsNXmJBGkihpqRMwI96/IFMjbygspbiqxDe
         wbWw==
X-Forwarded-Encrypted: i=1; AJvYcCXlHVeVH01jDQ6ayRcxmprj8bXC5dGBMX3r7nPO5axtkh0UA2b43Qy2f+cNHPPaLdC48FaPIyLL786YIqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FD7hGJKmgbxx5QqqntP96nOlDHSXuHsy5KTHKq5lzs/Hlo7a
	qXndXipRPENspvW5y+hYR9two0VUGT7HcdmHCjU0/azOk5joms9AOl9zei+REnPONxlhXNBMY/a
	RhRuWWgVkudaHnzx2h/uMePRnzJY=
X-Google-Smtp-Source: AGHT+IF3xzr0IrXObxzfcb4O6iTkSAiTXc9nhGEbRAIOPwqQ1mUji7C3cQ8eLfyj/AtYZrMAEqNFPbXuGeOYTAsI9BM=
X-Received: by 2002:a05:6402:3486:b0:5c8:bb09:b413 with SMTP id
 4fb4d7f45d1cf-5c8bb09b89cmr1699747a12.0.1727887210576; Wed, 02 Oct 2024
 09:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927151438.2143936-1-snovitoll@gmail.com> <CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com>
In-Reply-To: <CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 2 Oct 2024 21:39:57 +0500
Message-ID: <CACzwLxhjvJ5WmgB-yxZt3x5YQss9dLhL7KoHra0T-E2jm=vEAQ@mail.gmail.com>
Subject: Re: [PATCH] mm: instrument copy_from/to_kernel_nofault
To: Marco Elver <elver@google.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 9:00=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> On Fri, 27 Sept 2024 at 17:14, Sabyrzhan Tasbolatov <snovitoll@gmail.com>=
 wrote:
> >
> > Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault()
> > with instrument_memcpy_before() for KASAN, KCSAN checks and
> > instrument_memcpy_after() for KMSAN.
>
> There's a fundamental problem with instrumenting
> copy_from_kernel_nofault() - it's meant to be a non-faulting helper,
> i.e. if it attempts to read arbitrary kernel addresses, that's not a
> problem because it won't fault and BUG. These may be used in places
> that probe random memory, and KASAN may say that some memory is
> invalid and generate a report - but in reality that's not a problem.
>
> In the Bugzilla bug, Andrey wrote:
>
> > KASAN should check both arguments of copy_from/to_kernel_nofault() for =
accessibility when both are fault-safe.
>
> I don't see this patch doing it, or at least it's not explained. By
> looking at the code, I see that it does the instrument_memcpy_before()
> right after pagefault_disable(), which tells me that KASAN or other
> tools will complain if a page is not faulted in. These helpers are
> meant to be usable like that - despite their inherent unsafety,
> there's little that I see that KASAN can help with.

Hello, thanks for the comment!
instrument_memcpy_before() has been replaced with
instrument_read() and instrument_write() in
commit 9e3f2b1ecdd4("mm, kasan: proper instrument _kernel_nofault"),
and there are KASAN, KCSAN checks.

> What _might_ be useful, is detecting copying faulted-in but
> uninitialized memory to user space. So I think the only
> instrumentation we want to retain is KMSAN instrumentation for the
> copy_from_kernel_nofault() helper, and only if no fault was
> encountered.
>
> Instrumenting copy_to_kernel_nofault() may be helpful to catch memory
> corruptions, but only if faulted-in memory was accessed.

If we need to have KMSAN only instrumentation for
copy_from_user_nofault(), then AFAIU, in mm/kasan/kasan_test.c
copy_from_to_kernel_nofault_oob() should have only
copy_to_kernel_nofault() OOB kunit test to trigger KASAN.
And copy_from_user_nofault() kunit test can be placed in mm/kmsan/kmsan_tes=
t.c.

I wonder if instrument_get_user macro is OK for src ptr in
copy_from_kernel_nofault().

If this is true understanding, then there is no need to add
kasan_disable_current(),
kasan_enable_current() for kernel helpers functions that use
copy_from_kernel_nofault().

>
>
> > Tested on x86_64 and arm64 with CONFIG_KASAN_SW_TAGS.
> > On arm64 with CONFIG_KASAN_HW_TAGS, kunit test currently fails.
> > Need more clarification on it - currently, disabled in kunit test.
> >
> > Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> >  mm/kasan/kasan_test.c | 31 +++++++++++++++++++++++++++++++
> >  mm/maccess.c          |  8 ++++++--
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> > index 567d33b49..329d81518 100644
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -1944,6 +1944,36 @@ static void match_all_mem_tag(struct kunit *test=
)
> >         kfree(ptr);
> >  }
> >
> > +static void copy_from_to_kernel_nofault_oob(struct kunit *test)
> > +{
> > +       char *ptr;
> > +       char buf[128];
> > +       size_t size =3D sizeof(buf);
> > +
> > +       /* Not detecting fails currently with HW_TAGS */
> > +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> > +
> > +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +       OPTIMIZER_HIDE_VAR(ptr);
> > +
> > +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
> > +               /* Check that the returned pointer is tagged. */
> > +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_M=
IN);
> > +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_K=
ERNEL);
> > +       }
> > +
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_from_kernel_nofault(&buf[0], ptr, size));
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_from_kernel_nofault(ptr, &buf[0], size));
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_to_kernel_nofault(&buf[0], ptr, size));
> > +       KUNIT_EXPECT_KASAN_FAIL(test,
> > +               copy_to_kernel_nofault(ptr, &buf[0], size));
> > +       kfree(ptr);
> > +}
> > +
> >  static struct kunit_case kasan_kunit_test_cases[] =3D {
> >         KUNIT_CASE(kmalloc_oob_right),
> >         KUNIT_CASE(kmalloc_oob_left),
> > @@ -2017,6 +2047,7 @@ static struct kunit_case kasan_kunit_test_cases[]=
 =3D {
> >         KUNIT_CASE(match_all_not_assigned),
> >         KUNIT_CASE(match_all_ptr_tag),
> >         KUNIT_CASE(match_all_mem_tag),
> > +       KUNIT_CASE(copy_from_to_kernel_nofault_oob),
> >         {}
> >  };
> >
> > diff --git a/mm/maccess.c b/mm/maccess.c
> > index 518a25667..2c4251df4 100644
> > --- a/mm/maccess.c
> > +++ b/mm/maccess.c
> > @@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const vo=
id *unsafe_src,
> >
> >  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) =
 \
> >         while (len >=3D sizeof(type)) {                                =
   \
> > -               __get_kernel_nofault(dst, src, type, err_label);       =
         \
> > +               __get_kernel_nofault(dst, src, type, err_label);       =
 \
> >                 dst +=3D sizeof(type);                                 =
   \
> >                 src +=3D sizeof(type);                                 =
   \
> >                 len -=3D sizeof(type);                                 =
   \
> > @@ -32,6 +32,7 @@ long copy_from_kernel_nofault(void *dst, const void *=
src, size_t size)
> >                 return -ERANGE;
> >
> >         pagefault_disable();
> > +       instrument_memcpy_before(dst, src, size);
> >         if (!(align & 7))
> >                 copy_from_kernel_nofault_loop(dst, src, size, u64, Efau=
lt);
> >         if (!(align & 3))
> > @@ -39,6 +40,7 @@ long copy_from_kernel_nofault(void *dst, const void *=
src, size_t size)
> >         if (!(align & 1))
> >                 copy_from_kernel_nofault_loop(dst, src, size, u16, Efau=
lt);
> >         copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
> > +       instrument_memcpy_after(dst, src, size, 0);
> >         pagefault_enable();
> >         return 0;
> >  Efault:
> > @@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
> >
> >  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)   =
 \
> >         while (len >=3D sizeof(type)) {                                =
   \
> > -               __put_kernel_nofault(dst, src, type, err_label);       =
         \
> > +               __put_kernel_nofault(dst, src, type, err_label);       =
 \
> >                 dst +=3D sizeof(type);                                 =
   \
> >                 src +=3D sizeof(type);                                 =
   \
> >                 len -=3D sizeof(type);                                 =
   \
> > @@ -63,6 +65,7 @@ long copy_to_kernel_nofault(void *dst, const void *sr=
c, size_t size)
> >                 align =3D (unsigned long)dst | (unsigned long)src;
> >
> >         pagefault_disable();
> > +       instrument_memcpy_before(dst, src, size);
> >         if (!(align & 7))
> >                 copy_to_kernel_nofault_loop(dst, src, size, u64, Efault=
);
> >         if (!(align & 3))
> > @@ -70,6 +73,7 @@ long copy_to_kernel_nofault(void *dst, const void *sr=
c, size_t size)
> >         if (!(align & 1))
> >                 copy_to_kernel_nofault_loop(dst, src, size, u16, Efault=
);
> >         copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
> > +       instrument_memcpy_after(dst, src, size, 0);
> >         pagefault_enable();
> >         return 0;
> >  Efault:
> > --
> > 2.34.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kasan-dev/20240927151438.2143936-1-snovitoll%40gmail.com.

