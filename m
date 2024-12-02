Return-Path: <linux-kernel+bounces-426992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3279DFAF6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9E6163050
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A81F9404;
	Mon,  2 Dec 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpf2HSiH"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652241F9432;
	Mon,  2 Dec 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123696; cv=none; b=MIVoP29TROjmlrC1RPqV2aJqN/ZMoZaChRz2VbU3nW3Z1/SFSvsPb9Ups+Wh8ij9XjNObhGlSmBg/RWSAPcoSLlb0uHG1xE84K72jAuLr0og0vLHnmKHGOenEifAF8DLwtn6TfT+i+DK67Tvxa0Secfpl5qdML4AEKU1xS17HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123696; c=relaxed/simple;
	bh=Ft4O5XSechI9tZyA+jrXC1PDqP2UKsyMc3WO/BX29I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gdw4iTRBP4zeEWHcwazFe2oD2Fz5M3bWsm9DYhsk+ohWGuGwZAJKH+6o5GC+rpwZXqH7JQHywqLbDU6f84dEyHHvpLzWNQ3kylbRYESSQJdFN7ZrTaaivrulV2OKU+fotv6wkbhogo8tq2Kh/E5Xo5AifYZx4GBw6Q+9KA/F7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpf2HSiH; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85b9c456f46so434674241.3;
        Sun, 01 Dec 2024 23:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733123693; x=1733728493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyDQ9j9UHC5BbfNURrbflCNNwGQxDH1l+zeF4L4a4pU=;
        b=Zpf2HSiHqrDEPzBeADcwhiL9JmOW+JLn6IRqF1aHXOto2G84fp6AwxkptM62Zeuyyi
         NlUpbFLnE0zux9esdx1JnuESzxaAfYvX0ywUQEt1mjK7RDXLEotJhKh3nHjOvbw6gQ0k
         pWOgy42kqB0SUZu2Yc9AtxuinC1aibz1NNYKqdaGWHQl/aOnFcOdlI01bgxE3EHoHtOB
         51pIBQvPPTVoC76J9omOb4REoJi+LtYLUJwoABuv5AInzGc1Ljg/gdu+g/ho9lgq3UXg
         hMcvRbTjmGWuhqbX4h3phZ7BJXc8/YTSDVDDvIfbu+WUWsnWzCfFuPuKrR+VHGzqGre7
         r8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733123693; x=1733728493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyDQ9j9UHC5BbfNURrbflCNNwGQxDH1l+zeF4L4a4pU=;
        b=fPz3o+ogBv2uYJbkHme8iEo7aOP7+JTruoEsVNCAmNTHidF4zmEhZQxKD0NN6mwr/6
         IrFGEgolJPQALy5VgBesyJydBJVBECS+3/1FicEVwWSS9GcUFNkyFz51Fa/GTfIsUvQi
         v3vQazmWy8SGWrdThKu2sPuRQk6LACtbOCi6KdFRIi0ia2bGoZgUzNt3HHWfPR7+csT3
         /9n0zoUqU6/+iJaNvEheCBBCfugLwy1i2Z3g+IyV/QITAXJGTMJPOUWRQ42HeAslg1p7
         fufWT5PbvTDm+CGfch8+rRPma8QvvifvKX2MyeE9HTdBQt0EbiicVJ4NiEMThZDxg8vF
         L0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzvwXloxOqha6v53oz5X/nbEIg077vCz/HM5OdyFTBsgyrf/caekkeZnclqnLwRVChpBiu5CxmiC+LsSnGPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyERRKkROJ84qNj62nWrRfQIMwl8P7wNR/pzGmUGedHcnt5+gfR
	YJVCDHmhY5XFF5FBlU2j8b57D2OCIobaCSgH4rLK1XjBEpNHHB4h7Nr/DGwDmzMcUxTZaRYo7Tg
	x5Lc7fWQjFTU77z7C5gncyXeMem4=
X-Gm-Gg: ASbGncu4AAmTOFsSWWG9TcvS/Rw8y6ZnBcmvOv2njc1Yxk3xcwz8r0RheHMcQ/smzY/
	8DNH8jMxUlnMw1K1UznqRJOAXCi2yvqlb
X-Google-Smtp-Source: AGHT+IHVlLpv+VAr+llG00lYJhexczCgShyMsvZLK7u9hQnwuR36F0LGg3gBqqAopceA7gYdFDFD4CoyoP6KAzUuEMY=
X-Received: by 2002:a05:6102:290c:b0:4af:5e86:3ff9 with SMTP id
 ada2fe7eead31-4af5e8640ddmr15879332137.8.1733123693043; Sun, 01 Dec 2024
 23:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114005631.818440-1-alistair@alistair23.me>
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Dec 2024 16:14:26 +0900
Message-ID: <CAKmqyKNUYZun4Xsh=nNA5RG51MBdDRO-bx4mW1TdECTeaor4-w@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] rust: bindings: Auto-generate inline static functions
To: Alistair Francis <alistair@alistair23.me>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, benno.lossin@proton.me, boqun.feng@gmail.com, 
	me@kloenk.dev, alex.gaynor@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	aliceryhl@google.com, alistair.francis@wdc.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:56=E2=80=AFAM Alistair Francis <alistair@alistair=
