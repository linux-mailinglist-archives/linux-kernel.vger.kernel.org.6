Return-Path: <linux-kernel+bounces-526344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A87A3FD6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2677426115
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A22505A4;
	Fri, 21 Feb 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgletZSw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AA1DC9B0;
	Fri, 21 Feb 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158908; cv=none; b=eg87LW0cmiZMIN2QI7hU1y1H7J+dndGTZUhqPNBqrpjlrp92CQhaM0ija2ytqK4LsqClUH5Z2WCkSyW4pbLOf12vBFomiqWF6xL38EHqSs84fjg7f2OIDoVHFqa7/GT6aEcyH0LMXAk60gLs+61wB9G49pJeL00ajOazjaBWaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158908; c=relaxed/simple;
	bh=HPrP3ojvkSVZ5Kc1kBEaZImgxfvHyX7Dpb88DUxTK4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlcfDEg3lz9z3dYPC1KejuPOeeO6NkcYVVK425TIgN+GgIyqwXp3OZmG8j75Ilxo1JkcmTWDvwqai5kId1IFq1+HyzdEhC/fue9gBQTZKYV/UZ5mBQ/DkjYEQbe6JfipYBJJIVMdZXH8M3H8Jf1fM96ZTBrnz/roZxcZKeMo4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgletZSw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so2399460e87.0;
        Fri, 21 Feb 2025 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740158904; x=1740763704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+ovilXkqh0uwuaQP4pyblGCdU8pjRUdN2KKRsegnNo=;
        b=WgletZSwZ4SGaf/hAAeRY/xbqfO15cVvimdv+AvnjivpHxYnp1JC1boTaZDeZyKx7r
         squ53cv3a2oEDbs8nDI0psMwHrcN4+smIfT9olIF8K8mQBfG4ZyqVtU1EkA++wzcrYs/
         toxpsnso1h2JfQLxi6QdmyH3yZp5rIdcGUEw7K85+FboiAi4KXFNrZzO/1gAd4pJII6e
         nCD4V4dhr98YU72VqLSh7JNAyq/xkHJuXj3uYZsYZF/5cKNaVWG4pJ8Oqp1QtoBIC+87
         rMiLAfH02kY2s+G4rHmZ6If67bAvG5h+x7s6gfFigCYfp+9bh08NgqhqFlbQBks1a6V3
         2ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158904; x=1740763704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+ovilXkqh0uwuaQP4pyblGCdU8pjRUdN2KKRsegnNo=;
        b=HOrkIrmW14pEqMTmm7dye7atavEHods1ZHd0uNb7Wvvj2Byi9I15db51ajBcdLeBtG
         kAjSaszcfzbGlaWOjHcksuxuLTEjX8qRC/R/OAooj603jhFhLBwS28UELe3t0QIiFrvW
         itoszwVm3o5TQhyUM0/JgWfQoqsE0VJUHKsif3KxgC74vyJsb9gsax/E99orGTDcZVVa
         55mkluiiWb91MeQQru8ZKquxLN4jqr4vEmfa4argyqle6rmq/LwoO687pNFpNYHcFYFt
         1f89GBea/KYS8XQcramd1IOSLio25oydUAGX3dyfLb3b2LluKM8KBc3ILiiMevowZode
         Za8g==
X-Forwarded-Encrypted: i=1; AJvYcCVZPI13x1Wg6+p1g20AhTXFCSwtSXLW/su6TbGOUqgFtBwha/zWDLQA5xDeiztUUtYy7he/iwXLMGoehnM=@vger.kernel.org, AJvYcCWJDTBrDI1hd7uXnn0CAf4YMKhMZGfZ33PPN6Oznqz0UrE4auyIwNOhSmbYsFyecM2PZvVyLAKYQz70PZlqb0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGxOoUYqqPwljssomq8k3StMjdWo5EDhMXr7OeLukWnObBcvI
	qPoVujTjBEzjnRD3b5QdD0FWSLthJ4MtYVZVpkbp8aR0NImpbgwWek5OpTl8DxpKoBxInbq0S7H
	qHgrmekXy6RTct3gG8LaP626vPKk=
