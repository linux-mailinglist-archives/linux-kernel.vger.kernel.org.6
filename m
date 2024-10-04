Return-Path: <linux-kernel+bounces-350296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3314099030F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9452282385
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F61D2B1C;
	Fri,  4 Oct 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRBKwHqU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CC1D0E37
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045425; cv=none; b=mKGhH983pDp/1t4YZtGrpVvrtXxg7uLOsdblVWF13eWRVvof//vvKs8i3MhO7DxPSyOpKAqv9rp5P4HXOeVFVzjZzzBBSMOWof243Gcxo2I2KSuVaffAZHbwKbXWvwDsS6ejP4FHvGhFy5wVHWjt5JvnqFpCr5hur8JjjPiS7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045425; c=relaxed/simple;
	bh=maBFWYKxY1S2frNPZ2KHqaSGaynXxgIiJS84Fftfmy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OL+rNAyWSvgR8szJEdcr7zMKrgXrvHzX+Zo6vKPbtoFvHiWHvPZ50fw0ablSq7CrvbNaIQAXSbJvG1RmoCsme24VNRYHRdZrE1hKk5niny+4jVPY2IUx0wQ976tIHTi5Q5Ahn6DUp3mPO6CvsPZ9VUTcgx6zmtRCcexhXzXroRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRBKwHqU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so2713688a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728045422; x=1728650222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkQGIL5EVYPHu1HndHhTEW+Z6R2TaJeNi0ejVqgiqaI=;
        b=gRBKwHqUomaAbpyPqwaU4tBnbENi4+n3GisY/NkzflrrAfYcP7p2LoDS3cmQRwtgTO
         YBr+OzpxSdqlgBDq/lYkG5ylQB2YWlJVh8LvZFdsP19ezjujtIzRPP3da0+W4Lla1ZcP
         vKIUnfZa5zbRGSbhqQkimTwDtdwLIWtM4zdGUiz0f/vA+JPIX2/EvGvXnC+t2y7avVAe
         nsonS1MA9Cn1rQLP0MLyaUpGmpkl5eXQJ50+gMpnZZ6HbUh9Voa4xhzDdGhyWw05TAdP
         ieHzVuDmhApyYSPYV/gbHsY+axmXGCG5SXIkUSK2uzyLHVmsvL18btpc1YDU3la7CGUc
         usDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045422; x=1728650222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkQGIL5EVYPHu1HndHhTEW+Z6R2TaJeNi0ejVqgiqaI=;
        b=d7K0bB5so42bhfw0rmuX5pOPqs4ZJ5Q5d60g3uqslu1nNzxBGPPSWc9T6m/9XEeHEK
         bKL5+Tm5uMpM4y7MFtPWfpwe2BcXTFifbg7SNRjom8baL3FV+jGCtJfZdxpKPKa+x0/I
         RQeaKFNBodH2BGvL6aFOZu0JNjR09mbjcdA3OLMGVunu2+3fRrdzkYlWsJdawgin+cx1
         TBssk4hhi3BsWxWnaHNOWX3PQRwZI0YOIybxz5LGkrT6PrqyrtqkYrYLLiXW1IsRBuE+
         QEgQAYF9aWuJBGY9RjUL0aTjD4rxfjyQ6XtlBSjBrKhEAfGaTt13FIUneasdfpZIuH0U
         YcHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1MuYFhbruviEyxph7U5MGvtJRQnB4e2Bg2++iY0QHWq3Z4eCy0WLUt4/aNxljzR1H7zijECL1cg+UVS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXQD5HWvg+Said/BL28y348uXe1fLGu68zi3PDvfOZ2f3Hs3r
	Rg81kBsgRXrCofNBxrKgniEeeiyZhZDX8z5Uh2nGlxOnKd+TJasDsoOYebO8OFNwN1BzJEUsleK
	0L6VnDDMCI0pxXoEWhlKeD+1umhA=
