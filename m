Return-Path: <linux-kernel+bounces-526457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A6FA3FEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F6C4214CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D49250BE5;
	Fri, 21 Feb 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4VRijN8"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3B1E7C0A;
	Fri, 21 Feb 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162836; cv=none; b=XYwUjwZkENMQMgaNjpDKuj6nrpZ5I5U+jA4niGAMcL4Q9ivsCF4d/+vUTmf4Go1SvKtPTRBhJmkSaezjs2LEJqmLyVxH9JS07zCBblKTF3l2BbSoD9kv00u1GeJEsd/MEHQ64nMlIwuefi9wt06gm25cXM2jMGtEXyMqlP7SieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162836; c=relaxed/simple;
	bh=SevsMtAd6pcMIukozWoqRpvrs5tEn8so48kD9lEs31w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXruqHKxPBoA6ZjWAR23rv3F7Ynrf7wmUygniEBwILuZZHwhxBjIqVaQo5v7MiSRONGiXpTsUkP7b2+haoDJMosWXwbBh5cblc+Swq7ujX4kDKrRrsq4uosu6TJmDh5CSQL8G0ml8u986DvEC0mife37qYRium0auF5ntwbBoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4VRijN8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30918c29da2so25331621fa.0;
        Fri, 21 Feb 2025 10:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162833; x=1740767633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALbOSHAT/15UhdWN8gs88HPU77uFzWDWuyK2nCKLT/8=;
        b=N4VRijN8iYya26KXN6IeB+tvjV1LkjibM//m9VIbWwhfh/Mq/6ub4AI8pvGoLVCTHc
         bUqWh4bH4sE59ZGkx9YAJ8sPNLJq5+r6kiTOK+XBfX6H2k/GFYPIhhUTAEruZMxz3nAp
         qDkXmkk+vPi+TPap4C/z7zEiD7He+FJGtw0/WYGo0DGJY15uIsyfqt6y2MQAHNM+Au1C
         UEjYcUPA3raDobmz8yoDSeUbQeh62OFKtgTAcH8qIR4IodF+YnVzhAB7dnlyeGJVzyGW
         a3kVTVz6BsgQ8oNU8c0B2PQswUSxbQkL5TD7x4NgO2Dsg9oDx32eSNujOA9j+MdzMFWa
         Qq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162833; x=1740767633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALbOSHAT/15UhdWN8gs88HPU77uFzWDWuyK2nCKLT/8=;
        b=Zw8YzQTtbtfzR0PFZTlmZVHHSjPeK1JI5frWO8XrcjooyFoJBjqxozQAJuPLt/mF3i
         hU2gRVyLToBHPhfAoiqSbAUhHxADDHUOJ21TkPJ2YFBuvW44A8NoRdRuMJV4QAXicXp2
         p1fA+6CliySDJ14GEIjQf2V/WnZt7+Qb2L34vrU6C8w0oxStNioznV9/W1Z2zCPVSkEt
         oKA5oXFs53fSau8os0OWc4KWQJssOPZfTuGSyLvCPfLLTQK4jfjmnwLA2OEL2Oq9vEFW
         ng/3w7bV1M7oYC7w01xDgjqZoI7vOKlwl+xI63PotEppeNa515Mpr4CZtRC3CPCVWjuO
         cGXw==
X-Forwarded-Encrypted: i=1; AJvYcCWkFcWecV0xka7JCRuB3ghFlJ0qVf6xly4wYldyLReqai4X3HZ9HjyFrzvRGodgBY+ifAlYNIoAS/kPtrk=@vger.kernel.org, AJvYcCXZ5B4u2bo/nL980vfRtKtNawQm8VHsszkCRcQFqPLuOevrQQEz07pkELwy3ucWLLSZOLZoxMqlr48GrWz/9ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9uchfrx4/rvrBzGrVfLd7+Kc7GulRzYEZgB6FKbQws3azT8J
	ts0K0k+6RhLJiUqNY2j7a8q06CCBC7mPcCX+76KgHCFDdZHvu/tL/UZhCioC+oDBr0IJHE2lq6U
	6ZEpHOSUIrkrbQy7XO7hwRmI7+/w=
