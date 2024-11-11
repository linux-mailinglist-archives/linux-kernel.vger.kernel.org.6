Return-Path: <linux-kernel+bounces-403579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFCD9C377D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C189281506
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880614A4FB;
	Mon, 11 Nov 2024 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtKUR4H3"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057932C8E;
	Mon, 11 Nov 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299126; cv=none; b=Im9NrV/MnCpeCN5sb252pUOFU7gioxhqXFatiM826sm8bSqXsnZASZ2ul35jfpZQqbXbejxiI4o+6rLHNq9Np6uXBUnXz+mOPdlwgmAAc0N8qAvNY1gv+yB6pCzM+y5fzGJzz2Imzgu5VnG8eRofFioIDx8dF6mge/MnaoSjZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299126; c=relaxed/simple;
	bh=/t9Jwe4HDPD7YywpIuV3Lcf7kzdchTAFNEHbjmGCk70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7e8hai4ro/bDgzJTv3qQ5zW3BIYay07M9QPZeRxRdIOrwWHqD2jRWj8zVtt9zSBoofZ3/ouJiJ74hAmZa6XjxLpCiT++yVqvRl7wruilfJ1Ej9Sj3w3VT190A2JyPSG/yg8yzcvfWcsr5N+/thzAdH6mO7qD93nVVmNo3zWtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtKUR4H3; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85019a60523so1319488241.1;
        Sun, 10 Nov 2024 20:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731299124; x=1731903924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8zRUOdWrERuNjp0I0POAgNLhU+Cck87wCOaDfviZXU=;
        b=mtKUR4H3J8+qWGfXECScVYp58ty4kwmY1CtLPdnVwiOI4NNw1XbBFgg4wg3jjd80er
         DT2IxSp+wdtHcViXzAtSUdujOkxlSn4/vp5+Tn3U/HRjAudCX+U6yGkZcVSWk3eLeMxt
         /6+yJH61vfIj+15I3MQW4vGrZgMzGygmhuqVZjzq6F/045bVwJwGGfvHp4hq3JswoAQv
         Tghfra2cD2T4c8/m1b4rYpBhfqu9Tr3UT51yq8YaVEQ/vHHXvF/tsn7kdgw6VoXO8VA8
         Z3OyRPp41/yKHi1iTpTo/hWgz/ABa5NaGG2KMw8G6HnQfWBcBavxvEIu4uQekK+fKQzm
         n1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731299124; x=1731903924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8zRUOdWrERuNjp0I0POAgNLhU+Cck87wCOaDfviZXU=;
        b=Mh4TbxnfFKc6p0z+WLgnQwBb5ATUqZQB6QKqG8/RPk34RmdR0C73i98LMVcEwEXHq+
         Hfl1x+NVH402BDnS3HUyQEng4UFfCN/WR0s3TSCot2w8TQ9VhflmyWDmf2g9x0ROGlR/
         CfQf7kXj/lcaRZc5BNNmsxiVepxBrxU5zZtMqIvxIsV/mQaBLfs7RWKORkzQgD16bkPo
         KA0/jIXwBh+CykKaBerwuckC/DJKGwKPM8h5ueiCSLKfKEkKgNs9Ds/6yd5yLWmVLmBB
         lYBbnBTTrZtDsAvQ/0xPZH9QwuNCc07xCwRntigVkQnVUHwvJ4GzGHqozVZpQFwgRzNU
         Avgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1bH+D6ycO9HXIoYEisCKcJB9jt2c29edknsEKTQ0dlK2Kg1dqRcJtY9Rdi/3CCLfVyuA9cO6b01UYkls=@vger.kernel.org, AJvYcCVX4Sqwj2cbXruIgdncUBtm+RKzAHAq64oOA/NFqs7LcmYchthYWD0UGdE0mUz2i6i47v5J/i66LgRfAWDlMyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUdD43Vs/qzUGoxpLHHO6DGrKu8I/dgU3kSIFiqT/R9r/PHUz
	tgFCbSZ/DrdLSy9C4YVVT1aoMTCdzU1hPLhTnndFWt7v1i2I9uJBsPU8WlSYWELvCW6jjGIJuSo
	CHSmofPctdivUU/R6mEseMR9HAvY=