X-Google-Smtp-Source: AGHT+IFgvoRyJjs0lIyE4qY6H9T2dmOzQx1UEDkQrUquZSvU+x5YvpAG94POLKxLmfdFd8jtUSOHLrY8dnKcsjlOJ54=
X-Received: by 2002:a05:6402:348e:b0:5c8:9696:bae8 with SMTP id
 4fb4d7f45d1cf-5c8d2ed2ed0mr1700748a12.32.1728045421608; Fri, 04 Oct 2024
 05:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927151438.2143936-1-snovitoll@gmail.com> <CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com>
 <CACzwLxhjvJ5WmgB-yxZt3x5YQss9dLhL7KoHra0T-E2jm=vEAQ@mail.gmail.com> <CANpmjNMBJJ4e8EGkfFB2LmtPNEtzx2K7xLhK8PXdRsO=KiAS0Q@mail.gmail.com>
In-Reply-To: <CANpmjNMBJJ4e8EGkfFB2LmtPNEtzx2K7xLhK8PXdRsO=KiAS0Q@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Fri, 4 Oct 2024 17:37:45 +0500
Message-ID: <CACzwLxinN_tJ9_M3uXipwME8QA+1DLC9-Ps59ecSv=6SneOBvA@mail.gmail.com>
Subject: Re: [PATCH] mm: instrument copy_from/to_kernel_nofault
To: Marco Elver <elver@google.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:55=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Wed, 2 Oct 2024 at 18:40, Sabyrzhan Tasbolatov <snovitoll@gmail.com> w=
rote:
> >
> > On Wed, Oct 2, 2024 at 9:00=E2=80=AFPM Marco Elver <elver@google.com> w=
rote:
> > >
> > > On Fri, 27 Sept 2024 at 17:14, Sabyrzhan Tasbolatov <snovitoll@gmail.=
com> wrote:
> > > >
> > > > Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault()
> > > > with instrument_memcpy_before() for KASAN, KCSAN checks and
> > > > instrument_memcpy_after() for KMSAN.
> > >
> > > There's a fundamental problem with instrumenting
> > > copy_from_kernel_nofault() - it's meant to be a non-faulting helper,
> > > i.e. if it attempts to read arbitrary kernel addresses, that's not a
> > > problem because it won't fault and BUG. These may be used in places
> > > that probe random memory, and KASAN may say that some memory is
> > > invalid and generate a report - but in reality that's not a problem.
> > >
> > > In the Bugzilla bug, Andrey wrote:
> > >
> > > > KASAN should check both arguments of copy_from/to_kernel_nofault() =
for accessibility when both are fault-safe.
> > >
> > > I don't see this patch doing it, or at least it's not explained. By
> > > looking at the code, I see that it does the instrument_memcpy_before(=
)
> > > right after pagefault_disable(), which tells me that KASAN or other
> > > tools will complain if a page is not faulted in. These helpers are
> > > meant to be usable like that - despite their inherent unsafety,
> > > there's little that I see that KASAN can help with.
> >
> > Hello, thanks for the comment!
> > instrument_memcpy_before() has been replaced with
> > instrument_read() and instrument_write() in
> > commit 9e3f2b1ecdd4("mm, kasan: proper instrument _kernel_nofault"),
> > and there are KASAN, KCSAN checks.
> >
> > > What _might_ be useful, is detecting copying faulted-in but
> > > uninitialized memory to user space. So I think the only
> > > instrumentation we want to retain is KMSAN instrumentation for the
> > > copy_from_kernel_nofault() helper, and only if no fault was
> > > encountered.
> > >
> > > Instrumenting copy_to_kernel_nofault() may be helpful to catch memory
> > > corruptions, but only if faulted-in memory was accessed.
> >
> > If we need to have KMSAN only instrumentation for
> > copy_from_user_nofault(), then AFAIU, in mm/kasan/kasan_test.c
>
> Did you mean s/copy_from_user_nofault/copy_from_kernel_nofault/?
Yes, typo, sorry for the confusion.

>
> > copy_from_to_kernel_nofault_oob() should have only
> > copy_to_kernel_nofault() OOB kunit test to trigger KASAN.
> > And copy_from_user_nofault() kunit test can be placed in mm/kmsan/kmsan=
_test.c.
>
> I think in the interest of reducing false positives, I'd proceed with
> making copy_from_kernel_nofault() KMSAN only.

Here is my current upcoming patch that I will send separately
once it's tested, it's slowly being compiled on my laptop (away from PC).
I've moved copy_from_kernel_nofault() to kmsan_test.c and added
kmsan_check_memory() _before_ pagefault_disable() to check
kernel src address if it's initialized.
For copy_to_kernel_nofault() , I've left instrument_write() for memory
corruption check but before pagefault_disable() again, if I understood the =
logic
correctly. I will adjust kmsan kunit test once I can run it and send a PATC=
H.
Meanwhile, please let me know if the order of instrumentation before
pagefault_disable()
is correct.

