Return-Path: <linux-kernel+bounces-190494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C048CFF32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16C11F237AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4B15D5D2;
	Mon, 27 May 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyx/MeDg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCF13AD28
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810138; cv=none; b=U7CGbonKihtidyHBjR5gxghITBU2kuAi8D683ys86GJBlN3ykPGWDpWJPKur7dhlKVZ989Q4klCLpnYLyPGrfRhoeDHX9+MoMEMuYGmKjwPb2dFdPrWLqHOk2jw+iSFKEGPs1TzrNA0/diAT88PxszPZQ/RtuKZHuwWRTB7RYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810138; c=relaxed/simple;
	bh=W9k0BmIHyn2MJjOZIKvOW1YY7kqid4ihPr/22yJ4bvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqNuB4Z5qsiFwwYciYDvxLvPnIxhk7FTXBVPCXYj2LMSq8JP0iLfUKuGGv21uzJc6SiiE5vQz5LJ+EPP5F8w/YKQUeIyU/2BoMSHjD6kl8TPw7zO7zysHOaeQs9X2C2+aF3l/Vk4Jgpjz17LrxrCQKTyTsFTPRTlznohxmJ3jdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyx/MeDg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421140314d5so7013495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716810135; x=1717414935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a0IwIbKiun5ZjFq+aihsDppfHB3sjCXZbCHtC5Ys0k=;
        b=nyx/MeDgKKERkccBb8krpG9Zcn51T8/wtu+tMFcA7w749z9aNlDwVM8w/w/UAS3Omk
         758YFkShJPxJR5ABY8VEnROnHc5XoelAUQKjB9WSmi6gc9ArfFYYWCT8AtvoyEhHywXG
         6b2+PWval2bDSwxD2UGeLS1lxMKOOfcfz0P2TqVFDg33det/0BR5FMdBM2o3Sa7gAicV
         LDp8i0NeNh/0tHqROhUZKFy0/AMQD9v1OepuIzH2t9YhoT0qB5UmNZ3ootX57bKYOsb6
         x6141u8jsB2WqQKoMi64pPGHUkJozG4CrqjArFcOabj5/na44h5ko5bX6OT9KL6JoVKi
         cJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810135; x=1717414935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a0IwIbKiun5ZjFq+aihsDppfHB3sjCXZbCHtC5Ys0k=;
        b=N94Veipv+6iwMZ2RATDb+MbEhNB+W6dbmt5eIo1lIksx/nTQmRaIIWNNdNEPczlNix
         qu/TfvNFIyNWNS2afF6J0FCFB8lt23Jnlpo/zP4R7QYe+bqNQbz38PiopmMhbtBb/1u0
         kvEYaqDr4DzSzHKTDD54AibXQh/Ui3KkuXnobk9LksqpGckpjrCgPsY9mzteQa62JCFl
         21FpIt9f56RGwt5ZA8dSHH/lG31r0Gpl8mTGlE46awynF+Iaf1W8V/03KLQzK3ZznleU
         07aSENvXUMC0pfJoGsV+FdVo1H4vgOdpSn+g0WXPeYeOyUV37F1Wc7+dBzjFbzsUjV9N
         vDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFU19QvasfkboEZeijX4FOdG1NiHIGJn+ESnQP1ZOp3NYckEKquuRIfFVVk/WA7PijekPwEnAlz68xeJJgEIMa870NtuCspNS53W41
X-Gm-Message-State: AOJu0YwpQldJqAOAqvi1OyVexWbkCC9GeygA0kAkiDgpSBW6bHcJeY+c
	wNsSTN8m+Y5/xenVs758DLnBPb3CRUdMsJKUUH2CxNPKTE0spJFOeUO+I9rdGemxbnIKua4Y/mR
	EyUudAoVNEZ3Ytdy8Rq/b8ypZX0SH1kwdTiIm
X-Google-Smtp-Source: AGHT+IEvpaRfqMw/sKzNNtB4iVjDlASFoCmySrw4aSwM/P8O6KFd2w0EJJJKBGrH4vKAXtoiorMDYk9QNOejAdn6UG8=
X-Received: by 2002:a05:600c:4589:b0:41c:503:9a01 with SMTP id
 5b1f17b1804b1-42108a00012mr73225675e9.25.1716810135124; Mon, 27 May 2024
 04:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
 <20240506-linked-list-v2-3-7b910840c91f@google.com> <82220d9b-3f4f-43ba-ad15-412ceb349a56@proton.me>