X-Gm-Gg: ASbGncunC6o9MOE6VzB8O9B/u2vIErHXRA2WiU+xTDe6KXggoxIqXCO2uKYezRQEaYo
	ub2ODvVZLEYCX8QhU264/VEKBMlLixPqSfXN55AYTX49BjFnVOzViAhNUA2kBYoKJrRDCH81Q1n
	wz+/hn8/Wr0tJhEKSA4qdBIKT7+4xycjkTdHc7RCc1AA==
X-Google-Smtp-Source: AGHT+IFuk7rvEriHtLyIjuxhzbA0Y1/+LDTO72neye7ue98KceMlFPUJ/lFcETbG78MbjmQLgJbcisuEkYYRBxTlZes=
X-Received: by 2002:a05:6512:ad2:b0:545:191:81db with SMTP id
 2adb3069b0e04-54838f5e248mr1332168e87.50.1740158904361; Fri, 21 Feb 2025
 09:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-3-gary@garyguo.net>
 <CAJ-ks9npk8oSFHZHdViR1XhF+A8e2L+P0wCgmjE7mzAxS9WK1g@mail.gmail.com> <20250221161439.0e34fba9@eugeo>
In-Reply-To: <20250221161439.0e34fba9@eugeo>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 12:27:46 -0500
X-Gm-Features: AWEUYZnyeU1ZybS_ViUrsCp6ilnp2HGYKCgnGG028bJ5uhhlpMxXUWt8nmnM4LE
Message-ID: <CAJ-ks9=dsrsMD261HEbgHOUMXm=nj-GUymuCtZ8oeDFCx7JtrQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: convert `Arc` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Alex Mantel <alexmantel93@mailbox.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:14=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Wed, 19 Feb 2025 17:12:10 -0500
> Tamir Duberstein <tamird@gmail.com> wrote:
>
> >
> > Why did this signature need to change?
>
> I think I mentioned this in a earlier series. Smart pointers are not
> supposed to have methods (i.e. with a self receiver) as it may shadow
> deref'ed functions.

That probably deserves a separate commit, or at least a mention in the
commit message.

> > We could retain the unsynchronized operation here by taking a mutable
> > reference above and writing through it. Right? Could we remove `set`
> > from the abstraction in the previous patch?
>
> This was suggested as well in a previous series but I don't think it's
> a good idea. Creating a mutable reference and using unsynchronized
> write requires `unsafe`. `set` doesn't.
>
> Note that the `set` here is relaxed order. I doubt (if things are
> inlined properly) there'll be any codegen difference with a completely
> unsynchronized write.
>
> Not having an additional unsafe is a good trade-off to me.

Ack.

> > > @@ -412,16 +402,14 @@ fn clone(&self) -> Self {
> > >
> > >  impl<T: ?Sized> Drop for Arc<T> {
> > >      fn drop(&mut self) {
> > > -        // SAFETY: By the type invariant, there is necessarily a ref=
erence to the object. We cannot
> > > -        // touch `refcount` after it's decremented to a non-zero val=
ue because another thread/CPU
> > > -        // may concurrently decrement it to zero and free it. It is =
ok to have a raw pointer to
> > > -        // freed/invalid memory as long as it is never dereferenced.
> > > -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get()=
;
> > > -
> > >          // INVARIANT: If the refcount reaches zero, there are no oth=
er instances of `Arc`, and
> > >          // this instance is being dropped, so the broken invariant i=
s not observable.
> > > -        // SAFETY: Also by the type invariant, we are allowed to dec=
rement the refcount.
> > > -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(ref=
count) };
> > > +        // SAFETY: By the type invariant, there is necessarily a ref=
erence to the object.
> > > +        // NOTE: we cannot touch `refcount` after it's decremented t=
o a non-zero value because
> > > +        // another thread/CPU may concurrently decrement it to zero =
and free it. However it is okay
> > > +        // to have a transient reference to decrement the refcount, =
see
> > > +        // https://github.com/rust-lang/rust/issues/55005.
> > > +        let is_zero =3D unsafe { self.ptr.as_ref().refcount.dec_and_=
test() };
> >
> > How come this careful handling is not required in into_unique_or_drop?
> > At least, the SAFETY comment there is much more mundane.
>
> Because `into_unique_or_drop` doesn't actually remove the allocation
> (it only decrements refcount for non-zero or turn it into `UniqueArc`).

I don't follow. This comment here talks about a race with another CPU
decrementing to zero; isn't the same race possible between any
combination of `into_unique_or_drop` and `drop` callers?

