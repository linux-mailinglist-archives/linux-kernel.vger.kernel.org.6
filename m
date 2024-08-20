Return-Path: <linux-kernel+bounces-294423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B9958D81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5220E1F21915
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720C1C0DCA;
	Tue, 20 Aug 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHS3qqhH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C04482FF;
	Tue, 20 Aug 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175493; cv=none; b=gzYybspZA5v5Nqqo8lEw4pqfaVXEZEFtHPtcYX5y7U8HGJHCXeV/mjEath9gVFaiBJrRAjK+0B+DYN3Yzm8ovMeQMZMuxcKqmnmOOCygnz3xpf/Mz1zii7ijS6M5XE+Lhwz9nwrE+x5WIChx9zwFJQ3OeU6I8/fq0Xy/Ixr2mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175493; c=relaxed/simple;
	bh=NCqWG1JkBau7+mxdyR2gMzXSeKbrP0JYv4ksDoS6+U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUIjWo4Qw4yNzFVS9VOtcLYa7gpSK5FOLb390qQaikIbrUtGG13euzXA8dE1TVg3I4Mj//+SHYhQsNcYMETd/ccVmSLT3J2Lg1EOxklpEZRgUy6REc4mX+WB0Y465i9Y3Hllv/mop0L0MhPcO/lo+tST/LYM5ofOn4BtCQQ7WfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHS3qqhH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso63655105e9.3;
        Tue, 20 Aug 2024 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724175490; x=1724780290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uex0Zu5XeJjzbTzovpQP7F+VLtXX34oK2fmnyZ8I8+g=;
        b=IHS3qqhHn9CC7HiVrdsOqkEHsfVW02LMGbfUM2V0eCcn1hrzpu7yAQE471a0ULAXGW
         8vHcTQxAm+k9GQQOMjkOcDs2F+b0NtFJtOQYmJgDJErxamEwaFCtjsVFYn5O8bWA0j1I
         C5BY1sLGnbBSL021U6sowE1kcL/LAyH4d902YhBxCSjWqgwmNX0cAjhIPjKJflfNPk/d
         QRVaOeShaiXOcgJN8xZmUOaPVsQyLnuUCAo1bJRcjWaoJ/uy7RNWn+oTDP9WHb5lYmT5
         nw5s97QFWyZ/cML6oJkwtcIGRA6RjYlm8CmWJ+ByqyJ9mwoMZCqmbkoBWziABgURddnD
         VSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724175490; x=1724780290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uex0Zu5XeJjzbTzovpQP7F+VLtXX34oK2fmnyZ8I8+g=;
        b=t0ur3VSnTKfo+RY8Zrqbjp+yhBNbUAwep7iam686LZO/7SJFNdzj/2/CsJ0XoK2IbO
         09pN0ZUwWrLhRKVfuS6d32grEb21+hKcWDIy3UmN7QMaZYhsejCtEdQ1Fyaf5yYXnWMM
         JWUVH+/ZLxs6JFW52VvKi7JHdIgksTdXbAOBBRcYrDC4uy3Ja4MhspNZaTcVeg8TIg6r
         Mr40zwFNLPyN4ZBej87KMor/RzZblMRgM5mQzMz9wiHE4YNl7rKzN5FfULZdbPBnfGUu
         7pROI+oP8+NcukPy88IWzdF0HmJUtYSGcrOtz24yhF7CJOPzQnv1vWC122O6tcUXdmqb
         Kpgw==
X-Forwarded-Encrypted: i=1; AJvYcCXA3fFD/zF5Cyx7Hivdm77wQ2J473ab8NSk7nJN+h6idp54CKsDO7jsDcEok9pb1Re8elvByjwk3w2JneQwiLEJZ8euriS53Gx+MzGU+yDeInES8jiVuGZx238Bg7S5SO52rVYMrfmKlx1U8Tw=
X-Gm-Message-State: AOJu0YwBmCE9u6WYHh8PVymsatkZBhpO+Hu/5NXBZbRttyUNkUhIZdwA
	Xtftm7gx8oehI2bkasp11+vVatfRLNUf+cR0qZEAZx8U2liKl/WwNdMRJ61v7YIK59hu+amGwnN
	Z04u5KG9PRRhkzQn9ORuPwWDVS1Y=
X-Google-Smtp-Source: AGHT+IHYXYf11BLw6d9wcs7H10GmSDAckOfUEbQqIaMIQOUKiv8CPDwzbrDBMuodE7WHHyCVPpTutzPpNU7CP3ayV5k=
X-Received: by 2002:adf:e907:0:b0:371:8e24:1191 with SMTP id
 ffacd0b85a97d-371946a4455mr11698109f8f.53.1724175490194; Tue, 20 Aug 2024
 10:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819213534.4080408-1-mmaurer@google.com> <20240819213534.4080408-5-mmaurer@google.com>
