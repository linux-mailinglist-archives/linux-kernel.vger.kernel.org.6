Return-Path: <linux-kernel+bounces-335551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CD97E754
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A451C20FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4D188921;
	Mon, 23 Sep 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19t8NNHK"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8B18891D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079277; cv=none; b=oTi4mv1gXfP00VJs9rh2zKJTSu+D7sE9uaXv2wXI1WP2acPtz1Limjnjb87YNcqtNxsyoxhOaysFFJX1+YF+dBcDsiJWGbnJFO0R4pkFvlvHv/3KyRSfjiKM3WWCNDTm6ILPrsFW8DJPXt1LQl3A+gA4u8o+06a/1dcVBSvX77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079277; c=relaxed/simple;
	bh=o9RYAZ+ihKi/qnu3t8fCvW1gHNpjjOjwY4lKAZHoHaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2uxZFS7H155EdN2KWhAoYWQisEepok3VesL93l3Fa/l+2ypOlSUxKARZy6xzpFt1aLBxc2+5842Sj9A0hwk3xMsEZKQ6ZXcOY+zhDWW0mhoX0Bjpl08ICPVG0by+z5OcOGT105qpQ/cwDDau3vdPo1+nrBJs6MEl5QXWpJBXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19t8NNHK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso31550055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727079274; x=1727684074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhm6VDUyFbk0AMF8tTtB6iaMTp7O9/A12f5FRSU8wmY=;
        b=19t8NNHKU7P3mcepq7lVhdUhszBdWl/8KCs3Z1q5ibOSnHiD467Pa1Zrc4ZIdcIQrg
         Two8PjeUnXJYimTqPf9yhWkigzxDVjELdrlbTWZjC6JroYY+iswI4LIC8Oke6EVzqadM
         8nKx1252s0Jp/lL2h9qZVA/igqq+wKGfw7EdE4pmXuAxqfJbipEUEI4AWsPg5M/CWz+0
         kxouq+YNh6UfwLpBAsaBO0tt3udrXCkR0T5YT0bRYtBQNAi3ag0TwWlmMRJBlYUx4tax
         vhkSYtpO0/ReJBphhecoaOYuX+e2IT1BMawZITYJuUnNRiWDf+xqb9/M3+nxFGpe55V3
         t0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727079274; x=1727684074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhm6VDUyFbk0AMF8tTtB6iaMTp7O9/A12f5FRSU8wmY=;
        b=qhEUftBtEX3f8z/fOyM3LhJuKxLbPAJbz6Es9EHde0IFYTWLw3FK2OuFBlvCfRBopy
         cBoDdHATTqvZTd2ybxrvMUdYUIsMF/QN7m5IUjDVeS531yQvLjVQhQvoNaPIQL0xMvdY
         tYpNjSwQDcbEFZUEk6J0ObtakqkrSU1Rjh9cwLJ1nO1u2vJEiGZQZ04m4xNrZsMlCfYR
         4C4DKEiPla+pNqitIpkwNPtzn10+YWiA3EvXX1YhJeYz6PinsXmCC20kHaTpRpRakc0M
         5WfRBWEz0mr3QbmTAd6aYfLlyKA8xdyyy8eujEqCEQBlVrkD/if13ntOsh0YVe77y03T
         lDnA==
X-Forwarded-Encrypted: i=1; AJvYcCWk4xJYBefZexit3yKu6fVqLAOkGvprL3NwaEI4uXXZL4LbOmKpfvikqr8v/GlNAoJ4eKPDfGBoBjH4Icc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6w/wXFuJKPWHKkKTHiUdKNzwmP5iM3m4cjo9VMaJ37QD08nys
	pmdB0OKYVdevr7AUScsj5+2rNXf98AM62eJdQAPS07MK+PiVUdH2G4BqkD0VLHa3iPwIsCzX1Od
	hC8edK7b44AUOp9uBJAYMcis3d2P6uy8zAj2t
X-Google-Smtp-Source: AGHT+IGaGz3aAPtcpdOxV3K/A6xg/czFRCBlIbwHkW2YwCfRu8a/ULBRxzRicaQamRV5tPXenSsxkSmgE7i4TKwB1/0=
X-Received: by 2002:a05:6000:1f81:b0:374:c9aa:f24d with SMTP id
 ffacd0b85a97d-37a431bc6famr6549449f8f.59.1727079273754; Mon, 23 Sep 2024
 01:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <20240917222739.1298275-4-a.hindborg@kernel.org> <e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me>
 <20240921165801.1d1df6ab.gary@garyguo.net>
In-Reply-To: <20240921165801.1d1df6ab.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 10:14:22 +0200
Message-ID: <CAH5fLggudKg0x5jjOHxdSq4-m8x=OE7WM+uCtTCJKzG8rm37dg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] rust: sync: add `Arc::as_ptr`
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 5:58=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 19 Sep 2024 14:03:50 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>
> > On 18.09.24 00:27, Andreas Hindborg wrote:
> > > Add a method to get a pointer to the data contained in an `Arc`.
> > >
> > > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > > ---
> > >  rust/kernel/sync/arc.rs | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > > index 3673496c2363..a57ea3e2b44c 100644
> > > --- a/rust/kernel/sync/arc.rs
> > > +++ b/rust/kernel/sync/arc.rs
> > > @@ -258,6 +258,14 @@ pub fn into_raw(self) -> *const T {
> > >          unsafe { core::ptr::addr_of!((*ptr).data) }
> > >      }
> > >
> > > +    /// Return a raw pointer to the data in this arc.
> > > +    pub fn as_ptr(&self) -> *const T {
> >
> > I don't know if we have a convention for this, but shouldn't this be an
> > associated function? Because if `T` also has an `as_ptr` function, it
> > will be shadowed by this one.
>
> The usual Rust convention is usually that if `Deref` is implemented,
> then unless there's a good reason to do otherwise, associated function
> should be used.

The reason for this convention is that adding new &self methods on a
smart pointer is a breaking change, but we don't care about breaking
changes, so it doesn't fully apply to us.

Not that we shouldn't follow the convention, but it's not completely
clear to me either.

Alice