X-Gm-Gg: ASbGncupDtOhtKZNMG89ejMgXTWm3zuHo0fafyI8nRut0FNHUukj9yxK4+j49ELLfaQ
	bdByXJCMcClct7GMICQWqH1f8j20NNdHeSbHB5HC4pqAD69vhr4pmp7XBfqDVnvrI5n3rKxC9gg
	ESQDBL2KeeijC2vX473c3Kqz0aRnkbw1FwgEqA+ji7
X-Google-Smtp-Source: AGHT+IFrZ5qWP8BWvDyM+87TXPkiHJKiCRiTHy/tsrLiZw2sSYYR8doiBaLEh16SqrYOijCsJSfFMjxUY7+n9GKA4Rw=
X-Received: by 2002:a2e:9e89:0:b0:2ff:e7c3:9e2e with SMTP id
 38308e7fff4ca-30a598f4177mr17615651fa.17.1740162832958; Fri, 21 Feb 2025
 10:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-3-gary@garyguo.net>
 <CAJ-ks9npk8oSFHZHdViR1XhF+A8e2L+P0wCgmjE7mzAxS9WK1g@mail.gmail.com>
 <20250221161439.0e34fba9@eugeo> <CAJ-ks9=dsrsMD261HEbgHOUMXm=nj-GUymuCtZ8oeDFCx7JtrQ@mail.gmail.com>
 <20250221182849.21e9d83a@eugeo>
In-Reply-To: <20250221182849.21e9d83a@eugeo>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 13:33:16 -0500
X-Gm-Features: AWEUYZkpfYBKeGoYR72o0-nZ-YvzRuTGZLJyuZf6llFk580pjfq9TBiJfwJbll4
Message-ID: <CAJ-ks9muOuM_WpVKGOmcgd3LE_eQXL1jNQfT-yTQPcSkSeysRA@mail.gmail.com>
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

On Fri, Feb 21, 2025 at 1:29=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 21 Feb 2025 12:27:46 -0500
> Tamir Duberstein <tamird@gmail.com> wrote:
>
> > > > > @@ -412,16 +402,14 @@ fn clone(&self) -> Self {
> > > > >
> > > > >  impl<T: ?Sized> Drop for Arc<T> {
> > > > >      fn drop(&mut self) {
> > > > > -        // SAFETY: By the type invariant, there is necessarily a=
 reference to the object. We cannot
> > > > > -        // touch `refcount` after it's decremented to a non-zero=
 value because another thread/CPU
> > > > > -        // may concurrently decrement it to zero and free it. It=
 is ok to have a raw pointer to
> > > > > -        // freed/invalid memory as long as it is never dereferen=
ced.
> > > > > -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.g=
et();
> > > > > -
> > > > >          // INVARIANT: If the refcount reaches zero, there are no=
 other instances of `Arc`, and
> > > > >          // this instance is being dropped, so the broken invaria=
nt is not observable.
> > > > > -        // SAFETY: Also by the type invariant, we are allowed to=
 decrement the refcount.
> > > > > -        let is_zero =3D unsafe { bindings::refcount_dec_and_test=
(refcount) };
> > > > > +        // SAFETY: By the type invariant, there is necessarily a=
 reference to the object.
> > > > > +        // NOTE: we cannot touch `refcount` after it's decrement=
ed to a non-zero value because
> > > > > +        // another thread/CPU may concurrently decrement it to z=
ero and free it. However it is okay
> > > > > +        // to have a transient reference to decrement the refcou=
nt, see
> > > > > +        // https://github.com/rust-lang/rust/issues/55005.
> > > > > +        let is_zero =3D unsafe { self.ptr.as_ref().refcount.dec_=
and_test() };
> > > >
> > > > How come this careful handling is not required in into_unique_or_dr=
op?
> > > > At least, the SAFETY comment there is much more mundane.
> > >
> > > Because `into_unique_or_drop` doesn't actually remove the allocation
> > > (it only decrements refcount for non-zero or turn it into `UniqueArc`=
).
> >
> > I don't follow. This comment here talks about a race with another CPU
> > decrementing to zero; isn't the same race possible between any
> > combination of `into_unique_or_drop` and `drop` callers?
>
> Oh you're right. It's indeed the same situation. However I'd want to
> avoid repeating justification multiple times, given that this is really
> an explaination note to the reader. Do you have any suggestion on how
> to organise the comment so I can avoid repeating this multiple times?

The usual thing is to extract a helper. Is that possible here?