X-Google-Smtp-Source: AGHT+IHgqpCSv9vxe5BM0IPr3cZ2CK7j60+QQ750UXGr6jWobuGCnI4gA52uY7OemrTZ6r40bXtP+8sH2vqiiBU0FwM=
X-Received: by 2002:a05:6102:418e:b0:4a4:72f0:794a with SMTP id
 ada2fe7eead31-4aae13bd940mr10018436137.13.1731299124081; Sun, 10 Nov 2024
 20:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108031012.335203-1-alistair.francis@wdc.com>
 <20241108031012.335203-5-alistair.francis@wdc.com> <900683ff-568e-4f63-a8c7-31271bd83988@de.bosch.com>
In-Reply-To: <900683ff-568e-4f63-a8c7-31271bd83988@de.bosch.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Nov 2024 14:24:58 +1000
Message-ID: <CAKmqyKPS0b6VYKthsV-dC=XqNvkz_5N5On8-X76tx8U0T6iV_g@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] rust: helpers: Remove kunit helper
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: a.hindborg@kernel.org, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	alistair.francis@wdc.com, rust-for-linux@vger.kernel.org, me@kloenk.dev, 
	benno.lossin@proton.me, aliceryhl@google.com, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	gary@garyguo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:01=E2=80=AFPM Dirk Behme <dirk.behme@de.bosch.com>=
 wrote:
>
> Hi Alistair,
>
> On 08.11.2024 04:10, Alistair Francis wrote:
> > Now that we support wrap-static-fns we no longer need the custom helper=
.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   rust/bindgen_static_functions | 2 ++
> >   rust/helpers/helpers.c        | 1 -
> >   rust/helpers/kunit.c          | 8 --------
> >   3 files changed, 2 insertions(+), 9 deletions(-)
> >   delete mode 100644 rust/helpers/kunit.c
> >
> > diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functi=
ons
> > index 0269efa83c61..b4032d277e72 100644
> > --- a/rust/bindgen_static_functions
> > +++ b/rust/bindgen_static_functions
> > @@ -9,3 +9,5 @@
> >   --allowlist-function ERR_PTR
> >   --allowlist-function IS_ERR
> >   --allowlist-function PTR_ERR
> > +
> > +--allowlist-function kunit_get_current_test
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index e089ecdf091f..60b3fdc5c2de 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -10,7 +10,6 @@
> >   #include "bug.c"
> >   #include "build_assert.c"
> >   #include "build_bug.c"
> > -#include "kunit.c"
> >   #include "mutex.c"
> >   #include "page.c"
> >   #include "rbtree.c"
> > diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
> > deleted file mode 100644
> > index b85a4d394c11..000000000000
> > --- a/rust/helpers/kunit.c
> > +++ /dev/null
> > @@ -1,8 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -
> > -#include <kunit/test-bug.h>
> > -
> > -struct kunit *rust_helper_kunit_get_current_test(void)
> > -{
> > -     return kunit_get_current_test();
> > -}
>
> Could you check this? I don't get kunit_get_current_test() in the
> resulting bindings/bindings_generated_static.rs and
> exports_bindings_static_generated.h. So with CONFIG_KUNIT and
> CONFIG_RUST_KERNEL_DOCTESTS being enabled (not sure if both are required
> ;) ) I get dozens of errors due to that missing:
>
> error[E0425]: cannot find function `kunit_get_current_test` in crate
> `$crate::bindings`
>
> Reverting only this 4/11 and keeping all other patches of this series
> makes my kernel build fine, though :)

Thanks for testing! I was missing a "#include <kunit/test-bug.h>"

>
>
> Btw, do we want/need an update of the documentation?
>
> https://docs.kernel.org/rust/general-information.html#bindings

Good point, fixed in v3.

Alistair

>
> Thanks
>
> Dirk
>
> P.S.: Many thanks for rebasing against rust-next!
>

