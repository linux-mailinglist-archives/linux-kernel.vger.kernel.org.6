Return-Path: <linux-kernel+bounces-294539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C1958EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A095E1C2102C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD56165EE1;
	Tue, 20 Aug 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3QT+Srz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87D14C5A3;
	Tue, 20 Aug 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183854; cv=none; b=OOrB3oaAHINO4GcF1b2gJDVYv3B4a1HKumk1ScpbpAGsgGP4FjH51W5kg47OeMqYwOlXm34B3rhuxY728Zuwrsu6ufnS+f4DpB7FBSQeeRtFCT0wCFXLDYlXGEaMEzQ0msriAG8JPTbNoZdgaVuY/b2rNmH+BWRKYJ1MewCgB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183854; c=relaxed/simple;
	bh=VmVyGUGdtoMsG/YSgY7CAog57+p6Rsrn1MKZjKU17v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ++E7dISJL14jAXEQgCc70zZBkfC4Zf19yGs831jvj9ZywGU64BRXSwC/ch1i8meOQrZgxQ1IG7BNs0c6+85lBeIxBrW8EkUQdQFWKhiZ7O9o0HxrYuMItm3lFI6bnxNhu0dzoPy+laudvH/rxStiQriiYYsKIK2b6jU8SDvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3QT+Srz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718c176ed7so2819431f8f.2;
        Tue, 20 Aug 2024 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724183851; x=1724788651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaL9zj6zB1sI38i5Boy36u4I8G4LxBoHczpTGYKeAio=;
        b=Q3QT+Srzw7A3TPKumEm1XLNba+gY4IR9TKdwGIZ+NmUoQP3WEf8sTWq6tgdzTENJYS
         mBmikepM+E3dAjAY+J6Xafxv3BuRnGusgAcjCiDUrpz06E0rZ4kR6cOQkGQTLOs7UQTg
         pEiZkwAXLp+swon46Eqmy8vyWrDGpFxNpnTPwATCyG2VxYqQ8uzHFyEIw0xdfrNb7F6S
         bDHr6rNyuqtmFZ62+NWpNoEs19w+Z9ccEmNXv/1IXk8gFo2Lo5oaO2vcz2VIVSrojHSe
         aOe261qN/8xUfweXE9m58HNEMAwGqwbKRJTP3e2iuw6+P+t4CkaQG5nUE9OqgxkwKao2
         XDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183851; x=1724788651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaL9zj6zB1sI38i5Boy36u4I8G4LxBoHczpTGYKeAio=;
        b=wfRCOb12xi4MKwqYG5+VOHknUN/kL++cy+0LIWl4mrhqrRBDsMRsJvyupDdPetQcgO
         AEcSwPmFblYKZVSWo0xKj/217zLHERBR6R66P/jKspBItdGDXUP9O+0rfS0Q0xXbCThd
         J017DjpMD6QmtBa29AGUnGprHPTFmaO61bWYJhJ6Cdb6uAm9+M0kFn5p6aDgDOXA4KvB
         XU52VQHXH+BSNo2HvpU3Nlfev0lykFEgJeV+eedvh1bXftofr+cDtPnqQFouAfadR21n
         clWIvVFP8WPab+5U/jOgd9+x9pP7KxstwGXZcTulVEGH93v3vPj5TXu+rHmmKy/4pHog
         rxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4YFJIMoniQ25eJbKxVhWwfaewDZlFBVm4SmqJZj9NphAeF9p6G0Inge4nwYVERIsVhEtrDMAd1bB9B0=@vger.kernel.org, AJvYcCX4Up6r2N4xsM8CB2jTpVHL0Gz1a4mU2hQgpFjaeqGz+bFnHYYqkWokJkzQcsvU8OFo2nn5Gwk+iVLHnae9DJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtSOfux3gz2Kq3Xk9w10Qo/kbCAocJARxUO46R/0d8UH03D6E
	+66CqnSPrD3kxi/z4vrktPeha2sBCeiwQFK4NVhsgwiMtNoIOyElT6QNhxVtkgTjxU097ccInEA
	+CaAhMg9M/TlTDoNVNMkoAX8VKpo=
