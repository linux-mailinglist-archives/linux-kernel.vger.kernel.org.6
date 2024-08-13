Return-Path: <linux-kernel+bounces-285588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33273950FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24CC1F26545
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51141AB538;
	Tue, 13 Aug 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlsInnc/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696917B515;
	Tue, 13 Aug 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589637; cv=none; b=njd/3EqWZTH48/0uhKz5CmXgrfQWok0kyjl3iEsiweiptXaRg8XhZg6euYUDrLheFWtg3MxnnMbBLxWgBXT6a8RnyEzqKVzJOsdEus6epxm6xeY1VC8mBM3DjPS5Ri2WVQzR9mhfKjMuyO61C6cHDDmNje2IlCm20dSrYQCTsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589637; c=relaxed/simple;
	bh=z7d0Y8EywRx5BxQc97L1X5CgbIZyAMSBpLk5g8Kvunk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAsF6YRb1LQBP6cEGHD3J4fAOQ9ZVWxKCQsJfSFXJheLZQp1qcMs92cFKlZD7BfnkjI+IR0kn4STgLXZKOLeHQ5iHfdzFbJOYwlzD2X04rjqXgsv0YHVVaJQcthb5y2gDsXFmSnK8gHaaTRc+74fT3+fV1JeO7oI/mtAE0yEp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlsInnc/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36dd8a35722so2268111f8f.1;
        Tue, 13 Aug 2024 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723589633; x=1724194433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cttOyHmXr3Ka8gJTh+VvrIxgAB9wJeCTQuXopG67ZQ=;
        b=PlsInnc/Zwg1k6nntNKCGZIvX7rK8kYb+ljqpRCbUypAIeVIx4TWJ9vDK+Kuv5fx7U
         ZrsfI6dnrgMz5P5qvXXXRvnx6iLDsud8QvfoXMmla3n+Ql6u2xjfWnDJTPuSw1zc6wBp
         3D7YYvcieBXtKfVly+508hI3DMPe5pijpOJ5Aw2Yz/Ehm9We5N82OwiNqOdV5M1fwoJK
         QEqFkjOPsqBxiuIhzEXYLBcHmJcp7LyvL5DYJ3Pw9hP3IXWgrvfwd/IsJn/wImcnSYOt
         tiWfPStFunDs34yVqFwQfNciH1sOhuPweEKe2gf6/FaF58NOG0ZFuNIolpSz3RlAxj5a
         E8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723589633; x=1724194433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cttOyHmXr3Ka8gJTh+VvrIxgAB9wJeCTQuXopG67ZQ=;
        b=Zfo7aUqxdVUxirOW9v6QOWGziPHdRq47Bn8hVBisyWRGEYwvAhAe2uzn2gr5zcH4V2
         iVxxMPJSJqjnP8MBHc4hJuGPzW39Qtl8HAZDhmT+ywvxEwEbibJXpkP3d0XFDMAAvXJr
         8hwinkhTRlR4nYOuWJxpZkC6CrIUficrI9uWbRj05W3nqPu9OP6+n8dVDYM5kq8Jzf6s
         ZHviTgwjMhvDr+NBcvpJdjfZLc1ScSolGC2nstcYwTN5x6I4du+i4bfOD8HtecBNvgEs
         ek5MGxnq+A8+LzPhFMHJiR2yprj0l19E0Bjbr50ZgtCtqhCVgFpkykRilfZ99EQQB08R
         igQA==
X-Forwarded-Encrypted: i=1; AJvYcCWrgqXUJ0RvF1xeYrYw5NGiOnHh3bS3m52sWZnbxRSh18vNeVa/bX1Y7xptYl3vhU35k6wyAfoEqBZKghqmf2ysNVRoYJhpjGb/zwzXajk8LaUvE2fzQWsQTw7nwrqd5+lAGSi1cYFHhodtxIw=
X-Gm-Message-State: AOJu0YxjKY7Gz0wu5oIMx0Sq0lP7Z9G1eHJGfvA0uTnRnAe+nqw91q+L
	BiuhwTRSzWJpY2J86KhrBLwSdAUPJG+xOy2VFMsbEvjAxSkDVmyO8UdarzycBz+Um9YkOvHzGGC
	kx+uoJfzctCeFUsiPjp4C5ubNNow=
X-Google-Smtp-Source: AGHT+IEECoJkMB9xURSOa56jikc44tbEryXp3UYu/nA3WhLVRxfXsGIxnjB/vwMfYCeY+GbiIy7NPDu+RIwHan2qhMs=
X-Received: by 2002:a5d:5223:0:b0:367:99d8:70 with SMTP id ffacd0b85a97d-3717782761emr565874f8f.61.1723589633180;
 Tue, 13 Aug 2024 15:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812232910.2026387-1-mmaurer@google.com> <20240812232910.2026387-4-mmaurer@google.com>
In-Reply-To: <20240812232910.2026387-4-mmaurer@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 00:53:42 +0200
Message-ID: <CA+fCnZfWpCsW-mkKLc55+cRoBQJTeB1ecuown45zchRneNFLhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kasan: rust: Add KASAN smoke test via UAF
To: Matthew Maurer <mmaurer@google.com>
Cc: dvyukov@google.com, ojeda@kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, aliceryhl@google.com, 
	samitolvanen@google.com, Alexander Potapenko <glider@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:29=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Adds a smoke test to ensure that KASAN in Rust is actually detecting a
> Rust-native UAF. There is significant room to expand this test suite,
> but this will at least ensure that flags are having the intended effect.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  mm/kasan/Makefile                         |  9 ++++++++-
>  mm/kasan/{kasan_test.c =3D> kasan_test_c.c} | 13 +++++++++++++
>  mm/kasan/kasan_test_rust.rs               | 17 +++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
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

Let's keep the kasan_test.c name for the C tests to avoid changing the
module name. Naming Rust tests as kasan_test_rust.rs seems to be
sufficient.

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
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test_c.c
> similarity index 99%
> rename from mm/kasan/kasan_test.c
> rename to mm/kasan/kasan_test_c.c
> index 7b32be2a3cf0..28821c90840e 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -30,6 +30,7 @@
>  #include <asm/page.h>
>
>  #include "kasan.h"
> +#include "kasan_test_rust.h"

You forgot to include this file into the patch.

But I don't think you even need to create a new include file: just put
the new test function's declaration to kasan.h next to the other
test-related functions (e.g. after the part with
kasan_restore_multi_shot).

>
>  #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANUL=
E_SIZE)
>
> @@ -1899,6 +1900,17 @@ static void match_all_mem_tag(struct kunit *test)
>         kfree(ptr);
>  }
>
> +/*
> + * Check that Rust performing a uaf using `unsafe` is detected.

uaf -> use-after-free or UAF

> + * This is an undirected smoke test to make sure that Rust is being sani=
tized
> + * appropriately.

What is an undirected test? Let's drop this word, it is confusing.


> + */
> +static void rust_uaf(struct kunit *test)
> +{
> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
> +}
> +
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -1971,6 +1983,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
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
> index 000000000000..6f4b43ea488c
> --- /dev/null
> +++ b/mm/kasan/kasan_test_rust.rs
> @@ -0,0 +1,17 @@
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
> 2.46.0.76.ge559c4bf1a-goog
>

