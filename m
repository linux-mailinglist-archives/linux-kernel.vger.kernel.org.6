Return-Path: <linux-kernel+bounces-301755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B095F51E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20211F228D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24668193087;
	Mon, 26 Aug 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byvi5YJZ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9161917DF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686284; cv=none; b=J6qwEyfrd9P1/3A/2Mm4680um4QT3U0f6lLw2hwjwx48hQElakTc1McVuB/Zv4hvsMFxuYMEDJLervo6hWjw7exS2fDnQtJfP/lxlb9Ly6awtf4MOegflCAr6wrUn2grlRpGVWrjR2dYa5F1SA5+VBLu4BnASmaGorLJtIPFzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686284; c=relaxed/simple;
	bh=UBl4FU15A8tb8ujhhS/2FtY/4b0ns+u3UlTgs0f+NWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqXLfjRWTKBhtdtMd+3y6JGAHom4Ik0ZMoifRCCh/Pa7KUk/963P+qrm2j2co8H9XQAPXaNuoySPhevaw6dFj0SJKysRcLLWi6n4peSkX49C1NR1r7rW1SH4LvxJN7Y5DGnyLoP+Pd5VqBi5gaIK4B6CLtqeV7vY3/yk6uJA8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byvi5YJZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so37105875e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724686281; x=1725291081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RyvorOmaB0wAXgQv5bWHPkMw7nEOqq3IqbAMWHqucA=;
        b=byvi5YJZ0nnRZ5FN67wqGyevZOZaEp0q6EBrLPaaoCFxSFfgW1eu7fECZ+lTk6J+MQ
         Qb1MVhMHDGAGqu5bJpOswbxuvqxmjcez5m5aTTY6VY7Ecmcu2IToiQN2qtbAS3sbyU75
         QBjBfG9xR4YnzqP8NduBX72zwZxcvPmCnhjM1FKz2Vx2lpUPgHxjDrbNKdmFvIeeACnX
         anPj4RqTkMnBPJMyEqhDvEuOJjpcurDECCj+bPYhopWXoDG5KePsPh8oErJ7Bu6zqdxt
         7wXogYD+02dLdzyVEgL0J1xjxjQt/uGXfPhzdueO3yEm6j73TLnDvVeEMRm6AFpKkHBy
         Javg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686281; x=1725291081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RyvorOmaB0wAXgQv5bWHPkMw7nEOqq3IqbAMWHqucA=;
        b=To4Vye+a3AtkoDycFgUCZKq4GOrCkXKysYEycCnLoxa8eQ7Yr8pvAGvlWHyh4BawUg
         kZVeTBRkYf9v0Lbtco0DB8PfgUiNoBWfpIJSQvBtVgGcjjEYgNSNUupP7ab6JVqKCPtW
         xg18bGXmkJ2APkTgXE4/JwNbav9O7MnfplTFSE66+SlzM63liR0xZ1oEiQloBRnFS7+Q
         a3/5gLX8WZVqe02yRNOHol0CjJjXJdq4V3GuVjdwZd/qmJOy5xP9galHqTSdc5ZWvSDg
         +5+Ig8z1E3iE5lDT/H6+sOyqTD3O9O1GNpdqCgNHesjVAmsyvBX4iNyIFAuy9rY4n66o
         AnEw==
X-Forwarded-Encrypted: i=1; AJvYcCW6UvRxl1ySUMdw3lVfq5ojYJBRGA4oWb2U9GF8dlqYbErW6P9BaCn3nje181b6fOoNoN1am7WtNBRr8wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeExJPEYozPVqKeIjQWWn/8vA4cJSZG9mgyhA1Rpw5DggUhD71
	JMLDHsBjhmIwcVzW0ZqSHF7ruV1mTY9FP4jhlI+Zk08YabEt/mcJmyHcqwdwXXPJwq9zM6XDgnW
	SWVTySm4978ocsfB3wqYnG/gBaoH3UvxbDNp1
X-Google-Smtp-Source: AGHT+IEIqQrZlUNxKO6DnJGXQCf/gHmVjUX8ag+3f8xAxj+baEZ/T8fvEXoDQ1xhOzgL6fbmRHOMI7fmk4NmNz2Lsdw=
X-Received: by 2002:adf:e645:0:b0:36c:b5a1:f108 with SMTP id
 ffacd0b85a97d-373118e3547mr6032056f8f.39.1724686280737; Mon, 26 Aug 2024
 08:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-static-mutex-v1-1-a14ee71561f3@google.com> <9feb41cc-cb1c-4d0d-a3df-09298e69af69@proton.me>
In-Reply-To: <9feb41cc-cb1c-4d0d-a3df-09298e69af69@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Aug 2024 17:31:08 +0200
Message-ID: <CAH5fLgjtSVMcKL4aMrNT=zJPGvzAPJt3qAUMYdB-+3=s80FNKQ@mail.gmail.com>
Subject: Re: [PATCH] rust: add global lock support
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 26.08.24 17:27, Alice Ryhl wrote:
> > We don't currently have any support for global locks in Rust, however
> > they are very useful and I have needed to work around this limitation
> > several times. My workarounds generally involve initializing the mutex
> > in the module's init function, and this workaround is reflected here.
> >
> > Due to the initialization requirement, constructing a global mutex is
> > unsafe with the current approach. In the future, it would be really nic=
e
> > to support global mutexes that don't need to be initialized, which woul=
d
> > make them safe. Unfortunately, this is not possible today because
> > bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
> > compile-time constant. It just generates an `extern "C"` global
> > reference instead.
> >
> > On most architectures, we could initialize the lock to just contain all
> > zeros. A possible improvement would be to create a Kconfig constant
> > that is set whenever the current architecture uses all zeros for the
> > initializer and have `unsafe_const_init` be a no-op on those
> > architectures. We could also provide a safe const initializer that is
> > only available when that Kconfig option is set.
> >
> > For architectures that don't use all-zeros for the unlocked case, we
> > will most likely have to hard-code the correct representation on the
> > Rust side.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/sync/lock.rs | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index f6c34ca4d819..19e8ecd8d194 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -117,6 +117,40 @@ pub fn new(t: T, name: &'static CStr, key: &'stati=
c LockClassKey) -> impl PinIni
> >              }),
> >          })
> >      }
> > +
> > +    /// Create a global lock that has not yet been initialized.
> > +    ///
> > +    /// Since global locks is not yet fully supported, this method imp=
lements global locks by
> > +    /// requiring you to initialize them before you start using it. Us=
ually this is best done in
> > +    /// the module's init function.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// You must call [`unsafe_const_init`] before calling any other m=
ethod on this lock.
> > +    ///
> > +    /// [`unsafe_const_init`]: Self::unsafe_const_init
> > +    pub const unsafe fn unsafe_const_new(t: T) -> Self {
> > +        Self {
> > +            data: UnsafeCell::new(t),
> > +            state: Opaque::uninit(),
> > +            _pin: PhantomPinned,
> > +        }
> > +    }
> > +
> > +    /// Initialize a global lock.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * This lock must have been created with [`unsafe_const_new`].
> > +    /// * This lock must be pinned.
>
> You could also ask for `self: Pin<&Self>` and remove this constraint, or
> is that not possible in your use-case?

The value is going to be in a static, and it's inconvenient to have to
use Pin::new_unchecked when calling this initializer. Not sure much
value is gained.

Alice