X-Google-Smtp-Source: AGHT+IEznsehmKZmHvHgq4ZkCfGQmdhf6Mincfw8xXYVedCVeiTwsSwo5HAQJtbtnPBAZV9xE0roNoYhfGuJq41HffA=
X-Received: by 2002:a5d:474d:0:b0:367:980a:6af with SMTP id
 ffacd0b85a97d-372fd727b4amr37670f8f.59.1724183850741; Tue, 20 Aug 2024
 12:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820194910.187826-1-mmaurer@google.com> <20240820194910.187826-5-mmaurer@google.com>
In-Reply-To: <20240820194910.187826-5-mmaurer@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 20 Aug 2024 21:57:18 +0200
Message-ID: <CA+fCnZdCqt=eN6vWJ93K8dK8yO_ThV=pcaYT=a92XqUYdReuUg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kasan: rust: Add KASAN smoke test via UAF
To: Matthew Maurer <mmaurer@google.com>
Cc: ojeda@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, dvyukov@google.com, aliceryhl@google.com, 
	samitolvanen@google.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	glider@google.com, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:49=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Adds a smoke test to ensure that KASAN in Rust is actually detecting a
> Rust-native UAF. There is significant room to expand this test suite,
> but this will at least ensure that flags are having the intended effect.
>
> The rename from kasan_test.c to kasan_test_c.c is in order to allow the
> single kasan_test.ko test suite to contain both a .o file produced
> by the C compiler and one produced by rustc.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  mm/kasan/Makefile                         |  7 ++++++-
>  mm/kasan/kasan.h                          |  6 ++++++
>  mm/kasan/{kasan_test.c =3D> kasan_test_c.c} | 12 ++++++++++++
>  mm/kasan/kasan_test_rust.rs               | 19 +++++++++++++++++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
>  rename mm/kasan/{kasan_test.c =3D> kasan_test_c.c} (99%)
>  create mode 100644 mm/kasan/kasan_test_rust.rs
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 7634dd2a6128..13059d9ee13c 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -44,13 +44,18 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>  CFLAGS_KASAN_TEST +=3D -fno-builtin
>  endif
>
> -CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> +CFLAGS_kasan_test_c.o :=3D $(CFLAGS_KASAN_TEST)
> +RUSTFLAGS_kasan_test_rust.o :=3D $(RUSTFLAGS_KASAN)
>  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
>
>  obj-y :=3D common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o report_generic.o shado=
w.o quarantine.o
>  obj-$(CONFIG_KASAN_HW_TAGS) +=3D hw_tags.o report_hw_tags.o tags.o repor=
t_tags.o
>  obj-$(CONFIG_KASAN_SW_TAGS) +=3D init.o report_sw_tags.o shadow.o sw_tag=
s.o tags.o report_tags.o

Nit: empty line here.

> +kasan_test-objs :=3D kasan_test_c.o
> +ifdef CONFIG_RUST
> +       kasan_test-objs +=3D kasan_test_rust.o
> +endif
>
>  obj-$(CONFIG_KASAN_KUNIT_TEST) +=3D kasan_test.o
>  obj-$(CONFIG_KASAN_MODULE_TEST) +=3D kasan_test_module.o
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fb2b9ac0659a..f438a6cdc964 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -555,6 +555,12 @@ static inline bool kasan_arch_is_ready(void)       {=
 return true; }
>  void kasan_kunit_test_suite_start(void);
>  void kasan_kunit_test_suite_end(void);
>
> +#ifdef CONFIG_RUST
> +char kasan_test_rust_uaf(void);
> +#else
> +static inline char kasan_test_rust_uaf(void) { return '\0'; }
> +#endif
> +
>  #else /* CONFIG_KASAN_KUNIT_TEST */
>
>  static inline void kasan_kunit_test_suite_start(void) { }
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test_c.c
> similarity index 99%
> rename from mm/kasan/kasan_test.c
> rename to mm/kasan/kasan_test_c.c
> index 7b32be2a3cf0..dd3d2a1e3145 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1899,6 +1899,17 @@ static void match_all_mem_tag(struct kunit *test)
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
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_RUST);
> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
> +}
> +
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -1971,6 +1982,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
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