In-Reply-To: <20240819213534.4080408-5-mmaurer@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 20 Aug 2024 19:37:59 +0200
Message-ID: <CA+fCnZc9XeNTuD9nVVDqrF_1W1Vv26SVEwu1bCQ2usqfSPpiOw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kasan: rust: Add KASAN smoke test via UAF
To: Matthew Maurer <mmaurer@google.com>
Cc: dvyukov@google.com, ojeda@kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, aliceryhl@google.com, 
	samitolvanen@google.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	glider@google.com, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:35=E2=80=AFPM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> Adds a smoke test to ensure that KASAN in Rust is actually detecting a
> Rust-native UAF. There is significant room to expand this test suite,
> but this will at least ensure that flags are having the intended effect.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  mm/kasan/Makefile                         |  9 ++++++++-
>  mm/kasan/kasan.h                          |  1 +
>  mm/kasan/{kasan_test.c =3D> kasan_test_c.c} | 11 +++++++++++
>  mm/kasan/kasan_test_rust.rs               | 19 +++++++++++++++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
>  rename mm/kasan/{kasan_test.c =3D> kasan_test_c.c} (99%)
>  create mode 100644 mm/kasan/kasan_test_rust.rs
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 7634dd2a6128..d718b0f72009 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -44,7 +44,8 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>  CFLAGS_KASAN_TEST +=3D -fno-builtin
>  endif
>
> -CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> +CFLAGS_kasan_test_c.o :=3D $(CFLAGS_KASAN_TEST)
> +RUSTFLAGS_kasan_test_rust.o :=3D $(RUSTFLAGS_KASAN)
>  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
>
>  obj-y :=3D common.o report.o
> @@ -54,3 +55,9 @@ obj-$(CONFIG_KASAN_SW_TAGS) +=3D init.o report_sw_tags.=
o shadow.o sw_tags.o tags.o
>
>  obj-$(CONFIG_KASAN_KUNIT_TEST) +=3D kasan_test.o
>  obj-$(CONFIG_KASAN_MODULE_TEST) +=3D kasan_test_module.o
> +
> +kasan_test-objs :=3D kasan_test_c.o
> +
> +ifdef CONFIG_RUST
> +kasan_test-objs +=3D kasan_test_rust.o
> +endif

Let's put the kasan_test-objs directives before
obj-$(CONFIG_KASAN_KUNIT_TEST): they come first logically.

Also, I wonder, if something like kasan_test-objs-$(CONFIG_RUST) +=3D
kasan_test_rust.o would work to make this shorter?

> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fb2b9ac0659a..e5205746cc85 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -566,6 +566,7 @@ static inline void kasan_kunit_test_suite_end(void) {=
 }
>
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
> +char kasan_test_rust_uaf(void);

You need ifdef CONFIG_RUST checks here and an empty definition when
!CONFIG_RUST.

Please build-test and run the KASAN test suite without CONFIG_RUST
before sending the patches.

Also, I think it's better to put this declaration next to
kasan_kunit_test_suite_end: CONFIG_KASAN_MODULE_TEST is not tied to
the added KASAN test.

>
>  #endif
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test_c.c
> similarity index 99%
> rename from mm/kasan/kasan_test.c
> rename to mm/kasan/kasan_test_c.c
> index 7b32be2a3cf0..3a81e85a083f 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1899,6 +1899,16 @@ static void match_all_mem_tag(struct kunit *test)
>         kfree(ptr);
>  }
>
> +/*
> + * Check that Rust performing a use-after-free using `unsafe` is detecte=
d.
> + * This is a smoke test to make sure that Rust is being sanitized proper=
ly.
> + */
> +static void rust_uaf(struct kunit *test)
> +{

KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_RUST);


> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
> +}
> +
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -1971,6 +1981,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(match_all_not_assigned),
>         KUNIT_CASE(match_all_ptr_tag),
>         KUNIT_CASE(match_all_mem_tag),
> +       KUNIT_CASE(rust_uaf),
>         {}
>  };
>
> diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
> new file mode 100644
> index 000000000000..7239303b232c
> --- /dev/null
> +++ b/mm/kasan/kasan_test_rust.rs
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Helper crate for KASAN testing
> +//! Provides behavior to check the sanitization of Rust code.
> +use kernel::prelude::*;
> +use core::ptr::addr_of_mut;
> +
> +/// Trivial UAF - allocate a big vector, grab a pointer partway through,
> +/// drop the vector, and touch it.
> +#[no_mangle]
> +pub extern "C" fn kasan_test_rust_uaf() -> u8 {
> +    let mut v: Vec<u8> =3D Vec::new();
> +    for _ in 0..4096 {
> +        v.push(0x42, GFP_KERNEL).unwrap();
> +    }
> +    let ptr: *mut u8 =3D addr_of_mut!(v[2048]);
> +    drop(v);
> +    unsafe { *ptr }
> +}
> --
> 2.46.0.184.g6999bdac58-goog
>

