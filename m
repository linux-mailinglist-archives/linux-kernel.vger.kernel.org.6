Return-Path: <linux-kernel+bounces-401632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCD9C1D19
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1251C21E1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A201E7C1B;
	Fri,  8 Nov 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="et7gIF/j"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C67322E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069468; cv=none; b=Chbr3KKRgpZG2itEmqXem6+7KyOiEkWzC16UWIqf7jEXy3dRgwML9yJnTaS4lHMF3ZrDXs5w7MANb6OH6hvCDQB+jf9GM4mXXQYzBJnBvBReJ9zR7G1eoorj5F+eOHnJaGAKH8dgfhqNw/VfrIpby1LJV+h7/KS0zM8KtkFvpaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069468; c=relaxed/simple;
	bh=3hRiYMNKL2rlk9OfrmSXuFoemrmVhvI087tdQ0bmX1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtXdC25pC2MSLSEIrI5176A01zZ4ZgMnyt9hzvzo2C5XoMkSM+qiPcUL5eJNADAo/5PHlNpSYG10nTH4oZWcJfr+k3zVrFvOjsz6otGyOgA3EM2bddmvOT0hkKIInT1Vhp1xD2ojj/ZzpFbfHEqj4aB7+0y16IOK1SqC39V/qeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=et7gIF/j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1740221f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731069465; x=1731674265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEEI2hdw6EeKS40KZ7XpWp2TtHfkib4JXKZPiDzGo7Q=;
        b=et7gIF/jJ3p3BnHsHCOzrl1NcKJXB+29gisIwGjBdzV0uBpG12veDPoa1q7QasNgHj
         8/PpcziikhB92zyqcYfe9jfBOabs+0SlaCltf7LMhfNEZgEaL5+dtC8tfsV9IrIABr/b
         k4tcC5B2uvv9JvEG1PpQvL03BZ3r9TxOeALVhKSL/RJTBMvjMf+epj9l+D3esDoK3M5/
         wC4Br7d8UqxWG+3ITRB8Cj/d1ImqcXDKy0L3P++yQc/wFHX4cb7RcGXvtzDZTjTdeuYt
         k6SrfdKvgFxGi9sshNIXZYYQQJKl1xLUm1r/Q/8LeAALL3LTGExH/l3qimkr8/uCnorG
         smjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069465; x=1731674265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEEI2hdw6EeKS40KZ7XpWp2TtHfkib4JXKZPiDzGo7Q=;
        b=UfpFDJPzp1LKh+5MvM6IyatYXw4WQmDF2gbjJ5qKmy6S0P+gDbk2T0mU9ThaImkDVa
         S3tuTdyX/KgwwKDpxJtKB2bMQZAuafLpVf1gS/OHxsRwUzFyqxFbM380yazYckrT57Ls
         1+Ub8u8d1S3Pup+vFRZuFf4o+m+ZHiSfmDtNeIpe3Tl8A9SQN+zpbxysMqTZJp/G/0Zv
         YgDgfEEzzb5hHa5tSLYR46Zwk4EA/+M9TSGb+DbtEWUIZtZ6bpJXhqeriJ3C4mYdJouB
         ytnJgAhHikgHbdXye8de9vbTz4fkGYPcWGlQSPP6a8wPDPss9wv7OO3g/YYBRsNKUKnB
         vn6g==
X-Forwarded-Encrypted: i=1; AJvYcCXU/Ccx9uWOiI+v3m47MBtPBvViXJdUp36G7+rMI4WTdejo8O+IIM8YcjYUT/A02Afneidb9QQ09RYB2bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+BACHJdpwkPDtbnnaN3vFuoGIo4kKAgNBmqLhzW1/hfaxiqX
	P+VlJTm0jUfhrHRALNBryebwBg3SKuBVQQz81tkQDDyU+WyepVhwoKQr+64iDorWYN27gkv+JF7
	WwhSzRWbit9x7aRNueOKzujfZeDA825GiZo4D
X-Google-Smtp-Source: AGHT+IEQq3fvjVc0Pfh+o4nbT9M7AYxhKf9RFYQJk4AHn9mRdQ+iwK0Ztw5o55NOr3GW/QktNrTuxR0ggZycWjziGRk=
X-Received: by 2002:a05:6000:1868:b0:37c:d1ea:f1ce with SMTP id
 ffacd0b85a97d-381f1871ae1mr2592768f8f.25.1731069465450; Fri, 08 Nov 2024
 04:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-3-de650678648d@gmail.com> <CAH5fLgiMHE5GXQv8pSR_KYWsa44zr1o_FNrg1mj8QuTvNQmXhQ@mail.gmail.com>
 <CAJ-ks9=Ej0St7XnmvTysdnjPHh6O+4XdYFC6LouwEJR9GpUPNQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9=Ej0St7XnmvTysdnjPHh6O+4XdYFC6LouwEJR9GpUPNQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 8 Nov 2024 13:37:33 +0100
Message-ID: <CAH5fLgi=n-v5C4hH-+uozbiwwWCU_QGzhxfdTXfTyyy2ejJR+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rust: arc: split unsafe block, add missing comment
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:30=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Fri, Nov 8, 2024 at 6:38=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> > > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > > index af383bcd003e1122ebe1b62a49fe40279458e379..9adea755a5ad1a7b03f7f=
c30a7abc76c1f966c6c 100644
> > > --- a/rust/kernel/sync/arc.rs
> > > +++ b/rust/kernel/sync/arc.rs
> > > @@ -377,10 +377,14 @@ fn as_ref(&self) -> &T {
> > >
> > >  impl<T: ?Sized> Clone for Arc<T> {
> > >      fn clone(&self) -> Self {
> > > +        // SAFETY: By the type invariant, there is necessarily a ref=
erence to the object, so it is
> > > +        // safe to dereference it.
> > > +        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get()=
;
> >
> > I would normally prefer to avoid creating a reference to the entire
> > ArcInner, but in this particular case it is okay due to the specifics
> > of how Arc works.
>
> Note that this particular line appears also in the Drop impl just
> below. That said, can you help me understand the concern with creating
> a reference to the entire ArcInner?

Creating a shared reference to the entire ArcInner is an assertion
that no &mut exists to any part of the ArcInner, even though you only
access the refcount field. In this particular case, asserting shared
access to the `data` field is not a problem due to how Arc works, so
it's okay, but the pattern is problematic in other cases.

You could write `unsafe { (*self.ptr.as_ptr()).refcount.get() }` to
avoid the as_ref call.

Alice

