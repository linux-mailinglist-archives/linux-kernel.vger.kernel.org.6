Return-Path: <linux-kernel+bounces-353299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C5992BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E3BB254DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD41D279C;
	Mon,  7 Oct 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKTlZf+g"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B21C173D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304250; cv=none; b=NW8JxdberJoV5e2dpdPNukqIamsIL2ytLKY82BSHLqJ191DYNk45k64u1bACuiZqe78asCJmouLa+X2M1qVt/MUg9rfbij8GFfr40dshSXtVJoOvBeJpHDWfa9MYm1l918ScO4ariqPSFYdhE4ChvKMG5a353036cqDahh2ODqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304250; c=relaxed/simple;
	bh=tKw3Dv+ep5qgy/wCHKKBNbMDkWQxFHKiRzK1Yy/LhmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BS60B+Fngx8fzqEHn4qnaczuPjgq+6SXnmfvBbQ9VTD8xC4vKwCFO4lsEixORlnHLT7ebA/OIi+zrfsKt00XCEdzUBwIATRluo06CjSgGn7Ab9JWvozsSja4WUM/JZs9HWtw5eYuDe6uRPh8/6JIK8kEj5Jqzb6ypS78UMOPrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKTlZf+g; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cc810ce73so2310292f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728304247; x=1728909047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xcmrgt5t2c8dd5WZNO1q1kgJtgx+WDNB9aW9p8iaKAk=;
        b=LKTlZf+goFWihB5wooFjO1+fyY+EUEvnNyNAwG8+DbZOzC0ByE5QxAxbFNirCsEjyQ
         cgIcHtVfRvOG9bjfDAWfEVWrUlTIrAyF6brQzLSoAMMu+m7gpodrFsijjrY9Uf5OULG8
         sDwmoVJpYJw96UVBAS2fwDaQtq2y4rprTmQmJhY6Xd/z7jxYripCSKKkZXRXdvwan5rs
         bC98iRTQGvI0E5hEP2BsDfMQmrYsKxY0lH06RT8foVB8FiayDEr+Yd5UKo4QuTaXtQPu
         xCUMt9K03wZUNOxNsJRw1vtDgb32EV+VuQVYtVePKIqBjpXrQn1tKXGsg2Rr6n8+IUsE
         /kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304247; x=1728909047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xcmrgt5t2c8dd5WZNO1q1kgJtgx+WDNB9aW9p8iaKAk=;
        b=LKSzZDEtQduzELzgNsFMbNX3OK1FiIWyynPcUiHLcv0/rPg8FI4HWgUgzy3cOBVI3o
         T6XBowCNkVp6L5shCRpqeUqB08Su0Yp1mwKbNrHfOVyI435gLPcsna7WoJQxtXsxunUQ
         f+lgGZIineJrfBCafWU5q6Yw7PqykK5SVzk/Dd44+DEwQAXSg98pBPz+E0ckWuptZJ9q
         bBea87pnzMAfXyN4BNvTWSYUEzrzLM3zi3vOX9n5KWrLcXYVpMnbzt5HLwvpkGyAoPtk
         k67ymJDTfwG8E0oueUyWafKsMGq1XlkDUce+/TyF16Mao39gVFA/lad10LNHgJxLQhCJ
         yxqA==
X-Forwarded-Encrypted: i=1; AJvYcCXPiF1/fl43/oVVLrssxjb01poqTJmQCStgyGJzgW2zHS+8vL5aKx2CgczzptoQDEHGL22kDeq9N+U7MwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUg3cwkbBo9kYEf6wgys2oUyUFJDK6i/3TuzVqkC4sItGujNxk
	cU8Mj0VSDEf1Rl/m0ecXIdpNMbu+i+o4dOEBgPMNPPYDobltFjMdQQVWAafzJGRjzImbn62hKfl
	Ks+8ZggCd4PEMcsRWMfn/SzwZU3KK5l8xmj0j
X-Google-Smtp-Source: AGHT+IFBMpJdO483BxZZC9+G+ddezT0XaEDeEeegWB3jhbC1bsRQeuU2MWK1hqJE2xTnp+m2MW/1AAxNkifpUizxODc=
X-Received: by 2002:a5d:6d4f:0:b0:371:8dbf:8c1b with SMTP id
 ffacd0b85a97d-37d0e79149fmr5361273f8f.34.1728304246620; Mon, 07 Oct 2024
 05:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155247.2210469-1-gary@garyguo.net> <20241004155247.2210469-2-gary@garyguo.net>
 <2024100505-aftermath-glue-7e61@gregkh> <20241005143106.1196fd3a.gary@garyguo.net>
 <20241005152605.6d7d20e1.gary@garyguo.net>
In-Reply-To: <20241005152605.6d7d20e1.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 14:30:34 +0200
Message-ID: <CAH5fLgj6SPAM0KM2pF1v0gUCJA875VvWxddTCQXu7h+t1tDjfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Dirk Behme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 4:26=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 5 Oct 2024 14:31:06 +0100
> Gary Guo <gary@garyguo.net> wrote:
>
> > On Sat, 5 Oct 2024 09:40:53 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > On Fri, Oct 04, 2024 at 04:52:22PM +0100, Gary Guo wrote:
> > > > This is a wrapping layer of `include/linux/refcount.h`. Currently o=
nly
> > > > the most basic operations (read/set/inc/dec/dec_and_test) are imple=
mented,
> > > > additional methods can be implemented when they are needed.
> > > >
> > > > Currently the kernel refcount has already been used in `Arc`, howev=
er it
> > > > calls into FFI directly.
> > > >
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > > ---
> > > >  rust/helpers/refcount.c      | 15 ++++++
> > > >  rust/kernel/sync.rs          |  2 +
> > > >  rust/kernel/sync/refcount.rs | 94 ++++++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 111 insertions(+)
> > > >  create mode 100644 rust/kernel/sync/refcount.rs
> > > >
> > > > diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> > > > index f47afc148ec3..39649443426b 100644
> > > > --- a/rust/helpers/refcount.c
> > > > +++ b/rust/helpers/refcount.c
> > > > @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
> > > >   return (refcount_t)REFCOUNT_INIT(n);
> > > >  }
> > > >
> > > > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > > > +{
> > > > + return refcount_read(r);
> > > > +}
> > >
> > > Reading a refcount is almost always a wrong thing to do (it can chang=
e
> > > right after you read it), and I don't see any of the later patches in
> > > this series use this call, so can you just drop this?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I originally introduced this thinking I can replace Andreas's atomic
> > 2->0 operation with a read + set, but ended up couldn't do it.
> >
> > The refcount read is still useful to determine if the current value is
> > 1 -- in fact, `Arc::into_unique_or_drop` could use this rather than
> > decrementing the refcount and then incrementing it again (just doing a
> > refcount read would be much better codegen-wise than the current
> > behaviour). I'll probably make this change in the next version of the
> > series.
>
> Actually `into_unique_or_drop` can't use this because it needs to avoid
> running destructor when it races with other threads. The semantics for
> that function is better reflected with `refcount_dec_not_one`, which
> I'll introduce in v2, and I'll drop `read` in v2.

Ah, I did not know that C had a refcount_dec_not_one. Yeah, that's
exactly what into_unique_or_drop does.

Though I don't know if the cmpxchg loop is really more efficient than
just doing an infallible decrement like I do right now?

Alice

