Return-Path: <linux-kernel+bounces-570852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6452A6B543
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC514825CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81E1EEA32;
	Fri, 21 Mar 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7TZegAX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF71D5CD7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542917; cv=none; b=nYT/zF9vRn3hdu2epmHeQhaqMWyYbR5oztARqHI7lfprd/8oFsNiRQpuE05G2Givanxiol4D17YeEVCBCgmHK1rfJvzsMSG0aUtrKVhvOD6Pc07T3xRKVxcRpAuJsfBpaEgYhKfrtQzL/fmMPCblId4lq1HKcTCaekn8Xebx6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542917; c=relaxed/simple;
	bh=KtWrpnvUfUVYTX/5d9w7k3jQmT7JPaJMUddvlbWeGXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYOdyfAsf2tK+ZT72/JPoERuVAlK8UMxBBdzyiW+i0HlfxV9LLJbxESyObXn79E7El1zHY2Bd95m1MQvMPA0/gUyTJ7FTIxrOWLinWvGM+Zr0DrvdttbyAa07dJUxL9Hp21h2z3uGH+MgriGfOHcXrTD0aalLOheA4GvUytSn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7TZegAX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso7041945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742542914; x=1743147714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QDkKTpJk58Ktx+9rOT3NOwy69eQow/Xtda/ZJYwLaY=;
        b=G7TZegAXetPCojWkSui7UhGwJtHurcxr+C3/1TEZGCku7tqiYHaKK2u4veJEJvr5Jo
         h8jlxnYEjE4WHNCCUgEZKllAZTqzI+egj3mNA9Ik+ey4kPjec4zYUlYJNXIEn406wWxw
         ce8jMboSUQuCGzAgSxe3HdyGchN1dni7VzV2/u9qXnR9/JJGMRAgqGIGanXpeTl6PTTn
         HUU5d67dGdCXyq6KzVHKPR1ieuuRPr/svHod7+DAGqn9twvtgZFLLPofF7l9+AMJLJPi
         cIWDVjnWxaKoWBG3A+YLkubOT2cbUuGJ7Vs03lj74rMvjYTulMH1sHD2yL4Zn7ebrvx0
         Bymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542914; x=1743147714;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QDkKTpJk58Ktx+9rOT3NOwy69eQow/Xtda/ZJYwLaY=;
        b=QPH7RMcVtK5J5XzkvC3Ja6dAVDAjDqm6ywJv/quJK0Mq4JP3UQlMUs9uinv9fAyIeV
         aqQH2a89Fq4EBVw+TaeYnA+eW8HLSCbwQ2EtsL7vHiVXddcjdBaQumtd/7F+rl8RZ28s
         ZZ0wr4OD/FLVT+jTVJ9Qru9XkxSEZr9xLkI3mRtzyRi0DsVyrJrxI5X6y0NejZDLNWra
         DzbhSQjmg3aq+2XHnf7r2evAxrbNbQ5yGFE5GfzCSQeaQu+oRviUkVoqFCN27ucEl5hB
         A/hyJz8UxYgx6zGYCD573y1ic0crq2jRzVFyeTrTA7Dfn4qElFcMjjZNYK8EbtyokJyS
         shdg==
X-Forwarded-Encrypted: i=1; AJvYcCWFOKx+iFbpyy3GA/RggmpuQV7bxCNifFb7sZPFd19afAv/l2vdAYZY5f8LgskYg+pax07y9UFm7N8rGCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DlXVdOqP50HJRfgE8p5u4Hg7EjknK8pxVztbB2XNqra/2wkM
	Jveh71T7bNCmRUH2IvdaLZY4y7oZ0q2S1Pc0KyCviT+IeDNmiKl6z8FSjEyw2GTBAMmIyGHljqI
	oH861xYKT7vtr9w==
X-Google-Smtp-Source: AGHT+IGo9HK+CggSLT/xUlTNs1Ruo5T9zJS8QlsV4cOXsH823z1KcgJ6bloqShrzPtyywpLJq/NVddIOoxOR7PE=
X-Received: from wmbbd27.prod.google.com ([2002:a05:600c:1f1b:b0:43d:4055:98e3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f92:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43d50a4c4b6mr15640135e9.30.1742542914331;
 Fri, 21 Mar 2025 00:41:54 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:41:52 +0000
In-Reply-To: <CAJ-ks9mM6cb_b0G_ZZh+tnijOPo1imWv-bzhgrLpGcNXMsMjBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
 <20250320-vec-methods-v1-4-7dff5cf25fe8@google.com> <CAJ-ks9mM6cb_b0G_ZZh+tnijOPo1imWv-bzhgrLpGcNXMsMjBA@mail.gmail.com>
Message-ID: <Z90YQGxdEFAKznHN@google.com>
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::drain_all
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 06:12:50PM -0400, Tamir Duberstein wrote:
> On Thu, Mar 20, 2025 at 9:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > This is like the stdlib method drain, except that it's hard-coded to us=
e
> > the entire vector's range. Rust Binder uses it in the range allocator t=
o
> > take ownership of everything in a vector in a case where reusing the
> > vector is desirable.
> >
> > Implementing `DrainAll` in terms of `slice::IterMut` lets us reuse some
> > nice optimizations in core for the case where T is a ZST.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/alloc/kvec.rs | 57 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index df930ff0d0b85b8b03c9b7932a2b31dfb62612ed..303198509885f5e24b74da5=
a92382b518de3e1c0 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -564,6 +564,30 @@ pub fn truncate(&mut self, len: usize) {
> >          //   len, therefore we have exclusive access to [`new_len`, `o=
ld_len`)
> >          unsafe { ptr::drop_in_place(ptr) };
> >      }
> > +
> > +    /// Takes ownership of all items in this vector without consuming =
the allocation.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v =3D kernel::kvec![0, 1, 2, 3]?;
> > +    ///
> > +    /// for (i, j) in v.drain_all().enumerate() {
> > +    ///     assert_eq!(i, j);
> > +    /// }
> > +    ///
> > +    /// assert!(v.capacity() >=3D 4);
> > +    /// ```
> > +    pub fn drain_all(&mut self) -> DrainAll<'_, T> {
> > +        let len =3D self.len();
> > +        // INVARIANT: The first 0 elements are valid.
> > +        self.len =3D 0;
>=20
> Could you use `self.dec_len(self.len)` here? Then you'd have a &mut
> [T] rather than `MaybeUninit`. Provided you agree `dec_len` is sound,
> of course.

I think that `&mut MaybeUninit<T>` is better in this case. Calling
assume_init_read on a `&mut MaybeUninit<T>` does not leave the
MaybeUninit in an invalid state in the same way that calling `ptr::read`
on an `&mut T` does.

Alice