> By looking at the code, I see that it does the instrument_memcpy_before()
> right after pagefault_disable(), which tells me that KASAN or other
> tools will complain if a page is not faulted in. These helpers are
> meant to be usable like that - despite their inherent unsafety,
> there's little that I see that KASAN can help with.
---
 mm/kasan/kasan_test_c.c |  8 ++------
 mm/kmsan/kmsan_test.c   | 16 ++++++++++++++++
 mm/maccess.c            |  5 +++--
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 0a226ab032d..5cff90f831d 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1954,7 +1954,7 @@ static void rust_uaf(struct kunit *test)
  KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
 }

-static void copy_from_to_kernel_nofault_oob(struct kunit *test)
+static void copy_to_kernel_nofault_oob(struct kunit *test)
 {
  char *ptr;
  char buf[128];
@@ -1973,10 +1973,6 @@ static void
copy_from_to_kernel_nofault_oob(struct kunit *test)
  KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
  }

- KUNIT_EXPECT_KASAN_FAIL(test,
- copy_from_kernel_nofault(&buf[0], ptr, size));
- KUNIT_EXPECT_KASAN_FAIL(test,
- copy_from_kernel_nofault(ptr, &buf[0], size));
  KUNIT_EXPECT_KASAN_FAIL(test,
  copy_to_kernel_nofault(&buf[0], ptr, size));
  KUNIT_EXPECT_KASAN_FAIL(test,
@@ -2057,7 +2053,7 @@ static struct kunit_case kasan_kunit_test_cases[] =3D=
 {
  KUNIT_CASE(match_all_not_assigned),
  KUNIT_CASE(match_all_ptr_tag),
  KUNIT_CASE(match_all_mem_tag),
- KUNIT_CASE(copy_from_to_kernel_nofault_oob),
+ KUNIT_CASE(copy_to_kernel_nofault_oob),
  KUNIT_CASE(rust_uaf),
  {}
 };
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 13236d579eb..fc50d0aef47 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -640,6 +640,21 @@ static void test_unpoison_memory(struct kunit *test)
  KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }

+static void test_copy_from_kernel_nofault(struct kunit *test)
+{
+ long ret;
+ volatile char src[4], dst[4];
+
+ EXPECTATION_UNINIT_VALUE_FN(expect, "test_copy_from_kernel_nofault");
+ kunit_info(
+ test,
+ "testing copy_from_kernel_nofault with src uninitialized memory\n");
+
+ ret =3D copy_from_kernel_nofault(dst, src, sizeof(src));
+ USE(ret);
+ KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 static struct kunit_case kmsan_test_cases[] =3D {
  KUNIT_CASE(test_uninit_kmalloc),
  KUNIT_CASE(test_init_kmalloc),
@@ -664,6 +679,7 @@ static struct kunit_case kmsan_test_cases[] =3D {
  KUNIT_CASE(test_long_origin_chain),
  KUNIT_CASE(test_stackdepot_roundtrip),
  KUNIT_CASE(test_unpoison_memory),
+ KUNIT_CASE(test_copy_from_kernel_nofault),
  {},
 };

diff --git a/mm/maccess.c b/mm/maccess.c
index f752f0c0fa3..a91a39a56cf 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -31,8 +31,9 @@ long copy_from_kernel_nofault(void *dst, const void
*src, size_t size)
  if (!copy_from_kernel_nofault_allowed(src, size))
  return -ERANGE;

+ /* Make sure uninitialized kernel memory isn't copied. */
+ kmsan_check_memory(src, size);
  pagefault_disable();
- instrument_read(src, size);
  if (!(align & 7))
  copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
  if (!(align & 3))
@@ -63,8 +64,8 @@ long copy_to_kernel_nofault(void *dst, const void
*src, size_t size)
  if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
  align =3D (unsigned long)dst | (unsigned long)src;

- pagefault_disable();
  instrument_write(dst, size);
+ pagefault_disable();
  if (!(align & 7))
  copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
  if (!(align & 3))
--=20
2.34.1