23.me> wrote:
>
> The kernel includes a large number of static inline functions that are
> defined in header files. One example is the crypto_shash_descsize()
> function which is defined in hash.h as
>
> ```
> static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm=
)
> {
>         return tfm->descsize;
> }
> ```
>
> bindgen is currently unable to generate bindings to these functions as
> they are not publically exposed (they are static after all).
>
> The Rust code currently uses rust_helper_* functions, such as
> rust_helper_alloc_pages() for example to call the static inline
> functions. But this is a hassle as someone needs to write a C helper
> function.
>
> Instead we can use the bindgen wrap-static-fns feature. The feature
> is marked as experimental, but has recently been promoted to
> non-experimental (depending on your version of bindgen).
>
> By supporting wrap-static-fns we automatically generate a C file called
> extern.c that exposes the static inline functions, for example like this
>
> ```
> unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { re=
turn crypto_shash_descsize(tfm); }
> ```
>
> The nice part is that this is auto-generated.
>
> We then also get a bindings_generate_static.rs file with the Rust
> binding, like this
>
> ```
> extern "C" {
>     #[link_name =3D "crypto_shash_descsize__extern"]
>     pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::c_=
uint;
> }
> ```
>
> So now we can use the static inline functions just like normal
> functions.
>
> There are a bunch of static inline functions that don't work though, beca=
use
> the C compiler fails to build extern.c:
>  * functions with inline asm generate "operand probably does not match co=
nstraints"
>    errors (rip_rel_ptr() for example)
>  * functions with bit masks (u32_encode_bits() and friends) result in
>    "call to =E2=80=98__bad_mask=E2=80=99 declared with attribute error: b=
ad bitfield mask"
>    errors
>
> As well as that any static inline function that calls a function that has=
 been
> kconfig-ed out will fail to link as the function being called isn't built
> (mdio45_ethtool_gset_npage for example)
>
> Due to these failures we use a allow-list system (where functions must
> be manually enabled).
>
> This series adds support for bindgen generating wrappers for inline stati=
cs and
> then converts the existing helper functions to this new method. This does=
n't
> work for C macros, so we can't reamove all of the helper functions, but w=
e
> can remove most.

Any more comments?

Alistair

>
> v4:
>  - Fix out of tree builds
> v3:
>  - Change SoB email address to match from address
>  - Fixup kunit test build failure
>  - Update Rust binding documentation
> v2:
>  - Fixup build failures report by test bots
>  - Rebase on rust-next (ae7851c29747fa376)
>
> Alistair Francis (11):
>   rust: bindings: Support some inline static functions
>   rust: helpers: Remove blk helper
>   rust: helpers: Remove err helper
>   rust: helpers: Remove kunit helper
>   rust: helpers: Remove some page helpers
>   rust: helpers: Remove rbtree helper
>   rust: helpers: Remove some refcount helpers
>   rust: helpers: Remove signal helper
>   rust: helpers: Remove some spinlock helpers
>   rust: helpers: Remove some task helpers
>   rust: helpers: Remove uaccess helpers
>
>  Documentation/rust/general-information.rst | 10 +++---
>  rust/.gitignore                            |  2 ++
>  rust/Makefile                              | 37 ++++++++++++++++++++--
>  rust/bindgen_static_functions              | 32 +++++++++++++++++++
>  rust/bindings/bindings_helper.h            |  6 ++++
>  rust/bindings/lib.rs                       |  4 +++
>  rust/exports.c                             |  1 +
>  rust/helpers/blk.c                         | 14 --------
>  rust/helpers/err.c                         | 18 -----------
>  rust/helpers/helpers.c                     | 11 ++-----
>  rust/helpers/kunit.c                       |  8 -----
>  rust/helpers/page.c                        |  5 ---
>  rust/helpers/rbtree.c                      |  9 ------
>  rust/helpers/refcount.c                    | 10 ------
>  rust/helpers/signal.c                      |  8 -----
>  rust/helpers/spinlock.c                    | 15 ---------
>  rust/helpers/task.c                        | 10 ------
>  rust/helpers/uaccess.c                     | 15 ---------
>  18 files changed, 87 insertions(+), 128 deletions(-)
>  create mode 100644 rust/bindgen_static_functions
>  delete mode 100644 rust/helpers/blk.c
>  delete mode 100644 rust/helpers/err.c
>  delete mode 100644 rust/helpers/kunit.c
>  delete mode 100644 rust/helpers/rbtree.c
>  delete mode 100644 rust/helpers/signal.c
>  delete mode 100644 rust/helpers/uaccess.c
>
> --
> 2.47.0
>