In-Reply-To: <82220d9b-3f4f-43ba-ad15-412ceb349a56@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 May 2024 13:42:00 +0200
Message-ID: <CAH5fLghoHiU928pCzMy3DRZzbw7J_HUVMObGXGtX-0ncVJnP3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] rust: list: add struct with prev/next pointers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 11:58=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 06.05.24 11:53, Alice Ryhl wrote:
> > Define the ListLinks struct, which wraps the prev/next pointers that
> > will be used to insert values into a List in a future patch. Also
> > define the ListItem trait, which is implemented by structs that have a
> > ListLinks field.
> >
> > The ListItem trait provides four different methods that are all
> > essentially container_of or the reverse of container_of. Two of them ar=
e
> > used before inserting/after removing an item from the list, and the two
> > others are used when looking at a value without changing whether it is
> > in a list. This distinction is introduced because it is needed for the
> > patch that adds support for heterogeneous lists, which are implemented
> > by adding a third pointer field with a fat pointer to the full struct.
> > When inserting into the heterogeneous list, the pointer-to-self is
> > updated to have the right vtable, and the container_of operation is
> > implemented by just returning that pointer instead of using the real
> > container_of operation.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/list.rs | 116 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 116 insertions(+)
> >
> > diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> > index c5caa0f6105c..b5cfbb96a392 100644
> > --- a/rust/kernel/list.rs
> > +++ b/rust/kernel/list.rs
> > @@ -4,7 +4,123 @@
> >
> >  //! A linked list implementation.
> >
> > +use crate::init::PinInit;
> > +use crate::types::Opaque;
> > +use core::ptr;
> > +
> >  mod arc;
> >  pub use self::arc::{
> >      impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, Tr=
yNewListArc,
> >  };
> > +
> > +/// Implemented by types where a [`ListArc<Self>`] can be inserted int=
o a `List`.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that they provide the guarantees document=
ed on the three methods
>
> I would not mention the number of methods, since it is difficult to
> maintain and doesn't actually provide any value (it already is incorrect =
:)

I will remove the mention of a number.

> > +    /// This is called when an item is inserted into a `List`.
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// The caller is granted exclusive access to the returned [`ListL=
inks`] until `post_remove` is
> > +    /// called.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * The provided pointer must point at a valid value in an [`Arc=
`].
> > +    /// * Calls to `prepare_to_insert` and `post_remove` on the same v=
alue must alternate.
>
> Are there any synchronization requirements? Am I allowed to call
> `prepare_to_insert` and `post_remove` on different threads without
> synchronizing?

No, if you call them at the same time, then they aren't alternating.

> > +    /// * The caller must own the [`ListArc`] for this value.
> > +    /// * The caller must not give up ownership of the [`ListArc`] unl=
ess `post_remove` has been
> > +    ///   called after this call to `prepare_to_insert`.
> > +    ///
> > +    /// [`Arc`]: crate::sync::Arc
> > +    unsafe fn prepare_to_insert(me: *const Self) -> *mut ListLinks<ID>=
;
> > +
> > +    /// This undoes a previous call to `prepare_to_insert`.
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// The returned pointer is the pointer that was originally passed=
 to `prepare_to_insert`.
> > +    ///
> > +    /// The caller is free to recreate the `ListArc` after this call.
>
> As I read the requirements on `prepare_to_insert`, the caller is not
> required to deconstruct the `ListArc`. For example the caller is allowed
> to `clone_arc()` and then `into_raw()` and then pass that pointer to
> `prepare_to_insert`.
> So I would just remove this sentence.

I will remove it.

> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The provided pointer must be the pointer returned by the previ=
ous call to
>
> Does "most recent call" make more sense? I find previous call a bit
> weird. (also in the requirements above)

Sure, I can say "most recent".

Alice

> ---
> Cheers,
> Benno
>
> > +    /// `prepare_to_insert`.
> > +    unsafe fn post_remove(me: *mut ListLinks<ID>) -> *const Self;
> > +}
> > +
> > +#[repr(C)]
> > +#[derive(Copy, Clone)]
> > +struct ListLinksFields {
> > +    next: *mut ListLinksFields,
> > +    prev: *mut ListLinksFields,
> > +}
> > +
> > +/// The prev/next pointers for an item in a linked list.
> > +///
> > +/// # Invariants
> > +///
> > +/// The fields are null if and only if this item is not in a list.
> > +#[repr(transparent)]
> > +pub struct ListLinks<const ID: u64 =3D 0> {
> > +    #[allow(dead_code)]
> > +    inner: Opaque<ListLinksFields>,
> > +}
> > +
> > +// SAFETY: The next/prev fields of a ListLinks can be moved across thr=
ead boundaries.
> > +unsafe impl<const ID: u64> Send for ListLinks<ID> {}
> > +// SAFETY: The type is opaque so immutable references to a ListLinks a=
re useless. Therefore, it's
> > +// okay to have immutable access to a ListLinks from several threads a=
t once.
> > +unsafe impl<const ID: u64> Sync for ListLinks<ID> {}
> > +
> > +impl<const ID: u64> ListLinks<ID> {
> > +    /// Creates a new initializer for this type.
> > +    pub fn new() -> impl PinInit<Self> {
> > +        // INVARIANT: Pin-init initializers can't be used on an existi=
ng `Arc`, so this value will
> > +        // not be constructed in an `Arc` that already has a `ListArc`=
.
> > +        ListLinks {
> > +            inner: Opaque::new(ListLinksFields {
> > +                prev: ptr::null_mut(),
> > +                next: ptr::null_mut(),
> > +            }),
> > +        }
> > +    }
> > +}
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
>
>

